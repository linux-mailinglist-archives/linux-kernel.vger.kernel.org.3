Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990D6565681
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 15:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiGDNGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 09:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbiGDNGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 09:06:39 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140057.outbound.protection.outlook.com [40.107.14.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B75DE8C;
        Mon,  4 Jul 2022 06:06:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zur1OxX0x0d4xW9I9fHmRiQYwU9ep/GqUItTvTy9S1G6CZ97IEgqlh2MicFQEmh+0XbEBJCxuXwVUUV7uxDnxYwcr7z/9RvtWivRoD2dPHya1XgFUgn0yA+l9WuxEkkhkd4gzMYN7bRRZXs4ki8s4mn7CMtOf/i6ECF41VJFLq+hzxVgc2BwR4xMd5GkBSHKafQowhYB1OhaPkTlbxOllqGXkA8hgp5l4/QSPkGtl1j6Imh4DgSoQkdsNAiu5amQxiTq0KOFWIQFsmZ0x+87DyWAns99dVJ71Nza6WygzsSAWcBXyRRB0IEWDTcdjC5xXEl52QNipiOdjnNtK70aeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DAaIzGC67tFhDB4HLwbZTUvf7J8jw3lE7xv8HeyLGw=;
 b=QU94JBoZpJLQcVQi4obJDUVNF4MtT5pMIa3Q48lkoNPtY//495W3gaF/A93Nd8Vd2NpAmfXtdiB9DBwgGD38FpB/XQolJ0k2K3MfqY+pfCPuty5XbsLmkrCIceNiH35Ux1Gujluf2NSRSkHr2O78S6E1o6SBDcnCj3XvBHI5x1FgWIO+yqeIh7C5HUs6AqT6Abc/Qa0MqJ8LXDAh8D/Etc0p34pOFDTXgSTPQAPZbwRHGMNTQCmcpZAAAwGPKvucky0BTATMsXHruOfVsJm3GSSDYyq/WL46ntPCRFllz10BKdglgGBjJNfbS2GoM9GneTQIO9Rdbr/blDzAEieXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DAaIzGC67tFhDB4HLwbZTUvf7J8jw3lE7xv8HeyLGw=;
 b=eWh60KenK7UQQSLWwdGZeVtMwWK6sQZSEBHd4nDE0SMdZRLedwJsXaE4Dk19mee8/34qfd2+bVRJuy0pFx5aTCUEXI9m69Te205mu7B7N6OrviULljX5WlU9rknM8DzZziDeqrxAqMhi2tH0AFFZqB4fF4WE4QdF/WU6D5g4ClQY/wzk3HmIQC5CaSIPi/K9qwnGcrwTRyoj7KTP5BVaUIsUmXbKxXWf+ULy06rmdsAUF9ZbSYBzPzpaEr4krAdFwPR6ic5eKNQRhiM3o1apTmFDbaMgJJk2PIj49JqAsHHdTQgMDSBrVrIyrE5jyGQsbMgyDTSsDUVDWITA0SMN9A==
Received: from DU2PR04CA0228.eurprd04.prod.outlook.com (2603:10a6:10:2b1::23)
 by PA4PR10MB4573.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Mon, 4 Jul
 2022 13:06:29 +0000
Received: from DB5EUR01FT071.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:2b1:cafe::61) by DU2PR04CA0228.outlook.office365.com
 (2603:10a6:10:2b1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20 via Frontend
 Transport; Mon, 4 Jul 2022 13:06:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT071.mail.protection.outlook.com (10.152.5.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Mon, 4 Jul 2022 13:06:29 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 4 Jul 2022 15:06:28 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.69.161) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 4 Jul 2022 15:06:26 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
CC:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 1/1] gpio: nct6116d: add new driver for several Nuvoton super io chips
Date:   Mon, 4 Jul 2022 15:06:02 +0200
Message-ID: <20220704130602.12307-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220704130602.12307-1-henning.schild@siemens.com>
References: <20220704130602.12307-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.161]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--6.861300-8.000000
X-TMASE-MatchedRID: WFZVepIZlH4Td+SwcuWgWpcVPxYm2n8n6RGSI6KP9StdDcY5R0jT7uWb
        lHcaqvkONJUb9GR1a9nbJMbTT9K/TXjn0UTTDjfNujKSZWxviTfyNWG6Utfmrz8Ckw9b/GFeVBD
        QSDMig9HHkH7uosEn7JygeQq7W7Vvb1ikoVTeiwksTrWjnK6DICU+pleMQkmW9Ib/6w+1lWQpA2
        ExuipmWnmt2QvNwWXIsLNr5Tqhtfhdt1GhWjT3vHXMS4iGnHBcAjH7Fy71g+j27WtDgGBc8jMDH
        wdijHSHnhD4vcFcha7nsljC0VX9i5lMi9fe34dC1Fm0yAuBs33npeSiZTablcK1Ib9JAALx4F58
        RPNYsrGOSVCvVHWJJ1vD20hrIljlb7vhAFDgsdMr+xJSuR69oP8HOAZkrPDd4jnQTqD4CzQ7IFM
        OvFEK2D2mEJylgvfBdkk6onL8WMwKdXqDD6jyTQNezODO/fMltSL5F1ev9k7fSQNpZkETVDh4ai
        F3uCM26D4JsB5geK1/o74UQlCmAH2dcFgFzv71EtRm78gcrDFNUB+j1JNgw7rbxxduc6FPF430d
        3dMHka8vWYAnj0K56PFjJEFr+olwXCBO/GKkVqOhzOa6g8Krd0lC2O5W3Z57MkVJH7z3wcss32k
        5fIeMtuIiOUH/rtIGHGSiZkyd3s=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.861300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: E21E5917EEC891F2FB0E072CDAA24DA1AE0AB9A1F91CED3B33BB748256457D4C2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80e03171-b2e9-4380-1919-08da5dbe0264
