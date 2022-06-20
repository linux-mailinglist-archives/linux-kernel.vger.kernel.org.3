Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C175527DA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346794AbiFTXMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244385AbiFTXLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:11:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF242610A;
        Mon, 20 Jun 2022 16:10:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A93F614DB;
        Mon, 20 Jun 2022 23:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94402C3411B;
        Mon, 20 Jun 2022 23:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766627;
        bh=/3a1oApTEGdUacBzkDTaTopSYTRwHY+jgTl7QNfQ8XU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=aViuDFjDNDkKgRTQiZn0buAo8KQ2L0axRgnKNhLsW+rPgELdDIFJqJIBp/EjjQm6W
         zoNTSs8xeBmZ/W91GerO+EEHYID+aZNzGQ/oayM2LHHJakbcGK4fHL2Ig+dtNHD6DI
         Ks7znVwg4nfNyZpz3c5PtWimC2IresaidKZx/I8nEgXJxbGL6xW8F9KYBUwZRcAX08
         7h9vRGcyp/oDdQGY79tkNu9HPK1yLO8IVY6yPgOOQQMTolcTRieRFi0XIRmN4SM8HA
         hKvKGm+v+OJbqqu+YCUWiQ21yF01oZgfZju+l9edpd7x3eHNmdmu2ZwsKWp78jNyzA
         KCydEFrXak6tw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3956C5C05B9; Mon, 20 Jun 2022 16:10:27 -0700 (PDT)
Date:   Mon, 20 Jun 2022 16:10:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/23] RCU/context-tracking updates for v5.20
Message-ID: <20220620231027.GA3844372@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series merges RCU's dyntick-idle tracking into context tracking,
thus reducing the overhead of transitioning to kernel mode from either
idle or nohz_full userspace execution for kernels that track context
independently of RCU.  (Primarily for NO_HZ_FULL kernels.)

1.	Dump rcuc kthread status for CPUs not reporting quiescent state,
	courtesy of Zqiang.

2.	Apply noinstr to rcu_idle_enter() and rcu_idle_exit().

3.	context_tracking: Remove unused context_tracking_in_user(),
	courtesy of Frederic Weisbecker.

4.	context_tracking: Add a note about noinstr VS unsafe context
	tracking functions, courtesy of Frederic Weisbecker.

5.	context_tracking: Rename __context_tracking_enter/exit() to
	__ct_user_enter/exit(), courtesy of Frederic Weisbecker.

6.	context_tracking: Rename context_tracking_user_enter/exit()
	to user_enter/exit_callable(), courtesy of Frederic Weisbecker.

7.	context_tracking: Rename context_tracking_enter/exit() to
	ct_user_enter/exit(), courtesy of Frederic Weisbecker.

8.	context_tracking: Rename context_tracking_cpu_set() to
	ct_cpu_track_user(), courtesy of Frederic Weisbecker.

9.	context_tracking: Split user tracking Kconfig, courtesy of
	Frederic Weisbecker.

10.	context_tracking: Take idle eqs entrypoints over RCU, courtesy
	of Frederic Weisbecker.

11.	context_tracking: Take IRQ eqs entrypoints over RCU, courtesy
	of Frederic Weisbecker.

12.	context_tracking: Take NMI eqs entrypoints over RCU, courtesy
	of Frederic Weisbecker.

13.	rcu/context-tracking: Remove rcu_irq_enter/exit(), courtesy of
	Frederic Weisbecker.

14.	rcu/context_tracking: Move dynticks counter to context tracking,
	courtesy of Frederic Weisbecker.

15.	rcu/context_tracking: Move dynticks_nesting to context tracking,
	courtesy of Frederic Weisbecker.

16.	rcu/context_tracking: Move dynticks_nmi_nesting to context
	tracking, courtesy of Frederic Weisbecker.

17.	rcu/context-tracking: Move deferred nocb resched to context
	tracking, courtesy of Frederic Weisbecker.

18.	rcu/context-tracking: Move RCU-dynticks internal functions to
	context_tracking, courtesy of Frederic Weisbecker.

19.	rcu/context-tracking: Remove unused and/or unecessary middle
	functions, courtesy of Frederic Weisbecker.

20.	context_tracking: Convert state to atomic_t, courtesy of Frederic
	Weisbecker.

21.	rcu/context_tracking: Merge dynticks counter and context tracking
	states, courtesy of Frederic Weisbecker.

22.	MAINTAINERS: Add Paul as context tracking maintainer, courtesy
	of Frederic Weisbecker.

23.	context_tracking: Interrupts always disabled for ct_idle_exit(),
	courtesy of Peter Zijlstra.

						Thanx, Paul

