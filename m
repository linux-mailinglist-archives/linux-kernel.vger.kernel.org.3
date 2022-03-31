Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AF34EDBA7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbiCaO1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbiCaO1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:27:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDF121D7DB
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:25:45 -0700 (PDT)
Date:   Thu, 31 Mar 2022 16:25:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648736744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eVO5xfizl7kLJqGlvaVxRBZN+VQX+b3DTT7c76e9swg=;
        b=UtKgGqh5kcMsm7gU/S6UptFNGD3VFad9coVRX5YefQt+Fg7AV+WBqREPG232TaqRLlkfkC
        B18KkScXGFLxCI5Y9J/DCKsipFhML2fPGMSvJ6mbAmJ3ZJuBZuML+ZcBB6bDzzr5aA5qxU
        eTmzTgHdoBhJ9PXM0ayWTZvhsHBTqT4FExotXjEHrZqVJDdMHNVC0LWyNdMVSJHDatAkLa
        EsMoyhKDr5dPYXIlcsMh1ymqpQexFzERwb1nLEkNpGGurp7/v7QZ3evG2mmqSfx9wDk6Na
        8JxhcCPHaylzqxKmD5BfjikZb4FKeIT9QZXC2C0I8bbZorgIvp8/p5cc/PEHHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648736744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eVO5xfizl7kLJqGlvaVxRBZN+VQX+b3DTT7c76e9swg=;
        b=R+AcH6xPrkRjjcReFabzP3WXOFvAroJLyybrzOgsbENep9GymYZuqF6P4Xdsswe745Ck4Y
        dIAGRdVIv9X0G3Cw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] ptrace: fix ptrace vs tasklist_lock race on PREEMPT_RT.
Message-ID: <YkW55u6u2fo5QmV7@linutronix.de>
References: <Yh/b19JikC+Vnm8i@linutronix.de>
 <20220314185429.GA30364@redhat.com>
 <YjBO8yzxdmjTGNiy@linutronix.de>
 <20220315142944.GA22670@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220315142944.GA22670@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As explained by Alexander Fyodorov <halcy@yandex.ru>:

|read_lock(&tasklist_lock) in ptrace_stop() is converted to sleeping
|lock on a PREEMPT_RT kernel, and it can remove __TASK_TRACED from
|task->__state (by moving  it to task->saved_state). If parent does
|wait() on child followed by a sys_ptrace call, the following race can
|happen:
|
|- child sets __TASK_TRACED in ptrace_stop()
|- parent does wait() which eventually calls wait_task_stopped() and returns
|  child's pid
|- child blocks on read_lock(&tasklist_lock) in ptrace_stop() and moves
|  __TASK_TRACED flag to saved_state
|- parent calls sys_ptrace, which calls ptrace_check_attach() and
|  wait_task_inactive()

The patch is based on his initial patch where an additional check is
added in case the __TASK_TRACED moved to ->saved_state. The pi_lock is
acquired to have stable view on ->__state and ->saved_state.

wait_task_inactive() needs to check both task states while waiting for the
expected task state. Should the expected task state be in ->saved_state then
the task is blocked on a sleeping lock. In this case wait_task_inactive() n=
eeds
to wait until the lock situtation has been resolved (the expected state is =
in
->__state). This ensures that the task is idle and does not wakeup as part =
of
lock resolving and races for instance with __switch_to_xtra() while the
debugger clears TIF_BLOCKSTEP() (noted by Oleg Nesterov).

[ Fix for ptrace_unfreeze_traced() by Oleg Nesterov ]

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2:
  - Use also ->saved_state in task_state_match_and_set().
  - Wait in wait_task_inactive() until the desired task state is in
    ->__state so that the task won't wake up a as part of lock
    resolving. Pointed out by Oleg Nesterov.

 include/linux/sched.h |  128 +++++++++++++++++++++++++++++++++++++++++++++=
