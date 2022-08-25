Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFFC5A0E32
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241201AbiHYKpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbiHYKoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:44:55 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80082.outbound.protection.outlook.com [40.107.8.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023604BD3B;
        Thu, 25 Aug 2022 03:44:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzH68/f76Ip+tvjZS+NaAZ73C9RouR2kGIopm+RcO04xSkz6ux82ArDFVXQIgu/Z2wR7z5HTMbnPoih7Q0rkvlhcbKO5ARxEm+OWRW6XXNTABex5zQ9wX/JJ1Fwo+SbPqWzIZ3xmeF8pnbqX/MSqoUCEJrhk3Oi45Q8NlVD84B1KZJ7fKXWRD3O6cvD1fv9xakkeS2SFUXhXsjbVtD1+oCx8uD0oOMb+HM/35rv0RXLhDXt8uhRNr1Plww05atc5Jbgqj4f0BlEq2AoqGOPOFDrUre7i7jISz00hOJ+qIX/mzHKrJH5xc6CG0ZKCFx3r3uo5mnvSOwc63TTfoqaFFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXqcOZ2eEscInWqK2z7PIYAdQfxfLBfslrQ3D5wrsr4=;
 b=EKLlpoazRGZYh4u5ZEY1Nd6FYofe7uZtyqZt7swtl/Aj8CMFc7qj++uNEmSakFjcDb17A1ch4M9KcymtFu7QH7IWGYbGQZ6bDKg9gIARpG8zknmfVKa84bXJXXIyCnQb8g8e165uYl15Sq9J1DB1PiggXhA59rh7qPvXZOMisrU0NpOvEHvus2XbKFiqI1D5DQ6Xn7AxHUYD2DSYp9dQIQtcS4rDinlnYCShj2kQMRX8UiSiaZsychZR65z+mb/mcxFmw78D1oj0cwBDUZXlGS2qLU3hFnHn+1cVFI3D7zvKTD9FwSimmv8w8h96WXUVxNq33rgigTZrOnYHqeWJvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.74) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXqcOZ2eEscInWqK2z7PIYAdQfxfLBfslrQ3D5wrsr4=;
 b=CDqt+OF1jRMFVPVsLTU+rSBDEJpx6xj9h5DrcWiKh6DxjhlH9yQp1lgNo7hh583NPJcL5oB1W3k1eVzW2X7m+LUEl5WJrPtpUAmWpbE4rMNjzkOdjTJ8jlUzE5vcbM4BV/GMY3bUrCII3U+j/8JYx0anfcX/uay+qNkD/7x/8RMeZ2mRuB3NkPLlMVSkOZsnZp+lq/Ivzp1qvfVO+4TFrV5yERpzxkE6WDg5IkX3kBrubTXUnPiJZJSXuBq/XtkMfI706r1kEks2gIsWZ8Laceiz3dSoONT0m1tp3a9gx69B4PztSVNkps1mKLLA4Px59CQeYCYUxE2FvOF4lVMSig==
Received: from DB6PR0601CA0048.eurprd06.prod.outlook.com (2603:10a6:4:17::34)
 by AM9PR10MB4248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Thu, 25 Aug
 2022 10:44:48 +0000
