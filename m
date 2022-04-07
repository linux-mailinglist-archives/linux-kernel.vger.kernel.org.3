Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8824F7E6F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245028AbiDGLxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245008AbiDGLxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:53:45 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68ACA2364EB;
        Thu,  7 Apr 2022 04:51:45 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x33so2725175lfu.1;
        Thu, 07 Apr 2022 04:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kRv8uThwMjemCPH0U9dWg7Ga/t+oDd3aBEoB7wfTW1U=;
        b=e8tCwr77YvJqF7FoJIybsEy25RG/pfAVowZUzfc881Sk/yMJLDsR+7CzirdJFcwRtD
         Sp/Q3a30PzdphOy/3Ah+Re6Wzo+o13iItwUpjC+2prQW19JKNs9m+45co9ubbDqoZd++
         uWHIS9VrmDEne4XlYygrdv6Cul23hGgFwTW/isFdj8gVOCkCPTSRKfWIwVlAnuXrMqrL
         8DrnC8goGUqt8eUMoQNeBEc4ooGtg87e1rsWUATSkN0dWT/hv/mmIRT89sRWOV4r16VN
         ZD9sglGkr6VVHHZJc02RRuP6FSZBrE5nqmP7F2avG7LkCYhfIohMokF2Q5Uaqn7cR3pP
         u7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kRv8uThwMjemCPH0U9dWg7Ga/t+oDd3aBEoB7wfTW1U=;
        b=mI0Bi85mXdu6bwXLGKU5lO8afNLVo5D4OE99r7JT72ZVHWpBPGiKg8OZIha5OGjMo9
         moeu1K0iZ5nLXKjSREzCB4a5M/87juXVyG7CCLyjD+MxQNMtSgpo7Tjfq4KcrJW1BWz6
         2levvr1e3KFqqb5iyuKo6gvfHGF2nz38fLLSsVtZWz6JMcGG0ZXk6WpXbFdPwV8NDKQn
         k61MKvGOGBAUIN+kwHjERDjGXPmdxYeGdFzNLvnT7FXnQQOOTxALS2CSrI7UMQFOL7fF
         yoKyEnqOg+Gc909CXI2KXilUzYfswKYAVtt1eAUfdrYcBcQd5FyebGM1wsX7T+ankBXI
         JKLQ==
X-Gm-Message-State: AOAM533EWmVnNranfDrztelOpNSoTjr1Gd+ks79JvIhdT5o0LwvtOiCO
        jibnVsP5IHZ0CTJIxyikMr7bA2/tH1I=
X-Google-Smtp-Source: ABdhPJwsnQgFOt+/HsuI52G0JTO0s6m2NWSDkgYAkdvr/Nj3kQNfmE8EVNYcGrUXfftrPoCABhVNZQ==
X-Received: by 2002:a05:6512:e97:b0:464:f4dc:89f8 with SMTP id bi23-20020a0565120e9700b00464f4dc89f8mr1834802lfb.655.1649332303536;
        Thu, 07 Apr 2022 04:51:43 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id i16-20020a198c50000000b0044a2580a2d3sm2143666lfj.156.2022.04.07.04.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 04:51:43 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 2/2] leds: ktd2692: Make aux-gpios optional
Date:   Thu,  7 Apr 2022 14:51:25 +0300
Message-Id: <20220407115126.69293-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407115126.69293-1-markuss.broks@gmail.com>
References: <20220407115126.69293-1-markuss.broks@gmail.com>
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
 drivers/leds/flash/leds-ktd2692.c | 16 ++++++++++------
 2 files changed, 16 insertions(+), 6 deletions(-)

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
index f341da1503a4..bfbe1d5f7b8e 100644
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
@@ -287,8 +291,8 @@ static int ktd2692_parse_dt(struct ktd2692_context *led, struct device *dev,
 	led->aux_gpio = devm_gpiod_get(dev, "aux", GPIOD_ASIS);
 	ret = PTR_ERR_OR_ZERO(led->aux_gpio);
 	if (ret) {
-		dev_err(dev, "cannot get aux-gpios %d\n", ret);
-		return ret;
+		dev_info(dev, "aux-gpios not available, flash mode current might be reduced\n");
+		led->aux_gpio = NULL;
 	}
 
 	led->regulator = devm_regulator_get(dev, "vin");
-- 
2.35.1

