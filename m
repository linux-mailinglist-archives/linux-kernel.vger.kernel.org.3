Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEFC53F063
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbiFFUnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbiFFUmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:42:51 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3955EC31C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:38:57 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id e13-20020a4a884d000000b004154e612440so3010349ooi.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sKYToXk2NDc2jt1jMBno/tluKiVDdIv48HFtD+x8bb8=;
        b=HlEdGiS7qsT7DYF1JCL+GSdItgNvhNvjZbPZOrutrcimLZZ/lr3D/KnaDAcq16LRty
         Dkj73OPhpUnA8l7Uw1sT2NWg/VQpFpn9AdEdQ9tHMjLrbdAaHiSeumbrJLkPhdbLJrZx
         nYiqBZ3N55FrxdjqBYFLZm8gVrmRM/YydpiFxNH/Tcv+MPZgmAR2owMvUgqdQaTC5zm5
         P1emcMMiBh7AX7xiZEgZyMgdc7sQvbHQDopmGJLm4Ta3RDk6/68U+RN8T8mQZqFEzfa5
         5BAz428E2oUod875w9R8DGzsI2P0sN97cpkzokCPblqFXNdjgKSRy4jMcB9g8u43taMU
         uusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sKYToXk2NDc2jt1jMBno/tluKiVDdIv48HFtD+x8bb8=;
        b=eGdYRkIyn5FWg1PBv0Nmcrpsijkc45/RfnaWLGJBKmcQelQYaWgfpL2jP/sWJxMw92
         JwKn30XGrmREIav4Np0laCkaQ+xpP5NTWMggia7n6+EVn7KeZ+5fW2ZdLW9/+t7J6Ejk
         Nf91nbkwCkhmJibzZmFX+pHW/TS4e2jKYtZmKKKNNcH1UDHoTv5II05ElDDxD1S0PwxG
         PCEdAFAdToYK32IFWxnG17aMx3RG7ZluQvYTJMKRE+LnOrwoavHG6m4LX0bpEihZ/Qp/
         yWnznB4Sw9tai33ixr3+hnBAM+9x0qLRY8qIxdWBIwxLv6uJ1htxys1r9luRY8Gynd8x
         mW5A==
X-Gm-Message-State: AOAM5339KuaqjIZ99ZKnLDOOwhrGcGyFMOZ2d4hUpX6OXgPCF6EVN6k+
        XhNWLh13wEI1OWw07+jx1AyavfaQAQ==
X-Google-Smtp-Source: ABdhPJzGj9fZmYfoCniYhFjh4gtRS6U1WF86DztSKj85OSsbeDqW1sbKGaBQ5earSKCoV81HvasE4A==
X-Received: by 2002:a4a:942b:0:b0:33a:39e0:b908 with SMTP id h40-20020a4a942b000000b0033a39e0b908mr10879321ooi.62.1654547936263;
        Mon, 06 Jun 2022 13:38:56 -0700 (PDT)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id j22-20020a056808035600b0032e3cca8561sm4327188oie.21.2022.06.06.13.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:38:55 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 8/8] x86/signal/64: Move 64-bit signal code to its own file
Date:   Mon,  6 Jun 2022 16:38:02 -0400
Message-Id: <20220606203802.158958-9-brgerst@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220606203802.158958-1-brgerst@gmail.com>
References: <20220606203802.158958-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/kernel/Makefile    |   4 +-
 arch/x86/kernel/signal.c    | 376 -----------------------------------
 arch/x86/kernel/signal_64.c | 383 ++++++++++++++++++++++++++++++++++++
 3 files changed, 385 insertions(+), 378 deletions(-)
 create mode 100644 arch/x86/kernel/signal_64.c

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 4aa1bd55a362..a1bb527a02f5 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -48,7 +48,7 @@ KCOV_INSTRUMENT		:= n
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
-obj-y			:= process_$(BITS).o signal.o
+obj-y			:= process_$(BITS).o signal.o signal_$(BITS).o
 obj-$(CONFIG_COMPAT)	+= signal_compat.o
 obj-y			+= traps.o idt.o irq.o irq_$(BITS).o dumpstack_$(BITS).o
 obj-y			+= time.o ioport.o dumpstack.o nmi.o
@@ -57,7 +57,7 @@ obj-y			+= setup.o x86_init.o i8259.o irqinit.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 obj-$(CONFIG_IRQ_WORK)  += irq_work.o
 obj-y			+= probe_roms.o
