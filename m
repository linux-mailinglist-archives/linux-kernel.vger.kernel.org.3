Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F904F5C2D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbiDFLeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237610AbiDFLdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:33:10 -0400
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-eopbgr40081.outbound.protection.outlook.com [40.107.4.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39065211B37;
        Wed,  6 Apr 2022 01:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQ0/hcoUWcrjN1uJDGvjhG/Zg9hOn4lECqyKKjTONcu7t7dvPKUA8KDrFM32ZWGVOuvIx1MgXU+xRg02UC75PVRTNuffo7YQaxDrND0ujxnRzw1G8nIGDzcku4x6G4nCeLMAnNpbGvXTMayhnLEIF1XlH1nuDZ1VIBqi8ftumJd1dIFYPKxA9P03H2AVSmsrV9ipM/3CELUA8/5lfh5KzYYCRyB4zbZLkVyDxyXqpzYr87J+brLw4gJcjrRJSdGKmE+Os4fByiy2ddrSJQRbpg89p5tNmhSJ4DpNdKT7M2gHah9vhEgoTQAIGAWVTBG9HbduDuEjsF2zXUuEPorMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=is91ojJQW3Uh3nYnr3h3aZL7l/6jwu9tGtGWaPogUh4=;
 b=IsJ40wd73g1pNVdoJ/ss2iBs7cLGHdbn+In/lQ/p0klUc7D6Im+i0M0djMHI9WkbKo/g4ed4ImrVzZmE8Krgt7WqMPXHEkrJXeBIA2VXQjmlxdS7IZxaELfuMg/3df8RHO+3S0SdYAKw1C8k3vCM9IoBjz3c1mlZy4E3Yh/4CwUw4QoytMsASc+iJZto2gBTQ40AX9TKz3tkfAt+9wR+x0/i0hCtiz5TqzBUOSWcc0/g47njjrquFxXMUru9MqC41PFnMzcbWgYge7Sgq3UQyH/u4PiEeX5+kp1IcyXwzy8udWTvpoW5z+PS5WI9tMCiQ0xsUA0MttdYz3YnDU9V7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=is91ojJQW3Uh3nYnr3h3aZL7l/6jwu9tGtGWaPogUh4=;
 b=C7GUAZa4Js6yBBYhJzTd2uuhIVix8I5pcum7y+XCLdsPTYQaLn9TkWZ/Ll6raSA8eSLRzPkYZ6ybG11sFBzd+8WxD56ISZpPZ4CMlLYk82AJ8nMLgPqsLzthIlq5bwVrZhSmKEaVs0PeScyCGezH3Qdn7Q8f4FEsWXEiIGG/LYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB4988.eurprd04.prod.outlook.com (2603:10a6:10:1a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 08:21:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 08:21:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, l.stach@pengutronix.de,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/5] soc: imx: gpcv2: support i.MX8MP NoC settings
Date:   Wed,  6 Apr 2022 16:23:28 +0800
Message-Id: <20220406082330.2681591-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220406082330.2681591-1-peng.fan@oss.nxp.com>
References: <20220406082330.2681591-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9ac094c-927a-45af-5261-08da17a68247
X-MS-TrafficTypeDiagnostic: DB7PR04MB4988:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4988823952A4430672BD0F08C9E79@DB7PR04MB4988.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zM4Z0lTooBDZlWqKvK6FkzkPNA+TB6lZZYr1lH47ftfW6E7O8h9iWINkIvhPhl5zw3MzEiUC/L1r2+0kuG5GKRJ42m0/utkjuhlhj4VmYjfamV8xoPR3Wh86rm98SQHoefl9aXAYX/297DZ9wH5V4NYeRzH8A99/tNibAaYIuzZ4WTZWFTUT5uTuaKYzbJrHf1JQzMcv65ZEJEDih4GvDLwzDU0f89WfyW65tY1c/3jRLFuW6BX5ly7DOcIQtUc6RLfLlcgk4tQ4XFOIjVJgu2aNZn3fANXh0SdYJCcWehK+uZVoZDg2NpnVvaod3oqHDKImvZD0NA0yIMgKTEuqwuyInMK+mMXAOXTvs7EOF6XPvXg9///xcqHI23jHFHj7jcNH7hme/3DG0FiJkAesjVvbY6RSmfSBYgeJ1wVOcqPvnkViFS3Yii5aRy48C/rf0b53/DptgYQehsGbMr7Q98JVcFQqykFf+/J4EZA5TULNqPKk3ukJdjoZIM6FLrLxEz1NvHuLNHr4H5wHbX8z0wWh2cUx21VtW/tmPOdALjQMRon/GYcr/Oe5uWeRzjowh9vnFw42IRHpw17NpFssihlfDitJofzMLTwJHHJTw0OmJtDpDJo7RNdtlqJbKNAKIliUOS4dBMEosIq+VvP5LWOYeNgrclu23oZW88hLeUB+qcRhW3NQJ1KGYNzgcOR8Gr+myD0fKtvS2+9hv5w0Kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(7416002)(83380400001)(8936002)(86362001)(2906002)(38350700002)(186003)(38100700002)(2616005)(1076003)(26005)(52116002)(6666004)(6512007)(6506007)(4326008)(66556008)(508600001)(66946007)(66476007)(8676002)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n7gcQwDO3sJkxGOAiknKdQ+F+reSG3QbH3X3cChnQtX2A3sVP/lXWfcPTUF4?=
 =?us-ascii?Q?ZpYpXoCiGvkpc4z5kG/PYUQr4GXK6J6IEYJ9FvfQRWRaXzmTz3jrMessx3Vg?=
 =?us-ascii?Q?y5l165y5K0Z+n7bX03VmdnAcqWeg7vJSJPyUwFL7wHU+V1pV5B0pzMUCOPWk?=
 =?us-ascii?Q?4PGNs4tHNa6MzOWktSI4IHXo2vqMIiI8Bpi8bF8j2uXP6ZsYSwp9oRoKZQ76?=
 =?us-ascii?Q?Nfy0wkMoAU2RlmmZZ5XiIDmyevpXfTVCKgbdRNfUMX5YyV1TvzO//gAegthY?=
 =?us-ascii?Q?2VXEROKX0dtFomwLFvFdGCEELk32zMWwirIHnwM4Dlc5vCRalfdYX2rwElt+?=
 =?us-ascii?Q?kPXzK7KPOdXA9WeCR12hPSXM9Y3tlyJsxkuBLHjRlyCUZkIFp9e5dz4nBr3U?=
 =?us-ascii?Q?UT5uGlZlyPeC/MIlKlNEMEmlZ3ZJ25vR0NBLF6kFr3Z1B9XnpRyWhRFQb4TO?=
 =?us-ascii?Q?bc6jGXOwIJ7f9cUmqIR6l3Y4fyd65rb0GCAI7tCSh5II/Ow6DTPTVSyB914L?=
 =?us-ascii?Q?j7gi+HNn0frW5tdwLLvNTjnzCighNpVZEP3BWqc3GQnC4jREv6rBcr3Gw4dr?=
 =?us-ascii?Q?GpwovoJpidIFaQzBUsjqYPZniJ7If5htYSV+8GNeLIvgbL25L1l5I+JQkAhd?=
 =?us-ascii?Q?RRdYFPX0GhuvsqD7DiRKMC0Nkbq5yQdH2kvdEaNjaCkmJtAhforsgFTN6Cms?=
 =?us-ascii?Q?of7Irf5QPyZa/E+gROiFU9rmqyPv4fKadLSvzk0kMvz7h8z7fR+kvHPttXta?=
 =?us-ascii?Q?dLqy+MNEwgvBWD2LvkCgMPVhmJRdsqRv+K4stK9urQP3SbZS7GjAN3mmycxC?=
 =?us-ascii?Q?opurLtaRDjElphI/hj+BajRyeyFHsecRLgl4pSQ2i0jalWV4FQnw31wSQhBW?=
 =?us-ascii?Q?iDTDmVEC9FIp+UZD4QiXbgQNQW8xhfA/9xDmPbny675E92ytG0W77VvKIkvJ?=
 =?us-ascii?Q?HNUvot6p6/cNd7LEzcf3yyPrBCHXBdb6ILZMULcCjeBcbjM5pjYo/ShW8bN3?=
 =?us-ascii?Q?Mzla3NyntWoRt5cVqtfmo+sTjFt30C7+BC1OO537A4Ozh89SZPDxl74lYqQc?=
 =?us-ascii?Q?bbrn1VBHBLysongnM2l6dGpSH3JE3uwFtkvKs3lcarbhPCY9iTwH6sqMmoMA?=
 =?us-ascii?Q?Anc7+/Oph9RtlZ3DLR8PIoa+NuDVUOCzXpUjboM0ALnO1mwCBlw9/YEZfpm0?=
 =?us-ascii?Q?GJeqvxjsIDl3TFKskhOQpYNIDfbQC9CzEL77TaAqIZhhjDiJ0p1VpUovrMwK?=
 =?us-ascii?Q?+U03G/17cE3CI7gHxA3yZX6H/yQFbpiL4UbrdLF+LhJi01x+V/R8E2DxYOF0?=
 =?us-ascii?Q?35i3cWySjy1kChMdGjDQe9bzdfm7rMSn2b3MedDwwU+nqedmep5C51XMdYCL?=
 =?us-ascii?Q?5hYgqsoiteE00JeDx29uliPUxSmZ0sNz5Q6B4tmML3qhJsfSvnfIc1dThCRl?=
 =?us-ascii?Q?TkPvtnlQDgKeQjbT57hWl2Xk5q6+oMm4XpTiqlVieIoRBNbEOn56BxZ7a+CN?=
 =?us-ascii?Q?rbTS6IfSIqudEglbOJosQ809G5aKc+k+tn1pdeWGao8vnrG0WHoqOrOcz4Bk?=
 =?us-ascii?Q?sqHmJsxoqY7A+CZ8EvbnIVx0XNAZekyZS/tBui11SDRG2J2LxaA6So6d7Uzd?=
 =?us-ascii?Q?nbb6jpTIDd0QsAeLrGR/OMCHPht3ayWK55/p9NAYyZpvTwYlalKxFFq3pHjA?=
 =?us-ascii?Q?1A8hl5DD/z58V57q8O9e37a3VHtHE4VxYA/z7heNgjTngxNT5TchVOGQudxe?=
 =?us-ascii?Q?DiAsEk+8lg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ac094c-927a-45af-5261-08da17a68247
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 08:21:54.5787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYYVDTwILjCpHXsuF3ARsNlq+g4BF6Rt4Yh1es9ULUxRmykLuittZnyNWQrk77zZVKDJ8AdFA+ZkUetzh7O0Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4988
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The NoC reset value for GPU and MLMIX is not valid, need to set
it to a valid value after power up.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/gpcv2.c | 56 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 85aa86e1338a..7199cf8e148e 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
@@ -274,9 +275,17 @@ struct imx_pgc_regs {
 	u16 hsk;
 };
 
+struct imx_pgc_noc_data {
+	u32 off;
+	u32 priority;
+	u32 mode;
+	u32 extctrl;
+};
+
 struct imx_pgc_domain {
 	struct generic_pm_domain genpd;
 	struct regmap *regmap;
+	struct regmap *noc_regmap;
 	const struct imx_pgc_regs *regs;
 	struct regulator *regulator;
 	struct reset_control *reset;
@@ -298,6 +307,7 @@ struct imx_pgc_domain {
 
 	unsigned int pgc_sw_pup_reg;
 	unsigned int pgc_sw_pdn_reg;
+	const struct imx_pgc_noc_data *noc_data;
 };
 
 struct imx_pgc_domain_data {
@@ -313,6 +323,21 @@ to_imx_pgc_domain(struct generic_pm_domain *genpd)
 	return container_of(genpd, struct imx_pgc_domain, genpd);
 }
 
+static int imx_pgc_noc_set(struct imx_pgc_domain *domain)
+{
+	const struct imx_pgc_noc_data *data = domain->noc_data;
+	struct regmap *regmap = domain->noc_regmap;
+
+	if (!data || !regmap)
+		return 0;
+
+	regmap_write(regmap, data->off + 0x8, data->priority);
+	regmap_write(regmap, data->off + 0xc, data->mode);
+	regmap_write(regmap, data->off + 0x18, data->extctrl);
+
+	return 0;
+}
+
 static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 {
 	struct imx_pgc_domain *domain = to_imx_pgc_domain(genpd);
@@ -394,6 +419,8 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 	if (!domain->keep_clocks)
 		clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
 
+	imx_pgc_noc_set(domain);
+
 	return 0;
 
 out_clk_disable:
@@ -911,6 +938,25 @@ static const struct imx_pgc_domain_data imx8mm_pgc_domain_data = {
 	.pgc_regs = &imx7_pgc_regs,
 };
 
+#define IMX8MP_MLMIX	0
+#define IMX8MP_GPU2D	1
+#define IMX8MP_GPU3D	2
+
+static const struct imx_pgc_noc_data imx8mp_pgc_noc_data[] = {
+	[IMX8MP_MLMIX] = {
+		.off = 0x180,
+		.priority = 0x80000303,
+	},
+	[IMX8MP_GPU2D] = {
+		.off = 0x500,
+		.priority = 0x80000303,
+	},
+	[IMX8MP_GPU3D] = {
+		.off = 0x580,
+		.priority = 0x80000303,
+	},
+};
+
 static const struct imx_pgc_domain imx8mp_pgc_domains[] = {
 	[IMX8MP_POWER_DOMAIN_MIPI_PHY1] = {
 		.genpd = {
@@ -968,6 +1014,7 @@ static const struct imx_pgc_domain imx8mp_pgc_domains[] = {
 		},
 		.pgc = BIT(IMX8MP_PGC_MLMIX),
 		.keep_clocks = true,
+		.noc_data = &imx8mp_pgc_noc_data[IMX8MP_MLMIX],
 	},
 
 	[IMX8MP_POWER_DOMAIN_AUDIOMIX] = {
@@ -993,6 +1040,7 @@ static const struct imx_pgc_domain imx8mp_pgc_domains[] = {
 			.map = IMX8MP_GPU2D_A53_DOMAIN,
 		},
 		.pgc = BIT(IMX8MP_PGC_GPU2D),
+		.noc_data = &imx8mp_pgc_noc_data[IMX8MP_GPU2D],
 	},
 
 	[IMX8MP_POWER_DOMAIN_GPUMIX] = {
@@ -1032,6 +1080,7 @@ static const struct imx_pgc_domain imx8mp_pgc_domains[] = {
 			.map = IMX8MP_GPU3D_A53_DOMAIN,
 		},
 		.pgc = BIT(IMX8MP_PGC_GPU3D),
+		.noc_data = &imx8mp_pgc_noc_data[IMX8MP_GPU3D],
 	},
 
 	[IMX8MP_POWER_DOMAIN_MEDIAMIX] = {
@@ -1440,7 +1489,7 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 	};
 	struct device *dev = &pdev->dev;
 	struct device_node *pgc_np, *np;
-	struct regmap *regmap;
+	struct regmap *regmap, *noc_regmap;
 	void __iomem *base;
 	int ret;
 
@@ -1461,6 +1510,8 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	noc_regmap = syscon_regmap_lookup_by_compatible("fsl,imx8m-noc");
+
 	for_each_child_of_node(pgc_np, np) {
 		struct platform_device *pd_pdev;
 		struct imx_pgc_domain *domain;
@@ -1503,6 +1554,9 @@ static int imx_gpcv2_probe(struct platform_device *pdev)
 		domain = pd_pdev->dev.platform_data;
 		domain->regmap = regmap;
 		domain->regs = domain_data->pgc_regs;
+		domain->noc_data = domain_data->domains[domain_index].noc_data;
+		if (!IS_ERR(noc_regmap))
+			domain->noc_regmap = noc_regmap;
 
 		domain->genpd.power_on  = imx_pgc_power_up;
 		domain->genpd.power_off = imx_pgc_power_down;
-- 
2.25.1