+++--
 kernel/ptrace.c       |   25 +++++----
 kernel/sched/core.c   |   11 +++-
 3 files changed, 146 insertions(+), 18 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -118,12 +118,8 @@ struct task_group;
=20
 #define task_is_running(task)		(READ_ONCE((task)->__state) =3D=3D TASK_RUN=
NING)
=20
-#define task_is_traced(task)		((READ_ONCE(task->__state) & __TASK_TRACED) =
!=3D 0)
-
 #define task_is_stopped(task)		((READ_ONCE(task->__state) & __TASK_STOPPED=
) !=3D 0)
=20
-#define task_is_stopped_or_traced(task)	((READ_ONCE(task->__state) & (__TA=
SK_STOPPED | __TASK_TRACED)) !=3D 0)
-
 /*
  * Special states are those that do not use the normal wait-loop pattern. =
See
  * the comment with set_special_state().
@@ -2009,6 +2005,130 @@ static inline int test_tsk_need_resched(
 	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
 }
=20
+#ifdef CONFIG_PREEMPT_RT
+
+static inline bool task_state_match_and(struct task_struct *tsk, long stat=
e)
+{
+	unsigned long flags;
+	bool match =3D false;
+
+	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
+	if (READ_ONCE(tsk->__state) & state)
+		match =3D true;
+	else if (tsk->saved_state & state)
+		match =3D true;
+	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
+	return match;
+}
+
+static inline int __task_state_match_eq(struct task_struct *tsk, long stat=
e)
+{
+	int match =3D 0;
+
+	if (READ_ONCE(tsk->__state) =3D=3D state)
+		match =3D 1;
+	else if (tsk->saved_state =3D=3D state)
+		match =3D -1;
+
+	return match;
+}
+
+static inline int task_state_match_eq(struct task_struct *tsk, long state)
+{
+	unsigned long flags;
+	int match;
+
+	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
+	match =3D __task_state_match_eq(tsk, state);
+	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
+	return match;
+}
+
+static inline bool task_state_match_and_set(struct task_struct *tsk, long =
state,
+					    long new_state)
+{
+	unsigned long flags;
+	bool match =3D false;
+
+	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
+	if (READ_ONCE(tsk->__state) & state) {
+		WRITE_ONCE(tsk->__state, new_state);
+		match =3D true;
+	} else if (tsk->saved_state & state) {
+		tsk->saved_state =3D new_state;
+		match =3D true;
+	}
+	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
+	return match;
+}
+
+static inline bool task_state_match_eq_set(struct task_struct *tsk, long s=
tate,
+					   long new_state)
+{
+	unsigned long flags;
+	bool match =3D false;
+
+	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
+	if (READ_ONCE(tsk->__state) =3D=3D state) {
+		WRITE_ONCE(tsk->__state, new_state);
+		match =3D true;
+	} else if (tsk->saved_state =3D=3D state) {
+		tsk->saved_state =3D new_state;
+		match =3D true;
+	}
+	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
+	return match;
+}
+
+#else
+
+static inline bool task_state_match_and(struct task_struct *tsk, long stat=
e)
+{
+	return READ_ONCE(tsk->__state) & state;
+}
+
+static inline int __task_state_match_eq(struct task_struct *tsk, long stat=
e)
+{
+	return READ_ONCE(tsk->__state) =3D=3D state;
+}
+
+static inline int task_state_match_eq(struct task_struct *tsk, long state)
+{
+	return __task_state_match_eq(tsk, state);
+}
+
+static inline bool task_state_match_and_set(struct task_struct *tsk, long =
state,
+					    long new_state)
+{
+	if (READ_ONCE(tsk->__state) & state) {
+		WRITE_ONCE(tsk->__state, new_state);
+		return true;
+	}
+	return false;
+}
+
+static inline bool task_state_match_eq_set(struct task_struct *tsk, long s=
tate,
+					   long new_state)
+{
+	if (READ_ONCE(tsk->__state) =3D=3D state) {
+		WRITE_ONCE(tsk->__state, new_state);
+		return true;
+	}
+	return false;
+}
+
+#endif
+
+static inline bool task_is_traced(struct task_struct *tsk)
+{
+	return task_state_match_and(tsk, __TASK_TRACED);
+}
+
+static inline bool task_is_stopped_or_traced(struct task_struct *tsk)
+{
+	return task_state_match_and(tsk, __TASK_STOPPED | __TASK_TRACED);
+}
+
 /*
  * cond_resched() and cond_resched_lock(): latency reduction via
  * explicit rescheduling in places that are safe. The return
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -195,10 +195,10 @@ static bool ptrace_freeze_traced(struct
 		return ret;
=20
 	spin_lock_irq(&task->sighand->siglock);
-	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
-	    !__fatal_signal_pending(task)) {
-		WRITE_ONCE(task->__state, __TASK_TRACED);
-		ret =3D true;
+	if (!looks_like_a_spurious_pid(task) && !__fatal_signal_pending(task)) {
+
+		ret =3D task_state_match_and_set(task, __TASK_TRACED,
+					       __TASK_TRACED);
 	}
 	spin_unlock_irq(&task->sighand->siglock);
=20
@@ -207,7 +207,10 @@ static bool ptrace_freeze_traced(struct
=20
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	if (READ_ONCE(task->__state) !=3D __TASK_TRACED)
+	bool frozen;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
+	    READ_ONCE(task->__state) !=3D __TASK_TRACED)
 		return;
=20
 	WARN_ON(!task->ptrace || task->parent !=3D current);
@@ -217,12 +220,12 @@ static void ptrace_unfreeze_traced(struc
 	 * Recheck state under the lock to close this race.
 	 */
 	spin_lock_irq(&task->sighand->siglock);
