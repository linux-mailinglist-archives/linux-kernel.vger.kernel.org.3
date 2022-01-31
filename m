Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929A24A481E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378804AbiAaNbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378807AbiAaNbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:31:01 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06374C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:31:01 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w14so26829942edd.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dyOxlnF56fGFvmWlFeMFje49EyLTFgsIjGjI1oGHJXQ=;
        b=ez8GBhvi9YgiNQeS5F9M47uLlt4ytrPcD8aBMn/tPMQXM2+Lb7b4kp9VV+l65xH0uo
         IpAuQi15+2IvIRlh6RV45UmwSEa00x8RUEYzPKfvkm2Gr2VlKUMSl9pYIM/KcfVnYDtn
         w+4hivismuAKnNAT/iNqBi1/SV+ETFsu4C3LiK1J+35xZAXffwZWkXwsWdB0tEE9ZJX5
         /01FxHtXMkgo2iyFttRKIPmf1cfH29MJq3WAQLOKsqld9PuCk2pHD2+IcLTeSaMxRY5b
         C5jAS5cZa1xgQ9anEYTzdFYegRXQOp4Xo221AFJHwP54kBl1JZTThXaB7kMBxyr7mQtS
         J9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dyOxlnF56fGFvmWlFeMFje49EyLTFgsIjGjI1oGHJXQ=;
        b=w86j++je9svc4AYu33Q88xse28XhdOj4RSlm6YgkLDrWtj1hCjxKnKjq95G//yGVvb
         neNo3r/MB+kM66sJAY4j5jQDDaQ3W3E2RK3L8t9d+YCCwdxseV5zAf76xYmY5kwmeEYh
         YNL9cBqYGSGkGJ+hQQ9XrHxDiqND/YjyPIIr/6gtksjL9AIiDvmagy0IMU4pmYFely52
         xnFZTdSfXhJnhL8wdDF8KcDZDwDFvHi8W2So4rKj0PIgY6goabpHbegMrsubXtq5kXu3
         /dW7va3+VG1cOdCYDdvmk7IbzjcZQ2gqlkjk7yYNza7cfXBBKZlG69bBWtoIt1XiBQCr
         1jqg==
X-Gm-Message-State: AOAM532zYFY5mJB2t5GRdczbjTwjz0zUsuxs2bI+4jBkXhIF0AlA4Nja
        fbTOtJuZtcUr7Bo5BV03otFJRw==
X-Google-Smtp-Source: ABdhPJz1VD5sHKHWyFu16J6uThq2t+Uz16u/ZIm/fMUv73jvInYu4Q4qYjehg3Io14G1j1Uq0SV+8w==
X-Received: by 2002:aa7:d313:: with SMTP id p19mr21381970edq.380.1643635859596;
        Mon, 31 Jan 2022 05:30:59 -0800 (PST)
Received: from fedora.robimarko.hr (cpezg-94-253-144-81-cbl.xnet.hr. [94.253.144.81])
        by smtp.googlemail.com with ESMTPSA id c22sm13094334eds.72.2022.01.31.05.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 05:30:59 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        lee.jones@linaro.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org,
        skhan@linuxfoundation.org
Cc:     luka.perkov@sartura.hr, Robert Marko <robert.marko@sartura.hr>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v10 2/6] gpio: Add Delta TN48M CPLD GPIO driver
Date:   Mon, 31 Jan 2022 14:30:45 +0100
Message-Id: <20220131133049.77780-3-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220131133049.77780-1-robert.marko@sartura.hr>
References: <20220131133049.77780-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delta TN48M switch has an onboard Lattice CPLD that is used as a GPIO
expander.

The CPLD provides 12 pins in total on the TN48M, but on more advanced
switch models it provides up to 192 pins, so the driver is extendable
to support more switches.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Michael Walle <michael@walle.cc>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v10:
* Rebase onto 5.17-rc1

Changes in v9:
* Use {} instead of {0} for initialising the regmap config per Andys
comment
* Fix spelling mistake in KConfig

Changes in v8:
* No need to assing NULL to gpio_config per Andys comment

Changes in v7:
* Change compatibles, reduce their number
* Rework the driver to be easily extendible to support more devices
* Use match data to populate configuration
* Drop reviews and ACK-s as the driver changed

Changes in v6:
* Drop unused header
* Return the return value of device_property_read_u32()
instead of a hardcoded return

Changes in v2:
* Rewrite to use simple I2C MFD and GPIO regmap
* Drop DT bindings for pin numbering
---
 drivers/gpio/Kconfig      |  12 +++++
 drivers/gpio/Makefile     |   1 +
 drivers/gpio/gpio-tn48m.c | 100 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 drivers/gpio/gpio-tn48m.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 1c211b4c63be..c822cf6146cf 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1346,6 +1346,18 @@ config GPIO_TIMBERDALE
 	help
 	Add support for the GPIO IP in the timberdale FPGA.
 
