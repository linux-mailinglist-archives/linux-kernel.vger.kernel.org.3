Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D48590CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbiHLHoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237537AbiHLHoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:44:44 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60071.outbound.protection.outlook.com [40.107.6.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3908A6C11;
        Fri, 12 Aug 2022 00:44:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPcikr7Knb3WSCqXM6VpB/5VAXD4D+U8mAv97dDW4y178V7VzgsgNrpvOPNtZxjy1X2FKqp/JMI80QE7M0n6qTICXposfvy+y7uoril0yf3fFuwmXXw1xsxX3hPFraeeKv96s4ly2FrkTD/h0gXLhMckEwVe8jek+JEIEEQAyyBiMGBF0Q7N3xp1R8VF3tOqZmDAzMjNtnJTZ82dZ+R6zqcMPTldYiMhxoy2s6h9HR0tHpOiS14PQOGukl+TUX9hDkDskVuKdAYoUILenCHXN8ocH/msoD0cDnz2QVVTxKwsdx1d1yK3Tc2I1BZXWlzQE+0dBfABVoUKqnR4O9VUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jzF5bfJ/8npWlPnzTODZW0dj63j/TG1QjRCIWaygQo=;
 b=hhiVJGzQO2ByClgjEXDKRAzWt2Vvw7aBar3D2FUZQUI73dQKuZZqvoksH5nbEBxSoybssqPpBU4MYyk5xTBQwc66iSEPMoV8UmvrL78spkHv2enjJDXLpyWAe5xuAAoQIvVCK7KhTjj+6BQJpfDRmD7j7nzUwNDOCWP4+WzeLgb70ink2NFMYptSrqRTkwgUdjYtfaGo8h2T0NpDnfvXO8fiZRdS6KzJKp8n3R58Cvbne6e2ZTrgz8z6qUH1YlB7cRjkfpLq9ILNa5jUkElCmV9kIN2jqWBO9vYBsskZhzw/h2IRFWdYz4t1UieNVOFNBmi0Ej57AhMhYiWf36Hsxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jzF5bfJ/8npWlPnzTODZW0dj63j/TG1QjRCIWaygQo=;
 b=jKYMniwIbgUX2C0sgJN2WRRIFpdSinQIopXFIkOwhgRGx2uunZB4d4g+g9PZ2ebO84x1oUXhCm3IJJtPe/4CCyvYGdw6BgaSNoHfIrsFCXa6BHx5ouwMyIk8OvvMG64JXyPQLCf5UMRoik9+5rI/btXW3a3oTQALr5enxortWZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2922.eurprd04.prod.outlook.com (2603:10a6:3:d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.24; Fri, 12 Aug
 2022 07:44:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 07:44:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH 2/7] arm64: dts: imx93: add gpio clk
Date:   Fri, 12 Aug 2022 15:46:04 +0800
Message-Id: <20220812074609.53131-3-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6d9698a0-f760-4a1f-d357-08da7c368259
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2922:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOOVSJyRcTfbLpERKDpCu5SiW9hD2mgW7Ngak7tSYpv0CLpGAR3Y/doNuSP1/PSbDuOkdLUIhetAkTJbUhhNAXQQ9C1KElb2A6QiztjsgO9n9NiJqOZ+uiJ9CpaV3VTqIU/3gRxuvzz8FQaNy3LlTbGiQq2gLBUP7Ki55w5cyB62PTrZj/ywoG56sssZFeFr5uisvzpfp59gBcFXTL/7+5w7ajtMLzv6A9AZpwbvvbG5r7F88YGf7ZsP/4AyHuq0ydbNTE7UmumRsCqeeiDSp42KStkxgc2xhNWcPIJuwW1wU75s2DX5qYB+EXnlREw9H4kfYO6X3u4UWELniaWXLJ4ihw2dJNI0nw6h+m2FdRBrUi9qDEMk4g29qe0gkGoymhxx45OnK1eOe09FOcCG0pz04dlCaI5U9TuaU2tCQwYrsarenJ4VsTpToZhnZJ+wMtu+y/UeCjjAC/PpaA8X5szwq1npXGA47f6LW4ql2rWYW2ja6rcmXOPljhjjydjZLv1p2xacBF911fCU2YJ2akRF/ifTUZoPL9sXYzLkYYe0ywLHuWMxYgPizTFUp1vmSpFW+th4b/iBULd++EJi8kl5NzzUBYOavNbk17VzXdsCKumYSPKASSDpOXT7T3mU4Xgx5SrEkURzZCErOuWG1D15dCV/YAprYgYrGpcWnZb48oN09sH8fr+CaYsHYH1g2Rb3/T1W/rj15dIalFX3S2+HGSZGHIBOI+uQWNvYVXkYFjVId4lQAG/xRxo8Dbo2aNZp2Z5WL/maTCh9aD8uLD3Ipuyh/FJarGjx0B4sd5pKYFicaQK9soBx4x+bG7uO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(86362001)(66556008)(8676002)(4326008)(66946007)(2906002)(66476007)(38350700002)(38100700002)(8936002)(316002)(52116002)(54906003)(1076003)(41300700001)(186003)(83380400001)(6506007)(2616005)(478600001)(6666004)(5660300002)(6486002)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D+dAsZVK74fEf9Rt8Lcu7YSOpZZfTNRAjFeeC8+D+zbQ8B5mBQqiYHu69+r6?=
 =?us-ascii?Q?JEThUSHsWQQRjAlZSVzGmlAaxa7FTxCP3XsRJwuHZsTY8fZ12pd8GWn1v6I7?=
 =?us-ascii?Q?GRFguL3LOmjQvP/vnaffQP/E37TWfsQsBFBo8cU8ukxxvhN6AbZg2n+6Hcz3?=
 =?us-ascii?Q?tikumppQ/4hU/qc7GMehdr0RjhxufzCleEQZZu9ogc+CGtIZX1EeQMm+tPEc?=
 =?us-ascii?Q?Z9v2JZKjBhwFnyeCQGnQ9IiwDJElknag00IHFaf4XudJJWkw9TNV8nMr8Ci0?=
 =?us-ascii?Q?g7qe/+mHEXUiwhF6fZs6esk4Gwjb+mHVHqUDWIrrMk8+4IwRu8cUj6NcZDqv?=
 =?us-ascii?Q?lvnBnfzaLWPdmoSPrNKtnTi71njsnp2K8OnJBgG14EFtNR4Lu2au41Nw/XyS?=
 =?us-ascii?Q?SXdnNQlUzg/fEyKro+wf+l4Ul1whZxRQzMxpwhAo3EKUlzfR4xopvcljC8q8?=
 =?us-ascii?Q?MA2aTKgRvNPTASLvqX3KzjmuGgybXhVuf3i3VBNHaelG/PzEvGs1yNFblmG4?=
 =?us-ascii?Q?xJxG+DihKkvb01U8fEZCszO/vaS9p3r8FSsNOb/TaR36NHZYubMqI7yhzyX0?=
 =?us-ascii?Q?uSRb96h7D+w8B/P6XbvXpWBlLpDvszYKcEpDyPVQ6GbYRFpI/5AWPuvJVZh9?=
 =?us-ascii?Q?/CAgEh2+R5+tHTNmz2jP5l74P5C2EpwFGqPBsfsjSIOIDdTToeSAd7WAXqCX?=
 =?us-ascii?Q?RpqcJfD9Bs81w/+W2u7+Lbm1DSSUnh0rhx9kwDSY83ddaQW+vdnVtXfd1bur?=
 =?us-ascii?Q?UHTEAJs/ezy1FYNp53Ft/GKn3NQZPjhbFBM/XlHFDrKdpoqaBrhLGl9G7tBt?=
 =?us-ascii?Q?AM27D9w3Ph63X7mBjajNSJB1u4mUFUDlFN4a1Z1oPibIns6/SYHVnxcTNS4k?=
 =?us-ascii?Q?dh302aspCmhRbIyMMYBUq4dYZSSAoajEuI75nILjfZ6Wr7tU6ZuJtzAZ/nbW?=
 =?us-ascii?Q?Mqhz7XlNAaXhc5UTAkBD3/3Sfyo4Yuw1vt7ckDItwlXmGBAj77sD+Aoqx3Uz?=
 =?us-ascii?Q?XXFbTxRkZkVQBfZp3FY8I1ye+j1eTqr302rL+TO92G1XUk9Rze+GnKPeWnlH?=
 =?us-ascii?Q?+YevQmc98jLiHBFFcR1Is76w0DmChv0KuN9XHW4RQNU6yFiC0nEB7AWlh3Pm?=
 =?us-ascii?Q?EXbNDMHgXfvkSOAlBRwBDqahY6/ldkUMuOWnI24cz+5K9aL7wE5csMixXvAt?=
 =?us-ascii?Q?UZucPc/0PcI5DBGybJm+dsLM2U+fzHp8OSLquUPVXPS56tJxFTtr/PmvrLD7?=
 =?us-ascii?Q?5a7yOya5hGtn1k71kAL2VlkfRZHJZd8RDeTLUU8OyWaLgb5szmvwwfrEKn+W?=
 =?us-ascii?Q?Vyx7c9hef9vNQ6ohdbgLvZxjSvz/WGpefrqgFX/qXq97mS5Hl2CAMFRZHE5j?=
 =?us-ascii?Q?BIPz11JiKfw17KzhtoVLRYW+wbt4Ka8dD6EOp+CNNY53v0DIFMjz8mCNvdnU?=
 =?us-ascii?Q?B/1fvGry3sku8OFzE9bHuBzuhcfCQvIwe5FInanfEczr5rtzAa5csFr6EeXR?=
 =?us-ascii?Q?B6OxQ0OzXWejzHUPi5hh8+3+btfrk+ymVAgOngi4S51HyDzk2iZmv8uGkWfT?=
 =?us-ascii?Q?j9Z05f0C9NKIurk/AW0o4+9cclzN1cIAYb7YbWeK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9698a0-f760-4a1f-d357-08da7c368259
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 07:44:38.5068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jBXACLowiaGVXFX1j2wOubxhm3WJYsH7GastxUvz+9YMr6ewlwkP+xaPiLnC5bh0UpRz/O3wHyTzAHWQQLLEVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2922
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add the GPIO clk, otherwise GPIO may not work if clk driver disable the
GPIO clk during kernel boot.

Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 431dc239631d..26d5ce4a5f2c 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -295,6 +295,9 @@ gpio2: gpio@43810080 {
 			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&clk IMX93_CLK_GPIO2_GATE>,
+				 <&clk IMX93_CLK_GPIO2_GATE>;
+			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 32 32>;
 		};
 
@@ -306,6 +309,9 @@ gpio3: gpio@43820080 {
 			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&clk IMX93_CLK_GPIO3_GATE>,
+				 <&clk IMX93_CLK_GPIO3_GATE>;
+			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 64 32>;
 		};
 
@@ -317,6 +323,9 @@ gpio4: gpio@43830080 {
 			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&clk IMX93_CLK_GPIO4_GATE>,
+				 <&clk IMX93_CLK_GPIO4_GATE>;
+			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 96 32>;
 		};
 
@@ -328,6 +337,9 @@ gpio1: gpio@47400080 {
 			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&clk IMX93_CLK_GPIO1_GATE>,
+				 <&clk IMX93_CLK_GPIO1_GATE>;
+			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 0 32>;
 		};
 	};
-- 
2.37.1

