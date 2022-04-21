Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C06509DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388388AbiDUKaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbiDUK3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:29:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827A4110E;
        Thu, 21 Apr 2022 03:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8g5TaMU5yRqdoEGWhzsIuKrXRuMgG+v+35JrddlEHgQ=; b=a9IDSSTAjl8yj++mVffHh3aayR
        yz+yPRCpE5P3a1v06m7PA7lmIVvp4GjyrpaLBwwP6oJCztGh4/822r84eL/qXoS4u2tFfzYz7eii3
        oltmBCQuviMJ0psJqyqb2nI5JypCP4mkdTpyGqE9y98bGb7uhEQ6MmhX6IdSXhkxBuOgvwtNIr8Bl
        JfOy48GssEFyWAcwktG6/wYnGAuQlQOxRHikqlhD5Hvkh5CQ6MWJHDPMykM+S5r/xHOrR7NyQ4pV2
        2mGfCOPcaY6Qndd+88TORRQtdcTVY9SxzbKDahm31xvkOcfcXnmMGxEOKBdAcrcJKZfw+H9V9nEQT
        ASFt6Tuw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhU1C-007NBd-4r; Thu, 21 Apr 2022 10:26:34 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F22FE9861C1; Thu, 21 Apr 2022 12:26:31 +0200 (CEST)
Date:   Thu, 21 Apr 2022 12:26:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, rjw@rjwysocki.net,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC][PATCH] ptrace: Don't change __state
Message-ID: <20220421102631.GE2762@worktop.programming.kicks-ass.net>
References: <20220414183433.GC32752@redhat.com>
 <YlikBjA3kL3XEQP5@hirez.programming.kicks-ass.net>
 <20220415101644.GA10421@redhat.com>
 <20220415105755.GA15217@redhat.com>
 <Yllep6B8eva2VURJ@hirez.programming.kicks-ass.net>
 <20220418170104.GA16199@redhat.com>
 <20220420131731.GF2731@worktop.programming.kicks-ass.net>
 <20220420180323.GA14947@redhat.com>
 <875yn3zdag.fsf_-_@email.froward.int.ebiederm.org>
 <20220421072138.GI2731@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421072138.GI2731@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 09:21:38AM +0200, Peter Zijlstra wrote:
> > @@ -267,13 +266,13 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
> >  	read_unlock(&tasklist_lock);
> >  
> >  	if (!ret && !ignore_state) {
> > -		if (!wait_task_inactive(child, __TASK_TRACED)) {
> > +		if (!wait_task_inactive(child, TASK_TRACED)) {
> 
> This is still very dubious, there are spinlocks between
> set_current_state(TASK_TRACED) and schedule(), so wait_task_inactive()
> can fail where we don't want it to due to TASK_TRACED being temporarily
> held in ->saved_state.

As such, I've taken the liberty of munging yours and Oleg's approach
together. I've yet to actually test this but it looks feasible.

---
--- a/include/linux/sched/jobctl.h
+++ b/include/linux/sched/jobctl.h
@@ -19,9 +19,11 @@ struct task_struct;
 #define JOBCTL_TRAPPING_BIT	21	/* switching to TRACED */
 #define JOBCTL_LISTENING_BIT	22	/* ptracer is listening for events */
 #define JOBCTL_TRAP_FREEZE_BIT	23	/* trap for cgroup freezer */
+#define JOBCTL_DELAY_WAKEKILL_BIT 24	/* delay killable wakeups */
 
-#define JOBCTL_STOPPED_BIT	24
-#define JOBCTL_TRACED_BIT	25
+#define JOBCTL_STOPPED_BIT	25
+#define JOBCTL_TRACED_BIT	26
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
@@ -193,26 +193,32 @@ static bool looks_like_a_spurious_pid(st
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
+	if (READ_ONCE(task->__state) == TASK_TRACED &&
+	    !looks_like_a_spurious_pid(task) &&
 	    !__fatal_signal_pending(task)) {
-		WRITE_ONCE(task->__state, __TASK_TRACED);
+		WARN_ON_ONCE(!task_is_traced(task));
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
@@ -222,12 +228,11 @@ static void ptrace_unfreeze_traced(struc
 	 * Recheck state under the lock to close this race.
 	 */
 	spin_lock_irq(&task->sighand->siglock);
-	if (READ_ONCE(task->__state) == __TASK_TRACED) {
-		if (__fatal_signal_pending(task)) {
-			task->jobctl &= ~JOBCTL_TRACED;
-			wake_up_state(task, __TASK_TRACED);
-		} else
-			WRITE_ONCE(task->__state, TASK_TRACED);
+//	WARN_ON_ONCE(!(task->jobctl & JOBCTL_DELAY_WAKEKILL));
+	task->jobctl &= ~JOBCTL_DELAY_WAKEKILL;
+	if (__fatal_signal_pending(task)) {
+		task->jobctl &= ~JOBCTL_TRACED;
+		wake_up_state(task, TASK_WAKEKILL);
 	}
 	spin_unlock_irq(&task->sighand->siglock);
 }
@@ -251,40 +256,46 @@ static void ptrace_unfreeze_traced(struc
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
+	WARN_ON_ONCE(READ_ONCE(child->__state) == __TASK_TRACED);
+	WARN_ON_ONCE(READ_ONCE(child->jobctl) & JOBCTL_DELAY_WAKEKILL);
+
+	if (ignore_state)
+		return 0;
+
+	if (!task_is_traced(child))
+		return -ESRCH;
+
+	/* wait for JOBCTL_TRACED_QUIESCE to go away, see ptrace_stop() */
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
@@ -1329,8 +1340,7 @@ SYSCALL_DEFINE4(ptrace, long, request, l
 		goto out_put_task_struct;
 
 	ret = arch_ptrace(child, request, addr, data);
-	if (ret || request != PTRACE_DETACH)
-		ptrace_unfreeze_traced(child);
+	ptrace_unfreeze_traced(child);
 
  out_put_task_struct:
 	put_task_struct(child);
@@ -1472,8 +1482,7 @@ COMPAT_SYSCALL_DEFINE4(ptrace, compat_lo
 				  request == PTRACE_INTERRUPT);
 	if (!ret) {
 		ret = compat_arch_ptrace(child, request, addr, data);
-		if (ret || request != PTRACE_DETACH)
-			ptrace_unfreeze_traced(child);
+		ptrace_unfreeze_traced(child);
 	}
 
  out_put_task_struct:
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
