Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484184D5E45
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347428AbiCKJVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbiCKJVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:21:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5393D1BD051
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:20:40 -0800 (PST)
Date:   Fri, 11 Mar 2022 09:20:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646990438;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vXp/BwMGaXuQDTZ+03zLkKk4vdPZ/zvYpldZ5HRG09E=;
        b=HJA8k4Vj1HHzbVh/H8mXLSg3x8VHYHJ+YVv/5qaouSf2jqYNjA5hmAlrRyM9A/YJbZQ5jc
        b8x9oC932F3s4g1D5f+W1nFkcVPuw/0LHPDG1WQWflc9QHiFecvevGGR8nIAUqK7kJM9IV
        SwlnnM7ZLnlFFb0s1eErXo72NQ/84b9h9GQe+dK1CvX0gL0yKrcCfL4rEMlk785hXsN4S0
        HHFtY51DD1wTYAj+arb+2Pu6zWwQXLWoDn3I/G3MXyxZnb6THb9w1njKy3nIiDU59PyqQ2
        BLQycUiXFJSSh7WlErBDFa5hpDru8QqxBGJqJ5BYjhuNqmJTC/FW172RKcd3yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646990438;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vXp/BwMGaXuQDTZ+03zLkKk4vdPZ/zvYpldZ5HRG09E=;
        b=5y8PyynJ1+2KBuFlsCRYVn/PZh6aXZnkDV9cBIRj7Ho7JCyy6LFhi7mPevtVZv+sztcNBo
        x46ltUsFL1y8L3Dw==
From:   "irqchip-bot for Hector Martin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/apple-aic: Switch to
 irq_domain_create_tree and sparse hwirqs
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220309192123.152028-5-marcan@marcan.st>
References: <20220309192123.152028-5-marcan@marcan.st>
MIME-Version: 1.0
Message-ID: <164699043776.16921.13619935458323408850.tip-bot2@tip-bot2>
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

Commit-ID:     7c841f5f6fa3f991cb76b96cd2378337a74011b3
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/7c841f5f6fa3f991cb76b96cd2378337a74011b3
Author:        Hector Martin <marcan@marcan.st>
AuthorDate:    Thu, 10 Mar 2022 04:21:20 +09:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Mar 2022 08:59:46 

irqchip/apple-aic: Switch to irq_domain_create_tree and sparse hwirqs

This allows us to directly use the hardware event number as the hwirq
number. Since IRQ events have bit 16 set (type=1), FIQs now move to
starting at hwirq number 0.

This will become more important once multi-die support is introduced in
a later commit.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220309192123.152028-5-marcan@marcan.st
---
 drivers/irqchip/irq-apple-aic.c | 71 +++++++++++++++++---------------
 1 file changed, 39 insertions(+), 32 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 613e0eb..9648038 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -68,7 +68,7 @@
  */
 
 #define AIC_INFO		0x0004
-#define AIC_INFO_NR_HW		GENMASK(15, 0)
+#define AIC_INFO_NR_IRQ		GENMASK(15, 0)
 
 #define AIC_CONFIG		0x0010
 
@@ -77,7 +77,8 @@
 #define AIC_EVENT_TYPE		GENMASK(31, 16)
 #define AIC_EVENT_NUM		GENMASK(15, 0)
 
-#define AIC_EVENT_TYPE_HW	1
+#define AIC_EVENT_TYPE_FIQ	0 /* Software use */
+#define AIC_EVENT_TYPE_IRQ	1
 #define AIC_EVENT_TYPE_IPI	4
 #define AIC_EVENT_IPI_OTHER	1
 #define AIC_EVENT_IPI_SELF	2
@@ -160,6 +161,11 @@
 #define MPIDR_CPU(x)			MPIDR_AFFINITY_LEVEL(x, 0)
 #define MPIDR_CLUSTER(x)		MPIDR_AFFINITY_LEVEL(x, 1)
 
+#define AIC_IRQ_HWIRQ(x)	(FIELD_PREP(AIC_EVENT_TYPE, AIC_EVENT_TYPE_IRQ) | \
+				 FIELD_PREP(AIC_EVENT_NUM, x))
+#define AIC_FIQ_HWIRQ(x)	(FIELD_PREP(AIC_EVENT_TYPE, AIC_EVENT_TYPE_FIQ) | \
+				 FIELD_PREP(AIC_EVENT_NUM, x))
+#define AIC_HWIRQ_IRQ(x)	FIELD_GET(AIC_EVENT_NUM, x)
 #define AIC_NR_FIQ		4
 #define AIC_NR_SWIPI		32
 
