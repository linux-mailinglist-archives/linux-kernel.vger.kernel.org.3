Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A70472BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 13:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhLMMFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 07:05:32 -0500
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:64578
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232762AbhLMMFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 07:05:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdHp08Tl/OUUPgPYnga9rnP2Ab1jOUDa6o0L9kKFBvFfVXm/iH/wZ4Uqwxe0No5B5Cw4Lo9RiCkbRIc9Rb1tBKiijxAf5DAHlahBTZC0bJ0kQz7mpmwx2jeK8mlUnvaN7PxaqJs4TfV90I1BMq/odSwbYSoYgpvw4Rm48HBzOr8oDc/liPVuTCi0edoahtznuCd4AB3keciyRGGo7uEt9kworgClKjL8LR1wf12DO19Nek1oiIzAFoI4wwqYmmupUlhwA2Hc/9fzkUuCh+4Ok8oZRJWzT0F8xcZ372VuSnvOMtedYvLjCb9pE1DcE3ZlAkDZXhaM7umOURuEOVkMWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpQ6fvDz9lVe6PiNcyGz6TuiPeWGlMMdUgY2zDKz72w=;
 b=ZOK14X5s5fvHcmqdlmx1tBhq2bl5CIf29AunYmNyDS61Kjug5Guw16Iu/zXSj2uU0YYnPgmBAlEnyrcwbWsSmNrqEMb8XOHi9GRkbgb4f4KfD9FcyqXzMQfm9ONU9e5FzqohiuMuqI4PcQAjSq/6cuz8eE2U1CtZnAOw9QpAs+CZVOsCv9LFd1MJ7qy+MOBuRasvekYD8AYPkO8S+lVEyCn6w3WAHd9Oi4rDNfAkMVm1SMDLXaekWqb8zm0gfCsJyJomRO7u0r2SyKHdQxrayzLVMGu7tupkEK3k+pKwmsiSKtcCjjcInLHG1J/8DqBTL6HHtjEb72DAdQzpkyzL2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpQ6fvDz9lVe6PiNcyGz6TuiPeWGlMMdUgY2zDKz72w=;
 b=xqmcSppORVXO+qaJPryses24jIyyZyIjoOjO5JA1rd7Zjr+5Z69jVCkSIUH4TUPC0DxsefA9qZJckMH2FOXgpsfdE7GxoOSCGvN2u7d2rWqW22jn+Q3bzpKzLBzc9+jyGyTtR8E5tdZU9cfJqhVrDzH0I6eC2NzziVQjx5J5wt+gnAPMNzNEquAiDU97Fas2qTlF2bE/+xZ+kSrbKrVMHnpnlgQd2RcajhTdsFk+SEa8V9Yfp86F2HHPdAYdXvqSxpTx+ap9k077vFdzCaMShS5wdwQdWgCVprRZVd8sxov1u5r/5F/egHBr8jli/mu4nvsuVMRf9MR5KloFpWEShw==
Received: from OL1P279CA0038.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::7) by
 VI1PR10MB1552.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:802:31::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.21; Mon, 13 Dec 2021 12:05:14 +0000
