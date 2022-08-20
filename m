Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B664E59AC25
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 09:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344197AbiHTHS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 03:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344272AbiHTHSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 03:18:12 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD63C924F;
        Sat, 20 Aug 2022 00:18:07 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id w13so226732pgq.7;
        Sat, 20 Aug 2022 00:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1mL44LhgVNAFqi2qF+fV+oSg58Nxy3pqMbmee8fAK+0=;
        b=k/9Qd7lhzIbswn34lMy3BZO+KFiTLJosJsO4Qa6imOg60/0KwOMasJF59XXma78+xB
         fcc6qpftoIG2AfJrCpq3xRl7Rqgao2O/IzyB6NGzXvOXBffiYsO6LmsxxNOTZX+XJ2bG
         FPgrIXSujEejGI+QDDStCkxXHVhylaOrzYMIVVezvsW/lspgpIv2DwxVlGQY0VpbKVrm
         QEwn4C+c1hQf16GdwG/qf2RgqQG5GnK+4lazSgH60wbNF4S9gOnoowbsge3wCU0FGXjl
         SOQUw3WbyuZ/pBBRlsupfKr/zZdtkK7rX+rGQSc6Y1IspDhEFg5dq/hEYJ2aj/W9KYK0
         IWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1mL44LhgVNAFqi2qF+fV+oSg58Nxy3pqMbmee8fAK+0=;
        b=ohKDcu2jx1b+ZLKBk8b0WZCZuTBMb0D5FtlIfg3qnNHmN/jeUQgdX2BKtq+w7SApLC
         bVjj83SQfWWkIyECqH0uR7V3v0lwUYEB6NwyuGQ+gNMAgzcz43SjLaoJesmfJdz+SWdW
         v/B0nlJZTRNDRTYQs+LkqX5QsXIUQq82pl7JJpXLE2glwX5IOTISlZPwabTmHZ/4hHR8
         DtzjOd4gbN5TX5zyv2VSXmsSi7ao5Qb+ILBX6XnxJIwRZndxZFRQ6E/eeMF+o9T1tB5W
         Cr8ALmWzZMW8jJ+IIezeWjzToBZknY7RU+APr2V1UkTRjMTODQy+XZrraft7D3srt3TX
         S38Q==
X-Gm-Message-State: ACgBeo3v/TOICfM63qXf8N4WCWVJZZJngjQzBxe2m6dsXMkDDyHGNpD/
        7MU/iVDq1fnkcnAXGX19Eb20C2W+CNp6VVnWVeE=
X-Google-Smtp-Source: AA6agR4NxGnfZRo5gdcgBhdmQCqmhzWFRG8VI6JLloAAkzGDFS+5cm6dfx1sXHOQFYhAP+fUg/5wgA==
X-Received: by 2002:a63:82c8:0:b0:42a:498e:93ae with SMTP id w191-20020a6382c8000000b0042a498e93aemr4226039pgd.607.1660979886155;
        Sat, 20 Aug 2022 00:18:06 -0700 (PDT)
Received: from mithil.localdomain ([103.19.226.223])
        by smtp.gmail.com with ESMTPSA id j15-20020a17090a694f00b001faf273e4afsm1459019pjm.35.2022.08.20.00.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Aug 2022 00:18:05 -0700 (PDT)
From:   Mithil Bavishi <bavishimithil@gmail.com>
To:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org, sre@kernel.org,
        tony@atomide.com, linux@armlinux.org.uk, bavishimithil@gmail.com,
        contact@paulk.fr
Subject: [PATCH 08/10] input: misc: Rename twl4030_pwrbutton to twl_pwrbutton
Date:   Sat, 20 Aug 2022 12:46:58 +0530
Message-Id: <20220820071659.1215-9-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220820071659.1215-1-bavishimithil@gmail.com>
References: <20220820071659.1215-1-bavishimithil@gmail.com>
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

This renames the twl4030-pwrbutton driver to twl-pwrbutton,
since power button handling is very similar on most TWL chips.

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
 arch/arm/configs/omap2plus_defconfig          |  2 +-
 drivers/input/misc/Kconfig                    |  8 ++---
 drivers/input/misc/Makefile                   |  2 +-
 .../{twl4030-pwrbutton.c => twl-pwrbutton.c}  | 32 +++++++++----------
 4 files changed, 22 insertions(+), 22 deletions(-)
 rename drivers/input/misc/{twl4030-pwrbutton.c => twl-pwrbutton.c} (76%)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 99d015cf8..621fd8b7e 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -402,7 +402,7 @@ CONFIG_TOUCHSCREEN_TSC2007=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_CPCAP_PWRBUTTON=m
 CONFIG_INPUT_TPS65218_PWRBUTTON=m
-CONFIG_INPUT_TWL4030_PWRBUTTON=m
+CONFIG_INPUT_TWL_PWRBUTTON=m
 CONFIG_INPUT_UINPUT=m
 CONFIG_INPUT_PALMAS_PWRBUTTON=m
 CONFIG_INPUT_PWM_VIBRA=m
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index a18ab7358..2c50459c7 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -479,15 +479,15 @@ config INPUT_AXP20X_PEK
 	  be called axp20x-pek.
 
 
