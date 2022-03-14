Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFB54D7E49
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiCNJLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237891AbiCNJKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:10:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5583843399;
        Mon, 14 Mar 2022 02:09:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45063B80D5B;
        Mon, 14 Mar 2022 09:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B761BC340F5;
        Mon, 14 Mar 2022 09:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647248959;
        bh=5TX/dk0N+tSkMnJvZ8bJ8SCwTJbmkPqtIew+ntbu8GI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GfcAspsTgkbGYyQus8OX4ALk/+tYj8DfcENH4fmC30zJdrLWjC8qH94mTObdFRXOv
         A+RxJVat+KhHea/fcAOvno3gwx9qEidUZoHf/amyxhAhqgp/hRukAEblNqvNuLEClk
         7WULxQYOYD7gdHHbUJ0c3Ruce4DETZySuv0A3ASnMk3v11Jv6S9kI/acAty0uOiPJo
         2/cBMoczxpceCXIb8N88nzqqEXN+RbZYwyMUpUbB4qiwd9FUTKu3UzGPUul34j1CPS
         2QyrJtS0VhFU5Wlos+PsjMdcwYo+v1rRnhA2bfPmiRY1s13WD1Az1vMTRUxZUmuMLd
         VL/jRisiFec9w==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, tzungbi@kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] platform/chrome: cros_kbd_led_backlight: support EC PWM backend
Date:   Mon, 14 Mar 2022 17:08:35 +0800
Message-Id: <20220314090835.3822093-6-tzungbi@kernel.org>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
In-Reply-To: <20220314090835.3822093-1-tzungbi@kernel.org>
References: <20220314090835.3822093-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EC PWM backend uses EC_CMD_PWM_SET_KEYBOARD_BACKLIGHT and
EC_CMD_PWM_GET_KEYBOARD_BACKLIGHT for setting and getting the brightness
respectively.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- Update email address accordingly.

 drivers/platform/chrome/Kconfig               |   6 +
 .../platform/chrome/cros_kbd_led_backlight.c  | 126 +++++++++++++++---
 2 files changed, 117 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 3f74679a556c..298a49550857 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -142,6 +142,12 @@ config CROS_KBD_LED_BACKLIGHT_ACPI
 	help
 	  ChromeOS keyboard backlight ACPI backend.
 
+config CROS_KBD_LED_BACKLIGHT_EC_PWM
+	tristate "ChromeOS keyboard backlight EC PWM backend"
+	depends on CROS_EC && CROS_KBD_LED_BACKLIGHT
+	help
+	  ChromeOS keyboard backlight EC PWM backend.
+
 config CROS_EC_CHARDEV
 	tristate "ChromeOS EC miscdevice"
 	depends on MFD_CROS_EC_DEV
diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
index 1f2750c830d4..05a93b71d222 100644
--- a/drivers/platform/chrome/cros_kbd_led_backlight.c
+++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
@@ -11,10 +11,17 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/slab.h>
 
+struct keyboard_led_private {
+	struct led_classdev cdev;
+	struct cros_ec_device *ec;
+};
+
 /**
  * struct keyboard_led_drvdata - keyboard LED driver data.
  * @init:			Init function.
@@ -40,6 +47,8 @@ struct keyboard_led_drvdata {
 	enum led_brightness max_brightness;
 };
 
+#define KEYBOARD_BACKLIGHT_MAX 100
+
 #if IS_ENABLED(CONFIG_CROS_KBD_LED_BACKLIGHT_ACPI)
 
 /* Keyboard LED ACPI Device must be defined in firmware */
