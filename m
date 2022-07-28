Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AA15843B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbiG1P5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiG1P5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:57:10 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A7E51A29;
        Thu, 28 Jul 2022 08:57:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJUqnVXSi8p6ZQjLo/mFGti5RVDp+4uw6+ja7r87zKyoF0h0A3vydPxggzdJCGtmnCXZx3q0yKmYSzaX/qZx0TRWAO/hTWRkBX+oM/ku7XixPzy2D2WYk/sADZRZskPA8O88b8wC3u/eDaM637FyQCWkGOz2RIUVUEnIrSI/1kCKzIGc3hZqP84cIKlVoLDvq1jqlEAR3oVEwikpf8/DbuRewCv4GZOoSdGGE7CGf8KALYFOouMvR9AyiyjVaEo5Kb1IpFBKrfkAFE8EEScQHo2Sy/U4434uVaNosC8nu3uRDSv0x/6h+OI/ITRPjo94clnUQXUmzsM0dxA4M2Q7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3KwhYGpz1G6k+JfbZKb1Awi3Dwp2h6dvg8YUZb5LkA=;
 b=L0t7dv93tagkw6+csdh98peRB6xCIZf0VeeRAzmhoA1CdcSnqx4CqfirNUOABHK+1BubXRmVdmKonSKqz4QlshGIUdWCLDYb24nGeLZ3X3CM7kJIVSfP+j4LlRPMP4cPgT9sk6CpCb+e9freQN551MkR0O6VNMJIVOZ+ZB8NCb9+7zw9Gw8zlQ+HmqoOo09DqLrSXsYd+Wg7GG3vu49wsse5r2RKr3CRD2WbrNV5ioDZAp2ozf2p3Tz+9a5NXsHKkzxSntkm6Yej26SClyxiqYQ7FrDw6v2VtHU9SEDkJqAO4SeIz9lX2+RBxGC78ACe0uMXMozAtDepUqzWybU49w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3KwhYGpz1G6k+JfbZKb1Awi3Dwp2h6dvg8YUZb5LkA=;
 b=IhrL/3CBX2wMQHs217L5AzAPgE6UryaLvLHQkJqsPH8KD8EBXlqCCEdCZtSQ6q/7E5jz0/iuRk5/p3tz2UZ6u1/Y72R9jVHgssGhr6ekPGRf+9/3CPSa+rMHvyZ7QBtwousgYg9oDJQk0PDwcOBcrIUw9Ml+U1SJVbF5dWvhak7Lm5sOS0+Ju2UoIxk9M5/vJa9phVopvHfUyH1NokZV9Qu2Y5RsZ0/gWHp29c0P6+/VH25EqqxR6AectYVD20iS9C0R17wcCk15zBvA9VW6sy/O6DK6krqpr4Vi+Fknrw3q+IdntUABhYoYwewtY/PjFHrHqMLY7d2mQu2i5SvPIg==
Received: from DU2PR04CA0318.eurprd04.prod.outlook.com (2603:10a6:10:2b5::23)
 by DB9PR10MB4332.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:224::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Thu, 28 Jul
 2022 15:57:02 +0000