@@ -213,7 +219,7 @@ struct aic_irq_chip {
 	void __iomem *base;
 	struct irq_domain *hw_domain;
 	struct irq_domain *ipi_domain;
-	int nr_hw;
+	int nr_irq;
 
 	struct aic_info info;
 };
@@ -243,18 +249,22 @@ static void aic_ic_write(struct aic_irq_chip *ic, u32 reg, u32 val)
 
 static void aic_irq_mask(struct irq_data *d)
 {
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
 
-	aic_ic_write(ic, AIC_MASK_SET + MASK_REG(irqd_to_hwirq(d)),
-		     MASK_BIT(irqd_to_hwirq(d)));
+	u32 irq = AIC_HWIRQ_IRQ(hwirq);
+
+	aic_ic_write(ic, AIC_MASK_SET + MASK_REG(irq), MASK_BIT(irq));
 }
 
 static void aic_irq_unmask(struct irq_data *d)
 {
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
 
-	aic_ic_write(ic, AIC_MASK_CLR + MASK_REG(d->hwirq),
-		     MASK_BIT(irqd_to_hwirq(d)));
+	u32 irq = AIC_HWIRQ_IRQ(hwirq);
+
+	aic_ic_write(ic, AIC_MASK_CLR + MASK_REG(irq), MASK_BIT(irq));
 }
 
 static void aic_irq_eoi(struct irq_data *d)
@@ -281,8 +291,8 @@ static void __exception_irq_entry aic_handle_irq(struct pt_regs *regs)
 		type = FIELD_GET(AIC_EVENT_TYPE, event);
 		irq = FIELD_GET(AIC_EVENT_NUM, event);
 
-		if (type == AIC_EVENT_TYPE_HW)
-			generic_handle_domain_irq(aic_irqc->hw_domain, irq);
+		if (type == AIC_EVENT_TYPE_IRQ)
+			generic_handle_domain_irq(aic_irqc->hw_domain, event);
 		else if (type == AIC_EVENT_TYPE_IPI && irq == 1)
 			aic_handle_ipi(regs);
 		else if (event != 0)
