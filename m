Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102184B2112
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 10:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348380AbiBKJJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 04:09:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348372AbiBKJJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 04:09:29 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A1B103D
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:09:24 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id c3so4173872pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 01:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1/gAUkPXnFVdqiI1/AiwB74QuBfPKaN8GAZbTgsYxjQ=;
        b=arn4rVSPaBBHzbq65JIck/f1vEsNkSRyxoVBmIIp2jQepqrzWAEOuK92Fdqf8PMtHv
         vbNJIW9Qj/V7Emil905AXLHCPthUNn5LEHFvpN2G5ExIjJXvQXLnQQ39fIrNGP3IzWUR
         71rqSkg9f8foc2fnQB4DwuJzupkFjCkO9J960=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1/gAUkPXnFVdqiI1/AiwB74QuBfPKaN8GAZbTgsYxjQ=;
        b=lnFjuFntdRXYeGJxHETGTytuFOS5fo3XQb28wM7A1abm5nzSxbjrrMPCFc9qrJSY8N
         UO4JkhtPeqe/DIL4u6+GJp0btsjY39NwgJN8br5WU7+Biow9aZtlE1ubD9DV/GUvsTsa
         AnfpzS3PNUywHHdrKvJM/5/ZUShtBdUxDoAUYhorRPcPQOwhPdF+jQJpvF/KJTy0q4gX
         DENtN8WPAm597uBDKRus5a6IH2dYIDZ0mcU9S5mPcH5DBsyxCVHf40yHo9FUF7zE8vBs
         zTM/77j8+GWb7yI5n5+a1dqXaRCA39cKADVUCOyDqWQk6/jzQjKwqTAI5eyOpZ2eeQGv
         ZaUw==
X-Gm-Message-State: AOAM531pDQSUYvHi5QX9J/ZpoUxnXsJzHV4cgRfaqTO69e/GKA/rst6p
        MVvBSCfl9eRXWhUhw3c3hsRUnLyAhnRByQ==
X-Google-Smtp-Source: ABdhPJyxAHOrEQFjODBj0Zjuuk063HHtEIjd6A6qCYmzbZZ+YP/hbzi/U6/Iwo+TRoo5GpOEiLQDhw==
X-Received: by 2002:a17:902:ef47:: with SMTP id e7mr548381plx.73.1644570563767;
        Fri, 11 Feb 2022 01:09:23 -0800 (PST)
Received: from localhost ([2401:fa00:9:14:72c7:7d52:feb:9958])
        by smtp.gmail.com with UTF8SMTPSA id qe7sm4468349pjb.44.2022.02.11.01.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 01:09:23 -0800 (PST)
From:   =?UTF-8?q?Sami=20Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     bleung@chromium.org, evanbenn@chromium.org, tzungbi@google.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        =?UTF-8?q?Sami=20Ky=C3=B6stil=C3=A4?= <skyostil@chromium.org>
Subject: [PATCH v4 1/1] platform/chrome: add a driver for HPS
Date:   Fri, 11 Feb 2022 20:08:57 +1100
Message-Id: <20220211090858.7970-2-skyostil@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220211090858.7970-1-skyostil@chromium.org>
References: <20220211090858.7970-1-skyostil@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a driver for the ChromeOS human presence
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

Changes in v4:
- Simplified open/release pm logic.
- Renamed device to "cros-hps".
- Stylistics cleanups.

Changes in v3:
- Moved from drivers/misc to drivers/platform/chrome.

Changes in v2:
- Removed custom ioctl interface.
- Reworked to use miscdev.

 MAINTAINERS                            |   6 +
 drivers/platform/chrome/Kconfig        |  10 ++
 drivers/platform/chrome/Makefile       |   1 +
 drivers/platform/chrome/cros_hps_i2c.c | 151 +++++++++++++++++++++++++
 4 files changed, 168 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_hps_i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 69a2935daf6c..7896e61e9f7f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4567,6 +4567,12 @@ S:	Maintained
 F:	drivers/platform/chrome/cros_usbpd_notify.c
 F:	include/linux/platform_data/cros_usbpd_notify.h
 
+CHROMEOS HPS DRIVER
+M:	Sami Kyöstilä <skyostil@chromium.org>
+R:	Evan Benn <evanbenn@chromium.org>
+S:	Maintained
+F:	drivers/platform/chrome/cros_hps_i2c.c
+
 CHRONTEL CH7322 CEC DRIVER
 M:	Joe Tessler <jrt@google.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index ccc23d8686e8..7f33bcb619b0 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -217,6 +217,16 @@ config CROS_EC_TYPEC
 	  To compile this driver as a module, choose M here: the module will be
 	  called cros_ec_typec.
 
