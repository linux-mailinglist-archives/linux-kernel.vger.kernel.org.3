Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12594B2E1B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241027AbiBKUBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:01:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353069AbiBKUBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:01:33 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E55C4E;
        Fri, 11 Feb 2022 12:01:31 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id i21so16637904pfd.13;
        Fri, 11 Feb 2022 12:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7yEhdzmKiBIVPQNgvEVDotMSHO96bEnJ0/2MaKTuINI=;
        b=dQQ5vc+CRKq9rB5cNxrmwN6Aol6eMj6O0wlxnSCI2g0wd3dWaMBq3xDNBUgQ8ZVxiO
         tXB1DC6uBS9vdN0uZt+4ox/7ekUVipyczJJTBWHPRZlyLSnPVclPUSeLk+vslctrMa+g
         hpzctKpuLOyAiRPeooFkcHoeRdeQ2lvs4IsPfgMQKABsFkrnlkfH/TTxavaUEIKQTobq
         7Vyim5syU66Kd4VWQzZ6MH5L8tjRw6C056/6bcjY2Krkbovwa34Y0Vyayal8t2p0dn5W
         fC4pxXmrwYY/m0jqIzx1kTVkQdo0yvmvtrptSyBOmxVSHV1VjYwXDtjglUY/DVVgAo3V
         zOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7yEhdzmKiBIVPQNgvEVDotMSHO96bEnJ0/2MaKTuINI=;
        b=WN5G9ck50QfNVhGmXT+eOuKFxFcbqLsRX0H22fAQ+9iTr+QZavVyEqAfMdTE3f3Ot9
         t39haV7/VPH14TGG2qwtLqImuC0wn7hBOwn0UbomIPKOp5o4B6vKlAU1wAjxiNZCywoN
         0hwz+k9JgzFF0H+8IYx2TxJbmG7eGXBmUbwGM4evuZujY/PGeokBZqY9nFir59jHx3V4
         46rFV6cDUvP/9Q+ZvDyk7FRf5CyanayXtdR3mnJSmkj7F9VcJxeFIR8w/LvOBiceeGSp
         RR7IUn4bDp3BFvvoHRnWrWqZxKEm83RzMp5Kfxar3YH9qvncbmloMvhKYn34v62J/FSt
         NpcQ==
X-Gm-Message-State: AOAM530/IVwi6UkDZHIXCdn1PtNQTrxFU+HxUUSBEE0GcTIpuSFLAFxl
        GQ1SWrhsKc6uXLZOeq+sCCI=
X-Google-Smtp-Source: ABdhPJwVXOnbqurcePIcKhG+jxXjd9ekN4pr6QlNeHNOAlZHr1MGi1hkp4aqBv1srPHLYvORpkMyYQ==
X-Received: by 2002:aa7:900d:: with SMTP id m13mr3329110pfo.14.1644609691410;
        Fri, 11 Feb 2022 12:01:31 -0800 (PST)
Received: from localhost.localdomain ([117.194.161.23])
        by smtp.gmail.com with ESMTPSA id f15sm28915080pfv.189.2022.02.11.12.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:01:31 -0800 (PST)
From:   Abhijeet V <abhijeetviswa@gmail.com>
To:     Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abhijeet V <abhijeetviswa@gmail.com>
Subject: [PATCH 1/2] asus-wmi: Use led multicolor class for keyboard backlight
Date:   Sat, 12 Feb 2022 01:31:21 +0530
Message-Id: <20220211200122.9821-2-abhijeetviswa@gmail.com>
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

Use the led multicolor class for keyboard backlight so that support for
rgb keyboard leds can be added for supported Asus laptops.

Also refactored the keyboard led functions. The function names are now
indicative of what the function does.

Signed-off-by: Abhijeet V <abhijeetviswa@gmail.com>
---
 drivers/platform/x86/asus-wmi.c | 109 ++++++++++++++++++--------------
 1 file changed, 63 insertions(+), 46 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 2104a2621e50..117fbcb303d3 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -25,6 +25,7 @@
 #include <linux/input/sparse-keymap.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
+#include <linux/led-class-multicolor.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
@@ -88,6 +89,8 @@ module_param(fnlock_default, bool, 0444);
 #define ASUS_FAN_BOOST_MODE_SILENT_MASK		0x02
 #define ASUS_FAN_BOOST_MODES_MASK		0x03
 
+#define ASUS_KBD_SUBLED_COUNT			3
+
 #define ASUS_THROTTLE_THERMAL_POLICY_DEFAULT	0
 #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST	1
 #define ASUS_THROTTLE_THERMAL_POLICY_SILENT	2
