Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3B553F060
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiFFUnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbiFFUmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:42:49 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473401238AC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:38:56 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id s124so3134137oia.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OL+TIMQawJULWoHOFD9o6u7skDxbFg5kN3WkY6imDKw=;
        b=E23L0GB/iPJMFxfQgpNYcb9nXgjW69zmuHnYI0oV9nam6JU0td5eo4SN5et6B8eYJM
         yFKdqn224YDQCoWJ1oUoBn5sQyw17spsPUC9JusNFfXOGzHpzLwHv2pOOtTFYPsmsCfQ
         EyhzwUxaFaBUh9gGaa9I24zFOgGFxAedIHQF1MWQ7tFX1pIdmyTMw2s9fB+DOKjupX+Z
         Z+cza+8jWfknmDISkc059a/fVqYtqR9sMSVnWYt783cFUgI6WD1pB5U9IBbqSxZMYDOo
         I4oFBh2xlMgRUxwc0OYETkqUjSJxlMj92EopjvO9mu4qI4vk3kut/O2rM+hU6k6qqSzX
         p8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OL+TIMQawJULWoHOFD9o6u7skDxbFg5kN3WkY6imDKw=;
        b=gUbeeYoW41uGQai4x2DXhJlOHL+8oFOpTlvC7MsctsdVCr2uq90/OVnmVzp7hJBcil
         UijuC3YiZYTm1vJohweeaugrse9sLWCN6/PNP1o8jPZFjgrtokqirrYR3M1butC9YSdx
         j18yJnKMRxbCo0bZ5CsFF97X0AbkU1dww4QsYU7wAxm8h0l+Uk8zh2QrqihzLkHCOnxW
         PDtuhAn9gZbmjyMSB9EM/l9gvmohO1lOBcI/BCanjwKVRRvgxoobqJENZ/JhQ31JuqHG
         dWnIGiiOzWQ5KNC/8M7LZYFXgWAHF0S2uamMWrKEBq0Xji0u3DR0Sx50yQrtlCAVBJqv
         ySsA==
X-Gm-Message-State: AOAM530FgyOJxlK23aDkKgB+DrHuqLHvotcVqNvcLzk1Rbbaxp5QGDBC
        ZRZuVcdBDCnYsTZ4xI6mp0aXSXyYUQ==
X-Google-Smtp-Source: ABdhPJzwijnPlj7T5t5Ac/cRAspi0q/AMsrJlhdGbJX4A0L2oyrd0gz3lWLCLlrkEJVqMw12fEeYIw==
X-Received: by 2002:a05:6808:1202:b0:2f9:c7b4:fd56 with SMTP id a2-20020a056808120200b002f9c7b4fd56mr15143122oil.55.1654547935166;
        Mon, 06 Jun 2022 13:38:55 -0700 (PDT)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id j22-20020a056808035600b0032e3cca8561sm4327188oie.21.2022.06.06.13.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:38:54 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 7/8] x86/signal/32: Merge native and compat 32-bit signal code
Date:   Mon,  6 Jun 2022 16:38:01 -0400
Message-Id: <20220606203802.158958-8-brgerst@gmail.com>
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

There are significant differences between signal handling on 32-bit vs.
64-bit, like different structure layouts and legacy syscalls.  Instead
of duplicating that code for native and compat, merge both versions
into one file.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/ia32/Makefile                        |   2 -
 arch/x86/include/asm/segment.h                |   1 +
 arch/x86/kernel/Makefile                      |   4 +-
 arch/x86/kernel/signal.c                      | 219 +-----------------
 .../ia32_signal.c => kernel/signal_32.c}      |  59 ++++-
 include/linux/syscalls.h                      |   2 +
 6 files changed, 60 insertions(+), 227 deletions(-)
 rename arch/x86/{ia32/ia32_signal.c => kernel/signal_32.c} (86%)

