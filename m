Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC8B4C3FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238430AbiBYIQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238415AbiBYIQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:16:22 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150070.outbound.protection.outlook.com [40.107.15.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D701D2B73;
        Fri, 25 Feb 2022 00:15:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlM4T/SboDxh6aYxdvPhkkyiiucfyA6WqGONflkvz9WCGNFI+whI4Pwn5la+hxX69vXBydg6xdQpeifNWQB4Nd6XF142XRTg7BtRucHGuyr1FUHnopi6pfZsHsuuCZ+N/56fhAqvgiaDej4e9V1olhLdK22FPvTv1RDQPu44V+UV+9KNDpdfvCXJtFXtwtL1z+uI9V8Y2LRpnEj1qLoMm+yp8EJRWrF1ZdWjRkRYCmm5xF7uOMd4Djmkgs+d0Kb0EPe5+ftAPEgA9pVoknIR4oJunWUFQuvH0gfpzpom/XZv4IulHo8WTxHAjLPZKdl1fksfEAdaCK4x5/wion1V6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRCkEOu5OIRX88gq8xTRoBGYAkJ9gYDWVcbBrB2N3/Y=;
 b=kbSnagexWz1AWWhi/motwIbNzys9Azbc1g9BuFyrCTEXablzCvMju2NXivK3fe20Nhj26J+5nkzy1QzMM68JoPT+5vYuoUnGXwhRW3LEJh2PT7yvzpSC0rs2HHGKxEb9aY2O88BKNqJRGctHkMyJ/8AM4sg82hLk/VD/4Aye94TRyo1Tk1DqFlFnAQUD6t6dZueB9Y2JJmMgo9RE3TEyCJCk9Wp+wRP6igUWDCLcqI5Cw70r1da3BG8BDcuao5sxEx3r7B3TiwOFVfnhITQx8QKGM4iv6NoXL1zycWZYm1jwWbi9OKwYYIrtaXG/D2Ra5sHEqDvAE7PHEVFW4AbxHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRCkEOu5OIRX88gq8xTRoBGYAkJ9gYDWVcbBrB2N3/Y=;
 b=Wv2mpT+bjvhqb0vpiABAQ55cNn74SKEdg/q7Tcirdog8nPjUltgTy3ADB79dSOha/NdrgddUAhnVKrXEpZBYY7OYkmto/bWkrw4DQ09RrmM2IEVJQlGi4cVDDMezAu+pCIWq3iExTTYrY5mQbLstBbubza1vU1UubdT9MHk2v64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5419.eurprd04.prod.outlook.com (2603:10a6:10:88::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 08:15:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Fri, 25 Feb 2022
 08:15:47 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/3] clk: imx8mm: remove SYS PLL 1/2 clock gates
Date:   Fri, 25 Feb 2022 16:17:31 +0800
Message-Id: <20220225081733.2294166-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225081733.2294166-1-peng.fan@oss.nxp.com>
References: <20220225081733.2294166-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c32431a-1967-4fbe-84db-08d9f83706b5
X-MS-TrafficTypeDiagnostic: DB7PR04MB5419:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5419FF16967D898DB81642A7C93E9@DB7PR04MB5419.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKyBfKDdgIR0Rd+v+rlXNRnH8j4m6UkRpNeMgcOJSE6hbyu2/7Yok9tc/+oUG88vLu1Fw5y0NVzGYGq3iSLH/jGHLJ+hSFa/PmymwLtNcsgbHjBTd0jM7iNM2eX7wy3EgTrDEUAWHEOnV6r2JvCRpgwdzQ5kFfE1X86OBdnGArIqGagxhyybY2Ax47fLTU+lOuRHQoGoteVVlOODFDVirzEdZJE8GuwLGWVh/vJOfCqXiVF8l/dgaPV7477hqQvHmpU94JtIWg56hLdY+RS6djoAbN2obY1hPMUtw3FKXrW+GbMeAKJ6UxS5NynCnTyAJuNw+e9bxk8F6hBcKjwxBJuJcpD0NeLLLiw3lpK5x+twrWTp9iAYyW53Vtjl7gVt9sHL9Tbd+dO93v3TZB662zxjG21nnEdbCV6dN+nPjWdjyLwrWvUchV+0+7q83kZSsgFxPgzgnD8SI5M046PM9fAIC7LU7JB3BlAV3gEPmlh8uVylHtuVj9u92LfHcJKI484VuNWFAAG8kHl1OC+axrYso+lsGFk7MFwEmomRz3V5BycZYuwzjwCS1tkvcA1LBJjbJDAkOIGzL+yfSRBPPYPq2TMpLxMcw1ZpdYpXkhBWrYT2U59EBtDb3T2qVM6JOCJOyp90bQi3EA2dASL+B1CoPxxm/HZ9Rkl2nG1P4TBmBWYbk0HCXazFXo9nGcWyMH4VAzNdFY87m2KkA2pzVgcIaSP+Seqt9fGVj5C/t+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(1076003)(6666004)(7416002)(26005)(83380400001)(5660300002)(186003)(8676002)(6486002)(4326008)(66946007)(66556008)(66476007)(38100700002)(38350700002)(508600001)(2616005)(316002)(6512007)(2906002)(8936002)(6506007)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?koULM8IjlpsmDytEhW5nX+ys9oEH2PA68zBLD0Lnbi/0/HtTmz4bVjRimQr8?=
 =?us-ascii?Q?l4CMZdfCvT/qWYQlkV9iDYqvT2nylQJU3Ul3/ggA8FewsKKYYd9ltihCN25g?=
 =?us-ascii?Q?jACnDhwJIAY6+cE33PmnAYrYHXXaL2BSuzOvSkLH5Qjvq31K2ZF48yi03P9r?=
 =?us-ascii?Q?Q/YBuD0KYlZsNbX2dWV3Dv2OW/vzk7Hbff+XO4Mjs6vBKW2hAbTy5Y7eMVR9?=
 =?us-ascii?Q?ZAnxZkianlfnk/khRSXLvJzjdNIUAgqXV0a5YGoTt8GpaUdzfAgKnTpS1JQ5?=
 =?us-ascii?Q?60VF2kXBVmWEIFRpeW240/Zp+zY7s6uqzQsZ1fJiAm7x+MZDFTMT4MntBDoS?=
 =?us-ascii?Q?CeUaHa2RLsXtWWJoqKtbcwLkN2W+SdgkVq1VcwOGs/6ICB4IFsRv76lt7EN1?=
 =?us-ascii?Q?9qmZEY9cxsRZZLMPKWOreMYszdmUEDFMc6bFwOjbhYMBzKzdtn+kbaY5s5/W?=
 =?us-ascii?Q?OGt9s42NnHVaTfu9aTByQooWQEos9YzJ3iY/DPkhyMpJdhWS62AtP9qaqB15?=
 =?us-ascii?Q?voA1VM/v7zUaq2rRLfE+qLpi+VqZSaPmU1I54ZOBVmEaO4QXIrNh6PrEh2ZL?=
 =?us-ascii?Q?BefUzsuUNIbrT2Y075cRZaM0Q4VU004VpRDVSvyHxzTvyOi2t+oeaMTne9G9?=
 =?us-ascii?Q?5a2PPlmA4GW6IjDtgqQwngNqEKaDrjpeE7oFbKf1MI3OsY+YW7dLXvgQjW0J?=
 =?us-ascii?Q?KbccWDwCbtetV1DCtE2eGL9ASG2FALKRsRzyVQDYJJQrUbRu1BpisJwJug2N?=
 =?us-ascii?Q?bnkAEo/AzH2tkX4ygVzrCLXzC1pJENo3ZBBA1nuVocqgiqgsFf2A2mLlWKFo?=
 =?us-ascii?Q?YeloaNBhKN0Fyy3h5FBtRVY+fuFgngPlXQTWyLJcx+fMSaRFLGFV/s3u+cKP?=
 =?us-ascii?Q?q3VHJ4pMVpzM4DnCQN0uuXT0x9+YlqgO5P7EXRu3fPw/45wN+IL0eHnEaRS/?=
 =?us-ascii?Q?cnMnaVmHqZ5X25CtvqHupznw7zZoOq1+UMj2IPBntLBqfJ+ZS/X4qt9elfnn?=
 =?us-ascii?Q?H9qcS3z8B2Dss/aGDqtHBAtr/10/lP4IY/oDnz9va5So+3XUrlyKYIXFDf3Z?=
 =?us-ascii?Q?KP9f12TKJolj4faXjQXOsYUlXuADvcO6vgjF1fyvdCFqh45VueQB614mKb3l?=
 =?us-ascii?Q?pvavf7PrPStHn5w1W4LkZKLNn2jX96uM5yfttLRbxK8MxKrFk7co/XLfBDoy?=
 =?us-ascii?Q?Fmvg0JXxh9Jw5g7Ul98qnw/Yzbly13jEyaFaTBBYdWXa8k3P4L8jBki8gWfS?=
 =?us-ascii?Q?2oxcIn99t8qU3pHG1bW49UmZ2m2r4kxcNVsO6vSvCaoDybOKODiNibnzD/vR?=
 =?us-ascii?Q?1H1Wqz+Wood30ZdrhPBXec//Rm0o0WI6IHbID8Fa2FgPYtGhWrKNHc6s5Azh?=
 =?us-ascii?Q?9fPBdR4nGKrDpWvSyCi/gFH3ImRH4rEIkDfGJt+mbWwErFdtkXSNB/uzwved?=
 =?us-ascii?Q?aLwuQWU+qg+vNtFY6nll7zYIXSNV6t5vcWk/0fULCqvvu38ovhbSEtFknqFz?=
 =?us-ascii?Q?SvjN2JKjyyztVRyJ+299m3qqDjp6WD9f9NvgNOQzxp+aGZ5Z4JuglnLU5bab?=
 =?us-ascii?Q?DAOXDWDFTNfiikdJ4KRwIVxCKGJMeJh/4knpV8JayBNeirYU78n+h+fqqb0W?=
 =?us-ascii?Q?rJvBnnxMVMRTa/Zdmer67bo=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c32431a-1967-4fbe-84db-08d9f83706b5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 08:15:47.0803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ClL180r7Sk2vEeJADkMJj5cyUAYttdW4kRSR0FCOs3eDgH/DUqAAG4sQ/msBWcWEqJYE4U1ZaFWK4Ne9VMnqIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Remove the PLL 1/2 gates as it make AMP clock management harder without
obvious benifit.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c | 49 ++++++++++++------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index e92621fa8b9c..e8cbe181ec06 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -366,45 +366,28 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MM_SYS_PLL3_OUT] = imx_clk_hw_gate("sys_pll3_out", "sys_pll3_bypass", base + 0x114, 11);
 
 	/* SYS PLL1 fixed output */
