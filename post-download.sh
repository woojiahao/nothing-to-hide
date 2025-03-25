#!/bin/bash

# Generate a bunch of files and folders

mkdir -p sensitive/
mkdir {src,res}

echo 'print("hello world!")' >>src/script.py
echo 'KEY=secretshhhh' >>src/.env
echo 'KEY=secretshhhh' >>src/.env
curl 'https://variety.com/wp-content/uploads/2021/07/Rick-Astley-Never-Gonna-Give-You-Up.png?w=1000&h=667&crop=1&resize=1000%2C667' --output res/hidden.png
printf 'John\nAlice\nBob\nMichael' >>sensitive/names.txt
touch sensitive/sensitive_{1..5}.txt

echo 'sensitive/*' >>.gitignore
echo 'res/hidden.png' >>.gitignore
echo 'src/.env' >>.gitignore
echo '!sensitive/names.txt' >>.gitignore

git add .gitignore
git commit -m "Change"

first_commit_hash=$(git log --reverse --pretty=format:'%h' | head -n 1)
if [ $(git tag -l "git-mastery-start-$first_commit_hash") ]; then
  git tag -d "git-mastery-start-$first_commit_hash"
  git push --delete origin "git-mastery-start-$first_commit_hash" 2>/dev/null
fi

git tag "git-mastery-start-$first_commit_hash"
git push --tags
