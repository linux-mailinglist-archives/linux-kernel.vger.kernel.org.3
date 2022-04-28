Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAF751323E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345437AbiD1LTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344833AbiD1LTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:19:45 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3764F9FD;
        Thu, 28 Apr 2022 04:16:30 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C8FFF22238;
        Thu, 28 Apr 2022 13:16:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1651144588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JJo0GZRuGCtC68xA23LJ+wNLn42ignYVUjux2v0GG6Y=;
        b=S2UnDOdTw/i8J6PL6OhZwY2nKe78AgaqGftt/FbNASYMOz9XRKyjOhxhquh3O9WcX85ZWT
        mPPgU24Ig1a5wQTJvxSORcZvkfeBdbw2j7fX8vt2Bq3/fwchrjbYz/S5wL3GiDlwkOAX4j
        HRmhZtdgqdEzuQ4VIGbAd7F1TmbgbVs=
From:   Michael Walle <michael@walle.cc>
To:     Marc Zyngier <maz@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     UNGLinuxDriver@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] pinctrl: microchip-sgpio: make irq_chip immutable
Date:   Thu, 28 Apr 2022 13:16:22 +0200
Message-Id: <20220428111622.1395831-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since recently, the kernel is nagging about mutable irq_chips:

[    4.967050] gpio gpiochip1: (e2004190.gpio-input): not an immutable chip, please consider fixing it!

Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
helper functions and call the appropriate gpiolib functions.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/pinctrl/pinctrl-microchip-sgpio.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-microchip-sgpio.c b/drivers/pinctrl/pinctrl-microchip-sgpio.c
index 80a8939ad0c0..6dbe37d3d558 100644
--- a/drivers/pinctrl/pinctrl-microchip-sgpio.c
+++ b/drivers/pinctrl/pinctrl-microchip-sgpio.c
@@ -688,11 +688,17 @@ static void microchip_sgpio_irq_setreg(struct irq_data *data,
 
 static void microchip_sgpio_irq_mask(struct irq_data *data)
 {
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+
 	microchip_sgpio_irq_setreg(data, REG_INT_ENABLE, true);
+	gpiochip_disable_irq(chip, data->hwirq);
 }
 
 static void microchip_sgpio_irq_unmask(struct irq_data *data)
 {
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
+
+	gpiochip_enable_irq(chip, data->hwirq);
 	microchip_sgpio_irq_setreg(data, REG_INT_ENABLE, false);
 }
 
@@ -746,6 +752,8 @@ static const struct irq_chip microchip_sgpio_irqchip = {
 	.irq_ack	= microchip_sgpio_irq_ack,
 	.irq_unmask	= microchip_sgpio_irq_unmask,
 	.irq_set_type	= microchip_sgpio_irq_set_type,
+	.flags		= IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static void sgpio_irq_handler(struct irq_desc *desc)
@@ -861,11 +869,7 @@ static int microchip_sgpio_register_bank(struct device *dev,
 		if (irq) {
 			struct gpio_irq_chip *girq = &gc->irq;
 
-			girq->chip = devm_kmemdup(dev, &microchip_sgpio_irqchip,
-						  sizeof(microchip_sgpio_irqchip),
-						  GFP_KERNEL);
-			if (!girq->chip)
-				return -ENOMEM;
+			gpio_irq_chip_set_chip(girq, &microchip_sgpio_irqchip);
 			girq->parent_handler = sgpio_irq_handler;
 			girq->num_parents = 1;
 			girq->parents = devm_kcalloc(dev, 1,
-- 
2.30.2

