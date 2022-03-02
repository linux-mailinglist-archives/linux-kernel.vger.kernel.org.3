Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D384CB09F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 22:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243247AbiCBVFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 16:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiCBVFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 16:05:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF1A9FEE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 13:04:26 -0800 (PST)
Date:   Wed, 2 Mar 2022 22:04:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646255065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=fg/sKQ6f0UV33GcmF/GgkQhpvpQCCUt1A4rnP2trdOo=;
        b=qPN4FeBbNwIKWXxIxEREfdukZRCz0Bj7ltVAh31MwkLB13Rbn9qwDsw6GpXScPtJ4raJmU
        go2+TA8Ij+9tlJDyAq6MVaxLcf3YoiK6iMU5a/7MqECTg1jxvibz5yrnRwMCyVLziSCPZw
        EjsuZFfTWtUmpPbuqdQ5r28+Ho1phIDm/dip3EvATdJy6OE4jXALwbNunDkB1o+nXAsvAf
        55pZmmsUJXm450o9TyGisWs7E+mROijbn3ABA3UwdDmfSoS9GuJn/Zr8Jcd9Gr0AhDLgxD
        CEbBZtqCxMA5yeC/ke8zhu4wVGB0Nt/ZzTxcT2uPHmrdNlHTQc2xpW0CuT5N2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646255065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=fg/sKQ6f0UV33GcmF/GgkQhpvpQCCUt1A4rnP2trdOo=;
        b=bUuxBCgUD4OQdc1ZyizODOkBwnEcQEUvYqG2Z2aEYBAQ0tIUmAHvQu9Tdktk5pAfDAM0Ew
        ASthJQVzqdzYVABA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] ptrace: fix ptrace vs tasklist_lock race on PREEMPT_RT.
Message-ID: <Yh/b19JikC+Vnm8i@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
|task->state (by moving  it to task->saved_state). If parent does
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
taken in case the caller is interrupted between looking into ->state and
->saved_state.

[ Fix for ptrace_unfreeze_traced() by Oleg Nesterov ]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

I redid the state matching part compared to what I had in my queue so it
hopefully looks better.

 include/linux/sched.h | 127 ++++++++++++++++++++++++++++++++++++++++--
 kernel/ptrace.c       |  25 +++++----
 kernel/sched/core.c   |   5 +-
 3 files changed, 140 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 75ba8aa60248b..73109ce7ce789 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -118,12 +118,8 @@ struct task_group;
 
 #define task_is_running(task)		(READ_ONCE((task)->__state) == TASK_RUNNING)
 
-#define task_is_traced(task)		((READ_ONCE(task->__state) & __TASK_TRACED) != 0)
-
 #define task_is_stopped(task)		((READ_ONCE(task->__state) & __TASK_STOPPED) != 0)
 
