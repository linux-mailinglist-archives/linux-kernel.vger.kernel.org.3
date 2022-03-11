Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939434D5E46
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347412AbiCKJVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347388AbiCKJVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:21:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5B21BD05B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:20:38 -0800 (PST)
Date:   Fri, 11 Mar 2022 09:20:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646990436;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8GonAYtSpZjNXZsLXx8i8OotrK/IuPCNnxQKAWeALZI=;
        b=UeQfqtA1TcN01C7HmzVx6RaDWx9ACIJX7aWc29f5gjxYYQiHzxwWQNbB1qWJNg9xK2FUrN
        Zr1q3t4647lkMSa4N1qsLF1hzoEOV4iojR3ved8wSaoOvFFhl5yf5u32JnqPNlvHSm+x4o
        te1mT7pV+GSI4bg1UIxc83K98YSvL1r77SNu9YWbhAaJwPrRkbGssGZNp3rbjRMX0I/m9N
        IaiPBvwEkFjif6sGe4VXeJKMva8oxkVv7TmrTHD7lNtvAvUA6KE6iVV5t5TnOENMFYhnt9
        WY6FjZ3LJ6ZP7Et3W5I58nhnlQ5phwlR3jZ14EvOVnj23UbBN6MaW4buENdDlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646990436;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8GonAYtSpZjNXZsLXx8i8OotrK/IuPCNnxQKAWeALZI=;
        b=9SPONLiOLO0CdQCHdSViwadvKZNlaT30l74utHOKJSLHZmPi9kxorp3EE19qTW9H7A1xGQ
        +vPSAB5QCY7OHEAA==
From:   "irqchip-bot for Hector Martin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/apple-aic: Add support for AICv2
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220309192123.152028-8-marcan@marcan.st>
References: <20220309192123.152028-8-marcan@marcan.st>
MIME-Version: 1.0
Message-ID: <164699043431.16921.2816635433995674360.tip-bot2@tip-bot2>
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

Commit-ID:     768d4435de2a042f35069c68587d8e6702102248
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/768d4435de2a042f35069c68587d8e6702102248
Author:        Hector Martin <marcan@marcan.st>
AuthorDate:    Thu, 10 Mar 2022 04:21:23 +09:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Mar 2022 08:59:47 

irqchip/apple-aic: Add support for AICv2

Introduce support for the new AICv2 hardware block in t6000/t6001 SoCs.

It seems these blocks are missing the information required to compute
the event register offset in the capability registers, so we specify
that in the DT as a second reg entry.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220309192123.152028-8-marcan@marcan.st
---
 drivers/irqchip/irq-apple-aic.c | 181 +++++++++++++++++++++++++------
 1 file changed, 148 insertions(+), 33 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 93c6224..ba2dff7 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -103,6 +103,58 @@
 
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
+ * capability registers, so we have to explicitly specify the event
+ * register as a second reg entry in the device tree to remain
+ * forward-compatible.
+ */
+
+#define AIC2_IRQ_CFG_TARGET	GENMASK(3, 0)
+#define AIC2_IRQ_CFG_DELAY_IDX	GENMASK(7, 5)
+
 #define MASK_REG(x)		(4 * ((x) >> 5))
 #define MASK_BIT(x)		BIT((x) & GENMASK(4, 0))
 
