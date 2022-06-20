Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE505527D7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347066AbiFTXNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347048AbiFTXME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:12:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241331D329;
        Mon, 20 Jun 2022 16:10:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAF37614FF;
        Mon, 20 Jun 2022 23:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0781C341D5;
        Mon, 20 Jun 2022 23:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766632;
        bh=XyRgtSbvWle6eQPE5MOjMSTVqyJ2jrzKSkJQdZ5O6o8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JVqiBnRG+HmODhNEbcsRCQTKSU4+BRqs6o4v8vUYylnmqjXy6tJJYvTueMlIlnnnJ
         /ClUFh/bZdtS9/d/gPh841Xd1AJ5M5KDMPB3W00mBzdx+dSPHMUqk3vuuj7uE7LAL+
         vuZFfOEB1Bh6Jh8/ZAu9acExFt6i3FO1ilPCnoE6SM6wNbsYVL+fdDL1Zrr47qeb49
         mDkdabgELG75HDhaP9ZIu6KIWvn8RYbz7gG9LlZ5xnF2RNOZz1nk11Em8t5kuuwYbK
         HFYcv/Sr3QXnaXY5T6KhZchxRnQRMr8bVr4vMuRczyadsXN+RsdXvrNSDLgQSFNurM
         LYH/k8Abx4MHw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5CD365C0D1B; Mon, 20 Jun 2022 16:10:31 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>, Phil Auld <pauld@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alex Belits <abelits@marvell.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 09/23] context_tracking: Split user tracking Kconfig
Date:   Mon, 20 Jun 2022 16:10:15 -0700
Message-Id: <20220620231029.3844583-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620231027.GA3844372@paulmck-ThinkPad-P17-Gen-1>
References: <20220620231027.GA3844372@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

Context tracking is going to be used not only to track user transitions
but also idle/IRQs/NMIs. The user tracking part will then become a
separate feature. Prepare Kconfig for that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../time/context-tracking/arch-support.txt    |  6 ++--
 arch/Kconfig                                  |  4 +--
 arch/arm/Kconfig                              |  2 +-
 arch/arm/kernel/entry-common.S                |  4 +--
 arch/arm/kernel/entry-header.S                |  4 +--
 arch/arm64/Kconfig                            |  2 +-
 arch/csky/Kconfig                             |  2 +-
 arch/csky/kernel/entry.S                      |  4 +--
 arch/mips/Kconfig                             |  2 +-
 arch/powerpc/Kconfig                          |  2 +-
 arch/powerpc/include/asm/context_tracking.h   |  2 +-
 arch/riscv/Kconfig                            |  2 +-
 arch/riscv/kernel/entry.S                     |  6 ++--
 arch/sparc/Kconfig                            |  2 +-
 arch/sparc/kernel/rtrap_64.S                  |  2 +-
 arch/x86/Kconfig                              |  4 +--
 include/linux/context_tracking.h              | 12 +++----
 include/linux/context_tracking_state.h        |  4 +--
 init/Kconfig                                  |  4 +--
 kernel/context_tracking.c                     |  6 +++-
 kernel/sched/core.c                           |  2 +-
 kernel/time/Kconfig                           | 31 ++++++++++++-------
 22 files changed, 61 insertions(+), 48 deletions(-)

diff --git a/Documentation/features/time/context-tracking/arch-support.txt b/Documentation/features/time/context-tracking/arch-support.txt
index c9e0a16290e68..e59071a490901 100644
--- a/Documentation/features/time/context-tracking/arch-support.txt
+++ b/Documentation/features/time/context-tracking/arch-support.txt
@@ -1,7 +1,7 @@
 #
-# Feature name:          context-tracking
-#         Kconfig:       HAVE_CONTEXT_TRACKING
-#         description:   arch supports context tracking for NO_HZ_FULL
+# Feature name:          user-context-tracking
+#         Kconfig:       HAVE_CONTEXT_TRACKING_USER
+#         description:   arch supports user context tracking for NO_HZ_FULL
 #
     -----------------------
     |         arch |status|
diff --git a/arch/Kconfig b/arch/Kconfig
index fcf9a41a4ef5b..154b7b78da093 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -774,7 +774,7 @@ config HAVE_ARCH_WITHIN_STACK_FRAMES
 	  and similar) by implementing an inline arch_within_stack_frames(),
 	  which is used by CONFIG_HARDENED_USERCOPY.
 
-config HAVE_CONTEXT_TRACKING
+config HAVE_CONTEXT_TRACKING_USER
 	bool
 	help
 	  Provide kernel/user boundaries probes necessary for subsystems
@@ -785,7 +785,7 @@ config HAVE_CONTEXT_TRACKING
 	  protected inside rcu_irq_enter/rcu_irq_exit() but preemption or signal
 	  handling on irq exit still need to be protected.
 
