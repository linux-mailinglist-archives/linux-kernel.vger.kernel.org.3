Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C799D5A0E33
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241192AbiHYKo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241187AbiHYKoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:44:54 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80057.outbound.protection.outlook.com [40.107.8.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E6D18E1E;
        Thu, 25 Aug 2022 03:44:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsZuw5JiBgT3RFQRJLRjScKt9vYTF47icwKPGdxy046A88EFwcm3OK30tiqu0od7QZFwpseQBEi70fTYF2WsMjRfXsda4bQM2ji4QKpc8XvcdlDlNA7rQhaWIKBkB77sPKRLNpuBeyxAo7mpQEqNqbWOkrxVMxCh4zunw295wcWqYsWKjjXFuyHfm9BZ6e8uva0hQbYLyyXXbb+fY49weSoBdiIQcToSEtkCc+MJpD50WWVEQkdEyLI59Vk/muaCMHpzRf6OlXmZgyCya0nV8HWYnCu0dMYslO9+lavU8HDZuMpTKNmqaGvjiFq8Q+/ggqUIvuKf5RkrKHgPeNAL7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGtZGqDc6LA+iwjNfm9cHVQ+NwakcT1QLgyFZ8FGn5M=;
 b=Sj9kBCGx+xjCLjCoXwYaMrVPdIFb3gttYFyZR1XxcakPVNqZxFqJPG3/ezrpt6XQ3QiIUIsPYbhtzgnOy+7aCyoaBIiPjjr117oBRClRKRZtFi8ikCgOCNVhf//V1WP2et9Kgk4I382lOGfxgCSXptXjy23vNHA1Z1tTEyEgftR/yB4x47zAQRfOgnBhxI5FxtKEPhjQzOtIL/A3BNCLNCz/lJWjRR3XnM5Et7vNMNyZjncOwf/cDTdFxbbd67sfb0nk5tG8GG+R8mKinAYjNpXYKE809Bb27Y1xAXS6qXy0ICLXCGhnRWyUp+Jd9FINfkGoaQj7j47uYRINC19MxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGtZGqDc6LA+iwjNfm9cHVQ+NwakcT1QLgyFZ8FGn5M=;
 b=CKUg37JydTEb3nea2RzVnh9fNGagDdI2C8MP43235zmaT3o/LZTPZJcvunM6vmWYzfBKbU89isukgeezaSZmFX5yTr8LzFjPnJsndXo6Ivy3yDXXlPxW2XKSFdRENyr6jNv4nLHAgnXXklR2j3y0a+tDIHqxLhTZCr48/hoR/W+yGGAl8xFkwiDu+oCbSFryn76KxeykV7H9PblvwOSLl6lig9PHsGGxrtXHZ9ZO79pP/YDQuu3eEhuJ05NBaIr9rp3hAZNEv566J6xjt0rn83+DSEdk304IeN3FXLqH4L4zPkBGwliEsfQPa4GfkuMHYl0BVGBRQ1jPc28VunTXVg==
Received: from GV3P280CA0120.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::26) by
 AS8PR10MB5025.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:340::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.14; Thu, 25 Aug 2022 10:44:48 +0000
