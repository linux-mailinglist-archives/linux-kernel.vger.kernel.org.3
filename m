Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179604C3FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbiBYIQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbiBYIQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:16:26 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150042.outbound.protection.outlook.com [40.107.15.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160411D6F61;
        Fri, 25 Feb 2022 00:15:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CE2ey7K4IH2a48FKgLtuNLqFO9V+kp73qUtHsjom9RhImQL7WZ7d6UaWaHvPlFjbrvU8k24mRP66umnXA+FPdoCOoMyJd32aWgXWsKNwOeMFPjcGXNfY2e4ZA1KPEvzPyKJbx7j9bZCu45FbPoz3L4C7qK6+w7M8OyCOrghLA2z96D3ZMySYI4n9b2bO2kQ8fHrtjvoh4Pipu0c67xZ4lg2RFAHOS2yzNPiw802UN1wYLY8SJMXRmKFBtFGvb7EJfhnvMdJwaHWQ8PynFEeX+w/mhA0ciQIm62HLpifrQDuUn5YMnnOG9Bn/FC6/tW/Kt4H043bpasdh4TBKkb/bMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrrxtZ7gb9DxGJyAyYhNWmR+/U6C6g9Uu7FNLO7JnJ4=;
 b=iujeKtKfTKFiuk6AKvaPo8oDg30qkk2Mxzrwzo/gv8oTFzJ/g5RS77c8fURWLRkaYBnSIc6r+AAUjsp69Pr33pX3wE934EDWsN9Q3V7jgxF10G+Ns6fTrbk0fnT0fRwixFHp46NpOQUNWtu11JJNh0kb9uPCbI88MaU/ax7HhrEiGq/qLpApwhZx/cYahvPZPZNiev4pOYu/NuZcuwX5S/IibvCnTblthlx06uLe1OTg3jDMKIToVArqoOc2ALlMt6ZZkY4y/POruIu3b5QqHami9nwOVb7RK3pwjPsEnzC1afZpfyQY8GYooweuPVbokKvrMtrIWDIsflxavrgf2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrrxtZ7gb9DxGJyAyYhNWmR+/U6C6g9Uu7FNLO7JnJ4=;
 b=KgLBEOxhWoaUbMFtXHdEYNUHnceYnkSYLj9JIpolVdLf/mHEZ+2tmRLZ8l5n8i2kkP0EM86qOcIxotcBilJqdaY9evZqxWTDBgwrMbiqmLus7NgNLnbGRKhYvPYNC7PtL/gv2aMUU7FlYZoULVW0mYt4wP0IqlzeMIIKUnbW9f0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5419.eurprd04.prod.outlook.com (2603:10a6:10:88::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 08:15:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Fri, 25 Feb 2022
 08:15:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/3] clk: imx8mn: remove SYS PLL 1/2 clock gates
Date:   Fri, 25 Feb 2022 16:17:32 +0800
Message-Id: <20220225081733.2294166-3-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9b8d1e54-bd2e-4056-7c2e-08d9f837091f
X-MS-TrafficTypeDiagnostic: DB7PR04MB5419:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB5419562717FCE508A59094DFC93E9@DB7PR04MB5419.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: amcVdCtjq+o0TN1nmopwhtDuaIVe9C13ADaM8WRAnnvnLgjeey/dVNDcG1CiDn42KXd0J/Vd+WOvD7/2Jil3sY5PU1GjAK7c9+F1E3Hv4efzbOaZwqSY/6HeF9Im7XUpIn4BwA/6vPYozEFT48iwjnWgPg5vkcDIMmLfrYYiMK6XtN/fpHmpsKgqJQO7MxjiveC2M58VEdisMQg/rI4RMnP9xXwfZN3qC3NWwGg5gxOVXOZc6pMlfAY1bZf4u4krhp5wKL8ZKUcq3cIG2+VrnzGvgDy01DnDvWGo1W+NJUrg0N+ti89hPakLqCqyMWQcVFHFTQA/kNLivnYc/OtgMhba7zZRWA++bMiVREkXh0kMmqsHrykou4Pn3TKaA15qqfYUbDeV4/uwwRSJhyG6MAlh18J0uBVmt4laM5MuKhmjl8xZQNEz2Sw+JCFtQ4sitZgG/04CI4dekkilRVklhFpEqNJEKTlJywgc9Z86WmMYTmWBn9yrrOZsbepOxkecARvbJZHxXNu21xSoKA3Vam3ebsoaDLVpSCZf9Dd3nFV6b3DYpCQmfwpFVjkfLZwOxlNTYwwxQyuJ2lGdwjgWUX+Ut5KnOg+WMtBUExSsrysHl+tlx3ccY59/wN+Ufkh+Vk/9xGclUUfyt/Rb6vx1mmIEskAksgEeuseVo/iiAoONSOFx9BQLMHpfhM16vRLQXjKa9I2O7X0JynwlGZ6Z8jCwpLUIOZWt0G0aAKGZLpg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(1076003)(6666004)(7416002)(26005)(83380400001)(5660300002)(186003)(8676002)(6486002)(4326008)(66946007)(66556008)(66476007)(38100700002)(38350700002)(508600001)(2616005)(316002)(6512007)(2906002)(8936002)(6506007)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TJZG8NfYVdyy/TBoTI3DOwZjTeGmGYSVW0Z525U8C+Y0s+RBImcZynQokts+?=
 =?us-ascii?Q?pWaX4kza97v1M5QN4CM+C10I+/vFuCXfK5aIQX+tDrz7oBHNCFyg/2UdHb/N?=
 =?us-ascii?Q?EOyCwS4aedfbRTw/2emP1DLkvm7tNqwY6oLWl+NmbVy4O0lrk+SX5v10qyCK?=
 =?us-ascii?Q?W48eS5mLINB6KLSgr1vkmgwuDK5wYkd3szE5pHT5AcO4GCiaDLoqAS/71aw9?=
 =?us-ascii?Q?RyEz0tt+7VVGEx2hdOjiXZ4tXJu74tI9Ep4pqLFqpXQlE0t13xx/20lShFMV?=
 =?us-ascii?Q?DCtvlMcdML8ruF5VRlxHs0V/Vbmxa5BWKFdm7RKCaNyuMea/oB1hENI/iIoR?=
 =?us-ascii?Q?IOUsuQUOgRSVgO81fd5+ceaCAUSvNde2/dZ9YDevfF1rYgnqZeopOacsH1H4?=
 =?us-ascii?Q?5tcMy8EMpiqVUdtif/WIYZ7cx4O8PACVMws4WD+tKM4/K+Av8R2uxphxMpLf?=
 =?us-ascii?Q?haE6kzda78vm49WbCzWU1J+/Z/i99C104hmenH7WLANepkXYz6F8nvgKt4B0?=
 =?us-ascii?Q?WaMUKuq8mvvvD/inzeTaxYegqvY192yWEIWfNtSNQTKcM/kKctEd1v8emTGV?=
 =?us-ascii?Q?t6laMJ4C5hr5FSxUCoR2K9reKkwsSplRMp1q04DSeL6mU0PKBtW1oU6cT18f?=
 =?us-ascii?Q?qVfRll+CVxBOM60lutE9z6wjQl0p3v4DDwEEt+mxiCz0Ks3WWoUFIQYlps/a?=
 =?us-ascii?Q?SMprlpvYK++47IDnWEb+mvf5TQ5oadYKIQguNK/rc69C+7lnSLcVhsP8GMOK?=
 =?us-ascii?Q?KWFPPFCJfOW+7b/uh2YkCCvgqJ9FZcdwTo5p1xEPnR6k3v+lnSzQWyzGs2NU?=
 =?us-ascii?Q?YMAYD9m1ybwezJZEquAxV3u2w8b56sCrEaAmiUzYOINi5xjZBPFw8jex2CeK?=
 =?us-ascii?Q?o0ycEMchMurbu8aeKa1TE+1wdtYE7XHqdp/xVFHGgSwxAfaYYnqpZWe7+Ex2?=
 =?us-ascii?Q?ZhisDCdDca4DMsRYoNkDL3hKaM43qHbXi+ywqbi11qLxjOzxaTRNGgtV0JW2?=
 =?us-ascii?Q?zoJUTCPyYFYfSQMYxOewSBRNF6/vJP4j13/gyoclwY3bCd4eVgS2k1ePDikw?=
 =?us-ascii?Q?Xr7RivjpzAXYJi0K+5qdXoap6+wcjOLuXNtcWkBn1dYB2ApADVogIMATtgKn?=
 =?us-ascii?Q?hkeZkmGBfCRJrr9pmRzJwNk2uT3aePrqJEWoRTThoXhhIN5WkdP4gfXlu25s?=
 =?us-ascii?Q?vokZ+TekFQKq5D1G1nWziogmtP4t63GgNYppM/Xaet+mScs1WBXQmSSM0NxG?=
 =?us-ascii?Q?8eB6k3DkdsObi+/TF5jDeXC7BBNajixmAaggJ8UB9bB7TmiBOKZ1KdiwlH6D?=
 =?us-ascii?Q?28qG57TgHchsSVN5ipBLvD1Lbpito3XYa9IVJeosFuWObrd2RvacwA1xhkgi?=
 =?us-ascii?Q?P0+HvyTPKwByf0CbmH6eZNerZHUuPurXZZGrwQ6WBc1Z/PD8cy2ueBNP3kjr?=
 =?us-ascii?Q?XHzp2YRyawB2tmtvAAzB0ajhROn/sxVLSLKneamDyzzyZTXA5JlNeDR5aGcb?=
 =?us-ascii?Q?SeUg5MY7cqpNqbs7sRFnb4b6GuTPDzdO41CkNV11yeh4P2V1LbFD0J05TEGk?=
 =?us-ascii?Q?iG9WUdsHIz1ztwpB35wPn8/iZVXhuK779HSahGmWwvq+09FY6c8UUg9jjPFU?=
 =?us-ascii?Q?BGjNWeOIQUjFcCdljNYzmDQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8d1e54-bd2e-4056-7c2e-08d9f837091f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 08:15:51.1771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuWGqqNpRnc9kpoDtyLfD1o7Iu94/VnFtV7SXXNfcpFzbDxxDpCRIJpu9EgA9poxJyfxXI7aZ5CicpI5HQWyqQ==
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
 drivers/clk/imx/clk-imx8mn.c | 50 ++++++++++++------------------------
 1 file changed, 16 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 021355a24708..92fcbab4f5be 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -364,45 +364,27 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MN_SYS_PLL3_OUT] = imx_clk_hw_gate("sys_pll3_out", "sys_pll3_bypass", base + 0x114, 11);
 
 	/* SYS PLL1 fixed output */
