Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF50563601
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiGAOkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiGAOjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:39:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9183A4504F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:37:38 -0700 (PDT)
Date:   Fri, 01 Jul 2022 14:37:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656686257;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aD1D69e9TTB6sciVBzRfVTOcvxg9yJV/HIP8x76TUPI=;
        b=qk34+Ty9EOvU9siyj3ynQzHpvfRAMRKhSq9Ruyi7F1WZet//ACVJomRYxIt5R4ddv8TFK8
        4SkTiNbO3dNp+ybXlK+HAYmhFeB2gcXiXnorlKdGduvZ5n4fHjWDD0GGtxqpqIYrLa5wzn
        qQ2DDGnDKQqR6+s89hFnAQw/Wdv0Al2xHYOu+CIgU5A2FYd1fGacj3GmZ0PF8XgHXqcjaw
        zlixDrw4AtGFDi0MtM0Oo/CrpRPHv3jhipP7j/jrXxC92Rj9aFwjDvOuGfkPLKiuvSJ+IN
        i5MDr0RtXu8b4431jRWnX4gGZn/a981nuCsRifytQiFNdXKprYkUWVYNasO+DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656686257;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aD1D69e9TTB6sciVBzRfVTOcvxg9yJV/HIP8x76TUPI=;
        b=jvb1nWcO9L/CkNIfYIOkI4rgXdEJWALQXIU913Ba/Z+MloHqAB+OPHSTAhcZKRexi6W4g3
        c/Wnrf3z5j8M7EBw==
From:   "irqchip-bot for Lad Prabhakar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/sifive-plic: Add support for
 Renesas RZ/Five SoC
Cc:     Marc Zyngier <maz@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Samuel Holland <samuel@sholland.org>, tglx@linutronix.de
In-Reply-To: <20220630100241.35233-3-samuel@sholland.org>
References: <20220630100241.35233-3-samuel@sholland.org>
MIME-Version: 1.0
Message-ID: <165668625606.15455.6228532535029208746.tip-bot2@tip-bot2>
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

Commit-ID:     dd46337ca69662b6912bc230d393c4261d126b8f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/dd46337ca69662b6912bc230d393c4261d126b8f
Author:        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
AuthorDate:    Thu, 30 Jun 2022 05:02:39 -05:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 01 Jul 2022 15:27:23 +01:00

irqchip/sifive-plic: Add support for Renesas RZ/Five SoC

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

This patch adds a new compatible string for NCEPLIC100 (from Andes
Technology) interrupt controller found on Renesas RZ/Five SoC and adds
quirk bits to priv structure and implements PLIC_QUIRK_EDGE_INTERRUPT
quirk to change the interrupt flow.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220630100241.35233-3-samuel@sholland.org
---
 drivers/irqchip/irq-sifive-plic.c | 78 ++++++++++++++++++++++++++++--
 1 file changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index bb87e4c..90e4436 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -60,10 +60,13 @@
 #define	PLIC_DISABLE_THRESHOLD		0x7
 #define	PLIC_ENABLE_THRESHOLD		0
 
+#define PLIC_QUIRK_EDGE_INTERRUPT	0
+
 struct plic_priv {
 	struct cpumask lmask;
 	struct irq_domain *irqdomain;
 	void __iomem *regs;
+	unsigned long plic_quirks;
 };
 
 struct plic_handler {
@@ -81,6 +84,8 @@ static int plic_parent_irq __ro_after_init;
 static bool plic_cpuhp_setup_done __ro_after_init;
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
 
+static int plic_irq_set_type(struct irq_data *d, unsigned int type);
+
 static void __plic_toggle(void __iomem *enable_base, int hwirq, int enable)
 {
 	u32 __iomem *reg = enable_base + (hwirq / 32) * sizeof(u32);
@@ -176,6 +181,17 @@ static void plic_irq_eoi(struct irq_data *d)
 	}
 }
 
