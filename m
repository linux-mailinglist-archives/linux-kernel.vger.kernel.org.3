Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC161495E59
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 12:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380192AbiAULXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 06:23:09 -0500
Received: from mail-eopbgr130075.outbound.protection.outlook.com ([40.107.13.75]:53830
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1380148AbiAULXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 06:23:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K89bWqb3DE0IZz98syY763HUExUJ7JUTN+ikHU1opmohIL6UR0YHt0D8tfPtAcVd9lwFDfYpapR967X2mwH+gPwFQZxI8+LpdxhxFjZlFd+zcuFWeY+g4P+nYzhScYtuxGPrjMurQ/zoKKgkjL6nxMThA0i+h/5k1IgGmTRPW+s0Q13tL/A0LYfUh7E58nsMOkQoNbAHyM7yHn6YWCs7h7Q0FXYcH6V/8bOKxWNn2q7WKF/5Jb0YDoODbSaSsQVW8H4eXJpP+7T04ngwWi5PGqDxiPFBM/IjasxSr6OtWuL1iPQXChjdkHVmr0mOdEMLgIdfxJSAViX3LnZSV6wx0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5ZRw7hHS0vm1qG8ufV0oYLtf+nVvMrPEiu5I7GvN48=;
 b=k3ls+iDP3hrzuVMez/zkdTdcZ+1Lo4++3se/12E71PrTBhZJzCung1sAo4baQBCrqVfdDube3yMg9T4195mlSKPD4atTZQIj/nQ8xTIinRKz3/xYyIlZ9XwCibWy2xsuuKxB+jA5MEXuRYuji9JLr11MQyf78AJDaV+0R+2k7WEnJHHKXpbPO/fUvkb9u9r91t6AmzD1KBjzQvv/VOb2AG55CINfvj9vY0AYQb3jEqqVOQrCjzjazgfnFPACsc9b5F965amGKt4ZY87UVLEFYtN3wSIN4+1HaKB8PsfwskiNestPa5A2TwXjAmgfDospLDd1aB5aqbEi2Dm7jNNPkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5ZRw7hHS0vm1qG8ufV0oYLtf+nVvMrPEiu5I7GvN48=;
 b=d589WXJQ3tAQt9VkHgGhkMtWcALSCgCrcwtRy6xYKIr9N7DI2gAf3B3W0eN/uXZ+Vs+D9OZF52h3/YhhsLMQNFS6nzdS44Vzb0V2CPNBJxnZot4a1U/U4+618xffHVXb6AkuhT0WfYdY2DEmS3nCer8qIDNv+7r0SQLjIX9nw5k=
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
 11:22:53 +0000
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
Subject: [RFC 2/3] soc: imx: make i.MX8MN BLK CTRL a separate driver
Date:   Fri, 21 Jan 2022 13:22:37 +0200
Message-Id: <20220121112238.47281-3-abel.vesa@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e6447996-305a-4cf4-8f70-08d9dcd05d78
X-MS-TrafficTypeDiagnostic: DB8PR04MB6731:EE_
X-Microsoft-Antispam-PRVS: <DB8PR04MB67319A48935A11BB754D815FF65B9@DB8PR04MB6731.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DrIDrEqUlZcpYsuosOZw9kHK0Q//5s4jW6F/snhBfbPyLU+GELefzd39ZBKLmBJcl9yZ1HiqChcvr4+ZN/wmWfl8CNet03exKdvMe1yKy3of9B2y1wA53f9cx2t5PqF0obZEMVcZIPusoCRSfGhCCIX4gj9XxONS+X8DOmWsmIzS5nwWL9mVaBSVzmW2M35Ei1yvidlPwMCAc/fwyTCviUcBvxDK7Jgw7UmV654UGkL595f/l7oohKXZOe4I+O5sUdeY9kUnYWpZoWeATORx4Oil4hCgMzgDGtOmYo8x4xsSrszKJ3HKvvom02Tl0jSeGLmLLPNzzC13vXpLteo91UlI0NrsWqG3R46T0taqbIlhEXbepC6u6Ygxzygg/ZLbc6nitsu+OaI4UjYmbvu3KMp7L13FodQTX5uZuL1MlKtnySENmatBleE1vOdigG+lKQKSrePJKDV5lCLPslmdpRXhJ+WmdcIp+T7jsZ6supjejfSUbFhHjx7qEiWM4KFjgHn8HYPfSAyD7/QZrkGfiP51u9jQvbXADEW/SvSnKBCt0w5socbKH/NzxCm4LZBCEr+N+7n2TY51tL/MB8L6GacJAjf9Vvy34z6n6+pSqJOi/E8/QoKZraeKwxAEMchWmXNLhV/5YwhXBbHZGxI+1CGjKycX5haAcuMZq+PPjZ1IMpSoZycPde/xxOH+yxOrnZNO3NEDNmNBJAn3SrX5uA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(38350700002)(52116002)(2616005)(8676002)(6512007)(1076003)(6666004)(316002)(110136005)(54906003)(86362001)(6506007)(6486002)(66946007)(5660300002)(4326008)(66556008)(66476007)(8936002)(36756003)(44832011)(83380400001)(2906002)(186003)(26005)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DiUEMgnMyj9mA3dE+tSg4TyIOSbtvJUbNqhoxtz/iW/qGD/vV18EkE/8oYKB?=
 =?us-ascii?Q?FBdDsYB94VWHgFMUZA8FHgtmQUz6LwFQ+7Mxnwl5fLCyZnI/gyVyFcThf0Nb?=
 =?us-ascii?Q?RCARBjlV66l50WQn6lwUqH6rVQ3yryFfBisdZAbyGVYmt/vtJBS00q6tRuUo?=
 =?us-ascii?Q?X9hHA27/lLarYvGwPm3E/jRLExmvtDKtG78PEV8S+MJiQDFfcqVqDQLr5LGL?=
 =?us-ascii?Q?mcoXoaxtX/aQkx9YWhg4yc3Sfxfg2PtG+O0fIE8ylxDxUnUc3rkpMUFIYv3K?=
 =?us-ascii?Q?J4aQ01k3dq7fbYX9blLNTvKLzDDnLS/CJZr2aPpVEs6yzaEZGTZVN70Jx2UC?=
 =?us-ascii?Q?MogZsBXNxC39keakYFmBqe126JmrGB41VEyq6sEDFi7GPXBa1x9olBoTfUm2?=
 =?us-ascii?Q?Oby56B6F+vsZAg3I/Qii1XvYwwqNOSH0+qyjdb+HgLOnlyi2TNeBXyDzhRA8?=
 =?us-ascii?Q?BsPZ3Z42TaNbprE7kRfUb48YJYDBw3qyKLJjgLCb5PIF/WiVnBLNT8z1fFo9?=
 =?us-ascii?Q?NScsmgTUC/IXN34ea/+be6qz/XJl0xz2TpiglBnmxvb7QWAO6oBKjQP9IFpU?=
 =?us-ascii?Q?IoemAbWUa5jVphhAmGpq1jI6nYH+qzfgHXFOafuBD7s1FzLKMDD4eWOFvf5G?=
 =?us-ascii?Q?qk4VfSRFR2hkROMbzSeeZQhEnM3htfKKMwupcWbzsjo/aRHHzW+bRqaXpoli?=
 =?us-ascii?Q?/BctbRUri5xheOVZueJuf2tmQM2CG/3eN5u2ckhDFJN4zMZd8HKkCOrVRNY4?=
 =?us-ascii?Q?kJ+wB8/odIRg5eIWExnHVDk5QZ/oA57MYzlNYGHqaDiim4ryNOR6CNm1ICo5?=
 =?us-ascii?Q?5KhHP77B5GM/QDptwpqjQnsy5ciuu+tYFjYTE1Cq0pLX0JEiJeXxW2BofVYL?=
 =?us-ascii?Q?kxBXcEU61udqEGQCxGPUuYuy9N8vPV24BDcenVPrL95FD/vBdzWwr/7ksRyR?=
 =?us-ascii?Q?ydGehoylz1AA+lyZbU1yOjdNBMthDXtwLEL7/1cZyVkgOz3hqmI8Fbeah9uI?=
 =?us-ascii?Q?qJVlnLRKQ2ZxirfRENfATdHYVL7VefPK4UxhiqX790jnVlZByTNVAlmkBfOd?=
 =?us-ascii?Q?SFB+SWpo1y6pMU/TZZa7v7FD8SzyUeywA6NSoLMkB4JCOfDShLcqkwhaVRMv?=
 =?us-ascii?Q?D45l6fzfDQEwzWt4xYkqRGGeR8LYwOUiwOHkFjC7ie4UmV6Gu1qWKsZOiII1?=
 =?us-ascii?Q?tL5LXODnCCn4FnQMkZG/Cle5FybzpleH6TkwFdhqOXyeL2lWa5TjgickI1bV?=
 =?us-ascii?Q?5aaRfnVGmp328QcQ6m0VNPb60yd5lEUxjIOOQLlCg8X/rJsBU9x3biwawoxM?=
 =?us-ascii?Q?/DshoetPQZYC+6YxFZIdHmqgZt7mudUQoFMdf1IOb7HnHdxXxpY0Y5wJv3Y/?=
 =?us-ascii?Q?98TEqnIq2kMQLwSbJYCB8YpT2puDLKJWPEEg9fsUpYD4HsNvfX/FuTGm9R+T?=
 =?us-ascii?Q?tGwyvvJs4RXUmPjAcKks1vx5Pt1wh73W68NnOQ+0BhBKS4m+c5jsr+gicvPe?=
 =?us-ascii?Q?agewUSaVWELCdSIYiN5HyQJ/dAUBMUTX28tabxdUOgJ4SKmw/5lY4molx/Hd?=
 =?us-ascii?Q?cuPcUVJV+n+ZRz0SBwx9s+eO07xKwDeqfx5X9lhlvj5wCjExzAOZq9ALsDnI?=
 =?us-ascii?Q?5g0O02kCgz8LpNnYpZo2s6A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6447996-305a-4cf4-8f70-08d9dcd05d78
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 11:22:53.0219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Dlm1z3rqvreWq+SIO9jC2gTbiLRDnZ3mNxDEm7PJ4wYngXza/GYonq1ycOjwK4M8GpGnuNJd3bpiRE1E4F8IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6731
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx8m-blk-ctrl driver was increasing in size with every new BLK CTRL
addition for every SoC. Lets split the SoC specific parts into separate
drivers. Do that for i.MX8MN now.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/soc/imx/Kconfig           |   7 +++
 drivers/soc/imx/Makefile          |   1 +
 drivers/soc/imx/imx8m-blk-ctrl.c  |  93 ---------------------------
 drivers/soc/imx/imx8mn-blk-ctrl.c | 101 ++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 93 deletions(-)
 create mode 100644 drivers/soc/imx/imx8mn-blk-ctrl.c

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index b0cc53f3fc2c..8a3e0920b022 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -27,4 +27,11 @@ config SOC_IMX8MM_BLK_CTRL
 	  If you say yes here you get support for the NXP i.MX8MM BLK CTRL
 	  support.
 
+config SOC_IMX8MN_BLK_CTRL
+	bool "i.MX8MN SoC BLK CTRL support"
+	depends on SOC_IMX8M
+	help
+	  If you say yes here you get support for the NXP i.MX8MN BLK CTRL
+	  support.
+
 endmenu
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 06c2970e6308..f5243bc5f08f 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
 obj-$(CONFIG_SOC_IMX8M) += imx8m-blk-ctrl.o
 obj-$(CONFIG_SOC_IMX8MM_BLK_CTRL) += imx8mm-blk-ctrl.o
+obj-$(CONFIG_SOC_IMX8MN_BLK_CTRL) += imx8mn-blk-ctrl.o
diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 599b2a9a38bb..ebdb044c6afa 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -6,8 +6,6 @@
 
 #include <linux/of_device.h>
 
-#include <dt-bindings/power/imx8mn-power.h>
-
 #include "imx8m-blk-ctrl.h"
 
 static inline struct imx8m_blk_ctrl_domain *
@@ -322,94 +320,3 @@ static int imx8m_blk_ctrl_resume(struct device *dev)
 const struct dev_pm_ops imx8m_blk_ctrl_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(imx8m_blk_ctrl_suspend, imx8m_blk_ctrl_resume)
 };