------------------------------------------------------------------------

 Documentation/RCU/Design/Requirements/Requirements.rst          |    2 
 Documentation/RCU/stallwarn.rst                                 |    6 
 arch/Kconfig                                                    |    4 
 arch/arm/kernel/entry-header.S                                  |    4 
 arch/arm64/kernel/entry-common.c                                |    8 
 arch/csky/kernel/entry.S                                        |    4 
 arch/riscv/kernel/entry.S                                       |    6 
 b/Documentation/RCU/Design/Requirements/Requirements.rst        |   10 
 b/Documentation/RCU/stallwarn.rst                               |    4 
 b/Documentation/features/time/context-tracking/arch-support.txt |    6 
 b/MAINTAINERS                                                   |    1 
 b/arch/Kconfig                                                  |    4 
 b/arch/arm/Kconfig                                              |    2 
 b/arch/arm/kernel/entry-common.S                                |    4 
 b/arch/arm/kernel/entry-header.S                                |    8 
 b/arch/arm/mach-imx/cpuidle-imx6q.c                             |    5 
 b/arch/arm64/Kconfig                                            |    2 
 b/arch/arm64/kernel/entry-common.c                              |    6 
 b/arch/csky/Kconfig                                             |    2 
 b/arch/csky/kernel/entry.S                                      |    4 
 b/arch/mips/Kconfig                                             |    2 
 b/arch/powerpc/Kconfig                                          |    2 
 b/arch/powerpc/include/asm/context_tracking.h                   |    2 
 b/arch/riscv/Kconfig                                            |    2 
 b/arch/riscv/kernel/entry.S                                     |    6 
 b/arch/sparc/Kconfig                                            |    2 
 b/arch/sparc/kernel/rtrap_64.S                                  |    2 
 b/arch/x86/Kconfig                                              |    4 
 b/arch/x86/mm/fault.c                                           |    2 
 b/drivers/acpi/processor_idle.c                                 |    5 
 b/drivers/cpuidle/cpuidle-psci.c                                |    8 
 b/drivers/cpuidle/cpuidle-riscv-sbi.c                           |    8 
 b/drivers/cpuidle/cpuidle.c                                     |    9 
 b/include/linux/context_tracking.h                              |   12 
 b/include/linux/context_tracking_irq.h                          |   17 
 b/include/linux/context_tracking_state.h                        |    5 
 b/include/linux/entry-common.h                                  |   10 
 b/include/linux/hardirq.h                                       |    4 
 b/include/linux/rcupdate.h                                      |    2 
 b/include/linux/rcutiny.h                                       |    4 
 b/include/linux/rcutree.h                                       |    4 
 b/include/linux/tracepoint.h                                    |    4 
 b/init/Kconfig                                                  |    4 
 b/kernel/cfi.c                                                  |    4 
 b/kernel/context_tracking.c                                     |   34 
 b/kernel/cpu_pm.c                                               |    8 
 b/kernel/entry/common.c                                         |   12 
 b/kernel/extable.c                                              |    4 
 b/kernel/locking/lockdep.c                                      |    2 
 b/kernel/rcu/Kconfig                                            |    2 
 b/kernel/rcu/rcu.h                                              |    4 
 b/kernel/rcu/tree.c                                             |   14 
 b/kernel/rcu/tree.h                                             |    1 
 b/kernel/rcu/tree_exp.h                                         |    2 
 b/kernel/rcu/tree_plugin.h                                      |   38 
 b/kernel/rcu/tree_stall.h                                       |   49 
 b/kernel/rcu/update.c                                           |    2 
 b/kernel/sched/core.c                                           |    2 
 b/kernel/sched/idle.c                                           |   10 
 b/kernel/sched/sched.h                                          |    1 
 b/kernel/softirq.c                                              |    4 
 b/kernel/time/Kconfig                                           |   31 
 b/kernel/time/tick-sched.c                                      |    2 
 b/kernel/trace/trace.c                                          |    6 
 include/linux/context_tracking.h                                |   91 -
 include/linux/context_tracking_irq.h                            |    4 
 include/linux/context_tracking_state.h                          |  144 +
 include/linux/hardirq.h                                         |    8 
 include/linux/rcupdate.h                                        |   19 
 include/linux/rcutiny.h                                         |    2 
 include/linux/rcutree.h                                         |    5 
 kernel/context_tracking.c                                       |  808 +++++++---
 kernel/entry/common.c                                           |    4 
 kernel/rcu/tree.c                                               |  572 -------
 kernel/rcu/tree.h                                               |    7 
 kernel/rcu/tree_stall.h                                         |   12 
 kernel/time/Kconfig                                             |    6 
 kernel/trace/trace.c                                            |    2 
 78 files changed, 1142 insertions(+), 986 deletions(-)
