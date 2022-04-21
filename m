Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E526250A3BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 17:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389916AbiDUPNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 11:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389881AbiDUPNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 11:13:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239AB2F3B1;
        Thu, 21 Apr 2022 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=uC9Q8gMKi0sDdYgcl7ndC55xzbrgbUPkwPLGz7U5puw=; b=q7ayW9MyHkJ95jurnDkIA6E4Qb
        J7ivj8vvxrehJbVXoyu9Hrcr+NGh5/pqu1fi+U0Eu6wAxRByLietVaVpTYGcPF9RVuiRFUlvMc2CK
        z3Yxp1gFzxjhMkrh4fYmYcjmj7laVidQLCkGhbtxGWvdIKNLUQCACap4Nh+Y9b/HNi0CJ7yhJKDNr
        MOesr/hw4P3VVryqHt9Bj6DCb8jKFf+ZRNHwN5xFgPr0BGuqBiy0L7wpB5nIdYx+s1MkrbrJM2Ert
        jLCRdAvo6hZfY0G9Ki/cCuunbC3fW90vFx3wvuDRDCWTY7h4n7MXMDFgEqS/i7QwV6K0g61nbLqaL
        7GNn7Peg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhYRk-007QKO-4c; Thu, 21 Apr 2022 15:10:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 971BA30040C;
        Thu, 21 Apr 2022 17:10:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6C9C52B553DEF; Thu, 21 Apr 2022 17:10:13 +0200 (CEST)
Message-ID: <20220421150654.817117821@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 21 Apr 2022 17:02:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, ebiederm@xmission.com,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
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

Rework ptrace_check_attach() / ptrace_unfreeze_traced() to not rely on
task->__state as much.

Due to how PREEMPT_RT is changing the rules vs task->__state with the
introduction of task->saved_state while TASK_RTLOCK_WAIT (the whole
blocking spinlock thing), the way ptrace freeze tries to do things no
longer works.

Specifically there are two problems:

 - due to ->saved_state, the ->__state modification removing
   TASK_WAKEKILL no longer works reliably.

 - due to ->saved_state, wait_task_inactive() also no longer works
   reliably.

The first problem is solved by a suggestion from Eric that instead
of changing __state, TASK_WAKEKILL be delayed.

The second problem is solved by a suggestion from Oleg; add
JOBCTL_TRACED_QUIESCE to cover the chunk of code between
set_current_state(TASK_TRACED) and schedule(), such that
ptrace_check_attach() can first wait for JOBCTL_TRACED_QUIESCE to get
cleared, and then use wait_task_inactive().

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched/jobctl.h |    8 ++-
 kernel/ptrace.c              |   90 ++++++++++++++++++++++---------------------
 kernel/sched/core.c          |    5 --
 kernel/signal.c              |   36 ++++++++++++++---
 4 files changed, 86 insertions(+), 53 deletions(-)

--- a/include/linux/sched/jobctl.h
+++ b/include/linux/sched/jobctl.h
@@ -19,9 +19,11 @@ struct task_struct;
 #define JOBCTL_TRAPPING_BIT	21	/* switching to TRACED */
 #define JOBCTL_LISTENING_BIT	22	/* ptracer is listening for events */
 #define JOBCTL_TRAP_FREEZE_BIT	23	/* trap for cgroup freezer */
+#define JOBCTL_DELAY_WAKEKILL_BIT 24	/* delay killable wakeups */
 
-#define JOBCTL_STOPPED_BIT	24	/* do_signal_stop() */
-#define JOBCTL_TRACED_BIT	25	/* ptrace_stop() */
+#define JOBCTL_STOPPED_BIT	25	/* do_signal_stop() */
+#define JOBCTL_TRACED_BIT	26	/* ptrace_stop() */
+#define JOBCTL_TRACED_QUIESCE_BIT 27
 
 #define JOBCTL_STOP_DEQUEUED	(1UL << JOBCTL_STOP_DEQUEUED_BIT)
 #define JOBCTL_STOP_PENDING	(1UL << JOBCTL_STOP_PENDING_BIT)
@@ -31,9 +33,11 @@ struct task_struct;
 #define JOBCTL_TRAPPING		(1UL << JOBCTL_TRAPPING_BIT)
 #define JOBCTL_LISTENING	(1UL << JOBCTL_LISTENING_BIT)
 #define JOBCTL_TRAP_FREEZE	(1UL << JOBCTL_TRAP_FREEZE_BIT)
+#define JOBCTL_DELAY_WAKEKILL	(1UL << JOBCTL_DELAY_WAKEKILL_BIT)
 
 #define JOBCTL_STOPPED		(1UL << JOBCTL_STOPPED_BIT)
 #define JOBCTL_TRACED		(1UL << JOBCTL_TRACED_BIT)
