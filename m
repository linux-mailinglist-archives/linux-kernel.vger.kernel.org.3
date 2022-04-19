Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80FE50708A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352203AbiDSOcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353329AbiDSObr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:31:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262B0E0CF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:05 -0700 (PDT)
Date:   Tue, 19 Apr 2022 14:29:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650378543;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=igW7fwpJSydengzg/bbNTtjpK/uBGIdAR0sNedCbFJU=;
        b=A+kS3lrMHVmBYEAhhQ4fCzwdrCWmAbThvFkCZu3zXLdUc9cKeQU96rY9Fdig0uWxK3Zx+j
        X5uXickU5iljS+Q/gtojz37RQdIC9h2s5DKXxWkiKBhhSHACnLR2M1DqB0OmNINFdxBy4X
        JM4unx39JEjMAttwkDAf2gsUZBGqdg+Fmbj+vaTMXd5mUoV6PLa7a89NtdjPN/tvDKg/yZ
        FyExpT/MKVv0G9HUJKV/jBbwd5I4keRU4U1r5oOFXZJpRqgaPYr64ulEBZxQE3QtvLf0Cn
        X7se8yDTDZUOAsKOa1KUAHpo0siwveLf4Omo6ofZEOiCWF7/nhWznWsFsOY1sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650378543;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=igW7fwpJSydengzg/bbNTtjpK/uBGIdAR0sNedCbFJU=;
        b=eANlbdRH/qBcaZW5wL72hFhgE43Toz63oyfnU8m1DtTIAcKVhbd2JstuB6mzVjRahE0w8e
        kICYr3xa67d6OPAQ==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] gpio: pl061: Make the irqchip immutable
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Marc Zyngier <maz@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20220419141846.598305-6-maz@kernel.org>
References: <20220419141846.598305-6-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <165037854272.4207.3990053802403615021.tip-bot2@tip-bot2>
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

Commit-ID:     15d8c14ac849f41f2d41dbddb69f402aaf73ff8b
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/15d8c14ac849f41f2d41dbddb69f402aaf73ff8b
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 19 Apr 2022 15:18:41 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 19 Apr 2022 15:22:26 +01:00

gpio: pl061: Make the irqchip immutable

Prevent gpiolib from messing with the irqchip by advertising
the irq_chip structure as immutable, making it const, and adding
the various calls that gpiolib relies upon.

Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220419141846.598305-6-maz@kernel.org
---
 drivers/gpio/gpio-pl061.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 4ecab70..6464056 100644
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
