OSSLSIGNCODE_VERSION="$(osslsigncode -v 2>/dev/null|head -n1|cut -d, -f1)"
if [ "$OSSLSIGNCODE_VERSION" == "osslsigncode 1.7.1" ]
  then
    echo "osslsigncode already installed nothing to do"
    exit 0
fi
curl -o $WERCKER_CACHE_DIR/osslsigncode.tar.gz "http://hivelocity.dl.sourceforge.net/project/osslsigncode/osslsigncode/osslsigncode-1.7.1.tar.gz"
mkdir -p $WERCKER_CACHE_DIR/osslsigncode-build
tar -xf $WERCKER_CACHE_DIR/osslsigncode.tar.gz --strip=1 -C $WERCKER_CACHE_DIR/osslsigncode-build
sudo apt-get update
sudo apt-get install -y openssl autoconf libcurl4-openssl-dev libssl-dev
cd $WERCKER_CACHE_DIR/osslsigncode-build
./configure --prefix=/usr && make && sudo make install
