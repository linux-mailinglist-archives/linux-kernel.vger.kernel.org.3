Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2F1562FA0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbiGAJOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbiGAJOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:14:33 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10044.outbound.protection.outlook.com [40.107.1.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511EF43389;
        Fri,  1 Jul 2022 02:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMLzbbwWClFlS4bHOiQDc7PAco6WUofnH5IvYBeFj+F54sv65JYfiQOEMp4sSaxO94XiCKj9tGuRIf+Dj+iHfQbZHBIzR8RTNVYGZbeyz6gTfbljmqITC7DOEw8EvIcpM/iFy9k36A3t8/La+mhlmlmmYkoozG9S0wfrrWjhy7Zzgxrk3XSKJ3Bw/zMOn1Smc9Klx63cNOcORKjB3vVFmCWg19Angaw6H5cLT84UY2X/Cbtr6hXUAI4V4XvEYWUE8dszz8NBm3hz1LX0idoV0x8OAXzG1ot+SVQpqJU3GogPrLJwFgsYB3tVkj0ieu7OyDxJmOLKkcycQlS5CwUUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYj7JtrWkc8Q4jb0zoxWV1LptxEyv7AIX5m3zZA7VXI=;
 b=jcnVMsMMmXjjI2ZSMyKmAB39he8frkxI42y5PGCxihZSGeu5z5oiXiYnPkRmA5T/YK7VUvL86b80kegaVgCDmmO9xRkh0u+lgVh6COMfFY05XZNn1zv2VmivxSiIe6PAHLnooSMrELexePH15PDfe+NnnIEEjmZOzaUcaFU4YnuYwo84CENGsdls6jjYzF9/CAoT6+65XzmYWxzxbz7lHVqxPS9qbCnSyBfrvXi9/8XzzsPN4tbuKw0Cb1oi5lnwmw9CGWq5iHjgIAraAT66PF1sR96sERrLRKAU6WBI3IaX5UD1JKQ7nrtCcz0R54Z9N7NPFSNyLWSW8+hrqaz/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYj7JtrWkc8Q4jb0zoxWV1LptxEyv7AIX5m3zZA7VXI=;
 b=NGxUwTCSxMhQkJqwD7WgS6NOLx4t1fZrds3YDk8qpBG2FrBLlvQ7gkzkpJFqeoDY9AxF35qSjJK5ujCom9MKlBHTopTc3kEw9pLfazayiCXsW6FdIL33lJIZMzG62CNIzoeIOhS3kL0SrGEvNwTTlzfFIf9qMGpQkIjKe9Vmok5p7xrrfser1lSAlrk1yYmf2pBGhlNIGvLmnn3RSdIymTUFWUAyeWwvFSKrjhZH62AmKo6FJNvkzIX0Yme4bvxCfCCs45H9ju1ld1pglxIcyVuWOlcc/c/WzkEgefcvtDKZqZSzk7HxIbzlWa+yMfPgSTFJ1PoHplOvtAmsk8w/PA==
Received: from OL1P279CA0001.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::6) by
 DB8PR10MB3084.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:e7::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Fri, 1 Jul 2022 09:14:28 +0000
Received: from HE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::7f) by OL1P279CA0001.outlook.office365.com
 (2603:10a6:e10:12::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Fri, 1 Jul 2022 09:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT031.mail.protection.outlook.com (10.152.0.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Fri, 1 Jul 2022 09:14:27 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 1 Jul 2022 11:14:25 +0200
Received: from md1za8fc.ad001.siemens.net (139.25.68.241) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Fri, 1 Jul 2022 11:14:25 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tasanakorn Phaipool <tasanakorn@gmail.com>
CC:     Sheng-Yuan Huang <syhuang3@nuvoton.com>,
        Kuan-Wei Ho <cwho@nuvoton.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH 1/1] gpio: nct6116d: add new driver for several Nuvoton super io chips
Date:   Fri, 1 Jul 2022 11:14:12 +0200
Message-ID: <20220701091412.20718-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220701091412.20718-1-henning.schild@siemens.com>
References: <20220701091412.20718-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.68.241]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--6.861300-8.000000
X-TMASE-MatchedRID: WFZVepIZlH4Td+SwcuWgWpcVPxYm2n8n6RGSI6KP9StdDcY5R0jT7pq7
        DiIZuJv4Yy6fApvL8Bd+Nx1ftYxL8HfkN25JCr1q01CTCPwQxklSBYLp/taMcQPZZctd3P4BAZn
        /4A9db2Qju8aQamG8GJygeQq7W7Vvb1ikoVTeiwksTrWjnK6DICU+pleMQkmW9Ib/6w+1lWQpA2
        ExuipmWnmt2QvNwWXIsLNr5Tqhtfhdt1GhWjT3vHXMS4iGnHBcAjH7Fy71g+j27WtDgGBc8jMDH
        wdijHSHnhD4vcFcha7nsljC0VX9i5lMi9fe34dC1Fm0yAuBs33npeSiZTablcK1Ib9JAALx4F58
        RPNYsrGOSVCvVHWJJ1vD20hrIljlb7vhAFDgsdMr+xJSuR69oP8HOAZkrPDd4jnQTqD4CzQ7IFM
        OvFEK2D2mEJylgvfBdkk6onL8WMwKdXqDD6jyTQNezODO/fMltSL5F1ev9k7fSQNpZkETVDh4ai
        F3uCM26D4JsB5geK1/o74UQlCmAH2dcFgFzv71EtRm78gcrDFNUB+j1JNgw7rbxxduc6FPF430d
        3dMHka8vWYAnj0K56PFjJEFr+olwXCBO/GKkVqOhzOa6g8KrRaiTHcGU0MvfEYL3p7S8bmVuqzZ
        w+JQaUBlDGt3nrbxTqcIKpe4okc=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--6.861300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 00E216506F3F477AE9CA9B49336E6E3E8B1D3B012BDDD0A884F4704096AB24742000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 649fc9e2-90e4-4f85-053d-08da5b42197b
