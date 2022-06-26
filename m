Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD2A55AE08
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 03:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiFZBoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 21:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbiFZBop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 21:44:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05006E0D2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 18:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656207884; x=1687743884;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vac6tMAOfUZU5ZHFDgcgjGLQykDNtGMVCNxpXJFogAQ=;
  b=f5nYoUUngAOhoznO6hEALbL2pTeHR8bd/ViMZSPPDE83I86x16UZ7siY
   Ofoev5rXoLmIm+xgs7q9xgQfUFkZsM/sZE0MyrDEhpGcbBgdl2AoIXc/A
   f7fxombqJImpJlmyOMj61SF3dw20pJ7go23CbMNI2z02uRM1rttH3CYrA
   GuBLf7HN1KdlYdKG/eMXEWglhdRstFHF6eAfzgf/tL/yaMJRJBBQuqM8z
   8Plmv84KFeeAp3wobHUzGJ9gM7pWs/tuI9cpkrIT5YF8UWJETSosNU8nh
   ikgEwfdYpVh5hleRqqlNnF1vTVt+SDNGH0xyqrJSO7jm7gWFhwfFdkqNN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10389"; a="367549795"
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="367549795"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 18:44:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="587011969"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Jun 2022 18:44:43 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5HKM-0006Z9-HE;
        Sun, 26 Jun 2022 01:44:42 +0000
Date:   Sun, 26 Jun 2022 09:44:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: drivers/watchdog/mtx-1_wdt.c:184:27: sparse: sparse: incorrect type
 in initializer (incompatible argument 2 (different address spaces))
Message-ID: <202206260919.dDRBCnTm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0840a7914caa14315a3191178a9f72c742477860
commit: 76215889be9d2cd388207545424bbbe3bf80e1ea watchdog: mtx-1: drop au1000.h header file
date:   1 year ago
config: mips-randconfig-s032-20220626
compiler: mips64el-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-31-g4880bd19-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=76215889be9d2cd388207545424bbbe3bf80e1ea
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 76215889be9d2cd388207545424bbbe3bf80e1ea
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash drivers/watchdog/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
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
