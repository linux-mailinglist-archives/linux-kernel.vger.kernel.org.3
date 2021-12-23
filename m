Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255C547E2FA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbhLWMJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:09:06 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:41746 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348140AbhLWMIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:08:53 -0500
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafe:c901:29a7:866a:cac1:4c27])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 01B3D2866B3;
        Thu, 23 Dec 2021 13:08:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640261330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RyaYwva3N7ECDReF1XQQxThXmMLdzOhp3IrMxCfNMtg=;
        b=3jCetYy93cDkmJ+j9HaPweK+CI5QCIcF1NA8uTeOIsi3gEXDJ6TOgfMmkN+z/UiWLKzBRK
        snMSq84yzuykuo/nCtIjt0zsGsRy2B6x78XfEFbdNNlJKGG9VFithHwG+FBZBznC6ufDSC
        YDtW3bDLB8htHyOQYqUE062UcxKER+jzHdg5mZMWsw/EwJr6KWvVSsyYAaYPH9wVdwmcUM
        uQ96xmFXJvMvvxD0tJ+wBn5KN072uRjyNvBLstgGLkikAHebhUMqBvtk4452WCKqeGuXqU
        0YSFtA6GP00nJp0gcZ14z4hkdYC4CDJ8S9sCW7A/6k/sW+rdBkBaXZa18S5Ccw==
From:   Sander Vanheule <sander@svanheule.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [RFC PATCH v1 2/4] irqchip: realtek-rtl: use per-parent irq handling
Date:   Thu, 23 Dec 2021 13:08:32 +0100
Message-Id: <81bebcf62dfdc63155a69c3bdb2acefe4f5995ac.1640261161.git.sander@svanheule.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640261161.git.sander@svanheule.net>
References: <cover.1640261161.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt router controller is used to route 32 SoC interrupts to up
to 6 MIPS CPU interrupts. This means that the SoC interrupts inherit the
priority of to the target CPU interrupt.

Currently the driver handles all SoC interrupts equally, independent of
which CPU interrupt it is routed to. The use of __ffs actually gives
higher priority to lower IRQ lines, effectively bypassing the CPU
interrupt priority.

Additionally, this indiscriminate handling of SoC interrupts masked
another issue. There is an actually an offset between routing values
(1..6) and CPU interrupts (2..7), but the current mapping makes no
distinction between these two values. This issue was also hidden during
testing, because an interrupt mapping was used where for each required
interrupt another (unused) routing was configured, with an offset of +1.

Rework the driver to use a separate handler for each used CPU interrupt,
and use the correct routing values. Instead of assuming that the parent
interrupt controller is the MIPS CPU interrupt controller
("mti,cpu-interrupt-controller"), this is now checked explicitly to
correctly handle the timer interrupt.

Fixes: 9f3a0f34b84a ("irqchip: Add support for Realtek RTL838x/RTL839x interrupt controller")
Signed-off-by: Sander Vanheule <sander@svanheule.net>
---

This patch makes a few changes at the same time, and introduces the
*_irr functions, which aren't strictly required. This allows the last
patch to be a bit smaller, and seeks to add some clarity to the code.

Please let me know if this should be split into separate patches with
more incremental changes (in addition to other likely comments).
---
 drivers/irqchip/irq-realtek-rtl.c | 153 +++++++++++++++++++++---------
 1 file changed, 108 insertions(+), 45 deletions(-)

diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
index d6788dd93c7b..71366f1cf721 100644
--- a/drivers/irqchip/irq-realtek-rtl.c
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -7,6 +7,7 @@
 
 #include <linux/of_irq.h>
 #include <linux/irqchip.h>
+#include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/of_address.h>
 #include <linux/irqchip/chained_irq.h>
@@ -21,10 +22,43 @@
 #define RTL_ICTL_IRR2		0x10
 #define RTL_ICTL_IRR3		0x14
 
-#define REG(x)		(realtek_ictl_base + x)
+#define RTL_ICTL_NUM_PRIO	6
+
+#define REG(x)			(realtek_ictl_base + x)
 
 static DEFINE_RAW_SPINLOCK(irq_lock);
 static void __iomem *realtek_ictl_base;
