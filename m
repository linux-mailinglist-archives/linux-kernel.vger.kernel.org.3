Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD445ACA23
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbiIEF7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 01:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236547AbiIEF6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 01:58:37 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81DB326F3;
        Sun,  4 Sep 2022 22:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYdzuwZHfXlEx6BjqWUoKwRojiab3hbG0h5+zzySKltfRZXMa4wwYGvjGMWhXNcapgKqSLj0susYOWFuNEKvoG6a63zMhPV58sKfGpe+oegi+ukDGD3dM8SWp1BPR7A64ciT3NS4Sv1CWJwTECxf+PkfyDgSd4lQLSByCRVUfgWbNforKnOqxtsIHtSjRHPtf5qoLDiaEC1ulMPaaqgjzMJCD/UmkzlUiEv+RkW8eM6rc6lKBw9FB+rv8EHeVdvs/vXgV9ItBHMaeHnHqrNEqEhJGU6jgDkwoPgrzTR0NXMN3jDTEjvLIDyHVTlTw/SccTsEXEs2+7GOMdm0eG6s8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qedGAawE+bjuLdJAEnylYy5nrgKN0Dzq0qCkr6S76w=;
 b=B/EgpKDffbUFPDZ8OaNHST7HthGrmeDnDU+wCig0wLBum2maiU2/sA2CwLvGACMQbl9oQ3Ssb2L5GgMLQ2yRyDu4xcMLpMB+3zD9WH2cdZrH1t8y9Tw1mQobKWeRSiys2u/SW3ohV+m/zVLgeW/Z11mNW+UdlLLKnqz5ek3bIU18rJ5LF/Uixz77EpfKnqkGv1QWStMel6+mM+c+aDB4Ex+rdAN17n6ywA+x+qddlAVV0Hy7HRRDHNpxzkz5jo2+JeEiT3Zt+QIfMxs0QGdiMmDxt2tEsl0jPHsdT432IK85IGj11PtZ92vrFZTqAAoLyDRP3tDkurC73d0aBfDYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qedGAawE+bjuLdJAEnylYy5nrgKN0Dzq0qCkr6S76w=;
 b=CfaGdY0i67NtZh04tZTn51n+0nKKCyoXpO92+o7VQmBZvMPlLpn4CnrS4C0Ox6g8r1/6AbbEX4KcnwhXCoGuC2kB91N9QjICHtflyqn2R0RPtHBLmdO/W32UTiO907tcSJ91t9JxG3i+4u33q7s7A1E6LwyEudQec0eRE+wbe34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8276.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 05:57:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 05:57:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH V4 2/8] arm64: dts: imx93: correct SDHC clk entry
