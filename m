Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9894D26F1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiCIBQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiCIBQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:16:12 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECC815C66E;
        Tue,  8 Mar 2022 16:59:53 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id m12so869053edc.12;
        Tue, 08 Mar 2022 16:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=Q5yee2um5dwXMOKTOCzeOQkXQzKlkJ9Jp/nZl+x7O4U=;
        b=X3t/4IT+YKn85B8T2VKbIoJH0N72N1oep0F+Ml5bsJCBkZjSWES0+SmOgcOWWdn5d/
         zCeSKU/PpFmvjX66gqrkFMwZEIZdG0W3UEOEfc2MW6x9iuvI4K5jqGsg4A4KHv/sFhi1
         s8+LQweybbsKSV1LmacpF75FeEl4KEDmI7j78EruYDSc8lzPLqI/EvHOf8ooqQXloXcS
         T6WGv24+2XJIwSkiufh/jx3C4010WqFLh+u7Y1Fe2oF2FcPP8BT5yxAngPnSn58Eka5U
         qgPXZndmezV21vfv17rWX8OjOuTZVLLJxTzqkDiP4LBtIzlWDC7IclWUZ/AyG2v7V4kr
         i18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=Q5yee2um5dwXMOKTOCzeOQkXQzKlkJ9Jp/nZl+x7O4U=;
        b=OAxRYJ+0T1AxWaoRlGQ08ze1GAfJWwTc1P7yqqAzdtMH16jW4VGhl50MLeNIcOKV9U
         lTaSEVnhQGW4p/X24/jo4wGmdP8vVs0bnkfUad1ewh65/FckQbzC7ge7Ur7cMdzLWoFM
         bzIcFXOybcBFcywMJ7pV0SNQHTvcZZIrqttXgZ0QzJk4LVo/K3PhthjuqPetOEzIjPOl
         oLFhECuPfH86BjKtFevIUyWSXcoca5SLuW/lAt766jPU0dC/hjBrXD8+ZpALsNXk9LxJ
         50U/ztc9WpDUyQQ1+LO0qLHTMrOVCua/07cC3BofOHP4b/xj0hetBg9CF8VlJMcV2/Ox
         bg1w==
X-Gm-Message-State: AOAM532JcxR4MkHAMUkLiVrw3oDDUBdI+0UXBSkAqJ5q/YQwgKIE89kr
        1T4yOTblUE4HfzszrQLL5bL2HHBsmpx/X/0G
X-Google-Smtp-Source: ABdhPJyA/ptyOIM2WD10sC0KVUTgypVI9XwNKIv36yLO83TGQUENI6DGsj1lIDT6rJ5+Zjjf52DrOA==
X-Received: by 2002:a5d:55c1:0:b0:1ea:961e:2ce4 with SMTP id i1-20020a5d55c1000000b001ea961e2ce4mr14537166wrw.45.1646783462085;
        Tue, 08 Mar 2022 15:51:02 -0800 (PST)
Received: from hermes ([2604:3d09:e80:800::72d9])
        by smtp.gmail.com with ESMTPSA id e4-20020adffc44000000b001f1dba38a65sm206573wrs.105.2022.03.08.15.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 15:51:01 -0800 (PST)
Date:   Tue, 8 Mar 2022 16:50:57 -0700
From:   Manuel =?iso-8859-1?Q?Sch=F6nlaub?= <manuel.schoenlaub@gmail.com>
To:     manuel.schoenlaub@gmail.com
Cc:     lains@riseup.net, jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: logitech-hidpp: support Color LED feature (8071).
Message-ID: <Yifr4etBFPu1a2Ct@hermes>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
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

The HID++ protocol allows to set multicolor (RGB) to a static color.
Multiple of such LED zones per device are supported.
This patch exports said LEDs so that they can be set from userspace.

Signed-off-by: Manuel Schönlaub <manuel.schoenlaub@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 188 +++++++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 81de88ab2..0b6c9c4b8 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -24,6 +24,8 @@
 #include <linux/atomic.h>
 #include <linux/fixp-arith.h>
 #include <asm/unaligned.h>