-config HAVE_CONTEXT_TRACKING_OFFSTACK
+config HAVE_CONTEXT_TRACKING_USER_OFFSTACK
 	bool
 	help
 	  Architecture neither relies on exception_enter()/exception_exit()
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7630ba9cb6ccc..9acc6aac59126 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -84,7 +84,7 @@ config ARM
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARM_LPAE
 	select HAVE_ARM_SMCCC if CPU_V7
 	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
-	select HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_BUILDTIME_MCOUNT_SORT
 	select HAVE_DEBUG_KMEMLEAK if !XIP_KERNEL
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 7aa3ded4af929..37a0125fc9265 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -28,7 +28,7 @@
 #include "entry-header.S"
 
 saved_psr	.req	r8
-#if defined(CONFIG_TRACE_IRQFLAGS) || defined(CONFIG_CONTEXT_TRACKING)
+#if defined(CONFIG_TRACE_IRQFLAGS) || defined(CONFIG_CONTEXT_TRACKING_USER)
 saved_pc	.req	r9
 #define TRACE(x...) x
 #else
@@ -38,7 +38,7 @@ saved_pc	.req	lr
 
 	.section .entry.text,"ax",%progbits
 	.align	5
-#if !(IS_ENABLED(CONFIG_TRACE_IRQFLAGS) || IS_ENABLED(CONFIG_CONTEXT_TRACKING) || \
+#if !(IS_ENABLED(CONFIG_TRACE_IRQFLAGS) || IS_ENABLED(CONFIG_CONTEXT_TRACKING_USER) || \
 	IS_ENABLED(CONFIG_DEBUG_RSEQ))
 /*
  * This is the fast syscall return path.  We do as little as possible here,
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 95def2b38d1ca..99411fa913501 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -366,7 +366,7 @@ ALT_UP_B(.L1_\@)
  * between user and kernel mode.
  */
 	.macro ct_user_exit, save = 1
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 	.if	\save
 	stmdb   sp!, {r0-r3, ip, lr}
 	bl	user_exit_callable
@@ -378,7 +378,7 @@ ALT_UP_B(.L1_\@)
 	.endm
 
 	.macro ct_user_enter, save = 1
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 	.if	\save
 	stmdb   sp!, {r0-r3, ip, lr}
 	bl	user_enter_callable
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1652a9800ebee..7c5dd2af9ca95 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -174,7 +174,7 @@ config ARM64
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
-	select HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 21d72b078eefc..f55ba1745f7b9 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -42,7 +42,7 @@ config CSKY
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_SECCOMP_FILTER
-	select HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select HAVE_DEBUG_BUGVERBOSE
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index bc734d17c16f4..547b4cd1b24b4 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -19,7 +19,7 @@
 .endm
 
 .macro	context_tracking
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 	mfcr	a0, epsr
 	btsti	a0, 31
 	bt	1f
@@ -159,7 +159,7 @@ ret_from_exception:
 	and	r10, r9
 	cmpnei	r10, 0
 	bt	exit_work
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 	jbsr	user_enter_callable
 #endif
 1:
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index db09d45d59ec7..9457894db2375 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -56,7 +56,7 @@ config MIPS
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES
 	select HAVE_ASM_MODVERSIONS
-	select HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_TIF_NOHZ
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index c2ce2e60c8f0f..874c8d81284ad 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -202,7 +202,7 @@ config PPC
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ASM_MODVERSIONS
-	select HAVE_CONTEXT_TRACKING		if PPC64
+	select HAVE_CONTEXT_TRACKING_USER		if PPC64
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_STACKOVERFLOW
diff --git a/arch/powerpc/include/asm/context_tracking.h b/arch/powerpc/include/asm/context_tracking.h
index f2682b28b0502..4b63931c49e0e 100644
--- a/arch/powerpc/include/asm/context_tracking.h
+++ b/arch/powerpc/include/asm/context_tracking.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_POWERPC_CONTEXT_TRACKING_H
 #define _ASM_POWERPC_CONTEXT_TRACKING_H
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 #define SCHEDULE_USER bl	schedule_user
 #else
 #define SCHEDULE_USER bl	schedule
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 32ffef9f6e5b4..29b46f2173457 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -86,7 +86,7 @@ config RISCV
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
 	select HAVE_ASM_MODVERSIONS
-	select HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_EBPF_JIT if MMU
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 12f6bba57e335..b9eda3fcbd6d7 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -111,7 +111,7 @@ _save_context:
 	call __trace_hardirqs_off
 #endif
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 	/* If previous state is in user mode, call user_exit_callable(). */
 	li   a0, SR_PP
 	and a0, s1, a0
