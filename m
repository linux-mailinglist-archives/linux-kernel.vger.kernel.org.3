Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E60496328
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379267AbiAUQy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379008AbiAUQyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:54:21 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0622EC06173D;
        Fri, 21 Jan 2022 08:54:21 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id t9so14290844oie.12;
        Fri, 21 Jan 2022 08:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W6q2GvKgFmLMSEA3uVGLoy2Js4lfhFob5eKXqXL9wS0=;
        b=V80sEKCJ7CvnStxN8YoKYOwNYeczaLRhIjom+agXBX2hAYX0UqJNjEiP2Al+h+Mjgw
         oPX5Zlj1ftCCLNXZ2Qqqi7Zp6Y7oYFQBuGldLvYmnZ6yZSQGN16TAYAs2vv0rZc9H9mr
         g/S9b1+gABjVgoN2Q7+n3ISkE8tvMSYNRQgaC1hsgWsfG3q122/BjXtfIx+RxqEDpmup
         fiOZFqsGkp1ZgD9UNnuaiAMSjhDsTHmGmO26mVqEY18jOTui9yMgobi45DcusBteF2p+
         7QPnogKz4cAQrRqJbj0KElKi6ujDsNiJgHYNClWGVLgkkvO3GfVdyRZ0hrcfhvHqw0op
         E2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W6q2GvKgFmLMSEA3uVGLoy2Js4lfhFob5eKXqXL9wS0=;
        b=2F36GXUspEeoUtuQ5Quj1sWlNPlegPM1IUtShh+313OviZuyWy9yen0yIxzf1r96CN
         967CcF9Jtl1DKRcZBfT7iVAYY9ogo3PIUZFhV2PFMaBegnSJbAtkMxCV9BqUJ2PD3atf
         x5+p38/+2a6qBYUp/7MqlZvKR9GEinogaixJ+e0B9toQHThR5ZX7w5y+5TmYM71uI6uL
         MZaQmW8x3BzOWdwWVREtKAR0sBcVkzo7CCgvucOF2yRwoYAJQPA0tivKocjzff1icwFS
         kIs7wWlBtKksCtIKvsghQCCI305XdCLByK50455wn2Eyq9ImjYmTVCD8ezBRCgrnmtl2
         FCow==
X-Gm-Message-State: AOAM533Nduok8J4fveu1J52ixaELtlY6T2gpPABQ4UViPJ72qqBUHUIv
        TqSC0BMR/ujKcwPUp4LjNAc=
X-Google-Smtp-Source: ABdhPJxfuo+LWu20AiZhd5QEX3IL1Gxj5Jtadphle0HxWIMb8yHSIZs3cLopupLv0yVDm7K3ObMPjA==
X-Received: by 2002:a54:4191:: with SMTP id 17mr1222572oiy.39.1642784060271;
        Fri, 21 Jan 2022 08:54:20 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:cf72:4317:3105:f6e5])
        by smtp.gmail.com with ESMTPSA id y8sm1089271oou.23.2022.01.21.08.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:54:20 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons@linux-vserver.org>,
        Roderick Colenbrander <roderick.colenbrander@sony.com>,
        David Rheinsberg <david.rheinsberg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 02/31] hid: changing LED_* from enum led_brightness to actual value
Date:   Fri, 21 Jan 2022 13:54:07 -0300
Message-Id: <20220121165436.30956-3-sampaio.ime@gmail.com>
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
 drivers/hid/hid-bigbenff.c        | 10 +++++-----
 drivers/hid/hid-elan.c            |  2 +-
 drivers/hid/hid-lenovo.c          |  2 +-
 drivers/hid/hid-lg4ff.c           | 10 +++++-----
 drivers/hid/hid-picolcd_leds.c    |  6 +++---
 drivers/hid/hid-playstation.c     |  2 +-
 drivers/hid/hid-sony.c            |  4 ++--
 drivers/hid/hid-steelseries.c     | 14 +++++++-------
 drivers/hid/hid-u2fzero.c         |  4 ++--
 drivers/hid/hid-wiimote-modules.c |  4 ++--
 drivers/hid/wacom_sys.c           | 16 ++++++++--------
 drivers/hid/wacom_wac.c           |  2 +-
 12 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/hid/hid-bigbenff.c b/drivers/hid/hid-bigbenff.c
