Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B16530E34
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiEWJJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiEWJJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:09:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD1A4507C;
        Mon, 23 May 2022 02:09:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0B7860F84;
        Mon, 23 May 2022 09:08:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E960C36AE5;
        Mon, 23 May 2022 09:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653296939;
        bh=rIFpUgFbYYJCuRyZO6yCCt9+l07s4JFTgK0X7jWKLI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MdspXEm0IsQ7B80hm50yfU69NDLgB3p9iEgoabB4MgMTng5sAnqG4ZsBmD9HCK2tz
         cDSunYbb+w5e7/TYDKKiHYg9L/pOlzIGVja0dBjN5isALVtD0N69bLK2toyKascN/z
         OzCPGiDNvhy6/JNPEwIZQCyisR3c/MGqXAECE5drFzmG2MOost9fmCmSTvUjkodnsH
         zPC+Wtq/GYsGO0JMfq+7AhqfHlROBjY450T3PmIvmCLf1NGBFm+mRiFmN5e4c40HRf
         s+zYwSs1SIn50Q+LURSLVzXF50PTnSSll3R15oBIdobimRZxuYa81A/l0gYq9kqcnG
         Pyv+g8ZU9IUeg==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        mka@chromium.org, devicetree@vger.kernel.org, tzungbi@kernel.org
Subject: [PATCH v4 5/5] platform/chrome: cros_kbd_led_backlight: support EC PWM backend
Date:   Mon, 23 May 2022 17:08:22 +0800
Message-Id: <20220523090822.3035189-6-tzungbi@kernel.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
In-Reply-To: <20220523090822.3035189-1-tzungbi@kernel.org>
References: <20220523090822.3035189-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Changes from v3:
- Remove CROS_KBD_LED_BACKLIGHT_EC_PWM Kconfig.
- Remove stub function.
- Remove redundant variable assignments.
- Remove the "private" term.

Changes from v2:
- Turn CROS_KBD_LED_BACKLIGHT_EC_PWM to boolean.
- Use #ifdef for boolean CROS_KBD_LED_BACKLIGHT_EC_PWM.

Changes from v1:
- Update email address accordingly.

 drivers/platform/chrome/Kconfig               |   2 +-
 .../platform/chrome/cros_kbd_led_backlight.c  | 113 +++++++++++++++---
 2 files changed, 99 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index 717299cbccac..3caf3194e3f5 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -139,7 +139,7 @@ config CROS_EC_PROTO
 
 config CROS_KBD_LED_BACKLIGHT
 	tristate "Backlight LED support for Chrome OS keyboards"
-	depends on LEDS_CLASS && ACPI
+	depends on LEDS_CLASS && (ACPI || CROS_EC)
 	help
 	  This option enables support for the keyboard backlight LEDs on
 	  select Chrome OS systems.
diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
index 4bca880d7721..5ad41c10412d 100644
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
 
