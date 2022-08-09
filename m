Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340A258DABE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244801AbiHIPFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiHIPE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:04:58 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C4C1CB1A;
        Tue,  9 Aug 2022 08:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ogo3a4KhR/3v81sVkqnXXmIpowwuZCFYwqusFgmBPhld0SGLGk7KwGQDAtuApE6Kd2v//c1nbPoXGmJ83iAcIT5+1wPILZHtbcSF/p5C/HjOxaTVI3W5/vPaNWlt0lbM/YjdN7Z6KDDq7S3SOD/yHQZdaW2vHj88swfuJLcP/JPiBb27ZYFYLLFSnV/f73GBBfZfmLpPUq60Pf3fB3uYW52KpE+bfTumHHehNaKBKbZMO8Xtv5e89zSmhlliDIU9OhN3nzUN42UxB7ijoCfW5k3SqKlguP4Oyth9hBNFUYC9pfH09qEkH+UWcbCOFxYNNui6IlU8xWuaej5tlu1f8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzaUqQmeVJ2hp83ZBWKmMFLkduKzEfxPNWugpUX9nNQ=;
 b=aydF0L4dVxMyYpUigkg7lDTHTv8toZvG87x39gtBU2rpgdxpAGq1mzUpoU2KHZbDxgterAKz/8ykHDNR7EGgymxKrmkuXPYG9bdFWXphMocdih00Voi98MAMGwzaPZgV/X/0r3/L2LJdaaNP8YRok0+M1dCw1N1eQ/C4zcua7XIaXSFmn+KA+uGjY7yhqd5Es1t71KlRvnbu0L8OxFOYKG+latEA4TRe+f+Rp6JCQMbQGQqdCNmEa7ox7r5O2nLS1Clpu5feZQD53Q+LBbFujUyieP+1AWcVBgZ+GPdzIY29M4D/Vm4QdXLFY5OIPF9Ool3AjHOsXiZQGXvsHNNn8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzaUqQmeVJ2hp83ZBWKmMFLkduKzEfxPNWugpUX9nNQ=;
 b=stEM43mdzUBSADVmun5SeJ5Amryyt4I4xO4MZpZ2tGsUz4+Wn5J/kZgJCM3fGB9Lnm6is7zVG6+/D63lJ10GxjyU886JwljXnNDYmzz7OJRmAYOhLWhAxadqbx0sgkTrPJrexHrMzB3wLJD0gz3CX7hE9NxXtCPIhygLddlQxS3eADiHvcfur89mZzF/+34JXmSBCnFCNH+2z02DueOwPRkR0J0L+hSrBbIZWZ2oLW9FFenRAWL0aJuCAeivlFU2Y7fuj3y+wBjfdmtU/9eRTLKLSVvLzDDt80qwri52JHxJqG7YYTiyTTIBrgwguEa3vRF4+Zye8ODU3TQwmRNpog==
Received: from DB8PR09CA0012.eurprd09.prod.outlook.com (2603:10a6:10:a0::25)
 by VI1PR10MB1807.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:802:36::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Tue, 9 Aug
 2022 15:04:53 +0000