-	hws[IMX8MN_SYS_PLL1_40M_CG] = imx_clk_hw_gate("sys_pll1_40m_cg", "sys_pll1", base + 0x94, 27);
-	hws[IMX8MN_SYS_PLL1_80M_CG] = imx_clk_hw_gate("sys_pll1_80m_cg", "sys_pll1", base + 0x94, 25);
-	hws[IMX8MN_SYS_PLL1_100M_CG] = imx_clk_hw_gate("sys_pll1_100m_cg", "sys_pll1", base + 0x94, 23);
-	hws[IMX8MN_SYS_PLL1_133M_CG] = imx_clk_hw_gate("sys_pll1_133m_cg", "sys_pll1", base + 0x94, 21);
-	hws[IMX8MN_SYS_PLL1_160M_CG] = imx_clk_hw_gate("sys_pll1_160m_cg", "sys_pll1", base + 0x94, 19);
-	hws[IMX8MN_SYS_PLL1_200M_CG] = imx_clk_hw_gate("sys_pll1_200m_cg", "sys_pll1", base + 0x94, 17);
-	hws[IMX8MN_SYS_PLL1_266M_CG] = imx_clk_hw_gate("sys_pll1_266m_cg", "sys_pll1", base + 0x94, 15);
-	hws[IMX8MN_SYS_PLL1_400M_CG] = imx_clk_hw_gate("sys_pll1_400m_cg", "sys_pll1", base + 0x94, 13);
 	hws[IMX8MN_SYS_PLL1_OUT] = imx_clk_hw_gate("sys_pll1_out", "sys_pll1", base + 0x94, 11);
