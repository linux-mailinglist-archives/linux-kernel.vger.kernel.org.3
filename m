Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E1B5299CD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbiEQGsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240498AbiEQGsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:48:25 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BCD45077;
        Mon, 16 May 2022 23:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gp0lKhdYhXAWfFFB735bLTjoV3VYr2N8IM/XhPUXEBF4T9Gmw2SUM1ADqybkZ2r/4nBf3Gwdpag+YU9QbBS05xN7aG8d4LL/TWFmX4Mcr4WKqrDB2/SIxMDPOPkIM+ydea4hIKKbUzxhp7GDykOvLmPaAuaMO9alDb5Z8tnG03ET4/x6xHw78XJyA5UdtPqFXsygC0yqdGQ699BZqtApOAkitoSnyLlsYiqbxV5aNNuuEhOn9g8xfK5+mBaESodnlHb8OpWQjd05QbmGE2ElQczNXpUa1WIycoW4glRMZdMcOzVuuHVX4L/mmR9WC+sJg7xzmehNi1DAKEo4txlyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZAm33iGvkMlh6uUBGRS/NdPZnoxf1Hy6yiwq3vkeEE=;
 b=oKcm55QwxmfoDWePCQINBSYAPYG7E6d0qKsKBIkIBeNfICH8aIv9rFRWIKBkpZAJqFzTsiFnMg+rleAhoEbxIeAZ53XjlHSZB7XpZSOYL57meXuaYWjcgJFOw3ywsy03T1eH2KDn+YyHiARj4GkyWcr4jaKMiP9joOUefyDegETZEIHDi17UGEMWhdI5niZrg0IFMLzbFoTn9MYYexPtK0EQ2mebAq03vJJuTzaJvyyYDpcWHjQEtNZo6qbb5FjkNVT470tVyH9EmWeptPBIVOvZe2Qh0EVRQxC+z7GDh+tkGpG0LKghgC59EKn7aqRJhM2jIPzAudgIQsQKVRIWEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZAm33iGvkMlh6uUBGRS/NdPZnoxf1Hy6yiwq3vkeEE=;
 b=UMUiEvuy39jTZcqya23dHpYSlrKQerY6F7JXuLw5ljPfyoEJNMhTy5soCbDxkLGYSvpDcrNCb9xpgDTu7+x6vKfVS18Ng65zWoIWDXb0zf9/CI7nS1VgOMWcYZjPthGapejO3gSf1QfZcb+6MBWIj0cQ+kMQ0is9pESEKrBOMZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB6PR04MB3157.eurprd04.prod.outlook.com (2603:10a6:6:f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.18; Tue, 17 May 2022 06:48:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5250.014; Tue, 17 May 2022
 06:48:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 5/6] remoteproc: imx_rproc: support i.MX8QM
