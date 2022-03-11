Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357A74D5E48
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbiCKJV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347394AbiCKJVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:21:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2411BD05A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:20:41 -0800 (PST)
Date:   Fri, 11 Mar 2022 09:20:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646990439;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CyorxRkzoeZ3wohXQIFi8MaZOrCtKqVla5E67Di7TJE=;
        b=D+vQo2++E266JJ7GWSe7B+rBlzwSGYbW0mN/gnodEIDA//rpjH/jhVYZxbywzD60FQbkHZ
        e++X+C5paOYqr73U7MoxSeSPhkIGr3/5/9DnoQJcp96AgifV7YFabqmPwKBR59yf3OWVxE
        RH6fLGuJxqAf0yGb9MgE1g/FaIjOGuVq1pnaWKlfll7F22Xk0OLrxLt9Z3VacVjBWKfsYJ
        oYktO8mV0hp/UGIG1nACaXQ23VcLH7KC0sKfk5Yc77OWSCnhG3+gsedemiWTG5V7HfHdK+
        V5cIl7dZyFSUlbaxeZuhcFa1BZFnUQ4n4H8k+TFIazxG+HZ/7Qd5X+5tC5V/qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646990439;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CyorxRkzoeZ3wohXQIFi8MaZOrCtKqVla5E67Di7TJE=;
        b=WvxIGhDd62vx+2MA2c13+dhHAugUUlCLvO8mfle6JcXR55PyeoCkCCYySIdDut45O0PK/5
        upRUgf+b+lPBL8AA==
From:   "irqchip-bot for Hector Martin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/apple-aic: Add Fast IPI support
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220309192123.152028-4-marcan@marcan.st>
References: <20220309192123.152028-4-marcan@marcan.st>
MIME-Version: 1.0
Message-ID: <164699043863.16921.10704813887293708703.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     2cf68211664acd2e4bdd1fb66697137b30901981
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/2cf68211664acd2e4bdd1fb66697137b30901981
Author:        Hector Martin <marcan@marcan.st>
AuthorDate:    Thu, 10 Mar 2022 04:21:19 +09:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Mar 2022 08:59:46 

irqchip/apple-aic: Add Fast IPI support

The newer AICv2 present in t600x SoCs does not have legacy IPI support
at all. Since t8103 also supports Fast IPIs, implement support for this
first. The legacy IPI code is left as a fallback, so it can be
potentially used by older SoCs in the future.

The vIPI code is shared; only the IPI firing/acking bits change for Fast
IPIs.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220309192123.152028-4-marcan@marcan.st
---
 drivers/irqchip/irq-apple-aic.c | 122 +++++++++++++++++++++++++++----
 1 file changed, 109 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 38091eb..613e0eb 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -24,7 +24,7 @@
  * - Default "this CPU" register view and explicit per-CPU views
  *
  * In addition, this driver also handles FIQs, as these are routed to the same
- * IRQ vector. These are used for Fast IPIs (TODO), the ARMv8 timer IRQs, and
+ * IRQ vector. These are used for Fast IPIs, the ARMv8 timer IRQs, and
  * performance counters (TODO).
  *
  * Implementation notes:
@@ -52,9 +52,11 @@
 #include <linux/irqchip.h>
 #include <linux/irqchip/arm-vgic-info.h>
 #include <linux/irqdomain.h>
+#include <linux/jump_label.h>
 #include <linux/limits.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
+#include <asm/cputype.h>
 #include <asm/exception.h>
 #include <asm/sysreg.h>
 #include <asm/virt.h>
@@ -106,7 +108,6 @@
 
 /*
  * IMP-DEF sysregs that control FIQ sources
- * Note: sysreg-based IPIs are not supported yet.
  */
 
 /* Core PMC control register */
@@ -155,6 +156,10 @@
 #define SYS_IMP_APL_UPMSR_EL1		sys_reg(3, 7, 15, 6, 4)
 #define UPMSR_IACT			BIT(0)
 
