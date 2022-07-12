Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E7E571CC5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbiGLOdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233390AbiGLOdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:33:03 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B147BA393;
        Tue, 12 Jul 2022 07:32:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyHHYqEYCeITSqUmiqS/37PPIfw/+O1i3sOrtFrHV84uUd8SlF5IUBGFJ3CqsxUr5lZvqeAl+t1c1FNDwk0xq7Y/dvsajapHFDQwGMjqVhaZkgtPBj8gN9iRKA/leMi3s1KPwgc2MjjtyX6vgvl1V+yjXc7HBUoFmwh6CQnF1jLCduV3GYwFwauIRe2dXF/PtGt1kNzcHv5p+IU2J6idJN4BgBfWc32fC+RQBuWB9pCAiq2eKLBwORrGNfH0rpfwQ5d919zVry2GkiOn6zTR61mQ8WNdN67ON4SEBog6I7uxziAv2xWkFex7di3ct0zWTjSF9jAwoJZKjmMtIHz09Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nwLutBflnyBZMV/HKH3jLSdsiPh+IUZKTjFAhBQoBf4=;
 b=KMvnSKzV6dm7XL1vZYESawP3RnnaVqzOJyGdGOFTGYZv33YCH+gOXFUPnO1fEt1IOyafaJMrAgnivIeCCyOaUdZtgQ/R8IlQGzSVjcyrO+BbjjCo5l2pgi7eOb13bGv0eIfwVDIzxTBFyT9QsDhs9LkE7xPS0SNkH9mARigyJAF+77wnCADq5gqqVb6v2X3Qb3r316C8y9CoD89AReaFvNK/lLqPUiP9b6P1Tec+l+6+hGig2FH1wRZk9l1MQSaDCWCVj4zBXVgUfao/RLSKaVSPNSoero2sVOlCBjtCmo2pKdt35bmSKrS2YwZ76PlnGI6A2kUGnjTi5kxQJOnckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nwLutBflnyBZMV/HKH3jLSdsiPh+IUZKTjFAhBQoBf4=;
 b=RvSDR6cTlb6dX5J3IlbtFKSINd6Gdo6PQALDCejxpg8B7uYnTP5v3tcLXOpqOFSQfK1W05l0MOTKFreO52sC22hBfOnOaXd+jMfUrCeWvGtZFL6jk0HqEnJ+OozQDb4Ciae+J9Yyt7jFk5PGD6NvjUXoEPdg1eKVlHpkbxzTdqCbhnqIqTR47N05gfo/jJIIuU823p19uxXeieuqPviluokZaXj4mFUXxTJgkk0BR8Mevv12Fc4h0FvNqNR6oksb5uQPWJdhHM8ZvPwORRYQ0nV8NqP7QE4mKMW9jZ1IzhpTDVDEC7FI3Z6IP2hiJyX1ea7gowc/zwPqvC8FC7DkAw==
Received: from DB6PR0202CA0010.eurprd02.prod.outlook.com (2603:10a6:4:29::20)
 by VI1PR10MB2558.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 14:32:54 +0000
Received: from DB5EUR01FT069.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:29:cafe::21) by DB6PR0202CA0010.outlook.office365.com
 (2603:10a6:4:29::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Tue, 12 Jul 2022 14:32:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT069.mail.protection.outlook.com (10.152.5.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 14:32:54 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 12 Jul 2022 16:32:48 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.161) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 12 Jul 2022 16:32:48 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
CC:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v3 2/3] leds: simatic-ipc-leds-gpio: add new model 227G
Date:   Tue, 12 Jul 2022 16:32:36 +0200
Message-ID: <20220712143237.13992-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712143237.13992-1-henning.schild@siemens.com>
References: <20220712143237.13992-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.161]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.051300-8.000000
X-TMASE-MatchedRID: PhhAXV/E8uDFiWpUiGitMXibxqQL9M5Vn9v8HoDZ0FGJUlmL3Uj0mFF5
        adRR2Ej1Yy6fApvL8BePKVzaGaT8FjSZ7fU1v8cGIdEenw1YMGhRhHeTkgZm5j8Ckw9b/GFeTFQ
        nI+epPIZVZCccrGnfyBUCx/X5xkUnnMbutg9GaHV4CMgAuim1qLUi+RdXr/ZOqhcdnP91eXFrTW
        aGefu3pAQsw9A3PIlL+ifST869BXUz6mn1o9MiYCq75Q09Yd+O8om7UDiAlrnHmyDJSEsI230tC
        KdnhB589yM15V5aWpj6C0ePs7A07V9vMTaVNFNzhnCXbGOPTDtfxTIYE/WOxju1gO3/3AiO6oOS
        5rp+aqM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.051300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 87A1382DFE6081918F87051CB17ADF2AC55E4ECD7FC0499DF16CC0115930565F2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ba8718f-9e44-453c-ce77-08da64136865
