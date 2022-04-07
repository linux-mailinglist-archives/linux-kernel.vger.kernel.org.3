Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB29F4F7C92
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244183AbiDGKUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 06:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244171AbiDGKUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:20:07 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06F912BF8F;
        Thu,  7 Apr 2022 03:18:07 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x33so2336495lfu.1;
        Thu, 07 Apr 2022 03:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8xc2esaPhQG5Y2aFcZ1m/q+wr6tTLexMzP50smIMSEc=;
        b=ai/odVpwgAtW6qLKqSqRkKEuWhfCVJY8/tta5lKx4zSHyelDU82UlUu9a7wGTfIUA8
         /tOXy4TFvNgWME3yKRJzBrPZ0wKLnQu+4hDLFMpGqgItAgCMJjO51Q0PSUpEJMR+5sAY
         m4bnNUdUwilMoEmCBQqpYRwt2bRRx3TSj4klN+w8env+iakbb39MCkHp/Kga1y40cUlc
         WGxtG/TPSvbNW+0MyINBgi0plDdH7FU2MTcORsDGrRQUmHMPyUaX9uu2TzmO8EwGmHc/
         G2tLTOKa4hS4+xRNoF9LuOHoLog36EQvOMxb28UKKvGKNw3HLMDMRCDTLj5lJi1sXMYj
         VSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xc2esaPhQG5Y2aFcZ1m/q+wr6tTLexMzP50smIMSEc=;
        b=odPjFTt8EI2kDsGqhKXLB5SVjJDfPhIRTkfLX79UmIfVL3Nebbbfopxyd+/9QT8PYB
         /vUBpVORwzwERJm1/BbfBsZze266dpZoYDuZl6G9iaSCBTlaOR+4WTL1mvQF1XjAxupO
         4ra+tm9x/K3ic1/cxDcQJQG0FHrghRUVblnPLDq/qwVCpOFyTcgTe8bERoRNyCUgNZIO
         uWOh7/TGvdRfP1Mo0Ucd0J0rzTOjUsFNrtXAIBqRSid3XBh6MmSZp7oshs/WLNz3QzRX
         2navgbTl2wE6CYgE16LHMS9Jg0A4JVdyBrvpEeNfIoSKdYFY5etz8g+B/LhIbLtzG7AO
         uuAw==
X-Gm-Message-State: AOAM532JLRUrS/MJUh7q21qso4fYAASoDIq1oCauqK2UXmU4xkt+fiKe
        lFQrB+NthWz5zTVot5lqtgjfHhj6m9s=
X-Google-Smtp-Source: ABdhPJzTvOYxu4sys0zV4dc0/hwV5plnZJG/vaaIf8HAAL7JknaiUwn8P+g3GegkiMsK8sjs+Hg89Q==
X-Received: by 2002:ac2:51ce:0:b0:44a:2b4f:82b1 with SMTP id u14-20020ac251ce000000b0044a2b4f82b1mr9221355lfm.349.1649326685582;
        Thu, 07 Apr 2022 03:18:05 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id d2-20020a194f02000000b0044a2b77cd8dsm2121656lfb.105.2022.04.07.03.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 03:18:05 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] leds: ktd2692: Make aux-gpios optional
Date:   Thu,  7 Apr 2022 13:10:06 +0300
Message-Id: <20220407101034.13122-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407101034.13122-1-markuss.broks@gmail.com>
References: <20220407101034.13122-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the AUX pin optional, since it isn't a core part of functionality,
and the device is designed to be operational with only one CTRL pin.

Also pick up maintainership for the LED driver and the yaml bindings.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 MAINTAINERS                       |  6 ++++++
 drivers/leds/flash/leds-ktd2692.c | 18 ++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2db49ea7ae55..8ef5667a1d98 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10479,6 +10479,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktd253.yaml
 F:	drivers/video/backlight/ktd253-backlight.c
 
+KTD2692 FLASH LED DRIVER
+M:	Markuss Broks <markuss.broks@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/leds/backlight/kinetic,ktd2692.yaml
+F:	drivers/leds/flash/leds-ktd2692.yaml
+
 KTEST
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	John Hawley <warthog9@eaglescrag.net>
diff --git a/drivers/leds/flash/leds-ktd2692.c b/drivers/leds/flash/leds-ktd2692.c
index f341da1503a4..f30c4b11c84b 100644
--- a/drivers/leds/flash/leds-ktd2692.c
+++ b/drivers/leds/flash/leds-ktd2692.c
@@ -163,7 +163,8 @@ static int ktd2692_led_brightness_set(struct led_classdev *led_cdev,
 
 	if (brightness == LED_OFF) {
 		led->mode = KTD2692_MODE_DISABLE;
-		gpiod_direction_output(led->aux_gpio, KTD2692_LOW);
+		if (led->aux_gpio)
+			gpiod_direction_output(led->aux_gpio, KTD2692_LOW);
 	} else {
 		ktd2692_expresswire_write(led, brightness |
 					KTD2692_REG_MOVIE_CURRENT_BASE);
@@ -191,10 +192,12 @@ static int ktd2692_led_flash_strobe_set(struct led_classdev_flash *fled_cdev,
 				| KTD2692_REG_FLASH_TIMEOUT_BASE);
 
 		led->mode = KTD2692_MODE_FLASH;
-		gpiod_direction_output(led->aux_gpio, KTD2692_HIGH);
+		if (led->aux_gpio)
+			gpiod_direction_output(led->aux_gpio, KTD2692_HIGH);
 	} else {
 		led->mode = KTD2692_MODE_DISABLE;
-		gpiod_direction_output(led->aux_gpio, KTD2692_LOW);
+		if (led->aux_gpio)
+			gpiod_direction_output(led->aux_gpio, KTD2692_LOW);
 	}
 
 	ktd2692_expresswire_write(led, led->mode | KTD2692_REG_MODE_BASE);
@@ -248,7 +251,8 @@ static void ktd2692_setup(struct ktd2692_context *led)
 {
 	led->mode = KTD2692_MODE_DISABLE;
 	ktd2692_expresswire_reset(led);
-	gpiod_direction_output(led->aux_gpio, KTD2692_LOW);
+	if (led->aux_gpio)
+		gpiod_direction_output(led->aux_gpio, KTD2692_LOW);
 
 	ktd2692_expresswire_write(led, (KTD2692_MM_MIN_CURR_THRESHOLD_SCALE - 1)
 				 | KTD2692_REG_MM_MIN_CURR_THRESHOLD_BASE);
@@ -286,10 +290,8 @@ static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
 
 	led->aux_gpio = devm_gpiod_get(dev, "aux", GPIOD_ASIS);
 	ret = PTR_ERR_OR_ZERO(led->aux_gpio);
-	if (ret) {
-		dev_err(dev, "cannot get aux-gpios %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		dev_info(dev, "aux-gpios not available, flash mode current might be reduced\n");
 
 	led->regulator = devm_regulator_get(dev, "vin");
 	if (IS_ERR(led->regulator))
-- 
2.35.1