Received: from HE1EUR01FT056.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:8:cafe::34) by GV3P280CA0120.outlook.office365.com
 (2603:10a6:150:8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 25 Aug 2022 10:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT056.mail.protection.outlook.com (10.152.0.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 10:44:48 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Thu, 25 Aug 2022 12:44:47 +0200
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
Subject: [PATCH v6 4/7] gpio-f7188x: use unique labels for banks/chips
Date:   Thu, 25 Aug 2022 12:44:19 +0200
Message-ID: <20220825104422.14156-5-henning.schild@siemens.com>
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
X-TM-AS-Result: No-10--9.309700-8.000000
X-TMASE-MatchedRID: D+XfgODzmzordWdGoKfUymdUGQPHutoBOT0VlJjRfnH27WtDgGBc8tGO
        cAfHKa6uB2QWi8BF5ShpRezoWC5XLXFnQp1moK9xjO5iMKbqS0z7XyLXPDdLs6chFrOB9kanCy8
        7Unb7MRibKItl61J/yZ+inTK0bC9eKrauXd3MZDVTxudrnzbN7TI0TdGDHTeCxe6/NfpGSBcN14
        644BFiKkyi5Zl49Fqp
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.309700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 79C1488D1547FF70A121871CBCBD2E910B16D2D93238AA0059E925558D514A732000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32564fc4-1748-48a1-f1a9-08da8686d518
X-MS-TrafficTypeDiagnostic: AS8PR10MB5025:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HJTZw8Ez0dumlWAIIooQj5QuEhCACkmKsne7ZGHWlIcZRpLCb4ZhVkBvJJFxP4dOXMEKHWueU9hvGiyjsZGfoyOU+2T5DMBbi3vdTIWcwa7E/jCw6Mfww9AkImGS/WlpEm1NIc5Ktzpwyve1K7Ms/X8OILPFXzd3OHGAFQscGobvdlxmSiTx5BQbwsnTgqq4uuf4fm+aOeAd2/Yx3unCsTFklYYfcDfRyHxzFjRKkSkKPfDLU85pLRbHhh9oyNbxLXuUg9dt87KcTxPFqSW81UgJBbbVAsBGHM6ClVTYXK0OBBfcKjdRgj2xTsDA36pOvuScPbNiAHUfEm2rCn5pLks3dUq0G/pEr+vVPDEF8t59RB/wHA7+VFaNy9MxhGcUjZ15D2CDQKBFQy7BA3smRaqidyvPFC3iffD0/VGMjKOsVao+fUaeAsbyglsLCZgWtIL8hIASI1p83sfJ4cfaJUNxPfiGllfveYUf1mUxleiXcagxDyBOhMrG1iVG1dKeC1MTecaiuTcRoQnTfM/NucMk0M4z3xk0VVSCE0JnG+EXfegx75ldFX64FJTVKfjODPPjitMQkOkOd7OPjstpEEBEZK9fLeGlNPJRyW+0V4GqCIDUMqsdMozLcQC3lPRE+yzvG19BZTRHVyxx9o6E4J7xDiwfjioU9ED0GwAX3JRdzz6Ad0sALmi1GFe1uh+pivTfXLjcNafwbYP+LY7kV+FUcu/TMVucpu8LiZQMxd0f+5oLSVCGw0jAGf/buoydSwAyNlagu2yYgZQMGa5UId/MomL8SytzO3Ot80Ew3wfyourrbrlu0wBks8hGyJeLvOYCI3xRWe3VvR279TJyJkNQWowdBS4U6TpAghhOeoOeh2OZtti3g+E924h5NbXX
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(39860400002)(376002)(36840700001)(40470700004)(46966006)(4326008)(40460700003)(86362001)(70586007)(70206006)(5660300002)(26005)(7416002)(478600001)(6666004)(8936002)(107886003)(356005)(2906002)(40480700001)(81166007)(8676002)(41300700001)(82310400005)(921005)(82960400001)(44832011)(186003)(47076005)(1076003)(336012)(16526019)(82740400003)(2616005)(956004)(36860700001)(83380400001)(36756003)(110136005)(54906003)(316002)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 10:44:48.4269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32564fc4-1748-48a1-f1a9-08da8686d518
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT056.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5025
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

So that drivers building on top can find those pins with GPIO_LOOKUP
helpers.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Simon Guinot <simon.guinot@sequanux.org>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/gpio/gpio-f7188x.c | 138 ++++++++++++++++++-------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
index 29c73ea96466..9effa7769bef 100644
--- a/drivers/gpio/gpio-f7188x.c
+++ b/drivers/gpio/gpio-f7188x.c
@@ -163,10 +163,10 @@ static void f7188x_gpio_set(struct gpio_chip *chip, unsigned offset, int value);
 static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 				  unsigned long config);
 
-#define F7188X_GPIO_BANK(_base, _ngpio, _regbase)			\
+#define F7188X_GPIO_BANK(_base, _ngpio, _regbase, _label)			\
 	{								\
 		.chip = {						\
-			.label            = DRVNAME,			\
+			.label            = _label,			\
 			.owner            = THIS_MODULE,		\
 			.get_direction    = f7188x_gpio_get_direction,	\
 			.direction_input  = f7188x_gpio_direction_in,	\
@@ -191,98 +191,98 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 #define f7188x_gpio_data_single(type)	((type) == nct6116d)
 
 static struct f7188x_gpio_bank f71869_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 6, 0xF0),
-	F7188X_GPIO_BANK(10, 8, 0xE0),
-	F7188X_GPIO_BANK(20, 8, 0xD0),
-	F7188X_GPIO_BANK(30, 8, 0xC0),
-	F7188X_GPIO_BANK(40, 8, 0xB0),
-	F7188X_GPIO_BANK(50, 5, 0xA0),
-	F7188X_GPIO_BANK(60, 6, 0x90),
+	F7188X_GPIO_BANK(0, 6, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
+	F7188X_GPIO_BANK(60, 6, 0x90, DRVNAME "-6"),
 };
 
 static struct f7188x_gpio_bank f71869a_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 6, 0xF0),
-	F7188X_GPIO_BANK(10, 8, 0xE0),
-	F7188X_GPIO_BANK(20, 8, 0xD0),
-	F7188X_GPIO_BANK(30, 8, 0xC0),
-	F7188X_GPIO_BANK(40, 8, 0xB0),
-	F7188X_GPIO_BANK(50, 5, 0xA0),
-	F7188X_GPIO_BANK(60, 8, 0x90),
-	F7188X_GPIO_BANK(70, 8, 0x80),
+	F7188X_GPIO_BANK(0, 6, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
+	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
+	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
 };
 
 static struct f7188x_gpio_bank f71882_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 8, 0xF0),
