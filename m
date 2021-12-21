Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FB947C7D0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 20:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241929AbhLUTyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 14:54:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:3774 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbhLUTyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:54:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640116456; x=1671652456;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dbeS3nmzwpqJ0l8rX7IiCW/YtKPjrlQPhtaQpgG+LOc=;
  b=V9WAPOclNs+vJh4hWlwxEAJHYS//Os/TKctmeYWkQDOIyNSr37PPw/NK
   6dbQqxxeXl2SBN6IU/9R1TWWPRqCXD+NwN/WMt8UchnvyUsCGWbismlmN
   2eu5ygTWxiQke5GwcjAuS9CS4ubXqx0l8+6+donLB3weXp61PRHLB/w3M
   2xmXLq/BQuJVFU1Z1RKHOVprauyDVKQZ/CR1pUttl1UMK2JUuHU/J8YxG
   iqKdyy0fxFGPd5co98gvciPMJ7iO+76ryYYjs22wlQoaFpzOaWXwHMlN7
   qOdhrSoTJKwLYgLkfTSLH7krIOnyqAB72NQjxC+h84vlRCenMU8ghdAU8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="238017018"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="238017018"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 11:54:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="684776666"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 21 Dec 2021 11:54:14 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzlDB-0009U2-Mu; Tue, 21 Dec 2021 19:54:13 +0000
Date:   Wed, 22 Dec 2021 03:54:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/wip.umcg 4/4] kernel/sched/umcg.c:223:67: error:
 macro "__try_cmpxchg_user_asm" requires 6 arguments, but only 5 given
Message-ID: <202112220301.rEoh3bVR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/wip.umcg
head:   53c79fbe7deb72a1d3ef8d8164f6dd8003677b34
commit: 53c79fbe7deb72a1d3ef8d8164f6dd8003677b34 [4/4] sched: User Mode Concurency Groups
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20211222/202112220301.rEoh3bVR-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=53c79fbe7deb72a1d3ef8d8164f6dd8003677b34
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/wip.umcg
        git checkout 53c79fbe7deb72a1d3ef8d8164f6dd8003677b34
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/sched/umcg.c: In function 'umcg_update_state':
>> kernel/sched/umcg.c:223:67: error: macro "__try_cmpxchg_user_asm" requires 6 arguments, but only 5 given
     223 |  } while (!unsafe_try_cmpxchg_user(&self->state, &old, new, Efault));
         |                                                                   ^
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/uapi/linux/aio_abi.h:31,
                    from include/linux/syscalls.h:78,
                    from kernel/sched/umcg.c:8:
   arch/x86/include/asm/uaccess.h:428: note: macro "__try_cmpxchg_user_asm" defined here
     428 | #define __try_cmpxchg_user_asm(itype, ltype, _ptr, _pold, _new, label) ({ \
         | 
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/uapi/linux/aio_abi.h:31,
                    from include/linux/syscalls.h:78,
                    from kernel/sched/umcg.c:8:
>> arch/x86/include/asm/uaccess.h:563:18: error: '__try_cmpxchg_user_asm' undeclared (first use in this function); did you mean 'try_cmpxchg_release'?
     563 |  case 8: __ret = __try_cmpxchg_user_asm("q", "r"   \
         |                  ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/umcg.c:223:12: note: in expansion of macro 'unsafe_try_cmpxchg_user'
     223 |  } while (!unsafe_try_cmpxchg_user(&self->state, &old, new, Efault));
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/uaccess.h:563:18: note: each undeclared identifier is reported only once for each function it appears in
     563 |  case 8: __ret = __try_cmpxchg_user_asm("q", "r"   \
         |                  ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/umcg.c:223:12: note: in expansion of macro 'unsafe_try_cmpxchg_user'
     223 |  } while (!unsafe_try_cmpxchg_user(&self->state, &old, new, Efault));
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/umcg.c: In function 'umcg_enqueue_runnable':
   kernel/sched/umcg.c:408:95: error: macro "__try_cmpxchg_user_asm" requires 6 arguments, but only 5 given
     408 |  } while (!unsafe_try_cmpxchg_user(&server->runnable_workers_ptr, &first_ptr, self_ptr, Efault));
         |                                                                                               ^
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/uapi/linux/aio_abi.h:31,
                    from include/linux/syscalls.h:78,
                    from kernel/sched/umcg.c:8:
   arch/x86/include/asm/uaccess.h:428: note: macro "__try_cmpxchg_user_asm" defined here
     428 | #define __try_cmpxchg_user_asm(itype, ltype, _ptr, _pold, _new, label) ({ \
         | 
   In file included from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/uapi/linux/aio_abi.h:31,
                    from include/linux/syscalls.h:78,
                    from kernel/sched/umcg.c:8:
>> arch/x86/include/asm/uaccess.h:563:18: error: '__try_cmpxchg_user_asm' undeclared (first use in this function); did you mean 'try_cmpxchg_release'?
     563 |  case 8: __ret = __try_cmpxchg_user_asm("q", "r"   \
         |                  ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/umcg.c:408:12: note: in expansion of macro 'unsafe_try_cmpxchg_user'
     408 |  } while (!unsafe_try_cmpxchg_user(&server->runnable_workers_ptr, &first_ptr, self_ptr, Efault));
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/umcg.c: At top level:
   kernel/sched/umcg.c:428:5: warning: no previous prototype for 'umcg_wait' [-Wmissing-prototypes]
     428 | int umcg_wait(u64 timo)
         |     ^~~~~~~~~


vim +/__try_cmpxchg_user_asm +223 kernel/sched/umcg.c

   182	
   183	/*
   184	 * Do a state transition: @from -> @to.
   185	 *
   186	 * Will clear UMCG_TF_PREEMPT, UMCG_TF_COND_WAIT.
   187	 *
   188	 * When @to == {BLOCKED,RUNNABLE}, update timestamps.
   189	 *
   190	 * Returns:
   191	 *   0: success
   192	 *   -EAGAIN: when self->state != @from
   193	 *   -EFAULT
   194	 */
   195	static int umcg_update_state(struct task_struct *tsk,
   196				     struct umcg_task __user *self,
   197				     u32 from, u32 to)
   198	{
   199		u32 old, new;
   200		u64 now;
   201	
   202		if (to >= UMCG_TASK_RUNNABLE) {
   203			switch (tsk->umcg_clock) {
   204			case CLOCK_REALTIME:      now = ktime_get_real_ns();     break;
   205			case CLOCK_MONOTONIC:     now = ktime_get_ns();          break;
   206			case CLOCK_BOOTTIME:      now = ktime_get_boottime_ns(); break;
   207			case CLOCK_TAI:           now = ktime_get_clocktai_ns(); break;
   208			}
   209		}
   210	
   211		if (!user_access_begin(self, sizeof(*self)))
   212			return -EFAULT;
   213	
   214		unsafe_get_user(old, &self->state, Efault);
   215		do {
   216			if ((old & UMCG_TASK_MASK) != from)
   217				goto fail;
   218	
   219			new = old & ~(UMCG_TASK_MASK |
   220				      UMCG_TF_PREEMPT | UMCG_TF_COND_WAIT);
   221			new |= to & UMCG_TASK_MASK;
   222	
 > 223		} while (!unsafe_try_cmpxchg_user(&self->state, &old, new, Efault));
   224	
   225		if (to == UMCG_TASK_BLOCKED)
   226			unsafe_put_user(now, &self->blocked_ts, Efault);
   227		if (to == UMCG_TASK_RUNNABLE)
   228			unsafe_put_user(now, &self->runnable_ts, Efault);
   229	
   230		user_access_end();
   231		return 0;
   232	
   233	fail:
   234		user_access_end();
   235		return -EAGAIN;
   236	
   237	Efault:
   238		user_access_end();
   239		return -EFAULT;
   240	}
   241	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
