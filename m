Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1E756A3F4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 15:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbiGGNmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 09:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235968AbiGGNlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 09:41:55 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0433524971
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 06:41:54 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id os14so2256944ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 06:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bDCTJrI1zdZJoGe/yArvDEW3LAIX1C7pupl+sZWFohc=;
        b=LUadlLlRFiQCDkTi0qW4TyzoS1IRiWz5I5W2HSGe2ibGUc5F4S9fhhmRQve12jX9X7
         v23Dm4cZImzLVVCjLk1IBm7dsi4LW6UEJc7cM+DsTXrinsoDHj/SxLeJDOs+xWwfmz/+
         SyFrDk2E7aVvbHSTor30iDDVmDNTX2QD202v9Ql2IlGPndYArTrmotEF0ag41+P35pUt
         EcGVnD7N3ViMOBCq69OybzRwTLVr8AXzYJeUdRjnv+kMO4H1WJfeoJm9tfMll09oYchC
         6MrZn7V0uFkVfLkAawaFW0XYkNa5pU4SRsyju6lK/5vZ3XAho7ZR7vGDcgTEVP3Gs1HO
         /lFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bDCTJrI1zdZJoGe/yArvDEW3LAIX1C7pupl+sZWFohc=;
        b=N2p/vsmS56dRPL8WHFShr12SdxAAc+Xpnr4wJk8k2zQYrWs18upucAu7yLMhMQpBwz
         xNYaUT0+UQwohl0zJ4ZCM/fBiYpbYVsaMQl3Ql6ataFQP9/eQOnCOTUZHHlKDls+x2m1
         ft0cRbsTDCSChx9GyCRc/us4ncFwF9QsO3iooNVj9cW7ib/vXOtAe9t9ewmUV2PixhgY
         qyotSxJgDzahMStjKtSF+SMP5RIAgrZkpqOy0fi0hgc69aFmUeoKp2f/zqLKYN+O9ChP
         8IBSJbH5bAN//wnf5+lAPyyPHE8ZqnlYCVCvmB//SUyWrjo7vtQbjEWT6j/qw5ndjede
         j5mg==
X-Gm-Message-State: AJIora8iDB+Rlag2QB4sJNP8VTs1lmurXeL9hLUK5XP3fUr5UrjAY29K
        xBZc3cuN7Qkk4zoYzSadDDTOtE10N1oXJulI
X-Google-Smtp-Source: AGRyM1uF6t8vryvFi8UqoPp7a1RGjGj9CGud6t5Rj2uxS8HWtOy5Y2xWWTd/esdEfNAZe6Rwos5mrQ==
X-Received: by 2002:a17:906:9c82:b0:6df:c5f0:d456 with SMTP id fj2-20020a1709069c8200b006dfc5f0d456mr45926311ejc.287.1657201312303;
        Thu, 07 Jul 2022 06:41:52 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id eg37-20020a05640228a500b0043a587eb95dsm9550141edb.5.2022.07.07.06.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 06:41:51 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v2 5/5] leds: max597x: Add support for max597x
Date:   Thu,  7 Jul 2022 15:41:41 +0200
Message-Id: <20220707134141.1172300-6-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220707134141.1172300-1-Naresh.Solanki@9elements.com>
References: <20220707134141.1172300-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

max597x is hot swap controller with indication led support.
This driver uses DT property to configure led during boot time &
also provide the led control in sysfs.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/leds/Kconfig        |  10 +++
 drivers/leds/Makefile       |   1 +
 drivers/leds/leds-max597x.c | 130 ++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 drivers/leds/leds-max597x.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index a49979f41eee..64070cadac31 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -598,6 +598,16 @@ config LEDS_ADP5520
 	  To compile this driver as a module, choose M here: the module will
 	  be called leds-adp5520.
 
+config LEDS_MAX597X
+	tristate "Maxim 597x leds"
+	depends on I2C
+	depends on OF
+	depends on LEDS_CLASS
+	depends MFD_MAX597X
+	help
+	  This driver controls a Maxim 5970/5978 indication led via I2C bus.
+	  The MAX5970/5978 is a smart switch with 4 indication leds
+
 config LEDS_MC13783
 	tristate "LED Support for MC13XXX PMIC"
 	depends on LEDS_CLASS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 4fd2f92cd198..c44b0e9559ab 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_LEDS_LP8501)		+= leds-lp8501.o
 obj-$(CONFIG_LEDS_LP8788)		+= leds-lp8788.o
 obj-$(CONFIG_LEDS_LP8860)		+= leds-lp8860.o
 obj-$(CONFIG_LEDS_LT3593)		+= leds-lt3593.o
