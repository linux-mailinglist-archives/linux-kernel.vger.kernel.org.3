Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6D346E183
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 05:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbhLIEhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 23:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbhLIEhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 23:37:02 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE669C061353;
        Wed,  8 Dec 2021 20:33:28 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 0B6F142458;
        Thu,  9 Dec 2021 04:33:23 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 3/6] irqchip/apple-aic: Switch to irq_domain_create_tree and sparse hwirqs
Date:   Thu,  9 Dec 2021 13:32:46 +0900
Message-Id: <20211209043249.65474-4-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211209043249.65474-1-marcan@marcan.st>
References: <20211209043249.65474-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to directly use the hardware event number as the hwirq
number. Since IRQ events have bit 16 set (type=1), FIQs now move to
starting at hwirq number 0.

This will become more important once multi-die support is introduced in
a later commit.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/irqchip/irq-apple-aic.c | 67 ++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 1aa63580cae4..572d1af175fc 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -66,7 +66,7 @@
  */
 
 #define AIC_INFO		0x0004
-#define AIC_INFO_NR_HW		GENMASK(15, 0)
+#define AIC_INFO_NR_IRQ		GENMASK(15, 0)
 
 #define AIC_CONFIG		0x0010
 
@@ -75,6 +75,7 @@
 #define AIC_EVENT_TYPE		GENMASK(31, 16)
 #define AIC_EVENT_NUM		GENMASK(15, 0)
 
+#define AIC_EVENT_TYPE_FIQ	0 /* Software use */
 #define AIC_EVENT_TYPE_HW	1
 #define AIC_EVENT_TYPE_IPI	4
 #define AIC_EVENT_IPI_OTHER	1
@@ -158,6 +159,8 @@
 #define MPIDR_CPU			GENMASK(7, 0)
 #define MPIDR_CLUSTER			GENMASK(15, 8)
 
+#define AIC_FIQ_HWIRQ(x)	(FIELD_PREP(AIC_EVENT_TYPE, AIC_EVENT_TYPE_FIQ) | \
+				 FIELD_PREP(AIC_EVENT_NUM, x))
 #define AIC_NR_FIQ		4
 #define AIC_NR_SWIPI		32
 
@@ -209,7 +212,7 @@ struct aic_irq_chip {
 	void __iomem *base;
 	struct irq_domain *hw_domain;
 	struct irq_domain *ipi_domain;
-	int nr_hw;
+	int nr_irq;
 
 	struct aic_info info;
 };
@@ -239,18 +242,22 @@ static void aic_ic_write(struct aic_irq_chip *ic, u32 reg, u32 val)
 
 static void aic_irq_mask(struct irq_data *d)
 {
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
 
-	aic_ic_write(ic, AIC_MASK_SET + MASK_REG(irqd_to_hwirq(d)),
-		     MASK_BIT(irqd_to_hwirq(d)));
+	u32 irq = FIELD_GET(AIC_EVENT_NUM, hwirq);
+
+	aic_ic_write(ic, AIC_MASK_SET + MASK_REG(irq), MASK_BIT(irq));
 }
 
 static void aic_irq_unmask(struct irq_data *d)
 {
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
 	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
 
-	aic_ic_write(ic, AIC_MASK_CLR + MASK_REG(d->hwirq),
-		     MASK_BIT(irqd_to_hwirq(d)));
+	u32 irq = FIELD_GET(AIC_EVENT_NUM, hwirq);
+
+	aic_ic_write(ic, AIC_MASK_CLR + MASK_REG(irq), MASK_BIT(irq));
 }
 
 static void aic_irq_eoi(struct irq_data *d)
@@ -278,7 +285,7 @@ static void __exception_irq_entry aic_handle_irq(struct pt_regs *regs)
 		irq = FIELD_GET(AIC_EVENT_NUM, event);
 
 		if (type == AIC_EVENT_TYPE_HW)
-			generic_handle_domain_irq(aic_irqc->hw_domain, irq);
+			generic_handle_domain_irq(aic_irqc->hw_domain, event);
 		else if (type == AIC_EVENT_TYPE_IPI && irq == 1)
 			aic_handle_ipi(regs);
 		else if (event != 0)