@@ -193,6 +245,7 @@ struct aic_info {
 	/* Register offsets */
 	u32 event;
 	u32 target_cpu;
+	u32 irq_cfg;
 	u32 sw_set;
 	u32 sw_clr;
 	u32 mask_set;
@@ -220,6 +273,14 @@ static const struct aic_info aic1_fipi_info = {
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
@@ -229,11 +290,16 @@ static const struct of_device_id aic_info_match[] = {
 		.compatible = "apple,aic",
 		.data = &aic1_info,
 	},
+	{
+		.compatible = "apple,aic2",
+		.data = &aic2_info,
+	},
 	{}
 };
 
 struct aic_irq_chip {
 	void __iomem *base;
+	void __iomem *event;
 	struct irq_domain *hw_domain;
 	struct irq_domain *ipi_domain;
 
@@ -310,7 +376,7 @@ static void __exception_irq_entry aic_handle_irq(struct pt_regs *regs)
 		 * We cannot use a relaxed read here, as reads from DMA buffers
 		 * need to be ordered after the IRQ fires.
 		 */
-		event = readl(ic->base + ic->info.event);
+		event = readl(ic->event + ic->info.event);
 		type = FIELD_GET(AIC_EVENT_TYPE, event);
 		irq = FIELD_GET(AIC_EVENT_NUM, event);
 
@@ -373,6 +439,14 @@ static struct irq_chip aic_chip = {
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
@@ -529,10 +603,15 @@ static struct irq_chip fiq_chip = {
 static int aic_irq_domain_map(struct irq_domain *id, unsigned int irq,
 			      irq_hw_number_t hw)
 {
+	struct aic_irq_chip *ic = id->host_data;
 	u32 type = FIELD_GET(AIC_EVENT_TYPE, hw);
+	struct irq_chip *chip = &aic_chip;
+
+	if (ic->info.version == 2)
+		chip = &aic2_chip;
 
 	if (type == AIC_EVENT_TYPE_IRQ) {
-		irq_domain_set_info(id, irq, hw, &aic_chip, id->host_data,
+		irq_domain_set_info(id, irq, hw, chip, id->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
 	} else {
@@ -888,24 +967,26 @@ static int aic_init_cpu(unsigned int cpu)
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
-	 * These registers only exist on AICv1, AICv2 always uses fast IPIs.
-	 */
-	aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_SELF | AIC_IPI_OTHER);
-	if (static_branch_likely(&use_fast_ipi)) {
-		aic_ic_write(aic_irqc, AIC_IPI_MASK_SET, AIC_IPI_SELF | AIC_IPI_OTHER);
-	} else {
-		aic_ic_write(aic_irqc, AIC_IPI_MASK_SET, AIC_IPI_SELF);
-		aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
+		/*
+		 * Always keep IPIs unmasked at the hardware level (except auto-masking
+		 * by AIC during processing). We manage masks at the vIPI level.
+		 * These registers only exist on AICv1, AICv2 always uses fast IPIs.
+		 */
+		aic_ic_write(aic_irqc, AIC_IPI_ACK, AIC_IPI_SELF | AIC_IPI_OTHER);
+		if (static_branch_likely(&use_fast_ipi)) {
+			aic_ic_write(aic_irqc, AIC_IPI_MASK_SET, AIC_IPI_SELF | AIC_IPI_OTHER);
+		} else {
+			aic_ic_write(aic_irqc, AIC_IPI_MASK_SET, AIC_IPI_SELF);
+			aic_ic_write(aic_irqc, AIC_IPI_MASK_CLR, AIC_IPI_OTHER);
+		}
 	}
 
 	/* Initialize the local mask state */
@@ -933,14 +1014,16 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 		return -EIO;
 
 	irqc = kzalloc(sizeof(*irqc), GFP_KERNEL);
-	if (!irqc)
+	if (!irqc) {
+		iounmap(regs);
 		return -ENOMEM;
+	}
 
 	irqc->base = regs;
 
 	match = of_match_node(aic_info_match, node);
 	if (!match)
-		return -ENODEV;
+		goto err_unmap;
 
 	irqc->info = *(struct aic_info *)match->data;
 
@@ -958,6 +1041,28 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 		off = start_off = irqc->info.target_cpu;
 		off += sizeof(u32) * irqc->max_irq; /* TARGET_CPU */
 
+		irqc->event = irqc->base;
+
+		break;
+	}
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
+		irqc->event = of_iomap(node, 1);
+		if (WARN_ON(!irqc->event))
+			goto err_unmap;
+
 		break;
 	}
 	}
@@ -981,20 +1086,13 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 
 	irqc->hw_domain = irq_domain_create_tree(of_node_to_fwnode(node),
 						 &aic_irq_domain_ops, irqc);
-	if (WARN_ON(!irqc->hw_domain)) {
-		iounmap(irqc->base);
-		kfree(irqc);
-		return -ENODEV;
-	}
+	if (WARN_ON(!irqc->hw_domain))
+		goto err_unmap;
 
 	irq_domain_update_bus_token(irqc->hw_domain, DOMAIN_BUS_WIRED);
 
-	if (aic_init_smp(irqc, node)) {
-		irq_domain_remove(irqc->hw_domain);
-		iounmap(irqc->base);
-		kfree(irqc);
-		return -ENODEV;
-	}
+	if (aic_init_smp(irqc, node))
+		goto err_remove_domain;
 
 	set_handle_irq(aic_handle_irq);
 	set_handle_fiq(aic_handle_fiq);
@@ -1011,6 +1109,13 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
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
 
@@ -1027,6 +1132,16 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 		irqc->nr_irq, irqc->max_irq, irqc->nr_die, irqc->max_die, AIC_NR_FIQ, AIC_NR_SWIPI);
 
 	return 0;
+
+err_remove_domain:
+	irq_domain_remove(irqc->hw_domain);
+err_unmap:
+	if (irqc->event && irqc->event != irqc->base)
+		iounmap(irqc->event);
+	iounmap(irqc->base);
+	kfree(irqc);
+	return -ENODEV;
 }
 
-IRQCHIP_DECLARE(apple_m1_aic, "apple,aic", aic_of_ic_init);
+IRQCHIP_DECLARE(apple_aic, "apple,aic", aic_of_ic_init);
+IRQCHIP_DECLARE(apple_aic2, "apple,aic2", aic_of_ic_init);
