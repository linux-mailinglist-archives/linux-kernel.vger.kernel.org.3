Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4230F4B2E19
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353088AbiBKUBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:01:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240414AbiBKUBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:01:47 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B27C54;
        Fri, 11 Feb 2022 12:01:34 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id i6so16215745pfc.9;
        Fri, 11 Feb 2022 12:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NGMuc3QWa/tz9bO3RZ/u3cDSmW3qy4DcRBs8PaptKno=;
        b=Gnr7YIwgQZGHqHYRT63/meO9IIR0rw426TxbiV/E5CPgOLJTfqiRZR2tfvctMcxRrD
         wdFz5MoC6RFzbcWr4Xkl2PHUCbwvjSIq2UhkoQWxNCsPpQUjtuz/CLfUW4nAD5Zwb7z4
         UlWXnFsJ6WJSG7TZHoFnnsEnZOJP0H16IiXfjcZNBv12gXzP/UxLPkPh5V3nPalhYI+s
         8l80rGSZYlBq1Wa1c8mw3TdVPwU9mYiJLnLheknE9E71MzTN7VWHxxMVeKwAkGsc1ocy
         nUYmSXtlb/zJAt+GyXjqE555S95y6QVtCxutybdhYi1K6i0q67qfr6MNVJP1Yh+Oxztx
         pcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NGMuc3QWa/tz9bO3RZ/u3cDSmW3qy4DcRBs8PaptKno=;
        b=59gH9ptxBQV+BnOwVUeltFeW9MW2nYdJlojxlbZLpKhiavz9zqvXh99PqtUh423CTm
         2E9FroIxwZVyvaOdEDV3i5wGHwhbuG43xoDhcJjigaNaJqvtoqAxDQfsuQhCPeLB0U97
         TzEbzgFQv9InLCz6DA5UYhrCU71xXMVxhBVR4C71ZlG8uZSNM09vaUBMulZv9zbipmM7
         uObG/7bwCZ+ytzTjHJ6QDdMmHoJShu1Ur70LHAWs8ZSqWTK7zZ0rHhPxVtWBE2YVFbuc
         StKfrXAjbkSg2Wu57rleRKd5q7usU3uXS1YWX+Znwoku/Q6mJUNFoY9Ysepfu5/mBxJv
         AeJQ==
X-Gm-Message-State: AOAM530r9M+gAV5FbQ7NYR/BwlfngqnLSBrDYUcIL64xIG2xvVr2stSr
        zd2n5OmjYcsM77hPzlhDg4g=
X-Google-Smtp-Source: ABdhPJw0i5w2ryRDqs3JEpmMmeTR7/3UmsM41KWaHLyAXpgFJvMp8zDpqaABSyeFsfIv/wgns2nUvQ==
X-Received: by 2002:a63:181:: with SMTP id 123mr2653820pgb.546.1644609693981;
        Fri, 11 Feb 2022 12:01:33 -0800 (PST)
Received: from localhost.localdomain ([117.194.161.23])
        by smtp.gmail.com with ESMTPSA id f15sm28915080pfv.189.2022.02.11.12.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:01:33 -0800 (PST)
From:   Abhijeet V <abhijeetviswa@gmail.com>
To:     Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abhijeet V <abhijeetviswa@gmail.com>
Subject: [PATCH 2/2] asus-wmi: Add support for keyboard rgb backlights
Date:   Sat, 12 Feb 2022 01:31:22 +0530
Message-Id: <20220211200122.9821-3-abhijeetviswa@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220211200122.9821-1-abhijeetviswa@gmail.com>
References: <20220211200122.9821-1-abhijeetviswa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uses the led multicolor classdev to change the rgb values.
The WMI function expects other settings in addition to the rgb values.
This patch assumes some defaults to get the base rgb functionality
working.

Signed-off-by: Abhijeet V <abhijeetviswa@gmail.com>
---
 drivers/platform/x86/asus-wmi.c            | 137 +++++++++++++++++++++
 include/linux/platform_data/x86/asus-wmi.h |   2 +
 2 files changed, 139 insertions(+)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 117fbcb303d3..f8e92021399c 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -193,6 +193,12 @@ struct fan_curve_data {
 	u8 percents[FAN_CURVE_POINTS];
 };
 
