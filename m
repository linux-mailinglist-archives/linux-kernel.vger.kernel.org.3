Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208AE52F207
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352403AbiETSGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbiETSGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:06:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC0EB82F9;
        Fri, 20 May 2022 11:06:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CAAE6177D;
        Fri, 20 May 2022 18:06:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AEBC385A9;
        Fri, 20 May 2022 18:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653069994;
        bh=G28jhpLFmFvIyq89GzOQqrkV1FHK74KHCwfIDXJpj04=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=lhlDF30tz3k3dlAMG6MksvHxo+HIlg49dUySlMD/p1DlQ7s6tkt2xk5ZT6CmyJ8Go
         yQzCJuMjGKeT4MnwcCCHY64RBv+L7KWe9Aycl6jzYbBwpCExbGLgbRln4ooFZbk7N2
         QM/dc7qs08TsXG5SAklLxJXmOfIWHuJzJcwYaDFuxZjVQPJDQD9g4muTikixofhWnZ
         2KtAMokWmVVMxIzfKDS4JPH1TJvIYpLdZjtcFN+UTZc1Plt+os4DTtxA3hQPY5CxqM
         Mt40/d3mjN80KORg3KrHTCFYIy2iu3ZGUaJeVt4jxxs1blsKrKnc9yGgjquOH7XRFW
         p6u7eAB8HZsEw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 258235C05F8; Fri, 20 May 2022 11:06:34 -0700 (PDT)
Date:   Fri, 20 May 2022 11:06:34 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rcu@vger.kernel.org, kernel-team@fb.com
Subject: [GIT PULL] RCU changes for v5.19
Message-ID: <20220520180634.GA3788910@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus,

Once the merge window opens, please pull the latest RCU git tree from:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/rcu.2022.05.19a
  # HEAD: ce13389053a347aa9f8ffbfda2238352536e15c9 Merge branch 'exp.2022.05.11a' into HEAD

There are really eight more branches for a total of nine, but the other
eight had to be merged separately as the parent of the above commit here:

be05ee54378d ("Merge branches 'docs.2022.04.20a', 'fixes.2022.04.20a', 'nocb.2022.04.11b', 'rcu-tasks.2022.04.11b', 'srcu.2022.05.03a', 'torture.2022.04.11b', 'torture-tasks.2022.04.20a' and 'torturescript.2022.04.20a' into HEAD")

Stephen Rothwell located a conflict with these two commits, the latter
from the sysctl tree:

95d4e9e339d1 ("rcu: Provide a get_completed_synchronize_rcu() function")
d9ab0e63fa7f ("sched: Move rt_period/runtime sysctls to rt.c")

Stephen's suggested merge-conflict fix works in my testing:

https://lore.kernel.org/all/20220420153746.4790d532@canb.auug.org.au/

I do not normally pull from the sysctl tree, but if you would like me
to create an example merge, please let me know and I will set one up.

----------------------------------------------------------------
RCU pull request for v5.19

This pull request contains the following branches:

docs.2022.04.20a: Documentation updates.

fixes.2022.04.20a: Miscellaneous fixes.

nocb.2022.04.11b: Callback-offloading updates, mainly simplifications.

rcu-tasks.2022.04.11b: RCU-tasks updates, including some -rt fixups,
	handling of systems with sparse CPU numbering, and a fix for a
	boot-time race-condition failure.

srcu.2022.05.03a: Put SRCU on a memory diet in order to reduce the size
	of the srcu_struct structure.

torture.2022.04.11b: Torture-test updates fixing some bugs in tests and
	closing some testing holes.

torture-tasks.2022.04.20a: Torture-test updates for the RCU tasks flavors,
	most notably ensuring that building rcutorture and friends does
	not change the RCU-tasks-related Kconfig options.

torturescript.2022.04.20a: Torture-test scripting updates.

exp.2022.05.11a: Expedited grace-period updates, most notably providing
	milliseconds-scale (not all that) soft real-time response from
	synchronize_rcu_expedited().  This is also the first time in
	almost 30 years of RCU that someone other than me has pushed
	for a reduction in the RCU CPU stall-warning timeout, in this
	case by more than three orders of magnitude from 21 seconds to
	20 milliseconds.  This tighter timeout applies only to expedited
	grace periods.

----------------------------------------------------------------
Akira Yokosawa (1):
      docs: Update RCU cross-references as suggested in doc-guide

Alexander Aring (1):
      srcu: Use export for srcu_struct defined by DEFINE_STATIC_SRCU()

David Vernet (3):
      rcutorture: Avoid corner-case #DE with nsynctypes check
      rcutorture: Add missing return and use __func__ in warning
      rcu_sync: Fix comment to properly reflect rcu_sync_exit() behavior

Eric Dumazet (1):
      rcu-tasks: Handle sparse cpu_possible_mask