X-MS-TrafficTypeDiagnostic: VI1PR10MB2558:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xgoZ0xNUidYD2DcrvTrX0i997Ye7H00O9uBvEX/EHk5Sy/Y+margLzXed3p3Y3S09oexQjWxhtn8wmahdeyGXQhqrZeZtdooMGl/TNwSfOtnVQoRVr0Hr2gD+bVt8ykHsf7AGhIGrMwgvpE8260xLaq02S7MJpKamwigeUTa0xgujt/dXEODcsMXe29bEPVl1TNELGAyou88QC3Ml3o7YxnEjQLN2m4BEfCIiGH3rH8VeSk3Al+nzELZfInyFdci6UG8NTECkeQZE5BZsb3sRK90SM7m0JV3cy4i7v+scEstLqirZ+CsItNNkKUjcbtQggNIncnYequuGbfGdDzqW6UN0WaDKx3SMpKjYr2aWUzvhthdeU5Ybi1KncqolvQT2EIEUcY3HaQgOylEs6fLbj9hgGMSwXvFXjt2HJFiIgI7h64yI9hE5CNW84JqijRYUhvDZibKVd5h3dcOrF9aDa3mkKmwWn8zjADr61K3joe8axcusQyyZODDtlMgCb6OYhef1ErByYgXOimBABEMoNE1gCeywB9XqT4cWk7JOjs6rdMrvOcRx9MVEZiyqzbjz+mD2VCCQnluRtrxA0yOiaMl2eCpocE29gJGhVrjBD5TSBhXfiHRyLTprqOdJbu9xNOFMWqdX+o3j0qakX+GaW7YFRJmj9a/YdUjIokKWWwHxG9kvk9ZRvR0htDSPcPmp8NTi3KL66ZwIYqnT9uiXb7ZVM/aEVwhsusKSOrONoCYWK7N5sClsggqRMFbwyDDGtEVpS2URzO9imchhZsveNJVWXVNVk0taLAezuGCh5A8WRZLjujGa2+QNcc9w9pLIWCHF1/XMmIkikQegd9657tE4Lp1lQaDPrnDTa45KQ=
X-Forefront-Antispam-Report: CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(40470700004)(46966006)(36840700001)(107886003)(82310400005)(40480700001)(8936002)(26005)(336012)(47076005)(5660300002)(316002)(478600001)(36756003)(41300700001)(110136005)(1076003)(83380400001)(82960400001)(82740400003)(186003)(86362001)(4326008)(8676002)(956004)(356005)(70586007)(36860700001)(70206006)(16526019)(54906003)(40460700003)(44832011)(2906002)(81166007)(6666004)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 14:32:54.4223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba8718f-9e44-453c-ce77-08da64136865
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT069.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2558
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support of the Siemens Simatic IPC227G. Its LEDs are connected
to GPIO pins provided by the gpio_nct6116d module. We make sure that
gets loaded, if not enabled in the kernel config no LED support will be
available.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/leds/simple/simatic-ipc-leds-gpio.c   | 42 ++++++++++++++++---
 drivers/platform/x86/simatic-ipc.c            |  4 +-
 .../platform_data/x86/simatic-ipc-base.h      |  1 +
 include/linux/platform_data/x86/simatic-ipc.h |  1 +
 4 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.c b/drivers/leds/simple/simatic-ipc-leds-gpio.c
index 4c9e663a90ba..2931e2e2dcd4 100644
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
+		GPIO_LOOKUP_IDX("gpio_nct6116d-2", 0, NULL, 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio_nct6116d-2", 1, NULL, 1, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio_nct6116d-2", 2, NULL, 2, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio_nct6116d-2", 3, NULL, 3, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio_nct6116d-2", 4, NULL, 4, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio_nct6116d-2", 5, NULL, 5, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio_nct6116d-2", 6, NULL, 6, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio_nct6116d-3", 6, NULL, 7, GPIO_ACTIVE_HIGH),
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
+		if (!IS_ENABLED(CONFIG_GPIO_NCT6116D))
+			return -ENOTSUPP;
+		request_module("gpio_nct6116d");
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