Received: from DB5EUR01FT026.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:a0:cafe::1a) by DB8PR09CA0012.outlook.office365.com
 (2603:10a6:10:a0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Tue, 9 Aug 2022 15:04:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 DB5EUR01FT026.mail.protection.outlook.com (10.152.5.2) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.14 via Frontend Transport; Tue, 9 Aug 2022 15:04:53 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Tue, 9 Aug 2022 17:04:52 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.0.80) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 9 Aug 2022 17:04:52 +0200
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
Subject: [PATCH v2 1/4] gpio-f7188x: Add GPIO support for Nuvoton NCT6116
Date:   Tue, 9 Aug 2022 17:04:39 +0200
Message-ID: <20220809150442.3525-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220809150442.3525-1-henning.schild@siemens.com>
References: <20220809150442.3525-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.0.80]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.964100-8.000000
X-TMASE-MatchedRID: h70/C8ZQwy0najXSbZssErN5pka0DGqI47cLULZlxOVkGI+vgRTxME+c
        rEA4+nhZEmx/CUhRV0GhAqHLqD5GgW7iQTMjrcXyajaAHeKHIftiWV0DQ85LUrcPsR57JkIzSWg
        +u4ir2NPvmUrJba0cpHoHefDWzW72szhj7g02MR5Xt0iLVmIq+oEBch0HhZyDfzgVmnL/olWMQf
        Yi97TPS1VkJxysad/IRlSqJpn6jycKXI0GFROfCKWyTAyGeJuv/63r0U2g4cfCtSG/SQAC8bWTd
        tEh1dU0GlfXMQvierexCOv1qt1aOU+UviNdiXF3EtRm78gcrDGioinUBRkHmltTO+xodboGwRdj
        nTeqAAGbKItl61J/yZ+inTK0bC9eKrauXd3MZDWiZ3sWC9weZNJlJOoUXGozevzTvFcXhxjxz8N
        bCt5u+cNnCC/0tBlI
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.964100-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 980C58D8C0F0454EDC62F5EB960A0204CE12F51CB223AC75E6EA1B25C19196C62000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8692a1d-0c79-47e9-a6a1-08da7a1883f1
X-MS-TrafficTypeDiagnostic: VI1PR10MB1807:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZ96ykE7bkvbn7mvaXIxEv4mPqxn1szQLSC83znwV0hOtmYoHQs4BPI71tGXtRyEf/drXV/603bAiIDBcxQxvatI2+UXvfX1gdOfIXrv9YgqdXrNpxGAeB382pH9i6iFZFbT/9vEU+SOqz7y3wvx8OrWflMdjQ9FMtAsEoT6r7qLOSQ90Fcgxx7RB8yzoIx6MEbomVUlcSrP09WS+WRpt30gtEQ969max4lUgXuiZXjgJv6IDqbU4ePNntFEE1/5NbtcNBHFmgHSizZWc7eZ65uyH81g7uor5RjK8SJBUkvED7bgt4lt/BrE4wbd2zYFtzXKQQk/KnitL7+GFGh92yvbChqTi17iddWKOSjZ2M24xRCiOIK8/sCQC/vnBqQ2Zru0Yn+nOtDErYAyCOCQGPDim8mOmrBG9+Atc9rhlpYGGd8SYc3tmSoeYX1+ZVxR5mNByLmwmg92eP8ta1iDNHO1+YI+eap8kgb4jjp6FUOAi/tzURIxDs/pEO7hXmYaY9kJPSZXL20AXDeHoPi3BERdg/zfwxUopGDDzE7gPbZdFpCDUk6z7iyAQ68gUGtLvt8YyLxL5H14xmo+KeCQXTj7atyEeG95j3HNvMbKQkGOILTSGQvXBVm3JXSqN5LMav6s1p/Z94ZU5W2cIee0xnveafLwKYcotKG/AQ6p+FHXCTQ/CAoHA6PZPFWl3yTxMAMGlN0gUh9wskixtfD7BCH3hmGELTm14TRPExgiGUiNxIf6UQGZFPgZGgTbA8rE1LM8CcqaghIXaOqFY5d1x/MmPw2AP06EPL4LORt6AfHYDdfZv4deA4O9EXRbTA+6SzwkW2GGbGl8aNS7L1d2YkiYm/lExOLRicie1ahlW8rDOansLAGzm4TVi4BCM7eFFz/ybj1jwa4blpYx4uiPe8ZFCyFWrILmZCoWkBYpq1inpCICeaoWlT8f1tWtF1p9
X-Forefront-Antispam-Report: CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966006)(40470700004)(36840700001)(82740400003)(4326008)(7416002)(70206006)(70586007)(36860700001)(54906003)(8936002)(82310400005)(5660300002)(8676002)(186003)(316002)(44832011)(478600001)(110136005)(36756003)(956004)(107886003)(2616005)(47076005)(26005)(2906002)(41300700001)(336012)(6666004)(921005)(356005)(1076003)(16526019)(81166007)(83380400001)(82960400001)(86362001)(40480700001)(40460700003)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 15:04:53.7177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8692a1d-0c79-47e9-a6a1-08da7a1883f1
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT026.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1807
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

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/gpio/gpio-f7188x.c | 70 +++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
index 18a3147f5a42..4d8f38bc3b45 100644
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
@@ -38,6 +37,8 @@
 #define SIO_F81804_ID		0x1502  /* F81804 chipset ID, same for f81966 */
 #define SIO_F81865_ID		0x0704	/* F81865 chipset ID */
 
