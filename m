Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EFE502781
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 11:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351847AbiDOJpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 05:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351818AbiDOJow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 05:44:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D148AAC05A;
        Fri, 15 Apr 2022 02:42:22 -0700 (PDT)
Date:   Fri, 15 Apr 2022 09:42:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650015741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bSZo8uRuJkiFyKsfHPk9mIe2pXIyNYfWkVGJHMPzAuk=;
        b=VHxnIcOwTEj6uza6tK1Hcogcf2fuku6oRF4Rhlz1o4kaKNtNl0QeVRx7tzdyGEqjl0tz44
        X0dhhY2VUron8rWATJU66jzGq7GpH4u0DUJKmToHGkPetTDzNQv0T/cpbazbmxP/rXaV7K
        9gN/dnoiAaffGbVdycmVziJRjgb4PmtOGf0OGS73ILME/a5KlWQNjg34yEOwPb9dXjgNuQ
        rU3N/QckeyS/fRQAc6H8LzU6a2XGGUBmPFI3KP9xCED2Br/fTSkVgzQ3aOXtf42vwI3K9T
        m2oq4bQOv6Seta7LjAfn+UebIxjRbNf2dtKoZz7H4S3ilZbxZHQB7BENf1mbRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650015741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bSZo8uRuJkiFyKsfHPk9mIe2pXIyNYfWkVGJHMPzAuk=;
        b=j8iQGqo4XsFTm0PchEQbrpadUBumBDUXbTVVaaeJ/a+ZGLUwMg2pzg2Rnv56EPzjlJmgKt
        mYjurt49E6HV9iDQ==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/32: Remove lazy GS macros
Cc:     Brian Gerst <brgerst@gmail.com>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220325153953.162643-4-brgerst@gmail.com>
References: <20220325153953.162643-4-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <165001574039.4207.55289763093861470.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     3a24a60854d2ef19e0edcd11cdbbb4fabc655dde
Gitweb:        https://git.kernel.org/tip/3a24a60854d2ef19e0edcd11cdbbb4fabc655dde
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 25 Mar 2022 11:39:52 -04:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 14 Apr 2022 14:09:43 +02:00

x86/32: Remove lazy GS macros

GS is always a user segment now.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20220325153953.162643-4-brgerst@gmail.com
---
 arch/x86/include/asm/mmu_context.h |  2 +-
 arch/x86/include/asm/segment.h     |  5 -----
 arch/x86/kernel/process.c          |  5 +----
 arch/x86/kernel/process_32.c       | 11 ++++-------
 arch/x86/kernel/ptrace.c           |  6 +++---
 arch/x86/kernel/signal.c           |  8 +++++---
 arch/x86/kernel/vm86_32.c          |  4 ++--
 arch/x86/lib/insn-eval.c           |  5 +++--
 arch/x86/math-emu/get_address.c    |  2 +-
 9 files changed, 20 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 2751604..b8d40dd 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -141,7 +141,7 @@ do {						\
 #ifdef CONFIG_X86_32
 #define deactivate_mm(tsk, mm)			\
 do {						\
-	lazy_load_gs(0);			\
+	loadsegment(gs, 0);			\
 } while (0)
 #else
 #define deactivate_mm(tsk, mm)			\
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 656ed65..617b366 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -354,11 +354,6 @@ static inline void __loadsegment_fs(unsigned short value)
  * x86-32 user GS accessors.  This is ugly and could do with some cleaning up.
  */
 #ifdef CONFIG_X86_32
-# define get_user_gs(regs)		(u16)({ unsigned long v; savesegment(gs, v); v; })
-# define set_user_gs(regs, v)		loadsegment(gs, (unsigned long)(v))
-# define task_user_gs(tsk)		((tsk)->thread.gs)
-# define lazy_save_gs(v)		savesegment(gs, (v))
-# define lazy_load_gs(v)		loadsegment(gs, (v))
 # define load_gs_index(v)		loadsegment(gs, (v))
 #endif	/* X86_32 */
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b370767..96a9885 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -160,6 +160,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	savesegment(ds, p->thread.ds);
 #else
 	p->thread.sp0 = (unsigned long) (childregs + 1);
+	savesegment(gs, p->thread.gs);
 	/*
 	 * Clear all status flags including IF and set fixed bit. 64bit
 	 * does not have this initialization as the frame does not contain
@@ -191,10 +192,6 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	if (sp)
 		childregs->sp = sp;
 
-#ifdef CONFIG_X86_32
-	task_user_gs(p) = get_user_gs(current_pt_regs());
-#endif
-
 	if (unlikely(p->flags & PF_IO_WORKER)) {
 		/*
 		 * An IO thread is a user space thread, but it doesn't
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 26edb1c..877358f 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -63,10 +63,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
 	unsigned long d0, d1, d2, d3, d6, d7;
 	unsigned short gs;
 
-	if (user_mode(regs))
-		gs = get_user_gs(regs);
-	else
-		savesegment(gs, gs);
+	savesegment(gs, gs);
 
 	show_ip(regs, log_lvl);
 
@@ -114,7 +111,7 @@ void release_thread(struct task_struct *dead_task)
 void
 start_thread(struct pt_regs *regs, unsigned long new_ip, unsigned long new_sp)
 {
-	set_user_gs(regs, 0);
+	loadsegment(gs, 0);
 	regs->fs		= 0;
 	regs->ds		= __USER_DS;
 	regs->es		= __USER_DS;
@@ -177,7 +174,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	 * used %fs or %gs (it does not today), or if the kernel is
 	 * running inside of a hypervisor layer.
 	 */
-	lazy_save_gs(prev->gs);
+	savesegment(gs, prev->gs);
 
 	/*
 	 * Load the per-thread Thread-Local Storage descriptor.
@@ -208,7 +205,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	 * Restore %gs if needed (which is common)
 	 */
 	if (prev->gs | next->gs)
-		lazy_load_gs(next->gs);
+		loadsegment(gs, next->gs);
 
 	this_cpu_write(current_task, next_p);
 
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 98d10ef..37c12fb 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -170,9 +170,9 @@ static u16 get_segment_reg(struct task_struct *task, unsigned long offset)
 		retval = *pt_regs_access(task_pt_regs(task), offset);
 	else {
 		if (task == current)
-			retval = get_user_gs(task_pt_regs(task));
+			savesegment(gs, retval);
 		else
-			retval = task_user_gs(task);
+			retval = task->thread.gs;
 	}
 	return retval;
 }
