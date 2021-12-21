Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7941647C3EC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239931AbhLUQgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbhLUQgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:36:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62884C061574;
        Tue, 21 Dec 2021 08:36:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F29D3B8173F;
        Tue, 21 Dec 2021 16:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78393C36AE8;
        Tue, 21 Dec 2021 16:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640104597;
        bh=SN9l8I8kfnKshmzHeKICf8D0lbRE5oOt9OcSP99i48k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQYohjpcxaBrc2Rxcyhx2KK1cJG2wS+ANrnLWDmV5AsN6SlxK1LeAbx+01Y4WDQfl
         75sYsWkgvGZtox6uXke30cGAP4DYZKVNUQ5DATb6k+vsf0eEm6o2VMH7/pr0vv779a
         YvJrsykE1kbwb9BH18hJRq8IkCNqnS1fxq5VjAoC9kQrXeKtncL3EfD6/G7RSvbWkg
         ONjtME5o8iG5ep/5WSK+/VGVzsXdMIdla2afZPd2HIE45qlJrTGyFa7tcfdQ43cADF
         vfvl8WVW2/g4Wda4S9vUW972V1CMqHXRFon5gJq+kDprD5PMQL0Ds30afGniP0pZO0
         qt/M9AZfB6i+A==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup.patel@wdc.com, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 12/13] riscv: compat: signal: Add rt_frame implementation
Date:   Wed, 22 Dec 2021 00:35:31 +0800
Message-Id: <20211221163532.2636028-13-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211221163532.2636028-1-guoren@kernel.org>
References: <20211221163532.2636028-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Implement compat_setup_rt_frame for sigcontext save & restore. The
main process is the same with signal, but the rv32 pt_regs' size
is different from rv64's, so we needs convert them.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/kernel/compat_signal.c | 225 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/signal.c        |  13 +-
 2 files changed, 237 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/compat_signal.c b/arch/riscv/kernel/compat_signal.c
index 1ad3d348f37c..7041742ded08 100644
--- a/arch/riscv/kernel/compat_signal.c
+++ b/arch/riscv/kernel/compat_signal.c
@@ -12,7 +12,232 @@
 #include <asm/switch_to.h>
 #include <asm/csr.h>
 
