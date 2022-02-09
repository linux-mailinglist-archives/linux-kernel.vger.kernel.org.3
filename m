Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DD74AF6A0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236887AbiBIQ1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbiBIQ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:26:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B362FC05CB8A;
        Wed,  9 Feb 2022 08:26:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0303E61888;
        Wed,  9 Feb 2022 16:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FF3C340E7;
        Wed,  9 Feb 2022 16:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644423979;
        bh=ny7WPOGrdktIvsld2ipnjZYm8VgMPb92ANFBf+SLQ/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KvoOYY0BrYuu+AiERBaPWLzfWT8WDZoBgMUlb1NmVdnbLu0EF3alepzYYJQslZbVc
         rqxxSm7CfG7WDG8QgVl1VBBsQw2b3mOpGd3fUfI+xSUS+aCedT+Ph9hLewsgSQR+qd
         Tm5hi6ESGMOIj75w57Vd6JEkWCFagiP32Flndo2azOQjxZln8qjMVO21SJMrQlCEkH
         /05Wurvjj8/tNFDF1/2uMte2L1S8dczsEDfJ3Jj92JBUxcuTrpUVNsS6PHt+5aV/Xo
         9jdEQ7QgfkIpW7zbm3DG0GumLQrEYABM4pDGvI0phsMKQOw4XwIdL/89lhOlBvehvo
         YYhx81PYDgO3g==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nHpnN-006fgT-SV; Wed, 09 Feb 2022 16:26:17 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        kernel-team@android.com
