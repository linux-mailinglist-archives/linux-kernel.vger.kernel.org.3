Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E3549DCA4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbiA0Ig2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237826AbiA0Ig0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:36:26 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CDDC061747
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:36:26 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id y27so2050844pfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hOnwD3XCBEoi7EneALZ2BHLkba3O2+aqmrT8y3nvWFQ=;
        b=d2lE1NH16Rc6+e11u77wATb37z8W5WlkCUvTH/RnKm7YwDYJnl7Cajzxs8W1EuWoAF
         TEOaQ5yCX1l8i+Wp0nd+6EfegfQVYcuEa5pGHv6dCm3A23shxn/KFakjpqGkr9xo+7mU
         7D1Y3l/LjODJBIAHPfj/875lWkj8Aozz7e+Cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hOnwD3XCBEoi7EneALZ2BHLkba3O2+aqmrT8y3nvWFQ=;
        b=aEjieRpYXdu2mQnEbikwIHiMlHeHinJ5Ui9aDZ/lg2z+bWUf7ScWYTxT7VpUZxjwX4
         NXc15S7AP4F+HH0MgnsMzsjR3zsfASXMQ55tGLa3n3bbFEklpiFgeyHorSM0xHPrNXzD
         x8R0TWt4ZeLNuirWdxtbmC56mu6B0eJudO/8t/1t8/ljA7/xU1p7lSvkjETNmuI+3byd
         9qIwYRdZG31BbdVUpdC5QkCtpM0a6JyVJXbFbjyG8GU8q/sPjY3cfz5ASuRkel+oBqPN
         Vop6mNGNl8FoKALLCN1kmmgkCFVralwJ4/2Nkkj+hw9gvUsq+jHLTWLsNmCavb2B1gXI
         f2yg==
X-Gm-Message-State: AOAM5304Tj4tDdRaghXUhCSejZlfhwL3oBB8VZ5oco4gYoyXmY1DX2XA
        r3gttgWcuUWa7eiA5bEM7wQrVPKX4prutQ==
X-Google-Smtp-Source: ABdhPJzZVUv2RArMoBn4C067RzCz45V7UTw30ToXK3eajNyX45E+Vcc239HtueOA3cPLvJuTT1bXkg==
X-Received: by 2002:a63:215a:: with SMTP id s26mr2018176pgm.141.1643272586012;
        Thu, 27 Jan 2022 00:36:26 -0800 (PST)
Received: from localhost ([2401:fa00:9:14:f81:dff7:4d7c:382])
        by smtp.gmail.com with UTF8SMTPSA id z13sm1476023pfh.45.2022.01.27.00.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 00:36:25 -0800 (PST)
From:   =?UTF-8?q?Sami=20Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dtor@chromium.org, evanbenn@chromium.org, arnd@arndb.de,
        gregkh@linuxfoundation.org,
        =?UTF-8?q?Sami=20Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>
Subject: [PATCH 1/2] drivers/misc: add a driver for HPS
Date:   Thu, 27 Jan 2022 19:35:44 +1100
Message-Id: <20220127083545.1020423-2-skyostil@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127083545.1020423-1-skyostil@chromium.org>
References: <20220127083545.1020423-1-skyostil@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a driver for the ChromeOS snooping protection
sensor (aka. HPS). The driver supports a sensor connected to the I2C bus
and identified as "GOOG0020" in the ACPI tables.

When loaded, the driver exports the sensor to userspace through a
character device. This initial version of the device only supports power
management, i.e., communicating with the sensor must be done through I2C
from userspace.

Power management is implemented by enabling the respective power GPIO
while at least one userspace process holds an open fd on the character
device. By default, the device is powered down if there are no active
clients.

Note that the driver makes no effort to preserve the state of the sensor
between power down and power up events. Userspace is responsible for
reinitializing any needed state once power has been restored.

The device firmware, I2C protocol and other documentation is available
at https://chromium.googlesource.com/chromiumos/platform/hps-firmware.

Signed-off-by: Sami Kyöstilä <skyostil@chromium.org>
---

 MAINTAINERS            |   6 ++
 drivers/misc/Kconfig   |  10 ++
 drivers/misc/Makefile  |   1 +
 drivers/misc/hps-i2c.c | 223 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 240 insertions(+)
 create mode 100644 drivers/misc/hps-i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..9dea4b8c2ab5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8798,6 +8798,12 @@ S:	Maintained
 W:	http://artax.karlin.mff.cuni.cz/~mikulas/vyplody/hpfs/index-e.cgi
 F:	fs/hpfs/
 
