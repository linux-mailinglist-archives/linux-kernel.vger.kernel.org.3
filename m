Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F82B51C7E7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244097AbiEESiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383258AbiEEShG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:37:06 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FF654BF6;
        Thu,  5 May 2022 11:27:45 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:59748)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmgCW-00GUwm-HZ; Thu, 05 May 2022 12:27:44 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37118 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmgCV-002BtP-9e; Thu, 05 May 2022 12:27:44 -0600
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
Date:   Thu,  5 May 2022 13:26:43 -0500
Message-Id: <20220505182645.497868-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
References: <87a6bv6dl6.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nmgCV-002BtP-9e;;;mid=<20220505182645.497868-10-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18zgtbYXeo0wufUpFXuk3BN2RWYjqaP86w=
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
X-Spam-Timing: total 623 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.5 (0.7%), b_tie_ro: 3.1 (0.5%), parse: 1.42
        (0.2%), extract_message_metadata: 12 (2.0%), get_uri_detail_list: 3.9
        (0.6%), tests_pri_-1000: 11 (1.7%), tests_pri_-950: 0.97 (0.2%),
        tests_pri_-900: 0.85 (0.1%), tests_pri_-90: 68 (11.0%), check_bayes:
        67 (10.7%), b_tokenize: 12 (2.0%), b_tok_get_all: 11 (1.8%),
        b_comp_prob: 3.2 (0.5%), b_tok_touch_all: 37 (5.9%), b_finish: 0.74
        (0.1%), tests_pri_0: 510 (81.8%), check_dkim_signature: 0.70 (0.1%),
        check_dkim_adsp: 2.6 (0.4%), poll_dns_idle: 1.25 (0.2%), tests_pri_10:
        2.7 (0.4%), tests_pri_500: 8 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v4 10/12] ptrace: Don't change __state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop playing with tsk->__state to remove TASK_WAKEKILL while a ptrace
command is executing.

Instead remove TASK_WAKEKILL from the definition of TASK_TRACED, and
implement a new jobctl flag TASK_PTRACE_FROZEN.  This new flag is set
in jobctl_freeze_task and cleared when ptrace_stop is awoken or in
jobctl_unfreeze_task (when ptrace_stop remains asleep).

In signal_wake_up add __TASK_TRACED to state along with TASK_WAKEKILL
when the wake up is for a fatal signal.  Skip adding __TASK_TRACED
when TASK_PTRACE_FROZEN is not set.  This has the same effect as
changing TASK_TRACED to __TASK_TRACED as all of the wake_ups that use
TASK_KILLABLE go through signal_wake_up.

Handle a ptrace_stop being called with a pending fatal signal.
Previously it would have been handled by schedule simply failing to
sleep.  As TASK_WAKEKILL is no longer part of TASK_TRACED schedule
will sleep with a fatal_signal_pending.   The code in signal_wake_up
guarantees that the code will be awaked by any fatal signal that
codes after TASK_TRACED is set.

Previously the __state value of __TASK_TRACED was changed to
TASK_RUNNING when woken up or back to TASK_TRACED when the code was
left in ptrace_stop.  Now when woken up ptrace_stop now clears
JOBCTL_PTRACE_FROZEN and when left sleeping ptrace_unfreezed_traced
clears JOBCTL_PTRACE_FROZEN.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched.h        |  2 +-
 include/linux/sched/jobctl.h |  2 ++
 include/linux/sched/signal.h |  5 +++--
 kernel/ptrace.c              | 21 ++++++++-------------
 kernel/sched/core.c          |  5 +----
 kernel/signal.c              | 14 ++++++--------
 6 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d5e3c00b74e1..610f2fdb1e2c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -103,7 +103,7 @@ struct task_group;
 /* Convenience macros for the sake of set_current_state: */
 #define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
 #define TASK_STOPPED			(TASK_WAKEKILL | __TASK_STOPPED)
-#define TASK_TRACED			(TASK_WAKEKILL | __TASK_TRACED)
+#define TASK_TRACED			__TASK_TRACED
 
 #define TASK_IDLE			(TASK_UNINTERRUPTIBLE | TASK_NOLOAD)
 
diff --git a/include/linux/sched/jobctl.h b/include/linux/sched/jobctl.h
index fa067de9f1a9..d556c3425963 100644
--- a/include/linux/sched/jobctl.h
+++ b/include/linux/sched/jobctl.h
@@ -19,6 +19,7 @@ struct task_struct;
 #define JOBCTL_TRAPPING_BIT	21	/* switching to TRACED */
 #define JOBCTL_LISTENING_BIT	22	/* ptracer is listening for events */
 #define JOBCTL_TRAP_FREEZE_BIT	23	/* trap for cgroup freezer */
+#define JOBCTL_PTRACE_FROZEN_BIT	24	/* frozen for ptrace */
 
 #define JOBCTL_STOP_DEQUEUED	(1UL << JOBCTL_STOP_DEQUEUED_BIT)
 #define JOBCTL_STOP_PENDING	(1UL << JOBCTL_STOP_PENDING_BIT)