@@ -204,8 +207,6 @@ struct asus_wmi {
 	int wlan_led_wk;
 	struct led_classdev tpd_led;
 	int tpd_led_wk;
-	struct led_classdev kbd_led;
-	int kbd_led_wk;
 	struct led_classdev lightbar_led;
 	int lightbar_led_wk;
 	struct workqueue_struct *led_workqueue;
@@ -213,6 +214,10 @@ struct asus_wmi {
 	struct work_struct wlan_led_work;
 	struct work_struct lightbar_led_work;
 
+	struct led_classdev_mc kbd_led_mc;
+	int kbd_led_wk;
+	struct mc_subled subled_info[ASUS_KBD_SUBLED_COUNT];
+
 	struct asus_rfkill wlan;
 	struct asus_rfkill bluetooth;
 	struct asus_rfkill wimax;
@@ -870,15 +875,7 @@ static enum led_brightness tpd_led_get(struct led_classdev *led_cdev)
 	return read_tpd_led_state(asus);
 }
 
-static void kbd_led_update(struct asus_wmi *asus)
-{
-	int ctrl_param = 0;
-
-	ctrl_param = 0x80 | (asus->kbd_led_wk & 0x7F);
-	asus_wmi_set_devstate(ASUS_WMI_DEVID_KBD_BACKLIGHT, ctrl_param, NULL);
-}
-
-static int kbd_led_read(struct asus_wmi *asus, int *level, int *env)
+static int kbd_led_brightness_wmi_read(struct asus_wmi *asus, int *level, int *env)
 {
 	int retval;
 
@@ -905,50 +902,77 @@ static int kbd_led_read(struct asus_wmi *asus, int *level, int *env)
 	return 0;
 }
 
-static void do_kbd_led_set(struct led_classdev *led_cdev, int value)
+static void kbd_led_brightness_wmi_write(struct asus_wmi *asus, int value)
 {
-	struct asus_wmi *asus;
 	int max_level;
+	int ctrl_param = 0;
 
-	asus = container_of(led_cdev, struct asus_wmi, kbd_led);
-	max_level = asus->kbd_led.max_brightness;
-
+	max_level = asus->kbd_led_mc.led_cdev.max_brightness;
 	asus->kbd_led_wk = clamp_val(value, 0, max_level);
-	kbd_led_update(asus);
+
+	ctrl_param = 0x80 | (asus->kbd_led_wk & 0x7F);
+	asus_wmi_set_devstate(ASUS_WMI_DEVID_KBD_BACKLIGHT, ctrl_param, NULL);
 }
 
-static void kbd_led_set(struct led_classdev *led_cdev,
-			enum led_brightness value)
+static void kbd_led_brightness_set(struct led_classdev *led_cdev,
+		enum led_brightness value)
 {
+	struct asus_wmi *asus;
+	struct led_classdev_mc *led_cdev_mc;
+
 	/* Prevent disabling keyboard backlight on module unregister */
 	if (led_cdev->flags & LED_UNREGISTERING)
 		return;
 
-	do_kbd_led_set(led_cdev, value);
+	led_cdev_mc = container_of(led_cdev, struct led_classdev_mc, led_cdev);
+	asus = container_of(led_cdev_mc, struct asus_wmi, kbd_led_mc);
+
+	kbd_led_brightness_wmi_write(asus, value);
 }
 
-static void kbd_led_set_by_kbd(struct asus_wmi *asus, enum led_brightness value)
+static void kbd_led_set_brightness_by_hw(struct asus_wmi *asus,
+		enum led_brightness value)
 {
-	struct led_classdev *led_cdev = &asus->kbd_led;
+	struct led_classdev *led_cdev = &asus->kbd_led_mc.led_cdev;
 
-	do_kbd_led_set(led_cdev, value);
+	kbd_led_brightness_wmi_write(asus, value);
 	led_classdev_notify_brightness_hw_changed(led_cdev, asus->kbd_led_wk);
 }
 
-static enum led_brightness kbd_led_get(struct led_classdev *led_cdev)
+static enum led_brightness kbd_led_brightness_get(struct led_classdev *led_cdev)
 {
 	struct asus_wmi *asus;
+	struct led_classdev_mc *led_cdev_mc;
 	int retval, value;
 
-	asus = container_of(led_cdev, struct asus_wmi, kbd_led);
+	led_cdev_mc = container_of(led_cdev, struct led_classdev_mc, led_cdev);
+	asus = container_of(led_cdev_mc, struct asus_wmi, kbd_led_mc);
 
-	retval = kbd_led_read(asus, &value, NULL);
+	retval = kbd_led_brightness_wmi_read(asus, &value, NULL);
 	if (retval < 0)
 		return retval;
 
 	return value;
 }
 
+int kbd_led_classdev_init(struct asus_wmi *asus, int brightness)
+{
+	int rv;
+
+	asus->kbd_led_wk = brightness;
+	asus->kbd_led_mc.led_cdev.name = "asus::kbd_backlight";
+	asus->kbd_led_mc.led_cdev.flags = LED_BRIGHT_HW_CHANGED;
+	asus->kbd_led_mc.led_cdev.brightness_set = kbd_led_brightness_set;
+	asus->kbd_led_mc.led_cdev.brightness_get = kbd_led_brightness_get;
+	asus->kbd_led_mc.led_cdev.max_brightness = 3;
+
+	asus->kbd_led_mc.num_colors = ASUS_KBD_SUBLED_COUNT;
+
+	rv = led_classdev_multicolor_register(&asus->platform_device->dev,
+					&asus->kbd_led_mc);
+	return rv;
+}
+
 static int wlan_led_unknown_state(struct asus_wmi *asus)
 {
 	u32 result;
@@ -1026,7 +1050,7 @@ static enum led_brightness lightbar_led_get(struct led_classdev *led_cdev)
 
 static void asus_wmi_led_exit(struct asus_wmi *asus)
 {
-	led_classdev_unregister(&asus->kbd_led);
+	led_classdev_multicolor_unregister(&asus->kbd_led_mc);
 	led_classdev_unregister(&asus->tpd_led);
 	led_classdev_unregister(&asus->wlan_led);
 	led_classdev_unregister(&asus->lightbar_led);
@@ -1057,16 +1081,8 @@ static int asus_wmi_led_init(struct asus_wmi *asus)
 			goto error;
 	}
 
-	if (!kbd_led_read(asus, &led_val, NULL)) {
-		asus->kbd_led_wk = led_val;
-		asus->kbd_led.name = "asus::kbd_backlight";
-		asus->kbd_led.flags = LED_BRIGHT_HW_CHANGED;
-		asus->kbd_led.brightness_set = kbd_led_set;
-		asus->kbd_led.brightness_get = kbd_led_get;
-		asus->kbd_led.max_brightness = 3;
-
-		rv = led_classdev_register(&asus->platform_device->dev,
-					   &asus->kbd_led);
+	if (!kbd_led_brightness_wmi_read(asus, &led_val, NULL)) {
+		rv = kbd_led_classdev_init(asus, led_val);
 		if (rv)
 			goto error;
 	}
@@ -3057,18 +3073,19 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
 	}
 
 	if (code == NOTIFY_KBD_BRTUP) {
-		kbd_led_set_by_kbd(asus, asus->kbd_led_wk + 1);
+		kbd_led_set_brightness_by_hw(asus, asus->kbd_led_wk + 1);
 		return;
 	}
 	if (code == NOTIFY_KBD_BRTDWN) {
-		kbd_led_set_by_kbd(asus, asus->kbd_led_wk - 1);
+		kbd_led_set_brightness_by_hw(asus, asus->kbd_led_wk - 1);
 		return;
 	}
 	if (code == NOTIFY_KBD_BRTTOGGLE) {
-		if (asus->kbd_led_wk == asus->kbd_led.max_brightness)
-			kbd_led_set_by_kbd(asus, 0);
+		if (asus->kbd_led_wk == asus->kbd_led_mc.led_cdev.max_brightness)
+			kbd_led_set_brightness_by_hw(asus, 0);
 		else
-			kbd_led_set_by_kbd(asus, asus->kbd_led_wk + 1);
+			kbd_led_set_brightness_by_hw(asus,
+					asus->kbd_led_wk + 1);
 		return;
 	}
 
@@ -3720,8 +3737,8 @@ static int asus_hotk_resume(struct device *device)
 {
 	struct asus_wmi *asus = dev_get_drvdata(device);
 
-	if (!IS_ERR_OR_NULL(asus->kbd_led.dev))
-		kbd_led_update(asus);
+	if (!IS_ERR_OR_NULL(asus->kbd_led_mc.led_cdev.dev))
+		kbd_led_brightness_wmi_write(asus, asus->kbd_led_wk);
 
 	if (asus_wmi_has_fnlock_key(asus))
 		asus_wmi_fnlock_update(asus);
@@ -3762,8 +3779,8 @@ static int asus_hotk_restore(struct device *device)
 		bl = !asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_UWB);
 		rfkill_set_sw_state(asus->uwb.rfkill, bl);
 	}
-	if (!IS_ERR_OR_NULL(asus->kbd_led.dev))
-		kbd_led_update(asus);
+	if (!IS_ERR_OR_NULL(asus->kbd_led_mc.led_cdev.dev))
+		kbd_led_brightness_wmi_write(asus, asus->kbd_led_wk);
 
 	if (asus_wmi_has_fnlock_key(asus))
 		asus_wmi_fnlock_update(asus);
-- 
2.35.1

