Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1644DA637
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 00:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352561AbiCOXXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 19:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbiCOXXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 19:23:48 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF7E5D66B;
        Tue, 15 Mar 2022 16:22:36 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:53612)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nUGUt-009u8G-8K; Tue, 15 Mar 2022 17:22:35 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37864 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nUGUr-00EZK3-3o; Tue, 15 Mar 2022 17:22:34 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>, <linux-api@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
        <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
        <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
        <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
        <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
Date:   Tue, 15 Mar 2022 18:22:26 -0500
In-Reply-To: <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Tue, 15 Mar 2022 18:18:59 -0500")
Message-ID: <875yoe7qdp.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nUGUr-00EZK3-3o;;;mid=<875yoe7qdp.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18bmJhKt0zs1ZeySq/C8PKKAxniIbz05Ho=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1569 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.9 (0.2%), b_tie_ro: 2.7 (0.2%), parse: 1.34
        (0.1%), extract_message_metadata: 14 (0.9%), get_uri_detail_list: 4.0
        (0.3%), tests_pri_-1000: 14 (0.9%), tests_pri_-950: 1.03 (0.1%),
        tests_pri_-900: 0.88 (0.1%), tests_pri_-90: 90 (5.8%), check_bayes: 89
        (5.7%), b_tokenize: 15 (1.0%), b_tok_get_all: 11 (0.7%), b_comp_prob:
        2.1 (0.1%), b_tok_touch_all: 58 (3.7%), b_finish: 0.64 (0.0%),
        tests_pri_0: 1428 (91.0%), check_dkim_signature: 0.51 (0.0%),
        check_dkim_adsp: 2.3 (0.1%), poll_dns_idle: 0.92 (0.1%), tests_pri_10:
        2.9 (0.2%), tests_pri_500: 9 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/2] ptrace: Return the signal to continue with from
 ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The signal a task should continue with after a ptrace stop is
inconsistently read, cleared, and sent.  Solve this by reading and
clearing the signal to be sent in ptrace_stop.

