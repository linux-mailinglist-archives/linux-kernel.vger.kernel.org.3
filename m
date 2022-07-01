Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B187B5631D7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiGAKqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237068AbiGAKqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:46:06 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00072.outbound.protection.outlook.com [40.107.0.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDCE7437B;
        Fri,  1 Jul 2022 03:46:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzkDvdvQVRG5r+Yt4qmmSRNDPGiV6i7bqczzacZqQKAeNM2RRsuBLmz5Z/0FlsTpnc0xIh09vM2nSnVk4NzS0aT2ULQEGhMgbY8cDyfjUq3IWYC4QaZfhHVQAGyw/c5D7E+2kQeBeIstyxRcgSG9twUtoXbU/VHFjeob/GrTsI6oDlyqXPotEODM2xyXTijfEon5sVIo8jlMx7MoAtJnnteDU72pW9/q8aIPhHdJxevnr6wOTIhBE2sJAkrNZfZ+pyjFc7LxVcRRBfzhRv5Z469c/c1inFwwkb0blEMOndVkLzm/xbeh7kvPafLlFS+MT+sTXgCq2Id4JbCWrgBGXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mi0BiFoh91h6xoHWVePG7+aorttfMxQ5X5lm23o1680=;
 b=M2zLbbX2eE+4BY9C55DcJSlxHI2IAnpzL8RLI9mLLyJSxfRM4TiutkwoWXSXC6ovv96tKzGhDdVcHI7l1pw40DmGAM79/VkHdssoPwbnV1QcMYr1FgeV6l/RlOloNcdcmENzw/T01dNS6KMebhEMrj536CpO5UDK93DCkqDPMclPMuiJcXImNpzHt+BRf3zqDqQqb27L3a36D6e6ixX7/STmb1GFTeCTID3tKj2tuCqn2mTDgApby9LL4yo2AKpL9vJ+DpWvqW1/jxRPTe3YdZwMBFYxC+L/e96SRQ7qzYX6uepB+JGvXOKMluiB/4QkN1sw0288OjkRKrPhO/fhRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mi0BiFoh91h6xoHWVePG7+aorttfMxQ5X5lm23o1680=;
 b=K1ifNqbgXGFHRQRrf/AAU8w7MtrQrdjPTL8n5yETwTUP0RFlQys8WwMZ/uho9Clk0MpPhJELFn+9ws3GKsehEi3YW6u27VZzWUBWl9VL4VALRggldDrDpLxJ5rh1rSxh9Pq7Q0/3XE80MPyM3m7iKF0z8LbtQwvzH2s8oNLfu9o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7974.eurprd04.prod.outlook.com (2603:10a6:20b:2a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 10:46:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%6]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 10:46:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 5/6] remoteproc: imx_rproc: support i.MX8QM