X-MS-TrafficTypeDiagnostic: PA4PR10MB4573:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x2Ih1XRbTbU0wuaznd+BMxDcww2GNTjIxUFyr+9DnUeVQ6NrLQvsTVFBOppcnbYkggJnT7pe02BRcX+DBmG70Gt4/CngfTCK+55itAd56fYbVRG/6ZHeOqCgV7oSR5DALDT7hr5rA6UA96awUUpwbwguuuj+bl/IGkloK4varwSa7fBHwn9mi7FqbIU0uANNib1hWuBLceEPIM/Mbh/4aDfy0Rh1kigbx9S6QNmPvd/oMPBK+B2KahqBY37TSZiprCcMZgHlXuO47o3Ix0rSvLuQvhaE0ZM/azxIMUG8m0VDoWipJRhYCdirN0hoDvispxeveCwQ7aFADKhyKvwhEpJTAK3p3XcRO3NVMDoXSWZYtoVEDN9kO1676QViqzoZjKTjBUVFhbhCCXLRn7NpwxhPfCZyUTNKWD16t1C2GBt+p4y4o3m3b15narGIsiMvoWh8yNf79EEhQNhq0iBkKRKVIb7KxrTTuURALZMOdpp/jceGG3YTnFtCF0glY+Bhfmkdves2/Tm5R5OHdMqhAu6RyYIYfzWmcwk44o39xjnJkT9r6tOtp5Te1L55GXnrENRq+JJzqxQoEV4Qu3ZhQ6uN1HywoT8dL3/jrxHV1ONk0K3FZ3w5t4exYwZTge8mGZGcnIVbFkULntoF5dyRA0TbbAiZKVYZzSrH4DlmDEwDC2KXf+GBlXLhIXC0vGlg4TRJPWtcyS3hKiOGlYYGPKRrmCDWwiOHTBPtmDlc6cwXTrQxLFOiTECl73Tv8SR4rPMwKdyLDsQF6josAVcW2R+ClbjEgtPhpKT7NE/+7J6cGi7UjCUrzIX5c0uuYHmL
X-Forefront-Antispam-Report: CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(346002)(40470700004)(46966006)(36840700001)(82310400005)(16526019)(336012)(186003)(1076003)(47076005)(107886003)(83380400001)(82960400001)(40460700003)(36860700001)(7636003)(7596003)(82740400003)(356005)(6666004)(40480700001)(41300700001)(36756003)(2906002)(70586007)(70206006)(316002)(110136005)(478600001)(44832011)(54906003)(956004)(2616005)(8676002)(4326008)(26005)(5660300002)(8936002)(86362001)(30864003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 13:06:29.0886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e03171-b2e9-4380-1919-08da5dbe0264
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT071.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4573
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
index b01961999ced..40f1494b1adc 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -457,6 +457,15 @@ config GPIO_MXS
 	select GPIO_GENERIC
 	select GENERIC_IRQ_CHIP
 
+config GPIO_NCT6116D
+	tristate "Nuvoton Super-I/O GPIO support"
+	help
+	  This option enables support for GPIOs found on Nuvoton Super-I/O
+	  chips NCT5104D, NCT6106D, NCT6116D, NCT6122D.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called gpio-nct6116d.
+
 config GPIO_OCTEON
 	tristate "Cavium OCTEON GPIO"
 	depends on CAVIUM_OCTEON_SOC
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
index 000000000000..6c277636c773
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
+subsys_initcall(nct6116d_gpio_init);
+
+static void __exit nct6116d_gpio_exit(void)
+{
+	platform_device_unregister(nct6116d_gpio_pdev);
+	platform_driver_unregister(&nct6116d_gpio_driver);
+}
+module_exit(nct6116d_gpio_exit);
+
+MODULE_DESCRIPTION("GPIO driver for Nuvoton Super-I/O chips  NCT5104D, NCT6106D, NCT6116D, NCT6122D");
+MODULE_AUTHOR("Tasanakorn Phaipool <tasanakorn@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.35.1

