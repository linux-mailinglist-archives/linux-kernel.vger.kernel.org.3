Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A00846E180
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 05:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhLIEg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 23:36:58 -0500
Received: from marcansoft.com ([212.63.210.85]:54142 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232000AbhLIEg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 23:36:57 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DBDBE41EA7;
        Thu,  9 Dec 2021 04:33:20 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/6] irqchip/apple-aic: Add Fast IPI support
Date:   Thu,  9 Dec 2021 13:32:45 +0900
Message-Id: <20211209043249.65474-3-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209043249.65474-1-marcan@marcan.st>
References: <20211209043249.65474-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newer AICv2 present in t600x SoCs does not have legacy IPI support
at all. Since t8103 also supports Fast IPIs, implement support for this
first. The legacy IPI code is left as a fallback, so it can be
potentially used by older SoCs in the future.

The vIPI code is shared; only the IPI firing/acking bits change for Fast
IPIs.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/irqchip/irq-apple-aic.c | 112 ++++++++++++++++++++++++++++----
 1 file changed, 98 insertions(+), 14 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 3759dc36cc8f..1aa63580cae4 100644
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
@@ -106,7 +106,6 @@
 
 /*
  * IMP-DEF sysregs that control FIQ sources
- * Note: sysreg-based IPIs are not supported yet.
  */
 
 /* Core PMC control register */
@@ -155,6 +154,10 @@
 #define SYS_IMP_APL_UPMSR_EL1		sys_reg(3, 7, 15, 6, 4)
 #define UPMSR_IACT			BIT(0)
 
+/* MPIDR fields */
+#define MPIDR_CPU			GENMASK(7, 0)
+#define MPIDR_CLUSTER			GENMASK(15, 8)
+
 #define AIC_NR_FIQ		4
 #define AIC_NR_SWIPI		32
 
@@ -173,12 +176,42 @@
 #define AIC_TMR_EL02_PHYS	AIC_TMR_GUEST_PHYS
 #define AIC_TMR_EL02_VIRT	AIC_TMR_GUEST_VIRT
 
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
-	int ipi_hwirq;
+
+	struct aic_info info;
 };
 
 static DEFINE_PER_CPU(uint32_t, aic_fiq_unmasked);
@@ -387,8 +420,12 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 	 */
 
 	if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
-		pr_err_ratelimited("Fast IPI fired. Acking.\n");
-		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+		if (aic_irqc->info.fast_ipi) {
+			aic_handle_ipi(regs);
+		} else {
+			pr_err_ratelimited("Fast IPI fired. Acking.\n");
+			write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+		}
 	}
 
 	if (TIMER_FIRING(read_sysreg(cntp_ctl_el0)))