Date:   Fri,  1 Jul 2022 18:47:24 +0800
Message-Id: <20220701104725.557314-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701104725.557314-1-peng.fan@oss.nxp.com>
References: <20220701104725.557314-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 346c2467-b4d2-420d-d0e0-08da5b4ee45c
X-MS-TrafficTypeDiagnostic: AS8PR04MB7974:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rVk92fNqdRU9SxG1AatzzLGTmdCIQWRcIrdIuO4SYvfgEcgZpYFTSeWYyVAGFnKmvyoYscY7BNgh2d+wiXi7CzyLIDK+CQbZaLiRmAa1d66W1MPnuN/kdPRec0/4T1OHJ8mRdB/gqT6x9LLvpYDYsw9bR3PyrBzY+5uufy8dm76Q15RJ65Zd9rNvTPWMCS5iX/2knJEDQLbCcxrGWusm/If4cVkhSxcFIBm5QCy/XpT0rYm0cOCdWiR4D/yxsAFmMDIaKlOfraU4euQUph7jF0oNq0f4fKEVoQIUHJ7yWM2Myulq94mzX2O38+ZVuIBsB/crsxxx399Tqws+7VH/cmj2vrf+fNuAPvfi6gi0B5oIhbut/Id9epUoIQL5tbCtC1j/ido+xW/a15uBZ1N3zO4M3I8PXN/pbQmgdE2CHKvLXYJfKl/DnjltFlySU8V3UKpj13RDrSd1CLRKs8o/yETjfWHrjI4Y0aJLA1yMmLwGNpaUT2y4j17+zCKCo4MQwrqGSKe4gLtIB4wqOS4Twv1gWogMsOfljdpw/AEMTpn0OTl5cq3SsvPti64hjJrlzCGo72otmkhbPsXBN5HhlHOKdDhi+27k+fnY5aznTSznqyCIBeROpYnBVedvvgANMjAjxXDiU3TKsSJCMQTXpK3Zetio8j605wyDl9D68eimtUAA5kjZw8uv4Io+NfvlmHZ3ujzUD9eYxpgLYchRhXWJeCBqLOuTGaKec3bNTbkn8IggLFRheoHZfA9mztlZGpwbcC8/aecaa6jbmEOjR0MflILX9SFtIVaR304ynp6KtsjY3OxshKdiVIXgSH8j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(478600001)(7416002)(6486002)(38100700002)(38350700002)(66556008)(26005)(52116002)(6512007)(1076003)(6506007)(8936002)(86362001)(6666004)(83380400001)(2616005)(2906002)(186003)(41300700001)(5660300002)(4326008)(8676002)(316002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k2JzDshvxQpFcEOAiMpO97X50Sy/r4OjWn/+8VO8+7IEeY3lP5aiSvXzjTNp?=
 =?us-ascii?Q?u/7KYk8UD/IhbcHsEesKMymNN38lW1/VmbSxC6Fn3hJwmC68y+VyGCMAh3z0?=
 =?us-ascii?Q?2VlQuYHzNYr+cE2ofcLhM0RviMR8oX9iF95m2CeNCDh2F1hshtU74h6uj80N?=
 =?us-ascii?Q?1TK6FcJqW68HY7wwCajBPFLRJZVOfhGVnrDEL6bXcnbMKc11t5+wcbQQumyu?=
 =?us-ascii?Q?ipbpRDS2m4DzOGyKBQJbpwhQvqxdAEaIHx6/Lj+f2kKEfphhAd7AAvSzNQ4G?=
 =?us-ascii?Q?S3C8gxEn4GWQyjRcAGqdHOqlDyb+p2weOllG4VCbJzUfqotmhjDC++ZnyKsc?=
 =?us-ascii?Q?7cWvVmc+oPhsp1mf3jaVHdbs0DmtkDeKCtf0T3B1Z07K28QTREjAotS2HDKi?=
 =?us-ascii?Q?vlptZHOEKjLbRbYVCWb3q79F1gh8xuyYFjZzCwM1Ji2ozw++QllF6HRZV4fe?=
 =?us-ascii?Q?aH0IrgX6SV4hE6j5ypsj3l05MNkJ3S+vYDgQhxIo/yhuLE8f4W9PAGeI1/rD?=
 =?us-ascii?Q?zHcAUCd4WrK74rHdsIdxovKOaKa+d1lghxf/Pk8C7Oqo6uVR2M8NbCNOkdsq?=
 =?us-ascii?Q?S5SzgzB53Gguiajjh26hlO7rY1P+6PVBJHLXzKnzyEq3Rt4ZgvQlEnaVZrSg?=
 =?us-ascii?Q?yNLKUNIY0vquhZzjlPmQnx5Bk8zFnHBHSaz8n4AL2OFKlymVBgmFqVn+J1nb?=
 =?us-ascii?Q?0oKfyeYthK004JbUWNjM42hRMIl6/rXtKYBuJhc2iUoVJiX50sqijYhMzKhM?=
 =?us-ascii?Q?GXKKMEE+dNj4DD+nR6kiH9glW7EXjJ34VdihF1+D2fXvQayO6dbIg4m8m0Cv?=
 =?us-ascii?Q?YNPUknj/gCu4n+AHwDfSxzxarFeH4qh/R3m6QRIeKY5gRBGypSVju3D9WeRc?=
 =?us-ascii?Q?0Lf8T4xMT7HTnOPKhb5Y6mBzG4ALyaCZnj55yi1ezNmwPvmVG/Xzs0wc39Mq?=
 =?us-ascii?Q?jDyS/uZNpyi9v1BMk7t8xNFKdeOjVcSdRCUDFpX8RUwealpbzj8T+2Jlnv3d?=
 =?us-ascii?Q?vF/UtfGH7dj+Graeut6cCE9iS7Ly2JZVUEDpJU0sRhQKD9/RSbK+LvrsQur8?=
 =?us-ascii?Q?p0o/XXNuD5QxjHygXT8NEDebPN25AkmtJpQns9P2T5XWDYQfwlw/QsB+TETx?=
 =?us-ascii?Q?wCHsJG8T4V4gKhCWZLLDLZFanPvFIxjWZgjf1A36+brtLIlLw6wwDAh7xKCG?=
 =?us-ascii?Q?0Q9E5yZzXxtTunL96Rc47c7gEYF+Fp0610vbgPdjOxuQfLQyKavKKrJtWxdA?=
 =?us-ascii?Q?DhiNz0frHaGLEmqSF/45PRmNYa319Q2th2kWlcwjNlLcAy5i8U+EBbqW1v2M?=
 =?us-ascii?Q?kXDJXGHxkKf0iDzdqXFjzaYaed0nejMMOXrbp1MSwL2P5T48ekvGOAOREN6M?=
 =?us-ascii?Q?Fq3D9piXKC0KwS0adNShukkFgX4K/9tfK9N1KraCqz0aNlErS5/egrljIhKE?=
 =?us-ascii?Q?2/kbCHmZVEjgvPP4rftmV5+j8U1pq/J+lj+9wndR5rDcAnaPxTKTmH2Xgc3/?=
 =?us-ascii?Q?wGweAsaBO3X/qX7acOElYm3Gm2baQIo7bYtQnCKdUkOJFpeQHRnZ4CVWum/N?=
 =?us-ascii?Q?aP/+V5zUx69PxuuEeH70gHjNWaLyaE9ArZxiCIs/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346c2467-b4d2-420d-d0e0-08da5b4ee45c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 10:46:02.5099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3RxllLRWTaObN5lHDXzn1ssZ028lwXExS2eQHndGvqb0CtmRx7FD8mTzcsKvo75bPylm4T2T+mxbfags52Kxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7974
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Most logic are same as i.MX8QXP, but i.MX8QM has two general purpose
M4 cores, the two cores runs independently and they has different resource
id, different start address from SCFW view.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 47 +++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 0cecb7f422b4..f129cc840931 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2017 Pengutronix, Oleksij Rempel <kernel@pengutronix.de>
  */
 
+#include <dt-bindings/firmware/imx/rsrc.h>
 #include <linux/arm-smccc.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -75,10 +76,13 @@ struct imx_rproc_mem {
 	size_t size;
 };
 