Date:   Tue, 17 May 2022 14:49:36 +0800
Message-Id: <20220517064937.4033441-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
References: <20220517064937.4033441-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8e199b5-f477-42a0-faaf-08da37d136c9
X-MS-TrafficTypeDiagnostic: DB6PR04MB3157:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB6PR04MB3157B169DE7693A7EADEF9B3C9CE9@DB6PR04MB3157.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ae9g5lG0ako7swd/nA40kM65Q2awxbqfljxExOrG0suSZxveuF1Z86AhsU7LC9wZiP7Y0B27MVB3uxDOZjDwePJYZtjNFwyKR890kztbUKgI2NgUN+kMpfRiQZu7DoE6Cf8fbYCcwH9w8pLLPOMGz0zwcFQ5mMEkwRhtmJao7wQ3rRsRBzwYQ5fZh+qzNRzzNu97xsUPbDCGHe1hh0XFZnpTZj7TGCrrstzH1sOO2gPlHyGXhqdQRb9jlGWNNiV+HpHqHVvQqnFixTsa8Jkx/FkswTl0vOWtrxfu0DWGnfCG/JMxI/M0CqwxSW2D3pLw+abtfouFuokkElL8yDVa/e6eBjlTSRWqO9rldAgp10ECuCgyjDQkEw4VNAcEEicL3Sa8/Yb8+GoobHXmIEf7chGORwu7YLJhnu/qsf73JR7zRch/hxtU9KiXWVmyLNlWLJJmDTUyTpnb2wsMJKkvfHAJ9cJgvCCRvclIj1DXZ4CIyrbU2SajNLlTsNVzv2fpH7t1Sx2cLz9cRERUzCIJ0jTdUasL7+abGyPxrWE4TQkKyooay54pkS/ZD1B/juZYDe5nb2xIvcDF1BL+a8jDmt9SxWaTvUDer4OLv0dViEXGee18srSzuP/cazmJ1rcce19JIcVqYbtuCzByubB9WaNtr97faKJLiGCoaKA2C2gGtufsQ0oNe4BteV0lU/GE9U/MRvFsQGarQA39XXbKeqgsCjOMeIBBSDFC2bXj9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(86362001)(83380400001)(66946007)(66476007)(6666004)(52116002)(1076003)(6486002)(2616005)(186003)(7416002)(38100700002)(66556008)(2906002)(8936002)(921005)(508600001)(38350700002)(316002)(26005)(6512007)(6506007)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O5YXjrrzY2QcHaMj2x73nD1iwa40L/JhuarBkAu7ltC8IBM9jn3PJ0mlQ6nY?=
 =?us-ascii?Q?z5eECYagNrAuA7rSO4GNjehGLq6fVpmqdEcoXjIZaOGHUnb1A6/T+f7NZItd?=
 =?us-ascii?Q?peYa2xOvPKx0BfLyqaN8mvIlIDgoU/b+NB+K4RwU7p5ftn9RoChp93eLfeZY?=
 =?us-ascii?Q?R8RyL/bWYEMh2dmd56YWqaJOnsm0IpnboQ2FDq2eixdpoWhKbsYYtPdYpKP/?=
 =?us-ascii?Q?uFXH4pfueUbY8cbCRSwJQmQt6tjPHDR8KXbjBOD7p4Faw9l7kYCgKXAA928y?=
 =?us-ascii?Q?mnkPPGWATgOOKLzIA7YgNdEG+/yULPmuD5Wp7d7+U8/seEX8NmmLBPh8h58H?=
 =?us-ascii?Q?zExoFTm/8ClCjicrY924jAowluJsba6GG4F6BWaljBt2gzWS/ndOu3H7a303?=
 =?us-ascii?Q?dTh8xVIfNwKj3xpfeapgSDyXlbUv1NuvLx7L2Ra6KRN7ScTgvI6leunVqusF?=
 =?us-ascii?Q?grAAJJ3fZjEsqQzZYbin5Xrahk/z1ronJWr3HHNmaJFsb6M4IpWg43SVYCbY?=
 =?us-ascii?Q?jYozXCHXPg5+rYfkI+N5IXKyp28wzxIaO8vNcNR6ziZnq5T0NmidwmeDztPe?=
 =?us-ascii?Q?mYTPrwsOpc8KppAH1RpeeDjhhCPNUEJMFTMB/679VTbprwBP4XnSr/Nhbe1A?=
 =?us-ascii?Q?GZzhtx5mYC33XCiensnPVuGgbtKZkwkf63EqXcMePg868sgyCR5/56ZLABqc?=
 =?us-ascii?Q?DL4C4GYbIBmXsg3TYIge7UxYNvFA8yPpFHBQllVPyOXHpLVkyLCQBNMfOwVq?=
 =?us-ascii?Q?6on3NyETf/L8LNLGwDtKpa5GPGr6JuN80EdJAAPR4Ad1fLoL7Kg98BnU8Sxq?=
 =?us-ascii?Q?dCn11T60eiA/Tmd3Hj21IrDaR8zOQ7r5KBFoEWL07Odl1g2jvxlhz8uwqIQ1?=
 =?us-ascii?Q?MtGENH6+T6TmtNzU8oT0nkZyqBcCMNcn7zFCm8QnS1smY/DC5F8De1QTZEfa?=
 =?us-ascii?Q?Ab8S82/CChtyVO4jIPGhfBV7TIb7W43Yhap/i1amwRaxBZGNhg9xRQFE3sF3?=
 =?us-ascii?Q?teF0InMA7qVvSyYO1eJr3Ns36TIroNgLJpsfmVLHanktbzDPvKeAUWB7JBL8?=
 =?us-ascii?Q?LvhZPB5DpBkhn41+lnt40Dy/a/CnkY5tYB13BG30cSVfmP6NPRpdpMIjB59X?=
 =?us-ascii?Q?wElROQXkTgmfpskAiLqBBqL5Cdcl0VuwIE14dGirZexTDyQsj+Pl6XpsnKo0?=
 =?us-ascii?Q?dF28JZE8q86ylvNSHN3WQECtyyOgOntaoVmC3sVVz5fwtRWvGd+1sPXP53Kt?=
 =?us-ascii?Q?/h7SJYfvhSppIhxbUrsq6kwgenjNOb3Ia1nca6NAQP+7XOQjQYYZmEEj5kNt?=
 =?us-ascii?Q?30BaXLiUArG8pl7uy6DX1uLVMBbtg0hw4BLuoTiEm7zaxWFkzJQ70nvsUfbT?=
 =?us-ascii?Q?TdB9FBxt87dlLqbtUVXx6vyMkQHKKsHJrfsgZQLB6Y5ZvZ7tTUis6XmM/dkP?=
 =?us-ascii?Q?fetlYR+jPHkzjQEbmUAJKSowglJ9nGbSdd6DnKbqN0YjSQc/PQePR9RWIzUo?=
 =?us-ascii?Q?YVZV4n9sCM422P/jeH34Smu/EVT+oLjNh2o0Ci8RGf/FsA2X3ZGLPGXA4U2J?=
 =?us-ascii?Q?wqGe0UVteBFkqF6WlA2cGCVuxCJfKOzaoQWfAnedwodayDRKxa3QhLsO6HyI?=
 =?us-ascii?Q?l1neGdYqWo5OyLHAD5GbfrNzDarOsy+D2eOe5hkBO1K5q4DT/450IC8ElgMs?=
 =?us-ascii?Q?ej1WLeuKEiH7RvJ2acll+cZvYy1kqES3YX4oCBM4Muty1Kq3cl5yf81quBRv?=
 =?us-ascii?Q?UDlAVAgccA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e199b5-f477-42a0-faaf-08da37d136c9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 06:48:13.6057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6W79IIrmKk1I0FRrjPjTbivFN9kDXablkI90g1aL0OUYBck6XdTubvIoEpBEXqazIG5QxYIvk+dDxQWbDOI4Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3157
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
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
 drivers/remoteproc/imx_rproc.c | 41 +++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 49cce9dd55c7..8326193c13d6 100644
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
 
 struct imx_rproc {
 	struct device			*dev;
@@ -99,6 +103,7 @@ struct imx_rproc {
 	u32				rsrc_id;	/* resource id */
 	u32				entry;		/* cpu start address */
 	int                             num_pd;
+	u32				core_index;
 	struct device                   **pd_dev;
 	struct device_link              **pd_dev_link;
 };
@@ -129,6 +134,19 @@ static const struct imx_rproc_att imx_rproc_att_imx93[] = {
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
@@ -279,6 +297,12 @@ static const struct imx_rproc_dcfg imx_rproc_cfg_imx8mq = {
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
@@ -395,6 +419,11 @@ static int imx_rproc_da_to_sys(struct imx_rproc *priv, u64 da,
 	for (i = 0; i < dcfg->att_size; i++) {
 		const struct imx_rproc_att *att = &dcfg->att[i];
 
+		if (att->flags & ATT_CORE_MASK) {
+			if (!((BIT(priv->core_index)) & (att->flags & ATT_CORE_MASK)))
+				continue;
+		}
+
 		if (da >= att->da && da + len < att->da + att->size) {
 			unsigned int offset = da - att->da;
 
@@ -815,6 +844,11 @@ static int imx_rproc_detect_mode(struct imx_rproc *priv)
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
@@ -1008,6 +1042,7 @@ static const struct of_device_id imx_rproc_of_match[] = {
 	{ .compatible = "fsl,imx8mn-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8mp-cm7", .data = &imx_rproc_cfg_imx8mn },
 	{ .compatible = "fsl,imx8qxp-cm4", .data = &imx_rproc_cfg_imx8qxp },
+	{ .compatible = "fsl,imx8qm-cm4", .data = &imx_rproc_cfg_imx8qm },
 	{ .compatible = "fsl,imx8ulp-cm33", .data = &imx_rproc_cfg_imx8ulp },
 	{ .compatible = "fsl,imx93-cm33", .data = &imx_rproc_cfg_imx93 },
 	{},
-- 
2.25.1

