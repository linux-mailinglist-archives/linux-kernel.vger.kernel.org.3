Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9D24AF656
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbiBIQSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbiBIQRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:17:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0982BC05CB86
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:17:58 -0800 (PST)
Date:   Wed, 09 Feb 2022 16:17:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644423476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LI7ELKgcpBAuiOmp2wbaAniHZo6CiHNQ3PTei/E7sZk=;
        b=euJ/eR+tDzZ8G//HMqDh0sBPVzBO0F+SjnPeSYkh9IExZgg/cYU2G/O06bnNE1aQWO1F/W
        B1+qzwegm1/hx10L7N14YlPwpl8fd2GukKsX8aYKW35U60xpRWMdetoerYx//PCtZdrjnb
        tbuLRBJYDYBN8duGWtAY26wBbnv8kHXoXt2ZP87LIrJikZ6GOWVi4hOLSkD4CkxOSIjkq4
        goBLW0RFf6HDP2DpmP8/yVMHC1F49E86zJeRpAPWfsBgE3vurLOZ2HC98wBECcvPv7mzQQ
        l6nsQfqtWpnL/FT0xOxnwcxwD5tOX1NMy7lsDXCgqm8WLelLfym2DDMuiFMTWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644423476;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LI7ELKgcpBAuiOmp2wbaAniHZo6CiHNQ3PTei/E7sZk=;
        b=gNdFivX1Hf49ULQ2Mvz5f9J+7OEgqUJTgxwst/K9UZpXlpok8IRCUqE4CWn4rdRGT2kJKr
        hqXmnlY4e4Vgc+Aw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] gpio: omap: Move PM device over to irq domain
Cc:     Marc Zyngier <maz@kernel.org>, Tony Lindgren <tony@atomide.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, tglx@linutronix.de
In-Reply-To: <20220201120310.878267-8-maz@kernel.org>
References: <20220201120310.878267-8-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <164442347562.16921.3011110810898773896.tip-bot2@tip-bot2>
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

Commit-ID:     989c78f25ade0af66426b935f1113d4b0fe390c5
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/989c78f25ade0af66426b935f1113d4b0fe390c5
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 01 Feb 2022 12:03:05 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 09 Feb 2022 13:36:53 

gpio: omap: Move PM device over to irq domain

Move the reference to the device over to the irq domain.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: Tony Lindgren <tony@atomide.com>
Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>
Link: https://lore.kernel.org/r/20220201120310.878267-8-maz@kernel.org
---
 drivers/gpio/gpio-omap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index e099c39..80ddc43 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -986,7 +986,8 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
 		writel_relaxed(0, base + bank->regs->ctrl);
 }
 
-static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
+static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc,
+			       struct device *pm_dev)
 {
 	struct gpio_irq_chip *irq;
 	static int gpio;
@@ -1052,6 +1053,7 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 	if (ret)
 		return dev_err_probe(bank->chip.parent, ret, "Could not register gpio chip\n");
 
+	irq_domain_set_pm_device(bank->chip.irq.domain, pm_dev);
 	ret = devm_request_irq(bank->chip.parent, bank->irq,
 			       omap_gpio_irq_handler,
 			       0, dev_name(bank->chip.parent), bank);
@@ -1402,7 +1404,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	irqc->irq_bus_sync_unlock = gpio_irq_bus_sync_unlock,
 	irqc->name = dev_name(&pdev->dev);
 	irqc->flags = IRQCHIP_MASK_ON_SUSPEND;
-	irqc->parent_device = dev;
 
 	bank->irq = platform_get_irq(pdev, 0);
 	if (bank->irq <= 0) {
@@ -1466,7 +1467,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 
 	omap_gpio_mod_init(bank);
 
-	ret = omap_gpio_chip_init(bank, irqc);
+	ret = omap_gpio_chip_init(bank, irqc, dev);
 	if (ret) {
 		pm_runtime_put_sync(dev);
 		pm_runtime_disable(dev);
