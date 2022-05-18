Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E963A52C716
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 01:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiERW5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiERWzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:55:08 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A8A22688F;
        Wed, 18 May 2022 15:55:07 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:33160)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZO-00CkbE-8F; Wed, 18 May 2022 16:55:06 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38724 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZN-002Z0O-3U; Wed, 18 May 2022 16:55:05 -0600
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
Date:   Wed, 18 May 2022 17:53:50 -0500
Message-Id: <20220518225355.784371-11-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nrSZN-002Z0O-3U;;;mid=<20220518225355.784371-11-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+rSJyO1oyZx6lyj4Wo/uKq27rq9xXwpb0=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 456 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.7 (1.0%), b_tie_ro: 3.2 (0.7%), parse: 1.32
        (0.3%), extract_message_metadata: 11 (2.3%), get_uri_detail_list: 2.6
        (0.6%), tests_pri_-1000: 12 (2.6%), tests_pri_-950: 0.99 (0.2%),
        tests_pri_-900: 0.84 (0.2%), tests_pri_-90: 58 (12.6%), check_bayes:
        57 (12.4%), b_tokenize: 9 (1.9%), b_tok_get_all: 9 (2.0%),
        b_comp_prob: 1.89 (0.4%), b_tok_touch_all: 34 (7.4%), b_finish: 0.67
        (0.1%), tests_pri_0: 358 (78.4%), check_dkim_signature: 0.41 (0.1%),
        check_dkim_adsp: 1.66 (0.4%), poll_dns_idle: 0.33 (0.1%),
        tests_pri_10: 1.69 (0.4%), tests_pri_500: 6 (1.3%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH 11/16] ptrace: Use si_sino as the signal number to resume with
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The signal number to resume with is already in si_signo.  So instead
of placing an extra copy in tsk->exit_code and later reading the extra
copy from tsk->exit_code just read si_signo.

Read si_signo in ptrace_do_notify where it is easy as the siginfo is a
local variable.  Only ptrace_report_syscall cares about the signal to
resume with from ptrace_stop and it calls ptrace_notify which calls
ptrace_do_notify so moving the actual work into ptrace_do_notify where
it is easier is not a problem.

With ptrace_stop not being involved in returning the signal to tracer
asked the tracee to resume with remove the comment and the return
code from ptrace_stop.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c |  1 -
 kernel/signal.c | 13 ++++---------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index a0a07d140751..e0ecb1536dfc 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -530,7 +530,6 @@ static void ptrace_set_signr(struct task_struct *child, unsigned int signr)
 {
 	struct kernel_siginfo *info = child->last_siginfo;
 
-	child->exit_code = signr;
 	/*
 	 * Update the siginfo structure if the signal has
 	 * changed.  If the debugger wanted something
diff --git a/kernel/signal.c b/kernel/signal.c
index 3d955c23b13d..2cc45e8448e2 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2186,12 +2186,8 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
  * We always set current->last_siginfo while stopped here.
  * That makes it a way to test a stopped process for
  * being ptrace-stopped vs being job-control-stopped.
- *
- * Returns the signal the ptracer requested the code resume
- * with.  If the code did not stop because the tracer is gone,
- * the stop signal remains unchanged unless clear_code.
  */
-static int ptrace_stop(int exit_code, int why, unsigned long message,
+static void ptrace_stop(int exit_code, int why, unsigned long message,
 		       kernel_siginfo_t *info)
 	__releases(&current->sighand->siglock)
 	__acquires(&current->sighand->siglock)
@@ -2219,7 +2215,7 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 	 * signals here to prevent ptrace_stop sleeping in schedule.
 	 */
 	if (!current->ptrace || __fatal_signal_pending(current))
-		return exit_code;
+		return;
 
 	set_special_state(TASK_TRACED);
 	current->jobctl |= JOBCTL_TRACED;
@@ -2302,7 +2298,6 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 	 * any signal-sending on another CPU that wants to examine it.
 	 */
 	spin_lock_irq(&current->sighand->siglock);
-	exit_code = current->exit_code;
 	current->last_siginfo = NULL;
 	current->ptrace_message = 0;
 	current->exit_code = 0;
@@ -2316,7 +2311,6 @@ static int ptrace_stop(int exit_code, int why, unsigned long message,
 	 * This sets TIF_SIGPENDING, but never clears it.
 	 */
 	recalc_sigpending_tsk(current);
-	return exit_code;
 }
 
 static int ptrace_do_notify(int signr, int exit_code, int why, unsigned long message)
@@ -2330,7 +2324,8 @@ static int ptrace_do_notify(int signr, int exit_code, int why, unsigned long mes
 	info.si_uid = from_kuid_munged(current_user_ns(), current_uid());
 
 	/* Let the debugger run.  */
-	return ptrace_stop(exit_code, why, message, &info);
+	ptrace_stop(exit_code, why, message, &info);
+	return info.si_signo;
 }
 
 int ptrace_notify(int exit_code, unsigned long message)
-- 
2.35.3