-config INPUT_TWL4030_PWRBUTTON
-	tristate "TWL4030 Power button Driver"
+config INPUT_TWL_PWRBUTTON
+	tristate "TWL Power button Driver"
 	depends on TWL4030_CORE
 	help
 	  Say Y here if you want to enable power key reporting via the
-	  TWL4030 family of chips.
+	  TWL family of chips.
 
 	  To compile this driver as a module, choose M here. The module will
-	  be called twl4030_pwrbutton.
+	  be called twl_pwrbutton.
 
 config INPUT_TWL4030_VIBRA
 	tristate "Support for TWL4030 Vibrator"
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 28dfc444f..3eddb8cbd 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -78,7 +78,7 @@ obj-$(CONFIG_INPUT_SOC_BUTTON_ARRAY)	+= soc_button_array.o
 obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
 obj-$(CONFIG_INPUT_STPMIC1_ONKEY)  	+= stpmic1_onkey.o
 obj-$(CONFIG_INPUT_TPS65218_PWRBUTTON)	+= tps65218-pwrbutton.o
-obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
+obj-$(CONFIG_INPUT_TWL_PWRBUTTON)	+= twl-pwrbutton.o
 obj-$(CONFIG_INPUT_TWL4030_VIBRA)	+= twl4030-vibra.o
 obj-$(CONFIG_INPUT_TWL6040_VIBRA)	+= twl6040-vibra.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
diff --git a/drivers/input/misc/twl4030-pwrbutton.c b/drivers/input/misc/twl-pwrbutton.c
similarity index 76%
rename from drivers/input/misc/twl4030-pwrbutton.c
rename to drivers/input/misc/twl-pwrbutton.c
index b307cca17..5614c5003 100644
--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl-pwrbutton.c
@@ -1,5 +1,5 @@
 /**
- * twl4030-pwrbutton.c - TWL4030 Power Button Input Driver
+ * twl-pwrbutton.c - TWL4030 Power Button Input Driver
  *
  * Copyright (C) 2008-2009 Nokia Corporation
  *
@@ -52,7 +52,7 @@ static irqreturn_t powerbutton_irq(int irq, void *_pwr)
 	return IRQ_HANDLED;
 }
 
-static int twl4030_pwrbutton_probe(struct platform_device *pdev)
+static int twl_pwrbutton_probe(struct platform_device *pdev)
 {
 	struct input_dev *pwr;
 	int irq = platform_get_irq(pdev, 0);
@@ -65,14 +65,14 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
 	}
 
 	input_set_capability(pwr, EV_KEY, KEY_POWER);
-	pwr->name = "twl4030_pwrbutton";
-	pwr->phys = "twl4030_pwrbutton/input0";
+	pwr->name = "twl_pwrbutton";
+	pwr->phys = "twl_pwrbutton/input0";
 	pwr->dev.parent = &pdev->dev;
 
 	err = devm_request_threaded_irq(&pdev->dev, irq, NULL, powerbutton_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
 			IRQF_ONESHOT,
-			"twl4030_pwrbutton", pwr);
+			"twl_pwrbutton", pwr);
 	if (err < 0) {
 		dev_err(&pdev->dev, "Can't get IRQ for pwrbutton: %d\n", err);
 		return err;
@@ -90,24 +90,24 @@ static int twl4030_pwrbutton_probe(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_OF
-static const struct of_device_id twl4030_pwrbutton_dt_match_table[] = {
-       { .compatible = "ti,twl4030-pwrbutton" },
-       {},
+static const struct of_device_id twl_pwrbutton_dt_match_table[] = {
+	{ .compatible = "ti,twl4030-pwrbutton" },
+	{},
 };
-MODULE_DEVICE_TABLE(of, twl4030_pwrbutton_dt_match_table);
+MODULE_DEVICE_TABLE(of, twl_pwrbutton_dt_match_table);
 #endif
 
-static struct platform_driver twl4030_pwrbutton_driver = {
-	.probe		= twl4030_pwrbutton_probe,
+static struct platform_driver twl_pwrbutton_driver = {
+	.probe		= twl_pwrbutton_probe,
 	.driver		= {
-		.name	= "twl4030_pwrbutton",
-		.of_match_table = of_match_ptr(twl4030_pwrbutton_dt_match_table),
+		.name	= "twl_pwrbutton",
+		.of_match_table = of_match_ptr(twl_pwrbutton_dt_match_table),
 	},
 };
-module_platform_driver(twl4030_pwrbutton_driver);
+module_platform_driver(twl_pwrbutton_driver);
 
-MODULE_ALIAS("platform:twl4030_pwrbutton");
-MODULE_DESCRIPTION("Triton2 Power Button");
+MODULE_ALIAS("platform:twl_pwrbutton");
+MODULE_DESCRIPTION("TWL Power Button");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Peter De Schrijver <peter.de-schrijver@nokia.com>");
 MODULE_AUTHOR("Felipe Balbi <felipe.balbi@nokia.com>");
-- 
2.25.1

