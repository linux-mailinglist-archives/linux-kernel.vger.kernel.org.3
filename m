Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCF447210F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 07:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhLMG1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 01:27:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:23035 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232176AbhLMG1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 01:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639376861; x=1670912861;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rWBzBemTO2R+UxAwKhYbiYU/nf9v9KstHstUOWje57Q=;
  b=mH9qJ2Nn33OvT7V7Rbm8fZ95fbMEHH36wzkfuLSx0wY4wEcwcUKBvvJ0
   0poiYd1fGD1KN9ZRaHImNJSuRY0Wn+txIfKYiAJ5GNXPPjnSsLPiFHGsW
   Bf3qUgy7uiGz+MGwdiOGyumSw+y9Ay4C9oz8sN+nv4mbYbyGvc5Bxumfk
   i9pc7C2gky47XWRfnD1rLOqBHsb8rJijk/hQ1UP355o8ab7/GH9oAAWW5
   wZX00G7WgI5knFwqOoTFLOiYxbhygotk19pIy2FvMYpTNOVY7nR3Lu0jB
   H35r2x4pHRmSw1GO/uAGUNMXoRtDBgYDNu3eD9d0BwqNFChtyQXwCgulZ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="218684995"
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="218684995"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2021 22:27:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,201,1635231600"; 
   d="scan'208";a="463269894"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Dec 2021 22:27:39 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mweoE-0006Nk-Bl; Mon, 13 Dec 2021 06:27:38 +0000
Date:   Mon, 13 Dec 2021 14:27:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: drivers/watchdog/mtx-1_wdt.c:184:27: sparse: sparse: incorrect type
 in initializer (incompatible argument 2 (different address spaces))
Message-ID: <202112131443.4HWvLXx9-lkp@intel.com>
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
head:   2585cf9dfaaddf00b069673f27bb3f8530e2039c
commit: 76215889be9d2cd388207545424bbbe3bf80e1ea watchdog: mtx-1: drop au1000.h header file
date:   6 months ago
config: mips-randconfig-s032-20211213 (https://download.01.org/0day-ci/archive/20211213/202112131443.4HWvLXx9-lkp@intel.com/config)
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
