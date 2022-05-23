Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5034530F33
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiEWL3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234749AbiEWL3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:29:22 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80077.outbound.protection.outlook.com [40.107.8.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E0C4EF64;
        Mon, 23 May 2022 04:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGVo2fZeOTihEvLHeAQd9TyYR83zA0/r3JkSJM8O3L1YuW7tVQN5PiG3M0ZwxosYZbMbA+fMxGdtcceAVufwZ8MgujYGBcoo0dZS/Q0SpBAO7c6Vm7buG8pYe4ivCdurCvqxfX4ctR8Tzc2ATHeUq38n+5iBo8Dd3qh/Be26gKmwGW+P/Gk1wXV9DoR8yizt0Q/vvKaNowbSQsbcOPGPJp8bcpWi2qP7XPhVKt2b3awEAF+WTuqA2L6lIPxu8/6fkh2YgaCEoofDM6MpbUvszDG0cZkOsyUTIc2NUPkl/VdHeh4kBKUE3adWrUrRAAycll0LuymYrfcKg2KCURmUcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6uIurfmyarc/hTiEj1TvwQU0vA/KH9DEb7Y7Ry3GN/8=;
 b=Tt66ZkKp5yzUoiRJBbyuHaDCbMF4TcJAnUdCCjcac5wApV0qit5wl9FvSpH+mCDlBJKquesHKarbMHziO3iVXYsqQtJesFWMaIJSmUElBMKn4JgUlBb1lAIf+DCZ5nr3wpRMItd+O2rGJnbcU57wLemRHJlpGqiCsEVvwKh8hNnGO1DL//Q4AA1s514bI5zRSgu7u7eCzCDprbOId6bpsNOMb9k4WGH25VFM1Mkx5+QRjsM2m+7+tle68JhoPHeCMIQ/RNPw7yTrNP0eWi3OLTh5YFAztw/M1thvWWQVI+9hdvBNfrc2j6ck0ZjX1I0O4i47eGcU2rljN+8ADepCSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6uIurfmyarc/hTiEj1TvwQU0vA/KH9DEb7Y7Ry3GN/8=;
 b=iPhaujXzUDujVqRVvhlLbYDq3JzYJ9XAkXDIt5q+Pm4OssIdSPB/2e9Uh8yPG2ogTY027EnGnHd1F8IoNn9bHMJwYjmgFL6SAmPkF3u0r58AOfl+gBIJyWvVLphF2nkPDqkEWhy/V44GyESpjpuIBJbskmzEwY5A+2Sfka6xG90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6586.eurprd04.prod.outlook.com (2603:10a6:10:101::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 11:29:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5273.020; Mon, 23 May 2022
 11:29:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 7/7] arm64: dts: imx93: add mediamix blk ctrl node
Date:   Mon, 23 May 2022 19:30:29 +0800
Message-Id: <20220523113029.842753-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523113029.842753-1-peng.fan@oss.nxp.com>
References: <20220523113029.842753-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9144be0c-fc18-41fa-0a88-08da3caf779d
X-MS-TrafficTypeDiagnostic: DB8PR04MB6586:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB658650C781E776B8234AB345C9D49@DB8PR04MB6586.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnO85TMoqFQMZwX2DPqx82h4XnXJK6H+mo8WGqqH9oLrxRwfFxKZ/GCjW2824dE3tCsd6En+ks+qejjeZEj8LKwsZqMmUFAR/9vrRLolP59Dq9ine1Wj0tNx2Ll2aYrq2+Za3NeOzzX/FzzVCYXvlzth6WF2k0sdMpZ/WsdWyWorqYqmXLxbfCsDcjefH8i16HXj0p3PO8RmXF8CI/UCMQZRgqk+HglyH4U8YS6oZSsC+jwm0o8RBad63MltUtlkRo66d+rQePxgdoG0c9kYeagRBu6IH52AqlJNRipnmf0gfKhVR2Mda3iieXomiiaonVPzqe9LUO1Pw4TJQv4dJRdeJ1gSvPyqnZF8lw0/YNwDmFE+ymOb1lrgebjX74AOFEdNJv3gqQTiHG7nCjnjvqRSKopGvbOYgf98QAK5biBtEy0JZ8W/82QlFOGOgHSPvCVqn17GogUOiFDu/Nb/DeKo/KvNHnv9hHbp/IEM9Sc8BXJsLc0n08VWZUBIeO4i0+QtzbILI4GqmIdhqLjmlC3nr1OIC6sjlLxOr61jioA9o3fUZOO5BJDz3qAUgdiYLuyfLGWmleBB0d+zTZO1CF9y81VCdvvH58luq2Mvff1RDID2F+YpFpWvuy2VzCJVsEYgkmDHeYkNSRvhKahhA5R0JFqrtLSLGaUhxIh3bwrxgXjuMnsLh9kkerh4q/lqGPL1/RhvOvVWv5iqJ3U96g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(2906002)(52116002)(6666004)(2616005)(186003)(26005)(66556008)(66476007)(8676002)(4326008)(66946007)(5660300002)(1076003)(508600001)(6486002)(6506007)(6512007)(86362001)(83380400001)(38350700002)(38100700002)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CCYZrgetZjMUmKNtYnM7DS4RK5yJI67Q/lqF81qAg/bbCIsBMXJyAn8osZyd?=
 =?us-ascii?Q?R+EiZyJG45oJGjlU/d45k10/g8z5Z32TxZIm7BEbcC7drRxeZGhkEjS4xf34?=
 =?us-ascii?Q?tWOBp0q4PKz2AzlsqKGcKOgVyNOyhUOa+us+vugA7M4MSF/y1MmtfdGjn/Hb?=
 =?us-ascii?Q?PF5jzVc2M3k1vjqrYBObuUOlvcbJgombiKXksv/hCofL2PfZsBjFrTjKu8Mv?=
 =?us-ascii?Q?tZV8BXfvjjqF4So4f8swnkj8iOpMI36+sJCDD+2vjAfsou58xdOy8ik/pn90?=
 =?us-ascii?Q?w2PC9kknS3v7oIkCVU9XbWqX6ZNbt3597+T1ZejxhZVFqUQavwcXQcG3DvnD?=
 =?us-ascii?Q?9BK3vL1DvJfg2+tHEKD/VTDYVL157tfzRIQkHS2YkiUjtmqL5OaFIeNzEOIp?=
 =?us-ascii?Q?L9V5GGT3N06LZPKFd4isZ/QiQHA4Lyd/MlqK87zf+SylkvruLwVp7vc+Avam?=
 =?us-ascii?Q?LIB0EfvPEaSDe0EpaIAG31gJUsqety4jlypJKuSABCeVV+YVAggDxdsPtjwo?=
 =?us-ascii?Q?beBmphp5H3zKugXV7eBqg2VJ3uMWiohC5ga+L7Nh/jQ4piDKPyvYAhNcuYya?=
 =?us-ascii?Q?4r2IfjQ0rYhA4h3KJP/GeMbBSH11t6fUQFysniN0muwLlRxblfNqJDGTM/Mh?=
 =?us-ascii?Q?UytBXjHC2qd7Kjc5tIlOQH96UWGj71wD/72p/hsf7cqLfs1zbyXcKJ4GC6bU?=
 =?us-ascii?Q?NZD/jR9OfrYM6BytHtbLsws/zEpkM/z0OvnpiYUXUxLYBV9cSDTRQWeIAYpP?=
 =?us-ascii?Q?Ujx2C2LPJvXByiS8PZrknhB5Uwiv+ylbAO3s1LqqfAytyMIYJVLAP5ZKJMJi?=
 =?us-ascii?Q?H1hK08FQphTcVfjdH5wJV0FojWQ3tLcR5WJhH9Rf8rqSosVVmVARZXUyw2qp?=
 =?us-ascii?Q?75Z7MmGuleVBIxZxr9YxGSKBwRRlKAAJFOjaPzylV/hu+iGnevoPqaDGBqsC?=
 =?us-ascii?Q?OSjb/gcr9h43nnuGcvnatf/p3/cTsVx1mZn3fjCE1+6kr9FOHcWfcpZGflgL?=
 =?us-ascii?Q?5ANOvCiHSd40cyfC/KlV5qu4515L70Dn+hyzpw49c0Rs/qYdRvD1JcjkEZ2H?=
 =?us-ascii?Q?FrO59Yx5vnqjWf05ZUNrj1wlUPOIPHC0x6IvlP5SMArScGThgJ9dx9hwjXOL?=
 =?us-ascii?Q?SPkpTjwN4d+t1D229qHS22AD2fDvuzlDjYQCLco03mbu5ED0pAW1JhLhju61?=
 =?us-ascii?Q?DKCebqu2NeSLsKQz0y2U5trxbwujjigFLsoPOhVQf43i3USUOaVmOPIZlXsd?=
 =?us-ascii?Q?sS4sDnR+n4wsLZmsGp/P2SVqYrRjlO2cU4qzQQdBPlgk+8GSLznaTcY1pbH2?=
 =?us-ascii?Q?bk4GOMfPr48fGBlnhWd6pmeK4ycZ3wL4V/soHXb/4nQwRnSkUFLGXagUT+vn?=
 =?us-ascii?Q?CrNxvcP4GkoxxHixLGfs4LXWiiMAcWvisvldC79nFiDVrSLmvFKwX4wrgBi9?=
 =?us-ascii?Q?vST+V/jlt/3CXC9ps6ldulGT7wNVi/yxJKE9rPWYYq9l4FZIKRJSog4wemzK?=
 =?us-ascii?Q?Vq0eXkyh5BwZxmSbHghupiS2EM13FRHjMxOH3aVwfu72FoTrl+1wgvWoe++L?=
 =?us-ascii?Q?XXjvSlNrlEPT0UZF6uEga5XaLaEn2tAtQy0IE2pxvcDORoQpMQX+w6XVnbCO?=
 =?us-ascii?Q?sT/Ynxp0kzOEEBHJHuTRvB+Cjm6atxSbUaAvt0WRBqa9dEVOjePBnVfRk2mF?=
 =?us-ascii?Q?prxjWHmW9hHs3Z6byradwiEsy2SLHnBMpG6b1g4xxi6GVCwBeeUpOU5ywt3L?=
 =?us-ascii?Q?rF4xokQ2Fg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9144be0c-fc18-41fa-0a88-08da3caf779d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 11:29:15.3507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKZNbNuq+dS5QrAvDr0eEo3NeAxpxwOAp/SYy3XLW3KbyANWowqD+B6wRLrlfy/xml35NcBApcCGK8bbqI3p2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6586
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 mediamix blk ctrl node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 85686b684966..454c605303e4 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -348,5 +348,25 @@ gpio1: gpio@47400080 {
 			#interrupt-cells = <2>;
 			gpio-ranges = <&iomuxc 0 0 32>;
 		};
+
+		media_blk_ctrl: blk-ctrl@4ac10000 {
+			compatible = "fsl,imx93-media-blk-ctrl", "syscon";
+			reg = <0x4ac10000 0x10000>;
+			power-domains = <&mediamix>;
+			clocks = <&clk IMX93_CLK_MEDIA_APB>,
+				 <&clk IMX93_CLK_MEDIA_AXI>,
+				 <&clk IMX93_CLK_NIC_MEDIA_GATE>,
+				 <&clk IMX93_CLK_MEDIA_DISP_PIX>,
+				 <&clk IMX93_CLK_CAM_PIX>,
+				 <&clk IMX93_CLK_PXP_GATE>,
+				 <&clk IMX93_CLK_LCDIF_GATE>,
+				 <&clk IMX93_CLK_ISI_GATE>,
+				 <&clk IMX93_CLK_MIPI_CSI_GATE>,
+				 <&clk IMX93_CLK_MIPI_DSI_GATE>;
+			clock-names = "apb", "axi", "nic", "disp", "cam",
+				      "pxp", "lcdif", "isi", "csi", "dsi";
+			#power-domain-cells = <1>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.25.1

