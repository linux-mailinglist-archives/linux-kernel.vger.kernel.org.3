Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2A2515758
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239436AbiD2VwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238812AbiD2VwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:52:16 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403B7DB2D3;
        Fri, 29 Apr 2022 14:48:57 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:49628)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nkYTv-007O8s-O2; Fri, 29 Apr 2022 15:48:55 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:36464 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nkYTt-007RIp-EJ; Fri, 29 Apr 2022 15:48:55 -0600
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
Date:   Fri, 29 Apr 2022 16:48:26 -0500
Message-Id: <20220429214837.386518-1-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
References: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nkYTt-007RIp-EJ;;;mid=<20220429214837.386518-1-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX18QHwhDIVhRddYvW2NsQFv/0UjlGxd6VNQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=2 Fuz2=38 
X-Spam-Combo: ***;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 1635 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (0.7%), b_tie_ro: 10 (0.6%), parse: 1.15
        (0.1%), extract_message_metadata: 13 (0.8%), get_uri_detail_list: 2.5
        (0.2%), tests_pri_-1000: 14 (0.9%), tests_pri_-950: 1.38 (0.1%),
        tests_pri_-900: 1.16 (0.1%), tests_pri_-90: 168 (10.2%), check_bayes:
        166 (10.1%), b_tokenize: 13 (0.8%), b_tok_get_all: 9 (0.5%),
        b_comp_prob: 2.8 (0.2%), b_tok_touch_all: 138 (8.4%), b_finish: 1.03
        (0.1%), tests_pri_0: 1398 (85.5%), check_dkim_signature: 0.71 (0.0%),
        check_dkim_adsp: 3.0 (0.2%), poll_dns_idle: 1.03 (0.1%), tests_pri_10:
        3.6 (0.2%), tests_pri_500: 20 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH v2 01/12] signal: Rename send_signal send_signal_locked
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename send_signal send_signal_locked and make to make
it usable outside of signal.c.

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

