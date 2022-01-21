Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA33495E58
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380185AbiAULXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:23:06 -0500
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:53830
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1380132AbiAULW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:22:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkyb7ZEEDBjIwse2BXokWso28lLp+tixBSZS2LLvhm30El0ainHsGnnSdVzeC3QMuVtVxWO/VjAqJz9JPR19+cfQUjId/hegmQV5NqaBKvVMPM+KJkjT2n+YEULXyQ9APWu4XVMem6PKBNKWR/pSISD+86Gphlx4gCy0t50GKL4QRjp7Gl6241RsJ4T6FMwGPH5A6ezDi6kGNRdWLczCOZ1BOb9DUJReIFTXolpLqzUYTkxpXy+P9N7MoCIlIXlCNbjrV5DEyArCcUYI6eNMFXlC+bc4ZKosoy9o0l2eTlRHvJbgbHGO6WfQJwwE6SgAvRdEOEd2sS0u0f8mvvuKkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYEpV3PKUC+e2MeZlO5Rad/2xQP28AwkpnTx2FN8Tiw=;
 b=gpaAva7H5SGOySWYF6w4AAemnpKO7On+zrC6vy06QJNudOWEZdmFjSwxoHkfF+xCVm2rUq7sIUFAAvP6wn8avT6VokpXY+w9/w35FmiwV+yt5Lzss0ov5bsyOVylHzBSOScM2tHhxqxAWhWJ54NT6yUa0BIkZL4KQs/X8grQwsVDt9GIx1z6lzAtBWL2DMyXi+5auy0j4VNqkaV6cIAg1DauEX6Z9WwviNhK1d9HGCspL4PnCrhpgYzoy65mES9K+S9nMtiZO2Y32MY+wrrCFjoNjW3f5EfiMnJkVQPDV6tG37BP/95yKzSKuegPOO4Mvs/rT4gv32dLsq/9b1zM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYEpV3PKUC+e2MeZlO5Rad/2xQP28AwkpnTx2FN8Tiw=;
 b=qIEVwtWsxhwlY34ppUImwzKdle+aZVvC9ns0MMQCl7AR9EA8VE7DSedTld1uxNjDGqtl7tW7Z0e6GI8nAo+KoDJHcS7F691RR7U1+sMgEJ96mzAeXsCsK0M0b5sNEWzhIY1LWAsp0a7zE47o6DPw2nEuD20OIaJc+khjiVyHp3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DB8PR04MB6731.eurprd04.prod.outlook.com (2603:10a6:10:104::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Fri, 21 Jan
 2022 11:22:53 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7%6]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 11:22:52 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC 1/3] soc: imx: make i.MX8MM BLK CTRL a separate driver
Date:   Fri, 21 Jan 2022 13:22:36 +0200
Message-Id: <20220121112238.47281-2-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220121112238.47281-1-abel.vesa@nxp.com>
References: <20220121112238.47281-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0238.eurprd08.prod.outlook.com
 (2603:10a6:802:15::47) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76d61ce4-d52e-445e-e35e-08d9dcd05d29