-obj-$(CONFIG_X86_32)	+= sys_ia32.o signal_32.o
+obj-$(CONFIG_X86_32)	+= sys_ia32.o
 obj-$(CONFIG_IA32_EMULATION)	+= sys_ia32.o signal_32.o
 obj-$(CONFIG_X86_64)	+= sys_x86_64.o
 obj-$(CONFIG_X86_ESPFIX64)	+= espfix_64.o
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 962cfd835c90..1504eb8d25aa 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -37,13 +37,6 @@
 #include <asm/sighandling.h>
 #include <asm/vm86.h>
 
-#ifdef CONFIG_X86_64
-#include <linux/compat.h>
-#include <asm/proto.h>
-#include <asm/ia32_unistd.h>
-#include <asm/fpu/xstate.h>
-#endif /* CONFIG_X86_64 */
-
 #include <asm/syscall.h>
 #include <asm/sigframe.h>
 #include <asm/signal.h>
@@ -65,135 +58,6 @@ static inline int is_x32_frame(struct ksignal *ksig)
 		ksig->ka.sa.sa_flags & SA_X32_ABI;
 }
 
-#ifdef CONFIG_X86_64
-/*
- * If regs->ss will cause an IRET fault, change it.  Otherwise leave it
- * alone.  Using this generally makes no sense unless
- * user_64bit_mode(regs) would return true.
- */
-static void force_valid_ss(struct pt_regs *regs)
-{
-	u32 ar;
-	asm volatile ("lar %[old_ss], %[ar]\n\t"
-		      "jz 1f\n\t"		/* If invalid: */
-		      "xorl %[ar], %[ar]\n\t"	/* set ar = 0 */
-		      "1:"
-		      : [ar] "=r" (ar)
-		      : [old_ss] "rm" ((u16)regs->ss));
-
-	/*
-	 * For a valid 64-bit user context, we need DPL 3, type
-	 * read-write data or read-write exp-down data, and S and P
-	 * set.  We can't use VERW because VERW doesn't check the
-	 * P bit.
-	 */
-	ar &= AR_DPL_MASK | AR_S | AR_P | AR_TYPE_MASK;
-	if (ar != (AR_DPL3 | AR_S | AR_P | AR_TYPE_RWDATA) &&
-	    ar != (AR_DPL3 | AR_S | AR_P | AR_TYPE_RWDATA_EXPDOWN))
-		regs->ss = __USER_DS;
-}
-
-static bool restore_sigcontext(struct pt_regs *regs,
-			       struct sigcontext __user *usc,
-			       unsigned long uc_flags)
-{
-	struct sigcontext sc;
-
-	/* Always make any pending restarted system calls return -EINTR */
-	current->restart_block.fn = do_no_restart_syscall;
-
-	if (copy_from_user(&sc, usc, offsetof(struct sigcontext, reserved1)))
-		return false;
-
-	regs->bx = sc.bx;
-	regs->cx = sc.cx;
-	regs->dx = sc.dx;
-	regs->si = sc.si;
-	regs->di = sc.di;
-	regs->bp = sc.bp;
-	regs->ax = sc.ax;
-	regs->sp = sc.sp;
-	regs->ip = sc.ip;
-	regs->r8 = sc.r8;
-	regs->r9 = sc.r9;
-	regs->r10 = sc.r10;
-	regs->r11 = sc.r11;
-	regs->r12 = sc.r12;
-	regs->r13 = sc.r13;
-	regs->r14 = sc.r14;
-	regs->r15 = sc.r15;
-
-	/* Get CS/SS and force CPL3 */
-	regs->cs = sc.cs | 0x03;
-	regs->ss = sc.ss | 0x03;
-
-	regs->flags = (regs->flags & ~FIX_EFLAGS) | (sc.flags & FIX_EFLAGS);
-	/* disable syscall checks */
-	regs->orig_ax = -1;
-
-	/*
-	 * Fix up SS if needed for the benefit of old DOSEMU and
-	 * CRIU.
-	 */
-	if (unlikely(!(uc_flags & UC_STRICT_RESTORE_SS) && user_64bit_mode(regs)))
-		force_valid_ss(regs);
-
-	return fpu__restore_sig((void __user *)sc.fpstate, 0);
-}
-
-static __always_inline int
-__unsafe_setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
-		     struct pt_regs *regs, unsigned long mask)
-{
-	unsafe_put_user(regs->di, &sc->di, Efault);
-	unsafe_put_user(regs->si, &sc->si, Efault);
-	unsafe_put_user(regs->bp, &sc->bp, Efault);
-	unsafe_put_user(regs->sp, &sc->sp, Efault);
-	unsafe_put_user(regs->bx, &sc->bx, Efault);
-	unsafe_put_user(regs->dx, &sc->dx, Efault);
-	unsafe_put_user(regs->cx, &sc->cx, Efault);
-	unsafe_put_user(regs->ax, &sc->ax, Efault);
-	unsafe_put_user(regs->r8, &sc->r8, Efault);
-	unsafe_put_user(regs->r9, &sc->r9, Efault);
-	unsafe_put_user(regs->r10, &sc->r10, Efault);
-	unsafe_put_user(regs->r11, &sc->r11, Efault);
-	unsafe_put_user(regs->r12, &sc->r12, Efault);
-	unsafe_put_user(regs->r13, &sc->r13, Efault);
-	unsafe_put_user(regs->r14, &sc->r14, Efault);
-	unsafe_put_user(regs->r15, &sc->r15, Efault);
-
-	unsafe_put_user(current->thread.trap_nr, &sc->trapno, Efault);
-	unsafe_put_user(current->thread.error_code, &sc->err, Efault);
-	unsafe_put_user(regs->ip, &sc->ip, Efault);
-	unsafe_put_user(regs->flags, &sc->flags, Efault);
-	unsafe_put_user(regs->cs, &sc->cs, Efault);
-	unsafe_put_user(0, &sc->gs, Efault);
-	unsafe_put_user(0, &sc->fs, Efault);
-	unsafe_put_user(regs->ss, &sc->ss, Efault);
-
-	unsafe_put_user(fpstate, (unsigned long __user *)&sc->fpstate, Efault);
-
-	/* non-iBCS2 extensions.. */
-	unsafe_put_user(mask, &sc->oldmask, Efault);
-	unsafe_put_user(current->thread.cr2, &sc->cr2, Efault);
-	return 0;
-Efault:
-	return -EFAULT;
-}
-
-#define unsafe_put_sigcontext(sc, fp, regs, set, label)			\
-do {									\
-	if (__unsafe_setup_sigcontext(sc, fp, regs, set->sig[0]))	\
-		goto label;						\
-} while(0);
-
-#define unsafe_put_sigmask(set, frame, label) \
-	unsafe_put_user(*(__u64 *)(set), \
-			(__u64 __user *)&(frame)->uc.uc_sigmask, \
-			label)
-
-#endif /* CONFIG_X86_64 */
-
 /*
  * Set up a signal frame.
  */
