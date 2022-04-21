Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC46F50A3BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389952AbiDUPN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389885AbiDUPNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:13:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2392B2F00D;
        Thu, 21 Apr 2022 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=oF+PVY6vIU4SUP3fyaaG3nUd44JsjVm4tT8uFNkBQgY=; b=NVN13hy2D2IC+wwCb5CK1GDrqQ
        I4LEzJzh5Nen6kEHH5tL1QNf4SrCEBth4RSqQmzHvOFoeAFZBM/Em9iDKEr6KWNbao8tC49AizD2F
        2G3M0L6a7zM4pIv9Q9H3H9zTOAlE5PfN6SmdKI3ZR7FYINdZSIyGEn2I9UUjTGonMHBhZNPeS3PE3
        CHRxH5l/YC640b79WAICyCAia68d3Go6wl44Oj5tyJz0nEC0gufG5Twi9r5kI5ct/rs3ifaVywB8l
        ascBhlJmjwFIJUBZkNM4Dv09b9bVj7vlLlHhQx6ZrCfQJP1V7Di2yo1tOiLLkRoa9l2SiseahAday
        5zinzkhA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhYRk-007QKP-3l; Thu, 21 Apr 2022 15:10:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 98C8A30066D;
        Thu, 21 Apr 2022 17:10:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 65FDF2B34A737; Thu, 21 Apr 2022 17:10:13 +0200 (CEST)
Message-ID: <20220421150654.757693825@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 21 Apr 2022 17:02:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, ebiederm@xmission.com,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 1/5] sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state
References: <20220421150248.667412396@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/sched/jobctl.h |    6 ++++++
 include/linux/sched/signal.h |    5 ++++-
 kernel/ptrace.c              |   26 +++++++++++++++-----------
 kernel/signal.c              |   16 ++++++++++++----
 5 files changed, 40 insertions(+), 21 deletions(-)

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
@@ -20,6 +20,9 @@ struct task_struct;
 #define JOBCTL_LISTENING_BIT	22	/* ptracer is listening for events */
 #define JOBCTL_TRAP_FREEZE_BIT	23	/* trap for cgroup freezer */
 
+#define JOBCTL_STOPPED_BIT	24	/* do_signal_stop() */
+#define JOBCTL_TRACED_BIT	25	/* ptrace_stop() */
+
 #define JOBCTL_STOP_DEQUEUED	(1UL << JOBCTL_STOP_DEQUEUED_BIT)
 #define JOBCTL_STOP_PENDING	(1UL << JOBCTL_STOP_PENDING_BIT)
 #define JOBCTL_STOP_CONSUME	(1UL << JOBCTL_STOP_CONSUME_BIT)
@@ -29,6 +32,9 @@ struct task_struct;
 #define JOBCTL_LISTENING	(1UL << JOBCTL_LISTENING_BIT)
 #define JOBCTL_TRAP_FREEZE	(1UL << JOBCTL_TRAP_FREEZE_BIT)
 
