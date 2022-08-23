Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1CA59E427
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 15:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241878AbiHWNYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 09:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239409AbiHWNYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 09:24:22 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140075.outbound.protection.outlook.com [40.107.14.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA340832FD;
        Tue, 23 Aug 2022 03:24:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNI4+Q/GuJfCPUUCN5Yp5SMGl7+++9eRPMopEzRHqGtnFToKiAbb0nXhb5imUCWidv6ZDDA5MpLYxgMBxOYOPirO00AF3pi/HxiigTZs1lGVUIXD4U4FJINtc1fh02ndDetVWWQDbYQHEY17ws7ReFQKRxfXHUuaOCGX/oyv80Q4kf4NGP0Bpd1OAHJ6j4hCOhgrei1GdZWa9zef6KnX115vXv2T6Itx22LpJ/aLu+YZmpnYVrlg+Ux4AvkGD7Mf6GiBF/TeAYNoxAV+zWyh6owDwMQ64C8ysaVXQ9ksnPHvvpPt+mA6BLPiQCwLcwA7cGxzjVUXUZuiKL4Ss3wldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJfNBa3jZQbus0nWJrpVwxiGnHo3hPjPmJQrfrkFI1E=;
 b=hrtntfP66XFKnvLvUZRn4dQizAb0da0y6SpVS6D90BINdcyrrldYc+dIi6AuoS2d5aEg+loO7wINnIf3UU1oP+4LvwjLIxNuFf4dbj1PVL2QvEKLCLgJNU8nyE3COr0zt8JbkKiS7Myiju9qYoerUcSBUsdeK8AoZkZo7vwWJacjDAFZhZvCNDtJTJ8aC2bl+i4Jqx19Ot/rLI19Ahd2/VuCULIeVjVr3CDYTUNdZJnTb5Y1W1DzKwPhu2Hp7AHEU1UBXmSjoo5dbGjZObDjr9oQ81FCG17hIMLqloi7Vj+Br/3g8mx//jPBldCCPP4idPK+eetX2TMNLsV6516w5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.75) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJfNBa3jZQbus0nWJrpVwxiGnHo3hPjPmJQrfrkFI1E=;
 b=pu4baKXDYPBVMZzGLHJa0J76I/464qU003m/ZOEKA1Jljb5aYR48Iq3uVcMIrBzNbw3FV5Ils8UeQnud+WZg7Uwy8W0Rzxnqc8EUERrkU2F1xrX60vC+03+2pbWmuS9pJrpxvhlW032F6uomlppjAnjA2psIAqodDT7Jvwx+7X2Y734akC91fQ6r6S0nMf5AyQF6AnlzAgloleiuapEgocsUbSDF1dHFeybw6U3xIQDsM1R7j4Za7F5Yd3CLLWpbQX1pDYABJwDygLxq0eLXOjUsxvwFBOaSKKyGxBIv+z2cGaYjlANmovr55RDE42NRCWE14iFeJaLl865YpgCZxA==
Received: from GV3P280CA0094.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::7) by
 AM9PR10MB4021.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.17; Tue, 23 Aug
 2022 10:23:55 +0000
