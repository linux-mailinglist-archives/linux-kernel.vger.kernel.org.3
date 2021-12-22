Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400A447CDB1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 08:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243088AbhLVHyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 02:54:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:9888 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243081AbhLVHyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 02:54:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640159679; x=1671695679;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2w+lGVcohewn20WQ0OAK3RTcvvwOvDVPKz5Jg0DFtYc=;
  b=K9Tteyy45ueH6zDQuswttF4HK59nDWN2Jhn9lMvzo+MKJPo8h6U3qpe9
   uMdlSyOXvLxOF3xobwT/e1gJC6CTyqmf6upf+0s1kSvJRPHej7MMB2pl2
   R3jVHq1IV1xqse7lbdIkReAwyRbI4WgSbd8TOk2tU3QiTZaBWj9ztcr76
   77l8NPPwWqUZG2Nr0+XTiURB06lZtpZnyKvzbSk1yQV7ECgssFztvfMDN
   RpkZZTD+b8ZrdHexHQ84twm6hSdgN4iIe0W/K343hAkrrkRdzmhhduAdW
   98pm+1u20UZchbtbSIWIWjerEITaD0jKpz8KsYZ/2xG14ukrf5vcKoDEo
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="303939624"
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="303939624"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 23:54:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="468084609"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 21 Dec 2021 23:54:38 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzwSL-0000Gc-Bd; Wed, 22 Dec 2021 07:54:37 +0000
Date:   Wed, 22 Dec 2021 15:54:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guo Ren <guoren@linux.alibaba.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [csky-linux:riscv_compat_v1 12/13]
 arch/riscv/kernel/compat_signal.c:199:5: warning: no previous prototype for
 'compat_setup_rt_frame'
Message-ID: <202112221514.cPqrnZR0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/c-sky/csky-linux riscv_compat_v1
head:   60f122c486d0c1c8b30e0b264c215db4a5a0124d
commit: 341104ec427222e0500c50837a7661fb57e42c0f [12/13] riscv: compat: signal: Add rt_frame implementation
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20211222/202112221514.cPqrnZR0-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/c-sky/csky-linux/commit/341104ec427222e0500c50837a7661fb57e42c0f
        git remote add csky-linux https://github.com/c-sky/csky-linux
        git fetch --no-tags csky-linux riscv_compat_v1
        git checkout 341104ec427222e0500c50837a7661fb57e42c0f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/ arch/riscv/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/riscv/kernel/compat_signal.c:199:5: warning: no previous prototype for 'compat_setup_rt_frame' [-Wmissing-prototypes]
     199 | int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
         |     ^~~~~~~~~~~~~~~~~~~~~


vim +/compat_setup_rt_frame +199 arch/riscv/kernel/compat_signal.c

   198	
 > 199	int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
   200		struct pt_regs *regs)
   201	{
   202		struct compat_rt_sigframe __user *frame;
   203		long err = 0;
   204	
   205		frame = compat_get_sigframe(ksig, regs, sizeof(*frame));
   206		if (!access_ok(frame, sizeof(*frame)))
   207			return -EFAULT;
   208	
   209		err |= copy_siginfo_to_user32(&frame->info, &ksig->info);
   210	
   211		/* Create the ucontext. */
   212		err |= __put_user(0, &frame->uc.uc_flags);
   213		err |= __put_user(NULL, &frame->uc.uc_link);
   214		err |= __compat_save_altstack(&frame->uc.uc_stack, regs->sp);
   215		err |= compat_setup_sigcontext(frame, regs);
   216		err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
   217		if (err)
   218			return -EFAULT;
   219	
   220		regs->ra = (unsigned long)COMPAT_VDSO_SYMBOL(
   221				current->mm->context.vdso, rt_sigreturn);
   222	
   223		/*
   224		 * Set up registers for signal handler.
   225		 * Registers that we don't modify keep the value they had from
   226		 * user-space at the time we took the signal.
   227		 * We always pass siginfo and mcontext, regardless of SA_SIGINFO,
   228		 * since some things rely on this (e.g. glibc's debug/segfault.c).
   229		 */
   230		regs->epc = (unsigned long)ksig->ka.sa.sa_handler;
   231		regs->sp = (unsigned long)frame;
   232		regs->a0 = ksig->sig;                     /* a0: signal number */
   233		regs->a1 = (unsigned long)(&frame->info); /* a1: siginfo pointer */
   234		regs->a2 = (unsigned long)(&frame->uc);   /* a2: ucontext pointer */
   235	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