-/* att flags */
+/* att flags: lower 16 bits specifying core, higher 16 bits for flags  */
 /* M4 own area. Can be mapped at probe */
-#define ATT_OWN		BIT(1)
-#define ATT_IOMEM	BIT(2)
+#define ATT_OWN         BIT(31)
+#define ATT_IOMEM       BIT(30)
+
+#define ATT_CORE_MASK   0xffff
+#define ATT_CORE(I)     BIT((I))
 
 static int imx_rproc_detach_pd(struct rproc *rproc);
 
@@ -101,6 +105,7 @@ struct imx_rproc {
 	u32				rsrc_id;	/* resource id */
 	u32				entry;		/* cpu start address */
 	int                             num_pd;
+	u32				core_index;
 	struct device                   **pd_dev;
 	struct device_link              **pd_dev_link;
 };
@@ -131,6 +136,19 @@ static const struct imx_rproc_att imx_rproc_att_imx93[] = {
 	{ 0xD0000000, 0xa0000000, 0x10000000, 0 },
 };
 
+static const struct imx_rproc_att imx_rproc_att_imx8qm[] = {
+	/* dev addr , sys addr  , size      , flags */
+	{ 0x08000000, 0x08000000, 0x10000000, 0},
+	/* TCML */
+	{ 0x1FFE0000, 0x34FE0000, 0x00020000, ATT_OWN | ATT_IOMEM | ATT_CORE(0)},
+	{ 0x1FFE0000, 0x38FE0000, 0x00020000, ATT_OWN | ATT_IOMEM | ATT_CORE(1)},
+	/* TCMU */
+	{ 0x20000000, 0x35000000, 0x00020000, ATT_OWN | ATT_IOMEM | ATT_CORE(0)},
+	{ 0x20000000, 0x39000000, 0x00020000, ATT_OWN | ATT_IOMEM | ATT_CORE(1)},
+	/* DDR (Data) */
+	{ 0x80000000, 0x80000000, 0x60000000, 0 },
+};
+
 static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
 	{ 0x08000000, 0x08000000, 0x10000000, 0 },
 	/* TCML/U */
@@ -281,6 +299,12 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8mq = {
 	.method		= IMX_RPROC_MMIO,
 };
 
+static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qm = {
+	.att            = imx_rproc_att_imx8qm,
+	.att_size       = ARRAY_SIZE(imx_rproc_att_imx8qm),
+	.method         = IMX_RPROC_SCU_API,
+};
+
 static const struct imx_rproc_dcfg imx_rproc_cfg_imx8qxp = {
 	.att		= imx_rproc_att_imx8qxp,
 	.att_size	= ARRAY_SIZE(imx_rproc_att_imx8qxp),
@@ -397,6 +421,17 @@ static int imx_rproc_da_to_sys(struct imx_rproc *priv, u64 da,
 	for (i = 0; i < dcfg->att_size; i++) {
 		const struct imx_rproc_att *att = &dcfg->att[i];
 
+		/*
+		 * Ignore entries not belong to current core:
+		 * i.MX8QM has dual general M4_[0,1] cores, M4_0's own entries
+		 * has "ATT_CORE(0) & BIT(0)" true, M4_1's own entries has
+		 * "ATT_CORE(1) & BIT(1)" true.
+		 */
+		if (att->flags & ATT_CORE_MASK) {
+			if (!((BIT(priv->core_index)) & (att->flags & ATT_CORE_MASK)))
+				continue;
+		}
+
 		if (da >= att->da && da + len < att->da + att->size) {
 			unsigned int offset = da - att->da;
 
@@ -846,6 +881,11 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 			return ret;
 		}
 
+		if (priv->rsrc_id == IMX_SC_R_M4_1_PID0)
+			priv->core_index = 1;
+		else
+			priv->core_index = 0;
+
 		/*
 		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
 		 * and Linux could only do IPC with Mcore and nothing else.
@@ -1042,6 +1082,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
 	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8qxp-cm4", .data = &imx_rproc_cfg_imx8qxp },
+	{ .compatible = "fsl,imx8qm-cm4", .data = &imx_rproc_cfg_imx8qm },
 	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
 	{ .compatible = "fsl,imx93-cm33", .data = &imx_rproc_cfg_imx93 },
 	{},
-- 
2.25.1