In an ideal world everything except ptrace_signal would share a common
implementation of continuing with the signal, so ptracers could count
on the signal they ask to continue with actually being delivered.  For
now retain bug compatibility and just return with the signal number
the ptracer requested the code continue with.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/ptrace.h | 12 ++++++------
 kernel/signal.c        | 31 ++++++++++++++++++-------------
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 3e6b46e2b7be..15b3d176b6b4 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -60,7 +60,7 @@ extern int ptrace_writedata(struct task_struct *tsk, char __user *src, unsigned
 extern void ptrace_disable(struct task_struct *);
 extern int ptrace_request(struct task_struct *child, long request,
 			  unsigned long addr, unsigned long data);
-extern void ptrace_notify(int exit_code, unsigned long message);
+extern int ptrace_notify(int exit_code, unsigned long message);
 extern void __ptrace_link(struct task_struct *child,
 			  struct task_struct *new_parent,
 			  const struct cred *ptracer_cred);
@@ -419,21 +419,21 @@ extern void sigaction_compat_abi(struct k_sigaction *act, struct k_sigaction *oa
 static inline int ptrace_report_syscall(unsigned long message)
 {
 	int ptrace = current->ptrace;
+	int signr;
 
 	if (!(ptrace & PT_PTRACED))
 		return 0;
 
-	ptrace_notify(SIGTRAP | ((ptrace & PT_TRACESYSGOOD) ? 0x80 : 0), message);
+	signr = ptrace_notify(SIGTRAP | ((ptrace & PT_TRACESYSGOOD) ? 0x80 : 0),
+			      message);
 
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
 	 * for normal use.  strace only continues with a signal if the
 	 * stopping signal is not SIGTRAP.  -brl
 	 */
-	if (current->exit_code) {
-		send_sig(current->exit_code, current, 1);
-		current->exit_code = 0;
-	}
+	if (signr)
+		send_sig(signr, current, 1);
 
 	return fatal_signal_pending(current);
 }
diff --git a/kernel/signal.c b/kernel/signal.c
index a49ac7149256..e53ee84b9021 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2188,15 +2188,17 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
  * That makes it a way to test a stopped process for
  * being ptrace-stopped vs being job-control-stopped.
  *
- * If we actually decide not to stop at all because the tracer
- * is gone, we keep current->exit_code unless clear_code.
+ * Returns the signal the ptracer requested the code resume
+ * with.  If the code did not stop because the tracer is gone,
+ * the stop signal remains unchanged unless clear_code.
  */
-static void ptrace_stop(int exit_code, int why, int clear_code,
+static int ptrace_stop(int exit_code, int why, int clear_code,
 			unsigned long message, kernel_siginfo_t *info)
 	__releases(&current->sighand->siglock)
 	__acquires(&current->sighand->siglock)
 {
 	bool gstop_done = false;
+	bool read_code = true;
 
 	if (arch_ptrace_stop_needed()) {
 		/*
@@ -2305,8 +2307,9 @@ static void ptrace_stop(int exit_code, int why, int clear_code,
 
 		/* tasklist protects us from ptrace_freeze_traced() */
 		__set_current_state(TASK_RUNNING);
+		read_code = false;
 		if (clear_code)
-			current->exit_code = 0;
+			exit_code = 0;
 		read_unlock(&tasklist_lock);
 	}
 
@@ -2316,8 +2319,10 @@ static void ptrace_stop(int exit_code, int why, int clear_code,
 	 * any signal-sending on another CPU that wants to examine it.
 	 */
 	spin_lock_irq(&current->sighand->siglock);
+	if (read_code) exit_code = current->exit_code;
 	current->last_siginfo = NULL;
 	current->ptrace_message = 0;
+	current->exit_code = 0;
 
 	/* LISTENING can be set only during STOP traps, clear it */
 	current->jobctl &= ~JOBCTL_LISTENING;
@@ -2328,9 +2333,10 @@ static void ptrace_stop(int exit_code, int why, int clear_code,
 	 * This sets TIF_SIGPENDING, but never clears it.
 	 */
 	recalc_sigpending_tsk(current);
+	return exit_code;
 }
 
-static void ptrace_do_notify(int signr, int exit_code, int why, unsigned long message)
+static int ptrace_do_notify(int signr, int exit_code, int why, unsigned long message)
 {
 	kernel_siginfo_t info;
 
@@ -2341,18 +2347,21 @@ static void ptrace_do_notify(int signr, int exit_code, int why, unsigned long me
 	info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
 
 	/* Let the debugger run.  */
-	ptrace_stop(exit_code, why, 1, message, &info);
+	return ptrace_stop(exit_code, why, 1, message, &info);
 }
 
-void ptrace_notify(int exit_code, unsigned long message)
+int ptrace_notify(int exit_code, unsigned long message)
 {
+	int signr;
+
 	BUG_ON((exit_code & (0x7f | ~0xffff)) != SIGTRAP);
 	if (unlikely(task_work_pending(current)))
 		task_work_run();
 
 	spin_lock_irq(&current->sighand->siglock);
-	ptrace_do_notify(SIGTRAP, exit_code, CLD_TRAPPED, message);
+	signr = ptrace_do_notify(SIGTRAP, exit_code, CLD_TRAPPED, message);
 	spin_unlock_irq(&current->sighand->siglock);
+	return signr;
 }
 
 /**
@@ -2511,7 +2520,6 @@ static void do_jobctl_trap(void)
 	} else {
 		WARN_ON_ONCE(!signr);
 		ptrace_stop(signr, CLD_STOPPED, 0, 0, NULL);
-		current->exit_code = 0;
 	}
 }
 
@@ -2564,15 +2572,12 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info, enum pid_type type)
 	 * comment in dequeue_signal().
 	 */
 	current->jobctl |= JOBCTL_STOP_DEQUEUED;
-	ptrace_stop(signr, CLD_TRAPPED, 0, 0, info);
+	signr = ptrace_stop(signr, CLD_TRAPPED, 0, 0, info);
 
 	/* We're back.  Did the debugger cancel the sig?  */
-	signr = current->exit_code;
 	if (signr == 0)
 		return signr;
 
-	current->exit_code = 0;
-
 	/*
 	 * Update the siginfo structure if the signal has
 	 * changed.  If the debugger wanted something
-- 
2.29.2

