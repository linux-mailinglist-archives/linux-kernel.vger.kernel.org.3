Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DA959FCA7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbiHXOEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbiHXOEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:04:16 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9227096FD8;
        Wed, 24 Aug 2022 07:04:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjPi+DFzLk+RIs2TYOEzKdTjpEQPLtPMMDXkf6kXaaykmMPE9ewc838vgK9x031UmXg1TNxEuerNGLJ/VsAeZ/GfscYx/frG6B96RO/Yx2Q6Ne1iyV7/iHN+2rgIbbcnZF9yeKka+jcc5Xg7WrIAsReQ+TlcdMgwoKYNa0hAAVNcbrXv2tPvjHLBFiSzaYR3AGKqLAPX/5RHKZq3rByfF2AJ0X3gqbzXaReeP428A9wcddcSQXnZO789tFx2/wGpU1cDIsgncuuLW75XNNlKzkiwlRfHzb73eopwLst+/hsUK6jITGgM3IvfujGzbRzuof0SAttIJThXpEowuQsE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+2bViNTZBcxo0DYtI+egJrMHPDUebydfxh/wJvFVUo=;
 b=HqkwFsZTLPgouZn1jh/Acmq6xTeWOzGm82GL84vV321kKycQOYLzQaRCaAk5swZ/+Z0ePIZoaAFkwdKEqegPmHVO8QOhw3eFJmJkifcEHN+pgKTYtOOl25GBGdphWkA9tYVQQA8RmVQSIBYEKZM5dWgKYbcRpOYlpjB0LrHn0H02+iM6gbJZGtFHJ9e/ylcf8EwXul+HthV0eFpQJg3nJnaLTunvMbfgyc05TDZzBNJKGCq7SY+zxCDhHcgjWlKLDiHzXxkcSZj3ordkxWjibRWRVm/PTDjoIef48F7T24TGjWKIjcpP38FnuMzuUzzPxpd+y+8j7TqNYPRNfj5TLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.74) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+2bViNTZBcxo0DYtI+egJrMHPDUebydfxh/wJvFVUo=;
 b=J50nK9aOucw4EWy+DO6ndLVR/4HO51NH8j0SzDKWXGxIsoYWsYGkEKrv2I/dyn8sN6HxiGRhepnCeYwj2numZQ0Vw5yLaIflI/DWg6gu/lp1d9WdZUBmKn9oOUuMMTuQ+tnMuhWa7JbHRYlIBWLeWpHx+SVuA2MzYRJdRQbym54sEJ1ScKp835RCauNDv1l7VIBTpJCDcDYQA6vKIDQvbTtyhSteVs6xxjJDqPqX9utaAUfK0dogWv8wsBydrNr/kZDCIAspp/4jppkNRd1V0ga9fq1UFgRCTPiuTx3BJtkWverI6Lyz45b4EgP0H6KvvSCjkYc+XLp4mRUrtx3QNA==
Received: from DB6P191CA0017.EURP191.PROD.OUTLOOK.COM (2603:10a6:6:28::27) by
 AM9PR10MB4197.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 14:04:12 +0000