+static struct irq_chip plic_edge_chip = {
+	.name		= "SiFive PLIC",
+	.irq_ack	= plic_irq_eoi,
+	.irq_mask	= plic_irq_mask,
+	.irq_unmask	= plic_irq_unmask,
+#ifdef CONFIG_SMP
+	.irq_set_affinity = plic_set_affinity,
+#endif
+	.irq_set_type	= plic_irq_set_type,
+};
+
 static struct irq_chip plic_chip = {
 	.name		= "SiFive PLIC",
 	.irq_mask	= plic_irq_mask,
@@ -184,8 +200,32 @@ static struct irq_chip plic_chip = {
 #ifdef CONFIG_SMP
 	.irq_set_affinity = plic_set_affinity,
 #endif
+	.irq_set_type	= plic_irq_set_type,
 };
 
+static int plic_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
+
+	if (!test_bit(PLIC_QUIRK_EDGE_INTERRUPT, &priv->plic_quirks))
+		return IRQ_SET_MASK_OK_NOCOPY;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		irq_set_chip_handler_name_locked(d, &plic_edge_chip,
+						 handle_edge_irq, NULL);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		irq_set_chip_handler_name_locked(d, &plic_chip,
+						 handle_fasteoi_irq, NULL);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return IRQ_SET_MASK_OK;
+}
+
 static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hwirq)
 {
@@ -198,6 +238,19 @@ static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
+static int plic_irq_domain_translate(struct irq_domain *d,
+				     struct irq_fwspec *fwspec,
+				     unsigned long *hwirq,
+				     unsigned int *type)
+{
+	struct plic_priv *priv = d->host_data;
+
+	if (test_bit(PLIC_QUIRK_EDGE_INTERRUPT, &priv->plic_quirks))
+		return irq_domain_translate_twocell(d, fwspec, hwirq, type);
+
+	return irq_domain_translate_onecell(d, fwspec, hwirq, type);
+}
+
 static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				 unsigned int nr_irqs, void *arg)
 {
@@ -206,7 +259,7 @@ static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	unsigned int type;
 	struct irq_fwspec *fwspec = arg;
 
-	ret = irq_domain_translate_onecell(domain, fwspec, &hwirq, &type);
+	ret = plic_irq_domain_translate(domain, fwspec, &hwirq, &type);
 	if (ret)
 		return ret;
 
@@ -220,7 +273,7 @@ static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops plic_irqdomain_ops = {
-	.translate	= irq_domain_translate_onecell,
+	.translate	= plic_irq_domain_translate,
 	.alloc		= plic_irq_domain_alloc,
 	.free		= irq_domain_free_irqs_top,
 };
@@ -281,8 +334,9 @@ static int plic_starting_cpu(unsigned int cpu)
 	return 0;
 }
 
-static int __init plic_init(struct device_node *node,
-		struct device_node *parent)
+static int __init __plic_init(struct device_node *node,
+			      struct device_node *parent,
+			      unsigned long plic_quirks)
 {
 	int error = 0, nr_contexts, nr_handlers = 0, i;
 	u32 nr_irqs;
@@ -293,6 +347,8 @@ static int __init plic_init(struct device_node *node,
 	if (!priv)
 		return -ENOMEM;
 
+	priv->plic_quirks = plic_quirks;
+
 	priv->regs = of_iomap(node, 0);
 	if (WARN_ON(!priv->regs)) {
 		error = -EIO;
@@ -410,6 +466,20 @@ out_free_priv:
 	return error;
 }
 
+static int __init plic_init(struct device_node *node,
+			    struct device_node *parent)
+{
+	return __plic_init(node, parent, 0);
+}
+
 IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
 IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
 IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_init); /* for firmware driver */
+
+static int __init plic_edge_init(struct device_node *node,
+				 struct device_node *parent)
+{
+	return __plic_init(node, parent, BIT(PLIC_QUIRK_EDGE_INTERRUPT));
+}
+
+IRQCHIP_DECLARE(andestech_nceplic100, "andestech,nceplic100", plic_edge_init);
