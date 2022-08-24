Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6117559F096
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 03:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbiHXBJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 21:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbiHXBJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 21:09:17 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B518A1E7;
        Tue, 23 Aug 2022 18:09:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C07k7/UvYRh/m+IONljNjNLy/RHVeJAPWleW8g/aCNkEQ9O9yByTUmO6iRiM0GFbTJDgsY+YDogQCSFr6ZVzq0blfPliCV8lMN+WUTfnRMpFetZiCg/zNbUc2OP5glNC0gYu5UBx0JRmnt0K/AfL9MoKWGVFNfF5nHW6ymRqFCp6kNAEjB2Cj+yVuTWZkQtISDhy8f0Pobey029BhSew4TiaIM6uyzIo47ut3GcLGDxnnjAm2U52MvYzX5EaT0C8mN3p0+xENjN2DNvs3Mvf1OHd8kk6bNdsc4LyVmt97OZa2oAivVJWQhDRVlshCuBNezRzCO5lGVayFl520NFFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUT97Dvt3ucUmD9ppAfywi0D0H3XVw1WsLuuzUvm9IU=;
 b=P9qi1TjYqCtGazEwWAwfX9hoUqR98zYb3YWy2e+vscj5eUHR0ogPKVyDbRGy3jVvXcXHAVRVXS0AUYFqs26mrGPke+xJo5il3SGXEKUc5pahyoY9NRAM5UOieLdkybgukvuHKjFg7cXQaaBPYS5rzD+h0LEQ40OIL37gbf/C2dXAJ9Ut49mi+IXzqaBf1svkk7ppA7qg0grSuhYCHNBPkV1/Ty31DOfaqUD4d7hyfMGXFHZRGVbQq6vF3zdXtS2eYpze3Yi9zVd4TQC5vFBiEK2aXWbKcKqMM15YDPhISTTheSJ9CpWM6gistIajgo3pycgLaAircI9FffhhhK0pGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUT97Dvt3ucUmD9ppAfywi0D0H3XVw1WsLuuzUvm9IU=;
 b=fO0KEhE7+tNFm5VsDqTV9+jyDGbU+YWJ6TSdxIAzISt5SqzsjXslpYgG0zZvTZSi2CVzgeBus/+VXA5wfMsFghS8JKbh0stllhxf9wF+GqluWh4yfAsunCDPWxaeVC5StK3VDRxJaTcMapFUPzPBnDV6PXL1ca0rSDNotXG/0hE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6182.eurprd04.prod.outlook.com (2603:10a6:20b:bb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 01:09:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5546.023; Wed, 24 Aug 2022
 01:09:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@kernel.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V5 5/6] remoteproc: imx_rproc: support i.MX8QM
