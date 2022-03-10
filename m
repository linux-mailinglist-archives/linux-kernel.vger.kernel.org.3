Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B634D3EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbiCJBRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239108AbiCJBRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:17:43 -0500
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D971C125535;
        Wed,  9 Mar 2022 17:16:43 -0800 (PST)
Received: from 1nS7Pz-0008LN-Tz by out3a.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nS7Q1-0008PP-Vx; Wed, 09 Mar 2022 17:16:41 -0800
Received: by emcmailer; Wed, 09 Mar 2022 17:16:41 -0800
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3a.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1nS7Pz-0008LN-Tz; Wed, 09 Mar 2022 17:16:39 -0800
Received: from tsdebian.Massive (unknown [75.164.75.221])
        by mail.embeddedts.com (Postfix) with ESMTPSA id 85AD91AAE;
        Wed,  9 Mar 2022 18:16:38 -0700 (MST)
From:   Kris Bahnsen <kris@embeddedTS.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Featherston <mark@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>
Subject: [PATCH v3 1/2] gpio: ts4900: Do not set DAT and OE together
Date:   Wed,  9 Mar 2022 17:16:16 -0800
Message-Id: <20220310011617.29660-2-kris@embeddedTS.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20220310011617.29660-1-kris@embeddedTS.com>
References: <20220310011617.29660-1-kris@embeddedTS.com>
X-Outbound-IP: 66.210.251.27
X-Env-From: kris@embeddedTS.com
X-Proto: esmtps
X-Revdns: wsip-66-210-251-27.ph.ph.cox.net
X-HELO: mail.embeddedts.com
X-TLS:  TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256
X-Authenticated_ID: 
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (b)
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=References:In-Reply-To:Message-Id:Date:To:From; bh=8wyGVFJPNB2jCzDjKR0LThAefQWN+7Tnxe9+aJ7ZSmo=;b=WEq3V4kSpT68o8LuPVu+207SbGCgplAgG08S5ZPi1Kt9mSJP0jf75Ekp9iSt34YSw0EUUOOhceOsex6QT9844xU+rOpmdC148YhcDvasdY71De6ZcHxYDAEjWKFr+HLo5mX99z7XQvkz6vGmo3BdaRhlsHQQ4cQLfBZKrhpkfG/SoC3tUfBBgbIXRyJ8S6Te/8znnnK6/lfnBK9OeLBBZ1aqsjG2QedtL70MhqfPxEt2Wv1CS3RJXghzesNbNibZNGZztW7TCKTVIUscUm6lFhp3RU/XVAT5dMieGa36ehi6BZ0ozevTYQ1xWiwxZe1lQuZtwlE+byONkmVaCb7Now==;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Featherston <mark@embeddedTS.com>

This works around an issue with the hardware where both OE and
DAT are exposed in the same register. If both are updated
simultaneously, the harware makes no guarantees that OE or DAT
will actually change in any given order and may result in a
glitch of a few ns on a GPIO pin when changing direction and value
in a single write.

Setting direction to input now only affects OE bit. Setting
direction to output updates DAT first, then OE.

Fixes: 9c6686322d74 ("gpio: add Technologic I2C-FPGA gpio support")

Signed-off-by: Mark Featherston <mark@embeddedTS.com>
Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
---
 drivers/gpio/gpio-ts4900.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-ts4900.c b/drivers/gpio/gpio-ts4900.c
index d885032cf814..d918d2df4de2 100644
--- a/drivers/gpio/gpio-ts4900.c
+++ b/drivers/gpio/gpio-ts4900.c
@@ -1,7 +1,7 @@
 /*
  * Digital I/O driver for Technologic Systems I2C FPGA Core
  *
- * Copyright (C) 2015 Technologic Systems
+ * Copyright (C) 2015, 2018 Technologic Systems
  * Copyright (C) 2016 Savoir-Faire Linux
  *
  * This program is free software; you can redistribute it and/or
@@ -55,19 +55,33 @@ static int ts4900_gpio_direction_input(struct gpio_chip *chip,
 {
 	struct ts4900_gpio_priv *priv = gpiochip_get_data(chip);
 
-	/*
-	 * This will clear the output enable bit, the other bits are
-	 * dontcare when this is cleared
+	/* Only clear the OE bit here, requires a RMW. Prevents potential issue
+	 * with OE and data getting to the physical pin at different times.
 	 */
-	return regmap_write(priv->regmap, offset, 0);
+	return regmap_update_bits(priv->regmap, offset, TS4900_GPIO_OE, 0);
 }
 
 static int ts4900_gpio_direction_output(struct gpio_chip *chip,
 					unsigned int offset, int value)
 {
 	struct ts4900_gpio_priv *priv = gpiochip_get_data(chip);
+	unsigned int reg;
 	int ret;
 
+	/* If changing from an input to an output, we need to first set the
+	 * proper data bit to what is requested and then set OE bit. This
+	 * prevents a glitch that can occur on the IO line
+	 */
+	regmap_read(priv->regmap, offset, &reg);
+	if (!(reg & TS4900_GPIO_OE)) {
+		if (value)
+			reg = TS4900_GPIO_OUT;
+		else
+			reg &= ~TS4900_GPIO_OUT;
+
+		regmap_write(priv->regmap, offset, reg);
+	}
+
 	if (value)
 		ret = regmap_write(priv->regmap, offset, TS4900_GPIO_OE |
 							 TS4900_GPIO_OUT);
-- 
2.11.0

