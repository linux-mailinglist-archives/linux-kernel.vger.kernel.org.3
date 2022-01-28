Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC76C4A0280
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 22:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349917AbiA1VEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 16:04:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:32648 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231409AbiA1VEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 16:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643403844; x=1674939844;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ASgkFYwwTRZanrw0AK9YosZcIFPeg1uJvPc0GqPq9/E=;
  b=VGh2sH5jYiaj0sPTJOjA8cbKvA6o9eVRo2r9Yj8QhX0N1MpjqQ9WEEJ3
   onXi5lnih3BXWT9TpL1kF63D5LOx52ozVVsdmyhwMd191SocgDyO7S5Og
   F0Fy4KyFneP8dMeGGgWnPFli/z5Xdvksav+skXYS+nKF+6FxSUpXVpncw
   UIrgY0Hxvml9uDLCFCB7G71pVJyO9qv5+XsKLMuE/oGX9QBvMvxYRmLql
   Pd0v18duwHTJVIiF6VrguBod4QN49HgtRjOCPUHSrnymBo5zggtiJ0mbB
   3c1bf7zpiBK4Z6Y+Kp0GRANcViardsHnJvxxRhu/MQzNXpzHbvqtV33LR
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="307926877"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="307926877"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 13:04:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="496249913"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Jan 2022 13:04:02 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDYPZ-000OJV-Sm; Fri, 28 Jan 2022 21:04:01 +0000
Date:   Sat, 29 Jan 2022 05:03:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: arch/mips/kvm/vz.c:1552: warning: expecting prototype for
 kvm_trap_vz_handle_cop_unusuable(). Prototype was for
 kvm_trap_vz_handle_cop_unusable() instead
