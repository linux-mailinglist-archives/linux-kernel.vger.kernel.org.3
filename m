Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BD9510C48
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355971AbiDZW4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355968AbiDZW42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:56:28 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF0549F85;
        Tue, 26 Apr 2022 15:53:11 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:60124)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njU3S-007Fzy-R5; Tue, 26 Apr 2022 16:53:10 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35772 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njU3R-006ASW-E4; Tue, 26 Apr 2022 16:53:10 -0600
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
Date:   Tue, 26 Apr 2022 17:52:11 -0500
Message-Id: <20220426225211.308418-9-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1njU3R-006ASW-E4;;;mid=<20220426225211.308418-9-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19w1+3yMGSvM4LpuQLqkwbjRk3gRrqwCXE=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 561 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.9 (0.7%), b_tie_ro: 2.8 (0.5%), parse: 0.72
        (0.1%), extract_message_metadata: 10 (1.8%), get_uri_detail_list: 1.75
        (0.3%), tests_pri_-1000: 11 (2.0%), tests_pri_-950: 1.07 (0.2%),
        tests_pri_-900: 0.84 (0.2%), tests_pri_-90: 119 (21.3%), check_bayes:
        118 (21.1%), b_tokenize: 9 (1.7%), b_tok_get_all: 9 (1.6%),
        b_comp_prob: 1.99 (0.4%), b_tok_touch_all: 94 (16.8%), b_finish: 0.63
        (0.1%), tests_pri_0: 403 (71.9%), check_dkim_signature: 0.43 (0.1%),
        check_dkim_adsp: 1.77 (0.3%), poll_dns_idle: 0.41 (0.1%),
        tests_pri_10: 1.71 (0.3%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH 9/9] ptrace: Don't change __state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop playing with tsk->__state to remove TASK_WAKEKILL while a ptrace
command is executing.

Instead implement a new jobtl flag JOBCTL_DELAY_WAKEKILL.  This new
flag is set in jobctl_freeze_task and cleared when ptrace_stop is
awoken or in jobctl_unfreeze_task (when ptrace_stop remains asleep).

In signal_wake_up_state drop TASK_WAKEKILL from state if TASK_WAKEKILL
is used while JOBCTL_DELAY_WAKEKILL is set.  This has the same effect
as changing TASK_TRACED to __TASK_TRACED as all of the wake_ups that
use TASK_KILLABLE go through signal_wake_up except the wake_up in
ptrace_unfreeze_traced.

Previously the __state value of __TASK_TRACED was changed to
TASK_RUNNING when woken up or back to TASK_TRACED when the code was
left in ptrace_stop.  Now when woken up ptrace_stop now clears
JOBCTL_DELAY_WAKEKILL and when left sleeping ptrace_unfreezed_traced
clears JOBCTL_DELAY_WAKEKILL.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/jobctl.h |  2 ++
 include/linux/sched/signal.h |  3 ++-
 kernel/ptrace.c              | 11 +++++------
 kernel/signal.c              |  1 +
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/jobctl.h b/include/linux/sched/jobctl.h
index fa067de9f1a9..4e154ad8205f 100644
--- a/include/linux/sched/jobctl.h
+++ b/include/linux/sched/jobctl.h
@@ -19,6 +19,7 @@ struct task_struct;
 #define JOBCTL_TRAPPING_BIT	21	/* switching to TRACED */
 #define JOBCTL_LISTENING_BIT	22	/* ptracer is listening for events */
 #define JOBCTL_TRAP_FREEZE_BIT	23	/* trap for cgroup freezer */
+#define JOBCTL_DELAY_WAKEKILL_BIT	24	/* delay killable wakeups */
 
 #define JOBCTL_STOP_DEQUEUED	(1UL << JOBCTL_STOP_DEQUEUED_BIT)
 #define JOBCTL_STOP_PENDING	(1UL << JOBCTL_STOP_PENDING_BIT)
@@ -28,6 +29,7 @@ struct task_struct;
 #define JOBCTL_TRAPPING		(1UL << JOBCTL_TRAPPING_BIT)
 #define JOBCTL_LISTENING	(1UL << JOBCTL_LISTENING_BIT)
 #define JOBCTL_TRAP_FREEZE	(1UL << JOBCTL_TRAP_FREEZE_BIT)
+#define JOBCTL_DELAY_WAKEKILL	(1UL << JOBCTL_DELAY_WAKEKILL_BIT)
 
 #define JOBCTL_TRAP_MASK	(JOBCTL_TRAP_STOP | JOBCTL_TRAP_NOTIFY)
 #define JOBCTL_PENDING_MASK	(JOBCTL_STOP_PENDING | JOBCTL_TRAP_MASK)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 3c8b34876744..1947c85aa9d9 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -437,7 +437,8 @@ extern void signal_wake_up_state(struct task_struct *t, unsigned int state);
 
 static inline void signal_wake_up(struct task_struct *t, bool resume)
 {
-	signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
+	bool wakekill = resume && !(t->jobctl & JOBCTL_DELAY_WAKEKILL);
+	signal_wake_up_state(t, wakekill ? TASK_WAKEKILL : 0);
 }
 static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
 {
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 842511ee9a9f..0bea74539320 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -194,7 +194,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
 	    !__fatal_signal_pending(task)) {
-		WRITE_ONCE(task->__state, __TASK_TRACED);
+		task->jobctl |= JOBCTL_DELAY_WAKEKILL;
 		ret = true;
 	}
 
@@ -203,7 +203,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	if (READ_ONCE(task->__state) != __TASK_TRACED)
+	if (!(READ_ONCE(task->jobctl) & JOBCTL_DELAY_WAKEKILL))
 		return;
 
 	WARN_ON(!task->ptrace || task->parent != current);
@@ -213,11 +213,10 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
 	 * Recheck state under the lock to close this race.
 	 */
 	spin_lock_irq(&task->sighand->siglock);
-	if (READ_ONCE(task->__state) == __TASK_TRACED) {
+	if (task->jobctl & JOBCTL_DELAY_WAKEKILL) {
+		task->jobctl &= ~JOBCTL_DELAY_WAKEKILL;
 		if (__fatal_signal_pending(task))
 			wake_up_state(task, __TASK_TRACED);
-		else
-			WRITE_ONCE(task->__state, TASK_TRACED);
 	}
 	spin_unlock_irq(&task->sighand->siglock);
 }
@@ -253,7 +252,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 	 */
 	if (lock_task_sighand(child, &flags)) {
 		if (child->ptrace && child->parent == current) {
-			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
+			WARN_ON(child->jobctl & JOBCTL_DELAY_WAKEKILL);
 			/*
 			 * child->sighand can't be NULL, release_task()
 			 * does ptrace_unlink() before __exit_signal().
diff --git a/kernel/signal.c b/kernel/signal.c
index 584d67deb3cb..2b332f89cbad 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2307,6 +2307,7 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 
 	/* LISTENING can be set only during STOP traps, clear it */
 	current->jobctl &= ~JOBCTL_LISTENING;
+	current->jobctl &= ~JOBCTL_DELAY_WAKEKILL;
 
 	/*
 	 * Queued signals ignored us while we were stopped for tracing.
-- 
2.35.3

