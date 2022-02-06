Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B711F4AB0B3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 17:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245355AbiBFQmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 11:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245027AbiBFQmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 11:42:08 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C00C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 08:42:07 -0800 (PST)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:f5f1:f284:117e:4f61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id DA4BA29DB9D;
        Sun,  6 Feb 2022 17:42:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1644165724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9A1S2X5VUAC5ZNhhTte8U2IjYOlEwZr++dBF3T1yWEs=;
        b=7VwKFJePvupxrxp2rUh3/sAQnTY66WYTlIDu5EO5/tP3a99czAg4V7oaZugilmZ/U0stBb
        NdAZqFjBUMpKKmPe2KZf5HKyPS5FpF9jhuRu9hJOp9qG+Ln67gr1jrOZbhFAObBc0wApam
        wFo54hMTObC4wiUFT/dYlZ/C/Dt0jvbnXBClGFXB2msCu3Y+KV6ATg51L6HgfzEY3wv5WE
        GRZ7vphH/Y75futOFi1fJMpt/0NeIJVwkRxNeb3RzwF7vqdeW2iv77K5Pp0JXw6b2OXHPb
        EImS17rPO5A7bU4AZdXrfi3HseeNdF4wGbjqBNN90aRTa1Oa8MXOrIKj9P+c6A==
From:   Sander Vanheule <sander@svanheule.net>
To:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v4 2/3] irqchip/realtek-rtl: use parent interrupts
Date:   Sun,  6 Feb 2022 17:41:52 +0100
Message-Id: <ad04133f2adb39fed2f6060f1460dd0446f98eed.1644165421.git.sander@svanheule.net>
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
 drivers/irqchip/irq-realtek-rtl.c | 133 ++++++++++++++----------------
 1 file changed, 61 insertions(+), 72 deletions(-)

diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index 50a56820c99b..388f4a7bfb80 100644
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
+static inline void write_irr(void __iomem *irr0, int idx, u32 value)
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
 
@@ -95,90 +123,51 @@ static void realtek_irq_dispatch(struct irq_desc *desc)
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
+
+	if (parent_irq < 0)
+		return parent_irq;
+	else if (!parent_irq)
+		return -ENODEV;
 
-	domain = irq_domain_add_simple(node, 32, 0,
+	domain = irq_domain_add_simple(node, RTL_ICTL_NUM_INPUTS, 0,
 				       &irq_domain_ops, NULL);
+	if (!domain)
+		return -ENOMEM;
 
-	ret = map_interrupts(node, domain);
-	if (ret) {
-		pr_err("invalid interrupt map\n");
-		return ret;
-	}
+	irq_set_chained_handler_and_data(parent_irq, realtek_irq_dispatch, domain);
 
 	return 0;
 }
-- 
2.34.1

