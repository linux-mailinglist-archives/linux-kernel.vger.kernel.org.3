Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515E4468662
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 18:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355548AbhLDRE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 12:04:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:7646 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355347AbhLDRE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 12:04:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="237072559"
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="237072559"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 09:00:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,287,1631602800"; 
   d="scan'208";a="610771544"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 04 Dec 2021 09:00:55 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtYP9-000JDX-5H; Sat, 04 Dec 2021 17:00:55 +0000
Date:   Sun, 5 Dec 2021 00:59:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [chenxing:msc313_mainlining 66/73]
 drivers/irqchip/irq-msc313-pm-wakeup.c:21:25: error: 'field_mask' redeclared
 as different kind of symbol
Message-ID: <202112050039.jCdN1Ahm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/linux-chenxing/linux.git msc313_mainlining
head:   4c9fe2eaf0fcfd50fbd5abafd740731257f5a8d6
commit: f5fb19c0d43f74f67be367e492708b7a53e853c1 [66/73] irqchip: MStar wakeup intc
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20211205/202112050039.jCdN1Ahm-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/linux-chenxing/linux/commit/f5fb19c0d43f74f67be367e492708b7a53e853c1
        git remote add chenxing git://github.com/linux-chenxing/linux.git
        git fetch --no-tags chenxing msc313_mainlining
        git checkout f5fb19c0d43f74f67be367e492708b7a53e853c1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/irqchip/irq-msc313-pm-wakeup.c:21:25: error: 'field_mask' redeclared as different kind of symbol
      21 | static struct reg_field field_mask = REG_FIELD(MSTAR_PMSLEEP_WAKEUPSOURCE, 0, 7);
         |                         ^~~~~~~~~~
   In file included from arch/mips/include/asm/mips-cm.h:14,
                    from arch/mips/include/asm/mips-cps.h:104,
                    from arch/mips/include/asm/smp-ops.h:16,
                    from arch/mips/include/asm/smp.h:21,
                    from include/linux/smp.h:113,
                    from include/linux/lockdep.h:14,
                    from include/linux/spinlock.h:62,
                    from include/linux/irq.h:14,
                    from drivers/irqchip/irq-msc313-pm-wakeup.c:6:
   include/linux/bitfield.h:122:28: note: previous definition of 'field_mask' with type 'u64(u64)' {aka 'long long unsigned int(long long unsigned int)'}
     122 | static __always_inline u64 field_mask(u64 field)
         |                            ^~~~~~~~~~
   drivers/irqchip/irq-msc313-pm-wakeup.c: In function 'msc313_pm_wakeup_intc_of_init':
   drivers/irqchip/irq-msc313-pm-wakeup.c:132:9: warning: ignoring return value of 'request_irq' declared with attribute 'warn_unused_result' [-Wunused-result]
     132 |         request_irq(irq, msc313_pm_wakeup_intc_chainedhandler, IRQF_SHARED,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     133 |                                 "pmsleep", domain);
         |                                 ~~~~~~~~~~~~~~~~~~


vim +/field_mask +21 drivers/irqchip/irq-msc313-pm-wakeup.c

    20	
  > 21	static struct reg_field field_mask = REG_FIELD(MSTAR_PMSLEEP_WAKEUPSOURCE, 0, 7);
    22	static struct reg_field field_type = REG_FIELD(MSTAR_PMSLEEP_REG24, 0, 7);
    23	static struct reg_field field_status = REG_FIELD(MSTAR_PMSLEEP_WAKEINT_STATUS, 0, 7);
    24	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
