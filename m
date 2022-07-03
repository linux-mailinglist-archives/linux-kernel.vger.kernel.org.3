Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8247C564642
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiGCJNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiGCJNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:13:39 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80080.outbound.protection.outlook.com [40.107.8.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F585FBB;
        Sun,  3 Jul 2022 02:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nuwMxxR+BMPo7uOYT/k/Wsx+p32lFOwGTJMSKL8fAQCjh5HrvRn9Xp76KHR0aVD0/uE8/L0ichS4vpwafXyEDOmgaYCKHflBIT9IhKTAKFUJ+SmsGXf2LNC9wrlmCyscZCHd5o8odKHdEYXScqpI3LEpZN9e0Lx3OcnU/zAOf4wCT91n0UPp3w7FeLaKuvFm3g5fJjbboUDYta2J13p9cdQG0yjrUjHDVPYF3ybTf4t4/EVsQENjBqs2JzSPNo2hWHFcM76JjQ9dTUSF/3CU9w0UV6poosu6J26kbQCQ54joctMiUoWlY5WnakFCL9Bc44IUG6VyA5fnNrUXckiZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOopy64MQy6CMEomqOMI6JoOnLtFW9zU1O5Kq0iz5Tw=;
 b=JyDPQUCy7ICeBXH/WTx8zqVJD5oQjI/+qVUrT05YuhY3u1SOnB7oGPnirLGh0f7LwSEuSaZ60t0XLD2WBbfGUPXkFqC3b9nHx4quoXRta8U9nrXNlgco/hvvPPJEH6B2c0pfqZyomwYjtPfI9GpieazHaRfOhoDelzqDt26eEW1UC0uZe/O29x9U5xAkejtnj+pqNi1De6PkhtBrFXpfZd0NiV+ikyd6KdD77+60oFmTbG0LhKbqR5Fxsv6vzNN3GeHDlTTL05Pukc8v3VUD7YIXO/fBkWQOkJ+4LRuPchvuTzoJw+HBxD0wkDd2ca2HCBTfk+AiJH78jwU/ZHPsEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOopy64MQy6CMEomqOMI6JoOnLtFW9zU1O5Kq0iz5Tw=;
 b=lVDF+XI11e4dC75SRbnXytDKe54q9JKELB5SUm83HhCEYZajWKSCaaf4SjATW0r/y4qc8ZF1qWEm62CeL3E6KxS2cn96RV5EpDXS8dFAuGDrp507u1aK7rAe+BIr4MS2HtI9LfaEtwrUTXiIYUCpPclTvYm55vk7RjerjLZ/ZpE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7768.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Sun, 3 Jul
 2022 09:13:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 09:13:33 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abelvesa@kernel.org,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 4/7] soc: imx: add icc paths for i.MX8MP media blk ctrl
