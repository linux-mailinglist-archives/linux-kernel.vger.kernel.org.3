Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC37510C44
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347844AbiDZW40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355926AbiDZW4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:56:12 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668CF18D6AF;
        Tue, 26 Apr 2022 15:53:02 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:59964)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njU3J-007FuH-G6; Tue, 26 Apr 2022 16:53:01 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35772 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njU3H-006ASW-Pc; Tue, 26 Apr 2022 16:53:00 -0600
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
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 26 Apr 2022 17:52:08 -0500
Message-Id: <20220426225211.308418-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1njU3H-006ASW-Pc;;;mid=<20220426225211.308418-6-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1/1Z2Swk+DIr2XbNLy5Dsbn7VoKLPhHEf4=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *******;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 974 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 12 (1.2%), b_tie_ro: 10 (1.1%), parse: 1.91
        (0.2%), extract_message_metadata: 22 (2.3%), get_uri_detail_list: 6
        (0.6%), tests_pri_-1000: 15 (1.6%), tests_pri_-950: 1.42 (0.1%),
        tests_pri_-900: 1.18 (0.1%), tests_pri_-90: 243 (25.0%), check_bayes:
        241 (24.8%), b_tokenize: 21 (2.2%), b_tok_get_all: 13 (1.3%),
        b_comp_prob: 4.9 (0.5%), b_tok_touch_all: 197 (20.2%), b_finish: 1.30
        (0.1%), tests_pri_0: 651 (66.9%), check_dkim_signature: 0.84 (0.1%),
        check_dkim_adsp: 3.6 (0.4%), poll_dns_idle: 0.92 (0.1%), tests_pri_10:
        3.4 (0.3%), tests_pri_500: 18 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 6/9] signal: Always call do_notify_parent_cldstop with siglock held
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that siglock keeps tsk->parent and tsk->real_parent constant
require that do_notify_parent_cldstop is called with tsk->siglock held
instead of the tasklist_lock.

