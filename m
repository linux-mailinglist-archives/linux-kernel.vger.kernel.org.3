Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9515A7FBB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiHaONz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiHaONZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:13:25 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C9FD83E8;
        Wed, 31 Aug 2022 07:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=js7Ggf7VsShJFMMOA6u9Q7j9YXgI8AmQeTr1SGRRfCKNe2YRLqFKuoZFJP/vUbIgRBObOFThMslq+uT6Q1A9U1wl/y8Y5mv5qLgyLD6HlLOzEmTiVyLhmoQeooJYpe33ZhsjcUkGBVXeWSpptzEdxglfximmRStfDmr1PFZwKIaGC65WEJa+HCqmNqVEsROoasKu0cprBgkBcINO2VSPeJZvMWgSP6n3FJTkYdyVdAyZMOzolcIcTa50/zPmALCY5TWveXc3JN9NEiuWXSUXqtIc7Ir968vyhhBs3hp1MtzwibS8l9HaTGM2XvmrQxWc5hQcWgP+zA4Ud5uF1RE3AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMUTGkKytnF3XSpCNIiEnas2bTrlALLNXk6MfYjbvek=;
 b=RW5e9Kdwv3dHEQV3No3oaM6+wOdaI/ZOv3SBnrlNEgpcSIiywRRi3khj8l4w87lIyNxfsZHCINLqcmgQB+krnVzVM2EAwz4A4SqR79TXlQqqfM+q8EExUMLkCmHxhEQLAgWZtPc3GpdYjK+rQmwYFrwpwKJmQTalRvwyjkByISZQMD/SGNUSFrBBbz788NSwSUaGvw5OdiSyKQ1ft5y12d6Zc/3wd884qEAitQIEr3TNs4S+r3LE+DEMaP5GwB3BBNjq73m6huWGbxuOUXG83kU5kmWu/M1tvk9mU3L0GoeFvyoUhHvL0yexKX4vBxB8BcGaZJhGPByGoKGVVSflpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMUTGkKytnF3XSpCNIiEnas2bTrlALLNXk6MfYjbvek=;
 b=XPmH8If3QHxRrSOO+nmFBrhVt8LXWdfIlNL17Egm+VVi+7MlKrR/CgPV83OARq3k4qt1tAyabt0fcZgClynXvlDOflLt93NljTuVzVeSLTRehY4/Xa60UGVbAmrXCEYi/eHJuo4gFUWlCvatndQw8Kyj7HKzTjnJ6eIFiDvp5os=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7355.eurprd04.prod.outlook.com (2603:10a6:102:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 14:13:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:13:10 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 7/8] arm64: dts: imx93: add lpi2c nodes
