Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8D555A011
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiFXSDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiFXSDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:03:31 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB22D1A04D;
        Fri, 24 Jun 2022 11:03:29 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,218,1650898800"; 
   d="scan'208";a="124039040"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Jun 2022 03:03:29 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1BD8F40C554E;
        Sat, 25 Jun 2022 03:03:24 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/2] irqchip/sifive-plic: Add support for Renesas RZ/Five SoC
Date:   Fri, 24 Jun 2022 19:03:11 +0100
Message-Id: <20220624180311.3007-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220624180311.3007-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220624180311.3007-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas RZ/Five SoC has a RISC-V AX45MP AndesCore with NCEPLIC100. The
NCEPLIC100 supports both edge-triggered and level-triggered interrupts. In
case of edge-triggered interrupts NCEPLIC100 ignores the next interrupt
edge until the previous completion message has been received and
NCEPLIC100 doesn't support pending interrupt counter, hence losing the
interrupts if not acknowledged in time.

So the workaround for edge-triggered interrupts to be handled correctly
and without losing is that it needs to be acknowledged first and then
handler must be run so that we don't miss on the next edge-triggered
interrupt.

This patch adds a new compatible string for Renesas RZ/Five SoC and
changes the chained interrupt haindler for RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
RFC-->v1:
* Fixed review comments pointed by Geert
* Dropped handle_fasteoi_ack_irq support as for the PLIC we need to
claim the interrupt by reading the register and then acknowledge it.
* Add a new chained handler for RZ/Five SoC.
---
 drivers/irqchip/irq-sifive-plic.c | 95 +++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 173446cc9204..f53dff49e122 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -60,10 +60,13 @@
 #define	PLIC_DISABLE_THRESHOLD		0x7
 #define	PLIC_ENABLE_THRESHOLD		0
 
+#define PLIC_INTERRUPT_CELL_SIZE2	2
+
 struct plic_priv {
 	struct cpumask lmask;
 	struct irq_domain *irqdomain;
 	void __iomem *regs;
+	u32 intsize;
 };
 
 struct plic_handler {
@@ -163,7 +166,7 @@ static int plic_set_affinity(struct irq_data *d,
 }
 #endif
 
-static void plic_irq_eoi(struct irq_data *d)
+static void plic_irq_ack(struct irq_data *d)
 {
 	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
 
@@ -176,6 +179,23 @@ static void plic_irq_eoi(struct irq_data *d)
 	}
 }
 
