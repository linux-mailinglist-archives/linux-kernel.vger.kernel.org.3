Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3D059E48F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbiHWNdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241922AbiHWNcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:32:04 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-ve1eur02on0600.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe06::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A0E857EA;
        Tue, 23 Aug 2022 03:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjYL/KMQgfDbWp0/4mzgvUN4VUWth9PQ4cksSri0LtxfFWHsLgBIJlIagZvX8XvIBggCLkHq5QOGamR34LKzpASl1EpgWP7Y7W/ohZDzzgRBMgN1+G1LjIFSqWWomfi0309CFFly/2l+KDEe3SZyQgqNVzuDEdc0iIJigkVGyqlDaNEF4NmaYj1hKFQejTfrBXUbKo0KPvx4PMSzZVHlVRk8uhk4p5prn0FY868oD9Rnh4rTZm4OLVFmYp4O6O1weTJ1fzF0Y6Dth0AZaTrN8/Vv862jvESpwn8mDJmW5z+J14sHxDxjU8x81mD1fnMpWw/f4Pp6WMfT0eN+lsa+bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uys8JiJg0SwsbAo1MzR11HfF9h4DwhfnG6CyB8d+G2o=;
 b=YYfMzqbYPw9ioKtgF2OmGhPZggFHmISsRglsAzg/65DOSKXVCt4nQgtedV12CIimXVuJsd4gkJiN6G3YELfnEOl4OtlI5Ef6f80zQ+uFGaKAosOHawDzL6+6O3QI2+QNVAMgyd6MYOx6sRpiFOT5eGOGihGEyrL0xE6X+//LvD+afu+gru781hV5Zi3WBEV1fiDpnn7v9k3THaA/MHP4T5+xRZ0ukkNGarkStSGUO8RV82B2fC1ArOfi4bJFcd+x+4Rqvq9TJqreosk4njoeg8h99OWJgnmyfy6m+7vzUDRXR5qbvQtFjZ0J2YeVLyzLMAE8t2rdeE6c6ccDXfDRnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.75) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uys8JiJg0SwsbAo1MzR11HfF9h4DwhfnG6CyB8d+G2o=;
 b=CFmJ2WwCMXdAcwY02yEObUAcFaKCxUHfuFNvXuMhtMmRmIY3DMuTXt8VMQ2s4Jlpis4dsDEdv8Y/CQjH/fZOUDCGFFG7wGqMMWH5kVxmA2nCV87/LIH/U2eNdlJ3U6gBK5Rv88dAqNF+Y7rOuZEa/ZHQYaIQu0stb58WvD3rJgekcsNt9fePUeiypB5NGSrbboUjo8SOw7v0MMuTvPmRMQiY8Q3sJgAkj372AaInpBZAXyXNWuplFyFTN3YaCGSdfrrcMzRGWXzyq9SWJBqn0vWaLr3+no2lMIvid4RfVoZanv0VU9hV+cdwADvMe7BuuSM3jc59tftHiRXaOsjTEA==
Received: from GV3P280CA0033.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::26) by
 DB8PR10MB2650.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:af::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Tue, 23 Aug 2022 10:24:06 +0000
