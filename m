Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F174827F8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 17:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiAAQkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 11:40:24 -0500
Received: from mail-vi1eur05on2078.outbound.protection.outlook.com ([40.107.21.78]:37760
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232544AbiAAQkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 11:40:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5VpsQ2Xw0LhzVP/Sz93OZj8FslSxKS6WDE/dqrHRqO55u1LsgSaetgWrAn8Ms8Tg+iArxeOR4VcLrA80X1F0FF2ONzkSa7b7sjXdjfer4zbPO2xZHhNLvAqRz81jD7fNZG5bN2Hv4KoBHW/2T0yWJXOTpC0G/hAEDAX5luDR6viwbL2sYUzEQ+Cnbyu3bbJho8ayQy0AHkxSp9eYTVgvWYwWSj3jdymgUKsnoTkcG7liqM4dOrXd20C/328U4ekw00OuP7nmm3oKwjgN5FmCNOWNqprEClb/nvVq/WDKNxFVv9024oOTP4AzUSQJP6a+jPpDRwn5VulZeI/jjIQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eriNmF3W4OEwQACsARp7f70NQGA2G3W1AGI+3SUrvxM=;
 b=KEyeB2P6gteq30kQZ4ceOSmH332dQF1xLHVw2q9uOBfIPHyznCxMeMMWLL55rQd9PbPrsF8ovzjB54Qxz8Fk4SOcGIZULIaDExwphdN4Rx7unE7eKtu/Pp4i1n23rKQd/35BQDp8389iUGTLNEpCCtat4oQ53XE4BfWLzPcfWLbE6hM1kJmkMucq4++O9IwfpDDK75kcVQ178kocUFQLGbLgp5m0x2Y7fzXwmLz5NZl22V1rYthWMbmAofJOYIp0hyt7GqMlGWUbbqZnTeVvBclgvEwP5OfFlGBpSKMdpG6+EF/mDyeBKQ+RLcC7llgIa35LB6PvCl3WZIjOG9BVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eriNmF3W4OEwQACsARp7f70NQGA2G3W1AGI+3SUrvxM=;
 b=S1WrQUQXzIE5r2Fg9ubi5LScwhSsWSbMp0qPQ8PxE59wPIQzRz7SjLVzG1Wps71ywblSsG94GGhhrJb4J+7Vc43duH88aahpMI/5EH8EkLv3Pm3PFqOl25DCQ2Cvt1e+xoeOl8QxsjR0vTGk0zMkucoBNoAuLLGpnjrpqkZ3iaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR0402MB2797.eurprd04.prod.outlook.com (2603:10a6:800:ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Sat, 1 Jan
 2022 16:40:15 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4844.015; Sat, 1 Jan 2022
 16:40:15 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] interconnect: imx8: Remove the imx_icc_node_adj_desc
Date:   Sat,  1 Jan 2022 18:39:56 +0200
Message-Id: <20220101163956.3344467-3-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220101163956.3344467-1-abel.vesa@nxp.com>
References: <20220101163956.3344467-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P18901CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::24) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a13f5f0-4d78-405d-24b3-08d9cd45634e
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2797:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB2797BA737FF17FAC94337BB0F6479@VI1PR0402MB2797.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ng2kXErhQpJIYcQw5Id6dv3j61TR6U7gJkBhlhmudeUsWFFirsC7Z6A/bX3TBDJITo9A4r7n3EiWKF46jRySYxgI8a0w1Y6qT/CkHGhDulxS3l4M+WRTE4Oxk892aXp1mL/ak6vV/DPRKNHyeDeOucH5Tab7V82JNkU8gfLa46hRZ2/W9gG24JLBlo1J6piT/s3ltSWK9eDIItxmMfjT8/mbU6S1/xs6mPv7uUfmrwxNbhbPcOhne3MLRcub5DuSTdoca0iQX9TAqGTOyeDuP46bMlwj1Hyn0en/uRATJr3jUSrQ44nZuGA79wgkRn2OTZDIA5wuOhMC28MBux5dTLbQCSaiw91e56TNvC6UGNT+YAe65PiFB1FbLHI6IyAxpBnlL9yzSDgdAIxgPO8NCev+ui5bL8LRnHAwQiY3HaoalFAozwq73aoInJti2vQnFErwzkObQYgK5lo+/amvLh4PlWergaIC9rWras5A0+JWxXNGoAOzIPbKf8ZdePmD/1X5jU7ZulgIvBP5cpiDdrlRCoE7/uYH+CWv+H2JVxoCuH0RS1Fh1fBZOAGusGnrMpso/iENG8d27ZN/LwcgMA8vRAEWDWumRCIHtCVwhGtRqk7ewRRJzhtlnx1TGf3C828CipH3jd/nGIhMvzQ7sSWt5KjJB6WL969utzIx+Vy4y8o/o2f2S5IJo5/d5C3gZmjoORkNj59PCZ8qpCaWSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(6512007)(5660300002)(6486002)(36756003)(38350700002)(38100700002)(66476007)(316002)(2906002)(44832011)(86362001)(8936002)(110136005)(52116002)(2616005)(1076003)(186003)(6666004)(30864003)(508600001)(8676002)(66556008)(83380400001)(26005)(6506007)(66946007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rllc6JscAFrokJiPxi2umSrPGVbgpFqPyG2paLAgOt4PANkLiEfelSDq3M42?=
 =?us-ascii?Q?96phxCin1GQ4jOAFRV7H5I8AmHxqkQG/eiyLhRlJ0yF/wOGu5U3VJvYgQuco?=
 =?us-ascii?Q?WxLTiB+8qNN3FhxZxM+JGeCfeFmh+sFZVzhXz/mX7g4ngUgDBsyEhYvi5cru?=
 =?us-ascii?Q?QXiVxKDH9vGDFt4E5nCh/uGVKvu5/EO3hTe4awkldGxNVfpGRurvY9XOla0V?=
 =?us-ascii?Q?FgqnbSxgXZzQH9maq4NGQmsDbqsCc29fzeC6yGW8vFVsaZppJ5Jbyxvtx0aR?=
 =?us-ascii?Q?gRDErVwShC15q3fhBw/SI51gJWdbKsVZOGNmsBknxpShEYWerlnGQ8wjh8ZZ?=
 =?us-ascii?Q?2hX0rrbkEF2nFqUqCfhHKcGef//yPDsf7eoceUfvx6Lst5wQrB38bArxb/HD?=
 =?us-ascii?Q?FtUl22+J8hZMYtw9XMjuH8SO0FzxlWJA/7HQA6civSe1+JcCvon53LrYmcsa?=
 =?us-ascii?Q?6kyEozftqcN4FW01nBzDUBo676TP9gweGjtu5UYedM8BUUwue06eXIgnQjcJ?=
 =?us-ascii?Q?i8+wPB9OsrxEvljbNfizQ3lFnJDePh+v3x1k33m6pFg7ET4lCllJK72IyZfR?=
 =?us-ascii?Q?Zgfm6CMDI78gDrbf98RR89/pz+vSoUX46pc/cXMzBGdKextLo/c/fiZj4Q5c?=
 =?us-ascii?Q?MS4VHQ9l0m/uYk2Xmj2Gal+bNxUpD8tsMTgpEIq08z5gIUQ+cZucaccdVrtE?=
 =?us-ascii?Q?yev2SPFCznm7poFX5Ii0FmDGLfuq/WbCQ9LAajAY6D71iKGc5t7OLJhzRS66?=
 =?us-ascii?Q?e+qxFkIhaEIhg5mokdR4bBOB+Q4intbMzmd+FfwzE+8VnjEtzptAGeqraMhG?=
 =?us-ascii?Q?PslOMTJj2KegcPmzuY8z/8T5Ml8J/Kj1EHNT6hRf8owzzouccn1yOuOQiZrS?=
 =?us-ascii?Q?4ngl93o76vC5XWAZZ8XhYTzxkZz3L1/vbQN6zOIKgWTtYc2eNe0QPE5HBtBO?=
 =?us-ascii?Q?3bRaclP/OBzyS3bWoGQa5POmt/utcHmHU9ZoAfYLqT2HpNBn+WAE1pZc2NPf?=
 =?us-ascii?Q?64ibjgUhwLLktp5GTeMkCCRIWUG1tHiEpwERTTuf6lDFJSY0Ev4eg9hKLi+c?=
 =?us-ascii?Q?dyXH0MY1N12OBF1Tv+7pYdRzFMD3t/b/oG0vgvq2wENpB8ARyqqzQghsTVvb?=
 =?us-ascii?Q?MX5fdiucRPrUXDy/mxD718fUY5flht9s8G2uJF5BNi41fwXSi3Q6GeqeJfUK?=
 =?us-ascii?Q?g7u+kunzM/MSTkycZQsqqxSBDSOdZJBtdNwdFODVm/soba0VrlXts1qY7Zbo?=
 =?us-ascii?Q?AYxTEhzB4xUJdt0B4Mu8SONJHgi0KHt8kKvOE88YNiN1CsYYXSq9p5Lyqiup?=
 =?us-ascii?Q?eIZnrPN4H1zEEepxcv7pGiqxRPYPuxgF3GD5p1CG5TzZHs8mbd2rBVqdJwK3?=
 =?us-ascii?Q?bYyf88qccgX+bOsUcIkM1KXUzaPAN62bAev6YwTzaWAypDy1A6m93fniASv+?=
 =?us-ascii?Q?pvvCUpnsTUkBOxqN9Xva/WDMV6GPyxRUTOubCAZQkYSLoIrIVyiCbN3tMRD5?=
 =?us-ascii?Q?TvPEyNRFJmCAdVOLorbI/EN9Py/H2XC9pgMLPe6wihq3epq9zRkVzC7N5f87?=
 =?us-ascii?Q?aQmSLDi72ym3kq0ITxgcK9td/SQY6n6pUtbILAcuRNr2ZHq2fQBI8DoKm/AB?=
 =?us-ascii?Q?w4DyUswat5wjzpOyaR0OhjI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a13f5f0-4d78-405d-24b3-08d9cd45634e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2022 16:40:15.3478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6CUEc9zpZH2NyZt1cn2cu0kJE+wvK9y7k2KXiXKf2aB4BU4OhxZZAZmCqhhV1fDOJqdylw5+cgay3/l84BMcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2797
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the imx generic interconnect doesn't use the
imx_icc_node_adj_desc, we remove it from all the i.MX8M
platform drivers.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---

Changes since v1:
 * added missing comma for the "PL301_MAIN" node in i.MX8MN which fixes
   the build

 drivers/interconnect/imx/imx.h    | 19 ++++-------------
 drivers/interconnect/imx/imx8mm.c | 32 +++++++++-------------------
 drivers/interconnect/imx/imx8mn.c | 28 +++++++------------------
 drivers/interconnect/imx/imx8mq.c | 35 ++++++++++---------------------
 4 files changed, 33 insertions(+), 81 deletions(-)

diff --git a/drivers/interconnect/imx/imx.h b/drivers/interconnect/imx/imx.h
index 75da51076c68..5c9f5138f6aa 100644
--- a/drivers/interconnect/imx/imx.h
+++ b/drivers/interconnect/imx/imx.h
@@ -14,15 +14,6 @@
 
 #define IMX_ICC_MAX_LINKS	4
 
-/*
- * struct imx_icc_node_adj - Describe a dynamic adjustable node
- */
-struct imx_icc_node_adj_desc {
-	unsigned int bw_mul, bw_div;
-	const char *phandle_name;
-	bool main_noc;
-};
-
 /*
  * struct imx_icc_node - Describe an interconnect node
  * @name: name of the node
@@ -35,23 +26,21 @@ struct imx_icc_node_desc {
 	u16 id;
 	u16 links[IMX_ICC_MAX_LINKS];
 	u16 num_links;
-	const struct imx_icc_node_adj_desc *adj;
 };
 
-#define DEFINE_BUS_INTERCONNECT(_name, _id, _adj, ...)			\
+#define DEFINE_BUS_INTERCONNECT(_name, _id, ...)			\
 	{								\
 		.id = _id,						\
 		.name = _name,						\
-		.adj = _adj,						\
 		.num_links = ARRAY_SIZE(((int[]){ __VA_ARGS__ })),	\
 		.links = { __VA_ARGS__ },				\
 	}
 
 #define DEFINE_BUS_MASTER(_name, _id, _dest_id)				\
-	DEFINE_BUS_INTERCONNECT(_name, _id, NULL, _dest_id)
+	DEFINE_BUS_INTERCONNECT(_name, _id, _dest_id)
 
-#define DEFINE_BUS_SLAVE(_name, _id, _adj)				\
-	DEFINE_BUS_INTERCONNECT(_name, _id, _adj)
+#define DEFINE_BUS_SLAVE(_name, _id)					\
+	DEFINE_BUS_INTERCONNECT(_name, _id)
 
 int imx_icc_register(struct platform_device *pdev,
 		     struct imx_icc_node_desc *nodes,
diff --git a/drivers/interconnect/imx/imx8mm.c b/drivers/interconnect/imx/imx8mm.c
index 1083490bb391..0c16110bef9d 100644
--- a/drivers/interconnect/imx/imx8mm.c
+++ b/drivers/interconnect/imx/imx8mm.c
@@ -14,18 +14,6 @@
 
 #include "imx.h"
 
-static const struct imx_icc_node_adj_desc imx8mm_dram_adj = {
-	.bw_mul = 1,
-	.bw_div = 16,
-	.phandle_name = "fsl,ddrc",
-};
-
-static const struct imx_icc_node_adj_desc imx8mm_noc_adj = {
-	.bw_mul = 1,
-	.bw_div = 16,
-	.main_noc = true,
-};
-
 /*
  * Describe bus masters, slaves and connections between them
  *
@@ -33,43 +21,43 @@ static const struct imx_icc_node_adj_desc imx8mm_noc_adj = {
  * PL301 nics which are skipped/merged into PL301_MAIN
  */
 static struct imx_icc_node_desc nodes[] = {
-	DEFINE_BUS_INTERCONNECT("NOC", IMX8MM_ICN_NOC, &imx8mm_noc_adj,
+	DEFINE_BUS_INTERCONNECT("NOC", IMX8MM_ICN_NOC,
 			IMX8MM_ICS_DRAM, IMX8MM_ICN_MAIN),
 
-	DEFINE_BUS_SLAVE("DRAM", IMX8MM_ICS_DRAM, &imx8mm_dram_adj),
-	DEFINE_BUS_SLAVE("OCRAM", IMX8MM_ICS_OCRAM, NULL),
+	DEFINE_BUS_SLAVE("DRAM", IMX8MM_ICS_DRAM),
+	DEFINE_BUS_SLAVE("OCRAM", IMX8MM_ICS_OCRAM),
 	DEFINE_BUS_MASTER("A53", IMX8MM_ICM_A53, IMX8MM_ICN_NOC),
 
 	/* VPUMIX */
 	DEFINE_BUS_MASTER("VPU H1", IMX8MM_ICM_VPU_H1, IMX8MM_ICN_VIDEO),
 	DEFINE_BUS_MASTER("VPU G1", IMX8MM_ICM_VPU_G1, IMX8MM_ICN_VIDEO),
 	DEFINE_BUS_MASTER("VPU G2", IMX8MM_ICM_VPU_G2, IMX8MM_ICN_VIDEO),
-	DEFINE_BUS_INTERCONNECT("PL301_VIDEO", IMX8MM_ICN_VIDEO, NULL, IMX8MM_ICN_NOC),
+	DEFINE_BUS_INTERCONNECT("PL301_VIDEO", IMX8MM_ICN_VIDEO, IMX8MM_ICN_NOC),
 
 	/* GPUMIX */
 	DEFINE_BUS_MASTER("GPU 2D", IMX8MM_ICM_GPU2D, IMX8MM_ICN_GPU),
 	DEFINE_BUS_MASTER("GPU 3D", IMX8MM_ICM_GPU3D, IMX8MM_ICN_GPU),
-	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MM_ICN_GPU, NULL, IMX8MM_ICN_NOC),
+	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MM_ICN_GPU, IMX8MM_ICN_NOC),
 
 	/* DISPLAYMIX */
 	DEFINE_BUS_MASTER("CSI", IMX8MM_ICM_CSI, IMX8MM_ICN_MIPI),
 	DEFINE_BUS_MASTER("LCDIF", IMX8MM_ICM_LCDIF, IMX8MM_ICN_MIPI),
-	DEFINE_BUS_INTERCONNECT("PL301_MIPI", IMX8MM_ICN_MIPI, NULL, IMX8MM_ICN_NOC),
+	DEFINE_BUS_INTERCONNECT("PL301_MIPI", IMX8MM_ICN_MIPI, IMX8MM_ICN_NOC),
 
 	/* HSIO */
 	DEFINE_BUS_MASTER("USB1", IMX8MM_ICM_USB1, IMX8MM_ICN_HSIO),
 	DEFINE_BUS_MASTER("USB2", IMX8MM_ICM_USB2, IMX8MM_ICN_HSIO),
 	DEFINE_BUS_MASTER("PCIE", IMX8MM_ICM_PCIE, IMX8MM_ICN_HSIO),
-	DEFINE_BUS_INTERCONNECT("PL301_HSIO", IMX8MM_ICN_HSIO, NULL, IMX8MM_ICN_NOC),
+	DEFINE_BUS_INTERCONNECT("PL301_HSIO", IMX8MM_ICN_HSIO, IMX8MM_ICN_NOC),
 
 	/* Audio */
 	DEFINE_BUS_MASTER("SDMA2", IMX8MM_ICM_SDMA2, IMX8MM_ICN_AUDIO),
 	DEFINE_BUS_MASTER("SDMA3", IMX8MM_ICM_SDMA3, IMX8MM_ICN_AUDIO),
-	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MM_ICN_AUDIO, NULL, IMX8MM_ICN_MAIN),
+	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MM_ICN_AUDIO, IMX8MM_ICN_MAIN),
 
 	/* Ethernet */
 	DEFINE_BUS_MASTER("ENET", IMX8MM_ICM_ENET, IMX8MM_ICN_ENET),
