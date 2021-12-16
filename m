Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A1C47733F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 14:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237612AbhLPNfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 08:35:08 -0500
Received: from mga05.intel.com ([192.55.52.43]:36621 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232211AbhLPNfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 08:35:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639661705; x=1671197705;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xR924ioZNz+ZaYeB6olyR9xJzBJPxwGYcCZKA58ApSE=;
  b=A13FGx/e4Hn3prxpyGf4AEBp7hTveMgW0IrL8QE9kFNtQKZ02ohjVf7z
   Be0t4F5TFkYyNX1oFPj5kmy9aQ6oASVtN3EV1/8ri6S6bS0sobcokfVGB
   OIOQm9q6E920RS2to/59KEqNw4ASVgFzRs9jeU50D9dUce8JMRJ7yg49M
   2nk19NBZ/sGC8JDR2pLrUT9K6OID3aNppa43cJkeFecmubO2qRSPRc0SJ
   3Mkr9eycBcwpg4OkSf9saf5kUDTHHiljPfcjC4VdHBEx1CiFW5Au6UXXp
   j2LomLUll4FkJ3NK5Fm4H5oZrXKRUIdn6+7JkrN3pmPuyMjKiofpILyfV
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="325772543"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="325772543"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 05:35:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="466068760"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2021 05:35:03 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxquU-0003DW-TE; Thu, 16 Dec 2021 13:35:02 +0000
Date:   Thu, 16 Dec 2021 21:34:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: drivers/watchdog/mtx-1_wdt.c:184:27: sparse: sparse: incorrect type
 in initializer (incompatible argument 2 (different address spaces))
Message-ID: <202112162138.CtaUacXU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2b14864acbaaf03d9c01982e243a84632524c3ac
commit: 76215889be9d2cd388207545424bbbe3bf80e1ea watchdog: mtx-1: drop au1000.h header file
date:   6 months ago
config: mips-randconfig-s032-20211216 (https://download.01.org/0day-ci/archive/20211216/202112162138.CtaUacXU-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
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

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
