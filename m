Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42844867D3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 17:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbiAFQmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 11:42:11 -0500
Received: from mail-am6eur05on2044.outbound.protection.outlook.com ([40.107.22.44]:18017
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241367AbiAFQmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 11:42:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E78x16zrDulaJ0av3WVc3pHzQU6eN7XowiLuUKILe3rBSC4Q+QkTP3Dr5GGEUjrphstaEBUtJ9kUUbLGbY7ekMf7OTPO0f8JgdpzW/npWFEhKcGR7qqIsQ7hyw7jKfS2I05LkyMEB+qa0l79CEU3CxqxKrBW4nzrQSq5LjDT+8PehRdVhit11YrcCMrW32YyWxerh9RMoTuto5ubARerxDqgdgRVvQYCITZ/8K1PzkMvtXc1Z/p+RtZIbXwiSQZ1RwmC1QAjIF9h9wli5J+34meBI+Jl/FOBqBGEXm3VetHZiSdpgUKDoh1bqIscqYyXkh6tpRf3DMd7H472Vuv/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsfVulp2W03e6NGLFHQToVhMlO76NSvLIOSe8hAqpyY=;
 b=kp1tMJfl62OBANkWE8jj+9OB+GEBVlIKmqTvCDFM26EPgDwrQyikDJyQFLS9T45uQaFxaJvE2CbuimjKARuXcPhxTpGUGakQZFtt3hneD5uEATS8cju+ZYpBoZKX7YMbCnIdlK/WyrQP64XLZnIheIfoBjitjOt+0U0ERHpWsbUFZAlV3bnSf0dYUShOz89cl9+zyTFMwT1zhGzMJ8WjcWcBVspFW3IWaRKUiS2l6rTaR9NIm4Wp6sXk9Fv6Sa2F6O/ZPEmz6aLwt+cI9L/6P/9cZVaFljiJFDguUlcYJPhiFlz0QrlgZB7i20uN0jbSXfcAZMSmqjEYr23FetBk1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsfVulp2W03e6NGLFHQToVhMlO76NSvLIOSe8hAqpyY=;
 b=paZFDp8C5WhMHU8RHRsqED/kp9mOr1MWd94sP2xuCj8mqOGwC9RW01epUfJTdU3E0kDTeWYK+LOL3Y3qiJB5YbI0f7ZlDFYf/VYkG6PxG170L5l4Z2UrKQAVIiTHos122pTwYJw1ernGK37Pm71b+ExaJYqb5n5R5UK8S3S5hhs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR0402MB3837.eurprd04.prod.outlook.com (2603:10a6:803:25::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 16:42:01 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4844.016; Thu, 6 Jan 2022
 16:42:01 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v4 3/3] interconnect: imx: Remove the imx_icc_node_adj_desc
Date:   Thu,  6 Jan 2022 18:41:50 +0200
Message-Id: <20220106164150.3474048-3-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220106164150.3474048-1-abel.vesa@nxp.com>
References: <20220106164150.3474048-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0046.eurprd04.prod.outlook.com
 (2603:10a6:802:2::17) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01be0678-a8b8-4ecd-1305-08d9d13376bd
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3837:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB3837F10713C1775B615C8685F64C9@VI1PR0402MB3837.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RgzLTToCATdiQVGeXcSjqSvtBElzYq4T6enfoHNOWmbV5yXLOk+VNqtHNhczbgLTdHi2jSRQJ3AZOqqYAnD5+CGojX3x8SjOWnSopW9mlWFoWiXcuX4jxp4To21BCoIcR7q+Chd79QPoPG1kt7gMJN3kvQvx8fWS7cDwOFh0gxUh6wbD7ll7Y9WBeIBxZt3j133FeP4u0nC2IKGBXLS/CiIkZTsmpCrzepcw1VR4xN32aHr8SaaUqtR3fdRJ9QWDto5t59r/787Scy7/CpL2ZJtWrXfHIlwO6Y3mPs42Dn6HNBpbQML3V5NU+ehnXAS116+6qULdgz5zN/gtNIFpEanEV6SfwvVZzcYCwJdt1Z/uZw3L7r5aVGVQ0KDi6r0WCgpxw0ffZakX6xBFagEnWP3TX3Jt08mG+3BOsBLiyZ7b0FZbLoyYHuJLTlMDvqvjlO3nKswiH0sphFGRecs0wcOhoTuCKEbrtkEB+YE6S2SAuXkN/4Q9IdS5juAAje+/MYcCgDdw5uUXubi7OepQtf8JiMVG2eLgj6Hr/Ac6rdV8EMVV0EHDA4fhEbW8vdxGbtGh+04JwgNcX6IysftjbZdApfYkPF1J6rvAXx4uhDoSbWub13xGogHhOmbl7Tc3rY6LkAhhZBpiwxkHnEzd6sZeXk/chXm2sRQork2YnVrZyRQ2vrZFoYqO+Ukws2Tv70PJZh4EjC9mE+0zt5JGjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(6506007)(8936002)(52116002)(110136005)(54906003)(26005)(6512007)(508600001)(2906002)(2616005)(6486002)(4326008)(30864003)(6666004)(1076003)(186003)(66946007)(86362001)(66556008)(44832011)(66476007)(5660300002)(316002)(36756003)(38100700002)(83380400001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KH5vZYnKmZrdyklhrNtgBgFHZSRNJ2pYwO0t+M/ZfFycHRzNbLswaBhVTvAz?=
 =?us-ascii?Q?4jipCiS5S7hz4mQtPyaFXIx0heSilr1gUFsfXJyTqntkqJsH/Qioiyqq8Ej7?=
 =?us-ascii?Q?/PGk1rvWdyepMIXxrt2w36fOhDY+TQEAitm81+bQmHBzxvJTDHZJWL4IN6Ns?=
 =?us-ascii?Q?N5H1/0TyNT1UV30VCRI4PHV7zr6ldRt2yw4KFZe1wmdgjiyLXbzMvNfoLu4q?=
 =?us-ascii?Q?6L2tg63YyzedyJu+tO2ZGCtkdiDOc1OjL4S6HP0793afivCtvL5gxWn60sZu?=
 =?us-ascii?Q?kh9UQhMYIs691XTRMRISOC1gk8wHLa4SmKtilDxwYSDnJ1vLvaLumFcMxecg?=
 =?us-ascii?Q?J7lGvP6wK3lQ3cYHc2L4fNoxa29vYBo6k0c14wEFgjneRl3gAZmzHjDaTsyg?=
 =?us-ascii?Q?JMfrQoqdEmhxdhCaFRfhzUBw2v7VVjqb/Yn03vbn67LWLWElwIjA5+UMKChz?=
 =?us-ascii?Q?fFTEGUCx3q+Wip+h96uN6EZfsgpesPw1GTT1wfBnyKJC2SLsqVIlnnkfQhWq?=
 =?us-ascii?Q?3Rie/CjUfD1y0YA/xlUyoq6Ti8LplLdL+JHu8UjudQ5270QuQWcB1jOgUdkg?=
 =?us-ascii?Q?OIzd+tNV5JU3KpnQ4H3V16ggknjeq6mjTYKY00JjcPC+XtVhRshDSGfa3z1L?=
 =?us-ascii?Q?t4ZFcJm01+PnpPpixShOe0DTiO43SYx7jghnFxYLYr0l1SYGqetuzvEWEsBn?=
 =?us-ascii?Q?kMx/VrQYRXA5sCjt2fYiQLr15bPIPyGQEX/KN8FrPt6FqdFKp363o6vLkHmE?=
 =?us-ascii?Q?qXTMjftwhkYQEEadyOsiUg38XdBgGB7oxQWQ9lDFP35E/oQcEc4D0thP2TMz?=
 =?us-ascii?Q?uHp33C3YfQiGT9sYlSbJNKU9LV3kYHXbFsiE1oxSZ7lMjjkGxD1fEujQmnWx?=
 =?us-ascii?Q?Cev02B/0A3BwG3vJmxfext27XriI978FalalCD1KzjrG6sqXYU/vRLzjnlI3?=
 =?us-ascii?Q?JkNOGlqOKOHUga7cv8BmMBGjFcwXj6NvQTcldWtMrUut9esBGxPuhTiSM4vF?=
 =?us-ascii?Q?mSalM13tIdlZsDyV0Kfra2XSLtTnXrFX+D+bEviGB17i3YW+W0+OTD9U5TVw?=
 =?us-ascii?Q?tdv/bNJvkaKE4J8A9F9yK90aA5ByDTnNyx/HB5gW2HtVNAUbjgy8RYSc9WB5?=
 =?us-ascii?Q?cZjfvocqPHdgAnriGsQewa8NW4C8mzP5e2MlW6buap8gdpekpthbjNQaK4yx?=
 =?us-ascii?Q?HRtOCLaS1qsgmpA31VsSwJrf4FWABgtNe457PdQIHPiyvVSlXdTmZE2kTPAX?=
 =?us-ascii?Q?Prs1sg7cBw4mCjPWsVWURXhUrgWOKjFJOjOOgdZa7gxGFZz+G5C0ARg/P/0J?=
 =?us-ascii?Q?krYqARSLWRXIg02YVFeFnFzQyDp+4/6XukOAEUEAYmvEkfaI8ucVUL+eHJh4?=
 =?us-ascii?Q?XBCRUOpDZpwusAubHcI0WpKm3ve9NWYq73bQf5rnr67Ax6ftcBDGBvWXp4Ou?=
 =?us-ascii?Q?3A3VoDNZuLay7XVIuxhzr4mkQkx9VNj1rYi6k1q2zNf8NgTt8jwMq8hT6rWd?=
 =?us-ascii?Q?MGXais0obVmc/aAVTtALYbSCMtL93TT7DKAgjdHDjQWmxOkQoXpI2kHX22NW?=
 =?us-ascii?Q?KycF3RTg6X46PZzT0RvBA50OziWU1m7kZ6Z89j+S83BbEocsnD2e83MC7Z6t?=
 =?us-ascii?Q?nqJ/LnNd67LcLG0Gq8AEtiw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01be0678-a8b8-4ecd-1305-08d9d13376bd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 16:42:01.6635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wFWrCHQGmjlGOgrWxkm0aaQ08qrJYjKTeyhsn1f2dqvDKBgKG0boRBmQr2XMS4F4Cib6vC3BbXiVZUABbaBKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3837
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the imx generic interconnect doesn't use the
imx_icc_node_adj_desc, we remove it from all the i.MX8M
platform drivers.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---

Changes since v3:
 * none

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

