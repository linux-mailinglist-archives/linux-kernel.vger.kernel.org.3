Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6447F5A781B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiHaHtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiHaHsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:48:50 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEB9BFEA7;
        Wed, 31 Aug 2022 00:48:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXxkZ3TtrbC9bcsL2+bNFCXB94HWBIStEdm/ap5xS2WsDUCw0VGG8ohShKqJPWvf7bYntP7coVXQSinM86/pC4MRCgIvZnarlAozDBspnDF7gG9xa2lta254ILRJ5H1q3HJz2549FL4/6s02DaXl0ztbohbqLa3sPhdfaXrcQrkRl0E2tT5L4FnwI1keBIzFQnd4Jmj6QhO8TNcx7zst88skviHOUPUFDIcx33/Q0NxVfk6rZKSgfBeYB2PR8SXDjPCKP+KKtAPXwSSGxu4OZTfGN4iv1YQ6ur5fk/N0PawFoKRZ0CB1ki1emNMCbt6UhXCI10+3wTWxZo8LZ6BsXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2sxnzJbaEJXOhhdYf35veoJIAbGQfMDbZrRfUiefFc=;
 b=MfSynpfB51oJx8TRa8P2OTCcDWwrsJu8i+zwNpdHOmyZ6jDHg8JLXxWvXTrWoLyeKNU0kRZW+7A1a1brCk+SPeQnVZIVUiVEFbgaOWNbk0hUrbx/t70WtplWKA2vcctczCnj7yoWx54/QwfVZzE87zXzNHcGSzYQfChVJQeW4VsliW5NYGkruQbXtQk/Q5Z4pwI7CiwxQzWbzXalNodxyPvWgFdUZURhrpcRvoe+aVDJoRIjKBjhjzVYiXNBDhaCY6sNFG6TjaukpfsLxEo45ykiF6BwgjhqsUhoV6SnWQn6oCSQ+UKLSJYoe/R4XROgCbWclZafSpU3BrVUDgqWpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2sxnzJbaEJXOhhdYf35veoJIAbGQfMDbZrRfUiefFc=;
 b=blkNN5fgsGhJdunT2nZjPUyIRm0V4pv82F9+rgIANSgCK+2BFJQEaP+ExI1aTISV0fKfoYobxVx0mykwbazwm112C5w7LDUCG3GGCuE8elVsszUkuLQBQnF045WRdH4N6ESBerRbK71n/DZtf44MqTygEKRASFMpn1BUfiDWkn4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9247.eurprd04.prod.outlook.com (2603:10a6:102:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 07:48:32 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 07:48:32 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 8/8] arm64: dts: imx93: add lpspi nodes