Received: from DB5EUR01FT089.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:2b5:cafe::91) by DU2PR04CA0318.outlook.office365.com
 (2603:10a6:10:2b5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Thu, 28 Jul 2022 15:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT089.mail.protection.outlook.com (10.152.5.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.10 via Frontend Transport; Thu, 28 Jul 2022 15:57:02 +0000
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
Subject: [PATCH 1/4] gpio-f7188x: Add GPIO support for Nuvoton NCT6116
Date:   Thu, 28 Jul 2022 17:56:49 +0200
Message-ID: <20220728155652.29516-2-henning.schild@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: e13c98be-eda3-4e0c-7b3f-08da70b1d00e
X-MS-TrafficTypeDiagnostic: DB9PR10MB4332:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1/001oTtonm4YKqrV75CisapgrUGC923yTtcKO46l5dog4SAa7YjpIoZf31Bvnbum3HBRCN+5f7ITwVY4yrH1VPFpGtHeFnkFUshsQZek72gjBCzNGFjE7EeWijLMd5SkxDnCyUcmsg3K4zGaIjEu+TFJHzd0tVUUDCvEkJm0iB9I6EdtIHUnDLu/oQA5u+r/LOpy3jsuwIHDtUAR/YGr1h9QTN/HYclHf+nc+GZZ6j0+eMjuuCl9lE9X+9RkjOCOvMGzNxhiTLezIzZEGlJ9fR1N+iXCknPsqTV++sAoHtTYRzKr++dothyI7WUF9aWPKMM4xma61yy714NSu1gAv4afXkXh7vOqmIAB4siE86eqnYbaHRiVI8RLGoolnCUZeDwhHoZDqscYJqDYUhQGqoBvbB9Y95y51ZxybAsRxFnz/hVqjNQy3Y61Em37rW+dmJ2XODpcJk9anx5F7iDVscbqmkQSNfIeaCT1lJ4vh6ISNcfww8KS8WZm6Q2WQwtLZcVit8cVQSzwXwOR6n+DipO9MHuoPXW42pkoccbavgQiCcYXqiLwSEeaRZqpdsxAicYpz18OECCiH9qA9s7VctdGC8hZsSoCA4i2dX6iRnQG1n5r4+kxKOUnoRY3CGOp/QG7oiBVUPW6L8iXAT4IxdWgYMXycV708sdCuBkZ1XSCcuC0omjETyxfBA+LHNXYooG0xRWcbeyBAyXrG92kD/eoXfkl/llWVUDhQ9oQIqY5mzYrk01j4MlqQWpHjacLx1x7YwmwxY8a9BLBbCug2rgU2bnJ3YaPxvOtHLuhl3KjVqJ8ECwPSkAEVUJR2ZoREeSftFMuO/SApB77+rpHw==
X-Forefront-Antispam-Report: CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(136003)(346002)(40470700004)(36840700001)(46966006)(110136005)(86362001)(478600001)(41300700001)(6666004)(356005)(26005)(36860700001)(82960400001)(83380400001)(336012)(47076005)(956004)(2616005)(16526019)(81166007)(107886003)(1076003)(186003)(316002)(8936002)(44832011)(5660300002)(36756003)(4326008)(40460700003)(82310400005)(2906002)(54906003)(70206006)(82740400003)(70586007)(8676002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 15:57:02.7853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e13c98be-eda3-4e0c-7b3f-08da70b1d00e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT089.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4332
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/gpio/gpio-f7188x.c | 70 ++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
index 18a3147f5a42..431ce2cda1d8 100644
--- a/drivers/gpio/gpio-f7188x.c
+++ b/drivers/gpio/gpio-f7188x.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * GPIO driver for Fintek Super-I/O F71869, F71869A, F71882, F71889 and F81866
+ * and Nuvoton Super-I/O NCT6116D
  *
  * Copyright (C) 2010-2013 LaCie
  *
@@ -22,13 +23,11 @@
 #define SIO_LDSEL		0x07	/* Logical device select */
 #define SIO_DEVID		0x20	/* Device ID (2 bytes) */
 #define SIO_DEVREV		0x22	/* Device revision */
-#define SIO_MANID		0x23	/* Fintek ID (2 bytes) */
 
-#define SIO_LD_GPIO		0x06	/* GPIO logical device */
 #define SIO_UNLOCK_KEY		0x87	/* Key to enable Super-I/O */
 #define SIO_LOCK_KEY		0xAA	/* Key to disable Super-I/O */
 
-#define SIO_FINTEK_ID		0x1934	/* Manufacturer ID */
+#define SIO_LD_GPIO_FINTEK	0x06	/* GPIO logical device */
 #define SIO_F71869_ID		0x0814	/* F71869 chipset ID */
 #define SIO_F71869A_ID		0x1007	/* F71869A chipset ID */
 #define SIO_F71882_ID		0x0541	/* F71882 chipset ID */
@@ -38,6 +37,9 @@
 #define SIO_F81804_ID		0x1502  /* F81804 chipset ID, same for f81966 */
 #define SIO_F81865_ID		0x0704	/* F81865 chipset ID */
 
+#define SIO_LD_GPIO_NUVOTON	0x07	/* GPIO logical device */
+#define SIO_NCT6116D_ID		0xD283  /* NCT6116D chipset ID */
+#define SIO_GPIO_ENABLE		0x30	/* GPIO enable */
 
 enum chips {
 	f71869,
@@ -48,6 +50,7 @@ enum chips {
 	f81866,
 	f81804,
 	f81865,
+	nct6116d,
 };
 
 static const char * const f7188x_names[] = {
@@ -59,10 +62,12 @@ static const char * const f7188x_names[] = {
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
 
@@ -254,6 +259,17 @@ static struct f7188x_gpio_bank f81865_gpio_bank[] = {
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
@@ -264,13 +280,20 @@ static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
 
 	superio_exit(sio->addr);
 
-	if (dir & 1 << offset)
+	if (sio->device == SIO_LD_GPIO_NUVOTON) {
+		if (dir & BIT(offset))
+			return GPIO_LINE_DIRECTION_IN;
+
+		return GPIO_LINE_DIRECTION_OUT;
+	}
+
+	if (dir & BIT(offset))
 		return GPIO_LINE_DIRECTION_OUT;
 
 	return GPIO_LINE_DIRECTION_IN;
@@ -286,10 +309,14 @@ static int f7188x_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
-	dir &= ~BIT(offset);
+
+	if (sio->device == SIO_LD_GPIO_FINTEK)
+		dir &= ~BIT(offset);
+	else
+		dir |= BIT(offset);
 	superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
 
 	superio_exit(sio->addr);
@@ -307,7 +334,7 @@ static int f7188x_gpio_get(struct gpio_chip *chip, unsigned offset)
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
 	dir = !!(dir & BIT(offset));
@@ -332,7 +359,7 @@ static int f7188x_gpio_direction_out(struct gpio_chip *chip,
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	data_out = superio_inb(sio->addr, gpio_data_out(bank->regbase));
 	if (value)
@@ -342,7 +369,10 @@ static int f7188x_gpio_direction_out(struct gpio_chip *chip,
 	superio_outb(sio->addr, gpio_data_out(bank->regbase), data_out);
 
 	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
-	dir |= BIT(offset);
+	if (sio->device == SIO_LD_GPIO_FINTEK)
+		dir |= BIT(offset);
+	else
+		dir &= ~BIT(offset);
 	superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
 
 	superio_exit(sio->addr);
@@ -360,7 +390,7 @@ static void f7188x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	err = superio_enter(sio->addr);
 	if (err)
 		return;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	data_out = superio_inb(sio->addr, gpio_data_out(bank->regbase));
 	if (value)
@@ -388,7 +418,7 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	data = superio_inb(sio->addr, gpio_out_mode(bank->regbase));
 	if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN)
@@ -449,6 +479,10 @@ static int f7188x_gpio_probe(struct platform_device *pdev)
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
@@ -485,12 +519,8 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
 		return err;
 
 	err = -ENODEV;
-	devid = superio_inw(addr, SIO_MANID);
-	if (devid != SIO_FINTEK_ID) {
-		pr_debug(DRVNAME ": Not a Fintek device at 0x%08x\n", addr);
-		goto err;
-	}
 
+	sio->device = SIO_LD_GPIO_FINTEK;
 	devid = superio_inw(addr, SIO_DEVID);
 	switch (devid) {
 	case SIO_F71869_ID:
@@ -517,8 +547,12 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
 	case SIO_F81865_ID:
 		sio->type = f81865;
 		break;
+	case SIO_NCT6116D_ID:
+		sio->device = SIO_LD_GPIO_NUVOTON;
+		sio->type = nct6116d;
+		break;
 	default:
-		pr_info(DRVNAME ": Unsupported Fintek device 0x%04x\n", devid);
+		pr_info(DRVNAME ": Unsupported device 0x%04x\n", devid);
 		goto err;
 	}
 	sio->addr = addr;
-- 
2.35.1

