Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5D34CD5DF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239743AbiCDOGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbiCDOGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:06:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4721B9880;
        Fri,  4 Mar 2022 06:05:55 -0800 (PST)
Date:   Fri, 04 Mar 2022 14:05:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646402754;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7kZAWozMoqSyGGGl7Nn0CvmDaXDrPcsS8WCQvQqVchE=;
        b=t/EKQZoSPG312my0z/DJZBugy/VaOd2ohqVU7PzglAcCGBgc5pokhd4mofj0GJiMHNs898
        75beBaTwGIzHnbk0V/NERnAzorfjOtIEQ4fpvcftbYclzNevBCVxdFtHev+xacAhoAufbs
        lXTEqReajNo89I+kPllK5Ki057um55lvIWlRlpb8dW1/rHnAg1oKj1NduyWTRF/73FI/6F
        OO6XDabJ+M2/CoxkjNgwnh1ezeFJ3ANMnNYqwsH1f0qHqHBsodJif8eVJUHaYtikfCMv7E
        sVSypeecL+bEB5pMX6Y6knd3xefZfCTHm2jzqBje3HqPyXyAXkuhBKUEIIdbaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646402754;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7kZAWozMoqSyGGGl7Nn0CvmDaXDrPcsS8WCQvQqVchE=;
        b=KWFjfyCz2oR8AG3AMKLWbpfL3vncw8PaJGtPxfrE4nNWBXMtDVsCb1uMtvKNJMVPIjARH/
        xAvb5F4nrAl/SKDg==
From:   "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] signal, x86: Delay calling signals in atomic on RT
 enabled kernels
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <qMQw6aP5@linutronix.de>
References: <qMQw6aP5@linutronix.de>
MIME-Version: 1.0
Message-ID: <164640275280.16921.11566005697906517658.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/core branch of tip:

Commit-ID:     bf9ad37dc8a30cce22ae95d6c2ca6abf8731d305
Gitweb:        https://git.kernel.org/tip/bf9ad37dc8a30cce22ae95d6c2ca6abf8731d305
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Tue, 14 Jul 2015 14:26:34 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Mar 2022 14:58:54 +01:00

signal, x86: Delay calling signals in atomic on RT enabled kernels

On x86_64 we must disable preemption before we enable interrupts
for stack faults, int3 and debugging, because the current task is using
a per CPU debug stack defined by the IST. If we schedule out, another task
can come in and use the same stack and cause the stack to be corrupted
and crash the kernel on return.

When CONFIG_PREEMPT_RT is enabled, spinlock_t locks become sleeping, and
one of these is the spin lock used in signal handling.

Some of the debug code (int3) causes do_trap() to send a signal.
This function calls a spinlock_t lock that has been converted to a
sleeping lock. If this happens, the above issues with the corrupted
stack is possible.

Instead of calling the signal right away, for PREEMPT_RT and x86,
the signal information is stored on the stacks task_struct and
TIF_NOTIFY_RESUME is set. Then on exit of the trap, the signal resume
code will send the signal when preemption is enabled.

[ rostedt: Switched from #ifdef CONFIG_PREEMPT_RT to
  ARCH_RT_DELAYS_SIGNAL_SEND and added comments to the code. ]
[bigeasy: Add on 32bit as per Yang Shi, minor rewording. ]
[ tglx: Use a config option ]

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/Ygq5aBB/qMQw6aP5@linutronix.de
---
 arch/x86/Kconfig       |  1 +
 include/linux/sched.h  |  3 +++
 kernel/Kconfig.preempt | 12 +++++++++++-
 kernel/entry/common.c  | 14 ++++++++++++++
 kernel/signal.c        | 40 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9f5bd41..d557ac2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -120,6 +120,7 @@ config X86
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANT_HUGE_PMD_SHARE
 	select ARCH_WANT_LD_ORPHAN_WARN
