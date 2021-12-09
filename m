Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE5046E186
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 05:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhLIEhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 23:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbhLIEhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 23:37:04 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A87C061746;
        Wed,  8 Dec 2021 20:33:31 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2E25E4248B;
        Thu,  9 Dec 2021 04:33:26 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 4/6] irqchip/apple-aic: Dynamically compute register offsets
Date:   Thu,  9 Dec 2021 13:32:47 +0900
Message-Id: <20211209043249.65474-5-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209043249.65474-1-marcan@marcan.st>
References: <20211209043249.65474-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to support AIC variants with different numbers of IRQs
based on capability registers.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/irqchip/irq-apple-aic.c | 73 +++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 572d1af175fc..d03caed51d56 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -62,7 +62,7 @@
 #include <dt-bindings/interrupt-controller/apple-aic.h>
 
 /*
- * AIC registers (MMIO)
+ * AIC v1 registers (MMIO)
  */
 
 #define AIC_INFO		0x0004
@@ -92,16 +92,14 @@
 #define AIC_IPI_SELF		BIT(31)
 
 #define AIC_TARGET_CPU		0x3000
-#define AIC_SW_SET		0x4000
-#define AIC_SW_CLR		0x4080
-#define AIC_MASK_SET		0x4100
-#define AIC_MASK_CLR		0x4180
 
 #define AIC_CPU_IPI_SET(cpu)	(0x5008 + ((cpu) << 7))
 #define AIC_CPU_IPI_CLR(cpu)	(0x500c + ((cpu) << 7))
 #define AIC_CPU_IPI_MASK_SET(cpu) (0x5024 + ((cpu) << 7))
 #define AIC_CPU_IPI_MASK_CLR(cpu) (0x5028 + ((cpu) << 7))
 
+#define AIC_MAX_IRQ		0x400
+
 #define MASK_REG(x)		(4 * ((x) >> 5))
 #define MASK_BIT(x)		BIT((x) & GENMASK(4, 0))
 
@@ -182,17 +180,31 @@
 struct aic_info {
 	int version;
 
+	/* Register offsets */
+	u32 event;
+	u32 target_cpu;
+	u32 sw_set;
+	u32 sw_clr;
+	u32 mask_set;
+	u32 mask_clr;
+
 	/* Features */
 	bool fast_ipi;
 };
 
 static const struct aic_info aic1_info = {
 	.version	= 1,
+
+	.event		= AIC_EVENT,
+	.target_cpu	= AIC_TARGET_CPU,
 };
 
 static const struct aic_info aic1_fipi_info = {
 	.version	= 1,
 
+	.event		= AIC_EVENT,
+	.target_cpu	= AIC_TARGET_CPU,
+
 	.fast_ipi	= true,
 };
 
@@ -212,7 +224,9 @@ struct aic_irq_chip {
 	void __iomem *base;
 	struct irq_domain *hw_domain;
 	struct irq_domain *ipi_domain;
+
 	int nr_irq;
+	int max_irq;
 
 	struct aic_info info;
 };
@@ -247,7 +261,7 @@ static void aic_irq_mask(struct irq_data *d)
 
 	u32 irq = FIELD_GET(AIC_EVENT_NUM, hwirq);
 
-	aic_ic_write(ic, AIC_MASK_SET + MASK_REG(irq), MASK_BIT(irq));
+	aic_ic_write(ic, ic->info.mask_set + MASK_REG(irq), MASK_BIT(irq));
 }
 
 static void aic_irq_unmask(struct irq_data *d)
@@ -257,7 +271,7 @@ static void aic_irq_unmask(struct irq_data *d)
 
 	u32 irq = FIELD_GET(AIC_EVENT_NUM, hwirq);
 
-	aic_ic_write(ic, AIC_MASK_CLR + MASK_REG(irq), MASK_BIT(irq));
+	aic_ic_write(ic, ic->info.mask_clr + MASK_REG(irq), MASK_BIT(irq));
 }
 
 static void aic_irq_eoi(struct irq_data *d)
@@ -280,7 +294,7 @@ static void __exception_irq_entry aic_handle_irq(struct pt_regs *regs)
 		 * We cannot use a relaxed read here, as reads from DMA buffers
 		 * need to be ordered after the IRQ fires.
 		 */