@@ -564,6 +601,21 @@ static const struct irq_domain_ops aic_irq_domain_ops = {
  * IPI irqchip
  */
 
+static void aic_ipi_send_fast(int cpu)
+{
+	u64 mpidr = cpu_logical_map(cpu);
+	u64 my_mpidr = cpu_logical_map(smp_processor_id());
+	u64 cluster = FIELD_GET(MPIDR_CLUSTER, mpidr);
+	u64 idx = FIELD_GET(MPIDR_CPU, mpidr);
+
+	if (FIELD_GET(MPIDR_CLUSTER, my_mpidr) == cluster)
+		write_sysreg_s(FIELD_PREP(IPI_RR_CPU, idx),
+			       SYS_IMP_APL_IPI_RR_LOCAL_EL1);
+	else
+		write_sysreg_s(FIELD_PREP(IPI_RR_CPU, idx) | FIELD_PREP(IPI_RR_CLUSTER, cluster),
+			       SYS_IMP_APL_IPI_RR_GLOBAL_EL1);
+}
+
 static void aic_ipi_mask(struct irq_data *d)
 {
 	u32 irq_bit = BIT(irqd_to_hwirq(d));
@@ -589,8 +641,12 @@ static void aic_ipi_unmask(struct irq_data *d)
 	 * If a pending vIPI was unmasked, raise a HW IPI to ourselves.
 	 * No barriers needed here since this is a self-IPI.
 	 */
-	if (atomic_read(this_cpu_ptr(&aic_vipi_flag)) & irq_bit)
-		aic_ic_write(ic, AIC_IPI_SEND, AIC_IPI_SEND_CPU(smp_processor_id()));
+	if (atomic_read(this_cpu_ptr(&aic_vipi_flag)) & irq_bit) {
+		if (ic->info.fast_ipi)
+			aic_ipi_send_fast(smp_processor_id());
+		else
+			aic_ic_write(ic, AIC_IPI_SEND, AIC_IPI_SEND_CPU(smp_processor_id()));
+	}
 }
 
 static void aic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
@@ -618,8 +674,12 @@ static void aic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 		smp_mb__after_atomic();
 
 		if (!(pending & irq_bit) &&
-		    (atomic_read(per_cpu_ptr(&aic_vipi_enable, cpu)) & irq_bit))
-			send |= AIC_IPI_SEND_CPU(cpu);
+		    (atomic_read(per_cpu_ptr(&aic_vipi_enable, cpu)) & irq_bit)) {
+			if (ic->info.fast_ipi)
+				aic_ipi_send_fast(cpu);
+			else
+				send |= AIC_IPI_SEND_CPU(cpu);
+		}
 	}
 
 	/*
@@ -651,8 +711,16 @@ static void aic_handle_ipi(struct pt_regs *regs)
 	/*
 	 * Ack the IPI. We need to order this after the AIC event read, but
 	 * that is enforced by normal MMIO ordering guarantees.
+	 *
+	 * For the Fast IPI case, this needs to be ordered before the vIPI
+	 * handling below, so we need to isb();
 	 */
-	aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_OTHER);
+	if (aic_irqc->info.fast_ipi) {
+		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
+		isb();
+	} else {
+		aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_OTHER);
+	}
 
 	/*
 	 * The mask read does not need to be ordered. Only we can change
@@ -680,7 +748,8 @@ static void aic_handle_ipi(struct pt_regs *regs)
 	 * No ordering needed here; at worst this just changes the timing of
 	 * when the next IPI will be delivered.
 	 */
-	aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
+	if (!aic_irqc->info.fast_ipi)
+		aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
 }
 
 static int aic_ipi_alloc(struct irq_domain *d, unsigned int virq,
@@ -779,8 +848,12 @@ static int aic_init_cpu(unsigned int cpu)
 	 * by AIC during processing). We manage masks at the vIPI level.
 	 */
 	aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_SELF | AIC_IPI_OTHER);
-	aic_ic_write(aic_irqc, AIC_IPI_MASK_SET, AIC_IPI_SELF);
-	aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
+	if (!aic_irqc->info.fast_ipi) {
+		aic_ic_write(aic_irqc, AIC_IPI_MASK_SET, AIC_IPI_SELF);
+		aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
+	} else {
+		aic_ic_write(aic_irqc, AIC_IPI_MASK_SET, AIC_IPI_SELF | AIC_IPI_OTHER);
+	}
 
 	/* Initialize the local mask state */
 	__this_cpu_write(aic_fiq_unmasked, 0);
@@ -800,6 +873,7 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	void __iomem *regs;
 	u32 info;
 	struct aic_irq_chip *irqc;
+	const struct of_device_id *match;
 
 	regs = of_iomap(node, 0);
 	if (WARN_ON(!regs))
@@ -809,9 +883,16 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
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
 
@@ -846,6 +927,9 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	if (!is_kernel_in_hyp_mode())
 		pr_info("Kernel running in EL1, mapping interrupts");
 
+	if (irqc->info.fast_ipi)
+		pr_info("Using Fast IPIs");
+
 	cpuhp_setup_state(CPUHP_AP_IRQ_APPLE_AIC_STARTING,
 			  "irqchip/apple-aic/ipi:starting",
 			  aic_init_cpu, NULL);
-- 
2.33.0

