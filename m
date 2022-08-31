Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92545A7ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiHaJ7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiHaJ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:59:06 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130075.outbound.protection.outlook.com [40.107.13.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE9ED1E20;
        Wed, 31 Aug 2022 02:59:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TG8CDud3fYEsgOHqu5RAhNZ4FAcTyn5di1SWMquBf60xgXocwa5912b7rDLYRCDkeuzzleNlJf0tJbVScO8kKMKQZAmfj18ZLKUhwppPTZ7j1vxECwyPSeMyBY2E3SgKyCbqQhvMExHMVEWaVaCUyEsAU6u70efQzyxJRPcYcOomTXcNzILzJIDm17ZYWMY3JncYql4BYLUYy2O5ZnGoSFAjB/BA36tffU3StIAdNfTrCLJWl4A1tU6sHaJGw6wjZ5I2oKZr/CzkB6Ra31xUvSgHjqkhG34CDZmccbQFpH5/GaDe80o5qFoO+E/L24Vs9a4ewqEiI0+UoxKCcsPDuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77y+gmLGE6dNiFf+vfo1d8H2kH3tu2PmlGeplUWZhpo=;
 b=WXPmQ6j1g2cfODbD6t7D6BDPv2Xq4ajR37uHJTq4TLANhxKFN+6t19LslKof/8ZJnCbzfYrKTgyg9NbXp23OtFL5kKOjlDbFsv6QM9DpgbHSFPfpqgRKEhL1GLPaweGQMcuJVt1KKakvaQRSV9r6lsupHfKMr8WoalxjOg97JDEH/Sc++3nGZCE2oS70bLWnLMUL17O4jHCWcS0LLqQ8YXIQ67rKYTK8REL72yVxHZZaAMPWlYqh7X4w8IPaNrL5GM4vXsuBmcRQPtpYZDqJSjtRJ0LStatL7bR4dxSWRThl5pBmfpiywNubIVkQ/YmM1/I5/VX8z2ZTqmK5yCCFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77y+gmLGE6dNiFf+vfo1d8H2kH3tu2PmlGeplUWZhpo=;
 b=Xu/8Vt6nybX0+jRBUuw7+nM8NnmNSAVfgjxgX+G5nYoJvpB+5eORXfYH4WsXREDv1y+iRgibiY80/QhsE1KRg32TsX7nO0GUk0WIT5ZV71dMOggtPHrtIlD9jxz+3ZExOPsSUZLcdYaUtC5NQ5Y22IjmYZDEg4jVFhm5ddD/MTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5671.eurprd04.prod.outlook.com (2603:10a6:20b:a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 09:59:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 09:59:03 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4/6] arm64: dts: imx8ulp: add pmu node
Date:   Wed, 31 Aug 2022 18:00:14 +0800
Message-Id: <20220831100016.3649852-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831100016.3649852-1-peng.fan@oss.nxp.com>
References: <20220831100016.3649852-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 515c4767-2f1c-40b3-4ff2-08da8b376f09
X-MS-TrafficTypeDiagnostic: AM6PR04MB5671:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Avy672alGsv8HyqUf0wGtHuE2/wI+5w9hPRkjE7A+odh1GmMm88SZtcrCDffSwTuCJQrq5XdMwCZPsK6xixR94xo6B/1oKizGjmSia/Zeuub0gdfE8yrcj8UqlBcy4B8hjGN4QQahHynOTtaKuLIL1Hw2ez8PNOWb1Um5Bo7J8VJbzX/4c60oC2Fx6vycDmwGI8Xt1tpyyXl4PnCa1UeprAPmg9/ifgT251IeaXIYI2CYDTafpjfLH4WtqaaaZ5gHVYEfgOYf3t1b1V/Lw1L3nuAbQMa8WbudI/k6NDvqKWAJoTnkysfb2QVjBWdLlBDROgstA04Mi4MQqMU19alXD/lePyALrx3jmHoopEBgezT7/T7uYPfo7hUc9XeLxHPYDWVCo6nivpCz4mFq2KtFel7hXW2uH8+ElTuebqKro9oQpk6g2JcKVz+mwMKFIDXXfEPGSUyr2nQBu4735X6uX34cV7kmIXgWUD7SCRKTvOyskgEa6+l8FrcN3d+2i9CoRiwZCHlkfb+hLZCYU4Hk3LAP2OLR2PjMLIrycz1TX1MalUTh0tFnU+HsgrVg1CYoAyqPnKEk/sNedGeP+BKYTs8cVgL1LXt7fkrWRLAZBUsD6Q5mV/RSjRGY1athFnP0ttpHWc4owoaE6vzw+PP3EK3nZYJr82B9zwmrKV3SUdxe3HlUSvLDSFTPqALcW/tgXTMopHtevakQmU911Ayzo0pJ/XqlyJa0DM42x3/ooH8hHubj2sAmG751ODlFatBmvSPyuaLDhY1cogfty0y7qaqETQtHf/WGzL0H7GVCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(4326008)(66476007)(8936002)(5660300002)(66556008)(2906002)(66946007)(8676002)(2616005)(1076003)(316002)(4744005)(6486002)(41300700001)(6666004)(6506007)(52116002)(86362001)(6512007)(26005)(186003)(478600001)(38350700002)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ms/MgdS2ayuCFVNtnYSZL7r1+x3S+Tv9dT+3uHm/62HV+Dr/G5cUg/MhB/Up?=
 =?us-ascii?Q?LG01ODSoUPJd+upmtwaMJmyotPzHuWj3sfM8FLis9DB/73PVjlb+ZK5jhV/c?=
 =?us-ascii?Q?TmlUAwSSORRmISANBzztM0FULxr4IjP4JPV2J8vBVcaUPPWtqbUHaAHFoA1L?=
 =?us-ascii?Q?30TE8yqepIqlHEmQ8dFKPiR1NzKgn9Hni9ZkUIGhB/RObqUUVqLdyQb6p0Nf?=
 =?us-ascii?Q?9B3y2Mtag8Kui/3+Ftr64kvLU/FCvmzsPLauHY2Mv70NzS8som6myQ4046bb?=
 =?us-ascii?Q?CuTO77apwXNOYW9MFmnKyzgXsIEklA2PDidzPlP3cdS8YUVYDwGsiOBVlV+b?=
 =?us-ascii?Q?SGFhTdjEzXUGlnpIaI3idCVRD7qs/cDG3Gnak3Z97uFAzhwzebzLYvEKRF18?=
 =?us-ascii?Q?jeE3lsXhfBJd9Eyd8hvDkndGpVYmMa5A078VbHiA0QZLngkKV77i8NhYgQfh?=
 =?us-ascii?Q?L0yo7Cn2d60/A6i5heMhH2BMjb+0US4NMhreco781MMSSux867gGqIJjrwxI?=
 =?us-ascii?Q?KpUXio+6BMomkm+FMamNbXduf/YrJ8LW/EePFHsoml3vm6IV99NmHS2j6u3/?=
 =?us-ascii?Q?K4KtM3zGrxOi7l8uiy22PR7SFvwcBq5lXv9vOfZhXHERqkVAjHsvp97wNjTH?=
 =?us-ascii?Q?2KHnUQf/331LQKuHKUS38k/vvlIagDZA8Z9oM+PUf4XaM0TWHtRcwrSGh2KV?=
 =?us-ascii?Q?17t387gQ3KXpV5EzMUGJQbR3s9Uj9ZbJPOF4NniJLrvbK/I9xYyCeqqH04e4?=
 =?us-ascii?Q?Aa+D1PVcZcdtLGTur6zUSLPjr6YGVaJQuJ+EcFKnPvl9fytO+NgGIkCUlM7e?=
 =?us-ascii?Q?WtHQGhlbGJgart55HQeNrvC0iBsrPdEd5fkkdziEhEqS29C60kmLAk1+Qytb?=
 =?us-ascii?Q?XQSlKVvjTE/QiY1/1qfEylSdTpUnCQmL+AWIAL52krpYnUsjODwn+9tEn1iQ?=
 =?us-ascii?Q?I1lPD1p+YifyeURqGCk8Zy0JZzCRPl2Xql1l8TCirfkc8JN4x9BKjdA7+rRD?=
 =?us-ascii?Q?er/Pbe52gutcqZl+JvnX/d6kgIvgacmY0G117ecZMUKfUYnbo0oGBBodI26q?=
 =?us-ascii?Q?bdoIFVqEwysp633kUwKZZNoFzIrWyoXFEY/pV3e8SsZrYf/6vzy+aaHa2yF/?=
 =?us-ascii?Q?Elf/F3xFQdFC73u8meHr8nRJ87vHVTz0GrEd3ffNNPqMj8fG5eO/ojhx3KJe?=
 =?us-ascii?Q?fJKTL1KVBsvQIfNWKjlbKJguUNfHG8L6I45fUw8n4oXs5PYf1JSbqA91priw?=
 =?us-ascii?Q?NAIPobJ4Hj/PbbSaMHqrtLaPUXZAcEESpGfYoyLXNSMkE0BlhGfefN1gXFNn?=
 =?us-ascii?Q?4OrmOZnRW7X3ZpI8ZYdYUQsczCuscLzyC/R42LxVCcXKN7DSt1Mdxij4uQf+?=
 =?us-ascii?Q?bTRavpd5XgSBKrCVJuhddcENry8YJFRruU9awBiGRVr/cHpP52CwZZfFDaeB?=
 =?us-ascii?Q?QUQv2o8iAxriHwpMS8jCTESSAFfTrkDmwv1jPNjcih+i/HyOuuCzgIu6Cl9A?=
 =?us-ascii?Q?U5+lVDtrv2AxA9/6w9v25RkKClHUq+yj7syGfUutnz0kc5VBoB0FTP7RcIcn?=
 =?us-ascii?Q?IuNdKwKBXVRITWuEcFIZNla5m5EM7iyjdjCqHO6j?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515c4767-2f1c-40b3-4ff2-08da8b376f09
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 09:59:03.3220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqIg045OyqxWH0kc8w0fbqaFWM8GGpOtLjE6D+MLdL0Uf4CmvOmGs5/Rmq/WwolcoyOmSYLS1akIxnWpSiFhjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5671
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX8ULP pmu node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 88bb30384024..abec8ad4a8de 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -63,6 +63,14 @@ gic: interrupt-controller@2d400000 {
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	pmu {
+		compatible = "arm,cortex-a35-pmu";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_PPI 7
+			     (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupt-affinity = <&A35_0>, <&A35_1>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.37.1

