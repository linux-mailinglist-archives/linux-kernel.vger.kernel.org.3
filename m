Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2523448A788
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 06:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347323AbiAKF7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 00:59:23 -0500
Received: from mga01.intel.com ([192.55.52.88]:14327 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232684AbiAKF7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 00:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641880761; x=1673416761;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6sBzcfmkPb6nG+9lQMHDkUozMUsaiUG2t10ejg2Hcd4=;
  b=THHfFb0mwZcCeolO++/8rRtUDOhi406uUhCD/z7Wkz6tyyXQ9TtbfnQD
   JEXNsAqdp00B6GlJEAztJMT4MMgdskwaHfYQxEBo1IrXyQ9E7xCBOp/zM
   KXY3faKYSpUj+VB8y6rQ14Ilaws7Pjhwkb2cDhkzTYULc0VeHybBxT638
   DB9Njeee1eCEKMlkw68N/bXqTu9MJsHpVv4YAhfClYVV9jzkRLhynKrSl
   IBM3YQ5ac6qStgdN4Nsil4Q8aUyPCLTHCOPFdKSeYRqiBYRZ0R/RC/suw
   xfeGVjfE6BMZsACPm2MrKojGjI81Uw6cGCyn7D54jLvLUIii+Mr1hyALV
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="267743271"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="xz'?scan'208";a="267743271"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 21:59:20 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="xz'?scan'208";a="528597932"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.143])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 21:59:15 -0800
Date:   Tue, 11 Jan 2022 13:59:12 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Nico Pache <npache@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andr Almeida <andrealmeid@collabora.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: [mm/oom_kill]  b93acee44e:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c
Message-ID: <20220111055912.GB26270@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: b93acee44e1a2b541ffe5ae1dda6be3d6f65987f ("mm/oom_kill: wake futex waiters before annihilating victim shared mutex")
url: https://github.com/0day-ci/linux/commits/Yang-Li/net-phy-micrel-use-min-macro-instead-of-doing-it-manually/20211224-171618

in testcase: boot

on test machine: qemu-system-x86_64 -enable-kvm -cpu Icelake-Server -smp 4 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):



If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[   61.631030][  T538] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:584
[   61.632850][  T538] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 538, name: kworker/u8:5
[   61.634593][  T538] preempt_count: 1, expected: 0
[   61.635532][  T538] RCU nest depth: 0, expected: 0
[   61.636479][  T538] 2 locks held by kworker/u8:5/538:
[ 61.637447][ T538] #0: c5515ef8 (oom_lock){+.+.}-{3:3}, at: __alloc_pages_slowpath+0x4f7/0xe40 
[ 61.639340][ T538] #1: f591cafc (&p->alloc_lock){+.+.}-{2:2}, at: find_lock_task_mm (mm/oom_kill.c:145) 
[   61.641023][  T538] Preemption disabled at:
[ 61.641037][ T538] find_lock_task_mm (mm/oom_kill.c:145) 
[   61.642909][  T538] CPU: 2 PID: 538 Comm: kworker/u8:5 Not tainted 5.16.0-rc6-00051-gb93acee44e1a #2
[   61.644587][  T538] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   61.646331][  T538] Call Trace:
[ 61.646977][ T538] dump_stack_lvl (lib/dump_stack.c:107) 
[ 61.647873][ T538] dump_stack (lib/dump_stack.c:114) 
[ 61.648692][ T538] __might_resched.cold (kernel/sched/core.c:9539) 
[ 61.649673][ T538] ? find_lock_task_mm (mm/oom_kill.c:145) 
[ 61.650669][ T538] __might_sleep (kernel/sched/core.c:9468 (discriminator 24)) 
[ 61.651544][ T538] __mutex_lock (include/linux/kernel.h:101 kernel/locking/mutex.c:584 kernel/locking/mutex.c:740) 
[ 61.652306][ T538] ? check_preemption_disabled (lib/smp_processor_id.c:16) 
[ 61.655532][ T538] ? check_preemption_disabled (lib/smp_processor_id.c:16) 
[ 61.656539][ T538] mutex_lock_nested (kernel/locking/mutex.c:793) 
[ 61.657421][ T538] ? futex_cleanup_begin (kernel/futex/core.c:1084) 
[ 61.658371][ T538] futex_cleanup_begin (kernel/futex/core.c:1084) 
[ 61.659339][ T538] futex_exit_release (kernel/futex/core.c:1124) 
[ 61.660237][ T538] __oom_kill_process (mm/oom_kill.c:899) 
[ 61.661238][ T538] oom_kill_process (mm/oom_kill.c:1008) 
[ 61.662178][ T538] out_of_memory (mm/oom_kill.c:1131 (discriminator 4)) 
[ 61.663049][ T538] __alloc_pages_slowpath+0xd7f/0xe40 
[ 61.664287][ T538] __alloc_pages (mm/page_alloc.c:5382) 
[ 61.665183][ T538] cache_grow_begin+0x247/0x320 
[ 61.666307][ T538] cache_alloc_refill (mm/slab.c:2965) 
[ 61.667261][ T538] ? check_preemption_disabled (lib/smp_processor_id.c:16) 
[ 61.668392][ T538] kmem_cache_alloc (mm/slab.c:3048 mm/slab.c:3031 mm/slab.c:3292 mm/slab.c:3316 mm/slab.c:3507) 
[ 61.669315][ T538] getname_kernel (fs/namei.c:227) 
[ 61.670208][ T538] kernel_execve (include/linux/err.h:36 fs/exec.c:1940) 
[ 61.671077][ T538] call_usermodehelper_exec_async (kernel/umh.c:116) 
[ 61.672208][ T538] ? umh_complete (kernel/umh.c:67) 
[ 61.673026][ T538] ret_from_fork (arch/x86/entry/entry_32.S:775) 
[   61.673926][  T538]
[   61.674318][  T538] =============================
[   61.675084][  T538] [ BUG: Invalid wait context ]
[   61.675857][  T538] 5.16.0-rc6-00051-gb93acee44e1a #2 Tainted: G        W
[   61.677049][  T538] -----------------------------
[   61.677824][  T538] kworker/u8:5/538 is trying to lock:
[ 61.678698][ T538] f591d154 (&tsk->futex_exit_mutex){+.+.}-{3:3}, at: futex_cleanup_begin (kernel/futex/core.c:1084) 
[   61.680223][  T538] other info that might help us debug this:
[   61.681201][  T538] context-{4:4}
[   61.681786][  T538] 2 locks held by kworker/u8:5/538:
[ 61.682660][ T538] #0: c5515ef8 (oom_lock){+.+.}-{3:3}, at: __alloc_pages_slowpath+0x4f7/0xe40 
[ 61.684302][ T538] #1: f591cafc (&p->alloc_lock){+.+.}-{2:2}, at: find_lock_task_mm (mm/oom_kill.c:145) 
[   61.685872][  T538] stack backtrace:
[   61.686492][  T538] CPU: 2 PID: 538 Comm: kworker/u8:5 Tainted: G        W         5.16.0-rc6-00051-gb93acee44e1a #2
[   61.688196][  T538] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   61.689731][  T538] Call Trace:
[ 61.690294][ T538] dump_stack_lvl (lib/dump_stack.c:107) 
[ 61.691025][ T538] dump_stack (lib/dump_stack.c:114) 
[ 61.691730][ T538] __lock_acquire.cold (kernel/locking/lockdep.c:4680 kernel/locking/lockdep.c:4739 kernel/locking/lockdep.c:4977) 
[ 61.692585][ T538] ? check_preemption_disabled (lib/smp_processor_id.c:16) 
[ 61.693533][ T538] lock_acquire (kernel/locking/lockdep.c:438 kernel/locking/lockdep.c:5639 kernel/locking/lockdep.c:5602) 
[ 61.694275][ T538] ? futex_cleanup_begin (kernel/futex/core.c:1084) 
[ 61.695139][ T538] ? __might_resched.cold (kernel/sched/core.c:9539) 
[ 61.696045][ T538] ? find_lock_task_mm (mm/oom_kill.c:145) 
[ 61.696868][ T538] __mutex_lock (arch/x86/include/asm/atomic.h:29 include/linux/atomic/atomic-long.h:523 include/linux/atomic/atomic-instrumented.h:1184 kernel/locking/mutex.c:104 kernel/locking/mutex.c:149 kernel/locking/mutex.c:609 kernel/locking/mutex.c:740) 
[ 61.697523][ T538] ? futex_cleanup_begin (kernel/futex/core.c:1084) 
[ 61.698389][ T538] ? check_preemption_disabled (lib/smp_processor_id.c:16) 
[ 61.699287][ T538] ? check_preemption_disabled (lib/smp_processor_id.c:16) 
[ 61.700190][ T538] mutex_lock_nested (kernel/locking/mutex.c:793) 
[ 61.700975][ T538] ? futex_cleanup_begin (kernel/futex/core.c:1084) 
[ 61.701816][ T538] futex_cleanup_begin (kernel/futex/core.c:1084) 
[ 61.702621][ T538] futex_exit_release (kernel/futex/core.c:1124) 
[ 61.703363][ T538] __oom_kill_process (mm/oom_kill.c:899) 
[ 61.704227][ T538] oom_kill_process (mm/oom_kill.c:1008) 
[ 61.705003][ T538] out_of_memory (mm/oom_kill.c:1131 (discriminator 4)) 
[ 61.705784][ T538] __alloc_pages_slowpath+0xd7f/0xe40 
[ 61.706829][ T538] __alloc_pages (mm/page_alloc.c:5382) 
[ 61.707608][ T538] cache_grow_begin+0x247/0x320 
[ 61.708602][ T538] cache_alloc_refill (mm/slab.c:2965) 
[ 61.709435][ T538] ? check_preemption_disabled (lib/smp_processor_id.c:16) 
[ 61.710385][ T538] kmem_cache_alloc (mm/slab.c:3048 mm/slab.c:3031 mm/slab.c:3292 mm/slab.c:3316 mm/slab.c:3507) 
[ 61.711194][ T538] getname_kernel (fs/namei.c:227) 
[ 61.711964][ T538] kernel_execve (include/linux/err.h:36 fs/exec.c:1940) 
[ 61.712710][ T538] call_usermodehelper_exec_async (kernel/umh.c:116) 
[ 61.713660][ T538] ? umh_complete (kernel/umh.c:67) 
[ 61.714361][ T538] ret_from_fork (arch/x86/entry/entry_32.S:775) 
[   61.715202][  T538] Out of memory: Killed process 458 (systemd-journal) total-vm:15160kB, anon-rss:344kB, file-rss:3536kB, shmem-rss:1384kB, UID:0 pgtables:20kB oom_score_adj:0
[   61.831730][   T41] oom_reaper: reaped process 458 (systemd-journal), now anon-rss:0kB, file-rss:0kB, shmem-rss:1384kB
[   62.198664][  T539] _warn_unseeded_randomness: 3 callbacks suppressed
[ 62.198675][ T539] random: get_random_u32 called from arch_rnd+0x19/0x30 with crng_init=1 
[ 62.198691][ T539] random: get_random_u32 called from randomize_stack_top+0x35/0x50 with crng_init=1 
[ 62.198703][ T539] random: get_random_u32 called from arch_align_stack+0x35/0x50 with crng_init=1 
Stopping Flush Journal to Persistent Storage...
[  OK  ] Stopped Journal Service.
Starting Journal Service...
[ 71.972603][ T540] random: get_random_u32 called from arch_rnd+0x19/0x30 with crng_init=1 
[ 71.972628][ T540] random: get_random_u32 called from randomize_stack_top+0x35/0x50 with crng_init=1 
[ 71.972635][ T540] random: get_random_u32 called from arch_align_stack+0x35/0x50 with crng_init=1 
[  OK  ] Started Journal Service.
Starting Flush Journal to Persistent Storage...
[  OK  ] Reached target System Initialization.
[  OK  ] Listening on D-Bus System Message Bus Socket.
[  OK  ] Reached target Sockets.
[  OK  ] Started Daily apt download activities.
[  OK  ] Started Daily Cleanup of Temporary Directories.
[  OK  ] Started Daily apt upgrade and clean activities.
[  OK  ] Reached target Timers.
[  OK  ] Reached target Basic System.
Starting LKP bootstrap...
Startin[   77.266134][  T544] _warn_unseeded_randomness: 17 callbacks suppressed
g /etc/rc.local [ 77.266144][ T544] random: get_random_u32 called from arch_rnd+0x19/0x30 with crng_init=1 
Compatibility...[ 77.266160][ T544] random: get_random_u32 called from randomize_stack_top+0x35/0x50 with crng_init=1 

[ 77.266173][ T544] random: get_random_u32 called from arch_align_stack+0x35/0x50 with crng_init=1 
Starting LSB: Execute the kexec -e command to reboot system...
Starting LSB: Start and stop bmc-watchdog...
Starting OpenBSD Secure Shell server...
[   87.529761][  T560] _warn_unseeded_randomness: 70 callbacks suppressed
[ 87.529769][ T560] random: get_random_u32 called from arch_rnd+0x19/0x30 with crng_init=1 
[ 87.529779][ T560] random: get_random_u32 called from randomize_stack_top+0x35/0x50 with crng_init=1 
[ 87.529787][ T560] random: get_random_u32 called from arch_align_stack+0x35/0x50 with crng_init=1 
Starting System Logging Service...
[   87.475599] rc.local[545]: PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/lkp/lkp/src/bin
[   87.588377][  T523] systemd-udevd invoked oom-killer: gfp_mask=0x40cc0(GFP_KERNEL|__GFP_COMP), order=0, oom_score_adj=0
[   87.590235][  T523] CPU: 1 PID: 523 Comm: systemd-udevd Tainted: G        W         5.16.0-rc6-00051-gb93acee44e1a #2
[   87.592034][  T523] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[   87.593451][  T523] Call Trace:
[ 87.593965][ T523] dump_stack_lvl (lib/dump_stack.c:107) 
[ 87.594666][ T523] dump_stack (lib/dump_stack.c:114) 
[ 87.595338][ T523] dump_header (mm/oom_kill.c:465) 
[ 87.596051][ T523] ? ___ratelimit (lib/ratelimit.c:69) 
[ 87.596794][ T523] oom_kill_process.cold (mm/oom_kill.c:994) 
[ 87.597533][ T523] out_of_memory (mm/oom_kill.c:1131 (discriminator 4)) 
[ 87.598258][ T523] __alloc_pages_slowpath+0xd7f/0xe40 
[ 87.599300][ T523] __alloc_pages (mm/page_alloc.c:5382) 
[ 87.600063][ T523] cache_grow_begin+0x247/0x320 
[ 87.600974][ T523] cache_alloc_refill (mm/slab.c:2965) 
[ 87.601757][ T523] ? check_preemption_disabled (lib/smp_processor_id.c:16) 
[ 87.602703][ T523] kmem_cache_alloc (mm/slab.c:3048 mm/slab.c:3031 mm/slab.c:3292 mm/slab.c:3316 mm/slab.c:3507) 
[ 87.603512][ T523] ? import_iovec (lib/iov_iter.c:2015) 
[ 87.604274][ T523] getname_flags (include/linux/audit.h:323 include/linux/audit.h:363 fs/namei.c:134) 
[ 87.605141][ T523] ? kfree (mm/slab.c:3790) 
[ 87.605789][ T523] getname_flags (fs/namei.c:204) 
[ 87.606502][ T523] getname (fs/namei.c:218) 
[ 87.607132][ T523] do_sys_openat2 (include/linux/err.h:36 fs/open.c:1207) 
[ 87.607931][ T523] ? dput_to_list (include/linux/rcupdate.h:689 fs/dcache.c:909) 
[ 87.608737][ T523] do_sys_open (fs/open.c:1229) 
[ 87.609451][ T523] __ia32_sys_open (fs/open.c:1232) 
[ 87.610228][ T523] do_int80_syscall_32 (arch/x86/entry/common.c:112 arch/x86/entry/common.c:132) 
[ 87.611061][ T523] ? check_preemption_disabled (lib/smp_processor_id.c:16) 
[ 87.612021][ T523] ? rcu_read_lock_held_common (kernel/rcu/update.c:104) 
[ 87.612977][ T523] ? rcu_read_lock_sched_held (kernel/rcu/update.c:123) 
[ 87.613916][ T523] ? trace_irq_enable (include/trace/events/preemptirq.h:40) 
[ 87.614765][ T523] ? syscall_exit_to_user_mode (kernel/entry/common.c:303) 
[ 87.615723][ T523] ? do_int80_syscall_32 (arch/x86/entry/common.c:136) 
[ 87.616495][ T523] ? do_int80_syscall_32 (arch/x86/entry/common.c:136) 
[ 87.617348][ T523] ? do_int80_syscall_32 (arch/x86/entry/common.c:136) 
[ 87.618209][ T523] ? do_int80_syscall_32 (arch/x86/entry/common.c:136) 
[ 87.619046][ T523] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1097) 
[ 87.620016][ T523] entry_INT80_32 (arch/x86/entry/entry_32.S:981) 
[   87.620774][  T523] EIP: 0xb7f33a02
[ 87.621392][ T523] Code: 95 01 00 05 25 36 02 00 83 ec 14 8d 80 e8 99 ff ff 50 6a 02 e8 1f ff 00 00 c7 04 24 7f 00 00 00 e8 7e 87 01 00 66 90 90 cd 80 <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 1c 24 c3 8d b6 00 00
All code
========
   0:	95                   	xchg   %eax,%ebp
   1:	01 00                	add    %eax,(%rax)
   3:	05 25 36 02 00       	add    $0x23625,%eax
   8:	83 ec 14             	sub    $0x14,%esp
   b:	8d 80 e8 99 ff ff    	lea    -0x6618(%rax),%eax
  11:	50                   	push   %rax
  12:	6a 02                	pushq  $0x2
  14:	e8 1f ff 00 00       	callq  0xff38
  19:	c7 04 24 7f 00 00 00 	movl   $0x7f,(%rsp)
  20:	e8 7e 87 01 00       	callq  0x187a3
  25:	66 90                	xchg   %ax,%ax
  27:	90                   	nop
  28:	cd 80                	int    $0x80
  2a:*	c3                   	retq   		<-- trapping instruction
  2b:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  31:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
  38:	8b 1c 24             	mov    (%rsp),%ebx
  3b:	c3                   	retq   
  3c:	8d                   	.byte 0x8d
  3d:	b6 00                	mov    $0x0,%dh
	...

Code starting with the faulting instruction
===========================================
   0:	c3                   	retq   
   1:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
   7:	8d bc 27 00 00 00 00 	lea    0x0(%rdi,%riz,1),%edi
   e:	8b 1c 24             	mov    (%rsp),%ebx
  11:	c3                   	retq   
  12:	8d                   	.byte 0x8d
  13:	b6 00                	mov    $0x0,%dh


To reproduce:

        # build kernel
	cd linux
	cp config-5.16.0-rc6-00051-gb93acee44e1a .config
	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



---
0DAY/LKP+ Test Infrastructure                   Open Source Technology Center
https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corporation

Thanks,
Oliver Sang


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.16.0-rc6-00051-gb93acee44e1a"

#
# Automatically generated file; DO NOT EDIT.
# Linux/i386 5.16.0-rc6 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-22) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_CLANG_VERSION=0
CONFIG_AS_IS_GNU=y
CONFIG_AS_VERSION=23502
CONFIG_LD_IS_BFD=y
CONFIG_LD_VERSION=23502
CONFIG_LLD_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=y
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
# CONFIG_SYSVIPC is not set
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y
# CONFIG_TIME_KUNIT_TEST is not set

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
# CONFIG_HIGH_RES_TIMERS is not set
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y

#
# BPF subsystem
#
CONFIG_BPF_SYSCALL=y
# CONFIG_BPF_JIT is not set
# CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
CONFIG_USERMODE_DRIVER=y
CONFIG_BPF_PRELOAD=y
# CONFIG_BPF_PRELOAD_UMD is not set
# end of BPF subsystem

CONFIG_PREEMPT_BUILD=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y
CONFIG_PREEMPT_DYNAMIC=y
# CONFIG_SCHED_CORE is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
# CONFIG_TASK_DELAY_ACCT is not set
# CONFIG_TASK_XACCT is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKHEADERS=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_PRINTK_INDEX=y
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
CONFIG_UCLAMP_TASK=y
CONFIG_UCLAMP_BUCKETS_COUNT=5
# end of Scheduler features

CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough=5"
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
# CONFIG_CFS_BANDWIDTH is not set
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_UCLAMP_TASK_GROUP=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CPUSETS is not set
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
# CONFIG_CGROUP_PERF is not set
CONFIG_CGROUP_BPF=y
CONFIG_CGROUP_MISC=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
# CONFIG_TIME_NS is not set
CONFIG_IPC_NS=y
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
# CONFIG_RD_BZIP2 is not set
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
CONFIG_RD_ZSTD=y
CONFIG_BOOT_CONFIG=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_KCMP=y
CONFIG_RSEQ=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_COMPAT_BRK=y
CONFIG_SLAB=y
# CONFIG_SLUB is not set
# CONFIG_SLAB_MERGE_DEFAULT is not set
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SYSTEM_DATA_VERIFICATION=y
# CONFIG_PROFILING is not set
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_X86_32=y
CONFIG_FORCE_DYNAMIC_FTRACE=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf32-i386"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_BITS_MAX=16
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=512
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_X86_32_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
# CONFIG_X86_CPU_RESCTRL is not set
# CONFIG_X86_BIGSMP is not set
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_INTEL_LPSS=y
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
CONFIG_IOSF_MBI=y
CONFIG_IOSF_MBI_DEBUG=y
CONFIG_X86_32_IRIS=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
# CONFIG_PARAVIRT_SPINLOCKS is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_M486SX is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
# CONFIG_M686 is not set
# CONFIG_MPENTIUMII is not set
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUMM is not set
CONFIG_MPENTIUM4=y
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MK8 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MEFFICEON is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MELAN is not set
# CONFIG_MGEODEGX1 is not set
# CONFIG_MGEODE_LX is not set
# CONFIG_MCYRIXIII is not set
# CONFIG_MVIAC3_2 is not set
# CONFIG_MVIAC7 is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_X86_GENERIC=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=7
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=6
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_TRANSMETA_32=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_CPU_SUP_VORTEX_32=y
CONFIG_HPET_TIMER=y
CONFIG_DMI=y
CONFIG_NR_CPUS_RANGE_BEGIN=2
CONFIG_NR_CPUS_RANGE_END=8
CONFIG_NR_CPUS_DEFAULT=8
CONFIG_NR_CPUS=8
CONFIG_SCHED_CLUSTER=y
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
# CONFIG_SCHED_MC_PRIO is not set
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
# CONFIG_PERF_EVENTS_INTEL_RAPL is not set
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
CONFIG_PERF_EVENTS_AMD_UNCORE=y
# end of Performance monitoring

# CONFIG_X86_LEGACY_VM86 is not set
CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX32=y
# CONFIG_X86_IOPL_IOPERM is not set
CONFIG_TOSHIBA=y
CONFIG_I8K=y
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
# CONFIG_MICROCODE_OLD_INTERFACE is not set
CONFIG_X86_MSR=y
# CONFIG_X86_CPUID is not set
# CONFIG_NOHIGHMEM is not set
CONFIG_HIGHMEM4G=y
# CONFIG_HIGHMEM64G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_X86_CPA_STATISTICS=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ILLEGAL_POINTER_VALUE=0
# CONFIG_HIGHPTE is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=y
# CONFIG_EFI is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
CONFIG_DEBUG_HOTPLUG_CPU0=y
CONFIG_COMPAT_VDSO=y
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
# CONFIG_STRICT_SIGALTSTACK_SIZE is not set
# end of Processor type and features

CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
# CONFIG_SUSPEND is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
# CONFIG_HIBERNATION_SNAPSHOT_DEV is not set
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
CONFIG_PM_AUTOSLEEP=y
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
CONFIG_PM_CLK=y
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
CONFIG_ACPI_DEBUGGER=y
CONFIG_ACPI_DEBUGGER_USER=y
# CONFIG_ACPI_SPCR_TABLE is not set
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=y
# CONFIG_ACPI_AC is not set
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
CONFIG_ACPI_HOTPLUG_CPU=y
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_PLATFORM_PROFILE=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_TABLE_UPGRADE is not set
CONFIG_ACPI_DEBUG=y
# CONFIG_ACPI_PCI_SLOT is not set
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=y
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
# CONFIG_ACPI_APEI_GHES is not set
# CONFIG_ACPI_APEI_EINJ is not set
CONFIG_ACPI_APEI_ERST_DEBUG=y
CONFIG_ACPI_DPTF=y
CONFIG_DPTF_POWER=y
# CONFIG_DPTF_PCH_FIVR is not set
CONFIG_ACPI_CONFIGFS=y
CONFIG_PMIC_OPREGION=y
CONFIG_XPOWER_PMIC_OPREGION=y
# CONFIG_TPS68470_PMIC_OPREGION is not set
CONFIG_ACPI_VIOT=y
CONFIG_X86_PM_TIMER=y
CONFIG_X86_APM_BOOT=y
CONFIG_APM=y
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
CONFIG_APM_DO_ENABLE=y
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
CONFIG_APM_ALLOW_INTS=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
# CONFIG_X86_PCC_CPUFREQ is not set
CONFIG_X86_ACPI_CPUFREQ=y
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K6=y
# CONFIG_X86_POWERNOW_K7 is not set
CONFIG_X86_POWERNOW_K8=y
# CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
CONFIG_X86_GX_SUSPMOD=y
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_SPEEDSTEP_ICH=y
CONFIG_X86_SPEEDSTEP_SMI=y
CONFIG_X86_P4_CLOCKMOD=y
CONFIG_X86_CPUFREQ_NFORCE2=y
# CONFIG_X86_LONGRUN is not set
CONFIG_X86_LONGHAUL=y
CONFIG_X86_E_POWERSAVER=y

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=y
# CONFIG_X86_SPEEDSTEP_RELAXED_CAP_CHECK is not set
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_CPU_IDLE_GOV_TEO=y
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
CONFIG_SCx200=y
CONFIG_SCx200HR_TIMER=y
# CONFIG_OLPC is not set
# CONFIG_ALIX is not set
CONFIG_NET5501=y
CONFIG_GEOS=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_COMPAT_32=y
# end of Binary Emulations

CONFIG_HAVE_ATOMIC_IOMAP=y
CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
# CONFIG_KPROBES is not set
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_STATIC_CALL_SELFTEST=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_ARCH_32BIT_OFF_T=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
# CONFIG_SECCOMP is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=8
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_ISA_BUS_API=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_LOCK_EVENT_COUNTS=y
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SPLIT_ARG64=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
CONFIG_GCOV_KERNEL=y
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_GCOV_PROFILE_ALL is not set
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_RQ_ALLOC_TIME=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=y
CONFIG_BLK_DEV_ZONED=y
# CONFIG_BLK_DEV_THROTTLING is not set
CONFIG_BLK_WBT=y
CONFIG_BLK_WBT_MQ=y
CONFIG_BLK_CGROUP_IOLATENCY=y
# CONFIG_BLK_CGROUP_FC_APPID is not set
CONFIG_BLK_CGROUP_IOCOST=y
CONFIG_BLK_CGROUP_IOPRIO=y
# CONFIG_BLK_DEBUG_FS is not set
CONFIG_BLK_SED_OPAL=y
CONFIG_BLK_INLINE_ENCRYPTION=y
CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=y

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_AMIGA_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_MQ_RDMA=y
CONFIG_BLK_PM=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
CONFIG_IOSCHED_BFQ=y
# CONFIG_BFQ_GROUP_IOSCHED is not set
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_EXCLUSIVE_SYSTEM_RAM=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
# CONFIG_COMPACTION is not set
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_TRANSPARENT_HUGEPAGE is not set
# CONFIG_CLEANCACHE is not set
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_SYSFS=y
CONFIG_CMA_AREAS=7
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD=y
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="zstd"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
CONFIG_Z3FOLD=y
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ZONE_DMA=y
CONFIG_VMAP_PFN=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_KMAP_LOCAL=y
CONFIG_SECRETMEM=y

#
# Data Access Monitoring
#
CONFIG_DAMON=y
CONFIG_DAMON_KUNIT_TEST=y
CONFIG_DAMON_VADDR=y
# CONFIG_DAMON_PADDR is not set
CONFIG_DAMON_VADDR_KUNIT_TEST=y
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
CONFIG_UNIX_DIAG=y
CONFIG_TLS=y
# CONFIG_TLS_DEVICE is not set
CONFIG_TLS_TOE=y
CONFIG_XFRM=y
CONFIG_XFRM_OFFLOAD=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
CONFIG_XFRM_MIGRATE=y
# CONFIG_XFRM_STATISTICS is not set
CONFIG_XFRM_AH=y
CONFIG_XFRM_ESP=y
CONFIG_XFRM_IPCOMP=y
# CONFIG_NET_KEY is not set
# CONFIG_SMC is not set
CONFIG_XDP_SOCKETS=y
CONFIG_XDP_SOCKETS_DIAG=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
# CONFIG_NET_IPGRE is not set
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
# CONFIG_IP_PIMSM_V1 is not set
# CONFIG_IP_PIMSM_V2 is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_NET_IPVTI=y
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
# CONFIG_NET_FOU_IP_TUNNELS is not set
CONFIG_INET_AH=y
CONFIG_INET_ESP=y
CONFIG_INET_ESP_OFFLOAD=y
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=y
CONFIG_INET_XFRM_TUNNEL=y
CONFIG_INET_TUNNEL=y
# CONFIG_INET_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
CONFIG_TIPC=y
CONFIG_TIPC_MEDIA_IB=y
CONFIG_TIPC_MEDIA_UDP=y
CONFIG_TIPC_CRYPTO=y
CONFIG_TIPC_DIAG=y
CONFIG_ATM=y
CONFIG_ATM_CLIP=y
CONFIG_ATM_CLIP_NO_ICMP=y
CONFIG_ATM_LANE=y
# CONFIG_ATM_MPOA is not set
# CONFIG_ATM_BR2684 is not set
# CONFIG_L2TP is not set
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
# CONFIG_BRIDGE_CFM is not set
CONFIG_NET_DSA=y
CONFIG_NET_DSA_TAG_AR9331=y
CONFIG_NET_DSA_TAG_BRCM_COMMON=y
CONFIG_NET_DSA_TAG_BRCM=y
CONFIG_NET_DSA_TAG_BRCM_LEGACY=y
CONFIG_NET_DSA_TAG_BRCM_PREPEND=y
CONFIG_NET_DSA_TAG_HELLCREEK=y
CONFIG_NET_DSA_TAG_GSWIP=y
CONFIG_NET_DSA_TAG_DSA_COMMON=y
CONFIG_NET_DSA_TAG_DSA=y
CONFIG_NET_DSA_TAG_EDSA=y
CONFIG_NET_DSA_TAG_MTK=y
CONFIG_NET_DSA_TAG_KSZ=y
CONFIG_NET_DSA_TAG_OCELOT=y
CONFIG_NET_DSA_TAG_OCELOT_8021Q=y
CONFIG_NET_DSA_TAG_QCA=y
CONFIG_NET_DSA_TAG_RTL4_A=y
# CONFIG_NET_DSA_TAG_RTL8_4 is not set
CONFIG_NET_DSA_TAG_LAN9303=y
# CONFIG_NET_DSA_TAG_SJA1105 is not set
CONFIG_NET_DSA_TAG_TRAILER=y
CONFIG_NET_DSA_TAG_XRS700X=y
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
# CONFIG_VLAN_8021Q_MVRP is not set
CONFIG_DECNET=y
# CONFIG_DECNET_ROUTER is not set
CONFIG_LLC=y
CONFIG_LLC2=y
CONFIG_ATALK=y
# CONFIG_DEV_APPLETALK is not set
CONFIG_X25=y
# CONFIG_LAPB is not set
CONFIG_PHONET=y
CONFIG_IEEE802154=y
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=y
CONFIG_IEEE802154_SOCKET=y
CONFIG_MAC802154=y
# CONFIG_NET_SCHED is not set
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=y
CONFIG_BATMAN_ADV=y
CONFIG_BATMAN_ADV_BATMAN_V=y
CONFIG_BATMAN_ADV_BLA=y
CONFIG_BATMAN_ADV_DAT=y
# CONFIG_BATMAN_ADV_NC is not set
# CONFIG_BATMAN_ADV_MCAST is not set
# CONFIG_BATMAN_ADV_DEBUG is not set
# CONFIG_BATMAN_ADV_TRACING is not set
CONFIG_OPENVSWITCH=y
# CONFIG_VSOCKETS is not set
CONFIG_NETLINK_DIAG=y
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=y
CONFIG_NET_NSH=y
CONFIG_HSR=y
CONFIG_NET_SWITCHDEV=y
# CONFIG_NET_L3_MASTER_DEV is not set
CONFIG_QRTR=y
CONFIG_QRTR_SMD=y
# CONFIG_QRTR_TUN is not set
# CONFIG_QRTR_MHI is not set
CONFIG_NET_NCSI=y
# CONFIG_NCSI_OEM_CMD_GET_MAC is not set
CONFIG_NCSI_OEM_CMD_KEEP_PHY=y
CONFIG_PCPU_DEV_REFCNT=y
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_SOCK_RX_QUEUE_MAPPING=y
CONFIG_XPS=y
CONFIG_CGROUP_NET_PRIO=y
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_STREAM_PARSER is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=y
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
CONFIG_AF_RXRPC=y
CONFIG_AF_RXRPC_INJECT_LOSS=y
# CONFIG_AF_RXRPC_DEBUG is not set
CONFIG_RXKAD=y
CONFIG_AF_KCM=y
CONFIG_STREAM_PARSER=y
CONFIG_MCTP=y
# CONFIG_MCTP_TEST is not set
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_SPY=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=y
CONFIG_NL80211_TESTMODE=y
CONFIG_CFG80211_DEVELOPER_WARNINGS=y
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
# CONFIG_CFG80211_DEFAULT_PS is not set
CONFIG_CFG80211_DEBUGFS=y
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_CFG80211_WEXT_EXPORT=y
CONFIG_LIB80211=y
CONFIG_LIB80211_CRYPT_WEP=y
CONFIG_LIB80211_CRYPT_CCMP=y
CONFIG_LIB80211_CRYPT_TKIP=y
CONFIG_LIB80211_DEBUG=y
CONFIG_MAC80211=y
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
CONFIG_MAC80211_MESSAGE_TRACING=y
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_RDMA is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=y
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
# CONFIG_CEPH_LIB_USE_DNS_RESOLVER is not set
# CONFIG_NFC is not set
CONFIG_PSAMPLE=y
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SELFTESTS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=y
# CONFIG_ETHTOOL_NETLINK is not set

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
CONFIG_EISA_VLB_PRIMING=y
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_VIRTUAL_ROOT=y
# CONFIG_EISA_NAMES is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEFAULT is not set
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
CONFIG_PCIEASPM_PERFORMANCE=y
CONFIG_PCIE_PTM=y
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=y
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
CONFIG_PCI_LABEL=y
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_IBM is not set
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=y
CONFIG_HOTPLUG_PCI_CPCI=y
# CONFIG_HOTPLUG_PCI_CPCI_ZT5550 is not set
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=y
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=y
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
# CONFIG_PCCARD is not set
CONFIG_RAPIDIO=y
CONFIG_RAPIDIO_DISC_TIMEOUT=30
# CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS is not set
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=y
# CONFIG_RAPIDIO_CHMAN is not set
CONFIG_RAPIDIO_MPORT_CDEV=y

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=y
CONFIG_RAPIDIO_CPS_XX=y
CONFIG_RAPIDIO_TSI568=y
# CONFIG_RAPIDIO_CPS_GEN2 is not set
CONFIG_RAPIDIO_RXS_GEN3=y
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
# CONFIG_STANDALONE is not set
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
CONFIG_FW_LOADER_COMPRESS=y
# CONFIG_FW_CACHE is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_PM_QOS_KUNIT_TEST=y
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
# CONFIG_DRIVER_PE_KUNIT_TEST is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SLIMBUS=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_SPMI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_REGMAP_SCCB=y
CONFIG_REGMAP_I3C=y
CONFIG_REGMAP_SPI_AVMM=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
# CONFIG_MHI_BUS_PCI_GENERIC is not set
# end of Bus devices

CONFIG_CONNECTOR=y
# CONFIG_PROC_EVENTS is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

# CONFIG_EDD is not set
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_DMIID is not set
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_ISCSI_IBFT is not set
# CONFIG_FW_CFG_SYSFS is not set
CONFIG_SYSFB=y
CONFIG_SYSFB_SIMPLEFB=y
CONFIG_GOOGLE_FIRMWARE=y
CONFIG_GOOGLE_SMI=y
# CONFIG_GOOGLE_COREBOOT_TABLE is not set
CONFIG_GOOGLE_MEMCONSOLE=y
CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY=y
CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=y
CONFIG_MTD_CMDLINE_PARTS=y
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
# CONFIG_MTD_BLOCK is not set
CONFIG_MTD_BLOCK_RO=y

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
CONFIG_FTL=y
CONFIG_NFTL=y
# CONFIG_NFTL_RW is not set
CONFIG_INFTL=y
CONFIG_RFD_FTL=y
# CONFIG_SSFDC is not set
CONFIG_SM_FTL=y
CONFIG_MTD_OOPS=y
CONFIG_MTD_SWAP=y
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
CONFIG_MTD_JEDECPROBE=y
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_STAA=y
CONFIG_MTD_CFI_UTIL=y
CONFIG_MTD_RAM=y
CONFIG_MTD_ROM=y
CONFIG_MTD_ABSENT=y
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
# CONFIG_MTD_PHYSMAP is not set
CONFIG_MTD_SBC_GXX=y
CONFIG_MTD_SCx200_DOCFLASH=y
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=y
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
CONFIG_MTD_SCB2_FLASH=y
# CONFIG_MTD_NETtel is not set
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_PCI is not set
CONFIG_MTD_INTEL_VR_NOR=y
CONFIG_MTD_PLATRAM=y
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
CONFIG_MTD_MCHP23K256=y
# CONFIG_MTD_MCHP48L640 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=y
CONFIG_BCH_CONST_M=14
CONFIG_BCH_CONST_T=4
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=y
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_RAW_NAND=y

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
CONFIG_MTD_NAND_CAFE=y
# CONFIG_MTD_NAND_CS553X is not set
CONFIG_MTD_NAND_MXIC=y
CONFIG_MTD_NAND_GPIO=y
# CONFIG_MTD_NAND_PLATFORM is not set
CONFIG_MTD_NAND_ARASAN=y

#
# Misc
#
CONFIG_MTD_SM_COMMON=y
# CONFIG_MTD_NAND_NANDSIM is not set
CONFIG_MTD_NAND_RICOH=y
# CONFIG_MTD_NAND_DISKONCHIP is not set
# CONFIG_MTD_SPI_NAND is not set

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
# CONFIG_MTD_NAND_ECC_SW_BCH is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=y
CONFIG_MTD_QINFO_PROBE=y
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=y
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
CONFIG_MTD_UBI_GLUEBI=y
# CONFIG_MTD_UBI_BLOCK is not set
CONFIG_MTD_HYPERBUS=y
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=y
# CONFIG_PARPORT_PC is not set
# CONFIG_PARPORT_AX88796 is not set
# CONFIG_PARPORT_1284 is not set
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_ISAPNP=y
CONFIG_PNPBIOS=y
# CONFIG_PNPBIOS_PROC_FS is not set
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_VIRTIO_BLK is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set
# CONFIG_BLK_DEV_RNBD_SERVER is not set