@@ -310,7 +317,7 @@ static int aic_irq_set_affinity(struct irq_data *d,
 	else
 		cpu = cpumask_any_and(mask_val, cpu_online_mask);
 
-	aic_ic_write(ic, AIC_TARGET_CPU + hwirq * 4, BIT(cpu));
+	aic_ic_write(ic, AIC_TARGET_CPU + FIELD_GET(AIC_EVENT_NUM, hwirq) * 4, BIT(cpu));
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
 	return IRQ_SET_MASK_OK;
@@ -340,9 +347,7 @@ static struct irq_chip aic_chip = {
 
 static unsigned long aic_fiq_get_idx(struct irq_data *d)
 {
-	struct aic_irq_chip *ic = irq_data_get_irq_chip_data(d);
-
-	return irqd_to_hwirq(d) - ic->nr_hw;
+	return FIELD_GET(AIC_EVENT_NUM, irqd_to_hwirq(d));
 }
 
 static void aic_fiq_set_mask(struct irq_data *d)
@@ -430,11 +435,11 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
 
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
@@ -442,12 +447,12 @@ static void __exception_irq_entry aic_handle_fiq(struct pt_regs *regs)
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
@@ -492,13 +497,13 @@ static struct irq_chip fiq_chip = {
 static int aic_irq_domain_map(struct irq_domain *id, unsigned int irq,
 			      irq_hw_number_t hw)
 {
-	struct aic_irq_chip *ic = id->host_data;
+	u32 type = FIELD_GET(AIC_EVENT_TYPE, hw);
 
-	if (hw < ic->nr_hw) {
+	if (type == AIC_EVENT_TYPE_HW) {
 		irq_domain_set_info(id, irq, hw, &aic_chip, id->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
-	} else {
+	} else if (type == AIC_EVENT_TYPE_FIQ) {
 		irq_set_percpu_devid(irq);
 		irq_domain_set_info(id, irq, hw, &fiq_chip, id->host_data,
 				    handle_percpu_devid_irq, NULL, NULL);
@@ -519,14 +524,15 @@ static int aic_irq_domain_translate(struct irq_domain *id,
 
 	switch (fwspec->param[0]) {
 	case AIC_IRQ:
-		if (fwspec->param[1] >= ic->nr_hw)
+		if (fwspec->param[1] >= ic->nr_irq)
 			return -EINVAL;
-		*hwirq = fwspec->param[1];
+		*hwirq = (FIELD_PREP(AIC_EVENT_TYPE, AIC_EVENT_TYPE_HW) |
+			  FIELD_PREP(AIC_EVENT_NUM, fwspec->param[1]));
 		break;
 	case AIC_FIQ:
 		if (fwspec->param[1] >= AIC_NR_FIQ)
 			return -EINVAL;
-		*hwirq = ic->nr_hw + fwspec->param[1];
+		*hwirq = AIC_FIQ_HWIRQ(fwspec->param[1]);
 
 		/*
 		 * In EL1 the non-redirected registers are the guest's,
@@ -535,10 +541,10 @@ static int aic_irq_domain_translate(struct irq_domain *id,
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
@@ -894,11 +900,10 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	aic_irqc = irqc;
 
 	info = aic_ic_read(irqc, AIC_INFO);
-	irqc->nr_hw = FIELD_GET(AIC_INFO_NR_HW, info);
+	irqc->nr_irq = FIELD_GET(AIC_INFO_NR_IRQ, info);
 
-	irqc->hw_domain = irq_domain_create_linear(of_node_to_fwnode(node),
-						   irqc->nr_hw + AIC_NR_FIQ,
-						   &aic_irq_domain_ops, irqc);
+	irqc->hw_domain = irq_domain_create_tree(of_node_to_fwnode(node),
+						 &aic_irq_domain_ops, irqc);
 	if (WARN_ON(!irqc->hw_domain)) {
 		iounmap(irqc->base);
 		kfree(irqc);
@@ -917,11 +922,11 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
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
@@ -937,7 +942,7 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 	vgic_set_kvm_info(&vgic_info);
 
 	pr_info("Initialized with %d IRQs, %d FIQs, %d vIPIs\n",
-		irqc->nr_hw, AIC_NR_FIQ, AIC_NR_SWIPI);
+		irqc->nr_irq, AIC_NR_FIQ, AIC_NR_SWIPI);
 
 	return 0;
 }
-- 
2.33.0