@@ -176,7 +176,7 @@ handle_syscall:
 	 */
 	csrs CSR_STATUS, SR_IE
 #endif
-#if defined(CONFIG_TRACE_IRQFLAGS) || defined(CONFIG_CONTEXT_TRACKING)
+#if defined(CONFIG_TRACE_IRQFLAGS) || defined(CONFIG_CONTEXT_TRACKING_USER)
 	/* Recover a0 - a7 for system calls */
 	REG_L a0, PT_A0(sp)
 	REG_L a1, PT_A1(sp)
@@ -269,7 +269,7 @@ resume_userspace:
 	andi s1, s0, _TIF_WORK_MASK
 	bnez s1, work_pending
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 	call user_enter_callable
 #endif
 
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index ba449c47effd8..9232411a8821a 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -71,7 +71,7 @@ config SPARC64
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_SYSCALL_TRACEPOINTS
-	select HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_TIF_NOHZ
 	select HAVE_DEBUG_KMEMLEAK
 	select IOMMU_HELPER
diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
index c5fd4b450d9b6..eef102765a7e2 100644
--- a/arch/sparc/kernel/rtrap_64.S
+++ b/arch/sparc/kernel/rtrap_64.S
@@ -15,7 +15,7 @@
 #include <asm/visasm.h>
 #include <asm/processor.h>
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 # define SCHEDULE_USER schedule_user
 #else
 # define SCHEDULE_USER schedule
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be0b95e51df66..b0a6dbbb760bc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -186,8 +186,8 @@ config X86
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
-	select HAVE_CONTEXT_TRACKING		if X86_64
-	select HAVE_CONTEXT_TRACKING_OFFSTACK	if HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING_USER		if X86_64
+	select HAVE_CONTEXT_TRACKING_USER_OFFSTACK	if HAVE_CONTEXT_TRACKING_USER
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_OBJTOOL_MCOUNT		if HAVE_OBJTOOL
 	select HAVE_BUILDTIME_MCOUNT_SORT
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 63259fece7c76..e35ae66b4794e 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -10,7 +10,7 @@
 #include <asm/ptrace.h>
 
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 extern void ct_cpu_track_user(int cpu);
 
 /* Called with interrupts disabled.  */
@@ -52,7 +52,7 @@ static inline enum ctx_state exception_enter(void)
 {
 	enum ctx_state prev_ctx;
 
-	if (IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK) ||
+	if (IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK) ||
 	    !context_tracking_enabled())
 		return 0;
 
@@ -65,7 +65,7 @@ static inline enum ctx_state exception_enter(void)
 
 static inline void exception_exit(enum ctx_state prev_ctx)
 {
-	if (!IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK) &&
+	if (!IS_ENABLED(CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK) &&
 	    context_tracking_enabled()) {
 		if (prev_ctx != CONTEXT_KERNEL)
 			ct_user_enter(prev_ctx);
@@ -109,14 +109,14 @@ static inline enum ctx_state ct_state(void) { return CONTEXT_DISABLED; }
 static __always_inline bool context_tracking_guest_enter(void) { return false; }
 static inline void context_tracking_guest_exit(void) { }
 
-#endif /* !CONFIG_CONTEXT_TRACKING */
+#endif /* !CONFIG_CONTEXT_TRACKING_USER */
 
 #define CT_WARN_ON(cond) WARN_ON(context_tracking_enabled() && (cond))
 
-#ifdef CONFIG_CONTEXT_TRACKING_FORCE
+#ifdef CONFIG_CONTEXT_TRACKING_USER_FORCE
 extern void context_tracking_init(void);
 #else
 static inline void context_tracking_init(void) { }
-#endif /* CONFIG_CONTEXT_TRACKING_FORCE */
+#endif /* CONFIG_CONTEXT_TRACKING_USER_FORCE */
 
 #endif
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index edc7b46376a6b..2b46afe105a96 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -22,7 +22,7 @@ struct context_tracking {
 	} state;
 };
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 extern struct static_key_false context_tracking_key;
 DECLARE_PER_CPU(struct context_tracking, context_tracking);
 
@@ -45,6 +45,6 @@ static inline bool context_tracking_enabled_this_cpu(void)
 static __always_inline bool context_tracking_enabled(void) { return false; }
 static __always_inline bool context_tracking_enabled_cpu(int cpu) { return false; }
 static __always_inline bool context_tracking_enabled_this_cpu(void) { return false; }
-#endif /* CONFIG_CONTEXT_TRACKING */
+#endif /* CONFIG_CONTEXT_TRACKING_USER */
 
 #endif
diff --git a/init/Kconfig b/init/Kconfig
index c7900e8975f18..06454d19e2f0a 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -494,11 +494,11 @@ config VIRT_CPU_ACCOUNTING_NATIVE
 
 config VIRT_CPU_ACCOUNTING_GEN
 	bool "Full dynticks CPU time accounting"
-	depends on HAVE_CONTEXT_TRACKING
+	depends on HAVE_CONTEXT_TRACKING_USER
 	depends on HAVE_VIRT_CPU_ACCOUNTING_GEN
 	depends on GENERIC_CLOCKEVENTS
 	select VIRT_CPU_ACCOUNTING
-	select CONTEXT_TRACKING
+	select CONTEXT_TRACKING_USER
 	help
 	  Select this option to enable task and CPU time accounting on full
 	  dynticks systems. This accounting is implemented by watching every
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 7f457a1a1b551..a6997daf27d10 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -22,6 +22,8 @@
 #include <linux/export.h>
 #include <linux/kprobes.h>
 
+#ifdef CONFIG_CONTEXT_TRACKING_USER
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/context_tracking.h>
 
@@ -252,7 +254,7 @@ void __init ct_cpu_track_user(int cpu)
 	initialized = true;
 }
 