+struct keyboard_led {
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
 #ifdef CONFIG_ACPI
 
 /* Keyboard LED ACPI Device must be defined in firmware */
@@ -47,8 +56,6 @@ struct keyboard_led_drvdata {
 #define ACPI_KEYBOARD_BACKLIGHT_READ	ACPI_KEYBOARD_BACKLIGHT_DEVICE ".KBQC"
 #define ACPI_KEYBOARD_BACKLIGHT_WRITE	ACPI_KEYBOARD_BACKLIGHT_DEVICE ".KBCM"
 
-#define ACPI_KEYBOARD_BACKLIGHT_MAX		100
-
 static void keyboard_led_set_brightness_acpi(struct led_classdev *cdev,
 					     enum led_brightness brightness)
 {
@@ -107,39 +114,114 @@ static const struct keyboard_led_drvdata keyboard_led_drvdata_acpi = {
 	.init = keyboard_led_init_acpi,
 	.brightness_set = keyboard_led_set_brightness_acpi,
 	.brightness_get = keyboard_led_get_brightness_acpi,
-	.max_brightness = ACPI_KEYBOARD_BACKLIGHT_MAX,
+	.max_brightness = KEYBOARD_BACKLIGHT_MAX,
 };
 
 #endif /* CONFIG_ACPI */
 
+#ifdef CONFIG_CROS_EC
+
+static int
+keyboard_led_set_brightness_ec_pwm(struct led_classdev *cdev,
+				   enum led_brightness brightness)
+{
+	struct {
+		struct cros_ec_command msg;
+		struct ec_params_pwm_set_keyboard_backlight params;
+	} __packed buf;
+	struct ec_params_pwm_set_keyboard_backlight *params = &buf.params;
+	struct cros_ec_command *msg = &buf.msg;
+	struct keyboard_led *keyboard_led = container_of(cdev, struct keyboard_led, cdev);
+
+	memset(&buf, 0, sizeof(buf));
+
+	msg->command = EC_CMD_PWM_SET_KEYBOARD_BACKLIGHT;
+	msg->outsize = sizeof(*params);
+
+	params->percent = brightness;
+
+	return cros_ec_cmd_xfer_status(keyboard_led->ec, msg);
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
+	struct keyboard_led *keyboard_led = container_of(cdev, struct keyboard_led, cdev);
+	int ret;
+
+	memset(&buf, 0, sizeof(buf));
+
+	msg->command = EC_CMD_PWM_GET_KEYBOARD_BACKLIGHT;
+	msg->insize = sizeof(*resp);
+
+	ret = cros_ec_cmd_xfer_status(keyboard_led->ec, msg);
+	if (ret < 0)
+		return ret;
+
+	return resp->percent;
+}
+
+static int keyboard_led_init_ec_pwm(struct platform_device *pdev)
+{
+	struct keyboard_led *keyboard_led = platform_get_drvdata(pdev);
+
+	keyboard_led->ec = dev_get_drvdata(pdev->dev.parent);
+	if (!keyboard_led->ec) {
+		dev_err(&pdev->dev, "no parent EC device\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {
+	.init = keyboard_led_init_ec_pwm,
+	.brightness_set_blocking = keyboard_led_set_brightness_ec_pwm,
+	.brightness_get = keyboard_led_get_brightness_ec_pwm,
+	.max_brightness = KEYBOARD_BACKLIGHT_MAX,
+};
+
+#else /* CONFIG_CROS_EC */
+
+static const struct keyboard_led_drvdata keyboard_led_drvdata_ec_pwm = {};
+
+#endif /* CONFIG_CROS_EC */
+
 static int keyboard_led_probe(struct platform_device *pdev)
 {
-	struct led_classdev *cdev;
 	const struct keyboard_led_drvdata *drvdata;
+	struct keyboard_led *keyboard_led;
 	int error;
 
 	drvdata = device_get_match_data(&pdev->dev);
 	if (!drvdata)
 		return -EINVAL;
 
+	keyboard_led = devm_kzalloc(&pdev->dev, sizeof(*keyboard_led), GFP_KERNEL);
+	if (!keyboard_led)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, keyboard_led);
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
+	keyboard_led->cdev.name = "chromeos::kbd_backlight";
+	keyboard_led->cdev.flags |= LED_CORE_SUSPENDRESUME;
+	keyboard_led->cdev.max_brightness = drvdata->max_brightness;
+	keyboard_led->cdev.brightness_set = drvdata->brightness_set;
+	keyboard_led->cdev.brightness_set_blocking = drvdata->brightness_set_blocking;
+	keyboard_led->cdev.brightness_get = drvdata->brightness_get;
 
-	error = devm_led_classdev_register(&pdev->dev, cdev);
+	error = devm_led_classdev_register(&pdev->dev, &keyboard_led->cdev);
 	if (error)
 		return error;
 
@@ -158,6 +240,7 @@ MODULE_DEVICE_TABLE(acpi, keyboard_led_acpi_match);
 static const struct of_device_id keyboard_led_of_match[] = {
 	{
 		.compatible = "google,cros-kbd-led-backlight",
+		.data = &keyboard_led_drvdata_ec_pwm,
 	},
 	{}
 };
-- 
2.36.1.124.g0e6072fb45-goog

