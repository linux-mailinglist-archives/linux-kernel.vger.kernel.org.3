Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D95C46E18C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 05:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhLIEhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 23:37:16 -0500
Received: from marcansoft.com ([212.63.210.85]:54246 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232053AbhLIEhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 23:37:10 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DFA3C41EA2;
        Thu,  9 Dec 2021 04:33:33 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 6/6] irqchip/apple-aic: Add support for AICv2
Date:   Thu,  9 Dec 2021 13:32:49 +0900
Message-Id: <20211209043249.65474-7-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209043249.65474-1-marcan@marcan.st>
References: <20211209043249.65474-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce support for the new AICv2 hardware block in t6000/t6001 SoCs.

It seems these blocks are missing the information required to compute
the event register offset in the capability registers, so we specify
that in the DT.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/irqchip/irq-apple-aic.c | 146 ++++++++++++++++++++++++++++----
 1 file changed, 128 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 46b7750548a0..226d5232dd14 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -101,6 +101,57 @@
 
 #define AIC_MAX_IRQ		0x400
 
+/*
+ * AIC v2 registers (MMIO)
+ */
+
+#define AIC2_VERSION		0x0000
+#define AIC2_VERSION_VER	GENMASK(7, 0)
+
+#define AIC2_INFO1		0x0004
+#define AIC2_INFO1_NR_IRQ	GENMASK(15, 0)
+#define AIC2_INFO1_LAST_DIE	GENMASK(27, 24)
+
+#define AIC2_INFO2		0x0008
+
+#define AIC2_INFO3		0x000c
+#define AIC2_INFO3_MAX_IRQ	GENMASK(15, 0)
+#define AIC2_INFO3_MAX_DIE	GENMASK(27, 24)
+
+#define AIC2_RESET		0x0010
+#define AIC2_RESET_RESET	BIT(0)
+
+#define AIC2_CONFIG		0x0014
+#define AIC2_CONFIG_ENABLE	BIT(0)
+#define AIC2_CONFIG_PREFER_PCPU	BIT(28)
+
+#define AIC2_TIMEOUT		0x0028
+#define AIC2_CLUSTER_PRIO	0x0030
+#define AIC2_DELAY_GROUPS	0x0100
+
+#define AIC2_IRQ_CFG		0x2000
+
+/*
+ * AIC2 registers are laid out like this, starting at AIC2_IRQ_CFG:
+ *
+ * Repeat for each die:
+ *   IRQ_CFG: u32 * MAX_IRQS
+ *   SW_SET: u32 * (MAX_IRQS / 32)
+ *   SW_CLR: u32 * (MAX_IRQS / 32)
+ *   MASK_SET: u32 * (MAX_IRQS / 32)
+ *   MASK_CLR: u32 * (MAX_IRQS / 32)
+ *   HW_STATE: u32 * (MAX_IRQS / 32)
+ *
+ * This is followed by a set of event registers, each 16K page aligned.
+ * The first one is the AP event register we will use. Unfortunately,
+ * the actual implemented die count is not specified anywhere in the
+ * capability registers, so we have to explcitly specify the event
+ * register offset in the device tree to remain forward-compatible.
+ */
+
+#define AIC2_IRQ_CFG_TARGET	GENMASK(3, 0)
+#define AIC2_IRQ_CFG_DELAY_IDX	GENMASK(7, 5)
+
 #define MASK_REG(x)		(4 * ((x) >> 5))
 #define MASK_BIT(x)		BIT((x) & GENMASK(4, 0))
 
