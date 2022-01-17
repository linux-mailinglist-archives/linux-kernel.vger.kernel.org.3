Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38845490C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241006AbiAQQNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240936AbiAQQNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:13:33 -0500
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [IPv6:2001:67c:2050:1::465:111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC515C06161C;
        Mon, 17 Jan 2022 08:13:32 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4Jcxlt6Jd8zQkjF;
        Mon, 17 Jan 2022 17:13:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1642436009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a1vsx+73yO//LTfnZakZY7L86flI50eX3rHI5DH1Kqg=;
        b=zU0bgrKjJ15VtjFsLqRsEttsN+gpzHYXCoFVgsaCx7h6N76mJkHfVmhXAlxUebVoX5QS0U
        SpQfF4oDeVR960N0u7lgDlIQOfJuUEEpwuDjYGsNVxPhF6IQsNeRXBoWbGI2etv4Mk2Lki
        uHaJFK3V8Od5TGao7/9X3/3rOk5mzyg5g4vJI0t07ZXuaORBPUQ6Zu59BRl3d4l4U0jyZ7
        oE+aMLNC26bhWy230O84Jg0PvUbISRHJiOq0Uny1a3Q+5mq81WR9pXZN3Fc+tYa7gU7xVy
        YM1EnDfHQA+deH9zW/Z0uw8DOXKN+65EgOehbXU1R96b8BhTVzN5Wsr6QuA3EA==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     linux-hwmon@vger.kernel.org
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: [PATCH v1 4/4] pmbus: Add support for bcm6123 Bus Converter
Date:   Mon, 17 Jan 2022 17:12:50 +0100
Message-Id: <db9cb6a43de9b248b76f815c6c173d1eefd42ad0.1642434222.git.sylv@sylv.io>
In-Reply-To: <cover.1642434222.git.sylv@sylv.io>
References: <cover.1642434222.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

BCM6123 is an Fixed-Ratio DC-DC Converter.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 drivers/hwmon/pmbus/Kconfig   |  9 ++++
 drivers/hwmon/pmbus/Makefile  |  1 +
 drivers/hwmon/pmbus/bcm6123.c | 90 +++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+)
 create mode 100644 drivers/hwmon/pmbus/bcm6123.c

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index c96f7b7338bd..62dac90631c5 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -48,6 +48,15 @@ config SENSORS_ADM1275
 	  This driver can also be built as a module. If so, the module will
 	  be called adm1275.
 
+config SENSORS_BCM6123
+	tristate "Vicor BCM6123 Compatible Power Supplies"
+	help
+	  If you say yes here you get hardware monitoring support for Vicor
+	  BCM6123 Power Supplies.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called bcm6123.
+
 config SENSORS_BEL_PFE
 	tristate "Bel PFE Compatible Power Supplies"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index e5935f70c9e0..2918c2ea7bc5 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_PMBUS)		+= pmbus_core.o
 obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
 obj-$(CONFIG_SENSORS_ADM1266)	+= adm1266.o
 obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
+obj-$(CONFIG_SENSORS_BCM6123)	+= bcm6123.o
 obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
 obj-$(CONFIG_SENSORS_BPA_RS600)	+= bpa-rs600.o
 obj-$(CONFIG_SENSORS_DELTA_AHE50DC_FAN) += delta-ahe50dc-fan.o
diff --git a/drivers/hwmon/pmbus/bcm6123.c b/drivers/hwmon/pmbus/bcm6123.c
new file mode 100644
index 000000000000..78fc259bc40f
--- /dev/null
+++ b/drivers/hwmon/pmbus/bcm6123.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Hardware monitoring driver for Infineon bcm6123
+ *
+ * Copyright (c) 2021 9elements GmbH
+ *
+ * VOUT_MODE is not supported by the device. The driver fakes VOUT linear16
+ * mode with exponent value -8 as direct mode with m=256/b=0/R=0.
+ *
+ * The device supports VOUT_PEAK, IOUT_PEAK, and TEMPERATURE_PEAK, however
+ * this driver does not currently support them.
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pmbus.h>
+#include "pmbus.h"
+
+static struct pmbus_platform_data bcm6123_plat_data = {
+	.flags = PMBUS_NO_CAPABILITY,
+};
+
+static struct pmbus_driver_info bcm6123_info = {
+	.pages = 2,
+	.format[PSC_VOLTAGE_IN] = direct,
+	.format[PSC_VOLTAGE_OUT] = direct,
+	.format[PSC_CURRENT_IN] = direct,
+	.format[PSC_CURRENT_OUT] = direct,
+	.format[PSC_POWER] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+	.m[PSC_VOLTAGE_IN] = 1,
+	.b[PSC_VOLTAGE_IN] = 0,
+	.R[PSC_VOLTAGE_IN] = 1,
+	.m[PSC_VOLTAGE_OUT] = 1,
+	.b[PSC_VOLTAGE_OUT] = 0,
+	.R[PSC_VOLTAGE_OUT] = 1,
+	.m[PSC_CURRENT_IN] = 1,
+	.b[PSC_CURRENT_IN] = 0,
+	.R[PSC_CURRENT_IN] = 3,
+	.m[PSC_CURRENT_OUT] = 1,
+	.b[PSC_CURRENT_OUT] = 0,
+	.R[PSC_CURRENT_OUT] = 2,
+	.func[0] = 0, /* Summing page without voltage readings */
+	.func[1] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
+	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
+	    | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+	    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
+	    | PMBUS_HAVE_IIN | PMBUS_HAVE_POUT,
+};
+
+static int bcm6123_probe(struct i2c_client *client)
+{
+	client->dev.platform_data = &bcm6123_plat_data;
+
+	return pmbus_do_probe(client, &bcm6123_info);
+}
+
+static const struct i2c_device_id bcm6123_id[] = {
+	{"bcm6123", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, bcm6123_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id bcm6123_of_match[] = {
+	{ .compatible = "vicor,bcm6123" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bcm6123_of_match);
+#endif
+
+/* This is the driver that will be inserted */
+static struct i2c_driver bcm6123_driver = {
+	.driver = {
+		   .name = "bcm6123",
+		   .of_match_table = of_match_ptr(bcm6123_of_match),
+		   },
+	.probe_new = bcm6123_probe,
+	.id_table = bcm6123_id,
+};
+
+module_i2c_driver(bcm6123_driver);
+
+MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
+MODULE_DESCRIPTION("PMBus driver for Vicor bcm6123");
+MODULE_LICENSE("GPL");
-- 
2.33.1