-	hws[IMX8MM_SYS_PLL1_40M_CG] = imx_clk_hw_gate("sys_pll1_40m_cg", "sys_pll1", base + 0x94, 27);
-	hws[IMX8MM_SYS_PLL1_80M_CG] = imx_clk_hw_gate("sys_pll1_80m_cg", "sys_pll1", base + 0x94, 25);
-	hws[IMX8MM_SYS_PLL1_100M_CG] = imx_clk_hw_gate("sys_pll1_100m_cg", "sys_pll1", base + 0x94, 23);
-	hws[IMX8MM_SYS_PLL1_133M_CG] = imx_clk_hw_gate("sys_pll1_133m_cg", "sys_pll1", base + 0x94, 21);
-	hws[IMX8MM_SYS_PLL1_160M_CG] = imx_clk_hw_gate("sys_pll1_160m_cg", "sys_pll1", base + 0x94, 19);
-	hws[IMX8MM_SYS_PLL1_200M_CG] = imx_clk_hw_gate("sys_pll1_200m_cg", "sys_pll1", base + 0x94, 17);
-	hws[IMX8MM_SYS_PLL1_266M_CG] = imx_clk_hw_gate("sys_pll1_266m_cg", "sys_pll1", base + 0x94, 15);
-	hws[IMX8MM_SYS_PLL1_400M_CG] = imx_clk_hw_gate("sys_pll1_400m_cg", "sys_pll1", base + 0x94, 13);
 	hws[IMX8MM_SYS_PLL1_OUT] = imx_clk_hw_gate("sys_pll1_out", "sys_pll1", base + 0x94, 11);
 
