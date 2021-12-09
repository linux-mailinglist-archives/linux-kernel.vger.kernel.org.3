Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813FD46F58F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 22:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhLIVIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 16:08:16 -0500
Received: from mga11.intel.com ([192.55.52.93]:31442 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231374AbhLIVIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 16:08:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639083881; x=1670619881;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4hxx5pVJ+4n5HPkOdw7km8GM2pLgp9IY2efketRTUik=;
  b=UPxpEKEwrhe0nfcCKdUb+Xq5HFwNvWWeCtIKsDa6iF9SH671luRVtF7n
   bCXrr4+hbUjEUAndmrYzkm21NDq7vaHvzL5Ci7JKZ0AS5gslCPbB4YnjN
   2CSMCINLcP4Zda6r3x9CUBLcSFkuQxoYmdEH0f3ehY/EToFUOHqytV1u4
   eCfa5+AJ9Umo7DmV1blsDwh+gfnPwD0ojXEQcBUg3cnruvYxmQRs9eu9C
   r3szrDiJolrEIFwgQS80kkKk6YHIsbD1ciJrOGuGmj28PRaw9y5hrveuE
   i0D1EbZogUNmEqBjeiOeDkLgN08w8dn2Jr/fGGyu8r1aBcPQR8JV/ysen
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="235718580"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="235718580"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 13:04:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="516479308"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 09 Dec 2021 13:04:39 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvQak-0002Nk-Tu; Thu, 09 Dec 2021 21:04:38 +0000
Date:   Fri, 10 Dec 2021 05:04:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: arch/mips/kvm/vz.c:1552: warning: expecting prototype for
 kvm_trap_vz_handle_cop_unusuable(). Prototype was for
 kvm_trap_vz_handle_cop_unusable() instead
Message-ID: <202112100504.EqkymVXu-lkp@intel.com>
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
head:   2a987e65025e2b79c6d453b78cb5985ac6e5eb26
commit: 45c7e8af4a5e3f0bea4ac209eea34118dd57ac64 MIPS: Remove KVM_TE support
date:   9 months ago
config: mips-randconfig-r005-20211209 (https://download.01.org/0day-ci/archive/20211210/202112100504.EqkymVXu-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash arch/mips/crypto/ arch/mips/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/mips/kvm/vz.c:471: warning: Function parameter or member 'out_compare' not described in '_kvm_vz_save_htimer'
   arch/mips/kvm/vz.c:471: warning: Function parameter or member 'out_cause' not described in '_kvm_vz_save_htimer'
   arch/mips/kvm/vz.c:471: warning: Excess function parameter 'compare' description in '_kvm_vz_save_htimer'
   arch/mips/kvm/vz.c:471: warning: Excess function parameter 'cause' description in '_kvm_vz_save_htimer'
>> arch/mips/kvm/vz.c:1552: warning: expecting prototype for kvm_trap_vz_handle_cop_unusuable(). Prototype was for kvm_trap_vz_handle_cop_unusable() instead


vim +1552 arch/mips/kvm/vz.c

c992a4f6a9b0a37 James Hogan   2017-03-14  1543  
c992a4f6a9b0a37 James Hogan   2017-03-14  1544  /**
c992a4f6a9b0a37 James Hogan   2017-03-14  1545   * kvm_trap_vz_handle_cop_unusuable() - Guest used unusable coprocessor.
c992a4f6a9b0a37 James Hogan   2017-03-14  1546   * @vcpu:	Virtual CPU context.
c992a4f6a9b0a37 James Hogan   2017-03-14  1547   *
c992a4f6a9b0a37 James Hogan   2017-03-14  1548   * Handle when the guest attempts to use a coprocessor which hasn't been allowed
c992a4f6a9b0a37 James Hogan   2017-03-14  1549   * by the root context.
c992a4f6a9b0a37 James Hogan   2017-03-14  1550   */
c992a4f6a9b0a37 James Hogan   2017-03-14  1551  static int kvm_trap_vz_handle_cop_unusable(struct kvm_vcpu *vcpu)
c992a4f6a9b0a37 James Hogan   2017-03-14 @1552  {
c992a4f6a9b0a37 James Hogan   2017-03-14  1553  	u32 cause = vcpu->arch.host_cp0_cause;
c992a4f6a9b0a37 James Hogan   2017-03-14  1554  	enum emulation_result er = EMULATE_FAIL;
c992a4f6a9b0a37 James Hogan   2017-03-14  1555  	int ret = RESUME_GUEST;
c992a4f6a9b0a37 James Hogan   2017-03-14  1556  
c992a4f6a9b0a37 James Hogan   2017-03-14  1557  	if (((cause & CAUSEF_CE) >> CAUSEB_CE) == 1) {
c992a4f6a9b0a37 James Hogan   2017-03-14  1558  		/*
c992a4f6a9b0a37 James Hogan   2017-03-14  1559  		 * If guest FPU not present, the FPU operation should have been
c992a4f6a9b0a37 James Hogan   2017-03-14  1560  		 * treated as a reserved instruction!
c992a4f6a9b0a37 James Hogan   2017-03-14  1561  		 * If FPU already in use, we shouldn't get this at all.
c992a4f6a9b0a37 James Hogan   2017-03-14  1562  		 */
c992a4f6a9b0a37 James Hogan   2017-03-14  1563  		if (WARN_ON(!kvm_mips_guest_has_fpu(&vcpu->arch) ||
c992a4f6a9b0a37 James Hogan   2017-03-14  1564  			    vcpu->arch.aux_inuse & KVM_MIPS_AUX_FPU)) {
c992a4f6a9b0a37 James Hogan   2017-03-14  1565  			preempt_enable();
c992a4f6a9b0a37 James Hogan   2017-03-14  1566  			return EMULATE_FAIL;
c992a4f6a9b0a37 James Hogan   2017-03-14  1567  		}
c992a4f6a9b0a37 James Hogan   2017-03-14  1568  
c992a4f6a9b0a37 James Hogan   2017-03-14  1569  		kvm_own_fpu(vcpu);
c992a4f6a9b0a37 James Hogan   2017-03-14  1570  		er = EMULATE_DONE;
c992a4f6a9b0a37 James Hogan   2017-03-14  1571  	}
c992a4f6a9b0a37 James Hogan   2017-03-14  1572  	/* other coprocessors not handled */
c992a4f6a9b0a37 James Hogan   2017-03-14  1573  
c992a4f6a9b0a37 James Hogan   2017-03-14  1574  	switch (er) {
c992a4f6a9b0a37 James Hogan   2017-03-14  1575  	case EMULATE_DONE:
c992a4f6a9b0a37 James Hogan   2017-03-14  1576  		ret = RESUME_GUEST;
c992a4f6a9b0a37 James Hogan   2017-03-14  1577  		break;
c992a4f6a9b0a37 James Hogan   2017-03-14  1578  
c992a4f6a9b0a37 James Hogan   2017-03-14  1579  	case EMULATE_FAIL:
c34b26b98caca48 Tianjia Zhang 2020-06-23  1580  		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
c992a4f6a9b0a37 James Hogan   2017-03-14  1581  		ret = RESUME_HOST;
c992a4f6a9b0a37 James Hogan   2017-03-14  1582  		break;
c992a4f6a9b0a37 James Hogan   2017-03-14  1583  
c992a4f6a9b0a37 James Hogan   2017-03-14  1584  	default:
c992a4f6a9b0a37 James Hogan   2017-03-14  1585  		BUG();
c992a4f6a9b0a37 James Hogan   2017-03-14  1586  	}
c992a4f6a9b0a37 James Hogan   2017-03-14  1587  	return ret;
c992a4f6a9b0a37 James Hogan   2017-03-14  1588  }
c992a4f6a9b0a37 James Hogan   2017-03-14  1589  

:::::: The code at line 1552 was first introduced by commit
:::::: c992a4f6a9b0a37c8bd7dfc727ecc3fed125c16b KVM: MIPS: Implement VZ support

:::::: TO: James Hogan <james.hogan@imgtec.com>
:::::: CC: James Hogan <james.hogan@imgtec.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