Received: from HE1EUR01FT029.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:9:cafe::1d) by GV3P280CA0033.outlook.office365.com
 (2603:10a6:150:9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11 via Frontend
 Transport; Tue, 23 Aug 2022 10:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT029.mail.protection.outlook.com (10.152.0.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Tue, 23 Aug 2022 10:24:06 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Tue, 23 Aug 2022 12:24:05 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 23 Aug 2022 12:24:05 +0200
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
Subject: [PATCH v4 3/5] leds: simatic-ipc-leds-gpio: add new model 227G
Date:   Tue, 23 Aug 2022 12:23:42 +0200
Message-ID: <20220823102344.17624-4-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220823102344.17624-1-henning.schild@siemens.com>
References: <20220823102344.17624-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.993400-8.000000
X-TMASE-MatchedRID: +FHTzIsWzBfFiWpUiGitMXibxqQL9M5Vn9v8HoDZ0FGJUlmL3Uj0mFF5
        adRR2Ej1cJHSK1bfF9XIk1roNguAzQKr8oJXtCB2yCTsSIAWZKeEtFE/+7XCupxVZzZr7+O769x
        ONVZSrH2eEPi9wVyFrtP+kXNq5kuZrMaxf80qMWtTzfzVMAd4vz9ETA4D04a1CWlWR223da4Xiv
        wflisSrNuykrHhg4Pd836gDighvV0myTOhJRwOLSzQ05q86YIulCv0a7truiL805SSvoAPN58kB
        WlYDDNgmyiLZetSf8mfop0ytGwvXiq2rl3dzGQ1cjuUA+LMX8CNdtODhoevRtu7L1rWUj4KKWpC
        7b5UCw235n1TT1N6/w==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.993400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 286C19467F7B8135A4ECFE34DB58B74416F1C7FA022A171B13D6BDA06D99F4E12000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7027f404-48c9-420c-2154-08da84f19be2
X-MS-TrafficTypeDiagnostic: DB8PR10MB2650:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A5xX8S5MV/+PLW0aTc5jHzf7atMCzqnWc97FvTeU9bbeB7cG61NDuFgdG+KJ5owb3AbfDPB5cb+3tFTwEqWv/133SQKz4CMKdVBfseXBCqSUYnNCJYcrpPoefRtkJ1lwd8pLDJL5Es1dWHDToXfGJH79WKvABFmG3E0E0R3EfTWdMnaTkmZPefSYHJ04LKfqGgC7UkivlknbKd54NOGEePYwPuzLZK2DTk52y/LiSyGx03A3HDB3+ozF+ZAMdwEZpTQWQWzq0K8HTwVjSxBdvtWfvK2VUe4RXVZq3qamP1qR30oW3bwMpckkEwy/HCw3Zrwc3ClDxU3bnMsxInK88er7Ri2my1ndOH5bazhTTBd44bg6kSKMHtytFBH52aRDTHwdMFEQWSmAikpg/N6x0Klx7FJ5R/EUGPdIIYsiE1kuNtOJZvhSnZ+GU4hNC8IyHJAc3sPfSnMMMOuNNL5fpZXXeKA2KMKXUa2JZgm+c6NlMt1yzsCZjq8mG1W3DiQQdCrw/I8hnKNiF8e2LOaT+VQ+NsL/iYZRnjShQi4AP40reYvElkaRuQHAL6/xSnVV4dATunZ8RDCvPFScT79dFYuRX3BTAryyUpukqYehjJBot49cwW2VOQdiF+22fG8QnZWO1sR7zBnRWPS8u8xmxT1PojCD/QZLkD7Pi9+niF97mmm589GFg6xVXoIboKACq7KKVf2SYm6mhfjfgh1/7p+AjiwcknjgrQ6p56BC4hKpAtzOLtM6OecdLqwATWbBmOOMKB7PP9jBUEGWrhRS1TVdcle5gFRpHAwW05Zpv27pxb5bBvpkOQHq/BAaPSqOM1/swlqZHMBvDtpmtEmveqwp985qbVhUuy6+tnUEs9Z5zjiiQWh0o8TbSUvup4Jbphps7O5EJspYtHw7vvVydA==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966006)(36840700001)(40470700004)(83380400001)(40460700003)(40480700001)(921005)(81166007)(356005)(82740400003)(36756003)(36860700001)(70586007)(8676002)(4326008)(70206006)(82310400005)(6666004)(54906003)(7416002)(8936002)(5660300002)(44832011)(26005)(34020700004)(316002)(478600001)(47076005)(110136005)(41300700001)(82960400001)(956004)(2616005)(336012)(86362001)(2906002)(186003)(1076003)(107886003)(16526019)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 10:24:06.2525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7027f404-48c9-420c-2154-08da84f19be2
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT029.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2650
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support of the Siemens Simatic IPC227G. Its LEDs are connected
to GPIO pins provided by the gpio-f7188x module. We make sure that
gets loaded, if not enabled in the kernel config no LED support will be
available.

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

