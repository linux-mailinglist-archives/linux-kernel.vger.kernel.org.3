Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56175A5A07
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiH3Dbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiH3DbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:31:14 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7695FAA4D1;
        Mon, 29 Aug 2022 20:30:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rmk5z5gpEx9FRnR9XTLIvZ7YIK9LtZ+57OI/8k3OYFBWqqLU73TXRvFP62N/OzUEu+gclgZHf/idcEZj7QKlHgdMz0+C9hUOsLAIDx5awNXluDjjuMtn9JFlspeYw1BDQIuvvXbSeELKG3lHpzugJ9C8MLH1Gud/u1hz+zDNjoAj8OpOHPa1SmziilajvH6P9uNEUJqWNbumkHae8gHsdYunzt5jX2WfILI/iGsRWlpKL5YZl8e984eCbh6A1/cMApMMemb6dBANfRvJurRH9/qlu6xmTaAzjzJoEhPrIHv2C2BaOpKSccVAstUUbbisye7riUeYDueTEpC2/CItVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2JUHBfTA1K72ecX2MRp2Wn5YabWMaDDVctQF/gu1a4=;
 b=IjbiqMwCdyqYDROFs8q1Xv4oUxsRK4LJxAwl6DzjPQ4ylvEIScI1rviGCF+pwm9VQT6buoD8jXt7SlxS64fbW5VeJW0PtWBUlOwk0DOHit3UcY7Ruzh+t9yerX8kc4sTD2bw2RxW18CrhkQq8QOXpVgLPRexKhu5YXMTtyrWNkCYmPciG+b/HHkHmGFhSE2intEnJ/HOUHulGNifzxniuO1If47XcFydbiu9KVKfOMNL1O/RavKWsIjikolO12u1Ddq+wE6iurtgdYGtKzikjPam+cLPX0+Fd2OFW1nOsxE/OqNht1z4FW2jg3RoBIc6ALlt/4R7pcPymvREBc3nww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2JUHBfTA1K72ecX2MRp2Wn5YabWMaDDVctQF/gu1a4=;
 b=AvD5FAsy1B4wGPPZ34MgkDBPwUu9fSx3h8xZQYt8kCFfHvUUumzqqsn+GhyEK53UGKDaWIp8O9R2VHs5KRlPItvqCY0ZzBRBqbbY8ztUU7B8adJDrDsbdlNGPzRGDUW/b26Ncv79cze2fPGM4UcqcLtnTfYxFVs1SvZfi06OreM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6926.eurprd04.prod.outlook.com (2603:10a6:803:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 03:30:39 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%6]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 03:30:39 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 8/8] clk: imx93: add SAI IPG clk
