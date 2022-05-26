Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A973534981
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbiEZDwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiEZDwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:52:25 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150070.outbound.protection.outlook.com [40.107.15.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545AAA0D31;
        Wed, 25 May 2022 20:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ob3L92aBwNh5q/C6NBzm58guD7bhVNSks6MAc68mMyx7Y+mpy4Mtc7d+V7cuTI8cESoSSnoAn+BiDjFony+YQb4MLDnY0tmrrydfZKWswJSn+vQXBhNRXtRUoIfbw84s8aMQfJbjgtfR7i6/3MdyZy+C9IfFwE169bPhIR8AeDsGArsL4Cc15v7aaeo0km3SgF1znUG1M58yIau/qfhlvQ+HKbSsOZGpErbdFjfar8Y/qb976jftSLW8jnFqkFP22P+7l37R9IdB2FOscWZbZH4OIcNHQtUyulNnzrKq3b7SeZo9Fq393tNsGWmVgBOt6EsXhaZV29sYJST39qbOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGz9Xv3jiVF0H+sge+mN/7r0UMryka8h4sEmSqY2ias=;
 b=SHOI7Z9LJ1m5QajkJJxw/sosV2uxPLs4hV9+Rsvg1D70DmHMw0kayqhij03ThGIpytxu48N/YYKBmAK+x5JnERJYbj00Iz0SkKZZN5ZBAG4k/WfkO/RRj6B0rDv5O5DbTofo6u9R2H70gmqY3MtCwvAjTbwTCnYOE8Us7FThQDRu1GVaUEIiRUC3L7g91BgDyHwfhc6cTDQ6x4leABwVcuUpVNNJ9pkljSqr+Tj95WTvQPBpg3+rcAtaUdhlXZWyUz1Vomqp4cPDPHP2khFoppDx+5ZvPIgVQ2aAxTDwB5jTwnu6dSGwuWWv3uHwd01I+fRCK+J/I0x9PQqjVyj/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGz9Xv3jiVF0H+sge+mN/7r0UMryka8h4sEmSqY2ias=;
 b=b05ZRSzUt9SLOpSx7GH/XP7fqirnm9S4cVy5NcsCUUKdaWhtprWWtm7Wbv4tFVQ/VwyJ5NyXlj9ZI0Q9L4vJk015HfKOg5Mgv6TSnEtBzxErOvPUodW9K0UlIXX6AjwQjC8tUtxLQfTNJbkPmPbro+SuEqvEf77BG+AfutyXKWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM4PR0401MB2324.eurprd04.prod.outlook.com (2603:10a6:200:4f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 03:52:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 03:52:18 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, evicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] arm64: dts: ls-10xx: use generic dma node name
Date:   Thu, 26 May 2022 11:54:05 +0800
Message-Id: <20220526035405.4062687-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0005.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 769c0af1-0c27-4ccd-eaa9-08da3ecb2109
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2324:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM4PR0401MB23240EC823E0DF1D1CBE698DC9D99@AM4PR0401MB2324.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4/Bw6+5p1eqf4rMo8F/AoedJZ3BGe1wluql7DFGcvHNt4ruS/p5Eg39j74UwQ9cZppaJn1eR+4MKO01BLVFUBRxQyBE7JAL10V5/RAQUVeb8Oy6FJp6g9mcV9KJ84QSumR0kusry5gYZAs4oJTOrdRxdy2SR9Tu59NodPFFSRrkCh93PQCUr2VVmnsMgzdQi1niKQpQ0nMgAUUvwZk7b7ueSXJ2MZ5r6+32+ru1qUxRG+BhLEHpNx2Jc6W146vJKSaihQ/b4IMP7YRnO1duNyJm9YoeFTVzcS0ctynuk/PhhDIqaOXvEaQu/2ryLgzgZ2vrqhyKVuClaWyBuu1XUP0KS1WfE+CTqHdnwaPH1AZUX7Ebx76qRbCwG170rxp8HOtlgNziL9OoCa7Uq/+A8rKMOphjmO2Yj56vCCFvFmIZXySifZkTrDGCJaF9T2NFa4cnRYcjgesmLTcusx+x8eYRyQiR456sPtprVEsPgCexORUePj9CVEYAIEKQhXtX3LZmgNGWCBip/bql7Hm9842IqIUksmoLLGZ8CpWPTs/Ug3RHomeOdhVeqLlg+QtCrb2wqzVZrAyho7CVpLU9QbTVgSs3+F3M0+BYvFG+syDSB6uLpgS73KsnwbIvGzzRwzBvXO039Xs7ymEJCQU4CrMWPBMtrCKy55y1RuKoEHGqyrBVtmO6c/hc+ZuloLL8cnZxSKzO6/IvbPKG6+awO7hJI5aA1VB+XEbRBv3qYobw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(508600001)(6512007)(316002)(38100700002)(26005)(6486002)(86362001)(1076003)(38350700002)(186003)(83380400001)(6506007)(66476007)(52116002)(66556008)(4326008)(8676002)(66946007)(2616005)(8936002)(6666004)(2906002)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E54Hj5YfJHEguHuBSfSyiHzhhhPlZ6AN99AlqW/uxRcrU7kpwJdDnTpgTEJZ?=
 =?us-ascii?Q?/yK4E6Q8foAnr51e10frorg3qCyXpCGnMvmXCuKMIAcBFMCLVQLly30+foUO?=
 =?us-ascii?Q?cppkEHvA2EU59aXeSSqcJveDDyL8uzLVXTg4RljQWHJwK0UiCQA+PGlVAwC0?=
 =?us-ascii?Q?26eKRDLGOrpVxIOKboP7uKS+CPju8oQYCBBk3uM3HJzQauQzkKcEoTJaKC8u?=
 =?us-ascii?Q?0yFZDbcPNkdSqIb8aJxg958UGOOQc2P1sBtEKD/teEHEYmYcYsZi8SkraAwL?=
 =?us-ascii?Q?s5DZlgnLYjQCHty/XMJd9UTmICi4FlIjecHKjW9v3p4qbtZiMiamsntUYihV?=
 =?us-ascii?Q?nF/whn8dwBh1Lt7PGi+rCYp55aryGJleiHMBERSS5wKon93IEbExSUoI90FE?=
 =?us-ascii?Q?D8ulz4O34Hgk/KZ7dqkTWe239n+njJZz8nzl6dNyiKA20/PFQpTEZnHNNKX5?=
 =?us-ascii?Q?dTvfxvRJdAtTpfmS24zJl7ESJR3IoDK85tPVRaUn8t2agXUSUA1l1jtTBV/A?=
 =?us-ascii?Q?LKDDny0qil3nDEYpVDXl7O7KfWCHtENtIEeQjjjIa+zODa4sbvmSVA6ngm3K?=
 =?us-ascii?Q?EdD0zxLTg92AfOqZJMjRUOC3ktcc4JicV8Zo6b5iKS1Uu7J2YFotMkNRsFiA?=
 =?us-ascii?Q?zOEYjOX8Acv3yfZLgSRNbtj2lmCiAyT+VDWx48kLMFDYXHOO0ZXDEEoVOTRP?=
 =?us-ascii?Q?Sr7OqSird4QVOGs1uS1vlbOyV0RM2LTFQ/dbv17IESpYKfmMZ60pIzIAeWTe?=
 =?us-ascii?Q?KjH8UoCLX+RpxyWK6rq6kT7huEosQmcfJ64nqxEUEHBqI7u2jH2OcLlXu67c?=
 =?us-ascii?Q?gRgJ7Okd9zXsn9YinstxMCgZRKOs3onsv//qPC30PFn/3alXaMBfIGpVHjlJ?=
 =?us-ascii?Q?dAzG8diE4zcBV47rFRc1Igy5WjSLsq/pF/SXYUYYf6XxtBTgBKawXX5FQ/5x?=
 =?us-ascii?Q?Z9aBYrNLOMhTq71NjyW3FjWn+seLD3Gwyh7CnuOqhIlTPjGP22xMK0ivjkSb?=
 =?us-ascii?Q?zRGOcS6YVRx1okWzjcoVYrZNZSjxPnGJ+n/HCqYIArhG5mx2gk7vKenG+7u7?=
 =?us-ascii?Q?CW4KOUWgKfp3B07tvEtoTF2QYkyGHdwBOD0wgkx6M4YiolXbIqhtzKgErsCE?=
 =?us-ascii?Q?3tWGQtnfrZEQsmB7KmpAwREXL50BHj5CtOss2o47hXvTafAdHelnxnWTHaQC?=
 =?us-ascii?Q?+XnhAMk0U+decjb3g5ied0rDhArL+bOfKF2P0ZAq3xyvt/+YvR5wVuBgfo9W?=
 =?us-ascii?Q?hVWxXBIUH6t/SdU62dQV/p7F42FFLzsOjeZtpUpkW6Z1nZ3hYLgj/LsnbWFQ?=
 =?us-ascii?Q?8Tp6x6emNvNnv0v2x1I2EUUXAZVh3Nyctbk0SUHuPXAsyx/zHW4pRNwhyMuw?=
 =?us-ascii?Q?wBKIvNQlbw4tdCF/F7q0f+Ousg4r3OC6fm59ILmY9siaX03YES0w6oLM2KtC?=
 =?us-ascii?Q?Hw0PGc9yPHcopApTxV43neWMENtI1oOlm+YvSOqjh6l3NeTfbloszUmySeyZ?=
 =?us-ascii?Q?ua7RW6z383bX/OpCxT0XneYW0sZ3eTW+V4BG944sKdqfklKcziWx8PcbQ0sm?=
 =?us-ascii?Q?QkNkDPAJOIeeTcB9P0y7ioosqbe58ebrus/Wk8S8mG+S8UQ37p6FBm+x58sz?=
 =?us-ascii?Q?4TjDE4VjE2OQvXZIjP2nIe0Q5XGGjNHp54Erzp6rHvmFTBRvy8UEq8nujGXD?=
 =?us-ascii?Q?RXZsWRZgjAMAJMTZBpirgOpe7NsLdAwuzO2a25jQiXJC3S8b90AAao0y2h25?=
 =?us-ascii?Q?F3jzN3oflg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 769c0af1-0c27-4ccd-eaa9-08da3ecb2109
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 03:52:18.3208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mx+ITqPrTmg8z5/i4pNi7hSZ4brKynPysWRRilval/pCGAizwS3b06sebVUbSgMWdGu7JU6xBKsMbwCra8edVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2324
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
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