+#include <linux/leds.h>
+#include <linux/led-class-multicolor.h>
 #include "usbhid/usbhid.h"
 #include "hid-ids.h"
 
@@ -96,6 +98,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_CAPABILITY_BATTERY_VOLTAGE	BIT(4)
 #define HIDPP_CAPABILITY_BATTERY_PERCENTAGE	BIT(5)
 #define HIDPP_CAPABILITY_UNIFIED_BATTERY	BIT(6)
+#define HIDPP_CAPABILITY_HIDPP20_COLORED_LEDS	BIT(7)
 
 #define lg_map_key_clear(c)  hid_map_usage_clear(hi, usage, bit, max, EV_KEY, (c))
 
@@ -159,6 +162,12 @@ struct hidpp_battery {
 	u8 supported_levels_1004;
 };
 
+struct hidpp_leds {
+	u8 feature_index;
+	u8 count;
+	struct led_classdev_mc leds[];
+};
+
 /**
  * struct hidpp_scroll_counter - Utility class for processing high-resolution
  *                             scroll events.
@@ -201,6 +210,7 @@ struct hidpp_device {
 	u8 supported_reports;
 
 	struct hidpp_battery battery;
+	struct hidpp_leds *leds;
 	struct hidpp_scroll_counter vertical_wheel_counter;
 
 	u8 wireless_feature_index;
@@ -1708,6 +1718,134 @@ static int hidpp_battery_get_property(struct power_supply *psy,
 	return ret;
 }
 
+/* -------------------------------------------------------------------------- */
+/* 0x8070: Color LED effect                                                   */
+/* -------------------------------------------------------------------------- */
+
+#define HIDPP_PAGE_LED_EFFECTS 0x8070
+
+#define CMD_COLOR_LED_EFFECTS_GET_INFO 0x00
+
+#define CMD_COLOR_LED_EFFECTS_SET_ZONE_STATE 0x31
+
+static int hidpp20_color_led_effect_get_info(struct hidpp_device *hidpp_dev,
+					     u8 feature_index, u8 *count)
+{
+	struct hidpp_report response;
+	int ret;
+	u8 *params = (u8 *)response.fap.params;
+
+	ret = hidpp_send_fap_command_sync(hidpp_dev, feature_index,
+					  CMD_COLOR_LED_EFFECTS_GET_INFO,
+					  NULL, 0, &response);
+
+	if (ret > 0) {
+		hid_err(hidpp_dev->hid_dev,
+			"%s: received protocol error 0x%02x\n",
+			__func__, ret);
+		return -EPROTO;
+	}
+	if (ret)
+		return ret;
+
+	*count = params[0];
+	return 0;
+}
+
+static int hidpp20_color_effect_set(struct hidpp_device *hidpp_dev,
+				    u8 zone, bool enabled,
+				    u8 r, u8 b, u8 g)
+{
+	int ret;
+	u8 params[5];
+	struct hidpp_report response;
+
+	params[0] = zone;
+	params[1] = enabled ? 1 : 0;
+	params[2] = r;
+	params[3] = g;
+	params[4] = b;
+
+	ret = hidpp_send_fap_command_sync(hidpp_dev,
+					  hidpp_dev->leds->feature_index,
+					  CMD_COLOR_LED_EFFECTS_SET_ZONE_STATE,
+					  params, sizeof(params), &response);
+
+	if (ret)
+		return ret;
+	return 0;
+}
+
+static int hidpp_set_brightness(struct led_classdev *cdev,
+				enum led_brightness brightness)
+{
+	int n;
+	struct device *dev = cdev->dev->parent;
+	struct hid_device *hid = to_hid_device(dev);
+	struct hidpp_device *hidpp = hid_get_drvdata(hid);
+
+	struct led_classdev_mc *mc_cdev = lcdev_to_mccdev(cdev);
+	u8 red, green, blue;
+
+	led_mc_calc_color_components(mc_cdev, brightness);
+	red = mc_cdev->subled_info[0].brightness;
+	green = mc_cdev->subled_info[1].brightness;
+	blue = mc_cdev->subled_info[2].brightness;
+
+	for (n = 0; n < hidpp->leds->count; n++) {
+		if (cdev == &hidpp->leds->leds[n].led_cdev) {
+			return hidpp20_color_effect_set(hidpp, n,
+							brightness > 0,
+							red, green, blue);
+		}
+	}
+
+	return LED_OFF;
+}
+
+static int hidpp_mc_led_register(struct hidpp_device *hidpp_dev,
+				 struct led_classdev_mc *mc_dev,
+				 int zone)
+{
+	struct hid_device *hdev = hidpp_dev->hid_dev;
+	struct mc_subled *mc_led_info;
+	struct led_classdev *cdev;
+	int ret;
+
+	mc_led_info = devm_kmalloc_array(&hdev->dev, 3,
+					 sizeof(*mc_led_info),
+					 GFP_KERNEL | __GFP_ZERO);
+	if (!mc_led_info)
+		return -ENOMEM;
+
+	mc_led_info[0].color_index = LED_COLOR_ID_RED;
+	mc_led_info[1].color_index = LED_COLOR_ID_GREEN;
+	mc_led_info[2].color_index = LED_COLOR_ID_BLUE;
+
+	mc_dev->subled_info = mc_led_info;
+	mc_dev->num_colors = 3;
+
+	cdev = &mc_dev->led_cdev;
+	cdev->name = devm_kasprintf(&hdev->dev, GFP_KERNEL,
+				    "%s:rgb:indicator-%d", hdev->uniq, zone);
+
+	if (!cdev->name)
+		return -ENOMEM;
+
+	cdev->brightness = 0;
+	cdev->max_brightness = 255;
+	cdev->flags |= LED_CORE_SUSPENDRESUME;
+	cdev->brightness_set_blocking = hidpp_set_brightness;
+
+	ret = devm_led_classdev_multicolor_register(&hdev->dev, mc_dev);
+	if (ret < 0) {
+		hid_err(hdev, "Cannot register multicolor LED device: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 /* -------------------------------------------------------------------------- */
 /* 0x1d4b: Wireless device status                                             */
 /* -------------------------------------------------------------------------- */
@@ -3699,6 +3837,54 @@ static int hidpp_event(struct hid_device *hdev, struct hid_field *field,
 	return 1;
 }
 
+static int hidpp_initialize_leds(struct hidpp_device *hidpp_dev)
+{
+	u8 count;
+	u8 feature_index;
+	u8 feature_type;
+	int i;
+	int ret;
+	struct hid_device *hdev;
+
+	hdev = hidpp_dev->hid_dev;
+	if (hidpp_dev->leds)
+		return 0;
+	if (hidpp_dev->protocol_major >= 2) {
+		ret = hidpp_root_get_feature(hidpp_dev,
+					     HIDPP_PAGE_LED_EFFECTS,
+					     &feature_index,
+						     &feature_type);
+			if (ret)
+				return ret;
+
+		ret = hidpp20_color_led_effect_get_info(hidpp_dev, feature_index, &count);
+		if (ret)
+			return ret;
+
+		hidpp_dev->capabilities |= HIDPP_CAPABILITY_HIDPP20_COLORED_LEDS;
+		hidpp_dev->leds = devm_kzalloc(&hdev->dev,
+					       struct_size(hidpp_dev->leds, leds, count),
+					       GFP_KERNEL);
+
+		if (!hidpp_dev->leds)
+			return -ENOMEM;
+
+		hidpp_dev->leds->feature_index = feature_index;
+		hidpp_dev->leds->count = count;
+
+		for (i = 0; i < count; i++) {
+			ret = hidpp_mc_led_register(hidpp_dev, &hidpp_dev->leds->leds[i], i);
+			if (ret < 0)
+				return ret;
+		}
+
+		return 0;
+
+	} else {
+		return 0;
+	}
+}
+
 static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 {
 	static atomic_t battery_no = ATOMIC_INIT(0);
@@ -3943,6 +4129,8 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 	if (hidpp->battery.ps)
 		power_supply_changed(hidpp->battery.ps);
 
+	hidpp_initialize_leds(hidpp);
+
 	if (hidpp->quirks & HIDPP_QUIRK_HI_RES_SCROLL)
 		hi_res_scroll_enable(hidpp);
 
-- 
2.30.2

