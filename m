Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE90510C3C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 00:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355929AbiDZW4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 18:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355811AbiDZWz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 18:55:57 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507C246B1B;
        Tue, 26 Apr 2022 15:52:49 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:59724)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njU36-007FoN-AH; Tue, 26 Apr 2022 16:52:48 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:35772 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1njU35-006ASW-1p; Tue, 26 Apr 2022 16:52:47 -0600
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
Date:   Tue, 26 Apr 2022 17:52:04 -0500
Message-Id: <20220426225211.308418-2-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1njU35-006ASW-1p;;;mid=<20220426225211.308418-2-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+c1Ee4UNrlcnVgOWffscWqxqbj5icZJeo=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 
X-Spam-Combo: ******;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 634 ms - load_scoreonly_sql: 0.14 (0.0%),
        signal_user_changed: 12 (1.9%), b_tie_ro: 10 (1.6%), parse: 1.45
        (0.2%), extract_message_metadata: 15 (2.4%), get_uri_detail_list: 2.2
        (0.3%), tests_pri_-1000: 16 (2.6%), tests_pri_-950: 1.38 (0.2%),
        tests_pri_-900: 1.15 (0.2%), tests_pri_-90: 74 (11.6%), check_bayes:
        72 (11.4%), b_tokenize: 12 (1.9%), b_tok_get_all: 9 (1.4%),
        b_comp_prob: 2.7 (0.4%), b_tok_touch_all: 45 (7.0%), b_finish: 1.02
        (0.2%), tests_pri_0: 499 (78.6%), check_dkim_signature: 0.65 (0.1%),
        check_dkim_adsp: 3.1 (0.5%), poll_dns_idle: 0.81 (0.1%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 8 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/9] signal: Replace __group_send_sig_info with send_signal_locked
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function send_signal_locked does more than __group_send_sig_info so
replace it.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 drivers/tty/tty_jobctrl.c      | 4 ++--
 include/linux/signal.h         | 1 -
 kernel/signal.c                | 8 +-------
 kernel/time/posix-cpu-timers.c | 6 +++---
 4 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index 80b86a7992b5..0d04287da098 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -215,8 +215,8 @@ int tty_signal_session_leader(struct tty_struct *tty, int exit_session)
 				spin_unlock_irq(&p->sighand->siglock);
 				continue;
 			}
-			__group_send_sig_info(SIGHUP, SEND_SIG_PRIV, p);
-			__group_send_sig_info(SIGCONT, SEND_SIG_PRIV, p);
+			send_signal_locked(SIGHUP, SEND_SIG_PRIV, p, PIDTYPE_TGID);
+			send_signal_locked(SIGCONT, SEND_SIG_PRIV, p, PIDTYPE_TGID);
 			put_pid(p->signal->tty_old_pgrp);  /* A noop */
 			spin_lock(&tty->ctrl.lock);
 			tty_pgrp = get_pid(tty->ctrl.pgrp);
diff --git a/include/linux/signal.h b/include/linux/signal.h
index 55605bdf5ce9..3b98e7a28538 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -282,7 +282,6 @@ extern int do_send_sig_info(int sig, struct kernel_siginfo *info,
 				struct task_struct *p, enum pid_type type);
 extern int group_send_sig_info(int sig, struct kernel_siginfo *info,
 			       struct task_struct *p, enum pid_type type);
-extern int __group_send_sig_info(int, struct kernel_siginfo *, struct task_struct *);
 extern int send_signal_locked(int sig, struct kernel_siginfo *info,
 			      struct task_struct *p, enum pid_type type);
 extern int sigprocmask(int, sigset_t *, sigset_t *);
diff --git a/kernel/signal.c b/kernel/signal.c
index b0403197b0ad..72d96614effc 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1281,12 +1281,6 @@ static int __init setup_print_fatal_signals(char *str)
 
 __setup("print-fatal-signals=", setup_print_fatal_signals);
 
-int
-__group_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p)
-{
-	return send_signal_locked(sig, info, p, PIDTYPE_TGID);
-}
-
 int do_send_sig_info(int sig, struct kernel_siginfo *info, struct task_struct *p,
 			enum pid_type type)
 {
@@ -2173,7 +2167,7 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
 	spin_lock_irqsave(&sighand->siglock, flags);
 	if (sighand->action[SIGCHLD-1].sa.sa_handler != SIG_IGN &&
 	    !(sighand->action[SIGCHLD-1].sa.sa_flags & SA_NOCLDSTOP))
-		__group_send_sig_info(SIGCHLD, &info, parent);
+		send_signal_locked(SIGCHLD, &info, parent, PIDTYPE_TGID);
 	/*
 	 * Even if SIGCHLD is not generated, we must wake up wait4 calls.
 	 */
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 0a97193984db..cb925e8ef9a8 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -870,7 +870,7 @@ static inline void check_dl_overrun(struct task_struct *tsk)
 {
 	if (tsk->dl.dl_overrun) {
 		tsk->dl.dl_overrun = 0;
-		__group_send_sig_info(SIGXCPU, SEND_SIG_PRIV, tsk);
+		send_signal_locked(SIGXCPU, SEND_SIG_PRIV, tsk, PIDTYPE_TGID);
 	}
 }
 
@@ -884,7 +884,7 @@ static bool check_rlimit(u64 time, u64 limit, int signo, bool rt, bool hard)
 			rt ? "RT" : "CPU", hard ? "hard" : "soft",
 			current->comm, task_pid_nr(current));
 	}
-	__group_send_sig_info(signo, SEND_SIG_PRIV, current);
+	send_signal_locked(signo, SEND_SIG_PRIV, current, PIDTYPE_TGID);
 	return true;
 }
 
@@ -958,7 +958,7 @@ static void check_cpu_itimer(struct task_struct *tsk, struct cpu_itimer *it,
 		trace_itimer_expire(signo == SIGPROF ?
 				    ITIMER_PROF : ITIMER_VIRTUAL,
 				    task_tgid(tsk), cur_time);
-		__group_send_sig_info(signo, SEND_SIG_PRIV, tsk);
+		send_signal_locked(signo, SEND_SIG_PRIV, tsk, PIDTYPE_TGID);
 	}
 
 	if (it->expires && it->expires < *expires)
-- 
2.35.3

