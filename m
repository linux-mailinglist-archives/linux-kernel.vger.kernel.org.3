Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41A65A5A06
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiH3Dbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiH3DbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:31:09 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4245AA4B30;
        Mon, 29 Aug 2022 20:30:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSytJpiIOfiIqPuuXii26dQYJOYojTe3Y5Cs4jQjlt22qvMzTtQJcSJWrj+MuY0ZPQOdPC1SF0VwmMr/bwIUwWDRfrkTl1ly5n9F89gqKWLJVAaqpXFDK+xSv0sgnUdkkIK8prpyE0lgvCBX8am8RkQoM65A+dFATiR53ZWpjZQHkcPwND8hDJJHk3BCtFtlXzan6isXG38fCFhWUkt0KXrVm85yCAXEqDUDYN/wPJO7Rnr39Fk0M7avgylM3Nay7kIu/Ax3Zro4Gu2sv/zN5ZrL8poGsa4Wr4GlaZPNrcIJXVvHD640ZzodlL9RddWegT5hgd1B5U2dh6liye0Gsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caWjZlihlyD1fE8NfjRybi50Li7X2p1/XAvodzrKCd0=;
 b=brlLQQ48uZ01cR6FKctOwkJ/EMqdzAovLXiIeLoBDx47d7CbmRFGcxS+spK1o/CngmdKZeLZcbXhf4wtIVPRhQLJPo43+sXP3ePUQIr8oHC52yLFyIFjznCk2hbcdcyxOCmz6uwyItk8ydcwxX1e1N0Q2n0u46y1QYqXfo0g6EVceGN1trJEyas3LjU20yWpJ6bnywt+7YlKggxQSlgntBWVSIBXhoU0eiBdqiHrniBg3hFxvezPBcb78xHwj8yw9t/zqw+aruUN1kEVqZS2RAET4lWs4cwMqN8QX7G6nJoL/Fe/m3Ip93tefbhxnGJBxHUSjY1tOMEaxE3u23RCZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caWjZlihlyD1fE8NfjRybi50Li7X2p1/XAvodzrKCd0=;
 b=i7w/nAFgQOCKRdFihKBEnwHQ2+qZOnvYucgOBKZTV7UEk+QrFl1lhPq0qYD2Y4nWlLPCjUDm4IQSG2oVhV45Ii2Y5+EmMKUg/RmlYeopvKTMBIafiemI30QKhLViRT7V/665Dphj7n0ILrleSS2o6t8PaIoitdqpdN40GXBb+Z0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR04MB6926.eurprd04.prod.outlook.com (2603:10a6:803:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 03:30:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%6]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 03:30:35 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V3 7/8] clk: imx93: add MU1/2 clock