#
# NVME Support
#
CONFIG_NVME_CORE=y
CONFIG_BLK_DEV_NVME=y
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=y
CONFIG_NVME_RDMA=y
CONFIG_NVME_FC=y
CONFIG_NVME_TCP=y
CONFIG_NVME_TARGET=y
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=y
CONFIG_NVME_TARGET_RDMA=y
# CONFIG_NVME_TARGET_FC is not set
CONFIG_NVME_TARGET_TCP=y
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=y
CONFIG_AD525X_DPOT=y
CONFIG_AD525X_DPOT_I2C=y
CONFIG_AD525X_DPOT_SPI=y
# CONFIG_DUMMY_IRQ is not set
CONFIG_IBM_ASM=y
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=y
# CONFIG_TIFM_7XX1 is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
CONFIG_HP_ILO=y
CONFIG_APDS9802ALS=y
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
CONFIG_SENSORS_TSL2550=y
# CONFIG_SENSORS_BH1770 is not set
CONFIG_SENSORS_APDS990X=y
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_PCH_PHUB=y
# CONFIG_LATTICE_ECP3_CONFIG is not set
CONFIG_SRAM=y
CONFIG_DW_XDATA_PCIE=y
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=y
CONFIG_MISC_RTSX=y
CONFIG_C2PORT=y
# CONFIG_C2PORT_DURAMAR_2150 is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
CONFIG_EEPROM_AT25=y
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_93XX46 is not set
CONFIG_EEPROM_IDT_89HPESX=y
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=y
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=y
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=y
# CONFIG_ALTERA_STAPL is not set
CONFIG_INTEL_MEI=y
CONFIG_INTEL_MEI_ME=y
# CONFIG_INTEL_MEI_TXE is not set
CONFIG_INTEL_MEI_HDCP=y
# CONFIG_INTEL_MEI_PXP is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_ECHO is not set
CONFIG_MISC_ALCOR_PCI=y
CONFIG_MISC_RTSX_PCI=y
# CONFIG_MISC_RTSX_USB is not set
CONFIG_HABANA_AI=y
CONFIG_UACCE=y
CONFIG_PVPANIC=y
CONFIG_PVPANIC_MMIO=y
CONFIG_PVPANIC_PCI=y
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=y
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_BLK_DEV_BSG is not set
CONFIG_CHR_DEV_SCH=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_FC_ATTRS=y
CONFIG_SCSI_ISCSI_ATTRS=y
CONFIG_SCSI_SAS_ATTRS=y
CONFIG_SCSI_SAS_LIBSAS=y
CONFIG_SCSI_SAS_ATA=y
# CONFIG_SCSI_SAS_HOST_SMP is not set
CONFIG_SCSI_SRP_ATTRS=y
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=y
CONFIG_ISCSI_BOOT_SYSFS=y
CONFIG_SCSI_CXGB3_ISCSI=y
CONFIG_SCSI_CXGB4_ISCSI=y
CONFIG_SCSI_BNX2_ISCSI=y
CONFIG_BE2ISCSI=y
CONFIG_BLK_DEV_3W_XXXX_RAID=y
# CONFIG_SCSI_HPSA is not set
CONFIG_SCSI_3W_9XXX=y
CONFIG_SCSI_3W_SAS=y
CONFIG_SCSI_ACARD=y
# CONFIG_SCSI_AHA152X is not set
CONFIG_SCSI_AHA1542=y
CONFIG_SCSI_AHA1740=y
CONFIG_SCSI_AACRAID=y
CONFIG_SCSI_AIC7XXX=y
CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
CONFIG_AIC7XXX_RESET_DELAY_MS=5000
# CONFIG_AIC7XXX_DEBUG_ENABLE is not set
CONFIG_AIC7XXX_DEBUG_MASK=0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
CONFIG_SCSI_AIC79XX=y
CONFIG_AIC79XX_CMDS_PER_DEVICE=32
CONFIG_AIC79XX_RESET_DELAY_MS=5000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=y
CONFIG_SCSI_MVSAS_DEBUG=y
# CONFIG_SCSI_MVSAS_TASKLET is not set
# CONFIG_SCSI_MVUMI is not set
CONFIG_SCSI_DPT_I2O=y
CONFIG_SCSI_ADVANSYS=y
CONFIG_SCSI_ARCMSR=y
CONFIG_SCSI_ESAS2R=y
CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=y
CONFIG_MEGARAID_MAILBOX=y
# CONFIG_MEGARAID_LEGACY is not set
# CONFIG_MEGARAID_SAS is not set
# CONFIG_SCSI_MPT3SAS is not set
# CONFIG_SCSI_MPT2SAS is not set
CONFIG_SCSI_MPI3MR=y
CONFIG_SCSI_SMARTPQI=y
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_UFS_HWMON is not set
# CONFIG_SCSI_HPTIOP is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=y
# CONFIG_LIBFC is not set
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
CONFIG_SCSI_FDOMAIN=y
CONFIG_SCSI_FDOMAIN_PCI=y
# CONFIG_SCSI_FDOMAIN_ISA is not set
# CONFIG_SCSI_ISCI is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
CONFIG_SCSI_IPS=y
CONFIG_SCSI_INITIO=y
CONFIG_SCSI_INIA100=y
CONFIG_SCSI_STEX=y
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_MMIO is not set
CONFIG_SCSI_IPR=y
# CONFIG_SCSI_IPR_TRACE is not set
# CONFIG_SCSI_IPR_DUMP is not set
CONFIG_SCSI_QLOGIC_FAS=y
CONFIG_SCSI_QLOGIC_1280=y
CONFIG_SCSI_QLA_FC=y
CONFIG_SCSI_QLA_ISCSI=y
CONFIG_SCSI_LPFC=y
# CONFIG_SCSI_LPFC_DEBUG_FS is not set
CONFIG_SCSI_SIM710=y
# CONFIG_SCSI_DC395x is not set
CONFIG_SCSI_AM53C974=y
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=y
CONFIG_SCSI_PMCRAID=y
CONFIG_SCSI_PM8001=y
CONFIG_SCSI_BFA_FC=y
CONFIG_SCSI_VIRTIO=y
# CONFIG_SCSI_CHELSIO_FCOE is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=y
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_ZPODD=y
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_AHCI_PLATFORM is not set
CONFIG_SATA_INIC162X=y
CONFIG_SATA_ACARD_AHCI=y
CONFIG_SATA_SIL24=y
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=y
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=y
# CONFIG_SATA_MV is not set
CONFIG_SATA_NV=y
CONFIG_SATA_PROMISE=y
# CONFIG_SATA_SIL is not set
CONFIG_SATA_SIS=y
CONFIG_SATA_SVW=y
CONFIG_SATA_ULI=y
CONFIG_SATA_VIA=y
CONFIG_SATA_VITESSE=y

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=y
# CONFIG_PATA_AMD is not set
CONFIG_PATA_ARTOP=y
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
CONFIG_PATA_CMD64X=y
# CONFIG_PATA_CS5520 is not set
# CONFIG_PATA_CS5530 is not set
CONFIG_PATA_CS5535=y
# CONFIG_PATA_CS5536 is not set
CONFIG_PATA_CYPRESS=y
CONFIG_PATA_EFAR=y
CONFIG_PATA_HPT366=y
CONFIG_PATA_HPT37X=y
CONFIG_PATA_HPT3X2N=y
# CONFIG_PATA_HPT3X3 is not set
CONFIG_PATA_IT8213=y
CONFIG_PATA_IT821X=y
CONFIG_PATA_JMICRON=y
CONFIG_PATA_MARVELL=y
CONFIG_PATA_NETCELL=y
CONFIG_PATA_NINJA32=y
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
CONFIG_PATA_OPTIDMA=y
CONFIG_PATA_PDC2027X=y
CONFIG_PATA_PDC_OLD=y
CONFIG_PATA_RADISYS=y
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SC1200 is not set
CONFIG_PATA_SCH=y
CONFIG_PATA_SERVERWORKS=y
CONFIG_PATA_SIL680=y
CONFIG_PATA_SIS=y
# CONFIG_PATA_TOSHIBA is not set
CONFIG_PATA_TRIFLEX=y
CONFIG_PATA_VIA=y
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
CONFIG_PATA_CMD640_PCI=y
CONFIG_PATA_ISAPNP=y
CONFIG_PATA_MPIIX=y
CONFIG_PATA_NS87410=y
# CONFIG_PATA_OPTI is not set
CONFIG_PATA_QDI=y
CONFIG_PATA_RZ1000=y
CONFIG_PATA_WINBOND_VLB=y

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=y
CONFIG_ATA_GENERIC=y
CONFIG_PATA_LEGACY=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
# CONFIG_MD_AUTODETECT is not set
# CONFIG_MD_LINEAR is not set
CONFIG_MD_RAID0=y
# CONFIG_MD_RAID1 is not set
CONFIG_MD_RAID10=y
CONFIG_MD_RAID456=y
CONFIG_MD_MULTIPATH=y
CONFIG_MD_FAULTY=y
CONFIG_BCACHE=y
CONFIG_BCACHE_DEBUG=y
CONFIG_BCACHE_CLOSURES_DEBUG=y
CONFIG_BCACHE_ASYNC_REGISTRATION=y
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=y
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=y
CONFIG_DM_PERSISTENT_DATA=y
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=y
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_THIN_PROVISIONING is not set
CONFIG_DM_CACHE=y
# CONFIG_DM_CACHE_SMQ is not set
CONFIG_DM_WRITECACHE=y
CONFIG_DM_ERA=y
CONFIG_DM_CLONE=y
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_RAID is not set
# CONFIG_DM_ZERO is not set
CONFIG_DM_MULTIPATH=y
# CONFIG_DM_MULTIPATH_QL is not set
CONFIG_DM_MULTIPATH_ST=y
CONFIG_DM_MULTIPATH_HST=y
# CONFIG_DM_MULTIPATH_IOA is not set
CONFIG_DM_DELAY=y
# CONFIG_DM_DUST is not set
# CONFIG_DM_INIT is not set
CONFIG_DM_UEVENT=y
# CONFIG_DM_FLAKEY is not set
# CONFIG_DM_VERITY is not set
# CONFIG_DM_SWITCH is not set
CONFIG_DM_LOG_WRITES=y
CONFIG_DM_INTEGRITY=y
# CONFIG_DM_ZONED is not set
CONFIG_DM_AUDIT=y
# CONFIG_TARGET_CORE is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=y
CONFIG_FIREWIRE_OHCI=y
# CONFIG_FIREWIRE_SBP2 is not set
CONFIG_FIREWIRE_NET=y
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
# CONFIG_NET_CORE is not set
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# Distributed Switch Architecture drivers
#
CONFIG_B53=y
CONFIG_B53_SPI_DRIVER=y
CONFIG_B53_MDIO_DRIVER=y
CONFIG_B53_MMAP_DRIVER=y
# CONFIG_B53_SRAB_DRIVER is not set
# CONFIG_B53_SERDES is not set
# CONFIG_NET_DSA_BCM_SF2 is not set
# CONFIG_NET_DSA_LOOP is not set
# CONFIG_NET_DSA_LANTIQ_GSWIP is not set
CONFIG_NET_DSA_MT7530=y
CONFIG_NET_DSA_MV88E6060=y
CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON=y
# CONFIG_NET_DSA_MICROCHIP_KSZ9477 is not set
CONFIG_NET_DSA_MICROCHIP_KSZ8795=y
CONFIG_NET_DSA_MICROCHIP_KSZ8795_SPI=y
CONFIG_NET_DSA_MICROCHIP_KSZ8863_SMI=y
CONFIG_NET_DSA_MV88E6XXX=y
CONFIG_NET_DSA_MSCC_SEVILLE=y
CONFIG_NET_DSA_AR9331=y
# CONFIG_NET_DSA_SJA1105 is not set
CONFIG_NET_DSA_XRS700X=y
CONFIG_NET_DSA_XRS700X_I2C=y
CONFIG_NET_DSA_XRS700X_MDIO=y
CONFIG_NET_DSA_QCA8K=y
# CONFIG_NET_DSA_REALTEK_SMI is not set
CONFIG_NET_DSA_SMSC_LAN9303=y
CONFIG_NET_DSA_SMSC_LAN9303_I2C=y
# CONFIG_NET_DSA_SMSC_LAN9303_MDIO is not set
CONFIG_NET_DSA_VITESSE_VSC73XX=y
CONFIG_NET_DSA_VITESSE_VSC73XX_SPI=y
CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM=y
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
CONFIG_NET_VENDOR_ADAPTEC=y
CONFIG_ADAPTEC_STARFIRE=y
CONFIG_NET_VENDOR_AGERE=y
CONFIG_ET131X=y
CONFIG_NET_VENDOR_ALACRITECH=y
CONFIG_SLICOSS=y
# CONFIG_NET_VENDOR_ALTEON is not set
CONFIG_ALTERA_TSE=y
# CONFIG_NET_VENDOR_AMAZON is not set
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=y
# CONFIG_NET_VENDOR_ARC is not set
CONFIG_NET_VENDOR_ASIX=y
# CONFIG_SPI_AX88796C is not set
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
CONFIG_ATL1=y
CONFIG_ATL1E=y
CONFIG_ATL1C=y
# CONFIG_ALX is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=y
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=y
CONFIG_CNIC=y
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=y
# CONFIG_BNXT_SRIOV is not set
# CONFIG_BNXT_FLOWER_OFFLOAD is not set
# CONFIG_BNXT_DCB is not set
# CONFIG_BNXT_HWMON is not set
# CONFIG_NET_VENDOR_BROCADE is not set
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=y
CONFIG_MACB_PCI=y
CONFIG_NET_VENDOR_CAVIUM=y
CONFIG_NET_VENDOR_CHELSIO=y
CONFIG_CHELSIO_T1=y
# CONFIG_CHELSIO_T1_1G is not set
CONFIG_CHELSIO_T3=y
CONFIG_CHELSIO_T4=y
CONFIG_CHELSIO_T4_DCB=y
CONFIG_CHELSIO_T4VF=y
CONFIG_CHELSIO_LIB=y
# CONFIG_CHELSIO_INLINE_CRYPTO is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0_ISA is not set
# CONFIG_NET_VENDOR_CISCO is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_CX_ECAT=y
CONFIG_DNET=y
# CONFIG_NET_VENDOR_DEC is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
# CONFIG_NET_VENDOR_EMULEX is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_NET_VENDOR_GOOGLE is not set
# CONFIG_NET_VENDOR_HUAWEI is not set
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
# CONFIG_IGB is not set
CONFIG_IGBVF=y
CONFIG_IXGB=y
CONFIG_IXGBE=y
# CONFIG_IXGBE_HWMON is not set
# CONFIG_IXGBE_DCB is not set
CONFIG_IXGBE_IPSEC=y
# CONFIG_I40E is not set
CONFIG_IGC=y
# CONFIG_NET_VENDOR_MICROSOFT is not set
CONFIG_JME=y
# CONFIG_NET_VENDOR_LITEX is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_MSCC_OCELOT_SWITCH_LIB=y
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=y
CONFIG_FEALNX=y
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETERION is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_NI=y
CONFIG_NI_XGE_MANAGEMENT_ENET=y
CONFIG_NET_VENDOR_NVIDIA=y
CONFIG_FORCEDETH=y
# CONFIG_NET_VENDOR_OKI is not set
CONFIG_ETHOC=y
# CONFIG_NET_VENDOR_PACKET_ENGINES is not set
CONFIG_NET_VENDOR_PENSANDO=y
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=y
CONFIG_QLCNIC=y
# CONFIG_QLCNIC_SRIOV is not set
# CONFIG_QLCNIC_DCB is not set
CONFIG_QLCNIC_HWMON=y
CONFIG_NETXEN_NIC=y
# CONFIG_QED is not set
CONFIG_NET_VENDOR_QUALCOMM=y
CONFIG_QCOM_EMAC=y
CONFIG_RMNET=y
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
# CONFIG_NET_VENDOR_RENESAS is not set
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
CONFIG_SXGBE_ETH=y
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
CONFIG_SFC_FALCON=y
CONFIG_SFC_FALCON_MTD=y
# CONFIG_NET_VENDOR_SILAN is not set
CONFIG_NET_VENDOR_SIS=y
CONFIG_SIS900=y
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_SMC9194=y
# CONFIG_EPIC100 is not set
CONFIG_SMSC911X=y
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
CONFIG_NET_VENDOR_VIA=y
CONFIG_VIA_RHINE=y
# CONFIG_VIA_RHINE_MMIO is not set
CONFIG_VIA_VELOCITY=y
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_XILINX is not set
CONFIG_FDDI=y
CONFIG_DEFXX=y
CONFIG_SKFP=y
# CONFIG_HIPPI is not set
CONFIG_NET_SB1000=y
CONFIG_PHYLINK=y
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
# CONFIG_AMD_PHY is not set
CONFIG_ADIN_PHY=y
# CONFIG_AQUANTIA_PHY is not set
CONFIG_AX88796B_PHY=y
# CONFIG_BROADCOM_PHY is not set
CONFIG_BCM54140_PHY=y
CONFIG_BCM7XXX_PHY=y
CONFIG_BCM84881_PHY=y
CONFIG_BCM87XX_PHY=y
CONFIG_BCM_NET_PHYLIB=y
CONFIG_CICADA_PHY=y
CONFIG_CORTINA_PHY=y
CONFIG_DAVICOM_PHY=y
# CONFIG_ICPLUS_PHY is not set
CONFIG_LXT_PHY=y
CONFIG_INTEL_XWAY_PHY=y
CONFIG_LSI_ET1011C_PHY=y
CONFIG_MARVELL_PHY=y
CONFIG_MARVELL_10G_PHY=y
# CONFIG_MARVELL_88X2222_PHY is not set
CONFIG_MAXLINEAR_GPHY=y
CONFIG_MEDIATEK_GE_PHY=y
CONFIG_MICREL_PHY=y
CONFIG_MICROCHIP_PHY=y
CONFIG_MICROCHIP_T1_PHY=y
# CONFIG_MICROSEMI_PHY is not set
CONFIG_MOTORCOMM_PHY=y
# CONFIG_NATIONAL_PHY is not set
CONFIG_NXP_C45_TJA11XX_PHY=y
CONFIG_NXP_TJA11XX_PHY=y
# CONFIG_AT803X_PHY is not set
# CONFIG_QSEMI_PHY is not set
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=y
# CONFIG_STE10XP is not set
CONFIG_TERANETICS_PHY=y
CONFIG_DP83822_PHY=y
CONFIG_DP83TC811_PHY=y
CONFIG_DP83848_PHY=y
CONFIG_DP83867_PHY=y
# CONFIG_DP83869_PHY is not set
CONFIG_VITESSE_PHY=y
# CONFIG_XILINX_GMII2RGMII is not set
CONFIG_MICREL_KS8995MA=y

#
# MCTP Device Drivers
#
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_FWNODE_MDIO=y
CONFIG_ACPI_MDIO=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_BITBANG=y
CONFIG_MDIO_BCM_UNIMAC=y
CONFIG_MDIO_GPIO=y
CONFIG_MDIO_MVUSB=y
CONFIG_MDIO_MSCC_MIIM=y

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
CONFIG_PCS_XPCS=y
CONFIG_PCS_LYNX=y
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
CONFIG_SLIP=y
CONFIG_SLHC=y
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
CONFIG_USB_LAN78XX=y
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=y
CONFIG_USB_NET_HUAWEI_CDC_NCM=y
# CONFIG_USB_NET_CDC_MBIM is not set
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
CONFIG_USB_NET_SR9800=y
# CONFIG_USB_NET_SMSC75XX is not set
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
# CONFIG_USB_ALI_M5632 is not set
CONFIG_USB_AN2720=y
# CONFIG_USB_BELKIN is not set
# CONFIG_USB_ARMLINUX is not set
CONFIG_USB_EPSON2888=y
# CONFIG_USB_KC2190 is not set
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=y
CONFIG_USB_NET_KALMIA=y
CONFIG_USB_NET_QMI_WWAN=y
# CONFIG_USB_NET_INT51X1 is not set
CONFIG_USB_CDC_PHONET=y
# CONFIG_USB_IPHETH is not set
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=y
CONFIG_USB_NET_CH9200=y
# CONFIG_USB_NET_AQC111 is not set
# CONFIG_USB_RTL8153_ECM is not set
CONFIG_WLAN=y
# CONFIG_WLAN_VENDOR_ADMTEK is not set
# CONFIG_WLAN_VENDOR_ATH is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
CONFIG_AT76C50X_USB=y
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
CONFIG_B43LEGACY=y
CONFIG_B43LEGACY_PCI_AUTOSELECT=y
CONFIG_B43LEGACY_PCICORE_AUTOSELECT=y
CONFIG_B43LEGACY_LEDS=y
CONFIG_B43LEGACY_HWRNG=y
# CONFIG_B43LEGACY_DEBUG is not set
CONFIG_B43LEGACY_PIO=y
# CONFIG_B43LEGACY_DMA_AND_PIO_MODE is not set
# CONFIG_B43LEGACY_DMA_MODE is not set
CONFIG_B43LEGACY_PIO_MODE=y
CONFIG_BRCMUTIL=y
CONFIG_BRCMSMAC=y
# CONFIG_BRCMFMAC is not set
# CONFIG_BRCM_TRACING is not set
# CONFIG_BRCMDBG is not set
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_AIRO=y
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
CONFIG_IPW2200=y
CONFIG_IPW2200_MONITOR=y
CONFIG_IPW2200_RADIOTAP=y
CONFIG_IPW2200_PROMISCUOUS=y
# CONFIG_IPW2200_QOS is not set
# CONFIG_IPW2200_DEBUG is not set
CONFIG_LIBIPW=y
CONFIG_LIBIPW_DEBUG=y
CONFIG_IWLEGACY=y
CONFIG_IWL4965=y
CONFIG_IWL3945=y

#
# iwl3945 / iwl4965 Debugging Options
#
CONFIG_IWLEGACY_DEBUG=y
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

# CONFIG_IWLWIFI is not set
CONFIG_WLAN_VENDOR_INTERSIL=y
CONFIG_HOSTAP=y
CONFIG_HOSTAP_FIRMWARE=y
# CONFIG_HOSTAP_FIRMWARE_NVRAM is not set
CONFIG_HOSTAP_PLX=y
# CONFIG_HOSTAP_PCI is not set
CONFIG_HERMES=y
# CONFIG_HERMES_PRISM is not set
# CONFIG_HERMES_CACHE_FW_ON_INIT is not set
CONFIG_PLX_HERMES=y
CONFIG_TMD_HERMES=y
# CONFIG_NORTEL_HERMES is not set
# CONFIG_ORINOCO_USB is not set
# CONFIG_P54_COMMON is not set
# CONFIG_WLAN_VENDOR_MARVELL is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_MT7601U=y
CONFIG_MT76_CORE=y
CONFIG_MT76_LEDS=y
CONFIG_MT76_USB=y
CONFIG_MT76x02_LIB=y
CONFIG_MT76x02_USB=y
CONFIG_MT76_CONNAC_LIB=y
CONFIG_MT76x0_COMMON=y
CONFIG_MT76x0U=y
# CONFIG_MT76x0E is not set
CONFIG_MT76x2_COMMON=y
CONFIG_MT76x2E=y
CONFIG_MT76x2U=y
CONFIG_MT7603E=y
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7915E is not set
CONFIG_MT7921_COMMON=y
CONFIG_MT7921E=y
# CONFIG_WLAN_VENDOR_MICROCHIP is not set
# CONFIG_WLAN_VENDOR_RALINK is not set
# CONFIG_WLAN_VENDOR_REALTEK is not set
# CONFIG_WLAN_VENDOR_RSI is not set
# CONFIG_WLAN_VENDOR_ST is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
CONFIG_WL18XX=y
CONFIG_WLCORE=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_USB_ZD1201=y
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
CONFIG_QTNFMAC=y
CONFIG_QTNFMAC_PCIE=y
CONFIG_MAC80211_HWSIM=y
CONFIG_USB_NET_RNDIS_WLAN=y
CONFIG_VIRT_WIFI=y
CONFIG_WAN=y
# CONFIG_HDLC is not set
CONFIG_IEEE802154_DRIVERS=y
CONFIG_IEEE802154_FAKELB=y
# CONFIG_IEEE802154_AT86RF230 is not set
CONFIG_IEEE802154_MRF24J40=y
CONFIG_IEEE802154_CC2520=y
CONFIG_IEEE802154_ATUSB=y
# CONFIG_IEEE802154_ADF7242 is not set
CONFIG_IEEE802154_CA8210=y
CONFIG_IEEE802154_CA8210_DEBUGFS=y
CONFIG_IEEE802154_MCR20A=y
# CONFIG_IEEE802154_HWSIM is not set

#
# Wireless WAN
#
CONFIG_WWAN=y
CONFIG_WWAN_HWSIM=y
CONFIG_MHI_WWAN_CTRL=y
CONFIG_MHI_WWAN_MBIM=y
CONFIG_RPMSG_WWAN_CTRL=y
# end of Wireless WAN

CONFIG_VMXNET3=y
# CONFIG_FUJITSU_ES is not set
CONFIG_USB4_NET=y
CONFIG_NETDEVSIM=y
CONFIG_NET_FAILOVER=y
CONFIG_NETDEV_LEGACY_INIT=y
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_SPARSEKMAP=y
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
CONFIG_KEYBOARD_ADP5589=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_QT1050=y
# CONFIG_KEYBOARD_QT1070 is not set
CONFIG_KEYBOARD_QT2160=y
CONFIG_KEYBOARD_DLINK_DIR685=y
CONFIG_KEYBOARD_LKKBD=y
# CONFIG_KEYBOARD_GPIO is not set
CONFIG_KEYBOARD_GPIO_POLLED=y
CONFIG_KEYBOARD_TCA6416=y
CONFIG_KEYBOARD_TCA8418=y
CONFIG_KEYBOARD_MATRIX=y
CONFIG_KEYBOARD_LM8323=y
CONFIG_KEYBOARD_LM8333=y
CONFIG_KEYBOARD_MAX7359=y
CONFIG_KEYBOARD_MCS=y
CONFIG_KEYBOARD_MPR121=y
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
CONFIG_KEYBOARD_SUNKBD=y
CONFIG_KEYBOARD_IQS62X=y
CONFIG_KEYBOARD_TM2_TOUCHKEY=y
CONFIG_KEYBOARD_XTKBD=y
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
CONFIG_MOUSE_SERIAL=y
CONFIG_MOUSE_APPLETOUCH=y
CONFIG_MOUSE_BCM5974=y
# CONFIG_MOUSE_CYAPA is not set
CONFIG_MOUSE_ELAN_I2C=y
CONFIG_MOUSE_ELAN_I2C_I2C=y
# CONFIG_MOUSE_ELAN_I2C_SMBUS is not set
# CONFIG_MOUSE_INPORT is not set
CONFIG_MOUSE_LOGIBM=y
# CONFIG_MOUSE_PC110PAD is not set
CONFIG_MOUSE_VSXXXAA=y
CONFIG_MOUSE_GPIO=y
CONFIG_MOUSE_SYNAPTICS_I2C=y
CONFIG_MOUSE_SYNAPTICS_USB=y
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
CONFIG_RMI4_CORE=y
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=y
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=y
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
CONFIG_RMI4_F34=y
# CONFIG_RMI4_F3A is not set
CONFIG_RMI4_F54=y
CONFIG_RMI4_F55=y

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
CONFIG_SERIO_CT82C710=y
CONFIG_SERIO_PARKBD=y
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=y
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DWLIB=y
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
CONFIG_SERIAL_MAX310X=y
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
CONFIG_SERIAL_SCCNXP=y
# CONFIG_SERIAL_SCCNXP_CONSOLE is not set
CONFIG_SERIAL_SC16IS7XX_CORE=y
CONFIG_SERIAL_SC16IS7XX=y
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
CONFIG_SERIAL_SC16IS7XX_SPI=y
CONFIG_SERIAL_TIMBERDALE=y
# CONFIG_SERIAL_BCM63XX is not set
CONFIG_SERIAL_ALTERA_JTAGUART=y
# CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_PCH_UART is not set
CONFIG_SERIAL_ARC=y
CONFIG_SERIAL_ARC_CONSOLE=y
CONFIG_SERIAL_ARC_NR_PORTS=1
CONFIG_SERIAL_RP2=y
CONFIG_SERIAL_RP2_NR_UARTS=32
CONFIG_SERIAL_FSL_LPUART=y
CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
CONFIG_SERIAL_SPRD=y
CONFIG_SERIAL_SPRD_CONSOLE=y
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_N_GSM=y
CONFIG_NOZOMI=y
# CONFIG_NULL_TTY is not set
CONFIG_HVC_DRIVER=y
# CONFIG_RPMSG_TTY is not set
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_PRINTER is not set
CONFIG_PPDEV=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_SI=y
CONFIG_IPMI_SSIF=y
# CONFIG_IPMI_IPMB is not set
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=y
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
# CONFIG_HW_RANDOM_INTEL is not set
CONFIG_HW_RANDOM_AMD=y
CONFIG_HW_RANDOM_BA431=y
CONFIG_HW_RANDOM_GEODE=y
CONFIG_HW_RANDOM_VIA=y
CONFIG_HW_RANDOM_VIRTIO=y
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_DTLK is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set
# CONFIG_MWAVE is not set
CONFIG_SCx200_GPIO=y
CONFIG_PC8736x_GPIO=y
CONFIG_NSC_GPIO=y
CONFIG_DEVMEM=y
CONFIG_NVRAM=y
# CONFIG_DEVPORT is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_CR50=y
CONFIG_TCG_TIS_I2C_ATMEL=y
# CONFIG_TCG_TIS_I2C_INFINEON is not set
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
# CONFIG_TCG_NSC is not set
CONFIG_TCG_ATMEL=y
CONFIG_TCG_INFINEON=y
# CONFIG_TCG_CRB is not set
CONFIG_TCG_VTPM_PROXY=y
CONFIG_TCG_TIS_ST33ZP24=y
CONFIG_TCG_TIS_ST33ZP24_I2C=y
CONFIG_TCG_TIS_ST33ZP24_SPI=y
CONFIG_TELCLOCK=y
CONFIG_XILLYBUS_CLASS=y
CONFIG_XILLYBUS=y
# CONFIG_XILLYUSB is not set
# CONFIG_RANDOM_TRUST_CPU is not set
CONFIG_RANDOM_TRUST_BOOTLOADER=y
# end of Character devices

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
# CONFIG_I2C_COMPAT is not set
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
CONFIG_I2C_MUX_LTC4306=y
# CONFIG_I2C_MUX_PCA9541 is not set
CONFIG_I2C_MUX_PCA954x=y
CONFIG_I2C_MUX_REG=y
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=y

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=y
CONFIG_I2C_ALI1563=y
CONFIG_I2C_ALI15X3=y
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
CONFIG_I2C_AMD_MP2=y
CONFIG_I2C_I801=y
CONFIG_I2C_ISCH=y
# CONFIG_I2C_ISMT is not set
CONFIG_I2C_PIIX4=y
# CONFIG_I2C_NFORCE2 is not set
CONFIG_I2C_NVIDIA_GPU=y
CONFIG_I2C_SIS5595=y
CONFIG_I2C_SIS630=y
CONFIG_I2C_SIS96X=y
# CONFIG_I2C_VIA is not set
CONFIG_I2C_VIAPRO=y

