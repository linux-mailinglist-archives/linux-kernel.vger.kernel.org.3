Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B7D489F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 19:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241316AbiAJSgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 13:36:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43488 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243461AbiAJSfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 13:35:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 787D661338;
        Mon, 10 Jan 2022 18:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62EDC36AE3;
        Mon, 10 Jan 2022 18:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641839729;
        bh=1VUPCtUzqqWqJ/NTUreqHZAfyQUNWCk/Z3kkWgGgK3I=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=HAk7ECSdpYT282lXarSCgQ4qYWlpCO/VHGuBEmgLSSf1mbO+og7QcjRE6rsbYkW3R
         w+8Z/pe8qZAlTxz3qNxh2HAzd/QO7EAX/Upmm7rRelXGo2NGQfmLL2dUp3E5C50kS5
         0i4b90LoH3pABQkphxkgVEErZ4KKlOreu8FS7Sgzs5yrjYJ+T7h8nzrltf1iJfqnUi
         Qsfa0o3N+tQTCwkDcs9M/aY1BaI4KH0qEBfbo8kZvQ2C1OeVi7XdHC+h2y0H/mXEJW
         pPAfQ4hw/L0nht2HR+bPI6QrpOsvSz/hqAS64Db1RlgYNF5z76dxDZEQKRSh5WlDFW
         l58DpMQWHJIXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8FBE85C0388; Mon, 10 Jan 2022 10:35:29 -0800 (PST)
Date:   Mon, 10 Jan 2022 10:35:29 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com
Subject: [GIT PULL] RCU changes for v5.17
Message-ID: <20220110183529.GA1012375@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Please pull the latest RCU git tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2022.01.09a
  # HEAD: f80fe66c38d561a006fb4f514b0ee5d11cbe2673 Merge branches 'doc.2021.11.30c', 'exp.2021.12.07a', 'fastnohz.2021.11.30c', 'fixes.2021.11.30c', 'nocb.2021.12.09a', 'nolibc.2021.11.30c', 'tasks.2021.12.09a', 'torture.2021.12.07a' and 'torturescript.2021.11.30c' into HEAD

RCU changes for this cycle were:

doc.2021.11.30c: Documentation updates, perhaps most notably Neil Brown's
	writeup of the reference-counting analogy to RCU.

exp.2021.12.07a: Expedited grace-period cleanups.

fastnohz.2021.11.30c: Remove CONFIG_RCU_FAST_NO_HZ due to lack of valid
	users. I have asked around, posted a blog entry, and sent this
	series to LKML without result.

fixes.2021.11.30c: Miscellaneous fixes.

nocb.2021.12.09a: RCU callback offloading updates, perhaps most notably
	Frederic Weisbecker's updates allowing CPUs booted in the
	de-offloaded state to be offloaded at runtime.

nolibc.2021.11.30c: nolibc fixes from Willy Tarreau and Anmar Faizi, but
	also including Mark Brown's addition of gettid().

tasks.2021.12.09a: RCU Tasks Trace fixes, including changes that increase
	the scalability of call_rcu_tasks_trace() for the BPF folks
	(Martin Lau and KP Singh).

torture.2021.12.07a: Various fixes including those from Wander Lairson
	Costa and Li Zhijian.

torturescript.2021.11.30c: Fixes plus addition of tests for the increased
	call_rcu_tasks_trace() scalability.

----------------------------------------------------------------
Akira Yokosawa (1):
      doc: RCU: Avoid 'Symbol' font-family in SVG figures

Ammar Faizi (3):
      tools/nolibc: x86-64: Fix startup code bug
      tools/nolibc: x86: Remove `r8`, `r9` and `r10` from the clobber list
      tools/nolibc: x86-64: Use `mov $60,%eax` instead of `mov $60,%rax`

Changbin Du (1):
      rcu: in_irq() cleanup

Chun-Hung Tseng (1):
      rcu: Replace ________p1 and _________p1 with __UNIQUE_ID(rcu)