-
-	hws[IMX8MN_SYS_PLL1_40M] = imx_clk_hw_fixed_factor("sys_pll1_40m", "sys_pll1_40m_cg", 1, 20);
-	hws[IMX8MN_SYS_PLL1_80M] = imx_clk_hw_fixed_factor("sys_pll1_80m", "sys_pll1_80m_cg", 1, 10);
-	hws[IMX8MN_SYS_PLL1_100M] = imx_clk_hw_fixed_factor("sys_pll1_100m", "sys_pll1_100m_cg", 1, 8);
-	hws[IMX8MN_SYS_PLL1_133M] = imx_clk_hw_fixed_factor("sys_pll1_133m", "sys_pll1_133m_cg", 1, 6);
-	hws[IMX8MN_SYS_PLL1_160M] = imx_clk_hw_fixed_factor("sys_pll1_160m", "sys_pll1_160m_cg", 1, 5);
-	hws[IMX8MN_SYS_PLL1_200M] = imx_clk_hw_fixed_factor("sys_pll1_200m", "sys_pll1_200m_cg", 1, 4);
-	hws[IMX8MN_SYS_PLL1_266M] = imx_clk_hw_fixed_factor("sys_pll1_266m", "sys_pll1_266m_cg", 1, 3);
-	hws[IMX8MN_SYS_PLL1_400M] = imx_clk_hw_fixed_factor("sys_pll1_400m", "sys_pll1_400m_cg", 1, 2);
+	hws[IMX8MN_SYS_PLL1_40M] = imx_clk_hw_fixed_factor("sys_pll1_40m", "sys_pll1_out", 1, 20);
+	hws[IMX8MN_SYS_PLL1_80M] = imx_clk_hw_fixed_factor("sys_pll1_80m", "sys_pll1_out", 1, 10);
+	hws[IMX8MN_SYS_PLL1_100M] = imx_clk_hw_fixed_factor("sys_pll1_100m", "sys_pll1_out", 1, 8);
+	hws[IMX8MN_SYS_PLL1_133M] = imx_clk_hw_fixed_factor("sys_pll1_133m", "sys_pll1_out", 1, 6);
+	hws[IMX8MN_SYS_PLL1_160M] = imx_clk_hw_fixed_factor("sys_pll1_160m", "sys_pll1_out", 1, 5);
+	hws[IMX8MN_SYS_PLL1_200M] = imx_clk_hw_fixed_factor("sys_pll1_200m", "sys_pll1_out", 1, 4);
+	hws[IMX8MN_SYS_PLL1_266M] = imx_clk_hw_fixed_factor("sys_pll1_266m", "sys_pll1_out", 1, 3);
+	hws[IMX8MN_SYS_PLL1_400M] = imx_clk_hw_fixed_factor("sys_pll1_400m", "sys_pll1_out", 1, 2);
 	hws[IMX8MN_SYS_PLL1_800M] = imx_clk_hw_fixed_factor("sys_pll1_800m", "sys_pll1_out", 1, 1);
 
 	/* SYS PLL2 fixed output */
