Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14F1585FFF
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiGaQxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiGaQxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:53:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972CA22F;
        Sun, 31 Jul 2022 09:53:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37C8AB80DA4;
        Sun, 31 Jul 2022 16:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A49C433D6;
        Sun, 31 Jul 2022 16:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659286387;
        bh=fAEH+bjEjRQ2zszabYpd7fiD6nuaHwztQpbKz75giQw=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=fd1fazu6T8oeJOA482GeLL3u3VFBJD+Eo1khcegEE+CbsVFY3l8ekl14V7D0ZgfFD
         01p4scXTbIf6Ps9xP94VoHmi4RzmdzGanJPbqYQ9dqXwBb6ODfmHFK+8PUV5V3ceh2
         x1KZ45fOpvhHxDJFJwThReV5nQ35pQaUFyB69bZoMnQUyhVD+65nenK4YEURnDXQol
         yzvPUWUYGo2kKXl7wTN2BQjvSrSQXLE0qAUKQRx9alglngJFv76kmhKGAdUv18qi0U
         j8CINFP55+3aDBoYHWrfYQiOL/Rb/XDM0L0GCPNrAR2ZHbpeTch7Iv3r8MBLLLReIm
         ONM8jHq77k6gw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8C2F65C0514; Sun, 31 Jul 2022 09:53:06 -0700 (PDT)
Date:   Sun, 31 Jul 2022 09:53:06 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com
Subject: RCU changes for v5.20 (or whatever)
Message-ID: <20220731165306.GA3033361@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Once the merge window opens, please pull the latest RCU git tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2022.07.26a
  # HEAD: 34bc7b454dc31f75a0be7ee8ab378135523d7c51: Merge branch 'ctxt.2022.07.05a' into HEAD (2022-07-21 17:46:18 -0700)

There are really six more branches for a total of seven, but the other
six had to be merged separately as the parent of the above commit here:

d38c8fe48354 ("Merge branches 'doc.2022.06.21a', 'fixes.2022.07.19a', 'nocb.2022.07.19a', 'poll.2022.07.21a', 'rcu-tasks.2022.06.21a' and 'torture.2022.06.21a' into HEAD

Stephen Rothwell located a conflict with these two commits, the latter
already in mainline:

24a9c54182b3 ("context_tracking: Split user tracking Kconfig")
7fd6ef61a5d6 ("LoongArch: Drop these obsolete selects in Kconfig")

The branch resolution.2022.07.26a in -rcu provides a sample merge using
Stephen's suggested merge-conflict fix:

https://lore.kernel.org/all/20220708141246.43111241@canb.auug.org.au/

----------------------------------------------------------------
RCU pull request for v5.20 (or whatever)

This pull request contains the following branches:

doc.2022.06.21a: Documentation updates.

fixes.2022.07.19a: Miscellaneous fixes.

nocb.2022.07.19a: Callback-offload updates, perhaps most notably a new
	RCU_NOCB_CPU_DEFAULT_ALL Kconfig option that causes all CPUs to
	be offloaded at boot time, regardless of kernel boot parameters.
	This is useful to battery-powered systems such as ChromeOS
	and Android.  In addition, a new RCU_NOCB_CPU_CB_BOOST kernel
	boot parameter prevents offloaded callbacks from interfering
	with real-time workloads and with energy-efficiency mechanisms.

poll.2022.07.21a: Polled grace-period updates, perhaps most notably
	making these APIs account for both normal and expedited grace
	periods.

rcu-tasks.2022.06.21a: Tasks RCU updates, perhaps most notably reducing
	the CPU overhead of RCU tasks trace grace periods by more than
	a factor of two on a system with 15,000 tasks.	The reduction
	is expected to increase with the number of tasks, so it seems
	reasonable to hypothesize that a system with 150,000 tasks might
	see a 20-fold reduction in CPU overhead.

torture.2022.06.21a: Torture-test updates.

ctxt.2022.07.05a: Updates that merge RCU's dyntick-idle tracking into
	context tracking, thus reducing the overhead of transitioning to
	kernel mode from either idle or nohz_full userspace execution
	for kernels that track context independently of RCU.  This is
	expected to be helpful primarily for kernels built with
	CONFIG_NO_HZ_FULL=y.

----------------------------------------------------------------
Anna-Maria Behnsen (1):
      rcu/torture: Change order of warning and trace dump

Chen Zhongjin (1):
      locking/csd_lock: Change csdlock_debug from early_param to __setup

Frederic Weisbecker (21):
      context_tracking: Remove unused context_tracking_in_user()
      context_tracking: Add a note about noinstr VS unsafe context tracking functions
      rcutorture: Fix ksoftirqd boosting timing and iteration
      context_tracking: Rename __context_tracking_enter/exit() to __ct_user_enter/exit()
      context_tracking: Rename context_tracking_user_enter/exit() to user_enter/exit_callable()
      context_tracking: Rename context_tracking_enter/exit() to ct_user_enter/exit()
      context_tracking: Rename context_tracking_cpu_set() to ct_cpu_track_user()
      context_tracking: Split user tracking Kconfig
      context_tracking: Take idle eqs entrypoints over RCU
      context_tracking: Take IRQ eqs entrypoints over RCU
      context_tracking: Take NMI eqs entrypoints over RCU
      rcu/context-tracking: Remove rcu_irq_enter/exit()
      rcu/context_tracking: Move dynticks counter to context tracking
      rcu/context_tracking: Move dynticks_nesting to context tracking
      rcu/context_tracking: Move dynticks_nmi_nesting to context tracking
      rcu/context-tracking: Move deferred nocb resched to context tracking
      rcu/context-tracking: Move RCU-dynticks internal functions to context_tracking
      rcu/context-tracking: Remove unused and/or unecessary middle functions
      context_tracking: Convert state to atomic_t
      MAINTAINERS: Add Paul as context tracking maintainer
      rcu/nocb: Add/del rdp to iterate from rcuog itself

Joel Fernandes (1):
      rcu/nocb: Add an option to offload all CPUs on boot

Joel Fernandes (Google) (1):
      rcu/kvfree: Remove useless monitor_todo flag

Johannes Berg (1):
      rcu: tiny: Record kvfree_call_rcu() call stack for KASAN

Li Qiong (1):
      rcutorture: Handle failure of memory allocation functions

Neeraj Upadhyay (2):
      srcu: Make expedited RCU grace periods block even less frequently
      rcu/tree: Add comment to describe GP-done condition in fqs loop

Patrick Wang (1):
      rcu: Avoid tracing a few functions executed in stop machine

Paul E. McKenney (57):
      rcu: Make normal polling GP be more precise about sequence numbers
      rcu: Provide a get_completed_synchronize_rcu() function
      rcutorture: Validate get_completed_synchronize_rcu()
      rcu-tasks: Check for abandoned callbacks
      rcu-tasks: Split rcu_tasks_one_gp() from rcu_tasks_kthread()
      rcu-tasks: Move synchronize_rcu_tasks_generic() down
      rcu-tasks: Drive synchronous grace periods from calling task
      rcu-tasks: Merge state into .b.need_qs and atomically update
      rcu-tasks: Remove rcu_tasks_trace_postgp() wait for counter
      rcu-tasks: Make trc_read_check_handler() fetch ->trc_reader_nesting only once
      rcu-tasks: Idle tasks on offline CPUs are in quiescent states
      rcu-tasks: Handle idle tasks for recently offlined CPUs
      rcu-tasks: RCU Tasks Trace grace-period kthread has implicit QS
      rcu-tasks: Make rcu_note_context_switch() unconditionally call rcu_tasks_qs()
      rcu-tasks: Simplify trc_inspect_reader() QS logic
      rcu-tasks: Add slow-IPI indicator to RCU Tasks Trace stall warnings
      rcu-tasks: Flag offline CPUs in RCU Tasks Trace stall warnings
      rcu-tasks: Make RCU Tasks Trace stall warnings print full .b.need_qs field
      rcu-tasks: Make RCU Tasks Trace stall warning handle idle offline tasks
      rcu-tasks: Add data structures for lightweight grace periods
      rcu-tasks: Track blocked RCU Tasks Trace readers
      rcu-tasks: Untrack blocked RCU Tasks Trace at reader end
      rcu-tasks: Add blocked-task indicator to RCU Tasks Trace stall warnings
      rcu-tasks: Move rcu_tasks_trace_pertask() before rcu_tasks_trace_pregp_step()
      rcu-tasks: Avoid rcu_tasks_trace_pertask() duplicate list additions
      rcu-tasks: Scan running tasks for RCU Tasks Trace readers
      rcu-tasks: Pull in tasks blocked within RCU Tasks Trace readers
      rcu-tasks: Stop RCU Tasks Trace from scanning idle tasks
      torture: Make kvm-remote.sh announce which system is being waited on
      rcu: Apply noinstr to rcu_idle_enter() and rcu_idle_exit()
      rcutorture: Update rcutorture.fwd_progress help text
      doc: Document the rcutree.rcu_divisor kernel boot parameter
      doc: Document rcutree.nocb_nobypass_lim_per_jiffy kernel parameter
      rcu-tasks: Stop RCU Tasks Trace from scanning full tasks list
      rcu-tasks: Maintain a count of tasks blocking RCU Tasks Trace grace period
      rcu-tasks: Eliminate RCU Tasks Trace IPIs to online CPUs
      rcu-tasks: Disable and enable CPU hotplug in same function
      rcu-tasks: Update comments
      rcu-tasks: Be more patient for RCU Tasks boot-time testing
      rcutorture: Simplify rcu_torture_read_exit_child() loop
      torture: Adjust to again produce debugging information
      rcutorture: Make failure indication note reader-batch overflow
      torture: Create kvm-check-branches.sh output in proper location
      context_tracking: Use arch_atomic_read() in __ct_state for KASAN
      srcu: Block less aggressively for expedited grace periods
      rcu: Decrease FQS scan wait time in case of callback overloading
      rcu: Forbid RCU_STRICT_GRACE_PERIOD in TINY_RCU kernels
      rcu: Initialize first_gp_fqs at declaration in rcu_gp_fqs()
      rcu: Switch polled grace-period APIs to ->gp_seq_polled
      rcu: Make polled grace-period API account for expedited grace periods
      rcu: Make Tiny RCU grace periods visible to polled APIs
      rcutorture: Verify that polled GP API sees synchronous grace periods
      rcu: Add polled expedited grace-period primitives
      rcutorture: Test polled expedited grace-period primitives
      rcu: Diagnose extended sync_rcu_do_polled_gp() loops
      Merge branches 'doc.2022.06.21a', 'fixes.2022.07.19a', 'nocb.2022.07.19a', 'poll.2022.07.21a', 'rcu-tasks.2022.06.21a' and 'torture.2022.06.21a' into HEAD
      Merge branch 'ctxt.2022.07.05a' into HEAD

Uladzislau Rezki (Sony) (1):
      rcu/nocb: Add option to opt rcuo kthreads out of RT priority

Waiman Long (1):
      rcu-tasks: Use delayed_work to delay rcu_tasks_verify_self_tests()

Zqiang (13):
      rcu: Dump rcuc kthread status for CPUs not reporting quiescent state
      rcutorture: Fix memory leak in rcu_test_debug_objects()
      rcuscale: Fix smp_processor_id()-in-preemptible warnings
      refscale: Convert test_lock spinlock to raw_spinlock
      rcu: Add rnp->cbovldmask check in rcutree_migrate_callbacks()
      rcu: Immediately boost preempted readers for strict grace periods
      rcu: Cleanup RCU urgency state for offline CPU
      rcu/nocb: Invert rcu_state.barrier_mutex VS hotplug lock locking order
      rcu/nocb: Fix NOCB kthreads spawn failure with rcu_nocb_rdp_deoffload() direct call
      rcu: Add nocb_cb_kthread check to rcu_is_callbacks_kthread()
      rcu/nocb: Avoid polling when my_rdp->nocb_head_rdp list is empty
      rcu: Put panic_on_rcu_stall() after expedited RCU CPU stall warnings
      rcu: Add irqs-disabled indicator to expedited RCU CPU stall warnings

 .../RCU/Design/Requirements/Requirements.rst       |  10 +-
 Documentation/RCU/stallwarn.rst                    |   6 +-
 Documentation/admin-guide/kernel-parameters.txt    |  52 ++
 .../time/context-tracking/arch-support.txt         |   6 +-
 MAINTAINERS                                        |   1 +
 arch/Kconfig                                       |   8 +-
 arch/arm/Kconfig                                   |   2 +-
 arch/arm/kernel/entry-common.S                     |   4 +-
 arch/arm/kernel/entry-header.S                     |  12 +-
 arch/arm/mach-imx/cpuidle-imx6q.c                  |   5 +-
 arch/arm64/Kconfig                                 |   2 +-
 arch/arm64/kernel/entry-common.c                   |  14 +-
 arch/csky/Kconfig                                  |   2 +-
 arch/csky/kernel/entry.S                           |   8 +-
 arch/loongarch/Kconfig                             |   2 +-
 arch/mips/Kconfig                                  |   2 +-
 arch/powerpc/Kconfig                               |   2 +-
 arch/powerpc/include/asm/context_tracking.h        |   2 +-
 arch/riscv/Kconfig                                 |   2 +-
 arch/riscv/kernel/entry.S                          |  12 +-
 arch/sparc/Kconfig                                 |   2 +-
 arch/sparc/kernel/rtrap_64.S                       |   2 +-
 arch/x86/Kconfig                                   |   4 +-
 arch/x86/mm/fault.c                                |   2 +-
 arch/xtensa/Kconfig                                |   2 +-
 arch/xtensa/kernel/entry.S                         |   8 +-
 drivers/acpi/processor_idle.c                      |   5 +-
 drivers/cpuidle/cpuidle-psci.c                     |   8 +-
 drivers/cpuidle/cpuidle-riscv-sbi.c                |   8 +-
 drivers/cpuidle/cpuidle.c                          |   9 +-
 include/linux/context_tracking.h                   |  95 +--
 include/linux/context_tracking_irq.h               |  21 +
 include/linux/context_tracking_state.h             | 113 +++-
 include/linux/entry-common.h                       |  10 +-
 include/linux/hardirq.h                            |  12 +-
 include/linux/rcupdate.h                           |  45 +-
 include/linux/rcupdate_trace.h                     |   2 +-
 include/linux/rcutiny.h                            |  27 +-
 include/linux/rcutree.h                            |  11 +-
 include/linux/sched.h                              |   4 +-
 include/linux/tracepoint.h                         |   4 +-
 init/Kconfig                                       |   4 +-
 init/init_task.c                                   |   1 +
 kernel/cfi.c                                       |   4 +-
 kernel/context_tracking.c                          | 617 +++++++++++++++++--
 kernel/cpu_pm.c                                    |   8 +-
 kernel/entry/common.c                              |  16 +-
 kernel/extable.c                                   |   4 +-
 kernel/fork.c                                      |   1 +
 kernel/locking/lockdep.c                           |   2 +-
 kernel/rcu/Kconfig                                 |  31 +
 kernel/rcu/Kconfig.debug                           |   2 +-
 kernel/rcu/rcu.h                                   |  19 +-
 kernel/rcu/rcuscale.c                              |   1 +
 kernel/rcu/rcutorture.c                            | 247 +++++---
 kernel/rcu/refscale.c                              |  18 +-
 kernel/rcu/srcutree.c                              |  98 ++-
 kernel/rcu/tasks.h                                 | 541 ++++++++++-------
 kernel/rcu/tiny.c                                  |  25 +-
 kernel/rcu/tree.c                                  | 660 ++++++---------------
 kernel/rcu/tree.h                                  |  21 +-
 kernel/rcu/tree_exp.h                              | 115 +++-
 kernel/rcu/tree_nocb.h                             | 266 ++++++---
 kernel/rcu/tree_plugin.h                           |  82 +--
 kernel/rcu/tree_stall.h                            |  55 +-
 kernel/rcu/update.c                                |  15 +-
 kernel/sched/core.c                                |  34 +-
 kernel/sched/idle.c                                |  10 +-
 kernel/sched/sched.h                               |   1 +
 kernel/smp.c                                       |   4 +-
 kernel/softirq.c                                   |   4 +-
 kernel/time/Kconfig                                |  37 +-
 kernel/time/tick-sched.c                           |   2 +-
 kernel/trace/trace.c                               |   8 +-
 .../selftests/rcutorture/bin/kvm-check-branches.sh |  11 +-
 .../testing/selftests/rcutorture/bin/kvm-remote.sh |   1 +
 tools/testing/selftests/rcutorture/bin/kvm.sh      |   6 +-
 77 files changed, 2216 insertions(+), 1303 deletions(-)
 create mode 100644 include/linux/context_tracking_irq.h
