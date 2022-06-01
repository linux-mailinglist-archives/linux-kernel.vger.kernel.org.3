Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EA553A105
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351418AbiFAJor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351325AbiFAJoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:44:30 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDADD5D5DD;
        Wed,  1 Jun 2022 02:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mG5uRfKY/KaO28JsefGea24icUu/yhl9ncSKZ1vF4Y+sQjBJIYqJ9h77fnPiUktguGGhs2NojlUPcX6Z+HBOaDmxcYM7u2CQQCBa8+Kd5dE7KGpG4UpNesvnf0byZWJJJS345Qwq/icbCaDlAUsOkOrLBw+sGV7Y6oozF+dhoBXpsCpqVZvj5ae3aNOaE4p8xq7OU6UInWYjiQi+tt7MvH/9H92Mm0YMgJr3qdGsRY0ip1li5ftfJiOWdVB3v7NGX+LmW3E9QfJm+nqEBsC/7scA1yINNzzXdnHrzOEbvw3zta7fMfXmS/grptLRi/PlEQCZN/vE4ARBprfc4BvSAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ty5ggt4gvv2BVeByuVnhN2yUDGXUmU4W6kAPkvobv4Y=;
 b=dY77T2AMPgBfjKEknZCnQ8Pu5b59LDm3SkPBZNPamsQ9q4J6W5zxE+mF8eFNeQpE9Nz8IFOGbYokff9roe+RDcAOfN8uMBNfPQ9mrcE2sSMXIGjwH7CKFlsAcX3nvQwkyppvxEqktSnIoCVX6zXEjRWIpOvcWfHCN97mjkBMJhXIT9HTl9/p7PmpxjivlOLGUnCYdxuqMymAfC8mVse9K3RT/rPXOzh5BeUqSDRUIbdov1OADFCKgw4D//dUbwXQkx0losSjEwJnRn4QkMF0GPX0dQ5eHGfZgf6WmXk9rp4L8MPHmtBBFQrJE9JhFHfJqKWImgL/7r7dM4O2XD4jtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ty5ggt4gvv2BVeByuVnhN2yUDGXUmU4W6kAPkvobv4Y=;
 b=As40kGcjWiPsuZBqAtkhuKAfy8DdYydzVFwVSv4vFhWdH5ZZxEn8edIB2hcGAvN6e9vpxxfjtoeCf2iRRaB+g78yoNTc4UDdrhX7QCV/ERFF97U6HLb5hJwCv7cG1jdBUAzCsgQbyt3SBYrk2TeJ7mbnMAs5gCqnMdjOocKvx18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB3PR0402MB3897.eurprd04.prod.outlook.com (2603:10a6:8:12::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Wed, 1 Jun
 2022 09:44:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 09:44:25 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/8] soc: imx: add icc paths for i.MX8MP hsio/hdmi blk ctrl
