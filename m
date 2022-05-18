Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA77852C6E9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiERW4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiERW4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:56:03 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769A12311D0;
        Wed, 18 May 2022 15:55:27 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:55710)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZi-003bi7-66; Wed, 18 May 2022 16:55:26 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38724 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZg-002Z0O-BI; Wed, 18 May 2022 16:55:25 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, Oleg Nesterov <oleg@redhat.com>,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        tj@kernel.org, linux-pm@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org,
        Robert OCallahan <roc@pernos.co>, Kyle Huey <khuey@pernos.co>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed, 18 May 2022 17:53:55 -0500
Message-Id: <20220518225355.784371-16-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nrSZg-002Z0O-BI;;;mid=<20220518225355.784371-16-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19tGoXERnofsWkaefTR9KA1SSKryl+GXsQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *******;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1131 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 9 (0.8%), b_tie_ro: 8 (0.7%), parse: 2.3 (0.2%),
        extract_message_metadata: 19 (1.7%), get_uri_detail_list: 8 (0.7%),
        tests_pri_-1000: 15 (1.4%), tests_pri_-950: 1.29 (0.1%),
        tests_pri_-900: 1.06 (0.1%), tests_pri_-90: 205 (18.1%), check_bayes:
        204 (18.0%), b_tokenize: 25 (2.2%), b_tok_get_all: 15 (1.3%),
        b_comp_prob: 4.4 (0.4%), b_tok_touch_all: 155 (13.7%), b_finish: 0.95
        (0.1%), tests_pri_0: 861 (76.1%), check_dkim_signature: 0.79 (0.1%),
        check_dkim_adsp: 2.6 (0.2%), poll_dns_idle: 0.85 (0.1%), tests_pri_10:
        2.9 (0.3%), tests_pri_500: 10 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 16/16] signal: Always call do_notify_parent_cldstop with siglock held
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that siglock keeps tsk->parent and tsk->real_parent constant
require that do_notify_parent_cldstop is called with tsk->siglock held
instead of the tasklist_lock.

As all of the callers of do_notify_parent_cldstop had to drop the
siglock and take tasklist_lock this simplifies all of it's callers.

This removes one reason for taking tasklist_lock.

This makes ptrace_stop so that it should reliably work correctly and
reliably with PREEMPT_RT enabled and CONFIG_CGROUPS disabled.  The
remaining challenge is that cgroup_enter_frozen takes spin_lock after
__state has been set to TASK_TRACED.  Which on PREEMPT_RT means the
code can sleep and change __state.  Not only that but it means that
wait_task_inactive could potentially detect the code scheduling away
at that point and fail, causing ptrace_check_attach to fail.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 262 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 189 insertions(+), 73 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 2cc45e8448e2..d4956be51939 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1994,6 +1994,129 @@ int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
 	return ret;
 }
 
