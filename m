Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E75564637
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 11:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbiGCJL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 05:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiGCJLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 05:11:16 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80077.outbound.protection.outlook.com [40.107.8.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4405964FF;
        Sun,  3 Jul 2022 02:11:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHaAPTSpRgipD9hvwE1vvBcNjDYF8EQ+MJ+muf/NTDJKzEaZ4SRGPBFEnjEIEjRN8IO6ykGbK6+5nr1k8LcRL3B5tR0GvZxkBI0qtGQBXuFEKIZOfUQT2Hqhgjrc9tMfnyDVz0JYoaQxsKPpxPOY8TMpvM9tDLLrLmLGEYL+LUYC/toK6N3TXgTerH5B7ywUIyLPo1T9JSX/82XU/7IyTORAPpw8pM/LRu13ViVBDTfLXM6r+vKmGVcCkb6grEDEbZ2jhiHVEl6UfBAXfwAAYukqO+dYScwb+yVyud6B4Ayhuo2P8r4MefwDMUBJR5eOfffDVi1RTLGygLS5jiqGcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kczbs4yhHEWJ4C5Hs3fCrHBXUSZ4VC57AFGmZuv0+w=;
 b=O9m3QvBA8E4zhavqZN4hbkc68RtpiHtaIbngVkMwomFo8AVRTMg9sSq0zsG+4Vmal0HpWEGE0g5DyL1xEhIAaQCY4wBg0Y77JbpV4irg+BHGA91SSZXEpDy1fvuNmzF1o+HmnFVk1RY+ayNfAaWFMCPodvjV+SgASD3k2p4Pi+AzTYWzJ+PXwup15R/YdewVy/mZTkgVgauZ7KCKJnbPa3T0znWL2xj3vJkbvSGBdc7eGOt5GhgP78mnNz6XzvuOHYFc3rTgkMQqHbLPLqHtd94T0y6lnawv4DwVtS8cIIxPq4YOgA5nJj6zclpFwIVNdgFU0sAx2/uWSbbsz1Cj1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kczbs4yhHEWJ4C5Hs3fCrHBXUSZ4VC57AFGmZuv0+w=;
 b=Mi8xGtDrhp0bCT7iXGziFtZ3WyGvmF3Sp5Pjyiq8/VPQdu8oNNr4+Frb5uTHTW9c50wGfeTG1R02Ix3Zb7ps2cNRtA1LMXCKIf6dLg77OVe9as+FXVqpUBjOUhiwbOjV81KiYsMtxSwf2Y6Y4YScwdwGeLpVU+E+SKvsa95soi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7768.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Sun, 3 Jul
 2022 09:11:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%5]) with mapi id 15.20.5395.018; Sun, 3 Jul 2022
 09:11:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, myungjoo.ham@samsung.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        abelvesa@kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 10/10] arm64: dts: imx8mp: add NoC node
