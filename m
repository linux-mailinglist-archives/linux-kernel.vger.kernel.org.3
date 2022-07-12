Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8B0571CC6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 16:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbiGLOdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 10:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbiGLOdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 10:33:03 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5684ABA3B7;
        Tue, 12 Jul 2022 07:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBkigryF/58eSv/hp4dyVsEvw74KgXp52txI7jEiJW/JPA1Nof1CCp2uXmZ2DmMnoX35e2m5Q3dSJo+pJbDEh3IMo5oZhcHL/XyWUT6jcjzJVtGaiKKxeoB1mdwmWrXEcwoiMhA1leoe3rnbNbqfNlMiDVO6ST2Pw4rZWno24eVudAHctYT7GZEpFczHCKQHGu73lJFnduUdXWhFtBLl9D+NdSIvKNEZB4sh0OK4fxnS3DvFlBrSh0aHy7iBlIG1x7U+xpvMxHE7+pJ2hY53o7Q3LAYdaNfEyvA6p6zFqXI0eRwq0INypVtntDALIX3n05WkDOsdTfJ4sKukFP1aMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOKa1wVdaWsE1WClrepGnfKm16MtmRusKllK+Koh7QQ=;
 b=iazEjGfubg1XaoV1Gpvvi8GRZAEzc+Mtzhntd7HRFrSIfyXudJ1Xlf5uxr7+kzhZiSvLnOHZggqGE/Xx/H7Rpqdjybce9HVLWgMUJQOPbwJOmqhHwH1w7VbyTGiH/YYgKwoxfTe3AcZdk425W+TgkSgeCLMggtdhV2wLnjIS91tZWszJeKDfQREwEmcUliraRHExlBMvtaezKnOWtBHP8d0IZjOLIK7c7lx4z9gjxhs0bhmmQa5m5HBNDHmmGiFyvEAbrr+WF28yN01t6t+4vySCOGa8jUC9xLvFCUA1b7iBQs65Cc9tcbag10J8Bs6bezzus2q+Ok3iy3N5bvGEUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOKa1wVdaWsE1WClrepGnfKm16MtmRusKllK+Koh7QQ=;
 b=WCiLkMSk1s7IHoT76PynpixQgxRESSUFxDHcQXHoKyaldG0ZHyqgTnDLQRNybCSYQ+eIx6GoXV6tmCvSboCPE9HyxSF2kFh3xBsxSjj3DIAm4ZUwgcLoVH3p6wGZ/cRBoqhkgnoaAskndWqMygTbVNd5KQSzHmwnQFjQgWPwF+VCfQemkEWnerXYcBXsFtj3VO6ko7cg2YuNw3wt71K3X2Pa+40e1jhVm2vuwZV95x6LtQGZWGVBTERaFVkS6qQ4KXkjjlTCBGxrZrxCYbHT5O3w9E5jT0UIjbAJq9KA1bJEWqZ3+QTxLjZVfCxjDEr8+SSDQmGGpsEARu0pECQ81Q==
Received: from DB6PR0202CA0003.eurprd02.prod.outlook.com (2603:10a6:4:29::13)
 by AM6PR10MB1957.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:31::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Tue, 12 Jul
 2022 14:32:53 +0000
