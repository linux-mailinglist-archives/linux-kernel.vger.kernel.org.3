Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1A2592785
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiHOBad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240291AbiHOBaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:30:00 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80089.outbound.protection.outlook.com [40.107.8.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB3913D28;
        Sun, 14 Aug 2022 18:29:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loOIJUxohJfwt5uMLCi17x6qUO4rmP/aX/IieKz1ldLXbpaAcsZGFLYi6qctXJHXvseL5M3GNXFK+CS85+qBnCcitmuEgfs5J4zYtEgsfyJHyXxniX7MEUmmxZiUA4fUMzpTTqWl4Sp9tXFIMITw5I+LYGW/1BinghNuEqlT8qMR+YCagN93GfjxUh8Vlg93IUEm2C9JbkEVjE3gYqmme3lzU6p90zXIWUDdMuFiEwet7eEGEiAa/x8ZNZmy0nge++y3CQ/VS3apLrlyLZWlf+tHiIKq73N9iQBP8qPIhBzXzdwdUgBSoDkDvukjsVGmCWyvqvZW7nXhjrJEY15b3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbZhX1d9KUXHfVurYPlwyERoOP/iIM5Y/sciXwqJbcE=;
 b=GjQjfXOrOLblt7GOvJ3wXk0GDZeE8hUY+pstmE4COcfMEI+izNUnp0Tzbr/x0RvAnOMHlMCZd16vo8Hd+HlPHd+MQrZgaFyZ9e4rrOajHgbV67DhFvR8KsWQGos5zMa+tJ8ru0T9qi1lDLpGJAdSSX18+AFJQii3Yz5nR9MgNvNcrpuk43ZtFbHJI/VeF5VWibFTfr2Klr96Gg8tE/zKPfxmPS/JR0PJyWHOK/nX+WMbBx07a/d8bveuoPyr1qubyFthv/jH1aLktQSXOMeDCuIQEcBplBHDixQs9b6ZI2ihmsVfme/CxJYhvL1irJlm2x4oCTDr2qbKn11qz2L5HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbZhX1d9KUXHfVurYPlwyERoOP/iIM5Y/sciXwqJbcE=;
 b=a+94cUaib+cKXkAVqezjJmvTO1WgH++GjCSMmRf/rrgp2LFL5JWZd1R5cbvhh+M64d2F1q4yJjVfyYZpZ178APgIY2bAUFzLrO3t/ztHEp9DLnC0U60qQV9WHLYu/IaKfFEMKElIeZJCaPA9LCQmE92b6f96o3HzbKE1i3T4h/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8751.eurprd04.prod.outlook.com (2603:10a6:102:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Mon, 15 Aug
 2022 01:29:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 01:29:47 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, abelvesa@kernel.org,
        abel.vesa@linaro.org, mturquette@baylibre.com, sboyd@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 8/8] clk: imx93: add SAI IPG clk
Date:   Mon, 15 Aug 2022 09:30:39 +0800
Message-Id: <20220815013039.474970-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815013039.474970-1-peng.fan@oss.nxp.com>
References: <20220815013039.474970-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0d00662-10c6-40f9-067a-08da7e5da3ab
X-MS-TrafficTypeDiagnostic: PAXPR04MB8751:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2n8pjXodxtT8h5w2H6CZh+Fb0CRZSD+c+XchDBYAEktmnWqABUZAdUX9ekF4QdEP/ynrJQ9zgLBsYecdWEsbBfTVMndeYQhKXWwxD6NQs0OJ2tIopNyZaVEDp9mX7TwxijsfCzFSB1ivi2mrA6BGrw3Xc6aQdZuJoV5JAXEuOMdXliXL/j4XxrCOvFwJ2sgUFU7hEXcp4vL4wLQbL1nW6EVA0H4w57GXSgRfii//050UXT/9Wj5TTI1J4pYQ4YoulB45iIVmcs0e2xmAwcQki/1NBRiYVPiN8ui0dcLXG+4UFp1Z5UTqRjYVkNv1EB18ZZcENQsV3i6EE0jHcVmPPELOy1KkiO4FaHkNDyxZbdsP55HECBknUCCmzkkP//xdzZsNt2DSN5NnTbYtv8ZZcgI0TC2GRfa/5pSgphgKmZQTpH85SZJkIWfpEiK6ih7uBDoc6nw8xPYB+kYItlfXeIs+VPaQa/rVXddyl5dqPkccLTyQFmIEWEn87bcaBhmjwYqm6H4ke5uvl/6Oq3iQLwI0XVkhKDWJbyQWYvljpGlv7/LFnjajRtICbfjRVxtnx6kZMug1c3BZSvMmLfMBA9unyFT+46t19/7n0Tfoq+svGWpOHI2hNKoH9TSrYMA/KYCAXANuPmowb6OR6Uwk3D/4uoHY5dsHsuecyU+oZ1WPEtE8GAr09AQgB3MQwAkLtg8QluU/45iZdXv6grygOyO0VF8oEUEZHM2C5/f1TohDeRDLZGa+Qo9bKpBsCRBi2620fT11VZ872tFH/YLoVO/hn+eFElCOh8QYQB8t9TI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(26005)(6506007)(52116002)(316002)(6666004)(7416002)(6512007)(83380400001)(1076003)(478600001)(2616005)(186003)(41300700001)(2906002)(38350700002)(86362001)(6486002)(4326008)(5660300002)(8936002)(66476007)(66556008)(38100700002)(66946007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WXt20bh6rcGejxkms9FZw21aXm4Kk9sB1NGvPZpffRDncPV2Y6RyDL+bSSsU?=
 =?us-ascii?Q?3GjdzxO+xBaxpMcqAqT7bRef5Dh4YMLBa/rqh9yvWBpouDTFPfxnQVututIH?=
 =?us-ascii?Q?TndeOlrzgse1+ux4sV1fV8AesC+/ILUKyqBzXbiRiQhgyPD1rDfxL/JpksCz?=
 =?us-ascii?Q?iw13WwyXspwIJRg+lnm//JsRrp3nJGMw06n4ih3aJ5nR0zkSgfjjsTSc9zD/?=
 =?us-ascii?Q?QbRP9yX7EisJkcJ7yqhqdedgiKGTqPGPntUG91GUbBcHPgzvj0SXzAI+6I22?=
 =?us-ascii?Q?204xS9taz6eMBcXWPJNJBtAFIWj3OlIZCiZNCBXWe9MuMrt//lfv3T41LwiU?=
 =?us-ascii?Q?Kh5tw2O94R0dmbkSeND9df/ZUGwAEuyA7vyj2mijKCnp3sNqHGm243SivF9R?=
 =?us-ascii?Q?+aRh74Z0UAn0c9NDyQ/RykP7O0RsWd19LsTPC3EogdnKKRwTtHdr72Xgyev5?=
 =?us-ascii?Q?7eawkY5WzBbnPZobFF2+0DnvEcppiEKq06scaaqv/7p+9DdJ501+SituJT4R?=
 =?us-ascii?Q?wv3I/QzSA/q2AEKeeUGQsg5UJf4LLWcEA+8A+/bOMP/3/3yfC2kfz4bWOlJv?=
 =?us-ascii?Q?DnP6c3XSRG+vUzdCOGEhvpyIO6R1SGaVkvQ7QY3VEvR4IzqmaQHk/2/CYE1Z?=
 =?us-ascii?Q?U9yv94PfHKUCkb9KPFWOUuEAf4LUujiGE4vYbKXRkSVJQfasjVHP+/824SdJ?=
 =?us-ascii?Q?P3vtwRAH6KI3U7QyHlpx3Hu0V2bUd4bOABZU/m9qrFR58OehbyCfICgSelac?=
 =?us-ascii?Q?tmtGgb0p1rjWckUzNJu3gwh4BTy+dv1zuRMCiaAI0YD2ppxnB9XbJWGdxKae?=
 =?us-ascii?Q?VUyhrGMcqxj05oS2AcG5d+OYlIpLInLEufTSG330+aFBkmXsI6CBz9UBHbv+?=
 =?us-ascii?Q?rrC1YzJeiahnuW+/78RPbJxvwLrHiYLRe2v1YgNF0ydUMwGVYwetYtLAFbjA?=
 =?us-ascii?Q?GXaLCLGk6djV8h8zQ51gvJ5abFc4/5nSBshLu36Pc6GF2ya2CRD4CnLDPHQh?=
 =?us-ascii?Q?Ow8HXe+X4T5y6j+FbTIaBKT3hHTkCfgYxu7Nf2zaRBH9NXeXNBw58r5gq10F?=
 =?us-ascii?Q?GNIWilCfh6B/0n7oL6KIkidBO2oh2xP4Y7Dwu7dsi6k0iIpaWjT/evtgQ2Ng?=
 =?us-ascii?Q?F1sjJAYoIrHOu6/DANwBoBuTcDNbntiK2FGJ+zYBFA6iqTbFhruvELLFzvc1?=
 =?us-ascii?Q?iAUQ08KkGGi2w6NtIQ6n23wqDqybkGIEu1Sdz+h/xaISfHVqdIpuQ/keUVbx?=
 =?us-ascii?Q?PxHIJj2abok1ySOrdz7AQHQbvk1aq/VKfADWlndfqcGNTdAKbl+CEX1v7vaF?=
 =?us-ascii?Q?dm8YuEzsDZ1UnBDXWyEa8XE8AZ01psgevxVr/gs/IPWribNCs2dYAQdh4dOX?=
 =?us-ascii?Q?wH6bCK9wr6WNjeTFwOxWl8QPrMEuNUekVI9CdP/wHRLCYZpI3toQNKQAKQzh?=
 =?us-ascii?Q?9Rsdwj8DL9o0tNlxtWA1Yh5XwgOh6Pov2sbgG7WlmZ4SfhCWwSCh4fBD8q/i?=
 =?us-ascii?Q?wVAYmVBpoi+BjCHOZiXG9X1whc/+RgAg55JkffWEtf42AfbPL4GAXsjSn2Jm?=
 =?us-ascii?Q?kDHv/1cJjUaHC8l71/gLk3U7ksXtB23W2AdFOdMd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d00662-10c6-40f9-067a-08da7e5da3ab
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 01:29:47.1642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+r7ysLz3w5ScUKwgWlrFrQUu5CHjFYUZrskXw9tVHEWsQV5zm4f2025dvZc9UKMVDY5RdbMO7FywCwQgrsiqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8751
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
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
---
 drivers/clk/imx/clk-imx93.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index 4008ab075dfe..6a76b9fdf18d 100644
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