#
# ACPI drivers
#
CONFIG_I2C_SCMI=y

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=y
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EG20T is not set
CONFIG_I2C_EMEV2=y
CONFIG_I2C_GPIO=y
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
# CONFIG_I2C_KEMPLD is not set
CONFIG_I2C_OCORES=y
CONFIG_I2C_PCA_PLATFORM=y
CONFIG_I2C_SIMTEC=y
CONFIG_I2C_XILINX=y

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=y
CONFIG_I2C_DLN2=y
CONFIG_I2C_CP2615=y
CONFIG_I2C_PARPORT=y
CONFIG_I2C_ROBOTFUZZ_OSIF=y
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=y
CONFIG_I2C_VIPERBOARD=y

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_PCA_ISA is not set
# CONFIG_SCx200_ACB is not set
CONFIG_I2C_VIRTIO=y
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
# CONFIG_I2C_SLAVE_EEPROM is not set
CONFIG_I2C_SLAVE_TESTUNIT=y
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=y
CONFIG_CDNS_I3C_MASTER=y
# CONFIG_DW_I3C_MASTER is not set
CONFIG_SVC_I3C_MASTER=y
# CONFIG_MIPI_I3C_HCI is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
CONFIG_SPI_MEM=y

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=y
CONFIG_SPI_ALTERA_CORE=y
# CONFIG_SPI_AXI_SPI_ENGINE is not set
CONFIG_SPI_BITBANG=y
CONFIG_SPI_BUTTERFLY=y
CONFIG_SPI_CADENCE=y
CONFIG_SPI_DESIGNWARE=y
CONFIG_SPI_DW_DMA=y
# CONFIG_SPI_DW_PCI is not set
CONFIG_SPI_DW_MMIO=y
# CONFIG_SPI_DLN2 is not set
CONFIG_SPI_NXP_FLEXSPI=y
CONFIG_SPI_GPIO=y
CONFIG_SPI_LM70_LLP=y
CONFIG_SPI_LANTIQ_SSC=y
CONFIG_SPI_OC_TINY=y
CONFIG_SPI_PXA2XX=y
CONFIG_SPI_PXA2XX_PCI=y
# CONFIG_SPI_ROCKCHIP is not set
CONFIG_SPI_SC18IS602=y
CONFIG_SPI_SIFIVE=y
# CONFIG_SPI_MXIC is not set
CONFIG_SPI_TOPCLIFF_PCH=y
CONFIG_SPI_XCOMM=y
CONFIG_SPI_XILINX=y
# CONFIG_SPI_ZYNQMP_GQSPI is not set
CONFIG_SPI_AMD=y

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=y
# CONFIG_SPI_LOOPBACK_TEST is not set
CONFIG_SPI_TLE62X0=y
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
CONFIG_SPMI=y
# CONFIG_SPMI_HISI3670 is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=y
# CONFIG_PPS_CLIENT_LDISC is not set
CONFIG_PPS_CLIENT_PARPORT=y
CONFIG_PPS_CLIENT_GPIO=y

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=y
CONFIG_PINCTRL_DA9062=y
CONFIG_PINCTRL_MCP23S08_I2C=y
CONFIG_PINCTRL_MCP23S08_SPI=y
CONFIG_PINCTRL_MCP23S08=y
CONFIG_PINCTRL_SX150X=y

#
# Intel pinctrl drivers
#
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
CONFIG_PINCTRL_ALDERLAKE=y
CONFIG_PINCTRL_BROXTON=y
CONFIG_PINCTRL_CANNONLAKE=y
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=y
CONFIG_PINCTRL_ELKHARTLAKE=y
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=y
CONFIG_PINCTRL_ICELAKE=y
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
CONFIG_PINCTRL_LEWISBURG=y
CONFIG_PINCTRL_SUNRISEPOINT=y
CONFIG_PINCTRL_TIGERLAKE=y
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_PINCTRL_MADERA=y
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_PINCTRL_CS47L92=y
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=y
CONFIG_GPIO_MAX730X=y

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=y
CONFIG_GPIO_DWAPB=y
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=y
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_SIOX is not set
# CONFIG_GPIO_VX855 is not set
CONFIG_GPIO_AMD_FCH=y
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
CONFIG_GPIO_SCH=y
CONFIG_GPIO_SCH311X=y
CONFIG_GPIO_WINBOND=y
CONFIG_GPIO_WS16C48=y
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_MAX7300=y
CONFIG_GPIO_MAX732X=y
CONFIG_GPIO_MAX732X_IRQ=y
CONFIG_GPIO_PCA953X=y
# CONFIG_GPIO_PCA953X_IRQ is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
CONFIG_GPIO_TPIC2810=y
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# CONFIG_GPIO_ARIZONA is not set
# CONFIG_GPIO_BD9571MWV is not set
CONFIG_GPIO_DA9052=y
# CONFIG_GPIO_DA9055 is not set
CONFIG_GPIO_DLN2=y
CONFIG_GPIO_JANZ_TTL=y
# CONFIG_GPIO_KEMPLD is not set
CONFIG_GPIO_LP3943=y
CONFIG_GPIO_LP873X=y
CONFIG_GPIO_MADERA=y
CONFIG_GPIO_PALMAS=y
# CONFIG_GPIO_RC5T583 is not set
# CONFIG_GPIO_TIMBERDALE is not set
CONFIG_GPIO_TPS65086=y
# CONFIG_GPIO_TPS6586X is not set
CONFIG_GPIO_TPS68470=y
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=y
# CONFIG_GPIO_BT8XX is not set
CONFIG_GPIO_ML_IOH=y
CONFIG_GPIO_PCH=y
# CONFIG_GPIO_PCI_IDIO_16 is not set
CONFIG_GPIO_PCIE_IDIO_24=y
CONFIG_GPIO_RDC321X=y
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_MAX3191X=y
CONFIG_GPIO_MAX7301=y
CONFIG_GPIO_MC33880=y
CONFIG_GPIO_PISOSR=y
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=y
# end of USB GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
CONFIG_GPIO_MOCKUP=y
CONFIG_GPIO_VIRTIO=y
# end of Virtual GPIO drivers

CONFIG_W1=y
# CONFIG_W1_CON is not set

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
# CONFIG_W1_MASTER_DS2490 is not set
CONFIG_W1_MASTER_DS2482=y
# CONFIG_W1_MASTER_DS1WM is not set
# CONFIG_W1_MASTER_GPIO is not set
CONFIG_W1_MASTER_SGI=y
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
# CONFIG_W1_SLAVE_THERM is not set
CONFIG_W1_SLAVE_SMEM=y
# CONFIG_W1_SLAVE_DS2405 is not set
# CONFIG_W1_SLAVE_DS2408 is not set
CONFIG_W1_SLAVE_DS2413=y
CONFIG_W1_SLAVE_DS2406=y
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=y
CONFIG_W1_SLAVE_DS2430=y
CONFIG_W1_SLAVE_DS2431=y
CONFIG_W1_SLAVE_DS2433=y
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=y
CONFIG_W1_SLAVE_DS250X=y
CONFIG_W1_SLAVE_DS2780=y
CONFIG_W1_SLAVE_DS2781=y
# CONFIG_W1_SLAVE_DS28E04 is not set
CONFIG_W1_SLAVE_DS28E17=y
# end of 1-wire Slaves

# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_PDA_POWER=y
CONFIG_GENERIC_ADC_BATTERY=y
CONFIG_TEST_POWER=y
CONFIG_CHARGER_ADP5061=y
CONFIG_BATTERY_CW2015=y
CONFIG_BATTERY_DS2760=y
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_DA9030 is not set
CONFIG_BATTERY_DA9052=y
CONFIG_CHARGER_DA9150=y
CONFIG_BATTERY_DA9150=y
CONFIG_AXP20X_POWER=y
# CONFIG_AXP288_FUEL_GAUGE is not set
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_BATTERY_MAX1721X is not set
CONFIG_CHARGER_PCF50633=y
CONFIG_CHARGER_ISP1704=y
CONFIG_CHARGER_MAX8903=y
CONFIG_CHARGER_LP8727=y
CONFIG_CHARGER_GPIO=y
CONFIG_CHARGER_MANAGER=y
CONFIG_CHARGER_LT3651=y
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX14577 is not set
CONFIG_CHARGER_MAX77693=y
CONFIG_CHARGER_MP2629=y
CONFIG_CHARGER_BQ2415X=y
CONFIG_CHARGER_BQ24190=y
CONFIG_CHARGER_BQ24257=y
# CONFIG_CHARGER_BQ24735 is not set
CONFIG_CHARGER_BQ2515X=y
CONFIG_CHARGER_BQ25890=y
CONFIG_CHARGER_BQ25980=y
CONFIG_CHARGER_BQ256XX=y
CONFIG_CHARGER_SMB347=y
CONFIG_BATTERY_GAUGE_LTC2941=y
CONFIG_BATTERY_GOLDFISH=y
CONFIG_BATTERY_RT5033=y
CONFIG_CHARGER_RT9455=y
CONFIG_CHARGER_BD99954=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_HWMON_DEBUG_CHIP=y

#
# Native drivers
#
# CONFIG_SENSORS_ABITUGURU is not set
CONFIG_SENSORS_ABITUGURU3=y
# CONFIG_SENSORS_AD7314 is not set
# CONFIG_SENSORS_AD7414 is not set
CONFIG_SENSORS_AD7418=y
CONFIG_SENSORS_ADM1021=y
CONFIG_SENSORS_ADM1025=y
CONFIG_SENSORS_ADM1026=y
CONFIG_SENSORS_ADM1029=y
CONFIG_SENSORS_ADM1031=y
# CONFIG_SENSORS_ADM1177 is not set
# CONFIG_SENSORS_ADM9240 is not set
CONFIG_SENSORS_ADT7X10=y
CONFIG_SENSORS_ADT7310=y
# CONFIG_SENSORS_ADT7410 is not set
CONFIG_SENSORS_ADT7411=y
# CONFIG_SENSORS_ADT7462 is not set
CONFIG_SENSORS_ADT7470=y
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_AHT10 is not set
CONFIG_SENSORS_AS370=y
CONFIG_SENSORS_ASC7621=y
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=y
CONFIG_SENSORS_K10TEMP=y
CONFIG_SENSORS_FAM15H_POWER=y
# CONFIG_SENSORS_APPLESMC is not set
# CONFIG_SENSORS_ASB100 is not set
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=y
# CONFIG_SENSORS_CORSAIR_CPRO is not set
CONFIG_SENSORS_CORSAIR_PSU=y
# CONFIG_SENSORS_DRIVETEMP is not set
# CONFIG_SENSORS_DS620 is not set
CONFIG_SENSORS_DS1621=y
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_SENSORS_DA9052_ADC is not set
CONFIG_SENSORS_DA9055=y
CONFIG_SENSORS_I5K_AMB=y
CONFIG_SENSORS_F71805F=y
CONFIG_SENSORS_F71882FG=y
CONFIG_SENSORS_F75375S=y
# CONFIG_SENSORS_MC13783_ADC is not set
CONFIG_SENSORS_FSCHMD=y
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=y
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
CONFIG_SENSORS_G762=y
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=y
CONFIG_SENSORS_IBMPEX=y
CONFIG_SENSORS_IIO_HWMON=y
# CONFIG_SENSORS_I5500 is not set
# CONFIG_SENSORS_CORETEMP is not set
# CONFIG_SENSORS_IT87 is not set
CONFIG_SENSORS_JC42=y
CONFIG_SENSORS_POWR1220=y
# CONFIG_SENSORS_LINEAGE is not set
CONFIG_SENSORS_LTC2945=y
CONFIG_SENSORS_LTC2947=y
CONFIG_SENSORS_LTC2947_I2C=y
# CONFIG_SENSORS_LTC2947_SPI is not set
CONFIG_SENSORS_LTC2990=y
# CONFIG_SENSORS_LTC2992 is not set
CONFIG_SENSORS_LTC4151=y
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=y
CONFIG_SENSORS_LTC4260=y
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=y
CONFIG_SENSORS_MAX1619=y
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=y
CONFIG_SENSORS_MAX31722=y
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6620 is not set
CONFIG_SENSORS_MAX6621=y
CONFIG_SENSORS_MAX6639=y
CONFIG_SENSORS_MAX6642=y
# CONFIG_SENSORS_MAX6650 is not set
CONFIG_SENSORS_MAX6697=y
CONFIG_SENSORS_MAX31790=y
CONFIG_SENSORS_MCP3021=y
CONFIG_SENSORS_TC654=y
CONFIG_SENSORS_TPS23861=y
# CONFIG_SENSORS_MENF21BMC_HWMON is not set
CONFIG_SENSORS_MR75203=y
CONFIG_SENSORS_ADCXX=y
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=y
# CONFIG_SENSORS_LM75 is not set
CONFIG_SENSORS_LM77=y
CONFIG_SENSORS_LM78=y
# CONFIG_SENSORS_LM80 is not set
CONFIG_SENSORS_LM83=y
CONFIG_SENSORS_LM85=y
CONFIG_SENSORS_LM87=y
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=y
CONFIG_SENSORS_LM93=y
# CONFIG_SENSORS_LM95234 is not set
CONFIG_SENSORS_LM95241=y
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
CONFIG_SENSORS_PC87427=y
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=y
# CONFIG_PMBUS is not set
CONFIG_SENSORS_SBTSI=y
CONFIG_SENSORS_SBRMI=y
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
CONFIG_SENSORS_SHT3x=y
# CONFIG_SENSORS_SHT4x is not set
CONFIG_SENSORS_SHTC1=y
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_DME1737=y
CONFIG_SENSORS_EMC1403=y
CONFIG_SENSORS_EMC2103=y
CONFIG_SENSORS_EMC6W201=y
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
CONFIG_SENSORS_SCH5636=y
CONFIG_SENSORS_STTS751=y
CONFIG_SENSORS_SMM665=y
CONFIG_SENSORS_ADC128D818=y
# CONFIG_SENSORS_ADS7828 is not set
CONFIG_SENSORS_ADS7871=y
CONFIG_SENSORS_AMC6821=y
CONFIG_SENSORS_INA209=y
# CONFIG_SENSORS_INA2XX is not set
CONFIG_SENSORS_INA3221=y
CONFIG_SENSORS_TC74=y
CONFIG_SENSORS_THMC50=y
CONFIG_SENSORS_TMP102=y
CONFIG_SENSORS_TMP103=y
CONFIG_SENSORS_TMP108=y
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=y
# CONFIG_SENSORS_TMP513 is not set
# CONFIG_SENSORS_VIA_CPUTEMP is not set
CONFIG_SENSORS_VIA686A=y
# CONFIG_SENSORS_VT1211 is not set
CONFIG_SENSORS_VT8231=y
CONFIG_SENSORS_W83773G=y
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
CONFIG_SENSORS_W83792D=y
# CONFIG_SENSORS_W83793 is not set
CONFIG_SENSORS_W83795=y
CONFIG_SENSORS_W83795_FANCTRL=y
CONFIG_SENSORS_W83L785TS=y
CONFIG_SENSORS_W83L786NG=y
# CONFIG_SENSORS_W83627HF is not set
CONFIG_SENSORS_W83627EHF=y
CONFIG_SENSORS_INTEL_M10_BMC_HWMON=y

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=y
CONFIG_SENSORS_ATK0110=y
CONFIG_THERMAL=y
CONFIG_THERMAL_NETLINK=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
# CONFIG_THERMAL_HWMON is not set
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
CONFIG_THERMAL_EMULATION=y

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=y
CONFIG_INTEL_SOC_DTS_IOSF_CORE=y
CONFIG_INTEL_SOC_DTS_THERMAL=y

#
# ACPI INT340X thermal drivers
#
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_PCH_THERMAL=y
CONFIG_INTEL_TCC_COOLING=y
CONFIG_INTEL_MENLOW=y
# end of Intel thermal drivers

CONFIG_GENERIC_ADC_THERMAL=y
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=y
CONFIG_DA9052_WATCHDOG=y
CONFIG_DA9055_WATCHDOG=y
CONFIG_DA9063_WATCHDOG=y
# CONFIG_DA9062_WATCHDOG is not set
CONFIG_MENF21BMC_WATCHDOG=y
# CONFIG_WDAT_WDT is not set
CONFIG_XILINX_WATCHDOG=y
CONFIG_ZIIRAVE_WATCHDOG=y
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_DW_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=y
CONFIG_RETU_WATCHDOG=y
CONFIG_ACQUIRE_WDT=y
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=y
CONFIG_SP5100_TCO=y
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=y
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=y
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=y
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=y
CONFIG_HP_WATCHDOG=y
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_KEMPLD_WDT is not set
# CONFIG_SC1200_WDT is not set
CONFIG_SCx200_WDT=y
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
# CONFIG_60XX_WDT is not set
CONFIG_SBC8360_WDT=y
CONFIG_SBC7240_WDT=y
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=y
CONFIG_TQMX86_WDT=y
CONFIG_VIA_WDT=y
CONFIG_W83627HF_WDT=y
CONFIG_W83877F_WDT=y
# CONFIG_W83977F_WDT is not set
CONFIG_MACHZ_WDT=y
CONFIG_SBC_EPX_C3_WATCHDOG=y
# CONFIG_INTEL_MEI_WDT is not set
# CONFIG_NI903X_WDT is not set
CONFIG_NIC7018_WDT=y
CONFIG_MEN_A21_WDT=y

#
# ISA-based Watchdog Cards
#
CONFIG_PCWATCHDOG=y
CONFIG_MIXCOMWD=y
# CONFIG_WDT is not set

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=y
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=y
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_B43_PCI_BRIDGE=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
# CONFIG_BCMA_HOST_PCI is not set
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_CS5535 is not set
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
CONFIG_MFD_BCM590XX=y
CONFIG_MFD_BD9571MWV=y
CONFIG_MFD_AXP20X=y
CONFIG_MFD_AXP20X_I2C=y
CONFIG_MFD_MADERA=y
# CONFIG_MFD_MADERA_I2C is not set
CONFIG_MFD_MADERA_SPI=y
CONFIG_MFD_CS47L15=y
CONFIG_MFD_CS47L35=y
CONFIG_MFD_CS47L85=y
# CONFIG_MFD_CS47L90 is not set
CONFIG_MFD_CS47L92=y
CONFIG_PMIC_DA903X=y
CONFIG_PMIC_DA9052=y
# CONFIG_MFD_DA9052_SPI is not set
CONFIG_MFD_DA9052_I2C=y
CONFIG_MFD_DA9055=y
CONFIG_MFD_DA9062=y
CONFIG_MFD_DA9063=y
CONFIG_MFD_DA9150=y
CONFIG_MFD_DLN2=y
CONFIG_MFD_MC13XXX=y
CONFIG_MFD_MC13XXX_SPI=y
# CONFIG_MFD_MC13XXX_I2C is not set
CONFIG_MFD_MP2629=y
CONFIG_HTC_PASIC3=y
CONFIG_HTC_I2CPLD=y
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=y
CONFIG_LPC_SCH=y
# CONFIG_INTEL_SOC_PMIC_BXTWC is not set
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
# CONFIG_INTEL_SOC_PMIC_MRFLD is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
CONFIG_MFD_INTEL_PMC_BXT=y
CONFIG_MFD_INTEL_PMT=y
CONFIG_MFD_IQS62X=y
CONFIG_MFD_JANZ_CMODIO=y
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=y
CONFIG_MFD_88PM805=y
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77693=y
CONFIG_MFD_MAX77843=y
CONFIG_MFD_MAX8907=y
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=y
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=y
CONFIG_MFD_RETU=y
CONFIG_MFD_PCF50633=y
# CONFIG_PCF50633_ADC is not set
CONFIG_PCF50633_GPIO=y
CONFIG_MFD_RDC321X=y
CONFIG_MFD_RT4831=y
CONFIG_MFD_RT5033=y
CONFIG_MFD_RC5T583=y
CONFIG_MFD_SI476X_CORE=y
CONFIG_MFD_SM501=y
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
CONFIG_MFD_LP3943=y
# CONFIG_MFD_LP8788 is not set
CONFIG_MFD_TI_LMU=y
CONFIG_MFD_PALMAS=y
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
CONFIG_TPS6507X=y
CONFIG_MFD_TPS65086=y
# CONFIG_MFD_TPS65090 is not set
CONFIG_MFD_TI_LP873X=y
CONFIG_MFD_TPS6586X=y
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
CONFIG_MFD_WL1273_CORE=y
CONFIG_MFD_LM3533=y
CONFIG_MFD_TIMBERDALE=y
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=y
CONFIG_MFD_ARIZONA=y
CONFIG_MFD_ARIZONA_I2C=y
CONFIG_MFD_ARIZONA_SPI=y
# CONFIG_MFD_CS47L24 is not set
# CONFIG_MFD_WM5102 is not set
# CONFIG_MFD_WM5110 is not set
CONFIG_MFD_WM8997=y
CONFIG_MFD_WM8998=y
CONFIG_MFD_WM8400=y
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
CONFIG_MFD_WCD934X=y
CONFIG_MFD_ATC260X=y
CONFIG_MFD_ATC260X_I2C=y
CONFIG_MFD_INTEL_M10_BMC=y
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
CONFIG_REGULATOR_88PG86X=y
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_ACT8865=y
CONFIG_REGULATOR_AD5398=y
CONFIG_REGULATOR_ARIZONA_LDO1=y
CONFIG_REGULATOR_ARIZONA_MICSUPP=y
CONFIG_REGULATOR_ATC260X=y
# CONFIG_REGULATOR_AXP20X is not set
# CONFIG_REGULATOR_BCM590XX is not set
CONFIG_REGULATOR_BD9571MWV=y
CONFIG_REGULATOR_DA903X=y
CONFIG_REGULATOR_DA9052=y
CONFIG_REGULATOR_DA9055=y
# CONFIG_REGULATOR_DA9062 is not set
CONFIG_REGULATOR_DA9210=y
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=y
CONFIG_REGULATOR_GPIO=y
CONFIG_REGULATOR_ISL9305=y
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LM363X is not set
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_LTC3676=y
# CONFIG_REGULATOR_MAX14577 is not set
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX8649=y
CONFIG_REGULATOR_MAX8660=y
CONFIG_REGULATOR_MAX8893=y
# CONFIG_REGULATOR_MAX8907 is not set
CONFIG_REGULATOR_MAX8952=y
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77826=y
CONFIG_REGULATOR_MC13XXX_CORE=y
CONFIG_REGULATOR_MC13783=y
CONFIG_REGULATOR_MC13892=y
CONFIG_REGULATOR_MP8859=y
CONFIG_REGULATOR_MT6311=y
CONFIG_REGULATOR_MT6315=y
# CONFIG_REGULATOR_MT6323 is not set
CONFIG_REGULATOR_MT6358=y
CONFIG_REGULATOR_MT6359=y
# CONFIG_REGULATOR_MT6397 is not set
# CONFIG_REGULATOR_PALMAS is not set
CONFIG_REGULATOR_PCA9450=y
# CONFIG_REGULATOR_PCF50633 is not set
CONFIG_REGULATOR_PV88060=y
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=y
CONFIG_REGULATOR_PWM=y
CONFIG_REGULATOR_QCOM_SPMI=y
CONFIG_REGULATOR_QCOM_USB_VBUS=y
CONFIG_REGULATOR_RASPBERRYPI_TOUCHSCREEN_ATTINY=y
# CONFIG_REGULATOR_RC5T583 is not set
CONFIG_REGULATOR_RT4801=y
# CONFIG_REGULATOR_RT4831 is not set
# CONFIG_REGULATOR_RT5033 is not set
CONFIG_REGULATOR_RT6160=y
# CONFIG_REGULATOR_RT6245 is not set
# CONFIG_REGULATOR_RTQ2134 is not set
CONFIG_REGULATOR_RTMV20=y
CONFIG_REGULATOR_RTQ6752=y
# CONFIG_REGULATOR_SLG51000 is not set
CONFIG_REGULATOR_TPS51632=y
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65086=y
# CONFIG_REGULATOR_TPS65132 is not set
# CONFIG_REGULATOR_TPS6524X is not set
CONFIG_REGULATOR_TPS6586X=y
# CONFIG_REGULATOR_WM8400 is not set
CONFIG_REGULATOR_QCOM_LABIBB=y
# CONFIG_RC_CORE is not set
CONFIG_CEC_CORE=y
CONFIG_CEC_NOTIFIER=y

#
# CEC support
#
CONFIG_MEDIA_CEC_SUPPORT=y
CONFIG_CEC_CH7322=y
# CONFIG_CEC_GPIO is not set
CONFIG_CEC_SECO=y
# CONFIG_USB_PULSE8_CEC is not set
CONFIG_USB_RAINSHADOW_CEC=y
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_SUPPORT_FILTER=y
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

CONFIG_VIDEO_DEV=y
CONFIG_MEDIA_CONTROLLER=y

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
# CONFIG_VIDEO_ADV_DEBUG is not set
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_VIDEO_TUNER=y
CONFIG_V4L2_FLASH_LED_CLASS=y
CONFIG_V4L2_FWNODE=y
CONFIG_V4L2_ASYNC=y
CONFIG_VIDEOBUF_GEN=y
CONFIG_VIDEOBUF_DMA_SG=y
CONFIG_VIDEOBUF_VMALLOC=y
# end of Video4Linux options

