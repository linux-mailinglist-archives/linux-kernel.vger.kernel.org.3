Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216DE4FE04E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbiDLMeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245744AbiDLMdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:33:18 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AA95A149;
        Tue, 12 Apr 2022 04:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=YkcanMudUrrWwtCRX80sZvYWSgv9wqc6arRCEIrUa2c=; b=DowUsHVCTdJrX61F02nRZe9+b1
        vNUfGe0yV+4Gzy1fW/WyyLmCt+3yzKOR+1G3Q/mwporGdR2QhiTPVQsbaPx2xGJx4aNxRBG+pB6mP
        zAyi8rBTahlEne/2Q/93AccIh/eeEaAax0r5+f5dWt28KuMaVoJoRlAFE3Ox78/OfEyEDwZNKOcax
        fuagcO9tpllfhKn3JPwfPiXWcVDJ9w8gUec2yTVDr44746nTzu3/ePQ89qUpewRnkjBbFT0hHQkPc
        zSiO5MGuCeh7ZseCU884xHhe6M9a2VJ9/zadm27LK623qf1FaUHizlZlpPHASecxFSj4EXbW/UBas
        v4HvTStQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neF2o-004JiY-Ih; Tue, 12 Apr 2022 11:50:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6238D3002DE;
        Tue, 12 Apr 2022 13:50:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4399C3017A05D; Tue, 12 Apr 2022 13:50:47 +0200 (CEST)
Message-ID: <20220412114853.842942162@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 12 Apr 2022 13:44:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, ebiederm@xmission.com,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
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

Currently ptrace_check_attach() / ptrace_freeze_traced() rely on
specific scheduler behaviour to freeze the task. In specific, it
relies on there not being any blocking behaviour between:

  set_special_state(TASK_TRACED);
  ...
  schedule();

specifically it relies on being able to change p->__state between
those two points (to clear/set TASK_WAKEKILL) and relies on
wait_task_inactive() to ensure the task has hit that schedule().

However, PREEMPT_RT is breaking this by introducing sleeping
spinlocks. The consequence of sleeping spinlocks is that p->__state
can change (also see p->saved_state) and that a task can be inactive
(off the runqueue) and *NOT* be at the schedule() as expected.

That is, both the p->__state and wait_task_inactive() usage are
broken.

In order to avoid having to deal with p->saved_state, flip the
wait_task_inactive() and p->__state poking. That is, first wait for
the victim to be in schedule() and then poke p->__state, which is in a
known state by then.

The only problem with this is that it's possible to race with a
concurrent ptrace_detach()+pthread_attach() landing back in the same
situation as before. To deal with this, compare the task's nvcsw
count to make sure there is no scheduling between the initial
quiescence and the final task state poking.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/ptrace.c     |  175 +++++++++++++++++++++++++++++++++++++++++-----------
 kernel/sched/core.c |    5 -
 2 files changed, 141 insertions(+), 39 deletions(-)

--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -186,31 +186,13 @@ static bool looks_like_a_spurious_pid(st
 }
 
 /*
- * Ensure that nothing can wake it up, even SIGKILL
+ * Ptrace operation is complete, re-allow TASK_WAKEKILL.
  *
- * A task is switched to this state while a ptrace operation is in progress;
- * such that the ptrace operation is uninterruptible.
+ * Unfreeze is easy, since ptrace_check_attach() guarantees the task is off the
+ * runqueue and __TASK_TRACED. If it's still __TASK_TRACED holding
+ * sighand->siglock serializes against ptrace_signal_wake_up() and we can
+ * simply put TASK_WAKEKILL back (or wake because there's a pending fatal).
  */
-static bool ptrace_freeze_traced(struct task_struct *task)
-{
-	bool ret = false;
-
-	/* Lockless, nobody but us can set this flag */
-	if (task->jobctl & JOBCTL_LISTENING)
-		return ret;
-
-	spin_lock_irq(&task->sighand->siglock);
-	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
-	    !__fatal_signal_pending(task)) {
-		task->jobctl |= JOBCTL_TRACED_FROZEN;
-		WRITE_ONCE(task->__state, __TASK_TRACED);
-		ret = true;
-	}
-	spin_unlock_irq(&task->sighand->siglock);
-
-	return ret;
-}
-
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
 	if (READ_ONCE(task->__state) != __TASK_TRACED)
@@ -234,6 +216,94 @@ static void ptrace_unfreeze_traced(struc
 	spin_unlock_irq(&task->sighand->siglock);
 }
 
