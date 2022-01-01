Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7949F4827E1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 16:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiAAPxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 10:53:10 -0500
Received: from mail-eopbgr00048.outbound.protection.outlook.com ([40.107.0.48]:58694
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232490AbiAAPxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 10:53:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFsSIrZaLAdEhQnHPdjfTTTXDXFW6bk2gcjB4IqYz5RXxAuERtJpGeQdO29k344QoRIJp3fQnFzoO3TSFOMYrz2i71frFyV1c+lIs2ANN+BNpCKm/tqMSqk7q01sml30TakR3pbHOzFbHWgqmejZUQmD8SNE+Sfvkzc3wdgA1RWk15ex/AKQLXq3HMAuWvcUAJx7vQmR6n1nXBzVvXH8Qi3iFw2/l8PDsU7zf/BaeX9xjP9UciG1abPc1G6gJVP8rVZkVcmq0Bsz+6Rvwehu0FQykRPZdUYWS7yXpc2FCPSCzwpMsq6MaqHbxqcE87UMSGyuhYTiJNj2I9iLoLAWaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIXMJNtzVFmTiurCFGua+w9ifaFR4qAH3c8tTvpaYYw=;
 b=AV24J13tDfNTZKxCyQMnIaxZma0UTDNujDCOuK0y8k6BggC3I/QAjHbcwOxnUjjz2h3rMOrCPQvC8n7/V1NGgjOb5gdHhxsNGqbhLhpgw/+MxS8YrNvDmyNiS9/irSXbZkNYauFXPHnw+GJFnOCkp1GH2EDkMTjTtREosHea6uLPWrHImob0zkDEWjeWwvu8rOTcI2g/ggBF2FGgMBno6TXjO88vX0gvSr7ExZdIwKkZJG73lWnjh9+PgxwZfLYJbQydW7GaIn98mOcKF7PBYGVTFchEm755vbRLcJV9+6bupYb6bEurH2EtX3KxSNjOlc6y5EEjbH3dBiJXzZugXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIXMJNtzVFmTiurCFGua+w9ifaFR4qAH3c8tTvpaYYw=;
 b=sa1wWLm2rW5VcwRxP5zwE70L9dGpg+AJyzBOY6OCUlCHXazQibaruAu/w46KU/otCpd2GJzLEywTUU06sog9ggRGRwEFkvKpfWW2zZ86XeGYZcnKTEEl8ekurP/So6csyljXXll6j4dJTzc7WcJj26/EUw8HUzpKj6PitIxaPOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VE1PR04MB7471.eurprd04.prod.outlook.com (2603:10a6:800:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Sat, 1 Jan
 2022 15:53:02 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::4c4c:f2b2:addb:841%6]) with mapi id 15.20.4844.015; Sat, 1 Jan 2022
 15:53:02 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] interconnect: imx8: Remove the imx_icc_node_adj_desc
Date:   Sat,  1 Jan 2022 17:52:45 +0200
Message-Id: <20220101155245.3139667-3-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220101155245.3139667-1-abel.vesa@nxp.com>
References: <20220101155245.3139667-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0084.eurprd09.prod.outlook.com
 (2603:10a6:802:29::28) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 406f332d-0cfd-4a8f-a18d-08d9cd3ecafa