Date:   Sun,  3 Jul 2022 17:14:48 +0800
Message-Id: <20220703091451.1416264-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703091451.1416264-1-peng.fan@oss.nxp.com>
References: <20220703091451.1416264-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b469541c-e37e-420f-1e89-08da5cd44dcf
X-MS-TrafficTypeDiagnostic: AS8PR04MB7768:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QR9pnvVXfYMhOzGENDod84FnKLim7BO4k3UzH3GWaUbKP8E5DbBZKaFqYlpqQhZrrsGk20+NZMdwjJlhTo+vsi4S4OqVhuUu26SunKx2DdLCy9H0omRDrulA5fEGKfZuVdl9HEMyVY+J5Y+MNfi/X75QBqAFu9rAxHSqxq/kdmCkcdcoHSlW1yJFLuja72GA7Dsx/cRzGl/4XsTqDS08uzBEuZof4gAt261NryhPu2DFjyW0a3/+L596TfOoMNZPpDyTRBYIkqzu/+O5GmByBXTsomIVBpOQePNbvxxba7UlrbGCuTL3aYwg0TadyRcEixS/pXzu/YOwOeyYHqwDzAP7oJXB7Pkr5jeAXsP51XT2MqpGWMa++jeigoJdbvtsryUM5mFG4cG+3DoQ/q++kiHlZI+e6oFsaWS8T2GaowDiSVrVlMElI9i8+P9lxx2Z+c7//Z/DPVnl9YgvvQmRL6a34cj/2LdpAIFi4P0cwtYydTp1hwm0j6oHvuACaHr/bvLFkvJDhBvhMQDL+tsd6F9HPml/b6ECGFslol2A90udtz4TNd/SSmRrUXwgjlp1QGk0gvG14vGuDv4sp7F88hjOTFBoAxZ5rlc1pVImLipYGsujZkUUKXPt2XVsmlU3+XBx34d9yZFdhMX2aOOFz8LNBrsr+9v4cZxFjm542knHExJlhe0iXhd9g3nGxIwzd66gyOpMqnGcVG6zrvApv1M0yYGm0DLJVKSuX4mzIzGbyQdwP+RWYNnTy5Cx6kBFDTzZLSmF6tyQ+SPAoedGVALPjEHzWcN9vgW52dbWYIVLu5QIlDSeTHnE3LI+dDVO52TFKbJiBUbQP/QU1eG2WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(478600001)(5660300002)(8936002)(7416002)(921005)(316002)(86362001)(6486002)(4326008)(8676002)(66476007)(66556008)(66946007)(83380400001)(2616005)(1076003)(186003)(6512007)(26005)(52116002)(2906002)(41300700001)(38100700002)(38350700002)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8pg48xRHHVaScBiDSsqbhMw/mVdAjJRdGjiSSzspOKU+ic/MichVxtcpHb8F?=
 =?us-ascii?Q?KawgsryGTvTNGUUUGT/QDK8A7GrT55TRDtKpr4K4dySVpFpmUUzNLa9IU6Y2?=
 =?us-ascii?Q?UdTj+O3jKq05cjmBX+rojrUO7NhwtwzhRn20ffAqp5/Plh8dOElZWLJkvLYM?=
 =?us-ascii?Q?pPvZWRhGgmVeHXDMg4RxvOXPrNHuvfEVH0IhI6jMAgekMo9XD9EEBlPuNGIm?=
 =?us-ascii?Q?xhlME5MR0DkG8T4kYVadIo4r8JgtV//mbyKfgJSZn6l1BTlkmPt4SiGacnbO?=
 =?us-ascii?Q?YM0W1VmAkXLqcj8y+Kq3706SXA8xeNoRAOMeeZHMfJv+R/1JKRkzYoSuuXtU?=
 =?us-ascii?Q?A+f4OcaMDNPf7NtrvhkBt1DfHP+gsgX0iEVy9k6xaByNdDCBuEWcRxCfh0fV?=
 =?us-ascii?Q?vW4ZAJ+8lYyawHefAyBAyc4HJ2ccRJEdUXH24dyp3G99hAEOGaDbQ+A+qLgD?=
 =?us-ascii?Q?98ceFoML1cS7k/epW5Su9g0ldJMHxk+oI9gLCwqtraVyhmGSjhYjoOvtexDu?=
 =?us-ascii?Q?Ys6pPRabfiIhbxqgmZ5WdMVSa0UGnfJOvV3BLLx8UDBplaf0tu8mZ22/Koqg?=
 =?us-ascii?Q?/q0jZkGlQMJ5quijYUQXqiXv9fQs3Y5PfMdl2G2atzd6ADii0lpUnf+cGXKg?=
 =?us-ascii?Q?DQJalyp4YtFOk/z1/QgSvr6iZs7zkABrVgNjBjOWTTCOLcaEFh+K//tPYq8Q?=
 =?us-ascii?Q?YKA/P+u19hGD/8LejkRig/xH6xNKUlrGbk7Nys02ivY2OBZe5JbWQ5kBmGPt?=
 =?us-ascii?Q?+vRa3gEySdLaikwfEjRVHib+1MaAYegGkzRptceycZMdiq2o0NGJzI9ccLrp?=
 =?us-ascii?Q?FrslpYvoqA0C69zQbLsZTAzh7sGZYs6G9deNmSJbJWHtUOVfVpIrY58kyAwy?=
 =?us-ascii?Q?+4GVqSVt4F+WjaGWjaEgC7Ugp66j9AuCsXnhLuagIY5JuVQbzWcqqbUwz88j?=
 =?us-ascii?Q?OB6pm9Egj+3kgYfxs/lSXWmyCR/Kw7LNUUOIUw2eZ2ZFHkCBmKfM2Nq0gHX3?=
 =?us-ascii?Q?LILlGpAnJXonI+H1Hr3zJ8+R4kUNVCTrBxW8MoUN+ZAYzHENONLLCBJBTe7A?=
 =?us-ascii?Q?GPaHxyHCvgdqqs/kot38drR8aYOBILzCIunGwxyHYT121wlu2rtH4uW575D+?=
 =?us-ascii?Q?RVRbxz7dh3C+cvr1Cm1RMaQUJ2yDZ81lYdXvsZDT8UiVH2hHJQWV5e5Js13b?=
 =?us-ascii?Q?cpnDSAsCFBVvrjye8mRzHFXAAo3Q/E63RSM0jclQ4/LXQC1h4kFuCCz6dQt/?=
 =?us-ascii?Q?XkJT12GFwYGZYkn9+4Q+9bIdqnRmWM7ef6B16vpWr+LxG3L/Wxau5OQjn1l3?=
 =?us-ascii?Q?gIjFcadchw3OloWuUAmbht2EWFPj5E84bt5uOFPmfmD0LCVYYcrzW3veZ7JP?=
 =?us-ascii?Q?encYwYENhZWzkztzTeCz9EISfe71i4cNf+MO/RkjJBcqpKNvREWmXLrxu5k4?=
 =?us-ascii?Q?9lu9Sj7h5eTQEEEZQq8BNpN1eSB1HnMvPk1IltsKHQ8WfYla+Hf67dJQ2397?=
 =?us-ascii?Q?iqT1uq9dShfWWXDvv5rWIHoIU5KSBkDaztMO1ETydcZCCbW1o0cG4YBOBNxG?=
 =?us-ascii?Q?grq1zzRU/+M99LPI3x48XZfy9cGYyxzeS+SKrdqQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b469541c-e37e-420f-1e89-08da5cd44dcf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 09:13:33.6306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBZwbyepHlwgAz3dfcSwbWob6+a1s9/E3CN6DtEDQFacNWNnELHakQG2ER9zuSCrWJSCHqzYawRSPqtSfFPLeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7768
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add interconnect paths for i.MX8MP media blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index dff7529268e4..9b0f81dc292b 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/interconnect.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -37,6 +38,8 @@ struct imx8m_blk_ctrl_domain_data {
 	const char *name;
 	const char * const *clk_names;
 	int num_clks;
+	const char * const *path_names;
+	int num_paths;
 	const char *gpc_name;
 	u32 rst_mask;
 	u32 clk_mask;
@@ -52,13 +55,16 @@ struct imx8m_blk_ctrl_domain_data {
 };
 
 #define DOMAIN_MAX_CLKS 4
+#define DOMAIN_MAX_PATHS 4
 
 struct imx8m_blk_ctrl_domain {
 	struct generic_pm_domain genpd;
 	const struct imx8m_blk_ctrl_domain_data *data;
 	struct clk_bulk_data clks[DOMAIN_MAX_CLKS];
+	struct icc_bulk_data paths[DOMAIN_MAX_PATHS];
 	struct device *power_dev;
 	struct imx8m_blk_ctrl *bc;
+	int num_paths;
 };
 
 struct imx8m_blk_ctrl_data {
@@ -117,6 +123,10 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 	if (data->mipi_phy_rst_mask)
 		regmap_set_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
 
+	ret = icc_bulk_set_bw(domain->num_paths, domain->paths);
+	if (ret)
+		dev_err(bc->dev, "failed to set icc bw\n");
+
 	/* disable upstream clocks */
 	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
 
@@ -224,10 +234,29 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 		int j;
 
 		domain->data = data;
+		domain->num_paths = data->num_paths;
 
 		for (j = 0; j < data->num_clks; j++)
 			domain->clks[j].id = data->clk_names[j];
 
+		for (j = 0; j < data->num_paths; j++) {
+			domain->paths[j].name = data->path_names[j];
+			/* Fake value for now, just let ICC could configure NoC mode/priority */
+			domain->paths[j].avg_bw = 1;
+			domain->paths[j].peak_bw = 1;
+		}
+
+		ret = devm_of_icc_bulk_get(dev, data->num_paths, domain->paths);
+		if (ret) {
+			if (ret != -EPROBE_DEFER) {
+				dev_warn_once(dev, "Could not get interconnect paths, NoC will stay unconfigured!\n");
+				domain->num_paths = 0;
+			} else {
+				dev_err_probe(dev, ret, "failed to get noc entries\n");
+				goto cleanup_pds;
+			}
+		}
+
 		ret = devm_clk_bulk_get(dev, data->num_clks, domain->clks);
 		if (ret) {
 			dev_err_probe(dev, ret, "failed to get clock\n");
@@ -650,6 +679,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
 		.gpc_name = "lcdif1",
 		.rst_mask = BIT(4) | BIT(5) | BIT(23),
 		.clk_mask = BIT(4) | BIT(5) | BIT(23),
+		.path_names = (const char *[]){"lcdif-rd", "lcdif-wr"},
+		.num_paths = 2,
 	},
 	[IMX8MP_MEDIABLK_PD_ISI] = {
 		.name = "mediablk-isi",
@@ -658,6 +689,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
 		.gpc_name = "isi",
 		.rst_mask = BIT(6) | BIT(7),
 		.clk_mask = BIT(6) | BIT(7),
+		.path_names = (const char *[]){"isi0", "isi1", "isi2"},
+		.num_paths = 3,
 	},
 	[IMX8MP_MEDIABLK_PD_MIPI_CSI2_2] = {
 		.name = "mediablk-mipi-csi2-2",
@@ -675,6 +708,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
 		.gpc_name = "lcdif2",
 		.rst_mask = BIT(11) | BIT(12) | BIT(24),
 		.clk_mask = BIT(11) | BIT(12) | BIT(24),
+		.path_names = (const char *[]){"lcdif-rd", "lcdif-wr"},
+		.num_paths = 2,
 	},
 	[IMX8MP_MEDIABLK_PD_ISP] = {
 		.name = "mediablk-isp",
@@ -683,6 +718,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
 		.gpc_name = "isp",
 		.rst_mask = BIT(16) | BIT(17) | BIT(18),
 		.clk_mask = BIT(16) | BIT(17) | BIT(18),
+		.path_names = (const char *[]){"isp0", "isp1"},
+		.num_paths = 2,
 	},
 	[IMX8MP_MEDIABLK_PD_DWE] = {
 		.name = "mediablk-dwe",
@@ -691,6 +728,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
 		.gpc_name = "dwe",
 		.rst_mask = BIT(19) | BIT(20) | BIT(21),
 		.clk_mask = BIT(19) | BIT(20) | BIT(21),
+		.path_names = (const char *[]){"dwe"},
+		.num_paths = 1,
 	},
 	[IMX8MP_MEDIABLK_PD_MIPI_DSI_2] = {
 		.name = "mediablk-mipi-dsi-2",
-- 
2.25.1