#
# Media controller options
#
# end of Media controller options

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
# CONFIG_USB_VIDEO_CLASS is not set
# CONFIG_USB_GSPCA is not set
CONFIG_USB_PWC=y
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
CONFIG_VIDEO_CPIA2=y
CONFIG_USB_ZR364XX=y
CONFIG_USB_STKWEBCAM=y
CONFIG_USB_S2255=y
CONFIG_VIDEO_USBTV=y

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=y
# CONFIG_VIDEO_PVRUSB2_SYSFS is not set
# CONFIG_VIDEO_HDPVR is not set
# CONFIG_VIDEO_STK1160_COMMON is not set
CONFIG_VIDEO_GO7007=y
# CONFIG_VIDEO_GO7007_USB is not set
CONFIG_VIDEO_GO7007_LOADER=y

#
# Analog/digital TV USB devices
#
# CONFIG_VIDEO_CX231XX is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=y
# CONFIG_VIDEO_EM28XX_V4L2 is not set
# CONFIG_VIDEO_EM28XX_ALSA is not set

#
# Software defined radio USB devices
#
# CONFIG_USB_AIRSPY is not set
# CONFIG_USB_HACKRF is not set
# CONFIG_USB_MSI2500 is not set
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_SOLO6X10 is not set
CONFIG_VIDEO_TW5864=y
# CONFIG_VIDEO_TW68 is not set
CONFIG_VIDEO_TW686X=y

#
# Media capture/analog TV support
#
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
CONFIG_VIDEO_HEXIUM_ORION=y
CONFIG_VIDEO_MXB=y
CONFIG_VIDEO_DT3155=y

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX25821=y
# CONFIG_VIDEO_CX25821_ALSA is not set
CONFIG_VIDEO_SAA7134=y
# CONFIG_VIDEO_SAA7134_ALSA is not set
CONFIG_VIDEO_SAA7134_GO7007=y
CONFIG_VIDEO_IPU3_CIO2=y
# CONFIG_CIO2_BRIDGE is not set
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=y
# CONFIG_RADIO_SI470X is not set
CONFIG_RADIO_SI4713=y
CONFIG_USB_SI4713=y
CONFIG_PLATFORM_SI4713=y
CONFIG_I2C_SI4713=y
CONFIG_RADIO_SI476X=y
CONFIG_USB_MR800=y
# CONFIG_USB_DSBR is not set
CONFIG_RADIO_MAXIRADIO=y
CONFIG_RADIO_SHARK=y
CONFIG_RADIO_SHARK2=y
CONFIG_USB_KEENE=y
CONFIG_USB_RAREMONO=y
# CONFIG_USB_MA901 is not set
CONFIG_RADIO_TEA5764=y
# CONFIG_RADIO_TEA5764_XTAL is not set
CONFIG_RADIO_SAA7706H=y
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_TIMBERDALE is not set
CONFIG_RADIO_WL1273=y
CONFIG_V4L_RADIO_ISA_DRIVERS=y
CONFIG_RADIO_ISA=y
CONFIG_RADIO_CADET=y
CONFIG_RADIO_RTRACK=y
CONFIG_RADIO_RTRACK_PORT=30f
CONFIG_RADIO_RTRACK2=y
CONFIG_RADIO_RTRACK2_PORT=30c
# CONFIG_RADIO_AZTECH is not set
CONFIG_RADIO_GEMTEK=y
CONFIG_RADIO_GEMTEK_PORT=34c
CONFIG_RADIO_GEMTEK_PROBE=y
# CONFIG_RADIO_MIROPCM20 is not set
CONFIG_RADIO_SF16FMI=y
# CONFIG_RADIO_SF16FMR2 is not set
# CONFIG_RADIO_TERRATEC is not set
CONFIG_RADIO_TRUST=y
CONFIG_RADIO_TRUST_PORT=350
# CONFIG_RADIO_TYPHOON is not set
CONFIG_RADIO_ZOLTRIX=y
CONFIG_RADIO_ZOLTRIX_PORT=20c
CONFIG_VIDEO_CX2341X=y
CONFIG_VIDEO_TVEEPROM=y
CONFIG_CYPRESS_FIRMWARE=y
CONFIG_VIDEOBUF2_CORE=y
CONFIG_VIDEOBUF2_V4L2=y
CONFIG_VIDEOBUF2_MEMOPS=y
CONFIG_VIDEOBUF2_DMA_CONTIG=y
CONFIG_VIDEOBUF2_VMALLOC=y
CONFIG_VIDEOBUF2_DMA_SG=y
CONFIG_VIDEO_SAA7146=y
CONFIG_VIDEO_SAA7146_VV=y
CONFIG_VIDEO_V4L2_TPG=y
CONFIG_V4L_PLATFORM_DRIVERS=y
CONFIG_VIDEO_CAFE_CCIC=y
# CONFIG_VIDEO_CADENCE is not set
CONFIG_VIDEO_ASPEED=y
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set
CONFIG_V4L_TEST_DRIVERS=y
CONFIG_VIDEO_VIMC=y
# CONFIG_VIDEO_VIM2M is not set
# CONFIG_VIDEO_VICODEC is not set
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=y
CONFIG_VIDEO_TDA7432=y
CONFIG_VIDEO_TDA9840=y
CONFIG_VIDEO_TDA1997X=y
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=y
CONFIG_VIDEO_CS3308=y
CONFIG_VIDEO_CS5345=y
CONFIG_VIDEO_CS53L32A=y
CONFIG_VIDEO_TLV320AIC23B=y
CONFIG_VIDEO_UDA1342=y
CONFIG_VIDEO_WM8775=y
CONFIG_VIDEO_WM8739=y
# CONFIG_VIDEO_VP27SMPX is not set
CONFIG_VIDEO_SONY_BTF_MPX=y
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=y
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=y
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
CONFIG_VIDEO_BT819=y
CONFIG_VIDEO_BT856=y
CONFIG_VIDEO_BT866=y
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
CONFIG_VIDEO_SAA7110=y
CONFIG_VIDEO_SAA711X=y
CONFIG_VIDEO_TC358743=y
CONFIG_VIDEO_TC358743_CEC=y
CONFIG_VIDEO_TVP514X=y
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
CONFIG_VIDEO_TW2804=y
CONFIG_VIDEO_TW9903=y
CONFIG_VIDEO_TW9906=y
CONFIG_VIDEO_TW9910=y
CONFIG_VIDEO_VPX3220=y

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=y
CONFIG_VIDEO_CX25840=y
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_SAA7127 is not set
CONFIG_VIDEO_SAA7185=y
CONFIG_VIDEO_ADV7170=y
# CONFIG_VIDEO_ADV7175 is not set
CONFIG_VIDEO_ADV7343=y
CONFIG_VIDEO_ADV7393=y
# CONFIG_VIDEO_ADV7511 is not set
CONFIG_VIDEO_AD9389B=y
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
# CONFIG_VIDEO_UPD64031A is not set
CONFIG_VIDEO_UPD64083=y
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=y
# end of Audio/Video compression chips

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=y
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
CONFIG_VIDEO_M52790=y
CONFIG_VIDEO_I2C=y
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=y
CONFIG_VIDEO_CCS_PLL=y
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_HI846 is not set
CONFIG_VIDEO_IMX208=y
# CONFIG_VIDEO_IMX214 is not set
CONFIG_VIDEO_IMX219=y
CONFIG_VIDEO_IMX258=y
# CONFIG_VIDEO_IMX274 is not set
CONFIG_VIDEO_IMX290=y
CONFIG_VIDEO_IMX319=y
# CONFIG_VIDEO_IMX355 is not set
CONFIG_VIDEO_OV02A10=y
# CONFIG_VIDEO_OV2640 is not set
CONFIG_VIDEO_OV2659=y
CONFIG_VIDEO_OV2680=y
CONFIG_VIDEO_OV2685=y
CONFIG_VIDEO_OV2740=y
# CONFIG_VIDEO_OV5647 is not set
CONFIG_VIDEO_OV5648=y
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
CONFIG_VIDEO_OV5675=y
CONFIG_VIDEO_OV5695=y
CONFIG_VIDEO_OV7251=y
CONFIG_VIDEO_OV772X=y
# CONFIG_VIDEO_OV7640 is not set
CONFIG_VIDEO_OV7670=y
CONFIG_VIDEO_OV7740=y
# CONFIG_VIDEO_OV8856 is not set
CONFIG_VIDEO_OV8865=y
CONFIG_VIDEO_OV9640=y
CONFIG_VIDEO_OV9650=y
# CONFIG_VIDEO_OV9734 is not set
CONFIG_VIDEO_OV13858=y
# CONFIG_VIDEO_OV13B10 is not set
# CONFIG_VIDEO_VS6624 is not set
CONFIG_VIDEO_MT9M001=y
CONFIG_VIDEO_MT9M032=y
CONFIG_VIDEO_MT9M111=y
CONFIG_VIDEO_MT9P031=y
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
CONFIG_VIDEO_MT9V011=y
CONFIG_VIDEO_MT9V032=y
CONFIG_VIDEO_MT9V111=y
CONFIG_VIDEO_SR030PC30=y
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
CONFIG_VIDEO_MAX9271_LIB=y
CONFIG_VIDEO_RDACM20=y
CONFIG_VIDEO_RDACM21=y
# CONFIG_VIDEO_RJ54N1 is not set
CONFIG_VIDEO_S5K6AA=y
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
CONFIG_VIDEO_S5K5BAF=y
CONFIG_VIDEO_CCS=y
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=y
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
CONFIG_VIDEO_DW9807_VCM=y
# end of Lens drivers

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=y
# CONFIG_VIDEO_LM3560 is not set
CONFIG_VIDEO_LM3646=y
# end of Flash devices

#
# SPI helper chips
#
CONFIG_VIDEO_GS1662=y
# end of SPI helper chips

#
# Media SPI Adapters
#
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=y

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=y
CONFIG_MEDIA_TUNER_TDA18250=y
CONFIG_MEDIA_TUNER_TDA8290=y
CONFIG_MEDIA_TUNER_TDA827X=y
CONFIG_MEDIA_TUNER_TDA18271=y
CONFIG_MEDIA_TUNER_TDA9887=y
CONFIG_MEDIA_TUNER_TEA5761=y
# CONFIG_MEDIA_TUNER_TEA5767 is not set
CONFIG_MEDIA_TUNER_MSI001=y
CONFIG_MEDIA_TUNER_MT20XX=y
# CONFIG_MEDIA_TUNER_MT2060 is not set
CONFIG_MEDIA_TUNER_MT2063=y
CONFIG_MEDIA_TUNER_MT2266=y
CONFIG_MEDIA_TUNER_MT2131=y
# CONFIG_MEDIA_TUNER_QT1010 is not set
# CONFIG_MEDIA_TUNER_XC2028 is not set
CONFIG_MEDIA_TUNER_XC5000=y
# CONFIG_MEDIA_TUNER_XC4000 is not set
CONFIG_MEDIA_TUNER_MXL5005S=y
CONFIG_MEDIA_TUNER_MXL5007T=y
# CONFIG_MEDIA_TUNER_MC44S803 is not set
CONFIG_MEDIA_TUNER_MAX2165=y
CONFIG_MEDIA_TUNER_TDA18218=y
CONFIG_MEDIA_TUNER_FC0011=y
CONFIG_MEDIA_TUNER_FC0012=y
CONFIG_MEDIA_TUNER_FC0013=y
# CONFIG_MEDIA_TUNER_TDA18212 is not set
CONFIG_MEDIA_TUNER_E4000=y
# CONFIG_MEDIA_TUNER_FC2580 is not set
# CONFIG_MEDIA_TUNER_M88RS6000T is not set
# CONFIG_MEDIA_TUNER_TUA9001 is not set
CONFIG_MEDIA_TUNER_SI2157=y
CONFIG_MEDIA_TUNER_IT913X=y
# CONFIG_MEDIA_TUNER_R820T is not set
# CONFIG_MEDIA_TUNER_MXL301RF is not set
# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
# end of Customize TV tuners

#
# Tools to develop new frontends
#
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_AGP=y
# CONFIG_AGP_ALI is not set
CONFIG_AGP_ATI=y
CONFIG_AGP_AMD=y
# CONFIG_AGP_AMD64 is not set
CONFIG_AGP_INTEL=y
CONFIG_AGP_NVIDIA=y
CONFIG_AGP_SIS=y
CONFIG_AGP_SWORKS=y
# CONFIG_AGP_VIA is not set
# CONFIG_AGP_EFFICEON is not set
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DBI=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=y
CONFIG_DRM_VRAM_HELPER=y
CONFIG_DRM_TTM_HELPER=y
CONFIG_DRM_GEM_CMA_HELPER=y
CONFIG_DRM_KMS_CMA_HELPER=y
CONFIG_DRM_GEM_SHMEM_HELPER=y
CONFIG_DRM_SCHED=y

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_CH7006 is not set
CONFIG_DRM_I2C_SIL164=y
# CONFIG_DRM_I2C_NXP_TDA998X is not set
CONFIG_DRM_I2C_NXP_TDA9950=y
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=y
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_REQUEST_TIMEOUT=20000
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
CONFIG_DRM_VGEM=y
CONFIG_DRM_VKMS=y
# CONFIG_DRM_VMWGFX is not set
# CONFIG_DRM_GMA500 is not set
CONFIG_DRM_UDL=y
CONFIG_DRM_AST=y
# CONFIG_DRM_MGAG200 is not set
CONFIG_DRM_QXL=y
CONFIG_DRM_VIRTIO_GPU=y
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=y
CONFIG_DRM_PANEL_WIDECHIPS_WS2401=y
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_ANALOGIX_ANX78XX=y
CONFIG_DRM_ANALOGIX_DP=y
# end of Display Interface Bridges

CONFIG_DRM_ETNAVIV=y
CONFIG_DRM_ETNAVIV_THERMAL=y
CONFIG_DRM_BOCHS=y
# CONFIG_DRM_CIRRUS_QEMU is not set
CONFIG_DRM_GM12U320=y
CONFIG_DRM_SIMPLEDRM=y
# CONFIG_TINYDRM_HX8357D is not set
CONFIG_TINYDRM_ILI9225=y
CONFIG_TINYDRM_ILI9341=y
CONFIG_TINYDRM_ILI9486=y
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
CONFIG_TINYDRM_ST7586=y
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_VBOXVIDEO is not set
CONFIG_DRM_GUD=y
CONFIG_DRM_LEGACY=y
CONFIG_DRM_TDFX=y
# CONFIG_DRM_R128 is not set
CONFIG_DRM_MGA=y
CONFIG_DRM_SIS=y
CONFIG_DRM_VIA=y
# CONFIG_DRM_SAVAGE is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
# CONFIG_FB is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_L4F00242T03=y
CONFIG_LCD_LMS283GF05=y
# CONFIG_LCD_LTV350QV is not set
CONFIG_LCD_ILI922X=y
CONFIG_LCD_ILI9320=y
CONFIG_LCD_TDO24M=y
CONFIG_LCD_VGG2432A4=y
# CONFIG_LCD_PLATFORM is not set
CONFIG_LCD_AMS369FG06=y
CONFIG_LCD_LMS501KF03=y
CONFIG_LCD_HX8357=y
CONFIG_LCD_OTM3225A=y
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
# CONFIG_BACKLIGHT_LM3533 is not set
CONFIG_BACKLIGHT_PWM=y
# CONFIG_BACKLIGHT_DA903X is not set
# CONFIG_BACKLIGHT_DA9052 is not set
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=y
# CONFIG_BACKLIGHT_RT4831 is not set
CONFIG_BACKLIGHT_SAHARA=y
CONFIG_BACKLIGHT_ADP8860=y
CONFIG_BACKLIGHT_ADP8870=y
CONFIG_BACKLIGHT_PCF50633=y
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=y
CONFIG_BACKLIGHT_LP855X=y
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
# end of Console display driver support
# end of Graphics support

CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_SEQ_DEVICE=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_VERBOSE=y
CONFIG_SND_PCM_XRUN_DEBUG=y
CONFIG_SND_CTL_VALIDATION=y
CONFIG_SND_JACK_INJECTION_DEBUG=y
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_CTL_LED=y
CONFIG_SND_SEQUENCER=y
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_SEQ_MIDI_EVENT=y
CONFIG_SND_SEQ_MIDI=y
CONFIG_SND_SEQ_VIRMIDI=y
CONFIG_SND_DRIVERS=y
CONFIG_SND_DUMMY=y
CONFIG_SND_ALOOP=y
CONFIG_SND_VIRMIDI=y
# CONFIG_SND_MTPAV is not set
CONFIG_SND_MTS64=y
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set
# CONFIG_SND_PORTMAN2X4 is not set
# CONFIG_SND_ISA is not set
# CONFIG_SND_PCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=y
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
# CONFIG_SND_HDA_PATCH_LOADER is not set
CONFIG_SND_HDA_CODEC_REALTEK=y
CONFIG_SND_HDA_CODEC_ANALOG=y
CONFIG_SND_HDA_CODEC_SIGMATEL=y
CONFIG_SND_HDA_CODEC_VIA=y
# CONFIG_SND_HDA_CODEC_HDMI is not set
CONFIG_SND_HDA_CODEC_CIRRUS=y
# CONFIG_SND_HDA_CODEC_CS8409 is not set
CONFIG_SND_HDA_CODEC_CONEXANT=y
CONFIG_SND_HDA_CODEC_CA0110=y
CONFIG_SND_HDA_CODEC_CA0132=y
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
# CONFIG_SND_HDA_CODEC_CMEDIA is not set
# CONFIG_SND_HDA_CODEC_SI3054 is not set
CONFIG_SND_HDA_GENERIC=y
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=y
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=y
CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=y
CONFIG_SND_INTEL_SOUNDWIRE_ACPI=y
# CONFIG_SND_SPI is not set
# CONFIG_SND_USB is not set
# CONFIG_SND_FIREWIRE is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_TOPOLOGY_KUNIT_TEST=y
CONFIG_SND_SOC_ACPI=y
# CONFIG_SND_SOC_ADI is not set
# CONFIG_SND_SOC_AMD_ACP is not set
CONFIG_SND_SOC_AMD_ACP3x=y
CONFIG_SND_SOC_AMD_RENOIR=y
CONFIG_SND_SOC_AMD_RENOIR_MACH=y
CONFIG_SND_SOC_AMD_ACP5x=y
# CONFIG_SND_SOC_AMD_VANGOGH_MACH is not set
# CONFIG_SND_SOC_AMD_ACP6x is not set
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set
CONFIG_SND_ATMEL_SOC=y
CONFIG_SND_BCM63XX_I2S_WHISTLER=y
CONFIG_SND_DESIGNWARE_I2S=y
CONFIG_SND_DESIGNWARE_PCM=y

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
CONFIG_SND_SOC_FSL_SAI=y
CONFIG_SND_SOC_FSL_MQS=y
CONFIG_SND_SOC_FSL_AUDMIX=y
CONFIG_SND_SOC_FSL_SSI=y
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
CONFIG_SND_SOC_FSL_MICFIL=y
CONFIG_SND_SOC_FSL_XCVR=y
CONFIG_SND_SOC_FSL_RPMSG=y
CONFIG_SND_SOC_IMX_AUDMUX=y
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=y
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SOC_INTEL_SST=y
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=y
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI=y
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=y
# CONFIG_SND_SOC_INTEL_SKYLAKE is not set
CONFIG_SND_SOC_INTEL_SKL=y
# CONFIG_SND_SOC_INTEL_APL is not set
# CONFIG_SND_SOC_INTEL_KBL is not set
CONFIG_SND_SOC_INTEL_GLK=y
CONFIG_SND_SOC_INTEL_CNL=y
CONFIG_SND_SOC_INTEL_CFL=y
CONFIG_SND_SOC_INTEL_CML_H=y
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=y
CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC=y
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=y
CONFIG_SND_SOC_ACPI_INTEL_MATCH=y
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES=y
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=y
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=y
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=y
# CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH is not set
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=y
CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH=y
# CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=y
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=y
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=y
# CONFIG_SND_SOC_INTEL_SKL_RT286_MACH is not set
# CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH is not set
# CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH is not set
CONFIG_SND_SOC_MTK_BTCVSD=y
CONFIG_SND_SOC_SOF_TOPLEVEL=y
CONFIG_SND_SOC_SOF_PCI=y
CONFIG_SND_SOC_SOF_ACPI=y
# CONFIG_SND_SOC_SOF_DEBUG_PROBES is not set
# CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
CONFIG_SND_SOC_XILINX_SPDIF=y
CONFIG_SND_SOC_XTFPGA_I2S=y
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
CONFIG_SND_SOC_ADAU_UTILS=y
# CONFIG_SND_SOC_ADAU1372_I2C is not set
# CONFIG_SND_SOC_ADAU1372_SPI is not set
CONFIG_SND_SOC_ADAU1701=y
CONFIG_SND_SOC_ADAU17X1=y
CONFIG_SND_SOC_ADAU1761=y
# CONFIG_SND_SOC_ADAU1761_I2C is not set
CONFIG_SND_SOC_ADAU1761_SPI=y
CONFIG_SND_SOC_ADAU7002=y
CONFIG_SND_SOC_ADAU7118=y
CONFIG_SND_SOC_ADAU7118_HW=y
CONFIG_SND_SOC_ADAU7118_I2C=y
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
CONFIG_SND_SOC_AK4458=y
CONFIG_SND_SOC_AK4554=y
# CONFIG_SND_SOC_AK4613 is not set
CONFIG_SND_SOC_AK4642=y
CONFIG_SND_SOC_AK5386=y
CONFIG_SND_SOC_AK5558=y
CONFIG_SND_SOC_ALC5623=y
# CONFIG_SND_SOC_BD28623 is not set
CONFIG_SND_SOC_BT_SCO=y
# CONFIG_SND_SOC_CS35L32 is not set
CONFIG_SND_SOC_CS35L33=y
CONFIG_SND_SOC_CS35L34=y
CONFIG_SND_SOC_CS35L35=y
CONFIG_SND_SOC_CS35L36=y
# CONFIG_SND_SOC_CS35L41_SPI is not set
# CONFIG_SND_SOC_CS35L41_I2C is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
CONFIG_SND_SOC_CS42L52=y
CONFIG_SND_SOC_CS42L56=y
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4234 is not set
CONFIG_SND_SOC_CS4265=y
CONFIG_SND_SOC_CS4270=y
CONFIG_SND_SOC_CS4271=y
# CONFIG_SND_SOC_CS4271_I2C is not set
CONFIG_SND_SOC_CS4271_SPI=y
# CONFIG_SND_SOC_CS42XX8_I2C is not set
CONFIG_SND_SOC_CS43130=y
# CONFIG_SND_SOC_CS4341 is not set
CONFIG_SND_SOC_CS4349=y
CONFIG_SND_SOC_CS53L30=y
CONFIG_SND_SOC_CX2072X=y
CONFIG_SND_SOC_DA7213=y
CONFIG_SND_SOC_DMIC=y
CONFIG_SND_SOC_ES7134=y
CONFIG_SND_SOC_ES7241=y
CONFIG_SND_SOC_ES8316=y
CONFIG_SND_SOC_ES8328=y
CONFIG_SND_SOC_ES8328_I2C=y
CONFIG_SND_SOC_ES8328_SPI=y
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDA=y
CONFIG_SND_SOC_ICS43432=y
CONFIG_SND_SOC_INNO_RK3036=y
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=y
# CONFIG_SND_SOC_MAX98357A is not set
# CONFIG_SND_SOC_MAX98504 is not set
CONFIG_SND_SOC_MAX9867=y
CONFIG_SND_SOC_MAX98927=y
# CONFIG_SND_SOC_MAX98520 is not set
CONFIG_SND_SOC_MAX98373=y
CONFIG_SND_SOC_MAX98373_I2C=y
CONFIG_SND_SOC_MAX98390=y
CONFIG_SND_SOC_MAX9860=y
# CONFIG_SND_SOC_MSM8916_WCD_ANALOG is not set
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=y
CONFIG_SND_SOC_PCM1681=y
# CONFIG_SND_SOC_PCM1789_I2C is not set
CONFIG_SND_SOC_PCM179X=y
CONFIG_SND_SOC_PCM179X_I2C=y
CONFIG_SND_SOC_PCM179X_SPI=y
CONFIG_SND_SOC_PCM186X=y
CONFIG_SND_SOC_PCM186X_I2C=y
CONFIG_SND_SOC_PCM186X_SPI=y
CONFIG_SND_SOC_PCM3060=y
# CONFIG_SND_SOC_PCM3060_I2C is not set
CONFIG_SND_SOC_PCM3060_SPI=y
CONFIG_SND_SOC_PCM3168A=y
# CONFIG_SND_SOC_PCM3168A_I2C is not set
CONFIG_SND_SOC_PCM3168A_SPI=y
CONFIG_SND_SOC_PCM5102A=y
CONFIG_SND_SOC_PCM512x=y
# CONFIG_SND_SOC_PCM512x_I2C is not set
CONFIG_SND_SOC_PCM512x_SPI=y
CONFIG_SND_SOC_RK3328=y
CONFIG_SND_SOC_RL6231=y
CONFIG_SND_SOC_RT5616=y
CONFIG_SND_SOC_RT5631=y
CONFIG_SND_SOC_RT5640=y
CONFIG_SND_SOC_RT5651=y
CONFIG_SND_SOC_RT5659=y
CONFIG_SND_SOC_RT5670=y
# CONFIG_SND_SOC_RT9120 is not set
# CONFIG_SND_SOC_SGTL5000 is not set
CONFIG_SND_SOC_SI476X=y
CONFIG_SND_SOC_SIGMADSP=y
CONFIG_SND_SOC_SIGMADSP_I2C=y
CONFIG_SND_SOC_SIGMADSP_REGMAP=y
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
CONFIG_SND_SOC_SIMPLE_MUX=y
CONFIG_SND_SOC_SPDIF=y
# CONFIG_SND_SOC_SSM2305 is not set
CONFIG_SND_SOC_SSM2518=y
CONFIG_SND_SOC_SSM2602=y
# CONFIG_SND_SOC_SSM2602_SPI is not set
CONFIG_SND_SOC_SSM2602_I2C=y
CONFIG_SND_SOC_SSM4567=y
CONFIG_SND_SOC_STA32X=y
CONFIG_SND_SOC_STA350=y
CONFIG_SND_SOC_STI_SAS=y
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2764 is not set
CONFIG_SND_SOC_TAS2770=y
CONFIG_SND_SOC_TAS5086=y
CONFIG_SND_SOC_TAS571X=y
CONFIG_SND_SOC_TAS5720=y
CONFIG_SND_SOC_TAS6424=y
CONFIG_SND_SOC_TDA7419=y
CONFIG_SND_SOC_TFA9879=y
CONFIG_SND_SOC_TFA989X=y
CONFIG_SND_SOC_TLV320AIC23=y
CONFIG_SND_SOC_TLV320AIC23_I2C=y
CONFIG_SND_SOC_TLV320AIC23_SPI=y
# CONFIG_SND_SOC_TLV320AIC31XX is not set
CONFIG_SND_SOC_TLV320AIC32X4=y
CONFIG_SND_SOC_TLV320AIC32X4_I2C=y
CONFIG_SND_SOC_TLV320AIC32X4_SPI=y
CONFIG_SND_SOC_TLV320AIC3X=y
CONFIG_SND_SOC_TLV320AIC3X_I2C=y
CONFIG_SND_SOC_TLV320AIC3X_SPI=y
CONFIG_SND_SOC_TLV320ADCX140=y
CONFIG_SND_SOC_TS3A227E=y
CONFIG_SND_SOC_TSCS42XX=y
# CONFIG_SND_SOC_TSCS454 is not set
CONFIG_SND_SOC_UDA1334=y
CONFIG_SND_SOC_WCD9335=y
CONFIG_SND_SOC_WCD_MBHC=y
CONFIG_SND_SOC_WCD934X=y
CONFIG_SND_SOC_WM8510=y
CONFIG_SND_SOC_WM8523=y
CONFIG_SND_SOC_WM8524=y
CONFIG_SND_SOC_WM8580=y
# CONFIG_SND_SOC_WM8711 is not set
CONFIG_SND_SOC_WM8728=y
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
CONFIG_SND_SOC_WM8741=y
# CONFIG_SND_SOC_WM8750 is not set
CONFIG_SND_SOC_WM8753=y
CONFIG_SND_SOC_WM8770=y
# CONFIG_SND_SOC_WM8776 is not set
CONFIG_SND_SOC_WM8782=y
CONFIG_SND_SOC_WM8804=y
# CONFIG_SND_SOC_WM8804_I2C is not set
CONFIG_SND_SOC_WM8804_SPI=y
CONFIG_SND_SOC_WM8903=y
CONFIG_SND_SOC_WM8904=y
CONFIG_SND_SOC_WM8960=y
CONFIG_SND_SOC_WM8962=y
CONFIG_SND_SOC_WM8974=y
# CONFIG_SND_SOC_WM8978 is not set
CONFIG_SND_SOC_WM8985=y
CONFIG_SND_SOC_ZL38060=y
CONFIG_SND_SOC_MAX9759=y
# CONFIG_SND_SOC_MT6351 is not set
CONFIG_SND_SOC_MT6358=y
# CONFIG_SND_SOC_MT6660 is not set
CONFIG_SND_SOC_NAU8315=y
CONFIG_SND_SOC_NAU8540=y
CONFIG_SND_SOC_NAU8810=y
# CONFIG_SND_SOC_NAU8821 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=y
CONFIG_SND_SOC_TPA6130A2=y
# CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
CONFIG_SND_SOC_LPASS_VA_MACRO=y
CONFIG_SND_SOC_LPASS_RX_MACRO=y
CONFIG_SND_SOC_LPASS_TX_MACRO=y
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
# CONFIG_SND_X86 is not set
# CONFIG_SND_VIRTIO is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
CONFIG_HID_ACRUX=y
CONFIG_HID_ACRUX_FF=y
# CONFIG_HID_APPLE is not set
CONFIG_HID_AUREAL=y
CONFIG_HID_BELKIN=y
CONFIG_HID_CHERRY=y
# CONFIG_HID_COUGAR is not set
CONFIG_HID_MACALLY=y
# CONFIG_HID_CMEDIA is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=y
CONFIG_DRAGONRISE_FF=y
CONFIG_HID_EMS_FF=y
# CONFIG_HID_ELECOM is not set
CONFIG_HID_EZKEY=y
CONFIG_HID_GEMBIRD=y
CONFIG_HID_GFRM=y
CONFIG_HID_GLORIOUS=y
CONFIG_HID_VIVALDI=y
CONFIG_HID_KEYTOUCH=y
CONFIG_HID_KYE=y
CONFIG_HID_WALTOP=y
CONFIG_HID_VIEWSONIC=y
# CONFIG_HID_XIAOMI is not set
CONFIG_HID_GYRATION=y
# CONFIG_HID_ICADE is not set
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=y
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=y
CONFIG_HID_LED=y
CONFIG_HID_LENOVO=y
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MALTRON=y
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=y
# CONFIG_HID_NINTENDO is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=y
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=y
CONFIG_HID_PICOLCD=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=y
CONFIG_HID_SAITEK=y
CONFIG_HID_SEMITEK=y
# CONFIG_HID_SPEEDLINK is not set
CONFIG_HID_STEAM=y
CONFIG_HID_STEELSERIES=y
# CONFIG_HID_SUNPLUS is not set
CONFIG_HID_RMI=y
CONFIG_HID_GREENASIA=y
CONFIG_GREENASIA_FF=y
# CONFIG_HID_SMARTJOYPLUS is not set
CONFIG_HID_TIVO=y
CONFIG_HID_TOPSEED=y
# CONFIG_HID_THINGM is not set
# CONFIG_HID_UDRAW_PS3 is not set
CONFIG_HID_WIIMOTE=y
CONFIG_HID_XINMO=y
CONFIG_HID_ZEROPLUS=y
CONFIG_ZEROPLUS_FF=y
# CONFIG_HID_ZYDACRON is not set
CONFIG_HID_SENSOR_HUB=y
CONFIG_HID_SENSOR_CUSTOM_SENSOR=y
CONFIG_HID_ALPS=y
# end of Special HID drivers

