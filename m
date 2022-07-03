Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3EBB564646
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiGCJN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiGCJNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:13:54 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80057.outbound.protection.outlook.com [40.107.8.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB61363A3;
        Sun,  3 Jul 2022 02:13:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=in3WFCBUKYLGKtBzmog1GlsFDLOTw7kMZU6GEFCxeOXZvesI7Y5qUuRFC3kNPHOvjGumKD/eIZtv6lGAWTIMIaetmGqEzU8pv2Egwnl8XW+bzmkhio+ZnaX3vWJiZ4zP9CGMzx55P9/y1F2Dy0IwBcYVu7Xo/DYNM9VpjRBzywKgh810XuYVBF9NzX195Q+6nbLhwC60HtIkcCWTAtRi/lDm7DU6B9Yolk1Wj+IB3YGiG4iwwi81iDn2sYUPOoPBalln+2O+6Q1PlUhikWr8E3OfEJIswI28/r/gAjtECvgAsT41obl4B2hS6IkdUCVGEvYLhfbclgTLKQbdpktFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhrpTevmypPVrzxq67Y2aIcMSCunN+Swy6LAyezdEuI=;
 b=n4NqgnbSqqiAc436VGz+WhaPRm7GDZm3mEzoekfnH8cX5jBvoHAh0MzTdgQ0A1Y1YVGRbGuJG0oN6aCKSkR3S6aJqiFa3SEb24WzNKbCjtC1ZdyC3VzSlNy71LbEVw/PthSJNFVKjI50HfraSI0yrUJj4j6arYpSeRz8lhS8n4zl8+X1fD6VxCchSl/saw5eRHXl3d4a0FpbjIQtErDc9kzBwaBL1pCxIMQci7u8ThKev8hbm0wGrjAfHHJpAsyTfNXfiTqrt5Bxt21RMk1Jl0EtsLG7tSfH4IvjpEHsPcb5kv71gZTH7tZ+pNwKOHqQKenQRbJxiqPBBfuOwSd2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhrpTevmypPVrzxq67Y2aIcMSCunN+Swy6LAyezdEuI=;
 b=DzQ2HrK9ZV+WNNLThix4slHBPCZtQ3nDXKNuF/tEP7kHIjMoCdDjxxN9WlatcNknAloSo7izGNIh6tVGFnOhVemnVXtlJxgs7BgLhQwje/aFQxSs3EopMcukv+YbF95IzzA3+KpGOzSxfpYvmzKRpiDtsWPrcLK5b7FxcT2Rxvs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7768.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Sun, 3 Jul
 2022 09:13:45 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 09:13:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abelvesa@kernel.org,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 6/7] arm64: dts: imx8mp: add interconnects for media blk ctrl