X-MS-TrafficTypeDiagnostic: VE1PR04MB7471:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB747124D55A323810BC7CEA59F6479@VE1PR04MB7471.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: haJN6/joP3vUQYz3PwnG7sDwVRBTPzvOcUoo9HVoXj8ojPbhknd+ps6WnN7pja1KWPTQWREIgQHA2hgV6rQdufZuyXfpm24Wx1yuDInTCn3jRmJrsYIUwerf8tEcrby8+10X3a6/zozwuEuNFwx2tygIYrHUrjp9gTFm4DkH/ERB3CM8GunzZiWfKB8CKKXg0kLyDhpYfzHeI96uhLIRnBay2v2AZNHugPDD4hFeFBoYxxvpdQnNyW/Ak96hU1v+Sz3EmAYuczc9KrpUCt/ODXvdWy6XINUodfQR2ZCbog3mb4WZQMP+4VAReq/ugwMFKM5Di7wuwqCUVCzVmu7nB7RRIULWKy1q4fWt8/qjVF7fpuYX/hXp+HfmHWaDPlLWlAi2pNAfE/8cT3/fBSftbnekCwD+attCVuSpvHUhSBBNl8u7eSC5QOFU/CR2gg+ctpaNCngMoZg7S44QMb5380a+ogIFK/5Lft3xEUpwQ+KqF+zsSpR3O8e9M9uGlaxbz4DHhuZSKCe1fMkhDpcHvQmZYr+s9iYrH8L1fJ8zbaZc5zZpHM/s2XFaRn/zmHdhgFvN5x+OzZyz42FLfWpi19y718raVaIJ6hRil1nuWCtf3QgP3do6uHrJ9NzJlhZOD8RJeh+XLpG+nemZ75keYA2QhafNPHpYFvalbnBPDHJbxjfNexsBusSwoDqcX2JOif7ZCO4GT0KUzO2nntOedg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(4326008)(66946007)(2616005)(52116002)(316002)(186003)(26005)(83380400001)(38350700002)(66556008)(38100700002)(5660300002)(30864003)(1076003)(6666004)(110136005)(2906002)(36756003)(44832011)(8936002)(54906003)(508600001)(8676002)(86362001)(6506007)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7a115do6g0vTLHa+UCVAqK8xnVi9+Mr3EatLkhJjxs5O93TGPu/8i93BqnvR?=
 =?us-ascii?Q?jyfO3c2AfVGQNcHRghjMkLwNbnHeChYUmaSaBgGFLdnWoVSESXEo+U2CCyn1?=
 =?us-ascii?Q?Imty7I/0j6qCQr1kWhGdZstAjlvQjcDVV0Yr/j9F3ya1y587fE0dUk0G14Dz?=
 =?us-ascii?Q?cZt5odvAeCVZ1/nj9YusFFIunt7j2+brAKObVM/LyNvwZsPguomN/kqoq6gF?=
 =?us-ascii?Q?T9NsJcuEYnvN7AiUZisbyzA7lOJPDBcbK53EqaAtm6MhXXB2QmPK5gjbmLuy?=
 =?us-ascii?Q?AdHsDPq/Nrc4YYtqPOGh5lWIGftOro3DtDtTYvOd92DugfOH0wkcrliOp3TT?=
 =?us-ascii?Q?/0NaP/ryaeNtq2BHx6NrlEKDvRfiihnXSn/U40Uq0/EmvgaiqERLTmkR/D4I?=
 =?us-ascii?Q?/B51dV0Dkkz5ltB8i9NJs3BNUdumPZeVscy9IHGNBF9NWKn44GjQI65eTqjl?=
 =?us-ascii?Q?3umat4bluXUenRGZUmYsZ3owW5KdpAbJNQ5Fr2WLPvd4OJpWGk1Cc0p0sQ3M?=
 =?us-ascii?Q?Drok3XXu4vU6XECcBy709n84i8OGPxeBOOy/PvB83wS1YJoHgjYWL/FGhSqW?=
 =?us-ascii?Q?JwwSTJ2rF9BAqfa1ngpDGgj7nLiv/KzL+XNgGfRauP64kd3tbb/vjN6Kh4Jg?=
 =?us-ascii?Q?txTa16EwZ6+H57SZ+lxgFD+wvMx135+nf+lJTihlQzTA6zZes8DJIYxfoNm7?=
 =?us-ascii?Q?A9h9YEs2TRalMJcyuWe5IAXrlG+Yh3np9xA4zXep7L7jm6uliWx1T01DF28S?=
 =?us-ascii?Q?yi777Timgs4T3+mo10/F3O64ddnTTJcnOPuh3VnGzL9WNKy9M546Os/qa/7f?=
 =?us-ascii?Q?AH7+4VIaOUnBFJJf2lauF0O9V3Y5XWOR/FOxXaU+EUmxdEpaSqTWN1qTWMEf?=
 =?us-ascii?Q?72+F9aRPoeuSkitEpKKanOA9f2B192jHNO4KF8QyYqi13zLM/JmRNqhX840g?=
 =?us-ascii?Q?9TYcF+qnVH5ydi/NeI+DX6vM7iwh5ERjps8sN37kHHCOdBjqfvXiJDHa+TZR?=
 =?us-ascii?Q?elALApKj09w/FconvIptVw5jNm+tu8dsX4BbbmpkelUlMc0ijx0w24yf/DfV?=
 =?us-ascii?Q?S45DQ4Lb5hqlZrWGAoSANQYGyUTS6Yc3NrVYMEvtN2LIj+2u3oAub1HHj18k?=
 =?us-ascii?Q?RFBFXvDMl9OTK3203NVRIpY4nW/WQKhKuXLIdC6q+8kPoPB8TJYnYCBNjCL7?=
 =?us-ascii?Q?0vsmIKgrVU3HbqBF14RE9Ymrf+5q8f392Xmq1VvM2VYZ6mqk9TeyI026vpgS?=
 =?us-ascii?Q?CuIxnSNkwWv3iLIBmSuLcQYiGPP6OmBzzxsSs7maWa6lklIOZhZWuUjHX6Of?=
 =?us-ascii?Q?fqKeXdqT+XTOZIdVWmLBA/GJq4zOVtyZnVVlIEP190k/BMvVeJl2vIA1xgNS?=
 =?us-ascii?Q?7DbcgbADBC9UGgeqz0k/dJZUye2kZfTfjqfcGLX8fHfCkJW0QcJ26wXDJpLw?=
 =?us-ascii?Q?QdfGrmRcuIZOZ30dKJjOFKHorq3mz1+hppkzyjp5yilVOZmDQ6mAjevc3+6v?=
 =?us-ascii?Q?LODgCzlNX6hsBpRc2vQytoWqQFwBel0NsO8WiEEWOmZ3A5s4KIiZcDBE0y9M?=
 =?us-ascii?Q?KsiZp5UQrlVhXFNs/sOAArGXqHGlPRDtBkZQwph4/hTUbkRrnYhe571gNQyx?=
 =?us-ascii?Q?fOdnCn3knb0DR4ycCeFgeNs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406f332d-0cfd-4a8f-a18d-08d9cd3ecafa
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2022 15:53:02.8154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5P5NP37esJlCnse6SdCfxbWfWFnHBEA+6ZXRmdDLMhPI9uEw5TSKVD243wweNjMC5GL8XbBhQ+Wuti8PsONrlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7471
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the imx generic interconnect doesn't use the
imx_icc_node_adj_desc, we remove it from all the i.MX8M
platform drivers.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
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
index ad97e55fd4e5..8d16bd5cf006 100644
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
+	DEFINE_BUS_INTERCONNECT("PL301_MAIN", IMX8MN_ICN_MAIN
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

