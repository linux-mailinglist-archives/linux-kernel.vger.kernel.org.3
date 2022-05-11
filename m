Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3216522E73
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243715AbiEKIcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243828AbiEKIbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:31:49 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D9C27CD5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:46 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l11-20020a17090a49cb00b001d923a9ca99so1450242pjm.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=knp0cFUX68YXmasBp7zCeiKDqtafu8GC4P5SG+qc96s=;
        b=H6IZ3cvzvAlN+sUIDWTQC6TuSPON8N+diUcE7N3L7rxqyJ5+7Nzh9ovpvYbD2DW/J6
         rOw1wLx64shfJ7SCj2dtxpvX3x3ML9h9rpmO2oHyHemeMsj1+eiXaxzBOFAnW0oAgMwx
         jDidZSUQjvuhPB/frAmyKDscP1YuEfTMs8frFrY+zn/TtyG4jW39js+/sP1nfDgQCeD1
         C7aTgixJbkFzhdz58DjORfRxSGdHTyZGJqgEw65FtIanuzTtdNYJ+2Q8pLMG/VKUKj9S
         YHHv8cPGuOt/bM5uu+zqPk6ssgsZ14mbk3X0HS21I41FzvOAdumThc1Gq/PPS1APEl8V
         Vamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=knp0cFUX68YXmasBp7zCeiKDqtafu8GC4P5SG+qc96s=;
        b=UaaHmx4JqDrA+8hWkh+oF0aXe9alqHIHB9unqZZvnAHf3jvIRuNhcZSPyzxjfB5KN3
         xcEjMM54IpPlMrJNGiYjvLuYQm/bpw18zqufWP9uCWSngZlrI0YA6oST69JWG7HYVByx
         kRmhDLQlggg26ztAbveg+Ipf7O+FUeNWnP1ciHG+moJLGku+DbBuvr0ZlI8vS31kfnsa
         vgFZdZTyMrUnDN3AuD46wTaYcz1osjbgxPakHrCxykyyhcgODhqbldiqejrKDZvnNr3g
         3r9BXZAtiy/zyNtwoAAG6XBpNApkkphJNJ0MYesDUIMnMhpp40LL5Zv0eOFRHK9RJsBM
         r7RA==
X-Gm-Message-State: AOAM530/qupVyA8b8CdwxSqb/q60KbkxOactYa3zH0TLHgNVQqfEdC+5
        /ALiKbA4D2DV59T+UcsNX+Z/Hw==
X-Google-Smtp-Source: ABdhPJzLDEDEZBimm9+VXNZCVWI58MveCHWQ80jkKxcXiRXLgAomiTeX4iswid/G5PPyhxFV9VXxJw==
X-Received: by 2002:a17:902:8f8d:b0:15b:7b98:22e6 with SMTP id z13-20020a1709028f8d00b0015b7b9822e6mr24318754plo.102.1652257905563;
        Wed, 11 May 2022 01:31:45 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7900a000000b0050dc7628170sm1020202pfo.74.2022.05.11.01.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 01:31:45 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
Subject: [PATCH v10 10/16] riscv: Add sigcontext save/restore for vector
Date:   Wed, 11 May 2022 08:31:20 +0000
Message-Id: <055b74196f945ab09c97e229ad54b2c07e55bf90.1652257230.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1652257230.git.greentime.hu@sifive.com>
References: <cover.1652257230.git.greentime.hu@sifive.com>
In-Reply-To: <cover.1652257230.git.greentime.hu@sifive.com>
References: <cover.1652257230.git.greentime.hu@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds sigcontext save/restore for vector. The vector registers
will be saved in datap pointer. The datap pointer will be allocated
dynamically when the task needs in kernel space. The datap pointer will
be set right after the __riscv_v_state data structure to save all the
vector registers in the signal handler stack.

Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/uapi/asm/sigcontext.h |  24 ++++
 arch/riscv/kernel/asm-offsets.c          |   2 +
 arch/riscv/kernel/setup.c                |   4 +
 arch/riscv/kernel/signal.c               | 165 ++++++++++++++++++++++-
 4 files changed, 191 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/uapi/asm/sigcontext.h b/arch/riscv/include/uapi/asm/sigcontext.h
index 84f2dfcfdbce..b8a0fd7d7cfc 100644
--- a/arch/riscv/include/uapi/asm/sigcontext.h
+++ b/arch/riscv/include/uapi/asm/sigcontext.h
@@ -8,6 +8,23 @@
 
 #include <asm/ptrace.h>
 