@@ -28,6 +29,7 @@ struct task_struct;
 #define JOBCTL_TRAPPING		(1UL << JOBCTL_TRAPPING_BIT)
 #define JOBCTL_LISTENING	(1UL << JOBCTL_LISTENING_BIT)
 #define JOBCTL_TRAP_FREEZE	(1UL << JOBCTL_TRAP_FREEZE_BIT)
+#define JOBCTL_PTRACE_FROZEN	(1UL << JOBCTL_PTRACE_FROZEN_BIT)
 
 #define JOBCTL_TRAP_MASK	(JOBCTL_TRAP_STOP | JOBCTL_TRAP_NOTIFY)
 #define JOBCTL_PENDING_MASK	(JOBCTL_STOP_PENDING | JOBCTL_TRAP_MASK)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 3c8b34876744..e66948abbee4 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -435,9 +435,10 @@ extern void calculate_sigpending(void);
 
 extern void signal_wake_up_state(struct task_struct *t, unsigned int state);
 
-static inline void signal_wake_up(struct task_struct *t, bool resume)
+static inline void signal_wake_up(struct task_struct *t, bool fatal)
 {
-	signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
+	fatal = fatal && !(t->jobctl & JOBCTL_PTRACE_FROZEN);
+	signal_wake_up_state(t, fatal ? TASK_WAKEKILL | __TASK_TRACED : 0);
 }
 static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
 {
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 05953ac9f7bd..83ed28262708 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -197,7 +197,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 	spin_lock_irq(&task->sighand->siglock);
 	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
 	    !__fatal_signal_pending(task)) {
-		WRITE_ONCE(task->__state, __TASK_TRACED);
+		task->jobctl |= JOBCTL_PTRACE_FROZEN;
 		ret = true;
 	}
 	spin_unlock_irq(&task->sighand->siglock);
@@ -207,23 +207,19 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	if (READ_ONCE(task->__state) != __TASK_TRACED)
-		return;
-
-	WARN_ON(!task->ptrace || task->parent != current);
+	unsigned long flags;
 
 	/*
-	 * PTRACE_LISTEN can allow ptrace_trap_notify to wake us up remotely.
-	 * Recheck state under the lock to close this race.
+	 * The child may be awake and may have cleared
+	 * JOBCTL_PTRACE_FROZEN (see ptrace_resume).  The child will
+	 * not set JOBCTL_PTRACE_FROZEN or enter __TASK_TRACED anew.
 	 */
-	spin_lock_irq(&task->sighand->siglock);
-	if (READ_ONCE(task->__state) == __TASK_TRACED) {
+	if (lock_task_sighand(task, &flags)) {
+		task->jobctl &= ~JOBCTL_PTRACE_FROZEN;
 		if (__fatal_signal_pending(task))
 			wake_up_state(task, __TASK_TRACED);
-		else
-			WRITE_ONCE(task->__state, TASK_TRACED);
+		unlock_task_sighand(task, &flags);
 	}
-	spin_unlock_irq(&task->sighand->siglock);
 }
 
 /**
@@ -256,7 +252,6 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 	 */
 	read_lock(&tasklist_lock);
 	if (child->ptrace && child->parent == current) {
-		WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
 		/*
 		 * child->sighand can't be NULL, release_task()
 		 * does ptrace_unlink() before __exit_signal().
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d575b4914925..3c351707e830 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6304,10 +6304,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 
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
diff --git a/kernel/signal.c b/kernel/signal.c
index d2d0c753156c..a58b68a2d3c6 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2209,14 +2209,12 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 	}
 
 	/*
-	 * schedule() will not sleep if there is a pending signal that
-	 * can awaken the task.
-	 *
-	 * After this point ptrace_signal_wake_up will clear TASK_TRACED
-	 * if ptrace_unlink happens.  Handle previous ptrace_unlinks
-	 * here to prevent ptrace_stop sleeping in schedule.
+	 * After this point ptrace_signal_wake_up or signal_wake_up
+	 * will clear TASK_TRACED if ptrace_unlink happens or a fatal
+	 * signal comes in.  Handle previous ptrace_unlinks and fatal
+	 * signals here to prevent ptrace_stop sleeping in schedule.
 	 */
-	if (!current->ptrace)
+	if (!current->ptrace || __fatal_signal_pending(current))
 		return exit_code;
 
 	set_special_state(TASK_TRACED);
@@ -2305,7 +2303,7 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 	current->exit_code = 0;
 
 	/* LISTENING can be set only during STOP traps, clear it */
-	current->jobctl &= ~JOBCTL_LISTENING;
+	current->jobctl &= ~(JOBCTL_LISTENING | JOBCTL_PTRACE_FROZEN);
 
 	/*
 	 * Queued signals ignored us while we were stopped for tracing.
-- 
2.35.3

