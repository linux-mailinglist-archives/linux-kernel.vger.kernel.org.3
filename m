Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084C04D7E46
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 10:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237888AbiCNJKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 05:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237862AbiCNJKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 05:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CA542A3F;
        Mon, 14 Mar 2022 02:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57980612C5;
        Mon, 14 Mar 2022 09:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73166C340E9;
        Mon, 14 Mar 2022 09:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647248953;
        bh=BPBQ/VX/IKiPRs7Ob5fSE29vKLC3yU2YLakDP89mHZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ETYSt4+U9c7/RZqN6mHOmvsGzCGnG16moR79KAnpnCrFmzzafmX1XftSNExR5AeIQ
         V516NQZdClgvufQXPFKeAZxzy1WVVNhqUqmcKFBJuDGz95M5LKx4W2VYEqXbNC2R2A
         RECVht+dJ91yOqT8rtVwjpffsf/b5Ba//UZcBFp21aKmmI6euBUtdtrCzmDboimvRP
         sdVJhZd4AbcZTTtqURUgfl1divs2bNMUbb7qPkXn2XSEhagnqmbEOOxgCctluyQFls
         12gpc9w0hk0MiHM2+C5hUMOf22L3x1Kie9a4BoFkQeN6Y5vUue1nvseMgg+rBUzscg
         hqsyEv86fzbLQ==
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, tzungbi@kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] platform/chrome: cros_kbd_led_backlight: separate ACPI backend
Date:   Mon, 14 Mar 2022 17:08:32 +0800
Message-Id: <20220314090835.3822093-3-tzungbi@kernel.org>
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

cros_kbd_led_backlight uses ACPI_KEYBOARD_BACKLIGHT_WRITE and
ACPI_KEYBOARD_BACKLIGHT_READ for setting and getting the brightness
respectively.

Separate ACPI operations as an independent option for preparing the
driver to support other backends.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
Changes from v1:
- Update email address accordingly.
- Use CONFIG_ACPI guard per "kernel test robot <lkp@intel.com>" reported an
  unused variable issue.

 drivers/platform/chrome/Kconfig               |  8 +-
 .../platform/chrome/cros_kbd_led_backlight.c  | 93 ++++++++++++++++---
 2 files changed, 87 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index ccc23d8686e8..3f74679a556c 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -128,7 +128,7 @@ config CROS_EC_PROTO
 
 config CROS_KBD_LED_BACKLIGHT
 	tristate "Backlight LED support for Chrome OS keyboards"
-	depends on LEDS_CLASS && ACPI
+	depends on LEDS_CLASS
 	help
 	  This option enables support for the keyboard backlight LEDs on
 	  select Chrome OS systems.
@@ -136,6 +136,12 @@ config CROS_KBD_LED_BACKLIGHT
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_kbd_led_backlight.
 
+config CROS_KBD_LED_BACKLIGHT_ACPI
+	bool "ChromeOS keyboard backlight ACPI backend"
+	depends on ACPI && CROS_KBD_LED_BACKLIGHT
+	help
+	  ChromeOS keyboard backlight ACPI backend.
+
 config CROS_EC_CHARDEV
 	tristate "ChromeOS EC miscdevice"
 	depends on MFD_CROS_EC_DEV
diff --git a/drivers/platform/chrome/cros_kbd_led_backlight.c b/drivers/platform/chrome/cros_kbd_led_backlight.c
index f9587a562bb7..e26d1d4cd801 100644
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
+#if IS_ENABLED(CONFIG_CROS_KBD_LED_BACKLIGHT_ACPI)
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
@@ -73,15 +98,55 @@ static int keyboard_led_probe(struct platform_device *pdev)
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
+#else /* IS_ENABLED(CONFIG_CROS_KBD_LED_BACKLIGHT_ACPI) */
+
+static int keyboard_led_init_acpi_null(struct platform_device *pdev)
+{
+	return -EOPNOTSUPP;
+}
+
+static const struct keyboard_led_drvdata keyboard_led_drvdata_acpi = {
+	.init = keyboard_led_init_acpi_null,
+};
+
+#endif /* IS_ENABLED(CONFIG_CROS_KBD_LED_BACKLIGHT_ACPI) */
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
@@ -90,16 +155,18 @@ static int keyboard_led_probe(struct platform_device *pdev)
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
2.35.1.723.g4982287a31-goog