-	hws[IMX8MM_SYS_PLL1_40M] = imx_clk_hw_fixed_factor("sys_pll1_40m", "sys_pll1_40m_cg", 1, 20);
-	hws[IMX8MM_SYS_PLL1_80M] = imx_clk_hw_fixed_factor("sys_pll1_80m", "sys_pll1_80m_cg", 1, 10);
-	hws[IMX8MM_SYS_PLL1_100M] = imx_clk_hw_fixed_factor("sys_pll1_100m", "sys_pll1_100m_cg", 1, 8);
-	hws[IMX8MM_SYS_PLL1_133M] = imx_clk_hw_fixed_factor("sys_pll1_133m", "sys_pll1_133m_cg", 1, 6);
-	hws[IMX8MM_SYS_PLL1_160M] = imx_clk_hw_fixed_factor("sys_pll1_160m", "sys_pll1_160m_cg", 1, 5);
-	hws[IMX8MM_SYS_PLL1_200M] = imx_clk_hw_fixed_factor("sys_pll1_200m", "sys_pll1_200m_cg", 1, 4);
-	hws[IMX8MM_SYS_PLL1_266M] = imx_clk_hw_fixed_factor("sys_pll1_266m", "sys_pll1_266m_cg", 1, 3);
-	hws[IMX8MM_SYS_PLL1_400M] = imx_clk_hw_fixed_factor("sys_pll1_400m", "sys_pll1_400m_cg", 1, 2);
+	hws[IMX8MM_SYS_PLL1_40M] = imx_clk_hw_fixed_factor("sys_pll1_40m", "sys_pll1_out", 1, 20);
+	hws[IMX8MM_SYS_PLL1_80M] = imx_clk_hw_fixed_factor("sys_pll1_80m", "sys_pll1_out", 1, 10);
+	hws[IMX8MM_SYS_PLL1_100M] = imx_clk_hw_fixed_factor("sys_pll1_100m", "sys_pll1_out", 1, 8);
+	hws[IMX8MM_SYS_PLL1_133M] = imx_clk_hw_fixed_factor("sys_pll1_133m", "sys_pll1_out", 1, 6);
+	hws[IMX8MM_SYS_PLL1_160M] = imx_clk_hw_fixed_factor("sys_pll1_160m", "sys_pll1_out", 1, 5);
+	hws[IMX8MM_SYS_PLL1_200M] = imx_clk_hw_fixed_factor("sys_pll1_200m", "sys_pll1_out", 1, 4);
+	hws[IMX8MM_SYS_PLL1_266M] = imx_clk_hw_fixed_factor("sys_pll1_266m", "sys_pll1_out", 1, 3);
+	hws[IMX8MM_SYS_PLL1_400M] = imx_clk_hw_fixed_factor("sys_pll1_400m", "sys_pll1_out", 1, 2);
 	hws[IMX8MM_SYS_PLL1_800M] = imx_clk_hw_fixed_factor("sys_pll1_800m", "sys_pll1_out", 1, 1);
 
 	/* SYS PLL2 fixed output */
