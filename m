Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C74525DA7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378436AbiEMIhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378416AbiEMIhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:37:21 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80BD2655CE;
        Fri, 13 May 2022 01:37:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3mXIG3Lo+JnKrLOd+JtxlIuLJmg5l8XEDVM9OxiRrfuSa0krV5rJHhTauZld+BvI+VZd5o1AIjVdqkP9+EDdeH9a0GRb93jdFmB536M9JxJCLhq0/KZI5wWb9KEeCRQCMbhWzDl6jXyn7UhOFygFwZ31DeB+O135Fg93HoW+9abu6jaAVzpPtr/pCUGqW1+9aOpA+udo7A6Z1KKQ88DPucz/nXCpn53LjgI6oimHddOnXI7Zv4mvHE9aJ3aigWpYCeaF7DC7rnN3hSIjvfw9KdjuRbZyUKpDrtNOG6JGJFeZ4x+ZUlEaBjuhwHvYQcHQ1sOvR6/UIcfWnnnpGPqaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+IwfmZOu53L0UY/fvak0+V27Hs7B6p71/Zsq4rxx/0=;
 b=hH9MYOdsqUjOcbjMmY4Ev7EenfbhupcJRG5oBPp6TEZzwklpqfLZ/vsi6+9ULe68i1ZeFYJYYDS0SE4pR338/YljLyu9HwcyMXh1Hs3XFs+CZZ783X73ldWZsMPQOzHQg6AvPDjiK9tni/ZP7R1Njl/nR/jiKUvUDIcRhoJvKc2ZT1KMK6GzlaS5NTfORfGXJhEp5X8N80xRADR8FcrvBBEknGAN4h8LKJR4JRfQTYA1CCrjPwVV0+NTWogol9IXfWkGntoSppD0qQH9kCkgyYZbVxEyBxli5NNpJv7Ea8Nk63tyyjIZYK1IM7ma6vqNqTUprPHOZz/ts9Wkvm90fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+IwfmZOu53L0UY/fvak0+V27Hs7B6p71/Zsq4rxx/0=;
 b=CFKvgU7KdDgiODF2Uqx9Vz3U+XuPjDPesH1P6a5DMXlchWD+n7PX+mAJHpsKZEiVhp47BmhsaUi224B++RFBuHffy9ZOMkRZbmeFqQeJQK2GecR5Kep2lG4ESgfbPPYH1GnTzekTfGo/nZ9f2SAXc+rxPoB+9fw9tFgS/8AtrmRrGzY66m9RlZPsLYGbGmrUjZL2tG1hTkIANyam+0towsgiTE28NetaZdSQYTtjCktX+O1vOQOd3T1G7fAU3QIEYc2gyMMNzycplZANCP4l/fXlExUtSg0VZJWL5Zk2Ya39A8cEpSwbsz2FgT0YyAt62hm6h2LTDRh9PFVK3HFmQQ==
Received: from DB7PR03CA0105.eurprd03.prod.outlook.com (2603:10a6:10:72::46)
 by DB9PR10MB5642.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 08:37:16 +0000
Received: from DB5EUR01FT081.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:72:cafe::7f) by DB7PR03CA0105.outlook.office365.com
 (2603:10a6:10:72::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15 via Frontend
 Transport; Fri, 13 May 2022 08:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT081.mail.protection.outlook.com (10.152.5.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 08:37:14 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 10:37:14 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.210) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 13 May 2022 10:37:14 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Mark Gross <markgross@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>, Enrico Weigelt <lkml@metux.net>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v3 4/4] leds: simatic-ipc-leds-gpio: add GPIO version of Siemens driver
