Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F535070A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353358AbiDSObw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353322AbiDSObp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:31:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF258329BE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:29:02 -0700 (PDT)
Date:   Tue, 19 Apr 2022 14:29:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650378541;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jlViW5fBVreJz2N2SEJ9Xl6za33WMKbA0WBc+NQbD/k=;
        b=Y6mHUkhJ94XwzEevLr2JdGqUkTI2YyyGitV+3SbeJPnTCWWBfKmlbNVKu8Sxxp1ES38Y35
        Ympn+4HZOSg6OH1Q6TS7+gGGvAEgjXmBKZTQOL5LWlqNYZroRdefnGy+NsbwYoUaahtZCp
        Ih0LvVMpGaYkFDsjxs6BDH91Zqyt3da1eCn5BNwNB6oS3dSRebANq48Ovf19XOAzMeoRUK
        TkBt71cNbgjy8JjAXTJ9lteRCuv7PUHXgcM+41m2gIhqWnwWnkKPAJsQ3OZFzg7qQ+CVJa
        MEWOQMTDeb5rlF0FsZLMBNOakFbaXrUpoU796NhZU7n8hmdMuluyM6MijhdkAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650378541;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jlViW5fBVreJz2N2SEJ9Xl6za33WMKbA0WBc+NQbD/k=;
        b=PPdL4jhnZEa5MZ0zl8gLPItDKPKvxiPnPcM1n3wAUf0Kq+1mvirb5eyq/WRfBBMcYodfKf
        Y7qMZIwe2s0w0YBw==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] pinctrl: amd: Make the irqchip immutable
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20220419141846.598305-9-maz@kernel.org>
References: <20220419141846.598305-9-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <165037854017.4207.13810392986433536494.tip-bot2@tip-bot2>
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

Commit-ID:     6173e56f76c712aac9d45208ccec7a065382911f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/6173e56f76c712aac9d45208ccec7a065382911f
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 19 Apr 2022 15:18:44 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 19 Apr 2022 15:22:26 +01:00

pinctrl: amd: Make the irqchip immutable

Prevent gpiolib from messing with the irqchip by advertising
the irq_chip structure as immutable, making it const, and adding
the various calls that gpiolib relies upon.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20220419141846.598305-9-maz@kernel.org
---
 drivers/pinctrl/pinctrl-amd.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 1a7d686..0645c2c 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -387,6 +387,8 @@ static void amd_gpio_irq_enable(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct amd_gpio *gpio_dev = gpiochip_get_data(gc);
 
+	gpiochip_enable_irq(gc, d->hwirq);
+
 	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 	pin_reg = readl(gpio_dev->base + (d->hwirq)*4);
 	pin_reg |= BIT(INTERRUPT_ENABLE_OFF);
@@ -408,6 +410,8 @@ static void amd_gpio_irq_disable(struct irq_data *d)
 	pin_reg &= ~BIT(INTERRUPT_MASK_OFF);
 	writel(pin_reg, gpio_dev->base + (d->hwirq)*4);
 	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
+
+	gpiochip_disable_irq(gc, d->hwirq);
 }
 
 static void amd_gpio_irq_mask(struct irq_data *d)
@@ -577,7 +581,7 @@ static void amd_irq_ack(struct irq_data *d)
 	*/
 }
 
-static struct irq_chip amd_gpio_irqchip = {
+static const struct irq_chip amd_gpio_irqchip = {
 	.name         = "amd_gpio",
 	.irq_ack      = amd_irq_ack,
 	.irq_enable   = amd_gpio_irq_enable,
@@ -593,7 +597,8 @@ static struct irq_chip amd_gpio_irqchip = {
 	 * the wake event. Otherwise the wake event will never clear and
 	 * prevent the system from suspending.
 	 */
-	.flags        = IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND,
+	.flags        = IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 #define PIN_IRQ_PENDING	(BIT(INTERRUPT_STS_OFF) | BIT(WAKE_STS_OFF))
@@ -1026,7 +1031,7 @@ static int amd_gpio_probe(struct platform_device *pdev)
 	amd_gpio_irq_init(gpio_dev);
 
 	girq = &gpio_dev->gc.irq;
-	girq->chip = &amd_gpio_irqchip;
+	gpio_irq_chip_set_chip(girq, &amd_gpio_irqchip);
 	/* This will let us handle the parent IRQ in the driver */
 	girq->parent_handler = NULL;
 	girq->num_parents = 0;
