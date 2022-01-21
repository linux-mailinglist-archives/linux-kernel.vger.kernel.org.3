Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C502496330
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379398AbiAUQys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379036AbiAUQyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:54:31 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D01C06173D;
        Fri, 21 Jan 2022 08:54:31 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id q186so14347706oih.8;
        Fri, 21 Jan 2022 08:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5s5UbzjGtCWz5IFAAJ8W73hj4zFXrrDystMmQJgy/K0=;
        b=fSDTz17GP1ENZ9TNg++fhuNarE5aoMJy71DtoGonwd2QtSCqntLqDPoSo9iC4DLF2H
         4pbJ+SCNGlyzBVTN4L/32SyjESoCM+qQ6jaB9RVpb79aZJplW0zuj4TJHO0H6qL3RTFf
         1zwGf8QO4wXLwDO5HatBgBKCGjcZRkFjf5KXxcpcXuiIw4N5PoJQoXbL836v3ECgfluM
         30gNkB+pVZ1vRTU2FlYFRBH0jQl7QemGvOJzeKODlI9aPRnWlJSOJ+UYzaqgS3oznNSs
         uk75Wohu9H5pNRdEMgG/ZNY4nhu4S05fvlAKPlSRXjIg1ztqG3W+4RwISw2K8VV2fXNx
         lktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5s5UbzjGtCWz5IFAAJ8W73hj4zFXrrDystMmQJgy/K0=;
        b=EYV4HNs8k1CA6tdPm7MBgdKM2fkk9/VxF3nLvvlD68lGMjkgR12f0HZCihQEh73NbZ
         icRNfNPVoLJhQvaducXiX4JXKlV3hsgxjMFhRvxhsrY0/sQ8of1TtDYtyoZ+cARgu1Fp
         7nu2lfqj4gs6qvupCva3RMU0nVy7xPDrlHf2WYM83smIcGoPcmJtLmTEhN2ky+sxECV5
         ki60/sAgfgPlaztdp7A6edm02xF+z1AhVOelJEI3bPPI3fR0HojhGmBacW2iTTNDJ4nF
         zV6L9yXSE6WNZfTqHJosIGoLtpQm15c1sryAdWcn/y7uzIGPIZP8VmolimUBj6nfxedV
         I0TQ==
X-Gm-Message-State: AOAM531VRKKB9z9PjPUjh7xCeSugCj/tXhbS+BgWI7V2V19IusAj0fZS
        eiYDTjLVR1Tw4D3WkPe2FGk=
X-Google-Smtp-Source: ABdhPJxvBuBxMuXHNeqQqmpPiBGLgjWTEw0bKwOXqMg3pK9cWTM3CNpmQojh7ca/Kw7mYV+BxY9+ww==
X-Received: by 2002:a05:6808:1b07:: with SMTP id bx7mr1267018oib.38.1642784070933;
        Fri, 21 Jan 2022 08:54:30 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:cf72:4317:3105:f6e5])
        by smtp.gmail.com with ESMTPSA id y8sm1089271oou.23.2022.01.21.08.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:54:30 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Miloslav Trmac <mitr@volny.cz>
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 06/31] input: misc: changing LED_* from enum led_brightness to actual value
Date:   Fri, 21 Jan 2022 13:54:11 -0300
Message-Id: <20220121165436.30956-7-sampaio.ime@gmail.com>
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
 drivers/input/misc/apanel.c       | 4 ++--
 drivers/input/misc/ims-pcu.c      | 2 +-
 drivers/input/misc/wistron_btns.c | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/apanel.c b/drivers/input/misc/apanel.c
index 7276657ad7ca..3b7e2f032f33 100644
--- a/drivers/input/misc/apanel.c
+++ b/drivers/input/misc/apanel.c
@@ -115,7 +115,7 @@ static int mail_led_set(struct led_classdev *led,
 			 enum led_brightness value)
 {
 	struct apanel *ap = container_of(led, struct apanel, mail_led);
-	u16 led_bits = value != LED_OFF ? 0x8000 : 0x0000;
+	u16 led_bits = value != 0 ? 0x8000 : 0x0000;
 
 	return i2c_smbus_write_word_data(ap->client, 0x10, led_bits);
 }
@@ -189,7 +189,7 @@ static void apanel_shutdown(struct i2c_client *client)
 	struct apanel *ap = i2c_get_clientdata(client);
 
 	if (device_chip[APANEL_DEV_LED] != CHIP_NONE)
-		led_set_brightness(&ap->mail_led, LED_OFF);
+		led_set_brightness(&ap->mail_led, 0);
 }
 
 static const struct i2c_device_id apanel_id[] = {
diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 6f38aa23a1ff..9665f371837d 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -986,7 +986,7 @@ ims_pcu_backlight_get_brightness(struct led_classdev *cdev)
 			 "Failed to get current brightness, error: %d\n",
 			 error);
 		/* Assume the LED is OFF */
-		brightness = LED_OFF;
+		brightness = 0;
 	} else {
 		brightness =
 			get_unaligned_le16(&pcu->cmd_buf[IMS_PCU_DATA_OFFSET]);
diff --git a/drivers/input/misc/wistron_btns.c b/drivers/input/misc/wistron_btns.c
index 80dfd72a02d3..cd290722a389 100644
--- a/drivers/input/misc/wistron_btns.c
+++ b/drivers/input/misc/wistron_btns.c
@@ -1039,14 +1039,14 @@ static bool bluetooth_enabled;
 static void wistron_mail_led_set(struct led_classdev *led_cdev,
 				enum led_brightness value)
 {
-	bios_set_state(MAIL_LED, (value != LED_OFF) ? 1 : 0);
+	bios_set_state(MAIL_LED, (value != 0) ? 1 : 0);
 }
 
 /* same as setting up wifi card, but for laptops on which the led is managed */
 static void wistron_wifi_led_set(struct led_classdev *led_cdev,
 				enum led_brightness value)
 {
-	bios_set_state(WIFI, (value != LED_OFF) ? 1 : 0);
+	bios_set_state(WIFI, (value != 0) ? 1 : 0);
 }
 
 static struct led_classdev wistron_mail_led = {
@@ -1064,7 +1064,7 @@ static void wistron_led_init(struct device *parent)
 	if (leds_present & FE_WIFI_LED) {
 		u16 wifi = bios_get_default_setting(WIFI);
 		if (wifi & 1) {
-			wistron_wifi_led.brightness = (wifi & 2) ? LED_FULL : LED_OFF;
+			wistron_wifi_led.brightness = (wifi & 2) ? LED_FULL : 0;
 			if (led_classdev_register(parent, &wistron_wifi_led))
 				leds_present &= ~FE_WIFI_LED;
 			else
@@ -1076,7 +1076,7 @@ static void wistron_led_init(struct device *parent)
 
 	if (leds_present & FE_MAIL_LED) {
 		/* bios_get_default_setting(MAIL) always retuns 0, so just turn the led off */
-		wistron_mail_led.brightness = LED_OFF;
+		wistron_mail_led.brightness = 0;
 		if (led_classdev_register(parent, &wistron_mail_led))
 			leds_present &= ~FE_MAIL_LED;
 		else
-- 
2.34.1