+/*
+ * In order to start a ptrace operation the victim task must be off the
+ * runqueue in state __TASK_TRACED.
+ */
+static int __ptrace_freeze_cond(struct task_struct *p)
+{
+	if (!task_is_traced(p))
+		return -ESRCH;
+
+	if (task_curr(p))
+		return -EINPROGRESS;
+
+	if (p->on_rq)
+		return -EWOULDBLOCK;
+
+	/*
+	 * Due to PREEMPT_RT it is possible the task is blocked on a spinlock
+	 * in state TASK_RTLOCK_WAIT, if so, gotta wait until that goes away.
+	 */
+	if (!(READ_ONCE(p->__state) & __TASK_TRACED))
+		return -EWOULDBLOCK;
+
+	return 0;
+}
+
+/*
+ * Returns:
+ *  0:		  task is off runqueue in TASK_TRACED
+ *  -ESRCH:	  not traced
+ *  -EINPROGRESS: still running
+ *  -EWOULDBLOCK: not running
+ */
+static int __ptrace_pre_freeze(struct task_struct *p, void *arg)
+{
+	int ret;
+
+	ret = __ptrace_freeze_cond(p);
+	if (ret)
+		return ret;
+
+	*(unsigned long *)arg = p->nvcsw;
+
+	return 0;
+}
+
+/*
+ * Returns:
+ *  0:		  task is off runqueue, now __TASK_TRACED
+ *  -ESRCH:	  not traced, or scheduled since pre_freeze
+ *  -GAIN:	  still running
+ *  -EWOULDBLOCK: not running
+ */
+static int __ptrace_freeze(struct task_struct *p, void *arg)
+{
+	int ret;
+
+	ret = __ptrace_freeze_cond(p);
+	if (ret)
+		return ret;
+
+	/*
+	 * Task scheduled between __ptrace_pre_freeze() and here, not our task
+	 * anymore.
+	 */
+	if (*(unsigned long *)arg != p->nvcsw)
+		return -ESRCH;
+
+	if (looks_like_a_spurious_pid(p))
+		return -ESRCH;
+
+	if (__fatal_signal_pending(p))
+		return -ESRCH;
+
+	/*
+	 * we hold:
+	 *
+	 *  - tasklist_lock       (avoids ptrace_detach)
+	 *  - p->sighand->siglock (avoids ptrace_signal_wake_up)
+	 *  - p->pi_lock          (avoids anything scheduler)
+	 *
+	 * task is absolutely frozen, now we can safely take out
+	 * TASK_WAKEKILL.
+	 */
+	p->jobctl |= JOBCTL_TRACED_FROZEN;
+	WRITE_ONCE(p->__state, __TASK_TRACED);
+	return 0;
+}
+
 /**
  * ptrace_check_attach - check whether ptracee is ready for ptrace operation
  * @child: ptracee to check for
@@ -253,7 +323,36 @@ static void ptrace_unfreeze_traced(struc
  */
 static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 {
-	int ret = -ESRCH;
+	ktime_t to = TICK_NSEC;
+	unsigned long nvcsw;
+	int ret;
+
+	if (child == current)
+		return -ESRCH;
+
+	if (!ignore_state) for (;;) {
+		/*
+		 * Ensure this child is a quiescent TASK_TRACED task.
+		 */
+		ret = task_call_func(child, __ptrace_pre_freeze, &nvcsw);
+		switch (ret) {
+		case 0:
+			break;
+		case -ESRCH:
+			return ret;
+		case -EINPROGRESS:
+			while (task_curr(child))
+				cpu_relax();
+			continue;
+		case -EWOULDBLOCK:
+			/*
+			 * XXX horrible, randomly wait 1 tick and try again.
+			 */
+			set_current_state(TASK_UNINTERRUPTIBLE);
+			schedule_hrtimeout(&to, HRTIMER_MODE_REL_HARD);
+			continue;
+		}
+	}
 
 	/*
 	 * We take the read lock around doing both checks to close a
@@ -262,29 +361,35 @@ static int ptrace_check_attach(struct ta
 	 * we are sure that this is our traced child and that can only
 	 * be changed by us so it's not changing right after this.
 	 */
+	ret = -ESRCH;
 	read_lock(&tasklist_lock);
 	if (child->ptrace && child->parent == current) {
 		WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
+		if (ignore_state) {
+			ret = 0;
+			goto unlock;
+		}
+
+		if (child->jobctl & JOBCTL_LISTENING)
+			goto unlock;
+
 		/*
 		 * child->sighand can't be NULL, release_task()
 		 * does ptrace_unlink() before __exit_signal().
 		 */
-		if (ignore_state || ptrace_freeze_traced(child))
-			ret = 0;
-	}
-	read_unlock(&tasklist_lock);
-
-	if (!ret && !ignore_state) {
-		if (!wait_task_inactive(child, __TASK_TRACED)) {
+		spin_lock_irq(&child->sighand->siglock);
+		ret = task_call_func(child, __ptrace_freeze, &nvcsw);
+		if (ret) {
 			/*
-			 * This can only happen if may_ptrace_stop() fails and
-			 * ptrace_stop() changes ->state back to TASK_RUNNING,
-			 * so we should not worry about leaking __TASK_TRACED.
+			 * If *anything* changed since __ptrace_pre_freeze()
+			 * this fails.
 			 */
-			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
 			ret = -ESRCH;
 		}
+		spin_unlock_irq(&child->sighand->siglock);
 	}
+unlock:
+	read_unlock(&tasklist_lock);
 
 	return ret;
 }
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