+	select ARCH_WANTS_RT_DELAYED_SIGNALS
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
 	select BUILDTIME_TABLE_SORT
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 75ba8aa..098e37f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1087,6 +1087,9 @@ struct task_struct {
 	/* Restored if set_restore_sigmask() was used: */
 	sigset_t			saved_sigmask;
 	struct sigpending		pending;
+#ifdef CONFIG_RT_DELAYED_SIGNALS
+	struct kernel_siginfo		forced_info;
+#endif
 	unsigned long			sas_ss_sp;
 	size_t				sas_ss_size;
 	unsigned int			sas_ss_flags;
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index ce77f02..5644abd 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -132,4 +132,14 @@ config SCHED_CORE
 	  which is the likely usage by Linux distributions, there should
 	  be no measurable impact on performance.
 
-
+config ARCH_WANTS_RT_DELAYED_SIGNALS
+	bool
+	help
+	  This option is selected by architectures where raising signals
+	  can happen in atomic contexts on PREEMPT_RT enabled kernels. This
+	  option delays raising the signal until the return to user space
+	  loop where it is also delivered. X86 requires this to deliver
+	  signals from trap handlers which run on IST stacks.
+
+config RT_DELAYED_SIGNALS
+	def_bool PREEMPT_RT && ARCH_WANTS_RT_DELAYED_SIGNALS
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index bad7136..0543a2c 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -148,6 +148,18 @@ static void handle_signal_work(struct pt_regs *regs, unsigned long ti_work)
 	arch_do_signal_or_restart(regs, ti_work & _TIF_SIGPENDING);
 }
 
+#ifdef CONFIG_RT_DELAYED_SIGNALS
+static inline void raise_delayed_signal(void)
+{
+	if (unlikely(current->forced_info.si_signo)) {
+		force_sig_info(&current->forced_info);
+		current->forced_info.si_signo = 0;
+	}
+}
+#else
+static inline void raise_delayed_signal(void) { }
+#endif
+
 static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 					    unsigned long ti_work)
 {
@@ -162,6 +174,8 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 		if (ti_work & _TIF_NEED_RESCHED)
 			schedule();
 
+		raise_delayed_signal();
+
 		if (ti_work & _TIF_UPROBE)
 			uprobe_notify_resume(regs);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 9b04631..e93de6d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1308,6 +1308,43 @@ enum sig_handler {
 };
 
 /*
+ * On some archictectures, PREEMPT_RT has to delay sending a signal from a
+ * trap since it cannot enable preemption, and the signal code's
+ * spin_locks turn into mutexes. Instead, it must set TIF_NOTIFY_RESUME
+ * which will send the signal on exit of the trap.
+ */
+#ifdef CONFIG_RT_DELAYED_SIGNALS
+static inline bool force_sig_delayed(struct kernel_siginfo *info,
+				     struct task_struct *t)
+{
+	if (!in_atomic())
+		return false;
+
+	if (WARN_ON_ONCE(t->forced_info.si_signo))
+		return true;
+
+	if (is_si_special(info)) {
+		WARN_ON_ONCE(info != SEND_SIG_PRIV);
+		t->forced_info.si_signo = info->si_signo;
+		t->forced_info.si_errno = 0;
+		t->forced_info.si_code = SI_KERNEL;
+		t->forced_info.si_pid = 0;
+		t->forced_info.si_uid = 0;
+	} else {
+		t->forced_info = *info;
+	}
+	set_tsk_thread_flag(t, TIF_NOTIFY_RESUME);
+	return true;
+}
+#else
+static inline bool force_sig_delayed(struct kernel_siginfo *info,
+				     struct task_struct *t)
+{
+	return false;
+}
+#endif
+
+/*
  * Force a signal that the process can't ignore: if necessary
  * we unblock the signal and change any SIG_IGN to SIG_DFL.
  *
@@ -1327,6 +1364,9 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
 	struct k_sigaction *action;
 	int sig = info->si_signo;
 
+	if (force_sig_delayed(info, t))
+		return 0;
+
 	spin_lock_irqsave(&t->sighand->siglock, flags);
 	action = &t->sighand->action[sig-1];
 	ignored = action->sa.sa_handler == SIG_IGN;
