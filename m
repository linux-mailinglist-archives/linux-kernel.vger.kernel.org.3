Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE025070A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353409AbiDSOcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353337AbiDSObs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:31:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9EA31342
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:06 -0700 (PDT)
Date:   Tue, 19 Apr 2022 14:29:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650378544;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bC9UeMem4uJsQOjBgP7HV58P0gLulRWaaQpTu58LeaE=;
        b=J87Sox3vpWRXCHvIdMI+B+T4qRsOi25qbpQTlX+2vbZPLGdVZCCq0Ae8p55PQRoqv2Oz0o
        kunLqDsheLEgdP6Zo0qxDnQth6I2Gz53m3UY1KpBJ2cnrWO2/MYPEZOwHVajKim1tCkdTW
        aPVOKLcjWXIVTt4QpUMKKRC9tHGnDDgqVEWqKTkKI6wIxQhp7SqmBLaqUHPOOyelTn5BzN
        9Ov6lq6kv/xQVOYW5HjBVzYbVK4RiEhcLpl2ebJx2ZENuXhvz/LzYHxT4LQodko+ZtPlfc
        3E/UOLnTxvB17GYRLwM2Lz+CBgQFjcgsqTlrf7PRBHG5yvxt5D5O7208guQNtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650378544;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bC9UeMem4uJsQOjBgP7HV58P0gLulRWaaQpTu58LeaE=;
        b=DEW2ZI0PvIWn9KNhTw3V5bvZTNsm6NhoxjHSzKD6P1w6D65EGICg4h5re4kMe0nNz2Vn5i
        PVMQ30xIFeBWApAg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] gpio: tegra186: Make the irqchip immutable
Cc:     Thierry Reding <treding@nvidia.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220419141846.598305-5-maz@kernel.org>
References: <20220419141846.598305-5-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <165037854358.4207.16445271769839327129.tip-bot2@tip-bot2>
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

Commit-ID:     bba00555ede79ad8a743da908f708466f6bac0f8
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/bba00555ede79ad8a743da908f708466f6bac0f8
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 19 Apr 2022 15:18:40 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 19 Apr 2022 15:22:26 +01:00

gpio: tegra186: Make the irqchip immutable

Prevent gpiolib from messing with the irqchip by advertising
the irq_chip structure as immutable, making it const, and adding
the various calls that gpiolib relies upon.

Acked-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220419141846.598305-5-maz@kernel.org
---
 drivers/gpio/gpio-tegra186.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 031fe10..84c4f1e 100644
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
@@ -456,6 +459,24 @@ static int tegra186_irq_set_wake(struct irq_data *data, unsigned int on)
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
+	.irq_ack		= tegra186_irq_ack,
+	.irq_mask		= tegra186_irq_mask,
+	.irq_unmask		= tegra186_irq_unmask,
+	.irq_set_type		= tegra186_irq_set_type,
+	.irq_set_wake		= tegra186_irq_set_wake,
+	.irq_print_chip		= tegra186_irq_print_chip,
+	.flags			= IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
 static void tegra186_gpio_irq(struct irq_desc *desc)
 {
 	struct tegra_gpio *gpio = irq_desc_get_handler_data(desc);
@@ -760,15 +781,8 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
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
+	gpio_irq_chip_set_chip(irq, &tegra186_gpio_irq_chip);
 	irq->fwnode = of_node_to_fwnode(pdev->dev.of_node);
 	irq->child_to_parent_hwirq = tegra186_gpio_child_to_parent_hwirq;
 	irq->populate_parent_alloc_arg = tegra186_gpio_populate_parent_fwspec;