@@ -210,7 +210,7 @@ static int set_segment_reg(struct task_struct *task,
 		break;
 
 	case offsetof(struct user_regs_struct, gs):
-		task_user_gs(task) = value;
+		task->thread.gs = value;
 	}
 
 	return 0;
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index e439eb1..9c7265b 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -93,7 +93,7 @@ static bool restore_sigcontext(struct pt_regs *regs,
 		return false;
 
 #ifdef CONFIG_X86_32
-	set_user_gs(regs, sc.gs);
+	loadsegment(gs, sc.gs);
 	regs->fs = sc.fs;
 	regs->es = sc.es;
 	regs->ds = sc.ds;
@@ -146,8 +146,10 @@ __unsafe_setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
 		     struct pt_regs *regs, unsigned long mask)
 {
 #ifdef CONFIG_X86_32
-	unsafe_put_user(get_user_gs(regs),
-				  (unsigned int __user *)&sc->gs, Efault);
+	unsigned int gs;
+	savesegment(gs, gs);
+
+	unsafe_put_user(gs,	  (unsigned int __user *)&sc->gs, Efault);
 	unsafe_put_user(regs->fs, (unsigned int __user *)&sc->fs, Efault);
 	unsafe_put_user(regs->es, (unsigned int __user *)&sc->es, Efault);
 	unsafe_put_user(regs->ds, (unsigned int __user *)&sc->ds, Efault);
diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
index c21bcd6..e9e803a 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -151,7 +151,7 @@ exit_vm86:
 
 	memcpy(&regs->pt, &vm86->regs32, sizeof(struct pt_regs));
 
-	lazy_load_gs(vm86->regs32.gs);
+	loadsegment(gs, vm86->regs32.gs);
 
 	regs->pt.ax = retval;
 	return;
@@ -325,7 +325,7 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
  * Save old state
  */
 	vm86->saved_sp0 = tsk->thread.sp0;
-	lazy_save_gs(vm86->regs32.gs);
+	savesegment(gs, vm86->regs32.gs);
 
 	/* make room for real-mode segments */
 	preempt_disable();
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index b781d32..21104c4 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -342,9 +342,9 @@ static int resolve_seg_reg(struct insn *insn, struct pt_regs *regs, int regoff)
  */
 static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
 {
-#ifdef CONFIG_X86_64
 	unsigned short sel;
 
+#ifdef CONFIG_X86_64
 	switch (seg_reg_idx) {
 	case INAT_SEG_REG_IGNORE:
 		return 0;
@@ -402,7 +402,8 @@ static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
 	case INAT_SEG_REG_FS:
 		return (unsigned short)(regs->fs & 0xffff);
 	case INAT_SEG_REG_GS:
-		return get_user_gs(regs);
+		savesegment(gs, sel);
+		return sel;
 	case INAT_SEG_REG_IGNORE:
 	default:
 		return -EINVAL;
diff --git a/arch/x86/math-emu/get_address.c b/arch/x86/math-emu/get_address.c
index b82ca14..4a9fd90 100644
--- a/arch/x86/math-emu/get_address.c
+++ b/arch/x86/math-emu/get_address.c
@@ -153,7 +153,7 @@ static long pm_address(u_char FPU_modrm, u_char segment,
 	switch (segment) {
 	case PREFIX_GS_ - 1:
 		/* user gs handling can be lazy, use special accessors */
-		addr->selector = get_user_gs(FPU_info->regs);
+		savesegment(gs, addr->selector);
 		break;
 	default:
 		addr->selector = PM_REG_(segment);
