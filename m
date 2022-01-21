Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D12349632E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379359AbiAUQyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378945AbiAUQy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:54:29 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9F3C06173B;
        Fri, 21 Jan 2022 08:54:28 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id a10-20020a9d260a000000b005991bd6ae3eso12458581otb.11;
        Fri, 21 Jan 2022 08:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Je4Vg4olpeQt3YYgiuDinqh8u3SDDMhhHec3zR+vbpw=;
        b=eyCdocg3/BwFXfNB6Ra58X0zGei6GdzjOGAdVx7J3EZnQTgNGumoi5fmYK2Za3iy/V
         jN4KcidqxXKzrCkljB4x44HUo0uALqPUK43TPmRzhAvbqRJMFkRqo6GK8HHgOmkpkYMb
         VH5XLEj6enzXbw4Y5gnI7kzbDKx7XjMl5ewZlxJ9g7HHghQjUU1V24v+fC1CwCfIzFWn
         JrgLaglsFFu6zmi604vr/azRkUrGkI+B1oTVYYKJki6GU/uzAgmPq6SNxHH12lnQSmDy
         kuNuIvUTd6OO79GVAqblQz1rJXzXKW6npRKdtuI63j3qmOr8EXqz8PDpQiksyusBI/L6
         m+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Je4Vg4olpeQt3YYgiuDinqh8u3SDDMhhHec3zR+vbpw=;
        b=GBjo9k+eK9gUAmpwzDlTlMIAUGW7/xZxJXLidH9GSBbbh/JyKlOys7PDhMo5ryyuK+
         RRbHmcEUR0SCUzEJU3t17XWc1oOq9tPG/W5Y7LgDilly4q+94+vWUTEBbYd98C30Vwu0
         /JZyPLBW5MgimB9Y10I12KkuBZEx5asvXVT9mECbu3UCISporkP/+GgkHZ6Pug6kIhiy
         2/JmCTlfT+jkQJzo8QnxAU1gVz913HOaIae4Hr0cU2MFomWwDe3SqTGa1WWkstCqTdBS
         vLqAMwlH88RH0zDDDgwOHWSWPvYWcUtVcKmFakzQRl7nckoFCyErvlnxGNKgHb7BMzFv
         GJWA==
X-Gm-Message-State: AOAM530VAR8UaLVIojQ5oT1qVwMm8Sp41wmU0qFxBYzCUrVF3isAQUv2
        oRKFajr+yXDdZOyw/g+L9IxKQzFnNkQ=
X-Google-Smtp-Source: ABdhPJy2nNfP2/sQ5pcqgIqsWk02rQQ3m1RbWO9oJ+ZEbEFN7V0EXWGwjzgsJulb5byjReHdhGwo3A==
X-Received: by 2002:a05:6830:40c6:: with SMTP id h6mr3263411otu.247.1642784068274;
        Fri, 21 Jan 2022 08:54:28 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:cf72:4317:3105:f6e5])
        by smtp.gmail.com with ESMTPSA id y8sm1089271oou.23.2022.01.21.08.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:54:27 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 05/31] input: keyboard: changing LED_* from enum led_brightness to actual value
Date:   Fri, 21 Jan 2022 13:54:10 -0300
Message-Id: <20220121165436.30956-6-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121165436.30956-1-sampaio.ime@gmail.com>
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum led_brightness, which contains the declaration of LED_OFF,
LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
max_brightness.
---
 drivers/input/keyboard/cap11xx.c      |  2 +-
 drivers/input/keyboard/qt2160.c       |  6 +++---
 drivers/input/keyboard/tm2-touchkey.c | 12 ++++++------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
index 7c85343cd32f..04c03157ef8a 100644
--- a/drivers/input/keyboard/cap11xx.c
+++ b/drivers/input/keyboard/cap11xx.c
@@ -290,7 +290,7 @@ static int cap11xx_init_leds(struct device *dev,
 		led->cdev.flags = 0;
 		led->cdev.brightness_set_blocking = cap11xx_led_set;
 		led->cdev.max_brightness = 1;
-		led->cdev.brightness = LED_OFF;
+		led->cdev.brightness = 0;
 
 		error = of_property_read_u32(child, "reg", &reg);
 		if (error != 0 || reg >= num_leds) {
diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 32d4a076eaa3..b80c2195dabb 100644
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -78,7 +78,7 @@ static int qt2160_led_set(struct led_classdev *cdev,
 	if (value != led->brightness) {
 		drive = qt2160_read(client, QT2160_CMD_DRIVE_X);
 		pwmen = qt2160_read(client, QT2160_CMD_PWMEN_X);
-		if (value != LED_OFF) {
+		if (value != 0) {
 			drive |= BIT(led->id);
 			pwmen |= BIT(led->id);
 
@@ -93,7 +93,7 @@ static int qt2160_led_set(struct led_classdev *cdev,
 		 * Changing this register will change the brightness
 		 * of every LED in the qt2160. It's a HW limitation.
 		 */
-		if (value != LED_OFF)
+		if (value != 0)
 			qt2160_write(client, QT2160_CMD_PWM_DUTY, value);
 
 		led->brightness = value;
@@ -269,7 +269,7 @@ static int qt2160_register_leds(struct qt2160_data *qt2160)
 		snprintf(led->name, sizeof(led->name), "qt2160:x%d", i);
 		led->cdev.name = led->name;
 		led->cdev.brightness_set_blocking = qt2160_led_set;
-		led->cdev.brightness = LED_OFF;
+		led->cdev.brightness = 0;
 		led->id = i;
 		led->qt2160 = qt2160;
 
diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index 632cd6c1c8d4..b28ebbc75d11 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -91,7 +91,7 @@ static int tm2_touchkey_led_brightness_set(struct led_classdev *led_dev,
 	u32 volt;
 	u8 data;
 
-	if (brightness == LED_OFF) {
+	if (brightness == 0) {
 		volt = TM2_TOUCHKEY_LED_VOLTAGE_MIN;
 		data = touchkey->variant->cmd_led_off;
 	} else {
@@ -173,9 +173,9 @@ static irqreturn_t tm2_touchkey_irq_handler(int irq, void *devid)
 	if (touchkey->variant->fixed_regulator &&
 				data & TM2_TOUCHKEY_BIT_PRESS_EV) {
 		/* touch turns backlight on, so make sure we're in sync */
-		if (touchkey->led_dev.brightness == LED_OFF)
+		if (touchkey->led_dev.brightness == 0)
 			tm2_touchkey_led_brightness_set(&touchkey->led_dev,
-							LED_OFF);
+							0);
 	}
 
 	return IRQ_HANDLED;
@@ -280,8 +280,8 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 
 	/* led device */
 	touchkey->led_dev.name = TM2_TOUCHKEY_DEV_NAME;
-	touchkey->led_dev.brightness = LED_ON;
-	touchkey->led_dev.max_brightness = LED_ON;
+	touchkey->led_dev.brightness = 1;
+	touchkey->led_dev.max_brightness = 1;
 	touchkey->led_dev.brightness_set_blocking =
 					tm2_touchkey_led_brightness_set;
 
@@ -293,7 +293,7 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 	}
 
 	if (touchkey->variant->fixed_regulator)
-		tm2_touchkey_led_brightness_set(&touchkey->led_dev, LED_ON);
+		tm2_touchkey_led_brightness_set(&touchkey->led_dev, 1);
 
 	return 0;
 }
-- 
2.34.1