-		event = readl(ic->base + AIC_EVENT);
+		event = readl(ic->base + ic->info.event);
 		type = FIELD_GET(AIC_EVENT_TYPE, event);
 		irq = FIELD_GET(AIC_EVENT_NUM, event);
 
@@ -312,12 +326,15 @@ static int aic_irq_set_affinity(struct irq_data *d,
 	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
 	int cpu;
 
+	if (!ic->info.target_cpu)
+		return -EINVAL;
+
 	if (force)
 		cpu = cpumask_first(mask_val);
 	else
 		cpu = cpumask_any_and(mask_val, cpu_online_mask);
 
-	aic_ic_write(ic, AIC_TARGET_CPU + FIELD_GET(AIC_EVENT_NUM, hwirq) * 4, BIT(cpu));
+	aic_ic_write(ic, ic->info.target_cpu + FIELD_GET(AIC_EVENT_NUM, hwirq) * 4, BIT(cpu));
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
 	return IRQ_SET_MASK_OK;
@@ -876,8 +893,8 @@ static struct gic_kvm_info vgic_info __initdata = {
 static int __init aic_of_ic_init(struct device_node *node, struct device_node *parent)
 {
 	int i;
+	u32 off;
 	void __iomem *regs;
-	u32 info;
 	struct aic_irq_chip *irqc;
 	const struct of_device_id *match;
 
@@ -899,8 +916,30 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 
 	aic_irqc = irqc;
 
-	info = aic_ic_read(irqc, AIC_INFO);
-	irqc->nr_irq = FIELD_GET(AIC_INFO_NR_IRQ, info);
+	switch (irqc->info.version) {
+	case 1: {
+		u32 info;
+
+		info = aic_ic_read(irqc, AIC_INFO);
+		irqc->nr_irq = FIELD_GET(AIC_INFO_NR_IRQ, info);
+		irqc->max_irq = AIC_MAX_IRQ;
+
+		off = irqc->info.target_cpu;
+		off += sizeof(u32) * irqc->max_irq; /* TARGET_CPU */
+
+		break;
+	}
+	}
+
+	irqc->info.sw_set = off;
+	off += sizeof(u32) * (irqc->max_irq >> 5); /* SW_SET */
+	irqc->info.sw_clr = off;
+	off += sizeof(u32) * (irqc->max_irq >> 5); /* SW_CLR */
+	irqc->info.mask_set = off;
+	off += sizeof(u32) * (irqc->max_irq >> 5); /* MASK_SET */
+	irqc->info.mask_clr = off;
+	off += sizeof(u32) * (irqc->max_irq >> 5); /* MASK_CLR */
+	off += sizeof(u32) * (irqc->max_irq >> 5); /* HW_STATE */
 
 	irqc->hw_domain = irq_domain_create_tree(of_node_to_fwnode(node),
 						 &aic_irq_domain_ops, irqc);
@@ -923,11 +962,11 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	set_handle_fiq(aic_handle_fiq);
 
 	for (i = 0; i < BITS_TO_U32(irqc->nr_irq); i++)
-		aic_ic_write(irqc, AIC_MASK_SET + i * 4, U32_MAX);
+		aic_ic_write(irqc, irqc->info.mask_set + i * 4, U32_MAX);
 	for (i = 0; i < BITS_TO_U32(irqc->nr_irq); i++)
-		aic_ic_write(irqc, AIC_SW_CLR + i * 4, U32_MAX);
+		aic_ic_write(irqc, irqc->info.sw_clr + i * 4, U32_MAX);
 	for (i = 0; i < irqc->nr_irq; i++)
-		aic_ic_write(irqc, AIC_TARGET_CPU + i * 4, 1);
+		aic_ic_write(irqc, irqc->info.target_cpu + i * 4, 1);
 
 	if (!is_kernel_in_hyp_mode())
 		pr_info("Kernel running in EL1, mapping interrupts");
@@ -941,8 +980,8 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 
 	vgic_set_kvm_info(&vgic_info);
 
-	pr_info("Initialized with %d IRQs, %d FIQs, %d vIPIs\n",
-		irqc->nr_irq, AIC_NR_FIQ, AIC_NR_SWIPI);
+	pr_info("Initialized with %d/%d IRQs, %d FIQs, %d vIPIs",
+		irqc->nr_irq, irqc->max_irq, AIC_NR_FIQ, AIC_NR_SWIPI);
 
 	return 0;
 }
-- 
2.33.0