diff --git a/arch/x86/ia32/Makefile b/arch/x86/ia32/Makefile
index e481056698de..333556a86b2a 100644
--- a/arch/x86/ia32/Makefile
+++ b/arch/x86/ia32/Makefile
@@ -3,7 +3,5 @@
 # Makefile for the ia32 kernel emulation subsystem.
 #
 
-obj-$(CONFIG_IA32_EMULATION) := ia32_signal.o
-
 audit-class-$(CONFIG_AUDIT) := audit.o
 obj-$(CONFIG_IA32_EMULATION) += $(audit-class-y)
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index e056c29dfcda..c390a672d560 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -135,6 +135,7 @@
 #define __KERNEL_DS			(GDT_ENTRY_KERNEL_DS*8)
 #define __USER_DS			(GDT_ENTRY_DEFAULT_USER_DS*8 + 3)
 #define __USER_CS			(GDT_ENTRY_DEFAULT_USER_CS*8 + 3)
+#define __USER32_CS			__USER_CS
 #define __ESPFIX_SS			(GDT_ENTRY_ESPFIX_SS*8)
 
 /* segment for calling fn: */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 03364dc40d8d..4aa1bd55a362 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -57,8 +57,8 @@ obj-y			+= setup.o x86_init.o i8259.o irqinit.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 obj-$(CONFIG_IRQ_WORK)  += irq_work.o
 obj-y			+= probe_roms.o
-obj-$(CONFIG_X86_32)	+= sys_ia32.o
-obj-$(CONFIG_IA32_EMULATION)	+= sys_ia32.o
+obj-$(CONFIG_X86_32)	+= sys_ia32.o signal_32.o
+obj-$(CONFIG_IA32_EMULATION)	+= sys_ia32.o signal_32.o
 obj-$(CONFIG_X86_64)	+= sys_x86_64.o
 obj-$(CONFIG_X86_ESPFIX64)	+= espfix_64.o
 obj-$(CONFIG_SYSFS)	+= ksysfs.o
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 0511e050d24a..962cfd835c90 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -92,10 +92,6 @@ static void force_valid_ss(struct pt_regs *regs)
 	    ar != (AR_DPL3 | AR_S | AR_P | AR_TYPE_RWDATA_EXPDOWN))
 		regs->ss = __USER_DS;
 }