Received: from DB5EUR01FT069.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:29:cafe::51) by DB6PR0202CA0003.outlook.office365.com
 (2603:10a6:4:29::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Tue, 12 Jul 2022 14:32:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT069.mail.protection.outlook.com (10.152.5.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 14:32:53 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 12 Jul 2022 16:32:48 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.161) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 12 Jul 2022 16:32:48 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
CC:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v3 1/3] gpio: nct6116d: add new driver for several Nuvoton super io chips
Date:   Tue, 12 Jul 2022 16:32:35 +0200
Message-ID: <20220712143237.13992-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712143237.13992-1-henning.schild@siemens.com>
References: <20220712143237.13992-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.161]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--8.523600-8.000000
X-TMASE-MatchedRID: nTzxzMSGx3YTd+SwcuWgWpcVPxYm2n8n6RGSI6KP9StdDcY5R0jT7uWb
        lHcaqvkONJUb9GR1a9nbJMbTT9K/TXjn0UTTDjfNujKSZWxviTfyNWG6Utfmrz8Ckw9b/GFeTJD
        l9FKHbrkda1Vk3RqxOMRLhY4YFk6ttt/4kApsBTMVh9CPTUlmMp5Napjzkj5fPaBTJyy84wVr2q
        JoNIuCjVgLks93sG9tfP7hxKOHfyQheimONs0wVv/2w1GhpaxJXPWa1r073dhQIqE1CnEPF41j+
        mrGi/PFRkVsYO5i1ygmZXuPVZCqh3kO10HjLgnp8XG3zT5yERlthJ7IXRIqNho8wYJxWb0OBXJ6
        j2Ez1IeLxWuV11DGxjRWUV7QyeVeAMiAN1jVvmVgOb2hKLw6D2KzPi0pKhZeqg0gbtLVIa+s/vM
        FnvXRhpl8NETW6pKCl23JNSaQyjNkDZHn5XG+Op5V4QyQemOg42nbKJncaZQJaVZHbbd1ro5Uaf
        LmrvaGAwAObkR2opZrn05jFut6Kz0MuqEGj+GxVIKZ9Pa/e17epncDgUbx3W/6CCblACLh+LidU
        RF+DB2mOWRsO8Mnh+dGC5niM4Ay4vM1YF6AJbbCCfuIMF6xLSAHAopEd76vRS9AkBHH6Wtv3wOe
        +pe0t1KFYRlDwm4zxxjTDZz5w4FbDQAJ8Eh12A==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.523600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 6982F22C76C7203A1B035A452663876796D8AF1E9AB7B2D0CD741CE44C62BE7B2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6542eb04-2fc4-4c42-607a-08da641367d4
