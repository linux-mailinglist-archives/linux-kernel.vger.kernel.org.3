Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CCA4AB0B2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 17:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245461AbiBFQmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 11:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245047AbiBFQmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 11:42:08 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B39C043186
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 08:42:07 -0800 (PST)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:f5f1:f284:117e:4f61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id B002B29DB9E;
        Sun,  6 Feb 2022 17:42:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1644165725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uwqCfn8+7fhgjL6et+oEF0zLQi3m+lngIzcjw213o+g=;
        b=o8Oe5AZEuCptf5Xrd855M+ElwWn1UYzIiZl95MtosyrGqLLa/UE5SZQh/qI0fnM9Z4cF6e
        y1/u2GqOsb1G1ZTcpnAICva9rKuYhm2dn6/mcVqd3MumXu1AhMbaQcpO2LpGTZEJgfHCj7
        I3XBhLQ6NO2ZHmjR9ucdIOH2UcbkECZvZUpZkXXu1QFzjduEadevEdL/XzX+0JYfysqcAk
        /TFTEm6sK0ENrEEOBaES8wIlfQey+5HZX8QRjO1dY6+zDJEkBEzm3cqj0PHj1teFllDT5m
        yk3d74XVLUuTiAoZTTmtCBgpLL/dNSjYoZFi4dnVNu3mG9V51DxN5qtmHUIACA==
From:   Sander Vanheule <sander@svanheule.net>
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v4 3/3] irqchip/realtek-rtl: use per-parent domains
Date:   Sun,  6 Feb 2022 17:41:53 +0100
Message-Id: <54b9090510fe1a90fb7d335b680af3adeff9838a.1644165421.git.sander@svanheule.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644165421.git.sander@svanheule.net>
References: <cover.1644165421.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt router can connect each of its inputs to one of the parent
interrupts. These parent interrupts may be handled differently by their
interrupt controller. SoC interrupts should be treated per-parent, to
maintain this expected behaviour for routed child interrupts.

For example, it is possible that both networking interrupts and the
system event timer interrupts are routed through this controller. Even
under high network load, event timer interrupts should take precedence,
which can be ensured by routing them to a higher priority parent.

Rework the driver to use a separate domain for each output, using all
available parents interrupts (as specified in the devicetree). A
per-parent mask of child interrupts is used to keep track of which
domain should handle which interrupts.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/irqchip/irq-realtek-rtl.c | 150 ++++++++++++++++++++++++------
 1 file changed, 124 insertions(+), 26 deletions(-)

diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index 388f4a7bfb80..868eb9b25e84 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -22,12 +22,22 @@
 #define RTL_ICTL_IRR3		0x14
 
 #define RTL_ICTL_NUM_INPUTS	32
+#define RTL_ICTL_NUM_OUTPUTS	15
 
 #define REG(x)		(realtek_ictl_base + x)
 
 static DEFINE_RAW_SPINLOCK(irq_lock);
 static void __iomem *realtek_ictl_base;
 
+struct realtek_ictl_output {
+	/* IRQ controller data */
+	struct fwnode_handle *fwnode;
+	/* Output specific data */
+	unsigned int output_index;
+	struct irq_domain *domain;
+	u32 child_mask;
+};
+
 /*
  * IRR0-IRR3 store 4 bits per interrupt, but Realtek uses inverted numbering,
  * placing IRQ 31 in the first four bits. A routing value of '0' means the
@@ -37,6 +47,11 @@ static void __iomem *realtek_ictl_base;
 #define IRR_OFFSET(idx)		(4 * (3 - (idx * 4) / 32))
 #define IRR_SHIFT(idx)		((idx * 4) % 32)
 
+static inline u32 read_irr(void __iomem *irr0, int idx)
+{
+	return (readl(irr0 + IRR_OFFSET(idx)) >> IRR_SHIFT(idx)) & 0xf;
+}
+
 static inline void write_irr(void __iomem *irr0, int idx, u32 value)
 {
 	unsigned int offset = IRR_OFFSET(idx);
@@ -84,51 +99,128 @@ static struct irq_chip realtek_ictl_irq = {
 
 static int intc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 {
+	struct realtek_ictl_output *output = d->host_data;
 	unsigned long flags;
+	u32 routing_old;
+	int err = 0;
+
+	raw_spin_lock_irqsave(&irq_lock, flags);
+
+	/*
+	 * Inputs can only be routed to one output, so they shouldn't end up in
+	 * multiple domains. Perform this check in the same atomic context as
+	 * configuring the routing to prevent races.
+	 */
+	routing_old = read_irr(REG(RTL_ICTL_IRR0), hw);
+	if (routing_old && output->output_index != routing_old - 1) {
+		pr_err("int %ld already routed to output %d\n",
+			hw, routing_old - 1);
+		err = -EINVAL;
+		goto out;
+	}
+
+	output->child_mask |= BIT(hw);
+	write_irr(REG(RTL_ICTL_IRR0), hw, output->output_index + 1);
 
 	irq_set_chip_and_handler(irq, &realtek_ictl_irq, handle_level_irq);
 
-	raw_spin_lock_irqsave(&irq_lock, flags);
-	write_irr(REG(RTL_ICTL_IRR0), hw, 1);
+out:
 	raw_spin_unlock_irqrestore(&irq_lock, flags);
 
