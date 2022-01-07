Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DCA487452
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346222AbiAGIzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:55:01 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:31147 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236255AbiAGIzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:55:00 -0500
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JVcRT3my1zbbcF;
        Fri,  7 Jan 2022 16:52:21 +0800 (CST)
Received: from huawei.com (10.67.174.47) by dggeme758-chm.china.huawei.com
 (10.3.19.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.20; Fri, 7
 Jan 2022 16:54:58 +0800
From:   He Ying <heying24@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <marcan@marcan.st>, <maz@kernel.org>,
        <joey.gouly@arm.com>, <pcc@google.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <heying24@huawei.com>
Subject: [PATCH] arm64: Make CONFIG_ARM64_PSEUDO_NMI macro wrap all the pseudo-NMI code
Date:   Fri, 7 Jan 2022 03:55:36 -0500
Message-ID: <20220107085536.214501-1-heying24@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.47]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our product has been updating its kernel from 4.4 to 5.10 recently and
found a performance issue. We do a bussiness test called ARP test, which
tests the latency for a ping-pong packets traffic with a certain payload.
The result is as following.

 - 4.4 kernel: avg = ~20s
 - 5.10 kernel (CONFIG_ARM64_PSEUDO_NMI is not set): avg = ~40s

I have been just learning arm64 pseudo-NMI code and have a question,
why is the related code not wrapped by CONFIG_ARM64_PSEUDO_NMI?
I wonder if this brings some performance regression.

First, I make this patch and then do the test again. Here's the result.

 - 5.10 kernel with this patch not applied: avg = ~40s
 - 5.10 kernel with this patch applied: avg = ~23s

Amazing! Note that all kernel is built with CONFIG_ARM64_PSEUDO_NMI not
set. It seems the pseudo-NMI feature actually brings some overhead to
performance event if CONFIG_ARM64_PSEUDO_NMI is not set.

Furthermore, I find the feature also brings some overhead to vmlinux size.
I build 5.10 kernel with this patch applied or not while
CONFIG_ARM64_PSEUDO_NMI is not set.

 - 5.10 kernel with this patch not applied: vmlinux size is 384060600 Bytes.
 - 5.10 kernel with this patch applied: vmlinux size is 383842936 Bytes.

That means arm64 pseudo-NMI feature may bring ~200KB overhead to
vmlinux size.

Above all, arm64 pseudo-NMI feature brings some overhead to vmlinux size
and performance even if config is not set. To avoid it, add macro control
all around the related code.

Signed-off-by: He Ying <heying24@huawei.com>
---
 arch/arm64/include/asm/irqflags.h | 38 +++++++++++++++++++++++++++++--
 arch/arm64/kernel/entry.S         |  4 ++++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index b57b9b1e4344..82f771b41cf5 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -26,6 +26,7 @@
  */
 static inline void arch_local_irq_enable(void)
 {
+#ifdef CONFIG_ARM64_PSEUDO_NMI
 	if (system_has_prio_mask_debugging()) {
 		u32 pmr = read_sysreg_s(SYS_ICC_PMR_EL1);
 
@@ -41,10 +42,18 @@ static inline void arch_local_irq_enable(void)
 		: "memory");
 
 	pmr_sync();
+#else
+	asm volatile(
+		"msr	daifclr, #3		// arch_local_irq_enable"
+		:
+		:
+		: "memory");
+#endif
 }
 
 static inline void arch_local_irq_disable(void)
 {
+#ifdef CONFIG_ARM64_PSEUDO_NMI
 	if (system_has_prio_mask_debugging()) {
 		u32 pmr = read_sysreg_s(SYS_ICC_PMR_EL1);
 
@@ -58,6 +67,13 @@ static inline void arch_local_irq_disable(void)
 		:
 		: "r" ((unsigned long) GIC_PRIO_IRQOFF)
 		: "memory");
+#else
+	asm volatile(
+		"msr	daifset, #3		// arch_local_irq_disable"
+		:
+		:
+		: "memory");
+#endif
 }
 
 /*
@@ -66,7 +82,7 @@ static inline void arch_local_irq_disable(void)
 static inline unsigned long arch_local_save_flags(void)
 {
 	unsigned long flags;
-
+#ifdef CONFIG_ARM64_PSEUDO_NMI
 	asm volatile(ALTERNATIVE(
 		"mrs	%0, daif",
 		__mrs_s("%0", SYS_ICC_PMR_EL1),
@@ -74,12 +90,19 @@ static inline unsigned long arch_local_save_flags(void)
 		: "=&r" (flags)
 		:
 		: "memory");
-
+#else
+	asm volatile(
+		"mrs	%0, daif"
+		: "=r" (flags)
+		:
+		: "memory");
+#endif
 	return flags;
 }
 
 static inline int arch_irqs_disabled_flags(unsigned long flags)
 {
+#ifdef CONFIG_ARM64_PSEUDO_NMI
 	int res;
 
 	asm volatile(ALTERNATIVE(
@@ -91,6 +114,9 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 		: "memory");
 
 	return res;
+#else
+	return flags & PSR_I_BIT;
+#endif
 }
 
 static inline int arch_irqs_disabled(void)
@@ -119,6 +145,7 @@ static inline unsigned long arch_local_irq_save(void)
  */
 static inline void arch_local_irq_restore(unsigned long flags)
 {
+#ifdef CONFIG_ARM64_PSEUDO_NMI
 	asm volatile(ALTERNATIVE(
 		"msr	daif, %0",
 		__msr_s(SYS_ICC_PMR_EL1, "%0"),
@@ -128,6 +155,13 @@ static inline void arch_local_irq_restore(unsigned long flags)
 		: "memory");
 
 	pmr_sync();
+#else
+	asm volatile(
+		"msr	daif, %0"
+		:
+		: "r" (flags)
+		: "memory");
+#endif
 }
 
 #endif /* __ASM_IRQFLAGS_H */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 2f69ae43941d..ffc32d3d909a 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -300,6 +300,7 @@ alternative_else_nop_endif
 	str	w21, [sp, #S_SYSCALLNO]
 	.endif
 
+#ifdef CONFIG_ARM64_PSEUDO_NMI
 	/* Save pmr */
 alternative_if ARM64_HAS_IRQ_PRIO_MASKING
 	mrs_s	x20, SYS_ICC_PMR_EL1
@@ -307,6 +308,7 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
 	mov	x20, #GIC_PRIO_IRQON | GIC_PRIO_PSR_I_SET
 	msr_s	SYS_ICC_PMR_EL1, x20
 alternative_else_nop_endif
+#endif
 
 	/* Re-enable tag checking (TCO set on exception entry) */
 #ifdef CONFIG_ARM64_MTE
@@ -330,6 +332,7 @@ alternative_else_nop_endif
 	disable_daif
 	.endif
 
+#ifdef CONFIG_ARM64_PSEUDO_NMI
 	/* Restore pmr */
 alternative_if ARM64_HAS_IRQ_PRIO_MASKING
 	ldr	x20, [sp, #S_PMR_SAVE]
@@ -339,6 +342,7 @@ alternative_if ARM64_HAS_IRQ_PRIO_MASKING
 	dsb	sy				// Ensure priority change is seen by redistributor
 .L__skip_pmr_sync\@:
 alternative_else_nop_endif
+#endif
 
 	ldp	x21, x22, [sp, #S_PC]		// load ELR, SPSR
 
-- 
2.17.1