Received: from DB5EUR01FT085.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:28:cafe::e0) by DB6P191CA0017.outlook.office365.com
 (2603:10a6:6:28::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Wed, 24 Aug 2022 14:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT085.mail.protection.outlook.com (10.152.5.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 14:04:11 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Wed, 24 Aug 2022 16:04:11 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 24 Aug 2022 16:04:09 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Pavel Machek <pavel@ucw.cz>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee@kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>
CC:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>,
        <simon.guinot@sequanux.org>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v5 3/5] leds: simatic-ipc-leds-gpio: add new model 227G
Date:   Wed, 24 Aug 2022 16:03:45 +0200
Message-ID: <20220824140347.1842-4-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220824140347.1842-1-henning.schild@siemens.com>
References: <20220824140347.1842-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05109a20-0f60-45d1-f2d1-08da85d9857e
X-MS-TrafficTypeDiagnostic: AM9PR10MB4197:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yuMLARvgakdg0WHhY+myRmglHNOruygRrruQ+U3HHB7DIS5P3OC5zBdVSEaImT7XKkl/tMgkxfcfrjYidt/jFkdCbk0bjo1Lo1aUBeJzoXBR92+iEECYE68eJ162w2p9tUs1C+dcFdfpk6u7xGq6tcs6lwIr/gg+8bZn85hP/HgGRADBrgjphtpieEHS65ni4QvROwUe4htmFtQT4vnbIAhbpO05biWHrECC9M6IOmuJ0AGRLgAH/2M/rCLR+LTepED7pG8y6bUt9HhlECKS2q8pApO2hqXYMOrr/L+Lg1D7MEMrhLisk9trdWhH9dHvJDzV+32TCGBCP0MAExkchlaCKcr9V3jTX/0r1birFD7ZJ21Cr+AYIznQHoHiqjRrVbxB7SfpIh/KislmEh0ickMwVKAwIcl+b+sRu443hJLwl+lTsRE+620Dpal6YYjltkOBoPQQm2aeWL9sKzLsj5blDjvBR3RzFhXRppk60a7e8NdABTi8Gw+cPcJQMbFbXpJ31+7jNWc4rg+qiOC1cDGYwqYEOPfc5Zh6m+tKqq/dv9Ii6zgx1DkT+BOnYMPX92eHhJMAEG0ZDdXhp9IazSy/JRCWAxeJ27k9dP7shAK5voGY3QkhxmOueSsfCz8bqZ/TsC6PZ9XKG0mD8wDz9OVEAg13UbpsmXDIQudkRRMTG4h1bOX/yiyQ1PR76HYxVCiHuh4dAaJSdFql9CxphIQeQLcGI1W8FORXw8YFqrpmiShVc2QrvbIyg/V3f1AHxYOXaPkYzLrG0M/p3j3fhbZOZcS5SU0VwYMGPSbgfpRy16+byD11Pn1EU47cLytNsICDGN2iq72mjJhCpTNk9egsPP22fxWltq+qnLgJlx0C/7WodudIfU+ig+W8nMpx
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966006)(36840700001)(40470700004)(8676002)(4326008)(316002)(70206006)(54906003)(110136005)(82310400005)(40480700001)(70586007)(40460700003)(44832011)(8936002)(7416002)(5660300002)(2906002)(82740400003)(36860700001)(34020700004)(36756003)(86362001)(82960400001)(356005)(921005)(7596003)(7636003)(41300700001)(26005)(6666004)(107886003)(478600001)(47076005)(83380400001)(956004)(186003)(16526019)(2616005)(1076003)(336012)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 14:04:11.9808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05109a20-0f60-45d1-f2d1-08da85d9857e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT085.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4197
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support of the Siemens Simatic IPC227G. Its LEDs are connected
to GPIO pins provided by the gpio-f7188x module. We make sure that
gets loaded, if not enabled in the kernel config no LED support will be
available.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/simatic-ipc-leds-gpio.c   | 42 ++++++++++++++++---
 drivers/platform/x86/simatic-ipc.c            |  4 +-
 .../platform_data/x86/simatic-ipc-base.h      |  1 +
 include/linux/platform_data/x86/simatic-ipc.h |  1 +
 4 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
index 4c9e663a90ba..0d73dcbeec2d 100644
--- a/drivers/leds/simple/simatic-ipc-leds-gpio.c
+++ b/drivers/leds/simple/simatic-ipc-leds-gpio.c
@@ -13,28 +13,45 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/x86/simatic-ipc-base.h>
 