-	hws[IMX8MM_SYS_PLL2_50M_CG] = imx_clk_hw_gate("sys_pll2_50m_cg", "sys_pll2", base + 0x104, 27);
-	hws[IMX8MM_SYS_PLL2_100M_CG] = imx_clk_hw_gate("sys_pll2_100m_cg", "sys_pll2", base + 0x104, 25);
-	hws[IMX8MM_SYS_PLL2_125M_CG] = imx_clk_hw_gate("sys_pll2_125m_cg", "sys_pll2", base + 0x104, 23);
-	hws[IMX8MM_SYS_PLL2_166M_CG] = imx_clk_hw_gate("sys_pll2_166m_cg", "sys_pll2", base + 0x104, 21);
-	hws[IMX8MM_SYS_PLL2_200M_CG] = imx_clk_hw_gate("sys_pll2_200m_cg", "sys_pll2", base + 0x104, 19);
-	hws[IMX8MM_SYS_PLL2_250M_CG] = imx_clk_hw_gate("sys_pll2_250m_cg", "sys_pll2", base + 0x104, 17);
-	hws[IMX8MM_SYS_PLL2_333M_CG] = imx_clk_hw_gate("sys_pll2_333m_cg", "sys_pll2", base + 0x104, 15);
-	hws[IMX8MM_SYS_PLL2_500M_CG] = imx_clk_hw_gate("sys_pll2_500m_cg", "sys_pll2", base + 0x104, 13);
 	hws[IMX8MM_SYS_PLL2_OUT] = imx_clk_hw_gate("sys_pll2_out", "sys_pll2", base + 0x104, 11);
