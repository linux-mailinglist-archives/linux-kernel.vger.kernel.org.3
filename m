Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2447D5A7807
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiHaHtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiHaHsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:48:46 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958AFC2F84;
        Wed, 31 Aug 2022 00:48:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Krk/ObtwAA0xokV+wiHKcBkpPm6g0eVb7SKTrsaICmdhvVahfaEsmrPG/OMs4Oic/J1/ZH9lQOHlFHoCkoTfVjIvDeVBH5fHtRVXEyprXjE5Qf3vtjS7gZqRc3xnxYaVrBZO53RbdnCBKt8vcI4GXLiOxozKn3qKUh73y7XjvBNXWNvPV9cdeXZKssHAdjiSO/eIPAZH33HNYorESboYbaksGAYQh3LmBoRP6EdhbwAmuydpbB+c5td77Xr64mTOFi+6KOGowUvK3F8l79HTM8WJ8cn8GIJJ5EKagWr6Qx7n58lwkQIeP/2kRvURA4td5NKltGCqEdzP9tWe32fDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMUTGkKytnF3XSpCNIiEnas2bTrlALLNXk6MfYjbvek=;
 b=k0StX7UrJiixaM5odyQ7NVpha/FFYPkHYG0ZkfZcH0WZ2TruN+vkuXlGkK+0t+5hV571u4qKPBfk34MTE7Nr4MuGgkl8IquKu3PIX++mZQeH0YDp4p9VUXPjaIR+0t3H1DSPNQ732c6B0VrHAoFskTV74RNCr2qNEDd14VcsoUuITB2/++KehJGe6UZeQ6kWdB5dZHa6Qg/vsh4A1ZFXvpdehrkDkACVrVX5M5hT3GNIq85LvbQZd4shdPl3dcWqoNmaF5cny47L8CXsKNGUrdFCXC+miLYLV0/rdCw5omcgFsV6Roce3jpto0xnC/qPWga9CDzcbZLi12bpPVS6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMUTGkKytnF3XSpCNIiEnas2bTrlALLNXk6MfYjbvek=;
 b=ed+J+gNyoJdHwsnFJGZ1J83WehJ7mvHSf5tyZPUWIEZ3h7xnF34XgRC1stPYZ5s0xgHrsa5/4G2j/wgt1S77xaUIFhAxqpkRZlwiZUiBuladwpt0uFqKnpNFpmXvNiskOO6YzH7v98gjjv7dYIdT71oMyT8L7uwdOmrumYsEGwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9247.eurprd04.prod.outlook.com (2603:10a6:102:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 07:48:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 07:48:26 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 7/8] arm64: dts: imx93: add lpi2c nodes