#
# USB HID support
#
# CONFIG_USB_HID is not set
# CONFIG_HID_PID is not set
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID_ACPI=y
# end of I2C HID support

CONFIG_I2C_HID_CORE=y
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
CONFIG_USB_ULPI_BUS=y
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
CONFIG_USB_FEW_INIT_RETRIES=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=y
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_DBGCAP=y
CONFIG_USB_XHCI_PCI=y
CONFIG_USB_XHCI_PCI_RENESAS=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
# CONFIG_USB_EHCI_TT_NEWSCHED is not set
CONFIG_USB_EHCI_PCI=y
CONFIG_USB_EHCI_FSL=y
CONFIG_USB_EHCI_HCD_PLATFORM=y
CONFIG_USB_OXU210HP_HCD=y
# CONFIG_USB_ISP116X_HCD is not set
CONFIG_USB_FOTG210_HCD=y
CONFIG_USB_MAX3421_HCD=y
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_SSB is not set
CONFIG_USB_OHCI_HCD_PLATFORM=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_U132_HCD=y
CONFIG_USB_SL811_HCD=y
CONFIG_USB_SL811_HCD_ISO=y
CONFIG_USB_R8A66597_HCD=y
CONFIG_USB_HCD_BCMA=y
CONFIG_USB_HCD_SSB=y
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=y
# CONFIG_USB_PRINTER is not set
CONFIG_USB_WDM=y
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_REALTEK=y
# CONFIG_REALTEK_AUTOPM is not set
CONFIG_USB_STORAGE_DATAFAB=y
# CONFIG_USB_STORAGE_FREECOM is not set
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_USBAT=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
# CONFIG_USB_STORAGE_ALAUDA is not set
CONFIG_USB_STORAGE_ONETOUCH=y
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
CONFIG_USB_UAS=y

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
CONFIG_USB_CDNS_SUPPORT=y
CONFIG_USB_CDNS3=y
# CONFIG_USB_CDNS3_GADGET is not set
# CONFIG_USB_CDNS3_HOST is not set
# CONFIG_USB_CDNS3_PCI_WRAP is not set
CONFIG_USB_CDNSP_PCI=y
CONFIG_USB_CDNSP_GADGET=y
# CONFIG_USB_CDNSP_HOST is not set
CONFIG_USB_MUSB_HDRC=y
# CONFIG_USB_MUSB_HOST is not set
CONFIG_USB_MUSB_GADGET=y
# CONFIG_USB_MUSB_DUAL_ROLE is not set

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
CONFIG_MUSB_PIO_ONLY=y
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
CONFIG_USB_ISP1760=y
CONFIG_USB_ISP1761_UDC=y
# CONFIG_USB_ISP1760_HOST_ROLE is not set
CONFIG_USB_ISP1760_GADGET_ROLE=y
# CONFIG_USB_ISP1760_DUAL_ROLE is not set

#
# USB port drivers
#
CONFIG_USB_USS720=y
CONFIG_USB_SERIAL=y
# CONFIG_USB_SERIAL_CONSOLE is not set
# CONFIG_USB_SERIAL_GENERIC is not set
# CONFIG_USB_SERIAL_SIMPLE is not set
# CONFIG_USB_SERIAL_AIRCABLE is not set
CONFIG_USB_SERIAL_ARK3116=y
CONFIG_USB_SERIAL_BELKIN=y
# CONFIG_USB_SERIAL_CH341 is not set
CONFIG_USB_SERIAL_WHITEHEAT=y
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=y
# CONFIG_USB_SERIAL_CP210X is not set
# CONFIG_USB_SERIAL_CYPRESS_M8 is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
CONFIG_USB_SERIAL_IPAQ=y
# CONFIG_USB_SERIAL_IR is not set
CONFIG_USB_SERIAL_EDGEPORT=y
# CONFIG_USB_SERIAL_EDGEPORT_TI is not set
CONFIG_USB_SERIAL_F81232=y
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=y
# CONFIG_USB_SERIAL_IPW is not set
# CONFIG_USB_SERIAL_IUU is not set
CONFIG_USB_SERIAL_KEYSPAN_PDA=y
# CONFIG_USB_SERIAL_KEYSPAN is not set
CONFIG_USB_SERIAL_KLSI=y
CONFIG_USB_SERIAL_KOBIL_SCT=y
CONFIG_USB_SERIAL_MCT_U232=y
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=y
# CONFIG_USB_SERIAL_MOS7715_PARPORT is not set
# CONFIG_USB_SERIAL_MOS7840 is not set
CONFIG_USB_SERIAL_MXUPORT=y
CONFIG_USB_SERIAL_NAVMAN=y
CONFIG_USB_SERIAL_PL2303=y
# CONFIG_USB_SERIAL_OTI6858 is not set
CONFIG_USB_SERIAL_QCAUX=y
CONFIG_USB_SERIAL_QUALCOMM=y
CONFIG_USB_SERIAL_SPCP8X5=y
CONFIG_USB_SERIAL_SAFE=y
CONFIG_USB_SERIAL_SAFE_PADDED=y
# CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
CONFIG_USB_SERIAL_SYMBOL=y
# CONFIG_USB_SERIAL_TI is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
CONFIG_USB_SERIAL_WWAN=y
# CONFIG_USB_SERIAL_OPTION is not set
CONFIG_USB_SERIAL_OMNINET=y
# CONFIG_USB_SERIAL_OPTICON is not set
# CONFIG_USB_SERIAL_XSENS_MT is not set
# CONFIG_USB_SERIAL_WISHBONE is not set
# CONFIG_USB_SERIAL_SSU100 is not set
# CONFIG_USB_SERIAL_QT2 is not set
CONFIG_USB_SERIAL_UPD78F0730=y
CONFIG_USB_SERIAL_XR=y
# CONFIG_USB_SERIAL_DEBUG is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
CONFIG_USB_EMI26=y
CONFIG_USB_ADUTUX=y
CONFIG_USB_SEVSEG=y
CONFIG_USB_LEGOTOWER=y
CONFIG_USB_LCD=y
CONFIG_USB_CYPRESS_CY7C63=y
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=y
CONFIG_USB_FTDI_ELAN=y
CONFIG_USB_APPLEDISPLAY=y
CONFIG_APPLE_MFI_FASTCHARGE=y
CONFIG_USB_SISUSBVGA=y
CONFIG_USB_LD=y
CONFIG_USB_TRANCEVIBRATOR=y
CONFIG_USB_IOWARRIOR=y
CONFIG_USB_TEST=y
CONFIG_USB_EHSET_TEST_FIXTURE=y
CONFIG_USB_ISIGHTFW=y
CONFIG_USB_YUREX=y
CONFIG_USB_EZUSB_FX2=y
CONFIG_USB_HUB_USB251XB=y
CONFIG_USB_HSIC_USB3503=y
CONFIG_USB_HSIC_USB4604=y
CONFIG_USB_LINK_LAYER_TEST=y
# CONFIG_USB_CHAOSKEY is not set
# CONFIG_USB_ATM is not set

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=y
# CONFIG_NOP_USB_XCEIV is not set
CONFIG_USB_GPIO_VBUS=y
# CONFIG_TAHVO_USB is not set
CONFIG_USB_ISP1301=y
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
CONFIG_USB_GADGET_DEBUG_FILES=y
CONFIG_USB_GADGET_DEBUG_FS=y
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2
# CONFIG_U_SERIAL_CONSOLE is not set

#
# USB Peripheral Controller
#
CONFIG_USB_FUSB300=y
# CONFIG_USB_FOTG210_UDC is not set
CONFIG_USB_GR_UDC=y
CONFIG_USB_R8A66597=y
CONFIG_USB_PXA27X=y
# CONFIG_USB_MV_UDC is not set
CONFIG_USB_MV_U3D=y
CONFIG_USB_M66592=y
CONFIG_USB_BDC_UDC=y
# CONFIG_USB_AMD5536UDC is not set
CONFIG_USB_NET2272=y
# CONFIG_USB_NET2272_DMA is not set
CONFIG_USB_NET2280=y
CONFIG_USB_GOKU=y
CONFIG_USB_EG20T=y
# CONFIG_USB_MAX3420_UDC is not set
CONFIG_USB_DUMMY_HCD=y
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=y
CONFIG_USB_F_ACM=y
CONFIG_USB_U_SERIAL=y
CONFIG_USB_U_ETHER=y
CONFIG_USB_U_AUDIO=y
CONFIG_USB_F_SERIAL=y
CONFIG_USB_F_OBEX=y
CONFIG_USB_F_NCM=y
CONFIG_USB_F_ECM=y
CONFIG_USB_F_PHONET=y
CONFIG_USB_F_EEM=y
CONFIG_USB_F_SUBSET=y
CONFIG_USB_F_RNDIS=y
CONFIG_USB_F_MASS_STORAGE=y
CONFIG_USB_F_FS=y
CONFIG_USB_F_UAC2=y
CONFIG_USB_F_HID=y
CONFIG_USB_F_PRINTER=y
CONFIG_USB_CONFIGFS=y
CONFIG_USB_CONFIGFS_SERIAL=y
CONFIG_USB_CONFIGFS_ACM=y
CONFIG_USB_CONFIGFS_OBEX=y
# CONFIG_USB_CONFIGFS_NCM is not set
CONFIG_USB_CONFIGFS_ECM=y
CONFIG_USB_CONFIGFS_ECM_SUBSET=y
CONFIG_USB_CONFIGFS_RNDIS=y
CONFIG_USB_CONFIGFS_EEM=y
CONFIG_USB_CONFIGFS_PHONET=y
# CONFIG_USB_CONFIGFS_MASS_STORAGE is not set
# CONFIG_USB_CONFIGFS_F_LB_SS is not set
CONFIG_USB_CONFIGFS_F_FS=y
# CONFIG_USB_CONFIGFS_F_UAC1 is not set
# CONFIG_USB_CONFIGFS_F_UAC1_LEGACY is not set
CONFIG_USB_CONFIGFS_F_UAC2=y
# CONFIG_USB_CONFIGFS_F_MIDI is not set
# CONFIG_USB_CONFIGFS_F_HID is not set
# CONFIG_USB_CONFIGFS_F_UVC is not set
CONFIG_USB_CONFIGFS_F_PRINTER=y

#
# USB Gadget precomposed configurations
#
# CONFIG_USB_ZERO is not set
CONFIG_USB_AUDIO=y
# CONFIG_GADGET_UAC1 is not set
# CONFIG_USB_ETH is not set
CONFIG_USB_G_NCM=y
# CONFIG_USB_GADGETFS is not set
CONFIG_USB_FUNCTIONFS=y
# CONFIG_USB_FUNCTIONFS_ETH is not set
# CONFIG_USB_FUNCTIONFS_RNDIS is not set
CONFIG_USB_FUNCTIONFS_GENERIC=y
CONFIG_USB_MASS_STORAGE=y
CONFIG_USB_G_SERIAL=y
# CONFIG_USB_MIDI_GADGET is not set
CONFIG_USB_G_PRINTER=y
CONFIG_USB_CDC_COMPOSITE=y
# CONFIG_USB_G_NOKIA is not set
CONFIG_USB_G_ACM_MS=y
CONFIG_USB_G_MULTI=y
CONFIG_USB_G_MULTI_RNDIS=y
# CONFIG_USB_G_MULTI_CDC is not set
CONFIG_USB_G_HID=y
CONFIG_USB_G_DBGP=y
# CONFIG_USB_G_DBGP_PRINTK is not set
CONFIG_USB_G_DBGP_SERIAL=y
# CONFIG_USB_G_WEBCAM is not set
# CONFIG_USB_RAW_GADGET is not set
# end of USB Gadget precomposed configurations

# CONFIG_TYPEC is not set
CONFIG_USB_ROLE_SWITCH=y
CONFIG_USB_ROLES_INTEL_XHCI=y
# CONFIG_MMC is not set
CONFIG_MEMSTICK=y
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
CONFIG_MEMSTICK_UNSAFE_RESUME=y
CONFIG_MSPRO_BLOCK=y
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
# CONFIG_MEMSTICK_TIFM_MS is not set
CONFIG_MEMSTICK_JMICRON_38X=y
CONFIG_MEMSTICK_R592=y
CONFIG_MEMSTICK_REALTEK_PCI=y
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=y

#
# LED drivers
#
CONFIG_LEDS_APU=y
CONFIG_LEDS_LM3530=y
CONFIG_LEDS_LM3532=y
CONFIG_LEDS_LM3533=y
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_MT6323 is not set
CONFIG_LEDS_NET48XX=y
CONFIG_LEDS_WRAP=y
CONFIG_LEDS_PCA9532=y
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=y
CONFIG_LEDS_LP3952=y
CONFIG_LEDS_LP50XX=y
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
CONFIG_LEDS_DA903X=y
CONFIG_LEDS_DA9052=y
CONFIG_LEDS_DAC124S085=y
# CONFIG_LEDS_PWM is not set
CONFIG_LEDS_REGULATOR=y
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=y
CONFIG_LEDS_LT3593=y
CONFIG_LEDS_MC13783=y
CONFIG_LEDS_TCA6507=y
CONFIG_LEDS_TLC591XX=y
CONFIG_LEDS_LM355x=y
# CONFIG_LEDS_OT200 is not set
# CONFIG_LEDS_MENF21BMC is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_MLXREG=y
# CONFIG_LEDS_USER is not set
CONFIG_LEDS_NIC78BX=y
CONFIG_LEDS_TI_LMU_COMMON=y
CONFIG_LEDS_LM36274=y

#
# Flash and Torch LED drivers
#
# CONFIG_LEDS_AS3645A is not set
CONFIG_LEDS_LM3601X=y
# CONFIG_LEDS_RT8515 is not set
# CONFIG_LEDS_SGM3140 is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
# CONFIG_LEDS_TRIGGER_TIMER is not set
CONFIG_LEDS_TRIGGER_ONESHOT=y
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=y
CONFIG_LEDS_TRIGGER_BACKLIGHT=y
CONFIG_LEDS_TRIGGER_CPU=y
CONFIG_LEDS_TRIGGER_ACTIVITY=y
CONFIG_LEDS_TRIGGER_GPIO=y
# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=y
CONFIG_LEDS_TRIGGER_CAMERA=y
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
CONFIG_LEDS_TRIGGER_PATTERN=y
CONFIG_LEDS_TRIGGER_AUDIO=y
CONFIG_LEDS_TRIGGER_TTY=y
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=y
CONFIG_INFINIBAND_USER_MAD=y
CONFIG_INFINIBAND_USER_ACCESS=y
CONFIG_INFINIBAND_USER_MEM=y
# CONFIG_INFINIBAND_ON_DEMAND_PAGING is not set
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_MTHCA=y
CONFIG_INFINIBAND_MTHCA_DEBUG=y
# CONFIG_INFINIBAND_CXGB4 is not set
# CONFIG_MLX4_INFINIBAND is not set
# CONFIG_INFINIBAND_OCRDMA is not set
CONFIG_INFINIBAND_VMWARE_PVRDMA=y
CONFIG_INFINIBAND_IPOIB=y
# CONFIG_INFINIBAND_IPOIB_CM is not set
CONFIG_INFINIBAND_IPOIB_DEBUG=y
CONFIG_INFINIBAND_IPOIB_DEBUG_DATA=y
CONFIG_INFINIBAND_SRP=y
# CONFIG_INFINIBAND_ISER is not set
CONFIG_INFINIBAND_RTRS=y
# CONFIG_INFINIBAND_RTRS_CLIENT is not set
CONFIG_INFINIBAND_RTRS_SERVER=y
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
CONFIG_EDAC_DEBUG=y
CONFIG_EDAC_AMD76X=y
CONFIG_EDAC_E7XXX=y
CONFIG_EDAC_E752X=y
CONFIG_EDAC_I82875P=y
# CONFIG_EDAC_I82975X is not set
CONFIG_EDAC_I3000=y
CONFIG_EDAC_I3200=y
CONFIG_EDAC_IE31200=y
CONFIG_EDAC_X38=y
CONFIG_EDAC_I5400=y
CONFIG_EDAC_I82860=y
CONFIG_EDAC_R82600=y
# CONFIG_EDAC_I5000 is not set
CONFIG_EDAC_I5100=y
CONFIG_EDAC_I7300=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
# CONFIG_RTC_CLASS is not set
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
CONFIG_DMABUF_MOVE_NOTIFY=y
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=y
# CONFIG_DMABUF_SYSFS_STATS is not set
# CONFIG_DMABUF_HEAPS_SYSTEM is not set
# CONFIG_DMABUF_HEAPS_CMA is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_PANEL is not set
CONFIG_UIO=y
CONFIG_UIO_CIF=y
CONFIG_UIO_PDRV_GENIRQ=y
CONFIG_UIO_DMEM_GENIRQ=y
CONFIG_UIO_AEC=y
CONFIG_UIO_SERCOS3=y
CONFIG_UIO_PCI_GENERIC=y
# CONFIG_UIO_NETX is not set
CONFIG_UIO_PRUSS=y
# CONFIG_UIO_MF624 is not set
# CONFIG_VFIO is not set
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_PCI_LIB=y
CONFIG_VIRTIO_PCI_LIB_LEGACY=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_VDPA is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=y
CONFIG_VIRTIO_MMIO=y
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=y
CONFIG_VDPA=y
# CONFIG_VDPA_SIM is not set
CONFIG_VDPA_USER=y
CONFIG_VHOST_IOTLB=y
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

