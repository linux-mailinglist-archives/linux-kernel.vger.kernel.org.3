Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726545ABA4E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 23:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiIBVkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 17:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbiIBVka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 17:40:30 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D18B37197
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 14:40:20 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id jy14so2391475qvb.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 14:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=+5W3kIyuKIp9hTxfCgunIN6PQveCEir/569gHMdhyOc=;
        b=j80KkNfzDLQPPP6jv+cQ+Yydwhz8HRQENT41Pf6dYvGrapRyr4+S4vD35MwkFID5UD
         knJCoiJd9cGE7jfrOB86i/HLLX805ds1QfLcCsgRubE/fwP9gaCvURLDAfWPlwUO0yFn
         RY5OP2vnCUuRYV1CYFrduWMtWprZ+XHFybLpXrOLT/7qLxlZ/LnL6lmUvwJvGo2OlWeU
         vjtog/5KK2zQglRC/YeLVMJOietAySDpFQ48GN+jnrxPAJRnSIu2VXmM4a2IGExpBlrr
         X2iCmLV2q1mywLlrNiQCtQ6+zKk+fi95ExuEfQ3aF8Duvpp27azmsq6TIAEfwmZbdzmO
         f5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+5W3kIyuKIp9hTxfCgunIN6PQveCEir/569gHMdhyOc=;
        b=OVL1GyiHQlPxRHW5nFkXxhaVbVr7MfDfzW4XcOt09e/TwYeD+RAaxsFLu0XsQVETRw
         sX1uSgnoqVsMIEPJHW6wHRtrjXU0NbMaHD+MtKl755sZXf7kHeiYQgDUpRpxSMre5Cd1
         rq8/rXwWR5+gddO9BgMuuZBYTZ0gLdG2KlCdZtEOwih+7wasL2W3V430wZF00LlNPJMg
         3iUyBTPKJr5nqIA3IYpT9YghZr6wqn0MOpLrXV348J4zkYoIBrMF4oL76r5TGofwt8II
         lWfFeSBoY+xwleIV34jcNMG5o/1I7nodXX/2g6wmXOua8IhAPgoWr3XCE2G8TkeO8lrV
         jF6g==
X-Gm-Message-State: ACgBeo38HqNc51FosQuZr0fo3cjvXDLaqz6CHRAa5glogejPwG80umOW
        NG9ioiAc5vZ6AudNPBxL8+iAAHeDLeR07g==
X-Google-Smtp-Source: AA6agR4TFJACeWR/WS95zWZP4ea+baOtunwHv3hkiI+TUYWmdBYAuBl3hVo13YauYO8E83rcId6E6Q==
X-Received: by 2002:a05:6214:20a2:b0:476:9071:2e60 with SMTP id 2-20020a05621420a200b0047690712e60mr30255860qvd.110.1662154819521;
        Fri, 02 Sep 2022 14:40:19 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id 15-20020ac84e8f000000b0031f0b43629dsm1819533qtp.23.2022.09.02.14.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 14:40:19 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     brgl@bgdev.pl, linus.walleij@linaro.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 2/4] gpio: 104-idi-48: Make irq_chip immutable
Date:   Fri,  2 Sep 2022 13:45:24 -0400
Message-Id: <ff27742d2b425968194f77a8b98491661536fa8c.1662140119.git.william.gray@linaro.org>
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
 drivers/gpio/gpio-104-idi-48.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index 40be76efeed7..3286b914a2cf 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -113,6 +113,7 @@ static void idi_48_irq_mask(struct irq_data *data)
 	spin_lock_irqsave(&idi48gpio->lock, flags);
 
 	idi48gpio->irq_mask[boundary] &= ~mask;
+	gpiochip_disable_irq(chip, offset);
 
 	/* Exit early if there are still input lines with IRQ unmasked */
 	if (idi48gpio->irq_mask[boundary])
@@ -140,6 +141,7 @@ static void idi_48_irq_unmask(struct irq_data *data)
 
 	prev_irq_mask = idi48gpio->irq_mask[boundary];
 
+	gpiochip_enable_irq(chip, offset);
 	idi48gpio->irq_mask[boundary] |= mask;
 
 	/* Exit early if IRQ was already unmasked for this boundary */
@@ -164,12 +166,14 @@ static int idi_48_irq_set_type(struct irq_data *data, unsigned int flow_type)
 	return 0;
 }
 
-static struct irq_chip idi_48_irqchip = {
+static const struct irq_chip idi_48_irqchip = {
 	.name = "104-idi-48",
 	.irq_ack = idi_48_irq_ack,
 	.irq_mask = idi_48_irq_mask,
 	.irq_unmask = idi_48_irq_unmask,
-	.irq_set_type = idi_48_irq_set_type
+	.irq_set_type = idi_48_irq_set_type,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
 };
 
 static irqreturn_t idi_48_irq_handler(int irq, void *dev_id)
@@ -267,7 +271,7 @@ static int idi_48_probe(struct device *dev, unsigned int id)
 	idi48gpio->chip.get_multiple = idi_48_gpio_get_multiple;
 
 	girq = &idi48gpio->chip.irq;
-	girq->chip = &idi_48_irqchip;
+	gpio_irq_chip_set_chip(girq, &idi_48_irqchip);
 	/* This will let us handle the parent IRQ in the driver */
 	girq->parent_handler = NULL;
 	girq->num_parents = 0;
-- 
2.37.2