+/**
+ * lock_parents_siglocks - Take current, real_parent, and parent's siglock
+ * @lock_tracer: The tracers siglock is needed.
+ *
+ * There is no natural ordering to these locks so they must be sorted
+ * before being taken.
+ *
+ * There are two complicating factors here:
+ * - The locks live in sighand and sighand can be arbitrarily shared
+ * - parent and real_parent can change when current's siglock is unlocked.
+ *
+ * To deal with this first the all of the sighand pointers are
+ * gathered under current's siglock, and the sighand pointers are
+ * sorted.  As siglock lives inside of sighand this also sorts the
+ * siglock's by address.
+ *
+ * Then the siglocks are taken in order dropping current's siglock if
+ * necessary.
+ *
+ * Finally if parent and real_parent have not changed return.
+ * If they either parent has changed drop their locks and try again.
+ *
+ * Changing sighand is an infrequent and somewhat expensive operation
+ * (unshare or exec) and so even in the worst case this loop
+ * should not loop too many times before all of the proper locks are
+ * taken in order.
+ *
+ * CONTEXT:
+ * Must be called with @current->sighand->siglock held
+ *
+ * RETURNS:
+ * current's, real_parent's, and parent's siglock held.
+ */
+static void lock_parents_siglocks(bool lock_tracer)
+	__releases(&current->sighand->siglock)
+	__acquires(&current->sighand->siglock)
+	__acquires(&current->real_parent->sighand->siglock)
+	__acquires(&current->parent->sighand->siglock)
+{
+	struct task_struct *me = current;
+	struct sighand_struct *m_sighand = me->sighand;
+
+	lockdep_assert_held(&m_sighand->siglock);
+
+	rcu_read_lock();
+	for (;;) {
+		struct task_struct *parent, *tracer;
+		struct sighand_struct *p_sighand, *t_sighand, *s1, *s2, *s3;
+
+		parent = me->real_parent;
+		tracer = ptrace_parent(me);
+		if (!tracer || !lock_tracer)
+			tracer = parent;
+
+		p_sighand = rcu_dereference(parent->sighand);
+		t_sighand = rcu_dereference(tracer->sighand);
+
+		/* Sort the sighands so that s1 >= s2 >= s3 */
+		s1 = m_sighand;
+		s2 = p_sighand;
+		s3 = t_sighand;
+		if (s1 > s2)
+			swap(s1, s2);
+		if (s1 > s3)
+			swap(s1, s3);
+		if (s2 > s3)
+			swap(s2, s3);
+
+		/* Take the locks in order */
+		if (s1 != m_sighand) {
+			spin_unlock(&m_sighand->siglock);
+			spin_lock(&s1->siglock);
+		}
+		if (s1 != s2)
+			spin_lock_nested(&s2->siglock, 1);
+		if (s2 != s3)
+			spin_lock_nested(&s3->siglock, 2);
+
+		/* Verify the proper locks are held */
+		if (likely((s1 == m_sighand) ||
+			   ((me->real_parent == parent) &&
+			    (me->parent == tracer) &&
+			    (parent->sighand == p_sighand) &&
+			    (tracer->sighand == t_sighand)))) {
+			break;
+		}
+
+		/* Drop all but current's siglock */
+		if (p_sighand != m_sighand)
+			spin_unlock(&p_sighand->siglock);
+		if (t_sighand != p_sighand)
+			spin_unlock(&t_sighand->siglock);
+
+		/*
+		 * Since [pt]_sighand will likely change if we go
+		 * around, and m_sighand is the only one held, make sure
+		 * it is subclass-0, since the above 's1 != m_sighand'
+		 * clause very much relies on that.
+		 */
+		lock_set_subclass(&m_sighand->siglock.dep_map, 0, _RET_IP_);
+	}
+	rcu_read_unlock();
+}
+
+static void unlock_parents_siglocks(bool unlock_tracer)
+	__releases(&current->real_parent->sighand->siglock)
+	__releases(&current->parent->sighand->siglock)
+{
+	struct task_struct *me = current;
+	struct task_struct *parent = me->real_parent;
+	struct task_struct *tracer = ptrace_parent(me);
+	struct sighand_struct *m_sighand = me->sighand;
+	struct sighand_struct *p_sighand = parent->sighand;
+
+	if (p_sighand != m_sighand)
+		spin_unlock(&p_sighand->siglock);
+	if (tracer && unlock_tracer) {
+		struct sighand_struct *t_sighand = tracer->sighand;
+		if (t_sighand != p_sighand)
+			spin_unlock(&t_sighand->siglock);
+	}
+}
+
 static void do_notify_pidfd(struct task_struct *task)
 {
 	struct pid *pid;
@@ -2125,11 +2248,12 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
 				     bool for_ptracer, int why)
 {
 	struct kernel_siginfo info;
-	unsigned long flags;
 	struct task_struct *parent;
 	struct sighand_struct *sighand;
 	u64 utime, stime;
 
+	lockdep_assert_held(&tsk->sighand->siglock);
+
 	if (for_ptracer) {
 		parent = tsk->parent;
 	} else {
@@ -2137,6 +2261,8 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
 		parent = tsk->real_parent;
 	}
 
+	lockdep_assert_held(&parent->sighand->siglock);
+
 	clear_siginfo(&info);
 	info.si_signo = SIGCHLD;
 	info.si_errno = 0;
@@ -2168,7 +2294,6 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
  	}
 
 	sighand = parent->sighand;