Date:   Tue, 30 Aug 2022 11:31:37 +0800
Message-Id: <20220830033137.4149542-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220830033137.4149542-1-peng.fan@oss.nxp.com>
References: <20220830033137.4149542-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::34)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd0f7f7d-5b48-4ee0-c4eb-08da8a3802c6
X-MS-TrafficTypeDiagnostic: VI1PR04MB6926:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ROFwfkqKnEVr/kfMRxGbY1ILq7A5G2mngTJMoiEzN/4RXleR4CNWK0HgCmRxr5zNaNxgOpqA92GrXDILX5Uw/WG2LCkUe6RtJAsucFeo9igjM5z404yHxryAqogXOVOt7Nc6ll+CG/Cgv3cJpCdld2NFhHXsFYrD4Hfqvx9m8ovBUtbuMwvtlJ+hSBqmZDIN8rzqMzuPa0G/x9ZEm0SltYemY3y/V8NrC9hdKv85u2P4acu/Sx1zGL0Tu/wYzq45LjhLdOlJkrEeac9Q7GPxGOf1xxco51nGrKq1vvKaGgAUFpw+fm8wDghGvUhEjpUex2dqwqp/KDIrOxSai3V191BqdYs0bGjRVaqPReqk8qUL636F8aHDsmSeZmhtHn2oSIC/31qt+HGpRsWU/4K0vUmXizS2gXLoOB3dGBdUOrZLukWz3NyfR3Nolx1MM2vOSLIFqa8juu+fvvsh3vL6Bw5ZtSbXrJJdEpTKDbE97bz0R3UaJTNiMcGab2Di4VwBfbpWbjtOg0rPN2E4hGFQZI3RLfjSwJE8VNsFlTJNMSQ4BSandk6kXaLjuRjLQY9unnjRKTlIReW9UW9Iol3BY2yLH44qU6srh8wEN9cxNh1swa3U5V2nSBhAgRHeHwo/bfgPfo6G4Hp+EbVQTnzgUVIQBdWGxY1o2sEHz9Bq+BjIkgVk3NnGxiT2U4zLHBb4MumJ/+hN2Msn7Wy3KTjH71RYsrD5ndzeiZjQT+U0rJ0z6/JYbtI1GfRM7ZYbxpFs5ZelWSeMnbCi/GzXqxZ5wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(6512007)(2906002)(38100700002)(6506007)(2616005)(26005)(38350700002)(52116002)(186003)(1076003)(83380400001)(4326008)(66476007)(66946007)(66556008)(8676002)(316002)(6486002)(7416002)(8936002)(86362001)(41300700001)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rfwC7wLMhjNkG4Ff+UOBV0q0Lup6dh9YHq8zQoQRdwq+p0pGq/yD+gJfv+R9?=
 =?us-ascii?Q?BT1LMU9ZML6PlbRP+IPiuKqMgwVb67Kx7N81Xj+ckCIIqOGus4kH0NXVT468?=
 =?us-ascii?Q?Nw0CElq4nl9rxr+Dfkr4CgsyaLB0t6zVE59G8ZjHdVxdkhGhE7Yc8LCnbief?=
 =?us-ascii?Q?11WOYwTMNzZws7HXRh3aQbbLlaSLd3SIJJO0xypACinrpvv5ZPmMGOQm0Dmz?=
 =?us-ascii?Q?CiZtWZ/K/sLfObSbABUD32TjhH0F0B+DVR9u9TvAfQeAzqUviPnXENgabkd9?=
 =?us-ascii?Q?0UyAljK5NgiaivB0l1T1bqSX02qpEBFimHOUf5jQfILUQiswhbIVoBj5o0U1?=
 =?us-ascii?Q?MicvlBHiEc4tojPqYgf1YEejydfeOL6VIhW6kcNCIDXM+App72PXr4WCsAhD?=
 =?us-ascii?Q?FJr3gw78Ev7+0/VA41eJngkN+PG1YCslk3ERiHnajNIymDbToL5+T6H5OSkq?=
 =?us-ascii?Q?SgAEZ4+2SYAB929mvnNA1mLmTJFWQDVt1jLUEgkfAxydVhsDMlzZOjmj7uMu?=
 =?us-ascii?Q?8OsHbMeAMbqxCnCgt3DcMwT6q7SPauVaV4pHz0DAOtdzIIhKaG46D2J+HM7F?=
 =?us-ascii?Q?I76Gb+QhEkaPHDtr4jrcfIKPg/Dk6YokPX0TzDcvmxr0F5CRSXK9LYzIVGC2?=
 =?us-ascii?Q?rq0y3PUI+qzThksmToflBZ3a5UCtH591/C2T8OZaA6K7FLFInhyX9tiPxmDy?=
 =?us-ascii?Q?WliHixVHjsimjZI76NVKUu9Cz7l9zwujxF4GV/7E1K1yUOZ1IACifgDPfKOM?=
 =?us-ascii?Q?sTNhLxAP4WBA/yYHH2P0H7JlOM9SZUpLeaZpk6WlkJPUjt0fsO1/R0NCz+hj?=
 =?us-ascii?Q?8GBiLAzD2BMkY3z8VP35HTstdW0y+BKc13sPAna1xY4JcbYs+xTPus8JWuSh?=
 =?us-ascii?Q?u/yQiPtn8iJARZ7jhsuwInLu412rOTqOFVwZYYseYNspfXSd4XRGjH9bU3Fs?=
 =?us-ascii?Q?oII1OyFcNT8K0fqtpzwKApYlqyG3wA1vv8MayPpXr77PJsmYLCIiueZ8awdT?=
 =?us-ascii?Q?6AW5x305KoukpAxdPuIQoygiScpCTqI6FIIWsQIlQjYPATb1h9MlmBLog62Y?=
 =?us-ascii?Q?UnbRFueEbsZG3flBXzAXTOZehclwKiF4q/xI55wGtdzOxKHupunqAwR3sdx0?=
 =?us-ascii?Q?jBcriFdGiYbNf6AAJcTkgxrnC4aHAwQ8ecInGQWu+Tz3pYanv/77vRbpq+dB?=
 =?us-ascii?Q?9AlqF9mdUnF3I4bUH5I/y2eBzML9b2PXe7eZvtWs0vYAilWa0h4Z9an2qiEg?=
 =?us-ascii?Q?ehnC1pq4OF5nagM34qZxA6FfYeqUQnSVlMyh8pFhhKeobWdFYe96fPnj4tIy?=
 =?us-ascii?Q?VCvISNmkiCGhNnWuyPiVEIG4yfDj/XO/bTmgNS931rg40mgeHr+6ldnwhixl?=
 =?us-ascii?Q?BW7BoUUqka8Czlf95jIpf4m9mIAECC8nJT/v9lfzTtmTkFltbGwJbiv+VM8C?=
 =?us-ascii?Q?PjeiyTurMHihfYa7s5xLvtCFAsK3Vce3TXSdoOEvYW4Lf/ydWeL7jIENExP5?=
 =?us-ascii?Q?0hjoCkwCuPXu8sICM5wFl+lnUenjgUc2doRmNfI18G/4NnXBxIcgrE/M09xk?=
 =?us-ascii?Q?MmrMq6CZWQe45NajfXLxkUQcGs2NrZtxe+ZQkZTT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0f7f7d-5b48-4ee0-c4eb-08da8a3802c6
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 03:30:39.8384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+AxADPnkEiWiSROoCJl2ExOQ16XXSvqSRDWZVHbJ1yYmTGMgGmCgjqevtLxAAf8plj4QAwz/8ExHKHx8GA+TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6926
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The clk topology is as below:
bus_aon_root------>\                  /--->SAI IPG
                    -->SAI LPCG gate-->