X-MS-TrafficTypeDiagnostic: DB8PR04MB6731:EE_
X-Microsoft-Antispam-PRVS: <DB8PR04MB67314CE93B38D8BBCFFE5E07F65B9@DB8PR04MB6731.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8dywfOXi4O+y4pTUNhKkNVKecAUDx5R2BykRsYu5hH/pOsiJiR9Ne3Zvvm38Wk5eLjP5Ed7XRVFRfEYDmzzwXbf1Ec4Q0GZy5/9WBJCVJnTSnfdDVOr1os50sp3+Rl8Ij+gLPRulTYTMTKn8Om+47O+0ZWh3wzWWOxk3yOdAn6yx1JEr/0y5hqfRqFVHvyZxKv5jZou+Eh9uG07RYsg06J/rVZNIZbul5w53lrfth5MuSylkr8Jx8BtM2Dyb1PPT4zVhCOgZeq/LEzqYHPgFCcXLDcqAhXQqCWRcLNpHS03X5al6Oh1psz8QsYetYkrcN70h9G20/fg8MiCWS0EvTwv7RI66k5yfZcFoCtNJd4V7IheUOiIQeueMOc1VNk87uQpeNIG56+SR56uZfVdlya2s7LmFQ2VtlQvFwjiydkJVRapDsHsaZTMbFxkmsU8o16vPxm/qtOrzqHrqYAtLz96653rH5oR35+pn0ga9RpwjVjGJ0OyX3GTc5gr+2PMSUsuUu/9fhNDM4kybuSp2CSYWlVS9hRsfLxLuMWzky1ywXRKlUS0v6GZp9FXImpuiHhXsY+r4wSGNdyaTbE2socPkYZF3ztJFjPvjS7/nqYO2p2jBKyX5GI9XMyzOwsJgXrz5GVYhxkjuach8jxBRAewMiRD/QH37hX5XemGjPVoA+p2fRnelJa6Ip6rppcGsj/sSav9+/nBF+nzV9dHSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(38350700002)(52116002)(2616005)(8676002)(6512007)(1076003)(6666004)(316002)(110136005)(54906003)(86362001)(6506007)(30864003)(6486002)(66946007)(5660300002)(4326008)(66556008)(66476007)(8936002)(36756003)(44832011)(83380400001)(2906002)(186003)(26005)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6F5h2/CF3iWQcDvw41oqRq/hlOyOxFqKZY5eU6RKX1STRDacvaxLbWXeG+vo?=
 =?us-ascii?Q?uWulx0J4yz7izFBqE4vgcgEZL95xYwPdurvLb5aVcbBMVq80l2y2cc0nxaLC?=
 =?us-ascii?Q?FDoAyCXSLJ06VmTLTM6qRPJxVfD38EG3+r2BGz9ssB08+syB6IsgQB/r92BJ?=
 =?us-ascii?Q?TSCnC1sCiW5Y0RdrmjqrTX4jw3ikNGj5HcQLVZFbygCGWL0HRKPJKsCaipEU?=
 =?us-ascii?Q?TJnOvEI5vzUVzZ/UhmMQhnwie35LFRqU9uyK+2taRXda+XznpOPw6XwzzNqq?=
 =?us-ascii?Q?/mBQTeH3zHqNRzb8cAFFSpawAmC6B8Gzz6I0mOAo2+3N9te0Dx6QWT0fXSTF?=
 =?us-ascii?Q?sxRqDhmla6o0jFr+lElnLhutmSrfUt+24E6U1X5ztlryYuUwBE+Nep9+1Egn?=
 =?us-ascii?Q?yTuaME0Qv6eQ4gGZ/eYVky20ZzY1Ov5e0qTDa/0HYV1Kv3CwTzcHh32OynuA?=
 =?us-ascii?Q?pAV5IcrK6RtuLpkMRjqGMyuVz4p2eualQI/AsLTceHL9XDsLUIwZixgILxrt?=
 =?us-ascii?Q?gsjVAskN0+W4xpzAVlCZwO0/1c3UmjbIY45JmRuHkNeFPc9C4Fv7WUBziXVw?=
 =?us-ascii?Q?8jZszeDMbJ+fc82m2HT8Y6588hCLOX3YtFkvPt6JeywTpfw0QGOo5vh3e3rU?=
 =?us-ascii?Q?XtUfYoPhO2ww9LmJYAdhW+K5oSeJhx2b2Dai5M10GAoLxKhpw7TFkxeJlRxj?=
 =?us-ascii?Q?HMOqf/Uap+HFmVA26KHmWlvoduaFkFlpf5H4dB2WGcRliuw3ATwH6/mkKnuo?=
 =?us-ascii?Q?UpqtZfrEflNKnxdgkGpBHD1sKjEq7bmW+DIcb4TKwM0iUN/cAU682UMeWRWt?=
 =?us-ascii?Q?F81YE1tO8phGPvT4sT/UUSOKbRR+pbIXGUgkbnO/zw7D9x6YXATd8CNYghWs?=
 =?us-ascii?Q?gkQ0OITOz3Qd3b+qszyBgdYfX8zdWrU1gXSF1dqsIN+stkoSTh5kDgY1bnM9?=
 =?us-ascii?Q?lsXk/bXphPWUi5gOgVvyvM3n1rXw1r7A7VuCAGFEJNqjUsq9JT1PgbguKNL5?=
 =?us-ascii?Q?vlV7JSN2zWwzPVF8U7VLkfMsr0g8MI8P/0PQH0TCe+4xOygkUoZfs0TEKrpI?=
 =?us-ascii?Q?NNatsorFwUAETex82tXA44+ZGyIFDknSsid12Oj11drl7kayjveZ3rf1zXiw?=
 =?us-ascii?Q?AIUq/KuW06DduzmRJ5ycpdOAAJpfS3ME5Nqxf0OjW0cH8rFLJb7T9CG0AvKb?=
 =?us-ascii?Q?/bL4OOVe8y2BbqZeMjVKkYJd7blYymdxGGS4b1fXtIhCVB5GLSBl/9QGt7V0?=
 =?us-ascii?Q?jv1LtqLxfM7RyjZrehteiIH/CMr0l5CeoLkTwQVMvMa2aJb6yPb3XLsD7a/i?=
 =?us-ascii?Q?ceTKPFZwZzdS4BnxIVUp0WOVoGjt0fdNZy36JOoJpF1ua1jgnMhOrrfafROA?=
 =?us-ascii?Q?0/mFFrRre5YvvZ+yc6UNWthJeJqedxTmk8j7tU0lLrcduEYgtEdkVyxkDwbi?=
 =?us-ascii?Q?hAMUMnak7naAdK+pIigLDuSUYS6cugsqaPPDwRdTa+Mj66LSJo65E3Aoe/ac?=
 =?us-ascii?Q?fpr+0bgR8hz6pp1c8bglrj4NhiiCYQdojedrx++dONCCiRDSH+9MoYHffrEv?=
 =?us-ascii?Q?NV+i4evpFF/cLqP0ilr+S54u+5T+X6gk/XTHmkr98SXM2e2F8Ud+g0aoYB6b?=
 =?us-ascii?Q?DUNYc3DZc5lyGvd83+G/tY8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d61ce4-d52e-445e-e35e-08d9dcd05d29
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 11:22:52.5220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: shEX1/xgRdQnlyq87+F+yojnMOUMuYpL4QpjEBiy8mq/F2nTFXmB3W9Klu31cMR9O4j5s+Cjtw2iMK321/18ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6731
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx8m-blk-ctrl driver was increasing in size with every new BLK CTRL
addition for every SoC. Lets split the SoC specific parts into separate
drivers. Do that for i.MX8MM now.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/soc/imx/Kconfig           |   7 +
 drivers/soc/imx/Makefile          |   1 +
 drivers/soc/imx/imx8m-blk-ctrl.c  | 210 +-----------------------------
 drivers/soc/imx/imx8m-blk-ctrl.h  |  72 ++++++++++
 drivers/soc/imx/imx8mm-blk-ctrl.c | 173 ++++++++++++++++++++++++
 5 files changed, 257 insertions(+), 206 deletions(-)
 create mode 100644 drivers/soc/imx/imx8m-blk-ctrl.h
 create mode 100644 drivers/soc/imx/imx8mm-blk-ctrl.c

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index a840494e849a..b0cc53f3fc2c 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -20,4 +20,11 @@ config SOC_IMX8M
 	  support, it will provide the SoC info like SoC family,
 	  ID and revision etc.
 