+static void plic_irq_eoi(struct irq_data *d)
+{
+	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+	unsigned int irq = irq_find_mapping(handler->priv->irqdomain, d->hwirq);
+
+	/*
+	 * For Renesas RZ/Five (R9A07G043) SoC if the interrupt type is
+	 * IRQ_TYPE_EDGE_RISING we have already acknowledged it in the
+	 * handler.
+	 */
+	if (handler->priv->intsize == PLIC_INTERRUPT_CELL_SIZE2 &&
+	    (irq_get_trigger_type(irq) & IRQ_TYPE_EDGE_RISING))
+		return;
+
+	plic_irq_ack(d);
+}
+
 static const struct irq_chip plic_chip = {
 	.name		= "SiFive PLIC",
 	.irq_mask	= plic_irq_mask,
@@ -198,6 +218,19 @@ static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
+static int plic_irq_domain_translate(struct irq_domain *d,
+				     struct irq_fwspec *fwspec,
+				     unsigned long *hwirq,
+				     unsigned int *type)
+{
+	struct plic_priv *priv = d->host_data;
+
+	if (priv->intsize == PLIC_INTERRUPT_CELL_SIZE2)
+		return irq_domain_translate_twocell(d, fwspec, hwirq, type);
+
+	return irq_domain_translate_onecell(d, fwspec, hwirq, type);
+}
+
 static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				 unsigned int nr_irqs, void *arg)
 {
@@ -206,7 +239,7 @@ static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	unsigned int type;
 	struct irq_fwspec *fwspec = arg;
 
-	ret = irq_domain_translate_onecell(domain, fwspec, &hwirq, &type);
+	ret = plic_irq_domain_translate(domain, fwspec, &hwirq, &type);
 	if (ret)
 		return ret;
 
@@ -220,11 +253,55 @@ static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops plic_irqdomain_ops = {
-	.translate	= irq_domain_translate_onecell,
+	.translate	= plic_irq_domain_translate,
 	.alloc		= plic_irq_domain_alloc,
 	.free		= irq_domain_free_irqs_top,
 };
 
+/*
+ * On Renesas RZ/Five (R9A07G043) SoC IRQ_TYPE_LEVEL_HIGH and
+ * IRQ_TYPE_EDGE_RISING interrupts are the supported interrupt types.
+ * If the global interrupt source was edge-triggered NCEPLIC100 (PLIC
+ * core on Renesas RZ/Five SoC) ignores next edge interrupts until the
+ * previous completion message is received. NCEPLIC100 on Renesas RZ/Five
+ * SoC doesn't stack the pending interrupts so in case there is a delay
+ * in handling the IRQ_TYPE_EDGE_RISING interrupt we lose the subsequent
+ * interrupts. The workaround for IRQ_TYPE_EDGE_RISING interrupt is to
+ * first we have to claim the interrupt by reading the claim register,
+ * then quickly issue an complete interrupt by writing the source ID
+ * register back to the claim  register and then later run the handler.
+ */
+static void renesas_rzfive_plic_handle_irq(struct irq_desc *desc)
+{
+	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	void __iomem *claim = handler->hart_base + CONTEXT_CLAIM;
+	irq_hw_number_t hwirq;
+	unsigned int irq;
+	int err;
+
+	WARN_ON_ONCE(!handler->present);
+
+	chained_irq_enter(chip, desc);
+
+	while ((hwirq = readl(claim))) {
+		irq = irq_find_mapping(handler->priv->irqdomain, hwirq);
+		if (!irq) {
+			pr_warn_ratelimited("can't find mapping for hwirq %lu\n", hwirq);
+			break;
+		}
+
+		if (irq_get_trigger_type(irq) & IRQ_TYPE_EDGE_RISING)
+			plic_irq_ack(irq_get_irq_data(irq));
+
+		err = generic_handle_irq(irq);
+		if (err)
+			pr_warn_ratelimited("error handling irq %u\n", irq);
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
 /*
  * Handling an interrupt is a two-step process: first you claim the interrupt
  * by reading the claim register, then you complete the interrupt by writing
@@ -288,11 +365,20 @@ static int __init plic_init(struct device_node *node,
 	u32 nr_irqs;
 	struct plic_priv *priv;
 	struct plic_handler *handler;
+	irq_flow_handler_t plic_chanined_handler;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
+	if (of_property_read_u32(node, "#interrupt-cells", &priv->intsize))
+		return -EINVAL;
+
+	if (priv->intsize == PLIC_INTERRUPT_CELL_SIZE2)
+		plic_chanined_handler = &renesas_rzfive_plic_handle_irq;
+	else
+		plic_chanined_handler = &plic_handle_irq;
+
 	priv->regs = of_iomap(node, 0);
 	if (WARN_ON(!priv->regs)) {
 		error = -EIO;
@@ -358,7 +444,7 @@ static int __init plic_init(struct device_node *node,
 			plic_parent_irq = irq_of_parse_and_map(node, i);
 			if (plic_parent_irq)
 				irq_set_chained_handler(plic_parent_irq,
-							plic_handle_irq);
+							plic_chanined_handler);
 		}
 
 		/*
@@ -411,5 +497,6 @@ static int __init plic_init(struct device_node *node,
 }
 
 IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
+IRQCHIP_DECLARE(renesas_r9a07g043_plic, "renesas,r9a07g043-plic", plic_init);
 IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
 IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_init); /* for firmware driver */
-- 
2.25.1