+#define SIO_LD_GPIO_NUVOTON	0x07	/* GPIO logical device */
+#define SIO_NCT6116D_ID		0xD283  /* NCT6116D chipset ID */
 
 enum chips {
 	f71869,
@@ -48,6 +49,7 @@ enum chips {
 	f81866,
 	f81804,
 	f81865,
+	nct6116d,
 };
 
 static const char * const f7188x_names[] = {
@@ -59,10 +61,12 @@ static const char * const f7188x_names[] = {
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
 
@@ -170,6 +174,9 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 /* Output mode register (0:open drain 1:push-pull). */
 #define gpio_out_mode(base) (base + 3)
 
+#define gpio_needs_invert(device)	((device) != SIO_LD_GPIO_FINTEK)
+#define gpio_single_data(device)	((device) != SIO_LD_GPIO_FINTEK)
+
 static struct f7188x_gpio_bank f71869_gpio_bank[] = {
 	F7188X_GPIO_BANK(0, 6, 0xF0),
 	F7188X_GPIO_BANK(10, 8, 0xE0),
@@ -254,6 +261,17 @@ static struct f7188x_gpio_bank f81865_gpio_bank[] = {
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
@@ -264,13 +282,16 @@ static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
 
 	superio_exit(sio->addr);
 
-	if (dir & 1 << offset)
+	if (gpio_needs_invert(sio->device))
+		dir = ~dir;
+
+	if (dir & BIT(offset))
 		return GPIO_LINE_DIRECTION_OUT;
 
 	return GPIO_LINE_DIRECTION_IN;
@@ -286,10 +307,14 @@ static int f7188x_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
-	dir &= ~BIT(offset);
+
+	if (gpio_needs_invert(sio->device))
+		dir |= BIT(offset);
+	else
+		dir &= ~BIT(offset);
 	superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
 
 	superio_exit(sio->addr);
@@ -307,11 +332,11 @@ static int f7188x_gpio_get(struct gpio_chip *chip, unsigned offset)
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
 	dir = !!(dir & BIT(offset));
-	if (dir)
+	if (gpio_single_data(sio->device) || dir)
 		data = superio_inb(sio->addr, gpio_data_out(bank->regbase));
 	else
 		data = superio_inb(sio->addr, gpio_data_in(bank->regbase));
@@ -332,7 +357,7 @@ static int f7188x_gpio_direction_out(struct gpio_chip *chip,
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	data_out = superio_inb(sio->addr, gpio_data_out(bank->regbase));
 	if (value)
@@ -342,7 +367,10 @@ static int f7188x_gpio_direction_out(struct gpio_chip *chip,
 	superio_outb(sio->addr, gpio_data_out(bank->regbase), data_out);
 
 	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
-	dir |= BIT(offset);
+	if (gpio_needs_invert(sio->device))
+		dir &= ~BIT(offset);
+	else
+		dir |= BIT(offset);
 	superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
 
 	superio_exit(sio->addr);
@@ -360,7 +388,7 @@ static void f7188x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	err = superio_enter(sio->addr);
 	if (err)
 		return;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	data_out = superio_inb(sio->addr, gpio_data_out(bank->regbase));
 	if (value)
@@ -388,7 +416,7 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	data = superio_inb(sio->addr, gpio_out_mode(bank->regbase));
 	if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN)
@@ -449,6 +477,10 @@ static int f7188x_gpio_probe(struct platform_device *pdev)
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
@@ -485,12 +517,8 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
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
@@ -517,8 +545,12 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
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

