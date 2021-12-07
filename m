Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E3A46B325
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 07:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbhLGGtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 01:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbhLGGtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 01:49:18 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7954CC061746;
        Mon,  6 Dec 2021 22:45:48 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id n26so12522842pff.3;
        Mon, 06 Dec 2021 22:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G0omo7Egqr3hytg5r9KH47aiBoXPSyXGzIlq5RGChSA=;
        b=VYlmU4B3WwLuxMzTakTr9D4yheq4v2y4TdCRtge5Vl6prjGqPx5TzVuE+W/ewiQpwh
         9uRf+1hBnt9fOJC1sO0KFrdU/kpct9tyiAApZJeWKyb4+7MaZqexpVHQg5Zcuoh8ff4y
         MuidlwVNBc8hxX42/Sm3fC2563F5Jp2Dbzcv2dRbLZ18Tg3fRlcRjNpM7q7BfJa7CISF
         oM+Pcm3dSmZC9lzAw5smsI89AnD+dXFZpV7mZ79wdMTnbC4pdrq5aESB+XfofA0INZf1
         3ZL6R1kKQfNknM9H0gmPczwtyIWgKZmMrEkL7lW3hmXfvCMdPTHi2L97pV84wjorVTwK
         cZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G0omo7Egqr3hytg5r9KH47aiBoXPSyXGzIlq5RGChSA=;
        b=xSbarpneIWKmCXf7J+UZrtg910GpwqrlAhkNChVPgS/h3jAmOV1mzcOw4KH+Dgeqql
         f4vmIBkl8eBG/TPlm3f5FAZ6wLKniC8YsdnOnkSt9vTFOwNGbjZApaLllmKw2cuj3gtC
         2f6ngiHx33EdUcvRgDzbOQzBXgFqr0/XlTOLFJ2/6e5mn+BureSUXZA43HfXTMYUXup0
         utOcQycEXakOuWzpRgR19YfQCCVDqED/a/RqMe4pKal4OgxzYkojWbNs9ylEEdz/ETMY
         MMP2jMGWCTexsC+ZDckYxoTL3D5nX0tG3gtYWBYZyvwyrffA61Gqk5b/bse780XypDor
         fy2A==
X-Gm-Message-State: AOAM533VuFOf5XyCqO3r7TUnCRAOGffswzszYWFqWudzprM/JfvNMxHM
        yUY0BPlMo+KIb5EcO0KbCGI=
X-Google-Smtp-Source: ABdhPJwzUYfN7C9r5TbnwE8X42vLzMZDr8n/CFZ+xPEt3cZ4jZt2BdFRd81vwTJgeZr7h0CWYageuA==
X-Received: by 2002:a63:8848:: with SMTP id l69mr23277994pgd.41.1638859547882;
        Mon, 06 Dec 2021 22:45:47 -0800 (PST)
