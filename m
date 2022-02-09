Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8797B4AF698
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbiBIQ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbiBIQ0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:26:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E212C0612BE;
        Wed,  9 Feb 2022 08:26:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C53E6173F;
        Wed,  9 Feb 2022 16:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBDCC36AE2;
        Wed,  9 Feb 2022 16:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644423979;
        bh=oB6h9NrunoVA0c76SiilyTbLi8O8MnX8iolIrbh8ArY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a5BXrAditPtDAq6w5VqTfYuvjwZ/QZiBACa/81ymD0zsKifvyWiYV+cHeNSgqTLO/
         zLTVzYS2PCJ/45hTrwWB9+gEKwTFfssn0qHkdUeoZmeoEBvuaogMHXbN0GBa2PeVUh
         JtKNdJIwovJLuK3prCud6vFKd/ZOMJ1YCZ1xvfQxYEty34WUgqMIOR2UUCc4dw/aKa
         j6eZ1Falv+h5laHrHmAumcxw/IoB3p/CYW8uTgogXqACarLrZ0Ek4UUnxJol0GbusG
         BBUBcrejRIm5fPv0Fp2Hc7hIP2h55QihsSLntQ7pF6D65o+eERhb5bSJpbrWXAj/sO
         oCfCSprnTYa5A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nHpnN-006fgT-Jd; Wed, 09 Feb 2022 16:26:17 +0000
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
Subject: [PATCH 06/10] irqchip/ts4800: Switch to dynamic chip name output
Date:   Wed,  9 Feb 2022 16:26:03 +0000
Message-Id: <20220209162607.1118325-7-maz@kernel.org>
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

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-ts4800.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-ts4800.c b/drivers/irqchip/irq-ts4800.c
index f032db23b30f..b2d61d4f6fe6 100644
--- a/drivers/irqchip/irq-ts4800.c
+++ b/drivers/irqchip/irq-ts4800.c
@@ -19,14 +19,15 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/seq_file.h>
 
 #define IRQ_MASK        0x4
 #define IRQ_STATUS      0x8
 
 struct ts4800_irq_data {
 	void __iomem            *base;
+	struct platform_device	*pdev;
 	struct irq_domain       *domain;
-	struct irq_chip         irq_chip;
 };
 
 static void ts4800_irq_mask(struct irq_data *d)
@@ -47,12 +48,25 @@ static void ts4800_irq_unmask(struct irq_data *d)
 	writew(reg & ~mask, data->base + IRQ_MASK);
 }
 
+static void ts4800_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct ts4800_irq_data *data = irq_data_get_irq_chip_data(d);
+
+	seq_printf(p, "%s", dev_name(&data->pdev->dev));
+}
+
+static const struct irq_chip ts4800_chip = {
+	.irq_mask	= ts4800_irq_mask,
+	.irq_unmask	= ts4800_irq_unmask,
+	.irq_print_chip	= ts4800_irq_print_chip,
+};
+
 static int ts4800_irqdomain_map(struct irq_domain *d, unsigned int irq,
 				irq_hw_number_t hwirq)
 {
 	struct ts4800_irq_data *data = d->host_data;
 
-	irq_set_chip_and_handler(irq, &data->irq_chip, handle_simple_irq);
+	irq_set_chip_and_handler(irq, &ts4800_chip, handle_simple_irq);
 	irq_set_chip_data(irq, data);
 	irq_set_noprobe(irq);
 
@@ -92,13 +106,13 @@ static int ts4800_ic_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct ts4800_irq_data *data;
-	struct irq_chip *irq_chip;
 	int parent_irq;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
+	data->pdev = pdev;
 	data->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
@@ -111,11 +125,6 @@ static int ts4800_ic_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	irq_chip = &data->irq_chip;
-	irq_chip->name = dev_name(&pdev->dev);
-	irq_chip->irq_mask = ts4800_irq_mask;
-	irq_chip->irq_unmask = ts4800_irq_unmask;
-
 	data->domain = irq_domain_add_linear(node, 8, &ts4800_ic_ops, data);
 	if (!data->domain) {
 		dev_err(&pdev->dev, "cannot add IRQ domain\n");
-- 
2.30.2