-	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MM_ICN_ENET, NULL, IMX8MM_ICN_MAIN),
+	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MM_ICN_ENET, IMX8MM_ICN_MAIN),
 
 	/* Other */
 	DEFINE_BUS_MASTER("SDMA1", IMX8MM_ICM_SDMA1, IMX8MM_ICN_MAIN),
@@ -77,7 +65,7 @@ static struct imx_icc_node_desc nodes[] = {
 	DEFINE_BUS_MASTER("USDHC1", IMX8MM_ICM_USDHC1, IMX8MM_ICN_MAIN),
 	DEFINE_BUS_MASTER("USDHC2", IMX8MM_ICM_USDHC2, IMX8MM_ICN_MAIN),
 	DEFINE_BUS_MASTER("USDHC3", IMX8MM_ICM_USDHC3, IMX8MM_ICN_MAIN),
-	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MM_ICN_MAIN, NULL,
+	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MM_ICN_MAIN,
 			IMX8MM_ICN_NOC, IMX8MM_ICS_OCRAM),
 };
 
diff --git a/drivers/interconnect/imx/imx8mn.c b/drivers/interconnect/imx/imx8mn.c
index ad97e55fd4e5..f03f8db00917 100644
--- a/drivers/interconnect/imx/imx8mn.c
+++ b/drivers/interconnect/imx/imx8mn.c
@@ -11,18 +11,6 @@
 
 #include "imx.h"
 
