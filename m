Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2994CA986
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiCBPtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240800AbiCBPtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:49:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C493A245BC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:48:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DBAF61740
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 15:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959AAC340F1;
        Wed,  2 Mar 2022 15:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646236115;
        bh=ciXcyYnIUVWExVMqLuzRBy8vgRjard065bDchEbcTs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TbZvc5/UIWFsfc7rYEkraQyV9eKqT8MH44NZoAIjxi5PaQ0L/t/vx6oxHNVilK2Wa
         xKjKNsC8NryFAn1St/x9Yr0ChR15pieKzuEwV1IETbFNV0jf6RMCSX8/P7OGTTB0f3
         2qaFZVlaK3RrTZ5h2kTpp6KR/VWYJ5/gvBK7KGADdMKotRfquejPzvkqUxnAu2RkId
         NQkMVaF2lNTlXZqNQcUrwpOu9YZiDtsXb1IQeAieU9NED+KpYRF6Q6KdJgDzhE9X2D
         tMyVTPHQ5uCVGNsAI30SAV0KKg6W7zS0DP5ch7o2Liw7rMxo1k7Q3rHLY9FO6MCyBA
         7YZCILkzbP9CQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 05/19] context_tracking: Split user tracking Kconfig
Date:   Wed,  2 Mar 2022 16:47:56 +0100
Message-Id: <20220302154810.42308-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302154810.42308-1-frederic@kernel.org>
References: <20220302154810.42308-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Context tracking is going to be used not only to track user transitions
but also idle/IRQs/NMIs. The user tracking part will then become a
seperate feature. Prepare Kconfig for that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Yu Liao<liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
---
 .../time/context-tracking/arch-support.txt    |  6 ++---
 arch/Kconfig                                  |  4 ++--
 arch/arm/Kconfig                              |  2 +-
 arch/arm/kernel/entry-common.S                |  4 ++--
 arch/arm/kernel/entry-header.S                |  4 ++--
 arch/arm64/Kconfig                            |  2 +-
 arch/csky/Kconfig                             |  2 +-
 arch/csky/kernel/entry.S                      |  4 ++--
 arch/mips/Kconfig                             |  2 +-
 arch/powerpc/Kconfig                          |  2 +-
 arch/powerpc/include/asm/context_tracking.h   |  2 +-
 arch/riscv/Kconfig                            |  2 +-
 arch/riscv/kernel/entry.S                     |  6 ++---
 arch/sparc/Kconfig                            |  2 +-
 arch/sparc/kernel/rtrap_64.S                  |  2 +-
 arch/x86/Kconfig                              |  4 ++--
 include/linux/context_tracking.h              | 12 +++++-----
 include/linux/context_tracking_state.h        |  4 ++--
 init/Kconfig                                  |  4 ++--
 kernel/context_tracking.c                     |  6 ++++-
 kernel/sched/core.c                           |  2 +-
 kernel/time/Kconfig                           | 22 +++++++++++--------
 22 files changed, 54 insertions(+), 46 deletions(-)

diff --git a/Documentation/features/time/context-tracking/arch-support.txt b/Documentation/features/time/context-tracking/arch-support.txt
index 4ed116c2ec39..0696fd08429e 100644
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
index 678a80713b21..1a3b79cfc9e3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -762,7 +762,7 @@ config HAVE_ARCH_WITHIN_STACK_FRAMES
 	  and similar) by implementing an inline arch_within_stack_frames(),
 	  which is used by CONFIG_HARDENED_USERCOPY.
 
-config HAVE_CONTEXT_TRACKING
+config HAVE_CONTEXT_TRACKING_USER
 	bool
 	help
 	  Provide kernel/user boundaries probes necessary for subsystems
@@ -773,7 +773,7 @@ config HAVE_CONTEXT_TRACKING
 	  protected inside rcu_irq_enter/rcu_irq_exit() but preemption or signal
 	  handling on irq exit still need to be protected.
 