Frederic Weisbecker (7):
      rcu: Remove rcu_is_nocb_cpu()
      rcu/nocb: Move rcu_nocb_is_setup to rcu_state
      rcu: Assume rcu_init() is called before smp
      rcu: Initialize boost kthread only for boot node prior SMP initialization
      rcu/nocb: Initialize nocb kthreads only for boot CPU prior SMP initialization
      rcutorture: Call preempt_schedule() through static call/key
      rcu: Fix preemption mode check on synchronize_rcu[_expedited]()

Kalesh Singh (1):
      rcu: Move expedited grace period (GP) work to RT kthread_worker

Lukas Bulwahn (1):
      srcu: Drop needless initialization of sdp in srcu_gp_start()

Neeraj Upadhyay (1):
      srcu: Ensure snp nodes tree is fully initialized before traversal

Padmanabha Srinivasaiah (1):
      rcu-tasks: Fix race in schedule and flush work

Paul E. McKenney (58):
      srcu: Tighten cleanup_srcu_struct() GP checks
      srcu: Fix s/is/if/ typo in srcu_node comment
      srcu: Make srcu_funnel_gp_start() cache ->mynode in snp_leaf
      srcu: Make Tree SRCU able to operate without snp_node array
      srcu: Dynamically allocate srcu_node array
      srcu: Add size-state transitioning code
      srcu: Make rcutorture dump the SRCU size state
      srcu: Compute snp_seq earlier in srcu_funnel_gp_start()
      srcu: Use invalid initial value for srcu_node GP sequence numbers
      srcu: Add boot-time control over srcu_node array allocation
      srcu: Avoid NULL dereference in srcu_torture_stats_print()
      srcu: Prevent cleanup_srcu_struct() from freeing non-dynamic ->sda
      srcu: Explain srcu_funnel_gp_start() call to list_add() is safe
      srcu: Create concurrency-safe helper for initiating size transition
      srcu: Add contention-triggered addition of srcu_node tree
      rcu-tasks: Print pre-stall-warning informational messages
      rcu-tasks: Make Tasks RCU account for userspace execution
      rcu-tasks: Restore use of timers for non-RT kernels
      rcu-tasks: Make show_rcu_tasks_generic_gp_kthread() check all CPUs
      rcu-tasks: Handle sparse cpu_possible_mask in rcu_tasks_invoke_cbs()
      torture: Add rcu_normal and rcu_expedited runs to torture.sh
      rcutorture: Suppress debugging grace period delays during flooding
      scftorture: Fix distribution of short handler delays
      rcu: Make TASKS_RUDE_RCU select IRQ_WORK
      torture: Reposition so that $? collects ssh code in torture.sh
      torture: Use "-o Batchmode=yes" to disable ssh password requests
      torture: Permit running of experimental torture types
      rcu: Clarify fill-the-gap comment in rcu_segcblist_advance()
      rcu: Fix rcu_preempt_deferred_qs_irqrestore() strict QS reporting
      rcu: Check for jiffies going backwards
      docs: Add documentation for rude and trace RCU flavors
      kernel/smp: Provide boot-time timeout for CSD lock diagnostics
      rcu: Add comments to final rcu_gp_cleanup() "if" statement
      rcu: Print number of online CPUs in RCU CPU stall-warning messages
      rcu: Make the TASKS_RCU Kconfig option be selected
      rcutorture: Allow rcutorture without RCU Tasks Trace
      rcutorture: Allow rcutorture without RCU Tasks
      rcutorture: Allow rcutorture without RCU Tasks Rude
      rcutorture: Add CONFIG_PREEMPT_DYNAMIC=n to TASKS02 scenario
      rcutorture: Allow specifying per-scenario stat_interval
      refscale: Allow refscale without RCU Tasks
      refscale: Allow refscale without RCU Tasks Rude/Trace
      rcuscale: Allow rcuscale without RCU Tasks
      rcuscale: Allow rcuscale without RCU Tasks Rude/Trace
      scftorture: Adjust for TASKS_RCU Kconfig option being selected
      torture: Skip vmlinux check for kvm-again.sh runs
      torture: Enable CSD-lock stall reports for scftorture
      rcutorture: Adjust scenarios' Kconfig options for CONFIG_PREEMPT_DYNAMIC
      scftorture: Remove extraneous "scf" from per_version_boot_params
      torture: Save "make allmodconfig" .config file
      rcutorture: Make kvm.sh allow more memory for --kasan runs
      rcutorture: Make torture.sh refscale and rcuscale specify Tasks Trace RCU
      rcutorture: Make torture.sh allow for --kasan
      srcu: Automatically determine size-transition strategy at boot
      srcu: Add contention check to call_srcu() srcu_data ->lock acquisition
      srcu: Prevent expedited GPs and blocking readers from consuming CPU
      Merge branches 'docs.2022.04.20a', 'fixes.2022.04.20a', 'nocb.2022.04.11b', 'rcu-tasks.2022.04.11b', 'srcu.2022.05.03a', 'torture.2022.04.11b', 'torture-tasks.2022.04.20a' and 'torturescript.2022.04.20a' into HEAD
      Merge branch 'exp.2022.05.11a' into HEAD

Paul Menzel (1):
      torture: Make thread detection more robust by using lspcu

