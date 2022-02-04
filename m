Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2CE4AA11A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 21:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238650AbiBDUUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 15:20:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237616AbiBDUUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:20:34 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CB3C06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 12:20:28 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso14113965pjv.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 12:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j6C39UFn+jrEqEIOvITw0T2gh1RnTm0sOBo49+WVuDA=;
        b=jGvPAGwayYyRxJU/DyY/MMJwXAGIuoD2BSFjJHICXNMolE12b7ijp2RV+FCiUd7G0X
         orlr6ZpVrI2eM7+TuN9DaaSbqfcqk+X9nqSp87sAZUeZpXmLVJPxeuV1LqEqNAt4nx5e
         bs8HiyKzLPBgTC0QjvKrXdIKgKCSCjVKQvm4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j6C39UFn+jrEqEIOvITw0T2gh1RnTm0sOBo49+WVuDA=;
        b=3xr3ZoMcuHpTfPyCt7xfsEBZSZbzFBON8nQ+czqHfovEmsltvUxvjAShDPKTI8U6jw
         QLw3RWcq2Mx2qC8k6E/kDQmeuhdsk67kDsM46X05jY333YY/TuWjZIaXjROgRg/RD2AL
         aDg2MixaqtQwDDOkOGjfzQTvOyjk8Qv5sNDVNWb6BxaREcJFpkYXXq3Cs1NGMK8YYDiz
         pqDIiJ4mKDJy5EHdUeVXNnyVObz+elVSGEYtjyAYmNn7qtaBTTWdokySE1YZfr+CmbL0
         b4yLc+jjkkebx7uVrVfLnx6y22WWdtwmAySpYtTn9/XnS/+CM7ieOxGNMlUICYCkd2pI
         GQhA==
X-Gm-Message-State: AOAM533GW1FQdosTIBHtSBIaopq8KkFgse/ky5qgwGfIxUkJo8NR2eJT
        ezOKCNKdyBtHryaTSCyf5sy1sA==
X-Google-Smtp-Source: ABdhPJy4fIjcXd5iKfn71Ecib6moONOKAzLwXXPrXvh0pjqlt8nRvQHCfG2u/CfjfwBY300zubxQ1Q==
X-Received: by 2002:a17:902:d48a:: with SMTP id c10mr4746224plg.139.1644006027577;
        Fri, 04 Feb 2022 12:20:27 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:1ba2:dd59:3b59:18bc])
        by smtp.gmail.com with ESMTPSA id q17sm3385561pfk.108.2022.02.04.12.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 12:20:27 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     benjamin.tissoires@redhat.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        "Sean O'Brien" <seobrien@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH 4/5] HID: google: Add support for vivaldi to hid-hammer
Date:   Fri,  4 Feb 2022 12:20:20 -0800
Message-Id: <20220204202021.895426-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220204202021.895426-1-swboyd@chromium.org>
References: <20220204202021.895426-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to the hammer driver to parse vivaldi keyboard layouts and
expose them to userspace. This allows hammer devices to use vivaldi
function row keys while also supporting the other features this driver
supports, like the CBAS (chrome base attached switch) and a keyboard
backlight.

Cc: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Sean O'Brien" <seobrien@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/hid/Kconfig             |  1 +
 drivers/hid/hid-google-hammer.c | 95 +++++++++++++++++++++++++--------
 2 files changed, 75 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 5569a2029dab..070c4c8128e8 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -405,6 +405,7 @@ config HOLTEK_FF
 
 config HID_GOOGLE_HAMMER
 	tristate "Google Hammer Keyboard"
+	select INPUT_VIVALDIFMAP
 	depends on USB_HID && LEDS_CLASS && CROS_EC
 	help
 	Say Y here if you have a Google Hammer device.
diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 0403beb3104b..e3dd26ddbd43 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -15,6 +15,7 @@
 
 #include <linux/acpi.h>
 #include <linux/hid.h>
+#include <linux/input/vivaldi-keymap.h>
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -22,6 +23,7 @@
 #include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
 #include <linux/pm_wakeup.h>
+#include <linux/sysfs.h>
 #include <asm/unaligned.h>
 
 #include "hid-ids.h"
@@ -300,6 +302,11 @@ struct hammer_kbd_leds {
 	u8 buf[2] ____cacheline_aligned;
 };
 
