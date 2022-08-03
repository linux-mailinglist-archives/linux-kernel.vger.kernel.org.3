Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C84B5889D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 11:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbiHCJvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 05:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237727AbiHCJvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 05:51:32 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CA5F19;
        Wed,  3 Aug 2022 02:50:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFIozngwcenMQRuyzF/JhjduTyqBxUE29kU7WluBMWbz6KzlUhiw+1QrFRu+GOVAHdM5h1OHKmr5/QvPlDXx+5WS+uChd+q7Y5N648uCA8wHJ1D+RlbuzkKMpVSqfJ7v65CxTmJ//ImAT8BAHPjMH4JctmV/yKr5zZgeDFE3tFJ/zPkX4T6jZfTRtYwjh1IJxuwnrAoWpEgVZtg6lTodydDHLXUEsq3BcanezMdvw8r7gkMV3XIufEu7/wsOWenNAi8a0pRqx6a7B66Ba3gcnZjrNupHONhKg6rkkOKjXjmJbSrx8yjOxrc6nP63Pfc6AplAR5ukpCG9m8T+SkSFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0o98xzrDe1+y0pLHnqxdnzH+mHYX/jYBSYo5OxphnD0=;
 b=NmQZY7vvkyjcTfv8y6Zr7UYN8bem3/3a4snzsEiAiN+ezOyg3a9yoUBSH9bTsJ3GN++D+gFDVQLMpcPpwflOCz86SznwbSDGK41eZ9N24IKIWT9D3TBV2iF2uV1wo3fM4jmreGA5nKmADcukl/Q3LKVATcwL/+VfCj37URZuz2MiTzBqLkZrQ2DnaFogC9vSpt/lRbSTLcjj4i+Se5m44tCqMgmGywUdlt6NKQPDAhwO3QD7u5tvW4nafvR8lhq6FepTulAAWhG+hxiQU0nC0h8yWxUfDIrABu1Rz6mtHJNFISrnbJCvBSY1aNdUHQCeZnAAY5YEQZ1PaG/+OOkOGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0o98xzrDe1+y0pLHnqxdnzH+mHYX/jYBSYo5OxphnD0=;
 b=BVyxIlTs4vNPDkCP89arfR52pWe9klxFfFqnagSCwOv6ltufFa8DXaXJDAVjo9f6dbsnlNMPW6iaG1VrU00WdpNY8CNgBYgkeG1WbdiKXUwR4wNi0aXanhc9Me1+tzFq+nZiRZFeitmXR5CfU6fZDTmTIGmRSpW4049Vs3e8BW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2891.eurprd04.prod.outlook.com (2603:10a6:3:df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Wed, 3 Aug
 2022 09:49:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 09:49:43 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Haibo Chen <haibo.chen@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] arm64: dts: imx93: assign the correct ipg/ahb clock for usdhc
