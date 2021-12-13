Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8FC472BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbhLMMF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:05:28 -0500
Received: from mail-am6eur05on2045.outbound.protection.outlook.com ([40.107.22.45]:44448
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232598AbhLMMFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:05:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyYAlrb45WwevGBS9qJCAV0xtL9MFvPSdFFbeSJ/kW4XjqoYJ1Kfj9UjmnzFjKX+C+l40ndLjZvU+DXn075iX0w7AoP/yF5X8Xm5R+fgJV7duRcg6dermjq4wqpfFjjQBUKXqh6wDyWHtjeosONJ1McG87St54tP0IssGkQjllhI1JJARJyWeJrh6eKPAtKvuhi2UEpeMQwcw9WqhC6kq9FxDULq9X6RuKd8Dnzk1bjDiq3Oc6n8zI31stp3DTDON0h+x/6mKEWwNJZrr517uuiFPDwrVX8TJKf40pzPQdtEKB3hmUtnnTpHe/Ddv5ayG9cQFL1HjfCz19DGfxGk5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2DD134lpTFwEvu4AJH5ciN6KtYuWuHGPSkmng8lTnE=;
 b=lrO25rjAqT4BY6bMdcuDjZsNMkT2IDM/PKUFObPkYqp/kQv6S0nIhDk3tTkcfLDa8MGSJ8wh5NhN0ZiiFWOvHg5SxRkM4WR4LZjqZUI0qYvAPXF88JdSAFLfqNnOyBExgLoEM+ZhDXDoWnXM7qMgRIFrggUy9BB3K5MkbqO2ABPDeeDO8L3TDzEFsLeNSTQKYFfVUEtpaulaYBsisuwf+DrnfDeitffaye7Z9ta7aclUtF7CNcLIZoWoY09A5TVyxQ+S8P3yExo3SO8sTS7wpiPaDZ7TLanjQOJXSjNYMyNKYLENmyGDFzaGvsmbTivrwI6UP/fIjjNeBNPGEm68lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2DD134lpTFwEvu4AJH5ciN6KtYuWuHGPSkmng8lTnE=;
 b=FD1dD+lKC+PQbIYopirGIkODbJmtZR5vv6QSqmuHaocUcRNoQv4dheAJtW54sGk+I55jrlocQEPreHzBo0AUoa0rENdto7LErs9yVnFZlH1TA6xa7b6bf8tzZ0WIS8ze7w2qvJm83+PxhdH7eq4Vy/bjkOqXp88jdVzPuFdPJPpoCbP5TLLfFMVUIiqy2qsPPQR07EOjyDS7Kz6Hi0LYUNf3+Ikww68nD8pRbT8A0dMgM8RlEJMdDdnPrgNE4Ho/kqfNBEFEJdgBRWiVCuC/OhzVXMSBY92AarPsmwVKcmwAI8+glmoO8MN3HS5rveh41SJyFJqQqvWM6EOxi/vsDA==
Received: from DB6PR0601CA0043.eurprd06.prod.outlook.com (2603:10a6:4:17::29)
 by DB7PR10MB2524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 12:05:13 +0000
Received: from DB5EUR01FT048.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:17:cafe::75) by DB6PR0601CA0043.outlook.office365.com
 (2603:10a6:4:17::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.15 via Frontend
 Transport; Mon, 13 Dec 2021 12:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT048.mail.protection.outlook.com (10.152.5.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Mon, 13 Dec 2021 12:05:13 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 13:05:13 +0100
Received: from md1za8fc.ad001.siemens.net (139.25.69.80) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 13:05:13 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>
CC:     Srikanth Krishnakar <skrishnakar@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Henning Schild <henning.schild@siemens.com>,
        "Gerd Haeussler" <gerd.haeussler.ext@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Enrico Weigelt <lkml@metux.net>
Subject: [PATCH v5 2/4] leds: simatic-ipc-leds: add new driver for Siemens Industial PCs
Date:   Mon, 13 Dec 2021 13:05:00 +0100
Message-ID: <20211213120502.20661-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211213120502.20661-1-henning.schild@siemens.com>
References: <20211213120502.20661-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.80]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b46b062e-0659-4330-d343-08d9be30d1ed
X-MS-TrafficTypeDiagnostic: DB7PR10MB2524:EE_
X-Microsoft-Antispam-PRVS: <DB7PR10MB2524017F65FFEF9BDBC12BA885749@DB7PR10MB2524.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:469;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SK5an1SjApr0dkd3IDu98Q6JEqxrHvwsNrzzHji9hyLxlV/pMX4vGcauPeyQOxJGtY5pZoEgkApJbPuKuwLb/K9THAx+95Agw37LcvmJTpInzsssSpD77yWpfTc2ThHIlHtsQeT8T2YjXfablVeUWsPw40iruQIMoV5b1Y+hRQ9NzsIlAYYgU8nC1LP7SqJ+wkpX0UE7uUH7xu8rJndl/jwKRE45jGc+ZaoIK5nvRqdhuOAvvMjsAGjWxiNwakmRgaiFemvigFD64NCfBQ5N2/Jg1VVH+pA6qYWmYKglAc0epX6UD9NMMFT/pw+HS82Ppd+8WRb0LKyeeWPoVPxC+QaFRHBruA5iboK2yCWbXJQbH3EVeu4/Xk++lYBN1cxcpUnfZqBaAWrjmHuTk7l67L54ZY47EfjWAPGV6tQD2RDpppeUJGSplfWwdLGNdP9mA72mxh20CXGvTxDSx1fYIHqBVBjOSbFrFWGnQHxcYqVKTm0MPVBScEykGLxlA2h+v1ANlzZzrCJH9HrjKTOK2G6IQRi3mwK2WdMxta6BZ+03ZyZJZA+4AP1SoTE39DhlNyUcfpq3WyHrPhHjGYbhj5uH939jzuRAxpg3QVKfslEP+I+uOrNac+zfX62Cme8SnDuDPhmlyyigNG6/ThFOc8uK/HyTRHe/1jRL+Y4HvGQ9OdLoeYAzlPjOjLUqE3vKYL6xxVkdUUxLUKXa0byk9Q==
X-Forefront-Antispam-Report: CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(70206006)(336012)(86362001)(6666004)(1076003)(110136005)(47076005)(8936002)(16526019)(2906002)(186003)(956004)(26005)(36756003)(82960400001)(7416002)(36860700001)(70586007)(5660300002)(316002)(2616005)(44832011)(82310400004)(4326008)(83380400001)(8676002)(7596003)(7636003)(508600001)(356005)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 12:05:13.8742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b46b062e-0659-4330-d343-08d9be30d1ed
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT048.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2524
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver adds initial support for several devices from Siemens. It is
based on a platform driver introduced in an earlier commit.

One of the supported machines has GPIO connected LEDs, here we poke GPIO
memory directly because pinctrl does not come up.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/Kconfig                   |   3 +
 drivers/leds/Makefile                  |   3 +
 drivers/leds/simple/Kconfig            |  11 ++
 drivers/leds/simple/Makefile           |   2 +
 drivers/leds/simple/simatic-ipc-leds.c | 202 +++++++++++++++++++++++++
 5 files changed, 221 insertions(+)
 create mode 100644 drivers/leds/simple/Kconfig
 create mode 100644 drivers/leds/simple/Makefile
 create mode 100644 drivers/leds/simple/simatic-ipc-leds.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index ed800f5da7d8..ac6688d7a3f4 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -879,4 +879,7 @@ source "drivers/leds/flash/Kconfig"
 comment "LED Triggers"
 source "drivers/leds/trigger/Kconfig"
 
+comment "Simple LED drivers"
+source "drivers/leds/simple/Kconfig"
+
 endif # NEW_LEDS
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index c636ec069612..1a719caf14c0 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -105,3 +105,6 @@ obj-$(CONFIG_LEDS_TRIGGERS)		+= trigger/
 
 # LED Blink
 obj-y					+= blink/
+
+# Simple LED drivers
+obj-y					+= simple/
diff --git a/drivers/leds/simple/Kconfig b/drivers/leds/simple/Kconfig
new file mode 100644
index 000000000000..9f6a68336659
--- /dev/null
+++ b/drivers/leds/simple/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config LEDS_SIEMENS_SIMATIC_IPC
+	tristate "LED driver for Siemens Simatic IPCs"
+	depends on LEDS_CLASS
+	depends on SIEMENS_SIMATIC_IPC
+	help
+	  This option enables support for the LEDs of several Industrial PCs
+	  from Siemens.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called simatic-ipc-leds.
diff --git a/drivers/leds/simple/Makefile b/drivers/leds/simple/Makefile
new file mode 100644
index 000000000000..8481f1e9e360
--- /dev/null
+++ b/drivers/leds/simple/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds.o
diff --git a/drivers/leds/simple/simatic-ipc-leds.c b/drivers/leds/simple/simatic-ipc-leds.c
new file mode 100644
index 000000000000..ff2c96e73241
--- /dev/null
+++ b/drivers/leds/simple/simatic-ipc-leds.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for LEDs
+ *
+ * Copyright (c) Siemens AG, 2018-2021
+ *
+ * Authors:
+ *  Henning Schild <henning.schild@siemens.com>
+ *  Jan Kiszka <jan.kiszka@siemens.com>
+ *  Gerd Haeussler <gerd.haeussler.ext@siemens.com>
+ */
+
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_data/x86/simatic-ipc-base.h>
+#include <linux/platform_device.h>
+#include <linux/sizes.h>
+#include <linux/spinlock.h>
+
+#define SIMATIC_IPC_LED_PORT_BASE	0x404E
+
+struct simatic_ipc_led {
+	unsigned int value; /* mask for io and offset for mem */
+	char *name;
+	struct led_classdev cdev;
+};
+
+static struct simatic_ipc_led simatic_ipc_leds_io[] = {
+	{1 << 15, "green:" LED_FUNCTION_STATUS "-1" },
+	{1 << 7,  "yellow:" LED_FUNCTION_STATUS "-1" },
+	{1 << 14, "red:" LED_FUNCTION_STATUS "-2" },
+	{1 << 6,  "yellow:" LED_FUNCTION_STATUS "-2" },
+	{1 << 13, "red:" LED_FUNCTION_STATUS "-3" },
+	{1 << 5,  "yellow:" LED_FUNCTION_STATUS "-3" },
+	{ }
+};
+
+/* the actual start will be discovered with PCI, 0 is a placeholder */
+struct resource simatic_ipc_led_mem_res = DEFINE_RES_MEM_NAMED(0, SZ_4K, KBUILD_MODNAME);
+
+static void *simatic_ipc_led_memory;
+
+static struct simatic_ipc_led simatic_ipc_leds_mem[] = {
+	{0x500 + 0x1A0, "red:" LED_FUNCTION_STATUS "-1"},
+	{0x500 + 0x1A8, "green:" LED_FUNCTION_STATUS "-1"},
+	{0x500 + 0x1C8, "red:" LED_FUNCTION_STATUS "-2"},
+	{0x500 + 0x1D0, "green:" LED_FUNCTION_STATUS "-2"},
+	{0x500 + 0x1E0, "red:" LED_FUNCTION_STATUS "-3"},
+	{0x500 + 0x198, "green:" LED_FUNCTION_STATUS "-3"},
+	{ }
+};
+
+static struct resource simatic_ipc_led_io_res =
+	DEFINE_RES_IO_NAMED(SIMATIC_IPC_LED_PORT_BASE, SZ_2, KBUILD_MODNAME);
+
+static DEFINE_SPINLOCK(reg_lock);
+
+static inline struct simatic_ipc_led *cdev_to_led(struct led_classdev *led_cd)
+{
+	return container_of(led_cd, struct simatic_ipc_led, cdev);
+}
+
+static void simatic_ipc_led_set_io(struct led_classdev *led_cd,
+				   enum led_brightness brightness)
+{
+	struct simatic_ipc_led *led = cdev_to_led(led_cd);
+	unsigned long flags;
+	unsigned int val;
+
+	spin_lock_irqsave(&reg_lock, flags);
+
+	val = inw(SIMATIC_IPC_LED_PORT_BASE);
+	if (brightness == LED_OFF)
+		outw(val | led->value, SIMATIC_IPC_LED_PORT_BASE);
+	else
+		outw(val & ~led->value, SIMATIC_IPC_LED_PORT_BASE);
+
+	spin_unlock_irqrestore(&reg_lock, flags);
+}
+
+static enum led_brightness simatic_ipc_led_get_io(struct led_classdev *led_cd)
+{
+	struct simatic_ipc_led *led = cdev_to_led(led_cd);
+
+	return inw(SIMATIC_IPC_LED_PORT_BASE) & led->value ? LED_OFF : led_cd->max_brightness;
+}
+
+static void simatic_ipc_led_set_mem(struct led_classdev *led_cd,
+				    enum led_brightness brightness)
+{
+	struct simatic_ipc_led *led = cdev_to_led(led_cd);
+
+	u32 *p;
+
+	p = simatic_ipc_led_memory + led->value;
+	*p = (*p & ~1) | (brightness == LED_OFF);
+}
+
+static enum led_brightness simatic_ipc_led_get_mem(struct led_classdev *led_cd)
+{
+	struct simatic_ipc_led *led = cdev_to_led(led_cd);
+
+	u32 *p;
+
+	p = simatic_ipc_led_memory + led->value;
+	return (*p & 1) ? LED_OFF : led_cd->max_brightness;
+}
+
+static int simatic_ipc_leds_probe(struct platform_device *pdev)
+{
+	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
+	struct device *dev = &pdev->dev;
+	struct simatic_ipc_led *ipcled;
+	struct led_classdev *cdev;
+	struct resource *res;
+	int err, type;
+	u32 *p;
+
+	switch (plat->devmode) {
+	case SIMATIC_IPC_DEVICE_227D:
+	case SIMATIC_IPC_DEVICE_427E:
+		res = &simatic_ipc_led_io_res;
+		ipcled = simatic_ipc_leds_io;
+		/* on 227D the two bytes work the other way araound */
+		if (plat->devmode == SIMATIC_IPC_DEVICE_227D) {
+			while (ipcled->value) {
+				ipcled->value = swab16(ipcled->value);
+				ipcled++;
+			}
+			ipcled = simatic_ipc_leds_io;
+		}
+		type = IORESOURCE_IO;
+		if (!devm_request_region(dev, res->start, resource_size(res), KBUILD_MODNAME)) {
+			dev_err(dev, "Unable to register IO resource at %pR\n", res);
+			return -EBUSY;
+		}
+		break;
+	case SIMATIC_IPC_DEVICE_127E:
+		res = &simatic_ipc_led_mem_res;
+		ipcled = simatic_ipc_leds_mem;
+		type = IORESOURCE_MEM;
+
+		/* get GPIO base from PCI */
+		res->start = simatic_ipc_get_membase0(PCI_DEVFN(13, 0));
+		if (res->start == 0)
+			return -ENODEV;
+
+		/* do the final address calculation */
+		res->start = res->start + (0xC5 << 16);
+		res->end += res->start;
+
+		simatic_ipc_led_memory = devm_ioremap_resource(dev, res);
+		if (IS_ERR(simatic_ipc_led_memory))
+			return PTR_ERR(simatic_ipc_led_memory);
+
+		/* initialize power/watchdog LED */
+		p = simatic_ipc_led_memory + 0x500 + 0x1D8; /* PM_WDT_OUT */
+		*p = (*p & ~1);
+		p = simatic_ipc_led_memory + 0x500 + 0x1C0; /* PM_BIOS_BOOT_N */
+		*p = (*p | 1);
+
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	while (ipcled->value) {
+		cdev = &ipcled->cdev;
+		if (type == IORESOURCE_MEM) {
+			cdev->brightness_set = simatic_ipc_led_set_mem;
+			cdev->brightness_get = simatic_ipc_led_get_mem;
+		} else {
+			cdev->brightness_set = simatic_ipc_led_set_io;
+			cdev->brightness_get = simatic_ipc_led_get_io;
+		}
+		cdev->max_brightness = LED_ON;
+		cdev->name = ipcled->name;
+
+		err = devm_led_classdev_register(dev, cdev);
+		if (err < 0)
+			return err;
+		ipcled++;
+	}
+
+	return 0;
+}
+
+static struct platform_driver simatic_ipc_led_driver = {
+	.probe = simatic_ipc_leds_probe,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	}
+};
+
+module_platform_driver(simatic_ipc_led_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
+MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
-- 
2.32.0

