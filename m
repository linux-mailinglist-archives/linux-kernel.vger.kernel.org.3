Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820394FA4D7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 07:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbiDIFHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 01:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241090AbiDIFFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 01:05:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5421DDFE0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 22:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649480518; x=1681016518;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mrxeIMFE/zCJOE//MbawfI5/xq/MFMlJPnchF/qYcHY=;
  b=KmGV02V130nQznsgVtsk2SnL3yP9zrrldFl5bzKc11je5hEyNWFid4MY
   1Wn/Z84wv/sc+MjRbw3iPeTSPaZYl5UFRUd6b47Dm8PlCFCQ3Jf7RjNXZ
   smB16eA/l+jOGr06VU+Btko4wYoFxqFD13zF/t7s6orWW8hkR+Fs/1c4G
   KcnvHOhVtb4ce7b2bqpSZToH/vT959yOW45Bya03b7R+DTTx4MpN6xRfk
   a6LgKP1+R3c62l57A8uPbxYieY2Ek/0HvhrF4YGCvxhdEhCAdgBJZ4est
   XECKfOZV5w0XwIFMSY3DArJmnrWosz41RPvH0PXyQGCCKaXUN8bzCQQbw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="259357342"
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="259357342"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 22:01:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="698496085"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 08 Apr 2022 22:01:56 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nd3ER-0000sr-IU;
        Sat, 09 Apr 2022 05:01:55 +0000
Date:   Sat, 9 Apr 2022 13:01:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: drivers/watchdog/mtx-1_wdt.c:184:27: sparse: sparse: incorrect type
 in initializer (incompatible argument 2 (different address spaces))
Message-ID: <202204091208.7UtE1W6a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6c7376da23587738ab0e84b8b90b6cc02db5181e
commit: 76215889be9d2cd388207545424bbbe3bf80e1ea watchdog: mtx-1: drop au1000.h header file
date:   10 months ago
config: mips-randconfig-s032-20220409 (https://download.01.org/0day-ci/archive/20220409/202204091208.7UtE1W6a-lkp@intel.com/config)
compiler: mips64el-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=76215889be9d2cd388207545424bbbe3bf80e1ea
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 76215889be9d2cd388207545424bbbe3bf80e1ea
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/watchdog/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> drivers/watchdog/mtx-1_wdt.c:184:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected long ( *write )( ... ) @@     got long ( * )( ... ) @@
   drivers/watchdog/mtx-1_wdt.c:184:27: sparse:     expected long ( *write )( ... )
   drivers/watchdog/mtx-1_wdt.c:184:27: sparse:     got long ( * )( ... )

vim +184 drivers/watchdog/mtx-1_wdt.c

04bf3b4f5fc033 drivers/char/watchdog/mtx-1_wdt.c Florian Fainelli 2007-05-06  177  
b47a166ed0baaa drivers/watchdog/mtx-1_wdt.c      Jan Engelhardt   2008-01-22  178  static const struct file_operations mtx1_wdt_fops = {
04bf3b4f5fc033 drivers/char/watchdog/mtx-1_wdt.c Florian Fainelli 2007-05-06  179  	.owner		= THIS_MODULE,
04bf3b4f5fc033 drivers/char/watchdog/mtx-1_wdt.c Florian Fainelli 2007-05-06  180  	.llseek		= no_llseek,
ed78c2da149247 drivers/watchdog/mtx-1_wdt.c      Alan Cox         2008-05-19  181  	.unlocked_ioctl	= mtx1_wdt_ioctl,
b6dfb2477fb0bf drivers/watchdog/mtx-1_wdt.c      Arnd Bergmann    2019-06-03  182  	.compat_ioctl	= compat_ptr_ioctl,
04bf3b4f5fc033 drivers/char/watchdog/mtx-1_wdt.c Florian Fainelli 2007-05-06  183  	.open		= mtx1_wdt_open,
04bf3b4f5fc033 drivers/char/watchdog/mtx-1_wdt.c Florian Fainelli 2007-05-06 @184  	.write		= mtx1_wdt_write,
7944d3a5a70ee5 drivers/watchdog/mtx-1_wdt.c      Wim Van Sebroeck 2008-08-06  185  	.release	= mtx1_wdt_release,
04bf3b4f5fc033 drivers/char/watchdog/mtx-1_wdt.c Florian Fainelli 2007-05-06  186  };
04bf3b4f5fc033 drivers/char/watchdog/mtx-1_wdt.c Florian Fainelli 2007-05-06  187  
04bf3b4f5fc033 drivers/char/watchdog/mtx-1_wdt.c Florian Fainelli 2007-05-06  188  

:::::: The code at line 184 was first introduced by commit
:::::: 04bf3b4f5fc033adf921f2e57d034ddbebef5fe7 [WATCHDOG] MTX-1 Watchdog driver

:::::: TO: Florian Fainelli <florian.fainelli@int-evry.fr>
:::::: CC: Wim Van Sebroeck <wim@iguana.be>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