Frederic Weisbecker (20):
      rcu: Ignore rdp.cpu_no_qs.b.exp on preemptible RCU's rcu_qs()
      rcu: Move rcu_data.cpu_no_qs.b.exp reset to rcu_export_exp_rdp()
      rcu: Remove rcu_data.exp_deferred_qs and convert to rcu_data.cpu no_qs.b.exp
      rcu/exp: Mark current CPU as exp-QS in IPI loop second pass
      rcu/nocb: Make local rcu_nocb_lock_irqsave() safe against concurrent deoffloading
      rcu/nocb: Prepare state machine for a new step
      rcu/nocb: Invoke rcu_core() at the start of deoffloading
      rcu/nocb: Make rcu_core() callbacks acceleration (de-)offloading safe
      rcu/nocb: Check a stable offloaded state to manipulate qlen_last_fqs_check
      rcu/nocb: Use appropriate rcu_nocb_lock_irqsave()
      rcu/nocb: Limit number of softirq callbacks only on softirq
      rcu: Fix callbacks processing time limit retaining cond_resched()
      rcu: Apply callbacks processing time limit only on softirq
      rcu/nocb: Don't invoke local rcu core on callback overload from nocb kthread
      rcu/nocb: Remove rcu_node structure from nocb list when de-offloaded
      rcu/nocb: Prepare nocb_cb_wait() to start with a non-offloaded rdp
      rcu/nocb: Optimize kthreads and rdp initialization
      rcu/nocb: Create kthreads on all CPUs if "rcu_nocbs=" or "nohz_full=" are passed
      rcu/nocb: Allow empty "rcu_nocbs" kernel parameter
      rcu/nocb: Merge rcu_spawn_cpu_nocb_kthread() and rcu_spawn_one_nocb_kthread()

Jun Miao (1):
      rcu: Avoid alloc_pages() when recording stack

Li Zhijian (9):
      refscale: Simplify the errexit checkpoint
      refscale: Prevent buffer to pr_alert() being too long
      refscale: Always log the error message
      refscale: Add missing '\n' to flush message
      scftorture: Add missing '\n' to flush message
      scftorture: Remove unused SCFTORTOUT
      rcuscale: Always log error message
      scftorture: Always log error message
      locktorture,rcutorture,torture: Always log error message

Mark Brown (1):
      tools/nolibc: Implement gettid()

Neeraj Upadhyay (1):
      rcu-tasks: Inspect stalled task's trc state in locked state

NeilBrown (1):
      doc: Add refcount analogy to What is RCU