As all of the callers of do_notify_parent_cldstop had to drop the
siglock and take tasklist_lock this simplifies all of it's callers.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 156 +++++++++++++++++-------------------------------
 1 file changed, 55 insertions(+), 101 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 72d96614effc..584d67deb3cb 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2121,11 +2121,13 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
 				     bool for_ptracer, int why)
 {
 	struct kernel_siginfo info;
-	unsigned long flags;
 	struct task_struct *parent;
 	struct sighand_struct *sighand;
+	bool lock;
 	u64 utime, stime;
 
+	assert_spin_locked(&tsk->sighand->siglock);
+
 	if (for_ptracer) {
 		parent = tsk->parent;
 	} else {
@@ -2164,7 +2166,9 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
  	}
 
 	sighand = parent->sighand;
-	spin_lock_irqsave(&sighand->siglock, flags);
+	lock = tsk->sighand != sighand;
+	if (lock)
+		spin_lock_nested(&sighand->siglock, SINGLE_DEPTH_NESTING);
 	if (sighand->action[SIGCHLD-1].sa.sa_handler != SIG_IGN &&
 	    !(sighand->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
 		send_signal_locked(SIGCHLD, &info, parent, PIDTYPE_TGID);
@@ -2172,7 +2176,8 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
 	 * Even if SIGCHLD is not generated, we must wake up wait4 calls.
 	 */
 	__wake_up_parent(tsk, parent);
-	spin_unlock_irqrestore(&sighand->siglock, flags);
+	if (lock)
+		spin_unlock(&sighand->siglock);
 }
 
 /*
@@ -2193,7 +2198,6 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 	__acquires(&current->sighand->siglock)
 {
 	bool gstop_done = false;
-	bool read_code = true;
 
 	if (arch_ptrace_stop_needed()) {
 		/*
@@ -2209,6 +2213,34 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 		spin_lock_irq(&current->sighand->siglock);
 	}
 
+	/* Don't stop if current is not ptraced */
+	if (unlikely(!current->ptrace))
+		return (clear_code) ? 0 : exit_code;
+
+	/*
+	 * If @why is CLD_STOPPED, we're trapping to participate in a group
+	 * stop.  Do the bookkeeping.  Note that if SIGCONT was delievered
+	 * across siglock relocks since INTERRUPT was scheduled, PENDING
+	 * could be clear now.  We act as if SIGCONT is received after
+	 * TASK_TRACED is entered - ignore it.
+	 */
+	if (why == CLD_STOPPED && (current->jobctl & JOBCTL_STOP_PENDING))
+		gstop_done = task_participate_group_stop(current);
+
+	/*
+	 * Notify parents of the stop.
+	 *
+	 * While ptraced, there are two parents - the ptracer and
+	 * the real_parent of the group_leader.  The ptracer should
+	 * know about every stop while the real parent is only
+	 * interested in the completion of group stop.  The states
+	 * for the two don't interact with each other.  Notify
+	 * separately unless they're gonna be duplicates.
+	 */
+	do_notify_parent_cldstop(current, true, why);
+	if (gstop_done && ptrace_reparented(current))
+		do_notify_parent_cldstop(current, false, why);
+
 	/*
 	 * schedule() will not sleep if there is a pending signal that
 	 * can awaken the task.
@@ -2239,15 +2271,6 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 	current->last_siginfo = info;
 	current->exit_code = exit_code;
 
-	/*
-	 * If @why is CLD_STOPPED, we're trapping to participate in a group
-	 * stop.  Do the bookkeeping.  Note that if SIGCONT was delievered
-	 * across siglock relocks since INTERRUPT was scheduled, PENDING
-	 * could be clear now.  We act as if SIGCONT is received after
-	 * TASK_TRACED is entered - ignore it.
-	 */
-	if (why == CLD_STOPPED && (current->jobctl & JOBCTL_STOP_PENDING))
-		gstop_done = task_participate_group_stop(current);
 
 	/* any trap clears pending STOP trap, STOP trap clears NOTIFY */
 	task_clear_jobctl_pending(current, JOBCTL_TRAP_STOP);
@@ -2257,56 +2280,19 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 	/* entering a trap, clear TRAPPING */
 	task_clear_jobctl_trapping(current);
 
+	/*
+	 * Don't want to allow preemption here, because
+	 * sys_ptrace() needs this task to be inactive.
+	 *
+	 * XXX: implement spin_unlock_no_resched().
+	 */
+	preempt_disable();
 	spin_unlock_irq(&current->sighand->siglock);
-	read_lock(&tasklist_lock);
-	if (likely(current->ptrace)) {
-		/*
-		 * Notify parents of the stop.
-		 *
-		 * While ptraced, there are two parents - the ptracer and
-		 * the real_parent of the group_leader.  The ptracer should
-		 * know about every stop while the real parent is only
-		 * interested in the completion of group stop.  The states
-		 * for the two don't interact with each other.  Notify
-		 * separately unless they're gonna be duplicates.
-		 */
-		do_notify_parent_cldstop(current, true, why);
-		if (gstop_done && ptrace_reparented(current))
-			do_notify_parent_cldstop(current, false, why);
 
-		/*
-		 * Don't want to allow preemption here, because
-		 * sys_ptrace() needs this task to be inactive.
-		 *
-		 * XXX: implement read_unlock_no_resched().
-		 */
-		preempt_disable();
-		read_unlock(&tasklist_lock);
-		cgroup_enter_frozen();
-		preempt_enable_no_resched();
-		freezable_schedule();
-		cgroup_leave_frozen(true);
-	} else {
-		/*
-		 * By the time we got the lock, our tracer went away.
-		 * Don't drop the lock yet, another tracer may come.
-		 *
-		 * If @gstop_done, the ptracer went away between group stop
-		 * completion and here.  During detach, it would have set
-		 * JOBCTL_STOP_PENDING on us and we'll re-enter
-		 * TASK_STOPPED in do_signal_stop() on return, so notifying
-		 * the real parent of the group stop completion is enough.
-		 */
-		if (gstop_done)
-			do_notify_parent_cldstop(current, false, why);
-
-		/* tasklist protects us from ptrace_freeze_traced() */
-		__set_current_state(TASK_RUNNING);
-		read_code = false;
-		if (clear_code)
-			exit_code = 0;
-		read_unlock(&tasklist_lock);
-	}
+	cgroup_enter_frozen();
+	preempt_enable_no_resched();
+	freezable_schedule();
+	cgroup_leave_frozen(true);
 
 	/*
 	 * We are back.  Now reacquire the siglock before touching
@@ -2314,8 +2300,7 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 	 * any signal-sending on another CPU that wants to examine it.
 	 */
 	spin_lock_irq(&current->sighand->siglock);
-	if (read_code)
-		exit_code = current->exit_code;
+	exit_code = current->exit_code;
 	current->last_siginfo = NULL;
 	current->ptrace_message = 0;
 	current->exit_code = 0;
@@ -2444,34 +2429,17 @@ static bool do_signal_stop(int signr)
 	}
 
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
@@ -2665,8 +2633,6 @@ bool get_signal(struct ksignal *ksig)
 
 		signal->flags &= ~SIGNAL_CLD_MASK;
 
-		spin_unlock_irq(&sighand->siglock);
-
 		/*
 		 * Notify the parent that we're continuing.  This event is
 		 * always per-process and doesn't make whole lot of sense
@@ -2675,15 +2641,10 @@ bool get_signal(struct ksignal *ksig)
 		 * the ptracer of the group leader too unless it's gonna be
 		 * a duplicate.
 		 */
-		read_lock(&tasklist_lock);
 		do_notify_parent_cldstop(current, false, why);
-
 		if (ptrace_reparented(current->group_leader))
 			do_notify_parent_cldstop(current->group_leader,
 						true, why);
-		read_unlock(&tasklist_lock);
-
-		goto relock;
 	}
 
 	for (;;) {
@@ -2940,7 +2901,6 @@ static void retarget_shared_pending(struct task_struct *tsk, sigset_t *which)
 
 void exit_signals(struct task_struct *tsk)
 {
-	int group_stop = 0;
 	sigset_t unblocked;
 
 	/*
@@ -2971,21 +2931,15 @@ void exit_signals(struct task_struct *tsk)
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
-	}
+	if (unlikely(tsk->jobctl & JOBCTL_STOP_PENDING) &&
+	    task_participate_group_stop(tsk))
+		do_notify_parent_cldstop(tsk, false, CLD_STOPPED);
+out:
+	spin_unlock_irq(&tsk->sighand->siglock);
 }
 
 /*
-- 
2.35.3

