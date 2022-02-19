Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405824BC7A8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 11:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240914AbiBSKVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 05:21:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbiBSKVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:21:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C25ED85;
        Sat, 19 Feb 2022 02:21:26 -0800 (PST)
Date:   Sat, 19 Feb 2022 10:21:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645266084;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bfsmmmgYz6XtuNCc/ZpC5Qhszq+K1zOoaQ9NcczOQzE=;
        b=RwKDmdUFTIYo1RVUbb7oHslS3zPLytGj7TVGcr2zyIYMZkSTijIPxF9g+j1sPx6nQ+FwlQ
        quZ6y7+RA0y3o+qyevVf3AFdVOVIwQHVLlXho2G90N6qpSlK5+kzH4XgljRDcPfsFBjtJR
        Niod7kYWQDTzJey/deOrKWGa6yMLSUUIZduFChQXNMth5Q6lYJJfA5RiGDeWrF9qEbTpQK
        uX+ep6Ky2N5Xz5vRziuD6sJbpooJDEp37oG3QR42igw9O9ePF/4IOXK9m9+QRVQPbIP7ZD
        RPFkTuyVwZ/2BseErYQ5h8FOvRxhkfVmAovufPtiPajQMOcfV84Av2dcdHCcJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645266084;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bfsmmmgYz6XtuNCc/ZpC5Qhszq+K1zOoaQ9NcczOQzE=;
        b=82IkPgMkiDNVRO0oTUQu9O7jrdXgJaWBNUvf/DvGJhWXw2Q3Varo3ibncX4GprJ35PfR31
        OdlM1Fw0u1FolJCQ==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] arm64: Support PREEMPT_DYNAMIC
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220214165216.2231574-8-mark.rutland@arm.com>
References: <20220214165216.2231574-8-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <164526608332.16921.5809069444201168846.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1b2d3451ee50a0968cb9933f726e50b368ba5073
Gitweb:        https://git.kernel.org/tip/1b2d3451ee50a0968cb9933f726e50b368ba5073
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 14 Feb 2022 16:52:16 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 19 Feb 2022 11:11:09 +01:00

arm64: Support PREEMPT_DYNAMIC

This patch enables support for PREEMPT_DYNAMIC on arm64, allowing the
preemption model to be chosen at boot time.

Specifically, this patch selects HAVE_PREEMPT_DYNAMIC_KEY, so that each
preemption function is an out-of-line call with an early return
depending upon a static key. This leaves almost all the codegen up to
the compiler, and side-steps a number of pain points with static calls
(e.g. interaction with CFI schemes). This should have no worse overhead
than using non-inline static calls, as those use out-of-line trampolines
with early returns.

For example, the dynamic_cond_resched() wrapper looks as follows when
enabled. When disabled, the first `B` is replaced with a `NOP`,
resulting in an early return.

| <dynamic_cond_resched>:
|        bti     c
|        b       <dynamic_cond_resched+0x10>     // or `nop`
|        mov     w0, #0x0
|        ret
|        mrs     x0, sp_el0
|        ldr     x0, [x0, #8]
|        cbnz    x0, <dynamic_cond_resched+0x8>
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mov     x29, sp
|        bl      <preempt_schedule_common>
|        mov     w0, #0x1
|        ldp     x29, x30, [sp], #16
|        autiasp
|        ret

... compared to the regular form of the function:

| <__cond_resched>:
|        bti     c
|        mrs     x0, sp_el0
|        ldr     x1, [x0, #8]
|        cbz     x1, <__cond_resched+0x18>
|        mov     w0, #0x0
|        ret
|        paciasp
|        stp     x29, x30, [sp, #-16]!
|        mov     x29, sp
|        bl      <preempt_schedule_common>
|        mov     w0, #0x1
|        ldp     x29, x30, [sp], #16
|        autiasp
|        ret

Since arm64 does not yet use the generic entry code, we must define our
own `sk_dynamic_irqentry_exit_cond_resched`, which will be
enabled/disabled by the common code in kernel/sched/core.c. All other
preemption functions and associated static keys are defined there.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20220214165216.2231574-8-mark.rutland@arm.com
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/preempt.h | 19 +++++++++++++++++--
 arch/arm64/kernel/entry-common.c | 10 +++++++++-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6978140..7d0f0cd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -192,6 +192,7 @@ config ARM64
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
+	select HAVE_PREEMPT_DYNAMIC_KEY
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_FUNCTION_ARG_ACCESS_API
diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index e83f098..0159b62 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -2,6 +2,7 @@
 #ifndef __ASM_PREEMPT_H
 #define __ASM_PREEMPT_H
 
+#include <linux/jump_label.h>
 #include <linux/thread_info.h>
 
 #define PREEMPT_NEED_RESCHED	BIT(32)
@@ -80,10 +81,24 @@ static inline bool should_resched(int preempt_offset)
 }
 
 #ifdef CONFIG_PREEMPTION
+
 void preempt_schedule(void);
-#define __preempt_schedule() preempt_schedule()
 void preempt_schedule_notrace(void);
-#define __preempt_schedule_notrace() preempt_schedule_notrace()
+
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
+DECLARE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+void dynamic_preempt_schedule(void);
+#define __preempt_schedule()		dynamic_preempt_schedule()
+void dynamic_preempt_schedule_notrace(void);
+#define __preempt_schedule_notrace()	dynamic_preempt_schedule_notrace()
+
+#else /* CONFIG_PREEMPT_DYNAMIC */
+
+#define __preempt_schedule()		preempt_schedule()
+#define __preempt_schedule_notrace()	preempt_schedule_notrace()
+
+#endif /* CONFIG_PREEMPT_DYNAMIC */
 #endif /* CONFIG_PREEMPTION */
 
 #endif /* __ASM_PREEMPT_H */
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 2c639b6..675352e 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -220,9 +220,17 @@ static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
 		lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DEFINE_STATIC_KEY_TRUE(sk_dynamic_irqentry_exit_cond_resched);
+#define need_irq_preemption() \
+	(static_branch_unlikely(&sk_dynamic_irqentry_exit_cond_resched))
+#else
+#define need_irq_preemption()	(IS_ENABLED(CONFIG_PREEMPTION))
+#endif
+
 static void __sched arm64_preempt_schedule_irq(void)
 {
-	if (!IS_ENABLED(CONFIG_PREEMPTION))
+	if (!need_irq_preemption())
 		return;
 
 	/*
