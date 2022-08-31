Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4175A7FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiHaOOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiHaONl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:13:41 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2040.outbound.protection.outlook.com [40.107.21.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C76AD7CFA;
        Wed, 31 Aug 2022 07:13:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5g8gPeVoup/DGyn3jf+nCcpzcuREMw3KLfEUsxnHdat75YxQJDpj7JFvYnXPX9RkR9ZGhiF95Vll0sZi4b8ax6o9t12nGMRlAu9FdOkrJlLjtQ6DlXUlkQbN7c1Q9S3lsADQA9fc4xhaCGhSbIF9KVTxfNDlGN9mqtFfw1qSFs4yZNJOCKxSxie5nqUgS4n75VflS24BuYoFy5DzXZHW5Pqq5jPS1oi35Ix59dsijCdx+E0DABxwRv5Z2jv3SAJzCLpsvKuC5od4LXtkgFBtbBp7xfe0BMTah1nkWq3kITLXVLXz3D/RzIOdLuUFsCqTiMROhd+ErAG+26QksZEPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2sxnzJbaEJXOhhdYf35veoJIAbGQfMDbZrRfUiefFc=;
 b=ETm9nNh46o3BzlUkmT9GXDsBi8sys0MO0w/trlDO/VOiRpGMJJpK3CdenyJ2Hb7NGW+HXZEqOS4/8fnYnIrKv1ajc3C0/8WqFMcN7Nl4/m23u2H2a+g3up9ZL33C4n5gmZU/F8uL9UrXUi+RE8JOrKoPA4RjJmraY9sWs19rNoSHXQPCITUKVH9NdReGZ6nUmEYbxRxlU2uQXvPCTDY9TvJVZgPSV1unTrkaDoy4wNh8M0tbJsaI3ddK03v0n106r56vj62gBJtKrVxJQ9mwqg0X5qyKFaC0sLkqBp7HTgd0Ugm321VhZt66Qz9ssEOb4spCkGi3E0WisrcqjCbN6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2sxnzJbaEJXOhhdYf35veoJIAbGQfMDbZrRfUiefFc=;
 b=LDGr0hh73OX1/dHeWm+6NumUadxduCDJOsX/+Q2YUM30uwKakfQpCNNrWuw5d3vQfZZ8XrhK3UKqgrSE3N1LX96TSI8X/S8fsELG/xANNX/CrmLxaw3asjB5hdpsPQMK1k2i7/1+1kjwH43ijp4+dqCDdwXnA8VrAMDoWbZafHM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7355.eurprd04.prod.outlook.com (2603:10a6:102:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 14:13:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:13:14 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 8/8] arm64: dts: imx93: add lpspi nodes
Date:   Wed, 31 Aug 2022 22:14:18 +0800
Message-Id: <20220831141418.38532-9-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a2322bef-486e-4402-93c1-08da8b5af1ad
X-MS-TrafficTypeDiagnostic: PR3PR04MB7355:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gi6HRRk3Aps1rYiUAn3njJtYu52VCRz1akDyQW/3kHDvF05Jku+wqTzX2GmHl6/zHS0OAux0vo9spgUZdblZItUaHD9+XsQOp12oTx3sC31ESp2cVFvdtkuG0jwNzT+UKZNrq94AbMoXTQJmWi0xO9ExUtA6UgeenEyuMPCvhZBt0qku41L2l0huTydIacWzoMXInKwULyPkK6PuMczzGrjpyD9JVQ6UsAAfDYg0nIhzHBfy9z343Gx2wE+vnTKbF6AQQhFA14+cylwNJ275O8XDf/pl7uhkZItYYSJ4z2g7glkEfsRfumRMzt0faIg2qAy+Ym/1yf5vxALJCrGyK3t2mlnRm723cEzElJEVq/1L7iqt4ml0B1l/isy4CFTd/WPgDmPkwMdVM0C7jFTvmcrPqDeDFGsWi4JQiU4Ck0vW+3WCIQgIw88yrRQQqlbnOQXmhvTYcAuZvVzM0kiqNkZWmta3jiOVb8zThLUM1d/+H0+NcRD+RNgL2/50VxoGr95j4aLKcYk3IP5+LxHfNmUG7NpF90s0w9awPaqVlLnbPwR5KLb6MfTZPS1J0dql5bkmLr5mxmOULL0LDXoPJ/q8AYm4pbDXpQmqAL/vLriw+OhopTm9Lz3iLOY61HFNlRsQYkN/vfZ0HdHBgPHAEH5sTYDSLPYSXZ3qCU2zAOIBiwn5cAncmUVRDcCu/zkBMqczx9y53VYMHweJ4SQ/qxyjeQ3CkjcXvT93LjOTVllqD1FnbPHuCw+Jc9zh+K6EE3ONDprDyhp4l4EVZtE+1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(8676002)(4326008)(66476007)(66556008)(186003)(1076003)(2616005)(5660300002)(6506007)(52116002)(316002)(41300700001)(38100700002)(66946007)(26005)(6512007)(86362001)(6486002)(478600001)(2906002)(38350700002)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jlzF0U89fTXswCQfJ8VUZyZe+pLRWe8fzmjSu60ohBLBgQOQxZAKFWyBkyTJ?=
 =?us-ascii?Q?wSWe9SgdCEBOYTfWFL+PXEJ71bjiRbMBThE0U9o4UYuNURlq80sHvMWg/iTv?=
 =?us-ascii?Q?WwuLuY5NHC/ujDS/zv+I2tTii5YdrSyHRwhac2DlVXg4HHTlsO1Oh+gQWNag?=
 =?us-ascii?Q?kSumXylNSNwoS+UkrX8rG7dEExyL+PKjymMMnt8K91mL/0PKlcttgx9PnzUT?=
 =?us-ascii?Q?FxTVq6tLRBFcFUtz08umKEJ4d9zC0nKeRLZw31lOxac1o1KtfvXuCA9apeHf?=
 =?us-ascii?Q?o93pu/19ZMlAbYpDHehQlUwlOGPqsjnbxv1RBvKZws+tnyue6k4HlFKbuixD?=
 =?us-ascii?Q?7hUhUNVaNht583TnfHtagc9SZLLAIx8k7QiGjLony40uin2cuBurs6cpGq9v?=
 =?us-ascii?Q?Q4VMlg4QvnCn3eZEtvOAdxeoRSkJnOpv90cl5vGpK8dtsBBxTZnAc26u0hco?=
 =?us-ascii?Q?Iyg8bJBm6RovfYO5atWhao5mvfUyfUFIaEmWOjlRi6tXyDBowLXtQ89PwWgW?=
 =?us-ascii?Q?a+nxv6d8Wn+rOpVT2keDrEDDbTfZMu3ZmdFunCqHsDsU3oT9poplXiIMcjcq?=
 =?us-ascii?Q?pcFSF7Kp+4n3VuMAFwHEw+pTMejqvU8/7OHwR2Q+aLeiMVFhzS7VkxwKNhDA?=
 =?us-ascii?Q?0AMZlEMzxP+j5nRnSsLxFoQdBkZZ3xAHylrMaqmXukxJ7olmbrKZnSbhb06f?=
 =?us-ascii?Q?vQGQxkzIeHZetX53OM1GoUVc/IU+kVk00XsDfjaYxMf83K5TEZ56xOWniIzv?=
 =?us-ascii?Q?06YJOWn4CiQLDrV+XKhRcfMZSfZcGwRQu3u1z84dHFzUE1t88a/G5mqTVAYR?=
 =?us-ascii?Q?bbReLfCj3SLdIJ8QK0Hpe0jZESm6l1WxBc6yq40yqnzYfM2GXyJCoiYXiDzm?=
 =?us-ascii?Q?p6rlmEmiTR2HZE0scX5RVmGALbKgNedkv7LgEQMs08Fj6Uhj/GClvK4Fmqwk?=
 =?us-ascii?Q?s8hyQayABZEj1/FMsb2/O7mMyoOhzHQk3UIYNWjDCKeXV+WVOQLlzsglp4BF?=
 =?us-ascii?Q?cJcYwH+unK9ttXDV6WGwJiSH9BhLgQqbIAQBgmT8zpctod7F5FvOG8/LYBXP?=
 =?us-ascii?Q?tm6vZnJ4gN2zIeC9YQ4GPA7LznW5nd593uaBW32dEdsUKuXWJtFgqUcCamcq?=
 =?us-ascii?Q?0R0jpsH/TqJDPLx2UElHIcP4hoWkEIfndR2BccM0B0V4yZGBlqUEtR3sl4qz?=
 =?us-ascii?Q?oyW7PythtKHY+APccQMp4r/cI24cUYnofN1SHzbt/VOBRVVZKzVdZ9t/XWe9?=
 =?us-ascii?Q?dRF/G1iz0Fd4mWNsQ2awlaF4JsosoZ/nZaoeWbNTbC3ToyqQWVE6T2gl05ZQ?=
 =?us-ascii?Q?kc5M6+8fo8jDyC+Ysf3/o4JrLLYhipGZqK6d/QEx1ndxGN5K48hHNks8X4U6?=
 =?us-ascii?Q?KVdd7+lrmul5nlCiMxd6Yf++GgTJMaYZIsI+lVmEhy8mQjpm5YW54aVtoXU4?=
 =?us-ascii?Q?+8zbptfWv4ei06bval9qOU/iRmytENA9TBjaUupnhvlHwPoPIqNQwhFIuJTh?=
 =?us-ascii?Q?8VPSq8REASHH3Itr31GKvSb6ni25O7jSo5Mckpey4z40UJXU7kKT2LacyzIT?=
 =?us-ascii?Q?Mn+HJI+zoGV10L33hBPKwSMQ+bZezyiSnf3hRc+y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2322bef-486e-4402-93c1-08da8b5af1ad
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 14:13:14.7785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMnvdnKZ5AvvSRwE2L/6R/bSizque+gcI364B8barT6lSJuato55g1ea5WqZB2gHzrZO1+gcdJ70GS8ssF4XHw==
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

