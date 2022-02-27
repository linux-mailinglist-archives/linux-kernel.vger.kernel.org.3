Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7D94C5990
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 06:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiB0F2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 00:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiB0F2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 00:28:07 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B7213FB5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 21:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645939644; x=1677475644;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dThaRCARWgD0WYtApn63KdLoojWjy8sjVprrcytnsSE=;
  b=a5riqrwOxpXDRuTsfZCzl0FFoyAWP/tz8ZuU+6S50siv5bnDtQrOfuWX
   nuLCWOCmq/jynB/g8/FMtmUVYrpXdIJKDEMh/Iw19TpHo1zda/F5JrNfw
   2VUdTdPTCtbfjHaJALb9YQOU++nKAxKJPbuiPMyVpO7bGhtffVF4D8VeS
   mkWoyQwYDkaC0KHCChom6i0zczgf5A3FtEAqWfuqYzuf/jfx3J0huYIAM
   8O3CopSDphLWoO/y36bcaf3Gupp4cjE0yEcCwE0MG+2+tdbJrIxxC9NJA
   VZg0UzALkY7EsfvLaFFtG5rQX+3r7i+A5KCdkbL1K0Zu1zkeX1gsQSSO3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="252436018"
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="252436018"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 21:27:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="640542586"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 26 Feb 2022 21:27:22 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOC5Z-0006G1-V2; Sun, 27 Feb 2022 05:27:21 +0000
Date:   Sun, 27 Feb 2022 13:26:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     kbuild-all@lists.01.org, Atish Patra <Atish.Patra@wdc.com>,
        linux-kernel@vger.kernel.org
Subject: [atishp04:sstc_v1 14/14] arch/riscv/kvm/vcpu_timer.c:312:55:
 warning: right shift count >= width of type
Message-ID: <202202271321.biwCXG9G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/atishp04/linux sstc_v1
head:   8904ca0d06f70e6d150b60b72d5ce21044ac9208
commit: 8904ca0d06f70e6d150b60b72d5ce21044ac9208 [14/14] RISC-V: KVM: Support sstc extension
config: riscv-randconfig-r001-20220227 (https://download.01.org/0day-ci/archive/20220227/202202271321.biwCXG9G-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/atishp04/linux/commit/8904ca0d06f70e6d150b60b72d5ce21044ac9208
        git remote add atishp04 https://github.com/atishp04/linux
        git fetch --no-tags atishp04 sstc_v1
        git checkout 8904ca0d06f70e6d150b60b72d5ce21044ac9208
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/ptrace.h:10,
                    from arch/riscv/include/asm/processor.h:13,
                    from arch/riscv/include/asm/irqflags.h:10,
                    from include/linux/irqflags.h:16,
                    from arch/riscv/include/asm/bitops.h:14,
                    from include/linux/bitops.h:33,
                    from include/linux/log2.h:12,
                    from include/asm-generic/div64.h:55,
                    from ./arch/riscv/include/generated/asm/div64.h:1,
                    from include/linux/math.h:5,
                    from include/linux/math64.h:6,
                    from include/linux/time64.h:5,
                    from include/linux/restart_block.h:10,
                    from include/linux/thread_info.h:14,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/percpu.h:6,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/kvm_host.h:7,
                    from arch/riscv/kvm/vcpu_timer.c:11:
   arch/riscv/kvm/vcpu_timer.c: In function 'kvm_riscv_vcpu_timer_restore':
>> arch/riscv/kvm/vcpu_timer.c:312:55: warning: right shift count >= width of type [-Wshift-count-overflow]
     312 |         csr_write(CSR_VSTIMECMPH, (u32)csr->vstimecmp >> 32);
         |                                                       ^~
   arch/riscv/include/asm/csr.h:283:45: note: in definition of macro 'csr_write'
     283 |         unsigned long __v = (unsigned long)(val);               \
         |                                             ^~~
   arch/riscv/kvm/vcpu_timer.c: In function 'kvm_riscv_vcpu_timer_save':
   arch/riscv/kvm/vcpu_timer.c:337:52: warning: right shift count >= width of type [-Wshift-count-overflow]
     337 |         csr->vstimecmp |= csr_read(CSR_VSTIMECMPH) >> 32;
         |                                                    ^~


vim +312 arch/riscv/kvm/vcpu_timer.c

   295	
   296	void kvm_riscv_vcpu_timer_restore(struct kvm_vcpu *vcpu)
   297	{
   298		struct kvm_vcpu_timer *vst;
   299		struct kvm_vcpu_csr *csr;
   300	
   301		kvm_riscv_vcpu_update_timedelta(vcpu);
   302	
   303		if (!cpu_sstc_ext_available)
   304			return;
   305	
   306		vst = &vcpu->arch.vstimer;
   307		csr = &vcpu->arch.guest_csr;
   308	#ifdef CONFIG_64BIT
   309		csr_write(CSR_VSTIMECMP, csr->vstimecmp);
   310	#else
   311		csr_write(CSR_VSTIMECMP, (u32)csr->vstimecmp);
 > 312		csr_write(CSR_VSTIMECMPH, (u32)csr->vstimecmp >> 32);
   313	#endif
   314	
   315		/* vstimer should be enabled for the remaining operations */
   316		if (unlikely(!vst->init_done))
   317			return;
   318	
   319		if (kvm_vcpu_is_blocking(vcpu))
   320			kvm_riscv_vcpu_timer_blocking(vcpu);
   321	}
   322	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
