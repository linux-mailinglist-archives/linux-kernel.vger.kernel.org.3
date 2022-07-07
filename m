Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20E3569E13
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235418AbiGGIu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbiGGIuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:50:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A8F45065
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:50:09 -0700 (PDT)
Date:   Thu, 07 Jul 2022 08:50:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657183808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kQMMeEWN31sPIE98ZCny+Mzr/8j2KWKLCIvMS4PoQsY=;
        b=YpjDpOiv+rWUoh/MWoXCd8J7d5I/QxmqUHslHJx2AHlKu4AdU8+VQLrSkVQtYOLtnM7wWt
        pijl96hfZIH487wFoHiDyiXHlAEg96d3TTP6llqt8YLPMoNSdU8GwLuwwoeVEBQUshUUss
        QSa1xN6sxZnAIZlf2ec1qI9EPOG+Y1ckRgo9iGQYsPBOWhaAoyaoqWss045PYiIgv3wQwB
        P30vX6rePHevF3HPGiX23GZl5u7CnDzQA5n5N3a5hc7C1lDZaEWRepP7Tw1ElDjD+8aqjm
        A7yypcBb4jel3f9v+Cci8sbok6dB1T1s4ZPhYEKFOf6hMRr1t3TKEartbQRgsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657183808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kQMMeEWN31sPIE98ZCny+Mzr/8j2KWKLCIvMS4PoQsY=;
        b=MjA+FN9G7Fb7Q39+EaY8otj4AIiXBkEHJR6tD6VCkV/9sGwWFBsH/aAtxiBXcACStBgdgR
        GjeYlWm1bEK/mYCw==
From:   "irqchip-bot for Samuel Holland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/mips-gic: Only register IPI
 domain when SMP is enabled
Cc:     kernel test robot <lkp@intel.com>,
        Samuel Holland <samuel@sholland.org>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220701200056.46555-2-samuel@sholland.org>
References: <20220701200056.46555-2-samuel@sholland.org>
MIME-Version: 1.0
Message-ID: <165718380687.15455.5041789110776942550.tip-bot2@tip-bot2>
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

Commit-ID:     8190cc572981f2f13b6ffc26c7cfa7899e5d3ccc
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/8190cc572981f2f13b6ffc26c7cfa7899e5d3ccc
Author:        Samuel Holland <samuel@sholland.org>
AuthorDate:    Fri, 01 Jul 2022 15:00:49 -05:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 07 Jul 2022 09:38:03 +01:00

irqchip/mips-gic: Only register IPI domain when SMP is enabled

The MIPS GIC irqchip driver may be selected in a uniprocessor
configuration, but it unconditionally registers an IPI domain.

Limit the part of the driver dealing with IPIs to only be compiled when
GENERIC_IRQ_IPI is enabled, which corresponds to an SMP configuration.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220701200056.46555-2-samuel@sholland.org
---
 drivers/irqchip/Kconfig        |  3 +-
 drivers/irqchip/irq-mips-gic.c | 80 ++++++++++++++++++++++-----------
 2 files changed, 56 insertions(+), 27 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 1f23a6b..d26a4ff 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -322,7 +322,8 @@ config KEYSTONE_IRQ
 
 config MIPS_GIC
 	bool
-	select GENERIC_IRQ_IPI
+	select GENERIC_IRQ_IPI if SMP
+	select IRQ_DOMAIN_HIERARCHY
 	select MIPS_CM
 
 config INGENIC_IRQ
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index ff89b36..8a9efb6 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -52,13 +52,15 @@ static DEFINE_PER_CPU_READ_MOSTLY(unsigned long[GIC_MAX_LONGS], pcpu_masks);
 
 static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
-static struct irq_domain *gic_ipi_domain;
 static int gic_shared_intrs;
 static unsigned int gic_cpu_pin;
 static unsigned int timer_cpu_pin;
 static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
+
+#ifdef CONFIG_GENERIC_IRQ_IPI
 static DECLARE_BITMAP(ipi_resrv, GIC_MAX_INTRS);
 static DECLARE_BITMAP(ipi_available, GIC_MAX_INTRS);
