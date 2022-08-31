Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1265A7802
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiHaHsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiHaHsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:48:08 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED8BAA35B;
        Wed, 31 Aug 2022 00:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNfBvIrvB5OFKY2c80rBCdzFMp/zyrThg2ELO9TTBi+mqjTj3gC316UswSsb4aEuFLc3JSSS7da+mKFjWFYZzs1bdnmZdPH8v35HXqln87D01Tc82t7iw1dZOYExgVEHPvNRhxQIPml8pcp7omdekBrT6/XDsDcnDCg3ZnfU8JzZhibNGZ1MqYliGabJRRndHtOblLy35D+v429eN3dVq7v5x903bqDqFFLuTyUdfEbqWt0HJPFOsjPkAaCvIjP/FPOekBmeKYGS3/qk4KmicUoAyGLRWinToRj/zyuUZRr87VNS5bCEMzHxUEI3liIKtLJ5DGQkIVJFu2zqpYZ3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qedGAawE+bjuLdJAEnylYy5nrgKN0Dzq0qCkr6S76w=;
 b=FPUG+qs9LIq1ExKXi2AN5C860v8VAvaX8IQkprf8891V+d1q8b5bAtVH6WuNBH9fP/dzx5MYKGzxW67vj4tGhAXcWEqM655K7OsZ3UpO0IXo2tVkX4oy1M1abhoQ/Kos7BnG8EolX25SUxaDbGb3OJavw78z9Uo7MAZqIBxyr2CRgIHFKxuZ5man168K+ZjVzZW2IxHoK6qITfureAeDMyFXnQPWAofnUWvaAIMLVvaehJb+93GSTj6OkeDLnio2KScQ3g74pr7ChGAK92/COR+51p/QsgRWaHHeXGQ6hNM2z1r0+5prk5dPDCAjSQNtSpwDwn+TCSui66DdooySGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qedGAawE+bjuLdJAEnylYy5nrgKN0Dzq0qCkr6S76w=;
 b=l6QR4K+rwPCOtuqLhuwfybb9pC2ta+TDZSX2eGy/WZcCNIfglN3UVteJs+P0rpW8kNKcavM4/JKokmW7JK9c0vQY01kdVB1FtIyKBKJupx+yz0iR9G2LX4xls7OJLCZ+2qTtrxCgOTYaq53fdIXUqPWNwMbBOxCoamQXE8IF3CE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9247.eurprd04.prod.outlook.com (2603:10a6:102:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 07:48:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 07:48:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH V2 2/8] arm64: dts: imx93: correct SDHC clk entry