X-MS-TrafficTypeDiagnostic: AM6PR10MB1957:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AZOiwDpZu/aqLxuVcEUALB6MGORXBqSlmPJODfxGugsBuAs8BKILtLJWurotvmC8uf8ogSE3/Db9eeDai6at23Q7Zu5qbN7ANNil9L+Vc1pVug7IbziMNpz4q/BUbT5CyUlsbagYg4RFv2AmdKV16a749hRiXxyju4SbXK9J513sROds7+jLr1yKIIS3hBfHRy/o4kNWe5q21mg6SlYMR4V935stIEcVYq3QH8abuk3Km1XdISK8+UWlosYnsZZr6IbQ4d+n78/jSaDyGd7rpd13eb3OLM4IuJsEIO/V1ypiZsBmFp6ac3PdMIdAnmuy8vize0pLzdGEJ9tV2rBiesCwLJsDflXAKwpvvgVO2ZGC+bMAT3jmIr61cjFuK2CFelUB1hTKGlimYNaL3HHD+YEbT3nbR5O3LoxC/jRneugJ3lxJdc0dDjTBUEdwSSTDuj4Vt3DTvD2PFPjTYCFRp61zxJbf42hXEqqxi2fvJ3ZFV/LpO+iWzk8FWDdL0aSeX2VVXjE/HmauhmtDvLVffzZb1rQl7zj87GmcReLgn3dqD64ZuB94uSlgFKh0ZCdjFgvJ39eucSJMfMfo9K/kUenD+jSYiTBOzalTN+uy0qssXdvYsmHQyr2gUJqz6WobJYYPWNgmFdMp53lW6hFiqXOETUQ3RsSuQNyxMSBgMQ60yIh5xLQOazRVJvIBI7fTJzQdZh5IVJ/Z+UZBiL2m/VUTEdt68sxeFnfuInBvK/8rNX4VKHjbmV+1YeSStwTtcYt9nKQ3rafRfXvTVF1VAewMoIkxEoYAhzBXEKXskUs96S4fR36A9VT7hpEeYo/C++u8eCtogJC7pAoqznTXTQ6Vwqyc/nETVtrmtaFm9vY=
X-Forefront-Antispam-Report: CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(346002)(136003)(36840700001)(40470700004)(46966006)(107886003)(336012)(83380400001)(40480700001)(47076005)(4326008)(1076003)(186003)(8676002)(70206006)(478600001)(70586007)(956004)(86362001)(82740400003)(8936002)(2616005)(82960400001)(30864003)(16526019)(316002)(2906002)(36860700001)(81166007)(40460700003)(110136005)(44832011)(82310400005)(41300700001)(5660300002)(36756003)(26005)(54906003)(356005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 14:32:53.4693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6542eb04-2fc4-4c42-607a-08da641367d4
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT069.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB1957
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds gpio support for several Nuvoton NCTXXX chips. These
Super-I/O chips offer multiple functions of which several already have
drivers in the kernel, i.e. hwmon and watchdog.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/gpio/Kconfig         |   9 +
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-nct6116d.c | 412 +++++++++++++++++++++++++++++++++++
 3 files changed, 422 insertions(+)
 create mode 100644 drivers/gpio/gpio-nct6116d.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b01961999ced..1f1ec035f3c6 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -899,6 +899,15 @@ config GPIO_IT87
 	  To compile this driver as a module, choose M here: the module will
 	  be called gpio_it87.
 
+config GPIO_NCT6116D
+	tristate "Nuvoton Super-I/O GPIO support"
+	help
+	  This option enables support for GPIOs found on Nuvoton Super-I/O
+	  chips NCT5104D, NCT6106D, NCT6116D, NCT6122D.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called gpio_nct6116d.
+
 config GPIO_SCH
 	tristate "Intel SCH/TunnelCreek/Centerton/Quark X1000 GPIO"
 	depends on (X86 || COMPILE_TEST) && ACPI
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 14352f6dfe8e..87f1b0a0cda2 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -107,6 +107,7 @@ obj-$(CONFIG_GPIO_MT7621)		+= gpio-mt7621.o
 obj-$(CONFIG_GPIO_MVEBU)		+= gpio-mvebu.o
 obj-$(CONFIG_GPIO_MXC)			+= gpio-mxc.o
 obj-$(CONFIG_GPIO_MXS)			+= gpio-mxs.o
+obj-$(CONFIG_GPIO_NCT6116D)		+= gpio-nct6116d.o
 obj-$(CONFIG_GPIO_OCTEON)		+= gpio-octeon.o
 obj-$(CONFIG_GPIO_OMAP)			+= gpio-omap.o
 obj-$(CONFIG_GPIO_PALMAS)		+= gpio-palmas.o
diff --git a/drivers/gpio/gpio-nct6116d.c b/drivers/gpio/gpio-nct6116d.c
new file mode 100644
index 000000000000..2ff92f3e11aa
--- /dev/null
+++ b/drivers/gpio/gpio-nct6116d.c
@@ -0,0 +1,412 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GPIO driver for Nuvoton Super-I/O chips NCT5104D, NCT6106D, NCT6116D, NCT6122D
+ *
+ * Authors:
+ *  Tasanakorn Phaipool <tasanakorn@gmail.com>
+ *  Sheng-Yuan Huang <syhuang3@nuvoton.com>
+ *  Kuan-Wei Ho <cwho@nuvoton.com>
+ *  Henning Schild <henning.schild@siemens.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/gpio/driver.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+/*
+ * Super-I/O registers
+ */
+#define SIO_LDSEL		0x07	/* Logical device select */
+#define SIO_CHIPID		0x20	/* Chaip ID (2 bytes) */
+#define SIO_GPIO_ENABLE		0x30	/* GPIO enable */
+
+#define SIO_LD_GPIO		0x07	/* GPIO logical device */
+#define SIO_UNLOCK_KEY		0x87	/* Key to enable Super-I/O */
+#define SIO_LOCK_KEY		0xAA	/* Key to disable Super-I/O */
+
+#define SIO_ID_MASK		GENMASK(15, 4)
+#define SIO_NCT5104D_ID		0x1061
+#define SIO_NCT6106D_ID		0xC452
+#define SIO_NCT6116D_ID		0xD282
+#define SIO_NCT6122D_ID		0xD2A3
+
+enum chips {
+	nct5104d,
+	nct6106d,
+	nct6116d,
+	nct6122d,
+};
+
+static const char * const nct6116d_names[] = {
+	[nct5104d] = "nct5104d",
+	[nct6106d] = "nct6106d",
+	[nct6116d] = "nct6116d",
+	[nct6122d] = "nct6122d",
+};
+
+struct nct6116d_sio {
+	int addr;
+	enum chips type;
+};
+
+struct nct6116d_gpio_bank {
+	struct gpio_chip chip;
+	unsigned int regbase;
+	struct nct6116d_gpio_data *data;
+};
+
+struct nct6116d_gpio_data {
+	struct nct6116d_sio *sio;
+	int nr_bank;
+	struct nct6116d_gpio_bank *bank;
+};
+
+/*
+ * Super-I/O functions.
+ */
+
+static inline int superio_inb(int base, int reg)
+{
+	outb(reg, base);
+	return inb(base + 1);
+}
+
+static int superio_inw(int base, int reg)
+{
+	int val;
+
+	outb(reg++, base);
+	val = inb(base + 1) << 8;
+	outb(reg, base);
+	val |= inb(base + 1);
+
+	return val;
+}
+
+static inline void superio_outb(int base, int reg, int val)
+{
+	outb(reg, base);
+	outb(val, base + 1);
+}
+
+static inline int superio_enter(int base)
+{
+	/* Don't step on other drivers' I/O space by accident. */
+	if (!request_muxed_region(base, 2, KBUILD_MODNAME)) {
+		pr_err("I/O address 0x%04x already in use\n", base);
+		return -EBUSY;
+	}
+
+	/* According to the datasheet the key must be send twice. */
+	outb(SIO_UNLOCK_KEY, base);
+	outb(SIO_UNLOCK_KEY, base);
+
+	return 0;
+}
+
+static inline void superio_select(int base, int ld)
+{
+	outb(SIO_LDSEL, base);
+	outb(ld, base + 1);
+}
+
+static inline void superio_exit(int base)
+{
+	outb(SIO_LOCK_KEY, base);
+	release_region(base, 2);
+}
+
+/*
+ * GPIO chip.
+ */
+
+#define gpio_dir(base) ((base) + 0)
+#define gpio_data(base) ((base) + 1)
+
+static inline void *nct6116d_to_gpio_bank(struct gpio_chip *chip)
+{
+	return container_of(chip, struct nct6116d_gpio_bank, chip);
+}
+
+static int nct6116d_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	struct nct6116d_gpio_bank *bank = nct6116d_to_gpio_bank(chip);
+	struct nct6116d_sio *sio = bank->data->sio;
+	int err;
+	u8 dir;
+
+	err = superio_enter(sio->addr);
+	if (err)
+		return err;
+	superio_select(sio->addr, SIO_LD_GPIO);
+
+	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
+
+	superio_exit(sio->addr);
+
+	if (dir & 1 << offset)
+		return GPIO_LINE_DIRECTION_OUT;
+
+	return GPIO_LINE_DIRECTION_IN;
+}
+
+static int nct6116d_gpio_direction_in(struct gpio_chip *chip, unsigned int offset)
+{
+	struct nct6116d_gpio_bank *bank = nct6116d_to_gpio_bank(chip);
+	struct nct6116d_sio *sio = bank->data->sio;
+	int err;
+	u8 dir;
+
+	err = superio_enter(sio->addr);
+	if (err)
+		return err;
+	superio_select(sio->addr, SIO_LD_GPIO);
+
+	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
+	dir |= BIT(offset);
+	superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
+
+	superio_exit(sio->addr);
+
+	return 0;
+}
+
+static int nct6116d_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct nct6116d_gpio_bank *bank = nct6116d_to_gpio_bank(chip);
+	struct nct6116d_sio *sio = bank->data->sio;
+	int err;
+	u8 data;
+
+	err = superio_enter(sio->addr);
+	if (err)
+		return err;
+	superio_select(sio->addr, SIO_LD_GPIO);
+
+	data = superio_inb(sio->addr, gpio_data(bank->regbase));
+
+	superio_exit(sio->addr);
+
+	return !!(data & BIT(offset));
+}
+
+static int nct6116d_gpio_direction_out(struct gpio_chip *chip,
+				     unsigned int offset, int value)
+{
+	struct nct6116d_gpio_bank *bank = nct6116d_to_gpio_bank(chip);
+	struct nct6116d_sio *sio = bank->data->sio;
+	u8 dir, data_out;
+	int err;
+
+	err = superio_enter(sio->addr);
+	if (err)
+		return err;
+	superio_select(sio->addr, SIO_LD_GPIO);
+
+	data_out = superio_inb(sio->addr, gpio_data(bank->regbase));
+	if (value)
+		data_out |= BIT(offset);
+	else
+		data_out &= ~BIT(offset);
+	superio_outb(sio->addr, gpio_data(bank->regbase), data_out);
+
+	dir = superio_inb(sio->addr, gpio_dir(bank->regbase));
+	dir &= ~BIT(offset);
+	superio_outb(sio->addr, gpio_dir(bank->regbase), dir);
+
+	superio_exit(sio->addr);
+
+	return 0;
+}
+
+static void nct6116d_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct nct6116d_gpio_bank *bank = nct6116d_to_gpio_bank(chip);
+	struct nct6116d_sio *sio = bank->data->sio;
+	u8 data_out;
+	int err;
+
+	err = superio_enter(sio->addr);
+	if (err)
+		return;
+	superio_select(sio->addr, SIO_LD_GPIO);
+
+	data_out = superio_inb(sio->addr, gpio_data(bank->regbase));
+	if (value)
+		data_out |= BIT(offset);
+	else
+		data_out &= ~BIT(offset);
+	superio_outb(sio->addr, gpio_data(bank->regbase), data_out);
+
+	superio_exit(sio->addr);
+}
+
+#define NCT6116D_GPIO_BANK(_base, _ngpio, _regbase, _label)			\
+	{									\
+		.chip = {							\
+			.label            = _label,				\
+			.owner            = THIS_MODULE,			\
+			.get_direction    = nct6116d_gpio_get_direction,	\
+			.direction_input  = nct6116d_gpio_direction_in,		\
+			.get              = nct6116d_gpio_get,			\
+			.direction_output = nct6116d_gpio_direction_out,	\
+			.set              = nct6116d_gpio_set,			\
+			.base             = _base,				\
+			.ngpio            = _ngpio,				\
+			.can_sleep        = false,				\
+		},								\
+		.regbase = _regbase,						\
+	}
+
+static struct nct6116d_gpio_bank nct6116d_gpio_bank[] = {
+	NCT6116D_GPIO_BANK(0, 8, 0xE0, KBUILD_MODNAME "-0"),
+	NCT6116D_GPIO_BANK(10, 8, 0xE4, KBUILD_MODNAME "-1"),
+	NCT6116D_GPIO_BANK(20, 8, 0xE8, KBUILD_MODNAME "-2"),
+	NCT6116D_GPIO_BANK(30, 8, 0xEC, KBUILD_MODNAME "-3"),
+	NCT6116D_GPIO_BANK(40, 8, 0xF0, KBUILD_MODNAME "-4"),
+};
+
+/*
+ * Platform device and driver.
+ */
+
+static int nct6116d_gpio_probe(struct platform_device *pdev)
+{
+	struct nct6116d_sio *sio = pdev->dev.platform_data;
+	struct nct6116d_gpio_data *data;
+	int err;
+	int i;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->nr_bank = ARRAY_SIZE(nct6116d_gpio_bank);
+	data->bank = nct6116d_gpio_bank;
+	data->sio = sio;
+
+	platform_set_drvdata(pdev, data);
+
+	/* For each GPIO bank, register a GPIO chip. */
+	for (i = 0; i < data->nr_bank; i++) {
+		struct nct6116d_gpio_bank *bank = &data->bank[i];
+
+		bank->chip.parent = &pdev->dev;
+		bank->data = data;
+
+		err = devm_gpiochip_add_data(&pdev->dev, &bank->chip, bank);
+		if (err)
+			return dev_err_probe(&pdev->dev, err,
+				"Failed to register gpiochip %d\n", i);
+	}
+
+	return 0;
+}
+
+static int __init nct6116d_find(int addr, struct nct6116d_sio *sio)
+{
+	u16 devid;
+	int err;
+
+	err = superio_enter(addr);
+	if (err)
+		return err;
+
+	devid = superio_inw(addr, SIO_CHIPID);
+	superio_exit(addr);
+	switch (devid & SIO_ID_MASK) {
+	case SIO_NCT5104D_ID & SIO_ID_MASK:
+		sio->type = nct5104d;
+		break;
+	case SIO_NCT6106D_ID & SIO_ID_MASK:
+		sio->type = nct6106d;
+		break;
+	case SIO_NCT6116D_ID & SIO_ID_MASK:
+		sio->type = nct6116d;
+		break;
+	case SIO_NCT6122D_ID & SIO_ID_MASK:
+		sio->type = nct6122d;
+		break;
+	default:
+		pr_info("Unsupported device 0x%04x\n", devid);
+		return -ENODEV;
+	}
+	sio->addr = addr;
+
+	pr_info("Found %s at 0x%x chip id 0x%04x\n",
+		nct6116d_names[sio->type], addr, devid);
+	return 0;
+}
+
+static struct platform_device *nct6116d_gpio_pdev;
+
+static int __init
+nct6116d_gpio_device_add(const struct nct6116d_sio *sio)
+{
+	int err;
+
+	nct6116d_gpio_pdev = platform_device_alloc(KBUILD_MODNAME, -1);
+	if (!nct6116d_gpio_pdev)
+		return -ENOMEM;
+
+	err = platform_device_add_data(nct6116d_gpio_pdev, sio, sizeof(*sio));
+	if (err) {
+		pr_err("Platform data allocation failed\n");
+		goto err;
+	}
+
+	err = platform_device_add(nct6116d_gpio_pdev);
+	if (err) {
+		pr_err("Device addition failed\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	platform_device_put(nct6116d_gpio_pdev);
+
+	return err;
+}
+
+static struct platform_driver nct6116d_gpio_driver = {
+	.driver = {
+		.name	= KBUILD_MODNAME,
+	},
+	.probe		= nct6116d_gpio_probe,
+};
+
+static int __init nct6116d_gpio_init(void)
+{
+	struct nct6116d_sio sio;
+	int err;
+
+	if (nct6116d_find(0x2e, &sio) &&
+	    nct6116d_find(0x4e, &sio))
+		return -ENODEV;
+
+	err = platform_driver_register(&nct6116d_gpio_driver);
+	if (!err) {
+		err = nct6116d_gpio_device_add(&sio);
+		if (err)
+			platform_driver_unregister(&nct6116d_gpio_driver);
+	}
+
+	return err;
+}
+
+static void __exit nct6116d_gpio_exit(void)
+{
+	platform_device_unregister(nct6116d_gpio_pdev);
+	platform_driver_unregister(&nct6116d_gpio_driver);
+}
+module_init(nct6116d_gpio_init);
+module_exit(nct6116d_gpio_exit);
+
+MODULE_DESCRIPTION("GPIO driver for Nuvoton Super-I/O chips  NCT5104D, NCT6106D, NCT6116D, NCT6122D");
+MODULE_AUTHOR("Tasanakorn Phaipool <tasanakorn@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.35.1

