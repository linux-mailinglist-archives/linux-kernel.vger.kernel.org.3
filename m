Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9892947F8BE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 21:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhLZUCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 15:02:43 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:57548 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbhLZT7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 14:59:36 -0500
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:201f:9f28:b747:b33a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 8C3E7288175;
        Sun, 26 Dec 2021 20:59:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640548774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQROpGjB8/oQm8ho3AEhvLI6HBGxBtFxZGU3PVXv0XQ=;
        b=ZDfotFMp1H1rCjK7O6ye0opq79owqhClRE9K0OcK3KUi0IR+xu/5xFYOd7J1AL8WYVZ8po
        /9QgenL5UBXpcfKCRvCUH5gNHhJYeA0hvLl31tRGP/DWb13xCB18Dl0NoEDmcIC0AU3j11
        UuJTfuwCUOf3DcYNGWWrMvmYNmTnADiSphWHqRkI948VHSxw+tBrFervlc6y0J1p6/5puw
        XAgrpVKmOPcAGs6MF+zDJfndklb3HIfKUCGjtdIRJrbNOMv5O5thNamM3/zUMwUL1Wj7G3
        oVyBq4IXRKuoFNkTokqG51ydGkf/T4kutqn3PsdgSi7KCpvjXRY2+yD4eqI5Cg==
From:   Sander Vanheule <sander@svanheule.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [RFC PATCH v2 3/5] irqchip/realtek-rtl: use per-parent irq handling
Date:   Sun, 26 Dec 2021 20:59:26 +0100
Message-Id: <73789385f470b7630c19b4c632d60ef7b89a46d0.1640548009.git.sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640548009.git.sander@svanheule.net>
References: <cover.1640548009.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver handled all SoC interrupts equally, independent of which
parent interrupt it is routed to. Between all configured inputs, the use
of __ffs actually gives higher priority to lower input lines,
effectively bypassing any priority there might be among the parent
interrupts.

Rework the driver to use a separate handler for each parent interrupt,
to respect the order in which those parents interrupt are handled.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
With switching back to chained handlers, it became impossible to route a
SoC interrupt to the timer interrupt (CPU IRQ 7) on systems using the
CEVT-R4K timer. If a chained handler is already set for the timer
interrupt, the timer cannot request it anymore (due to IRQ_NOREQUEST)
and the system hangs. It is probably a terrible idea to also run e.g.
the console on the timer interrupt, but it is possible. If there are no
solutions to this, I can live with it though; there are still 5 other
interrupts.

Changes since v1:
- Limit scope to per-parent handling
- Replace the "priority" naming with the more generic "output"
- Don't request interrupts, but stick to chained handlers
---
 drivers/irqchip/irq-realtek-rtl.c | 109 ++++++++++++++++++++----------
 1 file changed, 74 insertions(+), 35 deletions(-)

diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index 568614edd88f..1f8f21a0bd1a 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -7,6 +7,7 @@
 
 #include <linux/of_irq.h>
 #include <linux/irqchip.h>
+#include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/of_address.h>
 #include <linux/irqchip/chained_irq.h>
@@ -21,10 +22,45 @@
 #define RTL_ICTL_IRR2		0x10
 #define RTL_ICTL_IRR3		0x14
 
+#define RTL_ICTL_NUM_OUTPUTS	6
+
 #define REG(x)		(realtek_ictl_base + x)
 
 static DEFINE_RAW_SPINLOCK(irq_lock);
 static void __iomem *realtek_ictl_base;