Date:   Wed, 31 Aug 2022 15:49:22 +0800
Message-Id: <20220831074923.3085937-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831074923.3085937-1-peng.fan@oss.nxp.com>
References: <20220831074923.3085937-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d628c7c-754f-445b-adf1-08da8b253011
X-MS-TrafficTypeDiagnostic: PA4PR04MB9247:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3BDK8oXdlygUGlrs3HtkRBaC7cozGYcjIMxnwINTJn7lTSH4F1SQfrHXOPGJbUEtVHiq5DJCzxwUf4nWHc+UopHG+S7RduTFcYD4EGppA7z+a0KPBqMl4bKZZuUCNT5ld/AQUCYdVCS1SSZSQPCmTIwl6uJHrNGDk27uNVIAgXNi3SRXyUNfHvGNVKNEVFN7XdbsJ15DxqzyTTWuBGno9uU6s+AsOaxLOAMohV01r+jeOAdv24GG0qDq7W/A0ShRUqHbzK8t9H9rmMQUq33msMQZoz+mmkTCMZ9K1YJ/dL1mFhCDmAmYrM76+7bBAkhk1/Fm84VkSSvxRlmaBdoA0BN5jW6Qpm4DwcWpPth3Y5JC86oGbYuF61XMOEgT3CBoAw3SMIYCRiFDNkGh0+i/NeVnvI6wX68aO5C6aTvdxe/3BkQwCfLSJwYR0qbdXFufQ5/SchdfMoE3iyJN4WF5x1lJRs4135gsC9raFP17uaXLOig5d4ns/XrSwd3uGqmS85U1hQYGIDfVXnEqGd8jTmf555ubCu11n5NMRPYtTmg2k3VILDKatgQ0i+czzsqj4UPx1uXQg9ms/mjMwuvj4/RvPctQUf6LzytV+ahprpfRpmHG7TY7Qb7EBiEJB23toAeCc7QrlJ7roqxosgXzcXzWa0B31t+42VhILBjjiM2arhYWIBxJ5qXCT2n+1Vv2QAFQ9pbuLmQUo3Obk02ttaZTdPAnelYeNYrnJo8+QZh4WakzwQ2JaHVGloQr6Mg4+uP2wGdj+iYWHcBAeqd6/s+0FoE7JbnaW7zKIpZOgI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(66556008)(66946007)(86362001)(38350700002)(966005)(41300700001)(8936002)(66476007)(38100700002)(4326008)(8676002)(6486002)(478600001)(5660300002)(83380400001)(186003)(316002)(2616005)(1076003)(6506007)(52116002)(6512007)(26005)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FBojZHqO3K3dFCBSwkJqsic7icHbPpzQljC60jznE7R1hy9t6XayoifE8oc2?=
 =?us-ascii?Q?eQmNHJ9rgKsVpKBUvE7FK0gqxoCkiQLylv1wwp4lyUUj7UzMtCOgfXvUN7Ur?=
 =?us-ascii?Q?WvYJWraBQa6fJUHgEo/V1dKnwoFnJPKqlsghiOPVXXpLHU13CGByPKNW6eEf?=
 =?us-ascii?Q?d0hLEP5BhReVNsrGH2LXJSmHv4mk4RAGa1X7OxP9RkhLF+EoJS46qiidprtd?=
 =?us-ascii?Q?cD+m5a6nSGq/MyD5FHitjucb6f8+UwICfHNPkbw+LzyaFqp6uYmB3xNy4yr8?=
 =?us-ascii?Q?uigOHInRtWE0+Ttfw1+dS8D1iAGVh9JszJppRboEZwn0R1DTqu+I+NZZxqTw?=
 =?us-ascii?Q?IXeJEF0G+hryx0ph2fu38L8eRJPH/MCyyDlYulSFe5oz4yNTjInHvyb/mZxD?=
 =?us-ascii?Q?AH/4wJ+aepjyPxhzKC1bcVeoemcWjr6VQmD5W3r1YGiwaD8yCYqqWPVFDyRY?=
 =?us-ascii?Q?s7ZIiNG8PuXT0k6BICYfSYWl9VDpPLqF+clVsHFFbdXGmDyNJL9PVvBnI8xe?=
 =?us-ascii?Q?4k88NtbcwTpMBmJ5CybrNIJT724GMJm4ZJ11K263mb1r3azWi53PrznT4S/2?=
 =?us-ascii?Q?PwcdeCgftd091BHoNzzlIZiKYleru2nBGEKaKHPx7+uqvbBRzJMsyMhjQgLn?=
 =?us-ascii?Q?DYIg7nUqLl9Q4FcoyZDpojLLQo8VOeCsLfHuumd5LG4hQ8XQ4HLUCnjctQ7x?=
 =?us-ascii?Q?kukw+zQeP4EQNfjN4/eli2mSYUB+YqN1WVlMw3WQQvH5Ep/qK/qoKHMQRzhk?=
 =?us-ascii?Q?OPvtO/vFsB95mzzsC95PjakOiyznz0dHQa6Xp0jqpy/1PigUQeG1WTw6ngTu?=
 =?us-ascii?Q?53/pvFC+qdGR0SPFyk+ZMLjAyiV/nwbpi+RPlv3xX5G6oE8pSXbAYwTVkLNB?=
 =?us-ascii?Q?cmpX2JU3l+OYRtbHWp6vr755CrRbYJOdved8y2cU2fMofCCil2dUbwFqdXU4?=
 =?us-ascii?Q?dd8hTvozkAGyuRtnBiNh4QF93w7/v+0GIuk18XKuKVR9HKyPv50bKCyRZBXM?=
 =?us-ascii?Q?0Udz+zx1UFHHDFTubkgOxH8YJXmc5WiSIr+S7b0j6PwU0RLY82iRJA/wS5St?=
 =?us-ascii?Q?ZwlWA5qF+rgiEbAr8pvJSNt+NYT2EqsTsxL+imJ65oqve+O/ms2cBnsyP7nm?=
 =?us-ascii?Q?uVlNEqe5PAGA+e4wirfmlcR1h6WVEjn3tunYbE8wlCdwE5kaEh++jPiK1KDH?=
 =?us-ascii?Q?BTPCSSjtMU7zpYlEedmaIQsUvqhOvB4rBRk8kcc1+uK6Y21AYboq83kG2+XC?=
 =?us-ascii?Q?PQnbye5IETagc6WJnmajvwfZZ+Ei52VA9ceiG6S2wgB+MiMHSAL6rEnYT2rI?=
 =?us-ascii?Q?DmTy61pCRO/RgDWQy4v1jI2Bvqta9yfMCwZlgoiU/ESt9jn9O+2+nIyB3Cv3?=
 =?us-ascii?Q?EK49Q3aG+xE9k7A3ri3JKAxhL/zBIjQzcy0wCYe37OlNOa6ihWPIDYUqas7c?=
 =?us-ascii?Q?yPffNHccddgPMuxbv6sa+pIjVjaphNnpra/Ab1KYa3CzuPeAYqYKXkJw+ni0?=
 =?us-ascii?Q?cAkKlzGCBh6BHmEjfZvgF0Xkpin2Yp13kRasUHOt8g+8hj6kV63GR/XbrJ9+?=
 =?us-ascii?Q?gc0k97CcwMUOAy9HvumKzfv7GkYUQNOd4KqUB8vS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d628c7c-754f-445b-adf1-08da8b253011
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 07:48:26.6767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vd0UyWzrahb1F6jqNBLsFOb8l8gqInCGWlPn5hi45UXwna75yEgyZRojn+sNWhwc94gDkK9p1DAXSeKL8Gxw5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9247
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 lpi2c nodes

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

