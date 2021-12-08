Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37CA46C88A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242761AbhLHAOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:14:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:60042 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233913AbhLHAOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:14:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="237949433"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="237949433"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 16:11:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="657960036"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 07 Dec 2021 16:11:17 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mukYG-000N6h-RC; Wed, 08 Dec 2021 00:11:16 +0000
Date:   Wed, 8 Dec 2021 08:10:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 39/40] arch/riscv/kvm/aia_aplic.c:254:6:
 warning: variable 'inject' is used uninitialized whenever 'if' condition is
 true
Message-ID: <202112080820.BR1BIqGS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   eb55ca3817a59020fc1e3d5a5de0a5adcebbedd0
commit: dc0299fdaf9714a56b13b955c086bab2f8bd4046 [39/40] RISC-V: KVM: Add in-kernel emulation of AIA APLIC
config: riscv-randconfig-c006-20211207 (https://download.01.org/0day-ci/archive/20211208/202112080820.BR1BIqGS-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/avpatel/linux/commit/dc0299fdaf9714a56b13b955c086bab2f8bd4046
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_kvm_aia_v1
        git checkout dc0299fdaf9714a56b13b955c086bab2f8bd4046
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kvm/aia_aplic.c:254:6: warning: variable 'inject' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
           if (irqd->sourcecfg & APLIC_SOURCECFG_D)
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/kvm/aia_aplic.c:293:6: note: uninitialized use occurs here
           if (inject)
               ^~~~~~
   arch/riscv/kvm/aia_aplic.c:254:2: note: remove the 'if' if its condition is always false
           if (irqd->sourcecfg & APLIC_SOURCECFG_D)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/kvm/aia_aplic.c:242:13: note: initialize the variable 'inject' to silence this warning
           bool inject, ie;
                      ^
                       = 0
   1 warning generated.


vim +254 arch/riscv/kvm/aia_aplic.c

   238	
   239	int kvm_riscv_aia_aplic_inject(struct kvm *kvm, u32 source, bool level)
   240	{
   241		u32 target;
   242		bool inject, ie;
   243		unsigned long flags;
   244		struct aplic_irq *irqd;
   245		struct aplic *aplic = kvm->arch.aia.aplic_state;
   246	
   247		if (!aplic || !source || (aplic->nr_irqs <= source))
   248			return -ENODEV;
   249		irqd = &aplic->irqs[source];
   250		ie = (aplic->domaincfg & APLIC_DOMAINCFG_IE) ? true : false;
   251	
   252		raw_spin_lock_irqsave(&irqd->lock, flags);
   253	
 > 254		if (irqd->sourcecfg & APLIC_SOURCECFG_D)
   255			goto skip_unlock;
   256	
   257		switch (irqd->sourcecfg & APLIC_SOURCECFG_SM_MASK) {
   258		case APLIC_SOURCECFG_SM_EDGE_RISE:
   259			if (level && !(irqd->state & APLIC_IRQ_STATE_INPUT) &&
   260			    !(irqd->state & APLIC_IRQ_STATE_PENDING))
   261				irqd->state |= APLIC_IRQ_STATE_PENDING;
   262			break;
   263		case APLIC_SOURCECFG_SM_EDGE_FALL:
   264			if (!level && (irqd->state & APLIC_IRQ_STATE_INPUT) &&
   265			    !(irqd->state & APLIC_IRQ_STATE_PENDING))
   266				irqd->state |= APLIC_IRQ_STATE_PENDING;
   267			break;
   268		case APLIC_SOURCECFG_SM_LEVEL_HIGH:
   269			if (level && !(irqd->state & APLIC_IRQ_STATE_PENDING))
   270				irqd->state |= APLIC_IRQ_STATE_PENDING;
   271			break;
   272		case APLIC_SOURCECFG_SM_LEVEL_LOW:
   273			if (!level && !(irqd->state & APLIC_IRQ_STATE_PENDING))
   274				irqd->state |= APLIC_IRQ_STATE_PENDING;
   275			break;
   276		}
   277	
   278		if (level)
   279			irqd->state |= APLIC_IRQ_STATE_INPUT;
   280		else
   281			irqd->state &= ~APLIC_IRQ_STATE_INPUT;
   282	
   283		inject = false;
   284		target = irqd->target;
   285		if (ie && (irqd->state & APLIC_IRQ_STATE_ENPEND)) {
   286			irqd->state &= ~APLIC_IRQ_STATE_PENDING;
   287			inject = true;
   288		}
   289	
   290	skip_unlock:
   291		raw_spin_unlock_irqrestore(&irqd->lock, flags);
   292	
   293		if (inject)
   294			aplic_inject_msi(kvm, source, target);
   295	
   296		return 0;
   297	}
   298	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
