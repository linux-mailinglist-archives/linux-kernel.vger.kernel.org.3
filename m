Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455324AF693
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbiBIQ0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236859AbiBIQ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:26:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BFEC05CB87;
        Wed,  9 Feb 2022 08:26:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8E5961881;
        Wed,  9 Feb 2022 16:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE0BC340FA;
        Wed,  9 Feb 2022 16:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644423979;
        bh=FMZwl2x1x4kUwATGFjH+jJWY/tUg+gF8fFqxjWMZ+II=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GDSOrpJ/EcrzUKRgKaDvG2yrWW6qqBcR06vO52WdUQfW+mbB8Clsfjk2IgGNUvM2m
         n3X6/EE1q99pF10VnxsD27CMEid0pJyNaLQmvuNaVx7r1fqpQyZu1Styu0LAEYWInf
         lO54cDAdwc+Sy8bpV8hMPfgUHkpRbsb8w9W3vMPJza0gdO44djn7lz/kMvaTrVLrEJ
         5+ak0l32gkkWA3yKSj1ZZXv2MlYMChuyrSJg8zq4sDDiDE54/tC3zvQ46+gRl51vPv
         oTreBj3GeX6Ux9arkZFQeKwogA+OAfP2hEW7k0IX+i2EUYnFhfpTd0I4OM8WJIRf+d
         cw1nil3JwTV1w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nHpnN-006fgT-9d; Wed, 09 Feb 2022 16:26:17 +0000
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
Subject: [PATCH 05/10] irqchip/mvebu-pic: Switch to dynamic chip name output
Date:   Wed,  9 Feb 2022 16:26:02 +0000
Message-Id: <20220209162607.1118325-6-maz@kernel.org>
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

Instead of overriding the name field, track the corresponding device
and use the relevant callback to output its name.

This allows us to make the irq_chip structure const.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-mvebu-pic.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-pic.c b/drivers/irqchip/irq-mvebu-pic.c
index 870f9866b8da..ef3d3646ccc2 100644
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
-- 
2.30.2

