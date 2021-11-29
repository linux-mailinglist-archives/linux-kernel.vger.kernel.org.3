Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8755246116A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244922AbhK2Jyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:54:38 -0500
Received: from foss.arm.com ([217.140.110.172]:34582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231709AbhK2Jvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:51:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18C81106F;
        Mon, 29 Nov 2021 01:48:25 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FCCB3F694;
        Mon, 29 Nov 2021 01:48:23 -0800 (PST)
Date:   Mon, 29 Nov 2021 09:48:18 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [tip:core/entry 9/11] arch/powerpc/kernel/interrupt.c:151:64:
 error: passing argument 2 of 'set_bits' makes pointer from integer without a
 cast
Message-ID: <YaShuNUwpTQRl6je@FVFF77S0Q05N>
References: <202111271105.v7pE3REd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111271105.v7pE3REd-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 11:03:48AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry
> head:   5796ee48d26a18930a8b86fb865ba195282889d0
> commit: 51ed65dcfd9c61a15920a40178d471d236a7514c [9/11] powerpc: Avoid discarding flags in system_call_exception()
> config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20211127/202111271105.v7pE3REd-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=51ed65dcfd9c61a15920a40178d471d236a7514c
>         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>         git fetch --no-tags tip core/entry
>         git checkout 51ed65dcfd9c61a15920a40178d471d236a7514c
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/powerpc/kernel/interrupt.c: In function 'system_call_exception':
> >> arch/powerpc/kernel/interrupt.c:151:64: error: passing argument 2 of 'set_bits' makes pointer from integer without a cast [-Werror=int-conversion]
>      151 |                 set_bits(_TIF_RESTOREALL, current_thread_info()->flags);
>    In file included from include/linux/bitops.h:33,
>                     from include/linux/log2.h:12,
>                     from include/asm-generic/div64.h:55,
>                     from ./arch/powerpc/include/generated/asm/div64.h:1,
>                     from include/linux/math.h:5,
>                     from include/linux/math64.h:6,
>                     from include/linux/time64.h:5,
>                     from include/linux/restart_block.h:10,
>                     from include/linux/thread_info.h:14,
>                     from arch/powerpc/include/asm/ptrace.h:323,
>                     from arch/powerpc/include/asm/hw_irq.h:12,
>                     from arch/powerpc/include/asm/irqflags.h:12,
>                     from include/linux/irqflags.h:16,
>                     from include/asm-generic/cmpxchg-local.h:6,
>                     from arch/powerpc/include/asm/cmpxchg.h:526,
>                     from arch/powerpc/include/asm/atomic.h:11,
>                     from include/linux/atomic.h:7,
>                     from include/linux/rcupdate.h:25,
>                     from include/linux/rculist.h:11,
>                     from include/linux/pid.h:5,
>                     from include/linux/sched.h:14,
>                     from include/linux/context_tracking.h:5,
>                     from arch/powerpc/kernel/interrupt.c:3:
>    arch/powerpc/include/asm/bitops.h:67:41: note: expected 'volatile long unsigned int *' but argument is of type 'long unsigned int'
>       67 |                 volatile unsigned long *_p)     \
>          |                 ~~~~~~~~~~~~~~~~~~~~~~~~^~
>    arch/powerpc/include/asm/bitops.h:82:1: note: in expansion of macro 'DEFINE_BITOP'
>       82 | DEFINE_BITOP(set_bits, or, "")
>          | ^~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> 
> vim +/set_bits +151 arch/powerpc/kernel/interrupt.c

>    149		if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
>    150				unlikely(MSR_TM_TRANSACTIONAL(regs->msr)))
>  > 151			set_bits(_TIF_RESTOREALL, current_thread_info()->flags);

I missed a `&` in my patch, and the above should have been:
	
	set_bits(_TIF_RESTOREALL, &current_thread_info()->flags);

Thomas, should I respin the series with that corrected, send a fixup patch to
apply atop, or would you prefer to fix the commit locally?

Thanks,
Mark.
