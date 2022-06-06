Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4B953F05B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbiFFUnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiFFUmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:42:32 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999FCED737
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:38:52 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id i66so21215273oia.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mqR3X/F3Pv3CiLzjWRVRYnBoua48jzxnCD1fH10NX1o=;
        b=IdlaCmhNQV92UfWSRiLtS5CoqgLmkwQZd9jIk90nIai7D8mxkN9zkeAfCZLuGPsiEW
         gv3d4QSRbn9bLGKaRaKAu0mA9tZUlPahF8DyMngNzdPIdWCThtFmsPMTyAUHbYgv/Avo
         DUHpowpgnEM++fz+bTQugavl+BBGsStliPD7jeODDJZKSq0qyudYIFRkmwhXcd3Z4MFg
         lLYrn9s0lm/UUKoLK09ukii5DspA9LqsDpobune5GaxWg2VTZq4l/RoUgeeMjYnl7dzq
         La24GcfP2kg7dsxR7dSvG0gohuhv8iIWZMSiT8pkDSIH5E9haQelFYWQKXef1uAj0ZbM
         agRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mqR3X/F3Pv3CiLzjWRVRYnBoua48jzxnCD1fH10NX1o=;
        b=ac30AKGmYtLi+rf4zyCa7dc7+LT6dtsAENGZ9EDUuR2m66yC+sWnpmnzepz2MMkij+
         Kctlxz8ZmyZeaUMoRGNLs+Z5OHwGw6JQXCzMJOBZnB0jYF9o8LXSeIc6gVO4pnkI1zEe
         3/sKvn2JWsO7wPSQ7ziJoq+0uHfitAif/1vieUU8ox99ClIISll9UfFD+5+pypZZry83
         x9jbqgpDFG86Rh60mwiu7xCpTVWVMp/Yop9mrX+rSEBs6SUjXFYZWJj8Vm4yu2n0tTBS
         5+3sKo2M+ucvYL+oW/70LpYw4ZRBB7Cu9DdcbQ34CJqm6WS6gWAYpct6vPy4kLTvZYv5
         Fe+Q==
X-Gm-Message-State: AOAM530h4VhnIYOiczfvOSu2n/tTWBpKnaIXhzb9uOg+Bn8vdrt4ZSgE
        IeRLwlduR298/J//urniMjDQnQJInw==
X-Google-Smtp-Source: ABdhPJzyOUqEiHvMYNpcIZyc7v1oJuOZpS/iz0xSZ2Ghr+wXo6osxkaehPKnhPHE1ZBiR7Rlef2fEg==
X-Received: by 2002:a05:6808:1825:b0:32b:a1e9:fdb6 with SMTP id bh37-20020a056808182500b0032ba1e9fdb6mr31104546oib.73.1654547931735;
        Mon, 06 Jun 2022 13:38:51 -0700 (PDT)
Received: from citadel.. (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id j22-20020a056808035600b0032e3cca8561sm4327188oie.21.2022.06.06.13.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:38:51 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 4/8] x86: Remove __USER32_DS
Date:   Mon,  6 Jun 2022 16:37:58 -0400
Message-Id: <20220606203802.158958-5-brgerst@gmail.com>
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

Replace all users with the equivalent __USER_DS, which will make merging
native and compat code simpler.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/entry/entry_64_compat.S |  4 ++--
 arch/x86/ia32/ia32_signal.c      | 14 +++++++-------
 arch/x86/include/asm/elf.h       |  4 ----
 arch/x86/include/asm/segment.h   |  1 -
 arch/x86/xen/xen-asm.S           |  8 ++++----
 5 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index d1052742ad0c..cd51d1f70382 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -59,7 +59,7 @@ SYM_CODE_START(entry_SYSENTER_compat)
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 	/* Construct struct pt_regs on stack */
-	pushq	$__USER32_DS		/* pt_regs->ss */
+	pushq	$__USER_DS		/* pt_regs->ss */
 	pushq	$0			/* pt_regs->sp = 0 (placeholder) */
 
 	/*
@@ -192,7 +192,7 @@ SYM_INNER_LABEL(entry_SYSCALL_compat_safe_stack, SYM_L_GLOBAL)
 	ANNOTATE_NOENDBR
 
 	/* Construct struct pt_regs on stack */
-	pushq	$__USER32_DS		/* pt_regs->ss */
+	pushq	$__USER_DS		/* pt_regs->ss */
 	pushq	%r8			/* pt_regs->sp */
 	pushq	%r11			/* pt_regs->flags */
 	pushq	$__USER32_CS		/* pt_regs->cs */
diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index b67e27685d46..a78885e3e85d 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -212,7 +212,7 @@ static void __user *get_sigframe(struct ksignal *ksig, struct pt_regs *regs,
 	if (ksig->ka.sa.sa_flags & SA_ONSTACK)
 		sp = sigsp(sp, ksig);
 	/* This is the legacy signal stack switching. */
-	else if (regs->ss != __USER32_DS &&
+	else if (regs->ss != __USER_DS &&
 		!(ksig->ka.sa.sa_flags & SA_RESTORER) &&
 		 ksig->ka.sa.sa_restorer)
 		sp = (unsigned long) ksig->ka.sa.sa_restorer;
@@ -284,11 +284,11 @@ int ia32_setup_frame(struct ksignal *ksig, struct pt_regs *regs)
 	regs->dx = 0;
 	regs->cx = 0;
 
-	loadsegment(ds, __USER32_DS);
-	loadsegment(es, __USER32_DS);
+	loadsegment(ds, __USER_DS);
+	loadsegment(es, __USER_DS);
 
 	regs->cs = __USER32_CS;
-	regs->ss = __USER32_DS;
+	regs->ss = __USER_DS;
 
 	return 0;
 Efault:
@@ -361,11 +361,11 @@ int ia32_setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs)
 	regs->dx = (unsigned long) &frame->info;
 	regs->cx = (unsigned long) &frame->uc;
 
-	loadsegment(ds, __USER32_DS);
-	loadsegment(es, __USER32_DS);
+	loadsegment(ds, __USER_DS);
+	loadsegment(es, __USER_DS);
 
 	regs->cs = __USER32_CS;
-	regs->ss = __USER32_DS;
+	regs->ss = __USER_DS;
 
 	return 0;
 Efault:
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index cb0ff1055ab1..be8b58da63b9 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -152,10 +152,6 @@ do {						\
 	(elf_check_arch_ia32(x) ||					\
 	 (IS_ENABLED(CONFIG_X86_X32_ABI) && (x)->e_machine == EM_X86_64))
 
-#if __USER32_DS != __USER_DS
-# error "The following code assumes __USER32_DS == __USER_DS"
-#endif
-
 static inline void elf_common_init(struct thread_struct *t,
 				   struct pt_regs *regs, const u16 ds)
 {
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 2e7890dd58a4..e056c29dfcda 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -210,7 +210,6 @@
 #define __KERNEL_DS			(GDT_ENTRY_KERNEL_DS*8)
 #define __USER32_CS			(GDT_ENTRY_DEFAULT_USER32_CS*8 + 3)
 #define __USER_DS			(GDT_ENTRY_DEFAULT_USER_DS*8 + 3)
-#define __USER32_DS			__USER_DS
 #define __USER_CS			(GDT_ENTRY_DEFAULT_USER_CS*8 + 3)
 #define __CPUNODE_SEG			(GDT_ENTRY_CPUNODE*8 + 3)
 
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index caa9bc2fa100..350174cf9d71 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -262,10 +262,10 @@ SYM_CODE_START(xen_syscall32_target)
 
 	/*
 	 * Neither Xen nor the kernel really knows what the old SS and
-	 * CS were.  The kernel expects __USER32_DS and __USER32_CS, so
+	 * CS were.  The kernel expects __USER_DS and __USER32_CS, so
 	 * report those values even though Xen will guess its own values.
 	 */
-	movq $__USER32_DS, 4*8(%rsp)
+	movq $__USER_DS, 4*8(%rsp)
 	movq $__USER32_CS, 1*8(%rsp)
 
 	jmp entry_SYSCALL_compat_after_hwframe
@@ -284,10 +284,10 @@ SYM_CODE_START(xen_sysenter_target)
 
 	/*
 	 * Neither Xen nor the kernel really knows what the old SS and
-	 * CS were.  The kernel expects __USER32_DS and __USER32_CS, so
+	 * CS were.  The kernel expects __USER_DS and __USER32_CS, so
 	 * report those values even though Xen will guess its own values.
 	 */
-	movq $__USER32_DS, 4*8(%rsp)
+	movq $__USER_DS, 4*8(%rsp)
 	movq $__USER32_CS, 1*8(%rsp)
 
 	jmp entry_SYSENTER_compat_after_hwframe
-- 
2.35.3

