Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45174F4D70
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582364AbiDEXmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443205AbiDEPjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:39:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E300C147AE1;
        Tue,  5 Apr 2022 06:55:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32088B81D5C;
        Tue,  5 Apr 2022 13:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA3DC385A7;
        Tue,  5 Apr 2022 13:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649166902;
        bh=5PC7cNcGGV9G0+eiFziaHyPdpTmXLBiQSjJ1/TC4vHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OHp+DpQ8tq3YWaIyyPnnCclgtnrI8TWTrlnE3G7ufpDrr/06gugrT6pNUXCTLOFc9
         vfUMs4bRFwz7HO4xxWTiCuTr1l+7H8CmdXgiYJ+ToyPwD+7tDWx+0VTwH5BvpmUgqJ
         8834A5mq04rRZVqQiG+UJ0xRcn+0aoFQNP/paht14/Xv1kiQOpXqjbfQl1NPoDN3Kv
         2Tbmgd4+W9QbuEcY9y9UcDR8a0Z4eg8dmSXb5lZxM+NHYWy33sCxyH6sX0Prm9JDmd
         WwrR5bCzR9TNEI0hPfotVkbMy3Q+BQ+Q1kcmsaRxhvBYOQckQJTaRwm2eXuB6E5s6L
         tccY8CC37Nkrw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nbje8-001q4g-S7; Tue, 05 Apr 2022 14:55:00 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, kernel-team@android.com
Subject: [PATCH v2 05/10] gpio: pl061: Make the irqchip immutable
Date:   Tue,  5 Apr 2022 14:54:39 +0100
Message-Id: <20220405135444.199295-6-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220405135444.199295-1-maz@kernel.org>
References: <20220405135444.199295-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com, joey.gouly@arm.com, jonathanh@nvidia.com, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, bjorn.andersson@linaro.org, agross@kernel.org, jeffrey.l.hugo@gmail.com, tglx@linutronix.de, Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, kernel-team@android.com
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

Prevent gpiolib from messing with the irqchip by advertising
the irq_chip structure as immutable, making it const, and adding
the various calls that gpiolib relies upon.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/gpio/gpio-pl061.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 4ecab700f23f..6464056cb6ae 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -52,7 +52,6 @@ struct pl061 {
 
 	void __iomem		*base;
 	struct gpio_chip	gc;
-	struct irq_chip		irq_chip;
 	int			parent_irq;
 
 #ifdef CONFIG_PM
@@ -241,6 +240,8 @@ static void pl061_irq_mask(struct irq_data *d)
 	gpioie = readb(pl061->base + GPIOIE) & ~mask;
 	writeb(gpioie, pl061->base + GPIOIE);
 	raw_spin_unlock(&pl061->lock);
+
+	gpiochip_disable_irq(gc, d->hwirq);
 }
 
 static void pl061_irq_unmask(struct irq_data *d)
@@ -250,6 +251,8 @@ static void pl061_irq_unmask(struct irq_data *d)
 	u8 mask = BIT(irqd_to_hwirq(d) % PL061_GPIO_NR);
 	u8 gpioie;
 
+	gpiochip_enable_irq(gc, d->hwirq);
+
 	raw_spin_lock(&pl061->lock);
 	gpioie = readb(pl061->base + GPIOIE) | mask;
 	writeb(gpioie, pl061->base + GPIOIE);
@@ -283,6 +286,24 @@ static int pl061_irq_set_wake(struct irq_data *d, unsigned int state)
 	return irq_set_irq_wake(pl061->parent_irq, state);
 }
 
+static void pl061_irq_print_chip(struct irq_data *data, struct seq_file *p)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+
+	seq_printf(p, dev_name(gc->parent));
+}
+
+static const struct irq_chip pl061_irq_chip = {
+	.irq_ack		= pl061_irq_ack,
+	.irq_mask		= pl061_irq_mask,
+	.irq_unmask		= pl061_irq_unmask,
+	.irq_set_type		= pl061_irq_type,
+	.irq_set_wake		= pl061_irq_set_wake,
+	.irq_print_chip		= pl061_irq_print_chip,
+	.flags			= IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct device *dev = &adev->dev;
@@ -315,13 +336,6 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 	/*
 	 * irq_chip support
 	 */
-	pl061->irq_chip.name = dev_name(dev);
-	pl061->irq_chip.irq_ack	= pl061_irq_ack;
-	pl061->irq_chip.irq_mask = pl061_irq_mask;
-	pl061->irq_chip.irq_unmask = pl061_irq_unmask;
-	pl061->irq_chip.irq_set_type = pl061_irq_type;
-	pl061->irq_chip.irq_set_wake = pl061_irq_set_wake;
-
 	writeb(0, pl061->base + GPIOIE); /* disable irqs */
 	irq = adev->irq[0];
 	if (!irq)
@@ -329,7 +343,7 @@ static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 	pl061->parent_irq = irq;
 
 	girq = &pl061->gc.irq;
-	girq->chip = &pl061->irq_chip;
+	gpio_irq_chip_set_chip(girq, &pl061_irq_chip);
 	girq->parent_handler = pl061_irq_handler;
 	girq->num_parents = 1;
 	girq->parents = devm_kcalloc(dev, 1, sizeof(*girq->parents),
-- 
2.34.1