+HPS (ChromeOS snooping protection sensor) DRIVER
+M:	Sami Kyöstilä <skyostil@chromium.org>
+R:	Evan Benn <evanbenn@chromium.org>
+S:	Maintained
+F:	drivers/misc/hps-i2c.c
+
 HSI SUBSYSTEM
 M:	Sebastian Reichel <sre@kernel.org>
 S:	Maintained
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 0f5a49fc7c9e..b48b7803f537 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -244,6 +244,16 @@ config HP_ILO
 	  To compile this driver as a module, choose M here: the
 	  module will be called hpilo.
 
+config HPS_I2C
+	tristate "ChromeOS HPS device support"
+	depends on HID && I2C && PM
+	help
+	  Say Y here if you want to enable support for the ChromeOS
+	  anti-snooping sensor (HPS), attached via I2C. The driver supports a
+	  sensor connected to the I2C bus and exposes it as a character device.
+	  To save power, the sensor is automatically powered down when no
+	  clients are accessing it.
+
 config QCOM_COINCELL
 	tristate "Qualcomm coincell charger support"
 	depends on MFD_SPMI_PMIC || COMPILE_TEST
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index a086197af544..162a7d530dab 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_SGI_GRU)		+= sgi-gru/
 obj-$(CONFIG_CS5535_MFGPT)	+= cs5535-mfgpt.o
 obj-$(CONFIG_GEHC_ACHC)		+= gehc-achc.o
 obj-$(CONFIG_HP_ILO)		+= hpilo.o
+obj-$(CONFIG_HPS_I2C)		+= hps-i2c.o
 obj-$(CONFIG_APDS9802ALS)	+= apds9802als.o
 obj-$(CONFIG_ISL29003)		+= isl29003.o
 obj-$(CONFIG_ISL29020)		+= isl29020.o