+/* MPIDR fields */
+#define MPIDR_CPU(x)			MPIDR_AFFINITY_LEVEL(x, 0)
+#define MPIDR_CLUSTER(x)		MPIDR_AFFINITY_LEVEL(x, 1)
+
 #define AIC_NR_FIQ		4
 #define AIC_NR_SWIPI		32
 
@@ -173,11 +178,44 @@
 #define AIC_TMR_EL02_PHYS	AIC_TMR_GUEST_PHYS
 #define AIC_TMR_EL02_VIRT	AIC_TMR_GUEST_VIRT
 
+DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
+
+struct aic_info {
+	int version;
+
+	/* Features */
+	bool fast_ipi;
+};
+
+static const struct aic_info aic1_info = {
+	.version	= 1,
+};
+
+static const struct aic_info aic1_fipi_info = {
+	.version	= 1,
+
+	.fast_ipi	= true,
+};
+
+static const struct of_device_id aic_info_match[] = {
+	{
+		.compatible = "apple,t8103-aic",
+		.data = &aic1_fipi_info,
+	},
+	{
+		.compatible = "apple,aic",
+		.data = &aic1_info,
+	},
+	{}
+};
+
 struct aic_irq_chip {
 	void __iomem *base;
 	struct irq_domain *hw_domain;
 	struct irq_domain *ipi_domain;
 	int nr_hw;
+
+	struct aic_info info;
 };
 
 static DEFINE_PER_CPU(uint32_t, aic_fiq_unmasked);
@@ -386,8 +424,12 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 	 */
 
 	if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
-		pr_err_ratelimited("Fast IPI fired. Acking.\n");
-		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+		if (static_branch_likely(&use_fast_ipi)) {
+			aic_handle_ipi(regs);
+		} else {
+			pr_err_ratelimited("Fast IPI fired. Acking.\n");
+			write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+		}
 	}
 
 	if (TIMER_FIRING(read_sysreg(cntp_ctl_el0)))
@@ -563,6 +605,22 @@ static const struct irq_domain_ops aic_irq_domain_ops = {
  * IPI irqchip
  */
 
+static void aic_ipi_send_fast(int cpu)
+{
+	u64 mpidr = cpu_logical_map(cpu);
+	u64 my_mpidr = read_cpuid_mpidr();
+	u64 cluster = MPIDR_CLUSTER(mpidr);
+	u64 idx = MPIDR_CPU(mpidr);
+
+	if (MPIDR_CLUSTER(my_mpidr) == cluster)
+		write_sysreg_s(FIELD_PREP(IPI_RR_CPU, idx),
+			       SYS_IMP_APL_IPI_RR_LOCAL_EL1);
+	else
+		write_sysreg_s(FIELD_PREP(IPI_RR_CPU, idx) | FIELD_PREP(IPI_RR_CLUSTER, cluster),
+			       SYS_IMP_APL_IPI_RR_GLOBAL_EL1);
+	isb();
+}
+
 static void aic_ipi_mask(struct irq_data *d)
 {
 	u32 irq_bit = BIT(irqd_to_hwirq(d));
@@ -588,8 +646,12 @@ static void aic_ipi_unmask(struct irq_data *d)
 	 * If a pending vIPI was unmasked, raise a HW IPI to ourselves.
 	 * No barriers needed here since this is a self-IPI.
 	 */
-	if (atomic_read(this_cpu_ptr(&aic_vipi_flag)) & irq_bit)
-		aic_ic_write(ic, AIC_IPI_SEND, AIC_IPI_SEND_CPU(smp_processor_id()));
+	if (atomic_read(this_cpu_ptr(&aic_vipi_flag)) & irq_bit) {
+		if (static_branch_likely(&use_fast_ipi))
+			aic_ipi_send_fast(smp_processor_id());
+		else
+			aic_ic_write(ic, AIC_IPI_SEND, AIC_IPI_SEND_CPU(smp_processor_id()));
+	}
 }
 
 static void aic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
@@ -617,8 +679,12 @@ static void aic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 		smp_mb__after_atomic();
 
 		if (!(pending & irq_bit) &&
-		    (atomic_read(per_cpu_ptr(&aic_vipi_enable, cpu)) & irq_bit))
-			send |= AIC_IPI_SEND_CPU(cpu);
+		    (atomic_read(per_cpu_ptr(&aic_vipi_enable, cpu)) & irq_bit)) {
+			if (static_branch_likely(&use_fast_ipi))
+				aic_ipi_send_fast(cpu);
+			else
+				send |= AIC_IPI_SEND_CPU(cpu);
+		}
 	}
 
 	/*
@@ -650,8 +716,16 @@ static void aic_handle_ipi(struct pt_regs *regs)
 	/*
 	 * Ack the IPI. We need to order this after the AIC event read, but
 	 * that is enforced by normal MMIO ordering guarantees.
+	 *
+	 * For the Fast IPI case, this needs to be ordered before the vIPI
+	 * handling below, so we need to isb();
 	 */
