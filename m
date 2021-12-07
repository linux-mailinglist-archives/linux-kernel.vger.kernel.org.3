Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B0146C365
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 20:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240890AbhLGTRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 14:17:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:63197 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231634AbhLGTRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 14:17:49 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="218347469"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="218347469"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 11:14:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="462435518"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 07 Dec 2021 11:14:11 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muful-000MtG-6K; Tue, 07 Dec 2021 19:14:11 +0000
Date:   Wed, 8 Dec 2021 03:14:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [asahilinux:asahi 4/51]
 drivers/net/ethernet/pensando/ionic/ionic_main.c:479:9: warning: 'strncpy'
 output truncated before terminating nul copying 31 bytes from a string of
 the same length
Message-ID: <202112080344.N5JOX240-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux asahi
head:   75169fcdd5a155624e1478e1799be7a5299b738c
commit: 1e5e6fb3675678bb5e970a19ae5e215b2daa6831 [4/51] Makefile: Add -asahi EXTRAVERSION
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20211208/202112080344.N5JOX240-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/AsahiLinux/linux/commit/1e5e6fb3675678bb5e970a19ae5e215b2daa6831
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux asahi
        git checkout 1e5e6fb3675678bb5e970a19ae5e215b2daa6831
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/net/ethernet/pensando/ionic/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/pensando/ionic/ionic_main.c: In function 'ionic_identify':
>> drivers/net/ethernet/pensando/ionic/ionic_main.c:479:9: warning: 'strncpy' output truncated before terminating nul copying 31 bytes from a string of the same length [-Wstringop-truncation]
     479 |         strncpy(ident->drv.driver_ver_str, UTS_RELEASE,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     480 |                 sizeof(ident->drv.driver_ver_str) - 1);
         |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/strncpy +479 drivers/net/ethernet/pensando/ionic/ionic_main.c