Date:   Fri, 13 May 2022 10:36:52 +0200
Message-ID: <20220513083652.974-5-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513083652.974-1-henning.schild@siemens.com>
References: <20220513083652.974-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.210]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 096e781e-372d-4433-48aa-08da34bbc840
X-MS-TrafficTypeDiagnostic: DB9PR10MB5642:EE_
X-Microsoft-Antispam-PRVS: <DB9PR10MB5642AE6A430EF79003C2606885CA9@DB9PR10MB5642.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZoIPqiFPTa9qWJee548pQft9du1A2I3XV2bf489oxj4I47cTafnRn2irMJPxxPKzL5J1Ma6u/AG/lwQ23ymIgu9HXibTQaObOfSmT8W/Qj0kAo/xZn5u10k2RFqlNOdM8LIfx+51C70F8WufP05+xCCzvT773tNqhAZfzlnWkn7rFZ9USc4CxiNCMWzS20twQw883LNUN1AjGKIMbB/wL8PLW2mpw3U8tRqB8Ge9B9ZbAywImzCLUqIf5YFxjxcNVP/BsEFIWOxvhAFBwaKckm6069bJ9GW5XheR630cncdUedRbIozJzuoj1RK2vnSxtxZ/eMCgWnilTgRXNopYYmQcdo6QltDYPcihhE3m4jITfeHmjHHBxrU3NO2i9tT0EVtzIvrye1APcAUmAQd4CAWzY8Hs3c7AvMjRPHsPdGlWqENMZELwRH0Sul9wXmnQiJRKoCqBV9hP/rRo6Wa63ktJM9RCeAEg1VAI8ehOXvcj0T9NFjjn3Jh0nLqAepHeAd0wagcEvIS9u9hMp8sjHjlWMvAKNzAzaTHnFORHzS5kyRzbf+gOJ1A8DA1sGWBy1YTrGZMxDkkk/OwFlWn8Dpmm+HGZOOSWQ1YSnuVM/FXAxYSxt9UC8A5Gu9RPdUdIO4SV2dXbtDG0PKvrXhQRHXkc44sBvpyc729m8FWebD8YLlHTa+DOE0J/RMHhuIhdp2esNygtJjJMCWzXN58W/Q==
X-Forefront-Antispam-Report: CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(186003)(26005)(83380400001)(107886003)(54906003)(44832011)(1076003)(82310400005)(316002)(6916009)(47076005)(30864003)(36756003)(16526019)(6666004)(5660300002)(956004)(2616005)(36860700001)(82960400001)(336012)(508600001)(4326008)(8676002)(70206006)(86362001)(70586007)(356005)(81166007)(40460700003)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 08:37:14.8750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 096e781e-372d-4433-48aa-08da34bbc840
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT081.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5642
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apollo Lake the pinctrl drivers will now come up without ACPI. Use
that instead of open coding it.
Create a new driver for that which can later be filled with more GPIO
based models, and which has different dependencies.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/Kconfig                 |   7 +-
 drivers/leds/simple/Makefile                |   1 +
 drivers/leds/simple/simatic-ipc-leds-gpio.c | 105 ++++++++++++++++++++
 drivers/leds/simple/simatic-ipc-leds.c      |  80 +--------------
 drivers/platform/x86/simatic-ipc.c          |   5 +-
 5 files changed, 117 insertions(+), 81 deletions(-)
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c

diff --git a/drivers/leds/simple/Kconfig b/drivers/leds/simple/Kconfig
index bbf8cff3c3f6..fd2b8225d926 100644
--- a/drivers/leds/simple/Kconfig
+++ b/drivers/leds/simple/Kconfig
@@ -1,12 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config LEDS_SIEMENS_SIMATIC_IPC
 	tristate "LED driver for Siemens Simatic IPCs"
-	depends on LEDS_CLASS
+	depends on LEDS_GPIO
 	depends on SIEMENS_SIMATIC_IPC
-	select P2SB
 	help
 	  This option enables support for the LEDs of several Industrial PCs
 	  from Siemens.
 