+config CROS_HPS_I2C
+	tristate "ChromeOS HPS device"
+	depends on HID && I2C && PM
+	help
+	  Say Y here if you want to enable support for the ChromeOS
+	  human presence sensor (HPS), attached via I2C. The driver supports a
+	  sensor connected to the I2C bus and exposes it as a character device.
+	  To save power, the sensor is automatically powered down when no
+	  clients are accessing it.
+
 config CROS_USBPD_LOGGER
 	tristate "Logging driver for USB PD charger"
 	depends on CHARGER_CROS_USBPD
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index f901d2e43166..66bd745d5931 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_CROS_EC_DEBUGFS)		+= cros_ec_debugfs.o
 cros-ec-sensorhub-objs			:= cros_ec_sensorhub.o cros_ec_sensorhub_ring.o cros_ec_trace.o
 obj-$(CONFIG_CROS_EC_SENSORHUB)		+= cros-ec-sensorhub.o
 obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
+obj-$(CONFIG_CROS_HPS_I2C)		+= cros_hps_i2c.o
 obj-$(CONFIG_CROS_USBPD_LOGGER)		+= cros_usbpd_logger.o
 obj-$(CONFIG_CROS_USBPD_NOTIFY)		+= cros_usbpd_notify.o
 
diff --git a/drivers/platform/chrome/cros_hps_i2c.c b/drivers/platform/chrome/cros_hps_i2c.c
new file mode 100644
index 000000000000..a5505951f989
--- /dev/null
+++ b/drivers/platform/chrome/cros_hps_i2c.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the ChromeOS human presence sensor (HPS), attached via I2C.
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
+	gpiod_set_value_cansleep(hps->enable_gpio, state);
+}
+
+static int hps_open(struct inode *inode, struct file *file)
+{
+	struct hps_drvdata *hps = container_of(file->private_data,
+					       struct hps_drvdata, misc_device);
+	struct device *dev = &hps->client->dev;
+
+	return pm_runtime_resume_and_get(dev);
+}
+
+static int hps_release(struct inode *inode, struct file *file)
+{
+	struct hps_drvdata *hps = container_of(file->private_data,
+					       struct hps_drvdata, misc_device);
+	struct device *dev = &hps->client->dev;
+
+	return pm_runtime_put(dev);
+}
+
+static const struct file_operations hps_fops = {
+	.owner = THIS_MODULE,
+	.open = hps_open,
+	.release = hps_release,
+};
+
+static int hps_i2c_probe(struct i2c_client *client)
+{
+	struct hps_drvdata *hps;
+	int ret;
+
+	hps = devm_kzalloc(&client->dev, sizeof(*hps), GFP_KERNEL);
+	if (!hps)
+		return -ENOMEM;
+
+	memset(&hps->misc_device, 0, sizeof(hps->misc_device));
+	hps->misc_device.parent = &client->dev;
+	hps->misc_device.minor = MISC_DYNAMIC_MINOR;
+	hps->misc_device.name = "cros-hps";
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
+	ret = misc_register(&hps->misc_device);
+	if (ret) {
+		dev_err(&client->dev, "failed to initialize misc device: %d\n", ret);
+		return ret;
+	}
+
+	hps_set_power(hps, false);
+	pm_runtime_enable(&client->dev);
+	return 0;
+}
+
+static int hps_i2c_remove(struct i2c_client *client)
+{
+	struct hps_drvdata *hps = i2c_get_clientdata(client);
+
+	pm_runtime_disable(&client->dev);
+	misc_deregister(&hps->misc_device);
+	hps_set_power(hps, true);
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
+	{ "cros-hps", 0 },
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
+		.name = "cros-hps",
+		.pm = &hps_pm_ops,
+		.acpi_match_table = ACPI_PTR(hps_acpi_id),
+	},
+};
+module_i2c_driver(hps_i2c_driver);
+
+MODULE_ALIAS("acpi:" HPS_ACPI_ID);
+MODULE_AUTHOR("Sami Kyöstilä <skyostil@chromium.org>");
+MODULE_DESCRIPTION("Driver for ChromeOS HPS");
+MODULE_LICENSE("GPL");
-- 
2.35.1.265.g69c8d7142f-goog

