Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B27F5A7FAC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbiHaONN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiHaOM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:12:57 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85686D75B0;
        Wed, 31 Aug 2022 07:12:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvLk/vW3lki635VeRUobsU0WqccGcprzE/0DNyUIc85ryee1O60nsMa//KAacBvl+WFPQjI/T0cOoqeTXvrW6LWAR/8UNB29OtN48jTaKCil6qBHn9w1ry6SN7MRo6FeSYVZ+y+nRRaASl/Nd+hBqb6VJxnpGgeI4gb1dNrW2tGFEAYXUUbQZ919Giisl0BNEQT9Kgz/Vr0AJKs9Yg/8kM80nXwkgyt0p9/FhLP7UjW5mbhScL69X6axWn8ODIUMB3iyMincuk92L9BEF/pfuUQ5EZkwXSx1QUv1ip/iGcjvzduckwaWIG9hBJSY6TdATArr9ap7ZUjEXC710X3GYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qedGAawE+bjuLdJAEnylYy5nrgKN0Dzq0qCkr6S76w=;
 b=QBjzG7h3wtRR0NGjj5pxH5ZQCthCtXjzhNCUhNoLCtu9pN0O9X3xMaYs/KbX1p1WQSSQK2JccI1EdoB2HLxlmtdbIYyb9e5POsrUVj9d/Des1uSoCgQE4HhFbX9CepA1sCRDAIIk4RTFXzJ7BFJqOrUdFMRxwuNurR7S8MIKkV9Zt0MCh4mOLif4FxK3fknc12SPQOWoEsAdMmep89fIhym+uHZmS3gMkXL/mneHdaYp7sf4pp8najhS6qh8uGENHyPHnGmVb7+qN9YSjN7vGvRaS/yvtET4JiCBc6gCEHNA5nY5UvGuGyv9phIwdtHFrV7xTPJjfQWAMDokgi1VMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qedGAawE+bjuLdJAEnylYy5nrgKN0Dzq0qCkr6S76w=;
 b=U7/WIqLHUO53uOAs4Agf7rwh3R5COaxUomeFgEZIVMGLZ/mlwrpTS50rMiiqrFDfsAUQc0N82jTdIlZaOk2NuHaGEbM3gcPkiEHF8uLERqkAP00+78emSFfrTCj4PCwx/5WXdI5Ikp5pAvtcq4S322d+AXDGG2UIXAOKsSw0m4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7355.eurprd04.prod.outlook.com (2603:10a6:102:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 14:12:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:12:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH V3 2/8] arm64: dts: imx93: correct SDHC clk entry