@@ -47,8 +56,6 @@ struct keyboard_led_drvdata {
 #define ACPI_KEYBOARD_BACKLIGHT_READ	ACPI_KEYBOARD_BACKLIGHT_DEVICE ".KBQC"
 #define ACPI_KEYBOARD_BACKLIGHT_WRITE	ACPI_KEYBOARD_BACKLIGHT_DEVICE ".KBCM"
 
-#define ACPI_KEYBOARD_BACKLIGHT_MAX		100
-
 static void keyboard_led_set_brightness_acpi(struct led_classdev *cdev,
 					     enum led_brightness brightness)
 {
@@ -107,7 +114,7 @@ static const struct keyboard_led_drvdata keyboard_led_drvdata_acpi = {
 	.init = keyboard_led_init_acpi,
 	.brightness_set = keyboard_led_set_brightness_acpi,
 	.brightness_get = keyboard_led_get_brightness_acpi,
-	.max_brightness = ACPI_KEYBOARD_BACKLIGHT_MAX,
+	.max_brightness = KEYBOARD_BACKLIGHT_MAX,
 };
 
 #else /* IS_ENABLED(CONFIG_CROS_KBD_LED_BACKLIGHT_ACPI) */
@@ -123,34 +130,122 @@ static const struct keyboard_led_drvdata keyboard_led_drvdata_acpi = {
 
 #endif /* IS_ENABLED(CONFIG_CROS_KBD_LED_BACKLIGHT_ACPI) */
 
+#if IS_ENABLED(CONFIG_CROS_KBD_LED_BACKLIGHT_EC_PWM)
+
+static int
+keyboard_led_set_brightness_blocking_ec_pwm(struct led_classdev *cdev,
+					    enum led_brightness brightness)
+{
+	struct {
+		struct cros_ec_command msg;
+		struct ec_params_pwm_set_keyboard_backlight params;
+	} __packed buf;
+	struct ec_params_pwm_set_keyboard_backlight *params = &buf.params;
+	struct cros_ec_command *msg = &buf.msg;
+	struct keyboard_led_private *private =
+		container_of(cdev, struct keyboard_led_private, cdev);
+
+	memset(&buf, 0, sizeof(buf));
+
+	msg->version = 0;
+	msg->command = EC_CMD_PWM_SET_KEYBOARD_BACKLIGHT;
+	msg->insize = 0;
+	msg->outsize = sizeof(*params);
+
+	params->percent = brightness;
+
+	return cros_ec_cmd_xfer_status(private->ec, msg);
+}
+
+static enum led_brightness
+keyboard_led_get_brightness_ec_pwm(struct led_classdev *cdev)
+{
+	struct {
+		struct cros_ec_command msg;
+		struct ec_response_pwm_get_keyboard_backlight resp;
+	} __packed buf;
+	struct ec_response_pwm_get_keyboard_backlight *resp = &buf.resp;
+	struct cros_ec_command *msg = &buf.msg;
+	struct keyboard_led_private *private =
+		container_of(cdev, struct keyboard_led_private, cdev);
+	int ret;
+
+	memset(&buf, 0, sizeof(buf));
+
+	msg->version = 0;
+	msg->command = EC_CMD_PWM_GET_KEYBOARD_BACKLIGHT;
+	msg->insize = sizeof(*resp);
+	msg->outsize = 0;
+
+	ret = cros_ec_cmd_xfer_status(private->ec, msg);
+	if (ret < 0)
+		return ret;
+
+	return resp->percent;
+}
+
+static int keyboard_led_init_ec_pwm(struct platform_device *pdev)
+{
+	struct keyboard_led_private *private = platform_get_drvdata(pdev);
+
+	private->ec = dev_get_drvdata(pdev->dev.parent);
+	if (!private->ec) {
+		dev_err(&pdev->dev, "no parent EC device\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {
+	.init = keyboard_led_init_ec_pwm,
+	.brightness_set_blocking = keyboard_led_set_brightness_blocking_ec_pwm,
+	.brightness_get = keyboard_led_get_brightness_ec_pwm,
+	.max_brightness = KEYBOARD_BACKLIGHT_MAX,
+};
+
+#else /* IS_ENABLED(CONFIG_CROS_KBD_LED_BACKLIGHT_EC_PWM) */
+
+static int keyboard_led_init_ec_pwm_null(struct platform_device *pdev)
+{
+	return -EOPNOTSUPP;
+}
+
+static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {
+	.init = keyboard_led_init_ec_pwm_null,
+};
+
+#endif /* IS_ENABLED(CONFIG_CROS_KBD_LED_BACKLIGHT_EC_PWM) */
+
 static int keyboard_led_probe(struct platform_device *pdev)
 {
-	struct led_classdev *cdev;
 	const struct keyboard_led_drvdata *drvdata;
+	struct keyboard_led_private *private;
 	int error;
 
 	drvdata = device_get_match_data(&pdev->dev);
 	if (!drvdata)
 		return -EINVAL;
 
+	private = devm_kzalloc(&pdev->dev, sizeof(*private), GFP_KERNEL);
+	if (!private)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, private);
+
 	if (drvdata->init) {
 		error = drvdata->init(pdev);
 		if (error)
 			return error;
 	}
 
-	cdev = devm_kzalloc(&pdev->dev, sizeof(*cdev), GFP_KERNEL);
-	if (!cdev)
-		return -ENOMEM;
-
-	cdev->name = "chromeos::kbd_backlight";
-	cdev->flags |= LED_CORE_SUSPENDRESUME;
-	cdev->max_brightness = drvdata->max_brightness;
-	cdev->brightness_set = drvdata->brightness_set;
-	cdev->brightness_set_blocking = drvdata->brightness_set_blocking;
-	cdev->brightness_get = drvdata->brightness_get;
+	private->cdev.name = "chromeos::kbd_backlight";
+	private->cdev.flags |= LED_CORE_SUSPENDRESUME;
+	private->cdev.max_brightness = drvdata->max_brightness;
+	private->cdev.brightness_set = drvdata->brightness_set;
+	private->cdev.brightness_set_blocking = drvdata->brightness_set_blocking;
+	private->cdev.brightness_get = drvdata->brightness_get;
 
-	error = devm_led_classdev_register(&pdev->dev, cdev);
+	error = devm_led_classdev_register(&pdev->dev, &private->cdev);
 	if (error)
 		return error;
 
@@ -169,6 +264,7 @@ MODULE_DEVICE_TABLE(acpi, keyboard_led_acpi_match);
 static const struct of_device_id keyboard_led_of_match[] = {
 	{
 		.compatible = "google,cros-kbd-led-backlight",
+		.data = &keyboard_led_drvdata_ec_pwm,
 	},
 	{}
 };
-- 
2.35.1.723.g4982287a31-goog

