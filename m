Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AF6552749
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345447AbiFTWz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344849AbiFTWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D172F1EAF6;
        Mon, 20 Jun 2022 15:54:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3753361461;
        Mon, 20 Jun 2022 22:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE0FC341F6;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765654;
        bh=eWdHTMnVTQ+8s6dSWT7VnrkEqgiCwDx+ZJxVEcLEC9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GmjEpPmfD2a2XnyStJO10I75JLE+jy7mYOkBhNkGn520PDxEB8C6Q9uQGh/75QIwO
         /3hTwXYX8FLZ33cbpWtqnyM9NCg80AhhwOO4aUq8wehBmSbOcMhsSV/v7rJZ5nMHns
         PYP+qjJttMstz7mGLabCigRfcC/ayGcE2/GG7cneL5TcITceyVJYA++hoimNSFNISg
         AzyFrehlIaV5GuvwlN33RPAAfxKUk1nXhdgF89nrBXDxL0uJlbfiqpUA907VpO0/WE
         O0P0oiLqk1YRbFxEDLygcoYfAOb+ZmX5vZWi0agquQoz1Mwq6MWC+nlD+xUtoekxC0
         MrCFlgPMv5c5A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5DE785C1695; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH rcu 28/32] rcu-tasks: Eliminate RCU Tasks Trace IPIs to online CPUs
Date:   Mon, 20 Jun 2022 15:54:07 -0700
Message-Id: <20220620225411.3842519-28-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the RCU Tasks Trace grace-period kthread IPIs each online CPU
using smp_call_function_single() in order to track any tasks currently in
RCU Tasks Trace read-side critical sections during which the corresponding
task has neither blocked nor been preempted.  These IPIs are annoying
and are also not strictly necessary because any task that blocks or is
preempted within its current RCU Tasks Trace read-side critical section
will be tracked on one of the per-CPU rcu_tasks_percpu structure's
->rtp_blkd_tasks list.  So the only time that this is a problem is if
one of the CPUs runs through a long-duration RCU Tasks Trace read-side
critical section without a context switch.

Note that the task_call_func() function cannot help here because there is
no safe way to identify the target task.  Of course, the task_call_func()
function will be very useful later, when processing the list of tasks,
but it needs to know the task.

This commit therefore creates a cpu_curr_snapshot() function that returns
a pointer the task_struct structure of some task that happened to be
running on the specified CPU more or less during the time that the
cpu_curr_snapshot() function was executing.  If there was no context
switch during this time, this function will return a pointer to the
task_struct structure of the task that was running throughout.  If there
was a context switch, then the outgoing task will be taken care of by
RCU's context-switch hook, and the incoming task was either already taken
care during some previous context switch, or it is not currently within an
RCU Tasks Trace read-side critical section.  And in this latter case, the
grace period already started, so there is no need to wait on this task.

This new cpu_curr_snapshot() function is invoked on each CPU early in
the RCU Tasks Trace grace-period processing, and the resulting tasks
are queued for later quiescent-state inspection.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 include/linux/sched.h |  1 +
 kernel/rcu/tasks.h    | 24 +++++++-----------------
 kernel/sched/core.c   | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b88caf54e1686..72242bc73d850 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2224,6 +2224,7 @@ static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
 
 extern bool sched_task_on_rq(struct task_struct *p);
 extern unsigned long get_wchan(struct task_struct *p);
+extern struct task_struct *cpu_curr_snapshot(int cpu);
 
 /*
  * In order to reduce various lock holder preemption latencies provide an
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 9d7d6fd4b8a79..c2aae2643a0b2 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1479,21 +1479,6 @@ static void rcu_tasks_trace_pertask(struct task_struct *t, struct list_head *hop
 		trc_wait_for_one_reader(t, hop);
 }
 
-/*
- * Get the current CPU's current task on the holdout list.
- * Calls to this function must be serialized.
- */
-static void rcu_tasks_trace_pertask_handler(void *hop_in)
-{
-	struct list_head *hop = hop_in;
-	struct task_struct *t = current;
-
-	// Pull in the currently running task, but only if it is currently
-	// in an RCU tasks trace read-side critical section.
-	if (rcu_tasks_trace_pertask_prep(t, false))
-		trc_add_holdout(t, hop);
-}
-
 /* Initialize for a new RCU-tasks-trace grace period. */
 static void rcu_tasks_trace_pregp_step(struct list_head *hop)
 {
@@ -1513,8 +1498,13 @@ static void rcu_tasks_trace_pregp_step(struct list_head *hop)
 
 	// These smp_call_function_single() calls are serialized to
 	// allow safe access to the hop list.
-	for_each_online_cpu(cpu)
-		smp_call_function_single(cpu, rcu_tasks_trace_pertask_handler, hop, 1);
+	for_each_online_cpu(cpu) {
+		rcu_read_lock();
+		t = cpu_curr_snapshot(cpu);
+		if (rcu_tasks_trace_pertask_prep(t, true))
+			trc_add_holdout(t, hop);
+		rcu_read_unlock();
+	}
 
 	// Only after all running tasks have been accounted for is it
 	// safe to take care of the tasks that have blocked within their
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da0bf6fe9ecdc..9568019be124c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4263,6 +4263,38 @@ int task_call_func(struct task_struct *p, task_call_f func, void *arg)
 	return ret;
 }
 
+/**
+ * cpu_curr_snapshot - Return a snapshot of the currently running task
+ * @cpu: The CPU on which to snapshot the task.
+ *
+ * Returns the task_struct pointer of the task "currently" running on
+ * the specified CPU.  If the same task is running on that CPU throughout,
+ * the return value will be a pointer to that task's task_struct structure.
+ * If the CPU did any context switches even vaguely concurrently with the
+ * execution of this function, the return value will be a pointer to the
+ * task_struct structure of a randomly chosen task that was running on
+ * that CPU somewhere around the time that this function was executing.
+ *
+ * If the specified CPU was offline, the return value is whatever it
+ * is, perhaps a pointer to the task_struct structure of that CPU's idle
+ * task, but there is no guarantee.  Callers wishing a useful return
+ * value must take some action to ensure that the specified CPU remains
+ * online throughout.
+ *
+ * This function executes full memory barriers before and after fetching
+ * the pointer, which permits the caller to confine this function's fetch
+ * with respect to the caller's accesses to other shared variables.
+ */
+struct task_struct *cpu_curr_snapshot(int cpu)
+{
+	struct task_struct *t;
+
+	smp_mb(); /* Pairing determined by caller's synchronization design. */
+	t = rcu_dereference(cpu_curr(cpu));
+	smp_mb(); /* Pairing determined by caller's synchronization design. */
+	return t;
+}
+
 /**
  * wake_up_process - Wake up a specific process
  * @p: The process to be woken up.
-- 
2.31.1.189.g2e36527f23