Received: from DB5EUR01FT055.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:17:cafe::cd) by DB6PR0601CA0048.outlook.office365.com
 (2603:10a6:4:17::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 25 Aug 2022 10:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT055.mail.protection.outlook.com (10.152.5.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 10:44:48 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
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
Subject: [PATCH v6 3/7] gpio-f7188x: Add GPIO support for Nuvoton NCT6116
Date:   Thu, 25 Aug 2022 12:44:18 +0200
Message-ID: <20220825104422.14156-4-henning.schild@siemens.com>
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
X-TM-AS-Result: No-10--9.929100-8.000000
X-TMASE-MatchedRID: xpRMqq2LnxwnajXSbZssErN5pka0DGqI47cLULZlxOVkGI+vgRTxME+c
        rEA4+nhZEmx/CUhRV0GhAqHLqD5GgW7iQTMjrcXyIyjGuFgTWAqmWOD8X0TFhCfphWrcxCwjaeM
        aKzvXUpljjMm9SMavFWO27X3o/SbCfGzuoVn0Vs6PQi9XuOWoOA2qw+l5gxNFXQ3GOUdI0+7lm5
        R3Gqr5Dr59Yrw3aQCHGdJD2ytTIBErtzhh+D9NIseenRSRvoM4Mzwe5s18okNzEyQF4j0rdxA5w
        xKjT3bqx6C6dcifNxiLVFtk3Um5KCqcD2KTceXurQB5G2coNlKCnzYdtGmczFPCjtWo3QQ8hVDn
        kfzD7uY8guXXRtiXIJhRBYxZ+VWn3nZy7lirOs91hJ+eDAEvqGoR/pevuvZYKrDHzH6zmUXAmOf
        zKotToreWSoRRutYI4G+HMbHU4xDi8zVgXoAltsIJ+4gwXrEtIAcCikR3vq94SPnU7aqreg9bxS
        b2aZXkGW+/zwSXigzF16Q1sV9deXkQgFDHvKre
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.929100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 9B10E295BA4954010F80E7662EDF7C9967301A7E88B7F15FB3021A92D1F07D1B2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7111230-f8e0-4aee-1a3e-08da8686d4f0
X-MS-TrafficTypeDiagnostic: AM9PR10MB4248:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FrXbCluS0b+JO4Wd0OulVizi8aTAYs1RJnUUxXH5P4RtDMjBacAnOyoxpoKzP+DNIsCjPxGMLq614R6V1MK5nSy2ix/uqjINagcTkit03IRtw6EaCUYrAghAQc/0b9cFFdmtaZiIkoTF3DMtzhl/KLX2tqxrUoNOxp7qGWdwyF1hlXB12NIHbnXROl7abOlLt+WQd40XlrCdfxtiodm6IcvXqYXmy49nyylHZBel4XPjf8k6xf+SDKSYIKA+alc+T6IT/TucIdW4dpEEOUcgBfvV39afCyTZigXjcbUl8GwGOPdSQHz2fiZDr6cYbNWjri+1y6LHLEb+/tqqsRnVlWJEj7+DPENskjT+ehcBPFBwcML3HQmEj5Cd5SD4SWHoxpgBxTRHfMO4jCxcvyA59KXaEQkZTu1+hdF+KgsWfZzJ3UXZMDOnO3Joib9k79BXQg8t4YAd55a7Rwnac5WKOZE+wY9VvcPXhsTh03vufk86lFmyqD0+Zoj0n5rK1Mwk25pPSkpHVzVysaJjxcBx8k0H3qCG1FuDWckEjMN0l7nB+7RH1i2l6ZrdO8B4QthKMj/ZUPSKX7U9+gS+AXqH2oUWJVM7f1gAKJxUkzr3+glJdpFQHy/O2qNwwWhTqL6/IqJd9h4xOGA1uykmgzLSXqe9riX3pntqQgROJjNXhe/Sz8uNJAw9Yd46E7NKhhGmAcEkL9JJSkP+uLA/uaRnA6ToeqeswZyKKQFR+9XzOsJ8yH1DKpOuRNnBNWeOIk13sufcfPnwsGKoGcSr2jU/Ss4s9NUaV2Qls55zbPA2Y6m5K79isl5t11+BtEtAGyTcwW6CNrZ2ARDwrzgRpcTcYg==
X-Forefront-Antispam-Report: CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(40470700004)(46966006)(36840700001)(5660300002)(7416002)(41300700001)(36860700001)(110136005)(54906003)(186003)(1076003)(40460700003)(8936002)(16526019)(336012)(86362001)(316002)(2616005)(956004)(47076005)(921005)(82960400001)(356005)(7596003)(7636003)(82310400005)(82740400003)(70586007)(70206006)(8676002)(4326008)(83380400001)(40480700001)(478600001)(6666004)(36756003)(2906002)(26005)(107886003)(44832011)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 10:44:48.1810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7111230-f8e0-4aee-1a3e-08da8686d4f0
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT055.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4248
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

Add GPIO support for Nuvoton NCT6116 chip. Nuvoton SuperIO chips are
very similar to the ones from Fintek. In other subsystems they also
share drivers and are called a family of drivers.

For the GPIO subsystem the only difference is that the direction bit is
reversed and that there is only one data bit per pin. On the SuperIO
level the logical device is another one.

On a chip level we do not have a manufacturer ID to check and also no
revision.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Simon Guinot <simon.guinot@sequanux.org>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/gpio/Kconfig       |   3 +-
 drivers/gpio/gpio-f7188x.c | 104 ++++++++++++++++++++++++++++---------
 2 files changed, 81 insertions(+), 26 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 0642f579196f..3f64345fe40b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -874,10 +874,11 @@ config GPIO_104_IDI_48
 	  module parameter.
 
 config GPIO_F7188X
-	tristate "F71869, F71869A, F71882FG, F71889F and F81866 GPIO support"
+	tristate "Fintek and Nuvoton Super-I/O GPIO support"
 	help
 	  This option enables support for GPIOs found on Fintek Super-I/O
 	  chips F71869, F71869A, F71882FG, F71889F and F81866.
+	  As well as Nuvoton Super-I/O chip NCT6116D.
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called f7188x-gpio.
diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
index 878458249833..29c73ea96466 100644
--- a/drivers/gpio/gpio-f7188x.c
+++ b/drivers/gpio/gpio-f7188x.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * GPIO driver for Fintek Super-I/O F71869, F71869A, F71882, F71889 and F81866
+ * GPIO driver for Fintek and Nuvoton Super-I/O chips
  *
  * Copyright (C) 2010-2013 LaCie
  *
@@ -22,23 +22,36 @@
  */
 #define SIO_LDSEL		0x07	/* Logical device select */
 #define SIO_DEVID		0x20	/* Device ID (2 bytes) */
-#define SIO_DEVREV		0x22	/* Device revision */
-#define SIO_MANID		0x23	/* Fintek ID (2 bytes) */
 
-#define SIO_LD_GPIO		0x06	/* GPIO logical device */
 #define SIO_UNLOCK_KEY		0x87	/* Key to enable Super-I/O */
 #define SIO_LOCK_KEY		0xAA	/* Key to disable Super-I/O */
 
-#define SIO_FINTEK_ID		0x1934	/* Manufacturer ID */
+/*
+ * Fintek devices.
+ */
+#define SIO_FINTEK_DEVREV	0x22	/* Fintek Device revision */
+#define SIO_FINTEK_MANID	0x23    /* Fintek ID (2 bytes) */
+
+#define SIO_FINTEK_ID		0x1934  /* Manufacturer ID */
+
 #define SIO_F71869_ID		0x0814	/* F71869 chipset ID */
 #define SIO_F71869A_ID		0x1007	/* F71869A chipset ID */
 #define SIO_F71882_ID		0x0541	/* F71882 chipset ID */
 #define SIO_F71889_ID		0x0909	/* F71889 chipset ID */
 #define SIO_F71889A_ID		0x1005	/* F71889A chipset ID */
 #define SIO_F81866_ID		0x1010	/* F81866 chipset ID */
-#define SIO_F81804_ID		0x1502  /* F81804 chipset ID, same for f81966 */
+#define SIO_F81804_ID		0x1502  /* F81804 chipset ID, same for F81966 */
 #define SIO_F81865_ID		0x0704	/* F81865 chipset ID */
 
+#define SIO_LD_GPIO_FINTEK	0x06	/* GPIO logical device */
+
+/*
+ * Nuvoton devices.
+ */
+#define SIO_NCT6116D_ID		0xD283  /* NCT6116D chipset ID */
+
+#define SIO_LD_GPIO_NUVOTON	0x07	/* GPIO logical device */
+
 
 enum chips {
 	f71869,
@@ -49,6 +62,7 @@ enum chips {
 	f81866,
 	f81804,
 	f81865,
+	nct6116d,
 };
 
 static const char * const f7188x_names[] = {
@@ -60,10 +74,12 @@ static const char * const f7188x_names[] = {
 	"f81866",
 	"f81804",
 	"f81865",
+	"nct6116d",
 };
 
 struct f7188x_sio {
 	int addr;
+	int device;
 	enum chips type;
 };
 
@@ -171,6 +187,9 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 /* Output mode register (0:open drain 1:push-pull). */
 #define f7188x_gpio_out_mode(base) ((base) + 3)
 
+#define f7188x_gpio_dir_invert(type)	((type) == nct6116d)
+#define f7188x_gpio_data_single(type)	((type) == nct6116d)
+
 static struct f7188x_gpio_bank f71869_gpio_bank[] = {
 	F7188X_GPIO_BANK(0, 6, 0xF0),
 	F7188X_GPIO_BANK(10, 8, 0xE0),
@@ -255,6 +274,17 @@ static struct f7188x_gpio_bank f81865_gpio_bank[] = {
 	F7188X_GPIO_BANK(60, 5, 0x90),
 };
 
+static struct f7188x_gpio_bank nct6116d_gpio_bank[] = {
+	F7188X_GPIO_BANK(0, 8, 0xE0),
+	F7188X_GPIO_BANK(10, 8, 0xE4),
+	F7188X_GPIO_BANK(20, 8, 0xE8),
+	F7188X_GPIO_BANK(30, 8, 0xEC),
+	F7188X_GPIO_BANK(40, 8, 0xF0),
+	F7188X_GPIO_BANK(50, 8, 0xF4),
+	F7188X_GPIO_BANK(60, 8, 0xF8),
+	F7188X_GPIO_BANK(70, 1, 0xFC),
+};
+
 static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 {
 	int err;
@@ -265,13 +295,16 @@ static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	dir = superio_inb(sio->addr, f7188x_gpio_dir(bank->regbase));
 
 	superio_exit(sio->addr);
 
-	if (dir & 1 << offset)
+	if (f7188x_gpio_dir_invert(sio->type))
+		dir = ~dir;
+
+	if (dir & BIT(offset))
 		return GPIO_LINE_DIRECTION_OUT;
 
 	return GPIO_LINE_DIRECTION_IN;
@@ -287,10 +320,14 @@ static int f7188x_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	dir = superio_inb(sio->addr, f7188x_gpio_dir(bank->regbase));
-	dir &= ~BIT(offset);
+
+	if (f7188x_gpio_dir_invert(sio->type))
+		dir |= BIT(offset);
+	else
+		dir &= ~BIT(offset);
 	superio_outb(sio->addr, f7188x_gpio_dir(bank->regbase), dir);
 
 	superio_exit(sio->addr);
@@ -308,11 +345,11 @@ static int f7188x_gpio_get(struct gpio_chip *chip, unsigned offset)
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	dir = superio_inb(sio->addr, f7188x_gpio_dir(bank->regbase));
 	dir = !!(dir & BIT(offset));
-	if (dir)
+	if (f7188x_gpio_data_single(sio->type) || dir)
 		data = superio_inb(sio->addr, f7188x_gpio_data_out(bank->regbase));
 	else
 		data = superio_inb(sio->addr, f7188x_gpio_data_in(bank->regbase));
@@ -333,7 +370,7 @@ static int f7188x_gpio_direction_out(struct gpio_chip *chip,
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	data_out = superio_inb(sio->addr, f7188x_gpio_data_out(bank->regbase));
 	if (value)
@@ -343,7 +380,10 @@ static int f7188x_gpio_direction_out(struct gpio_chip *chip,
 	superio_outb(sio->addr, f7188x_gpio_data_out(bank->regbase), data_out);
 
 	dir = superio_inb(sio->addr, f7188x_gpio_dir(bank->regbase));
-	dir |= BIT(offset);
+	if (f7188x_gpio_dir_invert(sio->type))
+		dir &= ~BIT(offset);
+	else
+		dir |= BIT(offset);
 	superio_outb(sio->addr, f7188x_gpio_dir(bank->regbase), dir);
 
 	superio_exit(sio->addr);
@@ -361,7 +401,7 @@ static void f7188x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	err = superio_enter(sio->addr);
 	if (err)
 		return;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	data_out = superio_inb(sio->addr, f7188x_gpio_data_out(bank->regbase));
 	if (value)
@@ -389,7 +429,7 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	data = superio_inb(sio->addr, f7188x_gpio_out_mode(bank->regbase));
 	if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN)
@@ -450,6 +490,10 @@ static int f7188x_gpio_probe(struct platform_device *pdev)
 		data->nr_bank = ARRAY_SIZE(f81865_gpio_bank);
 		data->bank = f81865_gpio_bank;
 		break;
+	case nct6116d:
+		data->nr_bank = ARRAY_SIZE(nct6116d_gpio_bank);
+		data->bank = nct6116d_gpio_bank;
+		break;
 	default:
 		return -ENODEV;
 	}
@@ -480,18 +524,15 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
 {
 	int err;
 	u16 devid;
+	u16 manid;
 
 	err = superio_enter(addr);
 	if (err)
 		return err;
 
 	err = -ENODEV;
-	devid = superio_inw(addr, SIO_MANID);
-	if (devid != SIO_FINTEK_ID) {
-		pr_debug("Not a Fintek device at 0x%08x\n", addr);
-		goto err;
-	}
 
+	sio->device = SIO_LD_GPIO_FINTEK;
 	devid = superio_inw(addr, SIO_DEVID);
 	switch (devid) {
 	case SIO_F71869_ID:
@@ -518,17 +559,30 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
 	case SIO_F81865_ID:
 		sio->type = f81865;
 		break;
+	case SIO_NCT6116D_ID:
+		sio->device = SIO_LD_GPIO_NUVOTON;
+		sio->type = nct6116d;
+		break;
 	default:
 		pr_info("Unsupported Fintek device 0x%04x\n", devid);
 		goto err;
 	}
+
+	/* double check manufacturer where possible */
+	if (sio->type != nct6116d) {
+		manid = superio_inw(addr, SIO_FINTEK_MANID);
+		if (manid != SIO_FINTEK_ID) {
+			pr_debug("Not a Fintek device at 0x%08x\n", addr);
+			goto err;
+		}
+	}
+
 	sio->addr = addr;
 	err = 0;
 
-	pr_info("Found %s at %#x, revision %d\n",
-		f7188x_names[sio->type],
-		(unsigned int) addr,
-		(int) superio_inb(addr, SIO_DEVREV));
+	pr_info("Found %s at %#x\n", f7188x_names[sio->type], (unsigned int)addr);
+	if (sio->type != nct6116d)
+		pr_info("   revision %d\n", superio_inb(addr, SIO_FINTEK_DEVREV));
 
 err:
 	superio_exit(addr);
-- 
2.35.1