+struct hammer_drvdata {
+	struct vivaldi_data vdata;
+	struct hammer_kbd_leds leds;
+};
+
 static int hammer_kbd_brightness_set_blocking(struct led_classdev *cdev,
 		enum led_brightness br)
 {
@@ -337,15 +344,11 @@ static int hammer_kbd_brightness_set_blocking(struct led_classdev *cdev,
 	return ret;
 }
 
-static int hammer_register_leds(struct hid_device *hdev)
+static int hammer_register_leds(struct hammer_drvdata *hdata, struct hid_device *hdev)
 {
 	struct hammer_kbd_leds *kbd_backlight;
-	int error;
-
-	kbd_backlight = kzalloc(sizeof(*kbd_backlight), GFP_KERNEL);
-	if (!kbd_backlight)
-		return -ENOMEM;
 
+	kbd_backlight = &hdata->leds;
 	kbd_backlight->hdev = hdev;
 	kbd_backlight->cdev.name = "hammer::kbd_backlight";
 	kbd_backlight->cdev.max_brightness = MAX_BRIGHTNESS;
@@ -356,26 +359,16 @@ static int hammer_register_leds(struct hid_device *hdev)
 	/* Set backlight to 0% initially. */
 	hammer_kbd_brightness_set_blocking(&kbd_backlight->cdev, 0);
 
-	error = led_classdev_register(&hdev->dev, &kbd_backlight->cdev);
-	if (error)
-		goto err_free_mem;
-
-	hid_set_drvdata(hdev, kbd_backlight);
-	return 0;
-
-err_free_mem:
-	kfree(kbd_backlight);
-	return error;
+	return led_classdev_register(&hdev->dev, &kbd_backlight->cdev);
 }
 
 static void hammer_unregister_leds(struct hid_device *hdev)
 {
-	struct hammer_kbd_leds *kbd_backlight = hid_get_drvdata(hdev);
+	struct hammer_drvdata *hdata = hid_get_drvdata(hdev);
+	struct hammer_kbd_leds *kbd_backlight = &hdata->leds;
 
-	if (kbd_backlight) {
+	if (kbd_backlight)
 		led_classdev_unregister(&kbd_backlight->cdev);
-		kfree(kbd_backlight);
-	}
 }
 
 #define HID_UP_GOOGLEVENDOR	0xffd10000
@@ -385,6 +378,58 @@ static void hammer_unregister_leds(struct hid_device *hdev)
 /* HID usage for keyboard backlight (Alphanumeric display brightness) */
 #define HID_AD_BRIGHTNESS	0x00140046
 
+static void hammer_feature_mapping(struct hid_device *hdev,
+				   struct hid_field *field,
+				   struct hid_usage *usage)
+{
+	struct hammer_drvdata *hdata = hid_get_drvdata(hdev);
+
+	vivaldi_hid_feature_mapping(&hdata->vdata, hdev, field, usage);
+}
+
+static ssize_t function_row_physmap_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct hid_device *hdev = to_hid_device(dev);
+	struct hammer_drvdata *hdata = hid_get_drvdata(hdev);
+	struct vivaldi_data *vdata = &hdata->vdata;
+
+	return vivaldi_function_row_physmap_show(vdata, buf);
+}
+
+static DEVICE_ATTR_RO(function_row_physmap);
+static struct attribute *hammer_sysfs_attrs[] = {
+	&dev_attr_function_row_physmap.attr,
+	NULL
+};
+
+static umode_t hammer_attr_is_visible(struct kobject *kobj,
+				      struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct hid_device *hdev = to_hid_device(dev);
+	struct hammer_drvdata *hdata = hid_get_drvdata(hdev);
+	struct vivaldi_data *vdata = &hdata->vdata;
+
+	if (attr == &dev_attr_function_row_physmap.attr &&
+	    !vdata->num_function_row_keys)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group input_attribute_group = {
+	.is_visible = hammer_attr_is_visible,
+	.attrs = hammer_sysfs_attrs,
+};
+
+static int hammer_input_configured(struct hid_device *hdev,
+				   struct hid_input *hidinput)
+{
+	return sysfs_create_group(&hdev->dev.kobj, &input_attribute_group);
+}
+
 static int hammer_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 				struct hid_field *field,
 				struct hid_usage *usage,
@@ -516,6 +561,12 @@ static int hammer_probe(struct hid_device *hdev,
 			const struct hid_device_id *id)
 {
 	int error;
+	struct hammer_drvdata *hdata;
+
+	hdata = devm_kzalloc(&hdev->dev, sizeof(*hdata), GFP_KERNEL);
+	if (!hdata)
+		return -ENOMEM;
+	hid_set_drvdata(hdev, hdata);
 
 	error = hid_parse(hdev);
 	if (error)
@@ -541,7 +592,7 @@ static int hammer_probe(struct hid_device *hdev,
 	}
 
 	if (hammer_has_backlight_control(hdev)) {
-		error = hammer_register_leds(hdev);
+		error = hammer_register_leds(hdata, hdev);
 		if (error)
 			hid_warn(hdev,
 				"Failed to register keyboard backlight: %d\n",
@@ -610,6 +661,8 @@ static struct hid_driver hammer_driver = {
 	.id_table = hammer_devices,
 	.probe = hammer_probe,
 	.remove = hammer_remove,
+	.feature_mapping = hammer_feature_mapping,
+	.input_configured = hammer_input_configured,
 	.input_mapping = hammer_input_mapping,
 	.event = hammer_event,
 };
-- 
https://chromeos.dev

