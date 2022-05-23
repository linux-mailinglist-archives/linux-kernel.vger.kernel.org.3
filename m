Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88213530E3C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiEWJJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiEWJI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:08:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34A945058;
        Mon, 23 May 2022 02:08:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D58AB80FA6;
        Mon, 23 May 2022 09:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B158BC3411A;
        Mon, 23 May 2022 09:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653296933;
        bh=j0siKCr2t3cIHVL6rBUrteD0xCpUE62iGsH1eC3VLAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jqCaTQ73ncMw9xmIs8VYv2wtzlXx5fSyGOHnUJ5Hpij46D05mDLnC2zukvvOjkMCh
         c7xHhFz4T1lZJQaNDxfafUQ2Y9+AFox4GlGtIpbvYFqgL0Kz6gpWj8DCQaoRZevw1d
         XZz/IxelExgPj32+gyjdSlZirrHN56oRPBJPJAE1+1iXqvC4Sfo0hgH+kOwVoOpZ2p
         QBiZgfNWfTU1NMLXupfHHIVd5ugRlLS+jGMgain4TzZLpIO9J91mzqAoeBypMtcTnQ
         YdfVoR2Kz8FFk20Vwmgm9SwMpkgxaw99nEmZO/xLOquyKGVHlE/Sb7oBvJeQftHAYW
         BfmF72QwCVVCw==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org
Cc:     chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        mka@chromium.org, devicetree@vger.kernel.org, tzungbi@kernel.org
Subject: [PATCH v4 2/5] platform/chrome: cros_kbd_led_backlight: separate ACPI backend
Date:   Mon, 23 May 2022 17:08:19 +0800
Message-Id: <20220523090822.3035189-3-tzungbi@kernel.org>
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

cros_kbd_led_backlight uses ACPI_KEYBOARD_BACKLIGHT_WRITE and
ACPI_KEYBOARD_BACKLIGHT_READ for setting and getting the brightness
respectively.

Separate ACPI operations for preparing the driver to support other
backends.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v3:
- Remove CROS_KBD_LED_BACKLIGHT_ACPI Kconfig.
- Remove stub function.

Changes from v2:
- Use #ifdef for boolean CONFIG_CROS_KBD_LED_BACKLIGHT_ACPI.

Changes from v1:
- Update email address accordingly.
- Use CONFIG_ACPI guard per "kernel test robot <lkp@intel.com>" reported an
  unused variable issue.

 .../platform/chrome/cros_kbd_led_backlight.c  | 82 ++++++++++++++++---
 1 file changed, 69 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
index f9587a562bb7..a86d664854ae 100644
--- a/drivers/platform/chrome/cros_kbd_led_backlight.c
+++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
@@ -13,6 +13,33 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+/**
+ * struct keyboard_led_drvdata - keyboard LED driver data.
+ * @init:			Init function.
+ * @brightness_get:		Get LED brightness level.
+ * @brightness_set:		Set LED brightness level.  Must not sleep.
+ * @brightness_set_blocking:	Set LED brightness level.  It can block the
+ *				caller for the time required for accessing a
+ *				LED device register
+ * @max_brightness:		Maximum brightness.
+ *
+ * See struct led_classdev in include/linux/leds.h for more details.
+ */
+struct keyboard_led_drvdata {
+	int (*init)(struct platform_device *pdev);
+
+	enum led_brightness (*brightness_get)(struct led_classdev *led_cdev);
+
+	void (*brightness_set)(struct led_classdev *led_cdev,
+			       enum led_brightness brightness);
+	int (*brightness_set_blocking)(struct led_classdev *led_cdev,
+				       enum led_brightness brightness);
+
+	enum led_brightness max_brightness;
+};
+
+#ifdef CONFIG_ACPI
+
 /* Keyboard LED ACPI Device must be defined in firmware */
 #define ACPI_KEYBOARD_BACKLIGHT_DEVICE	"\\_SB.KBLT"
 #define ACPI_KEYBOARD_BACKLIGHT_READ	ACPI_KEYBOARD_BACKLIGHT_DEVICE ".KBQC"