Date:   Wed,  1 Jun 2022 17:45:34 +0800
Message-Id: <20220601094537.3390127-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
References: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8380c8c3-0d12-41cb-aa6d-08da43b34ffe
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3897:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB3PR0402MB38973400225B17D8DF4FB278C9DF9@DB3PR0402MB3897.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pUhpBD0M09E8cXT2t8FP57o0CaDu+n2ywvmNbOQqOppdVVipZs0pKp9yCFKPAR1PUdMfjMxIkSv/LiOgW3xAi1ahK371aLsZwhSnCGUh0FCQ9pu8CVwiNIlRc+tW+7/rICTP3jhlD+9w87vxUcxpr/ZdisuP6+kpxnbQAoZhiE/e4Nqjzk77xUyF43RXfCIi/n8RGJfdMQTAroW1VeOKUd8l/EZDMTgE4fHXt+C1yzVbypkDaOG99xHxPr51lyDk/YTnYtzU+xjsHu5Df1r965p/KJaT/P83RdStY6WqUz99dSWHHdUcIDXjRp9g+Gi81wfUvszIKpBRgAnOfjgaKEcXAmO6c7IHhX4AUR8t2CQl33MGbd0Q8sgsjS6a5EcHdTMk2/rZzYsHhxwXuM+FZ5sSgHgMnsjcznpKTbwzZUqbwQg4tMblg1z5e6RpCyHrwb2kS+qHUYPEKxHAYV8cCME+UNIR1jhBk9Tdm4jREIxmJnEbryb5fkQfKMh82HfnH4FpcSWf7xPsCiXGJD30lB3MVwJtDhd0QLzVpmo+/ChephnEkON1mF1UTJ6zQie98MBbjjjjKhjwn9GlMbqTnM8UbJBy4FiR/RUov/NnDl5K7JO47u/s7Pfc5FlariW777aGeHH0f4EbGPL+VxZW+fOkN46Ii3SzHOJ/HywGaMpg8YiSlM5BAxeSEHeBtSnFAWwV+8eSRiPIEysFf3Urs3AHkO/CTz9UNXbnpS1xEVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(1076003)(66946007)(2616005)(86362001)(52116002)(6666004)(2906002)(508600001)(38100700002)(7416002)(8936002)(316002)(8676002)(6512007)(186003)(66476007)(66556008)(26005)(4326008)(6506007)(921005)(6486002)(5660300002)(83380400001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MIq0st2DPe+I2svH5rxA+4o0eTurn0PAAWast4w8o2Rcjxv6ICQ0GYqH4gR/?=
 =?us-ascii?Q?3IlH2GSmni21RzDGtSnNfcyt89pSBeYX4/mDPnPAG1KjgKPPqqQ6KQOBpzM/?=
 =?us-ascii?Q?reyP+4/UB/8SAXP3Dv9Uo80L1cLEkLFusPWq761iBTycRgDeDqXFzQMat2Fp?=
 =?us-ascii?Q?1SMiFmrqnsOY7c2nqMnJUsidbMLEmDSsDiu6CKStjHgYA0HDs0b5PpEQF6Jr?=
 =?us-ascii?Q?PPZVBjehJgnUAdKhqeV0LY93k11aW6buxER4GhhacbB4MGTNIl4C15eiWYCv?=
 =?us-ascii?Q?cAbOsXcneME4ghCu7nqkdun/ZvakZDk3hKL/ab8uSh/2aRKS+jIcies8y7uZ?=
 =?us-ascii?Q?UjfYOGUb0TwU4uVE0fiykSZAu+qjcTEl5AnWvfObbeeg2OUqECaUv0dTBESm?=
 =?us-ascii?Q?QbysDDNiXGZ/tMsWkwi/Yhc2o+6On6jXaWeVRrnKHk1BmtwG4KXcMRx9dKCA?=
 =?us-ascii?Q?EM2pSn2dLBiRO/OEhTbOVR+hyyG9PgC+LKo7dilrKZ6MB/Vj3Ap2mfvB+N6f?=
 =?us-ascii?Q?MpNiSr8HoeZI6z+IedMdfqNssCtLB4HyyVgHM3F+c2vWcUs8245+RYo4o20X?=
 =?us-ascii?Q?XFS46WSm0x4uiFDxeP1rGDxusi7XDSWPbCsdniRGggo74WMy5GXzn2e33TkT?=
 =?us-ascii?Q?QjRlSbj23cR7uL/S7uqSri2bzL6CpujkZ9L6JdCSsYmtTwPzO2VIkRnAe7ut?=
 =?us-ascii?Q?E5obFaYVuUulk2VsUKp2Wmrd5nXQyIdoBjboTRVQK8MMbdy1uA13lHW5HcUl?=
 =?us-ascii?Q?8fQCBOnJl3geDFBxEFo//1Ric49ORm636pQwnWe1Y5lmI0rtkqq9BoLzZslQ?=
 =?us-ascii?Q?16tSFQZznoV6YFu/hfBDI31RXKwz8p6323PNMw1RrTA/MPRXKHCjspQGdCTq?=
 =?us-ascii?Q?Bd1ZNNV/wkpCxbuyqZ/b9hLVwkWf5PbAjx1xRbaJBwJG8cYGAfrTBZ/Zmrwk?=
 =?us-ascii?Q?474bVg0AIPsmHZ9vELZUQNglr4FMpytAMFL9b2PqIp7Dtxulp+8j1TJJDVLQ?=
 =?us-ascii?Q?t4jjiJ5EwcEVAxbufL2sfpnxWcvWus6KckAVcozaMYjdDfiirHmPXqPG6myv?=
 =?us-ascii?Q?k+VDOeSwdndQBRPGfrujI69lNukNclV09OKvtcR5ilzE3nm3e7XIF8cBorm7?=
 =?us-ascii?Q?AMlFTQTOFRK3St+mw7oxP0aQ7J+XA6KXCyi5jjXw4kYugrmDAekUzzDyGdi6?=
 =?us-ascii?Q?W+z9Nq3OSdj5DerOi/HoYC8wJC9PiAg+AqZs6vav8fKFcUfERpZZghq9PzE8?=
 =?us-ascii?Q?QL1n6LyhVrb6Wudf294u1pvI+5iJ+C1rEZlaAbQ2cDCI26e8vh0KPygQhSuU?=
 =?us-ascii?Q?ndouVCH5iU335AT0T5BVq044Q0j7IZ4gUVCdv+twyCPpvZ/EYXpxgOmNswf/?=
 =?us-ascii?Q?sr0LH8pMsfLbFWOe1vNizo5+u8xJ5Pm7BxfFxJubrF0DYlvaKTIoF61TQ0Lr?=
 =?us-ascii?Q?P7YL7LJK6R8hgK5/XVAAunu58XKG00E/VyHOA+pF1qabURAkNOTOLLlz+DJI?=
 =?us-ascii?Q?5KFq9iH91hiZNnAY43xsRYXHyWsekeDdtHf2UIYZrHQ5rfGKJkoCDkSN2gKl?=
 =?us-ascii?Q?0qReN+0gD++eQj/w3Uq8k93tQRSSfas9H7GsRxs7eoNCm6V+sHQ/F/taa3XH?=
 =?us-ascii?Q?4k/vu9yzmKLfyy8gYXP3EgLfvckfpl+1CcqK2nzQGvD78TzhieXjWpYVV+3m?=
 =?us-ascii?Q?TuCJIbljZfXDhxErLHwH2uN9ZJiGo/cGrir1tO4BmBmKZPqIgSMy82ZXOH/T?=
 =?us-ascii?Q?6W4aaYkjSw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8380c8c3-0d12-41cb-aa6d-08da43b34ffe
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 09:44:25.1173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Is2pLa21F2r1zmvA6a6jse/AR7Pcf1U8V+s2h/qhpkKq7aXpZ9XYAcz1jhqikS8hipGWUtb0sQpPfYgWhNgO6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3897
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
 drivers/soc/imx/imx8mp-blk-ctrl.c | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
index 69191d7a2f54..9d1040f47b0c 100644
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
@@ -336,6 +345,8 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hdmi_domain_data[] = {
 		.clk_names = (const char *[]){ "axi", "apb" },
 		.num_clks = 2,
 		.gpc_name = "lcdif",
+		.path_names = (const char *[]){"lcdif-hdmi"},
+		.num_paths = 1,
 	},
 	[IMX8MP_HDMIBLK_PD_PAI] = {
 		.name = "hdmiblk-pai",
@@ -372,12 +383,16 @@ static const struct imx8mp_blk_ctrl_domain_data imx8mp_hdmi_domain_data[] = {
 		.clk_names = (const char *[]){ "axi", "apb" },
 		.num_clks = 2,
 		.gpc_name = "hrv",
+		.path_names = (const char *[]){"hrv"},
+		.num_paths = 1,
 	},
 	[IMX8MP_HDMIBLK_PD_HDCP] = {
 		.name = "hdmiblk-hdcp",
 		.clk_names = (const char *[]){ "axi", "apb" },
 		.num_clks = 2,
 		.gpc_name = "hdcp",
+		.path_names = (const char *[]){"hdcp"},
+		.num_paths = 1,
 	},
 };
 
@@ -421,6 +436,10 @@ static int imx8mp_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 		goto clk_disable;
 	}
 
+	ret = icc_bulk_set_bw(data->num_paths, domain->paths);
+	if (ret)
+		dev_err(bc->dev, "failed to set icc bw\n");
+
 	clk_bulk_disable_unprepare(data->num_clks, domain->clks);
 
 	return 0;
@@ -540,6 +559,19 @@ static int imx8mp_blk_ctrl_probe(struct platform_device *pdev)
 		for (j = 0; j < data->num_clks; j++)
 			domain->clks[j].id = data->clk_names[j];
 
+		for (j = 0; j < data->num_paths; j++) {
+			domain->paths[j].name = data->path_names[j];
+			domain->paths[j].avg_bw = INT_MAX;
+			domain->paths[j].peak_bw = INT_MAX;
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

