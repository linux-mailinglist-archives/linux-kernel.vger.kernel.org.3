Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57664F7D67
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244635AbiDGLAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244629AbiDGLA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:00:29 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0494EEBB86;
        Thu,  7 Apr 2022 03:58:29 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a30so6894716ljq.13;
        Thu, 07 Apr 2022 03:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8xc2esaPhQG5Y2aFcZ1m/q+wr6tTLexMzP50smIMSEc=;
        b=m7J0+Lynb7e5pv6iC0d8QaX3vw/bSRSsZO09eKEW+FuIlxpvM1bPRtwqzVyin653+o
         jmFA+gShHwh+DQdqI/bMEd0b6+j+JvP0Wk9YkF3pm1DbfClrKIt2lig/7DeiQ1E9FTSH
         z4voelYQyDggxleD14TmU5GOLnyuaHMHY1T7bG1kN1Bvw7uyPHi2eVh3H2Rxk7K0i23e
         Z10o2nUrL3CSsmj3QUfyqmTPwW8JxagI9cFIk/PynVxwhOTj1wzplkVK5+5WKdRKXJww
         pPKsifWYJGXYMfWGwm3WC2ksZlV1Na35RGPpRNQiU31kagFfA0i9uYELDVyAtRH+WWcD
         PE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xc2esaPhQG5Y2aFcZ1m/q+wr6tTLexMzP50smIMSEc=;
        b=7fLYQaT/a6VHX4ZU1T6dEF1LRnJcgO6sP4DZPvZPnSGGQSnM8kazFQ2fmYc/b54nXL
         AXXiFVu1lqHRsSZw6slpkZ2Lg4oPd0rVFsTa0FICgc9R13O2UyaLYvgGjvgSBvBhLftP
         Ia6FyRH4SHf+rucOcxqFsNykt/Co4uGdJWe1UKXQmMl+s7dYpyNPX547OJBs8jXG1SM3
         33JGDKGMA3ifiR6xmupThkhE5svAB5J6gDa2KvAT3dDodcYOAtRYJUOvRpLIwOZ16Umi
         powhFSx5wTEauA5apj9PXKzr3NJ502Lj8W8TYCX2ch9HluQgIx4Z5iSqv7QJxVsVwAWc
         RCSA==
X-Gm-Message-State: AOAM530UTqjUSpKzJfvY5QxFlnN9/L6ckyZcU5lqinEH1XkkFvqCt8AX
        I9dbzLJItqIvEM7bhXGacexvKVUCNg8=
X-Google-Smtp-Source: ABdhPJwNLSMx9pjrABFBtd1mNIVGIcHUbbxEvRla5gWZ1v8ZNvwO9gqJaQ5UGMyPwIpQxV1UICyIjQ==
X-Received: by 2002:a2e:7c17:0:b0:24a:fee5:e42b with SMTP id x23-20020a2e7c17000000b0024afee5e42bmr8235224ljc.496.1649329107137;
        Thu, 07 Apr 2022 03:58:27 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id k18-20020ac24572000000b0044ae25d47d7sm1990273lfm.143.2022.04.07.03.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 03:58:26 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] leds: ktd2692: Make aux-gpios optional
Date:   Thu,  7 Apr 2022 13:58:09 +0300
Message-Id: <20220407105810.20399-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407105810.20399-1-markuss.broks@gmail.com>
References: <20220407105810.20399-1-markuss.broks@gmail.com>
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

