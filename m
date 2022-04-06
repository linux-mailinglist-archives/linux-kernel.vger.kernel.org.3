Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 589CC4F5C2F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 13:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbiDFLdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 07:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbiDFLcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 07:32:50 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140053.outbound.protection.outlook.com [40.107.14.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82AB4588F3;
        Wed,  6 Apr 2022 01:21:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6VNyUNNqgqhfgrnOktwXlDgZ+xRfZ0nUKnp6ICIoFwhoml/L2+QuGJLpe6T7+0+0ixVAHFFPlbi+IiBSJwV3tUKfHnwxc1S7iFijaHnaDJTXNxHPRVTJtvWgHO7WW9plmopltJCom/mltsCHr9czlu1kMqJAprA/Kj7tKloz2kyJOh+9FBgq5tdSpicR4UfrJoSLqfr8B1lM2QEXro9LrEINJ/xHYUM/qxQuKB8FmPrWAw93m1aBq0qFCjHQ4+GXaQYJ/WbhrOIkmkMw/k7P6Oe6hVUTlAIH3eqrB3x1Cox4JgY/q2+H3W63vLGyZBkunXvMc53+PGiCtaoweENCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GjYzN53MT+gWG6urbFJ9U1jpgtS9/EOSZ8XZSanBVc=;
 b=VJfhUycaAOGAiJ4AKPu861lW/g/PAy411VbhtX7qTbFevXV8gi9QP6idHHHkHfvA931hSElbAex2WhuRTKFS3TlqHkvwXNvF7AHi6sE8nUK7xwEWn7e/emUejlk5tkjcDY38IdRNzC398hsvu7QcCcd1dkGzpa0/m0yLOcdMRGJrXaI4SIjDvHkYGHrjP7QtMvU8lZxIBKADIPMKDys+BhEsmzb5U/Abx9oP0vELLcurm1K2Ck4SWfjXKqHYbTzJg+MuutecIOT76JWWbqDr3EGuvZ+xsWDZAcVvVvGsDHzaOWXrRM2XQW3dPlju4w42vaS+jtjC+2MPtHSyOLT25Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GjYzN53MT+gWG6urbFJ9U1jpgtS9/EOSZ8XZSanBVc=;
 b=CX12SfO9iXS/dme2VW62Z6KmuZeLPBzb+pZN5eCu2BxURXmPCFNR/98WhmVj4Sky0Q2X6Txym4XNmcRVNn81Ta3xKfnBOAOpK5x0unddX2803RwqqndlPV7U1HNwIvWRd87FMT7CDCBu6/0CcVe9YjlyigiGnyzgoWhejb+iC40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB4988.eurprd04.prod.outlook.com (2603:10a6:10:1a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 08:21:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%7]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 08:21:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, l.stach@pengutronix.de,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/5] arm64: dts: imx8mp: add noc node
