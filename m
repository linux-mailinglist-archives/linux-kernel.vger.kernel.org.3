Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280515843BA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiG1P5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiG1P5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:57:11 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463B261D48;
        Thu, 28 Jul 2022 08:57:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROTBifVeY+U8cEGDCsGgyB6ObdWeC3HIcl4a/EQ/QIXRE7W32/5nJmnBgXegSxFjSrUqknsSaQGK3ePvHMLH4leTM0h3T+MkdcgqMc0vg79GnNT4970rm7VfqBYzLXv+VHbu3kHQpXgCwRPY10OjnJS7l78rclPp03bvl0UWYYaqg8EN1bKsq0JRMJddkV07tfQ8c/+tJK9MAmNkSOjoubFG4VS9Nf6/gKIPcnCqYHYvk3Mbeyza/EUCjnx7UgtWjgUJrksNwejiUQP4Ihcrq/vwhQgY44LDNcZ7a/AFSyRbiQtj4yBniDevjbP+qxldlHyEIdkUosL9G5hOptB9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=la1KRgcGK4dZq7v/VZiuS81LKrzy74zjsGQ5ifXobQg=;
 b=nuI+O45bJWsGLo5lkv2bglgauj0n/OZEJxZi+l6eUv9lhtn3iQUOAO4fTzBO6BFCsNMQkf9YgzKINLxlKggIiQoPkCcsf/I30hVpOLJ74NDzpm34uibhN9in9IRfHzreQdtnykw2vfIXI9w4PauIFqEIfrM34WwkNm//kCpTb2tj12SjK1hH4jYOZgwXaCHG8byj0bto7Xirv5MiNVmZJInsTVR54G3alWu+QTGyONAOUboIEk9r8D8c298FUNHXyWz1PJ2KZiXNnRg4+19s9MeSlX33mHKPDZ9kGHXd5jT5VHhOKNHYiGheJ4i8338fV+uZ5eTdn2yc6YcVce44Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=la1KRgcGK4dZq7v/VZiuS81LKrzy74zjsGQ5ifXobQg=;
 b=H00lp0IWvROSHDHtCr6sC2whNgTtgf+kdm/EVrMYXPXBqRcHbZS2j16ppaPdQZpBkovIEsamC6Hv/FOruVYL7MykoJqnFCGULKf1e27GzH8e5jympgak4zfCzmmfEs/2flzu1AxV+Y+XuDCMLAxueTUxGOhTbaHuscXYGu/i2DxMZSDXrT3NOp/DZTXltmkYJAmxROxqoCUP7tPSEBf3BgHxK935sXC5nWtF+HVP7nP5mGWjDU8bXFnUTuWy2ALG7kPh4+BPf+xJuhO7AMI0u2u8vG/s58nEcHzCdC9+NTY5me7Q74Niejpr/iPNaOkEhG51qbQuyMaxtiyNV5R6cg==
Received: from DU2PR04CA0304.eurprd04.prod.outlook.com (2603:10a6:10:2b5::9)
 by AM7PR10MB3686.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 28 Jul
 2022 15:57:03 +0000
Received: from DB5EUR01FT089.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:2b5:cafe::e4) by DU2PR04CA0304.outlook.office365.com
 (2603:10a6:10:2b5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11 via Frontend
 Transport; Thu, 28 Jul 2022 15:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT089.mail.protection.outlook.com (10.152.5.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.10 via Frontend Transport; Thu, 28 Jul 2022 15:57:03 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 28 Jul 2022 17:57:02 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.242) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 28 Jul 2022 17:57:02 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
CC:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 2/4] gpio-f7188x: use unique labels for banks/chips
Date:   Thu, 28 Jul 2022 17:56:50 +0200
Message-ID: <20220728155652.29516-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220728155652.29516-1-henning.schild@siemens.com>
References: <20220728155652.29516-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.242]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1a985a1-1e1f-41a3-029d-08da70b1d037
X-MS-TrafficTypeDiagnostic: AM7PR10MB3686:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8ibihkolTxmpgDUmsqLwoNm5sNfTINfrpOADj8F5A34nBzF39XFph7lEcCCPyg/RwGgkzyUmEonCCQi4hcJ6K0IFVmYWLNo0CTIhn4QDOMOTNh/152dVjsU5ZWQhLZq9zlkQNOQXq2usdsksBbNu21U/8N++5bag2/C4pkCeeONn2qIYOqxr6E8J6+dsdT+dSeTOyT/ExwtwCF0XQlQMHMjIts0lY1hyCG5YqVvBbO3rKT7I2rWXUBhD8hiCvGHVurUhoxUtwZsZkBUyeB6LKpfL6jyemlxC/D+UOrkTtDYLc1mPkB326BEPlIvshUGWUxiJ9KFEp7CjUCIVZYBlqOf0mGfQjp43dvQoyviWsl71qDSqdZnVxABk+JPbHKcYt2wEtuAHjdlvwt6yC7Nlb/uf6lc9XPvrbrreKvA9bF1tAgtXl4bZqbdHslUxXLivnKWtxA7syGqB91A60MoHtjkGZiSqEFcPMozzNpkNROe0sW5cQvp/PC9hwSriDPtK16N+Q+DKSAXwuHTMzrKGCxXJbA6sfOCLF1eWxgVAi6xD2LQgbD7zuprtrEMVO3R8LiBwAPRhFCWlEfTsu9WI2X+p1RIUZWq6t4WBQhwwFnQkPuvkZi/c8LPbDbPtXZSwUhKZJqc3tUOvMOGaiJsKMNDZMadHazKTN1rMjcGmkDzvIj0l0T35M4rbP6hIFoAcQiXJ4WoMVZdpaAX7PfpQxetnliJKktSP++z9EX/AHEEnriYdIMGUexrymY1YuMO4nY31uObU6lemLbug6AF2oo+o+eXOG8hL9wz8YUW+htI26eNoBbTnNY2Nta0GNICK+ibxuEbHOws+ueg4gluUg==
X-Forefront-Antispam-Report: CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(36840700001)(46966006)(40470700004)(8676002)(82740400003)(4326008)(36860700001)(47076005)(5660300002)(40480700001)(82960400001)(2616005)(70586007)(356005)(44832011)(8936002)(2906002)(956004)(70206006)(81166007)(1076003)(186003)(316002)(6666004)(41300700001)(86362001)(36756003)(478600001)(110136005)(107886003)(54906003)(26005)(336012)(83380400001)(40460700003)(16526019)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 15:57:03.0353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a985a1-1e1f-41a3-029d-08da70b1d037
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT089.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3686
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So that drivers building on top can find those pins with GPIO_LOOKUP
helpers.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/gpio/gpio-f7188x.c | 138 ++++++++++++++++++-------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
index 431ce2cda1d8..5f2f3c01231d 100644
--- a/drivers/gpio/gpio-f7188x.c
+++ b/drivers/gpio/gpio-f7188x.c
@@ -151,10 +151,10 @@ static void f7188x_gpio_set(struct gpio_chip *chip, unsigned offset, int value);
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
@@ -176,98 +176,98 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 #define gpio_out_mode(base) (base + 3)
 
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

