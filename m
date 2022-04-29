Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FC35157EF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381292AbiD2WLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381167AbiD2WK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:10:59 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA23DC9A2;
        Fri, 29 Apr 2022 15:07:29 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:54790)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nkYUG-00AIJQ-Lr; Fri, 29 Apr 2022 15:49:16 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36464 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nkYUF-007RIp-GC; Fri, 29 Apr 2022 15:49:16 -0600
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
Date:   Fri, 29 Apr 2022 16:48:32 -0500
Message-Id: <20220429214837.386518-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
References: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nkYUF-007RIp-GC;;;mid=<20220429214837.386518-7-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+Z8HlV3UkGfoy7F/rNg/M1zhIgnTw75z0=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 563 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 4.3 (0.8%), b_tie_ro: 2.2 (0.4%), parse: 0.81
        (0.1%), extract_message_metadata: 9 (1.6%), get_uri_detail_list: 2.2
        (0.4%), tests_pri_-1000: 11 (2.0%), tests_pri_-950: 1.01 (0.2%),
        tests_pri_-900: 0.87 (0.2%), tests_pri_-90: 63 (11.1%), check_bayes:
        61 (10.9%), b_tokenize: 11 (2.0%), b_tok_get_all: 10 (1.8%),
        b_comp_prob: 2.7 (0.5%), b_tok_touch_all: 34 (6.0%), b_finish: 0.80
        (0.1%), tests_pri_0: 459 (81.5%), check_dkim_signature: 0.47 (0.1%),
        check_dkim_adsp: 1.68 (0.3%), poll_dns_idle: 0.28 (0.0%),
        tests_pri_10: 2.9 (0.5%), tests_pri_500: 8 (1.5%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH v2 07/12] ptrace: Don't change __state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop playing with tsk->__state to remove TASK_WAKEKILL while a ptrace
command is executing.

Instead TASK_WAKEKILL from the definition of TASK_TRACED, and
implemention a new jobctl flag TASK_PTRACE_FROZEN.  This new This new
flag is set in jobctl_freeze_task and cleared when ptrace_stop is
awoken or in jobctl_unfreeze_task (when ptrace_stop remains asleep).

In singal_wake_up add __TASK_TRACED to state along with TASK_WAKEKILL
when it is indicated a fatal signal is pending.  Skip adding
__TASK_TRACED when TASK_PTRACE_FROZEN is not set.  This has the same
effect as changing TASK_TRACED to __TASK_TRACED as all of the wake_ups
that use TASK_KILLABLE go through signal_wake_up.

Don't set TASK_TRACED if fatal_signal_pending so that the code
continues not to sleep if there was a pending fatal signal before
ptrace_stop is called.  With TASK_WAKEKILL no longer present in
TASK_TRACED signal_pending_state will no longer prevent ptrace_stop
from sleeping if there is a pending fatal signal.

Previously the __state value of __TASK_TRACED was changed to
TASK_RUNNING when woken up or back to TASK_TRACED when the code was
left in ptrace_stop.  Now when woken up ptrace_stop now clears
JOBCTL_PTRACE_FROZEN and when left sleeping ptrace_unfreezed_traced
clears JOBCTL_PTRACE_FROZEN.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched.h        |  2 +-
 include/linux/sched/jobctl.h |  2 ++
 include/linux/sched/signal.h |  8 +++++++-
 kernel/ptrace.c              | 21 ++++++++-------------
 kernel/signal.c              |  9 +++------
 5 files changed, 21 insertions(+), 21 deletions(-)

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
index 3c8b34876744..35af34eeee9e 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -437,7 +437,13 @@ extern void signal_wake_up_state(struct task_struct *t, unsigned int state);
 
 static inline void signal_wake_up(struct task_struct *t, bool resume)
 {
-	signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
+	unsigned int state = 0;
+	if (resume) {
+		state = TASK_WAKEKILL;
+		if (!(t->jobctl & JOBCTL_PTRACE_FROZEN))
+			state |= __TASK_TRACED;
+	}
+	signal_wake_up_state(t, state);
 }
 static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
 {
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 43da5764b6f3..644eb7439d01 100644
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
diff --git a/kernel/signal.c b/kernel/signal.c
index 3fd2ce133387..5cf268982a7e 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2209,11 +2209,8 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 		spin_lock_irq(&current->sighand->siglock);
 	}
 
-	/*
-	 * schedule() will not sleep if there is a pending signal that
-	 * can awaken the task.
-	 */
-	set_special_state(TASK_TRACED);
+	if (!__fatal_signal_pending(current))
+		set_special_state(TASK_TRACED);
 
 	/*
 	 * We're committing to trapping.  TRACED should be visible before
@@ -2321,7 +2318,7 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 	current->exit_code = 0;
 
 	/* LISTENING can be set only during STOP traps, clear it */
-	current->jobctl &= ~JOBCTL_LISTENING;
+	current->jobctl &= ~(JOBCTL_LISTENING | JOBCTL_PTRACE_FROZEN);
 
 	/*
 	 * Queued signals ignored us while we were stopped for tracing.
-- 
2.35.3