+/* The Magic number for signal context frame header. */
+#define RVV_MAGIC	0x53465457
+#define END_MAGIC	0x0
+
+/* The size of END signal context header. */
+#define END_HDR_SIZE	0x0
+
+struct __riscv_ctx_hdr {
+	__u32 magic;
+	__u32 size;
+};
+
+struct __sc_riscv_v_state {
+	struct __riscv_ctx_hdr head;
+	struct __riscv_v_state v_state;
+} __attribute__((aligned(16)));
+
 /*
  * Signal context structure
  *
@@ -17,6 +34,13 @@
 struct sigcontext {
 	struct user_regs_struct sc_regs;
 	union __riscv_fp_state sc_fpregs;
+	/*
+	 * 4K + 128 reserved for vector state and future expansion.
+	 * This space is enough to store the vector context whose VLENB
+	 * is less or equal to 128.
+	 * (The size of the vector context is 4144 byte as VLENB is 128)
+	 */
+	__u8 __reserved[4224] __attribute__((__aligned__(16)));
 };
 
 #endif /* _UAPI_ASM_RISCV_SIGCONTEXT_H */
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 37e3e6a8d877..80316ef7bb78 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -75,6 +75,8 @@ void asm_offsets(void)
 	OFFSET(TSK_STACK_CANARY, task_struct, stack_canary);
 #endif
 
+	OFFSET(RISCV_V_STATE_MAGIC, __riscv_ctx_hdr, magic);
+	OFFSET(RISCV_V_STATE_SIZE, __riscv_ctx_hdr, size);
 	OFFSET(RISCV_V_STATE_VSTART, __riscv_v_state, vstart);
 	OFFSET(RISCV_V_STATE_VL, __riscv_v_state, vl);
 	OFFSET(RISCV_V_STATE_VTYPE, __riscv_v_state, vtype);
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 834eb652a7b9..36b55669b2da 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -260,6 +260,8 @@ static void __init parse_dtb(void)
 #endif
 }
 
+extern void __init init_rt_signal_env(void);
+
 void __init setup_arch(char **cmdline_p)
 {
 	parse_dtb();
@@ -295,6 +297,8 @@ void __init setup_arch(char **cmdline_p)
 #endif
 
 	riscv_fill_hwcap();
+
+	init_rt_signal_env();
 }
 
 static int __init topology_init(void)
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 9f4e59f80551..21b48bddeb8f 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -18,15 +18,16 @@
 #include <asm/csr.h>
 
 extern u32 __user_rt_sigreturn[2];
+static size_t rvv_sc_size;
 
 #define DEBUG_SIG 0
 
 struct rt_sigframe {
 	struct siginfo info;
-	struct ucontext uc;
 #ifndef CONFIG_MMU
 	u32 sigreturn_code[2];
 #endif
+	struct ucontext uc;
 };
 
 #ifdef CONFIG_FPU