-	F7188X_GPIO_BANK(10, 8, 0xE0),
-	F7188X_GPIO_BANK(20, 8, 0xD0),
-	F7188X_GPIO_BANK(30, 4, 0xC0),
-	F7188X_GPIO_BANK(40, 4, 0xB0),
+	F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(30, 4, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(40, 4, 0xB0, DRVNAME "-4"),
 };
 
 static struct f7188x_gpio_bank f71889a_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 7, 0xF0),
-	F7188X_GPIO_BANK(10, 7, 0xE0),
-	F7188X_GPIO_BANK(20, 8, 0xD0),
-	F7188X_GPIO_BANK(30, 8, 0xC0),
-	F7188X_GPIO_BANK(40, 8, 0xB0),
-	F7188X_GPIO_BANK(50, 5, 0xA0),
-	F7188X_GPIO_BANK(60, 8, 0x90),
-	F7188X_GPIO_BANK(70, 8, 0x80),
+	F7188X_GPIO_BANK(0, 7, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(10, 7, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
+	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
+	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
 };
 
 static struct f7188x_gpio_bank f71889_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 7, 0xF0),
-	F7188X_GPIO_BANK(10, 7, 0xE0),
-	F7188X_GPIO_BANK(20, 8, 0xD0),
-	F7188X_GPIO_BANK(30, 8, 0xC0),
-	F7188X_GPIO_BANK(40, 8, 0xB0),
-	F7188X_GPIO_BANK(50, 5, 0xA0),
-	F7188X_GPIO_BANK(60, 8, 0x90),
-	F7188X_GPIO_BANK(70, 8, 0x80),
+	F7188X_GPIO_BANK(0, 7, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(10, 7, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(50, 5, 0xA0, DRVNAME "-5"),
+	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
+	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
 };
 
 static struct f7188x_gpio_bank f81866_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 8, 0xF0),