Subject: [PATCH 07/10] irqchip/versatile-fpga: Switch to dynamic chip name output
Date:   Wed,  9 Feb 2022 16:26:04 +0000
Message-Id: <20220209162607.1118325-8-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220209162607.1118325-1-maz@kernel.org>
References: <20220209162607.1118325-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, matthias.bgg@gmail.com, grygorii.strashko@ti.com, ssantosh@kernel.org, khilman@kernel.org, tony@atomide.com, tglx@linutronix.de, vz@mleia.com, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, kernel@esmil.dk, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the name output to the relevant callback, which allows us
some nice cleanups (mostly owing to the fact that the driver is
now DT only.

We also drop a random include directive from the ftintc010 driver.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-ftintc010.c        |  1 -
 drivers/irqchip/irq-versatile-fpga.c   | 46 +++++++++++++++-----------
 include/linux/irqchip/versatile-fpga.h | 14 --------
 3 files changed, 26 insertions(+), 35 deletions(-)
 delete mode 100644 include/linux/irqchip/versatile-fpga.h

diff --git a/drivers/irqchip/irq-ftintc010.c b/drivers/irqchip/irq-ftintc010.c
index 5cc268880f8e..46a3aa60e50e 100644
--- a/drivers/irqchip/irq-ftintc010.c
+++ b/drivers/irqchip/irq-ftintc010.c
@@ -11,7 +11,6 @@
 #include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/irqchip.h>
-#include <linux/irqchip/versatile-fpga.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/of.h>
diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index f2757b6aecc8..ba543ed9c154 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -7,12 +7,12 @@
 #include <linux/io.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
-#include <linux/irqchip/versatile-fpga.h>
 #include <linux/irqdomain.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/seq_file.h>
 
 #include <asm/exception.h>
 #include <asm/mach/irq.h>
@@ -34,14 +34,12 @@
 /**
  * struct fpga_irq_data - irq data container for the FPGA IRQ controller
  * @base: memory offset in virtual memory
- * @chip: chip container for this instance
  * @domain: IRQ domain for this instance
  * @valid: mask for valid IRQs on this controller
  * @used_irqs: number of active IRQs on this controller
  */
 struct fpga_irq_data {
 	void __iomem *base;
-	struct irq_chip chip;
 	u32 valid;
 	struct irq_domain *domain;
 	u8 used_irqs;
@@ -67,6 +65,20 @@ static void fpga_irq_unmask(struct irq_data *d)
 	writel(mask, f->base + IRQ_ENABLE_SET);
 }
 
+static void fpga_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct fpga_irq_data *f = irq_data_get_irq_chip_data(d);
+
+	seq_printf(p, irq_domain_get_of_node(f->domain)->name);
+}
+
+static const struct irq_chip fpga_chip = {
+	.irq_ack	= fpga_irq_mask,
+	.irq_mask	= fpga_irq_mask,
+	.irq_unmask	= fpga_irq_unmask,
+	.irq_print_chip	= fpga_irq_print_chip,
+};
+
 static void fpga_irq_handle(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -116,7 +128,7 @@ static int handle_one_fpga(struct fpga_irq_data *f, struct pt_regs *regs)
  * Keep iterating over all registered FPGA IRQ controllers until there are
  * no pending interrupts.
  */
-asmlinkage void __exception_irq_entry fpga_handle_irq(struct pt_regs *regs)
+static asmlinkage void __exception_irq_entry fpga_handle_irq(struct pt_regs *regs)
 {
 	int i, handled;
 
@@ -135,8 +147,7 @@ static int fpga_irqdomain_map(struct irq_domain *d, unsigned int irq,
 	if (!(f->valid & BIT(hwirq)))
 		return -EPERM;
 	irq_set_chip_data(irq, f);
-	irq_set_chip_and_handler(irq, &f->chip,
-				handle_level_irq);
+	irq_set_chip_and_handler(irq, &fpga_chip, handle_level_irq);
 	irq_set_probe(irq);
 	return 0;
 }
@@ -146,8 +157,8 @@ static const struct irq_domain_ops fpga_irqdomain_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
-void __init fpga_irq_init(void __iomem *base, const char *name, int irq_start,
-			  int parent_irq, u32 valid, struct device_node *node)
+static void __init fpga_irq_init(void __iomem *base, int parent_irq,
+				 u32 valid, struct device_node *node)
 {
 	struct fpga_irq_data *f;
 	int i;
@@ -158,10 +169,6 @@ void __init fpga_irq_init(void __iomem *base, const char *name, int irq_start,
 	}
 	f = &fpga_irq_devices[fpga_irq_id];
 	f->base = base;
-	f->chip.name = name;
-	f->chip.irq_ack = fpga_irq_mask;
-	f->chip.irq_mask = fpga_irq_mask;
-	f->chip.irq_unmask = fpga_irq_unmask;
 	f->valid = valid;
 
 	if (parent_irq != -1) {
@@ -169,20 +176,19 @@ void __init fpga_irq_init(void __iomem *base, const char *name, int irq_start,
 						 f);
 	}
 
-	/* This will also allocate irq descriptors */
-	f->domain = irq_domain_add_simple(node, fls(valid), irq_start,
+	f->domain = irq_domain_add_linear(node, fls(valid),
 					  &fpga_irqdomain_ops, f);
 
 	/* This will allocate all valid descriptors in the linear case */
 	for (i = 0; i < fls(valid); i++)
 		if (valid & BIT(i)) {
-			if (!irq_start)
-				irq_create_mapping(f->domain, i);
+			/* Is this still required? */
+			irq_create_mapping(f->domain, i);
 			f->used_irqs++;
 		}
 
 	pr_info("FPGA IRQ chip %d \"%s\" @ %p, %u irqs",
-		fpga_irq_id, name, base, f->used_irqs);
+		fpga_irq_id, node->name, base, f->used_irqs);
 	if (parent_irq != -1)
 		pr_cont(", parent IRQ: %d\n", parent_irq);
 	else
@@ -192,8 +198,8 @@ void __init fpga_irq_init(void __iomem *base, const char *name, int irq_start,
 }
 
 #ifdef CONFIG_OF
-int __init fpga_irq_of_init(struct device_node *node,
-			    struct device_node *parent)
+static int __init fpga_irq_of_init(struct device_node *node,
+				   struct device_node *parent)
 {
 	void __iomem *base;
 	u32 clear_mask;
@@ -222,7 +228,7 @@ int __init fpga_irq_of_init(struct device_node *node,
 		parent_irq = -1;
 	}
 
-	fpga_irq_init(base, node->name, 0, parent_irq, valid_mask, node);
+	fpga_irq_init(base, parent_irq, valid_mask, node);
 
 	/*
 	 * On Versatile AB/PB, some secondary interrupts have a direct
diff --git a/include/linux/irqchip/versatile-fpga.h b/include/linux/irqchip/versatile-fpga.h
deleted file mode 100644
index a978fc8c7996..000000000000
--- a/include/linux/irqchip/versatile-fpga.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef PLAT_FPGA_IRQ_H
-#define PLAT_FPGA_IRQ_H
-
-struct device_node;
-struct pt_regs;
-
-void fpga_handle_irq(struct pt_regs *regs);
-void fpga_irq_init(void __iomem *, const char *, int, int, u32,
-		struct device_node *node);
-int fpga_irq_of_init(struct device_node *node,
-		     struct device_node *parent);
-
-#endif
-- 
2.30.2

