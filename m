Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1AB4ED60F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbiCaIsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbiCaIr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:47:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FC015470B;
        Thu, 31 Mar 2022 01:46:09 -0700 (PDT)
Date:   Thu, 31 Mar 2022 08:46:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648716367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CDQI9vtF4lOMDDh9EbLRakIHnrS5O396ViE9HmH7ckE=;
        b=dRUf9F6MXpgRSccxtrwHXh1dfIyJDn3WA+jz58hwnp+0DPbQvzhk0eQfe4/SwbHo6FjW5u
        53bnyB5edxO6tr3YfnPUGMoCidzJlfoPRxvsFHdkTlLcBwfA4mISLpI80EAMDLNVJQi3Jl
        q06svM7gPZrn90QiyprKCMIgCA90Kjaa5MpyHA3u8TnYhKAbLRPmevKrguC5f/afFzekBi
        MaObotjDN65U+FeMzq/gx9vl9V1gxVOQFNhmNVxvs3FdoZ1TC0M8UpzqlV79vhyKcO/U9T
        PsE68WoYmGqrCYUE1igXvJjMeW2xHwmycUcUITVBYevf7hvKKSUO3LyimjlrtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648716367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CDQI9vtF4lOMDDh9EbLRakIHnrS5O396ViE9HmH7ckE=;
        b=sNuAOHTd6poRi2wYwwfiHN7s2X2KXUszWZz0ym53NJfAg2m/liZhvrw2zABo82qMGjbcZ9
        nA0eyv/RzrHWnyAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] Revert "signal, x86: Delay calling signals in
 atomic on RT enabled kernels"
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <164871636568.389.8250963262354763972.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     7dd5ad2d3e82fb55229e3fe18e09160878e77e20
Gitweb:        https://git.kernel.org/tip/7dd5ad2d3e82fb55229e3fe18e09160878e77e20
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 31 Mar 2022 10:36:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 31 Mar 2022 10:36:55 +02:00

Revert "signal, x86: Delay calling signals in atomic on RT enabled kernels"

Revert commit bf9ad37dc8a. It needs to be better encapsulated and
generalized.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/Kconfig       |  1 -
 include/linux/sched.h  |  3 ---
 kernel/Kconfig.preempt | 12 +-----------
 kernel/entry/common.c  | 14 --------------
 kernel/signal.c        | 40 ----------------------------------------
 5 files changed, 1 insertion(+), 69 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7340d9f..442a426 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -122,7 +122,6 @@ config X86
 	select ARCH_WANT_GENERAL_HUGETLB
 	select ARCH_WANT_HUGE_PMD_SHARE
 	select ARCH_WANT_LD_ORPHAN_WARN
-	select ARCH_WANTS_RT_DELAYED_SIGNALS
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4a6fdd2..d5e3c00 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1090,9 +1090,6 @@ struct task_struct {
 	/* Restored if set_restore_sigmask() was used: */
 	sigset_t			saved_sigmask;
 	struct sigpending		pending;
-#ifdef CONFIG_RT_DELAYED_SIGNALS
-	struct kernel_siginfo		forced_info;
-#endif
 	unsigned long			sas_ss_sp;
 	size_t				sas_ss_size;
 	unsigned int			sas_ss_flags;
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 8c6de5a..c2f1fd9 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -133,14 +133,4 @@ config SCHED_CORE
 	  which is the likely usage by Linux distributions, there should
 	  be no measurable impact on performance.
 
-config ARCH_WANTS_RT_DELAYED_SIGNALS
-	bool
-	help
-	  This option is selected by architectures where raising signals
-	  can happen in atomic contexts on PREEMPT_RT enabled kernels. This
-	  option delays raising the signal until the return to user space
-	  loop where it is also delivered. X86 requires this to deliver
-	  signals from trap handlers which run on IST stacks.
-
-config RT_DELAYED_SIGNALS
-	def_bool PREEMPT_RT && ARCH_WANTS_RT_DELAYED_SIGNALS
+
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index ef8d94a..e57a224 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -142,18 +142,6 @@ void noinstr exit_to_user_mode(void)
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
 
-#ifdef CONFIG_RT_DELAYED_SIGNALS
-static inline void raise_delayed_signal(void)
-{
-	if (unlikely(current->forced_info.si_signo)) {
-		force_sig_info(&current->forced_info);
-		current->forced_info.si_signo = 0;
-	}
-}
-#else
-static inline void raise_delayed_signal(void) { }
-#endif
-
 static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 					    unsigned long ti_work)
 {
@@ -168,8 +156,6 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		if (ti_work & _TIF_NEED_RESCHED)
 			schedule();
 
-		raise_delayed_signal();
-
 		if (ti_work & _TIF_UPROBE)
 			uprobe_notify_resume(regs);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 368a34c..30cd1ca 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1308,43 +1308,6 @@ enum sig_handler {
 };
 
 /*
- * On some archictectures, PREEMPT_RT has to delay sending a signal from a
- * trap since it cannot enable preemption, and the signal code's
- * spin_locks turn into mutexes. Instead, it must set TIF_NOTIFY_RESUME
- * which will send the signal on exit of the trap.
- */
-#ifdef CONFIG_RT_DELAYED_SIGNALS
-static inline bool force_sig_delayed(struct kernel_siginfo *info,
-				     struct task_struct *t)
-{
-	if (!in_atomic())
-		return false;
-
-	if (WARN_ON_ONCE(t->forced_info.si_signo))
-		return true;
-
-	if (is_si_special(info)) {
-		WARN_ON_ONCE(info != SEND_SIG_PRIV);
-		t->forced_info.si_signo = info->si_signo;
-		t->forced_info.si_errno = 0;
-		t->forced_info.si_code = SI_KERNEL;
-		t->forced_info.si_pid = 0;
-		t->forced_info.si_uid = 0;
-	} else {
-		t->forced_info = *info;
-	}
-	set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
-	return true;
-}
-#else
-static inline bool force_sig_delayed(struct kernel_siginfo *info,
-				     struct task_struct *t)
-{
-	return false;
-}
-#endif
-
-/*
  * Force a signal that the process can't ignore: if necessary
  * we unblock the signal and change any SIG_IGN to SIG_DFL.
  *
@@ -1364,9 +1327,6 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
 	struct k_sigaction *action;
 	int sig = info->si_signo;
 
-	if (force_sig_delayed(info, t))
-		return 0;
-
 	spin_lock_irqsave(&t->sighand->siglock, flags);
 	action = &t->sighand->action[sig-1];
 	ignored = action->sa.sa_handler == SIG_IGN;
