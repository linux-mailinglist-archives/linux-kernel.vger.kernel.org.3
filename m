Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E38951C816
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384586AbiEESjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384398AbiEEShG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:37:06 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EE35EBF9;
        Thu,  5 May 2022 11:27:51 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:53836)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmgCc-007C2r-RS; Thu, 05 May 2022 12:27:50 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37118 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmgCb-002BtP-DG; Thu, 05 May 2022 12:27:50 -0600
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
        "Eric W . Biederman" <ebiederm@xmission.com>
Date:   Thu,  5 May 2022 13:26:45 -0500
Message-Id: <20220505182645.497868-12-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nmgCb-002BtP-DG;;;mid=<20220505182645.497868-12-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19yXDGzbN+79Chr1ZRx7vBHfiqPGCKeUto=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=40 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 663 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.7 (0.7%), b_tie_ro: 3.2 (0.5%), parse: 1.55
        (0.2%), extract_message_metadata: 16 (2.4%), get_uri_detail_list: 4.4
        (0.7%), tests_pri_-1000: 19 (2.8%), tests_pri_-950: 1.01 (0.2%),
        tests_pri_-900: 0.86 (0.1%), tests_pri_-90: 80 (12.1%), check_bayes:
        79 (11.9%), b_tokenize: 13 (1.9%), b_tok_get_all: 12 (1.9%),
        b_comp_prob: 3.4 (0.5%), b_tok_touch_all: 47 (7.1%), b_finish: 0.70
        (0.1%), tests_pri_0: 526 (79.4%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 2.9 (0.4%), poll_dns_idle: 0.25 (0.0%), tests_pri_10:
        2.4 (0.4%), tests_pri_500: 8 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v4 12/12] sched,signal,ptrace: Rework TASK_TRACED, TASK_STOPPED state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

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

--EWB
  * didn't add a unnecessary newline in signal.h
  * Update t->jobctl in signal_wake_up and ptrace_signal_wake_up
    instead of in signal_wake_up_state.  This prevents the clearing
    of TASK_STOPPED and TASK_TRACED from getting lost.
  * Added warnings if JOBCTL_STOPPED or JOBCTL_TRACED are not cleared

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220421150654.757693825@infradead.org
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/sched.h        |  8 +++-----
 include/linux/sched/jobctl.h |  6 ++++++
 include/linux/sched/signal.h | 19 +++++++++++++++----
 kernel/ptrace.c              | 16 +++++++++++++---
 kernel/signal.c              | 10 ++++++++--
 5 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 610f2fdb1e2c..cbe5c899599c 100644
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
diff --git a/include/linux/sched/jobctl.h b/include/linux/sched/jobctl.h
index d556c3425963..68876d0a7ef9 100644
--- a/include/linux/sched/jobctl.h
+++ b/include/linux/sched/jobctl.h
@@ -21,6 +21,9 @@ struct task_struct;
 #define JOBCTL_TRAP_FREEZE_BIT	23	/* trap for cgroup freezer */
 #define JOBCTL_PTRACE_FROZEN_BIT	24	/* frozen for ptrace */
 
+#define JOBCTL_STOPPED_BIT	26	/* do_signal_stop() */
+#define JOBCTL_TRACED_BIT	27	/* ptrace_stop() */
+
 #define JOBCTL_STOP_DEQUEUED	(1UL << JOBCTL_STOP_DEQUEUED_BIT)
 #define JOBCTL_STOP_PENDING	(1UL << JOBCTL_STOP_PENDING_BIT)
 #define JOBCTL_STOP_CONSUME	(1UL << JOBCTL_STOP_CONSUME_BIT)
@@ -31,6 +34,9 @@ struct task_struct;
 #define JOBCTL_TRAP_FREEZE	(1UL << JOBCTL_TRAP_FREEZE_BIT)
 #define JOBCTL_PTRACE_FROZEN	(1UL << JOBCTL_PTRACE_FROZEN_BIT)
 