-static const struct imx_icc_node_adj_desc imx8mn_dram_adj = {
-	.bw_mul = 1,
-	.bw_div = 4,
-	.phandle_name = "fsl,ddrc",
-};
-
-static const struct imx_icc_node_adj_desc imx8mn_noc_adj = {
-	.bw_mul = 1,
-	.bw_div = 4,
-	.main_noc = true,
-};
-
 /*
  * Describe bus masters, slaves and connections between them
  *
@@ -30,23 +18,23 @@ static const struct imx_icc_node_adj_desc imx8mn_noc_adj = {
  * PL301 nics which are skipped/merged into PL301_MAIN
  */
 static struct imx_icc_node_desc nodes[] = {
-	DEFINE_BUS_INTERCONNECT("NOC", IMX8MN_ICN_NOC, &imx8mn_noc_adj,
+	DEFINE_BUS_INTERCONNECT("NOC", IMX8MN_ICN_NOC,
 			IMX8MN_ICS_DRAM, IMX8MN_ICN_MAIN),
 
-	DEFINE_BUS_SLAVE("DRAM", IMX8MN_ICS_DRAM, &imx8mn_dram_adj),
-	DEFINE_BUS_SLAVE("OCRAM", IMX8MN_ICS_OCRAM, NULL),
+	DEFINE_BUS_SLAVE("DRAM", IMX8MN_ICS_DRAM),
+	DEFINE_BUS_SLAVE("OCRAM", IMX8MN_ICS_OCRAM),
 	DEFINE_BUS_MASTER("A53", IMX8MN_ICM_A53, IMX8MN_ICN_NOC),
 
 	/* GPUMIX */
 	DEFINE_BUS_MASTER("GPU", IMX8MN_ICM_GPU, IMX8MN_ICN_GPU),
-	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MN_ICN_GPU, NULL, IMX8MN_ICN_NOC),
+	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MN_ICN_GPU, IMX8MN_ICN_NOC),
 
 	/* DISPLAYMIX */
 	DEFINE_BUS_MASTER("CSI1", IMX8MN_ICM_CSI1, IMX8MN_ICN_MIPI),
 	DEFINE_BUS_MASTER("CSI2", IMX8MN_ICM_CSI2, IMX8MN_ICN_MIPI),
 	DEFINE_BUS_MASTER("ISI", IMX8MN_ICM_ISI, IMX8MN_ICN_MIPI),
 	DEFINE_BUS_MASTER("LCDIF", IMX8MN_ICM_LCDIF, IMX8MN_ICN_MIPI),