-	hws[IMX8MN_SYS_PLL2_50M_CG] = imx_clk_hw_gate("sys_pll2_50m_cg", "sys_pll2", base + 0x104, 27);
-	hws[IMX8MN_SYS_PLL2_100M_CG] = imx_clk_hw_gate("sys_pll2_100m_cg", "sys_pll2", base + 0x104, 25);
-	hws[IMX8MN_SYS_PLL2_125M_CG] = imx_clk_hw_gate("sys_pll2_125m_cg", "sys_pll2", base + 0x104, 23);
-	hws[IMX8MN_SYS_PLL2_166M_CG] = imx_clk_hw_gate("sys_pll2_166m_cg", "sys_pll2", base + 0x104, 21);
-	hws[IMX8MN_SYS_PLL2_200M_CG] = imx_clk_hw_gate("sys_pll2_200m_cg", "sys_pll2", base + 0x104, 19);
-	hws[IMX8MN_SYS_PLL2_250M_CG] = imx_clk_hw_gate("sys_pll2_250m_cg", "sys_pll2", base + 0x104, 17);
-	hws[IMX8MN_SYS_PLL2_333M_CG] = imx_clk_hw_gate("sys_pll2_333m_cg", "sys_pll2", base + 0x104, 15);
-	hws[IMX8MN_SYS_PLL2_500M_CG] = imx_clk_hw_gate("sys_pll2_500m_cg", "sys_pll2", base + 0x104, 13);
 	hws[IMX8MN_SYS_PLL2_OUT] = imx_clk_hw_gate("sys_pll2_out", "sys_pll2", base + 0x104, 11);
