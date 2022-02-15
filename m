Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443124B6BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237611AbiBOMUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:20:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbiBOMUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:20:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38861074EE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:19:59 -0800 (PST)
Date:   Tue, 15 Feb 2022 12:19:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644927596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dyM4Y7J7b4bK7UFlD0E5yLbZ9YLPHgg1Z8dWcUV0Tss=;
        b=PSpzCnhFoxJ0L8RLJY4OR3wUUi6VY9GBo80I0ZfTTLH/TVfx9RhKVzjZngKS9JHRBWfrEI
        HKcUNIUZGrdAFZDKXsnsz2oXIWPZF3/TXK4aKFaKmBV8UOblo/Z54MlbiEv7J7gaeMxYXw
        lT2qFoVpRUKAo9HPyWJLvyNBOU/jt4XaVDaOUrcENFjKbZahbMDK9Q1mfV5n0T1ji+DsCi
        K+u1+lWM/LuRkVePaBk+xc1aV1Z/iLSnfCzbLa7kOSlNNfFIUGrW+/hJoU+phtbsiOWVYF
        xNHwYU2Fw2Lmu0EzEYsd0Ry0ZkGRgmRjJn9Q9IztTpRTHEyMGDLvSAxIGzA1Gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644927596;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dyM4Y7J7b4bK7UFlD0E5yLbZ9YLPHgg1Z8dWcUV0Tss=;
        b=db+N8ZwMgCTW6gsY//3Wtz8kPIYBOJgopH+kQYPjwoZeiLmua2nT5RqYeSwpy6JP2hb0w+
        y9ADv8I4FVbcQHAQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/versatile-fpga: Switch to dynamic
 chip name output
Cc:     Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>, tglx@linutronix.de
In-Reply-To: <20220209162607.1118325-8-maz@kernel.org>
References: <20220209162607.1118325-8-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164492759537.16921.11531674759646795086.tip-bot2@tip-bot2>
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

Commit-ID:     3fb212a042fbd8eccbb2af1852e03ed7757b9600
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/3fb212a042fbd8eccbb2af1852e03ed7757b9600
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 09 Feb 2022 16:26:04 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 15 Feb 2022 11:25:46 

irqchip/versatile-fpga: Switch to dynamic chip name output

Move the name output to the relevant callback, which allows us
some nice cleanups (mostly owing to the fact that the driver is
now DT only.

We also drop a random include directive from the ftintc010 driver.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20220209162607.1118325-8-maz@kernel.org
---
 drivers/irqchip/irq-ftintc010.c        |  1 +-
 drivers/irqchip/irq-versatile-fpga.c   | 46 ++++++++++++++-----------
 include/linux/irqchip/versatile-fpga.h | 14 +--------
 3 files changed, 26 insertions(+), 35 deletions(-)
 delete mode 100644 include/linux/irqchip/versatile-fpga.h

diff --git a/drivers/irqchip/irq-ftintc010.c b/drivers/irqchip/irq-ftintc010.c
index 5cc2688..46a3aa6 100644
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
index f2757b6..ba543ed 100644
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
index a978fc8..0000000
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
