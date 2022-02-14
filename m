Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958084B416F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 06:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240478AbiBNFho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 00:37:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240460AbiBNFhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:37:41 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156B74EA35
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:37:34 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c10-20020a251c0a000000b0062272fc32bfso7053389ybc.17
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mvUncpaYliSmeR41+C/l/4otzikQqLf0u/Gn7UTF124=;
        b=CgnY/Etxq1CyrqQlo1UL4rL1ybmB5rCQ+6pY/MvGGHYyeaRQsk2wYMLegZQZEcwZsJ
         NyGIccHYFaOnm98G3N7N85lg3DLRQ7xGG5rxkwVD7W95E1+D1weAeD1yk3Q10IZ6Amt0
         Hw8qX+xAGOHGlE0R+X5VypIs+M8lpKY2gB5VlccfDK524l+q/KlnvnXOk3phmLmmhOdC
         TWGytAKQp4Gjxj/7h2Ud6bRoDWdzV9b0SiI//E+GziCKNvcwaptlfJuY47cilCo+nf3/
         m9Jx0k1qUxPpzzVO1nVgKvVuUO5dymF7qS3N42RoXWnbLGLQh/LgCxMxVBKPecZ3yFY9
         XkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mvUncpaYliSmeR41+C/l/4otzikQqLf0u/Gn7UTF124=;
        b=nwIVFPLn/BhEjnNpKeLY2HUkISBFU8SG2TDmQm+197Op0kkUCXaaM5H7jWKUH/P8xI
         4n7/zMED7OYtuDP5zxZUAL58FrxZbg29OmkJhZSYgiWacO7Evm01kD9hqRf0KjOTj97R
         ynZWHm1/wV28lhzMR2rI13nEPktYaANaJm0UKyweuRzpKGO/ymP3DJYE7ltX2SY/jjEJ
         3z7vLBjk/FjmxwpBVrg4BXgscf5MDux1Dm8W7FCEGX6Z45ZC3C15rHOOH81oF4zzIxzb
         mwvCbuHT6fibgPA6KghUfElsuyKbOHrqwvdnNsRfFmfgWzISt2FeBiU0gLrjofBdMNoB
         IqNA==
X-Gm-Message-State: AOAM5326+azHVgGHg1aS9QlWhNoIhfqg0YqNH9Ljk+3ZQqECKjagb5rD
        4evbcdpMZEyDGXbC3BX/cZuC1SkLn/lm
X-Google-Smtp-Source: ABdhPJyvjfHE/YYj+ehvCI5kt0131cYqhmHlQgRbK0thqB8SDSpmLWhwKARAD9ExhYgg6qDWIzUjIoLS8icM
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:f315:f92d:e3d3:2539])
 (user=tzungbi job=sendgmr) by 2002:a25:d9ce:: with SMTP id
 q197mr10879482ybg.739.1644817053360; Sun, 13 Feb 2022 21:37:33 -0800 (PST)
Date:   Mon, 14 Feb 2022 13:36:43 +0800
In-Reply-To: <20220214053646.3088298-1-tzungbi@google.com>
Message-Id: <20220214053646.3088298-3-tzungbi@google.com>
Mime-Version: 1.0
References: <20220214053646.3088298-1-tzungbi@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 2/5] platform/chrome: cros_kbd_led_backlight: separate ACPI backend
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     bleung@chromium.org, groeck@chromium.org, robh+dt@kernel.org
Cc:     chrome-platform@lists.linux.dev, tzungbi@google.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
 drivers/platform/chrome/Kconfig               |  8 +-
 .../platform/chrome/cros_kbd_led_backlight.c  | 91 ++++++++++++++++---
 2 files changed, 85 insertions(+), 14 deletions(-)

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
index f9587a562bb7..814f2b74c602 100644
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
@@ -90,16 +155,16 @@ static int keyboard_led_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct acpi_device_id keyboard_led_id[] = {
-	{ "GOOG0002", 0 },
+static const struct acpi_device_id keyboard_led_acpi_match[] = {
+	{ "GOOG0002", (kernel_ulong_t)&keyboard_led_drvdata_acpi },
 	{ }
 };
-MODULE_DEVICE_TABLE(acpi, keyboard_led_id);
+MODULE_DEVICE_TABLE(acpi, keyboard_led_acpi_match);
 
 static struct platform_driver keyboard_led_driver = {
 	.driver		= {
 		.name	= "chromeos-keyboard-leds",
-		.acpi_match_table = ACPI_PTR(keyboard_led_id),
+		.acpi_match_table = ACPI_PTR(keyboard_led_acpi_match),
 	},
 	.probe		= keyboard_led_probe,
 };
-- 
2.35.1.265.g69c8d7142f-goog

