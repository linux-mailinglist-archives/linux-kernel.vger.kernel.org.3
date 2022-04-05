Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F3B4F446B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 00:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386918AbiDEUFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443195AbiDEPjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:39:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C582E147AC8;
        Tue,  5 Apr 2022 06:55:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 213AC61944;
        Tue,  5 Apr 2022 13:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7369C385A4;
        Tue,  5 Apr 2022 13:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649166903;
        bh=K+uacYcRnrL7HPJFjNCi+sJ/H54EyMHrWY0d9kLsLks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kj55MBHO78oT2tA3RQmc362wFfV7zxDRyJHTu/s4kOktimn7ps4PXJBMkhwurREwD
         zCtI6fKBrMn882wy2KrU49jagjTkQXoV6FKGIYlCaqKXZT9SJZpRGl9S7bMHUBv/t9
         X4nBZCzjgswHJ0SQs3pjEDac3TZ1B1MWbgs7/pqM3FufbHQyaPCNwCV9za8R8uWVG1
         /bm6wmItsd4mSR5EDEEfaDM3h2YHThXflRE3BhkD0LvWBUH4mY1Jsdu5c4l2a4pWsv
         tjb2su7J79XYlyhrcNy9ZRB309QWDkAnMLPHg/vH3SgjOpq21ubwzJV56RgV2bC+ik
         av/6somdipLtQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nbje9-001q4g-Np; Tue, 05 Apr 2022 14:55:01 +0100
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
Subject: [PATCH v2 08/10] pinctrl: amd: Make the irqchip immutable
Date:   Tue,  5 Apr 2022 14:54:42 +0100
Message-Id: <20220405135444.199295-9-maz@kernel.org>
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
 drivers/pinctrl/pinctrl-amd.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 1a7d686494ff..0645c2c24f50 100644
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
-- 
2.34.1