-	return 0;
+	return err;
+}
+
+static int intc_select(struct irq_domain *d, struct irq_fwspec *fwspec,
+	enum irq_domain_bus_token bus_token)
+{
+	struct realtek_ictl_output *output = d->host_data;
+
+	if (fwspec->fwnode != output->fwnode)
+		return false;
+
+	/* Original specifiers only had one parameter */
+	if (WARN_ON_ONCE(fwspec->param_count < 2))
+		return true;
+
+	return fwspec->param[1] == output->output_index;
 }
 
 static const struct irq_domain_ops irq_domain_ops = {
 	.map = intc_map,
+	.select = intc_select,
 	.xlate = irq_domain_xlate_onecell,
 };
 
 static void realtek_irq_dispatch(struct irq_desc *desc)
 {
+	struct realtek_ictl_output *output = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct irq_domain *domain;
 	unsigned long pending;
 	unsigned int soc_int;
 
 	chained_irq_enter(chip, desc);
-	pending = readl(REG(RTL_ICTL_GIMR)) & readl(REG(RTL_ICTL_GISR));
+	pending = readl(REG(RTL_ICTL_GIMR)) & readl(REG(RTL_ICTL_GISR))
+		& output->child_mask;
 
 	if (unlikely(!pending)) {
 		spurious_interrupt();
 		goto out;
 	}
 
-	domain = irq_desc_get_handler_data(desc);
-	for_each_set_bit(soc_int, &pending, 32)
-		generic_handle_domain_irq(domain, soc_int);
+	for_each_set_bit(soc_int, &pending, RTL_ICTL_NUM_INPUTS)
+		generic_handle_domain_irq(output->domain, soc_int);
 
 out:
 	chained_irq_exit(chip, desc);
 }
 
+static int __init setup_parent_interrupts(struct device_node *node, int *parents,
+	unsigned int num_parents)
+{
+	struct realtek_ictl_output *outputs;
+	struct realtek_ictl_output *output;
+	struct irq_domain *domain;
+	unsigned int p;
+
+	outputs = kcalloc(num_parents, sizeof(*outputs), GFP_KERNEL);
+	if (!outputs)
+		return -ENOMEM;
+
+	for (p = 0; p < num_parents; p++) {
+		output = outputs + p;
+
+		domain = irq_domain_add_simple(node, RTL_ICTL_NUM_INPUTS, 0,
+					       &irq_domain_ops, output);
+		if (!domain)
+			goto domain_err;
+
+		output->fwnode = of_node_to_fwnode(node);
+		output->output_index = p;
+		output->domain = domain;
+
+		irq_set_chained_handler_and_data(parents[p], realtek_irq_dispatch, output);
+	}
+
+	return 0;
+
+domain_err:
+	while (p--) {
+		irq_set_chained_handler_and_data(parents[p], NULL, NULL);
+		irq_domain_remove(outputs[p].domain);
+	}
+
+	kfree(outputs);
+
+	return -ENOMEM;
+}
+
 static int __init realtek_rtl_of_init(struct device_node *node, struct device_node *parent)
 {
+	int parent_irqs[RTL_ICTL_NUM_OUTPUTS];
 	struct of_phandle_args oirq;
-	struct irq_domain *domain;
+	unsigned int num_parents;
 	unsigned int soc_irq;
-	int parent_irq;
+	unsigned int p;
 
 	realtek_ictl_base = of_iomap(node, 0);
 	if (!realtek_ictl_base)
@@ -139,37 +231,43 @@ static int __init realtek_rtl_of_init(struct device_node *node, struct device_no
 	for (soc_irq = 0; soc_irq < RTL_ICTL_NUM_INPUTS; soc_irq++)
 		write_irr(REG(RTL_ICTL_IRR0), soc_irq, 0);
 
-	if (WARN_ON(!of_irq_count(node))) {
+	num_parents = of_irq_count(node);
+	if (num_parents > RTL_ICTL_NUM_OUTPUTS) {
+		pr_err("too many parent interrupts\n");
+		return -EINVAL;
+	}
+
+	for (p = 0; p < num_parents; p++)
+		parent_irqs[p] = of_irq_get(node, p);
+
+	if (WARN_ON(!num_parents)) {
 		/*
 		 * If DT contains no parent interrupts, assume MIPS CPU IRQ 2
 		 * (HW0) is connected to the first output. This is the case for
 		 * all known hardware anyway. "interrupt-map" is deprecated, so
 		 * don't bother trying to parse that.
+		 * Since this is to account for old devicetrees with one-cell
+		 * interrupt specifiers, only one output domain is needed.
 		 */
 		oirq.np = of_find_compatible_node(NULL, NULL, "mti,cpu-interrupt-controller");
 		oirq.args_count = 1;
 		oirq.args[0] = 2;
 
-		parent_irq = irq_create_of_mapping(&oirq);
+		parent_irqs[0] = irq_create_of_mapping(&oirq);
+		num_parents = 1;
 
 		of_node_put(oirq.np);
-	} else {
-		parent_irq = of_irq_get(node, 0);
 	}
 
-	if (parent_irq < 0)
-		return parent_irq;
-	else if (!parent_irq)
-		return -ENODEV;
-
-	domain = irq_domain_add_simple(node, RTL_ICTL_NUM_INPUTS, 0,
-				       &irq_domain_ops, NULL);
-	if (!domain)
-		return -ENOMEM;
-
-	irq_set_chained_handler_and_data(parent_irq, realtek_irq_dispatch, domain);
+	/* Ensure we haven't collected any errors before proceeding */
+	for (p = 0; p < num_parents; p++) {
+		if (parent_irqs[p] < 0)
+			return parent_irqs[p];
+		if (!parent_irqs[p])
+			return -ENODEV;
+	}
 
-	return 0;
+	return setup_parent_interrupts(node, &parent_irqs[0], num_parents);
 }
 
 IRQCHIP_DECLARE(realtek_rtl_intc, "realtek,rtl-intc", realtek_rtl_of_init);
-- 
2.34.1