-config HAVE_CONTEXT_TRACKING_OFFSTACK
+config HAVE_CONTEXT_TRACKING_USER_OFFSTACK
 	bool
 	help
 	  Architecture neither relies on exception_enter()/exception_exit()
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fabe39169b12..2c5688f20421 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -81,7 +81,7 @@ config ARM
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if ARM_LPAE
 	select HAVE_ARM_SMCCC if CPU_V7
 	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
-	select HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK if !XIP_KERNEL
 	select HAVE_DMA_CONTIGUOUS if MMU
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index ac86c34682bb..5be34b7fe41e 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -26,7 +26,7 @@
 #include "entry-header.S"
 
 saved_psr	.req	r8
-#if defined(CONFIG_TRACE_IRQFLAGS) || defined(CONFIG_CONTEXT_TRACKING)
+#if defined(CONFIG_TRACE_IRQFLAGS) || defined(CONFIG_CONTEXT_TRACKING_USER)
 saved_pc	.req	r9
 #define TRACE(x...) x
 #else
@@ -36,7 +36,7 @@ saved_pc	.req	lr
 
 	.section .entry.text,"ax",%progbits
 	.align	5
-#if !(IS_ENABLED(CONFIG_TRACE_IRQFLAGS) || IS_ENABLED(CONFIG_CONTEXT_TRACKING) || \
+#if !(IS_ENABLED(CONFIG_TRACE_IRQFLAGS) || IS_ENABLED(CONFIG_CONTEXT_TRACKING_USER) || \
 	IS_ENABLED(CONFIG_DEBUG_RSEQ))
 /*
  * This is the fast syscall return path.  We do as little as possible here,
diff --git a/arch/arm/kernel/entry-header.S b/arch/arm/kernel/entry-header.S
index 3af2a521e1d6..cd1ce0a9c652 100644
--- a/arch/arm/kernel/entry-header.S
+++ b/arch/arm/kernel/entry-header.S
@@ -361,7 +361,7 @@
  * between user and kernel mode.
  */
 	.macro ct_user_exit, save = 1
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 	.if	\save
 	stmdb   sp!, {r0-r3, ip, lr}
 	bl	user_exit_callable
@@ -373,7 +373,7 @@
 	.endm
 
 	.macro ct_user_enter, save = 1
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 	.if	\save
 	stmdb   sp!, {r0-r3, ip, lr}
 	bl	user_enter_callable
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6978140edfa4..96e75d7fa0a3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -169,7 +169,7 @@ config ARM64
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
-	select HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 132f43f12dd8..c94cc907b828 100644
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
index bc734d17c16f..547b4cd1b24b 100644
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
index 058446f01487..efcab39667ea 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -55,7 +55,7 @@ config MIPS
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if CPU_SUPPORTS_HUGEPAGES
 	select HAVE_ASM_MODVERSIONS
-	select HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_TIF_NOHZ
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b779603978e1..9a889f919fed 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -192,7 +192,7 @@ config PPC
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ASM_MODVERSIONS
-	select HAVE_CONTEXT_TRACKING		if PPC64
+	select HAVE_CONTEXT_TRACKING_USER		if PPC64
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_STACKOVERFLOW
diff --git a/arch/powerpc/include/asm/context_tracking.h b/arch/powerpc/include/asm/context_tracking.h
index f2682b28b050..4b63931c49e0 100644
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
index 5adcbd9b5e88..36953ec26294 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -80,7 +80,7 @@ config RISCV
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
 	select HAVE_ASM_MODVERSIONS
-	select HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING_USER
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS if MMU
 	select HAVE_EBPF_JIT if MMU
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 5fbaa7be18a2..a773526fb3cc 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -111,7 +111,7 @@ _save_context:
 	call trace_hardirqs_off
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
@@ -251,7 +251,7 @@ resume_userspace:
 	andi s1, s0, _TIF_WORK_MASK
 	bnez s1, work_pending
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 	call user_enter_callable
 #endif
 
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 1cab1b284f1a..e736120f4333 100644
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
index c5fd4b450d9b..eef102765a7e 100644
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
index ebe8fc76949a..fbda20f6cf08 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -182,8 +182,8 @@ config X86
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_CMPXCHG_DOUBLE
 	select HAVE_CMPXCHG_LOCAL
