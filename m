Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65E85900C9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236476AbiHKPpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236440AbiHKPpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:45:08 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00059.outbound.protection.outlook.com [40.107.0.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312C7A8327;
        Thu, 11 Aug 2022 08:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQyjuAVUKdBPehnpcinbMc0JGj5ihkDOPaMW0dRlwKDHDLodg6p43urW0yBGlgUiT9REHTr8uCFV18P5myZkSHAm7lNsZzrhc3Ksc6q5FmvH8fz8soL/yUlZIzPtjXa7N5YV5KQ68P1qtzWzfcMNOt+bMA/b5XltTzoezLM4Pu6z+tfaAwNRbw6R0A7TfZPLxEscZGZD8pwvB4Bf5I5MUZtKOEIP0q8HHSoHpM0I9/doEiUFDPB3n73Zn7LwQ1Nc3M1CTTvlhJG3zQm4kfkUCdhxirT2FUK9GZt2fzEHNATCJ74HUuRM342YBFIqeCiTGBXF8fxeYl7zm6MpeT/+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Lw4i2UbKSyoieojE20sJ9B6ZT1JO1ChkSG/OQAgFLo=;
 b=O91sWGCMpEDFWAUixl9fj6JRrn7wZTEVP4KpaBiWSnLYaxLD/GIEIpFRQDlR8z7dd0O+NnLZRxODb+Ofts7t5P8w/sT40Jl+fbpwlnmRSFuE7Uu9Qz7uryhTgcVS5iSY/ddwcPQlLwWN0wP9RY1djpp1CKiUHQYPnmxKpN+JQOpU1aucwvn30nPm41iUuGvM3HcDsFckXTWqEssN7B8Gt2EtRxa7gmpfXUAnx8sD9yPVHhEtNun5j4eBRYv+zS7FW2BJnUSdUjZ7AQW/BVf2zs5HMzrHmZjkvJtiGsSiBn70ugG4kS3by5r8VaM8516/s6AQP6nVb13w6q7/hn/9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=linaro.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Lw4i2UbKSyoieojE20sJ9B6ZT1JO1ChkSG/OQAgFLo=;
 b=cF4h/q3x5uK8UBnrXv3/02y2jqQX6Wj2xVpjNAee1EKY/ngg3JTZXt9e5WgaytbzbjtXfBJEZIhzp+J8pL61reEzXz2/ZQvpEo7xn0PbUAw9F8W9Cde14v98r53iTIOVr4/W+qFtaRnwiwP59GcCcnF10Mbp993sJLeC/91W+3G2sOr5UTGLHzZZi+g9kNvUs1865dnQsd6RF/Qi8Cr4AINVgjiCpHeqUk3gXCwEzxNPsJ/jo83rE3jAMJZKwR2MHqBHYoU4bZhvBOXCvAveYi3+lRByi8Mj2XlFqw3sXY7KbnHTBgQtQSHmBKfnWytlYIT4hdkdnmVpf5u03poxAw==
Received: from DB6PR0202CA0014.eurprd02.prod.outlook.com (2603:10a6:4:29::24)
 by AM0PR10MB2417.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Thu, 11 Aug
 2022 15:39:19 +0000
Received: from DB5EUR01FT055.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:29:cafe::c5) by DB6PR0202CA0014.outlook.office365.com
 (2603:10a6:4:29::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.12 via Frontend
 Transport; Thu, 11 Aug 2022 15:39:19 +0000
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
 15.1.2507.9; Thu, 11 Aug 2022 17:39:18 +0200
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
Subject: [PATCH v3 1/4] gpio-f7188x: Add GPIO support for Nuvoton NCT6116
Date:   Thu, 11 Aug 2022 17:39:05 +0200
Message-ID: <20220811153908.31283-2-henning.schild@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: ac05d46b-70ed-49ae-ce04-08da7bafa807
X-MS-TrafficTypeDiagnostic: AM0PR10MB2417:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FkH9QwZ5FbbeZakv12VJLLZ4iXztZdUKQsIH3XaYdZZh46RWRP9gys+uJXNInpdM3uvdF3hsmxWdCEqFTqfbgO95xcpxwR8k6H3jPH0rSdJL9iVcgxIfTgJ0Rof8+kcmaZs1e83AvO99BWMp5Q+yXOrX8OrTHlGBvnWqZz3vejL1wvjaaqq5YlRfKMCPuXrXHqG0JmXi6ZYyZOaLw0q2SIlJy6MJ8QJqz4h2wuzFbncJgbGd07ymrGMKbWp+DfZ2LDXitLa2dlxmnO9lLVc8saUzz/Qhvqx/OTy/18jojS3UEAV1jR+S3HTJ6rPPvyelgHqsR63LdSlJNwVJYm+f9LwdURhH1RjDE9tqvFI0lfSZhl5EqLdgF+PqKMbvALvCPtHYfGXrzetz7jyvdx8CocyaQvFsPVIQbGQiJOSQoYA5KNGF+ZIF2h8bBkyiwblGGlSVRNPHjO8lr6Yna7UjEg+oDDBT17ZKZRdRDcS2Zu3L0TMAk++QiAklC1b4V+WV5LN1TH2hR1B+6O89GL4H3aDf/95625YHQgCyj1dfLyXHm7PtJHg9vGVi5ym4rC9/pCkED5QJ4auIeH3DvKgpSlUt7ILdWKAEI5Ws0+yg0jyZMq2Q18bJcqd7A/oyv/mNwpyZU+mdDELIZdCP6pacxTDgy7syoovFTTvXnD3c3d03D6eNcqZr6e2NImCSPmxYXdYlyXglD9ovc5ftGACQuEB8mOD1x/ZE6fiSJwYBKVnQudkSpxDTzO3vsm7huhqr01BCbxnbR/PAUv1vXLofT1n+LNIS9FW0xwItIXbbPJG+odpb8i01DShGIPAqXsM8JORhPrWH8F9KZJyYXtmIktTbSKxz+uQ7p3EZAC7YWnd2J1D1kVxONHXHmRdu/OjGRr2+RRbGRS8e9bKkeFEl3w==
X-Forefront-Antispam-Report: CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(136003)(396003)(40470700004)(46966006)(36840700001)(1076003)(82310400005)(107886003)(40460700003)(478600001)(86362001)(70206006)(81166007)(110136005)(8936002)(54906003)(82740400003)(356005)(26005)(82960400001)(921005)(5660300002)(36756003)(4326008)(2906002)(6666004)(186003)(16526019)(83380400001)(41300700001)(2616005)(7416002)(40480700001)(44832011)(336012)(47076005)(8676002)(956004)(36860700001)(316002)(70586007)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 15:39:19.4142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac05d46b-70ed-49ae-ce04-08da7bafa807
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT055.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2417
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
 drivers/gpio/gpio-f7188x.c | 71 +++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 20 deletions(-)

diff --git a/drivers/gpio/gpio-f7188x.c b/drivers/gpio/gpio-f7188x.c
index 18a3147f5a42..7b05ecc611e9 100644
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
@@ -22,13 +23,12 @@
 #define SIO_LDSEL		0x07	/* Logical device select */
 #define SIO_DEVID		0x20	/* Device ID (2 bytes) */
 #define SIO_DEVREV		0x22	/* Device revision */
-#define SIO_MANID		0x23	/* Fintek ID (2 bytes) */
 
-#define SIO_LD_GPIO		0x06	/* GPIO logical device */
 #define SIO_UNLOCK_KEY		0x87	/* Key to enable Super-I/O */
 #define SIO_LOCK_KEY		0xAA	/* Key to disable Super-I/O */
 
-#define SIO_FINTEK_ID		0x1934	/* Manufacturer ID */
+#define SIO_LD_GPIO_FINTEK	0x06	/* GPIO logical device */
+#define SIO_LD_GPIO_NUVOTON	0x07	/* GPIO logical device */
 #define SIO_F71869_ID		0x0814	/* F71869 chipset ID */
 #define SIO_F71869A_ID		0x1007	/* F71869A chipset ID */
 #define SIO_F71882_ID		0x0541	/* F71882 chipset ID */
@@ -37,7 +37,7 @@
 #define SIO_F81866_ID		0x1010	/* F81866 chipset ID */
 #define SIO_F81804_ID		0x1502  /* F81804 chipset ID, same for f81966 */
 #define SIO_F81865_ID		0x0704	/* F81865 chipset ID */
-
+#define SIO_NCT6116D_ID		0xD283  /* NCT6116D chipset ID */
 
 enum chips {
 	f71869,
@@ -48,6 +48,7 @@ enum chips {
 	f81866,
 	f81804,
 	f81865,
+	nct6116d,
 };
 
 static const char * const f7188x_names[] = {
@@ -59,10 +60,12 @@ static const char * const f7188x_names[] = {
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
 
@@ -170,6 +173,9 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 /* Output mode register (0:open drain 1:push-pull). */
 #define gpio_out_mode(base) (base + 3)
 
+#define gpio_dir_invert(type)	((type) == nct6116d)
+#define gpio_data_single(type)	((type) == nct6116d)
+
 static struct f7188x_gpio_bank f71869_gpio_bank[] = {
 	F7188X_GPIO_BANK(0, 6, 0xF0),
 	F7188X_GPIO_BANK(10, 8, 0xE0),
@@ -254,6 +260,17 @@ static struct f7188x_gpio_bank f81865_gpio_bank[] = {
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
@@ -264,13 +281,16 @@ static int f7188x_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
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
@@ -286,10 +306,14 @@ static int f7188x_gpio_direction_in(struct gpio_chip *chip, unsigned offset)
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
@@ -307,11 +331,11 @@ static int f7188x_gpio_get(struct gpio_chip *chip, unsigned offset)
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
@@ -332,7 +356,7 @@ static int f7188x_gpio_direction_out(struct gpio_chip *chip,
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	data_out = superio_inb(sio->addr, gpio_data_out(bank->regbase));
 	if (value)
@@ -342,7 +366,10 @@ static int f7188x_gpio_direction_out(struct gpio_chip *chip,
 	superio_outb(sio->addr, gpio_data_out(bank->regbase), data_out);
 
 	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
-	dir |= BIT(offset);
+	if (gpio_dir_invert(sio->type))
+		dir &= ~BIT(offset);
+	else
+		dir |= BIT(offset);
 	superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
 
 	superio_exit(sio->addr);
@@ -360,7 +387,7 @@ static void f7188x_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	err = superio_enter(sio->addr);
 	if (err)
 		return;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	data_out = superio_inb(sio->addr, gpio_data_out(bank->regbase));
 	if (value)
@@ -388,7 +415,7 @@ static int f7188x_gpio_set_config(struct gpio_chip *chip, unsigned offset,
 	err = superio_enter(sio->addr);
 	if (err)
 		return err;
-	superio_select(sio->addr, SIO_LD_GPIO);
+	superio_select(sio->addr, sio->device);
 
 	data = superio_inb(sio->addr, gpio_out_mode(bank->regbase));
 	if (param == PIN_CONFIG_DRIVE_OPEN_DRAIN)
@@ -449,6 +476,10 @@ static int f7188x_gpio_probe(struct platform_device *pdev)
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
@@ -485,12 +516,8 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
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
@@ -517,8 +544,12 @@ static int __init f7188x_find(int addr, struct f7188x_sio *sio)
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