-# define CONTEXT_COPY_SIZE	offsetof(struct sigcontext, reserved1)
-#else
-# define CONTEXT_COPY_SIZE	sizeof(struct sigcontext)
-#endif
 
 static bool restore_sigcontext(struct pt_regs *regs,
 			       struct sigcontext __user *usc,
@@ -106,16 +102,9 @@ static bool restore_sigcontext(struct pt_regs *regs,
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
-	if (copy_from_user(&sc, usc, CONTEXT_COPY_SIZE))
+	if (copy_from_user(&sc, usc, offsetof(struct sigcontext, reserved1)))
 		return false;
 
-#ifdef CONFIG_X86_32
-	loadsegment(gs, sc.gs);
-	regs->fs = sc.fs;
-	regs->es = sc.es;
-	regs->ds = sc.ds;
-#endif /* CONFIG_X86_32 */
-
 	regs->bx = sc.bx;
 	regs->cx = sc.cx;
 	regs->dx = sc.dx;
@@ -125,8 +114,6 @@ static bool restore_sigcontext(struct pt_regs *regs,
 	regs->ax = sc.ax;
 	regs->sp = sc.sp;
 	regs->ip = sc.ip;
-
-#ifdef CONFIG_X86_64
 	regs->r8 = sc.r8;
 	regs->r9 = sc.r9;
 	regs->r10 = sc.r10;
@@ -135,7 +122,6 @@ static bool restore_sigcontext(struct pt_regs *regs,
 	regs->r13 = sc.r13;
 	regs->r14 = sc.r14;
 	regs->r15 = sc.r15;
-#endif /* CONFIG_X86_64 */
 
 	/* Get CS/SS and force CPL3 */
 	regs->cs = sc.cs | 0x03;
@@ -145,33 +131,20 @@ static bool restore_sigcontext(struct pt_regs *regs,
 	/* disable syscall checks */
 	regs->orig_ax = -1;
 
-#ifdef CONFIG_X86_64
 	/*
 	 * Fix up SS if needed for the benefit of old DOSEMU and
 	 * CRIU.
 	 */
 	if (unlikely(!(uc_flags & UC_STRICT_RESTORE_SS) && user_64bit_mode(regs)))
 		force_valid_ss(regs);
-#endif
 
-	return fpu__restore_sig((void __user *)sc.fpstate,
-			       IS_ENABLED(CONFIG_X86_32));
+	return fpu__restore_sig((void __user *)sc.fpstate, 0);
 }
 
 static __always_inline int
 __unsafe_setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 		     struct pt_regs *regs, unsigned long mask)
 {
-#ifdef CONFIG_X86_32
-	unsigned int gs;
-	savesegment(gs, gs);
-
-	unsafe_put_user(gs,	  (unsigned int __user *)&sc->gs, Efault);
-	unsafe_put_user(regs->fs, (unsigned int __user *)&sc->fs, Efault);
-	unsafe_put_user(regs->es, (unsigned int __user *)&sc->es, Efault);
-	unsafe_put_user(regs->ds, (unsigned int __user *)&sc->ds, Efault);
-#endif /* CONFIG_X86_32 */
-
 	unsafe_put_user(regs->di, &sc->di, Efault);
 	unsafe_put_user(regs->si, &sc->si, Efault);
 	unsafe_put_user(regs->bp, &sc->bp, Efault);
@@ -180,7 +153,6 @@ __unsafe_setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 	unsafe_put_user(regs->dx, &sc->dx, Efault);
 	unsafe_put_user(regs->cx, &sc->cx, Efault);
 	unsafe_put_user(regs->ax, &sc->ax, Efault);
-#ifdef CONFIG_X86_64
 	unsafe_put_user(regs->r8, &sc->r8, Efault);
 	unsafe_put_user(regs->r9, &sc->r9, Efault);
 	unsafe_put_user(regs->r10, &sc->r10, Efault);
@@ -189,23 +161,15 @@ __unsafe_setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 	unsafe_put_user(regs->r13, &sc->r13, Efault);
 	unsafe_put_user(regs->r14, &sc->r14, Efault);
 	unsafe_put_user(regs->r15, &sc->r15, Efault);
-#endif /* CONFIG_X86_64 */
 
 	unsafe_put_user(current->thread.trap_nr, &sc->trapno, Efault);
 	unsafe_put_user(current->thread.error_code, &sc->err, Efault);
 	unsafe_put_user(regs->ip, &sc->ip, Efault);
-#ifdef CONFIG_X86_32
-	unsafe_put_user(regs->cs, (unsigned int __user *)&sc->cs, Efault);
-	unsafe_put_user(regs->flags, &sc->flags, Efault);
-	unsafe_put_user(regs->sp, &sc->sp_at_signal, Efault);
-	unsafe_put_user(regs->ss, (unsigned int __user *)&sc->ss, Efault);
-#else /* !CONFIG_X86_32 */
 	unsafe_put_user(regs->flags, &sc->flags, Efault);
 	unsafe_put_user(regs->cs, &sc->cs, Efault);
 	unsafe_put_user(0, &sc->gs, Efault);
 	unsafe_put_user(0, &sc->fs, Efault);
 	unsafe_put_user(regs->ss, &sc->ss, Efault);
-#endif /* CONFIG_X86_32 */
 
 	unsafe_put_user(fpstate, (unsigned long __user *)&sc->fpstate, Efault);
 
@@ -228,6 +192,8 @@ do {									\
 			(__u64 __user *)&(frame)->uc.uc_sigmask, \
 			label)
 
+#endif /* CONFIG_X86_64 */
+
 /*
  * Set up a signal frame.
  */
@@ -313,148 +279,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 	return (void __user *)sp;
 }
 
-#ifdef CONFIG_X86_32
-static const struct {
-	u16 poplmovl;
-	u32 val;
-	u16 int80;
-} __attribute__((packed)) retcode = {
-	0xb858,		/* popl %eax; movl $..., %eax */
-	__NR_sigreturn,
-	0x80cd,		/* int $0x80 */
-};
-
-static const struct {
-	u8  movl;
-	u32 val;
-	u16 int80;
-	u8  pad;
-} __attribute__((packed)) rt_retcode = {
-	0xb8,		/* movl $..., %eax */
-	__NR_rt_sigreturn,
-	0x80cd,		/* int $0x80 */
-	0
-};
-
-int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
-{
-	sigset_t *set = sigmask_to_save();
-	struct sigframe __user *frame;
-	void __user *restorer;
-	void __user *fp = NULL;
-
-	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
-
-	if (!user_access_begin(frame, sizeof(*frame)))
-		return -EFAULT;
-
-	unsafe_put_user(ksig->sig, &frame->sig, Efault);
-	unsafe_put_sigcontext(&frame->sc, fp, regs, set, Efault);
-	unsafe_put_user(set->sig[1], &frame->extramask[0], Efault);
-	if (current->mm->context.vdso)
-		restorer = current->mm->context.vdso +
-			vdso_image_32.sym___kernel_sigreturn;
-	else
-		restorer = &frame->retcode;
-	if (ksig->ka.sa.sa_flags & SA_RESTORER)
-		restorer = ksig->ka.sa.sa_restorer;
-
-	/* Set up to return from userspace.  */
-	unsafe_put_user(restorer, &frame->pretcode, Efault);
-
-	/*
-	 * This is popl %eax ; movl $__NR_sigreturn, %eax ; int $0x80
-	 *
-	 * WE DO NOT USE IT ANY MORE! It's only left here for historical
-	 * reasons and because gdb uses it as a signature to notice
-	 * signal handler stack frames.
-	 */
-	unsafe_put_user(*((u64 *)&retcode), (u64 *)frame->retcode, Efault);
-	user_access_end();
-
-	/* Set up registers for signal handler */
-	regs->sp = (unsigned long)frame;
-	regs->ip = (unsigned long)ksig->ka.sa.sa_handler;
-	regs->ax = (unsigned long)ksig->sig;
-	regs->dx = 0;
-	regs->cx = 0;
-
-	regs->ds = __USER_DS;
-	regs->es = __USER_DS;
-	regs->ss = __USER_DS;
-	regs->cs = __USER_CS;
-
-	return 0;
-
-Efault:
-	user_access_end();
-	return -EFAULT;
-}
-
-int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
-{
-	sigset_t *set = sigmask_to_save();
-	struct rt_sigframe __user *frame;
-	void __user *restorer;
-	void __user *fp = NULL;
-
-	frame = get_sigframe(ksig, regs, sizeof(*frame), &fp);
-
-	if (!user_access_begin(frame, sizeof(*frame)))
-		return -EFAULT;
-
-	unsafe_put_user(ksig->sig, &frame->sig, Efault);
-	unsafe_put_user(&frame->info, &frame->pinfo, Efault);
-	unsafe_put_user(&frame->uc, &frame->puc, Efault);
-
-	/* Create the ucontext.  */
-	if (static_cpu_has(X86_FEATURE_XSAVE))
-		unsafe_put_user(UC_FP_XSTATE, &frame->uc.uc_flags, Efault);
-	else
-		unsafe_put_user(0, &frame->uc.uc_flags, Efault);
-	unsafe_put_user(0, &frame->uc.uc_link, Efault);
-	unsafe_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
-
-	/* Set up to return from userspace.  */
-	restorer = current->mm->context.vdso +
-		vdso_image_32.sym___kernel_rt_sigreturn;
-	if (ksig->ka.sa.sa_flags & SA_RESTORER)
-		restorer = ksig->ka.sa.sa_restorer;
-	unsafe_put_user(restorer, &frame->pretcode, Efault);
-
-	/*
-	 * This is movl $__NR_rt_sigreturn, %ax ; int $0x80
-	 *
-	 * WE DO NOT USE IT ANY MORE! It's only left here for historical
-	 * reasons and because gdb uses it as a signature to notice
-	 * signal handler stack frames.
-	 */
-	unsafe_put_user(*((u64 *)&rt_retcode), (u64 *)frame->retcode, Efault);
-	unsafe_put_sigcontext(&frame->uc.uc_mcontext, fp, regs, set, Efault);
-	unsafe_put_sigmask(set, frame, Efault);
-	user_access_end();
-	
-	if (copy_siginfo_to_user(&frame->info, &ksig->info))
-		return -EFAULT;
-
-	/* Set up registers for signal handler */
-	regs->sp = (unsigned long)frame;
-	regs->ip = (unsigned long)ksig->ka.sa.sa_handler;
-	regs->ax = (unsigned long)ksig->sig;
-	regs->dx = (unsigned long)&frame->info;
-	regs->cx = (unsigned long)&frame->uc;
-
-	regs->ds = __USER_DS;
-	regs->es = __USER_DS;
-	regs->ss = __USER_DS;
-	regs->cs = __USER_CS;
-
-	return 0;
-Efault:
-	user_access_end();
-	return -EFAULT;
-}
-#else /* !CONFIG_X86_32 */
+#ifdef CONFIG_X86_64
 static unsigned long frame_uc_flags(struct pt_regs *regs)
 {
 	unsigned long flags;
@@ -545,7 +370,6 @@ int x64_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	user_access_end();
 	return -EFAULT;
 }
-#endif /* CONFIG_X86_32 */
 
 #ifdef CONFIG_X86_X32_ABI
 static int x32_copy_siginfo_to_user(struct compat_siginfo __user *to,
@@ -631,38 +455,6 @@ int x32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 /*
  * Do a signal return; undo the signal stack.
  */
-#ifdef CONFIG_X86_32
-SYSCALL_DEFINE0(sigreturn)
-{
-	struct pt_regs *regs = current_pt_regs();
-	struct sigframe __user *frame;
-	sigset_t set;
-
-	frame = (struct sigframe __user *)(regs->sp - 8);
-
-	if (!access_ok(frame, sizeof(*frame)))
-		goto badframe;
-	if (__get_user(set.sig[0], &frame->sc.oldmask) ||
-	    __get_user(set.sig[1], &frame->extramask[0]))
-		goto badframe;
-
-	set_current_blocked(&set);
-
-	/*
-	 * x86_32 has no uc_flags bits relevant to restore_sigcontext.
-	 * Save a few cycles by skipping the __get_user.
-	 */
-	if (!restore_sigcontext(regs, &frame->sc, 0))
-		goto badframe;
-	return regs->ax;
-
-badframe:
-	signal_fault(regs, frame, "sigreturn");
-
-	return 0;
-}
-#endif /* CONFIG_X86_32 */
-
 SYSCALL_DEFINE0(rt_sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
@@ -692,6 +484,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	signal_fault(regs, frame, "rt_sigreturn");
 	return 0;
 }
+#endif /* CONFIG_X86_64 */
 
 /*
  * There are four different struct types for signal frame: sigframe_ia32,
diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/kernel/signal_32.c
similarity index 86%
rename from arch/x86/ia32/ia32_signal.c
rename to arch/x86/kernel/signal_32.c
index e28421f53d44..2553136cf39b 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/kernel/signal_32.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *  linux/arch/x86_64/ia32/ia32_signal.c
- *
  *  Copyright (C) 1991, 1992  Linus Torvalds
  *
  *  1997-11-28  Modified for POSIX.1b signals by Richard Henderson
@@ -26,7 +24,6 @@
 #include <linux/uaccess.h>
 #include <asm/fpu/signal.h>
 #include <asm/ptrace.h>
-#include <asm/ia32_unistd.h>
 #include <asm/user32.h>
 #include <uapi/asm/sigcontext.h>
 #include <asm/proto.h>
@@ -35,6 +32,9 @@
 #include <asm/sighandling.h>
 #include <asm/smap.h>
 
+#ifdef CONFIG_IA32_EMULATION
+#include <asm/ia32_unistd.h>
+
 static inline void reload_segments(struct sigcontext_32 *sc)
 {
 	unsigned int cur;
@@ -53,6 +53,21 @@ static inline void reload_segments(struct sigcontext_32 *sc)
 		loadsegment(es, sc->es | 0x03);
 }
 
+#define sigset32_t			compat_sigset_t
+#define restore_altstack32		compat_restore_altstack
+#define unsafe_save_altstack32		unsafe_compat_save_altstack
+
+#else
+
+#define sigset32_t			sigset_t
+#define __NR_ia32_sigreturn		__NR_sigreturn
+#define __NR_ia32_rt_sigreturn		__NR_rt_sigreturn
+#define restore_altstack32		restore_altstack
+#define unsafe_save_altstack32		unsafe_save_altstack
+#define __copy_siginfo_to_user32	copy_siginfo_to_user
+
+#endif
+
 /*
  * Do a signal return; undo the signal stack.
  */
@@ -86,6 +101,7 @@ static bool ia32_restore_sigcontext(struct pt_regs *regs,
 	/* disable syscall checks */
 	regs->orig_ax = -1;
 
+#ifdef CONFIG_IA32_EMULATION
 	/*
 	 * Reload fs and gs if they have changed in the signal
 	 * handler.  This does not handle long fs/gs base changes in
@@ -93,10 +109,17 @@ static bool ia32_restore_sigcontext(struct pt_regs *regs,
 	 * normal case.
 	 */
 	reload_segments(&sc);
+#else
+	loadsegment(gs, sc.gs);
+	regs->fs = sc.fs;
+	regs->es = sc.es;
+	regs->ds = sc.ds;
+#endif
+
 	return fpu__restore_sig(compat_ptr(sc.fpstate), 1);
 }
 
-COMPAT_SYSCALL_DEFINE0(sigreturn)
+SYSCALL32_DEFINE0(sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct sigframe_ia32 __user *frame = (struct sigframe_ia32 __user *)(regs->sp-8);
@@ -119,7 +142,7 @@ COMPAT_SYSCALL_DEFINE0(sigreturn)
 	return 0;
 }
 
-COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
+SYSCALL32_DEFINE0(rt_sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct rt_sigframe_ia32 __user *frame;
@@ -129,7 +152,7 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
-	if (__get_user(set.sig[0], (__u64 __user *)&frame->uc.uc_sigmask))
+	if (__get_user(*(__u64 *)&set, (__u64 __user *)&frame->uc.uc_sigmask))
 		goto badframe;
 
 	set_current_blocked(&set);
@@ -137,7 +160,7 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 	if (!ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext))
 		goto badframe;
 
-	if (compat_restore_altstack(&frame->uc.uc_stack))
+	if (restore_altstack32(&frame->uc.uc_stack))
 		goto badframe;
 
 	return regs->ax;
@@ -159,9 +182,15 @@ __unsafe_setup_sigcontext32(struct sigcontext_32 __user *sc,
 			    struct pt_regs *regs, unsigned int mask)
 {
 	unsafe_put_user(get_user_seg(gs), (unsigned int __user *)&sc->gs, Efault);
+#ifdef CONFIG_IA32_EMULATION
 	unsafe_put_user(get_user_seg(fs), (unsigned int __user *)&sc->fs, Efault);
 	unsafe_put_user(get_user_seg(ds), (unsigned int __user *)&sc->ds, Efault);
 	unsafe_put_user(get_user_seg(es), (unsigned int __user *)&sc->es, Efault);
+#else
+	unsafe_put_user(regs->fs, (unsigned int __user *)&sc->fs, Efault);
+	unsafe_put_user(regs->es, (unsigned int __user *)&sc->es, Efault);
+	unsafe_put_user(regs->ds, (unsigned int __user *)&sc->ds, Efault);
+#endif
 
 	unsafe_put_user(regs->di, &sc->di, Efault);
 	unsafe_put_user(regs->si, &sc->si, Efault);
@@ -198,7 +227,7 @@ do {									\
 
 int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
-	compat_sigset_t *set = (compat_sigset_t *) sigmask_to_save();
+	sigset32_t *set = (sigset32_t *) sigmask_to_save();
 	struct sigframe_ia32 __user *frame;
 	void __user *restorer;
 	void __user *fp = NULL;
@@ -250,8 +279,13 @@ int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 	regs->dx = 0;
 	regs->cx = 0;
 
+#ifdef CONFIG_IA32_EMULATION
 	loadsegment(ds, __USER_DS);
 	loadsegment(es, __USER_DS);
+#else
+	regs->ds = __USER_DS;
+	regs->es = __USER_DS;
+#endif
 
 	regs->cs = __USER32_CS;
 	regs->ss = __USER_DS;
@@ -264,7 +298,7 @@ int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 
 int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 {
-	compat_sigset_t *set = (compat_sigset_t *) sigmask_to_save();
+	sigset32_t *set = (sigset32_t *) sigmask_to_save();
 	struct rt_sigframe_ia32 __user *frame;
 	void __user *restorer;
 	void __user *fp = NULL;
@@ -297,7 +331,7 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	else
 		unsafe_put_user(0, &frame->uc.uc_flags, Efault);
 	unsafe_put_user(0, &frame->uc.uc_link, Efault);
-	unsafe_compat_save_altstack(&frame->uc.uc_stack, regs->sp, Efault);
+	unsafe_save_altstack32(&frame->uc.uc_stack, regs->sp, Efault);
 
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
@@ -327,8 +361,13 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	regs->dx = (unsigned long) &frame->info;
 	regs->cx = (unsigned long) &frame->uc;
 
+#ifdef CONFIG_IA32_EMULATION
 	loadsegment(ds, __USER_DS);
 	loadsegment(es, __USER_DS);
+#else
+	regs->ds = __USER_DS;
+	regs->es = __USER_DS;
+#endif
 
 	regs->cs = __USER32_CS;
 	regs->ss = __USER_DS;
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a34b0f9a9972..33a0ee3bcb2e 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -264,6 +264,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 #define SC_VAL64(type, name) ((type) name##_hi << 32 | name##_lo)
 
 #ifdef CONFIG_COMPAT
+#define SYSCALL32_DEFINE0 COMPAT_SYSCALL_DEFINE0
 #define SYSCALL32_DEFINE1 COMPAT_SYSCALL_DEFINE1
 #define SYSCALL32_DEFINE2 COMPAT_SYSCALL_DEFINE2
 #define SYSCALL32_DEFINE3 COMPAT_SYSCALL_DEFINE3
@@ -271,6 +272,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 #define SYSCALL32_DEFINE5 COMPAT_SYSCALL_DEFINE5
 #define SYSCALL32_DEFINE6 COMPAT_SYSCALL_DEFINE6
 #else
+#define SYSCALL32_DEFINE0 SYSCALL_DEFINE0
 #define SYSCALL32_DEFINE1 SYSCALL_DEFINE1
 #define SYSCALL32_DEFINE2 SYSCALL_DEFINE2
 #define SYSCALL32_DEFINE3 SYSCALL_DEFINE3
-- 
2.35.3

