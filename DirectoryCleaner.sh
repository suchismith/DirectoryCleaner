#!/bin/bash
ext=$2
extensions[0]=""
directory=$1
count=0
if [ -d $directory ];
then
    flag=1
else
    echo "Invalid Directorty"
    exit 1
fi

cd $directory

if [[ "$ext" =~  "all" ]];
then
    
    for format in `ls -p | grep -Eo "\.[^/]+$"| sort|uniq | sed "s/\.//g"`
    do
        
        mkdir -p ${format}
        mv *.$format $format
        if [ $? -eq 0 ];
        then
        echo "Moved $format files"
        else    
        echo "Files with $format do not exist in this directory"
        fi
    done
    exit 1
fi






for file in "$@" 
do
    extensions[count]=$file
    let count+=1
done





for((i=1;i<count;i++))
do
    ls *.${extensions[$i]}  2>/dev/null 1>/dev/null
    if [ $? -eq 0 ];
    then 
        mkdir -p ${extensions[$i]} 
        mv *.${extensions[$i]} ${extensions[$i]} 2>/dev/null
        if [ $? -eq 0 ];
        then
        echo "Moved ${extensions[$i]} files"
        else    
        echo "Error in moving"
        fi
    else
        echo "Files with the extension ${extensions[$i]} do not exist "
    fi

done







