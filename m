Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6CD4B5BA2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiBNU42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:56:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiBNU4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:56:22 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9BB10781F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 12:56:01 -0800 (PST)
Received: from terra.local.svanheule.net (104.153-136-217.adsl-dyn.isp.belgacom.be [217.136.153.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id D3FCA2A25FC;
        Mon, 14 Feb 2022 19:57:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1644865028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YgNeTAxbgrC315MC1Jy5FCAajTIfZfPRjFdqJmtvvKY=;
        b=HN66mIkyyFsyVscl1o8gJyjO8eWD2hnaTwsJXHwZ7+ZHTwAJmoYuNj1H+C9s4+uAPLZBOH
        g25lPkv4buqJC8bNbUm+UssFwL6JvaxfUTBITi/uZuNj2dT5ggI8JsATC4JEudjgjVLVch
        YvMtUYweOZQ2TfdQ85efdWHA8TGZsXiWpRG55+maducZXNuNbpOR3ICNIA61a3No4TaKGZ
        BdnKA2mHhbKs09/WReffUUqHWWoHFY9QNrnfuN3Rvoy4U3W0b7h2NIqNg/Kg+WSC3o06N/
        SarAxqUoNFvKTCB+x9TZM47wGqd3BX/M8wFUcZTFUnktA6DO21l3i+30KFodOg==
From:   Sander Vanheule <sander@svanheule.net>
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v5 3/4] irqchip/realtek-rtl: use parent interrupts
Date:   Mon, 14 Feb 2022 19:57:00 +0100
Message-Id: <6484523d69a41e262a7c2d8bac76d31e189cdcbc.1644864700.git.sander@svanheule.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644864700.git.sander@svanheule.net>
References: <cover.1644864700.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt-map property for "realtek,rtl-intc" has been deprecated in
favor of a list of parent interrupts. Drop the open-coded parser for
interrupt-map, and use the first parent interrupt instead. If no parent
was provided, the driver will assume that this is the first hardware
interrupt of the SoC's MIPS CPU.

All SoC interrupts were treated equally, independent of which output
they were actually routed to. This means the driver might as well route
all interrupts to the first output, and achieve the same behaviour.

Without the interrupt-map property, interrupt routing information is no
longer available at initialisation. Routing setup will now happen later,
when a hardware interrupt is mapped by the subsystem.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
Changes since v4:
- Use irq_domain_add_linear instead of irq_domain_add_simple
- Drop 'inline' specifiers from static functions

 drivers/irqchip/irq-realtek-rtl.c | 133 ++++++++++++++----------------
 1 file changed, 61 insertions(+), 72 deletions(-)

diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index 14e049eed0f2..2a349082af81 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -21,11 +21,33 @@
 #define RTL_ICTL_IRR2		0x10
 #define RTL_ICTL_IRR3		0x14
 
+#define RTL_ICTL_NUM_INPUTS	32
+
 #define REG(x)		(realtek_ictl_base + x)
 
 static DEFINE_RAW_SPINLOCK(irq_lock);
 static void __iomem *realtek_ictl_base;
 
+/*
+ * IRR0-IRR3 store 4 bits per interrupt, but Realtek uses inverted numbering,
+ * placing IRQ 31 in the first four bits. A routing value of '0' means the
+ * interrupt is left disconnected. Routing values {1..15} connect to output
+ * lines {0..14}.
+ */
+#define IRR_OFFSET(idx)		(4 * (3 - (idx * 4) / 32))
+#define IRR_SHIFT(idx)		((idx * 4) % 32)
+
+static void write_irr(void __iomem *irr0, int idx, u32 value)
+{
+	unsigned int offset = IRR_OFFSET(idx);
+	unsigned int shift = IRR_SHIFT(idx);
+	u32 irr;
+
+	irr = readl(irr0 + offset) & ~(0xf << shift);
+	irr |= (value & 0xf) << shift;
+	writel(irr, irr0 + offset);
+}
+
 static void realtek_ictl_unmask_irq(struct irq_data *i)
 {
 	unsigned long flags;
@@ -62,8 +84,14 @@ static struct irq_chip realtek_ictl_irq = {
 
 static int intc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 {
+	unsigned long flags;
+
 	irq_set_chip_and_handler(irq, &realtek_ictl_irq, handle_level_irq);
 
+	raw_spin_lock_irqsave(&irq_lock, flags);
+	write_irr(REG(RTL_ICTL_IRR0), hw, 1);
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
+
 	return 0;
 }
 
@@ -95,89 +123,50 @@ static void realtek_irq_dispatch(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-/*
- * SoC interrupts are cascaded to MIPS CPU interrupts according to the
- * interrupt-map in the device tree. Each SoC interrupt gets 4 bits for
- * the CPU interrupt in an Interrupt Routing Register. Max 32 SoC interrupts
- * thus go into 4 IRRs. A routing value of '0' means the interrupt is left
- * disconnected. Routing values {1..15} connect to output lines {0..14}.
- */
-static int __init map_interrupts(struct device_node *node, struct irq_domain *domain)
-{
-	struct device_node *cpu_ictl;
-	const __be32 *imap;
-	u32 imaplen, soc_int, cpu_int, tmp, regs[4];
-	int ret, i, irr_regs[] = {
-		RTL_ICTL_IRR3,
-		RTL_ICTL_IRR2,
-		RTL_ICTL_IRR1,
-		RTL_ICTL_IRR0,
-	};
-	u8 mips_irqs_set;
-
-	ret = of_property_read_u32(node, "#address-cells", &tmp);
-	if (ret || tmp)
-		return -EINVAL;
-
-	imap = of_get_property(node, "interrupt-map", &imaplen);
-	if (!imap || imaplen % 3)
-		return -EINVAL;
-
-	mips_irqs_set = 0;
-	memset(regs, 0, sizeof(regs));
-	for (i = 0; i < imaplen; i += 3 * sizeof(u32)) {
-		soc_int = be32_to_cpup(imap);
-		if (soc_int > 31)
-			return -EINVAL;
-
-		cpu_ictl = of_find_node_by_phandle(be32_to_cpup(imap + 1));
-		if (!cpu_ictl)
-			return -EINVAL;
-		ret = of_property_read_u32(cpu_ictl, "#interrupt-cells", &tmp);
-		if (ret || tmp != 1)
-			return -EINVAL;
-		of_node_put(cpu_ictl);
-
-		cpu_int = be32_to_cpup(imap + 2);
-		if (cpu_int > 7 || cpu_int < 2)
-			return -EINVAL;
-
-		if (!(mips_irqs_set & BIT(cpu_int))) {
-			irq_set_chained_handler_and_data(cpu_int, realtek_irq_dispatch,
-							 domain);
-			mips_irqs_set |= BIT(cpu_int);
-		}
-
-		/* Use routing values (1..6) for CPU interrupts (2..7) */
-		regs[(soc_int * 4) / 32] |= (cpu_int - 1) << (soc_int * 4) % 32;
-		imap += 3;
-	}
-
-	for (i = 0; i < 4; i++)
-		writel(regs[i], REG(irr_regs[i]));
-
-	return 0;
-}
-
 static int __init realtek_rtl_of_init(struct device_node *node, struct device_node *parent)
 {
+	struct of_phandle_args oirq;
 	struct irq_domain *domain;
-	int ret;
+	unsigned int soc_irq;
+	int parent_irq;
 
 	realtek_ictl_base = of_iomap(node, 0);
 	if (!realtek_ictl_base)
 		return -ENXIO;
 
-	/* Disable all cascaded interrupts */
+	/* Disable all cascaded interrupts and clear routing */
 	writel(0, REG(RTL_ICTL_GIMR));
+	for (soc_irq = 0; soc_irq < RTL_ICTL_NUM_INPUTS; soc_irq++)
+		write_irr(REG(RTL_ICTL_IRR0), soc_irq, 0);
+
+	if (WARN_ON(!of_irq_count(node))) {
+		/*
+		 * If DT contains no parent interrupts, assume MIPS CPU IRQ 2
+		 * (HW0) is connected to the first output. This is the case for
+		 * all known hardware anyway. "interrupt-map" is deprecated, so
+		 * don't bother trying to parse that.
+		 */
+		oirq.np = of_find_compatible_node(NULL, NULL, "mti,cpu-interrupt-controller");
+		oirq.args_count = 1;
+		oirq.args[0] = 2;
+
+		parent_irq = irq_create_of_mapping(&oirq);
+
+		of_node_put(oirq.np);
+	} else {
+		parent_irq = of_irq_get(node, 0);
+	}
 
-	domain = irq_domain_add_linear(node, 32, &irq_domain_ops, NULL);
+	if (parent_irq < 0)
+		return parent_irq;
+	else if (!parent_irq)
+		return -ENODEV;
 
-	ret = map_interrupts(node, domain);
-	if (ret) {
-		pr_err("invalid interrupt map\n");
-		return ret;
-	}
+	domain = irq_domain_add_linear(node, RTL_ICTL_NUM_INPUTS, &irq_domain_ops, NULL);
+	if (!domain)
+		return -ENOMEM;
+
+	irq_set_chained_handler_and_data(parent_irq, realtek_irq_dispatch, domain);
 
 	return 0;
 }
-- 
2.35.1