Date:   Wed,  6 Apr 2022 16:23:27 +0800
Message-Id: <20220406082330.2681591-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220406082330.2681591-1-peng.fan@oss.nxp.com>
References: <20220406082330.2681591-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf1220a0-20ac-44dd-d0f8-08da17a67f8e
X-MS-TrafficTypeDiagnostic: DB7PR04MB4988:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4988F3BF557CE2B0FCFD802DC9E79@DB7PR04MB4988.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPc3DjqVZv7cFYyQGDXUuTlfttOUueCp4y3IcVqQqNLeyrc6dagzzzpbAaUiGdJP+TAV3t5sZOhCeTBSdDNv5cWkSX5Mn2fXOznUxoalkI/An663ldzph6Laqk88gPycyms6lQ4YYyGxpxzilCbZVcdFmITv0MnYZsYgJAHmIZlV9CDPfnU4hc7njm1KSkAb6b8nhkU13VLBD13wZhIkvthvS+MPOiTpDUWmuvl0K8h9Nky6VQICi68BEBpl+GT/kdj/tNU/2hV6kDlai87XEg/I4nOx1y4B998I28h3R6ToSiH0faXrbIqdbdZLk6fjHCuUD3bxUEcl667zS9sOv1sQh3DvpuijGjLKp9rCojD+7SaIAA4TQIsEeg7Qk6k6WfE7A8RceV0+h/fc7vs7aET53g6Fopqc078Z8etR6oaIXyUdYGWju1RemAlFnMeynweAEma/RdbF0X9yltbIEXrKVDuE3xRIuMuk1b+HkKUBzyT3BKTrfJgSj7LkxS5mLm3Ti3pSzayuiC78WiCsVU+aMLAIY9h9/Fw7UxIs+eSISjXTGgbMoY0cAYlpuFlzU12tQjPKieMA6AxlMxHVd58jJteGs6oINTU7iD7bP4XKHxYRNtY04h6/D+r7MtK9G/E54R7hndt83a1rbG+Fzo0H0g/ZFlBrmwRjk1N1WTt1464jJDVlG9nWAX6gqRKuhsU9w0KCgO2uzvgPxxLoNphsR8VQnegy01ntptmNNMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(7416002)(83380400001)(8936002)(4744005)(86362001)(2906002)(38350700002)(186003)(38100700002)(2616005)(1076003)(26005)(52116002)(6666004)(6512007)(6506007)(4326008)(66556008)(508600001)(66946007)(66476007)(8676002)(6486002)(316002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OISjc/HX2GAuNc6YoFIJj7yxAJ7pPgzCtMqobI34GmXUw8ogrkK6kK3ioLZs?=
 =?us-ascii?Q?qa5pa+/9O65ovuNdkaH79/f5EOB7gkSPUYT8TZP/3qCDrchf3SFbJdBxUaGW?=
 =?us-ascii?Q?HMa3VIKWAnJatoee9mI9k1eAInltToTmabnweoPXbRN7r1DbYNVa1cbnXnRq?=
 =?us-ascii?Q?FzWfQ9DMX9kg7GFIVu0mO3CaZpv/57Tv+9fDQgPQGzrr3tEkKQQNb2Lby3hs?=
 =?us-ascii?Q?CMb30crsm2DWdFNZ7Uw7JvBFmmxbIfBKGwlGbSCSxrsYay8UPXoL6/UB3aTv?=
 =?us-ascii?Q?ugU0GaYxWVQWmAUHsNWK4GFTJFfnAJE6sr1fmEY2QVX6yT/Tj+zbFkXnCa3M?=
 =?us-ascii?Q?OoCWAWPQMU44x2pWF61DZf6O/wlC0IpaYEGn/kyQ7r6lPX0CJVY7mraBZnNO?=
 =?us-ascii?Q?bzZAS3b/BaVQJRIOpuFTH8Ops6H1xaQs8qancgs8MJhCXUulYFSe/A94krmV?=
 =?us-ascii?Q?WbWBsSebxNGXtM74fk3ztr/sqUhSMsIBXwbV9kkmB1r3hIbwipvTXxEl/+OZ?=
 =?us-ascii?Q?+CzMvQ5AvYnPoUxkPxrR79MiirSIWxV6e+m3rYF2Dgg9hgDnW/LPhAtF6+bS?=
 =?us-ascii?Q?UOtAcdjfSQQj921xK/0xySpk9Har/VneIno6vGw5qrCijXt2jbmxQgdAqZd+?=
 =?us-ascii?Q?D7xWKSMnbup1iiCVPZmmDLvSj4alNpG2T/bZDHbeRG8Gs45CO5uD/0t4nYRL?=
 =?us-ascii?Q?GSmilmHAqfgEKyyWSCAnTtvoIqctBzqN1e2G5HyZi57J6scp8cXfXwLkfNAV?=
 =?us-ascii?Q?oNEE66SWL/ZrTNKNsrW/2qiaR4Z2iy/Kq8PPu4HWs5DbbnTvaQ3ANinDl5mT?=
 =?us-ascii?Q?akTJ5d1tN25AZhXJ2xmtdP3vH8NaJ5vi5Vj/OXdZHA9/5MsStHMrxSCcmW8j?=
 =?us-ascii?Q?iDk0k7Cg7d/wEDjlshrBQ1j356vBXdnaScOpgspjE21QtxVGPpUik52wK+cL?=
 =?us-ascii?Q?gCT8FgHPrlyH/XQIQpritPHsrpppNi5TwL9k/f1d4VK4WSQmZiyzPvJKY74J?=
 =?us-ascii?Q?3JH25D9GcAjF4M+on068GcwxT6JCGicOcMp2tgWZXD+wFi18EpxisuySeCy+?=
 =?us-ascii?Q?iOdMdDM5B+5YLiV7x4whivMyUhca4pCU3nxTR0OCNf+TvtR/1LWRI4wcrp+p?=
 =?us-ascii?Q?Ey8kKLrVRTvCCmgxNUe6eietjQ19ediLKfqRPoQNPRGwxXdJdSEWTROqL9r9?=
 =?us-ascii?Q?Y5k9LWZbTe2eMm4XBzRmaG/YgfwUEozVdLL2vqIX/FtWMt/0oUeAVIaO1bWo?=
 =?us-ascii?Q?WzxYkh6G9z1+WP1vJ4IlxR6WpLmn7gBj53hKGoV/Mp2cXIdSaNA5v6IngbO5?=
 =?us-ascii?Q?qMhGCn/gUnqK827RM+BFR46qQFHZUOd7NLVCaPSha9qRI6iCuqXY75yMEmNZ?=
 =?us-ascii?Q?YW1ZaAScZ8QKVyCAXAtv+J4Yf/5+oZ87zJIesemEPPO0uPGMIUO8vdShsKWP?=
 =?us-ascii?Q?ajdrsNI/jQ1qcaKb2lN+bbSx2IMupjPRr0j74xzXuMVH7Ktjfxur9s+9blZB?=
 =?us-ascii?Q?GDorDvEp2bVqtJV7/LIttrZH1U+p/ehFvCOnjXvNJPOX9Y+8ydSG98glEVW2?=
 =?us-ascii?Q?RIqSJ9jou/Pvc+RdNAGzxiU5NDkwFXl+I4vep7MlRibbENElDJL64Sl8RkHz?=
 =?us-ascii?Q?qHPjGE3e9ZWoidKBXs6RsOeDZCcs4LM/9HOK4A7K57uEdKz7EH7PwRN3QSoQ?=
 =?us-ascii?Q?alO1HGT3fcnD7+pCvPsbYGcnzq7IleGMLSf1GPLbXGcpYvomabDfcT3uL1aU?=
 =?us-ascii?Q?fvexJ+G02A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1220a0-20ac-44dd-d0f8-08da17a67f8e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2022 08:21:50.1247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DN3QnnfRoraT2rKOR+zszZVBKafkoqy27LP1ZVLZe3OaPXidx7AKKGKiXZY5igXV+Nw1UOVhc5qTCOOyjuXJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4988
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8MP main noc node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index e9e55fdd7652..be902f8155e8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1015,6 +1015,13 @@ gpu2d: gpu@38008000 {
 			power-domains = <&pgc_gpu2d>;
 		};
 
+		noc: interconnect@32700000 {
+			compatible = "fsl,imx8mp-noc", "fsl,imx8m-noc", "syscon";
+			reg = <0x32700000 0x100000>;
+			clocks = <&clk IMX8MP_CLK_NOC>;
+			#interconnect-cells = <1>;
+		};
+
 		aips4 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			reg = <0x32c00000 0x400000>;
-- 
2.25.1