Date:   Tue, 30 Aug 2022 11:31:36 +0800
Message-Id: <20220830033137.4149542-8-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 36d342cf-6220-4a48-4f5b-08da8a38002d
X-MS-TrafficTypeDiagnostic: VI1PR04MB6926:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tYJfql1rRArXxq/EAOZil6HYSbv0gzuhD4w5Leu3tj7OTkLUY05x64K50uDcJQvviLJfu4bKa5Q75IiP12yd5l63poqlvHeJq6NQEZwXpXbqVCQ+f7MT0SXgeSUrHCwjTPolYNtosPdaeGOys7Tz4BgYaeud4xIftlMdUcl59lVXP9rql5Uyd/7xSr4d7/nNCSYxAU9Fw+KOSouW4LnZub0DxCe3FtE8TbGFUJ7wBcbFkjWzgI4CI+HyNG1w67yUJjJ94udSG4QPg37aPIS9YIZ2psglI2z5TsrFb2jDUhtSMv6jR2MuHmjkCN6MDg2m1rMRNdkQcn0lIoQ5GvN3+QCGBp8X4z5iLPir/RRCUuuyd85VS35O6E2yNO1EoyBBSLpGUoVImMl8lh8Htm/7z8ulhD58c9SEBxk7+nViVtKu+qXbvUupnYFRk0q8rnEGSn10mMjTFHnrinwBWDqQ44zWkI6ShpXCmAiuRnfC8xiB4ZzcWcMKyrvQWjPAYrJv4ajkCfOrRUXQ2yW527ZyXv3yqbgYN4MUr28dDFMtjbvNDBAdkZ399udbFGdqg4n9fkS/FG0foIP1XouhmVvUp3jb+BFh9gbgHLQO+BNPnHz9MImOiQok86fO++dMpOvhUdfOsQ7Uwa1mE+3Erk8a9LNsQ5q7NAmJxLSrPxk4HfrkmlZe2yHflMqjDvLIA1YLZPUG9QPRsSOkIMhlxIo7dhl2xggS6PdFTfzvs4z8xLtESWTE8X7q2QTtkOGEvtS/m3MGdQ/dkIQNCErvDrzgZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(6512007)(2906002)(38100700002)(6506007)(2616005)(26005)(38350700002)(52116002)(186003)(1076003)(83380400001)(4326008)(66476007)(66946007)(66556008)(8676002)(316002)(6486002)(7416002)(8936002)(54906003)(86362001)(41300700001)(5660300002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D+d1EuSiQez98i61n5CKmVwt8jPFvS3aqD4UYAZUjGMSZhD1Ih6fKIDrwZoT?=
 =?us-ascii?Q?f38m2ZYA0sh4qURwlVITHE2GqSvISPQnXoWsDJHh/aXtBA1+Zau4GATrGlwG?=
 =?us-ascii?Q?tRdQR9cH0HzFMvzYqNQEXVOMx6Au8kRk/48QizUMh6NbE3RmT6Il79yKwK/p?=
 =?us-ascii?Q?BYiQv1rGyttvvAoEXXvAQo4V+yKETk18VQQIyAfxSws2cQeVM3OUHmu36Wdm?=
 =?us-ascii?Q?XPhU+VsZ4SoLrGNRf8oHIDkmPO/uXAOgEB/RDfK06MmYLKK07lo+LDyhZmkc?=
 =?us-ascii?Q?IoanitDSqmtxZ/WFcTonpkxgKZZrzYmekQSYoVM3o60uiTUUN3qgjUzp7HTL?=
 =?us-ascii?Q?EtlMl7JKS2IJzHn4mdR+rWvyEdVj8xJDozDoAqf7xxWUKUYiodv8V2KwzNAL?=
 =?us-ascii?Q?h1AJtJlVvJe4WISZw8DcCc8oHXnvuJiw5uv3vaxuVV9SmHrqMP7cu8fNCl5E?=
 =?us-ascii?Q?6CumBI+2P6MFPTxVp2v/EKe8ZX67AuKEVJyXUIhb1kZCrV1V5jDZUCLqmjqQ?=
 =?us-ascii?Q?IqtEUlvmU8reAOunXBVLwLm2DVwhN9PeOJWmrXLRRj5zOvLm0xAA4YpBKFNs?=
 =?us-ascii?Q?1MAFD9hDqhlelmHSXdWF6Tp6eNHDzr4Qpv6t8Yahs8OluyhnvmUB00FeA24V?=
 =?us-ascii?Q?l7THsgDnhtM5dgkOjYa/LTxxRkeUdHROLyH0eKUfyLK1HqUFFvnqk4Ln/CHO?=
 =?us-ascii?Q?Q3qXCZqMrfO1Z93tcsOZ7dW5fCAfvpNuJOMy5eLH724JoVgG6A1JvzdE/mra?=
 =?us-ascii?Q?qn82aUrJ1ny/itXm0Y2VQs5y2RpEKZN5NN9STsOn4TgxATD+pBkcmePVqfnE?=
 =?us-ascii?Q?k22WiicSHfOlcE4yGm6UL2BO7pCMdKLfnZHYAzOch1DLCP9TclN1zTw1OUD6?=
 =?us-ascii?Q?SsXHe5O4VgMgvSh1hiPic35pcc+1nja6BW3FDx8e821Vwm8VzcMrJr3NF3rn?=
 =?us-ascii?Q?tcm8v1J6sBjwXXiof5y7vZrjweG8dfAErPOle8DY1j279s2XcbW5CxskTtDv?=
 =?us-ascii?Q?Tbd6IgliT5qXbGdZ2zuPUhAGEsDHQ59i2/dpnwOfRUgUqUq5L3G7s6OCKfqG?=
 =?us-ascii?Q?xAmcmpn6WfFjNKJSaS6CyJuysBa14UdFklWqh2/05i+ZcCOI9SdiNy3stlcU?=
 =?us-ascii?Q?+FsS4xBb9RO1v9sDg06dlKjngE04YQijYilgUsTsoAsVeHegtda3pc2Q06jz?=
 =?us-ascii?Q?wHYUycME3wzJZUDpPo894RNiR0Pc9nDM3jtY06m/CSrdO/gut6D0Cfm4Op3M?=
 =?us-ascii?Q?wpLSO27SXEaNlKMvagg0KorKE8AlViL9QzvQ2CiYrrU211ZkDvSsTKCcIE2Y?=
 =?us-ascii?Q?/AUYMb1hsHevc67vabHLC0soB2vhpmnWG+3EnbDd3+6A2SH5clsFcfCD63WR?=
 =?us-ascii?Q?jCfMHmUFUXB3m07EnO8ZpHvKglaJ/imJ8sBcluRenRoD1JDXvmcpFfMW2+Yi?=
 =?us-ascii?Q?MHfISvuBs4N8d1a3ZGdKHif2yC4DDThbRKWKjO5PwCwmFjHBy8dDnMGzFNBM?=
 =?us-ascii?Q?vlVcxWjwEu/y0oYuvs6FdwBM3XfvFkgfLL3FjzPnrml/8byR2+L6+Nn2vFIx?=
 =?us-ascii?Q?nzBz7LTspo1082edkV/3hl8ce+ObwVmZF9PB3RyT?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d342cf-6220-4a48-4f5b-08da8a38002d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 03:30:35.4304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHMT7dRqlPl8LZFXerK2zxgEbUy1DJHaCFC2tcfC1PpA7UKXpTifa7ARPtbJY7yz6ESRSypB01/x+U7bxDtj2g==
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

The clk tree should be as:
bus_aon_root------>\               /--->MU1_B IP
                    -->MU_B gate-->
bus_wakeup_root--->/               \--->MU2_B IP

bus_aon_root------>\               /--->MU1_A IP
                    -->MU_A gate-->
bus_wakeup_root--->/               \--->MU2_A IP

So need use shared count gate. And linux use MU_B,
so set MU_A clk as CLK_IGNORE_UNUSED.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/clk/imx/clk-imx93.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index d9ec4d618f48..51af0b12ff9e 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -28,6 +28,8 @@ enum clk_sel {
 	MAX_SEL
 };
 
+static u32 share_count_mub;
+
 static const char *parent_names[MAX_SEL][4] = {
 	{"osc_24m", "sys_pll_pfd0_div2", "sys_pll_pfd1_div2", "video_pll"},
 	{"osc_24m", "sys_pll_pfd0_div2", "sys_pll_pfd1_div2", "sys_pll_pfd2_div2"},
@@ -159,8 +161,10 @@ static const struct imx93_clk_ccgr {
 	{ IMX93_CLK_WDOG5_GATE,		"wdog5",	"osc_24m",		0x8400, },
 	{ IMX93_CLK_SEMA1_GATE,		"sema1",	"bus_aon_root",		0x8440, },
 	{ IMX93_CLK_SEMA2_GATE,		"sema2",	"bus_wakeup_root",	0x8480, },
-	{ IMX93_CLK_MU_A_GATE,		"mu_a",		"bus_aon_root",		0x84c0, },
-	{ IMX93_CLK_MU_B_GATE,		"mu_b",		"bus_aon_root",		0x8500, },
+	{ IMX93_CLK_MU1_A_GATE,		"mu1_a",	"bus_aon_root",		0x84c0, CLK_IGNORE_UNUSED },
+	{ IMX93_CLK_MU2_A_GATE,		"mu2_a",	"bus_wakeup_root",	0x84c0, CLK_IGNORE_UNUSED },
+	{ IMX93_CLK_MU1_B_GATE,		"mu1_b",	"bus_aon_root",		0x8500, 0, &share_count_mub },
+	{ IMX93_CLK_MU2_B_GATE,		"mu2_b",	"bus_wakeup_root",	0x8500, 0, &share_count_mub },
 	{ IMX93_CLK_EDMA1_GATE,		"edma1",	"m33_root",		0x8540, },
 	{ IMX93_CLK_EDMA2_GATE,		"edma2",	"wakeup_axi_root",	0x8580, },
 	{ IMX93_CLK_FLEXSPI1_GATE,	"flexspi",	"flexspi_root",		0x8640, },
-- 
2.37.1