-	spin_lock_irqsave(&sighand->siglock, flags);
 	if (sighand->action[SIGCHLD-1].sa.sa_handler != SIG_IGN &&
 	    !(sighand->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
 		send_signal_locked(SIGCHLD, &info, parent, PIDTYPE_TGID);
@@ -2176,7 +2301,6 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
 	 * Even if SIGCHLD is not generated, we must wake up wait4 calls.
 	 */
 	__wake_up_parent(tsk, parent);
-	spin_unlock_irqrestore(&sighand->siglock, flags);
 }
 
 /*
@@ -2208,14 +2332,18 @@ static void ptrace_stop(int exit_code, int why, unsigned long message,
 		spin_lock_irq(&current->sighand->siglock);
 	}
 
+	lock_parents_siglocks(true);
 	/*
 	 * After this point ptrace_signal_wake_up or signal_wake_up
 	 * will clear TASK_TRACED if ptrace_unlink happens or a fatal
 	 * signal comes in.  Handle previous ptrace_unlinks and fatal
 	 * signals here to prevent ptrace_stop sleeping in schedule.
 	 */
-	if (!current->ptrace || __fatal_signal_pending(current))
+
+	if (!current->ptrace || __fatal_signal_pending(current)) {
+		unlock_parents_siglocks(true);
 		return;
+	}
 
 	set_special_state(TASK_TRACED);
 	current->jobctl |= JOBCTL_TRACED;
@@ -2254,16 +2382,6 @@ static void ptrace_stop(int exit_code, int why, unsigned long message,
 	if (why == CLD_STOPPED && (current->jobctl & JOBCTL_STOP_PENDING))
 		gstop_done = task_participate_group_stop(current);
 
-	/* any trap clears pending STOP trap, STOP trap clears NOTIFY */
-	task_clear_jobctl_pending(current, JOBCTL_TRAP_STOP);
-	if (info && info->si_code >> 8 == PTRACE_EVENT_STOP)
-		task_clear_jobctl_pending(current, JOBCTL_TRAP_NOTIFY);
-
-	/* entering a trap, clear TRAPPING */
-	task_clear_jobctl_trapping(current);
-
-	spin_unlock_irq(&current->sighand->siglock);
-	read_lock(&tasklist_lock);
 	/*
 	 * Notify parents of the stop.
 	 *
@@ -2279,14 +2397,25 @@ static void ptrace_stop(int exit_code, int why, unsigned long message,
 	if (gstop_done && (!current->ptrace || ptrace_reparented(current)))
 		do_notify_parent_cldstop(current, false, why);
 
+	unlock_parents_siglocks(true);
+
+	/* any trap clears pending STOP trap, STOP trap clears NOTIFY */
+	task_clear_jobctl_pending(current, JOBCTL_TRAP_STOP);
+	if (info && info->si_code >> 8 == PTRACE_EVENT_STOP)
+		task_clear_jobctl_pending(current, JOBCTL_TRAP_NOTIFY);
+
+	/* entering a trap, clear TRAPPING */
+	task_clear_jobctl_trapping(current);
+
 	/*
 	 * Don't want to allow preemption here, because
 	 * sys_ptrace() needs this task to be inactive.
 	 *
-	 * XXX: implement read_unlock_no_resched().
+	 * XXX: implement spin_unlock_no_resched().
 	 */
 	preempt_disable();
-	read_unlock(&tasklist_lock);
+	spin_unlock_irq(&current->sighand->siglock);
+
 	cgroup_enter_frozen();
 	preempt_enable_no_resched();
 	freezable_schedule();
@@ -2361,8 +2490,8 @@ int ptrace_notify(int exit_code, unsigned long message)
  * on %true return.
  *
  * RETURNS:
- * %false if group stop is already cancelled or ptrace trap is scheduled.
- * %true if participated in group stop.
+ * %false if group stop is already cancelled.
+ * %true otherwise (as lock_parents_siglocks may have dropped siglock).
  */
 static bool do_signal_stop(int signr)
 	__releases(&current->sighand->siglock)
@@ -2425,36 +2554,24 @@ static bool do_signal_stop(int signr)
 		}
 	}
 
+	lock_parents_siglocks(false);
+	/* Recheck JOBCTL_STOP_PENDING after unlock+lock of siglock */
+	if (unlikely(!(current->jobctl & JOBCTL_STOP_PENDING)))
+		goto out;
 	if (likely(!current->ptrace)) {
-		int notify = 0;
-
 		/*
 		 * If there are no other threads in the group, or if there
 		 * is a group stop in progress and we are the last to stop,
-		 * report to the parent.
+		 * report to the real_parent.
 		 */
 		if (task_participate_group_stop(current))
-			notify = CLD_STOPPED;
+			do_notify_parent_cldstop(current, false, CLD_STOPPED);
+		unlock_parents_siglocks(false);
 
 		current->jobctl |= JOBCTL_STOPPED;
 		set_special_state(TASK_STOPPED);
 		spin_unlock_irq(&current->sighand->siglock);
 
-		/*
-		 * Notify the parent of the group stop completion.  Because
-		 * we're not holding either the siglock or tasklist_lock
-		 * here, ptracer may attach inbetween; however, this is for
-		 * group stop and should always be delivered to the real
-		 * parent of the group leader.  The new ptracer will get
-		 * its notification when this task transitions into
-		 * TASK_TRACED.
-		 */
-		if (notify) {
-			read_lock(&tasklist_lock);
-			do_notify_parent_cldstop(current, false, notify);
-			read_unlock(&tasklist_lock);
-		}
-
 		/* Now we don't run again until woken by SIGCONT or SIGKILL */
 		cgroup_enter_frozen();
 		freezable_schedule();
@@ -2465,8 +2582,11 @@ static bool do_signal_stop(int signr)
 		 * Schedule it and let the caller deal with it.
 		 */
 		task_set_jobctl_pending(current, JOBCTL_TRAP_STOP);
-		return false;
 	}
