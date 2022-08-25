Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E415A0E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241274AbiHYKpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241227AbiHYKpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:45:25 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80084.outbound.protection.outlook.com [40.107.8.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDA2A4077;
        Thu, 25 Aug 2022 03:45:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQaHHEyoi2vExzqhgr6EZwa3HwhOyur0TimAM8eXUukDKqcpaGg3+QbTRMAoKfcXxAxrz2aJeY7IUy+UCL0CA2oZXGTxHlpo8ykxHliqjxpUqiL7PPgN9sy4Mo8pMmsobbCUcpTlE0I8clpNtV73c0H96kPG70pvp/mUioe3lMJsiJvLTxEEfUrZsFHF571ZieNbiX5ykWgayDFDceVBjcGKCon8YQJ1TMO941UvVM6NyYX0CsArjK5G9zN08FqUlqBj1MyoLh/qv60UirZVo9/sNuFimmrifeKdlzx/dhJJea/Gh6GHNevYvjctZzhdlWfJn0jxW5kn6V78QPjoWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+2bViNTZBcxo0DYtI+egJrMHPDUebydfxh/wJvFVUo=;
 b=SGHh18twZBIaUS4/eZLOi6xwdTSC7/iuK2k4K1lK930Pu3VLKHOVePoIYxvTrSe1CSsGeAHbM++YKPU/Gr3BbTp01/DARaQPqk/Eqy2w7scZFmG6WbQGoL9baf/3ON7Z4xfTUsSpxk23gwUAebwQFv3hvUe7eoKlItM2/td4nseh7Y4F47+NtehTAlJ57p8XnI2OSXoecnWCPm8oi/46KKR5Ys4W6gY8xa4/JbkqIm9utFVqdtzMi1x29qosLPqh2JBmLs1FA/TNOyCh2+UMz21unryGRSbtDydQXqstC8520IZ4EoafDK3ojhh3E8dOHPBZfvIXCuQYgQ/iS3LDNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 194.138.21.75) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=temperror action=none header.from=siemens.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+2bViNTZBcxo0DYtI+egJrMHPDUebydfxh/wJvFVUo=;
 b=FGBqSJUqA3rQK0p8Pu1TqoFsHUNf1gt5D2nt1EsmaGA93tuaI+SYndVM18qcVhvSDeRCxVfbD5f0lyUkyo8/i5uF8GKvmJTxAnrOMX7pHTk6gTGtqGelkeaCxMyTqdL/TD+BAyUxz4JVNIw0I7aRsh6j6EZGAz0WVrozV88XoCXjqdh09sJZYMthNqel0oMrb/Lz4ydaGWlY3VToaoae6iOuOKXUh3q/oGURi7ihK32cuZyuNFuHStoTF897JS+GrdlQgp183LrVn+Sv1blIXojTTIjsa4v/eNCIDmda2KXtjBSR9YxhlnzhGg/FEB0Mt8M8Ywr3/TVOEgx3BFcaTw==
Received: from AS8PR04CA0030.eurprd04.prod.outlook.com (2603:10a6:20b:310::35)
 by AM6PR10MB3109.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 10:44:50 +0000