-	  To compile this driver as a module, choose M here: the module
-	  will be called simatic-ipc-leds.
+	  To compile this driver as a module, choose M here: the modules
+	  will be called simatic-ipc-leds and simatic-ipc-leds-gpio.
diff --git a/drivers/leds/simple/Makefile b/drivers/leds/simple/Makefile
index 8481f1e9e360..1c7ef5e1324b 100644
--- a/drivers/leds/simple/Makefile
+++ b/drivers/leds/simple/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds.o
+obj-$(CONFIG_LEDS_SIEMENS_SIMATIC_IPC)	+= simatic-ipc-leds-gpio.o
diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
new file mode 100644
index 000000000000..4c9e663a90ba
--- /dev/null
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for GPIO based LEDs
+ *
+ * Copyright (c) Siemens AG, 2022
+ *
+ * Authors:
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#include <linux/gpio/machine.h>
+#include <linux/gpio/consumer.h>
+#include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
+	.dev_id = "leds-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 52, NULL, 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 53, NULL, 2, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 57, NULL, 3, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 4, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 5, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
+	},
+};
+
+static const struct gpio_led simatic_ipc_gpio_leds[] = {
+	{ .name = "green:" LED_FUNCTION_STATUS "-3" },
+	{ .name = "red:" LED_FUNCTION_STATUS "-1" },
+	{ .name = "green:" LED_FUNCTION_STATUS "-1" },
+	{ .name = "red:" LED_FUNCTION_STATUS "-2" },
+	{ .name = "green:" LED_FUNCTION_STATUS "-2" },
+	{ .name = "red:" LED_FUNCTION_STATUS "-3" },
+};
+
+static const struct gpio_led_platform_data simatic_ipc_gpio_leds_pdata = {
+	.num_leds	= ARRAY_SIZE(simatic_ipc_gpio_leds),
+	.leds		= simatic_ipc_gpio_leds,
+};
+
+static struct platform_device *simatic_leds_pdev;
+
+static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
+{
+	gpiod_remove_lookup_table(&simatic_ipc_led_gpio_table);
+	platform_device_unregister(simatic_leds_pdev);
+
+	return 0;
+}
+
+static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
+{
+	struct gpio_desc *gpiod;
+	int err;
+
+	gpiod_add_lookup_table(&simatic_ipc_led_gpio_table);
+	simatic_leds_pdev = platform_device_register_resndata(NULL,
+		"leds-gpio", PLATFORM_DEVID_NONE, NULL, 0,
+		&simatic_ipc_gpio_leds_pdata,
+		sizeof(simatic_ipc_gpio_leds_pdata));
+	if (IS_ERR(simatic_leds_pdev)) {
+		err = PTR_ERR(simatic_leds_pdev);
+		goto out;
+	}
+
+	/* PM_BIOS_BOOT_N */
+	gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL, 6, GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod)) {
+		err = PTR_ERR(gpiod);
+		goto out;
+	}
+	gpiod_put(gpiod);
+
+	/* PM_WDT_OUT */
+	gpiod = gpiod_get_index(&simatic_leds_pdev->dev, NULL, 7, GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod)) {
+		err = PTR_ERR(gpiod);
+		goto out;
+	}
+	gpiod_put(gpiod);
+
+	return 0;
+out:
+	simatic_ipc_leds_gpio_remove(pdev);
+
+	return err;
+}
+
+static struct platform_driver simatic_ipc_led_gpio_driver = {
+	.probe = simatic_ipc_leds_gpio_probe,
+	.remove = simatic_ipc_leds_gpio_remove,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	}
+};
+module_platform_driver(simatic_ipc_led_gpio_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
+MODULE_SOFTDEP("pre: platform:leds-gpio");
+MODULE_AUTHOR("Henning Schild <henning.schild@siemens.com>");
diff --git a/drivers/leds/simple/simatic-ipc-leds.c b/drivers/leds/simple/simatic-ipc-leds.c
index 2e7597c143d8..4894c228c165 100644
--- a/drivers/leds/simple/simatic-ipc-leds.c
+++ b/drivers/leds/simple/simatic-ipc-leds.c
@@ -15,7 +15,6 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/platform_data/x86/p2sb.h>
 #include <linux/platform_data/x86/simatic-ipc-base.h>
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
@@ -24,7 +23,7 @@
 #define SIMATIC_IPC_LED_PORT_BASE	0x404E
 
 struct simatic_ipc_led {
-	unsigned int value; /* mask for io and offset for mem */
+	unsigned int value; /* mask for io */
 	char *name;
 	struct led_classdev cdev;
 };
@@ -39,21 +38,6 @@ static struct simatic_ipc_led simatic_ipc_leds_io[] = {
 	{ }
 };
 
-/* the actual start will be discovered with p2sb, 0 is a placeholder */
-static struct resource simatic_ipc_led_mem_res = DEFINE_RES_MEM_NAMED(0, 0, KBUILD_MODNAME);
-
-static void __iomem *simatic_ipc_led_memory;
-
-static struct simatic_ipc_led simatic_ipc_leds_mem[] = {
-	{0x500 + 0x1A0, "red:" LED_FUNCTION_STATUS "-1"},
-	{0x500 + 0x1A8, "green:" LED_FUNCTION_STATUS "-1"},
-	{0x500 + 0x1C8, "red:" LED_FUNCTION_STATUS "-2"},
-	{0x500 + 0x1D0, "green:" LED_FUNCTION_STATUS "-2"},
-	{0x500 + 0x1E0, "red:" LED_FUNCTION_STATUS "-3"},
-	{0x500 + 0x198, "green:" LED_FUNCTION_STATUS "-3"},
-	{ }
-};
-
 static struct resource simatic_ipc_led_io_res =
 	DEFINE_RES_IO_NAMED(SIMATIC_IPC_LED_PORT_BASE, SZ_2, KBUILD_MODNAME);
 
@@ -89,28 +73,6 @@ static enum led_brightness simatic_ipc_led_get_io(struct led_classdev *led_cd)
 	return inw(SIMATIC_IPC_LED_PORT_BASE) & led->value ? LED_OFF : led_cd->max_brightness;
 }
 