X-MS-TrafficTypeDiagnostic: DB8PR10MB3084:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DNHrVSmfwKRYVP6IYgf15tre4S3r1p70qdWrIYXs0QZpbd3+k2k3xr26Y6C2CbC/UM1HQPKIX++Bt8RgSMrGRwiB1ZXQ8py2I0A3/4UcODhR6ZPXB+ZGTziuBEFUTsxmHo26vVKTreQ2CCWQ81JNUG5Pr9OFE9jfB3ZpyfHGjJAnvVFe3t+4ielIFbqID8A9p2yUjM3G4g0p+VKcIX6f/xxu0e8ewsCvPMqbSPoZd+X5+Ew7XhIaH3KrgfEstlbi8ldrdgehjgTQvk4GjG0V8w5qqez1evXi6ysX9zyEgNun1IpMZXIkzErb9kYDpftFj+t06Hm70QGUpBY9LSk1qHeBI/fHK38dilEr3JojFjIAE1ODzZOzQIS9OmhO9WaQHE3V6mFdnbcAIj+r4mIyCvZpTCrjzJ3YDYzHdB07JQCsxbPOjKOj2AKDMFREf6/M1p7f4dB4ARWEXu2TzNg+nSs4Usv00eJDYT7EZqoBrfzBGgRuQpQ35WHSzMzGGGB6/d5sCM6lkac6liym+nvyNrjZ52w15MHb0XU21i6UxMR27RNC402yjB4LMjZIvIkzUxk3j0dKMefBBzpZpPtJFy5MfYA/SnsP/PUVFITQWnzLX/hZpGBSyXsMS1Dwqq4uGXeNTxieO2lTzQe6EBR9WJ0S8HJAylWDnUuOV+0u8WYG8VZqfnuEJgS1qsz6QX6nSW7H0Db0SVHlumlFX6PTsz9vZsHLPACenHvG1WzA6SBwYlXq797xOAGFKKQDRmwIZiX1bT+DYwGBSVtVGs71Zimh4HBwmI9nXbrOL+OtlDdeBFoNNvXhqgV+dCsD8EiyRiuZnRhWAIrGz9Sj3Zd0qUk5khwW1nqiF27HShAYIRQ=
X-Forefront-Antispam-Report: CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(376002)(46966006)(40470700004)(36840700001)(8676002)(4326008)(36756003)(316002)(110136005)(44832011)(54906003)(36860700001)(82310400005)(83380400001)(70206006)(70586007)(478600001)(2906002)(8936002)(41300700001)(30864003)(6666004)(107886003)(5660300002)(1076003)(2616005)(956004)(336012)(47076005)(16526019)(26005)(186003)(86362001)(82960400001)(356005)(82740400003)(40480700001)(81166007)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 09:14:27.9027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 649fc9e2-90e4-4f85-053d-08da5b42197b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3084
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds gpio support for several Nuvoton NCTXXX chips. These super
io chips offer multiple functions of which several already have drivers in
the kernel, i.e. hwmon and wdt.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/gpio/Kconfig         |   9 +
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-nct6116d.c | 401 +++++++++++++++++++++++++++++++++++
 3 files changed, 411 insertions(+)
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
index 000000000000..bef2121da991
--- /dev/null
+++ b/drivers/gpio/gpio-nct6116d.c
@@ -0,0 +1,401 @@
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
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/gpio/driver.h>
+
+#define DRVNAME "gpio-nct6116d"
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
+#define SIO_ID_MASK		0xFFF0
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
+	"nct5104d",
+	"nct6106d",
+	"nct6116d",
+	"nct6122d",
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
+	if (!request_muxed_region(base, 2, DRVNAME)) {
+		pr_err(DRVNAME "I/O address 0x%04x already in use\n", base);
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
+static int nct6116d_gpio_direction_in(struct gpio_chip *chip, unsigned int offset);
+static int nct6116d_gpio_get(struct gpio_chip *chip, unsigned int offset);
+static int nct6116d_gpio_direction_out(struct gpio_chip *chip,
+				     unsigned int offset, int value);
+static void nct6116d_gpio_set(struct gpio_chip *chip, unsigned int offset, int value);
+
+#define NCT6116D_GPIO_BANK(_base, _ngpio, _regbase, _label)			\
+	{								\
+		.chip = {						\
+			.label            = _label,			\
+			.owner            = THIS_MODULE,		\
+			.direction_input  = nct6116d_gpio_direction_in,	\
+			.get              = nct6116d_gpio_get,		\
+			.direction_output = nct6116d_gpio_direction_out,	\
+			.set              = nct6116d_gpio_set,		\
+			.base             = _base,			\
+			.ngpio            = _ngpio,			\
+			.can_sleep        = false,			\
+		},							\
+		.regbase = _regbase,					\
+	}
+
+#define gpio_dir(base) ((base) + 0)
+#define gpio_data(base) ((base) + 1)
+
+static struct nct6116d_gpio_bank nct6116d_gpio_bank[] = {
+	NCT6116D_GPIO_BANK(0, 8, 0xE0, DRVNAME "-0"),
+	NCT6116D_GPIO_BANK(10, 8, 0xE4, DRVNAME "-1"),
+	NCT6116D_GPIO_BANK(20, 8, 0xE8, DRVNAME "-2"),
+	NCT6116D_GPIO_BANK(30, 8, 0xEC, DRVNAME "-3"),
+	NCT6116D_GPIO_BANK(40, 8, 0xF0, DRVNAME "-4"),
+};
+
+static int nct6116d_gpio_direction_in(struct gpio_chip *chip, unsigned int offset)
+{
+	int err;
+	struct nct6116d_gpio_bank *bank =
+		container_of(chip, struct nct6116d_gpio_bank, chip);
+	struct nct6116d_sio *sio = bank->data->sio;
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
+	int err;
+	struct nct6116d_gpio_bank *bank =
+		container_of(chip, struct nct6116d_gpio_bank, chip);
+	struct nct6116d_sio *sio = bank->data->sio;
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
+	int err;
+	struct nct6116d_gpio_bank *bank =
+		container_of(chip, struct nct6116d_gpio_bank, chip);
+	struct nct6116d_sio *sio = bank->data->sio;
+	u8 dir, data_out;
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
+	int err;
+	struct nct6116d_gpio_bank *bank =
+		container_of(chip, struct nct6116d_gpio_bank, chip);
+	struct nct6116d_sio *sio = bank->data->sio;
+	u8 data_out;
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
+/*
+ * Platform device and driver.
+ */
+
+static int nct6116d_gpio_probe(struct platform_device *pdev)
+{
+	int err;
+	int i;
+	struct nct6116d_sio *sio = pdev->dev.platform_data;
+	struct nct6116d_gpio_data *data;
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
+		if (err) {
+			dev_err(&pdev->dev,
+				"Failed to register gpiochip %d: %d\n",
+				i, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int __init nct6116d_find(int addr, struct nct6116d_sio *sio)
+{
+	int err;
+	u16 devid;
+
+	err = superio_enter(addr);
+	if (err)
+		return err;
+
+	devid = superio_inw(addr, SIO_CHIPID);
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
+		pr_info(DRVNAME ": Unsupported device 0x%04x\n", devid);
+		superio_exit(addr);
+		return -ENODEV;
+	}
+	sio->addr = addr;
+
+	pr_info(DRVNAME ": Found %s at %#x chip id 0x%04x\n",
+			nct6116d_names[sio->type],
+			(unsigned int)addr,
+			devid);
+
+	superio_exit(addr);
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
+	nct6116d_gpio_pdev = platform_device_alloc(DRVNAME, -1);
+	if (!nct6116d_gpio_pdev)
+		return -ENOMEM;
+
+	err = platform_device_add_data(nct6116d_gpio_pdev, sio, sizeof(*sio));
+	if (err) {
+		pr_err(DRVNAME "Platform data allocation failed\n");
+		goto err;
+	}
+
+	err = platform_device_add(nct6116d_gpio_pdev);
+	if (err) {
+		pr_err(DRVNAME "Device addition failed\n");
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
+		.name	= DRVNAME,
+	},
+	.probe		= nct6116d_gpio_probe,
+};
+
+static int __init nct6116d_gpio_init(void)
+{
+	int err;
+	struct nct6116d_sio sio;
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

