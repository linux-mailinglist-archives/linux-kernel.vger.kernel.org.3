Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7014A6B10
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 05:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243814AbiBBEuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 23:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244602AbiBBEuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 23:50:12 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2372C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 20:50:12 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o64so19196765pjo.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 20:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xVhMtqHlu6JCIou6HFk3Q3pHLaJU2AATV0pA57Jnst4=;
        b=n5DIelVdYVyO/sj67oGCUOVJ1jS5AQTKPdEKv37fKxOp+RLjQgpHcseTn5phAoNs06
         ZXsTuGhRdYkAHMJQAmNqdJhf/YEKPUaEq6m3jr7DJSBw4moy4pDp/K7CX4W9AfdCL3op
         i9UeQV4Jlflj2o3I5nQ+HpTz7nzALYLMKI09Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xVhMtqHlu6JCIou6HFk3Q3pHLaJU2AATV0pA57Jnst4=;
        b=rZeXDJj4eo/eNzdRlCdd+W15h8d87paxkW6vax16B06IoyzbdbnpQppQNKxVNR+0XB
         gIwq/YA58t07XeoD3Oy60jCJogze7gp1S4w2cI8oKpumcDLvRbpLbWPZ6RLKnneLFHQy
         4CJdBAXE6yWD84ZSm9vFxXeJ6d7HkmY5egMkV5I9L22JwQrTEdUaRQvJ/8SgWLunB8ic
         b9lV84jrf5a6sRr8KZXtKeDd1BrDmtGVvv2+s5yetIusiT9wP4B+tfK3tL88LAlN+qim
         gzz1tyZVlOPk/ldw+vaX9QNB7CQ8u86YXLHBuDCwxY1OOT2s2ZWvkl78TIzc7fgzqb0J
         k3zA==
X-Gm-Message-State: AOAM531sm0Vo9fwnT1hiKgTnE2ZOYaUXm3SAALpn7zyebfAJysfMYlkI
        2D1ob9k7sBJ4qXZEZt/39YW4RJYMPzDtYw==
X-Google-Smtp-Source: ABdhPJy9sveQ++Xlglmd5XhpO3noAMeCB3+NreACzmlZlZUE4kpkrxDvnfmXHtZe40Kwcot1in72xw==
X-Received: by 2002:a17:90a:fe2:: with SMTP id 89mr6188943pjz.162.1643777411946;
        Tue, 01 Feb 2022 20:50:11 -0800 (PST)
Received: from localhost ([2401:fa00:9:14:97af:7793:b97d:448e])
        by smtp.gmail.com with UTF8SMTPSA id a14sm24981865pfv.212.2022.02.01.20.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 20:50:11 -0800 (PST)
From:   =?UTF-8?q?Sami=20Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dtor@chromium.org, gregkh@linuxfoundation.org, arnd@arndb.de,
        evanbenn@chromium.org,
        =?UTF-8?q?Sami=20Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>
Subject: [PATCH v2 1/1] drivers/misc: add a driver for HPS
Date:   Wed,  2 Feb 2022 15:49:37 +1100
Message-Id: <20220202044937.3187603-2-skyostil@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202044937.3187603-1-skyostil@chromium.org>
References: <20220202044937.3187603-1-skyostil@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a driver for the ChromeOS screen privacy
sensor (aka. HPS). The driver supports a sensor connected to the I2C bus
and identified as "GOOG0020" in the ACPI tables.

When loaded, the driver exports the sensor to userspace through a
character device. This device only supports power management, i.e.,
communication with the sensor must be done through regular I2C
transmissions from userspace.

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

Changes in v2:
- Removed custom ioctl interface.
- Reworked to use miscdev.

 MAINTAINERS            |   6 ++
 drivers/misc/Kconfig   |  10 +++
 drivers/misc/Makefile  |   1 +
 drivers/misc/hps-i2c.c | 184 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 201 insertions(+)
 create mode 100644 drivers/misc/hps-i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f41088418aae..6c164ed84f60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8801,6 +8801,12 @@ S:	Maintained
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
index 0f5a49fc7c9e..44fcf60a67aa 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -244,6 +244,16 @@ config HP_ILO
 	  To compile this driver as a module, choose M here: the
 	  module will be called hpilo.
 
+config HPS_I2C
+	tristate "ChromeOS HPS device"
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
index 000000000000..9071c9324fa7
--- /dev/null
+++ b/drivers/misc/hps-i2c.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the ChromeOS screen privacy sensor (HPS), attached via I2C.
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
+#include <linux/fs.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+
+#define HPS_ACPI_ID		"GOOG0020"
+
+struct hps_drvdata {
+	struct i2c_client *client;
+	struct miscdevice misc_device;
+	struct gpio_desc *enable_gpio;
+};
+
+static void hps_set_power(struct hps_drvdata *hps, bool state)
+{
+	if (!IS_ERR_OR_NULL(hps->enable_gpio))
+		gpiod_set_value_cansleep(hps->enable_gpio, state);
+}
+
+static void hps_unload(void *drv_data)
+{
+	struct hps_drvdata *hps = drv_data;
+
+	hps_set_power(hps, true);
+}
+
+static int hps_open(struct inode *inode, struct file *file)
+{
+	struct hps_drvdata *hps = container_of(file->private_data,
+					       struct hps_drvdata, misc_device);
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
+	struct hps_drvdata *hps = container_of(file->private_data,
+					       struct hps_drvdata, misc_device);
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
+
+	hps = devm_kzalloc(&client->dev, sizeof(*hps), GFP_KERNEL);
+	if (!hps)
+		return -ENOMEM;
+
+	memset(&hps->misc_device, 0, sizeof(hps->misc_device));
+	hps->misc_device.parent = &client->dev;
+	hps->misc_device.minor = MISC_DYNAMIC_MINOR;
+	hps->misc_device.name = "hps";
+	hps->misc_device.fops = &hps_fops;
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
+	ret = misc_register(&hps->misc_device);
+	if (ret) {
+		dev_err(&client->dev, "failed to initialize misc device: %d\n", ret);
+		return ret;
+	}
+
+	hps_set_power(hps, false);
+	pm_runtime_enable(&client->dev);
+	return ret;
+}
+
+static int hps_i2c_remove(struct i2c_client *client)
+{
+	struct hps_drvdata *hps = i2c_get_clientdata(client);
+
+	pm_runtime_disable(&client->dev);
+	misc_deregister(&hps->misc_device);
+	return 0;
+}
+
+static int hps_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hps_drvdata *hps = i2c_get_clientdata(client);
+
+	hps_set_power(hps, false);
+	return 0;
+}
+
+static int hps_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct hps_drvdata *hps = i2c_get_clientdata(client);
+
+	hps_set_power(hps, true);
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
2.35.0.rc2.247.g8bbb082509-goog

