Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4989C5900B2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbiHKPpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbiHKPpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:45:09 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10075.outbound.protection.outlook.com [40.107.1.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA3DA832A;
        Thu, 11 Aug 2022 08:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIjZSylXeMiIF6k8oRuTKvY6nlSse2JHiptJCPdkTuFRz7cGjH1w0q5yjjTzVZaIJB+emI9ov3e8/WdY/hsol4XudLmY02OWngU3jGNxjzTKMZuNCsZ1V9S2eeWf4MEBmiURnCHSwM21LTE91hEWouC+DInesTLP1Uh1DlZq4dGxPoGuhAPRkFvXqWg6Fak4nhCrD7C0eYeZ6m0C1nWhG49xjLf/AfZYXokWZTEPnqetmmOdGD49Zx+JoP+ZKtUUA4a5JeAOkmAVfViOqLmS4Iq6XUJOZZ3aDvmNxBrcIS3t7lIAGTTcgo3ZFcdacHxSdVmWX6R8PTGv22jSGQ+13g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCVVMF3Qr16rrNNhAS4v/jeP83ETEWSAEbdHcsxo2c0=;
 b=bzICxF7VJ57Y1iDJq71FRzw7ASA4oOlKPWQbIucpQj7oR1C3H30QGEoC97kMAZNhILOsEdJ9CihaI3CCIrf7bxFTkSfY7rZzz80S9SX0VJ74yeV0QiokcGehlAYbVSwA07mQqa9gQGdmto0JWcJl7Ru/T22VXv6bJ8v08qDOq4qUBYzShWgW432POF/kSbVgC8c9IS/5sAEfPTqxEht23xOIoR5CzTtSzclZVGiYwfiSoe05gHhLpuh0BplxiOrDt1cc60A3oJmkNfXKaozSeynU/gq59y4W0qZyL+X2WERfakabYBwPhwtUnUNnSDCfgEoRNuA99Gu/u+qTD12Eiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCVVMF3Qr16rrNNhAS4v/jeP83ETEWSAEbdHcsxo2c0=;
 b=hixRwVWvqW7qAAeAeinTS0ZtYjdE9LYN/R+9b0SpXG9GywX+flVhGllG6jkoq1axC732P2Q68Mcf0O4/mdIPTgo6ofRiBefc6UUTm16YrFlFBKAKchojOMRU5gBYMY2IMtoxKQ4H1adC6NS/i7+DX68zfV1IlewTdRE0iqQ5hv5rz3bGSDKVrRZ08UEPtdmnkZpoN6gLDkoKxqY8gq+U39sTvgXlgmfgLFK6rxTuPDPvdcGTAWVSMkw4J91hE8e4dX4lQH93EXaTgkbWHkhLcs2T2Iq/fdPp5eAK+lcWlTAEAQDzqy4Tw3z+JAT76vtrF4VYe63lHqP5pN0JGgjj8Q==
Received: from DB6PR0202CA0018.eurprd02.prod.outlook.com (2603:10a6:4:29::28)
 by AM0PR10MB3410.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:156::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Thu, 11 Aug
 2022 15:39:20 +0000
Received: from DB5EUR01FT055.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:29:cafe::91) by DB6PR0202CA0018.outlook.office365.com
 (2603:10a6:4:29::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.12 via Frontend
 Transport; Thu, 11 Aug 2022 15:39:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT055.mail.protection.outlook.com (10.152.5.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Thu, 11 Aug 2022 15:39:19 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 11 Aug 2022 17:39:19 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 11 Aug 2022 17:39:18 +0200
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
Subject: [PATCH v3 2/4] gpio-f7188x: use unique labels for banks/chips
Date:   Thu, 11 Aug 2022 17:39:06 +0200
Message-ID: <20220811153908.31283-3-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811153908.31283-1-henning.schild@siemens.com>
References: <20220811153908.31283-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 456cc5dd-7803-4479-a197-08da7bafa85d
X-MS-TrafficTypeDiagnostic: AM0PR10MB3410:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8oHkvMDBKNdy4AHACrbHuS5cwRbkaCvbvWh+VrAt3upMGqW7CchLZKprynT+U1+tfoPjFfmwZAP5qocJTm0U7DjN/VMTpIDuN9sD9GUXSZll3uDZBwHED81Ufa0S/PPbH4UGFhytEmmnyWkeuE6vyJq4zDb6/jzZB60FFAp1gB4Usd/Swzs+R/+wlXWL/CanUTEoDiuZWCS24/Y5uzVKjsab2Ai0rl+Ba4ZAfPXkCKz+dmqsr+htQZV+dc8em+ooyy6ivLBpRhnkqLNRgeyPOIUfl0sr1LqXtnd1VdGzdj1zzskKXEvV5O8GcbXVl2IBJQcDIJVMhO+M+MC+T/znGRBY7P8R6U0gbJvRF5TnqtKjtwCPVQsRU7ZUx5yBd8FcJJdjyTvzRfpdqOHIlFC0rj3V7UtJrogLQ4HZ93ov+eQx3MjRTxqL/q5pTXii+HeLc6CmiBLpLHTqohcjWrlm1rG52UCu5tLd2jr6s7CoK0D8o/atr8eLc0yM6clbFoP9/Ep84VAtOnQUC+GUtKvrf/e3dFoNFMFhY0H40Fxac5opIaSSzVUGTWHR3511m5QyeLp33mLZWkLDE5Zzsygaw82jyoUW4wITiU7Zv+IEJp+KRtI5qNhnoxk/PjkjwjRAXIpKrVhLPaTENpLS4PYokHlWdQ0XC04AWzSpdkc/Y2hgyDLc/tJGEJdI5OCgMxFOQOPd2uEBVxI5RxqSAdqwi7viYl8yeP64bq6gzoaopIqsFDlyIjmtwMF/U9DuITlQnStyrtjS1rtyBzrmIZNPyXNCnIZkmP0mWxwqB5yGvG8qyuhKQ25CKD2RN+gU7I3jHXlcM71Jda66wuYWkHEhNUaRneyxws4+hmRrWmIQU2kJrSmpMxA2IkZtthuiLgp5tFgg/Lz/zCEBJl8QRPd3xA==
X-Forefront-Antispam-Report: CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(40470700004)(36840700001)(4326008)(8676002)(70206006)(5660300002)(70586007)(316002)(54906003)(40480700001)(110136005)(82310400005)(40460700003)(44832011)(8936002)(7416002)(2906002)(82740400003)(36860700001)(86362001)(81166007)(921005)(36756003)(82960400001)(6666004)(41300700001)(356005)(478600001)(26005)(83380400001)(336012)(2616005)(186003)(107886003)(16526019)(47076005)(1076003)(956004)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 15:39:19.9767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 456cc5dd-7803-4479-a197-08da7bafa85d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT055.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3410
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
index 7b05ecc611e9..45b466b04070 100644
--- a/drivers/gpio/gpio-f7188x.c
+++ b/drivers/gpio/gpio-f7188x.c
@@ -149,10 +149,10 @@ static void f7188x_gpio_set(struct gpio_chip *chip, unsigned offset, int value);
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
@@ -177,98 +177,98 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 #define gpio_data_single(type)	((type) == nct6116d)
 
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