Date:   Sun,  3 Jul 2022 17:14:50 +0800
Message-Id: <20220703091451.1416264-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703091451.1416264-1-peng.fan@oss.nxp.com>
References: <20220703091451.1416264-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d01ef1ca-dbd7-47c6-12c5-08da5cd454b3
X-MS-TrafficTypeDiagnostic: AS8PR04MB7768:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGFmaYRnaEeEf90alDzrnVdkXGqlxZ6rXS6j17nWOAkN0WA66/wnSaJgB02pJX0/t7NKL+4ZbM+gFBnmiYwM1yn4oHXF4KF27+wa7buUzzwJkS0b4PuaqRKx0dIZf6zy78Dntv8iaBjrOmszpV9oHy7aojaOcqeskGA3cZU9LUT8fl4s4uEDkH8cCnXTDySwnQUQ87qWHGs4kYghqTAW5YPgFVSO3U5VLMRNCPak5DGBqyxafcASwhEcdiqbe2Anyn+CpQkOo2oNcYhEzkSlvdBQtb0WdC6gi8aBtBk10vI5dKHZWDbQNh6k4aiU3HxoDTL09ZLryzthBUMcquA10PoXuRkw20SnFlGwr1+5loUIEOtbL7kRcwd0ixXHcIGXMmoEmHRLYpw4GBDp48RirXO5YkBwAdHizFW/uoYXZvTu8ZzThvAP2EU/j5U3Fp1ouPPKuaAK4nOB/99HNMiKIPz7KA9FhZQRrM3axoml76seQfwnq6tfjVB76NfodO+sL+vB2xvvq4Be76v5oyetE2FedcmMCs2aZF0n+un2NdtXSDPPKkik2AzTq5LZVs4dgrv1zZnUYl0xF3E7sctx1GZfmOSTjkVk/k6Lkpz8ak8w47WRQto6KBlzGy9ivBy/6oA39auAPwuTCfqCc2LKV7R0abFyFqFDap8+w5ZsqqG3nKV9B/67pMRSn3k/igz8fJbgwTfXWvJv0DmhIlvBifT4r7aY65TLBH0RhaZBkZj28Dp9CtRtK91lsWqjNpqsjIWVlcVudaPMiTqnoTa854MZkONaIAAti0B6Fst1jd/ghDReUKHg2Fcwj0Hc7qZv4QgrR2vWxuu31HAKZjgl/T2MCIJFULCJgtOqX8G+tQU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(478600001)(5660300002)(8936002)(7416002)(921005)(316002)(86362001)(6486002)(4326008)(8676002)(66476007)(66556008)(66946007)(83380400001)(2616005)(1076003)(186003)(6512007)(26005)(52116002)(2906002)(41300700001)(38100700002)(38350700002)(6506007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YoQD7cC7ILhNco2WZQnhd4ybcM/f/JfrJY9QGnKkse+isdkThmSW0Tgbmcer?=
 =?us-ascii?Q?iVhpl2+zC3bDBDlRnKcQIVVVeX68G3oSpHrJar3qLtuSJl0oKWXHrLR7XyYV?=
 =?us-ascii?Q?mtq+4K/a9RItHN3tGc4vtTotI/YotnB9+6YuqHHWXDgUHBtyC655ACyuabEY?=
 =?us-ascii?Q?d47e6XAuldZEaginPgVyFNJWNUjyLiiPGqFU4bDEz2CfkSzGlGxYA9bxInbj?=
 =?us-ascii?Q?Iexyudw/4FlxMsEwMOoTZ+vGA3HKt97KtMJwUnT0dXUGE5gP67pmcoHYaLMZ?=
 =?us-ascii?Q?nG0dp4+hYpFsO+uU7lueda+lQBHs9gKJPaslD4uOAj54z3IssKkyVr5JrsGr?=
 =?us-ascii?Q?il8lnwoX/k+y3jIzebrejK9EyN/ne3VdsLG7RXetA+N3oMaocSFq6iUjv2AN?=
 =?us-ascii?Q?LBNx43JGmma0DiYDNdr7K7HO7HNL+ycqXI/n1rraYggjQb6XcIPF8h3YEtRk?=
 =?us-ascii?Q?RLJ69A12x5cYlHnCd1KKSPO3GIlRAmGZv+XDmoWib8MvgfjECQsSNRZ9K6oZ?=
 =?us-ascii?Q?8HY2XXWK86qQlaYNgcMTpMyabZ/zxQ2GNOS26M5hqIiHMxq4keXoi/3K+uu4?=
 =?us-ascii?Q?i4JkfOOgE+jlBX+cb/YKNwh2xg/FTCot/MXSy1znbql0k+EpE/zVuCChIrUj?=
 =?us-ascii?Q?oUmDd6rKoCnWG/7armU8GP5IqjU8IXRQoGjGJ56AyepiJLpSBFaiQUNskFwC?=
 =?us-ascii?Q?Pn1L0BZ2EE4AZw6rmp7wEM7unBUTB4lRvE/yP0eaYC+VUcWibEaqUL657Rzo?=
 =?us-ascii?Q?XGd3uytIwxE8E2dezEtb1buJwjexzRlFUPthYeMUwRu8qLEnP8OY9eCUHcNJ?=
 =?us-ascii?Q?rVWqBBulh7yD3F5/ltQWUPkNgmym6d7RlNHPxhJGkgGjX0yub3IBPkXRuUpm?=
 =?us-ascii?Q?aFHcYcR42cS17gfjUP7iicxozNcTVQkRndxjZqTKkTQ3kmPfTmYtzc4XFdhz?=
 =?us-ascii?Q?f/y1F8VbWYGb4GzPHGwxcN67JOQ2cxFTJyu0WotRF3uU7qO24YcDWuj9B2qv?=
 =?us-ascii?Q?bXMzEj8HIUSflwfa8Ubu2eL41l3jGfa8NvAFAoNYhz/ejGuT+tHrooIM75Hg?=
 =?us-ascii?Q?1VmszRE3/82bT0gksV2ay9w7HqTpvicg+R1t1FMqNhv0gLYcJ0zSe0IN+PaG?=
 =?us-ascii?Q?aXTckrabdvH+4TrRn3tS8P2W0INb846jMaZEHZnhTm7K3/jUde12uRu1oZ2L?=
 =?us-ascii?Q?PK4scNyCavjv6bfxXnKIX3TytJ3XkbMZOoVhI4WRC6Xp5uowsK/NE53h/E3T?=
 =?us-ascii?Q?JwOK5ERPwMYgJqHtDWYOlDq+4SVTCpVV0e8p+MRs9sx1OlnGrz2LvRWAVggU?=
 =?us-ascii?Q?nM3lxLaTzaW+MFVgsilZzPS9oTNoeElnXs1IomES92/D9lErLX6W6CyO8XSc?=
 =?us-ascii?Q?s84vgPEqhG4zSk3u/0peojE8GDRa+sERPAEsVamy34I164b6Mg7ohRq5ZkaT?=
 =?us-ascii?Q?Ew7zBLOeYEIiDAM61XphZbnbmqGysHqPaQZcLYkynJbJuPhA9xZnCAmF+xpf?=
 =?us-ascii?Q?jfa20ZazNb1ZmHbR3dYyey3ktC9MZauZBgQQ5ZocMTCF+Tt/ui6B9xlP4BLh?=
 =?us-ascii?Q?btm10lPEZhtckziThjuSb7Ad2vWgJHVkpfyYd9lx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01ef1ca-dbd7-47c6-12c5-08da5cd454b3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 09:13:45.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HhOTKOuOgd7FMuBKBFFObXvTvWzBb6ferKePsKf6FL0KafKkgO2fvIG6+zf9rYPgWJADAyLBMu+HbGqulyPcBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7768
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add interconnect property for media blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 13a2ee77d3c6..08bd57742294 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1066,6 +1066,18 @@ media_blk_ctrl: blk-ctrl@32ec0000 {
 						     "lcdif1", "isi", "mipi-csi2",
 						     "lcdif2", "isp", "dwe",
 						     "mipi-dsi2";
+				interconnects =
+					<&noc IMX8MP_ICM_LCDIF_RD &noc IMX8MP_ICN_MEDIA>,
+					<&noc IMX8MP_ICM_LCDIF_WR &noc IMX8MP_ICN_MEDIA>,
+					<&noc IMX8MP_ICM_ISI0 &noc IMX8MP_ICN_MEDIA>,
+					<&noc IMX8MP_ICM_ISI1 &noc IMX8MP_ICN_MEDIA>,
+					<&noc IMX8MP_ICM_ISI2 &noc IMX8MP_ICN_MEDIA>,
+					<&noc IMX8MP_ICM_ISP0 &noc IMX8MP_ICN_MEDIA>,
+					<&noc IMX8MP_ICM_ISP1 &noc IMX8MP_ICN_MEDIA>,
+					<&noc IMX8MP_ICM_DWE &noc IMX8MP_ICN_MEDIA>;
+				interconnect-names = "lcdif-rd", "lcdif-wr", "isi0",
+						     "isi1", "isi2", "isp0", "isp1",
+						     "dwe";
 				clocks = <&clk IMX8MP_CLK_MEDIA_APB_ROOT>,
 					 <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>,
 					 <&clk IMX8MP_CLK_MEDIA_CAM1_PIX_ROOT>,
-- 
2.25.1