-	if (READ_ONCE(task->__state) =3D=3D __TASK_TRACED) {
-		if (__fatal_signal_pending(task))
-			wake_up_state(task, __TASK_TRACED);
-		else
-			WRITE_ONCE(task->__state, TASK_TRACED);
-	}
+
+	frozen =3D task_state_match_eq_set(task, __TASK_TRACED, TASK_TRACED);
+
+	if (frozen && __fatal_signal_pending(task))
+		wake_up_state(task, __TASK_TRACED);
+
 	spin_unlock_irq(&task->sighand->siglock);
 }
=20
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3219,6 +3219,8 @@ unsigned long wait_task_inactive(struct
 	struct rq *rq;
=20
 	for (;;) {
+		int match_type =3D 0;
+
 		/*
 		 * We do the initial early heuristics without holding
 		 * any task-queue locks at all. We'll only try to get
@@ -3239,7 +3241,8 @@ unsigned long wait_task_inactive(struct
 		 * is actually now running somewhere else!
 		 */
 		while (task_running(rq, p)) {
-			if (match_state && unlikely(READ_ONCE(p->__state) !=3D match_state))
+			if (match_state &&
+			    unlikely(!task_state_match_eq(p, match_state)))
 				return 0;
 			cpu_relax();
 		}
@@ -3254,7 +3257,9 @@ unsigned long wait_task_inactive(struct
 		running =3D task_running(rq, p);
 		queued =3D task_on_rq_queued(p);
 		ncsw =3D 0;
-		if (!match_state || READ_ONCE(p->__state) =3D=3D match_state)
+		if (match_state)
+			match_type =3D __task_state_match_eq(p, match_state);
+		if (!match_state || match_type)
 			ncsw =3D p->nvcsw | LONG_MIN; /* sets MSB */
 		task_rq_unlock(rq, p, &rf);
=20
@@ -3284,7 +3289,7 @@ unsigned long wait_task_inactive(struct
 		 * running right now), it's preempted, and we should
 		 * yield - it could be a while.
 		 */
-		if (unlikely(queued)) {
+		if (unlikely(queued || match_type < 0)) {
 			ktime_t to =3D NSEC_PER_SEC / HZ;
=20
 			set_current_state(TASK_UNINTERRUPTIBLE);