+#define JOBCTL_TRACED_QUIESCE	(1UL << JOBCTL_TRACED_QUIESCE_BIT)
 
 #define JOBCTL_TRAP_MASK	(JOBCTL_TRAP_STOP | JOBCTL_TRAP_NOTIFY)
 #define JOBCTL_PENDING_MASK	(JOBCTL_STOP_PENDING | JOBCTL_TRAP_MASK)
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -193,41 +193,44 @@ static bool looks_like_a_spurious_pid(st
  */
 static bool ptrace_freeze_traced(struct task_struct *task)
 {
+	unsigned long flags;
 	bool ret = false;
 
 	/* Lockless, nobody but us can set this flag */
 	if (task->jobctl & JOBCTL_LISTENING)
 		return ret;
 
-	spin_lock_irq(&task->sighand->siglock);
-	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
+	if (!lock_task_sighand(task, &flags))
+		return ret;
+
+	if (task_is_traced(task) &&
+	    !looks_like_a_spurious_pid(task) &&
 	    !__fatal_signal_pending(task)) {
-		WRITE_ONCE(task->__state, __TASK_TRACED);
+		WARN_ON_ONCE(READ_ONCE(task->__state) != TASK_TRACED);
+		WARN_ON_ONCE(task->jobctl & JOBCTL_DELAY_WAKEKILL);
+		task->jobctl |= JOBCTL_DELAY_WAKEKILL;
 		ret = true;
 	}
-	spin_unlock_irq(&task->sighand->siglock);
+	unlock_task_sighand(task, &flags);
 
 	return ret;
 }
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	if (READ_ONCE(task->__state) != __TASK_TRACED)
+	if (!task_is_traced(task))
 		return;
 
 	WARN_ON(!task->ptrace || task->parent != current);
 
-	/*
-	 * PTRACE_LISTEN can allow ptrace_trap_notify to wake us up remotely.
-	 * Recheck state under the lock to close this race.
-	 */
 	spin_lock_irq(&task->sighand->siglock);
-	if (READ_ONCE(task->__state) == __TASK_TRACED) {
+	if (task_is_traced(task)) {
+//		WARN_ON_ONCE(!(task->jobctl & JOBCTL_DELAY_WAKEKILL));
+		task->jobctl &= ~JOBCTL_DELAY_WAKEKILL;
 		if (__fatal_signal_pending(task)) {
 			task->jobctl &= ~JOBCTL_TRACED;
-			wake_up_state(task, __TASK_TRACED);
-		} else
-			WRITE_ONCE(task->__state, TASK_TRACED);
+			wake_up_state(task, TASK_WAKEKILL);
+		}
 	}
 	spin_unlock_irq(&task->sighand->siglock);
 }
