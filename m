Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC9159FCA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 16:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238537AbiHXOEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 10:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238097AbiHXOEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:04:05 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2041.outbound.protection.outlook.com [40.107.105.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2364B8688E;
        Wed, 24 Aug 2022 07:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgPhZcmtR2KxuSfpOV8YiM+TlIwo5bMg2H+t7ByJOwxLL2RSUh1QxOdfXInNGC6ZNCnqVHzM+iVG33UUTn6rL2XjGf6R5xBUBR7rbZLCtGWkYM+wIfRR+4IJG1YZDcvjze+GiNGOR0KZWP6Yl4b308wH8/6HjJtkPwA7OFNx9q+Us1Esoz2x/4XxPbra0S0IrXppfP1w8zAwn3Sow+8I3KCWB0FsauJRxnBgdtMEVoA0U1iKxiR+5S6CkwNdoXjHpj24KMSEQ3oL7l3GX7CkTu9efIzsFrZy1/bgwTR3KG+u7w4qL2Ja6fLt9+E66Ug9OD44C2EOgr/Elk3UlXBb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vY+IRD8AQL5pNUkJbuEwvcnKMHAvl/E2ZEMYnI9zJmE=;
 b=OJqN0V0Pqk5ikeIiVOuuwFTheRBJLSCxEMwgELwqk+5Gip84w/7Gt3PQ4j1cIfhmZkWH+LLvcxJfWwChc4XmNg7gpUdD/LlFO6w0WU9h2QBSv/KA8T2lW/QUuebuIw+hUu2X8gENZOfDCxm8wJokuZXUWsa19kLpNnWY8224JIQTXGNo3s6AhJmi8Rx0q4ldAaBceEGLnCvrm9REr+Xr/AMgvCIcPVDWlYWBwuEicnAllfrgkDUehQICs0o3zgkXtLbGieFVmFhsm9DhRBvym15H/cVwz0wv8/newFutBzWJRP4YcrvXhR1P2Zu+9hik6VVucWeOdz4ySrlaT0LTaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vY+IRD8AQL5pNUkJbuEwvcnKMHAvl/E2ZEMYnI9zJmE=;
 b=QZOS68FJGqSBaqgNBUg6+h3mlOqRxek1/1HJp1yzMr8Wg3qIyircCNNRCXLISbKhRuppWO3K3EGeTT2u4YHvRZCszDIdUtI+HcLiGiNx+XFz70DKLeeb4EVp6O3Ugm/zqwaxQoRHKKoIXR8wIiF8A8q3igdAxQBQ5scl+giR+Q2IYnPXCZj15EtpxHiuddcsDRTa5I4I0qQRM3wx3sk4JzSI+b4060r8PjVqV428Dinl3///rpFFwMrcO5Ncbf5T9J/DNhAzoUUAlzqslcVXKp7syzlctTKw+I2s5i5O9/pfu5nijUyDRB93V/8ZWeddFGJnzmxMdHyR+NGn93fIag==
Received: from DB9PR02CA0030.eurprd02.prod.outlook.com (2603:10a6:10:1d9::35)
 by VI1PR10MB2224.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:89::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Wed, 24 Aug
 2022 14:03:59 +0000
Received: from DB5EUR01FT009.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:1d9:cafe::1a) by DB9PR02CA0030.outlook.office365.com
 (2603:10a6:10:1d9::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Wed, 24 Aug 2022 14:03:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT009.mail.protection.outlook.com (10.152.4.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 14:03:59 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Wed, 24 Aug 2022 16:03:58 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 24 Aug 2022 16:03:57 +0200
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
Subject: [PATCH v5 1/5] gpio-f7188x: Add GPIO support for Nuvoton NCT6116
Date:   Wed, 24 Aug 2022 16:03:43 +0200
Message-ID: <20220824140347.1842-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220824140347.1842-1-henning.schild@siemens.com>
References: <20220824140347.1842-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--9.558100-8.000000
X-TMASE-MatchedRID: 4hNj2i8ecmwnajXSbZssErN5pka0DGqI47cLULZlxOVkGI+vgRTxME+c
        rEA4+nhZEmx/CUhRV0GhAqHLqD5GgW7iQTMjrcXyIyjGuFgTWAqmWOD8X0TFhCfphWrcxCwjP6T
        ki+9nU38HZBaLwEXlKIpbwG9fIuITxDz7g9Od+jiMiT1/gSrRziLSA2Bw59G2hjlBjwpom1OsU/
        iX0A2wj4vTOLR19hMMHR687uSBjUkAR2M5455n91jt7H32pJq0gQFyHQeFnIN/OBWacv+iVX/0y
        Dqj7AyLVWQnHKxp38hGVKommfqPJwpcjQYVE58IpbJMDIZ4m6+DrlECq0GE4mNW0DAjL5p+XGjQ
        f7uckKtGRWxg7mLXKMTr/G24o7RrCnOJY6i7X33k53wLsyYs5QwhA/znOS/bb/oIJuUAIuF9LQi
        nZ4QefPcjNeVeWlqY+gtHj7OwNO0LH2qjGZLbHeK7e9vioFO+EPjsoCTRPWYlbza6rYgu5uVR+x
        t+73YO
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.558100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 7911DB83ADFA2519C4AB3A2571267570AD7C3AC21E91D91B4DF10BA40E342D552000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c3b15f3-6e72-4a1b-962e-08da85d97dfd
X-MS-TrafficTypeDiagnostic: VI1PR10MB2224:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnA8y5No7v0l36BYxy3W+dnF4Yai+hR69I+sjgWBUoJrid/D6PM6vzNfrHJxh4u+2z5vHpxEPthIV4sE3qgDGieXkWMjFvO0abuafUvwlQ7gXh0gUTIHgfic5nzpy+lW4r3CgHOZojowozfwn2kiNqJgP/RwroqLvq8WSXGmbQttM26rw72qEmqSuExD2AX17QkGYnosDqkCttSRKRzkaVHeUc3J/iH6op9C4vV2Jt7NalvYPYVdj3oPrVj0YPjbjNwveW7riVSWr3BqIPfpYKPKlJbr2bRd0UGdisnQd+GJdOttoAIrrDYJ/S56dKtky89pDCRJamG2oCrRCYUPAC2WMWEN1BdFIy+KqWcQSxEKUyWK1015STEfklSVdsplhZzuqb3/OArtoEkdVfGzlY7KDIkhoJli00BdQyetWMWh3Oz/ejoGKgbIXyS7G4JQ53kt9efyWAYzVnsfFlRbq4hLvxDuks/mCSbTlRXc8BdLjjKUm+Qqn1+vdlYeeZFvFDgo/g0Qk5c7DYotmvvjwTQUzJlL6gZ2W6YQl4FpyBWQYqKL1uva6EnmtVa7meNWkpO76pMkQRArUuw+X3KctqLWNvZFzpveN/p66PsLrYnWpP8I6JJbcN2u3yz/27yoE2aQalUaWcjmaty/aVytcIvrCIQLQxZusR1bW2s98TW8qAczXzTqH/yiLRPWQIO0+WjTxm4cBSnA1gtYZIlMp2PrAHSx6+OZoppNFYHMtt0zCh+DyYzNBsNphrVgKU4uJz5H/pynGDMeuLXO1ATKf1rRircnL0DdU77yft1Rc2/fs6ulpkJGfTWYl7a1ls3ocQC+bPVeYpc9I0n/TPipeoATX2ju5tT5T8dH/TYTaEr78vI0sEsFj8eN6M5v4MdW2PqI7L+AOGDSHSpIfOLEsA==
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966006)(36840700001)(40470700004)(34020700004)(82310400005)(83380400001)(4326008)(40460700003)(40480700001)(921005)(81166007)(36756003)(356005)(36860700001)(82740400003)(70586007)(8676002)(70206006)(8936002)(316002)(7416002)(5660300002)(44832011)(26005)(478600001)(107886003)(6666004)(186003)(956004)(54906003)(82960400001)(110136005)(41300700001)(2906002)(86362001)(47076005)(1076003)(336012)(2616005)(16526019)(83996005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 14:03:59.3811
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3b15f3-6e72-4a1b-962e-08da85d97dfd
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT009.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2224
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
 drivers/gpio/gpio-f7188x.c | 106 ++++++++++++++++++++++++++++---------
 2 files changed, 83 insertions(+), 26 deletions(-)

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
index 18a3147f5a42..b73bf28bf347 100644
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
@@ -517,17 +558,32 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
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
+		pr_info(DRVNAME ":   revision %d\n", superio_inb(addr, SIO_FINTEK_DEVREV));
 
 err:
 	superio_exit(addr);
-- 
2.35.1