-	DEFINE_BUS_INTERCONNECT("PL301_MIPI", IMX8MN_ICN_MIPI, NULL, IMX8MN_ICN_NOC),
+	DEFINE_BUS_INTERCONNECT("PL301_MIPI", IMX8MN_ICN_MIPI, IMX8MN_ICN_NOC),
 
 	/* USB goes straight to NOC */
 	DEFINE_BUS_MASTER("USB", IMX8MN_ICM_USB, IMX8MN_ICN_NOC),
@@ -54,11 +42,11 @@ static struct imx_icc_node_desc nodes[] = {
 	/* Audio */
 	DEFINE_BUS_MASTER("SDMA2", IMX8MN_ICM_SDMA2, IMX8MN_ICN_AUDIO),
 	DEFINE_BUS_MASTER("SDMA3", IMX8MN_ICM_SDMA3, IMX8MN_ICN_AUDIO),
-	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MN_ICN_AUDIO, NULL, IMX8MN_ICN_MAIN),
+	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MN_ICN_AUDIO, IMX8MN_ICN_MAIN),
 
 	/* Ethernet */
 	DEFINE_BUS_MASTER("ENET", IMX8MN_ICM_ENET, IMX8MN_ICN_ENET),
-	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MN_ICN_ENET, NULL, IMX8MN_ICN_MAIN),
+	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MN_ICN_ENET, IMX8MN_ICN_MAIN),
 
 	/* Other */
 	DEFINE_BUS_MASTER("SDMA1", IMX8MN_ICM_SDMA1, IMX8MN_ICN_MAIN),