-
-	hws[IMX8MN_SYS_PLL2_50M] = imx_clk_hw_fixed_factor("sys_pll2_50m", "sys_pll2_50m_cg", 1, 20);
-	hws[IMX8MN_SYS_PLL2_100M] = imx_clk_hw_fixed_factor("sys_pll2_100m", "sys_pll2_100m_cg", 1, 10);
-	hws[IMX8MN_SYS_PLL2_125M] = imx_clk_hw_fixed_factor("sys_pll2_125m", "sys_pll2_125m_cg", 1, 8);
-	hws[IMX8MN_SYS_PLL2_166M] = imx_clk_hw_fixed_factor("sys_pll2_166m", "sys_pll2_166m_cg", 1, 6);
-	hws[IMX8MN_SYS_PLL2_200M] = imx_clk_hw_fixed_factor("sys_pll2_200m", "sys_pll2_200m_cg", 1, 5);
-	hws[IMX8MN_SYS_PLL2_250M] = imx_clk_hw_fixed_factor("sys_pll2_250m", "sys_pll2_250m_cg", 1, 4);
-	hws[IMX8MN_SYS_PLL2_333M] = imx_clk_hw_fixed_factor("sys_pll2_333m", "sys_pll2_333m_cg", 1, 3);
-	hws[IMX8MN_SYS_PLL2_500M] = imx_clk_hw_fixed_factor("sys_pll2_500m", "sys_pll2_500m_cg", 1, 2);
+	hws[IMX8MN_SYS_PLL2_50M] = imx_clk_hw_fixed_factor("sys_pll2_50m", "sys_pll2_out", 1, 20);
+	hws[IMX8MN_SYS_PLL2_100M] = imx_clk_hw_fixed_factor("sys_pll2_100m", "sys_pll2_out", 1, 10);
+	hws[IMX8MN_SYS_PLL2_125M] = imx_clk_hw_fixed_factor("sys_pll2_125m", "sys_pll2_out", 1, 8);
+	hws[IMX8MN_SYS_PLL2_166M] = imx_clk_hw_fixed_factor("sys_pll2_166m", "sys_pll2_out", 1, 6);
+	hws[IMX8MN_SYS_PLL2_200M] = imx_clk_hw_fixed_factor("sys_pll2_200m", "sys_pll2_out", 1, 5);
+	hws[IMX8MN_SYS_PLL2_250M] = imx_clk_hw_fixed_factor("sys_pll2_250m", "sys_pll2_out", 1, 4);
+	hws[IMX8MN_SYS_PLL2_333M] = imx_clk_hw_fixed_factor("sys_pll2_333m", "sys_pll2_out", 1, 3);
+	hws[IMX8MN_SYS_PLL2_500M] = imx_clk_hw_fixed_factor("sys_pll2_500m", "sys_pll2_out", 1, 2);
 	hws[IMX8MN_SYS_PLL2_1000M] = imx_clk_hw_fixed_factor("sys_pll2_1000m", "sys_pll2_out", 1, 1);
 
 	hws[IMX8MN_CLK_CLKOUT1_SEL] = imx_clk_hw_mux2("clkout1_sel", base + 0x128, 4, 4, clkout_sels, ARRAY_SIZE(clkout_sels));
-- 
2.25.1