+#endif /* CONFIG_GENERIC_IRQ_IPI */
 
 static struct gic_all_vpes_chip_data {
 	u32	map;
@@ -472,9 +474,11 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 	u32 map;
 
 	if (hwirq >= GIC_SHARED_HWIRQ_BASE) {
+#ifdef CONFIG_GENERIC_IRQ_IPI
 		/* verify that shared irqs don't conflict with an IPI irq */
 		if (test_bit(GIC_HWIRQ_TO_SHARED(hwirq), ipi_resrv))
 			return -EBUSY;
+#endif /* CONFIG_GENERIC_IRQ_IPI */
 
 		err = irq_domain_set_hwirq_and_chip(d, virq, hwirq,
 						    &gic_level_irq_controller,
@@ -567,6 +571,8 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.map = gic_irq_domain_map,
 };
 
+#ifdef CONFIG_GENERIC_IRQ_IPI
+
 static int gic_ipi_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
 				const u32 *intspec, unsigned int intsize,
 				irq_hw_number_t *out_hwirq,
@@ -670,6 +676,48 @@ static const struct irq_domain_ops gic_ipi_domain_ops = {
 	.match = gic_ipi_domain_match,
 };
 
+static int gic_register_ipi_domain(struct device_node *node)
+{
+	struct irq_domain *gic_ipi_domain;
+	unsigned int v[2], num_ipis;
+
+	gic_ipi_domain = irq_domain_add_hierarchy(gic_irq_domain,
+						  IRQ_DOMAIN_FLAG_IPI_PER_CPU,
+						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
+						  node, &gic_ipi_domain_ops, NULL);
+	if (!gic_ipi_domain) {
+		pr_err("Failed to add IPI domain");
+		return -ENXIO;
+	}
+
+	irq_domain_update_bus_token(gic_ipi_domain, DOMAIN_BUS_IPI);
+
+	if (node &&
+	    !of_property_read_u32_array(node, "mti,reserved-ipi-vectors", v, 2)) {
+		bitmap_set(ipi_resrv, v[0], v[1]);
+	} else {
+		/*
+		 * Reserve 2 interrupts per possible CPU/VP for use as IPIs,
+		 * meeting the requirements of arch/mips SMP.
+		 */
+		num_ipis = 2 * num_possible_cpus();
+		bitmap_set(ipi_resrv, gic_shared_intrs - num_ipis, num_ipis);
+	}
+
+	bitmap_copy(ipi_available, ipi_resrv, GIC_MAX_INTRS);
+
+	return 0;
+}
+
+#else /* !CONFIG_GENERIC_IRQ_IPI */
+
+static inline int gic_register_ipi_domain(struct device_node *node)
+{
+	return 0;
+}
+
+#endif /* !CONFIG_GENERIC_IRQ_IPI */
+
 static int gic_cpu_startup(unsigned int cpu)
 {
 	/* Enable or disable EIC */
@@ -688,11 +736,12 @@ static int gic_cpu_startup(unsigned int cpu)
 static int __init gic_of_init(struct device_node *node,
 			      struct device_node *parent)
 {
-	unsigned int cpu_vec, i, gicconfig, v[2], num_ipis;
+	unsigned int cpu_vec, i, gicconfig;
 	unsigned long reserved;
 	phys_addr_t gic_base;
 	struct resource res;
 	size_t gic_len;
+	int ret;
 
 	/* Find the first available CPU vector. */
 	i = 0;
@@ -780,30 +829,9 @@ static int __init gic_of_init(struct device_node *node,
 		return -ENXIO;
 	}
 
-	gic_ipi_domain = irq_domain_add_hierarchy(gic_irq_domain,
-						  IRQ_DOMAIN_FLAG_IPI_PER_CPU,
-						  GIC_NUM_LOCAL_INTRS + gic_shared_intrs,
-						  node, &gic_ipi_domain_ops, NULL);
-	if (!gic_ipi_domain) {
-		pr_err("Failed to add IPI domain");
-		return -ENXIO;
-	}
-
-	irq_domain_update_bus_token(gic_ipi_domain, DOMAIN_BUS_IPI);
-
-	if (node &&
-	    !of_property_read_u32_array(node, "mti,reserved-ipi-vectors", v, 2)) {
-		bitmap_set(ipi_resrv, v[0], v[1]);
-	} else {
-		/*
-		 * Reserve 2 interrupts per possible CPU/VP for use as IPIs,
-		 * meeting the requirements of arch/mips SMP.
-		 */
-		num_ipis = 2 * num_possible_cpus();
-		bitmap_set(ipi_resrv, gic_shared_intrs - num_ipis, num_ipis);
-	}
-
-	bitmap_copy(ipi_available, ipi_resrv, GIC_MAX_INTRS);
+	ret = gic_register_ipi_domain(node);
+	if (ret)
+		return ret;
 
 	board_bind_eic_interrupt = &gic_bind_eic_interrupt;
 
