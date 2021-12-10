Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB2B470CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344632AbhLJWPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:15:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58991 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344624AbhLJWPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639174299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rD/REU+DT9ZwR0BjEFACPZXbYoM4MRyoFG19cGkG8J8=;
        b=EDqZor9HKGTTe1mgMSBlKNURxJE8J0tMW3NhBCB4r1tvwv2fDbbFQbfcaSae9Jw0KQ/lJE
        Ow4Ii5IBhSQw4E99fl8n7wb7foNRWd0WE4UlC1mdcz7QUetLBBB+wMkpvZ5a8PogJSNGyW
        UQQ3TlK3btIJf0+A/yvmjPlsNGZiXqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-uzXkFI__NO6bOyk4gdkaDQ-1; Fri, 10 Dec 2021 17:11:36 -0500
X-MC-Unique: uzXkFI__NO6bOyk4gdkaDQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B92CA10168C0;
        Fri, 10 Dec 2021 22:11:34 +0000 (UTC)
Received: from cmirabil.remote.csb (unknown [10.22.8.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74640694DE;
        Fri, 10 Dec 2021 22:11:33 +0000 (UTC)
From:   Charles Mirabile <cmirabil@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Mirabile <cmirabil@redhat.com>,
        Lee Jones <lee.jones@linaro.org>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Mattias Brugger <mbrugger@suse.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
Subject: [PATCH V5 1/6] drivers/mfd: sensehat: Raspberry Pi Sense HAT core driver
Date:   Fri, 10 Dec 2021 17:10:28 -0500
Message-Id: <20211210221033.912430-2-cmirabil@redhat.com>
In-Reply-To: <20211210221033.912430-1-cmirabil@redhat.com>
References: <20211210221033.912430-1-cmirabil@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the core driver file, containing the regmap configuration
needed to communicate with the board over I2C. We also add the header
file shared by all three drivers, containing common data and definitions.
In addition, we add a config option to toggle compilation of the driver.

Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Co-developed-by: Mwesigwa Guma <mguma@redhat.com>
Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
Co-developed-by: Joel Savitz <jsavitz@redhat.com>
Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 drivers/mfd/Kconfig          |   8 ++
 drivers/mfd/Makefile         |   1 +
 drivers/mfd/sensehat-core.c  | 157 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/sensehat.h |  51 ++++++++++++
 4 files changed, 217 insertions(+)
 create mode 100644 drivers/mfd/sensehat-core.c
 create mode 100644 include/linux/mfd/sensehat.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 3fb480818599..e6de22f98c0e 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -11,6 +11,14 @@ config MFD_CORE
 	select IRQ_DOMAIN
 	default n
 
+config MFD_SENSEHAT_CORE
+	tristate "Raspberry Pi Sense HAT core functions"
+	depends on I2C
+	select MFD_CORE
+	help
+	  This is the core driver for the Raspberry Pi Sense HAT. This provides
+	  the necessary functions to communicate with the hardware.
+
 config MFD_CS5535
 	tristate "AMD CS5535 and CS5536 southbridge core functions"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 0b1b629aef3e..2b012e3d497d 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -263,6 +263,7 @@ obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
 obj-$(CONFIG_MFD_ROHM_BD957XMUF)	+= rohm-bd9576.o
 obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
+obj-$(CONFIG_MFD_SENSEHAT_CORE) += sensehat-core.o
 obj-$(CONFIG_MFD_ACER_A500_EC)	+= acer-ec-a500.o
 obj-$(CONFIG_MFD_QCOM_PM8008)	+= qcom-pm8008.o
 
diff --git a/drivers/mfd/sensehat-core.c b/drivers/mfd/sensehat-core.c
new file mode 100644
index 000000000000..c5b6f4648d88
--- /dev/null
+++ b/drivers/mfd/sensehat-core.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Raspberry Pi Sense HAT core driver
+ * http://raspberrypi.org
+ *
+ * Copyright (C) 2015 Raspberry Pi
+ * Copyright (C) 2021 Charles Mirabile, Mwesigwa Guma, Joel Savitz
+ *
+ * Original Author: Serge Schneider
+ * Revised for upstream Linux by: Charles Mirabile, Mwesigwa Guma, Joel Savitz
+ *
+ * This driver is based on wm8350 implementation and was refactored to use the
+ * misc device subsystem rather than the deprecated framebuffer subsystem.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
+#include <linux/mfd/sensehat.h>
+
+#define SENSEHAT_WAI 0xF0
+#define SENSEHAT_VER 0xF1
+
+#define SENSEHAT_ID 's'
+
+static struct platform_device *
+sensehat_client_dev_register(struct sensehat *sensehat, const char *name);
+
+static struct regmap_config sensehat_config;
+
+static int sensehat_probe(struct i2c_client *i2c,
+			  const struct i2c_device_id *id)
+{
+	int ret;
+	unsigned int reg;
+
+	struct sensehat *sensehat =
+		devm_kzalloc(&i2c->dev, sizeof(*sensehat), GFP_KERNEL);
+
+	if (!sensehat)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, sensehat);
+	sensehat->dev = &i2c->dev;
+	sensehat->i2c_client = i2c;
+
+	sensehat->regmap =
+		devm_regmap_init_i2c(sensehat->i2c_client, &sensehat_config);
+
+	if (IS_ERR(sensehat->regmap)) {
+		dev_err(sensehat->dev, "Failed to initialize sensehat regmap");
+		return PTR_ERR(sensehat->regmap);
+	}
+
+	ret = regmap_read(sensehat->regmap, SENSEHAT_WAI, &reg);
+	if (ret < 0) {
+		dev_err(sensehat->dev, "failed to read from device");
+		return ret;
+	}
+
+	if (reg != SENSEHAT_ID) {
+		dev_err(sensehat->dev, "expected device ID %i, got %i",
+			SENSEHAT_ID, ret);
+		return -EINVAL;
+	}
+
+	ret = regmap_read(sensehat->regmap, SENSEHAT_VER, &reg);
+	if (ret < 0) {
+		dev_err(sensehat->dev,
+			"Unable to get sensehat firmware version");
+		return ret;
+	}
+
+	dev_info(sensehat->dev, "Raspberry Pi Sense HAT firmware version %i\n",
+		 reg);
+
+#ifdef CONFIG_JOYSTICK_SENSEHAT
+	sensehat->joystick.pdev =
+		sensehat_client_dev_register(sensehat, "sensehat-joystick");
+
+	if (IS_ERR(sensehat->joystick.pdev)) {
+		dev_err(sensehat->dev, "failed to register sensehat-joystick");
+		return PTR_ERR(sensehat->joystick.pdev);
+	}
+#endif
+#ifdef CONFIG_SENSEHAT_DISPLAY
+
+	sensehat->display.pdev =
+		sensehat_client_dev_register(sensehat, "sensehat-display");
+
+	if (IS_ERR(sensehat->display.pdev)) {
+		dev_err(sensehat->dev, "failed to register sensehat-display");
+		return PTR_ERR(sensehat->display.pdev);
+	}
+#endif
+
+	return 0;
+}
+
+static struct platform_device *
+sensehat_client_dev_register(struct sensehat *sensehat, const char *name)
+{
+	long ret = -ENOMEM;
+	struct platform_device *pdev =
+		platform_device_alloc(name, PLATFORM_DEVID_AUTO);
+
+	if (!pdev)
+		goto alloc_fail;
+
+	pdev->dev.parent = sensehat->dev;
+	platform_set_drvdata(pdev, sensehat);
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		goto add_fail;
+
+	ret = devm_add_action_or_reset(
+		sensehat->dev, (void *)platform_device_unregister, pdev);
+	if (ret)
+		goto alloc_fail;
+
+	return pdev;
+
+add_fail:
+	platform_device_put(pdev);
+alloc_fail:
+	return ERR_PTR(ret);
+}
+
+static struct regmap_config sensehat_config = {
+	.name = "sensehat",
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static const struct i2c_device_id sensehat_i2c_id[] = {
+	{ .name = "sensehat" },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, sensehat_i2c_id);
+
+static struct i2c_driver sensehat_driver = {
+	.driver = { .name = "sensehat" },
+	.probe = sensehat_probe,
+	.id_table = sensehat_i2c_id,
+};
+
+module_i2c_driver(sensehat_driver);
+
+MODULE_DESCRIPTION("Raspberry Pi Sense HAT core driver");
+MODULE_AUTHOR("Serge Schneider <serge@raspberrypi.org>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/sensehat.h b/include/linux/mfd/sensehat.h
new file mode 100644
index 000000000000..5d241dbed174
--- /dev/null
+++ b/include/linux/mfd/sensehat.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Raspberry Pi Sense HAT core driver
+ * http://raspberrypi.org
+ *
+ * Copyright (C) 2015 Raspberry Pi
+ * Copyright (C) 2021 Charles Mirabile, Mwesigwa Guma, Joel Savitz
+ *
+ * Original Author: Serge Schneider
+ * Revised for upstream Linux by: Charles Mirabile, Mwesigwa Guma, Joel Savitz
+ */
+
+#ifndef __LINUX_MFD_SENSEHAT_H_
+#define __LINUX_MFD_SENSEHAT_H_
+#include <linux/miscdevice.h>
+
+#define SENSEDISP_IOC_MAGIC 0xF1
+
+#define SENSEDISP_IOGET_GAMMA _IO(SENSEDISP_IOC_MAGIC, 0)
+#define SENSEDISP_IOSET_GAMMA _IO(SENSEDISP_IOC_MAGIC, 1)
+#define SENSEDISP_IORESET_GAMMA _IO(SENSEDISP_IOC_MAGIC, 2)
+
+struct sensehat {
+	struct device *dev;
+	struct i2c_client *i2c_client;
+	struct regmap *regmap;
+
+	/* Client devices */
+	struct sensehat_joystick {
+		struct platform_device *pdev;
+		struct input_dev *keys_dev;
+	} joystick;
+
+	struct sensehat_display {
+		struct platform_device *pdev;
+		struct miscdevice mdev;
+		struct mutex rw_mtx;
+		u8 gamma[32];
+		struct {
+			u16 b : 5, u : 1, g : 5, r : 5;
+		} vmem[8][8];
+	} display;
+};
+
+enum gamma_preset {
+	GAMMA_DEFAULT = 0,
+	GAMMA_LOWLIGHT,
+	GAMMA_PRESET_COUNT,
+};
+
+#endif
-- 
2.31.1

