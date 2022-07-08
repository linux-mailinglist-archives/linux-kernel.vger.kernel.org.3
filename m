Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D71F56B4E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 10:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbiGHIz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 04:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237700AbiGHIzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 04:55:22 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10077.outbound.protection.outlook.com [40.107.1.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E89C7C1B9;
        Fri,  8 Jul 2022 01:55:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQUrit+/MVWE5/vaUeZ2vtLsNT5zVeo/WeW4y/EYfIS+/0kuVP0IThww29iWYzRpl2h75tTW2niH3Cmu6qhtYVBMvuQvL9a4ygINZ4MhiFwn2b6wWUMHSbBnp1wQrSjYbF8ZlvB4FEu2GYgGUtGCVttfHM4B/GmAI8iVYbRaulJ+1/94S1wF72FyjMdL9eIvciCOCUd1wMYCmKtsSJ5Uz8Qej8Tkdd32IoXn1HIWI4iS2Za/ZCUVDAl0vIpsdC5c1tJBWZeRVRFKr3nbZXgYVeOBm4YLs8gu/KbeTTv0hN72bxXjYK8JR/UB24OLlSx0qkTyfTmfSnXt8C5WFHfy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOopy64MQy6CMEomqOMI6JoOnLtFW9zU1O5Kq0iz5Tw=;
 b=U8Ki62a57LRlJU9lc9OAq/ZwuBbBYIrBXLNe+FAD0EI+qW/8Z1CVDl9tAXyl5igR/Q23MhiIczGIVrgxUdQtNTcp1+WBio7XZywbleVH5hvMSelCPMuVRaJJPXgppac6ObdID0I9Hy360OPhBciQrBFOY36kKKIILC2P9Ly2V3qBV/UiaQt6fY2qGxSBG7XOrTXDjoXVNLeF1/WURLkv7xPRij9ne6k6eZ1ud9Sh1FoY/U+MMbl2UCowIq835k80iMRKYvWei65YWW26rRZ2lmYL9y1H1JsD77oyP2n2VzS+2yE5ZZhj3sfUM6Zqu+N8GR5S6VUpKnmxG0Mh1fr5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOopy64MQy6CMEomqOMI6JoOnLtFW9zU1O5Kq0iz5Tw=;
 b=i4juQ1RRL63yGFSqqlX0JT7J8PgVshjnj8bpApjbXUuVqZfxj7nfky1Tgpc0w2HYNRWyfjxWSAKujXMLxVf86vf/RPp7KZd5azQppaS91xX6cfa7pUv3gNmDFAJ9bd8zjuMQaY2sPPfmIn9QODh5vdUB+95QpwCa4usSkAuf0tc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6503.eurprd04.prod.outlook.com (2603:10a6:20b:ff::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.19; Fri, 8 Jul
 2022 08:55:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5417.016; Fri, 8 Jul 2022
 08:55:18 +0000
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
Subject: [PATCH V4 4/7] soc: imx: add icc paths for i.MX8MP media blk ctrl
Date:   Fri,  8 Jul 2022 16:56:29 +0800
Message-Id: <20220708085632.1918323-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708085632.1918323-1-peng.fan@oss.nxp.com>
References: <20220708085632.1918323-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::14)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 332d7639-b83f-4fb9-d296-08da60bf94dd
X-MS-TrafficTypeDiagnostic: AM6PR04MB6503:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l/T8xnDjA3fcxWJyDslz8ITP+XvMRG7gnX0gK5jeK/yKqiAvg/IXasNz1FXgB/Lj94LWgxJOoNymOJL5tSH4u4gtPKFl9+LrA5pmrwlAw3PZYl0RHiVXbUAa2S7w8BEdA5yuqA6N+BQv6WJBxQKD7wjzXYoAsLpjCECpRJQNseg4xqsAvvwKjr7v94BznzI9sg7z+VS+vub/JXKLQVnOUCCy55FW1Awo3OiVClh1gXfYADZgzF6AIgm0ey5ekWZ42HzwcFWZYfDAVzLKRRM/EO9qzN1pB21lDdLfvPDFvmi+3exPZoMV5q+t2AzHR0f16wGt0q2hh4r98+hSqYX+NMQO6ZxY/a0lSQJ1Oqoub94o1QK2pI1DMD4OPTnLQfsaINP0HDP9Ek+5QYQMjTcv55yINGSVwHm5bjOtxdcUOv6sEe5Sq/Z6hY3DR9MLZmS41L2ou2TiVXe4By9/zRSdu8jBMkzA6cztezf0EXQ/98jyttzw9JxwFasnfsPKtPkaqPSMUTUohmkxJ5rCVXe+lubBHNcDYtap23IobZyjpL1qQuSxeEFUdGVi1UQV4YokMsiAjYkvEaOuFeDNgwEwjaBKG4f+iH3UKmMNQOOdv2LtThLMixM3FMBJ7Te75Q9OP5JmNQv6uiAm7kBKY2bJueJh9Tjp3OKHwYI/s25LY3rnT+9XPktx8L2MFmCQbJKcCK0keyxpmveOl61cB/2CShlljQjijH6f2nRBPFyOgSD+zLX8/Jnz9vJknzUQCCTIdIA93wHwhraEbhA4BkQ+hs+kakM7QHFri91FQq4LLqWIcp2OxQOOSAFxqZjiw7jykCLYgPPqg7HY6IqNpBV6Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(66556008)(66476007)(186003)(66946007)(2616005)(8936002)(1076003)(7416002)(4326008)(8676002)(5660300002)(83380400001)(6512007)(52116002)(478600001)(2906002)(38350700002)(38100700002)(6506007)(26005)(6666004)(41300700001)(921005)(6486002)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hzDQEtxv0DEho7L2AQ2gOOXYKKo1bl6t5y8GxrLA4MLQkqwht+TrcDSea7bt?=
 =?us-ascii?Q?URIer3dFztj1+aR/XiCh+Iyzk9QdUDrNZvpv/ykjavyHeif0cJ22Mg6VLjeQ?=
 =?us-ascii?Q?fUiRs0xl/5IDwP/8gRCXmaUPds9lpiS16buO/VioA5PIudj0Y3m47LYelqSx?=
 =?us-ascii?Q?XloWaxWCC1HvQcgNvoFVFuEa/ex+s3yM7n010zgLZSLc8cEa+nJRZia0Rq73?=
 =?us-ascii?Q?W8Z94n0cIN/nkqovGhyRmouy8GIAJIA/CYXuUV09x08UlaZ0w4IvCjgZ/HnK?=
 =?us-ascii?Q?qkN+1K54ebSqs/u5eJaddMY2c9WN5JPQv46358n049QkO00fh1FkpPv3jpEY?=
 =?us-ascii?Q?wBo67G+4hqErwHfM4wV+yD0abavPygDGQahVZKMypTRqHYXCNQLuuxmJp6sr?=
 =?us-ascii?Q?x1xver76n2QvyPxfbyAD70UZ/m2gziJcrJ1FIuWGpUZxlq1Vz6rfzUXF0IuK?=
 =?us-ascii?Q?jPAijTUM9dc1foDnmRCrm/egRndjqub5NN+z26OUbjMKpizSHohwzkxz5Olk?=
 =?us-ascii?Q?yL/hO4tD5rjmVXMzX0YiaJQdS+1dj9rfX1ZEVzoDA7NGT/cqC5E0N83wiuDn?=
 =?us-ascii?Q?7zv0eJPk2ms4aCIyY2V8ILWtRHCjFqEae5/8REW4jgN1f0aC9Yg2jTjmSFtO?=
 =?us-ascii?Q?IKOKW4c9IaXCo5jF887MYZ6YQxlUvoAqJJHJ+SlriQEPn9LvBaYIbhikRDK3?=
 =?us-ascii?Q?7Fo1k78SVlAi4Btv+5dhAwYK3QRPHvxM0xuJy7oALI7mHH2ZSryFj1fPyl75?=
 =?us-ascii?Q?1D/oQLCsII/0Vlvp/6F62T8jdUudp4Jxs1jNYqpiR5btum8GfAqkBXu3pBX8?=
 =?us-ascii?Q?C9popJvuVnkJTL2RokN9+VOXoT3XzBfy7JP5y+6/JbuWWe7fRF1pJCobEz80?=
 =?us-ascii?Q?MeAvJ+DVdUIosr9J7jhGlnT/6dJMc32M/xr2f6PRB05M1AL4KvBqt9RHoyoq?=
 =?us-ascii?Q?YFLCN1awpBzmQLXGC1cFNK22qr0XzDAhsWNqcx4DLogWndReYBBzmb44Y9CE?=
 =?us-ascii?Q?mKzfFYvzJexiN175Kkjw98As5m2akMSQgQaltbQpyWqUuM0CMvqVrfLbAVyL?=
 =?us-ascii?Q?DpyaoQmh88vjNpqCh4cyg/2dGjcMT8RIOfqcPpcamfZhw+K67TPfjZhOmGov?=
 =?us-ascii?Q?fCUtLobHhbX1f+i20cTN7TpTks2ibLN1c49AuQXmfNViQaZ6PpJcAz4ZJBxx?=
 =?us-ascii?Q?qTOLpeddkokoRnAPydmhcwrLebyTOKCAel9wvaIQuqt14qY9P/hWTt5j9jbD?=
 =?us-ascii?Q?BNvbb+iKtR9wkb2HaA6guK3nhjz/QyDsHfoBCJRwJMuS2OJR1PbxIXlyzvBb?=
 =?us-ascii?Q?1VMO59icyrSKCqzTwzqLckq7q6jpaxvLJsY6lGdQLNgEN7uA0f4T5khAeR9p?=
 =?us-ascii?Q?PkbYQS3TUyfv6T2UmsjSd3R0WpNP1nal/OV9qZPJMHvN12rWLlwncOlk0LEm?=
 =?us-ascii?Q?9wfZWmnM0kdZ2eEFA6dkpBPHQsWRrsPM3ZLlrAVgEvZ7M1+9MjfegQrLmYVU?=
 =?us-ascii?Q?nziaiEeMCBnYyfCCukIv4meQfUmVy8LEBj25stGr2aK85HWf6BCRLZYJ8ReC?=
 =?us-ascii?Q?swvsrCcnJ8rLsFA3WQjKhkUy652PKRHfXLDIl7ZT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332d7639-b83f-4fb9-d296-08da60bf94dd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 08:55:18.0806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkkNpF2BtpKoKnxLCazJLuu6HvqzpcQ7L+e7yq7ymGJUm5Lxv9kGPfM2AxJ+xrmLyBoLGgXZ9noZFMx3ZOdvnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6503
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