@@ -279,213 +143,6 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 	return (void __user *)sp;
 }
 
-#ifdef CONFIG_X86_64
-static unsigned long frame_uc_flags(struct pt_regs *regs)
-{
-	unsigned long flags;
-
-	if (boot_cpu_has(X86_FEATURE_XSAVE))
-		flags = UC_FP_XSTATE | UC_SIGCONTEXT_SS;
-	else
-		flags = UC_SIGCONTEXT_SS;
-
-	if (likely(user_64bit_mode(regs)))
-		flags |= UC_STRICT_RESTORE_SS;
-
-	return flags;
-}
-
-int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
-{
-	sigset_t *set = sigmask_to_save();
-	struct rt_sigframe __user *frame;
-	void __user *fp = NULL;
-	unsigned long uc_flags;
-
-	/* x86-64 should always use SA_RESTORER. */
-	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
-		return -EFAULT;
-
-	frame = get_sigframe(ksig, regs, sizeof(struct rt_sigframe), &fp);
-	uc_flags = frame_uc_flags(regs);
-
-	if (!user_access_begin(frame, sizeof(*frame)))
-		return -EFAULT;
-
-	/* Create the ucontext.  */
-	unsafe_put_user(uc_flags, &frame->uc.uc_flags, Efault);
-	unsafe_put_user(0, &frame->uc.uc_link, Efault);
-	unsafe_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
-
-	/* Set up to return from userspace.  If provided, use a stub
-	   already in userspace.  */
-	unsafe_put_user(ksig->ka.sa.sa_restorer, &frame->pretcode, Efault);
-	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
-	unsafe_put_sigmask(set, frame, Efault);
-	user_access_end();
-
-	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
-		if (copy_siginfo_to_user(&frame->info, &ksig->info))
-			return -EFAULT;
-	}
-
-	/* Set up registers for signal handler */
-	regs->di = ksig->sig;
-	/* In case the signal handler was declared without prototypes */
-	regs->ax = 0;
-
-	/* This also works for non SA_SIGINFO handlers because they expect the
-	   next argument after the signal number on the stack. */
-	regs->si = (unsigned long)&frame->info;
-	regs->dx = (unsigned long)&frame->uc;
-	regs->ip = (unsigned long) ksig->ka.sa.sa_handler;
-
-	regs->sp = (unsigned long)frame;
-
-	/*
-	 * Set up the CS and SS registers to run signal handlers in
-	 * 64-bit mode, even if the handler happens to be interrupting
-	 * 32-bit or 16-bit code.
-	 *
-	 * SS is subtle.  In 64-bit mode, we don't need any particular
-	 * SS descriptor, but we do need SS to be valid.  It's possible
-	 * that the old SS is entirely bogus -- this can happen if the
-	 * signal we're trying to deliver is #GP or #SS caused by a bad
-	 * SS value.  We also have a compatibility issue here: DOSEMU
-	 * relies on the contents of the SS register indicating the
-	 * SS value at the time of the signal, even though that code in
-	 * DOSEMU predates sigreturn's ability to restore SS.  (DOSEMU
-	 * avoids relying on sigreturn to restore SS; instead it uses
-	 * a trampoline.)  So we do our best: if the old SS was valid,
-	 * we keep it.  Otherwise we replace it.
-	 */
-	regs->cs = __USER_CS;
-
-	if (unlikely(regs->ss != __USER_DS))
-		force_valid_ss(regs);
-
-	return 0;
-
-Efault:
-	user_access_end();
-	return -EFAULT;
-}
-
-#ifdef CONFIG_X86_X32_ABI
-static int x32_copy_siginfo_to_user(struct compat_siginfo __user *to,
-		const struct kernel_siginfo *from)
-{
-	struct compat_siginfo new;
-
-	copy_siginfo_to_external32(&new, from);
-	if (from->si_signo == SIGCHLD) {
-		new._sifields._sigchld_x32._utime = from->si_utime;
-		new._sifields._sigchld_x32._stime = from->si_stime;
-	}
-	if (copy_to_user(to, &new, sizeof(struct compat_siginfo)))
-		return -EFAULT;
-	return 0;
-}
-
-int copy_siginfo_to_user32(struct compat_siginfo __user *to,
-			   const struct kernel_siginfo *from)
-{
-	if (in_x32_syscall())
-		return x32_copy_siginfo_to_user(to, from);
-	return __copy_siginfo_to_user32(to, from);
-}
-
-int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
-{
-	compat_sigset_t *set = (compat_sigset_t *) sigmask_to_save();
-	struct rt_sigframe_x32 __user *frame;
-	unsigned long uc_flags;
-	void __user *restorer;
-	void __user *fp = NULL;
-
-	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
-		return -EFAULT;
-
-	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
-
-	uc_flags = frame_uc_flags(regs);
-
-	if (!user_access_begin(frame, sizeof(*frame)))
-		return -EFAULT;
-
-	/* Create the ucontext.  */
-	unsafe_put_user(uc_flags, &frame->uc.uc_flags, Efault);
-	unsafe_put_user(0, &frame->uc.uc_link, Efault);
-	unsafe_compat_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
-	unsafe_put_user(0, &frame->uc.uc__pad0, Efault);
-	restorer = ksig->ka.sa.sa_restorer;
-	unsafe_put_user(restorer, (unsigned long __user *)&frame->pretcode, Efault);
-	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
-	unsafe_put_sigmask(set, frame, Efault);
-	user_access_end();
-
-	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
-		if (x32_copy_siginfo_to_user(&frame->info, &ksig->info))
-			return -EFAULT;
-	}
-
-	/* Set up registers for signal handler */
-	regs->sp = (unsigned long) frame;
-	regs->ip = (unsigned long) ksig->ka.sa.sa_handler;
-
-	/* We use the x32 calling convention here... */
-	regs->di = ksig->sig;
-	regs->si = (unsigned long) &frame->info;
-	regs->dx = (unsigned long) &frame->uc;
-
-	loadsegment(ds, __USER_DS);
-	loadsegment(es, __USER_DS);
-
-	regs->cs = __USER_CS;
-	regs->ss = __USER_DS;
-
-	return 0;
-
-Efault:
-	user_access_end();
-	return -EFAULT;
-}
-#endif /* CONFIG_X86_X32_ABI */
-
-/*
- * Do a signal return; undo the signal stack.
- */
-SYSCALL_DEFINE0(rt_sigreturn)
-{
-	struct pt_regs *regs = current_pt_regs();
-	struct rt_sigframe __user *frame;
-	sigset_t set;
-	unsigned long uc_flags;
-
-	frame = (struct rt_sigframe __user *)(regs->sp - sizeof(long));
-	if (!access_ok(frame, sizeof(*frame)))
-		goto badframe;
-	if (__get_user(*(__u64 *)&set, (__u64 __user *)&frame->uc.uc_sigmask))
-		goto badframe;
-	if (__get_user(uc_flags, &frame->uc.uc_flags))
-		goto badframe;
-
-	set_current_blocked(&set);
-
-	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
-		goto badframe;
-
-	if (restore_altstack(&frame->uc.uc_stack))
-		goto badframe;
-
-	return regs->ax;
-
-badframe:
-	signal_fault(regs, frame, "rt_sigreturn");
-	return 0;
-}
-#endif /* CONFIG_X86_64 */
-
 /*
  * There are four different struct types for signal frame: sigframe_ia32,
  * rt_sigframe_ia32, rt_sigframe_x32, and rt_sigframe. Use the worst case
@@ -749,36 +406,3 @@ bool sigaltstack_size_valid(size_t ss_size)
 	return true;
 }
 #endif /* CONFIG_DYNAMIC_SIGFRAME */