@@ -187,6 +238,7 @@ struct aic_info {
 	/* Register offsets */
 	u32 event;
 	u32 target_cpu;
+	u32 irq_cfg;
 	u32 sw_set;
 	u32 sw_clr;
 	u32 mask_set;
@@ -214,6 +266,14 @@ static const struct aic_info aic1_fipi_info = {
 	.fast_ipi	= true,
 };
 
+static const struct aic_info aic2_info = {
+	.version	= 2,
+
+	.irq_cfg	= AIC2_IRQ_CFG,
+
+	.fast_ipi	= true,
+};
+
 static const struct of_device_id aic_info_match[] = {
 	{
 		.compatible = "apple,t8103-aic",
@@ -223,6 +283,10 @@ static const struct of_device_id aic_info_match[] = {
 		.compatible = "apple,aic",
 		.data = &aic1_info,
 	},
+	{
+		.compatible = "apple,aic2",
+		.data = &aic2_info,
+	},
 	{}
 };
 
@@ -368,6 +432,14 @@ static struct irq_chip aic_chip = {
 	.irq_set_type = aic_irq_set_type,
 };
 
+static struct irq_chip aic2_chip = {
+	.name = "AIC2",
+	.irq_mask = aic_irq_mask,
+	.irq_unmask = aic_irq_unmask,
+	.irq_eoi = aic_irq_eoi,
+	.irq_set_type = aic_irq_set_type,
+};
+
 /*
  * FIQ irqchip
  */
@@ -524,10 +596,15 @@ static struct irq_chip fiq_chip = {
 static int aic_irq_domain_map(struct irq_domain *id, unsigned int irq,
 			      irq_hw_number_t hw)
 {
+	struct aic_irq_chip *ic = id->host_data;
 	u32 type = FIELD_GET(AIC_EVENT_TYPE, hw);
+	struct irq_chip *chip = &aic_chip;
+
+	if (ic->info.version == 2)
+		chip = &aic2_chip;
 
 	if (type == AIC_EVENT_TYPE_HW) {
-		irq_domain_set_info(id, irq, hw, &aic_chip, id->host_data,
+		irq_domain_set_info(id, irq, hw, chip, id->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
 	} else if (type == AIC_EVENT_TYPE_FIQ) {
@@ -882,23 +959,25 @@ static int aic_init_cpu(unsigned int cpu)
 	/* Commit all of the above */
 	isb();
 
-	/*
-	 * Make sure the kernel's idea of logical CPU order is the same as AIC's
-	 * If we ever end up with a mismatch here, we will have to introduce
-	 * a mapping table similar to what other irqchip drivers do.
-	 */
-	WARN_ON(aic_ic_read(aic_irqc, AIC_WHOAMI) != smp_processor_id());
+	if (aic_irqc->info.version == 1) {
+		/*
+		 * Make sure the kernel's idea of logical CPU order is the same as AIC's
+		 * If we ever end up with a mismatch here, we will have to introduce
+		 * a mapping table similar to what other irqchip drivers do.
+		 */
+		WARN_ON(aic_ic_read(aic_irqc, AIC_WHOAMI) != smp_processor_id());
 
-	/*
-	 * Always keep IPIs unmasked at the hardware level (except auto-masking
-	 * by AIC during processing). We manage masks at the vIPI level.
-	 */
-	aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_SELF | AIC_IPI_OTHER);
-	if (!aic_irqc->info.fast_ipi) {
-		aic_ic_write(aic_irqc, AIC_IPI_MASK_SET, AIC_IPI_SELF);
-		aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
-	} else {
-		aic_ic_write(aic_irqc, AIC_IPI_MASK_SET, AIC_IPI_SELF | AIC_IPI_OTHER);
+		/*
+		 * Always keep IPIs unmasked at the hardware level (except auto-masking
+		 * by AIC during processing). We manage masks at the vIPI level.
+		 */
+		aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_SELF | AIC_IPI_OTHER);
+		if (!aic_irqc->info.fast_ipi) {
+			aic_ic_write(aic_irqc, AIC_IPI_MASK_SET, AIC_IPI_SELF);
+			aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
+		} else {
+			aic_ic_write(aic_irqc, AIC_IPI_MASK_SET, AIC_IPI_SELF | AIC_IPI_OTHER);
+		}
 	}
 
 	/* Initialize the local mask state */
@@ -953,6 +1032,29 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 
 		break;
 	}
+	case 2: {
+		u32 info1, info3;
+
+		info1 = aic_ic_read(irqc, AIC2_INFO1);
+		info3 = aic_ic_read(irqc, AIC2_INFO3);
+
+		irqc->nr_irq = FIELD_GET(AIC2_INFO1_NR_IRQ, info1);
+		irqc->max_irq = FIELD_GET(AIC2_INFO3_MAX_IRQ, info3);
+		irqc->nr_die = FIELD_GET(AIC2_INFO1_LAST_DIE, info1) + 1;
+		irqc->max_die = FIELD_GET(AIC2_INFO3_MAX_DIE, info3);
+
+		off = start_off = irqc->info.irq_cfg;
+		off += sizeof(u32) * irqc->max_irq; /* IRQ_CFG */
+
+		if (of_property_read_u32(node, "apple,event-reg", &irqc->info.event) < 0) {
+			pr_err("Failed to get apple,event-reg property");
+			iounmap(irqc->base);
+			kfree(irqc);
+			return -ENODEV;
+		}
+
+		break;
+	}
 	}
 
 	irqc->info.sw_set = off;
@@ -999,6 +1101,13 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 		off += irqc->info.die_stride;
 	}
 
+	if (irqc->info.version == 2) {
+		u32 config = aic_ic_read(irqc, AIC2_CONFIG);
+
+		config |= AIC2_CONFIG_ENABLE;
+		aic_ic_write(irqc, AIC2_CONFIG, config);
+	}
+
 	if (!is_kernel_in_hyp_mode())
 		pr_info("Kernel running in EL1, mapping interrupts");
 
@@ -1017,4 +1126,5 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	return 0;
 }
 
-IRQCHIP_DECLARE(apple_m1_aic, "apple,aic", aic_of_ic_init);
+IRQCHIP_DECLARE(apple_aic, "apple,aic", aic_of_ic_init);
+IRQCHIP_DECLARE(apple_aic2, "apple,aic2", aic_of_ic_init);
-- 
2.33.0

