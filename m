Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D6A4D35B8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbiCIQpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:45:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238527AbiCIQb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:31:28 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B4B198D08
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 08:25:54 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:59198)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz8C-008XNf-6v; Wed, 09 Mar 2022 09:25:44 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34572 helo=localhost.localdomain)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRz8A-005hAS-Qt; Wed, 09 Mar 2022 09:25:43 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Wed,  9 Mar 2022 10:24:49 -0600
Message-Id: <20220309162454.123006-8-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
References: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nRz8A-005hAS-Qt;;;mid=<20220309162454.123006-8-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19MKYPBZsajzhiI7hSBuOQxerVPDJ+Pj64=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;linux-kernel@vger.kernel.org
X-Spam-Relay-Country: 
X-Spam-Timing: total 603 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 9 (1.4%), b_tie_ro: 7 (1.2%), parse: 1.07 (0.2%),
        extract_message_metadata: 12 (2.1%), get_uri_detail_list: 3.0 (0.5%),
        tests_pri_-1000: 13 (2.1%), tests_pri_-950: 1.20 (0.2%),
        tests_pri_-900: 1.00 (0.2%), tests_pri_-90: 89 (14.7%), check_bayes:
        87 (14.5%), b_tokenize: 12 (2.0%), b_tok_get_all: 8 (1.4%),
        b_comp_prob: 2.2 (0.4%), b_tok_touch_all: 61 (10.1%), b_finish: 1.03
        (0.2%), tests_pri_0: 457 (75.7%), check_dkim_signature: 0.58 (0.1%),
        check_dkim_adsp: 2.7 (0.4%), poll_dns_idle: 1.00 (0.2%), tests_pri_10:
        2.7 (0.4%), tests_pri_500: 15 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 08/13] task_work: Call tracehook_notify_signal from get_signal on all architectures
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Always handle TIF_NOTIFY_SIGNAL in get_signal.  With commit 35d0b389f3b2
("task_work: unconditionally run task_work from get_signal()") always
calling task_wofffffffrk_run all of the work of tracehook_notify_signal is
already happening except clearing TIF_NOTIFY_SIGNAL.

Factor clear_notify_signal out of tracehook_notify_signal and use it in
get_signal so that get_signal only needs one call of trask_work_run.