CONFIG_GREYBUS=y
# CONFIG_GREYBUS_ES2 is not set
CONFIG_COMEDI=y
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
# CONFIG_COMEDI_ISA_DRIVERS is not set
CONFIG_COMEDI_PCI_DRIVERS=y
CONFIG_COMEDI_8255_PCI=y
CONFIG_COMEDI_ADDI_WATCHDOG=y
# CONFIG_COMEDI_ADDI_APCI_1032 is not set
# CONFIG_COMEDI_ADDI_APCI_1500 is not set
CONFIG_COMEDI_ADDI_APCI_1516=y
CONFIG_COMEDI_ADDI_APCI_1564=y
CONFIG_COMEDI_ADDI_APCI_16XX=y
# CONFIG_COMEDI_ADDI_APCI_2032 is not set
CONFIG_COMEDI_ADDI_APCI_2200=y
CONFIG_COMEDI_ADDI_APCI_3120=y
# CONFIG_COMEDI_ADDI_APCI_3501 is not set
CONFIG_COMEDI_ADDI_APCI_3XXX=y
# CONFIG_COMEDI_ADL_PCI6208 is not set
CONFIG_COMEDI_ADL_PCI7X3X=y
CONFIG_COMEDI_ADL_PCI8164=y
CONFIG_COMEDI_ADL_PCI9111=y
CONFIG_COMEDI_ADL_PCI9118=y
# CONFIG_COMEDI_ADV_PCI1710 is not set
CONFIG_COMEDI_ADV_PCI1720=y
CONFIG_COMEDI_ADV_PCI1723=y
CONFIG_COMEDI_ADV_PCI1724=y
# CONFIG_COMEDI_ADV_PCI1760 is not set
CONFIG_COMEDI_ADV_PCI_DIO=y
CONFIG_COMEDI_AMPLC_DIO200_PCI=y
# CONFIG_COMEDI_AMPLC_PC236_PCI is not set
CONFIG_COMEDI_AMPLC_PC263_PCI=y
CONFIG_COMEDI_AMPLC_PCI224=y
CONFIG_COMEDI_AMPLC_PCI230=y
# CONFIG_COMEDI_CONTEC_PCI_DIO is not set
CONFIG_COMEDI_DAS08_PCI=y
CONFIG_COMEDI_DT3000=y
CONFIG_COMEDI_DYNA_PCI10XX=y
CONFIG_COMEDI_GSC_HPDI=y
CONFIG_COMEDI_MF6X4=y
CONFIG_COMEDI_ICP_MULTI=y
# CONFIG_COMEDI_DAQBOARD2000 is not set
CONFIG_COMEDI_JR3_PCI=y
# CONFIG_COMEDI_KE_COUNTER is not set
CONFIG_COMEDI_CB_PCIDAS64=y
CONFIG_COMEDI_CB_PCIDAS=y
CONFIG_COMEDI_CB_PCIDDA=y
CONFIG_COMEDI_CB_PCIMDAS=y
# CONFIG_COMEDI_CB_PCIMDDA is not set
CONFIG_COMEDI_ME4000=y
CONFIG_COMEDI_ME_DAQ=y
CONFIG_COMEDI_NI_6527=y
# CONFIG_COMEDI_NI_65XX is not set
CONFIG_COMEDI_NI_660X=y
CONFIG_COMEDI_NI_670X=y
CONFIG_COMEDI_NI_LABPC_PCI=y
CONFIG_COMEDI_NI_PCIDIO=y
CONFIG_COMEDI_NI_PCIMIO=y
# CONFIG_COMEDI_RTD520 is not set
# CONFIG_COMEDI_S626 is not set
CONFIG_COMEDI_MITE=y
CONFIG_COMEDI_NI_TIOCMD=y
CONFIG_COMEDI_USB_DRIVERS=y
CONFIG_COMEDI_DT9812=y
# CONFIG_COMEDI_NI_USB6501 is not set
# CONFIG_COMEDI_USBDUX is not set
CONFIG_COMEDI_USBDUXFAST=y
CONFIG_COMEDI_USBDUXSIGMA=y
CONFIG_COMEDI_VMK80XX=y
CONFIG_COMEDI_8254=y
CONFIG_COMEDI_8255=y
CONFIG_COMEDI_8255_SA=y
CONFIG_COMEDI_KCOMEDILIB=y
CONFIG_COMEDI_AMPLC_DIO200=y
CONFIG_COMEDI_DAS08=y
CONFIG_COMEDI_NI_LABPC=y
CONFIG_COMEDI_NI_TIO=y
CONFIG_COMEDI_NI_ROUTING=y
# CONFIG_COMEDI_TESTS is not set
CONFIG_STAGING=y
CONFIG_PRISM2_USB=y
# CONFIG_RTL8192U is not set
# CONFIG_RTLLIB is not set
CONFIG_R8712U=y
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
CONFIG_ADIS16203=y
CONFIG_ADIS16240=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7816=y
CONFIG_AD7280=y
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=y
CONFIG_ADT7316_SPI=y
CONFIG_ADT7316_I2C=y
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
CONFIG_AD7746=y
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
CONFIG_AD9832=y
CONFIG_AD9834=y
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
CONFIG_ADE7854=y
CONFIG_ADE7854_I2C=y
CONFIG_ADE7854_SPI=y
# end of Active energy metering IC

#
# Resolver to digital converters
#
CONFIG_AD2S1210=y
# end of Resolver to digital converters
# end of IIO staging drivers

CONFIG_STAGING_MEDIA=y
CONFIG_VIDEO_ZORAN=y
CONFIG_VIDEO_ZORAN_DC30=y
# CONFIG_VIDEO_ZORAN_ZR36060 is not set
# CONFIG_VIDEO_IPU3_IMGU is not set

#
# Android
#
# end of Android

# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=y
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
CONFIG_GS_FPGABOOT=y
# CONFIG_UNISYSSPAR is not set
# CONFIG_MOST_COMPONENTS is not set
CONFIG_GREYBUS_AUDIO=y
CONFIG_GREYBUS_AUDIO_APB_CODEC=y
# CONFIG_GREYBUS_BOOTROM is not set
CONFIG_GREYBUS_FIRMWARE=y
CONFIG_GREYBUS_HID=y
CONFIG_GREYBUS_LIGHT=y
CONFIG_GREYBUS_LOG=y
CONFIG_GREYBUS_LOOPBACK=y
# CONFIG_GREYBUS_POWER is not set
CONFIG_GREYBUS_RAW=y
# CONFIG_GREYBUS_VIBRATOR is not set
CONFIG_GREYBUS_BRIDGED_PHY=y
CONFIG_GREYBUS_GPIO=y
# CONFIG_GREYBUS_I2C is not set
CONFIG_GREYBUS_PWM=y
# CONFIG_GREYBUS_SPI is not set
# CONFIG_GREYBUS_UART is not set
CONFIG_GREYBUS_USB=y
# CONFIG_PI433 is not set
CONFIG_FIELDBUS_DEV=y
CONFIG_QLGE=y
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=y
CONFIG_WMI_BMOF=y
CONFIG_HUAWEI_WMI=y
CONFIG_MXM_WMI=y
CONFIG_PEAQ_WMI=y
# CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
CONFIG_XIAOMI_WMI=y
# CONFIG_GIGABYTE_WMI is not set
CONFIG_ACERHDF=y
CONFIG_ACER_WIRELESS=y
CONFIG_ACER_WMI=y
# CONFIG_ADV_SWBUTTON is not set
# CONFIG_APPLE_GMUX is not set
# CONFIG_ASUS_LAPTOP is not set
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=y
# CONFIG_ASUS_NB_WMI is not set
CONFIG_MERAKI_MX100=y
# CONFIG_EEEPC_LAPTOP is not set
CONFIG_EEEPC_WMI=y
# CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
# CONFIG_FUJITSU_LAPTOP is not set
CONFIG_FUJITSU_TABLET=y
CONFIG_GPD_POCKET_FAN=y
CONFIG_HP_ACCEL=y
CONFIG_WIRELESS_HOTKEY=y
CONFIG_HP_WMI=y
CONFIG_TC1100_WMI=y
CONFIG_IBM_RTL=y
# CONFIG_SENSORS_HDAPS is not set
CONFIG_THINKPAD_ACPI=y
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
CONFIG_THINKPAD_ACPI_DEBUGFACILITIES=y
CONFIG_THINKPAD_ACPI_DEBUG=y
CONFIG_THINKPAD_ACPI_UNSAFE_LEDS=y
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_THINKPAD_LMI is not set
CONFIG_X86_PLATFORM_DRIVERS_INTEL=y
CONFIG_INTEL_ATOMISP2_PDX86=y
CONFIG_INTEL_ATOMISP2_LED=y
CONFIG_INTEL_ATOMISP2_PM=y
# CONFIG_INTEL_SAR_INT1092 is not set
CONFIG_INTEL_SKL_INT3472=y
CONFIG_INTEL_PMC_CORE=y
CONFIG_INTEL_PMT_CLASS=y
CONFIG_INTEL_PMT_TELEMETRY=y
CONFIG_INTEL_PMT_CRASHLOG=y
CONFIG_INTEL_WMI=y
CONFIG_INTEL_WMI_SBL_FW_UPDATE=y
CONFIG_INTEL_WMI_THUNDERBOLT=y
CONFIG_INTEL_HID_EVENT=y
CONFIG_INTEL_VBTN=y
CONFIG_INTEL_INT0002_VGPIO=y
# CONFIG_INTEL_PUNIT_IPC is not set
CONFIG_INTEL_RST=y
# CONFIG_INTEL_SMARTCONNECT is not set
CONFIG_MSI_WMI=y
CONFIG_PCENGINES_APU2=y
# CONFIG_BARCO_P50_GPIO is not set
CONFIG_SAMSUNG_LAPTOP=y
# CONFIG_SAMSUNG_Q10 is not set
CONFIG_ACPI_TOSHIBA=y
CONFIG_TOSHIBA_BT_RFKILL=y
CONFIG_TOSHIBA_HAPS=y
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_ACPI_CMPC is not set
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=y
CONFIG_I2C_MULTI_INSTANTIATE=y
CONFIG_MLX_PLATFORM=y
CONFIG_INTEL_IPS=y
CONFIG_INTEL_SCU_IPC=y
CONFIG_INTEL_SCU=y
CONFIG_INTEL_SCU_PCI=y
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_INTEL_SCU_IPC_UTIL=y
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
# CONFIG_SURFACE_PLATFORMS is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
CONFIG_LMK04832=y
# CONFIG_COMMON_CLK_MAX9485 is not set
CONFIG_COMMON_CLK_SI5341=y
CONFIG_COMMON_CLK_SI5351=y
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
CONFIG_COMMON_CLK_PALMAS=y
# CONFIG_COMMON_CLK_PWM is not set
CONFIG_XILINX_VCU=y
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKSRC_I8253=y
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

# CONFIG_MAILBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
CONFIG_IOMMU_DEFAULT_DMA_STRICT=y
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_VIRTIO_IOMMU=y

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=y
# CONFIG_REMOTEPROC_CDEV is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
CONFIG_RPMSG_CHAR=y
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=y
# CONFIG_EXTCON_AXP288 is not set
CONFIG_EXTCON_FSA9480=y
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=y
CONFIG_EXTCON_MAX3355=y
# CONFIG_EXTCON_MAX77693 is not set
# CONFIG_EXTCON_MAX77843 is not set
# CONFIG_EXTCON_PALMAS is not set
CONFIG_EXTCON_PTN5150=y
CONFIG_EXTCON_RT8973A=y
CONFIG_EXTCON_SM5502=y
CONFIG_EXTCON_USB_GPIO=y
# CONFIG_EXTCON_USBC_TUSB320 is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
CONFIG_IIO_BUFFER_DMA=y
CONFIG_IIO_BUFFER_DMAENGINE=y
CONFIG_IIO_BUFFER_HW_CONSUMER=y
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=y
CONFIG_IIO_CONFIGFS=y
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
CONFIG_IIO_SW_TRIGGER=y
CONFIG_IIO_TRIGGERED_EVENT=y

#
# Accelerometers
#
CONFIG_ADIS16201=y
CONFIG_ADIS16209=y
# CONFIG_ADXL313_I2C is not set
# CONFIG_ADXL313_SPI is not set
CONFIG_ADXL345=y
CONFIG_ADXL345_I2C=y
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL355_I2C is not set
# CONFIG_ADXL355_SPI is not set
CONFIG_ADXL372=y
CONFIG_ADXL372_SPI=y
CONFIG_ADXL372_I2C=y
CONFIG_BMA180=y
CONFIG_BMA220=y
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_BMI088_ACCEL is not set
CONFIG_DA280=y
CONFIG_DA311=y
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_FXLS8962AF=y
CONFIG_FXLS8962AF_I2C=y
CONFIG_FXLS8962AF_SPI=y
CONFIG_HID_SENSOR_ACCEL_3D=y
# CONFIG_KXSD9 is not set
CONFIG_KXCJK1013=y
CONFIG_MC3230=y
CONFIG_MMA7455=y
# CONFIG_MMA7455_I2C is not set
CONFIG_MMA7455_SPI=y
CONFIG_MMA7660=y
CONFIG_MMA8452=y
CONFIG_MMA9551_CORE=y
CONFIG_MMA9551=y
CONFIG_MMA9553=y
# CONFIG_MXC4005 is not set
CONFIG_MXC6255=y
CONFIG_SCA3000=y
CONFIG_SCA3300=y
CONFIG_STK8312=y
CONFIG_STK8BA50=y
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=y
# CONFIG_AD7091R5 is not set
CONFIG_AD7124=y
# CONFIG_AD7192 is not set
CONFIG_AD7266=y
CONFIG_AD7291=y
# CONFIG_AD7292 is not set
CONFIG_AD7298=y
# CONFIG_AD7476 is not set
CONFIG_AD7606=y
CONFIG_AD7606_IFACE_PARALLEL=y
CONFIG_AD7606_IFACE_SPI=y
CONFIG_AD7766=y
CONFIG_AD7768_1=y
CONFIG_AD7780=y
CONFIG_AD7791=y
CONFIG_AD7793=y
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
CONFIG_AD799X=y
# CONFIG_AXP20X_ADC is not set
CONFIG_AXP288_ADC=y
CONFIG_CC10001_ADC=y
CONFIG_DA9150_GPADC=y
# CONFIG_DLN2_ADC is not set
CONFIG_HI8435=y
CONFIG_HX711=y
# CONFIG_INA2XX_ADC is not set
CONFIG_LTC2471=y
# CONFIG_LTC2485 is not set
CONFIG_LTC2496=y
# CONFIG_LTC2497 is not set
CONFIG_MAX1027=y
CONFIG_MAX11100=y
CONFIG_MAX1118=y
# CONFIG_MAX1241 is not set
CONFIG_MAX1363=y
CONFIG_MAX9611=y
CONFIG_MCP320X=y
CONFIG_MCP3422=y
CONFIG_MCP3911=y
CONFIG_MP2629_ADC=y
# CONFIG_NAU7802 is not set
CONFIG_PALMAS_GPADC=y
CONFIG_QCOM_SPMI_IADC=y
# CONFIG_QCOM_SPMI_VADC is not set
# CONFIG_QCOM_SPMI_ADC5 is not set
CONFIG_TI_ADC081C=y
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
CONFIG_TI_ADC12138=y
CONFIG_TI_ADC108S102=y
CONFIG_TI_ADC128S052=y
# CONFIG_TI_ADC161S626 is not set
CONFIG_TI_ADS1015=y
CONFIG_TI_ADS7950=y
# CONFIG_TI_ADS131E08 is not set
CONFIG_TI_TLC4541=y
# CONFIG_TI_TSC2046 is not set
# CONFIG_VIPERBOARD_ADC is not set
CONFIG_XILINX_XADC=y
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_AD8366=y
CONFIG_HMC425=y
# end of Amplifiers

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# end of Capacitance to digital converters

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=y
CONFIG_ATLAS_EZO_SENSOR=y
CONFIG_BME680=y
CONFIG_BME680_I2C=y
CONFIG_BME680_SPI=y
CONFIG_CCS811=y
CONFIG_IAQCORE=y
# CONFIG_SCD30_CORE is not set
# CONFIG_SCD4X is not set
CONFIG_SENSIRION_SGP30=y
CONFIG_SENSIRION_SGP40=y
CONFIG_SPS30=y
CONFIG_SPS30_I2C=y
# CONFIG_SENSEAIR_SUNRISE_CO2 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=y
CONFIG_HID_SENSOR_IIO_TRIGGER=y
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=y

#
# IIO SCMI Sensors
#
# end of IIO SCMI Sensors

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=y
CONFIG_IIO_SSP_SENSORHUB=y
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=y
CONFIG_IIO_ST_SENSORS_SPI=y
CONFIG_IIO_ST_SENSORS_CORE=y

#
# Digital to analog converters
#
CONFIG_AD5064=y
CONFIG_AD5360=y
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
CONFIG_AD5446=y
CONFIG_AD5449=y
CONFIG_AD5592R_BASE=y
CONFIG_AD5592R=y
CONFIG_AD5593R=y
# CONFIG_AD5504 is not set
CONFIG_AD5624R_SPI=y
CONFIG_AD5686=y
CONFIG_AD5686_SPI=y
# CONFIG_AD5696_I2C is not set
CONFIG_AD5755=y
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
CONFIG_AD5764=y
CONFIG_AD5766=y
# CONFIG_AD5770R is not set
CONFIG_AD5791=y
CONFIG_AD7303=y
CONFIG_AD8801=y
CONFIG_DS4424=y
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
CONFIG_M62332=y
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
CONFIG_TI_DAC082S085=y
CONFIG_TI_DAC5571=y
CONFIG_TI_DAC7311=y
# CONFIG_TI_DAC7612 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=y
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=y
CONFIG_ADF4371=y
# CONFIG_ADRF6780 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
CONFIG_ADIS16130=y
CONFIG_ADIS16136=y
CONFIG_ADIS16260=y
# CONFIG_ADXRS290 is not set
CONFIG_ADXRS450=y
CONFIG_BMG160=y
CONFIG_BMG160_I2C=y
CONFIG_BMG160_SPI=y
# CONFIG_FXAS21002C is not set
# CONFIG_HID_SENSOR_GYRO_3D is not set
CONFIG_MPU3050=y
CONFIG_MPU3050_I2C=y
CONFIG_IIO_ST_GYRO_3AXIS=y
CONFIG_IIO_ST_GYRO_I2C_3AXIS=y
CONFIG_IIO_ST_GYRO_SPI_3AXIS=y
CONFIG_ITG3200=y
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=y
# CONFIG_AFE4404 is not set
CONFIG_MAX30100=y
CONFIG_MAX30102=y
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=y
CONFIG_DHT11=y
CONFIG_HDC100X=y
# CONFIG_HDC2010 is not set
CONFIG_HID_SENSOR_HUMIDITY=y
# CONFIG_HTS221 is not set
CONFIG_HTU21=y
CONFIG_SI7005=y
CONFIG_SI7020=y
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
CONFIG_ADIS16460=y
CONFIG_ADIS16475=y
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
CONFIG_FXOS8700=y
CONFIG_FXOS8700_I2C=y
CONFIG_FXOS8700_SPI=y
CONFIG_KMX61=y
CONFIG_INV_ICM42600=y
CONFIG_INV_ICM42600_I2C=y
CONFIG_INV_ICM42600_SPI=y
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
CONFIG_IIO_ST_LSM6DSX=y
CONFIG_IIO_ST_LSM6DSX_I2C=y
CONFIG_IIO_ST_LSM6DSX_SPI=y
CONFIG_IIO_ST_LSM6DSX_I3C=y
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=y
CONFIG_IIO_ADIS_LIB_BUFFER=y

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
CONFIG_ADJD_S311=y
CONFIG_ADUX1020=y
# CONFIG_AL3010 is not set
CONFIG_AL3320A=y
# CONFIG_APDS9300 is not set
CONFIG_APDS9960=y
CONFIG_AS73211=y
CONFIG_BH1750=y
CONFIG_BH1780=y
# CONFIG_CM32181 is not set
CONFIG_CM3232=y
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
CONFIG_GP2AP002=y
CONFIG_GP2AP020A00F=y
CONFIG_IQS621_ALS=y
CONFIG_SENSORS_ISL29018=y
CONFIG_SENSORS_ISL29028=y
# CONFIG_ISL29125 is not set
# CONFIG_HID_SENSOR_ALS is not set
CONFIG_HID_SENSOR_PROX=y
CONFIG_JSA1212=y
CONFIG_RPR0521=y
CONFIG_SENSORS_LM3533=y
CONFIG_LTR501=y
CONFIG_LV0104CS=y
CONFIG_MAX44000=y
CONFIG_MAX44009=y
# CONFIG_NOA1305 is not set
CONFIG_OPT3001=y
CONFIG_PA12203001=y
CONFIG_SI1133=y
CONFIG_SI1145=y
CONFIG_STK3310=y
CONFIG_ST_UVIS25=y
CONFIG_ST_UVIS25_I2C=y
CONFIG_ST_UVIS25_SPI=y
CONFIG_TCS3414=y
# CONFIG_TCS3472 is not set
CONFIG_SENSORS_TSL2563=y
# CONFIG_TSL2583 is not set
# CONFIG_TSL2591 is not set
CONFIG_TSL2772=y
CONFIG_TSL4531=y
# CONFIG_US5182D is not set
CONFIG_VCNL4000=y
CONFIG_VCNL4035=y
# CONFIG_VEML6030 is not set
CONFIG_VEML6070=y
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
CONFIG_BMC150_MAGN=y
CONFIG_BMC150_MAGN_I2C=y
CONFIG_BMC150_MAGN_SPI=y
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=y
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
CONFIG_SENSORS_HMC5843=y
CONFIG_SENSORS_HMC5843_I2C=y
CONFIG_SENSORS_HMC5843_SPI=y
CONFIG_SENSORS_RM3100=y
CONFIG_SENSORS_RM3100_I2C=y
CONFIG_SENSORS_RM3100_SPI=y
# CONFIG_YAMAHA_YAS530 is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
# CONFIG_HID_SENSOR_INCLINOMETER_3D is not set
CONFIG_HID_SENSOR_DEVICE_ROTATION=y
# end of Inclinometer sensors

# CONFIG_IIO_TEST_FORMAT is not set

#
# Triggers - standalone
#
# CONFIG_IIO_HRTIMER_TRIGGER is not set
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
CONFIG_IIO_TIGHTLOOP_TRIGGER=y
CONFIG_IIO_SYSFS_TRIGGER=y
# end of Triggers - standalone

#
# Linear and angular position sensors
#
CONFIG_IQS624_POS=y
CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE=y
# end of Linear and angular position sensors

