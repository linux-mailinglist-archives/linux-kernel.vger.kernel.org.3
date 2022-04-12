Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C364FE04C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243663AbiDLMeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345976AbiDLMdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:33:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280A35A166;
        Tue, 12 Apr 2022 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=clWjpqcbNXMt2ERvOKHn+airowA8oa8QyaIODhrUpU4=; b=qMIElK47IUljG+XEViTXyGVVfI
        5Vml8dchDCRXOvS/GUcgWNyCSFWA6CE5g0GY2bed6VRCg080TMQNMwTHDp7sQduKzwC+2xRo5A+lJ
        V9n6xkDRGC1MPGRVH0+WERmbQui2Ox5AxOfMxOQcRThT7xUwlsUZYwRuziwfnvAwCSZGrTzy+ZF52
        czJsu7efxh1oVTaoFJNqJFGVntp27sbEi7ccbNJhyVZqPmRK6j+u4q7morfl4fyv8+PcpSCYFEjWZ
        NH0PbqwUZeQ3hxOsLGr59onQKom7Y2F3lxQFjNP9rfnBakRUwk8H+HbpyntDetizZ6XgSS6uaXDSB
        bzzin9rw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neF2o-00DILD-JP; Tue, 12 Apr 2022 11:50:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 645AB300792;
        Tue, 12 Apr 2022 13:50:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 402973017A05A; Tue, 12 Apr 2022 13:50:47 +0200 (CEST)
Message-ID: <20220412114853.782838521@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 12 Apr 2022 13:44:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, ebiederm@xmission.com,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 1/5] sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state
References: <20220412114421.691372568@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ptrace_stop() / do_signal_stop() rely on the special states
TASK_TRACED and TASK_STOPPED resp. to keep unique state. That is, this
state exists only in task->__state and nowhere else.

There's two spots of bother with this:

 - PREEMPT_RT has task->saved_state which complicates matters,
   meaning task_is_{traced,stopped}() needs to check an additional
   variable.

 - An alternative freezer implementation that itself relies on a
   special TASK state would loose TASK_TRACED/TASK_STOPPED and will
   result in misbehaviour.

As such, add additional state to task->jobctl to track this state
outside of task->__state.

NOTE: this doesn't actually fix anything yet, just adds extra state.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h        |    8 +++-----
 include/linux/sched/jobctl.h |    8 ++++++++
 include/linux/sched/signal.h |   15 ++++++++++++++-
 kernel/ptrace.c              |   18 ++++++++++++++----
 kernel/signal.c              |    9 ++++++---
 5 files changed, 45 insertions(+), 13 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -118,11 +118,9 @@ struct task_group;
 
 #define task_is_running(task)		(READ_ONCE((task)->__state) == TASK_RUNNING)
 
-#define task_is_traced(task)		((READ_ONCE(task->__state) & __TASK_TRACED) != 0)
-
-#define task_is_stopped(task)		((READ_ONCE(task->__state) & __TASK_STOPPED) != 0)
-
-#define task_is_stopped_or_traced(task)	((READ_ONCE(task->__state) & (__TASK_STOPPED | __TASK_TRACED)) != 0)
+#define task_is_traced(task)		((READ_ONCE(task->jobctl) & JOBCTL_TRACED) != 0)
+#define task_is_stopped(task)		((READ_ONCE(task->jobctl) & JOBCTL_STOPPED) != 0)
+#define task_is_stopped_or_traced(task)	((READ_ONCE(task->jobctl) & (JOBCTL_STOPPED | JOBCTL_TRACED)) != 0)
 
 /*
  * Special states are those that do not use the normal wait-loop pattern. See
--- a/include/linux/sched/jobctl.h
+++ b/include/linux/sched/jobctl.h
@@ -20,6 +20,10 @@ struct task_struct;
 #define JOBCTL_LISTENING_BIT	22	/* ptracer is listening for events */
 #define JOBCTL_TRAP_FREEZE_BIT	23	/* trap for cgroup freezer */
 
+#define JOBCTL_STOPPED_BIT	24
+#define JOBCTL_TRACED_BIT	25
+#define JOBCTL_TRACED_FROZEN_BIT 26
+
 #define JOBCTL_STOP_DEQUEUED	(1UL << JOBCTL_STOP_DEQUEUED_BIT)
 #define JOBCTL_STOP_PENDING	(1UL << JOBCTL_STOP_PENDING_BIT)
 #define JOBCTL_STOP_CONSUME	(1UL << JOBCTL_STOP_CONSUME_BIT)
@@ -29,6 +33,10 @@ struct task_struct;
 #define JOBCTL_LISTENING	(1UL << JOBCTL_LISTENING_BIT)
 #define JOBCTL_TRAP_FREEZE	(1UL << JOBCTL_TRAP_FREEZE_BIT)
 