Received: from VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:310:cafe::dc) by AS8PR04CA0030.outlook.office365.com
 (2603:10a6:20b:310::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 25 Aug 2022 10:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 194.138.21.75) smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=siemens.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of siemens.com: DNS Timeout)
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT059.mail.protection.outlook.com (10.152.3.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 10:44:49 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Thu, 25 Aug 2022 12:44:48 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 25 Aug 2022 12:44:47 +0200
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
Subject: [PATCH v6 5/7] leds: simatic-ipc-leds-gpio: add new model 227G
Date:   Thu, 25 Aug 2022 12:44:20 +0200
Message-ID: <20220825104422.14156-6-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825104422.14156-1-henning.schild@siemens.com>
References: <20220825104422.14156-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.474100-8.000000
X-TMASE-MatchedRID: Qby9J4e4UdTFiWpUiGitMXibxqQL9M5Vn9v8HoDZ0FGJUlmL3Uj0mFF5
        adRR2Ej1cJHSK1bfF9Umgo5BSqf/nu3KKKhzBK2tQq3vCgXA4C0S5iXdhf8hbmwTEruL9ObTP6T
        ki+9nU3/yY5FJckXFdm7lBX/37R4pI1uRVimIzhiFXYmCt5bnqrc+8pJXJ20jEhGH3CRdKUVcaN
        B/u5yQq+jMOEZ5AL0Sg7lN9LOvFDugzZZTnrU2qAGgqRQZQsCi/N0WsxWI4QdKzOvae5Q0rOBef
        ETzWLKxeUMkPpZu/kCjxYyRBa/qJcFwgTvxipFajoczmuoPCq2xjy26AbxiQ66ZsFHm/46eQuSZ
        FB5k+XLER/K3k5CAOvtse/274YkU
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.474100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 4781B099614B9956418F31726BDE52EAEC0ABEFBFAB9CB0C94722DC01939C9362000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab663d60-a025-4e8a-36ab-08da8686d5e1
X-MS-TrafficTypeDiagnostic: AM6PR10MB3109:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2mu4zzohpsz00OUANoxkida43p9WpdeU7CBO2CVlFPFOhEPkaOl6dT1BVj9bMiGtCBEMR4AeyLxGPyy7xGxM1OKWyY2dJ3Exidl6IpVBjdWyb8HRGSZaC9w06GdzL7h1ZGafysqALVrWfXv/qCvbhQN0Dos/BkunGyqNL/oLFXTIOTOc/ceH/x2ghJmyaAlV8P59G52yBkEEZUY/W16AYn/qwK8nNTOiPNwKWuqts9MdCfAYWDrkRXAwzXe59CxGN/KG7BF9bGaMvJSEv2PWhfsULGLlbH6ZMMzQv3K/VhlEIHZZ+XuSdW9SyFZnHGbysXnNnkdKk62YoOjMmTiYhOqRe/4tEZE5z5cSA3qv5Uc7/ij2FFYXizU/HWJmj1wYwSoRqxpnV/ZW2e3HvoEpYLUnY5SGR7vW9ES5lwT8uXBl9rH+Dj1EG0TLfe3imHQSNmwp/aYgLyqsQ2shvGP7KjM54dIBv6PQRcdKp9qg1yea2mdaIxmbqVd+YQPTvD1G7eJn9AY1z/KrI7tRg5bD7Ent6fMM4U7aTqykTpWmXk7V0TOA1NZB7lPq3k7HpoOU0+cZUPZWyh69UQBsP2o98lP2Bb8OB3bnLXmuWAeQg7UlYmyuqHZD4BBh8iPOcscfMHTBTz/xrYsGIs++4mYGRc9Q2oe8dYraVmaugcMkWH0D6Y5rf04NMWKOnsO5QIFolSxU/qY8MtyEvk0psz6uJGWFVTbz0GCfZLCiBK2Tz7oScxUI/lRsfkrImfoUmpBKpgBbVszc/syjhg+5/N6XZRj3AIKUN0dJPaCPymy0E/x6LsXfY/epcpB0bILrvIJOfh+ddwJjeN1cfuLASN4PB7jHPUca842m+i22/kpXnejTBvIuGg5EH7xHPR1xr2iD
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(40470700004)(46966006)(36840700001)(44832011)(70206006)(70586007)(6666004)(40480700001)(82310400005)(107886003)(2906002)(36756003)(8936002)(5660300002)(7416002)(478600001)(4326008)(54906003)(316002)(110136005)(41300700001)(8676002)(186003)(336012)(16526019)(26005)(2616005)(956004)(1076003)(47076005)(63370400001)(83380400001)(63350400001)(40460700003)(36860700001)(82960400001)(356005)(921005)(81166007)(86362001)(82740400003)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 10:44:49.7767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab663d60-a025-4e8a-36ab-08da8686d5e1
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB3109
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

