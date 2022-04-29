Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D6F5157EA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381278AbiD2WLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbiD2WKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:10:45 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D900DBD36;
        Fri, 29 Apr 2022 15:07:26 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:54950)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nkYUQ-00AILf-7G; Fri, 29 Apr 2022 15:49:26 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36464 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nkYUP-007RIp-3B; Fri, 29 Apr 2022 15:49:25 -0600
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
Date:   Fri, 29 Apr 2022 16:48:35 -0500
Message-Id: <20220429214837.386518-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
References: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nkYUP-007RIp-3B;;;mid=<20220429214837.386518-10-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18BszdtWlY/czZ0kfmE2y8Ll+tNMQpUINU=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 517 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.8 (0.9%), b_tie_ro: 3.4 (0.7%), parse: 1.29
        (0.3%), extract_message_metadata: 11 (2.1%), get_uri_detail_list: 3.0
        (0.6%), tests_pri_-1000: 11 (2.1%), tests_pri_-950: 1.01 (0.2%),
        tests_pri_-900: 0.86 (0.2%), tests_pri_-90: 98 (19.0%), check_bayes:
        96 (18.7%), b_tokenize: 9 (1.7%), b_tok_get_all: 9 (1.7%),
        b_comp_prob: 2.1 (0.4%), b_tok_touch_all: 73 (14.2%), b_finish: 0.79
        (0.2%), tests_pri_0: 373 (72.1%), check_dkim_signature: 0.43 (0.1%),
        check_dkim_adsp: 1.79 (0.3%), poll_dns_idle: 0.46 (0.1%),
        tests_pri_10: 2.6 (0.5%), tests_pri_500: 10 (2.0%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH v2 10/12] ptrace: Only return signr from ptrace_stop if it was provided
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ptrace_stop a ptrace_unlink or SIGKILL can occur either after
siglock is dropped or after tasklist_lock is dropped.  At either point
the result can be that ptrace will continue and not stop at schedule.

This means that there are cases where the current logic fails to handle
the fact that ptrace_stop did not actually stop, and can potentially
cause ptrace_report_syscall to attempt to deliver a signal.

Instead of attempting to detect in ptrace_stop when it fails to
stop update ptrace_resume and ptrace_detach to set a flag to indicate
that the signal to continue with has be set.   Use that
new flag to decided how to set return signal.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/jobctl.h |  2 ++
 kernel/ptrace.c              |  5 +++++
 kernel/signal.c              | 12 ++++++------
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/jobctl.h b/include/linux/sched/jobctl.h
index d556c3425963..2ff1bcd63cf4 100644
--- a/include/linux/sched/jobctl.h
+++ b/include/linux/sched/jobctl.h
@@ -20,6 +20,7 @@ struct task_struct;
 #define JOBCTL_LISTENING_BIT	22	/* ptracer is listening for events */
 #define JOBCTL_TRAP_FREEZE_BIT	23	/* trap for cgroup freezer */
 #define JOBCTL_PTRACE_FROZEN_BIT	24	/* frozen for ptrace */
+#define JOBCTL_PTRACE_SIGNR_BIT	25	/* ptrace signal number */
 
 #define JOBCTL_STOP_DEQUEUED	(1UL << JOBCTL_STOP_DEQUEUED_BIT)
 #define JOBCTL_STOP_PENDING	(1UL << JOBCTL_STOP_PENDING_BIT)
@@ -30,6 +31,7 @@ struct task_struct;
 #define JOBCTL_LISTENING	(1UL << JOBCTL_LISTENING_BIT)
 #define JOBCTL_TRAP_FREEZE	(1UL << JOBCTL_TRAP_FREEZE_BIT)
 #define JOBCTL_PTRACE_FROZEN	(1UL << JOBCTL_PTRACE_FROZEN_BIT)
+#define JOBCTL_PTRACE_SIGNR	(1UL << JOBCTL_PTRACE_SIGNR_BIT)
 
 #define JOBCTL_TRAP_MASK	(JOBCTL_TRAP_STOP | JOBCTL_TRAP_NOTIFY)
 #define JOBCTL_PENDING_MASK	(JOBCTL_STOP_PENDING | JOBCTL_TRAP_MASK)
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index c1c99e8be147..d80222251f60 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -596,7 +596,11 @@ static int ptrace_detach(struct task_struct *child, unsigned int data)
 	 * tasklist_lock avoids the race with wait_task_stopped(), see
 	 * the comment in ptrace_resume().
 	 */
+	spin_lock(&child->sighand->siglock);
 	child->exit_code = data;
+	child->jobctl |= JOBCTL_PTRACE_SIGNR;
+	spin_unlock(&child->sighand->siglock);
+
 	__ptrace_detach(current, child);
 	write_unlock_irq(&tasklist_lock);
 
@@ -883,6 +887,7 @@ static int ptrace_resume(struct task_struct *child, long request,
 	 */
 	spin_lock_irq(&child->sighand->siglock);
 	child->exit_code = data;
+	child->jobctl |= JOBCTL_PTRACE_SIGNR;
 	wake_up_state(child, __TASK_TRACED);
 	spin_unlock_irq(&child->sighand->siglock);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 5cf268982a7e..7cb27a27290a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2193,7 +2193,6 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 	__acquires(&current->sighand->siglock)
 {
 	bool gstop_done = false;
-	bool read_code = true;
 
 	if (arch_ptrace_stop_needed()) {
 		/*
@@ -2299,9 +2298,6 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 
 		/* tasklist protects us from ptrace_freeze_traced() */
 		__set_current_state(TASK_RUNNING);
-		read_code = false;
-		if (clear_code)
-			exit_code = 0;
 		read_unlock(&tasklist_lock);
 	}
 
@@ -2311,14 +2307,18 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
 	 * any signal-sending on another CPU that wants to examine it.
 	 */
 	spin_lock_irq(&current->sighand->siglock);
-	if (read_code)
+	/* Did userspace perhaps provide a signal to resume with? */
+	if (current->jobctl & JOBCTL_PTRACE_SIGNR)
 		exit_code = current->exit_code;
+	else if (clear_code)
+		exit_code = 0;
+
 	current->last_siginfo = NULL;
 	current->ptrace_message = 0;
 	current->exit_code = 0;
 
 	/* LISTENING can be set only during STOP traps, clear it */
-	current->jobctl &= ~(JOBCTL_LISTENING | JOBCTL_PTRACE_FROZEN);
+	current->jobctl &= ~(JOBCTL_LISTENING | JOBCTL_PTRACE_FROZEN | JOBCTL_PTRACE_SIGNR);
 
 	/*
 	 * Queued signals ignored us while we were stopped for tracing.
-- 
2.35.3