@@ -66,7 +54,7 @@ static struct imx_icc_node_desc nodes[] = {
 	DEFINE_BUS_MASTER("USDHC1", IMX8MN_ICM_USDHC1, IMX8MN_ICN_MAIN),
 	DEFINE_BUS_MASTER("USDHC2", IMX8MN_ICM_USDHC2, IMX8MN_ICN_MAIN),
 	DEFINE_BUS_MASTER("USDHC3", IMX8MN_ICM_USDHC3, IMX8MN_ICN_MAIN),
-	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MN_ICN_MAIN, NULL,
+	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MN_ICN_MAIN,
 			IMX8MN_ICN_NOC, IMX8MN_ICS_OCRAM),
 };
 
diff --git a/drivers/interconnect/imx/imx8mq.c b/drivers/interconnect/imx/imx8mq.c
index d7768d3c6d8a..b8c36d668946 100644
--- a/drivers/interconnect/imx/imx8mq.c
+++ b/drivers/interconnect/imx/imx8mq.c
@@ -12,18 +12,6 @@
 
 #include "imx.h"
 
-static const struct imx_icc_node_adj_desc imx8mq_dram_adj = {
-	.bw_mul = 1,
-	.bw_div = 4,
-	.phandle_name = "fsl,ddrc",
-};
-
-static const struct imx_icc_node_adj_desc imx8mq_noc_adj = {
-	.bw_mul = 1,
-	.bw_div = 4,
-	.main_noc = true,
-};
-
 /*
  * Describe bus masters, slaves and connections between them
  *
@@ -31,43 +19,42 @@ static const struct imx_icc_node_adj_desc imx8mq_noc_adj = {
  * PL301 nics which are skipped/merged into PL301_MAIN
  */
 static struct imx_icc_node_desc nodes[] = {
-	DEFINE_BUS_INTERCONNECT("NOC", IMX8MQ_ICN_NOC, &imx8mq_noc_adj,
-			IMX8MQ_ICS_DRAM, IMX8MQ_ICN_MAIN),
+	DEFINE_BUS_INTERCONNECT("NOC", IMX8MQ_ICN_NOC, IMX8MQ_ICS_DRAM, IMX8MQ_ICN_MAIN),
 
-	DEFINE_BUS_SLAVE("DRAM", IMX8MQ_ICS_DRAM, &imx8mq_dram_adj),
-	DEFINE_BUS_SLAVE("OCRAM", IMX8MQ_ICS_OCRAM, NULL),
+	DEFINE_BUS_SLAVE("DRAM", IMX8MQ_ICS_DRAM),
+	DEFINE_BUS_SLAVE("OCRAM", IMX8MQ_ICS_OCRAM),
 	DEFINE_BUS_MASTER("A53", IMX8MQ_ICM_A53, IMX8MQ_ICN_NOC),
 
 	/* VPUMIX */
 	DEFINE_BUS_MASTER("VPU", IMX8MQ_ICM_VPU, IMX8MQ_ICN_VIDEO),
-	DEFINE_BUS_INTERCONNECT("PL301_VIDEO", IMX8MQ_ICN_VIDEO, NULL, IMX8MQ_ICN_NOC),
+	DEFINE_BUS_INTERCONNECT("PL301_VIDEO", IMX8MQ_ICN_VIDEO, IMX8MQ_ICN_NOC),
 
 	/* GPUMIX */
 	DEFINE_BUS_MASTER("GPU", IMX8MQ_ICM_GPU, IMX8MQ_ICN_GPU),
-	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MQ_ICN_GPU, NULL, IMX8MQ_ICN_NOC),
+	DEFINE_BUS_INTERCONNECT("PL301_GPU", IMX8MQ_ICN_GPU, IMX8MQ_ICN_NOC),
 
 	/* DISPMIX (only for DCSS) */
 	DEFINE_BUS_MASTER("DC", IMX8MQ_ICM_DCSS, IMX8MQ_ICN_DCSS),
