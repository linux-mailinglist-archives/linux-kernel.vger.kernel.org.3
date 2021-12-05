Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772FE4688CA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 01:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhLEAyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 19:54:35 -0500
Received: from mga06.intel.com ([134.134.136.31]:46340 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229772AbhLEAye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 19:54:34 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10188"; a="297951666"
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="297951666"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2021 16:51:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,288,1631602800"; 
   d="scan'208";a="562158876"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 04 Dec 2021 16:51:06 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtfkA-000JdL-BT; Sun, 05 Dec 2021 00:51:06 +0000
Date:   Sun, 5 Dec 2021 08:50:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>, Kai Huang <kai.huang@intel.com>
Subject: arch/x86/kernel/cpu/sgx/virt.c:295:36: sparse: sparse: cast removes
 address space '__user' of expression
Message-ID: <202112050804.fLXTUZhm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bbef3c7a63d2a4cb0f3f839db9e767f168c5e348
commit: d155030b1e7c0e448aab22a803f7a71ea2e117d7 x86/sgx: Add helpers to expose ECREATE and EINIT to KVM
date:   8 months ago
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20211205/202112050804.fLXTUZhm-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d155030b1e7c0e448aab22a803f7a71ea2e117d7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d155030b1e7c0e448aab22a803f7a71ea2e117d7
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/hyperv/ arch/x86/kernel/cpu/sgx/ drivers/hv/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected int [assigned] ret @@     got restricted vm_fault_t @@
   arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse:     expected int [assigned] ret
   arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse:     got restricted vm_fault_t
   arch/x86/kernel/cpu/sgx/virt.c:60:20: sparse: sparse: restricted vm_fault_t degrades to integer
   arch/x86/kernel/cpu/sgx/virt.c:95:35: sparse: sparse: symbol 'sgx_vepc_vm_ops' was not declared. Should it be static?
>> arch/x86/kernel/cpu/sgx/virt.c:295:36: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/cpu/sgx/virt.c:326:24: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/cpu/sgx/virt.c:326:43: sparse: sparse: cast removes address space '__user' of expression
   arch/x86/kernel/cpu/sgx/virt.c:326:58: sparse: sparse: cast removes address space '__user' of expression

vim +/__user +295 arch/x86/kernel/cpu/sgx/virt.c

   260	
   261	/**
   262	 * sgx_virt_ecreate() - Run ECREATE on behalf of guest
   263	 * @pageinfo:	Pointer to PAGEINFO structure
   264	 * @secs:	Userspace pointer to SECS page
   265	 * @trapnr:	trap number injected to guest in case of ECREATE error
   266	 *
   267	 * Run ECREATE on behalf of guest after KVM traps ECREATE for the purpose
   268	 * of enforcing policies of guest's enclaves, and return the trap number
   269	 * which should be injected to guest in case of any ECREATE error.
   270	 *
   271	 * Return:
   272	 * -  0:	ECREATE was successful.
   273	 * - <0:	on error.
   274	 */
   275	int sgx_virt_ecreate(struct sgx_pageinfo *pageinfo, void __user *secs,
   276			     int *trapnr)
   277	{
   278		int ret;
   279	
   280		/*
   281		 * @secs is an untrusted, userspace-provided address.  It comes from
   282		 * KVM and is assumed to be a valid pointer which points somewhere in
   283		 * userspace.  This can fault and call SGX or other fault handlers when
   284		 * userspace mapping @secs doesn't exist.
   285		 *
   286		 * Add a WARN() to make sure @secs is already valid userspace pointer
   287		 * from caller (KVM), who should already have handled invalid pointer
   288		 * case (for instance, made by malicious guest).  All other checks,
   289		 * such as alignment of @secs, are deferred to ENCLS itself.
   290		 */
   291		if (WARN_ON_ONCE(!access_ok(secs, PAGE_SIZE)))
   292			return -EINVAL;
   293	
   294		__uaccess_begin();
 > 295		ret = __ecreate(pageinfo, (void *)secs);
   296		__uaccess_end();
   297	
   298		if (encls_faulted(ret)) {
   299			*trapnr = ENCLS_TRAPNR(ret);
   300			return -EFAULT;
   301		}
   302	
   303		/* ECREATE doesn't return an error code, it faults or succeeds. */
   304		WARN_ON_ONCE(ret);
   305		return 0;
   306	}
   307	EXPORT_SYMBOL_GPL(sgx_virt_ecreate);
   308	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