Date:   Wed,  3 Aug 2022 17:51:02 +0800
Message-Id: <20220803095103.3883035-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803095103.3883035-1-peng.fan@oss.nxp.com>
References: <20220803095103.3883035-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::33)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c85e9c61-00e3-40d7-e450-08da75357d96
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2891:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cdWuV+QVC+McxBePLLD9Kfj/NKndhrbu10IZqoeSEjvd8JzmCyl/3K7VzTNpRVCe3tRDv08LGbdTjFD4o8I5GHT4ODi9RhLqEeRFa8Af9STmbt5ZCf2p0VzRHr4OImEr5WG3r5zOVFXRxna9Sv+JGzhT/cEuE/lQ3UrEe1oeCoL0GnF4Iw96YWeFUJDh7Y8qC7BVszkFcCunrwJQXrnEhsmewxXOq9X67gv6tgK70+dbyvmcieHqFSjhb252AogjKZGw1ZUEi1wCFolE3oDdDAn9IFnUkIeBVsJDFpkd5BKYlH07YkLcgw6+TrAabsPKUt5cBcpxTCU8wyeRzjcFZm2s41pXwLq1cci+PfXqQuzlB8Pf/35aaxrxZ8As0iioUfhQWOnkusxT8340zEcDCktf0HwUUgm9d1fmDDWTT2sssXVGqB4kpP+ceIw2QPSuUWqPeDM7q3G8LGjSmUt0myBakoCSoRqw/D47dWUUqL4CjkxDzDmM4g0vcVdgAR91F9wHiQsBnbBNEkzDIKb95oo7SBqJTo3i1BFCiLiECoTMX7el954bKY4zWmw4WYKuDdv6srrdVwPWEQO/0/d1Pg3UD3FLVmSdBvkA2i4WhNlHvoOCbT2KX2J5sNaEFCsA6jquKkuYv27UKZY4IfDeL7aVOofEyBBrpHZLKSnXt1mxeDTtwhexH7T6orkVjmXDKbc1N5QLLRAQhp8709tD/PBftSc4vUEL8LJqW1ZhWotmpWLx62M5wZ3yUDW5EfpLHEEFcMJlTNa8H/9HwADGfD+q4aGRwzcp1siwDYijCkxUt9AY/sFNmCG7EKxWokV7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(6486002)(5660300002)(478600001)(4326008)(2906002)(66556008)(66476007)(66946007)(8676002)(38100700002)(8936002)(38350700002)(52116002)(86362001)(1076003)(2616005)(186003)(41300700001)(6666004)(6512007)(6506007)(26005)(54906003)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jMM96UPr+x3lGfnlMlNNGNB+00DA8BVRhOY0EZjmDJYNUd23aV7m6O75tOND?=
 =?us-ascii?Q?Rd7/v7R7hhLbfX/bOykFp43OgarHXEPSHBd96W0OhO0QM4WY+3ATdbGxycx+?=
 =?us-ascii?Q?JEV/tlWBvzdnz7cF7kzwMOmAnjowzbAUCrnln7BItvIkJhI3PHgo2tq5LsVh?=
 =?us-ascii?Q?Xvb28X6Rf36r2EEtdUPO363tCR9/MRSF0GwSWMuG3WBkT4CTwVEAiQdYE2c4?=
 =?us-ascii?Q?F8cO9cj2i9UWN64OChK6z44J3QFP8hWRVbJdmHSceHGCTQdFosrWgs+Iw+SO?=
 =?us-ascii?Q?SqG7SF1gdMDpw6VCVLqhYOL8HyMla9z/6+t8Ld+aosrjLxW3ruUtftiS9YK9?=
 =?us-ascii?Q?QVNr6Eqf0a23SYbs1ePSewJEdiF+cV6RmKByvhaHIDgTOUXIG5RvFNNq73Yo?=
 =?us-ascii?Q?6mAWzS7YvE90G2NCfZBI7DOkXUtw6p/eMxX3cFOj/cq6+4A7NknpNodDoZIn?=
 =?us-ascii?Q?HMIrh8vzVMmp8NfGvmQ5uszkRATwyaHWDhQ8hM9E4jINOIQoPnFNsXzsxaQr?=
 =?us-ascii?Q?fJ/5TxGOrTsHXjR+qJeU6CkUHlbZzvOTwIuSOjbPrNw3S0m4bPNoN2Gh703O?=
 =?us-ascii?Q?7E0cWRySDZSTAB6oHXnQ0sSnp25W+njbBEmw+5VKFXdqf3e7+HLVIXMi9sMB?=
 =?us-ascii?Q?aYFt0wusbapfSR7DzWMHkkuPoJAVufqf4u6mk8wCRJtN89+JhaX+WwvJf4Sg?=
 =?us-ascii?Q?fi+Fv2Fh7PrYOYx94IPnZFVkOJBdV2T2s0FamchIa3c8k0bqmf3r0uwCc5OL?=
 =?us-ascii?Q?Z7VhWf1b9xkcRNxG+9afI3lxf1+SP03/Qv3CVlwASjaGDOmjd1hBlcYCnzlh?=
 =?us-ascii?Q?41/u8c2YMg1Dj/c7PWUsfLck5EljUqOMlF5g1rbLSYraDLrvU1iJyZGdJ2Hh?=
 =?us-ascii?Q?uy2jrv0Y//xs5/N16e5ncIdDbZIR0zwGLbCZpALfmTlGcTzvL/LSw4IyckFf?=
 =?us-ascii?Q?UAl+ET6JT5FgT6GC/n8/aCEr4zL1XrS9HPhmLHvl/NbRB9uN8yk5LmoueHS1?=
 =?us-ascii?Q?bmf/kzN61LhHaS1tscBJnroJbNURPHvWcYxz5ONnknqUWtnt17nwwIOqiMnr?=
 =?us-ascii?Q?PjU3+bTYoZuGZbB2qVCWWrBXh0uyBk7eNYi0+W95YLRnrn5dmP9shymdsCCV?=
 =?us-ascii?Q?opkHJ9i/RW0e1A6ltSpNuCk7wrssPnyAc0ZxwZcMbZM7dwma2073X9vC+QaZ?=
 =?us-ascii?Q?iAZkinoAzdGt0WcHCTp44QU70ETA/suPgATKRerMQc5wRTSHv8GUB3aCKMHO?=
 =?us-ascii?Q?XIlbMdRyZzJC9DNk2MvTMgMe4VngCNzirplNoohFhUk4x+RdIbEIISCkhqY+?=
 =?us-ascii?Q?PV+E58KCqObG5520jD/4uoQmlgRY9XwCi6x4Egt464ETBrofDtXB/Wg5B3RW?=
 =?us-ascii?Q?CpQvaaj1HmudYrbHgoI5+4BHZMmFl5nkmDBalp9Swp9ugWj3WAaOa00LbKVH?=
 =?us-ascii?Q?2+NaquT1lZMe3Czu9hzqpxtUuhNu7IHnoFWOgafsrEI5GNVLUBMAlZjwJMwO?=
 =?us-ascii?Q?jDrPb0PKmzTmoCU9q4Z89jTpLudUSAzKEUQwjXQV2sFJz7g+XCeiZxCZIzYo?=
 =?us-ascii?Q?xpQBdpmyAtOdUrp+LgDxArUTjnuEVR1bUltFyb88?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85e9c61-00e3-40d7-e450-08da75357d96
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 09:49:43.1009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mzgg4ybP8CiUiITfa4rp6VNqVbawBUb9jOp8KaunuR84mAOSnvDF+XYHYOJGQKr1TwwRR8qyHIYjKE286nM7TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2891
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Assign the correct ipg/ahb clock for usdhc according to CCM.
Also config IMX93_CLK_USDHC1 to 400MHz to support eMMC HS400ES mode.

Fixes: ec8b5b5058ea ("arm64: dts: freescale: Add i.MX93 dtsi support")
Acked-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index f83a07c7c9b1..7d812897aa38 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -248,10 +248,13 @@ usdhc1: mmc@42850000 {
 				compatible = "fsl,imx93-usdhc", "fsl,imx8mm-usdhc";
 				reg = <0x42850000 0x10000>;
 				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk IMX93_CLK_DUMMY>,
-					 <&clk IMX93_CLK_DUMMY>,
+				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
+					 <&clk IMX93_CLK_WAKEUP_AXI>,
 					 <&clk IMX93_CLK_USDHC1_GATE>;
 				clock-names = "ipg", "ahb", "per";
+				assigned-clocks = <&clk IMX93_CLK_USDHC1>;
+				assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1>;
+				assigned-clock-rates = <400000000>;
 				bus-width = <8>;
 				fsl,tuning-start-tap = <20>;
 				fsl,tuning-step= <2>;
@@ -262,8 +265,8 @@ usdhc2: mmc@42860000 {
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
@@ -276,8 +279,8 @@ usdhc3: mmc@428b0000 {
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
2.25.1

