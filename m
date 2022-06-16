Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F76E54DBF9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359291AbiFPHix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359628AbiFPHid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:38:33 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30054.outbound.protection.outlook.com [40.107.3.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1795643B;
        Thu, 16 Jun 2022 00:38:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGoSmG3qKyTzQT1o7od2bBnpdUScUyNDsU2C2X0Ch654ewqoqATjMKEWbQgMSopnM6lRBXOMnnyhg3/NiGLcweZ2EINnF5oDviAwQDch6JujGihUZe3I3L30MGk4sXhCD+l7yqD9/pzXHOpFjMgecIZ5NWfAFXJnr7Romk6zcenzXvz7IDPbQdfWHA/Yr35PBAY9Jq/WpUZdzHukuFACMKhEcpWXAgpM7M99Nhdm3zoERcW25sgBc3HDp4/7JhBIQfPxhHMEux9J0T70gH/ptS/TIOSbUqArl6yHSMa6oOGHG1FKz3kz2qtqDUez5ND2x4fhDaMp9Kf5juwK/mS1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2cUj0Rs9UfkDeYhod2bqjitTiEGK8Q9AdQl6rQ0tPc=;
 b=mEqzTLmGZ4x6AKSR9G+mK6wDnoInJKIuoo9lh54ofe/+9n19ihiE4E4lixvnKzyH3PkBEfhSvE1BPF31CTH9ODy0Ppw9oscbLS98aYe10fh1qg+orHhuOrU//hqom3cTpW39bNodpWQE5o0BnguEAJQa+aq6SjAuTFWdbq08rp/tHPbtwefoweLUVFJ/i/1n0MoTZo3bDu15GwjBJGckL96kAUo52YGeYiyX9ke8PStotQvMKjDgsv1LK85vzq7uD60CN8iYvU41IqjOFn4gqdwLjQWK8Odh9k050Nm11DUqV9i7igkreVwYVrZlUjttA/2HJs4Yk6+rzXI9AAyi4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2cUj0Rs9UfkDeYhod2bqjitTiEGK8Q9AdQl6rQ0tPc=;
 b=dQ2VrTUdmQdcKT7vgsDeUKLsvFZ5blzyHHLDmHF52FgFqDE/85i4LnAwhE07sukWJb7YUuRWAuqS+f4MH16fumaX1ArlCW3pSEs/4i10glUXA1S02H/LjIkbto1vt9PcR8aG+Arv23WIfvnSpfj0V2BbHx/pOm0xjWkkP+kTOZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB4293.eurprd04.prod.outlook.com (2603:10a6:209:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.19; Thu, 16 Jun
 2022 07:38:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 07:38:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, paul.elder@ideasonboard.com,
        marex@denx.de, aford173@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 4/8] soc: imx: add icc paths for i.MX8MP media blk ctrl
Date:   Thu, 16 Jun 2022 15:39:49 +0800
Message-Id: <20220616073953.2204978-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616073953.2204978-1-peng.fan@oss.nxp.com>
References: <20220616073953.2204978-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07e56159-90fc-48b8-4221-08da4f6b3281
X-MS-TrafficTypeDiagnostic: AM6PR04MB4293:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB429399AD6EBB1493B6D7463FC9AC9@AM6PR04MB4293.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRnxK6U/jStHg/lnQbQKlh3um8Z6avUwyGLPbGqWtf+ekAgs2EnXhSWwzhExpjNyOhi+zgswxnc6vywSbKqi9s29Y5IwIzxHnjcdPLRuiE+OIWzNEXCjsnTrlUMXFzfVATCcF4up/Rcggn7Ho1Ft6pD+70YmyA2f1kruk5oL+nJ96cmUcCaKH8fBNB0H4q0BdNDMWymMZwZwUreeCeoWj89cmbytP394rmKaQymanZbgSvrFC1eqjcGec8uUp5V4zFzAcza3so13FUWGbxca4ZpT8DJH1bPqyZA6jg77HwqQixnOhbLhhHWNxLoiKW6hy6+2D7rNhScr+kd6w7IWzAtAec1IwhWJzu8Dx5Po4doG/nXzqA+VWAltsMmEl6ZtKUvB0UFgpv+dgB1UtlKBQNPn4hcMcHEKycmArZNUJCW5Lc6OEKtQrYZgRZuQg58xPFtevWpJe5bBMEaq1YA4poW+ZIUCNzbYbb9W8aKw5VJkTVJUvgHpi0V092NXE0KLy6mFH4/QmM1SIxrBhqssMhuHrU9ECFfPTbT1jy7DGnyPVAh5ktioomlfa3Ed7R0WwnjKWhS/i4wSOOYHO+Vk1s2jGLDnJdwlUro8vo99YtZEUA0e80MAGEHVTnNldQzzWZY2VD1uKcn6BT4Q2Sjp08FkfanF+qnOtfKhXjkIstHPiYnT52gQkXEAKgrd3HtNddhg1H1MmeC9zZw1AphMtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(6512007)(4326008)(2616005)(5660300002)(66946007)(8676002)(2906002)(7416002)(86362001)(6506007)(66556008)(508600001)(6486002)(8936002)(66476007)(52116002)(26005)(316002)(6666004)(83380400001)(38350700002)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tjJP5zP9MgFHXC+quc/5Y62X2qubcc0GdUJ/fIPK4Jt8OqY7gIqmZ84iREnn?=
 =?us-ascii?Q?y0tAI0lfzClEI9SvKbpjjzYXKkHhInbkxBNKOYfYnCRzgKVBCVbPerBwA3HD?=
 =?us-ascii?Q?WDq63nyDmkPWeegmRYFa9G5oF4TLMlL7dLJ9XgLVxuW8kCvkDx+5y+C4t8yy?=
 =?us-ascii?Q?6RTXB+2kV/J9Kqa3zWRp0oUidGRBOnaZrQ6fhsNkhSwBo2mAChxmndbt5jWi?=
 =?us-ascii?Q?Unp7hbeevR1dBBjSk4HwPcu6yi+qyRKfrB6sMTYczjnA2nMCuPIZqyGygDbG?=
 =?us-ascii?Q?QIouNl18vz7xWZQxphUM2E7pwqTHEOZFTIBtM4X8qBCMTsZ+6C1yTHi0YgYk?=
 =?us-ascii?Q?nrhl+HaHjcHv6v3CXX9Eolqcwwchl5gVFERlHrjkqLZ/Go0CQDWt36CJ4TNK?=
 =?us-ascii?Q?Yrv03YTPEaBROj3w/mOks1BwiDKHR2yATAIAL9zrVnrBHsBnkwPqv3/nPihI?=
 =?us-ascii?Q?YEAI6Rm/r4kLEWkd/yCUVlfD7RgzEZCXvIMPL4YJF8WXJzBQl5zVkxyu3vUq?=
 =?us-ascii?Q?eyEUPSpywVDsOreb3SSrBkH/rVs1aXAAgbMQD84Dr4t680jflqt2LktaxHYl?=
 =?us-ascii?Q?YM5W9WWIMxl15vGO+K5tLEUoRt3YES4VJbetsy6AUL8Vl4f9X6rKrODrucEb?=
 =?us-ascii?Q?XqKxif6Cl+dUROkc5y5fQW84cJ9IZ0VTfLzK4m9yuJpAbxz7N960BJ9BO5PH?=
 =?us-ascii?Q?SEzIgmeNuLj4EqIGf2LPFG2ycMf3QKC/TCiDd9ErmFIe8IKluZ/x1FBcMg+X?=
 =?us-ascii?Q?j5avxxsO/lPibO3gV690qFiO9b9CNs+wrs23BrU99JWtS5Y9IbaH4e9vUO9B?=
 =?us-ascii?Q?xoFsztPQa824LofiPI6IM90+v8k3JkeoacIA3ZZh5ZU6djc2dPs4EJdqb+JC?=
 =?us-ascii?Q?ql5dKEtCCN6XL2I86twooMqr0bSr4kUqkW+4XQ8C6aNrCisGgQqrP7v0IqQu?=
 =?us-ascii?Q?rBEGL+wbYhhTuet9x9VB446hOuXi5DVtuPzFB8UJT3n2CB1LBA2u++uSpzHe?=
 =?us-ascii?Q?DZFtYSa3lWL11lT27uyBiGLVSx/ob/4FTFNuYZfNKuxeb0epPVxQC8gVSaJV?=
 =?us-ascii?Q?xfpeHEaCa+l+CeFU/Y64dL7gvRU22AWQC/uU6lfC3GeeSIWILDsphcSHMnjy?=
 =?us-ascii?Q?JIAhWz0tYl6D08x4NvjRwy5kA+7U1PW1hYcUiOZCYpnQ8lq47Fn3K/nFOOsC?=
 =?us-ascii?Q?zVvrqsPZUUias+9RY+IAwPC4+Nqx2dz2maHqRFtR+HQfNAxi/ZIRN6jOrHyH?=
 =?us-ascii?Q?J31I+uAoo+Bi+RP6bMSOoqi3vZ/5c+kfmQr4Ii2P4ot2KE+1ZiyIi8n31+6Z?=
 =?us-ascii?Q?0Y1pwFNnJd56p7Wd8hdZtHMhPykNQv3BFfuI+h8z/8HJFHxmaVUY/mJSDhLs?=
 =?us-ascii?Q?0kgndbPeVbns+9V02Y6CMzmPcsDrpEQDXUSCh9i7uQyM76u5tTfzwQ80c4fh?=
 =?us-ascii?Q?8g463VWIlyZlZ4c8GwvWhsmw4xvVlJmqEKlq4VcVMzIlqkn+r1e6NBTrzytL?=
 =?us-ascii?Q?B/EQXNgCGydSFUO/pv0/0U1nfqkKJsBo2zyQObk4kNF1LivfU1nASQthuoM3?=
 =?us-ascii?Q?4lfPeUtML28HjKgFrS3IDu8R5+99GOGbCwCEoJLhG0gCC2/XXrk/Y50b7lcw?=
 =?us-ascii?Q?slcQkWuE9ZaSGth2FDByebo3qwVQwUcpxjaP1hEoFBLESIU55rpQibBzRdG4?=
 =?us-ascii?Q?Gl1c95OYmIPVVF8QF9cN1RecUyQgrAmBUxNba2xvU1Qas2ai9LOdIPtPWNeH?=
 =?us-ascii?Q?/cSO502ITw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07e56159-90fc-48b8-4221-08da4f6b3281
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:38:25.5647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCiiuel4+g3WhYL1t8lFL34bPppsg//4zXvPf/pZBcdUaPcsKIvfkZP4yEdnTbopuD425FbREMKmwtlgC9qGbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4293
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
 drivers/soc/imx/imx8m-blk-ctrl.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 7ebc28709e94..fc0b94be6439 100644
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
@@ -52,11 +55,13 @@ struct imx8m_blk_ctrl_domain_data {
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
 };
@@ -117,6 +122,10 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 	if (data->mipi_phy_rst_mask)
 		regmap_set_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
 
+	ret = icc_bulk_set_bw(data->num_paths, domain->paths);
+	if (ret)
+		dev_err(bc->dev, "failed to set icc bw\n");
+
 	/* disable upstream clocks */
 	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
 
@@ -228,6 +237,19 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
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
+			dev_err_probe(dev, ret, "failed to get noc entries\n");
+			goto cleanup_pds;
+		}
+
 		ret = devm_clk_bulk_get(dev, data->num_clks, domain->clks);
 		if (ret) {
 			dev_err_probe(dev, ret, "failed to get clock\n");
@@ -647,6 +669,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
 		.gpc_name = "lcdif1",
 		.rst_mask = BIT(4) | BIT(5) | BIT(23),
 		.clk_mask = BIT(4) | BIT(5) | BIT(23),
+		.path_names = (const char *[]){"lcdif-rd", "lcdif-wr"},
+		.num_paths = 2,
 	},
 	[IMX8MP_MEDIABLK_PD_ISI] = {
 		.name = "mediablk-isi",
@@ -655,6 +679,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
 		.gpc_name = "isi",
 		.rst_mask = BIT(6) | BIT(7),
 		.clk_mask = BIT(6) | BIT(7),
+		.path_names = (const char *[]){"isi0", "isi1", "isi2"},
+		.num_paths = 3,
 	},
 	[IMX8MP_MEDIABLK_PD_MIPI_CSI2_2] = {
 		.name = "mediablk-mipi-csi2-2",
@@ -672,6 +698,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
 		.gpc_name = "lcdif2",
 		.rst_mask = BIT(11) | BIT(12) | BIT(24),
 		.clk_mask = BIT(11) | BIT(12) | BIT(24),
+		.path_names = (const char *[]){"lcdif-rd", "lcdif-wr"},
+		.num_paths = 2,
 	},
 	[IMX8MP_MEDIABLK_PD_ISP] = {
 		.name = "mediablk-isp",
@@ -680,6 +708,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
 		.gpc_name = "isp",
 		.rst_mask = BIT(16) | BIT(17) | BIT(18),
 		.clk_mask = BIT(16) | BIT(17) | BIT(18),
+		.path_names = (const char *[]){"isp0", "isp1"},
+		.num_paths = 2,
 	},
 	[IMX8MP_MEDIABLK_PD_DWE] = {
 		.name = "mediablk-dwe",
@@ -688,6 +718,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_media_blk_ctl_domain_data[
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