diff --git a/drivers/misc/hps-i2c.c b/drivers/misc/hps-i2c.c
new file mode 100644
index 000000000000..fe9f073b0352
--- /dev/null
+++ b/drivers/misc/hps-i2c.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the ChromeOS anti-snooping sensor (HPS), attached via I2C.
+ *
+ * The driver exposes HPS as a character device, although currently no read or
+ * write operations are supported. Instead, the driver only controls the power
+ * state of the sensor, keeping it on only while userspace holds an open file
+ * descriptor to the HPS device.
+ *
+ * Copyright 2022 Google LLC.
+ */
+
+#include <linux/acpi.h>
+#include <linux/cdev.h>
+#include <linux/fs.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+
+#define HPS_ACPI_ID		"GOOG0020"
+#define HPS_MAX_DEVICES		1
+
+struct hps_drvdata {
+	struct i2c_client *client;
+
+	struct cdev cdev;
+	struct class *cdev_class;
+
+	struct gpio_desc *enable_gpio;
+};
+
+static int hps_dev_major;
+
+static void hps_power_on(struct hps_drvdata *hps)
+{
+	if (!IS_ERR_OR_NULL(hps->enable_gpio))
+		gpiod_set_value_cansleep(hps->enable_gpio, 1);
+}
+
+static void hps_power_off(struct hps_drvdata *hps)
+{
+	if (!IS_ERR_OR_NULL(hps->enable_gpio))
+		gpiod_set_value_cansleep(hps->enable_gpio, 0);
+}
+
+static void hps_unload(void *drv_data)
+{
+	struct hps_drvdata *hps = drv_data;
+
+	hps_power_on(hps);
+}
+
+static int hps_open(struct inode *inode, struct file *file)
+{
+	struct hps_drvdata *hps = container_of(inode->i_cdev, struct hps_drvdata, cdev);
+	struct device *dev = &hps->client->dev;
+	int ret;
+
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0)
+		goto pm_get_fail;
+	return 0;
+
+pm_get_fail:
+	pm_runtime_put(dev);
+	pm_runtime_disable(dev);
+	return ret;
+}
+
+static int hps_release(struct inode *inode, struct file *file)
+{
+	struct hps_drvdata *hps = container_of(inode->i_cdev, struct hps_drvdata, cdev);
+	struct device *dev = &hps->client->dev;
+	int ret;
+
+	ret = pm_runtime_put(dev);
+	if (ret < 0)
+		goto pm_put_fail;
+	return 0;
+
+pm_put_fail:
+	pm_runtime_disable(dev);
+	return ret;
+}
+
+const struct file_operations hps_fops = {
+	.owner = THIS_MODULE,
+	.open = hps_open,
+	.release = hps_release,
+};
+
+static int hps_i2c_probe(struct i2c_client *client)
+{
+	struct hps_drvdata *hps;
+	int ret = 0;
+	dev_t hps_dev;
+
+	hps = devm_kzalloc(&client->dev, sizeof(*hps), GFP_KERNEL);
+	if (!hps)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, hps);
+	hps->client = client;
+	hps->enable_gpio = devm_gpiod_get(&client->dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(hps->enable_gpio)) {
+		ret = PTR_ERR(hps->enable_gpio);
+		dev_err(&client->dev, "failed to get enable gpio: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_add_action(&client->dev, &hps_unload, hps);
+	if (ret) {
+		dev_err(&client->dev,
+			"failed to install unload action: %d\n", ret);
+		return ret;
+	}
+
+	ret = alloc_chrdev_region(&hps_dev, 0, HPS_MAX_DEVICES, "hps");
+	if (ret) {
+		dev_err(&client->dev,
+			"failed to register char dev: %d\n", ret);
+		return ret;
+	}
+	hps_dev_major = MAJOR(hps_dev);
+	cdev_init(&hps->cdev, &hps_fops);
+	ret = cdev_add(&hps->cdev, hps_dev, 1);
+	if (ret) {
+		dev_err(&client->dev, "cdev_add() failed: %d\n", ret);
+		goto cdev_add_failed;
+	}
+
+	hps->cdev_class = class_create(THIS_MODULE, "hps");
+	if (IS_ERR(hps->cdev_class)) {
+		dev_err(&client->dev, "class_create() failed: %d\n", ret);
+		goto class_create_failed;
+	}
+	device_create(hps->cdev_class, NULL, hps_dev, NULL, "hps");
+
+	hps_power_off(hps);
+	pm_runtime_enable(&client->dev);
+	return ret;
+
+class_create_failed:
+	ret = PTR_ERR(hps->cdev_class);
+	hps->cdev_class = NULL;
+
+cdev_add_failed:
+	unregister_chrdev_region(MKDEV(hps_dev_major, 0), HPS_MAX_DEVICES);
+	hps_dev_major = 0;
+	return ret;
+}
+
+static int hps_i2c_remove(struct i2c_client *client)
+{
+	struct hps_drvdata *hps = i2c_get_clientdata(client);
+
+	pm_runtime_disable(&client->dev);
+	if (hps_dev_major) {
+		dev_t hps_dev = MKDEV(hps_dev_major, 0);
+
+		device_destroy(hps->cdev_class, hps_dev);
+		class_destroy(hps->cdev_class);
+		hps->cdev_class = NULL;
+
+		cdev_del(&hps->cdev);
+		unregister_chrdev_region(hps_dev, HPS_MAX_DEVICES);
+		hps_dev_major = 0;
+	}
+	return 0;
+}
+
+static int hps_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hps_drvdata *hps = i2c_get_clientdata(client);
+
+	hps_power_off(hps);
+	return 0;
+}
+
+static int hps_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hps_drvdata *hps = i2c_get_clientdata(client);
+
+	hps_power_on(hps);
+	return 0;
+}
+static UNIVERSAL_DEV_PM_OPS(hps_pm_ops, hps_suspend, hps_resume, NULL);
+
+static const struct i2c_device_id hps_i2c_id[] = {
+	{ "hps", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, hps_i2c_id);
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id hps_acpi_id[] = {
+	{ HPS_ACPI_ID, 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, hps_acpi_id);
+#endif /* CONFIG_ACPI */
+
+static struct i2c_driver hps_i2c_driver = {
+	.probe_new = hps_i2c_probe,
+	.remove = hps_i2c_remove,
+	.id_table = hps_i2c_id,
+	.driver = {
+		.name = "hps",
+		.pm = &hps_pm_ops,
+#ifdef CONFIG_ACPI
+		.acpi_match_table = ACPI_PTR(hps_acpi_id),
+#endif
+	},
+};
+module_i2c_driver(hps_i2c_driver);
+
+MODULE_ALIAS("acpi:" HPS_ACPI_ID);
+MODULE_AUTHOR("Sami Kyöstilä <skyostil@chromium.org>");
+MODULE_DESCRIPTION("Driver for ChromeOS HPS");
+MODULE_LICENSE("GPL");
-- 
2.35.0.rc0.227.g00780c9af4-goog

