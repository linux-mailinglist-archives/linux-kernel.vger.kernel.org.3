Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D67A5542CD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351125AbiFVGOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352412AbiFVGNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:13:51 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80057.outbound.protection.outlook.com [40.107.8.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD7C11F;
        Tue, 21 Jun 2022 23:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOdKL4qEjbqe5NCBdxJcBpfR7hyIwa5iNKkQeuFGuhp8z7dnS5xrk8Lq+4HR06uq0Ih8vYw2DvGnpbL43vh+Y8xoUQmc0QpIazQwOp1x68DYf0igfbHQwsJUHJdxHogfDjWr9LsXzGACy/t9PavMOvTbSTyKBJQjvm8JezNXlFQdebMVvNmhPhGYWvMNv7D5D3+MRQiACxXmwQ66bJRWA//sMul3sQYy/hB30uHCviaqcEm76cmc5HglwVWAVgNqtVQdBUN3qQy9siAS/jrqPPzb+VS1njZzBe19zP55/Qv5Bc9DvAkby2P5VmadVNsutflH42quZdjaLycHLe/+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hg/JHi03ns/vnsCLxp2umjStbjMW5GFN/oxlFLog8CI=;
 b=loSN4AW6w7DiAGUqkJa+j7tLfjUjKFX9SBrqFGrWgCV4iVYFW7zueN5C2lSsTsnYBGELmjE2OoZ5/6o26WbSZCGXUX6x6XX2j+/mMH1wJZKgiKj8c3KFa3Av6tM4muVBQEMi6USSNittfivJ7anTihMJfcL/a3U1BPUGN4NsqGURusFRL2WFDIntW/hROhWOo5b09cOSs4J0LcF2lH3h1rCGDy+LwjGxJln0IjQbiai773YCeqbUxK/ry1V9H/aE3+wumuHb4UsNzQenkh/WI/zggqzAeGAss+PlXIkLPZmo6xk7ZwFt1fct1ADa9EWpNLTc9DhasQ4W2oKDK6uhvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hg/JHi03ns/vnsCLxp2umjStbjMW5GFN/oxlFLog8CI=;
 b=NRn+zRuUWwWCfVexhWllK2k+DV6FeSC/ur1+3VklHWEi0WXLwG7BzKClEdSIOC0rm0zPbyO9ZcUt/jWZq9uC4iKJoWI9eIZFj79X8KP20Wm4ps/8ZhibXs/S+Z45yxs8+nx8V4SGV8/g7o3iKqXPQ6GRuOrFBi6+1TWbrQUTnI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 06:13:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 06:13:45 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com, hvilleneuve@dimonoff.com,
        l.stach@pengutronix.de, abbaraju.manojsai@amarulasolutions.com,
        jagan@amarulasolutions.com, matteo.lisi@engicam.com,
        tharvey@gateworks.com, t.remmet@phytec.de,
        u.kleine-koenig@pengutronix.de, t.remmet@phytec.deh,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 13/14] arm64: dts: imx8mp-phyboard-pollux-rdk: correct i2c2 & mmc settings