@@ -20,8 +47,8 @@
 
 #define ACPI_KEYBOARD_BACKLIGHT_MAX		100
 
-static void keyboard_led_set_brightness(struct led_classdev *cdev,
-					enum led_brightness brightness)
+static void keyboard_led_set_brightness_acpi(struct led_classdev *cdev,
+					     enum led_brightness brightness)
 {
 	union acpi_object param;
 	struct acpi_object_list input;
@@ -40,7 +67,7 @@ static void keyboard_led_set_brightness(struct led_classdev *cdev,
 }
 
 static enum led_brightness
-keyboard_led_get_brightness(struct led_classdev *cdev)
+keyboard_led_get_brightness_acpi(struct led_classdev *cdev)
 {
 	unsigned long long brightness;
 	acpi_status status;
@@ -56,12 +83,10 @@ keyboard_led_get_brightness(struct led_classdev *cdev)
 	return brightness;
 }
 
-static int keyboard_led_probe(struct platform_device *pdev)
+static int keyboard_led_init_acpi(struct platform_device *pdev)
 {
-	struct led_classdev *cdev;
 	acpi_handle handle;
 	acpi_status status;
-	int error;
 
 	/* Look for the keyboard LED ACPI Device */
 	status = acpi_get_handle(ACPI_ROOT_OBJECT,
@@ -73,15 +98,44 @@ static int keyboard_led_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
+	return 0;
+}
+
+static const struct keyboard_led_drvdata keyboard_led_drvdata_acpi = {
+	.init = keyboard_led_init_acpi,
+	.brightness_set = keyboard_led_set_brightness_acpi,
+	.brightness_get = keyboard_led_get_brightness_acpi,
+	.max_brightness = ACPI_KEYBOARD_BACKLIGHT_MAX,
+};
+
+#endif /* CONFIG_ACPI */
+
+static int keyboard_led_probe(struct platform_device *pdev)
+{
+	struct led_classdev *cdev;
+	const struct keyboard_led_drvdata *drvdata;
+	int error;
+
+	drvdata = acpi_device_get_match_data(&pdev->dev);
+	if (!drvdata)
+		return -EINVAL;
+
+	if (drvdata->init) {
+		error = drvdata->init(pdev);
+		if (error)
+			return error;
+	}
+
 	cdev = devm_kzalloc(&pdev->dev, sizeof(*cdev), GFP_KERNEL);
 	if (!cdev)
 		return -ENOMEM;
 
 	cdev->name = "chromeos::kbd_backlight";
-	cdev->max_brightness = ACPI_KEYBOARD_BACKLIGHT_MAX;
 	cdev->flags |= LED_CORE_SUSPENDRESUME;
-	cdev->brightness_set = keyboard_led_set_brightness;
-	cdev->brightness_get = keyboard_led_get_brightness;
+	cdev->max_brightness = drvdata->max_brightness;
+	cdev->brightness_set = drvdata->brightness_set;
+	cdev->brightness_set_blocking = drvdata->brightness_set_blocking;
+	cdev->brightness_get = drvdata->brightness_get;
 
 	error = devm_led_classdev_register(&pdev->dev, cdev);
 	if (error)
@@ -90,16 +144,18 @@ static int keyboard_led_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct acpi_device_id keyboard_led_id[] = {
-	{ "GOOG0002", 0 },
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id keyboard_led_acpi_match[] = {
+	{ "GOOG0002", (kernel_ulong_t)&keyboard_led_drvdata_acpi },
 	{ }
 };
-MODULE_DEVICE_TABLE(acpi, keyboard_led_id);
+MODULE_DEVICE_TABLE(acpi, keyboard_led_acpi_match);
+#endif
 
 static struct platform_driver keyboard_led_driver = {
 	.driver		= {
 		.name	= "chromeos-keyboard-leds",
-		.acpi_match_table = ACPI_PTR(keyboard_led_id),
+		.acpi_match_table = ACPI_PTR(keyboard_led_acpi_match),
 	},
 	.probe		= keyboard_led_probe,
 };
-- 
2.36.1.124.g0e6072fb45-goog