Message-ID: <202201290312.Zn2lLZub-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   145d9b498fc827b79c1260b4caa29a8e59d4c2b9
commit: 45c7e8af4a5e3f0bea4ac209eea34118dd57ac64 MIPS: Remove KVM_TE support
date:   11 months ago
config: mips-malta_kvm_defconfig (https://download.01.org/0day-ci/archive/20220129/202201290312.Zn2lLZub-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 33b45ee44b1f32ffdbc995e6fec806271b4b3ba4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=45c7e8af4a5e3f0bea4ac209eea34118dd57ac64
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 45c7e8af4a5e3f0bea4ac209eea34118dd57ac64
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/mips/kvm/vz.c:471: warning: Function parameter or member 'out_compare' not described in '_kvm_vz_save_htimer'
   arch/mips/kvm/vz.c:471: warning: Function parameter or member 'out_cause' not described in '_kvm_vz_save_htimer'
   arch/mips/kvm/vz.c:471: warning: Excess function parameter 'compare' description in '_kvm_vz_save_htimer'
   arch/mips/kvm/vz.c:471: warning: Excess function parameter 'cause' description in '_kvm_vz_save_htimer'
>> arch/mips/kvm/vz.c:1552: warning: expecting prototype for kvm_trap_vz_handle_cop_unusuable(). Prototype was for kvm_trap_vz_handle_cop_unusable() instead


vim +1552 arch/mips/kvm/vz.c

c992a4f6a9b0a3 James Hogan   2017-03-14  1543  
c992a4f6a9b0a3 James Hogan   2017-03-14  1544  /**
c992a4f6a9b0a3 James Hogan   2017-03-14  1545   * kvm_trap_vz_handle_cop_unusuable() - Guest used unusable coprocessor.
c992a4f6a9b0a3 James Hogan   2017-03-14  1546   * @vcpu:	Virtual CPU context.
c992a4f6a9b0a3 James Hogan   2017-03-14  1547   *
c992a4f6a9b0a3 James Hogan   2017-03-14  1548   * Handle when the guest attempts to use a coprocessor which hasn't been allowed
c992a4f6a9b0a3 James Hogan   2017-03-14  1549   * by the root context.
c992a4f6a9b0a3 James Hogan   2017-03-14  1550   */
c992a4f6a9b0a3 James Hogan   2017-03-14  1551  static int kvm_trap_vz_handle_cop_unusable(struct kvm_vcpu *vcpu)
c992a4f6a9b0a3 James Hogan   2017-03-14 @1552  {
c992a4f6a9b0a3 James Hogan   2017-03-14  1553  	u32 cause = vcpu->arch.host_cp0_cause;
c992a4f6a9b0a3 James Hogan   2017-03-14  1554  	enum emulation_result er = EMULATE_FAIL;
c992a4f6a9b0a3 James Hogan   2017-03-14  1555  	int ret = RESUME_GUEST;
c992a4f6a9b0a3 James Hogan   2017-03-14  1556  
c992a4f6a9b0a3 James Hogan   2017-03-14  1557  	if (((cause & CAUSEF_CE) >> CAUSEB_CE) == 1) {
c992a4f6a9b0a3 James Hogan   2017-03-14  1558  		/*
c992a4f6a9b0a3 James Hogan   2017-03-14  1559  		 * If guest FPU not present, the FPU operation should have been
c992a4f6a9b0a3 James Hogan   2017-03-14  1560  		 * treated as a reserved instruction!
c992a4f6a9b0a3 James Hogan   2017-03-14  1561  		 * If FPU already in use, we shouldn't get this at all.
c992a4f6a9b0a3 James Hogan   2017-03-14  1562  		 */
c992a4f6a9b0a3 James Hogan   2017-03-14  1563  		if (WARN_ON(!kvm_mips_guest_has_fpu(&vcpu->arch) ||
c992a4f6a9b0a3 James Hogan   2017-03-14  1564  			    vcpu->arch.aux_inuse & KVM_MIPS_AUX_FPU)) {
c992a4f6a9b0a3 James Hogan   2017-03-14  1565  			preempt_enable();
c992a4f6a9b0a3 James Hogan   2017-03-14  1566  			return EMULATE_FAIL;
c992a4f6a9b0a3 James Hogan   2017-03-14  1567  		}
c992a4f6a9b0a3 James Hogan   2017-03-14  1568  
c992a4f6a9b0a3 James Hogan   2017-03-14  1569  		kvm_own_fpu(vcpu);
c992a4f6a9b0a3 James Hogan   2017-03-14  1570  		er = EMULATE_DONE;
c992a4f6a9b0a3 James Hogan   2017-03-14  1571  	}
c992a4f6a9b0a3 James Hogan   2017-03-14  1572  	/* other coprocessors not handled */
c992a4f6a9b0a3 James Hogan   2017-03-14  1573  
c992a4f6a9b0a3 James Hogan   2017-03-14  1574  	switch (er) {
c992a4f6a9b0a3 James Hogan   2017-03-14  1575  	case EMULATE_DONE:
c992a4f6a9b0a3 James Hogan   2017-03-14  1576  		ret = RESUME_GUEST;
c992a4f6a9b0a3 James Hogan   2017-03-14  1577  		break;
c992a4f6a9b0a3 James Hogan   2017-03-14  1578  
c992a4f6a9b0a3 James Hogan   2017-03-14  1579  	case EMULATE_FAIL:
c34b26b98caca4 Tianjia Zhang 2020-06-23  1580  		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
c992a4f6a9b0a3 James Hogan   2017-03-14  1581  		ret = RESUME_HOST;
c992a4f6a9b0a3 James Hogan   2017-03-14  1582  		break;
c992a4f6a9b0a3 James Hogan   2017-03-14  1583  
c992a4f6a9b0a3 James Hogan   2017-03-14  1584  	default:
c992a4f6a9b0a3 James Hogan   2017-03-14  1585  		BUG();
c992a4f6a9b0a3 James Hogan   2017-03-14  1586  	}
c992a4f6a9b0a3 James Hogan   2017-03-14  1587  	return ret;
c992a4f6a9b0a3 James Hogan   2017-03-14  1588  }
c992a4f6a9b0a3 James Hogan   2017-03-14  1589  

:::::: The code at line 1552 was first introduced by commit
:::::: c992a4f6a9b0a37c8bd7dfc727ecc3fed125c16b KVM: MIPS: Implement VZ support

:::::: TO: James Hogan <james.hogan@imgtec.com>
:::::: CC: James Hogan <james.hogan@imgtec.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