+config SOC_IMX8MM_BLK_CTRL
+	bool "i.MX8MM SoC BLK CTRL support"
+	depends on SOC_IMX8M
+	help
+	  If you say yes here you get support for the NXP i.MX8MM BLK CTRL
+	  support.
+
 endmenu
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 8a707077914c..06c2970e6308 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
 obj-$(CONFIG_SOC_IMX8M) += imx8m-blk-ctrl.o
+obj-$(CONFIG_SOC_IMX8MM_BLK_CTRL) += imx8mm-blk-ctrl.o
diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 511e74f0db8a..599b2a9a38bb 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -4,67 +4,11 @@
  * Copyright 2021 Pengutronix, Lucas Stach <kernel@pengutronix.de>
  */
 
-#include <linux/device.h>
-#include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/platform_device.h>
-#include <linux/pm_domain.h>
-#include <linux/pm_runtime.h>
-#include <linux/regmap.h>
-#include <linux/clk.h>
 
-#include <dt-bindings/power/imx8mm-power.h>
 #include <dt-bindings/power/imx8mn-power.h>
 
-#define BLK_SFT_RSTN	0x0
-#define BLK_CLK_EN	0x4
-#define BLK_MIPI_RESET_DIV	0x8 /* Mini/Nano DISPLAY_BLK_CTRL only */
-
-struct imx8m_blk_ctrl_domain;
-
-struct imx8m_blk_ctrl {
-	struct device *dev;
-	struct notifier_block power_nb;
-	struct device *bus_power_dev;
-	struct regmap *regmap;
-	struct imx8m_blk_ctrl_domain *domains;
-	struct genpd_onecell_data onecell_data;
-};
-
-struct imx8m_blk_ctrl_domain_data {
-	const char *name;
-	const char * const *clk_names;
-	int num_clks;
-	const char *gpc_name;
-	u32 rst_mask;
-	u32 clk_mask;
-
-	/*
-	 * i.MX8M Mini and Nano have a third DISPLAY_BLK_CTRL register
-	 * which is used to control the reset for the MIPI Phy.
-	 * Since it's only present in certain circumstances,
-	 * an if-statement should be used before setting and clearing this
-	 * register.
-	 */
-	u32 mipi_phy_rst_mask;
-};
-
-#define DOMAIN_MAX_CLKS 3
-
-struct imx8m_blk_ctrl_domain {
-	struct generic_pm_domain genpd;
-	const struct imx8m_blk_ctrl_domain_data *data;
-	struct clk_bulk_data clks[DOMAIN_MAX_CLKS];
-	struct device *power_dev;
-	struct imx8m_blk_ctrl *bc;
-};
-
-struct imx8m_blk_ctrl_data {
-	int max_reg;
-	notifier_fn_t power_notifier_fn;
-	const struct imx8m_blk_ctrl_domain_data *domains;
-	int num_domains;
-};
+#include "imx8m-blk-ctrl.h"
 
 static inline struct imx8m_blk_ctrl_domain *
 to_imx8m_blk_ctrl_domain(struct generic_pm_domain *genpd)
