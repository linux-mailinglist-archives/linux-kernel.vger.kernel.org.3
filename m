Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D50D4B6BE7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237622AbiBOMUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:20:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbiBOMUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:20:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93681074F1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:20:00 -0800 (PST)
Date:   Tue, 15 Feb 2022 12:19:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644927599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xiLW8WjZPZYQEnHnh5i0L5iUY/db+6ioj24TYsVkwXY=;
        b=OLnSoTpYSObKUM0NWfZ2N2nvG54J+tpq7gAy0q/M90xxIaPoU4ron7zHt/O4DmUxp3i1A8
        t04MPqboWLeKWjB/J2Xr2K33LakBWa5raU+Hco2xseTBE23c/myEkmnb1b0OhkYOUxnSUH
        OBiwZOa8tavRJYw5Dg/83CwdL02DpUOZzrA9lK26a/TNudTagjLa9ZvW6gpSaQLEp3mQ4W
        Hr9QAiadF7JnQSKvoj1+DdQtUhRt8aj8Sc5A07AjYckfVU+68i/yibsO3jgLa+tfPU/Rie
        NRhTzpAfiJTRFKZYz6xsSd0/yC/WEqXw9elPcmWL1DJ0oXXVSmR726gk5x4gFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644927599;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xiLW8WjZPZYQEnHnh5i0L5iUY/db+6ioj24TYsVkwXY=;
        b=XDSQ8v32G0R5lROFYyAsC4zlq1b6LIVz1OrgloMBloF6CjdMbgBL7ULbXg1CERpDlP05q8
        FBtz8YAfmVRDxYCQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/lpc32xx: Switch to dynamic chip
 name output
Cc:     Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>, tglx@linutronix.de
In-Reply-To: <20220209162607.1118325-5-maz@kernel.org>
References: <20220209162607.1118325-5-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164492759842.16921.2417198524555501420.tip-bot2@tip-bot2>
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

Commit-ID:     365550239f87342e3d29802fce0f5e9a044e8070
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/365550239f87342e3d29802fce0f5e9a044e8070
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 09 Feb 2022 16:26:01 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 15 Feb 2022 11:25:46 

irqchip/lpc32xx: Switch to dynamic chip name output

Instead of overriding the name field with the device name, use
the relevant callback. This allows us to make the irq_chip structure
const.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20220209162607.1118325-5-maz@kernel.org
---
 drivers/irqchip/irq-lpc32xx.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-lpc32xx.c b/drivers/irqchip/irq-lpc32xx.c
index a29357f..4d70a85 100644
--- a/drivers/irqchip/irq-lpc32xx.c
+++ b/drivers/irqchip/irq-lpc32xx.c
@@ -11,6 +11,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <asm/exception.h>
 
@@ -25,8 +26,8 @@
 
 struct lpc32xx_irq_chip {
 	void __iomem *base;
+	phys_addr_t addr;
 	struct irq_domain *domain;
-	struct irq_chip chip;
 };
 
 static struct lpc32xx_irq_chip *lpc32xx_mic_irqc;
@@ -118,6 +119,24 @@ static int lpc32xx_irq_set_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
+static void lpc32xx_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct lpc32xx_irq_chip *ic = irq_data_get_irq_chip_data(d);
+
+	if (ic == lpc32xx_mic_irqc)
+		seq_printf(p, "%08x.mic", ic->addr);
+	else
+		seq_printf(p, "%08x.sic", ic->addr);
+}
+
+static const struct irq_chip lpc32xx_chip = {
+	.irq_ack	= lpc32xx_irq_ack,
+	.irq_mask	= lpc32xx_irq_mask,
+	.irq_unmask	= lpc32xx_irq_unmask,
+	.irq_set_type	= lpc32xx_irq_set_type,
+	.irq_print_chip	= lpc32xx_irq_print_chip,
+};
+
 static void __exception_irq_entry lpc32xx_handle_irq(struct pt_regs *regs)
 {
 	struct lpc32xx_irq_chip *ic = lpc32xx_mic_irqc;
@@ -153,7 +172,7 @@ static int lpc32xx_irq_domain_map(struct irq_domain *id, unsigned int virq,
 	struct lpc32xx_irq_chip *ic = id->host_data;
 
 	irq_set_chip_data(virq, ic);
-	irq_set_chip_and_handler(virq, &ic->chip, handle_level_irq);
+	irq_set_chip_and_handler(virq, &lpc32xx_chip, handle_level_irq);
 	irq_set_status_flags(virq, IRQ_LEVEL);
 	irq_set_noprobe(virq);
 
@@ -183,6 +202,7 @@ static int __init lpc32xx_of_ic_init(struct device_node *node,
 	if (!irqc)
 		return -ENOMEM;
 
+	irqc->addr = addr;
 	irqc->base = of_iomap(node, 0);
 	if (!irqc->base) {
 		pr_err("%pOF: unable to map registers\n", node);
@@ -190,21 +210,11 @@ static int __init lpc32xx_of_ic_init(struct device_node *node,
 		return -EINVAL;
 	}
 
-	irqc->chip.irq_ack = lpc32xx_irq_ack;
-	irqc->chip.irq_mask = lpc32xx_irq_mask;
-	irqc->chip.irq_unmask = lpc32xx_irq_unmask;
-	irqc->chip.irq_set_type = lpc32xx_irq_set_type;
-	if (is_mic)
-		irqc->chip.name = kasprintf(GFP_KERNEL, "%08x.mic", addr);
-	else
-		irqc->chip.name = kasprintf(GFP_KERNEL, "%08x.sic", addr);
-
 	irqc->domain = irq_domain_add_linear(node, NR_LPC32XX_IC_IRQS,
 					     &lpc32xx_irq_domain_ops, irqc);
 	if (!irqc->domain) {
 		pr_err("unable to add irq domain\n");
 		iounmap(irqc->base);
-		kfree(irqc->chip.name);
 		kfree(irqc);
 		return -ENODEV;
 	}