-	select HAVE_CONTEXT_TRACKING		if X86_64
-	select HAVE_CONTEXT_TRACKING_OFFSTACK	if HAVE_CONTEXT_TRACKING
+	select HAVE_CONTEXT_TRACKING_USER		if X86_64
+	select HAVE_CONTEXT_TRACKING_USER_OFFSTACK	if HAVE_CONTEXT_TRACKING_USER
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_OBJTOOL_MCOUNT		if STACK_VALIDATION
 	select HAVE_DEBUG_KMEMLEAK
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index 40badd62ad56..75738f20e111 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -10,7 +10,7 @@
 #include <asm/ptrace.h>
 
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 extern void context_tracking_cpu_track_user(int cpu);
 
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
index 65a60d3313b0..64dbbb880378 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -22,7 +22,7 @@ struct context_tracking {
 	} state;
 };
 
-#ifdef CONFIG_CONTEXT_TRACKING
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 extern struct static_key_false context_tracking_key;
 DECLARE_PER_CPU(struct context_tracking, context_tracking);
 
@@ -50,6 +50,6 @@ static inline bool context_tracking_in_user(void) { return false; }
 static inline bool context_tracking_enabled(void) { return false; }
 static inline bool context_tracking_enabled_cpu(int cpu) { return false; }
 static inline bool context_tracking_enabled_this_cpu(void) { return false; }
-#endif /* CONFIG_CONTEXT_TRACKING */
+#endif /* CONFIG_CONTEXT_TRACKING_USER */
 
 #endif
diff --git a/init/Kconfig b/init/Kconfig
index e9119bf54b1f..22525443de90 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -498,11 +498,11 @@ config VIRT_CPU_ACCOUNTING_NATIVE
 
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
index 7b6643d2075d..42054841af3f 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -22,6 +22,8 @@
 #include <linux/export.h>
 #include <linux/kprobes.h>
 
+#ifdef CONFIG_CONTEXT_TRACKING_USER
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/context_tracking.h>
 
@@ -222,7 +224,7 @@ void __init context_tracking_cpu_track_user(int cpu)
 	initialized = true;
 }
 
-#ifdef CONFIG_CONTEXT_TRACKING_FORCE
+#ifdef CONFIG_CONTEXT_TRACKING_USER_FORCE
 void __init context_tracking_init(void)
 {
 	int cpu;
@@ -231,3 +233,5 @@ void __init context_tracking_init(void)
 		context_tracking_cpu_track_user(cpu);
 }
 #endif
+
+#endif /* #ifdef CONFIG_CONTEXT_TRACKING_USER */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2e4ae00e52d1..e79485afb58c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6398,7 +6398,7 @@ void __sched schedule_idle(void)
 	} while (need_resched());
 }
 
-#if defined(CONFIG_CONTEXT_TRACKING) && !defined(CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK)
+#if defined(CONFIG_CONTEXT_TRACKING_USER) && !defined(CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK)
 asmlinkage __visible void __sched schedule_user(void)
 {
 	/*
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 27b7868b5c30..aad89cc96787 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -111,7 +111,7 @@ config NO_HZ_FULL
 	# NO_HZ_COMMON dependency
 	# We need at least one periodic CPU for timekeeping
 	depends on SMP
-	depends on HAVE_CONTEXT_TRACKING
+	depends on HAVE_CONTEXT_TRACKING_USER
 	# VIRT_CPU_ACCOUNTING_GEN dependency
 	depends on HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select NO_HZ_COMMON
@@ -140,28 +140,32 @@ endchoice
 config CONTEXT_TRACKING
        bool
 
-config CONTEXT_TRACKING_FORCE
-	bool "Force context tracking"
-	depends on CONTEXT_TRACKING
+config CONTEXT_TRACKING_USER
+       select CONTEXT_TRACKING
+       bool
+
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
2.25.1