Date:   Wed, 31 Aug 2022 15:49:23 +0800
Message-Id: <20220831074923.3085937-9-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b3b6ee57-ca9f-4a11-c9df-08da8b253365
X-MS-TrafficTypeDiagnostic: PA4PR04MB9247:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S/b1NnR8/oYJCKW2PsxOw0KZAV/6fabYDh2B+cZJPviidqQ2QbL81sG2P0W4UnwO+Gy9R5oBbl5rn6f+O6lUcTlLLVPW5CEMch5zuXxws/WcbIR9ue/SwRysFbaXv1E1zstWtA327PCZf4FZ6xSO1fkIi3do/SWFgY8uTBnKS0zY0iUtt/c/oR1M0Zf9+XZFBTcXJhDum4DUz44YhDnb1nuE/sq9JnQePoBTkqzT3w4ZLzpUBji8W/Gil8yV9CSkd1VuQ7jF2e/2GscplffsiBUE5WkiWPfTPqkvLhbh5Qm73NSVO7n3FKWmakF9UBPaAXTOrIrNd+xUeOcIVAO1pjGWaSpOsR6ZeC5sSSGh0VNxI+TAxScx+Ate2EJNA9uh25afyrW4n+tjZf2gktA9V588LWAzReBsAKGvibmeNGpez+tV2C+fu+vYpNhg9KMDAcIJAL9F6g775b0DL+dlrPfAYEjVHxhLNspPTeUjTid7dusdPIjimq8xyAJhSjAbBFRr6AVW/ffy0FzGxRo7YfDezyMSsMdOdXP38DVMVdOtDT7m3o5d3n7uBxCfZrNYgXw3L1KaXUlTkFatHuDGyIApxe8Ar6IuBkcVIeERUH8yJPDYrdhC0syoekwAjNtO0DNN+KoWGmSuypWyluz/JGE95hVKJpF996wvrry71DDmsnRAMpRCkkxXCZlF4ZDqsRIfk+/swqLspXz/hFOq8kTg7wzyei1j17K7Y0JKNsbMFKPli8mBuk/v5ujieFqMwFHy/8BwbfxcZQnxtbEcpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(66556008)(66946007)(86362001)(38350700002)(41300700001)(8936002)(66476007)(38100700002)(4326008)(8676002)(6486002)(478600001)(5660300002)(83380400001)(186003)(316002)(2616005)(1076003)(6506007)(52116002)(6512007)(26005)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?py1nnGJO8UvSX0QOURwOiEivguIRJn4jkw+psdIZysSGcUvSKYc7niCUlFhs?=
 =?us-ascii?Q?/1JXn/fkxhU4HoB+jd9Zl5yoLS9pf+PDHy1iAP0ktSjafgl40ICbR9jgOJre?=
 =?us-ascii?Q?LWZFkiKMR9yL9o/+soVStPPTG4ruKUh347gZvH+dwOCZVOYiuksm5mAKH4We?=
 =?us-ascii?Q?3BFTOAWlkP0vOUG/oB0Zgb2TG3goQ6reg4usSpOgcz0FHzyKKpi+UGy/HdJU?=
 =?us-ascii?Q?R9u1uDvOMJmIhbTYUSvRybmnE8Do9LWY8iIlD3KB+ao/e7cEJIvro5LJwkKx?=
 =?us-ascii?Q?L+IxbfjN6IAWYAKViZpdVYLg/8PjHbTy/NuWJZ5oRhDC3ajloG/bAA3Q/z+C?=
 =?us-ascii?Q?yyMrXf1ujRYygGTgN8A7ZG5K5074RLaMt3IyKTlQTREdFqO0dRxjHj8uN6uq?=
 =?us-ascii?Q?Lj9/fkruOatrijLiMWBQ+GlT6/Vl3QKLTo7Y5V9aBQmsvWyrzXsAJ8twS3MS?=
 =?us-ascii?Q?9G6Rmif7b3qB/v6QEgBUG0iGW/SuzCRaF8/CZPreRmYqK2Dya/6J2j8g09Dz?=
 =?us-ascii?Q?t0fHM59qLdcMkMLXE5Gd7ViWZ49E+a9Jvgfrto6Nq7i7JmMu4v+bhiaJebwp?=
 =?us-ascii?Q?nMddEANlaPz2KAsjYat/sdSKFtxAE8ihbT1rd5XdBwk3Ra4eltqa2sIuGm5d?=
 =?us-ascii?Q?X7jYH2gK7MP7zLTQWWxaTWiWJ35xHvyvNE9pL0feZUv51dEx/EZLYH+dwD/B?=
 =?us-ascii?Q?vHsuoYIKIsTTQI605yfN0u+T885z7gZd3hsU0Edcccn4bWcE+bK6v3FjKOJc?=
 =?us-ascii?Q?GP3oaMIpqGnu67C++T+U+s/NmzH+ig3Ti8gMrY6RNVhRqRZ0gosulQlyH7cE?=
 =?us-ascii?Q?moNqSKxRkQiogSQ45si4hwiboAHwR1hJjgqqXI9Zi+a6TP4wR5eegY91MawY?=
 =?us-ascii?Q?nYHMjjwigjE7sFM9VbGl2hg2/N802B1Q8Y9d0jH/Xv5tKrwW1phku0o1Sw7a?=
 =?us-ascii?Q?Wrv0KA9YTOudP1iWeexP0y+QUW1a6okE9RbP3hpyRfvlSVC9gQ3miEkuCGn3?=
 =?us-ascii?Q?McgG6XwEUF/9rNqGIA2qpgym9kH3RWFDvk98n1ntdFKp5oh0fc9hFHPbsewv?=
 =?us-ascii?Q?PfjCyWCjcXzTCoE+HZ4LZCocSJY5KNhsgxVF34Hbtt7eClbqUN7yLQsp3Uy3?=
 =?us-ascii?Q?DsAj1TzInXxeOmjkf6EdUCR54dgy8bRRQufAnHZ6e691Pc1N9JZAMpAbBQyp?=
 =?us-ascii?Q?BWo6eATdMf5ktUu03pewyoQwC9r1bBCp6e6YMdsqJ9YkXOg2C6y90PtWcL88?=
 =?us-ascii?Q?G96pQlhy2+q/LDTiCS7hU3NoOYzIfXVir8zIgTI0LNF4t4FJYeM1Mqu7oYcs?=
 =?us-ascii?Q?V7Bi40atfWRj/xRXIOsfMd/pR3HpJyOgIVpFltH9BS5YjPYO5yXRjjVh8muv?=
 =?us-ascii?Q?/Yl8Vmj3jlbhR5RpjIU+lfm0cau3DCC4/D9D3MJnbnElPBlVbTFrGd0iR5WZ?=
 =?us-ascii?Q?gYMe1a8XM6Us1zB6doEqybfnF45cGRTacX+qtRRHwQfkPzGMOzezF42GtYmo?=
 =?us-ascii?Q?esc9OcbePCceU3AwQbB/7iYluzRwXBypMWC3l66HsPc1dgzQeWoRMVOXaGlA?=
 =?us-ascii?Q?8QIeUh3sOKZKpPGsWcMKUylCQCIJ6uQQHlh54vqD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b6ee57-ca9f-4a11-c9df-08da8b253365
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 07:48:32.3694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGiTCFUjmguhvOW0v9eID1ecuxWAEsfQmZEh/v1q+3Tf6xNEptVF85g42UDt7mzSZFouoNtDnyY9AYw8ZZ7xDQ==
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

Add i.MX93 lpspi nodes

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 58f36897bc5f..281371f6d6b0 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -166,6 +166,30 @@ lpi2c2: i2c@44350000 {
 				status = "disabled";
 			};
 
+			lpspi1: spi@44360000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
+				reg = <0x44360000 0x10000>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPSPI1_GATE>,
+					 <&clk IMX93_CLK_BUS_AON>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
+			lpspi2: spi@44370000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx93-spi", "fsl,imx7ulp-spi";
+				reg = <0x44370000 0x10000>;
+				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_LPSPI2_GATE>,
+					 <&clk IMX93_CLK_BUS_AON>;
+				clock-names = "per", "ipg";
+				status = "disabled";
+			};
+
 			lpuart1: serial@44380000 {
 				compatible = "fsl,imx93-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x44380000 0x1000>;
-- 
2.37.1