Date:   Wed, 22 Jun 2022 14:14:09 +0800
Message-Id: <20220622061410.853301-14-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220622061410.853301-1-peng.fan@oss.nxp.com>
References: <20220622061410.853301-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0961216-2d59-450c-d9b2-08da54165d44
X-MS-TrafficTypeDiagnostic: AM6PR04MB5623:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <AM6PR04MB5623A7A097DEEAB7EE6AD867C9B29@AM6PR04MB5623.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jY8Dl7k1c4Dsm0HhFFlckz6ZtXp6iwXWhfNHUvuvCSe5KuBaJj7zlt/UTUy5AMzg+nQa3oXZhzQgNelsrlvZv73GZo9toP5k5Yi/x2nd//MmUw1/+/LFYBJdHZCaEYjlOw8lV2fyDzDaB4xLjleFVg8Z5MAlw9e3PtECdKrfXlP6YjMT80Yvp7pD1tlPJGPKCZFVxliTg01pvK1aYDghT0hoKucSWScpl599Mk2Ju/VZZqy1KdmVCJemtg3vClxTktZHxcHDIr+SA98HQSGlm519lfylm94qkD/Aep49LhquQ0Lkfxge1i9w/Wpbbv9Ix5lt6fjXr7JVpxexrOb0luo5x2KmWryG6IeQA+3qhQbNvIhVHGNK/e+Qk9s6SEFIQqEsncyZSSzIyVE2yZ2+nlogjfhUUISSA0xRQ9uXYr64a+kBMfrNpg6NpkCb56LsS/cYzvCTja4/STkKB38rDafHFO+qXTNLlF+HfR/84xJ2NJYC8tixlENNmS1CnKVtjud4fp/8SisfEzEm7LzAkODNVl/yMn4R8XbemJcORXxJMPrKKs1Z6EZgoYyUiaEaKw9iCf3vABrn7CYd4W+nEDQtW0u8emvtPgMS6ujGDkDzlShHr8mpLVfXUbCja8FP3bhfiAd8MT7lgEzPnJ2pvLqlq/VrAk67MZlIcNU4svL6T82GdRfJxzqmL5n8kMFVvmOJAuXov7kZ/EXg0gESLNK+V45cNS6R1w7VCKFq7/ZxEswAKb5pOdJhxvBQnuhloxgTpdtUrSx6Sx8lfu9kOU82eYzA6JUA89V5XwXdrY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(6512007)(66946007)(4326008)(6666004)(66556008)(8676002)(86362001)(316002)(6506007)(52116002)(66476007)(26005)(6486002)(478600001)(1076003)(38100700002)(2616005)(8936002)(41300700001)(38350700002)(186003)(5660300002)(2906002)(83380400001)(7416002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MvqfX9mePkP10Jtac1wB3TL1CuCB/ls26YX0WJ/LOQfswFIq7fImcSKlYOdX?=
 =?us-ascii?Q?zt7SxPrVw+vkUjWr39Y4mDd84R2V7ExBQnmlobft/BHHD5g6G7regaAmqg36?=
 =?us-ascii?Q?O56b5kZmlG8ckoZ4QcwbQNfvbLiffSxZdMKVg5KCZZiOKAjnkyz7PICxL4+7?=
 =?us-ascii?Q?dw/chU0AMAjeWTbFkwvYnKfDjqSJl/V5ym2VFG7LhShHbi/jamM+jg21z+eD?=
 =?us-ascii?Q?2y9AWOcb4iLBgBaNQvXfM0Ipy17j2Ql1sx+iNrpJleSNpsMvP+lWKnBKNX+R?=
 =?us-ascii?Q?x3jN0eGAM4xFy8XEDsOoAoNvr0EleJj2Ca07dzQuo/0B6nZra0FHrULaXMuI?=
 =?us-ascii?Q?8XUDfUgqE5q01+4a92SBmqR6kNyXcuwAwXwFZF0fft9KL0Q4n4JLkBwgZF+i?=
 =?us-ascii?Q?O2X2gt+FVqfWx7XJYFPJ9Ldc3jv8a+4IgGdiBzNeC/+gDU5+Z3O5V+woXOW7?=
 =?us-ascii?Q?/ICNuyJF5z0TC2E6TrdxHPrQBkG/GtZJPV0n0gDoLhFz2V6eqT2kpIp26box?=
 =?us-ascii?Q?Hw/FI4RRQlacFKrC9A0q6SDFgK0eFOmLh6jAe40JHdFx87hEURFxF8r/d8RP?=
 =?us-ascii?Q?hFORV7q68FgySdU3btAaPa8OuT9uQX9tEKJvFdyso3eogwod4jEti1Q7Le4G?=
 =?us-ascii?Q?JTKZbpvsGXpQlfrA6s0KCI1yfId/7pZD8flAkZXBAVkcnVYvcgLOjPsqSe/k?=
 =?us-ascii?Q?gV8ZSMTFT5JycJd4YGcXevEO8vPlEtwwbuJ5Il+TGmcuGCGSKmqK9Cl/qONk?=
 =?us-ascii?Q?hxY8gPUjS3B1heH2WGnjxLfXe/pFDlKZBxGTQ2xio5heFfshvtW/wLLEcejz?=
 =?us-ascii?Q?EfUS2jsJcxbL1uF0uyyHOfPTY+MYDWlxdUNvX6IaGckxwmxNJYC0HmVsF4Mi?=
 =?us-ascii?Q?rbS41BxImAnIDohZNPMDxmo7ysHfYbpP7f20CRaxlgOLQ+pZx5CfmEZg1qWu?=
 =?us-ascii?Q?i4N9Xg3tigY8dnn+4oy+CzJD7+z3/ISiHhc+0a1Fd2MpD4tK6sRgooVuaVin?=
 =?us-ascii?Q?hwYU2YPwptHpgKYjN9sNIZI7DFkt8SFRY6G/x4LTn+SxYLQbXiG5KbZ+odLT?=
 =?us-ascii?Q?d3XWx+kdlaeI7VYysIYDxG8AVY6pPoaNy2puznvBRPVMI3oDD29AnFFrE8FI?=
 =?us-ascii?Q?0tm48JxV396oR189WlKf9tPCa85LOd9AU2hYCJ1GQolWl++xIhnWPMGc4Drs?=
 =?us-ascii?Q?2ciC9Ua7Ab0cy8qSGNNL07LmBkJkBTwizKAhXci6mjWc1v3y+VZgmwP24ZPy?=
 =?us-ascii?Q?CnxFU4dnmZNk1gqmN/mBB+6FRzRtmgIRtT/HwrNLExPWBnUHrIjGC+tRvhCg?=
 =?us-ascii?Q?TjhSfCsMJYjpqUb+8Fdg1QVvgVDe+QrrQOMAURgeW+BBbTFdIxCCbxDNzX9r?=
 =?us-ascii?Q?lfxYh1FFopCjTuERGTQMaV1M/ERyy6Vb4WLlVMjDSc/yxEiN5ltdKT/Kf95A?=
 =?us-ascii?Q?yYChOpnaJ8SuS5CjU9CoCNHETkmNsUw/Dl2QO33e9kB0dnkkLGfOUsAsSdcj?=
 =?us-ascii?Q?4sMBGXkItIYlBCaz8ON6rnwIux8F3FY8+F6JLUxM/jsPGjm/ZPI4pPAACHZu?=
 =?us-ascii?Q?974t46OsZAVrinGFAP8JklFSoPdfsGhBLBWWFIWmxIU8rJ7BVu455mdZQypx?=
 =?us-ascii?Q?NIqG10oXe29/1ITnTmwo0R/PWYukMawXXQaC48ldZKyNFsU/EnEeNDImPlWV?=
 =?us-ascii?Q?r8hVm3IMz1Q/7WBLA+r2zmc2zXFSFL/OyPZwn5H/gEjlSGuZ6QGRIxbwt6F4?=
 =?us-ascii?Q?IVWDm0HUwQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0961216-2d59-450c-d9b2-08da54165d44
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:13:45.9039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGrEpxLfhYMTSR8ub0Ha1Ty6WHcbSFgQMQgSu5urnGkA0n8ssuBUH/NdYLOrG96bOyWVyl19xYjE5+Urun60Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5623
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

