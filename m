Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55E94B6BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 13:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbiBOMUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 07:20:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiBOMUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:20:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82F51074E7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:19:59 -0800 (PST)
Date:   Tue, 15 Feb 2022 12:19:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644927598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=smDRKqrC9C3n679OqcRW68vfO63IJFXsaluYNs0VyhU=;
        b=pUUtBF80jx3ahjcXANctkgAQUHx+U+Nz5Dnsetk9eJpLsyNUUNngkVgrpQocr9Ipo0bE2z
        O2miY6VP3DU15OIAm0sHCeNyVRtZ3kB0vPTftXhReofcyuOkKzSHrt/xm3PIVEMCBcwtZS
        5UD4HR/0IbOU03pid4PHCd3rN0YIPUuHCCVHQ4BVHLZGBjl680Rcpto/xnkpVDyPwKYesA
        +rY9kNrXJFOVWvvNEmgv4Dx3AVgmNbbxO9awGMdbpS6Rk+p0DaJ8zAa4w90hBFPusNOGSi
        crbPcYjiuHnNZsvWhrXTJt3eFTUQbBwUq0G9mqTLyz3NYpIV6tje8k7uHxKExg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644927598;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=smDRKqrC9C3n679OqcRW68vfO63IJFXsaluYNs0VyhU=;
        b=OFysl6gEzqKIe7sHA4b2PZXu2uXmvP2MGbOOAhBvYOkmqxvOJ/8VvKHBFfaiq/0LDWJREh
        eTMAF6z2I5r3oeAA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/mvebu-pic: Switch to dynamic chip
 name output
Cc:     Marc Zyngier <maz@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>, tglx@linutronix.de
In-Reply-To: <20220209162607.1118325-6-maz@kernel.org>
References: <20220209162607.1118325-6-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164492759747.16921.12872550962294322927.tip-bot2@tip-bot2>
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

Commit-ID:     421f16238a9da88ce1f2e3a103866de095cc15f6
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/421f16238a9da88ce1f2e3a103866de095cc15f6
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 09 Feb 2022 16:26:02 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 15 Feb 2022 11:25:46 

irqchip/mvebu-pic: Switch to dynamic chip name output

Instead of overriding the name field, track the corresponding device
and use the relevant callback to output its name.

This allows us to make the irq_chip structure const.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20220209162607.1118325-6-maz@kernel.org
---
 drivers/irqchip/irq-mvebu-pic.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index 870f986..ef3d364 100644
--- a/drivers/irqchip/irq-mvebu-pic.c
+++ b/drivers/irqchip/irq-mvebu-pic.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/seq_file.h>
 
 #define PIC_CAUSE	       0x0
 #define PIC_MASK	       0x4
@@ -29,7 +30,7 @@ struct mvebu_pic {
 	void __iomem *base;
 	u32 parent_irq;
 	struct irq_domain *domain;
-	struct irq_chip irq_chip;
+	struct platform_device *pdev;
 };
 
 static void mvebu_pic_reset(struct mvebu_pic *pic)
@@ -66,6 +67,20 @@ static void mvebu_pic_unmask_irq(struct irq_data *d)
 	writel(reg, pic->base + PIC_MASK);
 }
 
+static void mvebu_pic_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct mvebu_pic *pic = irq_data_get_irq_chip_data(d);
+
+	seq_printf(p, dev_name(&pic->pdev->dev));
+}
+
+static const struct irq_chip mvebu_pic_chip = {
+	.irq_mask	= mvebu_pic_mask_irq,
+	.irq_unmask	= mvebu_pic_unmask_irq,
+	.irq_eoi	= mvebu_pic_eoi_irq,
+	.irq_print_chip	= mvebu_pic_print_chip,
+};
+
 static int mvebu_pic_irq_map(struct irq_domain *domain, unsigned int virq,
 			     irq_hw_number_t hwirq)
 {
@@ -73,8 +88,7 @@ static int mvebu_pic_irq_map(struct irq_domain *domain, unsigned int virq,
 
 	irq_set_percpu_devid(virq);
 	irq_set_chip_data(virq, pic);
-	irq_set_chip_and_handler(virq, &pic->irq_chip,
-				 handle_percpu_devid_irq);
+	irq_set_chip_and_handler(virq, &mvebu_pic_chip, handle_percpu_devid_irq);
 	irq_set_status_flags(virq, IRQ_LEVEL);
 	irq_set_probe(virq);
 
@@ -120,22 +134,16 @@ static int mvebu_pic_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct mvebu_pic *pic;
-	struct irq_chip *irq_chip;
 
 	pic = devm_kzalloc(&pdev->dev, sizeof(struct mvebu_pic), GFP_KERNEL);
 	if (!pic)
 		return -ENOMEM;
 
+	pic->pdev = pdev;
 	pic->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pic->base))
 		return PTR_ERR(pic->base);
 
-	irq_chip = &pic->irq_chip;
-	irq_chip->name = dev_name(&pdev->dev);
-	irq_chip->irq_mask = mvebu_pic_mask_irq;
-	irq_chip->irq_unmask = mvebu_pic_unmask_irq;
-	irq_chip->irq_eoi = mvebu_pic_eoi_irq;
-
 	pic->parent_irq = irq_of_parse_and_map(node, 0);
 	if (pic->parent_irq <= 0) {
 		dev_err(&pdev->dev, "Failed to parse parent interrupt\n");