+config GPIO_TN48M_CPLD
+	tristate "Delta Networks TN48M switch CPLD GPIO driver"
+	depends on MFD_TN48M_CPLD
+	select GPIO_REGMAP
+	help
+	  This enables support for the GPIOs found on the Delta
+	  Networks TN48M switch Lattice CPLD. It provides 12 pins in total,
+	  they are input-only or output-only type.
+
+	  This driver can also be built as a module. If so, the
+	  module will be called gpio-tn48m.
+
 config GPIO_TPS65086
 	tristate "TI TPS65086 GPO"
 	depends on MFD_TPS65086
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index edbaa3cb343c..3b68a9808154 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -148,6 +148,7 @@ obj-$(CONFIG_GPIO_TEGRA186)		+= gpio-tegra186.o
 obj-$(CONFIG_GPIO_TEGRA)		+= gpio-tegra.o
 obj-$(CONFIG_GPIO_THUNDERX)		+= gpio-thunderx.o
 obj-$(CONFIG_GPIO_TIMBERDALE)		+= gpio-timberdale.o
+obj-$(CONFIG_GPIO_TN48M_CPLD)		+= gpio-tn48m.o
 obj-$(CONFIG_GPIO_TPIC2810)		+= gpio-tpic2810.o
 obj-$(CONFIG_GPIO_TPS65086)		+= gpio-tps65086.o
 obj-$(CONFIG_GPIO_TPS65218)		+= gpio-tps65218.o
diff --git a/drivers/gpio/gpio-tn48m.c b/drivers/gpio/gpio-tn48m.c
new file mode 100644
index 000000000000..cd4a80b22794
--- /dev/null
+++ b/drivers/gpio/gpio-tn48m.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Delta TN48M CPLD GPIO driver
+ *
+ * Copyright (C) 2021 Sartura Ltd.
+ *
+ * Author: Robert Marko <robert.marko@sartura.hr>
+ */
+
+#include <linux/device.h>
+#include <linux/gpio/driver.h>
+#include <linux/gpio/regmap.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+enum tn48m_gpio_type {
+	TN48M_GP0 = 1,
+	TN48M_GPI,
+};
+
+struct tn48m_gpio_config {
+	int ngpio;
+	int ngpio_per_reg;
+	enum tn48m_gpio_type type;
+};
+
+static const struct tn48m_gpio_config tn48m_gpo_config = {
+	.ngpio = 4,
+	.ngpio_per_reg = 4,
+	.type = TN48M_GP0,
+};
+
+static const struct tn48m_gpio_config tn48m_gpi_config = {
+	.ngpio = 4,
+	.ngpio_per_reg = 4,
+	.type = TN48M_GPI,
+};
+
+static int tn48m_gpio_probe(struct platform_device *pdev)
+{
+	const struct tn48m_gpio_config *gpio_config;
+	struct gpio_regmap_config config = {};
+	struct regmap *regmap;
+	u32 base;
+	int ret;
+
+	if (!pdev->dev.parent)
+		return -ENODEV;
+
+	gpio_config = device_get_match_data(&pdev->dev);
+	if (!gpio_config)
+		return -ENODEV;
+
+	ret = device_property_read_u32(&pdev->dev, "reg", &base);
+	if (ret)
+		return ret;
+
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap)
+		return -ENODEV;
+
+	config.regmap = regmap;
+	config.parent = &pdev->dev;
+	config.ngpio = gpio_config->ngpio;
+	config.ngpio_per_reg = gpio_config->ngpio_per_reg;
+	switch (gpio_config->type) {
+	case TN48M_GP0:
+		config.reg_set_base = base;
+		break;
+	case TN48M_GPI:
+		config.reg_dat_base = base;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(&pdev->dev, &config));
+}
+
+static const struct of_device_id tn48m_gpio_of_match[] = {
+	{ .compatible = "delta,tn48m-gpo", .data = &tn48m_gpo_config },
+	{ .compatible = "delta,tn48m-gpi", .data = &tn48m_gpi_config },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tn48m_gpio_of_match);
+
+static struct platform_driver tn48m_gpio_driver = {
+	.driver = {
+		.name = "delta-tn48m-gpio",
+		.of_match_table = tn48m_gpio_of_match,
+	},
+	.probe = tn48m_gpio_probe,
+};
+module_platform_driver(tn48m_gpio_driver);
+
+MODULE_AUTHOR("Robert Marko <robert.marko@sartura.hr>");
+MODULE_DESCRIPTION("Delta TN48M CPLD GPIO driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

