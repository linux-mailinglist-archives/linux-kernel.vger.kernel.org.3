Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF64F50709E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353509AbiDSOcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353355AbiDSObw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:31:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B18137A0A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:09 -0700 (PDT)
Date:   Tue, 19 Apr 2022 14:29:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650378547;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BzvR37mlV3B7k6htjXXR4S3n+fQZgR/HItfdGCY9zsg=;
        b=MikBT1Y1GUkdPAlew4Q6HsFGMgmHy/Ds34lSTXZLeuhytbU2yaLwG84e0iiNOsgCzPiF85
        6p6J8l5ZOdDXIBNCyETPPYWjprhs4xXYsabFdhE4EakPsUF2LN8XoUSLLCXp2VqWoFXuvh
        bQEfFkcWibOkyA/GkICZseIvCl+xm/7GJCEYL68H8q6TB86j6UF4+6vQ+u0H/7S+zIQzzW
        jiHzdaxmGGyronSY3Xk0NSeQSIlzJZxNX8RUswzRmCEyyT6LwlRoNfgn22aUqeLr61bZOc
        I/9Ro6nL1k/7BKwXUGp5joWBA2aLxSX+bg/ifSSHQu+8HXn7APfXvjFb3cp1bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650378547;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BzvR37mlV3B7k6htjXXR4S3n+fQZgR/HItfdGCY9zsg=;
        b=L2BHChPQ/qjjAgMYjLzR33S2Fv4tOC82nAA2xYt7pSQVzXZqkdhyOrINAktBRJ/r5oKFG+
        u5Dqqw5ICGXid8CA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] pinctrl: apple-gpio: Make the irqchip immutable
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220419141846.598305-7-maz@kernel.org>
References: <20220419141846.598305-7-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <165037854188.4207.17354413029616065792.tip-bot2@tip-bot2>
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

Commit-ID:     374b87a0fcf9fa5dd1379271337ae19f95682956
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/374b87a0fcf9fa5dd1379271337ae19f95682956
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 19 Apr 2022 15:18:42 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 19 Apr 2022 15:22:26 +01:00

pinctrl: apple-gpio: Make the irqchip immutable

Prevent gpiolib from messing with the irqchip by advertising
the irq_chip structure as immutable, making it const, and adding
the various calls that gpiolib relies upon.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220419141846.598305-7-maz@kernel.org
---
 drivers/pinctrl/pinctrl-apple-gpio.c | 29 ++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-apple-gpio.c b/drivers/pinctrl/pinctrl-apple-gpio.c
index 72f4dd2..5e61084 100644
--- a/drivers/pinctrl/pinctrl-apple-gpio.c
+++ b/drivers/pinctrl/pinctrl-apple-gpio.c
@@ -36,7 +36,6 @@ struct apple_gpio_pinctrl {
 
 	struct pinctrl_desc pinctrl_desc;
 	struct gpio_chip gpio_chip;
-	struct irq_chip irq_chip;
 	u8 irqgrps[];
 };
 
@@ -275,17 +274,21 @@ static unsigned int apple_gpio_irq_type(unsigned int type)
 
 static void apple_gpio_irq_mask(struct irq_data *data)
 {
-	struct apple_gpio_pinctrl *pctl = gpiochip_get_data(irq_data_get_irq_chip_data(data));
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct apple_gpio_pinctrl *pctl = gpiochip_get_data(gc);
 
 	apple_gpio_set_reg(pctl, data->hwirq, REG_GPIOx_MODE,
 	                   FIELD_PREP(REG_GPIOx_MODE, REG_GPIOx_IN_IRQ_OFF));
+	gpiochip_disable_irq(gc, data->hwirq);
 }
 
 static void apple_gpio_irq_unmask(struct irq_data *data)
 {
-	struct apple_gpio_pinctrl *pctl = gpiochip_get_data(irq_data_get_irq_chip_data(data));
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct apple_gpio_pinctrl *pctl = gpiochip_get_data(gc);
 	unsigned int irqtype = apple_gpio_irq_type(irqd_get_trigger_type(data));
 
+	gpiochip_enable_irq(gc, data->hwirq);
 	apple_gpio_set_reg(pctl, data->hwirq, REG_GPIOx_MODE,
 	                   FIELD_PREP(REG_GPIOx_MODE, irqtype));
 }
@@ -343,13 +346,15 @@ static void apple_gpio_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static struct irq_chip apple_gpio_irqchip = {
-	.name		= "Apple-GPIO",
-	.irq_startup	= apple_gpio_irq_startup,
-	.irq_ack	= apple_gpio_irq_ack,
-	.irq_mask	= apple_gpio_irq_mask,
-	.irq_unmask	= apple_gpio_irq_unmask,
-	.irq_set_type	= apple_gpio_irq_set_type,
+static const struct irq_chip apple_gpio_irqchip = {
+	.name			= "Apple-GPIO",
+	.irq_startup		= apple_gpio_irq_startup,
+	.irq_ack		= apple_gpio_irq_ack,
+	.irq_mask		= apple_gpio_irq_mask,
+	.irq_unmask		= apple_gpio_irq_unmask,
+	.irq_set_type		= apple_gpio_irq_set_type,
+	.flags			= IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 /* Probe & register */
@@ -360,8 +365,6 @@ static int apple_gpio_register(struct apple_gpio_pinctrl *pctl)
 	void **irq_data = NULL;
 	int ret;
 
-	pctl->irq_chip = apple_gpio_irqchip;
-
 	pctl->gpio_chip.label = dev_name(pctl->dev);
 	pctl->gpio_chip.request = gpiochip_generic_request;
 	pctl->gpio_chip.free = gpiochip_generic_free;
@@ -377,7 +380,7 @@ static int apple_gpio_register(struct apple_gpio_pinctrl *pctl)
 	if (girq->num_parents) {
 		int i;
 
-		girq->chip = &pctl->irq_chip;
+		gpio_irq_chip_set_chip(girq, &apple_gpio_irqchip);
 		girq->parent_handler = apple_gpio_irq_handler;
 
 		girq->parents = kmalloc_array(girq->num_parents,