+#define JOBCTL_STOPPED		(1UL << JOBCTL_STOPPED_BIT)
+#define JOBCTL_TRACED		(1UL << JOBCTL_TRACED_BIT)
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
@@ -439,6 +441,7 @@ static inline void signal_wake_up(struct
 {
 	signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
 }
+
 static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
 {
 	signal_wake_up_state(t, resume ? __TASK_TRACED : 0);
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
@@ -218,9 +223,10 @@ static void ptrace_unfreeze_traced(struc
 	 */
 	spin_lock_irq(&task->sighand->siglock);
 	if (READ_ONCE(task->__state) == __TASK_TRACED) {
-		if (__fatal_signal_pending(task))
+		if (__fatal_signal_pending(task)) {
+			task->jobctl &= ~JOBCTL_TRACED;
 			wake_up_state(task, __TASK_TRACED);
-		else
+		} else
 			WRITE_ONCE(task->__state, TASK_TRACED);
 	}
 	spin_unlock_irq(&task->sighand->siglock);
@@ -475,8 +481,10 @@ static int ptrace_attach(struct task_str
 	 * in and out of STOPPED are protected by siglock.
 	 */
 	if (task_is_stopped(task) &&
-	    task_set_jobctl_pending(task, JOBCTL_TRAP_STOP | JOBCTL_TRAPPING))
+	    task_set_jobctl_pending(task, JOBCTL_TRAP_STOP | JOBCTL_TRAPPING)) {
+		task->jobctl &= ~JOBCTL_STOPPED;
 		signal_wake_up_state(task, __TASK_STOPPED);
+	}
 
 	spin_unlock(&task->sighand->siglock);
 
@@ -850,8 +858,6 @@ static long ptrace_get_rseq_configuratio
 static int ptrace_resume(struct task_struct *child, long request,
 			 unsigned long data)
 {
-	bool need_siglock;
-
 	if (!valid_signal(data))
 		return -EIO;
 
@@ -892,13 +898,11 @@ static int ptrace_resume(struct task_str
 	 * status and clears the code too; this can't race with the tracee, it
 	 * takes siglock after resume.
 	 */
-	need_siglock = data && !thread_group_empty(current);
-	if (need_siglock)
-		spin_lock_irq(&child->sighand->siglock);
+	spin_lock_irq(&child->sighand->siglock);
 	child->exit_code = data;
+	child->jobctl &= ~JOBCTL_TRACED;
 	wake_up_state(child, __TASK_TRACED);
-	if (need_siglock)
-		spin_unlock_irq(&child->sighand->siglock);
+	spin_unlock_irq(&child->sighand->siglock);
 
 	return 0;
 }
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -762,7 +762,10 @@ static int dequeue_synchronous_signal(ke
  */
 void signal_wake_up_state(struct task_struct *t, unsigned int state)
 {
+	lockdep_assert_held(&t->sighand->siglock);
+
 	set_tsk_thread_flag(t, TIF_SIGPENDING);
+
 	/*
 	 * TASK_WAKEKILL also means wake it up in the stopped/traced/killable
 	 * case. We don't check t->state here because there is a race with it
@@ -770,7 +773,9 @@ void signal_wake_up_state(struct task_st
 	 * By using wake_up_state, we ensure the process will wake up and
 	 * handle its death signal.
 	 */
-	if (!wake_up_state(t, state | TASK_INTERRUPTIBLE))
+	if (wake_up_state(t, state | TASK_INTERRUPTIBLE))
+		t->jobctl &= ~(JOBCTL_STOPPED | JOBCTL_TRACED);
+	else
 		kick_process(t);
 }
 
@@ -884,7 +889,7 @@ static int check_kill_permission(int sig
 static void ptrace_trap_notify(struct task_struct *t)
 {
 	WARN_ON_ONCE(!(t->ptrace & PT_SEIZED));
-	assert_spin_locked(&t->sighand->siglock);
+	lockdep_assert_held(&t->sighand->siglock);
 
 	task_set_jobctl_pending(t, JOBCTL_TRAP_NOTIFY);
 	ptrace_signal_wake_up(t, t->jobctl & JOBCTL_LISTENING);
@@ -930,9 +935,10 @@ static bool prepare_signal(int sig, stru
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
 
@@ -2219,6 +2225,7 @@ static int ptrace_stop(int exit_code, in
 	 * schedule() will not sleep if there is a pending signal that
 	 * can awaken the task.
 	 */
+	current->jobctl |= JOBCTL_TRACED;
 	set_special_state(TASK_TRACED);
 
 	/*
@@ -2460,6 +2467,7 @@ static bool do_signal_stop(int signr)
 		if (task_participate_group_stop(current))
 			notify = CLD_STOPPED;
 
+		current->jobctl |= JOBCTL_STOPPED;
 		set_special_state(TASK_STOPPED);
 		spin_unlock_irq(&current->sighand->siglock);
 