binding doc accepeted:
  https://lore.kernel.org/all/Yw3hfcQ2JV248GIo@shikoro/

 arch/arm64/boot/dts/freescale/imx93.dtsi | 89 ++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index f007314d8f1e..58f36897bc5f 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -16,6 +16,14 @@ / {
 	#size-cells = <2>;
 
 	aliases {
+		i2c0 = &lpi2c1;
+		i2c1 = &lpi2c2;
+		i2c2 = &lpi2c3;
+		i2c3 = &lpi2c4;
+		i2c4 = &lpi2c5;
+		i2c5 = &lpi2c6;
+		i2c6 = &lpi2c7;
+		i2c7 = &lpi2c8;
 		mmc0 = &usdhc1;
 		mmc1 = &usdhc2;
 		mmc2 = &usdhc3;
@@ -138,6 +146,26 @@ system_counter: timer@44290000 {
 				clock-names = "per";
 			};
 
+			lpi2c1: i2c@44340000 {
+				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x44340000 0x10000>;
+				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPI2C1_GATE>,
+					 <&clk IMX93_CLK_BUS_AON>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpi2c2: i2c@44350000 {
+				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x44350000 0x10000>;
+				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPI2C2_GATE>,
+					 <&clk IMX93_CLK_BUS_AON>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
 			lpuart1: serial@44380000 {
 				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x44380000 0x1000>;
@@ -197,6 +225,26 @@ mu2: mailbox@42440000 {
 				status = "disabled";
 			};
 
+			lpi2c3: i2c@42530000 {
+				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x42530000 0x10000>;
+				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPI2C3_GATE>,
+					 <&clk IMX93_CLK_BUS_WAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpi2c4: i2c@42540000 {
+				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x42540000 0x10000>;
+				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPI2C4_GATE>,
+					 <&clk IMX93_CLK_BUS_WAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
 			lpuart3: serial@42570000 {
 				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x42570000 0x1000>;
@@ -250,6 +298,47 @@ lpuart8: serial@426a0000 {
 				clock-names = "ipg";
 				status = "disabled";
 			};
+
+			lpi2c5: i2c@426b0000 {
+				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x426b0000 0x10000>;
+				interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPI2C5_GATE>,
+					 <&clk IMX93_CLK_BUS_WAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpi2c6: i2c@426c0000 {
+				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x426c0000 0x10000>;
+				interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPI2C6_GATE>,
+					 <&clk IMX93_CLK_BUS_WAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpi2c7: i2c@426d0000 {
+				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x426d0000 0x10000>;
+				interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPI2C7_GATE>,
+					 <&clk IMX93_CLK_BUS_WAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpi2c8: i2c@426e0000 {
+				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
+				reg = <0x426e0000 0x10000>;
+				interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPI2C8_GATE>,
+					 <&clk IMX93_CLK_BUS_WAKEUP>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
 		};
 
 		aips3: bus@42800000 {
-- 
2.37.1