-	DEFINE_BUS_INTERCONNECT("PL301_DC", IMX8MQ_ICN_DCSS, NULL, IMX8MQ_ICN_NOC),
+	DEFINE_BUS_INTERCONNECT("PL301_DC", IMX8MQ_ICN_DCSS, IMX8MQ_ICN_NOC),
 
 	/* USBMIX */
 	DEFINE_BUS_MASTER("USB1", IMX8MQ_ICM_USB1, IMX8MQ_ICN_USB),
 	DEFINE_BUS_MASTER("USB2", IMX8MQ_ICM_USB2, IMX8MQ_ICN_USB),
-	DEFINE_BUS_INTERCONNECT("PL301_USB", IMX8MQ_ICN_USB, NULL, IMX8MQ_ICN_NOC),
+	DEFINE_BUS_INTERCONNECT("PL301_USB", IMX8MQ_ICN_USB, IMX8MQ_ICN_NOC),
 
 	/* PL301_DISPLAY (IPs other than DCSS, inside SUPERMIX) */
 	DEFINE_BUS_MASTER("CSI1", IMX8MQ_ICM_CSI1, IMX8MQ_ICN_DISPLAY),
 	DEFINE_BUS_MASTER("CSI2", IMX8MQ_ICM_CSI2, IMX8MQ_ICN_DISPLAY),
 	DEFINE_BUS_MASTER("LCDIF", IMX8MQ_ICM_LCDIF, IMX8MQ_ICN_DISPLAY),