+obj-$(CONFIG_LEDS_MAX597X)		+= leds-max597x.o
 obj-$(CONFIG_LEDS_MAX77650)		+= leds-max77650.o
 obj-$(CONFIG_LEDS_MAX8997)		+= leds-max8997.o
 obj-$(CONFIG_LEDS_MC13783)		+= leds-mc13783.o
diff --git a/drivers/leds/leds-max597x.c b/drivers/leds/leds-max597x.c
new file mode 100644
index 000000000000..645d6cdcfa34
--- /dev/null
+++ b/drivers/leds/leds-max597x.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device driver for regulators in MAX5970 and MAX5978 IC
+ *
+ * Copyright (c) 2022 9elements GmbH
+ *
+ * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/i2c.h>
+#include <linux/mfd/max597x.h>
+#include <linux/regmap.h>
+#include <linux/version.h>
+#include <linux/platform_device.h>
+
+struct max597x_led {
+	struct regmap *regmap;
+	struct led_classdev led;
+	unsigned int index;
+};
+
+static int max597x_led_set_brightness(struct led_classdev *cdev,
+				      enum led_brightness brightness)
+{
+	struct max597x_led *led = cdev->driver_data;
+	int ret;
+
+	if (!led || !led->regmap)
+		return -1;
+
+	ret = regmap_update_bits(led->regmap, MAX5970_REG_LED_FLASH,
+				 1 << led->index, ~brightness << led->index);
+	if (ret < 0)
+		dev_err(cdev->dev, "failed to set brightness %d\n", ret);
+	return ret;
+}
+
+static int max597x_led(struct max597x_data *max597x, struct device_node *nc, u32 reg)
+{
+	struct max597x_led *led;
+	const char *state;
+	int ret = 0;
+
+	led = devm_kzalloc(max597x->dev, sizeof(struct max597x_led),
+				   GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	if (of_property_read_string(nc, "label", &led->led.name))
+		led->led.name = nc->name;
+
+	led->led.max_brightness = 1;
+	led->led.brightness_set_blocking = max597x_led_set_brightness;
+	led->led.default_trigger = "none";
+	led->index = reg;
+	led->regmap = max597x->regmap;
+	ret = led_classdev_register(max597x->dev, &led->led);
+	if (ret) {
+		dev_err(max597x->dev, "Error in initializing led %s", led->led.name);
+		devm_kfree(max597x->dev, led);
+		return ret;
+	}
+	led->led.driver_data = led;
+	led->led.dev = max597x->dev;
+	if (!of_property_read_string(nc, "default-state", &state)) {
+		if (!strcmp(state, "on")) {
+			led->led.brightness = 1;
+			led_set_brightness(&led->led, led->led.brightness);
+		}
+	}
+	return 0;
+}
+
+static int max597x_led_probe(struct platform_device *pdev)
+{
+
+
+	struct max597x_data *max597x = dev_get_drvdata(pdev->dev.parent);
+	struct device_node *np = dev_of_node(pdev->dev.parent);
+	struct device_node *led_node;
+	struct device_node *child;
+	int ret = 0;
+
+
+	led_node = of_get_child_by_name(np, "leds");
+	if (!led_node)
+		return -ENODEV;
+
+	for_each_available_child_of_node(led_node, child) {
+		u32 reg;
+
+		if (of_property_read_u32(child, "reg", &reg))
+			continue;
+
+		if (reg >= MAX597X_NUM_LEDS) {
+			dev_err(max597x->dev, "invalid LED (%u >= %d)\n", reg,
+				MAX597X_NUM_LEDS);
+			continue;
+		}
+
+		ret = max597x_led(max597x, child, reg);
+		if (ret < 0) {
+			of_node_put(child);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static struct platform_driver max597x_led_driver = {
+	.driver = {
+		.name = "max597x-led",
+	},
+	.probe = max597x_led_probe,
+};
+
+module_platform_driver(max597x_led_driver);
+
+
+MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
+MODULE_DESCRIPTION("MAX5970_hot-swap controller driver");
+MODULE_LICENSE("GPL v2");
-- 
2.35.3