+#define JOBCTL_STOPPED		(1UL << JOBCTL_STOPPED_BIT)
+#define JOBCTL_TRACED		(1UL << JOBCTL_TRACED_BIT)
+#define JOBCTL_TRACED_FROZEN	(1UL << JOBCTL_TRACED_FROZEN_BIT)
+
 #define JOBCTL_TRAP_MASK	(JOBCTL_TRAP_STOP | JOBCTL_TRAP_NOTIFY)
 #define JOBCTL_PENDING_MASK	(JOBCTL_STOP_PENDING | JOBCTL_TRAP_MASK)
 
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -294,8 +294,10 @@ static inline int kernel_dequeue_signal(
 static inline void kernel_signal_stop(void)
 {
 	spin_lock_irq(&current->sighand->siglock);
-	if (current->jobctl & JOBCTL_STOP_DEQUEUED)
+	if (current->jobctl & JOBCTL_STOP_DEQUEUED) {
+		current->jobctl |= JOBCTL_STOPPED;
 		set_special_state(TASK_STOPPED);
+	}
 	spin_unlock_irq(&current->sighand->siglock);
 
 	schedule();
@@ -437,10 +439,21 @@ extern void signal_wake_up_state(struct
 
 static inline void signal_wake_up(struct task_struct *t, bool resume)
 {
+	lockdep_assert_held(&t->sighand->siglock);
+
+	if (resume && !(t->jobctl & JOBCTL_TRACED_FROZEN))
+		t->jobctl &= ~(JOBCTL_STOPPED | JOBCTL_TRACED);
+
 	signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
 }
+
 static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
 {
+	lockdep_assert_held(&t->sighand->siglock);
+
+	if (resume)
+		t->jobctl &= ~JOBCTL_TRACED;
+
 	signal_wake_up_state(t, resume ? __TASK_TRACED : 0);
 }
 
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -185,7 +185,12 @@ static bool looks_like_a_spurious_pid(st
 	return true;
 }
 
-/* Ensure that nothing can wake it up, even SIGKILL */
+/*
+ * Ensure that nothing can wake it up, even SIGKILL
+ *
+ * A task is switched to this state while a ptrace operation is in progress;
+ * such that the ptrace operation is uninterruptible.
+ */
 static bool ptrace_freeze_traced(struct task_struct *task)
 {
 	bool ret = false;
@@ -197,6 +202,7 @@ static bool ptrace_freeze_traced(struct
 	spin_lock_irq(&task->sighand->siglock);
 	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
 	    !__fatal_signal_pending(task)) {
+		task->jobctl |= JOBCTL_TRACED_FROZEN;
 		WRITE_ONCE(task->__state, __TASK_TRACED);
 		ret = true;
 	}
@@ -218,9 +224,11 @@ static void ptrace_unfreeze_traced(struc
 	 */
 	spin_lock_irq(&task->sighand->siglock);
 	if (READ_ONCE(task->__state) == __TASK_TRACED) {
-		if (__fatal_signal_pending(task))
+		task->jobctl &= ~JOBCTL_TRACED_FROZEN;
+		if (__fatal_signal_pending(task)) {
+			task->jobctl &= ~JOBCTL_TRACED;
 			wake_up_state(task, __TASK_TRACED);
-		else
+		} else
 			WRITE_ONCE(task->__state, TASK_TRACED);
 	}
 	spin_unlock_irq(&task->sighand->siglock);
@@ -475,8 +483,10 @@ static int ptrace_attach(struct task_str
 	 * in and out of STOPPED are protected by siglock.
 	 */
 	if (task_is_stopped(task) &&
-	    task_set_jobctl_pending(task, JOBCTL_TRAP_STOP | JOBCTL_TRAPPING))
+	    task_set_jobctl_pending(task, JOBCTL_TRAP_STOP | JOBCTL_TRAPPING)) {
+		task->jobctl &= ~JOBCTL_STOPPED;
 		signal_wake_up_state(task, __TASK_STOPPED);
+	}
 
 	spin_unlock(&task->sighand->siglock);
 
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -884,7 +884,7 @@ static int check_kill_permission(int sig
 static void ptrace_trap_notify(struct task_struct *t)
 {
 	WARN_ON_ONCE(!(t->ptrace & PT_SEIZED));
-	assert_spin_locked(&t->sighand->siglock);
+	lockdep_assert_held(&t->sighand->siglock);
 
 	task_set_jobctl_pending(t, JOBCTL_TRAP_NOTIFY);
 	ptrace_signal_wake_up(t, t->jobctl & JOBCTL_LISTENING);
@@ -930,9 +930,10 @@ static bool prepare_signal(int sig, stru
 		for_each_thread(p, t) {
 			flush_sigqueue_mask(&flush, &t->pending);
 			task_clear_jobctl_pending(t, JOBCTL_STOP_PENDING);
-			if (likely(!(t->ptrace & PT_SEIZED)))
+			if (likely(!(t->ptrace & PT_SEIZED))) {
+				t->jobctl &= ~JOBCTL_STOPPED;
 				wake_up_state(t, __TASK_STOPPED);
-			else
+			} else
 				ptrace_trap_notify(t);
 		}
 
@@ -2219,6 +2220,7 @@ static int ptrace_stop(int exit_code, in
 	 * schedule() will not sleep if there is a pending signal that
 	 * can awaken the task.
 	 */
+	current->jobctl |= JOBCTL_TRACED;
 	set_special_state(TASK_TRACED);
 
 	/*
@@ -2460,6 +2462,7 @@ static bool do_signal_stop(int signr)
 		if (task_participate_group_stop(current))
 			notify = CLD_STOPPED;
 
+		current->jobctl |= JOBCTL_STOPPED;
 		set_special_state(TASK_STOPPED);
 		spin_unlock_irq(&current->sighand->siglock);
 