-#ifdef CONFIG_CONTEXT_TRACKING_FORCE
+#ifdef CONFIG_CONTEXT_TRACKING_USER_FORCE
 void __init context_tracking_init(void)
 {
 	int cpu;
@@ -261,3 +263,5 @@ void __init context_tracking_init(void)
 		ct_cpu_track_user(cpu);
 }
 #endif
+
+#endif /* #ifdef CONFIG_CONTEXT_TRACKING_USER */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da0bf6fe9ecdc..883167a57bf9d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6559,7 +6559,7 @@ void __sched schedule_idle(void)
 	} while (need_resched());
 }
 
-#if defined(CONFIG_CONTEXT_TRACKING) && !defined(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK)
+#if defined(CONFIG_CONTEXT_TRACKING_USER) && !defined(CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK)
 asmlinkage __visible void __sched schedule_user(void)
 {
 	/*
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 27b7868b5c30d..41f99bcfe9e66 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -73,6 +73,9 @@ config TIME_KUNIT_TEST
 
 	  If unsure, say N.
 
+config CONTEXT_TRACKING
+	bool
+
 if GENERIC_CLOCKEVENTS
 menu "Timers subsystem"
 
@@ -111,7 +114,7 @@ config NO_HZ_FULL
 	# NO_HZ_COMMON dependency
 	# We need at least one periodic CPU for timekeeping
 	depends on SMP
-	depends on HAVE_CONTEXT_TRACKING
+	depends on HAVE_CONTEXT_TRACKING_USER
 	# VIRT_CPU_ACCOUNTING_GEN dependency
 	depends on HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select NO_HZ_COMMON
@@ -137,31 +140,37 @@ config NO_HZ_FULL
 
 endchoice
 
-config CONTEXT_TRACKING
-       bool
+config CONTEXT_TRACKING_USER
+	bool
+	depends on HAVE_CONTEXT_TRACKING_USER
+	select CONTEXT_TRACKING
+	help
+	  Track transitions between kernel and user on behalf of RCU and
+	  tickless cputime accounting. The former case relies on context
+	  tracking to enter/exit RCU extended quiescent states.
 
-config CONTEXT_TRACKING_FORCE
-	bool "Force context tracking"
-	depends on CONTEXT_TRACKING
+config CONTEXT_TRACKING_USER_FORCE
+	bool "Force user context tracking"
+	depends on CONTEXT_TRACKING_USER
 	default y if !NO_HZ_FULL
 	help
 	  The major pre-requirement for full dynticks to work is to
-	  support the context tracking subsystem. But there are also
+	  support the user context tracking subsystem. But there are also
 	  other dependencies to provide in order to make the full
 	  dynticks working.
 
 	  This option stands for testing when an arch implements the
-	  context tracking backend but doesn't yet fulfill all the
+	  user context tracking backend but doesn't yet fulfill all the
 	  requirements to make the full dynticks feature working.
 	  Without the full dynticks, there is no way to test the support
-	  for context tracking and the subsystems that rely on it: RCU
+	  for user context tracking and the subsystems that rely on it: RCU
 	  userspace extended quiescent state and tickless cputime
 	  accounting. This option copes with the absence of the full
-	  dynticks subsystem by forcing the context tracking on all
+	  dynticks subsystem by forcing the user context tracking on all
 	  CPUs in the system.
 
 	  Say Y only if you're working on the development of an
-	  architecture backend for the context tracking.
+	  architecture backend for the user context tracking.
 
 	  Say N otherwise, this option brings an overhead that you
 	  don't want in production.
-- 
2.31.1.189.g2e36527f23