BIT3 and BIT0 are reserved bits, should not touch.

Fixes: 88f7f6bcca37 ("arm64: dts: freescale: Add support for phyBOARD-Pollux-i.MX8MP")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index cefd3d36f93f..6aa720bafe28 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -136,21 +136,21 @@ MX8MP_IOMUXC_SAI1_MCLK__GPIO4_IO20			0x10
 
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
-			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c3
-			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c3
+			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c2
+			MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c2
 		>;
 	};
 
 	pinctrl_i2c2_gpio: i2c2gpiogrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_I2C2_SCL__GPIO5_IO16	0x1e3
-			MX8MP_IOMUXC_I2C2_SDA__GPIO5_IO17	0x1e3
+			MX8MP_IOMUXC_I2C2_SCL__GPIO5_IO16	0x1e2
+			MX8MP_IOMUXC_I2C2_SDA__GPIO5_IO17	0x1e2
 		>;
 	};
 
 	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x41
+			MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
 		>;
 	};
 
@@ -175,7 +175,7 @@ MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d0
 			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d0
 			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d0
 			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d0
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0
 		>;
 	};
 
@@ -187,7 +187,7 @@ MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d4
 			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d4
 			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d4
 			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d4
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0
 		>;
 	};
 
@@ -199,7 +199,7 @@ MX8MP_IOMUXC_SD2_DATA0__USDHC2_DATA0	0x1d6
 			MX8MP_IOMUXC_SD2_DATA1__USDHC2_DATA1	0x1d6
 			MX8MP_IOMUXC_SD2_DATA2__USDHC2_DATA2	0x1d6
 			MX8MP_IOMUXC_SD2_DATA3__USDHC2_DATA3	0x1d6
-			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc1
+			MX8MP_IOMUXC_GPIO1_IO04__USDHC2_VSELECT	0xc0
 		>;
 	};
 };
-- 
2.25.1

