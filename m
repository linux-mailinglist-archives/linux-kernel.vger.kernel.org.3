Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BB24D3A2C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbiCITXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237736AbiCITXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:23:24 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E655743498;
        Wed,  9 Mar 2022 11:22:23 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8DE7B4218A;
        Wed,  9 Mar 2022 19:22:19 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 6/7] irqchip/apple-aic: Support multiple dies
Date:   Thu, 10 Mar 2022 04:21:22 +0900
Message-Id: <20220309192123.152028-7-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220309192123.152028-1-marcan@marcan.st>
References: <20220309192123.152028-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multi-die support in AICv2 uses several sets of IRQ registers. Introduce
a die count and compute the register group offset based on the die ID
field of the hwirq number, as reported by the hardware.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/irqchip/irq-apple-aic.c | 77 +++++++++++++++++++++++----------
 1 file changed, 54 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 4b1ba732f476..93c622435ba2 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -74,7 +74,8 @@
 
 #define AIC_WHOAMI		0x2000
 #define AIC_EVENT		0x2004
-#define AIC_EVENT_TYPE		GENMASK(31, 16)
+#define AIC_EVENT_DIE		GENMASK(31, 24)
+#define AIC_EVENT_TYPE		GENMASK(23, 16)
 #define AIC_EVENT_NUM		GENMASK(15, 0)
 
 #define AIC_EVENT_TYPE_FIQ	0 /* Software use */
@@ -159,11 +160,13 @@
 #define MPIDR_CPU(x)			MPIDR_AFFINITY_LEVEL(x, 0)
 #define MPIDR_CLUSTER(x)		MPIDR_AFFINITY_LEVEL(x, 1)
 
-#define AIC_IRQ_HWIRQ(x)	(FIELD_PREP(AIC_EVENT_TYPE, AIC_EVENT_TYPE_IRQ) | \
-				 FIELD_PREP(AIC_EVENT_NUM, x))
+#define AIC_IRQ_HWIRQ(die, irq)	(FIELD_PREP(AIC_EVENT_DIE, die) | \
+				 FIELD_PREP(AIC_EVENT_TYPE, AIC_EVENT_TYPE_IRQ) | \
+				 FIELD_PREP(AIC_EVENT_NUM, irq))
 #define AIC_FIQ_HWIRQ(x)	(FIELD_PREP(AIC_EVENT_TYPE, AIC_EVENT_TYPE_FIQ) | \
 				 FIELD_PREP(AIC_EVENT_NUM, x))
 #define AIC_HWIRQ_IRQ(x)	FIELD_GET(AIC_EVENT_NUM, x)
+#define AIC_HWIRQ_DIE(x)	FIELD_GET(AIC_EVENT_DIE, x)
 #define AIC_NR_FIQ		4
 #define AIC_NR_SWIPI		32
 
@@ -195,6 +198,8 @@ struct aic_info {
 	u32 mask_set;
 	u32 mask_clr;
 
+	u32 die_stride;
+
 	/* Features */
 	bool fast_ipi;
 };
@@ -234,6 +239,8 @@ struct aic_irq_chip {
 
 	int nr_irq;
 	int max_irq;
+	int nr_die;
+	int max_die;
 
 	struct aic_info info;
 };
@@ -266,9 +273,10 @@ static void aic_irq_mask(struct irq_data *d)
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
 
+	u32 off = AIC_HWIRQ_DIE(hwirq) * ic->info.die_stride;
 	u32 irq = AIC_HWIRQ_IRQ(hwirq);
 
-	aic_ic_write(ic, ic->info.mask_set + MASK_REG(irq), MASK_BIT(irq));
+	aic_ic_write(ic, ic->info.mask_set + off + MASK_REG(irq), MASK_BIT(irq));
 }
 
 static void aic_irq_unmask(struct irq_data *d)
@@ -276,9 +284,10 @@ static void aic_irq_unmask(struct irq_data *d)
 	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
 
+	u32 off = AIC_HWIRQ_DIE(hwirq) * ic->info.die_stride;
 	u32 irq = AIC_HWIRQ_IRQ(hwirq);
 
-	aic_ic_write(ic, ic->info.mask_clr + MASK_REG(irq), MASK_BIT(irq));
+	aic_ic_write(ic, ic->info.mask_clr + off + MASK_REG(irq), MASK_BIT(irq));
 }
 
 static void aic_irq_eoi(struct irq_data *d)
@@ -541,27 +550,41 @@ static int aic_irq_domain_translate(struct irq_domain *id,
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
 			return -EINVAL;
-		*hwirq = AIC_IRQ_HWIRQ(fwspec->param[1]);
+		if (args[0] >= ic->nr_irq)
+			return -EINVAL;
+		*hwirq = AIC_IRQ_HWIRQ(die, args[0]);
 		break;
 	case AIC_FIQ:
-		if (fwspec->param[1] >= AIC_NR_FIQ)
+		if (die != 0)
+			return -EINVAL;
+		if (args[0] >= AIC_NR_FIQ)
 			return -EINVAL;
-		*hwirq = AIC_FIQ_HWIRQ(fwspec->param[1]);
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
@@ -580,7 +603,7 @@ static int aic_irq_domain_translate(struct irq_domain *id,
 		return -EINVAL;
 	}
 
-	*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+	*type = args[1] & IRQ_TYPE_SENSE_MASK;
 
 	return 0;
 }
@@ -899,8 +922,8 @@ static struct gic_kvm_info vgic_info __initdata = {
 
 static int __init aic_of_ic_init(struct device_node *node, struct device_node *parent)
 {
-	int i;
-	u32 off;
+	int i, die;
+	u32 off, start_off;
 	void __iomem *regs;
 	struct aic_irq_chip *irqc;
 	const struct of_device_id *match;
@@ -930,8 +953,9 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 		info = aic_ic_read(irqc, AIC_INFO);
 		irqc->nr_irq = FIELD_GET(AIC_INFO_NR_IRQ, info);
 		irqc->max_irq = AIC_MAX_IRQ;
+		irqc->nr_die = irqc->max_die = 1;
 
-		off = irqc->info.target_cpu;
+		off = start_off = irqc->info.target_cpu;
 		off += sizeof(u32) * irqc->max_irq; /* TARGET_CPU */
 
 		break;
@@ -953,6 +977,8 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	else
 		static_branch_disable(&use_fast_ipi);
 
+	irqc->info.die_stride = off - start_off;
+
 	irqc->hw_domain = irq_domain_create_tree(of_node_to_fwnode(node),
 						 &aic_irq_domain_ops, irqc);
 	if (WARN_ON(!irqc->hw_domain)) {
@@ -973,12 +999,17 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
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
@@ -992,8 +1023,8 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 
 	vgic_set_kvm_info(&vgic_info);
 
-	pr_info("Initialized with %d/%d IRQs, %d FIQs, %d vIPIs",
-		irqc->nr_irq, irqc->max_irq, AIC_NR_FIQ, AIC_NR_SWIPI);
+	pr_info("Initialized with %d/%d IRQs * %d/%d die(s), %d FIQs, %d vIPIs",
+		irqc->nr_irq, irqc->max_irq, irqc->nr_die, irqc->max_die, AIC_NR_FIQ, AIC_NR_SWIPI);
 
 	return 0;
 }
-- 
2.33.0

