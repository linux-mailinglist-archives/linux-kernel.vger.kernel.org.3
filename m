Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F314B4170
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 06:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbiBNFiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 00:38:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiBNFhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 00:37:54 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41864EA1B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:37:46 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id s10-20020a17090a948a00b001b96be201f6so6034966pjo.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 21:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=29uHVdHAQSqiT8vvfXqlsD57wZoWh7bXiS10RQ7W7Qg=;
        b=Pr0sIocwVERST9JG5yNYFzh4bfH0oj29aF92lMVCUeQOm5sHkFEyreYdobAZHbm+fl
         yoZIypGvnAv5RfDCLvM/pLGbDC4x0obhy9+lnxLPI5zUEzjeypIr9E28KbcI4AeFqjJu
         ZeWzJay7J/rvPFUygr8T5Jl+7ceUQ7RCI3sZJK1Vqi2yfFkBynrs9FPgUcW3KegJdiPg
         ESxlTYktuJa4Gwj08a7M7G61QWkd6KA6+UCFSEMm6Ox+k6MmkjO8CFPRxQ8xtb5ldNAr
         g6r6P4K5nvWlvrYrCJBurEVE4CIehOCiipVhujNJzPHQzoUwAUPSxafHl7bZMF/mcdX2
         SLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=29uHVdHAQSqiT8vvfXqlsD57wZoWh7bXiS10RQ7W7Qg=;
        b=PHhaYGsoeeAU6k3TwXlH+XYnjwhJ0En7DOiE5D7yEqutsf6d83TPhTpqtNw3T4P9PK
         JIXq7JhwnbXzgd7d4VAvrbjehEyzwyzvw7gcMp0KfcRG2EOUneBGJpT2QEWr8cvJYXCw
         4nSt/AMkMUt0hJCmP2BGg4mjejkNE+xMYU5BhNjW9YZeVoII5dXdEXzVA/G3qkCuUF1a
         yIxquJR6aK4WPPaaH7cBy7YjIK4/C3P8nXzWFiPO+VQRGdXXF6mUIyFuLLUdc5Ws/Snu
         cxaIygmmaagLgYYcvoWM2IGhElXgfQgjFlV8ikFSnWjsYru7O+2v0AxtZzCNRGK37aB8
         yNZg==
X-Gm-Message-State: AOAM532GCj6HuJCC1PcUZo0AV911GxpZKdTeJRokAXLN6GcDQP9O+621
        y2qJdeKRNuqM8kSeVKIhPhwfqpyXv7Ck
X-Google-Smtp-Source: ABdhPJxKNKGdvDYl8ykS+dHO1ASu06EfmVMuaH4MZLhystWtVyLkcNMLBCQkNjLLUXLqBRdA9t3NMsHsmNHz
X-Received: from tzungbi-z840.tpe.corp.google.com ([2401:fa00:1:10:f315:f92d:e3d3:2539])
 (user=tzungbi job=sendgmr) by 2002:a62:ce06:: with SMTP id
 y6mr1345902pfg.85.1644817066460; Sun, 13 Feb 2022 21:37:46 -0800 (PST)
Date:   Mon, 14 Feb 2022 13:36:46 +0800
In-Reply-To: <20220214053646.3088298-1-tzungbi@google.com>
Message-Id: <20220214053646.3088298-6-tzungbi@google.com>
Mime-Version: 1.0
References: <20220214053646.3088298-1-tzungbi@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH 5/5] platform/chrome: cros_kbd_led_backlight: support EC PWM backend
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

EC PWM backend uses EC_CMD_PWM_SET_KEYBOARD_BACKLIGHT and
EC_CMD_PWM_GET_KEYBOARD_BACKLIGHT for setting and getting the brightness
respectively.

Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
---
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
index ba853e55d29a..d655cf5bc960 100644
--- a/drivers/platform/chrome/cros_kbd_led_backlight.c
+++ b/drivers/platform/chrome/cros_kbd_led_backlight.c
@@ -11,9 +11,16 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/platform_data/cros_ec_commands.h>
+#include <linux/platform_data/cros_ec_proto.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+struct keyboard_led_private {
+	struct led_classdev cdev;
+	struct cros_ec_device *ec;
+};
+
 /**
  * struct keyboard_led_drvdata - keyboard LED driver data.
  * @init:			Init function.
@@ -39,6 +46,8 @@ struct keyboard_led_drvdata {
 	enum led_brightness max_brightness;
 };
 
+#define KEYBOARD_BACKLIGHT_MAX 100
+
 #if IS_ENABLED(CONFIG_CROS_KBD_LED_BACKLIGHT_ACPI)
 
 /* Keyboard LED ACPI Device must be defined in firmware */
@@ -46,8 +55,6 @@ struct keyboard_led_drvdata {
 #define ACPI_KEYBOARD_BACKLIGHT_READ	ACPI_KEYBOARD_BACKLIGHT_DEVICE ".KBQC"
 #define ACPI_KEYBOARD_BACKLIGHT_WRITE	ACPI_KEYBOARD_BACKLIGHT_DEVICE ".KBCM"
 
-#define ACPI_KEYBOARD_BACKLIGHT_MAX		100
-
 static void keyboard_led_set_brightness_acpi(struct led_classdev *cdev,
 					     enum led_brightness brightness)
 {
@@ -106,7 +113,7 @@ static const struct keyboard_led_drvdata keyboard_led_drvdata_acpi = {
 	.init = keyboard_led_init_acpi,
 	.brightness_set = keyboard_led_set_brightness_acpi,
 	.brightness_get = keyboard_led_get_brightness_acpi,
-	.max_brightness = ACPI_KEYBOARD_BACKLIGHT_MAX,
+	.max_brightness = KEYBOARD_BACKLIGHT_MAX,
 };
 
 #else /* IS_ENABLED(CONFIG_CROS_KBD_LED_BACKLIGHT_ACPI) */
@@ -122,10 +129,97 @@ static const struct keyboard_led_drvdata keyboard_led_drvdata_acpi = {
 
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
 
 	drvdata = acpi_device_get_match_data(&pdev->dev);
@@ -135,24 +229,25 @@ static int keyboard_led_probe(struct platform_device *pdev)
 			return -EINVAL;
 	}
 
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
 
@@ -168,6 +263,7 @@ MODULE_DEVICE_TABLE(acpi, keyboard_led_acpi_match);
 static const struct of_device_id keyboard_led_of_match[] = {
 	{
 		.compatible = "google,cros-kbd-led-backlight",
+		.data = &keyboard_led_drvdata_ec_pwm,
 	},
 	{}
 };
-- 
2.35.1.265.g69c8d7142f-goog