Date:   Wed, 31 Aug 2022 22:14:12 +0800
Message-Id: <20220831141418.38532-3-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1e08773b-b3be-4724-91d6-08da8b5ae2cc
X-MS-TrafficTypeDiagnostic: PR3PR04MB7355:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: woBGYbPcjdMHg0Vp2snosJuKJbradUluysJbStgx3q4RyAWrukgjSLKSGsJNo0MqHNArQU/padThFyOR0TkRnKyjkOnlkvOmSvxoCB0twwPS2n6od+fL7yZqUt1UM4WFZUY9oFSGktrGLMiJR+o69LchoIYChosamVActWOfcyqDQg16woAmshcrJgHn+/x/5LZBn4FFLAXtUg6fMux7K5ZgySzohlpfXgw3XnfvgS/b6ZRCWba6cyFaJ31S79DnuwnysviUkYFIVhbsNvRv5R2hEFUfRywjA+45XMjMqDsgLdOjy1IN3aGDAFGrf/MRwbbm4FuwQOdPL2Y8RtWUG6hJXjuMZKGujq8RUetHEBBdb4O9Yyao3aT17abKlFEFCFDFwRZFC1J5Om3BK1qPb2a68cGAtS9/hk6HZ1PiDZSa6rE7dwhau3U0BXFspp624p/DBFtDS/trYuyCm6qUKkobsazYg8e/0ahS2GTsffzwzda3YA8klHQosWJZHPcH5dMst4MpKIzNJQywLhuyTLTlxfmBgGPcOx5Mk/MF/UE8YMNm57UoYZZKkK+i2mI0ks+sLdUaGsM3uChMSo7oIXPdZ9c2qOSbxj/1wdRq8qb53oOJWfpFAZRueXv0druLgl+rCiTNtEar7WIJTNYl+MD6o0Xd7/TYvLRaZl9Wmc0UK9cyRzTzbDegXaO8UagcxAhlpJ65nTzjzuZzIFGzrxCaBmHbmsRqPxNrPJ4rUYYVvv84FX/wAla8GLRiALc7O9AlOZBR5tBA7nVyHIh25Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(8676002)(4326008)(66476007)(66556008)(186003)(1076003)(2616005)(5660300002)(6506007)(52116002)(316002)(41300700001)(38100700002)(66946007)(26005)(6512007)(6666004)(86362001)(6486002)(478600001)(2906002)(54906003)(38350700002)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wMvdAC5mElGA74LSIVdYfzOWAwAhw39kkS9AHbGrJ8HH/YflXG5ofwJrnbz/?=
 =?us-ascii?Q?UwwLRN3bfPXCsoC/na/H1RVBxksmt0Sj7X9J/aSjyMzV0MVOol8vrw5k3Znc?=
 =?us-ascii?Q?Uv7XPCMPtab5mM9TlrjeHIIQsxgpy628cxZiwPy1ONr0WqdxQgOVafMDWOcT?=
 =?us-ascii?Q?iM8N5lzkjfS47ZS57+VwJGSGxTb74xE4ov7m5gxvIDkvl1Wvjs3pQ+Eb7oAZ?=
 =?us-ascii?Q?RAvJYP0j6rRPOlQXq2yit0Z6jFInQsUvx5AbDXt58gHqoaqiZMYJEPyqik30?=
 =?us-ascii?Q?pK/d37zv0gVt1zh6ObJk20QLy617zigargsQ76rCZEVjaB1mfBgJil6ubzA8?=
 =?us-ascii?Q?lGyn85DzOJnEXfdVRGKI+KjPKznqfMXwyhe3BgSl7v1H+atZV89rKU2wH+TV?=
 =?us-ascii?Q?PNFB5ZElky2QaEgtxIazexk/6m2a0PvGnLQy/uEbJsYzyBHN9kD2yiYerGqR?=
 =?us-ascii?Q?lb2rlOYr8jXbgFswASNt7k3zratXvDcfVSgpot/k1FgkNtkQtfBuIrYx9uy3?=
 =?us-ascii?Q?1IGoJBEOxn/alwfl4sOipJOcor4G5T3YxO7gvL2H73orcSQuOcQFwExHBMCC?=
 =?us-ascii?Q?NnMWpgvbbqQ8ZMdcieWSnBrLAkQdj65w96v0AvAsoRlWnFn2D6qsVe4wK0ET?=
 =?us-ascii?Q?weqDXYbgttEbvV3BiZHJsgp4EqFFedyVeVHRqmw2ZtCSR1iK9zocgc0HEuRU?=
 =?us-ascii?Q?ZADbDR07WiVAmMq0hAEsrYgaCs8rln9oTEBj9tN2XlBvc8v2vIvEEWYwPqI1?=
 =?us-ascii?Q?diOFM7hqM6iAx5x8nlnhVVerCA3BrFlEA23VvJchM+jGVGpAhlujyOL2jLpS?=
 =?us-ascii?Q?mrEYiEcroHxGOpzhfau28l1zwTN5pCPpDsQ7szd32ABigPkO7kml9xZw/6V0?=
 =?us-ascii?Q?Rgb7dVUF2hFduk6fzrm7ccISCwgfOfIOtfWSAshLM+iKN7uRmZf0ZhrzaPvS?=
 =?us-ascii?Q?+XI864ZX3QggKYGftd3cqdWHcQPeNz2R5YWqDQg/n+mrtw2lHzFu7sZ9eArc?=
 =?us-ascii?Q?YvoBTPljx1cVjl/u/CSSR04tD9hYr8ST6096E4f5UZGTBrA4pIgYm8FQfG2H?=
 =?us-ascii?Q?EP4o2UL0QOZxFSSrRCywHklHgrJN6pHSNWxBpkbJYtaFqwukP2je8b3FWWVt?=
 =?us-ascii?Q?oDgGEF2KLKGHYwGAbdFZpQaZk4AAwPLfv/m7AuODj5gaPYon1mtuFCt2nZEv?=
 =?us-ascii?Q?bYt4kTI8nqXAHKpu8zvKcypl5i7ZQLoTZVLwqvrHNe7pkgg69/3+9/WqNt9U?=
 =?us-ascii?Q?PwX5G528g6bEku+2dqMT6zJctuOm3fL11osDwkvcQP9n++Pznxq4Pe/VmxYS?=
 =?us-ascii?Q?iO/PWHTccZAFgU+Zr1N5m38HcoSUAHzSIZ/lVNmh91ri8aljzYKgbP8ZEReJ?=
 =?us-ascii?Q?tEjKOTh5eOtcTLobx+Gau0U69xNk/OyfvqLP8+kXr67lVCVK+DB/FoSK5oag?=
 =?us-ascii?Q?1kMx/nZNWDVEpAMDF3G4Svq+bD4tTZMSLqR60ctkT7w2iWBrWMnKhDHp4T7e?=
 =?us-ascii?Q?eSqTtxPuSdG808Lmz8Zabq2hpwWwNmk19jXdJMCcGQhZgKSDtP5EU3lHDiuc?=
 =?us-ascii?Q?y90uvqiEeZz9Up1O4HVPzeRxP1ZMboha8GUKEiHy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e08773b-b3be-4724-91d6-08da8b5ae2cc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 14:12:49.7533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KmK1iG1Pc5T8YkjADXPYt3CNjs5sSnHg8gU51VyeTztE+lPxUi2oBWNjc+ntqbh6C7swI4MeTd90FxhTC7TGQ==
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

DUMMY clk only works with clk_ignore_unused and bootloader enables those
clks that required for SDHC work properly.

Correct SDHC clk entry with real clk.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index f83a07c7c9b1..431dc239631d 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -248,8 +248,8 @@ usdhc1: mmc@42850000 {
 				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
 				reg = <0x42850000 0x10000>;
 				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_DUMMY>,
+				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
+					 <&clk IMX93_CLK_WAKEUP_AXI>,
 					 <&clk IMX93_CLK_USDHC1_GATE>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <8>;
@@ -262,8 +262,8 @@ usdhc2: mmc@42860000 {
 				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
 				reg = <0x42860000 0x10000>;
 				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_DUMMY>,
+				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
+					 <&clk IMX93_CLK_WAKEUP_AXI>,
 					 <&clk IMX93_CLK_USDHC2_GATE>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
@@ -276,8 +276,8 @@ usdhc3: mmc@428b0000 {
 				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
 				reg = <0x428b0000 0x10000>;
 				interrupts = <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_DUMMY>,
+				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
+					 <&clk IMX93_CLK_WAKEUP_AXI>,
 					 <&clk IMX93_CLK_USDHC3_GATE>;
 				clock-names = "ipg", "ahb", "per";
 				bus-width = <4>;
-- 
2.37.1

