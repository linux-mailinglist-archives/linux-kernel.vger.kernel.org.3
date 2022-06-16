Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C5B54DBF5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 09:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359630AbiFPHiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 03:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359653AbiFPHif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 03:38:35 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20071.outbound.protection.outlook.com [40.107.2.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372AE5675A;
        Thu, 16 Jun 2022 00:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwhTmwBLIjtIrg4u4yeUizplzcPcrJBqtLsZUg2BAulVO+q3Vbnh4/IFveH33DxiBbsFWMwH2DHxO6sBnE3N7e1ZUHssQzXa3HtRQBcONTWqXoF8uNVWCqGbzAHzNQ6wXA2ive9umIwYPkrhXft/pivvD8kZVdTOjMH30boLgQDWiRGAOXzBXhpJ63Gw16Zf6dFdMzxLK7dr+C1f8BSgwCFM5fKl3GjE2p5OPgU8sA50l4FJxy30Diy2g46tNmdinaZcv+hBHl49Df1AqzdVgFWRu8Q7eGLaSR0+PjmDHKR5V9G4qrr09i+4297CDs4TujE4qQwBcI1OK3EX6KkrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MKppfXu9JHpxJM6uJ3eOpBdVPAFsObcfwR6rVFCYdg=;
 b=j5VwIy555jFYUavD+kmSjacYtAsY8U6Z5BmaNJFXOLEKsXFcCd8frmderkbZKuD+oSx5FcYf6QHEU9Zvzan3X7k5hg/JXZbETXUCD6lQDyyaGqnLZJiOvK84KHJjFKFU5Zy0DVB4A/GtU+Bi73fBjaZtpgbyk8+QDnpsQIVlOUKha9hFV2M8xo+IDkdgqLg2fJim6fsQBgSSDkQdZMLfLkHD8esrzbmQzM2e8lU3znAG/ynXwjZvvNXR1mO1MvCQRwdNLyLM4cqRUwbAyFxjyIZNTh5gu72KoWPLBGdtTHO9k3Vn0s8amKWUivT7+x/VOsYmRip4puKhJRVLxMMcCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MKppfXu9JHpxJM6uJ3eOpBdVPAFsObcfwR6rVFCYdg=;
 b=OydFXj5lb+iVtzMOSkqqR9wBebc1Jj1fDqQHKjjdX3/p4R24It4ml6m/usVuc3fuHm32pw5ov9Dcx/GWQMyy04LtPXrzLgqWrMEK2Sfl2GydDS19+7UlF99Rlz3WrbUElKmmDDTn76EDfz8Cf3i2ZUUeF+YhiEvmbuO7YlKYF5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB5739.eurprd04.prod.outlook.com (2603:10a6:10:a5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Thu, 16 Jun
 2022 07:38:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5353.014; Thu, 16 Jun 2022
 07:38:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, paul.elder@ideasonboard.com,
        marex@denx.de, aford173@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 5/8] soc: imx: add icc paths for i.MX8MP hsio/hdmi blk ctrl
Date:   Thu, 16 Jun 2022 15:39:50 +0800
Message-Id: <20220616073953.2204978-6-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2f7604cc-1b27-4548-ed56-08da4f6b3502
X-MS-TrafficTypeDiagnostic: DB8PR04MB5739:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB5739AC2317B786B1D6342A47C9AC9@DB8PR04MB5739.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l9wAf4TxumaTEN+cbq3igweLw/4ep7qipapq9vsrPFy7cBwZ+vrEsRahAvsIVqpKKkz3gTSyKzROuFZtijU7vbN/w4vzbqhUkWRu/3tC5Nt4a62jSNbZHC0+qs9ahS8P04GG0+XPJvO1Lls7mk/4D3lbC8HGzl8PpOdHJFOjJp0DdvN0kbG8H5rO7TTUUJzKb3yoRj+NxsrlazgLpXkNHVABak2AnHn9tx+avX2INNpIN5Qt0wY0BweUJYsSFUigfWL4BnCNd320bGFkRZL2ylJDfyK6pjEOs7vqhoxuVVRlgxZtSTvUNyXrsUvN5MOrxyKe6Usykj66uQYEBcJODUQ5DTBVWHpxaGQO7AERwzGoOAgmi7SeSpee6baduUs2/8i7fPjba0oLY8rUuw+IkWIFNSGYOvbHHAxe4+fKaFgPLeAuEbuA3G0fdwd4bc83vS3a0eYiimSthQtvetWPYb9rUgOiVQEUjuDTkhRe9lTwtXcKAvv2mgau8prSLBDtHapVsk8q4Wlpebu411Ce22Pwpy2CudMGukRy8JgwSHgFqY5jScjq2jjsY5taSfdnwzEfiNbKde2H9TLLuuimgcjThaTyWKvsRF/aRODXuq1QxFNpWgoCeMAkNaZsymcYtt+PzGTUGr7PveoiJ9tbTqPKNjnKt8//vktiZwtrO1PQO34/izIvJq7z0faSQ+tLTxvISSxMLyNSNO1mb21C3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(38350700002)(38100700002)(66946007)(316002)(8936002)(2616005)(86362001)(6666004)(186003)(26005)(66476007)(66556008)(4326008)(83380400001)(8676002)(7416002)(6506007)(52116002)(5660300002)(2906002)(508600001)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gLRs+kUahSNnfproLb9qHFrdmnJcRAPD2Q919/ouVc4jYqLBP2lsJM032IM5?=
 =?us-ascii?Q?2lGDiE2ubjSwpwNBy2MEqqeG4+zwHTlG5Qhzq4cy3tx6LVz8/KUbqxMt/zU6?=
 =?us-ascii?Q?qTlbk+lv+82DgylLUStQqQTLCl0rsmL/SMYFAbMFAgC4UO2FXGvsXZsxb2L+?=
 =?us-ascii?Q?VlnM0rwwrLr+eO9NQrQjBrYXj6saZeaZbcWkKi/S+Wrj9MI9Z3i8YO7v4EHQ?=
 =?us-ascii?Q?ffYNTU1a5oEcUevy80Djrt6dNNl3E4I8qk+WD8YQm1tIp0LSRZTqPcjMx3Yt?=
 =?us-ascii?Q?oeFByJ2b0wb+wmjudI9H3F05Bxp+DwZlDsI0A1GU1U6B14VbbQbAi/GRdzNL?=
 =?us-ascii?Q?zlFWqdaO2Dv86HfECW+Zr2GE7Ja7oVkZ8cGCHm3JWncN/FMuQ174mAQl1KWK?=
 =?us-ascii?Q?mUK55HdC+YkkTGcMM3EEkykQXn1OW3AYr4aJLICcZVO3mQcM5rXyhEVTcxBM?=
 =?us-ascii?Q?mz/O7Zt3ATB93ba0fsBJMNIl//CjFUalWK5ViOf8QbXGZbq+xL3HEaHU9OZL?=
 =?us-ascii?Q?xd/tH277NQ2fchYlssp/nx3qmFJnFbzOoG92BLXDtiJHbv57QrvbY5fafq7w?=
 =?us-ascii?Q?gBLU5FfNEo7RMtpaTZOtM9HOhWfGhFhOVikeEu1Au1Gh27NZWvS4sHoIAmFW?=
 =?us-ascii?Q?J7lcfADnvdEaRQ3HiycwDbHyfWI7ma3M8sbcERcaFw8Sbol9Wgwocu2wb2d7?=
 =?us-ascii?Q?fksMBc7r3VibqW9l/1uy8qyQdZ3D2GFeiaItG7CclxZdtuKTPNpAb0THc4z8?=
 =?us-ascii?Q?Nu2IGtrl6xuDDj3l57g1frog5D5RJdrIlVO8pZsCG22/PDpxiphg5uxYM1CG?=
 =?us-ascii?Q?Wj/3t4oEiZm/t+M7MGVDE2gJmS1sIZeEoNHwFtyUSaXAFwspmM3RMg8o4zQp?=
 =?us-ascii?Q?HHVfmhhpmu9VTQSSYcwCP2x23In233g0oBIEUaahYbGaEAOaSGyxwsCTusb9?=
 =?us-ascii?Q?4xg9HmqQOyKh/ZO3niZUA3sgtFIC9hdDD8bo/6R5JR27JivpBu1yiL9fDoDs?=
 =?us-ascii?Q?gPkCavVg9oDdfKs6U53UTNpmmwn4GpzRHsmKdUPQsGw44XN4NWxPWixfROv8?=
 =?us-ascii?Q?A3n0qu9l8JyVqowOKL5D1Q3vt+6ytZl+Ph9Doo2bz48BpMU89545tpRpwdks?=
 =?us-ascii?Q?KPMR76tQQyG7+VkidIE1VxFaOKfbSuVwwSIXqyl8j8Pd7ZsgIIlDjmAsreZO?=
 =?us-ascii?Q?Bg1x47CRB2uImQWIIkFxpgWIjeb2ABcySpDysHz8vFX8UWVqCsefN0p0Uwsp?=
 =?us-ascii?Q?tF8UlLmbroVd7rl7gdF0TXspvtNOf86kwTnAt1bYTtSMKOBNh0ZTU9B4V2oU?=
 =?us-ascii?Q?Z8FhT0nTb6e7ogqTKk99pEvF7oq4Ulryl+HzPwdqtzeGkMVw4hNTNbK2krAp?=
 =?us-ascii?Q?i10zQwVLX3qkA/zwQn0t8wLkqNrYXiAKulSB8b+RGIx1sP703lyBG7m5DmWV?=
 =?us-ascii?Q?nTf80kyGj4DdgjtnNozfQ8/MNgwhHQTAcX7oJNOLpep5KrtXOrAS8sX83N32?=
 =?us-ascii?Q?xFOjo+ari1t9NVDER4rvZ+aa5noEp7nzcV0hvGej+LfSadKnVH2Fw3hzXc34?=
 =?us-ascii?Q?fOJ+Rmf/6JMaJzF08viEdZc7iwCGjbsg/LSNbZ6NAU1VRF4CWHOnQlOsFhFm?=
 =?us-ascii?Q?2JwS+qMGfSt7vvXIVmvwKeokZn2JOPi+qras1GEitWUDfbpbqjjEZXYvsmYp?=
 =?us-ascii?Q?IwPhDYgQVnlTDmPRjP2m0GQnLFAqbYJTd7atEIVIK6tuvEyhgcbk6Lr9MAzm?=
 =?us-ascii?Q?HWXekMvHhg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7604cc-1b27-4548-ed56-08da4f6b3502
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 07:38:30.7398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ySMWAt7lSVnoIoB19LFUrOonI2RAm9hnPRmQEJjZEyRvK+a/3iqHG0OoXBD3WB/4VYWJt60l10FdfkIsXpNjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5739
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
 drivers/soc/imx/imx8mp-blk-ctrl.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 4ca2ede6871b..58ff8ec70cfb 100644
--- a/drivers/soc/imx/imx8mp-blk-ctrl.c
+++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
@@ -6,6 +6,7 @@
 
 #include <linux/clk.h>
 #include <linux/device.h>
+#include <linux/interconnect.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
@@ -36,15 +37,19 @@ struct imx8mp_blk_ctrl_domain_data {
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
 	int id;
@@ -144,6 +149,8 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hsio_domain_data[] = {
 		.clk_names = (const char *[]){ "usb" },
 		.num_clks = 1,
 		.gpc_name = "usb",
+		.path_names = (const char *[]){"usb1", "usb2"},
+		.num_paths = 2,
 	},
 	[IMX8MP_HSIOBLK_PD_USB_PHY1] = {
 		.name = "hsioblk-usb-phy1",
@@ -158,6 +165,8 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hsio_domain_data[] = {
 		.clk_names = (const char *[]){ "pcie" },
 		.num_clks = 1,
 		.gpc_name = "pcie",
+		.path_names = (const char *[]){"noc-pcie", "pcie"},
+		.num_paths = 2,
 	},
 	[IMX8MP_HSIOBLK_PD_PCIE_PHY] = {
 		.name = "hsioblk-pcie-phy",
@@ -322,6 +331,8 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hdmi_domain_data[] = {
 		.clk_names = (const char *[]){ "axi", "apb" },
 		.num_clks = 2,
 		.gpc_name = "lcdif",
+		.path_names = (const char *[]){"lcdif-hdmi"},
+		.num_paths = 1,
 	},
 	[IMX8MP_HDMIBLK_PD_PAI] = {
 		.name = "hdmiblk-pai",
@@ -395,6 +406,10 @@ static int imx8mp_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 		goto clk_disable;
 	}
 
+	ret = icc_bulk_set_bw(data->num_paths, domain->paths);
+	if (ret)
+		dev_err(bc->dev, "failed to set icc bw\n");
+
 	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
 
 	return 0;
@@ -514,6 +529,20 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
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
+
 		ret = devm_clk_bulk_get(dev, data->num_clks, domain->clks);
 		if (ret) {
 			dev_err_probe(dev, ret, "failed to get clock\n");
-- 
2.25.1