@@ -314,7 +324,7 @@ static int aic_irq_set_affinity(struct irq_data *d,
 	else
 		cpu = cpumask_any_and(mask_val, cpu_online_mask);
 
-	aic_ic_write(ic, AIC_TARGET_CPU + hwirq * 4, BIT(cpu));
+	aic_ic_write(ic, AIC_TARGET_CPU + AIC_HWIRQ_IRQ(hwirq) * 4, BIT(cpu));
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
 	return IRQ_SET_MASK_OK;
@@ -344,9 +354,7 @@ static struct irq_chip aic_chip = {
 
 static unsigned long aic_fiq_get_idx(struct irq_data *d)
 {
-	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
-
-	return irqd_to_hwirq(d) - ic->nr_hw;
+	return AIC_HWIRQ_IRQ(irqd_to_hwirq(d));
 }
 
 static void aic_fiq_set_mask(struct irq_data *d)
@@ -434,11 +442,11 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 
 	if (TIMER_FIRING(read_sysreg(cntp_ctl_el0)))
 		generic_handle_domain_irq(aic_irqc->hw_domain,
-					  aic_irqc->nr_hw + AIC_TMR_EL0_PHYS);
+					  AIC_FIQ_HWIRQ(AIC_TMR_EL0_PHYS));
 
 	if (TIMER_FIRING(read_sysreg(cntv_ctl_el0)))
 		generic_handle_domain_irq(aic_irqc->hw_domain,
-					  aic_irqc->nr_hw + AIC_TMR_EL0_VIRT);
+					  AIC_FIQ_HWIRQ(AIC_TMR_EL0_VIRT));
 
 	if (is_kernel_in_hyp_mode()) {
 		uint64_t enabled = read_sysreg_s(SYS_IMP_APL_VM_TMR_FIQ_ENA_EL2);
@@ -446,12 +454,12 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 		if ((enabled & VM_TMR_FIQ_ENABLE_P) &&
 		    TIMER_FIRING(read_sysreg_s(SYS_CNTP_CTL_EL02)))
 			generic_handle_domain_irq(aic_irqc->hw_domain,
-						  aic_irqc->nr_hw + AIC_TMR_EL02_PHYS);
+						  AIC_FIQ_HWIRQ(AIC_TMR_EL02_PHYS));
 
 		if ((enabled & VM_TMR_FIQ_ENABLE_V) &&
 		    TIMER_FIRING(read_sysreg_s(SYS_CNTV_CTL_EL02)))
 			generic_handle_domain_irq(aic_irqc->hw_domain,
-						  aic_irqc->nr_hw + AIC_TMR_EL02_VIRT);
+						  AIC_FIQ_HWIRQ(AIC_TMR_EL02_VIRT));
 	}
 
 	if ((read_sysreg_s(SYS_IMP_APL_PMCR0_EL1) & (PMCR0_IMODE | PMCR0_IACT)) ==
@@ -496,9 +504,9 @@ static struct irq_chip fiq_chip = {
 static int aic_irq_domain_map(struct irq_domain *id, unsigned int irq,
 			      irq_hw_number_t hw)
 {
-	struct aic_irq_chip *ic = id->host_data;
+	u32 type = FIELD_GET(AIC_EVENT_TYPE, hw);
 
-	if (hw < ic->nr_hw) {
+	if (type == AIC_EVENT_TYPE_IRQ) {
 		irq_domain_set_info(id, irq, hw, &aic_chip, id->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
@@ -523,14 +531,14 @@ static int aic_irq_domain_translate(struct irq_domain *id,
 
 	switch (fwspec->param[0]) {
 	case AIC_IRQ:
-		if (fwspec->param[1] >= ic->nr_hw)
+		if (fwspec->param[1] >= ic->nr_irq)
 			return -EINVAL;
-		*hwirq = fwspec->param[1];
+		*hwirq = AIC_IRQ_HWIRQ(fwspec->param[1]);
 		break;
 	case AIC_FIQ:
 		if (fwspec->param[1] >= AIC_NR_FIQ)
 			return -EINVAL;
-		*hwirq = ic->nr_hw + fwspec->param[1];
+		*hwirq = AIC_FIQ_HWIRQ(fwspec->param[1]);
 
 		/*
 		 * In EL1 the non-redirected registers are the guest's,
@@ -539,10 +547,10 @@ static int aic_irq_domain_translate(struct irq_domain *id,
 		if (!is_kernel_in_hyp_mode()) {
 			switch (fwspec->param[1]) {
 			case AIC_TMR_GUEST_PHYS:
-				*hwirq = ic->nr_hw + AIC_TMR_EL0_PHYS;
+				*hwirq = AIC_FIQ_HWIRQ(AIC_TMR_EL0_PHYS);
 				break;
 			case AIC_TMR_GUEST_VIRT:
-				*hwirq = ic->nr_hw + AIC_TMR_EL0_VIRT;
+				*hwirq = AIC_FIQ_HWIRQ(AIC_TMR_EL0_VIRT);
 				break;
 			case AIC_TMR_HV_PHYS:
 			case AIC_TMR_HV_VIRT:
@@ -900,16 +908,15 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	aic_irqc = irqc;
 
 	info = aic_ic_read(irqc, AIC_INFO);
-	irqc->nr_hw = FIELD_GET(AIC_INFO_NR_HW, info);
+	irqc->nr_irq = FIELD_GET(AIC_INFO_NR_IRQ, info);
 
 	if (irqc->info.fast_ipi)
 		static_branch_enable(&use_fast_ipi);
 	else
 		static_branch_disable(&use_fast_ipi);
 
-	irqc->hw_domain = irq_domain_create_linear(of_node_to_fwnode(node),
-						   irqc->nr_hw + AIC_NR_FIQ,
-						   &aic_irq_domain_ops, irqc);
+	irqc->hw_domain = irq_domain_create_tree(of_node_to_fwnode(node),
+						 &aic_irq_domain_ops, irqc);
 	if (WARN_ON(!irqc->hw_domain)) {
 		iounmap(irqc->base);
 		kfree(irqc);
@@ -928,11 +935,11 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	set_handle_irq(aic_handle_irq);
 	set_handle_fiq(aic_handle_fiq);
 
-	for (i = 0; i < BITS_TO_U32(irqc->nr_hw); i++)
+	for (i = 0; i < BITS_TO_U32(irqc->nr_irq); i++)
 		aic_ic_write(irqc, AIC_MASK_SET + i * 4, U32_MAX);
-	for (i = 0; i < BITS_TO_U32(irqc->nr_hw); i++)
+	for (i = 0; i < BITS_TO_U32(irqc->nr_irq); i++)
 		aic_ic_write(irqc, AIC_SW_CLR + i * 4, U32_MAX);
-	for (i = 0; i < irqc->nr_hw; i++)
+	for (i = 0; i < irqc->nr_irq; i++)
 		aic_ic_write(irqc, AIC_TARGET_CPU + i * 4, 1);
 
 	if (!is_kernel_in_hyp_mode())
@@ -948,7 +955,7 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	vgic_set_kvm_info(&vgic_info);
 
 	pr_info("Initialized with %d IRQs, %d FIQs, %d vIPIs\n",
-		irqc->nr_hw, AIC_NR_FIQ, AIC_NR_SWIPI);
+		irqc->nr_irq, AIC_NR_FIQ, AIC_NR_SWIPI);
 
 	return 0;
 }
