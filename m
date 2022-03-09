Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000CE4D37A9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235998AbiCIQqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238651AbiCIQbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:31:40 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7915119D609
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:26:08 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:33598)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz8G-0032AE-SY; Wed, 09 Mar 2022 09:25:48 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34572 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz8F-005hAS-SC; Wed, 09 Mar 2022 09:25:48 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  9 Mar 2022 10:24:51 -0600
Message-Id: <20220309162454.123006-10-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nRz8F-005hAS-SC;;;mid=<20220309162454.123006-10-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18c77WACAnGV6rsjFny4+h3cMGGq4soXMk=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 376 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (2.9%), b_tie_ro: 10 (2.6%), parse: 0.89
        (0.2%), extract_message_metadata: 11 (3.0%), get_uri_detail_list: 1.40
        (0.4%), tests_pri_-1000: 13 (3.6%), tests_pri_-950: 1.25 (0.3%),
        tests_pri_-900: 0.99 (0.3%), tests_pri_-90: 73 (19.3%), check_bayes:
        71 (18.9%), b_tokenize: 7 (1.8%), b_tok_get_all: 6 (1.5%),
        b_comp_prob: 1.86 (0.5%), b_tok_touch_all: 54 (14.3%), b_finish: 0.82
        (0.2%), tests_pri_0: 252 (67.1%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 3.0 (0.8%), poll_dns_idle: 1.17 (0.3%), tests_pri_10:
        2.1 (0.6%), tests_pri_500: 7 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 10/13] signal: Move set_notify_signal and clear_notify_signal into sched/signal.h
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header tracehook.h is no place for code to live.  The functions
set_notify_signal and clear_notify_signal are not about signals.  They
are about interruptions that act like signals.  The fundamental signal
primitives wind up calling set_notify_signal and clear_notify_signal.
Which means they need to be maintained with the signal code.

Since set_notify_signal and clear_notify_signal must be maintained
with the signal subsystem move them into sched/signal.h and claim them
as part of the signal subsystem.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/sched/signal.h | 17 +++++++++++++++++
 include/linux/tracehook.h    | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index b6ecb9fc4cd2..3c8b34876744 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -349,6 +349,23 @@ extern void sigqueue_free(struct sigqueue *);
 extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type);
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 
+static inline void clear_notify_signal(void)
+{
+	clear_thread_flag(TIF_NOTIFY_SIGNAL);
+	smp_mb__after_atomic();
+}
+
+/*
+ * Called to break out of interruptible wait loops, and enter the
+ * exit_to_user_mode_loop().
+ */
+static inline void set_notify_signal(struct task_struct *task)
+{
+	if (!test_and_set_tsk_thread_flag(task, TIF_NOTIFY_SIGNAL) &&
+	    !wake_up_state(task, TASK_INTERRUPTIBLE))
+		kick_process(task);
+}
+
 static inline int restart_syscall(void)
 {
 	set_tsk_thread_flag(current, TIF_SIGPENDING);
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index e5d676e841e3..1b7365aef8da 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -106,21 +106,4 @@ static inline void tracehook_notify_resume(struct pt_regs *regs)
 	rseq_handle_notify_resume(NULL, regs);
 }
 
-static inline void clear_notify_signal(void)
-{
-	clear_thread_flag(TIF_NOTIFY_SIGNAL);
-	smp_mb__after_atomic();
-}
-
-/*
- * Called to break out of interruptible wait loops, and enter the
- * exit_to_user_mode_loop().
- */
-static inline void set_notify_signal(struct task_struct *task)
-{
-	if (!test_and_set_tsk_thread_flag(task, TIF_NOTIFY_SIGNAL) &&
-	    !wake_up_state(task, TASK_INTERRUPTIBLE))
-		kick_process(task);
-}
-
 #endif	/* <linux/tracehook.h> */
-- 
2.29.2