Date:   Mon,  5 Sep 2022 13:59:09 +0800
Message-Id: <20220905055915.3878000-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220905055915.3878000-1-peng.fan@oss.nxp.com>
References: <20220905055915.3878000-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba6228ad-ccc7-4ee4-d7d1-08da8f039051
X-MS-TrafficTypeDiagnostic: AM9PR04MB8276:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wFnqoBEQkT3MmQJVTzzSAYZqztNVut1XbJiSJDDq5knO3rhcFiwosF3nT6bwkYnKJZXoFgZt6x4pW1uUekTdIlxbxPB90O/oCa83/FNF5RkJOXt6oPIhRonBTlg7bbHDSh2ea2FwSMlrzVCRZPqzc4ctH2PDRUD/hJeLoTfdYGHnGmA1MRMl08rAniuf6R0IA05HjeejYnnFt/ynr6JrKZUGrh/tLHogUiYQjIMSYkQ6EaxPjJGOg+O0hL8FbthwafN4n4p5PcBy3dp+CQOElSW2MUl5yGRGYO08dxodcia64wgSfDSYsBAU9lvxbIIsQ7aDVumiUog4F7kJZJawWK9Aud7HVXzZKxK/9xXqBqLleCbdK0YhF2jYugi9qyUiYL1YvV0P6USajl/R4nndEXSJsTKfSOoKKWIZoM7mAvF6Hi/WEfxfZQSA9EHnjm3wCjcwmvu+8msw6HAKMo9dB7hJqAUec42lBn1YDTS2MHf4E5nncGuecOrM4bkC8w0ZMdSyD6iIvJ4wRdXI1FMwEill414lTJphspgL263WuqhHL246kJA28+bBrMmkAzEK4TA5ha59fQfFVrHoaFBoaJ2vi23wo+V7lbKBsSYvuVGJUTJ6g21GqMqI/dHkcSRrmHrD4eIUo/m2BFfwq1R2S9RyTD6Q20xwbfJUP6e3nxHwWlKA/9NZqc8HXnDjYdhETyD4/pptjeAzO3ymDYhFyhoapll39BEJoRL9v9L+1MenP6ItkoG9YS7K5qTv2ANPjteHWYz6JIQNu/T9WbQlIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(38100700002)(38350700002)(54906003)(478600001)(6486002)(316002)(86362001)(41300700001)(52116002)(6666004)(6506007)(26005)(1076003)(2616005)(2906002)(4326008)(66946007)(66556008)(66476007)(8676002)(186003)(8936002)(5660300002)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Om3Ash+XuESVrbquxqKUffiH9BKVFoICkqjEC8+pEwLapb3BtqPB+1m2by1c?=
 =?us-ascii?Q?ZRLAGdkNLTJmWKGiF0o3anqlhUiVWUlRE3hUTAjjwK2ciWYkFNm81QWC/Bmj?=
 =?us-ascii?Q?+8ROP/bMJRUEv12YkLveUnYVZF9zkk8vGSDHOmE+tNuT8cisX7hlx63GeDix?=
 =?us-ascii?Q?tVMSnPKmlV0y77FO7XvOdkNbQXz4iCcY5hOWzYqv9jRpfJpm53QegdPnAIA4?=
 =?us-ascii?Q?kcagCfSu+o9ssmLS0a4g/9E5LAsPUoC/R8gK3Yipk5bYmLmJcZAWstUHbMBw?=
 =?us-ascii?Q?RbTjrjBZvu1cn7vfvyvT8vKiVH6lCJPOByafSaYeccUI2DiYt/ibSUxHGGLY?=
 =?us-ascii?Q?ysKWbzclgeL/XDtTqOzAClh5V0JA1crPOInKcei7PnLS1cijTcqT9FZhqaTK?=
 =?us-ascii?Q?3ZGblSq7rJDr8x7ZoCeyDFdopSyrTgwS2eMMwAsHaS9RKZ7/Si6KozdRmyge?=
 =?us-ascii?Q?wRvwDBl+Eeqk/xitNtVN0QCxpMhfEaEB8pIydlSZSHebHYBqV0rrFPzlRg9w?=
 =?us-ascii?Q?gtl0dzDJEwHnPjGrEKf+y7k9t2pMD8cg6rXIt3DpiUUYmpQApoYjWqBMZ6kq?=
 =?us-ascii?Q?jw8fcD+Qt9pMuMoeTTALrINCipm5gF2OlsmDkTETakMoTCroD9K/JaMdTLAB?=
 =?us-ascii?Q?SIliINrtCgwCG4uS/afAGg6Ey4zUdSRmWyfArhgyfk0uednT50ueQYCGkTZd?=
 =?us-ascii?Q?8VLs9BHpe6mFQ8AW1RsutrrsFhpN2hWE8nznOe6sYk3zdGtgLlmz6qO5/FiO?=
 =?us-ascii?Q?wAZHdAczI0g/t8fuh9ZjWYUsuwVZ+0xSeCRgVRHlHVgezCe322S7XiROY8Su?=
 =?us-ascii?Q?O5010C2wbBSysaw7EG6yLGlJHz88MQbtjVM+cKPNivPdm5NsO8GLA+YyjPdM?=
 =?us-ascii?Q?ah2lSWQ1V780Ul2u5TFmCu8CN4JPXqii9ut0+qfa4jZEYfaHdPUVfZ+zIsoM?=
 =?us-ascii?Q?ofL1hRiX42NimIu/rdVQDw+r9elE9xbRN9pKQI4VmIODN7agZKAGh6hdplaA?=
 =?us-ascii?Q?3UVcYMT2Qvd4wjVHbTo+3yIZ00CxmJ8LGpwIs1MmOakXxnywj/vFDlPGs5jb?=
 =?us-ascii?Q?Zcn6fS2Gy2Pb5OMILjznuJrywp636o08XTnoph5thaRyRt2Qkm2QujcaLKaa?=
 =?us-ascii?Q?iXQB6Xic9Ro+emXaIZ19tHMbVI/h+82E5e34qYgB5lDeprK86riKMb9YmZGW?=
 =?us-ascii?Q?PYagnQ6aPDXlE92hckNYxiHLopLwCFvz/mMoS3duCagKq31Tj/JAORVXQDpw?=
 =?us-ascii?Q?QDP2zCu/QOC3LZwNIfUOJT2azRpv02Ls2WH5Uc2Ut4k1IGV/fDLsoDmZ34PI?=
 =?us-ascii?Q?8QE9nOC7frSV7TtBAy6gv2Wgy4yrC5lSmOLZkn6aDw6eCTRUYnErh/xtxUqU?=
 =?us-ascii?Q?EwOMFDbWE89m180+prYscVhdI8hwlUDJ7RkIf5thRq8XZX95kG5Xr7lcCsyM?=
 =?us-ascii?Q?bnKs9zvS2JfIDVE2pw4aJb0+uuNSBtM55pYNDHhsoe3tGrh6ZnNgLegOkcrl?=
 =?us-ascii?Q?QO7iQcTo2Zbb3UH6DqjlRha3AMpWUCBs0qej5IWqscX03Akv8TXuxSbadzI0?=
 =?us-ascii?Q?z+WK1ZN6zGL95xopcBryeIlxjYcaUBxWKQLcTw+X?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6228ad-ccc7-4ee4-d7d1-08da8f039051
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 05:57:49.6865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4X4PQqKEs8ZWUIG6dcqoQAcva7UZpkzVwTWIucinSXHRFTlHVTBfVxo+BvIaOQ0PFx+X0e6cL6r5ehXorISkmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8276
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

