Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056F44B1B35
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346810AbiBKBZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:25:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346783AbiBKBZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:25:16 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B7D26F3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:25:16 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id a39so12620037pfx.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=58Fa3Wh9DcmUEAhH/K1NiJCQawyeai7Qep950CRfr5k=;
        b=C4YaOcDtfxq7kY1jQKvfkU13/vHhbxvHUGn508siIeJtxoEzJEbfHyIkW55YF7eY+e
         re99s/55elAXpjQqg6FusJ8hNu9KS+yXl6QepnhUO0LCN8PUf4EnA+OdaAIl8xqCIVWE
         5mgbAIvcnNE0sNCe4BX4JcBgmf1OEn6Ww98xM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=58Fa3Wh9DcmUEAhH/K1NiJCQawyeai7Qep950CRfr5k=;
        b=0ItdoSbojzeq6kXfFv44qmKCZZLd1szjS1GxsNF5lmzQ9gvDOBHbLTEp5XsnZylD+1
         Bo46xJMD5iSzloHDm3JUh+WgZfef+RDHNvreFH0VpTL7pel9f06H7NohtDtiScydYs70
         MQxanbclgTEnAeuUASf4Uj+rs4K3CPDBrQw7/t3A8f4bBKGIkYM3fYAbyczk4F0lY22L
         gIzzhFNZBarjDTjqEN+J26ObJ6kVc/hJdXos0qqKVnbshNlrNHZ/GwkrXoAHt0SQACzN
         bvr0HxI32JfUKGpQtjQIO2awUfaTKpHeX3YNhWtKFIf9ZqWvqPyBPZ2LTSL39QCSB5Qv
         +Z2g==
X-Gm-Message-State: AOAM532gPEdRN8SRYLpefRNe67U36aSB2kOsY7T9cUJ04W6e3BQ8ZwnO
        chsRQbnp3D2hjIDvI2TpGNvWGg==
X-Google-Smtp-Source: ABdhPJxRBDplF5mdHSPHoKJOxY6u2L8GGoZRC7bwbpajUVv6F3KYPcpU50ahsP85IBbznirHfj6zzw==
X-Received: by 2002:a62:848c:: with SMTP id k134mr10289020pfd.86.1644542716183;
        Thu, 10 Feb 2022 17:25:16 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:fb9d:6747:c0b4:f7ee])
        by smtp.gmail.com with ESMTPSA id m13sm23260146pfh.197.2022.02.10.17.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 17:25:15 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     benjamin.tissoires@redhat.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        "Sean O'Brien" <seobrien@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v3 3/4] HID: google: Add support for vivaldi to hid-hammer
Date:   Thu, 10 Feb 2022 17:25:09 -0800
Message-Id: <20220211012510.1198155-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220211012510.1198155-1-swboyd@chromium.org>
References: <20220211012510.1198155-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index ea8fa71c9e9c..4bea966e617b 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -413,6 +413,7 @@ config HID_VIVALDI_COMMON
 config HID_GOOGLE_HAMMER
 	tristate "Google Hammer Keyboard"
 	select HID_VIVALDI_COMMON
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

