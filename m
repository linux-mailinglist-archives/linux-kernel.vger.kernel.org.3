Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCED65ABA3B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 23:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiIBVk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 17:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiIBVkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 17:40:24 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A304038476
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 14:40:21 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id g16so2728008qkl.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 14:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=bR3hEleHn1hDXjDK6nUjMSvBYEAsUeJzCzyUGuVERRQ=;
        b=wuzCTnre6tTsSegsWv8KZyKcXhhqdhcG6fFIvRHpUAcFTLq9edlgDAeNCrP1BZBuQs
         +snDeAgYpQ9ou4o7gjLmO4qAPCuMqjAMbSPDH6nE3m4Wt26glIh+Q+WnQ8h2JPbH743C
         XofCCIy/C62BWw7Gz4ktIrZQqvhlIuwS7utzOIyMLVq6TDdCeNhT05Niap6zzINjxe9d
         VRnsUCafjeFcUtRGslnzqSsXeskPb0D729WRKiT3jNNohcyEJmY1jMASfZ0wmaKpZmpH
         seXeBDvkWD9yhDdZJxHZ8g6wAsmC/bSfQs1ikHOQO7BCPMuu2XRckAw5U3BgMDCidcWo
         28Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bR3hEleHn1hDXjDK6nUjMSvBYEAsUeJzCzyUGuVERRQ=;
        b=otOpNwzsYl5yBZVtiQZInKQJK7O1I4Marin2cMCGr63lbXd7+tbKTnDsYCPu896Q9k
         PB2Rt4DEsS+jfbDPP/Nh8opQe7VDVOIbqUX10gtgEZQXjDYOQn6MTofNCWPr6uiimsvy
         mRkmXM0ml9zMxogBgc93yhVJeQWImLcgvNeHJp8ADVzkuw2OmKJQv3IPZimN2iXXGd2s
         UksXU1R91w9L0AarI536t1OXJp6v0OVfXD4lPEg3Ttc42XzAROwmqFcyP/BALy8gbKII
         ZcELQ1Zhh1SfTLQmIlY6LG/jyVpmns3fIvhUuaTAYuoDYuzvRo5kNDQb0T6ZwNN9E06a
         9oMg==
X-Gm-Message-State: ACgBeo0TcNqVP2nmfAhUrZg2DmzFblvv+qFJOftiMow7EZf9DGo5Gk9V
        aebcq1vQI/P+cnHKehxdmhyEh4RtDOrhBA==
X-Google-Smtp-Source: AA6agR5GjIxXkb/bcDLBsnO3UPU6jpE1pq17eJNvvjhLBlYBn3BCFQ7DqD21u9qoZ70EX7rLo01JsA==
X-Received: by 2002:a05:620a:4094:b0:6bb:8514:9c84 with SMTP id f20-20020a05620a409400b006bb85149c84mr24438491qko.134.1662154820356;
        Fri, 02 Sep 2022 14:40:20 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id 15-20020ac84e8f000000b0031f0b43629dsm1819533qtp.23.2022.09.02.14.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 14:40:20 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     brgl@bgdev.pl, linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Frede@cmslaser.com
Subject: [PATCH 3/4] gpio: 104-idio-16: Make irq_chip immutable
Date:   Fri,  2 Sep 2022 13:45:25 -0400
Message-Id: <1a97e3f21f695f238fad9366e5976694b41a5da0.1662140119.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1662140119.git.william.gray@linaro.org>
References: <cover.1662140119.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel warns about mutable irq_chips:

    "not an immutable chip, please consider fixing!"

Make the struct irq_chip const, flag it as IRQCHIP_IMMUTABLE, add the
new helper functions, and call the appropriate gpiolib functions.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-104-idio-16.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-104-idio-16.c b/drivers/gpio/gpio-104-idio-16.c
index 65a5f581d981..4756e583f223 100644
--- a/drivers/gpio/gpio-104-idio-16.c
+++ b/drivers/gpio/gpio-104-idio-16.c
@@ -174,10 +174,11 @@ static void idio_16_irq_mask(struct irq_data *data)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-	const unsigned long mask = BIT(irqd_to_hwirq(data));
+	const unsigned long offset = irqd_to_hwirq(data);
 	unsigned long flags;
 
-	idio16gpio->irq_mask &= ~mask;
+	idio16gpio->irq_mask &= ~BIT(offset);
+	gpiochip_disable_irq(chip, offset);
 
 	if (!idio16gpio->irq_mask) {
 		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
@@ -192,11 +193,12 @@ static void idio_16_irq_unmask(struct irq_data *data)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(data);
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-	const unsigned long mask = BIT(irqd_to_hwirq(data));
+	const unsigned long offset = irqd_to_hwirq(data);
 	const unsigned long prev_irq_mask = idio16gpio->irq_mask;
 	unsigned long flags;
 
-	idio16gpio->irq_mask |= mask;
+	gpiochip_enable_irq(chip, offset);
+	idio16gpio->irq_mask |= BIT(offset);
 
 	if (!prev_irq_mask) {
 		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
@@ -217,12 +219,14 @@ static int idio_16_irq_set_type(struct irq_data *data, unsigned int flow_type)
 	return 0;
 }
 
-static struct irq_chip idio_16_irqchip = {
+static const struct irq_chip idio_16_irqchip = {
 	.name = "104-idio-16",
 	.irq_ack = idio_16_irq_ack,
 	.irq_mask = idio_16_irq_mask,
 	.irq_unmask = idio_16_irq_unmask,
-	.irq_set_type = idio_16_irq_set_type
+	.irq_set_type = idio_16_irq_set_type,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static irqreturn_t idio_16_irq_handler(int irq, void *dev_id)
@@ -299,7 +303,7 @@ static int idio_16_probe(struct device *dev, unsigned int id)
 	idio16gpio->out_state = 0xFFFF;
 
 	girq = &idio16gpio->chip.irq;
-	girq->chip = &idio_16_irqchip;
+	gpio_irq_chip_set_chip(girq, &idio_16_irqchip);
 	/* This will let us handle the parent IRQ in the driver */
 	girq->parent_handler = NULL;
 	girq->num_parents = 0;
-- 
2.37.2