index 74ad8bf98bfd..3882b514f581 100644
--- a/drivers/hid/hid-bigbenff.c
+++ b/drivers/hid/hid-bigbenff.c
@@ -267,7 +267,7 @@ static void bigben_set_led(struct led_classdev *led,
 
 	for (n = 0; n < NUM_LEDS; n++) {
 		if (led == bigben->leds[n]) {
-			if (value == LED_OFF) {
+			if (value == 0) {
 				work = (bigben->led_state & BIT(n));
 				bigben->led_state &= ~BIT(n);
 			} else {
@@ -293,15 +293,15 @@ static enum led_brightness bigben_get_led(struct led_classdev *led)
 
 	if (!bigben) {
 		hid_err(hid, "no device data\n");
-		return LED_OFF;
+		return 0;
 	}
 
 	for (n = 0; n < NUM_LEDS; n++) {
 		if (led == bigben->leds[n])
-			return (bigben->led_state & BIT(n)) ? LED_ON : LED_OFF;
+			return (bigben->led_state & BIT(n)) ? 1 : 0;
 	}
 
-	return LED_OFF;
+	return 0;
 }
 
 static void bigben_remove(struct hid_device *hid)
@@ -375,7 +375,7 @@ static int bigben_probe(struct hid_device *hid,
 			dev_name(&hid->dev), n + 1
 		);
 		led->name = name;
-		led->brightness = (n == 0) ? LED_ON : LED_OFF;
+		led->brightness = (n == 0) ? 1 : 0;
 		led->max_brightness = 1;
 		led->brightness_get = bigben_get_led;
 		led->brightness_set = bigben_set_led;
diff --git a/drivers/hid/hid-elan.c b/drivers/hid/hid-elan.c
index 3091355d48df..44c20b60ba3e 100644
--- a/drivers/hid/hid-elan.c
+++ b/drivers/hid/hid-elan.c
@@ -453,7 +453,7 @@ static int elan_init_mute_led(struct hid_device *hdev)
 	mute_led->name = "elan:red:mute";
 	mute_led->default_trigger = "audio-mute";
 	mute_led->brightness_set_blocking = elan_mute_led_set_brigtness;
-	mute_led->max_brightness = LED_ON;
+	mute_led->max_brightness = 1;
 	mute_led->flags = LED_HW_PLUGGABLE;
 	mute_led->dev = &hdev->dev;
 
diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 93b1f935e526..b65d3a5175d5 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -842,7 +842,7 @@ static int lenovo_led_brightness_set(struct led_classdev *led_cdev,
 	if (led_cdev == &data_pointer->led_micmute)
 		led_nr = 1;
 
-	if (value == LED_OFF)
+	if (value == 0)
 		data_pointer->led_state &= ~(1 << led_nr);
 	else
 		data_pointer->led_state |= 1 << led_nr;
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 5e6a0cef2a06..6e65f92e6aec 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -1136,10 +1136,10 @@ static void lg4ff_led_set_brightness(struct led_classdev *led_cdev,
 		if (led_cdev != entry->wdata.led[i])
 			continue;
 		state = (entry->wdata.led_state >> i) & 1;
-		if (value == LED_OFF && state) {
+		if (value == 0 && state) {
 			entry->wdata.led_state &= ~(1 << i);
 			lg4ff_set_leds(hid, entry->wdata.led_state);
-		} else if (value != LED_OFF && !state) {
+		} else if (value != 0 && !state) {
 			entry->wdata.led_state |= 1 << i;
 			lg4ff_set_leds(hid, entry->wdata.led_state);
 		}
@@ -1157,14 +1157,14 @@ static enum led_brightness lg4ff_led_get_brightness(struct led_classdev *led_cde
 
 	if (!drv_data) {
 		hid_err(hid, "Device data not found.");
-		return LED_OFF;
+		return 0;
 	}
 
 	entry = drv_data->device_props;
 
 	if (!entry) {
 		hid_err(hid, "Device properties not found.");
-		return LED_OFF;
+		return 0;
 	}
 
 	for (i = 0; i < 5; i++)
@@ -1173,7 +1173,7 @@ static enum led_brightness lg4ff_led_get_brightness(struct led_classdev *led_cde
 			break;
 		}
 
-	return value ? LED_FULL : LED_OFF;
+	return value ? 255 : 0;
 }
 #endif
 
diff --git a/drivers/hid/hid-picolcd_leds.c b/drivers/hid/hid-picolcd_leds.c
index 6b505a753511..b000ee63b1c9 100644
--- a/drivers/hid/hid-picolcd_leds.c
+++ b/drivers/hid/hid-picolcd_leds.c
@@ -64,10 +64,10 @@ static void picolcd_led_set_brightness(struct led_classdev *led_cdev,
 		if (led_cdev != data->led[i])
 			continue;
 		state = (data->led_state >> i) & 1;
-		if (value == LED_OFF && state) {
+		if (value == 0 && state) {
 			data->led_state &= ~(1 << i);
 			picolcd_leds_set(data);
-		} else if (value != LED_OFF && !state) {
+		} else if (value != 0 && !state) {
 			data->led_state |= 1 << i;
 			picolcd_leds_set(data);
 		}
@@ -90,7 +90,7 @@ static enum led_brightness picolcd_led_get_brightness(struct led_classdev *led_c
 			value = (data->led_state >> i) & 1;
 			break;
 		}
-	return value ? LED_FULL : LED_OFF;
+	return value ? 255 : 0;
 }
 
 int picolcd_init_leds(struct picolcd_data *data, struct hid_report *report)
diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index b1b5721b5d8f..95ed22a533ec 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -873,7 +873,7 @@ static int dualsense_player_led_set_brightness(struct led_classdev *led, enum le
 	spin_lock_irqsave(&ds->base.lock, flags);
 
 	led_index = led - ds->player_leds;
-	if (value == LED_OFF)
+	if (value == 0)
 		ds->player_leds_state &= ~BIT(led_index);
 	else
 		ds->player_leds_state |= BIT(led_index);
diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 60ec2b29d54d..f4198cd8b94d 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -2048,7 +2048,7 @@ static enum led_brightness sony_led_get_brightness(struct led_classdev *led)
 	drv_data = hid_get_drvdata(hdev);
 	if (!drv_data) {
 		hid_err(hdev, "No device data\n");
-		return LED_OFF;
+		return 0;
 	}
 
 	for (n = 0; n < drv_data->led_count; n++) {
@@ -2056,7 +2056,7 @@ static enum led_brightness sony_led_get_brightness(struct led_classdev *led)
 			return drv_data->led_state[n];
 	}
 
-	return LED_OFF;
+	return 0;
 }
 
 static int sony_led_blink_set(struct led_classdev *led, unsigned long *delay_on,
diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index 37353c41cba7..b53587891b32 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -146,7 +146,7 @@ static void steelseries_srws1_led_all_set_brightness(struct led_classdev *led_cd
 		return;
 	}
 
-	if (value == LED_OFF)
+	if (value == 0)
 		drv_data->led_state = 0;
 	else
 		drv_data->led_state = (1 << (SRWS1_NUMBER_LEDS + 1)) - 1;
@@ -164,10 +164,10 @@ static enum led_brightness steelseries_srws1_led_all_get_brightness(struct led_c
 
 	if (!drv_data) {
 		hid_err(hid, "Device data not found.");
-		return LED_OFF;
+		return 0;
 	}
 
-	return (drv_data->led_state >> SRWS1_NUMBER_LEDS) ? LED_FULL : LED_OFF;
+	return (drv_data->led_state >> SRWS1_NUMBER_LEDS) ? 255 : 0;
 }
 
 static void steelseries_srws1_led_set_brightness(struct led_classdev *led_cdev,
@@ -188,10 +188,10 @@ static void steelseries_srws1_led_set_brightness(struct led_classdev *led_cdev,
 			continue;
 
 		state = (drv_data->led_state >> i) & 1;
-		if (value == LED_OFF && state) {
+		if (value == 0 && state) {
 			drv_data->led_state &= ~(1 << i);
 			steelseries_srws1_set_leds(hid, drv_data->led_state);
-		} else if (value != LED_OFF && !state) {
+		} else if (value != 0 && !state) {
 			drv_data->led_state |= 1 << i;
 			steelseries_srws1_set_leds(hid, drv_data->led_state);
 		}
@@ -210,7 +210,7 @@ static enum led_brightness steelseries_srws1_led_get_brightness(struct led_class
 
 	if (!drv_data) {
 		hid_err(hid, "Device data not found.");
-		return LED_OFF;
+		return 0;
 	}
 
 	for (i = 0; i < SRWS1_NUMBER_LEDS; i++)
@@ -219,7 +219,7 @@ static enum led_brightness steelseries_srws1_led_get_brightness(struct led_class
 			break;
 		}
 
-	return value ? LED_FULL : LED_OFF;
+	return value ? 255 : 0;
 }
 
 static int steelseries_srws1_probe(struct hid_device *hdev,
diff --git a/drivers/hid/hid-u2fzero.c b/drivers/hid/hid-u2fzero.c
index ad489caf53ad..1e73bd85b9b7 100644
--- a/drivers/hid/hid-u2fzero.c
+++ b/drivers/hid/hid-u2fzero.c
@@ -187,7 +187,7 @@ static int u2fzero_blink(struct led_classdev *ldev)
 static int u2fzero_brightness_set(struct led_classdev *ldev,
 				  enum led_brightness brightness)
 {
-	ldev->brightness = LED_OFF;
+	ldev->brightness = 0;
 	if (brightness)
 		return u2fzero_blink(ldev);
 	else
@@ -244,7 +244,7 @@ static int u2fzero_init_led(struct u2fzero_device *dev,
 		return -ENOMEM;
 
 	dev->ldev.name = dev->led_name;
-	dev->ldev.max_brightness = LED_ON;
+	dev->ldev.max_brightness = 1;
 	dev->ldev.flags = LED_HW_PLUGGABLE;
 	dev->ldev.brightness_set_blocking = u2fzero_brightness_set;
 
diff --git a/drivers/hid/hid-wiimote-modules.c b/drivers/hid/hid-wiimote-modules.c
index 213c58bf2495..9416f0e2a092 100644
--- a/drivers/hid/hid-wiimote-modules.c
+++ b/drivers/hid/hid-wiimote-modules.c
@@ -308,7 +308,7 @@ static enum led_brightness wiimod_led_get(struct led_classdev *led_dev)
 		}
 	}
 
-	return value ? LED_FULL : LED_OFF;
+	return value ? 255 : 0;
 }
 
 static void wiimod_led_set(struct led_classdev *led_dev,
@@ -325,7 +325,7 @@ static void wiimod_led_set(struct led_classdev *led_dev,
 			flag = WIIPROTO_FLAG_LED(i + 1);
 			spin_lock_irqsave(&wdata->state.lock, flags);
 			state = wdata->state.flags;
-			if (value == LED_OFF)
+			if (value == 0)
 				wiiproto_req_leds(wdata, state & ~flag);
 			else
 				wiiproto_req_leds(wdata, state | flag);
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 066c567dbaa2..9b0786f48867 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1304,13 +1304,13 @@ enum led_brightness wacom_leds_brightness_get(struct wacom_led *led)
 	struct wacom *wacom = led->wacom;
 
 	if (wacom->led.max_hlv)
-		return led->hlv * LED_FULL / wacom->led.max_hlv;
+		return led->hlv * 255 / wacom->led.max_hlv;
 
 	if (wacom->led.max_llv)
-		return led->llv * LED_FULL / wacom->led.max_llv;
+		return led->llv * 255 / wacom->led.max_llv;
 
 	/* device doesn't support brightness tuning */
-	return LED_FULL;
+	return 255;
 }
 
 static enum led_brightness __wacom_led_brightness_get(struct led_classdev *cdev)
@@ -1319,7 +1319,7 @@ static enum led_brightness __wacom_led_brightness_get(struct led_classdev *cdev)
 	struct wacom *wacom = led->wacom;
 
 	if (wacom->led.groups[led->group].select != led->id)
-		return LED_OFF;
+		return 0;
 
 	return wacom_leds_brightness_get(led);
 }
@@ -1333,14 +1333,14 @@ static int wacom_led_brightness_set(struct led_classdev *cdev,
 
 	mutex_lock(&wacom->lock);
 
-	if (!wacom->led.groups || (brightness == LED_OFF &&
+	if (!wacom->led.groups || (brightness == 0 &&
 	    wacom->led.groups[led->group].select != led->id)) {
 		error = 0;
 		goto out;
 	}
 
-	led->llv = wacom->led.llv = wacom->led.max_llv * brightness / LED_FULL;
-	led->hlv = wacom->led.hlv = wacom->led.max_hlv * brightness / LED_FULL;
+	led->llv = wacom->led.llv = wacom->led.max_llv * brightness / 255;
+	led->hlv = wacom->led.hlv = wacom->led.max_hlv * brightness / 255;
 
 	wacom->led.groups[led->group].select = led->id;
 
@@ -1389,7 +1389,7 @@ static int wacom_led_register_one(struct device *dev, struct wacom *wacom,
 	led->llv = wacom->led.llv;
 	led->hlv = wacom->led.hlv;
 	led->cdev.name = name;
-	led->cdev.max_brightness = LED_FULL;
+	led->cdev.max_brightness = 255;
 	led->cdev.flags = LED_HW_PLUGGABLE;
 	led->cdev.brightness_get = __wacom_led_brightness_get;
 	if (!read_only) {
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 2a4cc39962e7..d47e8c59aa4d 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3958,7 +3958,7 @@ static void wacom_24hd_update_leds(struct wacom *wacom, int mask, int group)
 		}
 		if (!updated && mask & BIT(i)) {
 			led->held = true;
-			led_trigger_event(&led->trigger, LED_FULL);
+			led_trigger_event(&led->trigger, 255);
 		} else {
 			led->held = false;
 		}
-- 
2.34.1