+static struct irq_domain *realtek_ictl_domain;
+
+struct realtek_ictl_output {
+	unsigned int routing_value;
+	u32 child_mask;
+};
+
+static struct realtek_ictl_output realtek_ictl_outputs[RTL_ICTL_NUM_OUTPUTS];
+
+/*
+ * IRR0-IRR3 store 4 bits per interrupt, but Realtek uses inverted numbering,
+ * placing IRQ 31 in the first four bits. A routing value of '0' means the
+ * interrupt is left disconnected. Routing values {1..15} connect to output
+ * lines {0..14}.
+ */
+#define IRR_OFFSET(idx)		(4 * (3 - (idx * 4) / 32))
+#define IRR_SHIFT(idx)		((idx * 4) % 32)
+
+static inline u32 read_irr(void __iomem *irr0, int idx)
+{
+	return (readl(irr0 + IRR_OFFSET(idx)) >> IRR_SHIFT(idx)) & 0xf;
+}
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
 
 static void realtek_ictl_unmask_irq(struct irq_data *i)
 {
@@ -74,42 +110,45 @@ static const struct irq_domain_ops irq_domain_ops = {
 
 static void realtek_irq_dispatch(struct irq_desc *desc)
 {
+	struct realtek_ictl_output *parent = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct irq_domain *domain;
 	unsigned int pending;
 
 	chained_irq_enter(chip, desc);
-	pending = readl(REG(RTL_ICTL_GIMR)) & readl(REG(RTL_ICTL_GISR));
+	pending = readl(REG(RTL_ICTL_GIMR)) & readl(REG(RTL_ICTL_GISR))
+		& parent->child_mask;
+
 	if (unlikely(!pending)) {
 		spurious_interrupt();
 		goto out;
 	}
-	domain = irq_desc_get_handler_data(desc);
-	generic_handle_domain_irq(domain, __ffs(pending));
+	generic_handle_domain_irq(realtek_ictl_domain, __ffs(pending));
 
 out:
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
+static void __init set_routing(struct realtek_ictl_output *output, unsigned int soc_int)
 {
+	unsigned int routing_old;
+
+	routing_old = read_irr(REG(RTL_ICTL_IRR0), soc_int);
+	if (routing_old) {
+		pr_warn("int %d already routed to %d, not updating\n", soc_int, routing_old);
+		return;
+	}
+
+	output->child_mask |= BIT(soc_int);
+	write_irr(REG(RTL_ICTL_IRR0), soc_int, output->routing_value);
+}
+
+static int __init map_interrupts(struct device_node *node)
+{
+	struct realtek_ictl_output *output;
 	struct device_node *cpu_ictl;
 	const __be32 *imap;
-	u32 imaplen, soc_int, cpu_int, tmp, regs[4];
-	int ret, i, irr_regs[] = {
-		RTL_ICTL_IRR3,
-		RTL_ICTL_IRR2,
-		RTL_ICTL_IRR1,
-		RTL_ICTL_IRR0,
-	};
-	u8 mips_irqs_set;
+	u32 imaplen, soc_int, cpu_int, tmp;
+	int ret, i;
 
 	ret = of_property_read_u32(node, "#address-cells", &tmp);
 	if (ret || tmp)
@@ -119,8 +158,6 @@ static int __init map_interrupts(struct device_node *node, struct irq_domain *do
 	if (!imap || imaplen % 3)
 		return -EINVAL;
 
-	mips_irqs_set = 0;
-	memset(regs, 0, sizeof(regs));
 	for (i = 0; i < imaplen; i += 3 * sizeof(u32)) {
 		soc_int = be32_to_cpup(imap);
 		if (soc_int > 31)
@@ -138,39 +175,41 @@ static int __init map_interrupts(struct device_node *node, struct irq_domain *do
 		if (cpu_int > 7 || cpu_int < 2)
 			return -EINVAL;
 
-		if (!(mips_irqs_set & BIT(cpu_int))) {
-			irq_set_chained_handler_and_data(cpu_int, realtek_irq_dispatch,
-							 domain);
-			mips_irqs_set |= BIT(cpu_int);
+		output = &realtek_ictl_outputs[cpu_int - 2];
+
+		if (!output->routing_value) {
+			irq_set_chained_handler_and_data(cpu_int, realtek_irq_dispatch, output);
+			/* Use routing values (1..6) for CPU interrupts (2..7) */
+			output->routing_value = cpu_int - 1;
 		}
 
-		/* Use routing values (1..6) for CPU interrupts (2..7) */
-		regs[(soc_int * 4) / 32] |= (cpu_int - 1) << (soc_int * 4) % 32;
+		set_routing(output, soc_int);
+
 		imap += 3;
 	}
 
-	for (i = 0; i < 4; i++)
-		writel(regs[i], REG(irr_regs[i]));
-
 	return 0;
 }
 
 static int __init realtek_rtl_of_init(struct device_node *node, struct device_node *parent)
 {
-	struct irq_domain *domain;
+	unsigned int soc_irq;
 	int ret;
 
+	memset(&realtek_ictl_outputs, 0, sizeof(realtek_ictl_outputs));
+
 	realtek_ictl_base = of_iomap(node, 0);
 	if (!realtek_ictl_base)
 		return -ENXIO;
 
 	/* Disable all cascaded interrupts */
 	writel(0, REG(RTL_ICTL_GIMR));
+	for (soc_irq = 0; soc_irq < 32; soc_irq++)
+		write_irr(REG(RTL_ICTL_IRR0), soc_irq, 0);
 
-	domain = irq_domain_add_simple(node, 32, 0,
-				       &irq_domain_ops, NULL);
+	realtek_ictl_domain = irq_domain_add_simple(node, 32, 0, &irq_domain_ops, NULL);
 
-	ret = map_interrupts(node, domain);
+	ret = map_interrupts(node);
 	if (ret) {
 		pr_err("invalid interrupt map\n");
 		return ret;
-- 
2.33.1