-static struct gpiod_lookup_table simatic_ipc_led_gpio_table = {
+struct gpiod_lookup_table *simatic_ipc_led_gpio_table;
+
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_127e = {
 	.dev_id = "leds-gpio",
 	.table = {
-		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 0, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 52, NULL, 1, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 53, NULL, 2, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 57, NULL, 3, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 58, NULL, 4, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 60, NULL, 5, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 51, NULL, 0, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 56, NULL, 6, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX("apollolake-pinctrl.0", 59, NULL, 7, GPIO_ACTIVE_HIGH),
 	},
 };
 
+static struct gpiod_lookup_table simatic_ipc_led_gpio_table_227g = {
+	.dev_id = "leds-gpio",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 0, NULL, 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 1, NULL, 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 2, NULL, 2, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 3, NULL, 3, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 4, NULL, 4, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-2", 5, NULL, 5, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-f7188x-3", 6, NULL, 6, GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP_IDX("gpio-f7188x-3", 7, NULL, 7, GPIO_ACTIVE_HIGH),
+	}
+};
+
 static const struct gpio_led simatic_ipc_gpio_leds[] = {
-	{ .name = "green:" LED_FUNCTION_STATUS "-3" },
 	{ .name = "red:" LED_FUNCTION_STATUS "-1" },
 	{ .name = "green:" LED_FUNCTION_STATUS "-1" },
 	{ .name = "red:" LED_FUNCTION_STATUS "-2" },
 	{ .name = "green:" LED_FUNCTION_STATUS "-2" },
 	{ .name = "red:" LED_FUNCTION_STATUS "-3" },
+	{ .name = "green:" LED_FUNCTION_STATUS "-3" },
 };
 
 static const struct gpio_led_platform_data simatic_ipc_gpio_leds_pdata = {
@@ -46,7 +63,7 @@ static struct platform_device *simatic_leds_pdev;
 
 static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
 {
-	gpiod_remove_lookup_table(&simatic_ipc_led_gpio_table);
+	gpiod_remove_lookup_table(simatic_ipc_led_gpio_table);
 	platform_device_unregister(simatic_leds_pdev);
 
 	return 0;
@@ -54,10 +71,25 @@ static int simatic_ipc_leds_gpio_remove(struct platform_device *pdev)
 
 static int simatic_ipc_leds_gpio_probe(struct platform_device *pdev)
 {
+	const struct simatic_ipc_platform *plat = pdev->dev.platform_data;
 	struct gpio_desc *gpiod;
 	int err;
 
-	gpiod_add_lookup_table(&simatic_ipc_led_gpio_table);
+	switch (plat->devmode) {
+	case SIMATIC_IPC_DEVICE_127E:
+		simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_127e;
+		break;
+	case SIMATIC_IPC_DEVICE_227G:
+		if (!IS_ENABLED(CONFIG_GPIO_F7188X))
+			return -ENODEV;
+		request_module("gpio-f7188x");
+		simatic_ipc_led_gpio_table = &simatic_ipc_led_gpio_table_227g;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	gpiod_add_lookup_table(simatic_ipc_led_gpio_table);
 	simatic_leds_pdev = platform_device_register_resndata(NULL,
 		"leds-gpio", PLATFORM_DEVID_NONE, NULL, 0,
 		&simatic_ipc_gpio_leds_pdata,
diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index ca3647b751d5..1825ef21a86d 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -41,6 +41,7 @@ static struct {
 	{SIMATIC_IPC_IPC127E, SIMATIC_IPC_DEVICE_127E, SIMATIC_IPC_DEVICE_NONE},
 	{SIMATIC_IPC_IPC227D, SIMATIC_IPC_DEVICE_227D, SIMATIC_IPC_DEVICE_NONE},
 	{SIMATIC_IPC_IPC227E, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_227E},
+	{SIMATIC_IPC_IPC227G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_NONE},
 	{SIMATIC_IPC_IPC277E, SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227E},
 	{SIMATIC_IPC_IPC427D, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_NONE},
 	{SIMATIC_IPC_IPC427E, SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_427E},
@@ -65,7 +66,8 @@ static int register_platform_devices(u32 station_id)
 	}
 
 	if (ledmode != SIMATIC_IPC_DEVICE_NONE) {
-		if (ledmode == SIMATIC_IPC_DEVICE_127E)
+		if (ledmode == SIMATIC_IPC_DEVICE_127E ||
+		    ledmode == SIMATIC_IPC_DEVICE_227G)
 			pdevname = KBUILD_MODNAME "_leds_gpio";
 		platform_data.devmode = ledmode;
 		ipc_led_platform_device =
diff --git a/include/linux/platform_data/x86/simatic-ipc-base.h b/include/linux/platform_data/x86/simatic-ipc-base.h
index 39fefd48cf4d..57d6a10dfc9e 100644
--- a/include/linux/platform_data/x86/simatic-ipc-base.h
+++ b/include/linux/platform_data/x86/simatic-ipc-base.h
@@ -19,6 +19,7 @@
 #define SIMATIC_IPC_DEVICE_427E 2
 #define SIMATIC_IPC_DEVICE_127E 3
 #define SIMATIC_IPC_DEVICE_227E 4
+#define SIMATIC_IPC_DEVICE_227G 5
 
 struct simatic_ipc_platform {
 	u8	devmode;
diff --git a/include/linux/platform_data/x86/simatic-ipc.h b/include/linux/platform_data/x86/simatic-ipc.h
index f3b76b39776b..7a2e79f3be0b 100644
--- a/include/linux/platform_data/x86/simatic-ipc.h
+++ b/include/linux/platform_data/x86/simatic-ipc.h
@@ -31,6 +31,7 @@ enum simatic_ipc_station_ids {
 	SIMATIC_IPC_IPC427E = 0x00000A01,
 	SIMATIC_IPC_IPC477E = 0x00000A02,
 	SIMATIC_IPC_IPC127E = 0x00000D01,
+	SIMATIC_IPC_IPC227G = 0x00000F01,
 };
 
 static inline u32 simatic_ipc_get_station_id(u8 *data, int max_len)
-- 
2.35.1