-#define task_is_stopped_or_traced(task)	((READ_ONCE(task->__state) & (__TASK_STOPPED | __TASK_TRACED)) != 0)
-
 /*
  * Special states are those that do not use the normal wait-loop pattern. See
  * the comment with set_special_state().
@@ -2006,6 +2002,129 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
 	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
 }
 
+#ifdef CONFIG_PREEMPT_RT
+
+static inline bool task_state_match_and(struct task_struct *tsk, long state)
+{
+	unsigned long flags;
+	bool match = false;
+
+	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
+	if (READ_ONCE(tsk->__state) & state)
+		match = true;
+	else if (tsk->saved_state & state)
+		match = true;
+	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
+	return match;
+}
+
+static inline bool __task_state_match_eq(struct task_struct *tsk, long state)
+{
+	bool match = false;
+
+	if (READ_ONCE(tsk->__state) == state)
+		match = true;
+	else if (tsk->saved_state == state)
+		match = true;
+	return match;
+}
+
+static inline bool task_state_match_eq(struct task_struct *tsk, long state)
+{
+	unsigned long flags;
+	bool match;
+
+	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
+	match = __task_state_match_eq(tsk, state);
+	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
+	return match;
+}
+
+static inline bool task_state_match_and_set(struct task_struct *tsk, long state,
+					    long new_state)
+{
+	unsigned long flags;
+	bool match = false;
+
+	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
+	if (READ_ONCE(tsk->__state) & state) {
+		WRITE_ONCE(tsk->__state, new_state);
+		match = true;
+	} else if (tsk->saved_state & state) {
+		tsk->__state = new_state;
+		match = true;
+	}
+	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
+	return match;
+}
+
+static inline bool task_state_match_eq_set(struct task_struct *tsk, long state,
+					   long new_state)
+{
+	unsigned long flags;
+	bool match = false;
+
+	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
+	if (READ_ONCE(tsk->__state) == state) {
+		WRITE_ONCE(tsk->__state, new_state);
+		match = true;
+	} else if (tsk->saved_state == state) {
+		tsk->saved_state = new_state;
+		match = true;
+	}
+	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
+	return match;
+}
+
+#else
+
+static inline bool task_state_match_and(struct task_struct *tsk, long state)
+{
+	return READ_ONCE(tsk->__state) & state;
+}
+
+static inline bool __task_state_match_eq(struct task_struct *tsk, long state)
+{
+	return READ_ONCE(tsk->__state) == state;
+}
+
+static inline bool task_state_match_eq(struct task_struct *tsk, long state)
+{
+	return __task_state_match_eq(tsk, state);
+}
+
+static inline bool task_state_match_and_set(struct task_struct *tsk, long state,
+					    long new_state)
+{
+	if (READ_ONCE(tsk->__state) & state) {
+		WRITE_ONCE(tsk->__state, new_state);
+		return true;
+	}
+	return false;
+}
+
+static inline bool task_state_match_eq_set(struct task_struct *tsk, long state,
+					   long new_state)
+{
+	if (READ_ONCE(tsk->__state) == state) {
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
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index eea265082e975..5ce0948c0c0a7 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -195,10 +195,10 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 		return ret;
 
 	spin_lock_irq(&task->sighand->siglock);
-	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
-	    !__fatal_signal_pending(task)) {
-		WRITE_ONCE(task->__state, __TASK_TRACED);
-		ret = true;
+	if (!looks_like_a_spurious_pid(task) && !__fatal_signal_pending(task)) {
+
+		ret = task_state_match_and_set(task, __TASK_TRACED,
+					       __TASK_TRACED);
 	}
 	spin_unlock_irq(&task->sighand->siglock);
 
@@ -207,7 +207,10 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	if (READ_ONCE(task->__state) != __TASK_TRACED)
+	bool frozen;
+
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
+	    READ_ONCE(task->__state) != __TASK_TRACED)
 		return;
 
 	WARN_ON(!task->ptrace || task->parent != current);
@@ -217,12 +220,12 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
 	 * Recheck state under the lock to close this race.
 	 */
 	spin_lock_irq(&task->sighand->siglock);
-	if (READ_ONCE(task->__state) == __TASK_TRACED) {
-		if (__fatal_signal_pending(task))
-			wake_up_state(task, __TASK_TRACED);
-		else
-			WRITE_ONCE(task->__state, TASK_TRACED);
-	}
+
+	frozen = task_state_match_eq_set(task, __TASK_TRACED, TASK_TRACED);
+
+	if (frozen && __fatal_signal_pending(task))
+		wake_up_state(task, __TASK_TRACED);
+
 	spin_unlock_irq(&task->sighand->siglock);
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9745613d531ce..a44414946de3d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3239,7 +3239,8 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 * is actually now running somewhere else!
 		 */
 		while (task_running(rq, p)) {
-			if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
+			if (match_state &&
+			    unlikely(!task_state_match_eq(p, match_state)))
 				return 0;
 			cpu_relax();
 		}
@@ -3254,7 +3255,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		running = task_running(rq, p);
 		queued = task_on_rq_queued(p);
 		ncsw = 0;
-		if (!match_state || READ_ONCE(p->__state) == match_state)
+		if (!match_state || __task_state_match_eq(p, match_state))
 			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
 		task_rq_unlock(rq, p, &rf);
 
-- 
2.35.1