Paul E. McKenney (43):
      rcutorture: Add CONFIG_PREEMPT_DYNAMIC=n to tiny scenarios
      doc: Remove obsolete kernel-per-CPU-kthreads RCU_FAST_NO_HZ advice
      torture: Remove RCU_FAST_NO_HZ from rcuscale and refscale scenarios
      torture: Remove RCU_FAST_NO_HZ from rcu scenarios
      rcu: Remove the RCU_FAST_NO_HZ Kconfig option
      rcu: Move rcu_needs_cpu() to tree.c
      srcu: Prevent redundant __srcu_read_unlock() wakeup
      rcu-tasks: Don't remove tasks with pending IPIs from holdout list
      rcutorture: Sanitize RCUTORTURE_RDR_MASK
      rcutorture: More thoroughly test nested readers
      rcutorture: Suppress pi-lock-across read-unlock testing for Tiny SRCU
      torture: Catch kvm.sh help text up with actual options
      torture: Make kvm-find-errors.sh report link-time undefined symbols
      torture: Retry download once before giving up
      rcutorture: Cause TREE02 and TREE10 scenarios to do more callback flooding
      rcutorture: Test RCU Tasks lock-contention detection
      torture: Fix incorrectly redirected "exit" in kvm-remote.sh
      torture: Properly redirect kvm-remote.sh "echo" commands
      rcu: Mark sync_sched_exp_online_cleanup() ->cpu_no_qs.b.exp load
      rcu: Prevent expedited GP from enabling tick on offline CPU
      rcu: Make idle entry report expedited quiescent states
      rcu: Tighten rcu_advance_cbs_nowake() checks
      rcu-tasks: Create per-CPU callback lists
      rcu-tasks: Introduce ->percpu_enqueue_shift for dynamic queue selection
      rcu-tasks: Convert grace-period counter to grace-period sequence number
      rcu_tasks: Convert bespoke callback list to rcu_segcblist structure
      rcutorture: Test RCU-tasks multiqueue callback queueing
      rcutorture: Enable multiple concurrent callback-flood kthreads
      rcutorture: Add ability to limit callback-flood intensity
      rcutorture: Combine n_max_cbs from all kthreads in a callback flood
      rcu-tasks: Use spin_lock_rcu_node() and friends
      rcu-tasks: Add a ->percpu_enqueue_lim to the rcu_tasks structure
      rcu-tasks: Abstract checking of callback lists
      rcu-tasks: Abstract invocations of callbacks
      rcu-tasks: Use workqueues for multiple rcu_tasks_invoke_cbs() invocations
      rcu-tasks: Make rcu_barrier_tasks*() handle multiple callback queues
      rcu-tasks: Add rcupdate.rcu_task_enqueue_lim to set initial queueing
      rcu-tasks: Count trylocks to estimate call_rcu_tasks() contention
      rcu-tasks: Avoid raw-spinlocked wakeups from call_rcu_tasks_generic()
      rcu-tasks: Use more callback queues if contention encountered
      rcu-tasks: Use separate ->percpu_dequeue_lim for callback dequeueing
      rcu-tasks: Use fewer callbacks queues if callback flood ends
      Merge branches 'doc.2021.11.30c', 'exp.2021.12.07a', 'fastnohz.2021.11.30c', 'fixes.2021.11.30c', 'nocb.2021.12.09a', 'nolibc.2021.11.30c', 'tasks.2021.12.09a', 'torture.2021.12.07a' and 'torturescript.2021.11.30c' into HEAD

Thomas Gleixner (1):
      rcu/nocb: Make rcu_core() callbacks acceleration preempt-safe

Wander Lairson Costa (1):
      rcutorture: Avoid soft lockup during cpu stall

Willy Tarreau (2):
      tools/nolibc: i386: fix initial stack alignment
      tools/nolibc: fix incorrect truncation of exit code

Zhouyi Zhou (1):
      rcu: Improve tree_plugin.h comments and add code cleanups

