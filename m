Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF5D564648
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbiGCJNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbiGCJNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:13:43 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80049.outbound.protection.outlook.com [40.107.8.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E3E2ADD;
        Sun,  3 Jul 2022 02:13:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiTItiJWLp3LxZUJSZAJtadCMBsNVUBkERz3KTo9OiLHxOha2aGS5+ROz9CgAXClkA3t/qLdG3ATlO9+0Oq74QJqfUb+yQT93lPsxHI9U5agDM3dxdJj9y/aTfC4WFTbN9TfAOlv0eklEbbnMoNDcHcqtnEwrDlz3PaAfkI2HjY2q+uHdecy8cJlDi1KwKRMIu/q8YjiXDl/u4Adx47Hl9SGLSdIzar8KtoRridPgsOPGY3gtmDLkhNnqpE5zBMtCf+ALjR7d6M9DKeQy16IYx803ndjky4BUtm96GRBy47mR27dxrpNqjSOqmh3oMmZbRcCmz1XCT9Xv46n+lmEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFq1v/soRy1/PKRZfFG3yla4ySPLxECTvPTdp6CXbQs=;
 b=JlT8IDWQWB8kaf9bSAbqUTU+G/YyaYY+s6GBarMb023N808YbnQ2N4Xh+RiHj3E7PJPLpnGwkm2V0RYscMC50drED3HsGWkl33x9loUHZN7AMY/hGDuS1ISMu3s+c+MV4zUPr229pWBxKPmFCg6ltu9uY7v/CMbgwF3z7JgB1yT8x57jGeDJQoxm561ZbBaskA30Uu1UK8/s+e1tqY6KXI4wB3Mb3JQv5EfURMzyzO3o2Y4dMtDnUfho3KmA8tFIh1g6sHdcW0hf4Kan7VW7HKripJOd1G+WT+vrqvT5uHEQZQALcxbi4pvcUD0aazzWFuWMQjggynnorR+oavdIYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFq1v/soRy1/PKRZfFG3yla4ySPLxECTvPTdp6CXbQs=;
 b=U2ggaifueQxSB9+ZtTXdORuh21+S1q/o7/bYLr1pSwuRjKdpKDSH5Yfe982LzhXab/2Be6q1x+/WF9RsbxTfQxrwg5tjcZk++TkTsf7OAgvJLwbUZV5jA44KUzPV4xDXyKL2KR6ZdrpcFhq/WBlXh025OV5tiD45sAgZ9er99tk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7768.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Sun, 3 Jul
 2022 09:13:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 09:13:39 +0000
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
Subject: [PATCH V3 5/7] soc: imx: add icc paths for i.MX8MP hsio/hdmi blk ctrl
Date:   Sun,  3 Jul 2022 17:14:49 +0800
Message-Id: <20220703091451.1416264-6-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 68d7e8c9-26c6-4737-f1b6-08da5cd4513c
X-MS-TrafficTypeDiagnostic: AS8PR04MB7768:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zhTAr7MOJWdlpD+2k4FM+ys5tggs4bxhWhUKnQ5q+Y9MxdNtWUh1RppC6HkTfddc1KNf0lfw1AlKmNM+phTtZn43NZVHK0wII+gploExqTIqp9vr8KlCRiXX/ZkIFnHkCzCOWdJz40FB1iu5o0qJbMJgv/bjnkaTJOsV6xSyNuJcDaBMalmH5mL+4wT47SPxDidM4W+qijyqplo4YcGFAqgab+0WrOU9vCDVKraVqnG9GMtTJvSHTH3GrC+lbG83m4UWtgpVCRNDuvTiIH2BwzRZHCEtvDu1GbhQvHc0i3umo9kwhqtn88ScDbpJa7iwM4py3VLrd7q1KtMyDCwdNvrfBpTLY6QZS8M/rDmfegmsXcfVe9qe9qW0FJpuJb6ENGhz59iDYTfn3IJq/NVfq+W8uk2g0tNQYuc6c3KTiwGi/JXVEyNxtfq5Kht3CDtQdffy2jT9Mkp+vMBbP8Gf8Olgt1fHBh2EX5KZA2bTC46jUGokh5HB7gdmrYIPpDIRT3S46B7A6IExZoqLopRsZMTN6gRGuP8Il1iLPQ5u/WuEYXL3pVVhZ0nixrlWjaSjIxo7E+ML6OS5LuoueP9lLDXhV75WWUGm0bRfh31jjoso4ilsixlHGGBZDBcYtTI4yW/kEWxVIt00TMYTx4ac4+sX0XzOQ5CJ4Dp1gMYBrX+Wvymrrf7vgC/PZhtFWKH2dx1WHFBSE3TxX9jNfTbU1LZQxm0hPFbph9KuQ2NDSea0Wd8rhsVQJPOJUGxkEq98YhnKCWiRNlqNIsjWv1LFNUlB77sgILTieLBfmdN0STnWhvi42tOvdTVoi+gk7Ku/+Q4K8yO+2NXy/THxPJ0W3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(478600001)(5660300002)(8936002)(7416002)(921005)(316002)(86362001)(6486002)(4326008)(8676002)(66476007)(66556008)(66946007)(83380400001)(2616005)(1076003)(186003)(6512007)(26005)(52116002)(2906002)(41300700001)(38100700002)(38350700002)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CR81HfM0ACNBMZ7K5Kv57lANVlMt4/iBYr595PLWSi+rIZVIyr1pYN5kP066?=
 =?us-ascii?Q?dbKv4aug/WF8/zhj+7i8pNafS9E2GAuJvT2jT+/EUyQRO7nwcjvw9rKr7STE?=
 =?us-ascii?Q?xPoWTKik66l+X24ZdVXWZqnyZ9bg5s+7LAWFXyfZ6B+dFUHv6gLB1Eg0X1GL?=
 =?us-ascii?Q?M5WqGcBJdwZhVo1ZPY43raN9TXVRlV/Ovnw51g9G4KFHlbqHXKLfuRd4l0ka?=
 =?us-ascii?Q?1gQ8UzLYxR350DbTRYCT6Wbq6aqK3Ui8LXwmpmshdIB3N1LrGzzFheg2BZoA?=
 =?us-ascii?Q?CD8Zw5jOe2EfwIKU8A4u5bQiCWWEDWYxU5utMSQ/4SekFzOju2vpO5m7+BaY?=
 =?us-ascii?Q?9vTt7OWI7fpzkfULOPq1O61Zf79GpLEjtA3Aq6no/bU1W5TMiaChIXVSicC/?=
 =?us-ascii?Q?KAg2V2XKE5hLAmc3I4sGUbIIx/CyAF3ebQHCDHPmPzSdcB4JXTG78dbWynY6?=
 =?us-ascii?Q?pZeuulj+j6TFgWv6RkRfX+s780Bqh+yUlBUzQdWxdSxWo591R0V0WbGJtop1?=
 =?us-ascii?Q?bizkxsU2PUBrwgxyfASNG+pxSR9pKA4otOiqfUMI05TnnbEsAgccm2QQ6VRJ?=
 =?us-ascii?Q?5i4xVjOtMENJJI0yIWOowCqT90bMIKRpZl4gKmBZEmBBMKpCOdNqxtdcvL9d?=
 =?us-ascii?Q?3UVUBpKhOKWP4LoR2nukcRxiIo57N0lOdL5gM9rYMw7XpcFWI5HtNbZMOHAl?=
 =?us-ascii?Q?QdQpqtF6TPpEZvFtHAQXXq6UE2dColqUC1M4pxuXr3dsM8EvMTuVyVMbtVEo?=
 =?us-ascii?Q?xTCpaeya63zVid7OCaTMdtQGlJ5kWSwSh25SLUetMw4ee4elFjDHTVo2ezMC?=
 =?us-ascii?Q?clt/Y9xMZn4v33ZBczzXuLB9GyC3zrAxIULl2lYorItxt/106RljW8hZx3a7?=
 =?us-ascii?Q?vis6OmgxU8jAo2jie3bX6JJCbtf1/Sx8yTxUsltVw5XCeeNgFcvM5Jh4Vzrh?=
 =?us-ascii?Q?SJdmGiQd0QY36HeSgK8cPqf8xzijpQXGTW9e48/zxtTqD3AMR+ilZ2nxLvEu?=
 =?us-ascii?Q?oiBG1lHaO9q+cCQiDdxBCobVkyQD2fdbAni6Kp5ndF0027fTuqKj7xMYPuA1?=
 =?us-ascii?Q?L86Zfn4Do44anlflqKyfZewnduNWSfwsRkg0Oy2+zwChycAjbF9FkncRIvLq?=
 =?us-ascii?Q?0nPh8fhTPhiJRKp6gaUxAn/lwFkEKOou8eoJAHWkpfngx02UlO8allzDKSP0?=
 =?us-ascii?Q?k7ZBw90C76aVxVXGW2DTKU2821nKU9VniBV+nyIHotTXT48WvKDsJ06E42dR?=
 =?us-ascii?Q?4mU9MNNlPWhmTyLAQICnQImWJZIS/SvlXdq34bLupjzDkgrYsrEZDTyJtRlg?=
 =?us-ascii?Q?zKZCuMIXICh79qZ51mD9yVUCqWtDEozSMSvSBmpmw4OgnXxhQEdvUMFvhF0D?=
 =?us-ascii?Q?RqXO1bIeC8fwL7jb5gjpsNstbLkpCV9oDaP21RNG8u6kP76Z0Miu16vCzgMd?=
 =?us-ascii?Q?wgcTnCVIqwUwFLiGhOiSqOjB910wDoRXALT0wSvZAG2U6j7LCNIomznQyp1z?=
 =?us-ascii?Q?J7mpDyPeeMexaz5fD+EPQBkNWr/ewXunbmQnhxXpT/65vV5Ca3ZavBchCkR2?=
 =?us-ascii?Q?ji25XCfcXgSqbkD6yY8LWlEoHBcaFHq3d6wIRW7l?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d7e8c9-26c6-4737-f1b6-08da5cd4513c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 09:13:39.3991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Ruxea1xvw/0exi3OwqO05WkdY98OlbNsoccCkGe5IJer5v7jaedDW7hVZaoK3b/SNlHmvN0MGuKKK721sl2yw==
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

Add interconnect paths for i.MX8MP hsio/hdmi blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/imx8mp-blk-ctrl.c | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 4ca2ede6871b..6f983adcb47c 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -6,6 +6,7 @@
 
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/interconnect.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -36,17 +37,22 @@ struct imx8mp_blk_ctrl_domain_data {
 	const char *name;
 	const char * const *clk_names;
 	int num_clks;
+	const char * const *path_names;
+	int num_paths;
 	const char *gpc_name;
 };
 
 #define DOMAIN_MAX_CLKS 2
+#define DOMAIN_MAX_PATHS 3
 
 struct imx8mp_blk_ctrl_domain {
 	struct generic_pm_domain genpd;
 	const struct imx8mp_blk_ctrl_domain_data *data;
 	struct clk_bulk_data clks[DOMAIN_MAX_CLKS];
+	struct icc_bulk_data paths[DOMAIN_MAX_PATHS];
 	struct device *power_dev;
 	struct imx8mp_blk_ctrl *bc;
+	int num_paths;
 	int id;
 };
 
@@ -144,6 +150,8 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hsio_domain_data[] = {
 		.clk_names = (const char *[]){ "usb" },
 		.num_clks = 1,
 		.gpc_name = "usb",
+		.path_names = (const char *[]){"usb1", "usb2"},
+		.num_paths = 2,
 	},
 	[IMX8MP_HSIOBLK_PD_USB_PHY1] = {
 		.name = "hsioblk-usb-phy1",
@@ -158,6 +166,8 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hsio_domain_data[] = {
 		.clk_names = (const char *[]){ "pcie" },
 		.num_clks = 1,
 		.gpc_name = "pcie",
+		.path_names = (const char *[]){"noc-pcie", "pcie"},
+		.num_paths = 2,
 	},
 	[IMX8MP_HSIOBLK_PD_PCIE_PHY] = {
 		.name = "hsioblk-pcie-phy",
@@ -322,6 +332,8 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hdmi_domain_data[] = {
 		.clk_names = (const char *[]){ "axi", "apb" },
 		.num_clks = 2,
 		.gpc_name = "lcdif",
+		.path_names = (const char *[]){"lcdif-hdmi"},
+		.num_paths = 1,
 	},
 	[IMX8MP_HDMIBLK_PD_PAI] = {
 		.name = "hdmiblk-pai",
@@ -395,6 +407,10 @@ static int imx8mp_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 		goto clk_disable;
 	}
 
+	ret = icc_bulk_set_bw(domain->num_paths, domain->paths);
+	if (ret)
+		dev_err(bc->dev, "failed to set icc bw\n");
+
 	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
 
 	return 0;
@@ -510,10 +526,29 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
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
-- 
2.25.1

