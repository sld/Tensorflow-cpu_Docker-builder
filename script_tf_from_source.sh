#!/bin/sh -e

echo "\n\nTENSORFLOW-FROM-SOURCE-SCRIPT\n"

git clone --depth 1 --branch v2.18.0 https://github.com/tensorflow/tensorflow.git
cd tensorflow/
./configure
bazel build --config=opt //tensorflow/tools/pip_package:wheel --repo_env=WHEEL_NAME=tensorflow --config=opt
cp bazel-bin/tensorflow/tools/pip_package/wheel_house/* /tf_wheel/

git clone --depth 1 --branch v2.18.0 https://github.com/tensorflow/text /text
cd /text
pip install /tf_wheel/tensorflow-2.18.0-cp310-cp310-linux_x86_64.whl
./oss_scripts/run_build.sh
cp /text/*.whl /tf_wheel/

exit 0