-
-static int imx8mn_disp_power_notifier(struct notifier_block *nb,
-				      unsigned long action, void *data)
-{
-	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
-						 power_nb);
-
-	if (action != GENPD_NOTIFY_ON && action != GENPD_NOTIFY_PRE_OFF)
-		return NOTIFY_OK;
-
-	/* Enable bus clock and deassert bus reset */
-	regmap_set_bits(bc->regmap, BLK_CLK_EN, BIT(8));
-	regmap_set_bits(bc->regmap, BLK_SFT_RSTN, BIT(8));
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
-static const struct imx8m_blk_ctrl_domain_data imx8mn_disp_blk_ctl_domain_data[] = {
-	[IMX8MN_DISPBLK_PD_MIPI_DSI] = {
-		.name = "dispblk-mipi-dsi",
-		.clk_names = (const char *[]){ "dsi-pclk", "dsi-ref", },
-		.num_clks = 2,
-		.gpc_name = "mipi-dsi",
-		.rst_mask = BIT(0) | BIT(1),
-		.clk_mask = BIT(0) | BIT(1),
-		.mipi_phy_rst_mask = BIT(17),
-	},
-	[IMX8MN_DISPBLK_PD_MIPI_CSI] = {
-		.name = "dispblk-mipi-csi",
-		.clk_names = (const char *[]){ "csi-aclk", "csi-pclk" },
-		.num_clks = 2,
-		.gpc_name = "mipi-csi",
-		.rst_mask = BIT(2) | BIT(3),
-		.clk_mask = BIT(2) | BIT(3),
-		.mipi_phy_rst_mask = BIT(16),
-	},
-	[IMX8MN_DISPBLK_PD_LCDIF] = {
-		.name = "dispblk-lcdif",
-		.clk_names = (const char *[]){ "lcdif-axi", "lcdif-apb", "lcdif-pix", },
-		.num_clks = 3,
-		.gpc_name = "lcdif",
-		.rst_mask = BIT(4) | BIT(5),
-		.clk_mask = BIT(4) | BIT(5),
-	},
-	[IMX8MN_DISPBLK_PD_ISI] = {
-		.name = "dispblk-isi",
-		.clk_names = (const char *[]){ "disp_axi", "disp_apb", "disp_axi_root",
-						"disp_apb_root"},
-		.num_clks = 4,
-		.gpc_name = "isi",
-		.rst_mask = BIT(6) | BIT(7),
-		.clk_mask = BIT(6) | BIT(7),
-	},
-};
-
-static const struct imx8m_blk_ctrl_data imx8mn_disp_blk_ctl_dev_data = {
-	.max_reg = 0x84,
-	.power_notifier_fn = imx8mn_disp_power_notifier,
-	.domains = imx8mn_disp_blk_ctl_domain_data,
-	.num_domains = ARRAY_SIZE(imx8mn_disp_blk_ctl_domain_data),
-};
-
-static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
-	{
-		.compatible = "fsl,imx8mn-disp-blk-ctrl",
-		.data = &imx8mn_disp_blk_ctl_dev_data
-	}, {
-		/* Sentinel */
-	}
-};
-MODULE_DEVICE_TABLE(of, imx8m_blk_ctrl_of_match);
-
-static struct platform_driver imx8m_blk_ctrl_driver = {
-	.probe = imx8m_blk_ctrl_probe,
-	.remove = imx8m_blk_ctrl_remove,
-	.driver = {
-		.name = "imx8m-blk-ctrl",
-		.pm = &imx8m_blk_ctrl_pm_ops,
-		.of_match_table = imx8m_blk_ctrl_of_match,
-	},
-};
-module_platform_driver(imx8m_blk_ctrl_driver);
diff --git a/drivers/soc/imx/imx8mn-blk-ctrl.c b/drivers/soc/imx/imx8mn-blk-ctrl.c
new file mode 100644
index 000000000000..20f53cd4e387
--- /dev/null
+++ b/drivers/soc/imx/imx8mn-blk-ctrl.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Copyright 2021 Pengutronix, Lucas Stach <kernel@pengutronix.de>
+ * Copyright 2022 NXP, Abel Vesa <abel.vesa@nxp.com>
+ */
+
+#include <dt-bindings/power/imx8mn-power.h>
+
+#include "imx8m-blk-ctrl.h"
+
+static int imx8mn_disp_power_notifier(struct notifier_block *nb,
+				      unsigned long action, void *data)
+{
+	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
+						 power_nb);
+
+	if (action != GENPD_NOTIFY_ON && action != GENPD_NOTIFY_PRE_OFF)
+		return NOTIFY_OK;
+
+	/* Enable bus clock and deassert bus reset */
+	regmap_set_bits(bc->regmap, BLK_CLK_EN, BIT(8));
+	regmap_set_bits(bc->regmap, BLK_SFT_RSTN, BIT(8));
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
+static const struct imx8m_blk_ctrl_domain_data imx8mn_disp_blk_ctl_domain_data[] = {
+	[IMX8MN_DISPBLK_PD_MIPI_DSI] = {
+		.name = "dispblk-mipi-dsi",
+		.clk_names = (const char *[]){ "dsi-pclk", "dsi-ref", },
+		.num_clks = 2,
+		.gpc_name = "mipi-dsi",
+		.rst_mask = BIT(0) | BIT(1),
+		.clk_mask = BIT(0) | BIT(1),
+		.mipi_phy_rst_mask = BIT(17),
+	},
+	[IMX8MN_DISPBLK_PD_MIPI_CSI] = {
+		.name = "dispblk-mipi-csi",
+		.clk_names = (const char *[]){ "csi-aclk", "csi-pclk" },
+		.num_clks = 2,
+		.gpc_name = "mipi-csi",
+		.rst_mask = BIT(2) | BIT(3),
+		.clk_mask = BIT(2) | BIT(3),
+		.mipi_phy_rst_mask = BIT(16),
+	},
+	[IMX8MN_DISPBLK_PD_LCDIF] = {
+		.name = "dispblk-lcdif",
+		.clk_names = (const char *[]){ "lcdif-axi", "lcdif-apb", "lcdif-pix", },
+		.num_clks = 3,
+		.gpc_name = "lcdif",
+		.rst_mask = BIT(4) | BIT(5),
+		.clk_mask = BIT(4) | BIT(5),
+	},
+	[IMX8MN_DISPBLK_PD_ISI] = {
+		.name = "dispblk-isi",
+		.clk_names = (const char *[]){ "disp_axi", "disp_apb", "disp_axi_root",
+						"disp_apb_root"},
+		.num_clks = 4,
+		.gpc_name = "isi",
+		.rst_mask = BIT(6) | BIT(7),
+		.clk_mask = BIT(6) | BIT(7),
+	},
+};
+
+static const struct imx8m_blk_ctrl_data imx8mn_disp_blk_ctl_dev_data = {
+	.max_reg = 0x84,
+	.power_notifier_fn = imx8mn_disp_power_notifier,
+	.domains = imx8mn_disp_blk_ctl_domain_data,
+	.num_domains = ARRAY_SIZE(imx8mn_disp_blk_ctl_domain_data),
+};
+
+static const struct of_device_id imx8mn_blk_ctrl_of_match[] = {
+	{
+		.compatible = "fsl,imx8mn-disp-blk-ctrl",
+		.data = &imx8mn_disp_blk_ctl_dev_data
+	}, {
+		/* Sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(of, imx8mn_blk_ctrl_of_match);
+
+static struct platform_driver imx8mn_blk_ctrl_driver = {
+	.probe = imx8m_blk_ctrl_probe,
+	.remove = imx8m_blk_ctrl_remove,
+	.driver = {
+		.name = "imx8mn-blk-ctrl",
+		.pm = &imx8m_blk_ctrl_pm_ops,
+		.of_match_table = imx8mn_blk_ctrl_of_match,
+	},
+};
+module_platform_driver(imx8mn_blk_ctrl_driver);
-- 
2.31.1

