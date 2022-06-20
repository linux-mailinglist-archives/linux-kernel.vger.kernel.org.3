Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DD5552731
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344067AbiFTWyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242451AbiFTWyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772B01B7;
        Mon, 20 Jun 2022 15:54:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DD356135C;
        Mon, 20 Jun 2022 22:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76421C3411B;
        Mon, 20 Jun 2022 22:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765642;
        bh=Esp2Vgy8DC2GHE0UbGvNRAdoymRYr2PZy4zq3mBgCqs=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Y1lr9xJIoQ53tussxIAcDbPsA81cYwzQu9j94xFTbXRqZy9xkQqYqZKUsQqjimT1J
         bBkDCq7P8m2eirwypZlqSygfQUUaqnAcyKd39/SDL8NVzd3WB/tG6H/P6AeAM0wT7j
         2qyu9cV7Ie4V3Q78fHHeE/msB6jVQouf1yDiwEYcn4GWxxaZf5cFTA51e1KpIjL+Ax
         Fy89QbNCrf6DQffkmJZvLykRANF+2Yx7N/kKkTdaOX9Md2CCyAsFVqw0zQj50FgJSj
         B4t2EHlHVJxkqaZVp3evPlKzXQ/GPgHcNdoC+IEQ01xSQUO3asBl+AyzQmpkdS7AS0
         QvoIVbtCUqYZA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 220D65C05B9; Mon, 20 Jun 2022 15:54:02 -0700 (PDT)
Date:   Mon, 20 Jun 2022 15:54:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/32] RCU Tasks updates for v5.20
Message-ID: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
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

This series provides updates for the RCU Tasks family, perhaps most
notably reducing the CPU overhead of RCU Tasks Trace grace periods:

1.	rcu-tasks: Check for abandoned callbacks.

2.	rcu-tasks: Split rcu_tasks_one_gp() from rcu_tasks_kthread().

3.	rcu-tasks: Move synchronize_rcu_tasks_generic() down.

4.	rcu-tasks: Drive synchronous grace periods from calling task.

5.	rcu-tasks: Merge state into .b.need_qs and atomically update.

6.	rcu-tasks: Remove rcu_tasks_trace_postgp() wait for counter.

7.	rcu-tasks: Make trc_read_check_handler() fetch
	->trc_reader_nesting only once.

8.	rcu-tasks: Idle tasks on offline CPUs are in quiescent states.

9.	rcu-tasks: Handle idle tasks for recently offlined CPUs.

10.	rcu-tasks: RCU Tasks Trace grace-period kthread has implicit QS.

11.	rcu-tasks: Make rcu_note_context_switch() unconditionally call
	rcu_tasks_qs().

12.	rcu-tasks: Simplify trc_inspect_reader() QS logic.

13.	rcu-tasks: Add slow-IPI indicator to RCU Tasks Trace stall
	warnings.

14.	rcu-tasks: Flag offline CPUs in RCU Tasks Trace stall warnings.

15.	rcu-tasks: Make RCU Tasks Trace stall warnings print full
	.b.need_qs field.

16.	rcu-tasks: Make RCU Tasks Trace stall warning handle idle
	offline tasks.

17.	rcu-tasks: Add data structures for lightweight grace periods.

18.	rcu-tasks: Track blocked RCU Tasks Trace readers.

19.	rcu-tasks: Untrack blocked RCU Tasks Trace at reader end.

20.	rcu-tasks: Add blocked-task indicator to RCU Tasks Trace stall
	warnings.

21.	rcu-tasks: Move rcu_tasks_trace_pertask() before
	rcu_tasks_trace_pregp_step().

22.	rcu-tasks: Avoid rcu_tasks_trace_pertask() duplicate list
	additions.

23.	rcu-tasks: Scan running tasks for RCU Tasks Trace readers.

24.	rcu-tasks: Pull in tasks blocked within RCU Tasks Trace readers.

25.	rcu-tasks: Stop RCU Tasks Trace from scanning idle tasks.

26.	rcu-tasks: Stop RCU Tasks Trace from scanning full tasks list.

27.	rcu-tasks: Maintain a count of tasks blocking RCU Tasks Trace
	grace period.

28.	rcu-tasks: Eliminate RCU Tasks Trace IPIs to online CPUs.

29.	rcu-tasks: Disable and enable CPU hotplug in same function.

30.	rcu-tasks: Update comments.

31.	rcu-tasks: Be more patient for RCU Tasks boot-time testing.

32.	rcu-tasks: Use delayed_work to delay
	rcu_tasks_verify_self_tests(), courtesy of Waiman Long.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/rcupdate.h       |   18 -
 b/include/linux/rcupdate_trace.h |    2 
 b/include/linux/sched.h          |    1 
 b/init/init_task.c               |    1 
 b/kernel/fork.c                  |    1 
 b/kernel/rcu/tasks.h             |    5 
 b/kernel/rcu/tree_plugin.h       |    2 
 b/kernel/sched/core.c            |   32 +
 include/linux/rcupdate.h         |   11 
 include/linux/sched.h            |    3 
 kernel/rcu/tasks.h               |  678 +++++++++++++++++++++++----------------
 11 files changed, 466 insertions(+), 288 deletions(-)
