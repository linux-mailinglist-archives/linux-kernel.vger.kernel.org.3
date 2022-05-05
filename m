Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107D451C7C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384526AbiEESiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344831AbiEEShG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:37:06 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9565EBE7;
        Thu,  5 May 2022 11:27:42 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:53554)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmgCT-004ZGt-Aw; Thu, 05 May 2022 12:27:41 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37118 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmgCQ-002BtP-58; Thu, 05 May 2022 12:27:40 -0600
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
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Thu,  5 May 2022 13:26:42 -0500
Message-Id: <20220505182645.497868-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nmgCQ-002BtP-58;;;mid=<20220505182645.497868-9-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+RYgbnT7ltQiZdmoTN1j5HqtZdsxHb5UM=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 2377 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 1378 (58.0%), b_tie_ro: 10 (0.4%), parse: 2.2
        (0.1%), extract_message_metadata: 28 (1.2%), get_uri_detail_list: 7
        (0.3%), tests_pri_-1000: 24 (1.0%), tests_pri_-950: 1.38 (0.1%),
        tests_pri_-900: 1.23 (0.1%), tests_pri_-90: 146 (6.1%), check_bayes:
        144 (6.1%), b_tokenize: 15 (0.6%), b_tok_get_all: 12 (0.5%),
        b_comp_prob: 3.9 (0.2%), b_tok_touch_all: 108 (4.5%), b_finish: 1.07
        (0.0%), tests_pri_0: 775 (32.6%), check_dkim_signature: 1.35 (0.1%),
        check_dkim_adsp: 6 (0.3%), poll_dns_idle: 4.6 (0.2%), tests_pri_10:
        3.1 (0.1%), tests_pri_500: 9 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v4 09/12] ptrace: Admit ptrace_stop can generate spuriuos SIGTRAPs
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Long ago and far away there was a BUG_ON at the start of ptrace_stop
that did "BUG_ON(!(current->ptrace & PT_PTRACED));" [1].  The BUG_ON
had never triggered but examination of the code showed that the BUG_ON
could actually trigger.  To complement removing the BUG_ON an attempt
to better handle the race was added.

The code detected the tracer had gone away and did not call
do_notify_parent_cldstop.  The code also attempted to prevent
ptrace_report_syscall from sending spurious SIGTRAPs when the tracer
went away.

The code to detect when the tracer had gone away before sending a
signal to tracer was a legitimate fix and continues to work to this
date.

The code to prevent sending spurious SIGTRAPs is a failure.  At the
time and until today the code only catches it when the tracer goes
away after siglock is dropped and before read_lock is acquired.  If
the tracer goes away after read_lock is dropped a spurious SIGTRAP can
still be sent to the tracee.  The tracer going away after read_lock
is dropped is the far likelier case as it is the bigger window.

Given that the attempt to prevent the generation of a SIGTRAP was a
failure and continues to be a failure remove the code that attempts to
do that.  This simplifies the code in ptrace_stop and makes
ptrace_stop much easier to reason about.

To successfully deal with the tracer going away, all of the tracer's
instrumentation of the child would need to be removed, and reliably
detecting when the tracer has set a signal to continue with would need
to be implemented.

[1] 66519f549ae5 ("[PATCH] fix ptracer death race yielding bogus BUG_ON")
History-Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 92 ++++++++++++++++++++-----------------------------
 1 file changed, 38 insertions(+), 54 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 3fd2ce133387..d2d0c753156c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2187,13 +2187,12 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
  * with.  If the code did not stop because the tracer is gone,
  * the stop signal remains unchanged unless clear_code.
  */
-static int ptrace_stop(int exit_code, int why, int clear_code,
-			unsigned long message, kernel_siginfo_t *info)
+static int ptrace_stop(int exit_code, int why, unsigned long message,
+		       kernel_siginfo_t *info)
 	__releases(&current->sighand->siglock)
 	__acquires(&current->sighand->siglock)
 {
 	bool gstop_done = false;
-	bool read_code = true;
 
 	if (arch_ptrace_stop_needed()) {
 		/*
@@ -2212,7 +2211,14 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 	/*
 	 * schedule() will not sleep if there is a pending signal that
 	 * can awaken the task.
+	 *
+	 * After this point ptrace_signal_wake_up will clear TASK_TRACED
+	 * if ptrace_unlink happens.  Handle previous ptrace_unlinks
+	 * here to prevent ptrace_stop sleeping in schedule.
 	 */
+	if (!current->ptrace)
+		return exit_code;
+
 	set_special_state(TASK_TRACED);
 
 	/*
@@ -2259,54 +2265,33 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 
 	spin_unlock_irq(&current->sighand->siglock);
 	read_lock(&tasklist_lock);
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
+	if (current->ptrace)
 		do_notify_parent_cldstop(current, true, why);
-		if (gstop_done && ptrace_reparented(current))
-			do_notify_parent_cldstop(current, false, why);
+	if (gstop_done && (!current->ptrace || ptrace_reparented(current)))
+		do_notify_parent_cldstop(current, false, why);
 
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
+	/*
+	 * Don't want to allow preemption here, because
+	 * sys_ptrace() needs this task to be inactive.
+	 *
+	 * XXX: implement read_unlock_no_resched().
+	 */
+	preempt_disable();
+	read_unlock(&tasklist_lock);
+	cgroup_enter_frozen();
+	preempt_enable_no_resched();
+	freezable_schedule();
+	cgroup_leave_frozen(true);
 
 	/*
 	 * We are back.  Now reacquire the siglock before touching
@@ -2314,8 +2299,7 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 	 * any signal-sending on another CPU that wants to examine it.
 	 */
 	spin_lock_irq(&current->sighand->siglock);
-	if (read_code)
-		exit_code = current->exit_code;
+	exit_code = current->exit_code;
 	current->last_siginfo = NULL;
 	current->ptrace_message = 0;
 	current->exit_code = 0;
@@ -2343,7 +2327,7 @@ static int ptrace_do_notify(int signr, int exit_code, int why, unsigned long mes
 	info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
 
 	/* Let the debugger run.  */
-	return ptrace_stop(exit_code, why, 1, message, &info);
+	return ptrace_stop(exit_code, why, message, &info);
 }
 
 int ptrace_notify(int exit_code, unsigned long message)
@@ -2515,7 +2499,7 @@ static void do_jobctl_trap(void)
 				 CLD_STOPPED, 0);
 	} else {
 		WARN_ON_ONCE(!signr);
-		ptrace_stop(signr, CLD_STOPPED, 0, 0, NULL);
+		ptrace_stop(signr, CLD_STOPPED, 0, NULL);
 	}
 }
 
@@ -2568,7 +2552,7 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info, enum pid_type type)
 	 * comment in dequeue_signal().
 	 */
 	current->jobctl |= JOBCTL_STOP_DEQUEUED;
-	signr = ptrace_stop(signr, CLD_TRAPPED, 0, 0, info);
+	signr = ptrace_stop(signr, CLD_TRAPPED, 0, info);
 
 	/* We're back.  Did the debugger cancel the sig?  */
 	if (signr == 0)
-- 
2.35.3