+struct asus_kbd_rgb {
+	u8 red;
+	u8 green;
+	u8 blue;
+};
+
 struct asus_wmi {
 	int dsts_id;
 	int spec;
@@ -217,6 +223,8 @@ struct asus_wmi {
 	struct led_classdev_mc kbd_led_mc;
 	int kbd_led_wk;
 	struct mc_subled subled_info[ASUS_KBD_SUBLED_COUNT];
+	struct asus_kbd_rgb kbd_rgb;
+	bool kbd_rgb_available;
 
 	struct asus_rfkill wlan;
 	struct asus_rfkill bluetooth;
@@ -914,6 +922,114 @@ static void kbd_led_brightness_wmi_write(struct asus_wmi *asus, int value)
 	asus_wmi_set_devstate(ASUS_WMI_DEVID_KBD_BACKLIGHT, ctrl_param, NULL);
 }
 
+static int kbd_led_rgb_wmi_write(struct asus_wmi *asus)
+{
+	int err;
+	u32 retval;
+	u8 red;
+	u8 green;
+	u8 blue;
+	u8 speed_byte;
+	u8 mode_byte;
+	u8 speed;
+	u8 mode;
+	u8 flags;
+	u8 persistent;
+
+	speed = 0; // Sane default
+	switch (speed) {
+	case 0:
+	default:
+		speed_byte = 0xe1; // slow
+		speed = 0;
+		break;
+	case 1:
+		speed_byte = 0xeb; // medium
+		break;
+	case 2:
+		speed_byte = 0xf5; // fast
+		break;
+	}
+
+	mode = 0; // Sane default
+	switch (mode) {
+	case 0:
+	default:
+		mode_byte = 0x00; // static color
+		mode = 0;
+		break;
+	case 1:
+		mode_byte = 0x01; // breathing
+		break;
+	case 2:
+		mode_byte = 0x02; // color cycle
+		break;
+	case 3:
+		mode_byte = 0x0a; // strobing
+		break;
+	}
+
+	red = clamp_val(asus->kbd_led_mc.subled_info[0].intensity, 0, 255);
+	green = clamp_val(asus->kbd_led_mc.subled_info[1].intensity, 0, 255);
+	blue = clamp_val(asus->kbd_led_mc.subled_info[2].intensity, 0, 255);
+
+	/*
+	 * 00 - Reset on boot
+	 * 01 - Persist across boot
+	 */
+	persistent = 1; // Sane defaults
+
+	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS,
+		ASUS_WMI_DEVID_KBD_RGB,
+		(persistent ? 0xb4 : 0xb3) |
+		(mode_byte << 8) |
+		(red << 16) |
+		(green << 24),
+		(blue) |
+		(speed_byte << 8), &retval);
+	if (err) {
+		pr_warn("RGB keyboard device 1, write error: %d\n", err);
+		return err;
+	}
+
+	if (retval != 1) {
+		pr_warn("RGB keyboard device 1, write error (retval): %x\n",
+				retval);
+		return -EIO;
+	}
+
+	/*
+	 * Enable: 02 - on boot (until module load) | 08 - awake | 20 - sleep
+	 * (2a or ff to enable everything)
+	 *
+	 * Logically 80 would be shutdown, but no visible effects of this option
+	 * were observed so far
+	 */
+	flags = 0xff;
+
+	err = asus_wmi_evaluate_method3(ASUS_WMI_METHODID_DEVS,
+		ASUS_WMI_DEVID_KBD_RGB2,
+		(0xbd) |
+		(flags << 16) |
+		(persistent ? 0x0100 : 0x0000), 0, &retval);
+	if (err) {
+		pr_warn("RGB keyboard device 2, write error: %d\n", err);
+		return err;
+	}
+
+	if (retval != 1) {
+		pr_warn("RGB keyboard device 2, write error (retval): %x\n",
+				retval);
+		return -EIO;
+	}
+
+	asus->kbd_rgb.red = red;
+	asus->kbd_rgb.green = green;
+	asus->kbd_rgb.blue = blue;
+
+	return 0;
+}
+
 static void kbd_led_brightness_set(struct led_classdev *led_cdev,
 		enum led_brightness value)
 {
@@ -928,6 +1044,18 @@ static void kbd_led_brightness_set(struct led_classdev *led_cdev,
 	asus = container_of(led_cdev_mc, struct asus_wmi, kbd_led_mc);
 
 	kbd_led_brightness_wmi_write(asus, value);
+
+	/* Check and set if rgb available */
+	if (!asus->kbd_rgb_available)
+		return;
+
+	if (asus->kbd_rgb.red == asus->subled_info[LED_COLOR_ID_RED].intensity &&
+			asus->kbd_rgb.green == asus->subled_info[LED_COLOR_ID_GREEN].intensity &&
+			asus->kbd_rgb.blue == asus->subled_info[LED_COLOR_ID_BLUE].intensity) {
+		return;
+	}
+
+	kbd_led_rgb_wmi_write(asus);
 }
 
 static void kbd_led_set_brightness_by_hw(struct asus_wmi *asus,
@@ -959,6 +1087,7 @@ int kbd_led_classdev_init(struct asus_wmi *asus, int brightness)
 {
 	int rv;
 
+	asus->kbd_rgb_available = true;
 	asus->kbd_led_wk = brightness;
 	asus->kbd_led_mc.led_cdev.name = "asus::kbd_backlight";
 	asus->kbd_led_mc.led_cdev.flags = LED_BRIGHT_HW_CHANGED;
@@ -966,6 +1095,14 @@ int kbd_led_classdev_init(struct asus_wmi *asus, int brightness)
 	asus->kbd_led_mc.led_cdev.brightness_get = kbd_led_brightness_get;
 	asus->kbd_led_mc.led_cdev.max_brightness = 3;
 
+	asus->subled_info[0].color_index = LED_COLOR_ID_RED;
+	asus->subled_info[0].channel = 0;
+	asus->subled_info[1].color_index = LED_COLOR_ID_GREEN;
+	asus->subled_info[1].channel = 1;
+	asus->subled_info[2].color_index = LED_COLOR_ID_BLUE;
+	asus->subled_info[2].channel = 2;
+	asus->kbd_led_mc.subled_info = asus->subled_info;
+
 	asus->kbd_led_mc.num_colors = ASUS_KBD_SUBLED_COUNT;
 
 	rv = led_classdev_multicolor_register(&asus->platform_device->dev,
diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
index a571b47ff362..a20ca3787e9f 100644
--- a/include/linux/platform_data/x86/asus-wmi.h
+++ b/include/linux/platform_data/x86/asus-wmi.h
@@ -59,6 +59,8 @@
 #define ASUS_WMI_DEVID_LIGHTBAR		0x00050025
 #define ASUS_WMI_DEVID_FAN_BOOST_MODE	0x00110018
 #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
+#define ASUS_WMI_DEVID_KBD_RGB		0x00100056
+#define ASUS_WMI_DEVID_KBD_RGB2		0x00100057
 
 /* Misc */
 #define ASUS_WMI_DEVID_PANEL_OD		0x00050019
-- 
2.35.1

