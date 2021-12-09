Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5527546E18B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 05:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhLIEhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 23:37:12 -0500
Received: from marcansoft.com ([212.63.210.85]:54222 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232090AbhLIEhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 23:37:07 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4F81641E64;
        Thu,  9 Dec 2021 04:33:30 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 5/6] irqchip/apple-aic: Support multiple dies
Date:   Thu,  9 Dec 2021 13:32:48 +0900
Message-Id: <20211209043249.65474-6-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209043249.65474-1-marcan@marcan.st>
References: <20211209043249.65474-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multi-die support in AICv2 uses several sets of IRQ registers. Introduce
a die count and compute the register group offset based on the die ID
field of the hwirq number, as reported by the hardware.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/irqchip/irq-apple-aic.c | 75 +++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 22 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index d03caed51d56..46b7750548a0 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -72,7 +72,8 @@
 
 #define AIC_WHOAMI		0x2000
 #define AIC_EVENT		0x2004
-#define AIC_EVENT_TYPE		GENMASK(31, 16)
+#define AIC_EVENT_DIE		GENMASK(31, 24)
+#define AIC_EVENT_TYPE		GENMASK(23, 16)
 #define AIC_EVENT_NUM		GENMASK(15, 0)
 
 #define AIC_EVENT_TYPE_FIQ	0 /* Software use */
@@ -157,6 +158,9 @@
 #define MPIDR_CPU			GENMASK(7, 0)
 #define MPIDR_CLUSTER			GENMASK(15, 8)
 
+#define AIC_IRQ_HWIRQ(die, irq)	(FIELD_PREP(AIC_EVENT_DIE, die) | \
+				 FIELD_PREP(AIC_EVENT_TYPE, AIC_EVENT_TYPE_HW) | \
+				 FIELD_PREP(AIC_EVENT_NUM, irq))
 #define AIC_FIQ_HWIRQ(x)	(FIELD_PREP(AIC_EVENT_TYPE, AIC_EVENT_TYPE_FIQ) | \
 				 FIELD_PREP(AIC_EVENT_NUM, x))
 #define AIC_NR_FIQ		4
@@ -188,6 +192,8 @@ struct aic_info {
 	u32 mask_set;
 	u32 mask_clr;
 
+	u32 die_stride;
+
 	/* Features */
 	bool fast_ipi;
 };
@@ -227,6 +233,8 @@ struct aic_irq_chip {
 
 	int nr_irq;
 	int max_irq;
+	int nr_die;
+	int max_die;
 
 	struct aic_info info;
 };
@@ -259,9 +267,10 @@ static void aic_irq_mask(struct irq_data *d)
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
 
+	u32 off = FIELD_GET(AIC_EVENT_DIE, hwirq) * ic->info.die_stride;
 	u32 irq = FIELD_GET(AIC_EVENT_NUM, hwirq);
 
-	aic_ic_write(ic, ic->info.mask_set + MASK_REG(irq), MASK_BIT(irq));
+	aic_ic_write(ic, ic->info.mask_set + off + MASK_REG(irq), MASK_BIT(irq));
 }
 
 static void aic_irq_unmask(struct irq_data *d)
@@ -269,9 +278,10 @@ static void aic_irq_unmask(struct irq_data *d)
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
 
+	u32 off = FIELD_GET(AIC_EVENT_DIE, hwirq) * ic->info.die_stride;
 	u32 irq = FIELD_GET(AIC_EVENT_NUM, hwirq);
 
-	aic_ic_write(ic, ic->info.mask_clr + MASK_REG(irq), MASK_BIT(irq));
+	aic_ic_write(ic, ic->info.mask_clr + off + MASK_REG(irq), MASK_BIT(irq));
 }
 
 static void aic_irq_eoi(struct irq_data *d)