Received: from HE1EUR01FT069.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:8:cafe::78) by GV3P280CA0094.outlook.office365.com
 (2603:10a6:150:8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19 via Frontend
 Transport; Tue, 23 Aug 2022 10:23:54 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT069.mail.protection.outlook.com (10.152.1.52) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Tue, 23 Aug 2022 10:23:54 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Tue, 23 Aug 2022 12:23:54 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 23 Aug 2022 12:23:53 +0200
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
Subject: [PATCH v4 1/5] gpio-f7188x: Add GPIO support for Nuvoton NCT6116
Date:   Tue, 23 Aug 2022 12:23:40 +0200
Message-ID: <20220823102344.17624-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220823102344.17624-1-henning.schild@siemens.com>
References: <20220823102344.17624-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1d37000-f2c5-4c9b-1f63-08da84f19504
X-MS-TrafficTypeDiagnostic: AM9PR10MB4021:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ZJeiWdjlwhms0CCgrG/hu6pgl7XwTWcDtjFUaEY3bP7hKjBd9ehSPacyr03TbLY9eNnJSX5wQ6slpn9v093vnH31gzTEjL+yMPxUliofFGhXJ74ttXagsjFV79WI81suhqGD+lmKGQ8F7QZdr9QKvgGfHUFeEksu9GziUaPjH6gIscWSE2px23UyLDJ7C84vdleYkwCosJGOkddSD95qRlbeX3Iiyb5pLCJiNLc7KdV6emeNgyY38vywk/hgdSxtXeFr08tAFrFgWPIYnR3CNgE1Rks6farbk29OoaFWZDIVTXXLuv7RgcT8hAhoUtAecsBThp5U/O9kGEBK973deCz1WOcPAQbuJt780cHwniiLXHLRIAHlgdsggzIukADanRarYxkZDzecwLGkbVXsuAvzcidkvWeGVQtO3FZaHWoU6atwXlpk6F864+g3E9EbnLbQKFxgsvd0jeY9Vcn4qBO8yZsyDBGzEV55bHzXIox4nu+iRI90HAfYFS3EpBuv15ELCFrVvwRwmwUiAxy9M/v22Sdd/UReum6wNkz3dcf68P4ePc+RvdW1UAYUEPNGwj2Ve8Y0d06DJWcn1GBRvDha5cKj55EGhMFPBR6IlFdfZIhMtk3VclPOnvyji6JKLln2nnrOZXP/+hzp6z6ZVrZ/lMomNuK1FPa93Qc6NqJYzDI2s+pa7vtGG6hJHO+PgW67FYJD4mdnmPZ9BQG14SsYdwqvYh9DibzoHSkeqqOcDUr8oAyWu5IQxMjGZRAwTFAo/Wnpf7g7FOmP4MzYOUlItjuL/w8VzrkSGXaXxLciWHJRYAhblhSnDDQlWDd1lHknHMblPMgtkxE1GH4ysjUzTehBHXEQLb162eNOSvRJkvpwY6XTNiF65+MFggN+XbF1lQFzkuFtRcGyhQ4TA==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(40470700004)(46966006)(36840700001)(36756003)(82740400003)(7416002)(40460700003)(34020700004)(41300700001)(81166007)(36860700001)(316002)(6666004)(8936002)(478600001)(110136005)(5660300002)(82310400005)(54906003)(83380400001)(40480700001)(356005)(921005)(26005)(2906002)(1076003)(8676002)(70586007)(16526019)(70206006)(186003)(107886003)(44832011)(47076005)(82960400001)(2616005)(336012)(956004)(86362001)(4326008)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 10:23:54.7428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d37000-f2c5-4c9b-1f63-08da84f19504
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT069.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4021
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/gpio/Kconfig       |   3 +-
 drivers/gpio/gpio-f7188x.c | 107 ++++++++++++++++++++++++++++---------
 2 files changed, 84 insertions(+), 26 deletions(-)

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
index 18a3147f5a42..820ac5d60fda 100644
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
@@ -21,23 +21,36 @@
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
@@ -48,6 +61,7 @@ enum chips {
 	f81866,
 	f81804,
 	f81865,
+	nct6116d,
 };
 
 static const char * const f7188x_names[] = {
@@ -59,10 +73,12 @@ static const char * const f7188x_names[] = {
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
 
@@ -170,6 +186,9 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 /* Output mode register (0:open drain 1:push-pull). */
 #define gpio_out_mode(base) (base + 3)
 
+#define gpio_dir_invert(type)	((type) == nct6116d)
+#define gpio_data_single(type)	((type) == nct6116d)
+
 static struct f7188x_gpio_bank f71869_gpio_bank[] = {
 	F7188X_GPIO_BANK(0, 6, 0xF0),
 	F7188X_GPIO_BANK(10, 8, 0xE0),
@@ -254,6 +273,17 @@ static struct f7188x_gpio_bank f81865_gpio_bank[] = {
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
@@ -264,13 +294,16 @@ static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
 
 	superio_exit(sio->addr);
 
-	if (dir & 1 << offset)
+	if (gpio_dir_invert(sio->type))
+		dir = ~dir;
+
+	if (dir & BIT(offset))
 		return GPIO_LINE_DIRECTION_OUT;
 
 	return GPIO_LINE_DIRECTION_IN;
@@ -286,10 +319,14 @@ static int f7188x_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
-	dir &= ~BIT(offset);
+
+	if (gpio_dir_invert(sio->type))
+		dir |= BIT(offset);
+	else
+		dir &= ~BIT(offset);
 	superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
 
 	superio_exit(sio->addr);
@@ -307,11 +344,11 @@ static int f7188x_gpio_get(struct gpio_chip *chip, unsigned offset)
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
 	dir = !!(dir & BIT(offset));
-	if (dir)
+	if (gpio_data_single(sio->type) || dir)
 		data = superio_inb(sio->addr, gpio_data_out(bank->regbase));
 	else
 		data = superio_inb(sio->addr, gpio_data_in(bank->regbase));
@@ -332,7 +369,7 @@ static int f7188x_gpio_direction_out(struct gpio_chip *chip,
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	data_out = superio_inb(sio->addr, gpio_data_out(bank->regbase));
 	if (value)
@@ -342,7 +379,10 @@ static int f7188x_gpio_direction_out(struct gpio_chip *chip,
 	superio_outb(sio->addr, gpio_data_out(bank->regbase), data_out);
 
 	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
-	dir |= BIT(offset);
+	if (gpio_dir_invert(sio->type))
+		dir &= ~BIT(offset);
+	else
+		dir |= BIT(offset);
 	superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
 
 	superio_exit(sio->addr);
@@ -360,7 +400,7 @@ static void f7188x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	err = superio_enter(sio->addr);
 	if (err)
 		return;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	data_out = superio_inb(sio->addr, gpio_data_out(bank->regbase));
 	if (value)
@@ -388,7 +428,7 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	data = superio_inb(sio->addr, gpio_out_mode(bank->regbase));
 	if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN)
@@ -449,6 +489,10 @@ static int f7188x_gpio_probe(struct platform_device *pdev)
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
@@ -479,18 +523,15 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
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
-		pr_debug(DRVNAME ": Not a Fintek device at 0x%08x\n", addr);
-		goto err;
-	}
 
+	sio->device = SIO_LD_GPIO_FINTEK;
 	devid = superio_inw(addr, SIO_DEVID);
 	switch (devid) {
 	case SIO_F71869_ID:
@@ -517,17 +558,33 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
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
+
+	/* double check manufacturer where possible */
+	if (sio->type != nct6116d) {
+		manid = superio_inw(addr, SIO_FINTEK_MANID);
+		if (manid != SIO_FINTEK_ID) {
+			pr_debug(DRVNAME ": Not a Fintek device at 0x%08x\n", addr);
+			goto err;
+		}
+	}
+
 	sio->addr = addr;
 	err = 0;
 
-	pr_info(DRVNAME ": Found %s at %#x, revision %d\n",
+	pr_info(DRVNAME ": Found %s at %#x\n",
 		f7188x_names[sio->type],
-		(unsigned int) addr,
-		(int) superio_inb(addr, SIO_DEVREV));
+		(unsigned int)addr);
+	if (sio->type != nct6116d)
+		pr_info(DRVNAME ":   revision %d\n",
+			(int)superio_inb(addr, SIO_FINTEK_DEVREV));
 
 err:
 	superio_exit(addr);
-- 
2.35.1

