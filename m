Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103294E7834
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347769AbiCYPpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377710AbiCYPnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:43:50 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE15BB0B1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:40:09 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id e189so8530951oia.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 08:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N0WSZEVvPP19spF54GjyVobZbjAlPoVO9KWpI4tO8xk=;
        b=VDmNiMduhp1oywBzrq09nMJSgbHCcnfJuhEec0965aIvd9aRWQdNnIs1S3AceqYWYw
         AfQ7s/GofIhWFurQ34XVdMgX3h99o0ePonrm4KdFwnlzN7kE2oiKpnHXLs2Ha6HEnMEG
         6Vw2Ot2yX3uj8b9PBnwZJHa7CuJ/DEb8vfuD1G5cdd3CGsjtrCCEY4uqaaEHEVHSS8a4
         y48xmjrRdIKKjA3eq7K6OO7OA+5nzyzJM/GrVmSP1ykYhgSj2R+26Cd95sGF27l64NZx
         Z1GF+BDdTv5sm6yZ0CThtIu1ltTEZzmBCv3E9myf8MelToAEq9GlWuMXjlvX2x8bZpha
         kbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N0WSZEVvPP19spF54GjyVobZbjAlPoVO9KWpI4tO8xk=;
        b=aKnG6JT5MMY8fMASvrRBlubobe+UZqj9h2FkHbxKJp9yjkzWVCVKWcGxypvrxsIWLX
         wmuvP8XD1yZrs8UjlSH2hUBu+aUJcBOwxm2Fx5CvojYd8IbPeVQyf/MqiBrKiY+zNSUF
         t2LBeoOtU5QHRVTShDYPUsliJLB22OqWMCnzc7CjaFtOrMIacPXX1kQasuWrHzxZHo5S
         f/KyDL13mgjTNxzilQkKMqo2gghJ1L1JCkjY2uj6rBmPzsF55EqUranGjqRKdKAlGZ+z
         TAHlNvReQmQM0uelR1tNcQYSwKpyO8gglOtol4ZAHdjNzlcgCjmbgcya3BsanVpkYFGz
         Lkeg==
X-Gm-Message-State: AOAM5322ug1cfa9af+LLPCWXnv3PBNhLST5B9BepJEFUPKhSkFj0RjOB
        TPLX4/vBZgfE1S81wsN6SVVhAdLbqA==
X-Google-Smtp-Source: ABdhPJzAh3PuCu+iAsL3GLwcOU6AT3tZ0FCQkFUczDGylNGL7anlPp53QqJtQoRrgP9aXB//cV90sA==
X-Received: by 2002:a05:6808:30a2:b0:2da:3ab6:2c83 with SMTP id bl34-20020a05680830a200b002da3ab62c83mr5311197oib.206.1648222807599;
        Fri, 25 Mar 2022 08:40:07 -0700 (PDT)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id el17-20020a056870f69100b000de9672ac3csm1709566oab.52.2022.03.25.08.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 08:40:07 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 3/4] x86-32: Remove lazy GS macros
Date:   Fri, 25 Mar 2022 11:39:52 -0400
Message-Id: <20220325153953.162643-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325153953.162643-1-brgerst@gmail.com>
References: <20220325153953.162643-1-brgerst@gmail.com>
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

GS is always a user segment now.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
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
index 27516046117a..b8d40ddeab00 100644
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
index 656ed6531d03..617b3663e4dd 100644
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
index b370767f5b19..96a9885b9c3a 100644
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
index 26edb1cd07a4..877358f3dba7 100644
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
index 8d2f2f995539..a2336db1aac1 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -171,9 +171,9 @@ static u16 get_segment_reg(struct task_struct *task, unsigned long offset)
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
@@ -211,7 +211,7 @@ static int set_segment_reg(struct task_struct *task,
 		break;
 
 	case offsetof(struct user_regs_struct, gs):
-		task_user_gs(task) = value;
+		task->thread.gs = value;
 	}
 
 	return 0;
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index ec71e06ae364..add4bb6f9d43 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -94,7 +94,7 @@ static bool restore_sigcontext(struct pt_regs *regs,
 		return false;
 
 #ifdef CONFIG_X86_32
-	set_user_gs(regs, sc.gs);
+	loadsegment(gs, sc.gs);
 	regs->fs = sc.fs;
 	regs->es = sc.es;
 	regs->ds = sc.ds;
@@ -147,8 +147,10 @@ __unsafe_setup_sigcontext(struct sigcontext __user *sc, void __user *fpstate,
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
index c21bcd668284..e9e803a4d44c 100644
--- a/arch/x86/kernel/vm86_32.c
+++ b/arch/x86/kernel/vm86_32.c
@@ -151,7 +151,7 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
 
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
index b781d324211b..21104c41cba0 100644
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
index b82ca14ba718..4a9fd9029a53 100644
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
-- 
2.35.1

