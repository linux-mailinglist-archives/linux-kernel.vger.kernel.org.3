Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF7558DAC9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244755AbiHIPF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244818AbiHIPFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:05:14 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140078.outbound.protection.outlook.com [40.107.14.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C085E1EAFC;
        Tue,  9 Aug 2022 08:05:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGn4rnGhv965x4bzaft1WK8l/M2j1CTRj8HD+urgYr38BHkQeIMtwnfHa/5LEm+horGxuDA1J1L7Y8rusxpCGTFZOROjDzYOP3KjZv+nUT9s2Sv1Z2R6/AfGZxPoQCuy71IznyLSXW8cHmUDZ/vH2C7QdD/kWAEJ4c/gZfHE2aB7Quwl8kKCuAz1rWl9MCqzk2HZ1AodT825YaeG5Lw9o4eSU2WTSd2VlmmUzhTVUtK6MSEQpNcWbTJh5DMTlIWEt94EoZriSOspiDMKgwQtAo1ZQLTdOLa+Hldw4dg5dO85HOtvQk9iIgLKk7fX9pCI7ok387pYHUQqo3b2ceBvWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fra4t7k5jfZkDA4RoMRNACiaCeB1EAzVqt+GvK6XdEE=;
 b=kPiYsMMD0JM8rB6BHODoizn2VwKTMPKRE0cgAG9m6i1OkjOP754Bidhz+VTgqzk0SKhC+Qj12M8XP+IAoEirQOK1mDd2kaTDi7zisnnV+UbZgyD1JiV6U4EP2Vj/jW5hFlj8R/pf4JuDztkyKpAXQPp0Cy4+AV4O3j9qYSpODb5yQhmXaC23lxAZZ1CgJqs/bUzieUh56crn82HWW8oq9FPuSDEWxpc2zT4HKeNdgvJJ20fwzsODEWtkLU70EyNzG+HyzeZGzjstCm3Y2ldYmgza0P3FR2XMOi1o5obZF8/aLTKaaMmkFtAGQsRqHXnzOlFf2Ff4j4+5kZjUT9F4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.75) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fra4t7k5jfZkDA4RoMRNACiaCeB1EAzVqt+GvK6XdEE=;
 b=bOc/kJKLMopi/i5SOiRaAlDa8XS0G9lU/OHGyZmYDktF86QtAxTTOes3O2nTi6rRcESLeXErbYiRun5nZPHUf2darDiRBUJZI6t/gJO4NDlQxUQQwqUoC3UDdgeDzDQT6kcPjp/PoUr5GnmhYqE5OQ8BWcP8wVQmJhhZtCFkR2ykOg2JibayUft+U/TvcPBXIDfpT/0VC/B/5N5kLvlXsSMbyIyHNswBI/TvsuC1/85f60jyCbqfI7wpty+jsKQgJWC5A9zVqB0eQCFM5cEokJ33+eulX4qQs6t6FxEk8P1ug4PmEj8QcWfZkxSopzU+HhmIwHPJ/0gCwh6vn+tsvQ==
Received: from AM6P195CA0066.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:87::43)
 by VI1PR10MB3984.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 9 Aug
 2022 15:05:05 +0000
Received: from VE1EUR01FT090.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:87:cafe::b) by AM6P195CA0066.outlook.office365.com
 (2603:10a6:209:87::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Tue, 9 Aug 2022 15:05:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT090.mail.protection.outlook.com (10.152.3.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 15:05:04 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Tue, 9 Aug 2022 17:05:04 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 9 Aug 2022 17:05:03 +0200
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
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 3/4] leds: simatic-ipc-leds-gpio: add new model 227G
Date:   Tue, 9 Aug 2022 17:04:41 +0200
Message-ID: <20220809150442.3525-4-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220809150442.3525-1-henning.schild@siemens.com>
References: <20220809150442.3525-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
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
X-TM-SNTS-SMTP: 8B5484228CE86B8F61FBD7E031EBFA6C6DCF3488D0C20E725FC9DA9CE4B9562C2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66cd6e45-61c6-421d-5ead-08da7a188a7a
X-MS-TrafficTypeDiagnostic: VI1PR10MB3984:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GwXmVlTW7z8Bf/vYnpRlyX/LspIYT9fpmytrmpzmMEKIsY6vb4CmNw7iwk+8q0SWkRhY5LhJMSBU+lHKmyq4uDdL3nbpzo5r+Vfjb5uIqC73jqyZo04OTVhuVkr1CIhACkZwe8ZbggeBBy0i3G8qIb8A6QkT1p52eZR9S8bFuCUxf0+dV0kHYk77Y8z3Uavqq3P9Sw4NpNnDVQPZ2QJ712IIG7ng+KU4aExWK9SIYkRvsLJamp1luYJ0+BHf1WxJU1nFKOEMNj+TV8eRNFKxLZCrqcGDVS+e3bFimEkUlaX4U7pQaXtYsZxk7A7pPLRUd307+u0b0JRKQIWPQqYdmN9lRxxn2f9JbJooY6wp1x7YTX77a1UveVgiSjBShjx3daJ22hbHzWA+mMHlN/jVRgq483THBu7KcQLWjIO78sOLnxFQyLvFC8fdrfYpmmTyQQt/rvbt560uVR1VotTdXyiKCZaXHniqKAV/IbV0WahGjvtP3cL0tj2Oq40MaBaN/YetNEqTRmageEtdrqCbIdiiFIh7swy6D7fTn5iNTU/EIAooefgHhz/JLzpPxrYQjVGrqiWXAcbJ5zzdBr+USsOKVSws+RajCTgrb3K/T6V1o0YaMXVVgzh26bGnwsAUX/Xbm62lauBUecxS7oOUA4H6aiOsPvIcq+X+AvtnyLLJMN3tCLJm/RZFEVO9Z2jXcX4ut+CG7Fbp3CCy5nYxYS2mDwHPpJuOMzhe8GS2NzA7pOHgTqhiGa/ipXtv7mkXoS9FD/1j1XCmHaj6JkZqZhykSbH+UvtKc6YBHD+KyndLPz35saFHteGw+xs5K1a1cCbbsAQMCQRe+clqoT98r8RZpHu061C7YQPytrYlW9iGMFXK1z/FaWA/mmT8YhcQ+c0e8tzsvGDof8AyoLIpTA==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966006)(40470700004)(36840700001)(316002)(54906003)(110136005)(41300700001)(478600001)(2906002)(40460700003)(82310400005)(40480700001)(70586007)(4326008)(8676002)(7416002)(44832011)(70206006)(5660300002)(8936002)(82740400003)(36860700001)(36756003)(86362001)(81166007)(16526019)(107886003)(82960400001)(356005)(921005)(1076003)(2616005)(956004)(186003)(336012)(47076005)(26005)(6666004)(83380400001)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 15:05:04.6800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cd6e45-61c6-421d-5ead-08da7a188a7a
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT090.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3984
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support of the Siemens Simatic IPC227G. Its LEDs are connected
to GPIO pins provided by the gpio-f7188x module. We make sure that
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

