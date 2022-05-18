Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2DD52C6C0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiERWzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiERWzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:55:00 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFF022DA18;
        Wed, 18 May 2022 15:54:55 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:55168)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZC-003bc3-Uc; Wed, 18 May 2022 16:54:54 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:38724 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nrSZB-002Z0O-N6; Wed, 18 May 2022 16:54:54 -0600
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
Date:   Wed, 18 May 2022 17:53:47 -0500
Message-Id: <20220518225355.784371-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
References: <871qwq5ucx.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nrSZB-002Z0O-N6;;;mid=<20220518225355.784371-8-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19U9H+LaT04oPfJY3DaaeOb2O0QxRcclq0=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 586 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 8 (1.4%), b_tie_ro: 7 (1.2%), parse: 1.03 (0.2%),
        extract_message_metadata: 12 (2.0%), get_uri_detail_list: 2.2 (0.4%),
        tests_pri_-1000: 15 (2.6%), tests_pri_-950: 1.33 (0.2%),
        tests_pri_-900: 1.04 (0.2%), tests_pri_-90: 166 (28.3%), check_bayes:
        164 (28.0%), b_tokenize: 12 (2.1%), b_tok_get_all: 11 (1.8%),
        b_comp_prob: 2.8 (0.5%), b_tok_touch_all: 135 (23.0%), b_finish: 0.90
        (0.2%), tests_pri_0: 370 (63.1%), check_dkim_signature: 0.62 (0.1%),
        check_dkim_adsp: 2.9 (0.5%), poll_dns_idle: 1.12 (0.2%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 08/16] ptrace: Only populate last_siginfo from ptrace
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in ptrace_signal to populate siginfo if the signal number
changed is buggy.  If the tracer contined the tracee using
ptrace_detach it is guaranteed to use the real_parent (or possibly a
new tracer) but definitely not the origional tracer to populate si_pid
and si_uid.

Fix this bug by only updating siginfo from the tracer so that the
tracers pid and the tracers uid are always used.

If it happens that ptrace_resume or ptrace_detach don't have
a signal to continue with clear siginfo.

This is a very old bug that has been fixable since commit 1669ce53e2ff
("Add PTRACE_GETSIGINFO and PTRACE_SETSIGINFO") when last_siginfo was
introduced and the tracer could change siginfo.

Fixes: v2.1.68
History-Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ptrace.c | 31 +++++++++++++++++++++++++++++--
 kernel/signal.c | 18 ------------------
 2 files changed, 29 insertions(+), 20 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 15e93eafa6f0..a24eed725cec 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -526,6 +526,33 @@ static int ptrace_traceme(void)
 	return ret;
 }
 
+static void ptrace_set_signr(struct task_struct *child, unsigned int signr)
+{
+	struct kernel_siginfo *info = child->last_siginfo;
+
+	child->exit_code = signr;
+	/*
+	 * Update the siginfo structure if the signal has
+	 * changed.  If the debugger wanted something
+	 * specific in the siginfo structure then it should
+	 * have updated *info via PTRACE_SETSIGINFO.
+	 */
+	if (info && (info->si_signo != signr)) {
+		clear_siginfo(info);
+
+		if (signr != 0) {
+			info->si_signo = signr;
+			info->si_errno = 0;
+			info->si_code = SI_USER;
+			rcu_read_lock();
+			info->si_pid = task_pid_nr_ns(current, task_active_pid_ns(child));
+			info->si_uid = from_kuid_munged(task_cred_xxx(child, user_ns),
+						current_uid());
+			rcu_read_unlock();
+		}
+	}
+}
+
 /*
  * Called with tasklist_lock held for writing.
  * Unlink a traced task, and clean it up if it was a traced zombie.
@@ -579,7 +606,7 @@ static int ptrace_detach(struct task_struct *child, unsigned int data)
 	 * tasklist_lock avoids the race with wait_task_stopped(), see
 	 * the comment in ptrace_resume().
 	 */
-	child->exit_code = data;
+	ptrace_set_signr(child, data);
 	__ptrace_detach(current, child);
 	write_unlock_irq(&tasklist_lock);
 
@@ -851,7 +878,7 @@ static int ptrace_resume(struct task_struct *child, long request,
 	 * wait_task_stopped() after resume.
 	 */
 	spin_lock_irq(&child->sighand->siglock);
-	child->exit_code = data;
+	ptrace_set_signr(child, data);
 	child->jobctl &= ~JOBCTL_TRACED;
 	wake_up_state(child, __TASK_TRACED);
 	spin_unlock_irq(&child->sighand->siglock);
diff --git a/kernel/signal.c b/kernel/signal.c
index e782c2611b64..ff4a52352390 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2562,24 +2562,6 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info, enum pid_type type)
 	if (signr == 0)
 		return signr;
 
-	/*
-	 * Update the siginfo structure if the signal has
-	 * changed.  If the debugger wanted something
-	 * specific in the siginfo structure then it should
-	 * have updated *info via PTRACE_SETSIGINFO.
-	 */
-	if (signr != info->si_signo) {
-		clear_siginfo(info);
-		info->si_signo = signr;
-		info->si_errno = 0;
-		info->si_code = SI_USER;
-		rcu_read_lock();
-		info->si_pid = task_pid_vnr(current->parent);
-		info->si_uid = from_kuid_munged(current_user_ns(),
-						task_uid(current->parent));
-		rcu_read_unlock();
-	}
-
 	/* If the (new) signal is now blocked, requeue it.  */
 	if (sigismember(&current->blocked, signr) ||
 	    fatal_signal_pending(current)) {
-- 
2.35.3