-
-#ifdef CONFIG_X86_X32_ABI
-COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
-{
-	struct pt_regs *regs = current_pt_regs();
-	struct rt_sigframe_x32 __user *frame;
-	sigset_t set;
-	unsigned long uc_flags;
-
-	frame = (struct rt_sigframe_x32 __user *)(regs->sp - 8);
-
-	if (!access_ok(frame, sizeof(*frame)))
-		goto badframe;
-	if (__get_user(set.sig[0], (__u64 __user *)&frame->uc.uc_sigmask))
-		goto badframe;
-	if (__get_user(uc_flags, &frame->uc.uc_flags))
-		goto badframe;
-
-	set_current_blocked(&set);
-
-	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
-		goto badframe;
-
-	if (compat_restore_altstack(&frame->uc.uc_stack))
-		goto badframe;
-
-	return regs->ax;
-
-badframe:
-	signal_fault(regs, frame, "x32 rt_sigreturn");
-	return 0;
-}
-#endif
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
new file mode 100644
index 000000000000..ff9c55064223
--- /dev/null
+++ b/arch/x86/kernel/signal_64.c
@@ -0,0 +1,383 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ *  Copyright (C) 2000, 2001, 2002 Andi Kleen SuSE Labs
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/unistd.h>
+#include <linux/uaccess.h>
+#include <linux/syscalls.h>
+
+#include <asm/ucontext.h>
+#include <asm/fpu/signal.h>
+#include <asm/sighandling.h>
+
+#include <asm/syscall.h>
+#include <asm/sigframe.h>
+#include <asm/signal.h>
+
+/*
+ * If regs->ss will cause an IRET fault, change it.  Otherwise leave it
+ * alone.  Using this generally makes no sense unless
+ * user_64bit_mode(regs) would return true.
+ */
+static void force_valid_ss(struct pt_regs *regs)
+{
+	u32 ar;
+	asm volatile ("lar %[old_ss], %[ar]\n\t"
+		      "jz 1f\n\t"		/* If invalid: */
+		      "xorl %[ar], %[ar]\n\t"	/* set ar = 0 */
+		      "1:"
+		      : [ar] "=r" (ar)
+		      : [old_ss] "rm" ((u16)regs->ss));
+
+	/*
+	 * For a valid 64-bit user context, we need DPL 3, type
+	 * read-write data or read-write exp-down data, and S and P
+	 * set.  We can't use VERW because VERW doesn't check the
+	 * P bit.
+	 */
+	ar &= AR_DPL_MASK | AR_S | AR_P | AR_TYPE_MASK;
+	if (ar != (AR_DPL3 | AR_S | AR_P | AR_TYPE_RWDATA) &&
+	    ar != (AR_DPL3 | AR_S | AR_P | AR_TYPE_RWDATA_EXPDOWN))
+		regs->ss = __USER_DS;
+}
+
+static bool restore_sigcontext(struct pt_regs *regs,
+			       struct sigcontext __user *usc,
+			       unsigned long uc_flags)
+{
+	struct sigcontext sc;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current->restart_block.fn = do_no_restart_syscall;
+
+	if (copy_from_user(&sc, usc, offsetof(struct sigcontext, reserved1)))
+		return false;
+
+	regs->bx = sc.bx;
+	regs->cx = sc.cx;
+	regs->dx = sc.dx;
+	regs->si = sc.si;
+	regs->di = sc.di;
+	regs->bp = sc.bp;
+	regs->ax = sc.ax;
+	regs->sp = sc.sp;
+	regs->ip = sc.ip;
+	regs->r8 = sc.r8;
+	regs->r9 = sc.r9;
+	regs->r10 = sc.r10;
+	regs->r11 = sc.r11;
+	regs->r12 = sc.r12;
+	regs->r13 = sc.r13;
+	regs->r14 = sc.r14;
+	regs->r15 = sc.r15;
+
+	/* Get CS/SS and force CPL3 */
+	regs->cs = sc.cs | 0x03;
+	regs->ss = sc.ss | 0x03;
+
+	regs->flags = (regs->flags & ~FIX_EFLAGS) | (sc.flags & FIX_EFLAGS);
+	/* disable syscall checks */
+	regs->orig_ax = -1;
+
+	/*
+	 * Fix up SS if needed for the benefit of old DOSEMU and
+	 * CRIU.
+	 */
+	if (unlikely(!(uc_flags & UC_STRICT_RESTORE_SS) && user_64bit_mode(regs)))
+		force_valid_ss(regs);
+
+	return fpu__restore_sig((void __user *)sc.fpstate, 0);
+}
+
+static __always_inline int
+__unsafe_setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
+		     struct pt_regs *regs, unsigned long mask)
+{
+	unsafe_put_user(regs->di, &sc->di, Efault);
+	unsafe_put_user(regs->si, &sc->si, Efault);
+	unsafe_put_user(regs->bp, &sc->bp, Efault);
+	unsafe_put_user(regs->sp, &sc->sp, Efault);
+	unsafe_put_user(regs->bx, &sc->bx, Efault);
+	unsafe_put_user(regs->dx, &sc->dx, Efault);
+	unsafe_put_user(regs->cx, &sc->cx, Efault);
+	unsafe_put_user(regs->ax, &sc->ax, Efault);
+	unsafe_put_user(regs->r8, &sc->r8, Efault);
+	unsafe_put_user(regs->r9, &sc->r9, Efault);
+	unsafe_put_user(regs->r10, &sc->r10, Efault);
+	unsafe_put_user(regs->r11, &sc->r11, Efault);
+	unsafe_put_user(regs->r12, &sc->r12, Efault);
+	unsafe_put_user(regs->r13, &sc->r13, Efault);
+	unsafe_put_user(regs->r14, &sc->r14, Efault);
+	unsafe_put_user(regs->r15, &sc->r15, Efault);
+
+	unsafe_put_user(current->thread.trap_nr, &sc->trapno, Efault);
+	unsafe_put_user(current->thread.error_code, &sc->err, Efault);
+	unsafe_put_user(regs->ip, &sc->ip, Efault);
+	unsafe_put_user(regs->flags, &sc->flags, Efault);
+	unsafe_put_user(regs->cs, &sc->cs, Efault);
+	unsafe_put_user(0, &sc->gs, Efault);
+	unsafe_put_user(0, &sc->fs, Efault);
+	unsafe_put_user(regs->ss, &sc->ss, Efault);
+
+	unsafe_put_user(fpstate, (unsigned long __user *)&sc->fpstate, Efault);
+
+	/* non-iBCS2 extensions.. */
+	unsafe_put_user(mask, &sc->oldmask, Efault);
+	unsafe_put_user(current->thread.cr2, &sc->cr2, Efault);
+	return 0;
+Efault:
+	return -EFAULT;
+}
+
+#define unsafe_put_sigcontext(sc, fp, regs, set, label)			\
+do {									\
+	if (__unsafe_setup_sigcontext(sc, fp, regs, set->sig[0]))	\
+		goto label;						\
+} while(0);
+
+#define unsafe_put_sigmask(set, frame, label) \
+	unsafe_put_user(*(__u64 *)(set), \
+			(__u64 __user *)&(frame)->uc.uc_sigmask, \
+			label)
+
+static unsigned long frame_uc_flags(struct pt_regs *regs)
+{
+	unsigned long flags;
+
+	if (boot_cpu_has(X86_FEATURE_XSAVE))
+		flags = UC_FP_XSTATE | UC_SIGCONTEXT_SS;
+	else
+		flags = UC_SIGCONTEXT_SS;
+
+	if (likely(user_64bit_mode(regs)))
+		flags |= UC_STRICT_RESTORE_SS;
+
+	return flags;
+}
+
+int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+{
+	sigset_t *set = sigmask_to_save();
+	struct rt_sigframe __user *frame;
+	void __user *fp = NULL;
+	unsigned long uc_flags;
+
+	/* x86-64 should always use SA_RESTORER. */
+	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
+		return -EFAULT;
+
+	frame = get_sigframe(ksig, regs, sizeof(struct rt_sigframe), &fp);
+	uc_flags = frame_uc_flags(regs);
+
+	if (!user_access_begin(frame, sizeof(*frame)))
+		return -EFAULT;
+
+	/* Create the ucontext.  */
+	unsafe_put_user(uc_flags, &frame->uc.uc_flags, Efault);
+	unsafe_put_user(0, &frame->uc.uc_link, Efault);
+	unsafe_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
+
+	/* Set up to return from userspace.  If provided, use a stub
+	   already in userspace.  */
+	unsafe_put_user(ksig->ka.sa.sa_restorer, &frame->pretcode, Efault);
+	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
+	unsafe_put_sigmask(set, frame, Efault);
+	user_access_end();
+
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
+		if (copy_siginfo_to_user(&frame->info, &ksig->info))
+			return -EFAULT;
+	}
+
+	/* Set up registers for signal handler */
+	regs->di = ksig->sig;
+	/* In case the signal handler was declared without prototypes */
+	regs->ax = 0;
+
+	/* This also works for non SA_SIGINFO handlers because they expect the
+	   next argument after the signal number on the stack. */
+	regs->si = (unsigned long)&frame->info;
+	regs->dx = (unsigned long)&frame->uc;
+	regs->ip = (unsigned long) ksig->ka.sa.sa_handler;
+
+	regs->sp = (unsigned long)frame;
+
+	/*
+	 * Set up the CS and SS registers to run signal handlers in
+	 * 64-bit mode, even if the handler happens to be interrupting
+	 * 32-bit or 16-bit code.
+	 *
+	 * SS is subtle.  In 64-bit mode, we don't need any particular
+	 * SS descriptor, but we do need SS to be valid.  It's possible
+	 * that the old SS is entirely bogus -- this can happen if the
+	 * signal we're trying to deliver is #GP or #SS caused by a bad
+	 * SS value.  We also have a compatibility issue here: DOSEMU
+	 * relies on the contents of the SS register indicating the
+	 * SS value at the time of the signal, even though that code in
+	 * DOSEMU predates sigreturn's ability to restore SS.  (DOSEMU
+	 * avoids relying on sigreturn to restore SS; instead it uses
+	 * a trampoline.)  So we do our best: if the old SS was valid,
+	 * we keep it.  Otherwise we replace it.
+	 */
+	regs->cs = __USER_CS;
+
+	if (unlikely(regs->ss != __USER_DS))
+		force_valid_ss(regs);
+
+	return 0;
+
+Efault:
+	user_access_end();
+	return -EFAULT;
+}
+
+/*
+ * Do a signal return; undo the signal stack.
+ */
+SYSCALL_DEFINE0(rt_sigreturn)
+{
+	struct pt_regs *regs = current_pt_regs();
+	struct rt_sigframe __user *frame;
+	sigset_t set;
+	unsigned long uc_flags;
+
+	frame = (struct rt_sigframe __user *)(regs->sp - sizeof(long));
+	if (!access_ok(frame, sizeof(*frame)))
+		goto badframe;
+	if (__get_user(*(__u64 *)&set, (__u64 __user *)&frame->uc.uc_sigmask))
+		goto badframe;
+	if (__get_user(uc_flags, &frame->uc.uc_flags))
+		goto badframe;
+
+	set_current_blocked(&set);
+
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+		goto badframe;
+
+	if (restore_altstack(&frame->uc.uc_stack))
+		goto badframe;
+
+	return regs->ax;
+
+badframe:
+	signal_fault(regs, frame, "rt_sigreturn");
+	return 0;
+}
+
+#ifdef CONFIG_X86_X32_ABI
+static int x32_copy_siginfo_to_user(struct compat_siginfo __user *to,
+		const struct kernel_siginfo *from)
+{
+	struct compat_siginfo new;
+
+	copy_siginfo_to_external32(&new, from);
+	if (from->si_signo == SIGCHLD) {
+		new._sifields._sigchld_x32._utime = from->si_utime;
+		new._sifields._sigchld_x32._stime = from->si_stime;
+	}
+	if (copy_to_user(to, &new, sizeof(struct compat_siginfo)))
+		return -EFAULT;
+	return 0;
+}
+
+int copy_siginfo_to_user32(struct compat_siginfo __user *to,
+			   const struct kernel_siginfo *from)
+{
+	if (in_x32_syscall())
+		return x32_copy_siginfo_to_user(to, from);
+	return __copy_siginfo_to_user32(to, from);
+}
+
+int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
+{
+	compat_sigset_t *set = (compat_sigset_t *) sigmask_to_save();
+	struct rt_sigframe_x32 __user *frame;
+	unsigned long uc_flags;
+	void __user *restorer;
+	void __user *fp = NULL;
+
+	if (!(ksig->ka.sa.sa_flags & SA_RESTORER))
+		return -EFAULT;
+
+	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
+
+	uc_flags = frame_uc_flags(regs);
+
+	if (!user_access_begin(frame, sizeof(*frame)))
+		return -EFAULT;
+
+	/* Create the ucontext.  */
+	unsafe_put_user(uc_flags, &frame->uc.uc_flags, Efault);
+	unsafe_put_user(0, &frame->uc.uc_link, Efault);
+	unsafe_compat_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
+	unsafe_put_user(0, &frame->uc.uc__pad0, Efault);
+	restorer = ksig->ka.sa.sa_restorer;
+	unsafe_put_user(restorer, (unsigned long __user *)&frame->pretcode, Efault);
+	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
+	unsafe_put_sigmask(set, frame, Efault);
+	user_access_end();
+
+	if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
+		if (x32_copy_siginfo_to_user(&frame->info, &ksig->info))
+			return -EFAULT;
+	}
+
+	/* Set up registers for signal handler */
+	regs->sp = (unsigned long) frame;
+	regs->ip = (unsigned long) ksig->ka.sa.sa_handler;
+
+	/* We use the x32 calling convention here... */
+	regs->di = ksig->sig;
+	regs->si = (unsigned long) &frame->info;
+	regs->dx = (unsigned long) &frame->uc;
+
+	loadsegment(ds, __USER_DS);
+	loadsegment(es, __USER_DS);
+
+	regs->cs = __USER_CS;
+	regs->ss = __USER_DS;
+
+	return 0;
+
+Efault:
+	user_access_end();
+	return -EFAULT;
+}
+
+COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
+{
+	struct pt_regs *regs = current_pt_regs();
+	struct rt_sigframe_x32 __user *frame;
+	sigset_t set;
+	unsigned long uc_flags;
+
+	frame = (struct rt_sigframe_x32 __user *)(regs->sp - 8);
+
+	if (!access_ok(frame, sizeof(*frame)))
+		goto badframe;
+	if (__get_user(set.sig[0], (__u64 __user *)&frame->uc.uc_sigmask))
+		goto badframe;
+	if (__get_user(uc_flags, &frame->uc.uc_flags))
+		goto badframe;
+
+	set_current_blocked(&set);
+
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+		goto badframe;
+
+	if (compat_restore_altstack(&frame->uc.uc_stack))
+		goto badframe;
+
+	return regs->ax;
+
+badframe:
+	signal_fault(regs, frame, "x32 rt_sigreturn");
+	return 0;
+}
+#endif /* CONFIG_X86_X32_ABI */
-- 
2.35.3