+#define JOBCTL_STOPPED		(1UL << JOBCTL_STOPPED_BIT)
+#define JOBCTL_TRACED		(1UL << JOBCTL_TRACED_BIT)
+
 #define JOBCTL_TRAP_MASK	(JOBCTL_TRAP_STOP | JOBCTL_TRAP_NOTIFY)
 #define JOBCTL_PENDING_MASK	(JOBCTL_STOP_PENDING | JOBCTL_TRAP_MASK)
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index e66948abbee4..07ba3404fcde 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -294,8 +294,10 @@ static inline int kernel_dequeue_signal(void)
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
@@ -437,12 +439,21 @@ extern void signal_wake_up_state(struct task_struct *t, unsigned int state);
 
 static inline void signal_wake_up(struct task_struct *t, bool fatal)
 {
-	fatal = fatal && !(t->jobctl & JOBCTL_PTRACE_FROZEN);
-	signal_wake_up_state(t, fatal ? TASK_WAKEKILL | __TASK_TRACED : 0);
+	unsigned int state = 0;
+	if (fatal && !(t->jobctl & JOBCTL_PTRACE_FROZEN)) {
+		t->jobctl &= ~(JOBCTL_STOPPED | JOBCTL_TRACED);
+		state = TASK_WAKEKILL | __TASK_TRACED;
+	}
+	signal_wake_up_state(t, state);
 }
 static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
 {
-	signal_wake_up_state(t, resume ? __TASK_TRACED : 0);
+	unsigned int state = 0;
+	if (resume) {
+		t->jobctl &= ~JOBCTL_TRACED;
+		state = __TASK_TRACED;
+	}
+	signal_wake_up_state(t, state);
 }
 
 void task_join_group_stop(struct task_struct *task);
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 36a5b7a00d2f..328a34a99124 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -185,7 +185,12 @@ static bool looks_like_a_spurious_pid(struct task_struct *task)
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
@@ -216,8 +221,10 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
 	 */
 	if (lock_task_sighand(task, &flags)) {
 		task->jobctl &= ~JOBCTL_PTRACE_FROZEN;
-		if (__fatal_signal_pending(task))
+		if (__fatal_signal_pending(task)) {
+			task->jobctl &= ~TASK_TRACED;
 			wake_up_state(task, __TASK_TRACED);
+		}
 		unlock_task_sighand(task, &flags);
 	}
 }
@@ -462,8 +469,10 @@ static int ptrace_attach(struct task_struct *task, long request,
 	 * in and out of STOPPED are protected by siglock.
 	 */
 	if (task_is_stopped(task) &&
-	    task_set_jobctl_pending(task, JOBCTL_TRAP_STOP | JOBCTL_TRAPPING))
+	    task_set_jobctl_pending(task, JOBCTL_TRAP_STOP | JOBCTL_TRAPPING)) {
+		task->jobctl &= ~JOBCTL_STOPPED;
 		signal_wake_up_state(task, __TASK_STOPPED);
+	}
 
 	spin_unlock(&task->sighand->siglock);
 
@@ -875,6 +884,7 @@ static int ptrace_resume(struct task_struct *child, long request,
 	 */
 	spin_lock_irq(&child->sighand->siglock);
 	child->exit_code = data;
+	child->jobctl &= ~JOBCTL_TRACED;
 	wake_up_state(child, __TASK_TRACED);
 	spin_unlock_irq(&child->sighand->siglock);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index a58b68a2d3c6..e782c2611b64 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -762,7 +762,10 @@ static int dequeue_synchronous_signal(kernel_siginfo_t *info)
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
@@ -930,9 +933,10 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
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
 
@@ -2218,6 +2222,7 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 		return exit_code;
 
 	set_special_state(TASK_TRACED);
+	current->jobctl |= JOBCTL_TRACED;
 
 	/*
 	 * We're committing to trapping.  TRACED should be visible before
@@ -2436,6 +2441,7 @@ static bool do_signal_stop(int signr)
 		if (task_participate_group_stop(current))
 			notify = CLD_STOPPED;
 
+		current->jobctl |= JOBCTL_STOPPED;
 		set_special_state(TASK_STOPPED);
 		spin_unlock_irq(&current->sighand->siglock);
 
-- 
2.35.3

