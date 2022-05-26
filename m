Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B209534983
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244959AbiEZDxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiEZDxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:53:05 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2053.outbound.protection.outlook.com [40.107.104.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3AABDA27;
        Wed, 25 May 2022 20:53:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTHRelxq2sUPbTP0OGA29wiBllTa/9LEC2lu8S6J6W1cOy6c9nNUEXUPaihFizXGiJlkusQjpnGzJtXFLCUuTdE1qOG1t+oulUb37efxrHexktlZPctw7wFKq+PN5nwTVhxbIPDglrdJVJ6eYSEC5azHseTi7mbwU04LuQO0hxa9jaA7WAZP7MXGyk3DZUXPjzC2RQY1/mNrMOC+RDCiZ0lOgyvHxCxWg00gfOBkAN1LqlYt3Jzrq7lx3bFLxJi/5je4rfJwGDe7SZj/xPZbXvYO+hVa/ebJR2MfTdgNsajQUch23uzMImUxZlQyIc2SzKoq1P3CCCLAmMAbwDW8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGz9Xv3jiVF0H+sge+mN/7r0UMryka8h4sEmSqY2ias=;
 b=PRjF4i7L3tBPNe3wPu2O+U6ysa14nbZYWHtyhyBbikz435R19nMgbGAOdn8OJyklkKmhhGltET8VoY9+w2qoXxBz3GsxZ9wf8S/pm5HJglDyEh7pKx4LGShJSzCg3rtdLp095uN9ImmqcBmMR++0TV/McEYgUolcGNNZWuA9Tl+xrXEqg2op+9FJZyd/NCjlp8Fnb0j0ONIdF6fWYsdKFLgU13+l/A6hSf+gEQu4LT3DE1ZfYTtWLj6Qu7IARdTI8rl0d1LAxmUSQwj94COFzRyak9MYad5piR0wmrH547o+2Wput08WEnMbDTQbBAM1qvn4uB75AJHjWWsr6X8tPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGz9Xv3jiVF0H+sge+mN/7r0UMryka8h4sEmSqY2ias=;
 b=W/PYiGnqv0Eei21Lfxw95r9v5rWbrUS7kLJRQAyTXRLDx7zShVm3v/xQV1yqr8kPSJrptLB1ulay7VWilP5bXUVIDrKhXaM5nMVr0rplC6utAfqvyfmg9WGWIAds7rGvcI7S9iDkq0yBAO3Dx3qAWIu2FdFXuhrJetujG/w8cuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8222.eurprd04.prod.outlook.com (2603:10a6:102:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 03:53:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 03:53:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: ls-10xx: use generic dma node name
Date:   Thu, 26 May 2022 11:54:49 +0800
Message-Id: <20220526035449.4062846-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95b70e2b-a39e-4972-80ef-08da3ecb3a84
X-MS-TrafficTypeDiagnostic: PAXPR04MB8222:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PAXPR04MB8222AF55CB1D234C23FC7BF3C9D99@PAXPR04MB8222.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZeIWludxspN+lVedW0WgFwPMLTsa3E/n1ciSEWacPAmFudJZyl6mwF4zs5ymBOXrfwxo5Jf+U8FuMZIOi1PrMhgHw45sQxTOfekonn3lrq3bXwFZGw7CWnbDfWmOAb5yIDrcQT9nELQ9LbURrEbu2lXhs5n+1xUzmK5B1H9W5G0zveidmsq/r3n2F5Of+Bb7sI/ah7SpDKSE16OaLZ7Xd6uOVaO6lhJqSAZpOVr4BpLlTQJ6ti457iIz3Aiic4VDB8VpAT23ArR7tTsbo8Tr8PuF44mNFlLS2PKPCEnCYINQgr8LP8pfj332hXQbGysh5pOpG2p0D2eop5hCsLH/tmvBi8GACSKPMjSaBnfzvwwlbKN1J9W2qZSMwzWVvUIpkJk7ZXhbJNbdXlxwywZTrkv7JWf1AIZ55lTpwWi0AFAfFja6AGvZoXWHQhVWj8HRxi4XJlcD8zjndovFiZ2EmJOnO/lM7EHUEZGPgTQm6ta4psSjfZlkA1vfWTEcBGHRj5c+iDp7qw+Ble0+HoCTQjDaN/ktPAHBmogJZiTHSWXwH6A4BdNoLKnNIH1EndCFQAiJ0V1dsvHyrD5A3KotOA3o6bT59Kj7CyOfNSqBW2AiI/rPGqqF4S86+QwX7mWNmn1fCGAWM6caUM8Kbf7U8NQJEjPkYH51TOkLp3UFkWA2YrbNNNpAXRC02lG7b7IKsV7kNRxGE8kxpCY2hrszCOTo4H6VQSntlZRH/+nKAIc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(316002)(66946007)(2616005)(66556008)(1076003)(52116002)(186003)(83380400001)(26005)(6486002)(6512007)(508600001)(5660300002)(6666004)(8936002)(8676002)(38350700002)(6506007)(4326008)(38100700002)(2906002)(86362001)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FrQ4zQ7PeEY4I2xcNBBvRiOWa628AUUWUaZWtykRSRCs/dSAabn6pVT0SJD6?=
 =?us-ascii?Q?N0IswblkS2YY+5+mweaizG/dZjUBEKjImRtdrt8t+RHjkt9d3Uh6082zsRuQ?=
 =?us-ascii?Q?W5j0RLK7a+vrSTLR/7vcyg/BGDk1v3ho/B2wqrUogeQKmxeWrQk5ZFtPYgEv?=
 =?us-ascii?Q?WYfpSxbRNBd+0t0eUFg5Xv4T28gzwYFeEdCk7VPFpzLmILD69umhvEdHtZOJ?=
 =?us-ascii?Q?/g6P2nHxcDRhQAERW3do/pvMQSxPXLldonTiZBESGwZWVoVycvGGpuOaV0qd?=
 =?us-ascii?Q?3De1/PpKQSjDoG1uy+qkCfh2X96ASMbV0P1zn9mONsvXdK22FN3eZN9nc3wJ?=
 =?us-ascii?Q?Mmioz14u+SjXLR36cQIM095s4LKWVPVXu5dLUfjBEzydTt8IRlHAjikFLISL?=
 =?us-ascii?Q?PM6ScXytMoBR7D0LFZk7P3PXkuYuQEs894xhHp8ysq38G7b+/dhLlzXJCA20?=
 =?us-ascii?Q?/OY+0WDa1hR5lsro7gDattQ+o2Zbwgeh+RPEax/MDVTADj9h2K/dU8PTMuXa?=
 =?us-ascii?Q?taTJZG1SjgqxE5cwN4sgvn8ufEzl+C5Q/b+0b9bcw9fbUUbvBNmfIiSnBKvy?=
 =?us-ascii?Q?gfNxR4nWp5/S3k5Mv8KBwW3aVhIfMdAI+3KHlckGg8GFIPH4Cp50fnJL2btl?=
 =?us-ascii?Q?UQBptfVKsvslqhPHHeKX04nbqJ4Ppb/eUVKb6i6QeZXSL5Tc8YtcoxTdqNHy?=
 =?us-ascii?Q?Ch+aIUTCD91SmAAOVItXOYrm1fXedjgyyAU3K0/W844di+dcVaH5WrmbtRsu?=
 =?us-ascii?Q?kMmwJlvtLk32vjXTkWblKFJYnnV8r4Yhve/+t+eBdBKEZ+vEtMozXSTtupqs?=
 =?us-ascii?Q?N8woa5YpGQ67asKbIJPU2lPM4Dz1XRniG61QyUC+yNZkLA01nXhQ/+EfC0fn?=
 =?us-ascii?Q?1A7iF+RoP18N/zld6hWCHXExgNB71NDmT9O0jMnodwd2/DeZSv1xNw1Elkaa?=
 =?us-ascii?Q?+RUkXFQQ/y3DKPtrRKk+Qq+KiTwMsnCU3I/oyIB3YHQmncaUPdNHG5enf0sx?=
 =?us-ascii?Q?CjrP3MJql8aYiGTuLfUQHs3nE+SxSrwIU6UpXuUjU1IO5ZLUIg0erUi0Hoyx?=
 =?us-ascii?Q?k1n8W9uUnipXNRh3N/Z9qYxj6G8e4pTFvAjt03AoOQxOQD4S8YNjxf/J8Kwv?=
 =?us-ascii?Q?HtLELVzd1lN34qtDfi6nbj91xJ+dVs06RDVLmztwYZsXGSTC65wf4CoJLK9R?=
 =?us-ascii?Q?tlEtp5Z2hMX6yb1tIqDZNiU4/0yzweowrt7mBdrAs7H74d6qL9mTfv56k42t?=
 =?us-ascii?Q?yQumbSuledYApnzluqvjWCfrev3e6pp4PCJzQMeKRojMw8LDxnO0qQULFU8Y?=
 =?us-ascii?Q?YfD0/PyQG7yx0tqM7wpc9Tx3ZYEIBEtLV473XxfPkN7Rby0jCxsEmlX6oN2M?=
 =?us-ascii?Q?RPDCOz7VpfalXd/wZ0mXLj5uLSJ4sNTSHcrofppm056J0E3lrMiAfFP3y1eD?=
 =?us-ascii?Q?vqqEC7saH0trvWphWsvoytUjsM5JqpUbRYQInFuQ+C6VFYYio/5cOubTLDrF?=
 =?us-ascii?Q?Twgbx/HMcOH0xkE5prPUOVZ52ZFB/jGHcbhs3XsFV33/ruxJUnapaDpnH32z?=
 =?us-ascii?Q?JZUPzLpEAkXf6pJHmvAFbGpddLlmp/8heKcPlGG9jb46SQAw4H+YkopIMyb0?=
 =?us-ascii?Q?x2OInWrVmjk4XTvE2mU/DyvGHyTtsU9rGVDrMvt5+NAdet+NMFw38KtQgpHe?=
 =?us-ascii?Q?aGiBWsLOi3daz//LIqqwIXwyZCQZfdhAUADUgrFgvAEWhvj2MO2hcgiwqNTe?=
 =?us-ascii?Q?ceuh0YMp/g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b70e2b-a39e-4972-80ef-08da3ecb3a84
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 03:53:01.0359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmDTF39LwpcXJsqTGP97wZIE//8AuZpkawOWyLoOZOi5X3o83oHYG004I7U5gwtDOBnNTSOoh8Wav2VEKiYGFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8222
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

dma-controller is preferred for dma node.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 50a72cda4727..f96df39d5533 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -465,7 +465,7 @@ QORIQ_CLK_PLL_DIV(4)>,
 			status = "disabled";
 		};
 
-		edma0: edma@2c00000 {
+		edma0: dma-controller@2c00000 {
 			#dma-cells = <2>;
 			compatible = "fsl,vf610-edma";
 			reg = <0x0 0x2c00000 0x0 0x10000>,
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 21200cbf7161..d91793d113eb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -784,7 +784,7 @@ wdog0: watchdog@2ad0000 {
 			big-endian;
 		};
 
-		edma0: edma@2c00000 {
+		edma0: dma-controller@2c00000 {
 			#dma-cells = <2>;
 			compatible = "fsl,vf610-edma";
 			reg = <0x0 0x2c00000 0x0 0x10000>,
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 0085e83adf65..46285b5710df 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -683,7 +683,7 @@ wdog0: watchdog@2ad0000 {
 			big-endian;
 		};
 
-		edma0: edma@2c00000 {
+		edma0: dma-controller@2c00000 {
 			#dma-cells = <2>;
 			compatible = "fsl,vf610-edma";
 			reg = <0x0 0x2c00000 0x0 0x10000>,
-- 
2.25.1

