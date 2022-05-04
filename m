Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4D951B209
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358209AbiEDWoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiEDWoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:44:54 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1B74888C;
        Wed,  4 May 2022 15:41:16 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:51346)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmNgJ-002DzC-E5; Wed, 04 May 2022 16:41:15 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37004 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nmNgH-00GI0k-4Y; Wed, 04 May 2022 16:41:15 -0600
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
Date:   Wed,  4 May 2022 17:40:48 -0500
Message-Id: <20220504224058.476193-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
References: <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nmNgH-00GI0k-4Y;;;mid=<20220504224058.476193-1-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+jVpUgWdpJbsR7ViOEHxSscRpMoLx4UTc=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1667 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 12 (0.7%), b_tie_ro: 10 (0.6%), parse: 1.31
        (0.1%), extract_message_metadata: 14 (0.9%), get_uri_detail_list: 3.4
        (0.2%), tests_pri_-1000: 14 (0.8%), tests_pri_-950: 1.23 (0.1%),
        tests_pri_-900: 1.07 (0.1%), tests_pri_-90: 107 (6.4%), check_bayes:
        105 (6.3%), b_tokenize: 12 (0.7%), b_tok_get_all: 9 (0.6%),
        b_comp_prob: 2.5 (0.2%), b_tok_touch_all: 78 (4.7%), b_finish: 0.94
        (0.1%), tests_pri_0: 1451 (87.1%), check_dkim_signature: 0.57 (0.0%),
        check_dkim_adsp: 2.8 (0.2%), poll_dns_idle: 0.97 (0.1%), tests_pri_10:
        3.4 (0.2%), tests_pri_500: 58 (3.5%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v3 01/11] signal: Rename send_signal send_signal_locked
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename send_signal and __send_signal to send_signal_locked and
__send_signal_locked to make send_signal usable outside of
signal.c.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/signal.h |  2 ++
 kernel/signal.c        | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index a6db6f2ae113..55605bdf5ce9 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -283,6 +283,8 @@ extern int do_send_sig_info(int sig, struct kernel_siginfo *info,
 extern int group_send_sig_info(int sig, struct kernel_siginfo *info,
 			       struct task_struct *p, enum pid_type type);
 extern int __group_send_sig_info(int, struct kernel_siginfo *, struct task_struct *);
+extern int send_signal_locked(int sig, struct kernel_siginfo *info,
+			      struct task_struct *p, enum pid_type type);
 extern int sigprocmask(int, sigset_t *, sigset_t *);
 extern void set_current_blocked(sigset_t *);
 extern void __set_current_blocked(const sigset_t *);
diff --git a/kernel/signal.c b/kernel/signal.c
index 30cd1ca43bcd..b0403197b0ad 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1071,8 +1071,8 @@ static inline bool legacy_queue(struct sigpending *signals, int sig)
 	return (sig < SIGRTMIN) && sigismember(&signals->signal, sig);
 }
 
-static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struct *t,
-			enum pid_type type, bool force)
+static int __send_signal_locked(int sig, struct kernel_siginfo *info,
+				struct task_struct *t, enum pid_type type, bool force)
 {
 	struct sigpending *pending;
 	struct sigqueue *q;
@@ -1212,8 +1212,8 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
 	return ret;
 }
 
-static int send_signal(int sig, struct kernel_siginfo *info, struct task_struct *t,
-			enum pid_type type)
+int send_signal_locked(int sig, struct kernel_siginfo *info,
+		       struct task_struct *t, enum pid_type type)
 {
 	/* Should SIGKILL or SIGSTOP be received by a pid namespace init? */
 	bool force = false;
@@ -1245,7 +1245,7 @@ static int send_signal(int sig, struct kernel_siginfo *info, struct task_struct
 			force = true;
 		}
 	}
-	return __send_signal(sig, info, t, type, force);
+	return __send_signal_locked(sig, info, t, type, force);
 }
 
 static void print_fatal_signal(int signr)
@@ -1284,7 +1284,7 @@ __setup("print-fatal-signals=", setup_print_fatal_signals);
 int
 __group_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p)
 {
-	return send_signal(sig, info, p, PIDTYPE_TGID);
+	return send_signal_locked(sig, info, p, PIDTYPE_TGID);
 }
 
 int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p,
@@ -1294,7 +1294,7 @@ int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p
 	int ret = -ESRCH;
 
 	if (lock_task_sighand(p, &flags)) {
-		ret = send_signal(sig, info, p, type);
+		ret = send_signal_locked(sig, info, p, type);
 		unlock_task_sighand(p, &flags);
 	}
 
@@ -1347,7 +1347,7 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
 	if (action->sa.sa_handler == SIG_DFL &&
 	    (!t->ptrace || (handler == HANDLER_EXIT)))
 		t->signal->flags &= ~SIGNAL_UNKILLABLE;
-	ret = send_signal(sig, info, t, PIDTYPE_PID);
+	ret = send_signal_locked(sig, info, t, PIDTYPE_PID);
 	spin_unlock_irqrestore(&t->sighand->siglock, flags);
 
 	return ret;
@@ -1567,7 +1567,7 @@ int kill_pid_usb_asyncio(int sig, int errno, sigval_t addr,
 
 	if (sig) {
 		if (lock_task_sighand(p, &flags)) {
-			ret = __send_signal(sig, &info, p, PIDTYPE_TGID, false);
+			ret = __send_signal_locked(sig, &info, p, PIDTYPE_TGID, false);
 			unlock_task_sighand(p, &flags);
 		} else
 			ret = -ESRCH;
@@ -2103,7 +2103,7 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 	 * parent's namespaces.
 	 */
 	if (valid_signal(sig) && sig)
-		__send_signal(sig, &info, tsk->parent, PIDTYPE_TGID, false);
+		__send_signal_locked(sig, &info, tsk->parent, PIDTYPE_TGID, false);
 	__wake_up_parent(tsk, tsk->parent);
 	spin_unlock_irqrestore(&psig->siglock, flags);
 
@@ -2601,7 +2601,7 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info, enum pid_type type)
 	/* If the (new) signal is now blocked, requeue it.  */
 	if (sigismember(&current->blocked, signr) ||
 	    fatal_signal_pending(current)) {
-		send_signal(signr, info, current, type);
+		send_signal_locked(signr, info, current, type);
 		signr = 0;
 	}
 
@@ -4793,7 +4793,7 @@ void kdb_send_sig(struct task_struct *t, int sig)
 			   "the deadlock.\n");
 		return;
 	}
-	ret = send_signal(sig, SEND_SIG_PRIV, t, PIDTYPE_PID);
+	ret = send_signal_locked(sig, SEND_SIG_PRIV, t, PIDTYPE_PID);
 	spin_unlock(&t->sighand->siglock);
 	if (ret)
 		kdb_printf("Fail to deliver Signal %d to process %d.\n",
-- 
2.35.3