@@ -535,28 +545,41 @@ static int aic_irq_domain_translate(struct irq_domain *id,
 				    unsigned int *type)
 {
 	struct aic_irq_chip *ic = id->host_data;
+	u32 *args;
+	u32 die = 0;
 
-	if (fwspec->param_count != 3 || !is_of_node(fwspec->fwnode))
+	if (fwspec->param_count < 3 || fwspec->param_count > 4 ||
+	    !is_of_node(fwspec->fwnode))
 		return -EINVAL;
 
+	args = &fwspec->param[1];
+
+	if (fwspec->param_count == 4) {
+		die = args[0];
+		args++;
+	}
+
 	switch (fwspec->param[0]) {
 	case AIC_IRQ:
-		if (fwspec->param[1] >= ic->nr_irq)
+		if (die >= ic->nr_die)
+			return -EINVAL;
+		if (args[0] >= ic->nr_irq)
 			return -EINVAL;
-		*hwirq = (FIELD_PREP(AIC_EVENT_TYPE, AIC_EVENT_TYPE_HW) |
-			  FIELD_PREP(AIC_EVENT_NUM, fwspec->param[1]));
+		*hwirq = AIC_IRQ_HWIRQ(die, args[0]);
 		break;
 	case AIC_FIQ:
-		if (fwspec->param[1] >= AIC_NR_FIQ)
+		if (die != 0)
 			return -EINVAL;
-		*hwirq = AIC_FIQ_HWIRQ(fwspec->param[1]);
+		if (args[0] >= AIC_NR_FIQ)
+			return -EINVAL;
+		*hwirq = AIC_FIQ_HWIRQ(args[0]);
 
 		/*
 		 * In EL1 the non-redirected registers are the guest's,
 		 * not EL2's, so remap the hwirqs to match.
 		 */
 		if (!is_kernel_in_hyp_mode()) {
-			switch (fwspec->param[1]) {
+			switch (args[0]) {
 			case AIC_TMR_GUEST_PHYS:
 				*hwirq = AIC_FIQ_HWIRQ(AIC_TMR_EL0_PHYS);
 				break;
@@ -575,7 +598,7 @@ static int aic_irq_domain_translate(struct irq_domain *id,
 		return -EINVAL;
 	}
 
-	*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+	*type = args[1] & IRQ_TYPE_SENSE_MASK;
 
 	return 0;
 }
@@ -892,8 +915,8 @@ static struct gic_kvm_info vgic_info __initdata = {
 
 static int __init aic_of_ic_init(struct device_node *node, struct device_node *parent)
 {
-	int i;
-	u32 off;
+	int i, die;
+	u32 off, start_off;
 	void __iomem *regs;
 	struct aic_irq_chip *irqc;
 	const struct of_device_id *match;
@@ -923,8 +946,9 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 		info = aic_ic_read(irqc, AIC_INFO);
 		irqc->nr_irq = FIELD_GET(AIC_INFO_NR_IRQ, info);
 		irqc->max_irq = AIC_MAX_IRQ;
+		irqc->nr_die = irqc->max_die = 1;
 
-		off = irqc->info.target_cpu;
+		off = start_off = irqc->info.target_cpu;
 		off += sizeof(u32) * irqc->max_irq; /* TARGET_CPU */
 
 		break;
@@ -941,6 +965,8 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	off += sizeof(u32) * (irqc->max_irq >> 5); /* MASK_CLR */
 	off += sizeof(u32) * (irqc->max_irq >> 5); /* HW_STATE */
 
+	irqc->info.die_stride = off - start_off;
+
 	irqc->hw_domain = irq_domain_create_tree(of_node_to_fwnode(node),
 						 &aic_irq_domain_ops, irqc);
 	if (WARN_ON(!irqc->hw_domain)) {
@@ -961,12 +987,17 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	set_handle_irq(aic_handle_irq);
 	set_handle_fiq(aic_handle_fiq);
 
-	for (i = 0; i < BITS_TO_U32(irqc->nr_irq); i++)
-		aic_ic_write(irqc, irqc->info.mask_set + i * 4, U32_MAX);
-	for (i = 0; i < BITS_TO_U32(irqc->nr_irq); i++)
-		aic_ic_write(irqc, irqc->info.sw_clr + i * 4, U32_MAX);
-	for (i = 0; i < irqc->nr_irq; i++)
-		aic_ic_write(irqc, irqc->info.target_cpu + i * 4, 1);
+	off = 0;
+	for (die = 0; die < irqc->nr_die; die++) {
+		for (i = 0; i < BITS_TO_U32(irqc->nr_irq); i++)
+			aic_ic_write(irqc, irqc->info.mask_set + off + i * 4, U32_MAX);
+		for (i = 0; i < BITS_TO_U32(irqc->nr_irq); i++)
+			aic_ic_write(irqc, irqc->info.sw_clr + off + i * 4, U32_MAX);
+		if (irqc->info.target_cpu)
+			for (i = 0; i < irqc->nr_irq; i++)
+				aic_ic_write(irqc, irqc->info.target_cpu + off + i * 4, 1);
+		off += irqc->info.die_stride;
+	}
 
 	if (!is_kernel_in_hyp_mode())
 		pr_info("Kernel running in EL1, mapping interrupts");
@@ -980,8 +1011,8 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 
 	vgic_set_kvm_info(&vgic_info);
 
-	pr_info("Initialized with %d/%d IRQs, %d FIQs, %d vIPIs",
-		irqc->nr_irq, irqc->max_irq, AIC_NR_FIQ, AIC_NR_SWIPI);
+	pr_info("Initialized with %d/%d IRQs * %d/%d die(s), %d FIQs, %d vIPIs",
+		irqc->nr_irq, irqc->max_irq, irqc->nr_die, irqc->max_die, AIC_NR_FIQ, AIC_NR_SWIPI);
 
 	return 0;
 }
-- 
2.33.0