@@ -83,16 +84,155 @@ static long save_fp_state(struct pt_regs *regs,
 #define restore_fp_state(task, regs) (0)
 #endif
 
+#ifdef CONFIG_VECTOR
+static long restore_v_state(struct pt_regs *regs, void **sc_reserved_ptr)
+{
+	long err;
+	struct __sc_riscv_v_state __user *state = (struct __sc_riscv_v_state *)(*sc_reserved_ptr);
+	void *datap;
+	__u32 magic;
+	__u32 size;
+
+	/* Get magic number and check it. */
+	err = __get_user(magic, &state->head.magic);
+	err = __get_user(size, &state->head.size);
+	if (unlikely(err))
+		return err;
+
+	if (magic != RVV_MAGIC || size != rvv_sc_size)
+		return -EINVAL;
+
+	/* Copy everything of __sc_riscv_v_state except datap. */
+	err = __copy_from_user(&current->thread.vstate, &state->v_state,
+			       RISCV_V_STATE_DATAP);
+	if (unlikely(err))
+		return err;
+
+	/* Copy the pointer datap itself. */
+	err = __get_user(datap, &state->v_state.datap);
+	if (unlikely(err))
+		return err;
+
+
+	/* Copy the whole vector content from user space datap. */
+	err = __copy_from_user(current->thread.vstate.datap, datap, riscv_vsize);
+	if (unlikely(err))
+		return err;
+
+	vstate_restore(current, regs);
+
+	/* Move sc_reserved_ptr to point the next signal context frame. */
+	*sc_reserved_ptr += size;
+
+	return err;
+}
+
+static long save_v_state(struct pt_regs *regs, void **sc_reserved_free_ptr)
+{
+	/*
+	 * Put __sc_riscv_v_state to the user's signal context space pointed
+	 * by sc_reserved_free_ptr and the datap point the address right
+	 * after __sc_riscv_v_state.
+	 */
+	struct __sc_riscv_v_state __user *state = (struct __sc_riscv_v_state *)
+		(*sc_reserved_free_ptr);
+	void *datap = state + 1;
+	long err;
+
+	*sc_reserved_free_ptr += rvv_sc_size;
+
+	err = __put_user(RVV_MAGIC, &state->head.magic);
+	err = __put_user(rvv_sc_size, &state->head.size);
+
+	vstate_save(current, regs);
+	/* Copy everything of vstate but datap. */
+	err = __copy_to_user(&state->v_state, &current->thread.vstate,
+			     RISCV_V_STATE_DATAP);
+	if (unlikely(err))
+		return err;
+
+	/* Copy the pointer datap itself. */
+	err = __put_user(datap, &state->v_state.datap);
+	if (unlikely(err))
+		return err;
+
+	/* Copy the whole vector content to user space datap. */
+	err = __copy_to_user(datap, current->thread.vstate.datap, riscv_vsize);
+
+	return err;
+}
+#else
+#define save_v_state(task, regs) (0)
+#define restore_v_state(task, regs) (0)
+#endif
+
 static long restore_sigcontext(struct pt_regs *regs,
 	struct sigcontext __user *sc)
 {
 	long err;
+	void *sc_reserved_ptr = sc->__reserved;
 	/* sc_regs is structured the same as the start of pt_regs */
 	err = __copy_from_user(regs, &sc->sc_regs, sizeof(sc->sc_regs));
 	/* Restore the floating-point state. */
 	if (has_fpu())
 		err |= restore_fp_state(regs, &sc->sc_fpregs);
+
+	while (1 && !err) {
+		__u32 magic, size;
+		struct __riscv_ctx_hdr *head = (struct __riscv_ctx_hdr *)sc_reserved_ptr;
+
+		err |= __get_user(magic, &head->magic);
+		err |= __get_user(size, &head->size);
+		if (err)
+			goto done;
+
+		switch (magic) {
+		case 0:
+			if (size)
+				goto invalid;
+			goto done;
+		case RVV_MAGIC:
+			if (!has_vector())
+				goto invalid;
+			if (size != rvv_sc_size)
+				goto invalid;
+			err |= restore_v_state(regs, &sc_reserved_ptr);
+			break;
+		default:
+			goto invalid;
+		}
+	}
+done:
 	return err;
+
+invalid:
+	return -EINVAL;
+}
+
+static size_t cal_rt_frame_size(void)
+{
+	struct rt_sigframe __user *frame;
+	static size_t frame_size;
+	size_t total_context_size = 0;
+	size_t sc_reserved_size = sizeof(frame->uc.uc_mcontext.__reserved);
+
+	if (frame_size)
+		goto done;
+
+	frame_size = sizeof(*frame);
+
+	if (has_vector())
+		total_context_size += rvv_sc_size;
+	/* Preserved a __riscv_ctx_hdr for END signal context header. */
+	total_context_size += sizeof(struct __riscv_ctx_hdr);
+
+	if (total_context_size > sc_reserved_size)
+		frame_size += (total_context_size - sc_reserved_size);
+
+	frame_size = round_up(frame_size, 16);
+done:
+	return frame_size;
+
 }
 
 SYSCALL_DEFINE0(rt_sigreturn)
@@ -101,13 +241,14 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	struct rt_sigframe __user *frame;
 	struct task_struct *task;
 	sigset_t set;
+	size_t frame_size = cal_rt_frame_size();
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
 	frame = (struct rt_sigframe __user *)regs->sp;
 
-	if (!access_ok(frame, sizeof(*frame)))
+	if (!access_ok(frame, frame_size))
 		goto badframe;
 
 	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
@@ -140,11 +281,20 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
 {
 	struct sigcontext __user *sc = &frame->uc.uc_mcontext;
 	long err;
+	void *sc_reserved_free_ptr = sc->__reserved;
+
 	/* sc_regs is structured the same as the start of pt_regs */
 	err = __copy_to_user(&sc->sc_regs, regs, sizeof(sc->sc_regs));
 	/* Save the floating-point state. */
 	if (has_fpu())
 		err |= save_fp_state(regs, &sc->sc_fpregs);
+	/* Save the vector state. */
+	if (has_vector())
+		err |= save_v_state(regs, &sc_reserved_free_ptr);
+
+	/* Put END __riscv_ctx_hdr at the end. */
+	err = __put_user(END_MAGIC, &((struct __riscv_ctx_hdr *)sc_reserved_free_ptr)->magic);
+	err = __put_user(END_HDR_SIZE, &((struct __riscv_ctx_hdr *)sc_reserved_free_ptr)->size);
 	return err;
 }
 
@@ -176,9 +326,10 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 {
 	struct rt_sigframe __user *frame;
 	long err = 0;
+	size_t frame_size = cal_rt_frame_size();
 
-	frame = get_sigframe(ksig, regs, sizeof(*frame));
-	if (!access_ok(frame, sizeof(*frame)))
+	frame = get_sigframe(ksig, regs, frame_size);
+	if (!access_ok(frame, frame_size))
 		return -EFAULT;
 
 	err |= copy_siginfo_to_user(&frame->info, &ksig->info);
@@ -321,3 +472,9 @@ asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
 	if (thread_info_flags & _TIF_NOTIFY_RESUME)
 		resume_user_mode_work(regs);
 }
+
+void init_rt_signal_env(void);
+void __init init_rt_signal_env(void)
+{
+	rvv_sc_size = sizeof(struct __sc_riscv_v_state) + riscv_vsize;
+}
-- 
2.17.1