-static void simatic_ipc_led_set_mem(struct led_classdev *led_cd,
-				    enum led_brightness brightness)
-{
-	struct simatic_ipc_led *led = cdev_to_led(led_cd);
-	void __iomem *reg = simatic_ipc_led_memory + led->value;
-	u32 val;
-
-	val = readl(reg);
-	val = (val & ~1) | (brightness == LED_OFF);
-	writel(val, reg);
-}
-
-static enum led_brightness simatic_ipc_led_get_mem(struct led_classdev *led_cd)
-{
-	struct simatic_ipc_led *led = cdev_to_led(led_cd);
-	void __iomem *reg = simatic_ipc_led_memory + led->value;
-	u32 val;
-
-	val = readl(reg);
-	return (val & 1) ? LED_OFF : led_cd->max_brightness;
-}
-
 static int simatic_ipc_leds_probe(struct platform_device *pdev)
 {
 	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
@@ -118,9 +80,7 @@ static int simatic_ipc_leds_probe(struct platform_device *pdev)
 	struct simatic_ipc_led *ipcled;
 	struct led_classdev *cdev;
 	struct resource *res;
-	void __iomem *reg;
-	int err, type;
-	u32 val;
+	int err;
 
 	switch (plat->devmode) {
 	case SIMATIC_IPC_DEVICE_227D:
@@ -135,51 +95,19 @@ static int simatic_ipc_leds_probe(struct platform_device *pdev)
 			}
 			ipcled = simatic_ipc_leds_io;
 		}
-		type = IORESOURCE_IO;
 		if (!devm_request_region(dev, res->start, resource_size(res), KBUILD_MODNAME)) {
 			dev_err(dev, "Unable to register IO resource at %pR\n", res);
 			return -EBUSY;
 		}
 		break;
-	case SIMATIC_IPC_DEVICE_127E:
-		res = &simatic_ipc_led_mem_res;
-		ipcled = simatic_ipc_leds_mem;
-		type = IORESOURCE_MEM;
-
-		err = p2sb_bar(NULL, 0, res);
-		if (err)
-			return err;
-
-		/* do the final address calculation */
-		res->start = res->start + (0xC5 << 16);
-		res->end = res->start + SZ_4K - 1;
-
-		simatic_ipc_led_memory = devm_ioremap_resource(dev, res);
-		if (IS_ERR(simatic_ipc_led_memory))
-			return PTR_ERR(simatic_ipc_led_memory);
-
-		/* initialize power/watchdog LED */
-		reg = simatic_ipc_led_memory + 0x500 + 0x1D8; /* PM_WDT_OUT */
-		val = readl(reg);
-		writel(val & ~1, reg);
-
-		reg = simatic_ipc_led_memory + 0x500 + 0x1C0; /* PM_BIOS_BOOT_N */
-		val = readl(reg);
-		writel(val | 1, reg);
-		break;
 	default:
 		return -ENODEV;
 	}
 
 	while (ipcled->value) {
 		cdev = &ipcled->cdev;
-		if (type == IORESOURCE_MEM) {
-			cdev->brightness_set = simatic_ipc_led_set_mem;
-			cdev->brightness_get = simatic_ipc_led_get_mem;
-		} else {
-			cdev->brightness_set = simatic_ipc_led_set_io;
-			cdev->brightness_get = simatic_ipc_led_get_io;
-		}
+		cdev->brightness_set = simatic_ipc_led_set_io;
+		cdev->brightness_get = simatic_ipc_led_get_io;
 		cdev->max_brightness = LED_ON;
 		cdev->name = ipcled->name;
 
diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index 26c35e1660cb..ca3647b751d5 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -51,6 +51,7 @@ static int register_platform_devices(u32 station_id)
 {
 	u8 ledmode = SIMATIC_IPC_DEVICE_NONE;
 	u8 wdtmode = SIMATIC_IPC_DEVICE_NONE;
+	char *pdevname = KBUILD_MODNAME "_leds";
 	int i;
 
 	platform_data.devmode = SIMATIC_IPC_DEVICE_NONE;
@@ -64,10 +65,12 @@ static int register_platform_devices(u32 station_id)
 	}
 
 	if (ledmode != SIMATIC_IPC_DEVICE_NONE) {
+		if (ledmode == SIMATIC_IPC_DEVICE_127E)
+			pdevname = KBUILD_MODNAME "_leds_gpio";
 		platform_data.devmode = ledmode;
 		ipc_led_platform_device =
 			platform_device_register_data(NULL,
-				KBUILD_MODNAME "_leds", PLATFORM_DEVID_NONE,
+				pdevname, PLATFORM_DEVID_NONE,
 				&platform_data,
 				sizeof(struct simatic_ipc_platform));
 		if (IS_ERR(ipc_led_platform_device))
-- 
2.35.1