-	aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_OTHER);
+	if (static_branch_likely(&use_fast_ipi)) {
+		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+		isb();
+	} else {
+		aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_OTHER);
+	}
 
 	/*
 	 * The mask read does not need to be ordered. Only we can change
@@ -679,7 +753,8 @@ static void aic_handle_ipi(struct pt_regs *regs)
 	 * No ordering needed here; at worst this just changes the timing of
 	 * when the next IPI will be delivered.
 	 */
-	aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
+	if (!static_branch_likely(&use_fast_ipi))
+		aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
 }
 
 static int aic_ipi_alloc(struct irq_domain *d, unsigned int virq,
@@ -776,10 +851,15 @@ static int aic_init_cpu(unsigned int cpu)
 	/*
 	 * Always keep IPIs unmasked at the hardware level (except auto-masking
 	 * by AIC during processing). We manage masks at the vIPI level.
+	 * These registers only exist on AICv1, AICv2 always uses fast IPIs.
 	 */
 	aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_SELF | AIC_IPI_OTHER);
-	aic_ic_write(aic_irqc, AIC_IPI_MASK_SET, AIC_IPI_SELF);
-	aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
+	if (static_branch_likely(&use_fast_ipi)) {
+		aic_ic_write(aic_irqc, AIC_IPI_MASK_SET, AIC_IPI_SELF | AIC_IPI_OTHER);
+	} else {
+		aic_ic_write(aic_irqc, AIC_IPI_MASK_SET, AIC_IPI_SELF);
+		aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
+	}
 
 	/* Initialize the local mask state */
 	__this_cpu_write(aic_fiq_unmasked, 0);
@@ -799,6 +879,7 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	void __iomem *regs;
 	u32 info;
 	struct aic_irq_chip *irqc;
+	const struct of_device_id *match;
 
 	regs = of_iomap(node, 0);
 	if (WARN_ON(!regs))
@@ -808,12 +889,24 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	if (!irqc)
 		return -ENOMEM;
 
-	aic_irqc = irqc;
 	irqc->base = regs;
 
+	match = of_match_node(aic_info_match, node);
+	if (!match)
+		return -ENODEV;
+
+	irqc->info = *(struct aic_info *)match->data;
+
+	aic_irqc = irqc;
+
 	info = aic_ic_read(irqc, AIC_INFO);
 	irqc->nr_hw = FIELD_GET(AIC_INFO_NR_HW, info);
 
+	if (irqc->info.fast_ipi)
+		static_branch_enable(&use_fast_ipi);
+	else
+		static_branch_disable(&use_fast_ipi);
+
 	irqc->hw_domain = irq_domain_create_linear(of_node_to_fwnode(node),
 						   irqc->nr_hw + AIC_NR_FIQ,
 						   &aic_irq_domain_ops, irqc);
@@ -845,6 +938,9 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	if (!is_kernel_in_hyp_mode())
 		pr_info("Kernel running in EL1, mapping interrupts");
 
+	if (static_branch_likely(&use_fast_ipi))
+		pr_info("Using Fast IPIs");
+
 	cpuhp_setup_state(CPUHP_AP_IRQ_APPLE_AIC_STARTING,
 			  "irqchip/apple-aic/ipi:starting",
 			  aic_init_cpu, NULL);
