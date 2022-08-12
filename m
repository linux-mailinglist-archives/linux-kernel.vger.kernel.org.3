Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559B5590CD1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbiHLHpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237509AbiHLHpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:45:00 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00042.outbound.protection.outlook.com [40.107.0.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573DDA6C09;
        Fri, 12 Aug 2022 00:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFwC+vw58TzAjxB3I5nGYujXG2FojGbF1MqYjlhM8k7t4ouiuVZDErb2TGzrw5t+NETB0s3R7LhwmcO3/8xTm/tTkSiud63kF++2Ftp2d7sTCtTZwh6eaXh3oe+7z9s5STKEBJD0teCzZR9sGCR6URPVTTqmKYXt1k3RLWJWEt1iZjFC6/K8Ct4/HGl2pd5ksZDSs/fa+Wre9ask+lWw6jKIRfc7FKovmJyRyhZCKdd6oSSety4+Wu4f1HxLsiWxqwInubRBu8bEfCKVheW63ul0uSMp0T8Yd8Y4vkVo4l5RxOspEBY/+ZTWm+jL7fxj/FHw6WdDIXIE2iYzB7RRhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsR3O2bbWcSVqKLY7UoNpDVX4eNtQEgD6YFurZIBzIg=;
 b=KyDow7ccTe/ET/MZPgVH5bwYBt7eSENraGbEqZ4Y0CSob5T8sXNLwY4Zt+GtZB1iZb0p5Wxp6d2JoFrwHReN636V3fm9EMRYx7TZo6lAagBGK0UwKEi5SxUTInCOKEEjUyCUcqW4FNvPayP9Dm0J3QmCqwrXX9GiprbvVVzaB5rE/Nk9lW0EipkdG0DQcKKX72rZNgsSP5xHw02ZkixRsw+bz/J4e/fsNQ/t6sEWvSLhiLMV8+cA/VVBNzadOqnkPzY997AzUiHwHyDBiST38mocfRE4fPFTRe0ZDgw3B3mgvUYSb0Csoaz68VRi7rddSNlWp8YoTgaO1Dz/XMy1Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsR3O2bbWcSVqKLY7UoNpDVX4eNtQEgD6YFurZIBzIg=;
 b=cBOMlVlayz9hF4aAS1kZk71sd8XFPQV2w4VkHpK+Y1/zdGLoI6NGrk1mdrK5UnTg/w0TLCVPPe6f6tnoL6I3f4P1ggFfQQQIz7NdLMRxnIWFiTZG/daU+4OopgJq33J5JueDdV4fmrxfuoVKQXQYKipqDeRHB4jm4k7NTOSfK48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GV1PR04MB9181.eurprd04.prod.outlook.com (2603:10a6:150:25::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.21; Fri, 12 Aug
 2022 07:44:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 07:44:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 6/7] arm64: dts: imx93: add lpi2c nodes
Date:   Fri, 12 Aug 2022 15:46:08 +0800
Message-Id: <20220812074609.53131-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812074609.53131-1-peng.fan@oss.nxp.com>
References: <20220812074609.53131-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 256d67d7-0cc1-4249-ddb9-08da7c368b97
X-MS-TrafficTypeDiagnostic: GV1PR04MB9181:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: meZHcttjX3BeUTeSs6SQeBnDdkYbZ+PwKG3NVFZ9s38q/HOuQT9z4NesKIlc61P/b6SEz4Yknx30w8hzSp1XAlLW4MwwxLms5Cm5WXnsDhMhb3tD8rTmQgBmz4w6Y2jE09dTkDj3g4pYwv2+T3bwhcEY/DpT0WwGsArJAZj8bYuURWWuwz0QfwbxeQ+25krcKVOJx55LTPXoOYsdzbjWckXNrIxJeWF3OQYCovq79E6TMz/PjpkOg/FbVyDVxn0wI869HTwPZJ65jnv/LZhjtKTGnZQGO8CmqVb7JBO9XjccVPBgNJtdiG89T/Fx9FIbX6rJcOLOzcs7muuVMvooIF2DIlT8LIthUqXZB9KjaJE2Rp0U+loxOQ+Or48vNrI2fbXPGBfxtnz4N6xOAyhyhBxLjLdGYVQr7MV6d82b0ODuDzroZA9evZQVMgegI3mxJGGWSgN6Bbddl0Ik3CHaQfEE5T16qkcIsz6ipNPjo5Vsq4Svk9/eGz2aqtnWwdiXvuCvVWat5jqxWaXgA27BTvJykWS6nNaTz7vHjJauO3RiJ4FuPZkUe8jklVCc2gi0nBk8207OLFudgGI65d04jYk4U+VyiAGf76s8xpRcq5ThxhZ0DczS4oi5/DzRKUed9LgL5n7CNP8fvDWxGlbDHjr72rHmSCzzNRXMyq8ffYprYRvgLb4oCa+MRmbVsWgHoJK/Bya73AvXcGswVh6xuROWWUCOFWIPRvaiHe1D8hHEJjO/xYty+1QH0LcnOELS2aMEEuFc/Ww/6DJn/v6FBCpuM6ofn8ky1q0zJWjOF2k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(38350700002)(38100700002)(2906002)(5660300002)(8936002)(6486002)(83380400001)(6512007)(66556008)(8676002)(66476007)(2616005)(66946007)(4326008)(478600001)(186003)(41300700001)(52116002)(6666004)(26005)(86362001)(316002)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AM6+5plP7FdnOVq4yky6MUFLkpyk+zxZ8tsP+h0cExizdAG587iQSxXJaCQC?=
 =?us-ascii?Q?mQE74b3i+GZabbDouu3n90OAtQHpmJGXVN5pfIdiKGrjerXRXs3ShomcbEiJ?=
 =?us-ascii?Q?pfh2WCLViLWv8FJDw2puxFc0lOCKqzE4AGbyFLkAkr9cXGUyquHSqoby1Unp?=
 =?us-ascii?Q?YHR8rhbekMpxghYfssvpx/5QB0m5+QlYuwv9X+pTtWmJXLWvTAdmZkjORqYm?=
 =?us-ascii?Q?mlYAuojt71ABX0m0UJpl+vll5qBpfE9VcUfSvHMG64B2uj7U9wZFG9rSDOP+?=
 =?us-ascii?Q?wmW/jlFOAFZcQrgtbEqpKxr05UksQwxy1MuM/spRbfSsFihASAxGDPugBVNm?=
 =?us-ascii?Q?yMO9MCwpYx/h4Q9pqsvDZPwCo6P9djjsxHudF0TPTdyuYPWHBBfkPhBNoEkH?=
 =?us-ascii?Q?yMImDlHWbtKopzN0CZcojRKk/tWsNR1yKtc6MQDJPLwEvESg0uXjrRRqaU93?=
 =?us-ascii?Q?w8aSS5QFXrryNcowJNs8doGVlXm0iJPvnKMmDJTdTcnplcBPejnntIhE4f5a?=
 =?us-ascii?Q?QrY6CgC2MEPZ7n55xn87gbm954r0LJEEfL3Mu4ENlm1GdMRB2UjNI5I/+YeE?=
 =?us-ascii?Q?lZhRINKJF9rhLMyLIGDUTTmgfnxSwKpj3prLu3S7JIhoVdtm7I7xHeBriYxS?=
 =?us-ascii?Q?lJrg4caUa/fPT870De1TH+VvGAC6j7vc5cd3BUCc01HkC1BjICF4vT6YDMW/?=
 =?us-ascii?Q?YYlcmY+2a3N/ls7FD51gOP1YYcjAUsxZejlSBczdxdltgdvDCpZswVratsK3?=
 =?us-ascii?Q?w1q/rzX2CkqAFKk9xQjebBj4ttmmIy8Psv7/rDFGuhDg4WvZN+yTHXjB3gyQ?=
 =?us-ascii?Q?wPc7ghZEVTC91ck45Mj9Dtxi7hfioLqa90g59u+TBoqAu4oUBigyF29hEYJH?=
 =?us-ascii?Q?JsZjx90jsJoXMJbo695Mc+R/pOBrgJmxobUsQK03LJx3ejpp0m9DJQ6tcYJU?=
 =?us-ascii?Q?Gyj+lUXUF8BRU5myoddZaymgdKsxBJy0dUDXbed7K+XzD6v7G0Sf2uqkMx3o?=
 =?us-ascii?Q?CCZHwafZVMrfQ8comuYEFa5DH+3SgscDaJK1GZZ7RlAHBpMBlOCHHANDTIQK?=
 =?us-ascii?Q?kNMUE0pirN423WDKLT3K5JGpaeYsFJ5/XDxaRlDgWj6a32heylXXQmOa6bt7?=
 =?us-ascii?Q?oF8x3RTO7sKrTYJVCYBvv0Qurb5jaNWG511Kx4kI71cQChuT4SjHccQWjtt9?=
 =?us-ascii?Q?bNLZA59lPBegElYI0WN9mmiVShvpiLn7eVouCwZQuGlPoDlghPHKVdZeJIDx?=
 =?us-ascii?Q?4G53+9K87UtIK5Vk8z9S4EPzZ6OjsGssAtDwOgYfsdYvxXmIqk3kxldxDfJF?=
 =?us-ascii?Q?XniBB4jsxwBd2BKgpGHecl7I3Tu6+Ma5CgO+D+Nk8AcKbfHkFeLxZOC809I/?=
 =?us-ascii?Q?RbBxEyKJFjXUozVjR2+cCH5KteTNMlcRTPGERhihM/BwT8J1RKYJXDK++fqL?=
 =?us-ascii?Q?I7LHnpOwqeTvsSyBLrZ0ogCmK6L37WwelVM9Z5SdF48wzliW9wfR0Ruguipt?=
 =?us-ascii?Q?5RgwJnwNqMTL5thb/wfF1zSFfHXXm4hLDM9RIhJ6ce8Ig0IKCsYLxhrH7xXf?=
 =?us-ascii?Q?UH5Pm1Z4k0Zgc+rzIdUYMkizHZo1LXlZb/vsys5h?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 256d67d7-0cc1-4249-ddb9-08da7c368b97
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 07:44:53.9986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQkEVZFdvwrVGk+x7T6MpgJAClVt2VwxsbetIlAU25ARMMzNd2Hwa/Ai+jv7lMcH4Zi7HO+SC4N/hiWVaKQ4Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9181
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
 arch/arm64/boot/dts/freescale/imx93.dtsi | 89 ++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index fd687d78cd03..3d1309d393a4 100644
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

