Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D965F4C1770
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242355AbiBWPpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242326AbiBWPoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:44:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B24EBF95A;
        Wed, 23 Feb 2022 07:44:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03B5BB820C8;
        Wed, 23 Feb 2022 15:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D386C340FB;
        Wed, 23 Feb 2022 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645631064;
        bh=SUMHRwHLSBCKt6500XeBFRSfc+yTeQJg5D0JuhgT3GU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k8wnDyj1uHxERgKeK02phgsLUftdGXrbd5qFabvyCkSnnyt34BAjJbRuIqdEvkgdX
         K/tcguWOd03meJ9EVPq7c0NWNEtMs97wkE6OLGdf97uHBBtM0SMjooXe6i3fWsth/G
         eKe3a5ijx6qXxfUYEXiv0cX9ftXYW1BNQlSzlzEvqm4yMgv4Gz4MneOSA3fu618kWV
         wjdvl07/4wrX0dLue6f0Y5FM0MjLApM8yFGDZ7PLMEd+IHuxzTbhy7is4K6hVuvX+s
         c8q3rRbGRJzd43uU9ETelUvJ0dMA7cF3bGMaxfHMJSGfofqJcY1OMQAVe+PioGduK0
         r7I2kx0psP9uA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nMtoU-009wgt-Kn; Wed, 23 Feb 2022 15:44:22 +0000
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
        Thomas Gleixner <tglx@linutronix.de>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, kernel-team@android.com
Subject: [PATCH 5/5] gpio: tegra186: Make the irqchip immutable
Date:   Wed, 23 Feb 2022 15:44:05 +0000
Message-Id: <20220223154405.54912-6-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220223154405.54912-1-maz@kernel.org>
References: <20220223154405.54912-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com, joey.gouly@arm.com, jonathanh@nvidia.com, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, bjorn.andersson@linaro.org, agross@kernel.org, tglx@linutronix.de, linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, kernel-team@android.com
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
 drivers/gpio/gpio-tegra186.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 8d298beffd86..2455e1a2c451 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -80,7 +80,6 @@ struct tegra_gpio_soc {
 
 struct tegra_gpio {
 	struct gpio_chip gpio;
-	struct irq_chip intc;
 	unsigned int num_irq;
 	unsigned int *irq;
 
@@ -372,6 +371,8 @@ static void tegra186_irq_mask(struct irq_data *data)
 	value = readl(base + TEGRA186_GPIO_ENABLE_CONFIG);
 	value &= ~TEGRA186_GPIO_ENABLE_CONFIG_INTERRUPT;
 	writel(value, base + TEGRA186_GPIO_ENABLE_CONFIG);
+
+	gpiochip_disable_irq(&gpio->gpio, data->hwirq);
 }
 
 static void tegra186_irq_unmask(struct irq_data *data)
@@ -385,6 +386,8 @@ static void tegra186_irq_unmask(struct irq_data *data)
 	if (WARN_ON(base == NULL))
 		return;
 
+	gpiochip_enable_irq(&gpio->gpio, data->hwirq);
+
 	value = readl(base + TEGRA186_GPIO_ENABLE_CONFIG);
 	value |= TEGRA186_GPIO_ENABLE_CONFIG_INTERRUPT;
 	writel(value, base + TEGRA186_GPIO_ENABLE_CONFIG);
@@ -456,6 +459,25 @@ static int tegra186_irq_set_wake(struct irq_data *data, unsigned int on)
 	return 0;
 }
 
+static void tegra186_irq_print_chip(struct irq_data *data, struct seq_file *p)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+
+	seq_printf(p, dev_name(gc->parent));
+}
+
+static const struct irq_chip tegra186_gpio_irq_chip = {
+	.irq_request_resources	= gpiochip_irq_reqres,
+	.irq_release_resources	= gpiochip_irq_relres,
+	.irq_ack		= tegra186_irq_ack,
+	.irq_mask		= tegra186_irq_mask,
+	.irq_unmask		= tegra186_irq_unmask,
+	.irq_set_type		= tegra186_irq_set_type,
+	.irq_set_wake		= tegra186_irq_set_wake,
+	.irq_print_chip		= tegra186_irq_print_chip,
+	.flags			= IRQCHIP_IMMUTABLE,
+};
+
 static void tegra186_gpio_irq(struct irq_desc *desc)
 {
 	struct tegra_gpio *gpio = irq_desc_get_handler_data(desc);
@@ -760,15 +782,8 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 	gpio->gpio.of_xlate = tegra186_gpio_of_xlate;
 #endif /* CONFIG_OF_GPIO */
 
-	gpio->intc.name = dev_name(&pdev->dev);
-	gpio->intc.irq_ack = tegra186_irq_ack;
-	gpio->intc.irq_mask = tegra186_irq_mask;
-	gpio->intc.irq_unmask = tegra186_irq_unmask;
-	gpio->intc.irq_set_type = tegra186_irq_set_type;
-	gpio->intc.irq_set_wake = tegra186_irq_set_wake;
-
 	irq = &gpio->gpio.irq;
-	irq->chip = &gpio->intc;
+	irq->chip = (struct irq_chip *)&tegra186_gpio_irq_chip;
 	irq->fwnode = of_node_to_fwnode(pdev->dev.of_node);
 	irq->child_to_parent_hwirq = tegra186_gpio_child_to_parent_hwirq;
 	irq->populate_parent_alloc_arg = tegra186_gpio_populate_parent_fwspec;
-- 
2.30.2