@@ -165,7 +109,7 @@ imx8m_blk_ctrl_xlate(struct of_phandle_args *args, void *data)
 
 static struct lock_class_key blk_ctrl_genpd_lock_class;
 
-static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
+int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 {
 	const struct imx8m_blk_ctrl_data *bc_data;
 	struct device *dev = &pdev->dev;
@@ -299,7 +243,7 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int imx8m_blk_ctrl_remove(struct platform_device *pdev)
+int imx8m_blk_ctrl_remove(struct platform_device *pdev)
 {
 	struct imx8m_blk_ctrl *bc = dev_get_drvdata(&pdev->dev);
 	int i;
@@ -375,150 +319,10 @@ static int imx8m_blk_ctrl_resume(struct device *dev)
 }
 #endif
 
-static const struct dev_pm_ops imx8m_blk_ctrl_pm_ops = {
+const struct dev_pm_ops imx8m_blk_ctrl_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(imx8m_blk_ctrl_suspend, imx8m_blk_ctrl_resume)
 };
 
-static int imx8mm_vpu_power_notifier(struct notifier_block *nb,
-				     unsigned long action, void *data)
-{
-	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
-						 power_nb);
-
-	if (action != GENPD_NOTIFY_ON && action != GENPD_NOTIFY_PRE_OFF)
-		return NOTIFY_OK;
-
-	/*
-	 * The ADB in the VPUMIX domain has no separate reset and clock
-	 * enable bits, but is ungated together with the VPU clocks. To
-	 * allow the handshake with the GPC to progress we put the VPUs
-	 * in reset and ungate the clocks.
-	 */
-	regmap_clear_bits(bc->regmap, BLK_SFT_RSTN, BIT(0) | BIT(1) | BIT(2));
-	regmap_set_bits(bc->regmap, BLK_CLK_EN, BIT(0) | BIT(1) | BIT(2));
-
-	if (action == GENPD_NOTIFY_ON) {
-		/*
-		 * On power up we have no software backchannel to the GPC to
-		 * wait for the ADB handshake to happen, so we just delay for a
-		 * bit. On power down the GPC driver waits for the handshake.
-		 */
-		udelay(5);
-
-		/* set "fuse" bits to enable the VPUs */
-		regmap_set_bits(bc->regmap, 0x8, 0xffffffff);
-		regmap_set_bits(bc->regmap, 0xc, 0xffffffff);
-		regmap_set_bits(bc->regmap, 0x10, 0xffffffff);
-		regmap_set_bits(bc->regmap, 0x14, 0xffffffff);
-	}
-
-	return NOTIFY_OK;
-}
-
-static const struct imx8m_blk_ctrl_domain_data imx8mm_vpu_blk_ctl_domain_data[] = {
-	[IMX8MM_VPUBLK_PD_G1] = {
-		.name = "vpublk-g1",
-		.clk_names = (const char *[]){ "g1", },
-		.num_clks = 1,
-		.gpc_name = "g1",
-		.rst_mask = BIT(1),
-		.clk_mask = BIT(1),
-	},
-	[IMX8MM_VPUBLK_PD_G2] = {
-		.name = "vpublk-g2",
-		.clk_names = (const char *[]){ "g2", },
-		.num_clks = 1,
-		.gpc_name = "g2",
-		.rst_mask = BIT(0),
-		.clk_mask = BIT(0),
-	},
-	[IMX8MM_VPUBLK_PD_H1] = {
-		.name = "vpublk-h1",
-		.clk_names = (const char *[]){ "h1", },
-		.num_clks = 1,
-		.gpc_name = "h1",
-		.rst_mask = BIT(2),
-		.clk_mask = BIT(2),
-	},
-};
-
-static const struct imx8m_blk_ctrl_data imx8mm_vpu_blk_ctl_dev_data = {
-	.max_reg = 0x18,
-	.power_notifier_fn = imx8mm_vpu_power_notifier,
-	.domains = imx8mm_vpu_blk_ctl_domain_data,
-	.num_domains = ARRAY_SIZE(imx8mm_vpu_blk_ctl_domain_data),
-};
-
-static int imx8mm_disp_power_notifier(struct notifier_block *nb,
-				      unsigned long action, void *data)
-{
-	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
-						 power_nb);
-
-	if (action != GENPD_NOTIFY_ON && action != GENPD_NOTIFY_PRE_OFF)
-		return NOTIFY_OK;
-
-	/* Enable bus clock and deassert bus reset */
-	regmap_set_bits(bc->regmap, BLK_CLK_EN, BIT(12));
-	regmap_set_bits(bc->regmap, BLK_SFT_RSTN, BIT(6));
-
-	/*
-	 * On power up we have no software backchannel to the GPC to
-	 * wait for the ADB handshake to happen, so we just delay for a
-	 * bit. On power down the GPC driver waits for the handshake.
-	 */
-	if (action == GENPD_NOTIFY_ON)
-		udelay(5);
-
-
-	return NOTIFY_OK;
-}
-
-static const struct imx8m_blk_ctrl_domain_data imx8mm_disp_blk_ctl_domain_data[] = {
-	[IMX8MM_DISPBLK_PD_CSI_BRIDGE] = {
-		.name = "dispblk-csi-bridge",
-		.clk_names = (const char *[]){ "csi-bridge-axi", "csi-bridge-apb",
-					       "csi-bridge-core", },
-		.num_clks = 3,
-		.gpc_name = "csi-bridge",
-		.rst_mask = BIT(0) | BIT(1) | BIT(2),
-		.clk_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5),
-	},
-	[IMX8MM_DISPBLK_PD_LCDIF] = {
-		.name = "dispblk-lcdif",
-		.clk_names = (const char *[]){ "lcdif-axi", "lcdif-apb", "lcdif-pix", },
-		.num_clks = 3,
-		.gpc_name = "lcdif",
-		.clk_mask = BIT(6) | BIT(7),
-	},
-	[IMX8MM_DISPBLK_PD_MIPI_DSI] = {
-		.name = "dispblk-mipi-dsi",
-		.clk_names = (const char *[]){ "dsi-pclk", "dsi-ref", },
-		.num_clks = 2,
-		.gpc_name = "mipi-dsi",
-		.rst_mask = BIT(5),
-		.clk_mask = BIT(8) | BIT(9),
-		.mipi_phy_rst_mask = BIT(17),
-	},
-	[IMX8MM_DISPBLK_PD_MIPI_CSI] = {
-		.name = "dispblk-mipi-csi",
-		.clk_names = (const char *[]){ "csi-aclk", "csi-pclk" },
-		.num_clks = 2,
-		.gpc_name = "mipi-csi",
-		.rst_mask = BIT(3) | BIT(4),
-		.clk_mask = BIT(10) | BIT(11),
-		.mipi_phy_rst_mask = BIT(16),
-	},
-};
-
-static const struct imx8m_blk_ctrl_data imx8mm_disp_blk_ctl_dev_data = {
-	.max_reg = 0x2c,
-	.power_notifier_fn = imx8mm_disp_power_notifier,
-	.domains = imx8mm_disp_blk_ctl_domain_data,
-	.num_domains = ARRAY_SIZE(imx8mm_disp_blk_ctl_domain_data),
-};
-
-
 static int imx8mn_disp_power_notifier(struct notifier_block *nb,
 				      unsigned long action, void *data)
 {
@@ -591,12 +395,6 @@ static const struct imx8m_blk_ctrl_data imx8mn_disp_blk_ctl_dev_data = {
 
 static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
 	{
-		.compatible = "fsl,imx8mm-vpu-blk-ctrl",
-		.data = &imx8mm_vpu_blk_ctl_dev_data
-	}, {
-		.compatible = "fsl,imx8mm-disp-blk-ctrl",
-		.data = &imx8mm_disp_blk_ctl_dev_data
-	}, {
 		.compatible = "fsl,imx8mn-disp-blk-ctrl",
 		.data = &imx8mn_disp_blk_ctl_dev_data
 	}, {
diff --git a/drivers/soc/imx/imx8m-blk-ctrl.h b/drivers/soc/imx/imx8m-blk-ctrl.h
new file mode 100644
index 000000000000..618b3429bb69
--- /dev/null
+++ b/drivers/soc/imx/imx8m-blk-ctrl.h
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Copyright 2021 Pengutronix, Lucas Stach <kernel@pengutronix.de>
+ * Copyright 2022 NXP, Abel Vesa <abel.vesa@nxp.com>
+ */
+
+#ifndef __IMX_BLK_CTRL_H
+#define __IMX_BLK_CTRL_H
+
+#include <linux/clk.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#define BLK_SFT_RSTN	0x0
+#define BLK_CLK_EN	0x4
+#define BLK_MIPI_RESET_DIV	0x8 /* Mini/Nano DISPLAY_BLK_CTRL only */
+
+struct imx8m_blk_ctrl_domain;
+
+struct imx8m_blk_ctrl {
+	struct device *dev;
+	struct notifier_block power_nb;
+	struct device *bus_power_dev;
+	struct regmap *regmap;
+	struct imx8m_blk_ctrl_domain *domains;
+	struct genpd_onecell_data onecell_data;
+};
+
+struct imx8m_blk_ctrl_domain_data {
+	const char *name;
+	const char * const *clk_names;
+	int num_clks;
+	const char *gpc_name;
+	u32 rst_mask;
+	u32 clk_mask;
+
+	/*
+	 * i.MX8M Mini and Nano have a third DISPLAY_BLK_CTRL register
+	 * which is used to control the reset for the MIPI Phy.
+	 * Since it's only present in certain circumstances,
+	 * an if-statement should be used before setting and clearing this
+	 * register.
+	 */
+	u32 mipi_phy_rst_mask;
+};
+
+#define DOMAIN_MAX_CLKS 3
+
+struct imx8m_blk_ctrl_domain {
+	struct generic_pm_domain genpd;
+	const struct imx8m_blk_ctrl_domain_data *data;
+	struct clk_bulk_data clks[DOMAIN_MAX_CLKS];
+	struct device *power_dev;
+	struct imx8m_blk_ctrl *bc;
+};
+
+struct imx8m_blk_ctrl_data {
+	int max_reg;
+	notifier_fn_t power_notifier_fn;
+	const struct imx8m_blk_ctrl_domain_data *domains;
+	int num_domains;
+};
+
+extern const struct dev_pm_ops imx8m_blk_ctrl_pm_ops;
+
+int imx8m_blk_ctrl_remove(struct platform_device *pdev);
+int imx8m_blk_ctrl_probe(struct platform_device *pdev);
+
+#endif
diff --git a/drivers/soc/imx/imx8mm-blk-ctrl.c b/drivers/soc/imx/imx8mm-blk-ctrl.c
new file mode 100644
index 000000000000..eb63d28b0157
--- /dev/null
+++ b/drivers/soc/imx/imx8mm-blk-ctrl.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Copyright 2021 Pengutronix, Lucas Stach <kernel@pengutronix.de>
+ * Copyright 2022 NXP, Abel Vesa <abel.vesa@nxp.com>
+ */
+
+#include <dt-bindings/power/imx8mm-power.h>
+
+#include "imx8m-blk-ctrl.h"
+
+static int imx8mm_vpu_power_notifier(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
+						 power_nb);
+
+	if (action != GENPD_NOTIFY_ON && action != GENPD_NOTIFY_PRE_OFF)
+		return NOTIFY_OK;
+
+	/*
+	 * The ADB in the VPUMIX domain has no separate reset and clock
+	 * enable bits, but is ungated together with the VPU clocks. To
+	 * allow the handshake with the GPC to progress we put the VPUs
+	 * in reset and ungate the clocks.
+	 */
+	regmap_clear_bits(bc->regmap, BLK_SFT_RSTN, BIT(0) | BIT(1) | BIT(2));
+	regmap_set_bits(bc->regmap, BLK_CLK_EN, BIT(0) | BIT(1) | BIT(2));
+
+	if (action == GENPD_NOTIFY_ON) {
+		/*
+		 * On power up we have no software backchannel to the GPC to
+		 * wait for the ADB handshake to happen, so we just delay for a
+		 * bit. On power down the GPC driver waits for the handshake.
+		 */
+		udelay(5);
+
+		/* set "fuse" bits to enable the VPUs */
+		regmap_set_bits(bc->regmap, 0x8, 0xffffffff);
+		regmap_set_bits(bc->regmap, 0xc, 0xffffffff);
+		regmap_set_bits(bc->regmap, 0x10, 0xffffffff);
+		regmap_set_bits(bc->regmap, 0x14, 0xffffffff);
+	}
+
+	return NOTIFY_OK;
+}
+
+static const struct imx8m_blk_ctrl_domain_data imx8mm_vpu_blk_ctl_domain_data[] = {
+	[IMX8MM_VPUBLK_PD_G1] = {
+		.name = "vpublk-g1",
+		.clk_names = (const char *[]){ "g1", },
+		.num_clks = 1,
+		.gpc_name = "g1",
+		.rst_mask = BIT(1),
+		.clk_mask = BIT(1),
+	},
+	[IMX8MM_VPUBLK_PD_G2] = {
+		.name = "vpublk-g2",
+		.clk_names = (const char *[]){ "g2", },
+		.num_clks = 1,
+		.gpc_name = "g2",
+		.rst_mask = BIT(0),
+		.clk_mask = BIT(0),
+	},
+	[IMX8MM_VPUBLK_PD_H1] = {
+		.name = "vpublk-h1",
+		.clk_names = (const char *[]){ "h1", },
+		.num_clks = 1,
+		.gpc_name = "h1",
+		.rst_mask = BIT(2),
+		.clk_mask = BIT(2),
+	},
+};
+
+static const struct imx8m_blk_ctrl_data imx8mm_vpu_blk_ctl_dev_data = {
+	.max_reg = 0x18,
+	.power_notifier_fn = imx8mm_vpu_power_notifier,
+	.domains = imx8mm_vpu_blk_ctl_domain_data,
+	.num_domains = ARRAY_SIZE(imx8mm_vpu_blk_ctl_domain_data),
+};
+
+static int imx8mm_disp_power_notifier(struct notifier_block *nb,
+				      unsigned long action, void *data)
+{
+	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
+						 power_nb);
+
+	if (action != GENPD_NOTIFY_ON && action != GENPD_NOTIFY_PRE_OFF)
+		return NOTIFY_OK;
+
+	/* Enable bus clock and deassert bus reset */
+	regmap_set_bits(bc->regmap, BLK_CLK_EN, BIT(12));
+	regmap_set_bits(bc->regmap, BLK_SFT_RSTN, BIT(6));
+
+	/*
+	 * On power up we have no software backchannel to the GPC to
+	 * wait for the ADB handshake to happen, so we just delay for a
+	 * bit. On power down the GPC driver waits for the handshake.
+	 */
+	if (action == GENPD_NOTIFY_ON)
+		udelay(5);
+
+
+	return NOTIFY_OK;
+}
+
+static const struct imx8m_blk_ctrl_domain_data imx8mm_disp_blk_ctl_domain_data[] = {
+	[IMX8MM_DISPBLK_PD_CSI_BRIDGE] = {
+		.name = "dispblk-csi-bridge",
+		.clk_names = (const char *[]){ "csi-bridge-axi", "csi-bridge-apb",
+					       "csi-bridge-core", },
+		.num_clks = 3,
+		.gpc_name = "csi-bridge",
+		.rst_mask = BIT(0) | BIT(1) | BIT(2),
+		.clk_mask = BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5),
+	},
+	[IMX8MM_DISPBLK_PD_LCDIF] = {
+		.name = "dispblk-lcdif",
+		.clk_names = (const char *[]){ "lcdif-axi", "lcdif-apb", "lcdif-pix", },
+		.num_clks = 3,
+		.gpc_name = "lcdif",
+		.clk_mask = BIT(6) | BIT(7),
+	},
+	[IMX8MM_DISPBLK_PD_MIPI_DSI] = {
+		.name = "dispblk-mipi-dsi",
+		.clk_names = (const char *[]){ "dsi-pclk", "dsi-ref", },
+		.num_clks = 2,
+		.gpc_name = "mipi-dsi",
+		.rst_mask = BIT(5),
+		.clk_mask = BIT(8) | BIT(9),
+		.mipi_phy_rst_mask = BIT(17),
+	},
+	[IMX8MM_DISPBLK_PD_MIPI_CSI] = {
+		.name = "dispblk-mipi-csi",
+		.clk_names = (const char *[]){ "csi-aclk", "csi-pclk" },
+		.num_clks = 2,
+		.gpc_name = "mipi-csi",
+		.rst_mask = BIT(3) | BIT(4),
+		.clk_mask = BIT(10) | BIT(11),
+		.mipi_phy_rst_mask = BIT(16),
+	},
+};
+
+static const struct imx8m_blk_ctrl_data imx8mm_disp_blk_ctl_dev_data = {
+	.max_reg = 0x2c,
+	.power_notifier_fn = imx8mm_disp_power_notifier,
+	.domains = imx8mm_disp_blk_ctl_domain_data,
+	.num_domains = ARRAY_SIZE(imx8mm_disp_blk_ctl_domain_data),
+};
+
+static const struct of_device_id imx8mm_blk_ctrl_of_match[] = {
+	{
+		.compatible = "fsl,imx8mm-vpu-blk-ctrl",
+		.data = &imx8mm_vpu_blk_ctl_dev_data
+	}, {
+		.compatible = "fsl,imx8mm-disp-blk-ctrl",
+		.data = &imx8mm_disp_blk_ctl_dev_data
+	}, {
+		/* Sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, imx8mm_blk_ctrl_of_match);
+
+static struct platform_driver imx8mm_blk_ctrl_driver = {
+	.probe = imx8m_blk_ctrl_probe,
+	.remove = imx8m_blk_ctrl_remove,
+	.driver = {
+		.name = "imx8mm-blk-ctrl",
+		.pm = &imx8m_blk_ctrl_pm_ops,
+		.of_match_table = imx8mm_blk_ctrl_of_match,
+	},
+};
+module_platform_driver(imx8mm_blk_ctrl_driver);
-- 
2.31.1