fbfb8031533c92 Shannon Nelson 2019-09-03  468  
fbfb8031533c92 Shannon Nelson 2019-09-03  469  int ionic_identify(struct ionic *ionic)
fbfb8031533c92 Shannon Nelson 2019-09-03  470  {
fbfb8031533c92 Shannon Nelson 2019-09-03  471  	struct ionic_identity *ident = &ionic->ident;
fbfb8031533c92 Shannon Nelson 2019-09-03  472  	struct ionic_dev *idev = &ionic->idev;
fbfb8031533c92 Shannon Nelson 2019-09-03  473  	size_t sz;
fbfb8031533c92 Shannon Nelson 2019-09-03  474  	int err;
fbfb8031533c92 Shannon Nelson 2019-09-03  475  
fbfb8031533c92 Shannon Nelson 2019-09-03  476  	memset(ident, 0, sizeof(*ident));
fbfb8031533c92 Shannon Nelson 2019-09-03  477  
fbfb8031533c92 Shannon Nelson 2019-09-03  478  	ident->drv.os_type = cpu_to_le32(IONIC_OS_TYPE_LINUX);
1fcbebf115d9ce Shannon Nelson 2020-03-06 @479  	strncpy(ident->drv.driver_ver_str, UTS_RELEASE,
fbfb8031533c92 Shannon Nelson 2019-09-03  480  		sizeof(ident->drv.driver_ver_str) - 1);
fbfb8031533c92 Shannon Nelson 2019-09-03  481  
fbfb8031533c92 Shannon Nelson 2019-09-03  482  	mutex_lock(&ionic->dev_cmd_lock);
fbfb8031533c92 Shannon Nelson 2019-09-03  483  
fbfb8031533c92 Shannon Nelson 2019-09-03  484  	sz = min(sizeof(ident->drv), sizeof(idev->dev_cmd_regs->data));
fbfb8031533c92 Shannon Nelson 2019-09-03  485  	memcpy_toio(&idev->dev_cmd_regs->data, &ident->drv, sz);
fbfb8031533c92 Shannon Nelson 2019-09-03  486  
fbfb8031533c92 Shannon Nelson 2019-09-03  487  	ionic_dev_cmd_identify(idev, IONIC_IDENTITY_VERSION_1);
fbfb8031533c92 Shannon Nelson 2019-09-03  488  	err = ionic_dev_cmd_wait(ionic, DEVCMD_TIMEOUT);
fbfb8031533c92 Shannon Nelson 2019-09-03  489  	if (!err) {
fbfb8031533c92 Shannon Nelson 2019-09-03  490  		sz = min(sizeof(ident->dev), sizeof(idev->dev_cmd_regs->data));
fbfb8031533c92 Shannon Nelson 2019-09-03  491  		memcpy_fromio(&ident->dev, &idev->dev_cmd_regs->data, sz);
fbfb8031533c92 Shannon Nelson 2019-09-03  492  	}
fbfb8031533c92 Shannon Nelson 2019-09-03  493  	mutex_unlock(&ionic->dev_cmd_lock);
fbfb8031533c92 Shannon Nelson 2019-09-03  494  
a21b5d49e77a2e Shannon Nelson 2020-10-01  495  	if (err) {
36b20b7fb1c3cb Shannon Nelson 2021-10-01  496  		dev_err(ionic->dev, "Cannot identify ionic: %d\n", err);
a21b5d49e77a2e Shannon Nelson 2020-10-01  497  		goto err_out;
a21b5d49e77a2e Shannon Nelson 2020-10-01  498  	}
fbfb8031533c92 Shannon Nelson 2019-09-03  499  
36b20b7fb1c3cb Shannon Nelson 2021-10-01  500  	if (isprint(idev->dev_info.fw_version[0]) &&
36b20b7fb1c3cb Shannon Nelson 2021-10-01  501  	    isascii(idev->dev_info.fw_version[0]))
36b20b7fb1c3cb Shannon Nelson 2021-10-01  502  		dev_info(ionic->dev, "FW: %.*s\n",
36b20b7fb1c3cb Shannon Nelson 2021-10-01  503  			 (int)(sizeof(idev->dev_info.fw_version) - 1),
36b20b7fb1c3cb Shannon Nelson 2021-10-01  504  			 idev->dev_info.fw_version);
36b20b7fb1c3cb Shannon Nelson 2021-10-01  505  	else
36b20b7fb1c3cb Shannon Nelson 2021-10-01  506  		dev_info(ionic->dev, "FW: (invalid string) 0x%02x 0x%02x 0x%02x 0x%02x ...\n",
36b20b7fb1c3cb Shannon Nelson 2021-10-01  507  			 (u8)idev->dev_info.fw_version[0],
36b20b7fb1c3cb Shannon Nelson 2021-10-01  508  			 (u8)idev->dev_info.fw_version[1],
36b20b7fb1c3cb Shannon Nelson 2021-10-01  509  			 (u8)idev->dev_info.fw_version[2],
36b20b7fb1c3cb Shannon Nelson 2021-10-01  510  			 (u8)idev->dev_info.fw_version[3]);
36b20b7fb1c3cb Shannon Nelson 2021-10-01  511  
a21b5d49e77a2e Shannon Nelson 2020-10-01  512  	err = ionic_lif_identify(ionic, IONIC_LIF_TYPE_CLASSIC,
a21b5d49e77a2e Shannon Nelson 2020-10-01  513  				 &ionic->ident.lif);
a21b5d49e77a2e Shannon Nelson 2020-10-01  514  	if (err) {
a21b5d49e77a2e Shannon Nelson 2020-10-01  515  		dev_err(ionic->dev, "Cannot identify LIFs: %d\n", err);
a21b5d49e77a2e Shannon Nelson 2020-10-01  516  		goto err_out;
a21b5d49e77a2e Shannon Nelson 2020-10-01  517  	}
fbfb8031533c92 Shannon Nelson 2019-09-03  518  
fbfb8031533c92 Shannon Nelson 2019-09-03  519  	return 0;
fbfb8031533c92 Shannon Nelson 2019-09-03  520  
a21b5d49e77a2e Shannon Nelson 2020-10-01  521  err_out:
fbfb8031533c92 Shannon Nelson 2019-09-03  522  	return err;
fbfb8031533c92 Shannon Nelson 2019-09-03  523  }
fbfb8031533c92 Shannon Nelson 2019-09-03  524  

:::::: The code at line 479 was first introduced by commit
:::::: 1fcbebf115d9ce077c2ba5ecfb521cc1eedcb467 ionic: drop ethtool driver version

:::::: TO: Shannon Nelson <snelson@pensando.io>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