sai[x]_clk_root--->/                  \--->SAI MCLK

So use shared count as i.MX93 MU_B gate.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/imx/clk-imx93.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 51af0b12ff9e..99cff1fd108b 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -28,6 +28,9 @@ enum clk_sel {
 	MAX_SEL
 };
 
+static u32 share_count_sai1;
+static u32 share_count_sai2;
+static u32 share_count_sai3;
 static u32 share_count_mub;
 
 static const char *parent_names[MAX_SEL][4] = {
@@ -215,9 +218,12 @@ static const struct imx93_clk_ccgr {
 	{ IMX93_CLK_USDHC1_GATE,	"usdhc1",	"usdhc1_root",		0x9380, },
 	{ IMX93_CLK_USDHC2_GATE,	"usdhc2",	"usdhc2_root",		0x93c0, },
 	{ IMX93_CLK_USDHC3_GATE,	"usdhc3",	"usdhc3_root",		0x9400, },
-	{ IMX93_CLK_SAI1_GATE,		"sai1",		"sai1_root",		0x9440, },
-	{ IMX93_CLK_SAI2_GATE,		"sai2",		"sai2_root",		0x9480, },
-	{ IMX93_CLK_SAI3_GATE,		"sai3",		"sai3_root",		0x94c0, },
+	{ IMX93_CLK_SAI1_GATE,          "sai1",         "sai1_root",            0x9440, 0, &share_count_sai1},
+	{ IMX93_CLK_SAI1_IPG,		"sai1_ipg_clk", "bus_aon_root",		0x9440, 0, &share_count_sai1},
+	{ IMX93_CLK_SAI2_GATE,          "sai2",         "sai2_root",            0x9480, 0, &share_count_sai2},
+	{ IMX93_CLK_SAI2_IPG,		"sai2_ipg_clk", "bus_wakeup_root",	0x9480, 0, &share_count_sai2},
+	{ IMX93_CLK_SAI3_GATE,          "sai3",         "sai3_root",            0x94c0, 0, &share_count_sai3},
+	{ IMX93_CLK_SAI3_IPG,		"sai3_ipg_clk", "bus_wakeup_root",	0x94c0, 0, &share_count_sai3},
 	{ IMX93_CLK_MIPI_CSI_GATE,	"mipi_csi",	"media_apb_root",	0x9580, },
 	{ IMX93_CLK_MIPI_DSI_GATE,	"mipi_dsi",	"media_apb_root",	0x95c0, },
 	{ IMX93_CLK_LVDS_GATE,		"lvds",		"media_ldb_root",	0x9600, },
-- 
2.37.1