+static struct irq_domain *realtek_ictl_domain;
+
+struct realtek_ictl_priority {
+	unsigned int routing_value;
+	u32 child_mask;
+};
+
+static struct realtek_ictl_priority priorities[RTL_ICTL_NUM_PRIO];
+
+/*
+ * IRR0-IRR3 store 4 bits per interrupt, but Realtek uses inverted
+ * numbering, placing IRQ 31 in the first four bits.
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
@@ -72,43 +106,67 @@ static const struct irq_domain_ops irq_domain_ops = {
 	.xlate = irq_domain_xlate_onecell,
 };
 
-static void realtek_irq_dispatch(struct irq_desc *desc)
+static irqreturn_t realtek_irq_dispatch(int irq, void *devid)
 {
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct irq_domain *domain;
-	unsigned int pending;
-
-	chained_irq_enter(chip, desc);
-	pending = readl(REG(RTL_ICTL_GIMR)) & readl(REG(RTL_ICTL_GISR));
-	if (unlikely(!pending)) {
-		spurious_interrupt();
-		goto out;
+	struct realtek_ictl_priority *priority = devid;
+	unsigned long pending;
+	int soc_irq;
+	int ret = 0;
+
+	pending = readl(REG(RTL_ICTL_GIMR)) & readl(REG(RTL_ICTL_GISR))
+		& priority->child_mask;
+
+	for_each_set_bit(soc_irq, &pending, BITS_PER_LONG) {
+		generic_handle_domain_irq(realtek_ictl_domain, soc_irq);
+		ret = 1;
 	}
-	domain = irq_desc_get_handler_data(desc);
-	generic_handle_domain_irq(domain, __ffs(pending));
 
-out:
-	chained_irq_exit(chip, desc);
+	return IRQ_RETVAL(ret);
 }
 
-/*
- * SoC interrupts are cascaded to MIPS CPU interrupts according to the
- * interrupt-map in the device tree. Each SoC interrupt gets 4 bits for
- * the CPU interrupt in an Interrupt Routing Register. Max 32 SoC interrupts
- * thus go into 4 IRRs.
- */
-static int __init map_interrupts(struct device_node *node, struct irq_domain *domain)
+static void __init set_routing(struct realtek_ictl_priority *priority, unsigned int soc_int)
 {
+	unsigned int priority_old;
+
+	priority_old = read_irr(REG(RTL_ICTL_IRR0), soc_int);
+	if (priority_old) {
+		pr_warn("int %d already routed to %d, not updating\n", soc_int, priority_old);
+		return;
+	}
+
+	priority->child_mask |= BIT(soc_int);
+	write_irr(REG(RTL_ICTL_IRR0), soc_int, priority->routing_value);
+}
+
+static int __init setup_parent_interrupt(struct realtek_ictl_priority *prio_ctl, int parent)
+{
+	struct device_node *parent_node;
+	struct irq_data *irqd;
+	unsigned int flags;
+	int parent_hwirq;
+
+	irqd = irq_get_irq_data(parent);
+	if (!irqd)
+		return -ENOENT;
+
+	parent_node = to_of_node(irqd->domain->fwnode);
+	parent_hwirq = irqd_to_hwirq(irqd);
+
+	flags = IRQF_PERCPU | IRQF_SHARED;
+	if (of_device_is_compatible(parent_node, "mti,cpu-interrupt-controller")
+		&& parent_hwirq == 7)
+		flags |= IRQF_TIMER;
+
+	return request_irq(parent, realtek_irq_dispatch, flags, "rtl-intc", prio_ctl);
+}
+
+static int __init map_interrupts(struct device_node *node)
+{
+	struct realtek_ictl_priority *prio_ctl;
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
+	u32 imaplen, soc_int, priority, tmp;
+	int ret, i;
 
 	ret = of_property_read_u32(node, "#address-cells", &tmp);
 	if (ret || tmp)
@@ -118,8 +176,6 @@ static int __init map_interrupts(struct device_node *node, struct irq_domain *do
 	if (!imap || imaplen % 3)
 		return -EINVAL;
 
-	mips_irqs_set = 0;
-	memset(regs, 0, sizeof(regs));
 	for (i = 0; i < imaplen; i += 3 * sizeof(u32)) {
 		soc_int = be32_to_cpup(imap);
 		if (soc_int > 31)
@@ -133,42 +189,49 @@ static int __init map_interrupts(struct device_node *node, struct irq_domain *do
 			return -EINVAL;
 		of_node_put(cpu_ictl);
 
-		cpu_int = be32_to_cpup(imap + 2);
-		if (cpu_int > 7)
+		/* Map priority (1..6) to MIPS CPU interrupt (2..7) */
+		priority = be32_to_cpup(imap + 2);
+		if (priority > 6 || priority < 1)
 			return -EINVAL;
 
-		if (!(mips_irqs_set & BIT(cpu_int))) {
-			irq_set_chained_handler_and_data(cpu_int, realtek_irq_dispatch,
-							 domain);
-			mips_irqs_set |= BIT(cpu_int);
+		prio_ctl = &priorities[priority - 1];
+
+		if (!prio_ctl->routing_value) {
+			ret = setup_parent_interrupt(prio_ctl, priority + 1);
+			if (ret)
+				return ret;
+
+			prio_ctl->routing_value = priority;
 		}
 
-		regs[(soc_int * 4) / 32] |= cpu_int << (soc_int * 4) % 32;
+		set_routing(prio_ctl, soc_int);
+
 		imap += 3;
 	}
 
-	for (i = 0; i < 4; i++)
-		writel(regs[i], REG(irr_regs[i]));
 
 	return 0;
 }
 
 static int __init realtek_rtl_of_init(struct device_node *node, struct device_node *parent)
 {
-	struct irq_domain *domain;
+	unsigned int soc_irq;
 	int ret;
 
+	memset(&priorities, 0, sizeof(priorities));
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