-
-	hws[IMX8MM_SYS_PLL2_50M] = imx_clk_hw_fixed_factor("sys_pll2_50m", "sys_pll2_50m_cg", 1, 20);
-	hws[IMX8MM_SYS_PLL2_100M] = imx_clk_hw_fixed_factor("sys_pll2_100m", "sys_pll2_100m_cg", 1, 10);
-	hws[IMX8MM_SYS_PLL2_125M] = imx_clk_hw_fixed_factor("sys_pll2_125m", "sys_pll2_125m_cg", 1, 8);
-	hws[IMX8MM_SYS_PLL2_166M] = imx_clk_hw_fixed_factor("sys_pll2_166m", "sys_pll2_166m_cg", 1, 6);
-	hws[IMX8MM_SYS_PLL2_200M] = imx_clk_hw_fixed_factor("sys_pll2_200m", "sys_pll2_200m_cg", 1, 5);
-	hws[IMX8MM_SYS_PLL2_250M] = imx_clk_hw_fixed_factor("sys_pll2_250m", "sys_pll2_250m_cg", 1, 4);
-	hws[IMX8MM_SYS_PLL2_333M] = imx_clk_hw_fixed_factor("sys_pll2_333m", "sys_pll2_333m_cg", 1, 3);
-	hws[IMX8MM_SYS_PLL2_500M] = imx_clk_hw_fixed_factor("sys_pll2_500m", "sys_pll2_500m_cg", 1, 2);
+	hws[IMX8MM_SYS_PLL2_50M] = imx_clk_hw_fixed_factor("sys_pll2_50m", "sys_pll2_out", 1, 20);
+	hws[IMX8MM_SYS_PLL2_100M] = imx_clk_hw_fixed_factor("sys_pll2_100m", "sys_pll2_out", 1, 10);
+	hws[IMX8MM_SYS_PLL2_125M] = imx_clk_hw_fixed_factor("sys_pll2_125m", "sys_pll2_out", 1, 8);
+	hws[IMX8MM_SYS_PLL2_166M] = imx_clk_hw_fixed_factor("sys_pll2_166m", "sys_pll2_out", 1, 6);
+	hws[IMX8MM_SYS_PLL2_200M] = imx_clk_hw_fixed_factor("sys_pll2_200m", "sys_pll2_out", 1, 5);
+	hws[IMX8MM_SYS_PLL2_250M] = imx_clk_hw_fixed_factor("sys_pll2_250m", "sys_pll2_out", 1, 4);
+	hws[IMX8MM_SYS_PLL2_333M] = imx_clk_hw_fixed_factor("sys_pll2_333m", "sys_pll2_out", 1, 3);
+	hws[IMX8MM_SYS_PLL2_500M] = imx_clk_hw_fixed_factor("sys_pll2_500m", "sys_pll2_out", 1, 2);
 	hws[IMX8MM_SYS_PLL2_1000M] = imx_clk_hw_fixed_factor("sys_pll2_1000m", "sys_pll2_out", 1, 1);
 
 	hws[IMX8MM_CLK_CLKOUT1_SEL] = imx_clk_hw_mux2("clkout1_sel", base + 0x128, 4, 4, clkout_sels, ARRAY_SIZE(clkout_sels));
-- 
2.25.1