-	DEFINE_BUS_INTERCONNECT("PL301_DISPLAY", IMX8MQ_ICN_DISPLAY, NULL, IMX8MQ_ICN_MAIN),
+	DEFINE_BUS_INTERCONNECT("PL301_DISPLAY", IMX8MQ_ICN_DISPLAY, IMX8MQ_ICN_MAIN),
 
 	/* AUDIO */
 	DEFINE_BUS_MASTER("SDMA2", IMX8MQ_ICM_SDMA2, IMX8MQ_ICN_AUDIO),
-	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MQ_ICN_AUDIO, NULL, IMX8MQ_ICN_DISPLAY),
+	DEFINE_BUS_INTERCONNECT("PL301_AUDIO", IMX8MQ_ICN_AUDIO, IMX8MQ_ICN_DISPLAY),
 
 	/* ENET */
 	DEFINE_BUS_MASTER("ENET", IMX8MQ_ICM_ENET, IMX8MQ_ICN_ENET),
-	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MQ_ICN_ENET, NULL, IMX8MQ_ICN_MAIN),
+	DEFINE_BUS_INTERCONNECT("PL301_ENET", IMX8MQ_ICN_ENET, IMX8MQ_ICN_MAIN),
 
 	/* OTHER */
 	DEFINE_BUS_MASTER("SDMA1", IMX8MQ_ICM_SDMA1, IMX8MQ_ICN_MAIN),
@@ -76,7 +63,7 @@ static struct imx_icc_node_desc nodes[] = {
 	DEFINE_BUS_MASTER("USDHC2", IMX8MQ_ICM_USDHC2, IMX8MQ_ICN_MAIN),
 	DEFINE_BUS_MASTER("PCIE1", IMX8MQ_ICM_PCIE1, IMX8MQ_ICN_MAIN),
 	DEFINE_BUS_MASTER("PCIE2", IMX8MQ_ICM_PCIE2, IMX8MQ_ICN_MAIN),
-	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MQ_ICN_MAIN, NULL,
+	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MQ_ICN_MAIN,
 			IMX8MQ_ICN_NOC, IMX8MQ_ICS_OCRAM),
 };
 
-- 
2.31.1