Date:   Sun,  3 Jul 2022 17:11:32 +0800
Message-Id: <20220703091132.1412063-11-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220703091132.1412063-1-peng.fan@oss.nxp.com>
References: <20220703091132.1412063-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0173.apcprd04.prod.outlook.com (2603:1096:4::35)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c086b60-a48c-42a1-5127-08da5cd3f7bc
X-MS-TrafficTypeDiagnostic: AS8PR04MB7768:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: drnzT30IA2/4kqQIXrwAplZyIOz2fk2iradF+8XSQwzqhMpHnYlplJTGD4246yejcsJEmg4Mr5/okE6eCk70Kea13uTaC0KXxhbIpam2qAX/H1k2IAiBdc8tFcVFYPRbPz+rAViXrIcGduXa9HVYsGBnGBCxrn3AP6kSh41CzXIizqL8+dSSlAudhobml0uq30aiu7OVBDXTr4iPeoWq66ClbixUeH8Ysze+44rJWdMGOv36X/AGZNM+iwmSwsE6qSkNUuNXykKjivcFytLPhJxhzK9cIlW3s9sNGVMP7/KxpQ0O71Wu67VQG7BO84aR2Flrt8M4+cCYeYsLBKImBnAa31ruDP35iOSPA6BMS/qfia9Xrwe7EHMvkrlIDDJi3vRyMSAS+nojt1KC+Yrj2T6g9GzdruV1xmgB8TU115fcnJYHg5gqOQBNEKKrxcsnT6XC4m92ZCO1qH+MurT7fljPKgewBXcvzXVgnNn42Dj9IPDh2bn59txwnICF7QOGQ9Tb74Gx+TKbBBphTRZAKSG7tlDbWAJxzw2rh/ffP7QK4getUJlqBWO+J5Wxql2OT46++XR1aGVcFVj+8u4cmZ+GMv+ZShSlOyd3eeUhhmIie9TlR3HMCppRCiOLNHwOb4jHCPECDsNWeVxMbO16ywxBZO2xITP0TTQNQ83t1S7ZlgIORPTbef+oXjMc/E+k6NK10fX02lA2UFAXGM438sc9cDw2mDaR/e/znMtB6jRPKBboOTBV1HTjXbv7NRgrohFexd8Q2ZBUfHPLwkZ3WfYOd6CHpIHh7O8kNLd/e6uN3QsNZFPuBDf+hMFc55t9R1adrLAQhpIQVZ1ltkxq/wGm6ObrhOohZ/NNWo/G5ac=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(478600001)(5660300002)(8936002)(7416002)(921005)(316002)(86362001)(6486002)(4326008)(8676002)(66476007)(66556008)(66946007)(83380400001)(2616005)(1076003)(186003)(6512007)(26005)(52116002)(2906002)(41300700001)(38100700002)(38350700002)(6506007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NQaMklNP6E8a1SMBt/ULS9esDdjM4NYL4PF1c+dZ1saDsmytA2bk61yYEiNL?=
 =?us-ascii?Q?xqVmytQa8rP7HbogQCkPisGwX698EYf0+HdlhJb+ZnAVVSVXyCH1TOvAHAQN?=
 =?us-ascii?Q?SwSrnaq0OReFwKoYE1ZedZ7FQMY2zK7NP4jBQ26E186xmCLROBNvgJH+K79Q?=
 =?us-ascii?Q?wyDIwzuiHCu9gdZEsiEMJmanoJUQkpj11+5XpxjG+0vXBQ67rigsf+H47Ny3?=
 =?us-ascii?Q?JXECiOFIv94EEe5C+NlRRGsv4eOE4vn0QqWsM+PbBIbcamkQwM+0oLWQR24e?=
 =?us-ascii?Q?/YKMtw5/SjZ9uOEhdfO4wNelDZ8BLCGMQsbSUZrNhHZYpvOFbsgytsTKHrAJ?=
 =?us-ascii?Q?Y10tw5sl5u4bz0fDkGqzjybl1GBBOVdybMiR+gQe8acDWcdcRIiqgLxYPMaX?=
 =?us-ascii?Q?NdlCZpagsfdsDaVt8eH6T85w8SgCTkH0dBTcDDGzOJYdEmjyGtmyBuwJ9S2u?=
 =?us-ascii?Q?vZqqyXl4dUMNnhMZdrAVpeQEGV+50LipFFvzc3o6FIP1gYx/Lb3I4qdrXXYY?=
 =?us-ascii?Q?HeNY2Qk1LRSTQM+qJ65rJ5hiiU/WSwyQXecGUpo+1ToHbU3IqkDfUX5Ro2xM?=
 =?us-ascii?Q?d4vKt3JpQD8xAlpzKihHVI/h4y6p5AesLLyE1vA+P0EFJzUsAq2e1CFZPcWh?=
 =?us-ascii?Q?YKyzL+ot+ftWlbDZcLBRNh+g63NWN1z4UvtbnVfgtUWv4T4RE/zTCz3+okry?=
 =?us-ascii?Q?bDWUR4CG9xD4MGCKrTIjOy4MUzODfsuVBpED62l9eQAO3MweyqgkZ6cVJpIY?=
 =?us-ascii?Q?N4rn29TZZL0iHsCk6nIMrieGR7bqGDv4uc1OFZf9d3+n8pS/NXHr/IisHl9h?=
 =?us-ascii?Q?wAlTUqGS2/F/sf4Ba2BNZLEeS/5mF5m63d6FMGfes77XEne4cAgCgpWnLHRx?=
 =?us-ascii?Q?mDV0oAZHKO9Z3yfiN4RqD3UwWz7Bx7N1yUY5f/sATMQnHVx1S2AY4WSl5KoG?=
 =?us-ascii?Q?Qmgr9NSeJYWy1CeQzDnHP6SH/DHq9aQu0UH+fvHSVimCWsUK9nW/c8h40wiO?=
 =?us-ascii?Q?pabtXkGWrwIHHurJcHXPTvzJdgpZG2eZrM//yfGnr1/a9HTpll3L4lalQRed?=
 =?us-ascii?Q?TV+qF6jx7+gkKwiBHTph60pRc5198p5uwy8ZIEHzsc9nz4GmcMZ17BG4p1g4?=
 =?us-ascii?Q?2QRNdsj2MBY/4MPghP0+/BpyL68SaLmImMjqCCmMy0AEOLtRJVnFu6ZFMx8w?=
 =?us-ascii?Q?gCDzYsam2PyPGlO/hZ/nyrKVCKj+UpReVDizuX1Z4n33yM2ivSu2PUQyZxV+?=
 =?us-ascii?Q?oMgpWH9g31b704O3UdhPgQu4iUByyJS5aoSAIueJfo8gbU+wWtefZyu3K5Cn?=
 =?us-ascii?Q?V6B3e1anUZfVWFDACKFMhbL8IwOhyKsX0OMAqtc3Ysnm8BXM2XybfodNiVW6?=
 =?us-ascii?Q?9dq/xWRZSijF9qHWCXKT5BBp906JcmbtNBZB2kE1SqhvWxX4ls3gs2V3VFAz?=
 =?us-ascii?Q?UN6gY9ViUAmxaC6E3n5sBYsVHZAdrX3bIwaNkbQaTX9LUrYUh1xaRVYx/aKz?=
 =?us-ascii?Q?TstXueQGvAnFlVIX/RiejMxnxfjV1pT+QOrUpBoob5MEZ5hijdlxNivzMZyZ?=
 =?us-ascii?Q?1dyIBqowF+U7+2lCVtU+RErieRw9G94ImqU4WPZx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c086b60-a48c-42a1-5127-08da5cd3f7bc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2022 09:11:09.3327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1H53xuwYPqkeJRIxdSuCeIsd79a84Z8rQpKal5Mlhv19FDTxqovqbSL7aYUrekjwxZxxESxA96J3/dIJMfWoUg==
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

Add i.MX8MP NoC node to make the interconnect i.MX8MP driver could work.
Currently dynamic frequency scaling of the i.MX8MP NoC has not been
supported, only NoC initial settings are configured by interconnect
driver.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index eb2d516278eb..13a2ee77d3c6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/clock/imx8mp-clock.h>
+#include <dt-bindings/interconnect/fsl,imx8mp.h>
 #include <dt-bindings/power/imx8mp-power.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
@@ -1019,6 +1020,27 @@ eqos: ethernet@30bf0000 {
 			};
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mp-noc", "fsl,imx8m-noc", "syscon";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MP_CLK_NOC>;
+			#interconnect-cells = <1>;
+
+			operating-points-v2 = <&noc_opp_table>;
+
+			noc_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-200M {
+					opp-hz = /bits/ 64 <200000000>;
+				};
+
+				opp-1000M {
+					opp-hz = /bits/ 64 <1000000000>;
+				};
+			};
+		};
+
 		aips4: bus@32c00000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x32c00000 0x400000>;
-- 
2.25.1