Received: from HE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::7a) by OL1P279CA0038.outlook.office365.com
 (2603:10a6:e10:14::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Mon, 13 Dec 2021 12:05:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT018.mail.protection.outlook.com (10.152.0.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.12 via Frontend Transport; Mon, 13 Dec 2021 12:05:14 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 13:05:13 +0100
Received: from md1za8fc.ad001.siemens.net (139.25.69.80) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 13 Dec 2021 13:05:13 +0100
From:   Henning Schild <henning.schild@siemens.com>
To:     <linux-kernel@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-watchdog@vger.kernel.org>
CC:     Srikanth Krishnakar <skrishnakar@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Henning Schild <henning.schild@siemens.com>,
        "Gerd Haeussler" <gerd.haeussler.ext@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Pavel Machek <pavel@ucw.cz>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Enrico Weigelt <lkml@metux.net>
Subject: [PATCH v5 3/4] watchdog: simatic-ipc-wdt: add new driver for Siemens Industrial PCs
Date:   Mon, 13 Dec 2021 13:05:01 +0100
Message-ID: <20211213120502.20661-4-henning.schild@siemens.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211213120502.20661-1-henning.schild@siemens.com>
References: <20211213120502.20661-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.80]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eb814d9-7688-43d1-dbfb-08d9be30d220
X-MS-TrafficTypeDiagnostic: VI1PR10MB1552:EE_
X-Microsoft-Antispam-PRVS: <VI1PR10MB155266893B6A2FC8885F0CC785749@VI1PR10MB1552.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tEEW6IK6BSUKPy/742Z+EpDebhaz13b69bEn8+v/xmr++UMwdHytgipF+x2OCGXV23zG4GCIIF1X2FEEFxg4LYL1ivKotpzMBZjtRYCgkcYPjNNyi2mZOIqBFsFmgONFo/W8/tQ2f3ukp/klGylA5US0P6605gHQP2YFMQIbY1Nj6IWq3snQQ/uManqwovE3Z9qVOrrkrVNbksT4d6dBOXI2tfo3LrYxKIc98dEQc+NCXlNkHNUzj7/5hv1Z00Xg/yeoiXBrG2R0i1S8bA6Vn/uTe2LXY/ACh5iPb0JNfzOSZT0WpOTcqHtP6s6PsoaHsd7923NjU1caPBt8HUtiNHNLgDHl+jfqjS9Mgs4SjlkKlaX9o5+EUTbOr2q5d41d0u/X/eJrhiigKc3Ua2D9OPpnpzkOuRS0RP6HTDc6EQ92P7ipZAOY7IufY7rOvGuOQkHEng7gp1YpDsmOU7tPV8klgYI6avlUPkb3TSOqXA83j3Xxfi2yGMNP5tqR8wFov0b8nxAuFrEnTntbLypKt04SfmtjLggDgrDjRILS6tKpnl6/8rcSIGPiKWkKzcNcQpKofQSlDKtumN6rjJnRjgqveV0iNNZkek2HvxzIcSbs5Lmg5plGo/HVyytlC9FlPWji3DiseuZTl866vwMARoOHa7yoGCLVCdm8V9FpniRHOcd9/H1xQ/X9iVpVNa/RtC2iENc6ILh+B+9FLhZGiFuPdjoLs5c37IRMQGhNUBs=
X-Forefront-Antispam-Report: CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(81166007)(186003)(16526019)(8936002)(4326008)(8676002)(26005)(956004)(44832011)(316002)(5660300002)(82310400004)(82960400001)(47076005)(2616005)(2906002)(70586007)(356005)(336012)(508600001)(70206006)(7416002)(83380400001)(86362001)(1076003)(6666004)(110136005)(54906003)(36756003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 12:05:14.1931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb814d9-7688-43d1-dbfb-08d9be30d220
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT018.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1552
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver adds initial support for several devices from Siemens. It is
based on a platform driver introduced in an earlier commit.

One of the supported machines does access a GPIO pin to enable the
watchdog. Here we poke GPIO memory because pinctrl does not come up.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/Kconfig           |  11 ++
 drivers/watchdog/Makefile          |   1 +
 drivers/watchdog/simatic-ipc-wdt.c | 228 +++++++++++++++++++++++++++++
 3 files changed, 240 insertions(+)
 create mode 100644 drivers/watchdog/simatic-ipc-wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 9d222ba17ec6..1dc86eb1361a 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1589,6 +1589,17 @@ config NIC7018_WDT
 	  To compile this driver as a module, choose M here: the module will be
 	  called nic7018_wdt.
 
+config SIEMENS_SIMATIC_IPC_WDT
+	tristate "Siemens Simatic IPC Watchdog"
+	depends on SIEMENS_SIMATIC_IPC
+	select WATCHDOG_CORE
+	help
+	  This driver adds support for several watchdogs found in Industrial
+	  PCs from Siemens.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called simatic-ipc-wdt.
+
 # M68K Architecture
 
 config M54xx_WATCHDOG
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 2ee97064145b..31b931846e32 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -143,6 +143,7 @@ obj-$(CONFIG_NI903X_WDT) += ni903x_wdt.o
 obj-$(CONFIG_NIC7018_WDT) += nic7018_wdt.o
 obj-$(CONFIG_MLX_WDT) += mlx_wdt.o
 obj-$(CONFIG_KEEMBAY_WATCHDOG) += keembay_wdt.o
+obj-$(CONFIG_SIEMENS_SIMATIC_IPC_WDT) += simatic-ipc-wdt.o
 
 # M68K Architecture
 obj-$(CONFIG_M54xx_WATCHDOG) += m54xx_wdt.o
diff --git a/drivers/watchdog/simatic-ipc-wdt.c b/drivers/watchdog/simatic-ipc-wdt.c
new file mode 100644
index 000000000000..8bac793c63fb
--- /dev/null
+++ b/drivers/watchdog/simatic-ipc-wdt.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Siemens SIMATIC IPC driver for Watchdogs
+ *
+ * Copyright (c) Siemens AG, 2020-2021
+ *
+ * Authors:
+ *  Gerd Haeussler <gerd.haeussler.ext@siemens.com>
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_data/x86/simatic-ipc-base.h>
+#include <linux/platform_device.h>
+#include <linux/sizes.h>
+#include <linux/util_macros.h>
+#include <linux/watchdog.h>
+
+#define WD_ENABLE_IOADR			0x62
+#define WD_TRIGGER_IOADR		0x66
+#define GPIO_COMMUNITY0_PORT_ID		0xaf
+#define PAD_CFG_DW0_GPP_A_23		0x4b8
+#define SAFE_EN_N_427E			0x01
+#define SAFE_EN_N_227E			0x04
+#define WD_ENABLED			0x01
+#define WD_TRIGGERED			0x80
+#define WD_MACROMODE			0x02
+
+#define TIMEOUT_MIN	2
+#define TIMEOUT_DEF	64
+#define TIMEOUT_MAX	64
+
+#define GP_STATUS_REG_227E	0x404D	/* IO PORT for SAFE_EN_N on 227E */
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0000);
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static struct resource gp_status_reg_227e_res =
+	DEFINE_RES_IO_NAMED(GP_STATUS_REG_227E, SZ_1, KBUILD_MODNAME);
+
+static struct resource io_resource_enable =
+	DEFINE_RES_IO_NAMED(WD_ENABLE_IOADR, SZ_1,
+			    KBUILD_MODNAME " WD_ENABLE_IOADR");
+
+static struct resource io_resource_trigger =
+	DEFINE_RES_IO_NAMED(WD_TRIGGER_IOADR, SZ_1,
+			    KBUILD_MODNAME " WD_TRIGGER_IOADR");
+
+/* the actual start will be discovered with pci, 0 is a placeholder */
+static struct resource mem_resource =
+	DEFINE_RES_MEM_NAMED(0, SZ_4, "WD_RESET_BASE_ADR");
+
+static u32 wd_timeout_table[] = {2, 4, 6, 8, 16, 32, 48, 64 };
+static void __iomem *wd_reset_base_addr;
+
+static int wd_start(struct watchdog_device *wdd)
+{
+	outb(inb(WD_ENABLE_IOADR) | WD_ENABLED, WD_ENABLE_IOADR);
+	return 0;
+}
+
+static int wd_stop(struct watchdog_device *wdd)
+{
+	outb(inb(WD_ENABLE_IOADR) & ~WD_ENABLED, WD_ENABLE_IOADR);
+	return 0;
+}
+
+static int wd_ping(struct watchdog_device *wdd)
+{
+	inb(WD_TRIGGER_IOADR);
+	return 0;
+}
+
+static int wd_set_timeout(struct watchdog_device *wdd, unsigned int t)
+{
+	int timeout_idx = find_closest(t, wd_timeout_table,
+				       ARRAY_SIZE(wd_timeout_table));
+
+	outb((inb(WD_ENABLE_IOADR) & 0xc7) | timeout_idx << 3, WD_ENABLE_IOADR);
+	wdd->timeout = wd_timeout_table[timeout_idx];
+	return 0;
+}
+
+static const struct watchdog_info wdt_ident = {
+	.options	= WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING |
+			  WDIOF_SETTIMEOUT,
+	.identity	= KBUILD_MODNAME,
+};
+
+static const struct watchdog_ops wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= wd_start,
+	.stop		= wd_stop,
+	.ping		= wd_ping,
+	.set_timeout	= wd_set_timeout,
+};
+
+static void wd_secondary_enable(u32 wdtmode)
+{
+	u16 resetbit;
+
+	/* set safe_en_n so we are not just WDIOF_ALARMONLY */
+	if (wdtmode == SIMATIC_IPC_DEVICE_227E) {
+		/* enable SAFE_EN_N on GP_STATUS_REG_227E */
+		resetbit = inb(GP_STATUS_REG_227E);
+		outb(resetbit & ~SAFE_EN_N_227E, GP_STATUS_REG_227E);
+	} else {
+		/* enable SAFE_EN_N on PCH D1600 */
+		resetbit = ioread16(wd_reset_base_addr);
+		iowrite16(resetbit & ~SAFE_EN_N_427E, wd_reset_base_addr);
+	}
+}
+
+static int wd_setup(u32 wdtmode)
+{
+	unsigned int bootstatus = 0;
+	int timeout_idx;
+
+	timeout_idx = find_closest(TIMEOUT_DEF, wd_timeout_table,
+				   ARRAY_SIZE(wd_timeout_table));
+
+	if (inb(WD_ENABLE_IOADR) & WD_TRIGGERED)
+		bootstatus |= WDIOF_CARDRESET;
+
+	/* reset alarm bit, set macro mode, and set timeout */
+	outb(WD_TRIGGERED | WD_MACROMODE | timeout_idx << 3, WD_ENABLE_IOADR);
+
+	wd_secondary_enable(wdtmode);
+
+	return bootstatus;
+}
+
+static struct watchdog_device wdd_data = {
+	.info = &wdt_ident,
+	.ops = &wdt_ops,
+	.min_timeout = TIMEOUT_MIN,
+	.max_timeout = TIMEOUT_MAX
+};
+
+static int simatic_ipc_wdt_probe(struct platform_device *pdev)
+{
+	struct simatic_ipc_platform *plat = pdev->dev.platform_data;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+
+	switch (plat->devmode) {
+	case SIMATIC_IPC_DEVICE_227E:
+		if (!devm_request_region(dev, gp_status_reg_227e_res.start,
+					 resource_size(&gp_status_reg_227e_res),
+					 KBUILD_MODNAME)) {
+			dev_err(dev,
+				"Unable to register IO resource at %pR\n",
+				&gp_status_reg_227e_res);
+			return -EBUSY;
+		}
+		fallthrough;
+	case SIMATIC_IPC_DEVICE_427E:
+		wdd_data.parent = dev;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!devm_request_region(dev, io_resource_enable.start,
+				 resource_size(&io_resource_enable),
+				 io_resource_enable.name)) {
+		dev_err(dev,
+			"Unable to register IO resource at %#x\n",
+			WD_ENABLE_IOADR);
+		return -EBUSY;
+	}
+
+	if (!devm_request_region(dev, io_resource_trigger.start,
+				 resource_size(&io_resource_trigger),
+				 io_resource_trigger.name)) {
+		dev_err(dev,
+			"Unable to register IO resource at %#x\n",
+			WD_TRIGGER_IOADR);
+		return -EBUSY;
+	}
+
+	if (plat->devmode == SIMATIC_IPC_DEVICE_427E) {
+		res = &mem_resource;
+
+		/* get GPIO base from PCI */
+		res->start = simatic_ipc_get_membase0(PCI_DEVFN(0x1f, 1));
+		if (res->start == 0)
+			return -ENODEV;
+
+		/* do the final address calculation */
+		res->start = res->start + (GPIO_COMMUNITY0_PORT_ID << 16) +
+			     PAD_CFG_DW0_GPP_A_23;
+		res->end += res->start;
+
+		wd_reset_base_addr = devm_ioremap_resource(dev, res);
+		if (IS_ERR(wd_reset_base_addr))
+			return PTR_ERR(wd_reset_base_addr);
+	}
+
+	wdd_data.bootstatus = wd_setup(plat->devmode);
+	if (wdd_data.bootstatus)
+		dev_warn(dev, "last reboot caused by watchdog reset\n");
+
+	watchdog_set_nowayout(&wdd_data, nowayout);
+	watchdog_stop_on_reboot(&wdd_data);
+	return devm_watchdog_register_device(dev, &wdd_data);
+}
+
+static struct platform_driver simatic_ipc_wdt_driver = {
+	.probe = simatic_ipc_wdt_probe,
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+};
+
+module_platform_driver(simatic_ipc_wdt_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" KBUILD_MODNAME);
+MODULE_AUTHOR("Gerd Haeussler <gerd.haeussler.ext@siemens.com>");
-- 
2.32.0