Date:   Wed, 31 Aug 2022 22:14:17 +0800
Message-Id: <20220831141418.38532-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831141418.38532-1-peng.fan@oss.nxp.com>
References: <20220831141418.38532-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b74a8887-e33a-42e5-732a-08da8b5aef57
X-MS-TrafficTypeDiagnostic: PR3PR04MB7355:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVxIBt8guprs8JEYOmyare+uFHcqP6NE2K+KxN/JUbE3CO8ioQea5wPvVD6xPR8mz5tOL9vungXk3LhPTLoXZzjyuQy1tzcoYPvFcgUtXodfpJJmq+66AHaLyviVakhx82m7nZzJYBtiTfVHJsF6MMUQxFFwPky0/do30XJo+JOniIVsN2/9ZxgkeVvImgQL59jgQlFV1xd2g+2PiEGM2UhEMk/L3ave5cNZgSCrEYi3Vs3CyREYzfBE1uF659puWVMgzxWHD3bElI1IpTLlBgHPZUCWFiZZom1SSDu4mm8pkGSyb8xhms0suKUq7NngVcmR0IEpIodY+0Rn5zVEGJZn9YILO9Z343ZgNsVPZW0xGM+LE/+cKSr6x6qcepMEZIB7sOHHvGib3UzO4LxJZtRNKaCsQdexdvsYrNl5ZJfeiLMh2II8OxazjaLpb83FexZpZvpNFaHITfnKmE7jaz7lyoikWiijJT11Wa3ZLEYP+btShuy8Z8olm7ccernmaSFIysl8RtQ7fdbvYb56a2N/PPSEuURxtH4m7FHjiP0tTBZ3+j4sobqbpMx3VHr4f8xs467TunVcYH+uk0UnADs7l7+Yxr2f4iE0rFOyHSI4J5sHpGT60rOmX8TLWORrRhT40hhQV4Zh/eHbmaVM8m5H2lZvE8b2fOiRP8oMHDOL535ApfZGrIR3IXgYShjK4RoREjgumsrT10lL83FdlXWRjisvTComSNr36AoGyNjTUrHNns9yFfdHvfK2UPW9R+QmWMjZ5hPzhSJseFvvMOHHQ7na+OpvWN/taeLenU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(8676002)(4326008)(66476007)(66556008)(186003)(1076003)(2616005)(5660300002)(6506007)(52116002)(316002)(41300700001)(38100700002)(66946007)(26005)(6512007)(86362001)(6486002)(478600001)(2906002)(966005)(38350700002)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x8iqdJcxU7SqdcZdc+AlyB/2mv2OGC3T2X5/eTR7NRvlOSa1FJOtKIQHmIGZ?=
 =?us-ascii?Q?0RNTuZtf0A6eLUerMlT+QZjLzxVeExoKFiL0/FCipSV3GvyaVUJTAokYFqNk?=
 =?us-ascii?Q?qUfb7v4vlte5Vd7HDjYT3PhuvG6EgJfuOPc0V+hVWBQ/4JOY+3x7hL80oCqU?=
 =?us-ascii?Q?dyDslYtfb903KHvTc/uPLp81bE/q5jYkFvDZZzEIWEliuRzXVm7G14qJOS42?=
 =?us-ascii?Q?OLvOcfj8Uc898SKg+/v9Yf0vDYjouMRDxqSlD6NDxSF3wmlSegepvhQ4E+Mn?=
 =?us-ascii?Q?ZHIXtyQ1RTFNJ3bstW+kLoSlUf4x7SD7aFN3UHOPNNmCRJyhyHkqQhldFIq9?=
 =?us-ascii?Q?YHjWNaowmXvSCok+BWQXUeV8TDrywgx+F5iQyPNDi4e5MlF+bvS++UZfWs6a?=
 =?us-ascii?Q?tcJnZI92ZvsGGv8JsT/papWHt9AyTPMz1Xo6Dw+TYoiJvRsUP/SJRhpFHO4r?=
 =?us-ascii?Q?rT/eB5MmYfOvtgm4ph/cepTRIlTFxUXojyXLI6smljieclKmp1cZagM5xPEr?=
 =?us-ascii?Q?XquBLczanarbBfY7TrrjbGlkXAfNbUx+g51P0N7RBJk1KjOgSWRGojxtul0H?=
 =?us-ascii?Q?27Sb3iGU9nXIQUB0sbFYPq6FvZ49CvJvvzUvR4vMftuMfWy7ZjGUvCyxSOGi?=
 =?us-ascii?Q?HIH4FfkfsYaxC/3sPZ4wo2C3ix5nDH8RXvGzfq4Zh28T9dANefODzEYk3XIT?=
 =?us-ascii?Q?CUBOd/Hmo7fjfhEPWLD3s/LawHJohGaNPUjTYJqRpRE+lywVp/YxGUY3vwZd?=
 =?us-ascii?Q?zEMwIA1hxnmoEX3FOhcvD5YL7ttQLOo3zHdFJeVcqLk0rX9atz09KQQx2ktf?=
 =?us-ascii?Q?zOA23BmQ470EHgu1WPBjnwehimjPegysI4Rqj9ouHLP99Wc1zlzineor1pSE?=
 =?us-ascii?Q?EnhMP+ZRF2mWzbS11yksmY04+neH5jblvaZrwSR85q/NtM8V5Xp2ZPk5MXly?=
 =?us-ascii?Q?42VbdMM8ugCikLZIxMgU8X93eut7MfMHt378AHLLcwqYq51rf9T6TT0X4Szt?=
 =?us-ascii?Q?b9LvdrRhosTs0EI2hHlCiKCAS7rg6AQjZwT7OcSpTgFgxJvvYb6QtJDmEttI?=
 =?us-ascii?Q?BDhxLDdW0zJVNQQQlAgyDDSz89xyQHkzAmC6TUMSu+0oYXWgYA64jiw5MbaV?=
 =?us-ascii?Q?vp9gO0jHPm3aWekdWHe0NyNbtPUjsLiKnuZNXKqycCAUQRNLJKD+qUVl1ChM?=
 =?us-ascii?Q?8KOGj/PFqdWUkzKkLXObpPSFoubaku2t41Fn/GGM9SkDbTMdYcVWE01LoqcX?=
 =?us-ascii?Q?TGB9WbFUuUH3+ePjJmrgmykiwiV3wruJ/FtjYe2ZKV/0UOhApjctFpqOdS9+?=
 =?us-ascii?Q?jcL8pc8yGehrRT++NwJBQxHbEOH2kKCs2Aqyx+hxNwtrDNqTCYhux0jsyV1E?=
 =?us-ascii?Q?9rSF6TDgILABOixG1SmGfpAKCFOChbB8qdzjO+iy2kHYp+VKOO5hRauT0iEv?=
 =?us-ascii?Q?H30f1xRWPE5zGORO/XlwUrudNzZA14IJ2K8ysvmyj8AbSVERMbhDpBN4HACX?=
 =?us-ascii?Q?iJHkO97psc7PjCATCo1WkTww0hWSbXJJ++U7Z+TSfwYgkllpqO3hvPtBXGDR?=
 =?us-ascii?Q?3riDDES4R42mE6jGbUEThGb6oRu2U9C/Sm9Q6csr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74a8887-e33a-42e5-732a-08da8b5aef57
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 14:13:10.7974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /pQNCXixi46Ko4vh6/pX0/tibjvxtYUO6cCbVEnjrUtRAEie0cEUvHYwwdMkmFbPN32jnRl5PwyFlIFcPIBL2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7355
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

