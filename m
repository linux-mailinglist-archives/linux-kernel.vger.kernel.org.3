Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC2C51B213
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379116AbiEDWpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379101AbiEDWpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:45:24 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C191532DC;
        Wed,  4 May 2022 15:41:45 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:54514)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmNgm-00EDUk-J6; Wed, 04 May 2022 16:41:44 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37004 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmNgk-00GI0k-38; Wed, 04 May 2022 16:41:44 -0600
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
Date:   Wed,  4 May 2022 17:40:55 -0500
Message-Id: <20220504224058.476193-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
References: <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nmNgk-00GI0k-38;;;mid=<20220504224058.476193-8-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18r3ZEzWh9z1nBb3IoAIttVr4/8JKFPylk=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1767 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.8 (0.3%), b_tie_ro: 3.3 (0.2%), parse: 1.49
        (0.1%), extract_message_metadata: 12 (0.7%), get_uri_detail_list: 4.0
        (0.2%), tests_pri_-1000: 11 (0.6%), tests_pri_-950: 0.99 (0.1%),
        tests_pri_-900: 0.86 (0.0%), tests_pri_-90: 219 (12.4%), check_bayes:
        218 (12.3%), b_tokenize: 11 (0.6%), b_tok_get_all: 12 (0.7%),
        b_comp_prob: 3.6 (0.2%), b_tok_touch_all: 187 (10.6%), b_finish: 0.82
        (0.0%), tests_pri_0: 1501 (84.9%), check_dkim_signature: 0.65 (0.0%),
        check_dkim_adsp: 1.85 (0.1%), poll_dns_idle: 0.49 (0.0%),
        tests_pri_10: 2.9 (0.2%), tests_pri_500: 9 (0.5%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH v3 08/11] ptrace: Admit ptrace_stop can generate spuriuos SIGTRAPs
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
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

With the removal of the incomplete detection of the tracer going away
in ptrace_stop, ptrace_stop always sleeps in schedule after
ptrace_freeze_traced succeeds.  Modify ptrace_check_attach to
warn if wait_task_inactive fails.

[1] 66519f549ae5 ("[PATCH] fix ptracer death race yielding bogus BUG_ON")
History-Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 14 ++-------
 kernel/signal.c | 81 ++++++++++++++++++-------------------------------
 2 files changed, 33 insertions(+), 62 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 7105821595bc..05953ac9f7bd 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -266,17 +266,9 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 	}
 	read_unlock(&tasklist_lock);
 
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
-	}
+	if (!ret && !ignore_state &&
+	    WARN_ON_ONCE(!wait_task_inactive(child, __TASK_TRACED)))
+		ret = -ESRCH;
 
 	return ret;
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index 3fd2ce133387..16828fde5424 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2187,8 +2187,8 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
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
@@ -2259,54 +2259,33 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 
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
@@ -2343,7 +2322,7 @@ static int ptrace_do_notify(int signr, int exit_code, int why, unsigned long mes
 	info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
 
 	/* Let the debugger run.  */
-	return ptrace_stop(exit_code, why, 1, message, &info);
+	return ptrace_stop(exit_code, why, message, &info);
 }
 
 int ptrace_notify(int exit_code, unsigned long message)
@@ -2515,7 +2494,7 @@ static void do_jobctl_trap(void)
 				 CLD_STOPPED, 0);
 	} else {
 		WARN_ON_ONCE(!signr);
-		ptrace_stop(signr, CLD_STOPPED, 0, 0, NULL);
+		ptrace_stop(signr, CLD_STOPPED, 0, NULL);
 	}
 }
 
@@ -2568,7 +2547,7 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info, enum pid_type type)
 	 * comment in dequeue_signal().
 	 */
 	current->jobctl |= JOBCTL_STOP_DEQUEUED;
-	signr = ptrace_stop(signr, CLD_TRAPPED, 0, 0, info);
+	signr = ptrace_stop(signr, CLD_TRAPPED, 0, info);
 
 	/* We're back.  Did the debugger cancel the sig?  */
 	if (signr == 0)
-- 
2.35.3