#
# Digital potentiometers
#
CONFIG_AD5110=y
CONFIG_AD5272=y
CONFIG_DS1803=y
# CONFIG_MAX5432 is not set
# CONFIG_MAX5481 is not set
CONFIG_MAX5487=y
CONFIG_MCP4018=y
CONFIG_MCP4131=y
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
CONFIG_TPL0102=y
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
CONFIG_BMP280=y
CONFIG_BMP280_I2C=y
CONFIG_BMP280_SPI=y
CONFIG_DLHL60D=y
CONFIG_DPS310=y
CONFIG_HID_SENSOR_PRESS=y
# CONFIG_HP03 is not set
# CONFIG_ICP10100 is not set
CONFIG_MPL115=y
# CONFIG_MPL115_I2C is not set
CONFIG_MPL115_SPI=y
CONFIG_MPL3115=y
CONFIG_MS5611=y
# CONFIG_MS5611_I2C is not set
CONFIG_MS5611_SPI=y
CONFIG_MS5637=y
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
CONFIG_HP206C=y
CONFIG_ZPA2326=y
CONFIG_ZPA2326_I2C=y
CONFIG_ZPA2326_SPI=y
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=y
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=y
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_PING is not set
CONFIG_RFD77402=y
# CONFIG_SRF04 is not set
CONFIG_SX9310=y
CONFIG_SX9500=y
CONFIG_SRF08=y
CONFIG_VCNL3020=y
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
CONFIG_AD2S90=y
CONFIG_AD2S1200=y
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_IQS620AT_TEMP=y
CONFIG_LTC2983=y
CONFIG_MAXIM_THERMOCOUPLE=y
# CONFIG_HID_SENSOR_TEMP is not set
CONFIG_MLX90614=y
CONFIG_MLX90632=y
# CONFIG_TMP006 is not set
CONFIG_TMP007=y
# CONFIG_TMP117 is not set
CONFIG_TSYS01=y
CONFIG_TSYS02D=y
# CONFIG_MAX31856 is not set
# CONFIG_MAX31865 is not set
# end of Temperature sensors

CONFIG_NTB=y
CONFIG_NTB_IDT=y
# CONFIG_NTB_EPF is not set
# CONFIG_NTB_SWITCHTEC is not set
CONFIG_NTB_PINGPONG=y
CONFIG_NTB_TOOL=y
CONFIG_NTB_PERF=y
# CONFIG_NTB_TRANSPORT is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
CONFIG_PWM_DWC=y
# CONFIG_PWM_IQS620A is not set
CONFIG_PWM_LP3943=y
CONFIG_PWM_LPSS=y
CONFIG_PWM_LPSS_PCI=y
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=y

#
# IRQ chip support
#
CONFIG_MADERA_IRQ=y
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
CONFIG_PHY_CAN_TRANSCEIVER=y

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=y
# end of PHY drivers for Broadcom platforms

CONFIG_PHY_PXA_28NM_HSIC=y
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_CPCAP_USB=y
# CONFIG_PHY_QCOM_USB_HS is not set
CONFIG_PHY_QCOM_USB_HSIC=y
CONFIG_PHY_TUSB1210=y
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
CONFIG_USB4=y
# CONFIG_USB4_DEBUGFS_WRITE is not set
CONFIG_USB4_KUNIT_TEST=y
CONFIG_USB4_DMA_TEST=y

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_DAX=y
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_NVMEM_SPMI_SDAM=y
# CONFIG_NVMEM_RMEM is not set

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_PROTO_BASIC is not set
# CONFIG_STM_PROTO_SYS_T is not set
CONFIG_STM_DUMMY=y
CONFIG_STM_SOURCE_CONSOLE=y
# CONFIG_STM_SOURCE_HEARTBEAT is not set
CONFIG_STM_SOURCE_FTRACE=y
CONFIG_INTEL_TH=y
CONFIG_INTEL_TH_PCI=y
CONFIG_INTEL_TH_ACPI=y
CONFIG_INTEL_TH_GTH=y
CONFIG_INTEL_TH_STH=y
# CONFIG_INTEL_TH_MSU is not set
# CONFIG_INTEL_TH_PTI is not set
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
CONFIG_SIOX=y
CONFIG_SIOX_BUS_GPIO=y
CONFIG_SLIMBUS=y
CONFIG_SLIM_QCOM_CTRL=y
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
CONFIG_MOST=y
CONFIG_MOST_USB_HDM=y
# CONFIG_MOST_CDEV is not set
CONFIG_MOST_SND=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4_FS is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_REISERFS_FS_XATTR is not set
CONFIG_JFS_FS=y
CONFIG_JFS_POSIX_ACL=y
CONFIG_JFS_SECURITY=y
# CONFIG_JFS_DEBUG is not set
# CONFIG_JFS_STATISTICS is not set
CONFIG_XFS_FS=y
# CONFIG_XFS_SUPPORT_V4 is not set
CONFIG_XFS_QUOTA=y
# CONFIG_XFS_POSIX_ACL is not set
# CONFIG_XFS_RT is not set
CONFIG_XFS_ONLINE_SCRUB=y
# CONFIG_XFS_ONLINE_REPAIR is not set
CONFIG_XFS_DEBUG=y
# CONFIG_XFS_ASSERT_FATAL is not set
# CONFIG_GFS2_FS is not set
CONFIG_OCFS2_FS=y
CONFIG_OCFS2_FS_O2CB=y
CONFIG_OCFS2_FS_STATS=y
# CONFIG_OCFS2_DEBUG_MASKLOG is not set
CONFIG_OCFS2_DEBUG_FS=y
CONFIG_BTRFS_FS=y
CONFIG_BTRFS_FS_POSIX_ACL=y
CONFIG_BTRFS_FS_CHECK_INTEGRITY=y
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
CONFIG_BTRFS_DEBUG=y
CONFIG_BTRFS_ASSERT=y
CONFIG_BTRFS_FS_REF_VERIFY=y
CONFIG_NILFS2_FS=y
CONFIG_F2FS_FS=y
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
# CONFIG_F2FS_FS_POSIX_ACL is not set
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
CONFIG_F2FS_FAULT_INJECTION=y
CONFIG_F2FS_FS_COMPRESSION=y
# CONFIG_F2FS_FS_LZO is not set
CONFIG_F2FS_FS_LZ4=y
# CONFIG_F2FS_FS_LZ4HC is not set
# CONFIG_F2FS_FS_ZSTD is not set
# CONFIG_F2FS_IOSTAT is not set
# CONFIG_ZONEFS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
CONFIG_FS_ENCRYPTION_ALGS=y
CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=y
# CONFIG_QFMT_V2 is not set
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=y
CONFIG_CUSE=y
CONFIG_VIRTIO_FS=y
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=y
CONFIG_NETFS_STATS=y
CONFIG_FSCACHE=y
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_DEBUG is not set
CONFIG_CACHEFILES=y
CONFIG_CACHEFILES_DEBUG=y
# end of Caches

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
CONFIG_UDF_FS=y
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_VFAT_FS is not set
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_KUNIT_TEST=y
CONFIG_EXFAT_FS=y
CONFIG_EXFAT_DEFAULT_IOCHARSET="utf8"
CONFIG_NTFS_FS=y
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
# CONFIG_NTFS3_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
CONFIG_ORANGEFS_FS=y
CONFIG_ADFS_FS=y
# CONFIG_ADFS_FS_RW is not set
CONFIG_AFFS_FS=y
CONFIG_ECRYPT_FS=y
CONFIG_ECRYPT_FS_MESSAGING=y
CONFIG_HFS_FS=y
CONFIG_HFSPLUS_FS=y
CONFIG_BEFS_FS=y
# CONFIG_BEFS_DEBUG is not set
CONFIG_BFS_FS=y
# CONFIG_EFS_FS is not set
CONFIG_JFFS2_FS=y
CONFIG_JFFS2_FS_DEBUG=0
CONFIG_JFFS2_FS_WRITEBUFFER=y
CONFIG_JFFS2_FS_WBUF_VERIFY=y
# CONFIG_JFFS2_SUMMARY is not set
CONFIG_JFFS2_FS_XATTR=y
# CONFIG_JFFS2_FS_POSIX_ACL is not set
CONFIG_JFFS2_FS_SECURITY=y
CONFIG_JFFS2_COMPRESSION_OPTIONS=y
CONFIG_JFFS2_ZLIB=y
CONFIG_JFFS2_LZO=y
CONFIG_JFFS2_RTIME=y
CONFIG_JFFS2_RUBIN=y
# CONFIG_JFFS2_CMODE_NONE is not set
# CONFIG_JFFS2_CMODE_PRIORITY is not set
# CONFIG_JFFS2_CMODE_SIZE is not set
CONFIG_JFFS2_CMODE_FAVOURLZO=y
CONFIG_UBIFS_FS=y
CONFIG_UBIFS_FS_ADVANCED_COMPR=y
# CONFIG_UBIFS_FS_LZO is not set
CONFIG_UBIFS_FS_ZLIB=y
CONFIG_UBIFS_FS_ZSTD=y
CONFIG_UBIFS_ATIME_SUPPORT=y
CONFIG_UBIFS_FS_XATTR=y
CONFIG_UBIFS_FS_SECURITY=y
# CONFIG_UBIFS_FS_AUTHENTICATION is not set
# CONFIG_CRAMFS is not set
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
# CONFIG_SQUASHFS_XATTR is not set
CONFIG_SQUASHFS_ZLIB=y
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
CONFIG_SQUASHFS_ZSTD=y
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
CONFIG_SQUASHFS_EMBEDDED=y
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
CONFIG_VXFS_FS=y
CONFIG_MINIX_FS=y
# CONFIG_OMFS_FS is not set
CONFIG_HPFS_FS=y
CONFIG_QNX4FS_FS=y
CONFIG_QNX6FS_FS=y
# CONFIG_QNX6FS_DEBUG is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
CONFIG_PSTORE_LZ4_COMPRESS=y
CONFIG_PSTORE_LZ4HC_COMPRESS=y
CONFIG_PSTORE_842_COMPRESS=y
CONFIG_PSTORE_ZSTD_COMPRESS=y
CONFIG_PSTORE_COMPRESS=y
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_842_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="zstd"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=y
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=y
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
CONFIG_NFS_SWAP=y
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
CONFIG_NFS_FSCACHE=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
CONFIG_NFSD=y
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_SUNRPC_SWAP=y
CONFIG_SUNRPC_DEBUG=y
CONFIG_SUNRPC_XPRT_RDMA=y
CONFIG_CEPH_FS=y
CONFIG_CEPH_FSCACHE=y
# CONFIG_CEPH_FS_POSIX_ACL is not set
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_SMB_DIRECT is not set
# CONFIG_CIFS_FSCACHE is not set
CONFIG_SMB_SERVER=y
# CONFIG_SMB_SERVER_SMBDIRECT is not set
CONFIG_SMB_SERVER_CHECK_CAP_NET_ADMIN=y
# CONFIG_SMB_SERVER_KERBEROS5 is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
CONFIG_AFS_FS=y
CONFIG_AFS_DEBUG=y
CONFIG_AFS_FSCACHE=y
# CONFIG_AFS_DEBUG_CURSOR is not set
CONFIG_9P_FS=y
CONFIG_9P_FSCACHE=y
# CONFIG_9P_FS_POSIX_ACL is not set
CONFIG_9P_FS_SECURITY=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
CONFIG_NLS_CODEPAGE_775=y
# CONFIG_NLS_CODEPAGE_850 is not set
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=y
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=y
CONFIG_NLS_CODEPAGE_862=y
CONFIG_NLS_CODEPAGE_863=y
CONFIG_NLS_CODEPAGE_864=y
# CONFIG_NLS_CODEPAGE_865 is not set
CONFIG_NLS_CODEPAGE_866=y
CONFIG_NLS_CODEPAGE_869=y
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
CONFIG_NLS_CODEPAGE_932=y
CONFIG_NLS_CODEPAGE_949=y
CONFIG_NLS_CODEPAGE_874=y
CONFIG_NLS_ISO8859_8=y
CONFIG_NLS_CODEPAGE_1250=y
CONFIG_NLS_CODEPAGE_1251=y
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_2=y
CONFIG_NLS_ISO8859_3=y
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
CONFIG_NLS_ISO8859_9=y
CONFIG_NLS_ISO8859_13=y
CONFIG_NLS_ISO8859_14=y
CONFIG_NLS_ISO8859_15=y
CONFIG_NLS_KOI8_R=y
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_MAC_ROMAN=y
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=y
# CONFIG_NLS_MAC_CROATIAN is not set
CONFIG_NLS_MAC_CYRILLIC=y
# CONFIG_NLS_MAC_GAELIC is not set
CONFIG_NLS_MAC_GREEK=y
CONFIG_NLS_MAC_ICELAND=y
CONFIG_NLS_MAC_INUIT=y
# CONFIG_NLS_MAC_ROMANIAN is not set
CONFIG_NLS_MAC_TURKISH=y
CONFIG_NLS_UTF8=y
# CONFIG_DLM is not set
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
# CONFIG_TRUSTED_KEYS is not set
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
# CONFIG_SECURITY_INFINIBAND is not set
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
# CONFIG_SECURITY_APPARMOR_HASH is not set
CONFIG_SECURITY_APPARMOR_DEBUG=y
# CONFIG_SECURITY_APPARMOR_DEBUG_ASSERTS is not set
CONFIG_SECURITY_APPARMOR_DEBUG_MESSAGES=y
# CONFIG_SECURITY_APPARMOR_KUNIT_TEST is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
CONFIG_SECURITY_SAFESETID=y
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_SECURITY_LANDLOCK=y
# CONFIG_INTEGRITY is not set
CONFIG_DEFAULT_SECURITY_APPARMOR=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_MEMCPY=y
CONFIG_ASYNC_XOR=y
CONFIG_ASYNC_PQ=y
CONFIG_ASYNC_RAID6_RECOV=y
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=y
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=y
# CONFIG_CRYPTO_ECDH is not set
# CONFIG_CRYPTO_ECDSA is not set
# CONFIG_CRYPTO_ECRDSA is not set
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=y

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=y
CONFIG_CRYPTO_GCM=y
CONFIG_CRYPTO_CHACHA20POLY1305=y
CONFIG_CRYPTO_AEGIS128=y
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=y

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=y
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
CONFIG_CRYPTO_OFB=y
CONFIG_CRYPTO_PCBC=y
# CONFIG_CRYPTO_XTS is not set
CONFIG_CRYPTO_KEYWRAP=y
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_ADIANTUM=y
CONFIG_CRYPTO_ESSIV=y

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=y
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=y
CONFIG_CRYPTO_CRC32=y
CONFIG_CRYPTO_CRC32_PCLMUL=y
CONFIG_CRYPTO_XXHASH=y
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_BLAKE2S=y
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_GHASH=y
CONFIG_CRYPTO_POLY1305=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_STREEBOG=y
CONFIG_CRYPTO_WP512=y

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_BLOWFISH_COMMON=y
# CONFIG_CRYPTO_CAMELLIA is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_FCRYPT=y
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_586 is not set
CONFIG_CRYPTO_SM4=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_TWOFISH_COMMON=y
# CONFIG_CRYPTO_TWOFISH_586 is not set

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
CONFIG_CRYPTO_842=y
CONFIG_CRYPTO_LZ4=y
CONFIG_CRYPTO_LZ4HC=y
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=y
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
# CONFIG_CRYPTO_USER_API_HASH is not set
CONFIG_CRYPTO_USER_API_SKCIPHER=y
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_LIB_BLAKE2S=y
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=1
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=y
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_LIB_SM4=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=y
CONFIG_CRYPTO_DEV_PADLOCK_AES=y
CONFIG_CRYPTO_DEV_PADLOCK_SHA=y
CONFIG_CRYPTO_DEV_GEODE=y
CONFIG_CRYPTO_DEV_HIFN_795X=y
CONFIG_CRYPTO_DEV_HIFN_795X_RNG=y
CONFIG_CRYPTO_DEV_ATMEL_I2C=y
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=y
CONFIG_CRYPTO_DEV_CCP=y
# CONFIG_CRYPTO_DEV_CCP_DD is not set
CONFIG_CRYPTO_DEV_QAT=y
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
CONFIG_CRYPTO_DEV_QAT_C3XXX=y
CONFIG_CRYPTO_DEV_QAT_C62X=y
CONFIG_CRYPTO_DEV_QAT_4XXX=y
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=y
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
CONFIG_CRYPTO_DEV_CHELSIO=y
CONFIG_CRYPTO_DEV_VIRTIO=y
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_PKCS7_TEST_KEY=y
# CONFIG_SIGNED_PE_FILE_VERIFICATION is not set

#
# Certificates for signature checking
#
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=y
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=y
CONFIG_PRIME_NUMBERS=y
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
CONFIG_CRC32_SELFTEST=y
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=y
# CONFIG_CRC4 is not set
CONFIG_CRC7=y
CONFIG_LIBCRC32C=y
CONFIG_CRC8=y
CONFIG_XXHASH=y
CONFIG_AUDIT_GENERIC=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=y
CONFIG_842_DECOMPRESS=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_COMPRESS=y
CONFIG_LZ4HC_COMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
CONFIG_XZ_DEC_TEST=y
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=y
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=y
CONFIG_BCH_CONST_PARAMS=y
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_PERCENTAGE=0
# CONFIG_CMA_SIZE_SEL_MBYTES is not set
CONFIG_CMA_SIZE_SEL_PERCENTAGE=y
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_DMA_MAP_BENCHMARK is not set
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_32=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONT_8x16=y
CONFIG_FONT_AUTOSELECT=y
CONFIG_SG_POOL=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=1024
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_FRAME_POINTER=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
# CONFIG_DEBUG_FS_ALLOW_ALL is not set
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
CONFIG_DEBUG_FS_ALLOW_NONE=y
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ONLY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_DIV_ZERO is not set
CONFIG_UBSAN_UNREACHABLE=y
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
# CONFIG_DEBUG_KMAP_LOCAL is not set
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_HAVE_ARCH_KFENCE=y
CONFIG_KFENCE=y
CONFIG_KFENCE_SAMPLE_INTERVAL=100
CONFIG_KFENCE_NUM_OBJECTS=255
CONFIG_KFENCE_STRESS_TEST_FAULTS=0
# CONFIG_KFENCE_KUNIT_TEST is not set
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=y
# CONFIG_SCF_TORTURE_TEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
# CONFIG_DEBUG_IRQFLAGS is not set
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
CONFIG_BUG_ON_DATA_CORRUPTION=y
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_TRACE=y
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
# CONFIG_FUNCTION_GRAPH_TRACER is not set
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
# CONFIG_FUNCTION_PROFILER is not set
# CONFIG_STACK_TRACER is not set
CONFIG_IRQSOFF_TRACER=y
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=y
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_TRACE_BRANCH_PROFILING=y
# CONFIG_BRANCH_PROFILE_NONE is not set
CONFIG_PROFILE_ANNOTATED_BRANCHES=y
CONFIG_TRACING_BRANCHES=y
CONFIG_BRANCH_TRACER=y
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_CC=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=y
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_FTRACE_RECORD_RECURSION=y
CONFIG_FTRACE_RECORD_RECURSION_SIZE=128
# CONFIG_RING_BUFFER_RECORD_RECURSION is not set
CONFIG_GCOV_PROFILE_FTRACE=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS=y
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
CONFIG_HIST_TRIGGERS_DEBUG=y
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_DEBUG_TLBFLUSH is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
CONFIG_PUNIT_ATOM_DEBUG=y
CONFIG_UNWINDER_FRAME_POINTER=y
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
CONFIG_KUNIT=y
# CONFIG_KUNIT_DEBUGFS is not set
CONFIG_KUNIT_TEST=y
CONFIG_KUNIT_EXAMPLE_TEST=y
# CONFIG_KUNIT_ALL_TESTS is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
CONFIG_STRING_SELFTEST=y
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=y
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=y
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
CONFIG_TEST_SYSCTL=y
CONFIG_BITFIELD_KUNIT=y
# CONFIG_RESOURCE_KUNIT_TEST is not set
# CONFIG_SYSCTL_KUNIT_TEST is not set
CONFIG_LIST_KUNIT_TEST=y
# CONFIG_LINEAR_RANGES_TEST is not set
CONFIG_CMDLINE_KUNIT_TEST=y
# CONFIG_BITS_TEST is not set
CONFIG_RATIONAL_KUNIT_TEST=y
# CONFIG_MEMCPY_KUNIT_TEST is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
CONFIG_TEST_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_USE_MEMTEST=y
CONFIG_MEMTEST=y
# end of Kernel Testing and Coverage
# end of Kernel hacking

--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='boot'
	export testcase='boot'
	export category='functional'
	export timeout='10m'
	export job_origin='boot.yaml'
	export queue_cmdline_keys='branch
commit'
	export queue='validate'
	export testbox='vm-icl-48'
	export tbox_group='vm-icl'
	export branch='linux-review/Yang-Li/net-phy-micrel-use-min-macro-instead-of-doing-it-manually/20211224-171618'
	export commit='b93acee44e1a2b541ffe5ae1dda6be3d6f65987f'
	export kconfig='i386-randconfig-a002-20211003'
	export repeat_to=6
	export nr_vm=160
	export submit_id='61db64f0d74c5e45c60a0b77'
	export job_file='/lkp/jobs/scheduled/vm-icl-48/boot-1-debian-i386-20191205.cgz-b93acee44e1a2b541ffe5ae1dda6be3d6f65987f-20220110-83398-mubg82-5.yaml'
	export id='0842193a3a3258934d786b8f693a1749ef961499'
	export queuer_version='/lkp-src'
	export model='qemu-system-x86_64 -enable-kvm -cpu Icelake-Server'
	export nr_cpu=4
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23600
	export kernel_cmdline='vmalloc=128M initramfs_async=0 page_owner=on'
	export rootfs='debian-i386-20191205.cgz'
	export compiler='gcc-9'
	export enqueue_time='2022-01-10 06:42:56 +0800'
	export _id='61db6502d74c5e45c60a0b79'
	export _rt='/result/boot/1/vm-icl/debian-i386-20191205.cgz/i386-randconfig-a002-20211003/gcc-9/b93acee44e1a2b541ffe5ae1dda6be3d6f65987f'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/boot/1/vm-icl/debian-i386-20191205.cgz/i386-randconfig-a002-20211003/gcc-9/b93acee44e1a2b541ffe5ae1dda6be3d6f65987f/3'
	export scheduler_version='/lkp/lkp/.src-20220107-102621'
	export arch='i386'
	export max_uptime=600
	export initrd='/osimage/debian/debian-i386-20191205.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/1/vm-icl/debian-i386-20191205.cgz/i386-randconfig-a002-20211003/gcc-9/b93acee44e1a2b541ffe5ae1dda6be3d6f65987f/3
BOOT_IMAGE=/pkg/linux/i386-randconfig-a002-20211003/gcc-9/b93acee44e1a2b541ffe5ae1dda6be3d6f65987f/vmlinuz-5.16.0-rc6-00051-gb93acee44e1a
branch=linux-review/Yang-Li/net-phy-micrel-use-min-macro-instead-of-doing-it-manually/20211224-171618
job=/lkp/jobs/scheduled/vm-icl-48/boot-1-debian-i386-20191205.cgz-b93acee44e1a2b541ffe5ae1dda6be3d6f65987f-20220110-83398-mubg82-5.yaml
user=lkp
ARCH=i386
kconfig=i386-randconfig-a002-20211003
commit=b93acee44e1a2b541ffe5ae1dda6be3d6f65987f
vmalloc=128M initramfs_async=0 page_owner=on
max_uptime=600
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/i386-randconfig-a002-20211003/gcc-9/b93acee44e1a2b541ffe5ae1dda6be3d6f65987f/modules.cgz'
	export bm_initrd='/osimage/deps/debian-i386-20191205.cgz/lkp_20201203.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export kernel='/pkg/linux/i386-randconfig-a002-20211003/gcc-9/b93acee44e1a2b541ffe5ae1dda6be3d6f65987f/vmlinuz-5.16.0-rc6-00051-gb93acee44e1a'
	export dequeue_time='2022-01-10 06:47:44 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-icl-48/boot-1-debian-i386-20191205.cgz-b93acee44e1a2b541ffe5ae1dda6be3d6f65987f-20220110-83398-mubg82-5.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper sleep 1
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper boot-slabinfo
	$LKP_SRC/stats/wrapper boot-meminfo
	$LKP_SRC/stats/wrapper memmap
	$LKP_SRC/stats/wrapper boot-memory
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper kernel-size
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper sleep
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--0ntfKIWw70PvrIHh
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
scRn+wIAAAAABFla

--0ntfKIWw70PvrIHh--