Date:   Wed, 31 Aug 2022 15:49:17 +0800
Message-Id: <20220831074923.3085937-3-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c5cbd2eb-9cc2-403a-e7ee-08da8b252046
X-MS-TrafficTypeDiagnostic: PA4PR04MB9247:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMreCQBYOwYo8H7I83rVpnRvSGGlV7ZE7Hh8o8oLh9OxTyTSlyBjn+yUfpBMdg59qlU1+fByywt3aUhxvbImDHRnOjWhaZ3oi99krq/QN6ApiUejlvXe1Nw5mRctwMnfTyOn9QOK37aJ3q1BeN0HoVAcAmNREOFCMG7sYjeTfqGzvDgHB7JN4VAcgJmuN4KC0SWqr1NQCQ6zbkbz+SF6/lFYa9WX8Srq0Gm6QdIFVzPk0FnjP+7osgYYSLOnwLnxKCMcq74icuQce90rXTQsIurhix6o+gPks89ssuoiOotk+bJGpheY7lzLXaUM/L0EJCUwa4a27Z+K62MgASo8raib95hsaSqryQ3p5aHOA6WfGTAccbCq6QR5K5WOYMs74JEvqo0kIBiyjQLqudavGtMHcIgAzK8BWge1em7a5OCGZjK5pM5rbVioTld/tc7nDctvMdrmwiB52eXl5OSNQV98ASjFgbyFHfamceKfIcscf/dDViPTpdLq2yXcao5qwDKPyjpjtS5zYSoJE3L4jUOOLROBdvgkgnnKJaP0TxHRM9XbOLvoCWErA5Ga7BKf4S2TDccWMvJT2Vjar8lBiA1B2YGwl4/EIJBKDqynAY4+jbH2/bGnS0KP1bswXfnqZFvp32EBtpHF0J+QIjsLKPnRpmkFzrvtwsIawBK/SsvDjH7YdvfvrutN62sPsIiJ8NPcOHhLQIwmDVN33Ba1mRLCs2IprrR6Hf9g7BsLm/cDNodXZmLW6sybsm0U6MoV7713yS126nKd5z9Q7j9VKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(66556008)(66946007)(86362001)(38350700002)(41300700001)(8936002)(66476007)(38100700002)(4326008)(8676002)(6486002)(478600001)(5660300002)(54906003)(83380400001)(186003)(316002)(2616005)(1076003)(6506007)(52116002)(6512007)(26005)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6+5A/9PW3oq7bZSdFmFiW3uPApPEIZrD1blqwi1MrHsvdNXEug8kTdGyXCit?=
 =?us-ascii?Q?n1lf+7Z88YtIVLbCUYLGqPioo3NEFUOscCZq6QR3Xx/o2arcavJIh6/cn0ql?=
 =?us-ascii?Q?9t1EFWuBFI4z9AdJC/9UFoF+jvKJnw0aWJ3FUW9t9n9Aj/9oeTlmsa7vCRLW?=
 =?us-ascii?Q?W0/I3dZ0c3J+jEg9rRgLC5NTSG/WKIjxqbuY3R/FXFCVko4K5xU5Pssbg+5d?=
 =?us-ascii?Q?gfGGv7HjmgZ7INRMxlGRdST9Hpowjy3rCG7DH2C41tlkNaeUzAJLmHzcaIN+?=
 =?us-ascii?Q?+YgWXYnPTc/M1H3VBxb0x3fptntrvos7DHIBSQokHr66zorVFMa5m06Hfh4t?=
 =?us-ascii?Q?BPRURmbi5yBiV5tABXaJUdWLTjw9gPzdWHLQ+rqrDMJeBfYf92p63u5ht0fw?=
 =?us-ascii?Q?bvj0iJ0QZ5S60YWNr8KZO5IiDwK2z5rB76OKnpdG0iXp+HqnmB6cL4IlsMii?=
 =?us-ascii?Q?11/SufBMGoS+3wcqQBQgBbfYwo+sDyc3dCI7Q5ae5ZQV7UlCpLju5+8KFlnl?=
 =?us-ascii?Q?MhV/ZpGYS7kxPmrobQ1jRr3xbsfirzYmOydaC0aoV2MQls+gahNJy+9nlJqP?=
 =?us-ascii?Q?LaxeF3sFVAQxoAdyMfi64Hyne/hKATBePhC3EQeeCirahHcAT9ptI7rcyi+d?=
 =?us-ascii?Q?B6CYJ1bjQUzNd/Mmi1bt6J9EM5xbKokD16kXoNbm2gzWXqfsbuoPDjB9oR8u?=
 =?us-ascii?Q?5wU2q0yS8uMi1gk3mL3imxzBmWzIskR+shlPRwYsxLxm7yE23JYRywHMCANJ?=
 =?us-ascii?Q?kqOBU/sCXDh93bEjogQ4Dx64GhVpZrXCq+LmjowdcKdL6FkQmCOjdJxH/NCl?=
 =?us-ascii?Q?p8Qt/RPnaKaTf2JORvKAZLBgPsOkyi9qe01xrTV6oEHMpXqpOejzevQ9fJIT?=
 =?us-ascii?Q?XgtpmS77S53JpB8SrARAVcQejF2BfGgLyMuu9HOUriZWmQ6Ha3RfR8szW88q?=
 =?us-ascii?Q?q+CEDMli5Vl3GPLOfD/kibIu6x94fYcr8Bu35phMusiqx8680V5XYveA+kg2?=
 =?us-ascii?Q?65lHSgc9Ac46ALgucnqyhRvMBFvaaqufd7LcBnFneBGM89jgJlTh8BGI4ukP?=
 =?us-ascii?Q?M9IHn7delWvNy4mjUduWK8BjvSmgLkjJKdyRnKEXF5L4Sgd+N8ywU4xAi0OA?=
 =?us-ascii?Q?Ldfw+66RRKUOqLuJ82KeG9fl4HjmLycZV1cSdtoMFgsMNwNlPDVK1RUCMBUj?=
 =?us-ascii?Q?5OimtyDy+Bgq3iT+CdpkSwLpni40r99y/t/IzZjYUO050obaEGv/zCwijXH8?=
 =?us-ascii?Q?ZE+6Re8euv4n90/UdYyk5qLh0lcWgl0CvJPOF+p6n5LTLfsxjCgQ3Su0CQN6?=
 =?us-ascii?Q?5jXkMoCugVBean3vrPlfcT8P9F0O8JzN7aonsMflMTNjMM/q6H78iD4fZ/qr?=
 =?us-ascii?Q?s/4UC0soGzS3vbqs1Y9Hjm7QZZq00eXEu3gG+Rl65P9k6zl4pF1Qf5PHKM7u?=
 =?us-ascii?Q?Fg0jq9zGfWVi+aOMY7NJG6aYXnh+daWA9wswNMngsA7j/2kdXclovCdlQKgc?=
 =?us-ascii?Q?Toezs1Ga9kPIaNeWRwbfHCyQKQiXDC+qy3e1ExxbSSqoOxQjoqAveL/qi30C?=
 =?us-ascii?Q?bI96mEOqEEeEch2ttfgFiDW+/BBUV84IxrGPR+7+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5cbd2eb-9cc2-403a-e7ee-08da8b252046
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 07:48:00.1820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJocHoZNNl9Hfh2Z2V6sGEIWn3wM41g8mJOcSN0tMLqXz7HHNxl6jdBk2pw2k1mdGrNui/k33aQSsvsjWUAwOw==
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