+#define COMPAT_DEBUG_SIG 0
+
+struct compat_sigcontext {
+	struct compat_user_regs_struct sc_regs;
+	union __riscv_fp_state sc_fpregs;
+};
+
+struct compat_ucontext {
+	compat_ulong_t		uc_flags;
+	struct compat_ucontext	*uc_link;
+	compat_stack_t		uc_stack;
+	sigset_t		uc_sigmask;
+	/* There's some padding here to allow sigset_t to be expanded in the
+	 * future.  Though this is unlikely, other architectures put uc_sigmask
+	 * at the end of this structure and explicitly state it can be
+	 * expanded, so we didn't want to box ourselves in here. */
+	__u8		  __unused[1024 / 8 - sizeof(sigset_t)];
+	/* We can't put uc_sigmask at the end of this structure because we need
+	 * to be able to expand sigcontext in the future.  For example, the
+	 * vector ISA extension will almost certainly add ISA state.  We want
+	 * to ensure all user-visible ISA state can be saved and restored via a
+	 * ucontext, so we're putting this at the end in order to allow for
+	 * infinite extensibility.  Since we know this will be extended and we
+	 * assume sigset_t won't be extended an extreme amount, we're
+	 * prioritizing this. */
+	struct compat_sigcontext uc_mcontext;
+};
+
+struct compat_rt_sigframe {
+	struct compat_siginfo info;
+	struct compat_ucontext uc;
+};
+
+#ifdef CONFIG_FPU
+static long compat_restore_fp_state(struct pt_regs *regs,
+	union __riscv_fp_state __user *sc_fpregs)
+{
+	long err;
+	struct __riscv_d_ext_state __user *state = &sc_fpregs->d;
+	size_t i;
+
+	err = __copy_from_user(&current->thread.fstate, state, sizeof(*state));
+	if (unlikely(err))
+		return err;
+
+	fstate_restore(current, regs);
+
+	/* We support no other extension state at this time. */
+	for (i = 0; i < ARRAY_SIZE(sc_fpregs->q.reserved); i++) {
+		u32 value;
+
+		err = __get_user(value, &sc_fpregs->q.reserved[i]);
+		if (unlikely(err))
+			break;
+		if (value != 0)
+			return -EINVAL;
+	}
+
+	return err;
+}
+
+static long compat_save_fp_state(struct pt_regs *regs,
+			  union __riscv_fp_state __user *sc_fpregs)
+{
+	long err;
+	struct __riscv_d_ext_state __user *state = &sc_fpregs->d;
+	size_t i;
+
+	fstate_save(current, regs);
+	err = __copy_to_user(state, &current->thread.fstate, sizeof(*state));
+	if (unlikely(err))
+		return err;
+
+	/* We support no other extension state at this time. */
+	for (i = 0; i < ARRAY_SIZE(sc_fpregs->q.reserved); i++) {
+		err = __put_user(0, &sc_fpregs->q.reserved[i]);
+		if (unlikely(err))
+			break;
+	}
+
+	return err;
+}
+#else
+#define compat_save_fp_state(task, regs) (0)
+#define compat_restore_fp_state(task, regs) (0)
+#endif
+
+static long compat_restore_sigcontext(struct pt_regs *regs,
+	struct compat_sigcontext __user *sc)
+{
+	long err;
+	struct compat_user_regs_struct cregs;
+
+	/* sc_regs is structured the same as the start of pt_regs */
+	err = __copy_from_user(&cregs, &sc->sc_regs, sizeof(sc->sc_regs));
+
+	cregs_to_regs(&cregs, regs);
+
+	/* Restore the floating-point state. */
+	if (has_fpu())
+		err |= compat_restore_fp_state(regs, &sc->sc_fpregs);
+	return err;
+}
+
 COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 {
+	struct pt_regs *regs = current_pt_regs();
+	struct compat_rt_sigframe __user *frame;
+	struct task_struct *task;
+	sigset_t set;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current->restart_block.fn = do_no_restart_syscall;
+
+	frame = (struct compat_rt_sigframe __user *)regs->sp;
+
+	if (!access_ok(frame, sizeof(*frame)))
+		goto badframe;
+
+	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
+		goto badframe;
+
+	set_current_blocked(&set);
+
+	if (compat_restore_sigcontext(regs, &frame->uc.uc_mcontext))
+		goto badframe;
+
+	if (compat_restore_altstack(&frame->uc.uc_stack))
+		goto badframe;
+
+	return regs->a0;
+
+badframe:
+	task = current;
+	if (show_unhandled_signals) {
+		pr_info_ratelimited(
+			"%s[%d]: bad frame in %s: frame=%p pc=%p sp=%p\n",
+			task->comm, task_pid_nr(task), __func__,
+			frame, (void *)regs->epc, (void *)regs->sp);
+	}
+	force_sig(SIGSEGV);
+	return 0;
+}
+
+static long compat_setup_sigcontext(struct compat_rt_sigframe __user *frame,
+	struct pt_regs *regs)
+{
+	struct compat_sigcontext __user *sc = &frame->uc.uc_mcontext;
+	struct compat_user_regs_struct cregs;
+	long err;
+
+	regs_to_cregs(&cregs, regs);
+
+	/* sc_regs is structured the same as the start of pt_regs */
+	err = __copy_to_user(&sc->sc_regs, &cregs, sizeof(sc->sc_regs));
+	/* Save the floating-point state. */
+	if (has_fpu())
+		err |= compat_save_fp_state(regs, &sc->sc_fpregs);
+	return err;
+}
+
+static inline void __user *compat_get_sigframe(struct ksignal *ksig,
+	struct pt_regs *regs, size_t framesize)
+{
+	unsigned long sp;
+	/* Default to using normal stack */
+	sp = regs->sp;
+
+	/*
+	 * If we are on the alternate signal stack and would overflow it, don't.
+	 * Return an always-bogus address instead so we will die with SIGSEGV.
+	 */
+	if (on_sig_stack(sp) && !likely(on_sig_stack(sp - framesize)))
+		return (void __user __force *)(-1UL);
+
+	/* This is the X/Open sanctioned signal stack switching. */
+	sp = sigsp(sp, ksig) - framesize;
+
+	/* Align the stack frame. */
+	sp &= ~0xfUL;
+
+	return (void __user *)sp;
+}
+
+int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
+	struct pt_regs *regs)
+{
+	struct compat_rt_sigframe __user *frame;
+	long err = 0;
+
+	frame = compat_get_sigframe(ksig, regs, sizeof(*frame));
+	if (!access_ok(frame, sizeof(*frame)))
+		return -EFAULT;
+
+	err |= copy_siginfo_to_user32(&frame->info, &ksig->info);
+
+	/* Create the ucontext. */
+	err |= __put_user(0, &frame->uc.uc_flags);
+	err |= __put_user(NULL, &frame->uc.uc_link);
+	err |= __compat_save_altstack(&frame->uc.uc_stack, regs->sp);
+	err |= compat_setup_sigcontext(frame, regs);
+	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
+	if (err)
+		return -EFAULT;
+
+	regs->ra = (unsigned long)COMPAT_VDSO_SYMBOL(
+			current->mm->context.vdso, rt_sigreturn);
+
+	/*
+	 * Set up registers for signal handler.
+	 * Registers that we don't modify keep the value they had from
+	 * user-space at the time we took the signal.
+	 * We always pass siginfo and mcontext, regardless of SA_SIGINFO,
+	 * since some things rely on this (e.g. glibc's debug/segfault.c).
+	 */
+	regs->epc = (unsigned long)ksig->ka.sa.sa_handler;
+	regs->sp = (unsigned long)frame;
+	regs->a0 = ksig->sig;                     /* a0: signal number */
+	regs->a1 = (unsigned long)(&frame->info); /* a1: siginfo pointer */
+	regs->a2 = (unsigned long)(&frame->uc);   /* a2: ucontext pointer */
+
+#if COMPAT_DEBUG_SIG
+	pr_info("SIG deliver (%s:%d): sig=%d pc=%p ra=%p sp=%p\n",
+		current->comm, task_pid_nr(current), ksig->sig,
+		(void *)regs->epc, (void *)regs->ra, frame);
+#endif
+
 	return 0;
 }
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index c2d5ecbe5526..27d8f39228c4 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2012 Regents of the University of California
  */
 
+#include <linux/compat.h>
 #include <linux/signal.h>
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
@@ -229,6 +230,11 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	return 0;
 }
 
+#ifdef CONFIG_COMPAT
+extern int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
+				 struct pt_regs *regs);
+#endif
+
 static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
 	sigset_t *oldset = sigmask_to_save();
@@ -258,8 +264,13 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 		}
 	}
 
+#ifdef CONFIG_COMPAT
 	/* Set up the stack frame */
-	ret = setup_rt_frame(ksig, oldset, regs);
+	if (is_compat_task())
+		ret = compat_setup_rt_frame(ksig, oldset, regs);
+	else
+#endif
+		ret = setup_rt_frame(ksig, oldset, regs);
 
 	signal_setup_done(ret, ksig, 0);
 }
-- 
2.25.1