Date:   Wed, 24 Aug 2022 09:10:22 +0800
Message-Id: <20220824011023.1493050-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
References: <20220824011023.1493050-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 051de99d-6d6c-46c3-86f2-08da856d3fe7
X-MS-TrafficTypeDiagnostic: AM6PR04MB6182:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rpVOR4h52QaMgaALys2fe50lDlCKbQDKF0MRDkVR6++Df0bJJVdaiKYfrqrv+DcFIFVBc8apmLn3xWeyzt88oaKpMGy/BbilV21jbIR/LquF1e3Y6hEJRAkqHqrrI508flk/xCdGp5gwYA3tdsnKJJk2SeixA9zk7kLU9wvNzVErDv+rpvSfK8g8LQ8/ruYskKT+keCbPNvWZoIcqrwhTlVXi9jeuyQd6O80gzN6/6g97qEb7mFzviHihhykfoLxgRP+dxRy97+nz151wqsaRG60xLzH3P6y0wriHnXeqzjbg6GYpXUZc9bhiS28S4w+MZeBimj0ae5rq45ebHQi/Tzkx7yTTZpgKi6zXXwYmS/s5FUBzR8ety/7VzGArJLHYWEmEy3fFwUYMqI6dS8wGEyPws8jvQAqsj751j7yuoBbN0gd7x3u/6kXs6BOZUq0THPgq2LKiyWvJvL2m7jId9QnTQuyPyNsJz+Z+Hpffud1zX1ClYAE0kTBSWAe3u0hO8Qwhqujlm+Bjq2hXBHRhj6X+n5guW/vmL83GXAv/r7j5PCULGm1SKz3r8RNz236tJDtO+z2g8j0H/yCiEvpbsvTi6wtlNzeRye0CbDTylM1mPAARb90V3uADtrnrvX6S9ZEnb9XQJhuAffDih7NAlOvSngT2GX3QLBu3z9YMe3IskizZT+BzZedNfY8fNqi9ynkLSfS4i/CfRem74RhkkjsFc6yNuV+BEb8nfrJkQdUiK3G3TNtbLSXBjruBQepQK5OLxgJJhWEE5EIy31uGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(38100700002)(316002)(38350700002)(41300700001)(6486002)(66476007)(8676002)(4326008)(66556008)(66946007)(6666004)(478600001)(5660300002)(7416002)(26005)(6512007)(8936002)(86362001)(6506007)(2906002)(52116002)(1076003)(186003)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x+WJQZtHHPNe0RalkOOz65rzo8Do2QhJ3z+q7JTPlywBm9n+z/H3dfESy0UE?=
 =?us-ascii?Q?HbqPGt6n0wEhZPvu5voYIpNFZpPDJwTHLqIa8hqt1KSq5cZTixvtqTry11LG?=
 =?us-ascii?Q?+DPVegvd/MXkuiBNzEZy+jfQzzlCDn5adqtftHl2xxoKEBb32sbUQ70/Ctht?=
 =?us-ascii?Q?T5IDG9/Udc3CQn8I3Qzzzo6YWkZFHnSSLmv65ywAouHVEotCM9u42xLqb7xy?=
 =?us-ascii?Q?YinMNMYR/Af/vpbXJ0omAw6u47A3ClAKWUGHNEWjiD4H98E2yH4KU/gKwJoX?=
 =?us-ascii?Q?cq8z4ue1LFrojBrCTa05a9Ie/OsghmRsd883zDm+3vMd0InBvmhLTM2S9drH?=
 =?us-ascii?Q?3rQKLZ7cVKVKCSefPjoSaMhTPOZZfxwpLMLlSekeQQ7M7FCsUo7GmItxYZCu?=
 =?us-ascii?Q?LBvAAWe/ctR4fC9AESRVnAD9hqL3Gx3TJGs4gsVujigVmS64u4Yd85wzLhRf?=
 =?us-ascii?Q?3ZZetOhVH0YqVZg0dtYfWSCX4wN9SaMJyLap7lwwMAAQuMi2UlEP4bWCeyTg?=
 =?us-ascii?Q?qNdfD7BCbd/LX4OzY8c2L/P6Vau/UxLPzn58qEveighLi+Ex49bxqQNSGB6d?=
 =?us-ascii?Q?0ggya+mItWFtB/sLDm4xvXjUTXGNg40bpuUl+AWP4Om4SUoSN1G5eucD9rgJ?=
 =?us-ascii?Q?fGy1WUBqcjmKPlwnpNLqJxM4obeuKKn6fzeSx4wAtKmmsnFvlF4RINY2LgA9?=
 =?us-ascii?Q?4OICNqPrEszjLg8uu7dk+1Oemi6qvEnvEjCepLeQWw8mYZd1ZW6U7DAdmmWy?=
 =?us-ascii?Q?dCcLC5lnqwjw6rsJttxQAh5olEy7J3nPlc9N80KL76gQf4l4k4dfqpZ4rVxc?=
 =?us-ascii?Q?QMRUtANFoJZQ26eVk0/qUxccYvIt56NP1DO7K7QM7BrF9q9RFNIN6LutOcy+?=
 =?us-ascii?Q?IuTwOsEexMn7Z5g0FEzbPuSdju4Gdo2mG95DaWXdsaczOeon42C7xjgye0Kp?=
 =?us-ascii?Q?g6MmPItGphSD9bA7lHGSjWCVeiRrZcox6cEbIXpPngMgD1etEkYuXVnt21yF?=
 =?us-ascii?Q?dQD5U8pDwOUDyVkR7J9FI2lSlmhqROAjORiNp0M7cxRQ16ZkvtusmooFA3cD?=
 =?us-ascii?Q?kU7bG6n+xjq80GL3m/NdfldJZVmSKbFQq6m4OhwMTd93V4qHEPOQmU9g7ROF?=
 =?us-ascii?Q?v6uz0db0SXESv1W0xi8Xh88LGD2HDWtjpC5R26+BZm6nSorEbvrdtyH8TGY+?=
 =?us-ascii?Q?7OXN5FJ1OvQtxlZhgtEdxh+vMhsz+QmxwO7KkfEcOnbqm9bppN0kdVGTlLqj?=
 =?us-ascii?Q?1ENWsX3H9+jc7QHbufhSOmT8e4ETvnFRqx8f7srIkO9P9qZq9ntxhmfwOH15?=
 =?us-ascii?Q?KnGpZD6j3cTkZjCxWxH0D2QcerWD2B6gbCjmf9mgvtEYoF9iB/vTG54fABD+?=
 =?us-ascii?Q?FswO3Dp8i9Vu3s8g6N9EoVkqZVWb5YOfeAEjw7DHtDKB6hyQ0CmvVpaf3FE/?=
 =?us-ascii?Q?NwNJFLfcPtseDJwt8ApOX54xlSI7jd/DQvEHDVAUMVVO1ZvjBKMjQsx83+9F?=
 =?us-ascii?Q?/8ROJ3mHHCIwxDVAUgA1HgwwrY1nzlvStMYSUgkhyyzx4h+UOYQxPNhn3KPQ?=
 =?us-ascii?Q?a/yePzZqyIIfH+2u4AJPP4qBJSYwkYtnh4laB3Me?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051de99d-6d6c-46c3-86f2-08da856d3fe7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 01:09:09.8144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3fBzRkmdxu4sL6emlLk5hLYrhWThWJCh+kwaIrD+ZRkeqMn+Rj9V7IJ4g6yV/OPJubrFseE65XZAgaoUrtgwHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6182
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
index 8cc8bcbbd895..9e46fd9bc2d1 100644
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
 
@@ -842,6 +877,11 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
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
@@ -1038,6 +1078,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
 	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8qxp-cm4", .data = &imx_rproc_cfg_imx8qxp },
+	{ .compatible = "fsl,imx8qm-cm4", .data = &imx_rproc_cfg_imx8qm },
 	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
 	{ .compatible = "fsl,imx93-cm33", .data = &imx_rproc_cfg_imx93 },
 	{},
-- 
2.37.1

