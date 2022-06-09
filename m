Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E6D544C83
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244277AbiFIMtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243725AbiFIMtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:49:42 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30081.outbound.protection.outlook.com [40.107.3.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46725205D7;
        Thu,  9 Jun 2022 05:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ltk8q31Wzu4Zla7ta4MqyiHmlT8uSZEjW4PVqcDFuSMBq5225zpQN8IG80Mh7hN1AH0BzYxPUcVspYODKEdHyRWrF7H4+69enYUEZQEGy6OIpD9YgrjRLXSMwbAI/OXX97vT/ne+vjk/Nnz8rhNB1gF3n7O2eHRuzNuYlNawRKizFhvurrfY4JtZttLSpLg2ENxEq4v+Mvi2UwIWHoso7Qersdrf1PnOOUDEm2xgBwU1bb70LOjDJQ6KqPC1SCVS9RHJi0Zoom/lzzQ2YMb8iw8215fIOI7PEmfIIsu7AeZiTgZOQpdy5T3YO8DWDEvk8fBmXm8iQvpOV4zI9LbzoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xj8PYQOsoyGRHYSChv9kUizYZC1UukY1tJ3BY4Ur7DU=;
 b=P/qzYWGl/LRoI+D+RWHySHvb+Kvxmqw8+dV5MRCTrDr8uCVBAGQfHpk1CAAHbOp6GvM+tDbTbF7WvDss9DfCKOqaH8yKhXNgkTgiwEAO3cXrY1cyNVsz9eqnwTM/LkqM9ySVltlHPx/Q2XKERCdltp5jPb5VrEMiFejOl6AfU8h51LoEzQ1PNy7T7+koalgAEjRjudyo2WAU9DKuKIUhndr8Ji8hCAWdTYpdNsArDpQ5BJZB69JbdnFfjCM23PVbAFtAliDexwjkZkgrfFQM7FYRLEXBEZVBLAjSfxTtkGKOILH62zQ3loFmpqMXl0/Gnsu5Gx/oIXNGjJosYU7m8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xj8PYQOsoyGRHYSChv9kUizYZC1UukY1tJ3BY4Ur7DU=;
 b=PjJV0gd01hw3VPkMKld+6MqpKqV9dVUjJ6CO/1ymGz16gYbtXnUTSIdGCv+cb6DNRExsjRhMlwp6verse8/RqTvd2hCWDKRFEWSED1ZYiwk5AicQcx72m0OxWg47dVgHCunFBEt44zfTUvN28Ct4U8APui8/74YTNnx+prUKEDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6952.eurprd04.prod.outlook.com (2603:10a6:20b:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 12:49:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 12:49:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 4/7] soc: imx: add i.MX93 SRC power domain driver
Date:   Thu,  9 Jun 2022 20:50:57 +0800
Message-Id: <20220609125100.3496633-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
References: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f85fe91-1d55-48ff-e8aa-08da4a16816b
X-MS-TrafficTypeDiagnostic: AM7PR04MB6952:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6952AB40B4FDCF532D910DB6C9A79@AM7PR04MB6952.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dfy4IFxJm6F6UriYT/Q4GXGShWeC3GCGw8038ecIb5FfyVX6tN18yN6OnluRfae5B4GIqmxXHcgEmpbLpqeH/bB0inDil0YPrvM+NUFIeycAt0VOV7wxnqGAtnfm5jJ9xRtKGPCV0r/5/mQWWAuhWyP6tSUBrOGQd3/SgwbtC7N+uWL8d9a11V30hBfzQvBLtGZPSFIvf2/IB4O+L4BRbfy/amSZMzlZtHEZVkDB49//HYV7O3mkS1C55GCXk11s0lRbtWHcIFmn7bWghYU81p72aLWcQKwNNWIh1OvD8YqGAW9ut+wXf4tsOcAD3qUQg2/1NRHNJqmcaUka91AWYbwJdD8YYa3zFg0HUpkgKo9bF5LtXO+CTdbpi5VFW+dzym2dJstp+8JcvDX0s+SIhAEQTQFkz+eHIJEKyXO3njqXbEyOqnNfnt76M9CYcNbSQ7ovxeoNHu7tTh4vLRjWnxM67x1ozUYGH4Phaku/eyb5owVc3afGrJcvGkoXFA0GzraWO7TXIO8y8QmI0TG6oavdPTlnGIL5YAVJ8O798kr7AtjG7PF6XbgssL84WjefsuAuelrlrs0XhrMsxhcXEa+sLWO1qpfhF5ryTJal5N0xuzeM4pW0h/YJ0f5Co3vxrUHOTd9SiWEM7lA98w+A1lb3tCBHnVrXTHCvvg8+UJ63cuPE1ddu+iyWHuAofIcDeG3I1O87TW1KaF6X5gj1nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6512007)(66556008)(8676002)(2906002)(4326008)(66476007)(26005)(6666004)(6506007)(38100700002)(52116002)(38350700002)(86362001)(316002)(8936002)(2616005)(508600001)(7416002)(1076003)(83380400001)(6486002)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ra1w9lkmr2R6TWGS5/IQry0L//JhJEaOEWtdiKEZNEvf81Y6Mzbz5XcjS0cq?=
 =?us-ascii?Q?qzSb/fDaB29JcyESEwHnmZucHTQjOSFwyrTXNe5wI3X6eo+tgKfJh7rSUs+N?=
 =?us-ascii?Q?evxQAYPYSOXCKeZZd+xS54U3UusnFN+yFLrrgp0YYdSteHKfTSGRZfqGGPzo?=
 =?us-ascii?Q?HEKrj+6zz9rJn2NKMTXrb4/IC1mWo+Icc97NzhifQ7AbfJml0fldnSNiqo1Y?=
 =?us-ascii?Q?IDODW7pfr18FNTxpk0+/w2vaBQTkB5vItzJN3emO5rVii4qlRHAVJoqxfxLA?=
 =?us-ascii?Q?SYnDqTVv4wiVbZiyhYukb+ofOh9qBsLg57EIwzGMMyo/4uRmWKmlarakFyDf?=
 =?us-ascii?Q?/DTy+dmYGHIz0PdmLQfzc5wiacljtv3Hb6h+rWw2o25Gg9LkOBa5lXHwadhB?=
 =?us-ascii?Q?oEarWZ/z4fyJXnlyGi8fF100ifj9LT5Nd+BlT8omeB23zfWexgmOfcAmtiXv?=
 =?us-ascii?Q?ijuFu7WVVQhQEysVa0NIv8Mg+rP3YqtPcLT5FafIE1gpnea46NfD/6bmkWZd?=
 =?us-ascii?Q?K1T/E0jApPNG9FGVGwTCGJAtXs4CUL7tJtLxwcmx/pqWYUi7hdglmFgl2mn+?=
 =?us-ascii?Q?1US6NCFmDOSJCTxCT8XOd+NHxTg2an5vkw8iKDVT78YkMMFnadQ5agZhX9VB?=
 =?us-ascii?Q?JEVK7dCl4FQKXLXBf8GTihPOtayq8ywiv1Ru1UNOB0aX9WEwlcA46/PsOhHP?=
 =?us-ascii?Q?BX5yaBgQxvDRD9+PqE0JX1qMb4cVSsVuZmKYdW0HcEX9DI/3NpfKUPSRvqxR?=
 =?us-ascii?Q?yM7m0K8QJrz4/LMT0hIfJ+nb7ifmVe9mqDCMCjBMr5j6DgOcuZsTwRVfdxWm?=
 =?us-ascii?Q?Oj65VzWwobO5lUz8peG0kvaeTX8rbtnYjSLbVm4ZCIS/qEcPtlMDJ5NjqyTG?=
 =?us-ascii?Q?zPTet7hOAK+SGq36ptzK0xkW1jbt8R81RZ3pIh+JQiN7mIx5GgWx4ruzSaZJ?=
 =?us-ascii?Q?Qwe/6N3pB9BQAGIot6r2Pd9PASLGArTcNABH/Gq3IONsGme+LAj/hI8QTkY3?=
 =?us-ascii?Q?bFF+7h2uOiUrWgu834Z/ZN0qWPMlMPemr57qhp1b4UTyx3pGOXZB6Ro9+86j?=
 =?us-ascii?Q?P0MXLIC5Bj+VM2djCSTju2dJwXUEYB594pT9PfOS2zQ6REFVAy998fdDWkD7?=
 =?us-ascii?Q?tTmllPakO9URLvVsQwly0RF4nnu0fckSuTn2XhBYkl+twm6oz+rfeoqfLjsH?=
 =?us-ascii?Q?pavxQfEHQMhBZ9ZRvLMPJIHNrk+F0b/bM7hrJfuq4O1yMYGIgOJpSq/BARht?=
 =?us-ascii?Q?kDKVw6Sp7N5VZupYTGpYYKClJ0UERQSIelxWIsbAMrU36gINpi1jDT0BdJtR?=
 =?us-ascii?Q?7pXdP4i7/kEaKRhnQf49xv3ausF7gTMPjoLVGLsjoZ3hpUPvwm+dGEaaaRDJ?=
 =?us-ascii?Q?NKFWYJkymZTNOFlNOsVL+kWC5gDn+SI3BHpDTLSDAFH+AT4ZcB0qW7X8Oub1?=
 =?us-ascii?Q?Udr7Zf8zYk3ocmyXTMQRAU1VM05cFDONPq/dsc5lEdwzXWj2jpzZoH7trWnR?=
 =?us-ascii?Q?0Eh5RSx9kXXJJMd6cOD1xYbINwe8cYHw05x8sStbXSuDta3jRf0CsNdnw8Iu?=
 =?us-ascii?Q?J/LYO5Euw7pZpMExj8urWApJxBde2+k5xMODpi63wO8CtzNaHnBkmhzM0N3d?=
 =?us-ascii?Q?ZiqOy5pEWU16j+NXggEsLQOAXB4BDVHyWpuiZos/O9jtvYstulVBB9PPX0dp?=
 =?us-ascii?Q?ilBDn+jk3SYQFguoe2MIlRcEuiHjMhImMploLJITLqM6PDcXi8YW6+JMZJ6P?=
 =?us-ascii?Q?jRP+iUSscw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f85fe91-1d55-48ff-e8aa-08da4a16816b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 12:49:34.9914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4XgWCcM117Dmzzvn8/ZyIKppW59E13cRmcItmC0F2XuXJnYKGFXNnWL7HDba5SyRmo2t3n+tKTaSaJgD2BkBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6952
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Support controlling power domain managed by System Reset
Controller(SRC). Current supported power domain is mediamix power
domain.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/Kconfig    |  10 ++
 drivers/soc/imx/Makefile   |   1 +
 drivers/soc/imx/imx93-pd.c | 271 +++++++++++++++++++++++++++++++++++++
 3 files changed, 282 insertions(+)
 create mode 100644 drivers/soc/imx/imx93-pd.c

diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index a840494e849a..5bfc1dfea28b 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -20,4 +20,14 @@ config SOC_IMX8M
 	  support, it will provide the SoC info like SoC family,
 	  ID and revision etc.
 
+config SOC_IMX9
+	tristate "i.MX9 SoC family support"
+	depends on ARCH_MXC || COMPILE_TEST
+	default ARCH_MXC && ARM64
+	select SOC_BUS
+	select PM_GENERIC_DOMAINS
+	help
+	  If you say yes here you get support for the NXP i.MX9 family
+	  support.
+
 endmenu
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index 63cd29f6d4d2..e3ed07a6bcf9 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
 obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
 obj-$(CONFIG_SOC_IMX8M) += imx8m-blk-ctrl.o
 obj-$(CONFIG_SOC_IMX8M) += imx8mp-blk-ctrl.o
+obj-$(CONFIG_SOC_IMX9) += imx93-pd.o
diff --git a/drivers/soc/imx/imx93-pd.c b/drivers/soc/imx/imx93-pd.c
new file mode 100644
index 000000000000..d4f8a8941759
--- /dev/null
+++ b/drivers/soc/imx/imx93-pd.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2022 NXP.
+ */
+
+#include <linux/clk.h>
+#include <linux/of_device.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <dt-bindings/power/fsl,imx93-power.h>
+
+#define IMX93_SRC_MEDIAMIX_OFF		0x2400
+
+#define MIX_SLICE_SW_CTRL_OFF		0x20
+#define SLICE_SW_CTRL_PSW_CTRL_OFF_MASK	BIT(4)
+#define SLICE_SW_CTRL_PDN_SOFT_MASK	BIT(31)
+
+#define MIX_FUNC_STAT_OFF		0xB4
+
+#define FUNC_STAT_PSW_STAT_MASK		BIT(0)
+#define FUNC_STAT_RST_STAT_MASK		BIT(2)
+#define FUNC_STAT_ISO_STAT_MASK		BIT(4)
+
+struct imx93_slice_info {
+	char *name;
+	u32 mix_off;
+};
+
+struct imx93_plat_data {
+	u32 num_slice;
+	struct imx93_slice_info *slices;
+};
+
+struct imx93_power_domain {
+	struct generic_pm_domain genpd;
+	struct device *dev;
+	void * __iomem base;
+	const struct imx93_slice_info *slice_info;
+	struct clk_bulk_data *clks;
+	int num_clks;
+};
+
+#define to_imx93_pd(_genpd) container_of(_genpd, struct imx93_power_domain, genpd)
+
+struct imx93_slice_info imx93_slice_infos[] = {
+	[IMX93_POWER_DOMAIN_MEDIAMIX] = {
+		.name      = "mediamix",
+		.mix_off = IMX93_SRC_MEDIAMIX_OFF,
+	}
+};
+
+struct imx93_plat_data imx93_plat_data = {
+	.num_slice = ARRAY_SIZE(imx93_slice_infos),
+	.slices = imx93_slice_infos,
+};
+
+static int imx93_pd_on(struct generic_pm_domain *genpd)
+{
+	struct imx93_power_domain *domain = to_imx93_pd(genpd);
+	const struct imx93_slice_info *slice_info =  domain->slice_info;
+	void * __iomem addr = domain->base + slice_info->mix_off;
+	u32 val;
+	int ret;
+
+	ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
+	if (ret) {
+		dev_err(domain->dev, "failed to enable clocks for domain: %s\n", genpd->name);
+		return ret;
+	}
+
+	val = readl(addr + MIX_SLICE_SW_CTRL_OFF);
+	val &= ~SLICE_SW_CTRL_PDN_SOFT_MASK;
+	writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
+
+	ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
+				 !(val & FUNC_STAT_ISO_STAT_MASK), 1, 10000);
+	if (ret) {
+		dev_err(domain->dev, "pd_on timeout: name: %s, stat: %x\n", genpd->name, val);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int imx93_pd_off(struct generic_pm_domain *genpd)
+{
+	struct imx93_power_domain *domain = to_imx93_pd(genpd);
+	const struct imx93_slice_info *slice_info =  domain->slice_info;
+	void * __iomem addr = domain->base + slice_info->mix_off;
+	int ret;
+	u32 val;
+
+	/* Power off MIX */
+	val = readl(addr + MIX_SLICE_SW_CTRL_OFF);
+	val |= SLICE_SW_CTRL_PDN_SOFT_MASK;
+	writel(val, addr + MIX_SLICE_SW_CTRL_OFF);
+
+	ret = readl_poll_timeout(addr + MIX_FUNC_STAT_OFF, val,
+				 val & FUNC_STAT_PSW_STAT_MASK, 1, 1000);
+	if (ret) {
+		dev_err(domain->dev, "pd_off timeout: name: %s, stat: %x\n", genpd->name, val);
+		return ret;
+	}
+
+	clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
+
+	return 0;
+};
+
+static const struct of_device_id imx93_power_domain_ids[] = {
+	{ .compatible = "fsl,imx93-src", .data = &imx93_plat_data, },
+	{},
+};
+
+static int imx93_pd_remove(struct platform_device *pdev)
+{
+	struct imx93_power_domain *pd = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	const struct imx93_plat_data *data = of_device_get_match_data(dev);
+	u32 num_domains = data->num_slice;
+	struct device_node *slice_np, *np;
+	int ret;
+
+	slice_np = of_get_child_by_name(pdev->dev.of_node, "slice");
+
+	for_each_child_of_node(slice_np, np) {
+		struct imx93_power_domain *domain;
+		u32 index;
+
+		if (!of_device_is_available(np))
+			continue;
+
+		ret = of_property_read_u32(np, "reg", &index);
+		if (ret) {
+			dev_err(dev, "Failed to read 'reg' property\n");
+			of_node_put(np);
+			return ret;
+		}
+
+		if (index >= num_domains) {
+			dev_warn(dev, "Domain index %d is out of bounds\n", index);
+			continue;
+		}
+
+		domain = &pd[index];
+
+		of_genpd_del_provider(np);
+
+		pm_genpd_remove(&domain->genpd);
+		clk_bulk_put_all(domain->num_clks, domain->clks);
+	};
+
+	return 0;
+}
+
+static int imx93_pd_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct imx93_plat_data *data = of_device_get_match_data(dev);
+	const struct imx93_slice_info *slice_info = data->slices;
+	struct imx93_power_domain *pd;
+	u32 num_domains = data->num_slice;
+	struct device_node *slice_np, *np;
+	void __iomem *base;
+	bool is_off;
+	int ret;
+
+	slice_np = of_get_child_by_name(dev->of_node, "slice");
+	if (!slice_np) {
+		dev_err(dev, "No slices specified in DT\n");
+		return -EINVAL;
+	}
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	pd = devm_kcalloc(dev, num_domains, sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pd);
+
+	for_each_child_of_node(slice_np, np) {
+		struct imx93_power_domain *domain;
+		u32 index;
+
+		if (!of_device_is_available(np))
+			continue;
+
+		ret = of_property_read_u32(np, "reg", &index);
+		if (ret) {
+			dev_err(dev, "Failed to read 'reg' property\n");
+			of_node_put(np);
+			return ret;
+		}
+
+		if (index >= num_domains) {
+			dev_warn(dev, "Domain index %d is out of bounds\n", index);
+			continue;
+		}
+
+		domain = &pd[index];
+
+		domain->num_clks = of_clk_bulk_get_all(np, &domain->clks);
+		if (domain->num_clks < 0) {
+			return dev_err_probe(domain->dev, domain->num_clks,
+					     "Failed to get %s's clocks\n",
+					     slice_info[index].name);
+		}
+
+		domain->genpd.name = slice_info[index].name;
+		domain->genpd.power_off = imx93_pd_off;
+		domain->genpd.power_on = imx93_pd_on;
+		domain->slice_info = &slice_info[index];
+		domain->base = base;
+
+		is_off = readl(domain->base + slice_info->mix_off + MIX_FUNC_STAT_OFF) &
+			FUNC_STAT_ISO_STAT_MASK;
+		/* Just to sync the status of hardware */
+		if (!is_off) {
+			ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
+			if (ret) {
+				dev_err(domain->dev, "failed to enable clocks for domain: %s\n",
+					domain->genpd.name);
+				clk_bulk_put_all(domain->num_clks, domain->clks);
+				return 0;
+			}
+		}
+
+		dev_info(dev, "%s: state: %x\n", domain->genpd.name,
+			 readl(domain->base + MIX_FUNC_STAT_OFF));
+		ret = pm_genpd_init(&domain->genpd, NULL, is_off);
+		if (ret) {
+			dev_err(dev, "failed to init genpd\n");
+			clk_bulk_put_all(domain->num_clks, domain->clks);
+			return ret;
+		}
+
+		ret = of_genpd_add_provider_simple(np, &domain->genpd);
+		if (ret) {
+			clk_bulk_put_all(domain->num_clks, domain->clks);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct of_device_id imx93_dt_ids[] = {
+	{ .compatible = "fsl,imx93-src", .data = &imx93_plat_data, },
+	{ }
+};
+
+static struct platform_driver imx93_power_domain_driver = {
+	.driver = {
+		.name	= "imx93_power_domain",
+		.owner	= THIS_MODULE,
+		.of_match_table = imx93_dt_ids,
+	},
+	.probe = imx93_pd_probe,
+	.remove = imx93_pd_remove,
+};
+module_platform_driver(imx93_power_domain_driver);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX93 power domain driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