Received: from howard-System-Product-Name.dhcpserver.bu9bmc.local (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id g13sm1358326pjc.39.2021.12.06.22.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 22:45:47 -0800 (PST)
From:   Howard Chiu <howard10703049@gmail.com>
X-Google-Original-From: Howard Chiu <howard.chiu@quantatw.com>
To:     linux@roeck-us.net, jdelvare@suse.com, inux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Howard Chiu <howard.chiu@quantatw.com>
Subject: [PATCH v1] hwmon: (pmbus) Add support for MPS Multi-phase mp5023 controller
Date:   Tue,  7 Dec 2021 14:43:25 +0800
Message-Id: <20211207064325.312583-1-howard.chiu@quantatw.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for mp5023 device from Monolithic Power Systems, Inc. (MPS)
vendor. This is a Hot-Swap Controller.

Signed-off-by: Howard Chiu <howard.chiu@quantatw.com>
---
 Documentation/hwmon/mp5023.rst | 80 ++++++++++++++++++++++++++++++++++
 drivers/hwmon/pmbus/Kconfig    |  9 ++++
 drivers/hwmon/pmbus/Makefile   |  1 +
 drivers/hwmon/pmbus/mp5023.c   | 66 ++++++++++++++++++++++++++++
 4 files changed, 156 insertions(+)
 create mode 100644 Documentation/hwmon/mp5023.rst
 create mode 100644 drivers/hwmon/pmbus/mp5023.c

diff --git a/Documentation/hwmon/mp5023.rst b/Documentation/hwmon/mp5023.rst
new file mode 100644
index 000000000000..b88506817406
--- /dev/null
+++ b/Documentation/hwmon/mp5023.rst
@@ -0,0 +1,80 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Kernel driver mp5023
+====================
+
+Supported chips:
+
+  * MPS MP5023
+
+    Prefix: 'mp5023'
+
+Author:
+
+	Howard Chiu <howard.chiu@quantatw.com>
+
+Description
+-----------
+
+This driver implements support for Monolithic Power Systems, Inc. (MPS)
+MP5023 Hot-Swap Controller.
+
+Device complaint with:
+
+- PMBus rev 1.3 interface.
+
+Device supports direct format for reading input voltage, output voltage,
+output current, input power and temperature.
+
+The driver exports the following attributes via the 'sysfs' files
+for input voltage:
+
+**in1_input**
+
+**in1_label**
+
+**in1_max**
+
+**in1_max_alarm**
+
+**in1_min**
+
+**in1_min_alarm**
+
+The driver provides the next attributes for output voltage:
+
+**in2_input**
+
+**in2_label**
+
+**in2_alarm**
+
+The driver provides the next attributes for output current:
+
+**curr1_input**
+
+**curr1_label**
+
+**curr1_alarm**
+
+**curr1_max**
+
+The driver provides the next attributes for input power:
+
+**power1_input**
+
+**power1_label**
+
+**power1_alarm**
+
+The driver provides the next attributes for temperature:
+
+**temp1_input**
+
+**temp1_max**
+
+**temp1_max_alarm**
+
+**temp1_crit**
+
+**temp1_crit_alarm**
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index ffb609cee3a4..b56bd8542864 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -276,6 +276,15 @@ config SENSORS_MP2975
 	  This driver can also be built as a module. If so, the module will
 	  be called mp2975.
 
+config SENSORS_MP5023
+	tristate "MPS MP5023"
+	help
+	  If you say yes here you get hardware monitoring support for MPS
+	  MP5023.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called mp5023.
+
 config SENSORS_PIM4328
 	tristate "Flex PIM4328 and compatibles"
 	help
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index 0ed4d596a948..61cdc24b1309 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
 obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
 obj-$(CONFIG_SENSORS_MP2888)	+= mp2888.o
 obj-$(CONFIG_SENSORS_MP2975)	+= mp2975.o
+obj-$(CONFIG_SENSORS_MP5023)	+= mp5023.o
 obj-$(CONFIG_SENSORS_PM6764TR)	+= pm6764tr.o
 obj-$(CONFIG_SENSORS_PXE1610)	+= pxe1610.o
 obj-$(CONFIG_SENSORS_Q54SJ108A2)	+= q54sj108a2.o
diff --git a/drivers/hwmon/pmbus/mp5023.c b/drivers/hwmon/pmbus/mp5023.c
new file mode 100644
index 000000000000..2d2048c9765e
--- /dev/null
+++ b/drivers/hwmon/pmbus/mp5023.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Driver for MPS MP5023 Hot-Swap Controller
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/of_device.h>
+#include "pmbus.h"
+
+static struct pmbus_driver_info mp5023_info = {
+	.pages = 1,
+
+	.format[PSC_VOLTAGE_IN] = direct,
+	.format[PSC_VOLTAGE_OUT] = direct,
+	.format[PSC_CURRENT_OUT] = direct,
+	.format[PSC_POWER] = direct,
+	.format[PSC_TEMPERATURE] = direct,
+
+	.m[PSC_VOLTAGE_IN] = 32,
+	.b[PSC_VOLTAGE_IN] = 0,
+	.R[PSC_VOLTAGE_IN] = 0,
+	.m[PSC_VOLTAGE_OUT] = 32,
+	.b[PSC_VOLTAGE_OUT] = 0,
+	.R[PSC_VOLTAGE_OUT] = 0,
+	.m[PSC_CURRENT_OUT] = 16,
+	.b[PSC_CURRENT_OUT] = 0,
+	.R[PSC_CURRENT_OUT] = 0,
+	.m[PSC_POWER] = 1,
+	.b[PSC_POWER] = 0,
+	.R[PSC_POWER] = 0,
+	.m[PSC_TEMPERATURE] = 2,
+	.b[PSC_TEMPERATURE] = 0,
+	.R[PSC_TEMPERATURE] = 0,
+
+	.func[0] =
+		PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_PIN |
+		PMBUS_HAVE_TEMP | PMBUS_HAVE_IOUT |
+		PMBUS_HAVE_STATUS_INPUT | PMBUS_HAVE_STATUS_TEMP,
+};
+
+static int mp5023_probe(struct i2c_client *client)
+{
+	return pmbus_do_probe(client, &mp5023_info);
+}
+
+static const struct of_device_id __maybe_unused mp5023_of_match[] = {
+	{ .compatible = "mps,mp5023", },
+	{}
+};
+
+MODULE_DEVICE_TABLE(of, mp5023_of_match);
+
+static struct i2c_driver mp5023_driver = {
+	.driver = {
+		   .name = "mp5023",
+		   .of_match_table = of_match_ptr(mp5023_of_match),
+	},
+	.probe_new = mp5023_probe,
+};
+
+module_i2c_driver(mp5023_driver);
+
+MODULE_AUTHOR("Howard Chiu <howard.chiu@quantatw.com>");
+MODULE_DESCRIPTION("PMBus driver for MPS MP5023 HSC");
+MODULE_LICENSE("GPL");
-- 
2.25.1