-	F7188X_GPIO_BANK(10, 8, 0xE0),
-	F7188X_GPIO_BANK(20, 8, 0xD0),
-	F7188X_GPIO_BANK(30, 8, 0xC0),
-	F7188X_GPIO_BANK(40, 8, 0xB0),
-	F7188X_GPIO_BANK(50, 8, 0xA0),
-	F7188X_GPIO_BANK(60, 8, 0x90),
-	F7188X_GPIO_BANK(70, 8, 0x80),
-	F7188X_GPIO_BANK(80, 8, 0x88),
+	F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(50, 8, 0xA0, DRVNAME "-5"),
+	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-6"),
+	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-7"),
+	F7188X_GPIO_BANK(80, 8, 0x88, DRVNAME "-8"),
 };
 
 
 static struct f7188x_gpio_bank f81804_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 8, 0xF0),
-	F7188X_GPIO_BANK(10, 8, 0xE0),
-	F7188X_GPIO_BANK(20, 8, 0xD0),
-	F7188X_GPIO_BANK(50, 8, 0xA0),
-	F7188X_GPIO_BANK(60, 8, 0x90),
-	F7188X_GPIO_BANK(70, 8, 0x80),
-	F7188X_GPIO_BANK(90, 8, 0x98),
+	F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(50, 8, 0xA0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(60, 8, 0x90, DRVNAME "-4"),
+	F7188X_GPIO_BANK(70, 8, 0x80, DRVNAME "-5"),
+	F7188X_GPIO_BANK(90, 8, 0x98, DRVNAME "-6"),
 };
 
 static struct f7188x_gpio_bank f81865_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 8, 0xF0),
-	F7188X_GPIO_BANK(10, 8, 0xE0),
-	F7188X_GPIO_BANK(20, 8, 0xD0),
-	F7188X_GPIO_BANK(30, 8, 0xC0),
-	F7188X_GPIO_BANK(40, 8, 0xB0),
-	F7188X_GPIO_BANK(50, 8, 0xA0),
-	F7188X_GPIO_BANK(60, 5, 0x90),
+	F7188X_GPIO_BANK(0, 8, 0xF0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(10, 8, 0xE0, DRVNAME "-1"),
+	F7188X_GPIO_BANK(20, 8, 0xD0, DRVNAME "-2"),
+	F7188X_GPIO_BANK(30, 8, 0xC0, DRVNAME "-3"),
+	F7188X_GPIO_BANK(40, 8, 0xB0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(50, 8, 0xA0, DRVNAME "-5"),
+	F7188X_GPIO_BANK(60, 5, 0x90, DRVNAME "-6"),
 };
 
 static struct f7188x_gpio_bank nct6116d_gpio_bank[] = {
-	F7188X_GPIO_BANK(0, 8, 0xE0),
-	F7188X_GPIO_BANK(10, 8, 0xE4),
-	F7188X_GPIO_BANK(20, 8, 0xE8),
-	F7188X_GPIO_BANK(30, 8, 0xEC),
-	F7188X_GPIO_BANK(40, 8, 0xF0),
-	F7188X_GPIO_BANK(50, 8, 0xF4),
-	F7188X_GPIO_BANK(60, 8, 0xF8),
-	F7188X_GPIO_BANK(70, 1, 0xFC),
+	F7188X_GPIO_BANK(0, 8, 0xE0, DRVNAME "-0"),
+	F7188X_GPIO_BANK(10, 8, 0xE4, DRVNAME "-1"),
+	F7188X_GPIO_BANK(20, 8, 0xE8, DRVNAME "-2"),
+	F7188X_GPIO_BANK(30, 8, 0xEC, DRVNAME "-3"),
+	F7188X_GPIO_BANK(40, 8, 0xF0, DRVNAME "-4"),
+	F7188X_GPIO_BANK(50, 8, 0xF4, DRVNAME "-5"),
+	F7188X_GPIO_BANK(60, 8, 0xF8, DRVNAME "-6"),
+	F7188X_GPIO_BANK(70, 1, 0xFC, DRVNAME "-7"),
 };
 
 static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
-- 
2.35.1

