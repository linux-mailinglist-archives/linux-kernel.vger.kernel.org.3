Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D693B4AF6A2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbiBIQ1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236893AbiBIQ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:26:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008E8C05CB8C;
        Wed,  9 Feb 2022 08:26:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91F0261889;
        Wed,  9 Feb 2022 16:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6562BC340ED;
        Wed,  9 Feb 2022 16:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644423980;
        bh=R5RKBeMN5KKCqXI9HwUlSz5oDemu9rYE1YTGCQmRlLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YeLxs1boOIdSnIZiGzvsfZytXHmwEctfigvUn65ZyqORJiFWm+4SOFvBsX9YHvmo+
         OvlspHO6yi6wBPJ8d8FUIf/Ve8cg8cYEptACXXeiP+46Pq/7XsHg3n1X/pnoWzW4vh
         jS3aoCNrFpgC6boSI9sCXJlMLvDtL22k8UQwnejfJ/EwDC9ttzd8ehQJelA39ZsuEw
         i5BazKwwJ/vyYedyQ4kNsdD32+j+ogSXBI01WUD5gHImatGdfkZLClXqU2Vndjbd9d
         hXzsK6tBftOfIilmCsmaoDdbQRi1ljgV0Ux98RYlyjeBQfj37QirOdFA+siAf3cBvi
         C1FZt1Lr/zFhw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nHpnO-006fgT-Fp; Wed, 09 Feb 2022 16:26:18 +0000
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
Subject: [PATCH 09/10] gpio: omap: Switch to dynamic chip name output
Date:   Wed,  9 Feb 2022 16:26:06 +0000
Message-Id: <20220209162607.1118325-10-maz@kernel.org>
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

Instead of overloading the name field, use the relevant callback to
output the device name. Take this opportunity to fix the trailing
commas that really should be semi-colons.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/gpio/gpio-omap.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 80ddc43fd875..f2f874f0bf95 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -22,6 +22,7 @@
 #include <linux/pm.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/seq_file.h>
 #include <linux/gpio/driver.h>
 #include <linux/bitops.h>
 #include <linux/platform_data/gpio-omap.h>
@@ -708,6 +709,13 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
+static void omap_gpio_irq_print_chip(struct irq_data *d, struct seq_file *p)
+{
+	struct gpio_bank *bank = omap_irq_data_get_bank(d);
+
+	seq_printf(p, dev_name(bank->chip.parent));
+}
+
 /*---------------------------------------------------------------------*/
 
 static int omap_mpuio_suspend_noirq(struct device *dev)
@@ -1393,16 +1401,16 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	if (!irqc)
 		return -ENOMEM;
 
-	irqc->irq_startup = omap_gpio_irq_startup,
-	irqc->irq_shutdown = omap_gpio_irq_shutdown,
-	irqc->irq_ack = dummy_irq_chip.irq_ack,
-	irqc->irq_mask = omap_gpio_mask_irq,
-	irqc->irq_unmask = omap_gpio_unmask_irq,
-	irqc->irq_set_type = omap_gpio_irq_type,
-	irqc->irq_set_wake = omap_gpio_wake_enable,
-	irqc->irq_bus_lock = omap_gpio_irq_bus_lock,
-	irqc->irq_bus_sync_unlock = gpio_irq_bus_sync_unlock,
-	irqc->name = dev_name(&pdev->dev);
+	irqc->irq_startup = omap_gpio_irq_startup;
+	irqc->irq_shutdown = omap_gpio_irq_shutdown;
+	irqc->irq_ack = dummy_irq_chip.irq_ack;
+	irqc->irq_mask = omap_gpio_mask_irq;
+	irqc->irq_unmask = omap_gpio_unmask_irq;
+	irqc->irq_set_type = omap_gpio_irq_type;
+	irqc->irq_set_wake = omap_gpio_wake_enable;
+	irqc->irq_bus_lock = omap_gpio_irq_bus_lock;
+	irqc->irq_bus_sync_unlock = gpio_irq_bus_sync_unlock;
+	irqc->irq_print_chip = omap_gpio_irq_print_chip;
 	irqc->flags = IRQCHIP_MASK_ON_SUSPEND;
 
 	bank->irq = platform_get_irq(pdev, 0);
-- 
2.30.2

