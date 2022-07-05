Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C900E566E7E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237866AbiGEMjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbiGEMc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:32:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920EC25C3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:23:35 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id k30so6916336edk.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 05:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VwrBJ0dMhYH4iU1iltI7/ub2I6M2+H+n4WuU9Trcwnc=;
        b=Av46x6bZn8dwY7dMBCUZf/XYBY65it79NvzeJKkM6qlbOoV7v7WlmmSmSi5moXO4Bq
         lnHcy+44e1XCqc9r30vm6hTFRaRLojk/CYGx7zGJxI4yIJZJtFDEfTt1koc542k2bfyK
         RtZc8UNDReWMf1yZdBeyTDRKmNsFZCwvh81baBbsp1KNJLEJrFFLp5YmiDVSD2t6iDgV
         Afkds0IyZRgZOKTVRXhLBcb4wy6QHxhb6a9WN60q3HAKYccLgYc4DiWEPc5e10mQNvlM
         2dwraPz6bvHO4aLcy9m9aRE+x7ZNRaxd6+XSE7n/d8uohTUjirH3Xcr+YBWDGrIa/eyL
         NoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VwrBJ0dMhYH4iU1iltI7/ub2I6M2+H+n4WuU9Trcwnc=;
        b=yDCsEy+6H6jYhn7xGEjaMO6d4tFFWszs5J9dr/ArhygezxiNamP5x5gFDb1CIIP4Im
         4b8dk/7wf+9vEeqKvsJ6wCttbPQEuXgnR1VCvJPyG0JHxQbVGcDZgUwc5rUtUaCwMOcn
         GZ30Q/ZTrDtlTDDidXGFdbWsWEw82YW0OF0bB0SEnLN8J5E0u7KiRfRWz5f5qbENZD8l
         hXGpgAV4PhXLWzBmV11HJ76u+iEslBl/Y/SAub4K7N1jSySN7+GfwF11DYzA3ob141Pn
         Y+CPkq65InMOHL3+CqLFfDewCGON+zMkddtOJNDMzoCacy+jHb+Raq1QCD+5Xttu7gTg
         DBHA==
X-Gm-Message-State: AJIora/xvR7M7xZyjTtqb+Cq75SYjVyVtOZ3IiSRuI3QI9UisK0Hi9dR
        ZHKbrL7gRdw9I4HrjEky/m4DX6JNZSa/UnBO
X-Google-Smtp-Source: AGRyM1s5p7Gv9Al4cwk7OhQk984dZUeggZ/Dit1km5l9UJa4LHmqREx/swvVsLvzbbxklG63iDnQlg==
X-Received: by 2002:aa7:d30b:0:b0:43a:4bea:75c6 with SMTP id p11-20020aa7d30b000000b0043a4bea75c6mr15141000edq.12.1657023813819;
        Tue, 05 Jul 2022 05:23:33 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id f15-20020a1709062c4f00b007081282cbd8sm15764758ejh.76.2022.07.05.05.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 05:23:33 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH 5/5] leds: max597x: Add support for max597x
Date:   Tue,  5 Jul 2022 14:22:43 +0200
Message-Id: <20220705122244.472894-6-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220705122244.472894-2-Naresh.Solanki@9elements.com>
References: <20220705122244.472894-2-Naresh.Solanki@9elements.com>
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
index a49979f41eee..682748097276 100644
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
+	select MFD_MAX597X
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

