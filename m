Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405D54F0873
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 10:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiDCIqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 04:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiDCIqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 04:46:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D260B35DCB
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 01:44:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648975453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BoH3D6x4fdB+6PJEpYbI/PLunjUWPVq6vfqIeo9ZBnA=;
        b=k3GevJcebIGpuFmhUxKyS99VywNuKFtp+QuFG3kmZfK/BBVAMEF58XhQUHafSFLYzyZ9OC
        OgV4ziEizWWWPniSZPvMIRub34g8hjicp+bOySRgDFetN81wBSLkc+EstqzQvyWa5s7Ayy
        ewihKfa4vHZEidY3TcEIjJljAq9JqCxiSJjh8aXdE9ckc+MjG/2DsKKj995ENcle2w3DPp
        ehB9RMJDzCmbjW81cjlTJUyibYSYzLDDeIiHgzsGu51GQyofXdyhaDK1HUDHGf0fvX8tn0
        /p7syDs+iZeepT/JabI6TOqKYtudif2i4vgSePy8SLL6h6/0gVT1EUtP7OUq7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648975453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BoH3D6x4fdB+6PJEpYbI/PLunjUWPVq6vfqIeo9ZBnA=;
        b=xgbSOu/+8wQi1MSzXVCZ1s43OVI0gkU1GrTLlKptDDrLj1d7i7ggzZa4JWM9hNuwu6CpaR
        EgxsY6X+aRhpN/Bw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/urgent for v5.18-rc1
Message-ID: <164897466883.360450.8070511660014503126.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun,  3 Apr 2022 10:44:12 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2022=
-04-03

up to:  7dd5ad2d3e82: Revert "signal, x86: Delay calling signals in atomic on=
 RT enabled kernels"


Revert the RT related signal changes. They need to be reworked and
generalized.

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      Revert "signal, x86: Delay calling signals in atomic on RT enabled kern=
els"


 arch/x86/Kconfig       |  1 -
 include/linux/sched.h  |  3 ---
 kernel/Kconfig.preempt | 12 +-----------
 kernel/entry/common.c  | 14 --------------
 kernel/signal.c        | 40 ----------------------------------------
 5 files changed, 1 insertion(+), 69 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7340d9f01b62..442a426e8a68 100644
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
index 4a6fdd2a679f..d5e3c00b74e1 100644
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
index 8c6de5a9ecc4..c2f1fd95a821 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -133,14 +133,4 @@ config SCHED_CORE
 	  which is the likely usage by Linux distributions, there should
 	  be no measurable impact on performance.
=20
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
index ef8d94a98b7e..e57a224d6b79 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -142,18 +142,6 @@ void noinstr exit_to_user_mode(void)
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
=20
-#ifdef CONFIG_RT_DELAYED_SIGNALS
-static inline void raise_delayed_signal(void)
-{
-	if (unlikely(current->forced_info.si_signo)) {
-		force_sig_info(&current->forced_info);
-		current->forced_info.si_signo =3D 0;
-	}
-}
-#else
-static inline void raise_delayed_signal(void) { }
-#endif
-
 static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 					    unsigned long ti_work)
 {
@@ -168,8 +156,6 @@ static unsigned long exit_to_user_mode_loop(struct pt_reg=
s *regs,
 		if (ti_work & _TIF_NEED_RESCHED)
 			schedule();
=20
-		raise_delayed_signal();
-
 		if (ti_work & _TIF_UPROBE)
 			uprobe_notify_resume(regs);
=20
diff --git a/kernel/signal.c b/kernel/signal.c
index 368a34c25bbf..30cd1ca43bcd 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1307,43 +1307,6 @@ enum sig_handler {
 	HANDLER_EXIT,	 /* Only visible as the process exit code */
 };
=20
-/*
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
-		WARN_ON_ONCE(info !=3D SEND_SIG_PRIV);
-		t->forced_info.si_signo =3D info->si_signo;
-		t->forced_info.si_errno =3D 0;
-		t->forced_info.si_code =3D SI_KERNEL;
-		t->forced_info.si_pid =3D 0;
-		t->forced_info.si_uid =3D 0;
-	} else {
-		t->forced_info =3D *info;
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
 /*
  * Force a signal that the process can't ignore: if necessary
  * we unblock the signal and change any SIG_IGN to SIG_DFL.
@@ -1364,9 +1327,6 @@ force_sig_info_to_task(struct kernel_siginfo *info, str=
uct task_struct *t,
 	struct k_sigaction *action;
 	int sig =3D info->si_signo;
=20
-	if (force_sig_delayed(info, t))
-		return 0;
-
 	spin_lock_irqsave(&t->sighand->siglock, flags);
 	action =3D &t->sighand->action[sig-1];
 	ignored =3D action->sa.sa_handler =3D=3D SIG_IGN;

