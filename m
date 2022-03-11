Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B284D5E44
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347418AbiCKJVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347391AbiCKJVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:21:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA0A1BD05E
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:20:39 -0800 (PST)
Date:   Fri, 11 Mar 2022 09:20:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646990438;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t6zT+CcrwmWPLH8yAbGKwWbIdN/E0nMlaJLrkNb+1l0=;
        b=rOtfXIt5KFwbvcz6exquAmfkzvHILNxa4xsdUXmZECro8YWL2LC6DBte0zY4XyrZQshrEm
        0Fdu88IuZXgS7zaKGEQqwvKqfFPqoVz2Uow4qI/3X4hGI0BdlqmgQFn5zS3j5cEi65biGH
        JNFIvzeXqX/5SgrUy4Rf9wcOGWZpW+vwQUk+ZqQk9/KWojp5oVfGbiVlw+8lx1G7wK0h76
        VTgNcVrKQIP8vYSJOODbwmAD8FnS3JZ1ZSESwAfkPH97wwGip09JFc5qJaNzS37VxklBfA
        hmb60vIh8tDEOfj4rQUihjskZbmuj151BbX82LgQdXVtUWn/mk+nv4Znq23YUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646990438;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t6zT+CcrwmWPLH8yAbGKwWbIdN/E0nMlaJLrkNb+1l0=;
        b=/S8W5quMFtu1ihZZwqsVID2gEPCuZ/5TchwAdU6Mqrh/jVoY+BMtyZC72+c6fpxSoTf+UN
        VuxXLZCE/NJxb9Dw==
From:   "irqchip-bot for Hector Martin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/apple-aic: Dynamically compute
 register offsets
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220309192123.152028-6-marcan@marcan.st>
References: <20220309192123.152028-6-marcan@marcan.st>
MIME-Version: 1.0
Message-ID: <164699043651.16921.6383157549558863615.tip-bot2@tip-bot2>
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

Commit-ID:     dc97fd6fec009957e81026055fc99a03877ff3b8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/dc97fd6fec009957e81026055fc99a03877ff3b8
Author:        Hector Martin <marcan@marcan.st>
AuthorDate:    Thu, 10 Mar 2022 04:21:21 +09:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Mar 2022 08:59:46 

irqchip/apple-aic: Dynamically compute register offsets

This allows us to support AIC variants with different numbers of IRQs
based on capability registers.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220309192123.152028-6-marcan@marcan.st
---
 drivers/irqchip/irq-apple-aic.c | 72 ++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 9648038..4b1ba73 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -64,7 +64,7 @@
 #include <dt-bindings/interrupt-controller/apple-aic.h>
 
 /*
- * AIC registers (MMIO)
+ * AIC v1 registers (MMIO)
  */
 
 #define AIC_INFO		0x0004
@@ -94,16 +94,14 @@
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
 
@@ -189,17 +187,31 @@ DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
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
 
@@ -219,7 +231,9 @@ struct aic_irq_chip {
 	void __iomem *base;
 	struct irq_domain *hw_domain;
 	struct irq_domain *ipi_domain;
+
 	int nr_irq;
+	int max_irq;
 
 	struct aic_info info;
 };
@@ -254,7 +268,7 @@ static void aic_irq_mask(struct irq_data *d)
 
 	u32 irq = AIC_HWIRQ_IRQ(hwirq);
 
-	aic_ic_write(ic, AIC_MASK_SET + MASK_REG(irq), MASK_BIT(irq));
+	aic_ic_write(ic, ic->info.mask_set + MASK_REG(irq), MASK_BIT(irq));
 }
 
 static void aic_irq_unmask(struct irq_data *d)
@@ -264,7 +278,7 @@ static void aic_irq_unmask(struct irq_data *d)
 
 	u32 irq = AIC_HWIRQ_IRQ(hwirq);
 
-	aic_ic_write(ic, AIC_MASK_CLR + MASK_REG(irq), MASK_BIT(irq));
+	aic_ic_write(ic, ic->info.mask_clr + MASK_REG(irq), MASK_BIT(irq));
 }
 
 static void aic_irq_eoi(struct irq_data *d)
@@ -287,7 +301,7 @@ static void __exception_irq_entry aic_handle_irq(struct pt_regs *regs)
 		 * We cannot use a relaxed read here, as reads from DMA buffers
 		 * need to be ordered after the IRQ fires.
 		 */
-		event = readl(ic->base + AIC_EVENT);
+		event = readl(ic->base + ic->info.event);
 		type = FIELD_GET(AIC_EVENT_TYPE, event);
 		irq = FIELD_GET(AIC_EVENT_NUM, event);
 
@@ -319,12 +333,14 @@ static int aic_irq_set_affinity(struct irq_data *d,
 	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
 	int cpu;
 
+	BUG_ON(!ic->info.target_cpu);
+
 	if (force)
 		cpu = cpumask_first(mask_val);
 	else
 		cpu = cpumask_any_and(mask_val, cpu_online_mask);
 
-	aic_ic_write(ic, AIC_TARGET_CPU + AIC_HWIRQ_IRQ(hwirq) * 4, BIT(cpu));
+	aic_ic_write(ic, ic->info.target_cpu + AIC_HWIRQ_IRQ(hwirq) * 4, BIT(cpu));
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
 	return IRQ_SET_MASK_OK;
@@ -884,8 +900,8 @@ static struct gic_kvm_info vgic_info __initdata = {
 static int __init aic_of_ic_init(struct device_node *node, struct device_node *parent)
 {
 	int i;
+	u32 off;
 	void __iomem *regs;
-	u32 info;
 	struct aic_irq_chip *irqc;
 	const struct of_device_id *match;
 
@@ -907,8 +923,30 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 
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
 
 	if (irqc->info.fast_ipi)
 		static_branch_enable(&use_fast_ipi);
@@ -936,11 +974,11 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
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
@@ -954,8 +992,8 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 
 	vgic_set_kvm_info(&vgic_info);
 
-	pr_info("Initialized with %d IRQs, %d FIQs, %d vIPIs\n",
-		irqc->nr_irq, AIC_NR_FIQ, AIC_NR_SWIPI);
+	pr_info("Initialized with %d/%d IRQs, %d FIQs, %d vIPIs",
+		irqc->nr_irq, irqc->max_irq, AIC_NR_FIQ, AIC_NR_SWIPI);
 
 	return 0;
 }