+out:
+	unlock_parents_siglocks(false);
+	spin_unlock_irq(&current->sighand->siglock);
+	return true;
 }
 
 /**
@@ -2624,32 +2744,30 @@ bool get_signal(struct ksignal *ksig)
 	if (unlikely(signal->flags & SIGNAL_CLD_MASK)) {
 		int why;
 
-		if (signal->flags & SIGNAL_CLD_CONTINUED)
-			why = CLD_CONTINUED;
-		else
-			why = CLD_STOPPED;
+		lock_parents_siglocks(true);
+		/* Recheck signal->flags after unlock+lock of siglock */
+		if (likely(signal->flags & SIGNAL_CLD_MASK)) {
+			if (signal->flags & SIGNAL_CLD_CONTINUED)
+				why = CLD_CONTINUED;
+			else
+				why = CLD_STOPPED;
 
-		signal->flags &= ~SIGNAL_CLD_MASK;
+			signal->flags &= ~SIGNAL_CLD_MASK;
 
-		spin_unlock_irq(&sighand->siglock);
-
-		/*
-		 * Notify the parent that we're continuing.  This event is
-		 * always per-process and doesn't make whole lot of sense
-		 * for ptracers, who shouldn't consume the state via
-		 * wait(2) either, but, for backward compatibility, notify
-		 * the ptracer of the group leader too unless it's gonna be
-		 * a duplicate.
-		 */
-		read_lock(&tasklist_lock);
-		do_notify_parent_cldstop(current, false, why);
-
-		if (ptrace_reparented(current->group_leader))
-			do_notify_parent_cldstop(current->group_leader,
-						true, why);
-		read_unlock(&tasklist_lock);
-
-		goto relock;
+			/*
+			 * Notify the parent that we're continuing.  This event is
+			 * always per-process and doesn't make whole lot of sense
+			 * for ptracers, who shouldn't consume the state via
+			 * wait(2) either, but, for backward compatibility, notify
+			 * the ptracer of the group leader too unless it's gonna be
+			 * a duplicate.
+			 */
+			do_notify_parent_cldstop(current, false, why);
+			if (ptrace_reparented(current->group_leader))
+				do_notify_parent_cldstop(current->group_leader,
+							 true, why);
+		}
+		unlock_parents_siglocks(true);
 	}
 
 	for (;;) {
@@ -2906,7 +3024,6 @@ static void retarget_shared_pending(struct task_struct *tsk, sigset_t *which)
 
 void exit_signals(struct task_struct *tsk)
 {
-	int group_stop = 0;
 	sigset_t unblocked;
 
 	/*
@@ -2937,21 +3054,20 @@ void exit_signals(struct task_struct *tsk)
 	signotset(&unblocked);
 	retarget_shared_pending(tsk, &unblocked);
 
-	if (unlikely(tsk->jobctl & JOBCTL_STOP_PENDING) &&
-	    task_participate_group_stop(tsk))
-		group_stop = CLD_STOPPED;
-out:
-	spin_unlock_irq(&tsk->sighand->siglock);
-
 	/*
 	 * If group stop has completed, deliver the notification.  This
 	 * should always go to the real parent of the group leader.
 	 */
-	if (unlikely(group_stop)) {
-		read_lock(&tasklist_lock);
-		do_notify_parent_cldstop(tsk, false, group_stop);
-		read_unlock(&tasklist_lock);
+	if (unlikely(tsk->jobctl & JOBCTL_STOP_PENDING)) {
+		lock_parents_siglocks(false);
+		/* Recheck JOBCTL_STOP_PENDING after unlock+lock of siglock */
+		if ((tsk->jobctl & JOBCTL_STOP_PENDING) &&
+		    task_participate_group_stop(tsk))
+			do_notify_parent_cldstop(tsk, false, CLD_STOPPED);
+		unlock_parents_siglocks(false);
 	}
+out:
+	spin_unlock_irq(&tsk->sighand->siglock);
 }
 
 /*
-- 
2.35.3