To keep the semantics in sync update xfer_to_guest_mode_work (which
does not call get_signal) to call tracehook_notify_signal if either
_TIF_SIGPENDING or _TIF_NOTIFY_SIGNAL.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/s390/kernel/signal.c    |  4 ++--
 arch/x86/kernel/signal.c     |  4 ++--
 include/linux/entry-common.h |  2 +-
 include/linux/tracehook.h    |  9 +++++++--
 kernel/entry/common.c        | 12 ++----------
 kernel/entry/kvm.c           |  2 +-
 kernel/signal.c              | 14 +++-----------
 7 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index 307f5d99514d..ea9e5e8182cd 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -453,7 +453,7 @@ static void handle_signal(struct ksignal *ksig, sigset_t *oldset,
  * stack-frames in one go after that.
  */
 
-void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
+void arch_do_signal_or_restart(struct pt_regs *regs)
 {
 	struct ksignal ksig;
 	sigset_t *oldset = sigmask_to_save();
@@ -466,7 +466,7 @@ void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
 	current->thread.system_call =
 		test_pt_regs_flag(regs, PIF_SYSCALL) ? regs->int_code : 0;
 
-	if (has_signal && get_signal(&ksig)) {
+	if (get_signal(&ksig)) {
 		/* Whee!  Actually deliver the signal.  */
 		if (current->thread.system_call) {
 			regs->int_code = current->thread.system_call;
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index ec71e06ae364..de3d5b5724d8 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -861,11 +861,11 @@ static inline unsigned long get_nr_restart_syscall(const struct pt_regs *regs)
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
  * mistake.
  */
-void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
+void arch_do_signal_or_restart(struct pt_regs *regs)
 {
 	struct ksignal ksig;
 
-	if (has_signal && get_signal(&ksig)) {
+	if (get_signal(&ksig)) {
 		/* Whee! Actually deliver the signal.  */
 		handle_signal(&ksig, regs);
 		return;
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 9efbdda61f7a..3537fd25f14e 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -257,7 +257,7 @@ static __always_inline void arch_exit_to_user_mode(void) { }
  *
  * Invoked from exit_to_user_mode_loop().
  */
-void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal);
+void arch_do_signal_or_restart(struct pt_regs *regs);
 
 /**
  * exit_to_user_mode - Fixup state when exiting to user mode
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index fa834a22e86e..b44a7820c468 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -106,6 +106,12 @@ static inline void tracehook_notify_resume(struct pt_regs *regs)
 	rseq_handle_notify_resume(NULL, regs);
 }
 
+static inline void clear_notify_signal(void)
+{
+	clear_thread_flag(TIF_NOTIFY_SIGNAL);
+	smp_mb__after_atomic();
+}
+
 /*
  * called by exit_to_user_mode_loop() if ti_work & _TIF_NOTIFY_SIGNAL. This
  * is currently used by TWA_SIGNAL based task_work, which requires breaking
@@ -113,8 +119,7 @@ static inline void tracehook_notify_resume(struct pt_regs *regs)
  */
 static inline void tracehook_notify_signal(void)
 {
-	clear_thread_flag(TIF_NOTIFY_SIGNAL);
-	smp_mb__after_atomic();
+	clear_notify_signal();
 	if (task_work_pending(current))
 		task_work_run();
 }
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index f0b1daa1e8da..79eaf9b4b10d 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -139,15 +139,7 @@ void noinstr exit_to_user_mode(void)
 }
 
 /* Workaround to allow gradual conversion of architecture code */
-void __weak arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal) { }
-
-static void handle_signal_work(struct pt_regs *regs, unsigned long ti_work)
-{
-	if (ti_work & _TIF_NOTIFY_SIGNAL)
-		tracehook_notify_signal();
-
-	arch_do_signal_or_restart(regs, ti_work & _TIF_SIGPENDING);
-}
+void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
 
 static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 					    unsigned long ti_work)
@@ -170,7 +162,7 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 			klp_update_patch_state(current);
 
 		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
-			handle_signal_work(regs, ti_work);
+			arch_do_signal_or_restart(regs);
 
 		if (ti_work & _TIF_NOTIFY_RESUME)
 			tracehook_notify_resume(regs);
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index 96d476e06c77..cabf36a489e4 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -8,7 +8,7 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
 	do {
 		int ret;
 
-		if (ti_work & _TIF_NOTIFY_SIGNAL)
+		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
 			tracehook_notify_signal();
 
 		if (ti_work & _TIF_SIGPENDING) {
diff --git a/kernel/signal.c b/kernel/signal.c
index 3b4cf25fb9b3..8632b88982c9 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2626,20 +2626,12 @@ bool get_signal(struct ksignal *ksig)
 	struct signal_struct *signal = current->signal;
 	int signr;
 
+	clear_notify_signal();
 	if (unlikely(task_work_pending(current)))
 		task_work_run();
 
-	/*
-	 * For non-generic architectures, check for TIF_NOTIFY_SIGNAL so
-	 * that the arch handlers don't all have to do it. If we get here
-	 * without TIF_SIGPENDING, just exit after running signal work.
-	 */
-	if (!IS_ENABLED(CONFIG_GENERIC_ENTRY)) {
-		if (test_thread_flag(TIF_NOTIFY_SIGNAL))
-			tracehook_notify_signal();
-		if (!task_sigpending(current))
-			return false;
-	}
+	if (!task_sigpending(current))
+		return false;
 
 	if (unlikely(uprobe_deny_signal()))
 		return false;
-- 
2.29.2