@@ -251,40 +254,45 @@ static void ptrace_unfreeze_traced(struc
  */
 static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 {
-	int ret = -ESRCH;
+	int traced;
 
 	/*
 	 * We take the read lock around doing both checks to close a
-	 * possible race where someone else was tracing our child and
-	 * detached between these two checks.  After this locked check,
-	 * we are sure that this is our traced child and that can only
-	 * be changed by us so it's not changing right after this.
+	 * possible race where someone else attaches or detaches our
+	 * natural child.
 	 */
 	read_lock(&tasklist_lock);
-	if (child->ptrace && child->parent == current) {
-		WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
-		/*
-		 * child->sighand can't be NULL, release_task()
-		 * does ptrace_unlink() before __exit_signal().
-		 */
-		if (ignore_state || ptrace_freeze_traced(child))
-			ret = 0;
-	}
+	traced = child->ptrace && child->parent == current;
 	read_unlock(&tasklist_lock);
+	if (!traced)
+		return -ESRCH;
 
-	if (!ret && !ignore_state) {
-		if (!wait_task_inactive(child, __TASK_TRACED)) {
-			/*
-			 * This can only happen if may_ptrace_stop() fails and
-			 * ptrace_stop() changes ->state back to TASK_RUNNING,
-			 * so we should not worry about leaking __TASK_TRACED.
-			 */
-			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
-			ret = -ESRCH;
-		}
+	if (ignore_state)
+		return 0;
+
+	if (!task_is_traced(child))
+		return -ESRCH;
+
+	WARN_ON_ONCE(READ_ONCE(child->jobctl) & JOBCTL_DELAY_WAKEKILL);
+
+	/* Wait for JOBCTL_TRACED_QUIESCE to go away, see ptrace_stop(). */
+	for (;;) {
+		if (fatal_signal_pending(current))
+			return -EINTR;
+
+		set_current_state(TASK_KILLABLE);
+		if (!(READ_ONCE(child->jobctl) & JOBCTL_TRACED_QUIESCE))
+			break;
+
+		schedule();
 	}
+	__set_current_state(TASK_RUNNING);
 
-	return ret;
+	if (!wait_task_inactive(child, TASK_TRACED) ||
+	    !ptrace_freeze_traced(child))
+		return -ESRCH;
+
+	return 0;
 }
 
 static bool ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
@@ -1329,8 +1337,7 @@ SYSCALL_DEFINE4(ptrace, long, request, l
 		goto out_put_task_struct;
 
 	ret = arch_ptrace(child, request, addr, data);
-	if (ret || request != PTRACE_DETACH)
-		ptrace_unfreeze_traced(child);
+	ptrace_unfreeze_traced(child);
 
  out_put_task_struct:
 	put_task_struct(child);
@@ -1472,8 +1479,7 @@ COMPAT_SYSCALL_DEFINE4(ptrace, compat_lo
 				  request == PTRACE_INTERRUPT);
 	if (!ret) {
 		ret = compat_arch_ptrace(child, request, addr, data);
-		if (ret || request != PTRACE_DETACH)
-			ptrace_unfreeze_traced(child);
+		ptrace_unfreeze_traced(child);
 	}
 
  out_put_task_struct:
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6310,10 +6310,7 @@ static void __sched notrace __schedule(u
 
 	/*
 	 * We must load prev->state once (task_struct::state is volatile), such
-	 * that:
-	 *
-	 *  - we form a control dependency vs deactivate_task() below.
-	 *  - ptrace_{,un}freeze_traced() can change ->state underneath us.
+	 * that we form a control dependency vs deactivate_task() below.
 	 */
 	prev_state = READ_ONCE(prev->__state);
 	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -764,6 +764,10 @@ void signal_wake_up_state(struct task_st
 {
 	lockdep_assert_held(&t->sighand->siglock);
 
+	/* Suppress wakekill? */
+	if (t->jobctl & JOBCTL_DELAY_WAKEKILL)
+		state &= ~TASK_WAKEKILL;
+
 	set_tsk_thread_flag(t, TIF_SIGPENDING);
 
 	/*
@@ -774,7 +778,7 @@ void signal_wake_up_state(struct task_st
 	 * handle its death signal.
 	 */
 	if (wake_up_state(t, state | TASK_INTERRUPTIBLE))
-		t->jobctl &= ~(JOBCTL_STOPPED | JOBCTL_TRACED);
+		t->jobctl &= ~(JOBCTL_STOPPED | JOBCTL_TRACED | JOBCTL_TRACED_QUIESCE);
 	else
 		kick_process(t);
 }
@@ -2187,6 +2191,15 @@ static void do_notify_parent_cldstop(str
 	spin_unlock_irqrestore(&sighand->siglock, flags);
 }
 
+static void clear_traced_quiesce(void)
+{
+	spin_lock_irq(&current->sighand->siglock);
+	WARN_ON_ONCE(!(current->jobctl & JOBCTL_TRACED_QUIESCE));
+	current->jobctl &= ~JOBCTL_TRACED_QUIESCE;
+	wake_up_state(current->parent, TASK_KILLABLE);
+	spin_unlock_irq(&current->sighand->siglock);
+}
+
 /*
  * This must be called with current->sighand->siglock held.
  *
@@ -2225,7 +2238,7 @@ static int ptrace_stop(int exit_code, in
 	 * schedule() will not sleep if there is a pending signal that
 	 * can awaken the task.
 	 */
-	current->jobctl |= JOBCTL_TRACED;
+	current->jobctl |= JOBCTL_TRACED | JOBCTL_TRACED_QUIESCE;
 	set_special_state(TASK_TRACED);
 
 	/*
@@ -2290,14 +2303,26 @@ static int ptrace_stop(int exit_code, in
 		/*
 		 * Don't want to allow preemption here, because
 		 * sys_ptrace() needs this task to be inactive.
-		 *
-		 * XXX: implement read_unlock_no_resched().
 		 */
 		preempt_disable();
 		read_unlock(&tasklist_lock);
-		cgroup_enter_frozen();
+		cgroup_enter_frozen(); // XXX broken on PREEMPT_RT !!!
+
+		/*
+		 * JOBCTL_TRACE_QUIESCE bridges the gap between
+		 * set_current_state(TASK_TRACED) above and schedule() below.
+		 * There must not be any blocking (specifically anything that
+		 * touched ->saved_state on PREEMPT_RT) between here and
+		 * schedule().
+		 *
+		 * ptrace_check_attach() relies on this with its
+		 * wait_task_inactive() usage.
+		 */
+		clear_traced_quiesce();
+
 		preempt_enable_no_resched();
 		freezable_schedule();
+
 		cgroup_leave_frozen(true);
 	} else {
 		/*
@@ -2335,6 +2360,7 @@ static int ptrace_stop(int exit_code, in
 
 	/* LISTENING can be set only during STOP traps, clear it */
 	current->jobctl &= ~JOBCTL_LISTENING;
+	current->jobctl &= ~JOBCTL_DELAY_WAKEKILL;
 
 	/*
 	 * Queued signals ignored us while we were stopped for tracing.