Sebastian Andrzej Siewior (2):
      rcu-tasks: Use rcuwait for the rcu_tasks_kthread()
      rcu-tasks: Use schedule_hrtimeout_range() to wait for grace periods

Uladzislau Rezki (1):
      rcu: Introduce CONFIG_RCU_EXP_CPU_STALL_TIMEOUT

Valentin Schneider (1):
      preempt/dynamic: Introduce preemption model accessors

Zqiang (2):
      rcu: Check for successful spawn of ->boost_kthread_task
      rcu: Use IRQ_WORK_INIT_HARD() to avoid rcu_read_unlock() hangs

 .../RCU/Design/Data-Structures/Data-Structures.rst |   2 +-
 .../Expedited-Grace-Periods.rst                    |   2 +-
 .../RCU/Design/Requirements/Requirements.rst       |  36 +-
 Documentation/RCU/arrayRCU.rst                     |   4 +-
 Documentation/RCU/checklist.rst                    |   9 +-
 Documentation/RCU/rcu.rst                          |  13 +-
 Documentation/RCU/rculist_nulls.rst                |   2 +-
 Documentation/RCU/stallwarn.rst                    |  20 +
 Documentation/RCU/whatisRCU.rst                    |  18 +-
 Documentation/admin-guide/kernel-parameters.txt    |  85 ++-
 arch/Kconfig                                       |   1 +
 include/linux/rcupdate.h                           |   1 +
 include/linux/sched.h                              |  41 ++
 include/linux/srcutree.h                           |  32 +-
 include/linux/torture.h                            |   2 +-
 kernel/bpf/Kconfig                                 |   1 +
 kernel/rcu/Kconfig                                 |  73 ++-
 kernel/rcu/Kconfig.debug                           |  23 +-
 kernel/rcu/rcu.h                                   |  13 +-
 kernel/rcu/rcu_segcblist.c                         |   8 +-
 kernel/rcu/rcuscale.c                              |  22 +-
 kernel/rcu/rcutorture.c                            | 129 +++--
 kernel/rcu/refscale.c                              |  22 +-
 kernel/rcu/srcutree.c                              | 639 +++++++++++++++------
 kernel/rcu/sync.c                                  |   2 +-
 kernel/rcu/tasks.h                                 |  89 ++-
 kernel/rcu/tree.c                                  | 146 ++++-
 kernel/rcu/tree.h                                  |   9 +-
 kernel/rcu/tree_exp.h                              | 151 +++--
 kernel/rcu/tree_nocb.h                             |  39 +-
 kernel/rcu/tree_plugin.h                           |  28 +-
 kernel/rcu/tree_stall.h                            |  36 +-
 kernel/rcu/update.c                                |   2 +
 kernel/scftorture.c                                |   5 +-
 kernel/sched/core.c                                |  12 +
 kernel/smp.c                                       |   7 +-
 kernel/trace/Kconfig                               |   1 +
 .../testing/selftests/rcutorture/bin/functions.sh  |   2 +-
 .../selftests/rcutorture/bin/kvm-find-errors.sh    |   2 +-
 .../selftests/rcutorture/bin/kvm-recheck.sh        |   7 +-
 .../testing/selftests/rcutorture/bin/kvm-remote.sh |  14 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  10 +-
 tools/testing/selftests/rcutorture/bin/torture.sh  |  29 +-
 .../selftests/rcutorture/configs/rcu/RUDE01        |   2 +
 .../selftests/rcutorture/configs/rcu/SRCU-N        |   2 +
 .../selftests/rcutorture/configs/rcu/TASKS01       |   1 +
 .../selftests/rcutorture/configs/rcu/TASKS02       |   4 +
 .../selftests/rcutorture/configs/rcu/TASKS02.boot  |   1 +
 .../selftests/rcutorture/configs/rcu/TASKS03       |   2 +
 .../selftests/rcutorture/configs/rcu/TRACE01       |   3 +
 .../selftests/rcutorture/configs/rcu/TRACE02       |   2 +
 .../selftests/rcutorture/configs/rcu/TREE04        |   5 +-
 .../selftests/rcutorture/configs/rcu/TREE07        |   1 +
 .../selftests/rcutorture/configs/rcu/TREE09        |   2 +
 .../selftests/rcutorture/configs/rcu/TREE10        |   1 +
 .../rcutorture/configs/rcu/ver_functions.sh        |  16 +-
 .../selftests/rcutorture/configs/rcuscale/CFcommon |   7 +-
 .../selftests/rcutorture/configs/rcuscale/TREE     |   2 +
 .../selftests/rcutorture/configs/refscale/CFcommon |   4 +
 .../rcutorture/configs/refscale/NOPREEMPT          |   2 +
 .../selftests/rcutorture/configs/scf/NOPREEMPT     |   2 +
 .../selftests/rcutorture/configs/scf/PREEMPT       |   1 +
 .../rcutorture/configs/scf/ver_functions.sh        |   3 +-
 63 files changed, 1411 insertions(+), 441 deletions(-)
