Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A02530FE3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiEWL3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbiEWL3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:29:05 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80045.outbound.protection.outlook.com [40.107.8.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C274ECF1;
        Mon, 23 May 2022 04:29:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPWOG5Ml9FxMK5QHqsbFi0gnSV3piVftirdrwtUD0A1qm/CruJ0NWV00++dXG5tBFVGniU1gUeQXhK0uRs6DcDc/mNHGBlqfeMk21WpyL4Qn9NR8slKKe3RZF6N3AKKJu7ROo4ZgIqwJEQBiw3D8MGL20LRC2peasrHZMtEsAZkyTM63Er6MRgB3B6BVmESMvVXZpWxbflMTvioJy4umld0XDyU4Ilufb+48BG7CMq2hqraj/4c4aqWkZXG/vXJmOSI9YbE9qcsQH/jKHANGQbytrQLjyxQ1022bPGOBdRad2e97jBNTCd/02Alnxz5k+3OD7dUPSiaI0WxB3uicOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GRmO33QdY0dtARzi9ScMm4URWVHl3SG6xN6TjtHm9Q=;
 b=lSKk2A1Wyvui0qIAnvo4YpSS2r89wA4PQLG1H8hvIL4Jyf43jvpIKSZP9qVLl7RGiQY1ESrKIm61dTZ7Uzl9VcdHxyieZxX1TdmNVJAmvMsDR2oP1thV3alcUIg+qd3f7XdWq9v1r+Zjapaw/0U7bs0Cq5llLOzLRzn1vQEXWC6NZloFpH3kcAaWyS7p8VQ/eZXFDLnqlugySuf0CXVbs2TtIzDA0dOkaKQ3ZLSPmiMak2gdbByPORCVgYMaBcuaKTkz79tnCeYTo/bwOrTty2SqZU4Zns6OuTi3Ogp9YSyq+5bS8qk6C+yEMRouryhbTU/UfzUkWslU0NuGoKPXDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GRmO33QdY0dtARzi9ScMm4URWVHl3SG6xN6TjtHm9Q=;
 b=UXPqcWpT2ptSvYDvGaKwICQ1exxik7Qg2FamLDAcUtA4eaK8R6GuQZ2Ji8C/ggLALNbuIzLkowj4klmr4JAu54l/Kt3MOh6hfceVVPKVYP2V7AwZ1Bf1lM77Nd8QGIE5VB71A95+nEAcBFEZVO2THPUKCWAAodjCn2xQeFeBc+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6586.eurprd04.prod.outlook.com (2603:10a6:10:101::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 11:29:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5273.020; Mon, 23 May 2022
 11:29:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/7] soc: imx: add i.MX93 SRC power domain driver
Date:   Mon, 23 May 2022 19:30:26 +0800
Message-Id: <20220523113029.842753-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523113029.842753-1-peng.fan@oss.nxp.com>
References: <20220523113029.842753-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bbf7340-6abf-4042-63a0-08da3caf6f31
X-MS-TrafficTypeDiagnostic: DB8PR04MB6586:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6586DDC77D8217C6FD2AF394C9D49@DB8PR04MB6586.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: voQKLSgwJUzlxPb5jInBjke6IzCyyU2OP1Ppe+9zF4IlBO8/Ps7Bhxz92eG+CIV0D5+UdZo7seDTsRWXocs93LJio37TVBO/GLeGJncqK8nAqy0hlwLP0PVb+JeQ5ZX8owgSMsb00h5tQz0oY0F6VGP1EmV/QubDHctj5iqdZx6h2sybhbP4ydcNLG0YAPvIiYpSst83w8oZVGfECFAf7WgT6lFD+y0gWkcbk5fflz0/W/wpE1CU8tZg66G986YPEnd7PEdbvo/A6+lpotEIlhA0Kpk1gGqsXennboIk7HlPR5zPUNa+nN07hKJAzEAlgBT5wLeWD2chJrJaxAttTcme363IcTf388AZD3yGalNwck3FKmiU7tJ+t1lZI8kOvNpRyAc8WLYw4Be4zRW29BPZnhtgl1FS9QoVgDzbLkef/PS/59h2vOCXg+iETykFYrof9aBSBqAfkUVqYQ1ykRFQRc9tEn3Ga9PwUo9gyQIY6oG3MxhGPPl16wZdZCzHkWt9BDdZ54j9qjmfFsgq00imGJHE7r8/z8CP4Aflf1xsLP7YINhBXlFxfOzWQwxdmexcerbMBrM2exDALgn9/xAgK8ZMEUndHmfJ+5LVxbhOnQoqDRzKV+yzYhw7Jm0Zx4w4RuMpGhCqAqCKBPA45YlTQrdLFp9cqlpTh2opQdnPIFC0uOrIyTgYDynTi4/aR5FIBm+HffJhHX+r3iF0/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(2906002)(52116002)(6666004)(2616005)(186003)(26005)(66556008)(66476007)(8676002)(4326008)(66946007)(5660300002)(1076003)(508600001)(6486002)(6506007)(6512007)(86362001)(83380400001)(38350700002)(38100700002)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s65U25DMqHXObNndHvO40/i7HDDAF2eyQdzebmEXGgd3I9xNX01PBmMKHK08?=
 =?us-ascii?Q?g+NlOWQ/D1FI5Rf+0bwRlNdxxqvhnOD2tlNVvFkvDvuIh2iHP+57wX8Hmegq?=
 =?us-ascii?Q?MQNqa0DG/hKX1x9yW7pZTbsK+Gk7GCEJ4mmUo9UoqAOIxoul2idbRiJodb7r?=
 =?us-ascii?Q?DBnToUb3a2OX5ygJIwCxE24j0HuRJDav6ipTCBUWkRFwJ0OB6f/hORyAwXG1?=
 =?us-ascii?Q?OQ+ZGQVY6VfI6xDjDpEDpiuz/rEbOHS08ZUq3pIbW6fHZ9LKSOW+QPNNvhfC?=
 =?us-ascii?Q?dvkrjIFD0YZG+acNhSux5lYvHlgsY0bilBzCfPLD/9dgtS0f4nyL9TFvSJUO?=
 =?us-ascii?Q?uKuX6DdcoWjJiU7Di4XiWiCwY+YUNSYC/4XetCGzvqPFFczZHOWJzoAKzJUt?=
 =?us-ascii?Q?Vd+Pm01tlg/0UNPbX6dPvv5nw2OVurVF/mRTJ++NTAmpyuw+UJTKpVC5KkjV?=
 =?us-ascii?Q?OK57vnqncUudTeSMAYg+nwxgZlB5E+P1Mq8BvzcsCyBsMyyGGJY092gJa5D+?=
 =?us-ascii?Q?IcupP6EWIjsTYQ//tSaSAYb4Qn13NFmhL+BicMbrhhIM9/tp2aSGEeGgzNgO?=
 =?us-ascii?Q?fHVbYabBIHTAPO1grlWgN51CyVl2QnXWtIRJhMWT17bBzxuLaZQJlIk9UIqU?=
 =?us-ascii?Q?jGdqGToBQCITiSFipfedTj/8VSaeUDTTGly9aWHfG3w4hqyGbXf9HGLka63F?=
 =?us-ascii?Q?exCWPgOoTGgHYkMjCFMRmmQ8kVjGSjX88t5p/aeVedYTqo7sMnHzv4mpPcWP?=
 =?us-ascii?Q?tiXNsiEbAFuYuLhgM+goREcqj8o+eGaOBeWCEOrKy05L8zqj4wpp2zT3aDdV?=
 =?us-ascii?Q?QuhABeeZmeJvFdLA7MvbB6/YvAx1E4LTUF2Is/alHtZAax8zOQXjKZE1WN2x?=
 =?us-ascii?Q?QNae+/GB4nYQAxu9whjpp4NGvbWhD4OWevrAXy853aasoGjsU9rcm04URS3m?=
 =?us-ascii?Q?Sup/5LprGWgNjkpsp4a2uOjUZ+DenVrx6HQ6vvHSDfs9WQ/4kcfMpcHHuW7y?=
 =?us-ascii?Q?bLnT2jZixOCO1BB3XorxEZB8E6po4V00N4o8KqY7gDKtEhYOUG06LdZ8AgYU?=
 =?us-ascii?Q?dyb5PqTC3RvW52a5lrnbHwkUdPHVoy3ep+VYXcbkIRQkAeXJHlNjhvzy4ppM?=
 =?us-ascii?Q?CMlJnjDRYqzxcpA6gDauPgsgvD+RUMLvBDuzLLt6nqWlzPumPvzvHNa/D858?=
 =?us-ascii?Q?j00fNOT3SAJ0qD/2sA1mcJ5Ywhz0UxfnZmOYekkjp5A/ldbp9LZO7sr4Yd+/?=
 =?us-ascii?Q?pXcXgC6Ygexo6cIq8qm8nL4FRXrWFfa+elZASiQSKi78CSj9D4O0q3X0odVN?=
 =?us-ascii?Q?Jnv+cmAQBwDn+sk6tQzPmHKsCrghPb7a4oU+p1hE0scC4pCA2fLHDikmnQ9r?=
 =?us-ascii?Q?Acg/JjWeCpHvf2WzOb77ZG2xcvljrjx+1GN9E+7yufTb2YD5t2sc5nnTps54?=
 =?us-ascii?Q?M9+JmKl1CDTtLO10XkXIg+dIqvyobt2p9Q/aiMVivkg04DVh/6f4ItdZhGzr?=
 =?us-ascii?Q?fZwVWDuTtatl3Y2bhwIn7zsNKnrwBRvbOvg3ZpaWFxKAMltdiRftX2RkqV8b?=
 =?us-ascii?Q?iDQuTLSgGB07sX0kUTvKFVm9IkW64MzX3bIDFSPfnIQom/ZkYj1NwlNhjpgu?=
 =?us-ascii?Q?ron/d2RemaP0R95vVTSj7cA1boyxHdcrtOmhWZVx4y4t385xsX83rQju77bm?=
 =?us-ascii?Q?jrd/xiAW6oseJU+1iJFXqC9Jyjlu8waLGejuhSz3k7FjXU1vs8db3l8bRMc6?=
 =?us-ascii?Q?b6UYIwl2wA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbf7340-6abf-4042-63a0-08da3caf6f31
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 11:29:01.1609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqzoFgRYXgfA9WDuIsHBLFmdd5XBQLl8+84Hw4A3UG2oxEUIROyYy1xaI20yLDfsw1yptlmRa4ARTgniEpZySA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6586
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index 000000000000..c6d204b51c14
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
+#include <dt-bindings/power/imx93-power.h>
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

