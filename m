Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5626F48A676
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347548AbiAKDgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:36:35 -0500
Received: from mail-eopbgr10052.outbound.protection.outlook.com ([40.107.1.52]:40878
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347569AbiAKDfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:35:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4l7QOU4LQEQIW7rf9izFgoA3ejKPB9fgodY9zJhW+TcapDHqKW8YuFpVftuRf68UdIMduKztLVH3xbM2zutOJUSsJJOmlr8cNrDy3p+vGtv6ksEQELjycUPUV/89yFWrrXZMT3Ah5lYHN0csBiv/lFD+EkihDMvE3k8UQCw7zHXqXbv2MluhJFuevnNfAOVs6+UZuijBh4E8bsowu5r4blIkz+aowwG1J9tuNgsrGqHyXB+rjyHwcNC1bM/d8CKKOvK7STZJ8OEjNi00toZLbg0k7cOEHKAIUZvm5uvuER7C4Jgp+fFxzkfQYRF61m8O+2GuL1LQLEHSvYKwo86VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tqm+O+sYiKh5yL45lMO1wcygnl9KWH+7J9khvwk+K4=;
 b=XFih91wl6cPGAJ7j7k7deAgjvXna7KP/jgaaL/JkqKKNijAyO8BArHqGZl8TjNrd+qEYpIHjJCZhEC/pEUdhYKOKhpAUQ819CykdoqXiW0Xiu9n4v/VierRfyk/uk1r8uHk2hVMeroGySqwTq7p+/9HQkQ+ubpvDtuePn0t4AbYYPeh/znxMy1zYRxTg2RcxFE1FBpsh7r1NhQUKZBekNaGH89fENIPeMi+HlYeBD25/ljG09FIr4HThOucko2GpI2inVFK+hHdV+SrPqwSri/Odi+a7LBRBxQ9KMKGutOE38S0u83baQsBgHmfGDE78uEzieosSocmV9uY0hPQYzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tqm+O+sYiKh5yL45lMO1wcygnl9KWH+7J9khvwk+K4=;
 b=HacbhQayfHW7MjM3qsneAq9Xts4U5QrjSFzOaRPm2Dp+s1vklq1f+0TjIQcTusfYG8HK7+Tk6uMH8Fafk6ihIyIorkkgv50hJpnIoz/zGaPmF/nl2itkGyz6dBUCc6HsiKq+rGrlwJp6eEhhm2Jvbfc+3w6ZY/R+VchzhivHs4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8520.eurprd04.prod.outlook.com (2603:10a6:10:2d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 03:35:05 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 03:35:05 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 8/9] remoteproc: imx_rproc: support i.MX8QM
Date:   Tue, 11 Jan 2022 11:33:32 +0800
Message-Id: <20220111033333.403448-11-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220111033333.403448-1-peng.fan@oss.nxp.com>
References: <20220111033333.403448-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0005.apcprd06.prod.outlook.com
 (2603:1096:4:186::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82c9ac16-379d-487a-00b7-08d9d4b35be3
X-MS-TrafficTypeDiagnostic: DU2PR04MB8520:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DU2PR04MB852038EEB7A80DF7B591C379C9519@DU2PR04MB8520.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FgV0tWuxF/buuiT2Y7/4ZhzEuP/UCbB0QY/Tn+0lW05LHCEQIRzuzdnWn9AmIK/FPrzspMCd80ayrbVsD/ZgdkUd+dAb1rGGo4ezqQ3AxTjzGJZmw6+m1wLYYXcdlODCitHpXPKAaNqYjlOgY+Lu2yxPaJyaRpACti5gvnCGwtIBm5y8zSrOW9p9CzQD9Bblrwe5MHgrUOmbsHHXxfESjFAZpk9QdnZXf6BGxePfsmB+56gxo+QDD+IBsjwrtZTZ6kel6Q73AkKdcguDrVFHh2lBSVc1wAF+Twsg7g7QOCLFehTCuLDnyPgtDZ7NWLPJZGXj5XpS/SeFySMCazRLghrhC+jMKHYerjvov7Gx1NJIvfYKRTEVpuvxdYnAzGUTcDcJTO12o3rT6qHs+qZ0UEmNbw2OkbV8TE+ZAke7ynT0Pke65jWUKtAfH6N5G2lBk6WGe3DDom4C7UxhMZ0MD4HzBY0eNGzWdh+2U/NEB1xvB3h8MP0M40DVNdE+HSUWroN/zW6BRdeQCGPRVhKceRk2aYPBSxCMNviE2nq+bGd3iVvURoyG2gxOcTs7nnRkGedCwGImLCqcmgmN0g7JPRQmyK75kXX9gfM5+/sBWu0T9dyAD5UH1ypJUcSBNsO27JvV2zx1bEdTnDlACX4FoesynYwC0wPDkpKaWGiB0Lo0LSgHrnG7eWE/mJJs3mPf0gpvTIZF4t0J/dmAEPWdNC9wrLlAlUMRqxTo/NlJoDo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(2616005)(6666004)(4326008)(186003)(26005)(6486002)(2906002)(86362001)(921005)(6506007)(83380400001)(508600001)(38350700002)(52116002)(38100700002)(6512007)(66946007)(5660300002)(8676002)(1076003)(66476007)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cuozP/PR9nFZoS6RFLr5fItiZ1rz5lpGb80TAzjhfLiDQb4NGD3x0dLdgukq?=
 =?us-ascii?Q?LsR2OvFXI14DqfsoVSuTc8gvdlpPQ8xl+0o464de0uWS36LieHYI15jam7uY?=
 =?us-ascii?Q?WHgwIGX9ITqlUPODMjxSz/S0kowqXsAXnKSDJhf+kDjPj/cEE6z/iHT/uBQQ?=
 =?us-ascii?Q?lKRdATn9iPVHvJCnB92RVL7ObSc2z9dvSx49oimpXV3BSsIbwZ8H0NSF4c4t?=
 =?us-ascii?Q?H4e8mPuQUp5BsTOhXN44Llq1wVBod3k5iWJlyxj6OtVohV/APt48c2ssvIxT?=
 =?us-ascii?Q?H0P2Ji2niab7WudC0jdCsuKlieiCnC5Eo3Lp7rFh9p2b7wokpX/TwkNO/1UH?=
 =?us-ascii?Q?jeoLqVX1a58lsNrrfECjmtZkTTnYKRoMMRs/7fuFzQMW7LNZsjlCC0N10/VH?=
 =?us-ascii?Q?Eeg1eNcYSfN+mJqZYxytm7XibYtpYs68oROEOlyLNHg+tHaO+iKgEWWRInXh?=
 =?us-ascii?Q?nf1wtWPungTtnSoZWKyPWhGBr3zGupsnuj9oWLNCTHxxOaLvSu4cL/C8cMyW?=
 =?us-ascii?Q?7qTIp3RF1XjmKlvAl7FGpUuoq4z3Gu61mytVdYoCeFkOoSSzOeglygf1LgiQ?=
 =?us-ascii?Q?4/Z1TRG1K2Sl9p1PeI8ALfp2gOCx2kEdAk0awd1/yXT2jP0SKBEw0ZaqmxA8?=
 =?us-ascii?Q?J0ZtQVgMBjeBNRjqdYj+/t3R89DFBZ3z/O6chldWE5yPJmUl0oXhWILDZ5i1?=
 =?us-ascii?Q?8Hex8rxxhftUJn1UzNW5ReHd79kvado3P8ezf0ZOYVYBlVEz12hcMdTdNw4x?=
 =?us-ascii?Q?IRJPgUL+dT21NPYJuAxucZZrkqXqMGMGQQZrrC3BlOENR6tgi2g5iIsuXEM3?=
 =?us-ascii?Q?Lwu4cusOUvAnck253bKLYndBn11MacGbqVcId9YZo240KtheO/04QEYezLne?=
 =?us-ascii?Q?ub04wLRLHOWhpGJGarv91+RLLSIbkwxEjOjYfVgkQkAhVtgHkdMiW16s96w8?=
 =?us-ascii?Q?GtPkL5JMdfEXiusSOXOYbd1kH+dAZOVbrVL/iG0+btkKW2F02KLOSn8xGe3F?=
 =?us-ascii?Q?c1QvJwgOz2L/5Z4Zsl+pE1x6hY4GpV4fhIRs1wDsYfgGvH2LK8sdMV14FagT?=
 =?us-ascii?Q?Ggd/V4T2ScXCIQhzVm4NJmBCN1WSChvw6OTirfYFKDsaywMlT7F7jmiq2RLm?=
 =?us-ascii?Q?9zGjDdljW+0vB9UAYUGSILXxR92PmsAAKnWxFCIdu+PuxSmBGBq2BTFBxhNc?=
 =?us-ascii?Q?O7xsPQhMovBT1z7MN5kSqkDSCYyd+iFaikvKMwMwvbcH9PwLgS3hMIa2apJi?=
 =?us-ascii?Q?2fvAfOH/Ynx7z48TdGrldCY8x6QTYdJzk5yPyzMgdJggDIi35V1ha9nRD9UM?=
 =?us-ascii?Q?2MjVGZ6HYiyOI+YMtjTz9xLZZ+qjXWUdl3mpussP8ifbTX86fITMWadNTVTX?=
 =?us-ascii?Q?2kaldwsaeQ9faJgz3xCMNhbpduJ3z1lsCJB3BUGCF8Z3hjr10uPJvJ+KXB5s?=
 =?us-ascii?Q?S86myaC9QQqthmOe1ky7GCMUQrcO/Yzn81iMPGjHJmaeuU4yk0c5xGAuK5d7?=
 =?us-ascii?Q?rsEyiIGPgjLp6L/+rq6p2J9J21AVCe4bEubskptTnfl5wRn0A7JieuZ08qRq?=
 =?us-ascii?Q?1UitIhN2PbajL9jYopLCLapyRoWk5OgLs+3IwVD/pik2DATwfvbTICMFNuEZ?=
 =?us-ascii?Q?XKkITpbHQgLCEQxGAdaN0zU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c9ac16-379d-487a-00b7-08d9d4b35be3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 03:35:05.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zc7Z0iAL+tnx8ov9hWT4PLpAwpJ53+0s2JXrnfPxwDtOxEq8KTjAL7p9I26xMf1h6r7iPZE7ARdVvJwsKSKnYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8520
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Most logic are same as i.MX8QXP, but i.MX8QM has two general purpose
M4 cores:
 Use the lower 16 bits specifying core, higher 16 bits for flags.
 The 2nd core has different start address from SCFW view

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/remoteproc/imx_rproc.c | 55 +++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 09d2a06e5ed6..7bc274fbce9f 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -77,8 +77,11 @@ struct imx_rproc_mem {
 
 /* att flags */
 /* M4 own area. Can be mapped at probe */
-#define ATT_OWN		BIT(1)
-#define ATT_IOMEM	BIT(2)
+#define ATT_OWN         BIT(31)
+#define ATT_IOMEM       BIT(30)
+/* I = [0:7] */
+#define ATT_CORE_MASK   0xffff
+#define ATT_CORE(I)     BIT((I))
 
 struct imx_rproc {
 	struct device			*dev;
@@ -98,11 +101,25 @@ struct imx_rproc {
 	struct notifier_block		proc_nb;
 	u32				rproc_pt;
 	u32				rsrc;
+	u32				reg;
 	int                             num_pd;
 	struct device                   **pd_dev;
 	struct device_link              **pd_dev_link;
 };
 
+static const struct imx_rproc_att imx_rproc_att_imx8qm[] = {
+	/* dev addr , sys addr  , size      , flags */
+	{ 0x08000000, 0x08000000, 0x10000000, 0},
+	/* TCML */
+	{ 0x1FFE0000, 0x34FE0000, 0x00020000, ATT_OWN | ATT_CORE(0)},
+	{ 0x1FFE0000, 0x38FE0000, 0x00020000, ATT_OWN | ATT_CORE(1)},
+	/* TCMU */
+	{ 0x20000000, 0x35000000, 0x00020000, ATT_OWN | ATT_CORE(0)},
+	{ 0x20000000, 0x39000000, 0x00020000, ATT_OWN | ATT_CORE(1)},
+	/* DDR (Data) */
+	{ 0x80000000, 0x80000000, 0x60000000, 0 },
+};
+
 static const struct imx_rproc_att imx_rproc_att_imx8qxp[] = {
 	/* dev addr , sys addr  , size	    , flags */
 	{ 0x08000000, 0x08000000, 0x10000000, 0},
@@ -260,6 +277,12 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8ulp = {
 	.method		= IMX_RPROC_NONE,
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
@@ -310,7 +333,10 @@ static int imx_rproc_start(struct rproc *rproc)
 		ret = res.a0;
 		break;
 	case IMX_RPROC_SCU_API:
-		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, true, 0x34fe0000);
+		if (priv->reg)
+			ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, true, 0x38fe0000);
+		else
+			ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, true, 0x34fe0000);
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -342,7 +368,10 @@ static int imx_rproc_stop(struct rproc *rproc)
 			dev_info(dev, "Not in wfi, force stopped\n");
 		break;
 	case IMX_RPROC_SCU_API:
-		ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, false, 0x34fe0000);
+		if (priv->reg)
+			ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, false, 0x38fe0000);
+		else
+			ret = imx_sc_pm_cpu_start(priv->ipc_handle, priv->rsrc, false, 0x34fe0000);
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -364,6 +393,11 @@ static int imx_rproc_da_to_sys(struct imx_rproc *priv, u64 da,
 	for (i = 0; i < dcfg->att_size; i++) {
 		const struct imx_rproc_att *att = &dcfg->att[i];
 
+		if (att->flags & ATT_CORE_MASK) {
+			if (!((BIT(priv->reg)) & (att->flags & ATT_CORE_MASK)))
+				continue;
+		}
+
 		if (da >= att->da && da + len < att->da + att->size) {
 			unsigned int offset = da - att->da;
 
@@ -594,6 +628,11 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
 		if (!(att->flags & ATT_OWN))
 			continue;
 
+		if (att->flags & ATT_CORE_MASK) {
+			if (!((BIT(priv->reg)) & (att->flags & ATT_CORE_MASK)))
+				continue;
+		}
+
 		if (b >= IMX_RPROC_MEM_MAX)
 			break;
 
@@ -809,6 +848,13 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
 			return ret;
 		}
 
+		priv->reg = of_get_cpu_hwid(dev->of_node, 0);
+		if (priv->reg == ~0U)
+			priv->reg = 0;
+
+		if (priv->reg > 1)
+			return -EINVAL;
+
 		priv->has_clk = false;
 		/*
 		 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
@@ -1005,6 +1051,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
 	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8qxp-cm4", .data = &imx_rproc_cfg_imx8qxp },
+	{ .compatible = "fsl,imx8qm-cm4", .data = &imx_rproc_cfg_imx8qm },
 	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
 	{},
 };
-- 
2.25.1