Zqiang (1):
      rcu: Avoid running boost kthreads on isolated CPUs

 .../RCU/Design/Expedited-Grace-Periods/Funnel0.svg |   4 +-
 .../RCU/Design/Expedited-Grace-Periods/Funnel1.svg |   4 +-
 .../RCU/Design/Expedited-Grace-Periods/Funnel2.svg |   4 +-
 .../RCU/Design/Expedited-Grace-Periods/Funnel3.svg |   4 +-
 .../RCU/Design/Expedited-Grace-Periods/Funnel4.svg |   4 +-
 .../RCU/Design/Expedited-Grace-Periods/Funnel5.svg |   4 +-
 .../RCU/Design/Expedited-Grace-Periods/Funnel6.svg |   4 +-
 .../RCU/Design/Expedited-Grace-Periods/Funnel7.svg |   4 +-
 .../RCU/Design/Expedited-Grace-Periods/Funnel8.svg |   4 +-
 .../Design/Requirements/GPpartitionReaders1.svg    |  36 +-
 .../Design/Requirements/ReadersPartitionGP1.svg    |  62 +--
 Documentation/RCU/stallwarn.rst                    |  11 -
 Documentation/RCU/whatisRCU.rst                    |  90 +++-
 Documentation/admin-guide/kernel-parameters.txt    |  70 ++-
 .../admin-guide/kernel-per-CPU-kthreads.rst        |   2 +-
 Documentation/timers/no_hz.rst                     |  10 +-
 include/linux/rcu_segcblist.h                      |  51 ++-
 include/linux/rcupdate.h                           |  50 ++-
 include/linux/rcutiny.h                            |   2 +-
 include/linux/srcu.h                               |   3 +-
 include/linux/torture.h                            |   9 +-
 kernel/locking/locktorture.c                       |   4 +-
 kernel/rcu/Kconfig                                 |  20 +-
 kernel/rcu/rcu_segcblist.c                         |  10 +-
 kernel/rcu/rcu_segcblist.h                         |  12 +-
 kernel/rcu/rcuscale.c                              |  14 +-
 kernel/rcu/rcutorture.c                            | 234 +++++++---
 kernel/rcu/refscale.c                              |  50 ++-
 kernel/rcu/srcutiny.c                              |   2 +-
 kernel/rcu/tasks.h                                 | 476 +++++++++++++++++----
 kernel/rcu/tree.c                                  | 131 ++++--
 kernel/rcu/tree.h                                  |  31 +-
 kernel/rcu/tree_exp.h                              |  14 +-
 kernel/rcu/tree_nocb.h                             | 160 ++++---
 kernel/rcu/tree_plugin.h                           | 250 ++---------
 kernel/rcu/tree_stall.h                            |  27 +-
 kernel/scftorture.c                                |  16 +-
 kernel/torture.c                                   |   4 +-
 tools/include/nolibc/nolibc.h                      |  86 ++--
 .../selftests/rcutorture/bin/kvm-find-errors.sh    |   4 +-
 .../selftests/rcutorture/bin/kvm-recheck-rcu.sh    |   2 +-
 .../testing/selftests/rcutorture/bin/kvm-remote.sh |  23 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |   9 +-
 .../selftests/rcutorture/bin/parse-build.sh        |   3 +-
 .../selftests/rcutorture/configs/rcu/SRCU-T        |   1 +
 .../selftests/rcutorture/configs/rcu/SRCU-U        |   1 +
 .../selftests/rcutorture/configs/rcu/TASKS01.boot  |   1 +
 .../selftests/rcutorture/configs/rcu/TINY01        |   1 +
 .../selftests/rcutorture/configs/rcu/TINY02        |   1 +
 .../selftests/rcutorture/configs/rcu/TRACE01.boot  |   1 +
 .../selftests/rcutorture/configs/rcu/TRACE02.boot  |   1 +
 .../selftests/rcutorture/configs/rcu/TREE01        |   1 -
 .../selftests/rcutorture/configs/rcu/TREE02        |   1 -
 .../selftests/rcutorture/configs/rcu/TREE02.boot   |   1 +
 .../selftests/rcutorture/configs/rcu/TREE04        |   1 -
 .../selftests/rcutorture/configs/rcu/TREE05        |   1 -
 .../selftests/rcutorture/configs/rcu/TREE06        |   1 -
 .../selftests/rcutorture/configs/rcu/TREE07        |   1 -
 .../selftests/rcutorture/configs/rcu/TREE08        |   1 -
 .../selftests/rcutorture/configs/rcu/TREE10        |   1 -
 .../selftests/rcutorture/configs/rcu/TREE10.boot   |   1 +
 .../selftests/rcutorture/configs/rcuscale/TINY     |   2 +-
 .../selftests/rcutorture/configs/rcuscale/TRACE01  |   1 -
 .../selftests/rcutorture/configs/rcuscale/TREE     |   1 -
 .../selftests/rcutorture/configs/rcuscale/TREE54   |   1 -
 .../rcutorture/configs/refscale/NOPREEMPT          |   1 -
 .../selftests/rcutorture/configs/refscale/PREEMPT  |   1 -
 .../selftests/rcutorture/doc/TREE_RCU-kconfig.txt  |   1 -
 68 files changed, 1244 insertions(+), 795 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE02.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREE10.boot
