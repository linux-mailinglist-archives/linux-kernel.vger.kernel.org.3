Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898D15ACA42
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbiIEF7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 01:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbiIEF6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 01:58:47 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D197133E24;
        Sun,  4 Sep 2022 22:58:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jG1SSclKEfZGUM/g3Kz0gpsCMOCaF8vPF428Pi9XHZRI5O3NN7TodfuOJuWgc3CynExnJALlmgWy42jUGe8y3Ob/7zy9DZGPdx0CpOY6+Zp6WivVTYZ2TmEpic6r3kUhPSYbmW7uDL3S5lUF3+UipF435U4Mkr+KK5NstlPgRuCUlUrE+AqPUEY2GOHrMhbJS0mYg0GEAbReRI85b7T0aL6A/5NkxGBNY/4PE03+Z1e66R++VI6SLpMQzKk1pkiEWoTznYZsv6pAuScJy2U1au268Ale6pRq5NxGW/MLoSG0bIwhaMaiE5OX8nkkgu0V0f24WOFTRa/fTAHpMaX0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzEW5jEzgVvSZi1YVla18whsZl2i+zoS8rRvYiziwx8=;
 b=J2WML72cjxPV0h2eaKg3DOoSoGu2I2NAffjuCxMJNFizrfA9OWWwVDcBdNrFYqi3UuU8GC63cBa8VLLkoJZ4xjSpDQ7daJwWT3yoEkXxSzSyT4Yn/16zzI2wU3Looy/scEMeEqb5vT8RsH9DYWfPAeZKJuUF3CAYYFQWuM1fskwzUmRyBlsrlEYnsYf0xnBEpoxsoZMetcfcZkBpSmkRm4/C18mmFVE3xBMTrv5Qxrh88qlB/O40D1/+jjMG7MWsW5eDEK6m1PUiYm4zGRFTE0QC27P/3RPBnB9lM5fHM4GRlGq/0pPGLGY0bcYU3OawreOWRLOdOmzqYvn/kPtCMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzEW5jEzgVvSZi1YVla18whsZl2i+zoS8rRvYiziwx8=;
 b=gIuhZ2pY/4JEbQdkGjg9IXS4DbQHuUUdxzBM1p3/xVIWI2CrN5ioGWR3RzbVraAvTpvW7fHatPo+NY/TFqPV/v+0FGwD7WxgMBXWDKI966pwnlAX6f1mhnNlBGP2IQo0427iK9MyDupMVCjc770AFJmK5uUEtWoJu44PtN2cl/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8276.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 05:58:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 05:58:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 5/8] arm64: dts: imx93: add blk ctrl node
Date:   Mon,  5 Sep 2022 13:59:12 +0800
Message-Id: <20220905055915.3878000-6-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 94333b34-3b95-4be9-debe-08da8f039758
X-MS-TrafficTypeDiagnostic: AM9PR04MB8276:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GAI0NSvW+1gH4SSNsl2Vk4/6rP3LAYEvp3qapSuDzN66LeOjJmhw8kCQLw2TBhVGyCbq+K2sjxm6XAyp7rGJj6AMWOj+K+bFDjY+6SVxEnhR/GbMadJJbmsZBSkPDYT+Xv8nMVz4IvZ3Hg2F7LosENjcSr88T35dl3jMsum5QCiIT8zdlR+iaatHYUaDm7mTzmTA3pNncRYFNUCkTdhE+lqye5PYAgC3fZ1SewGVfTquUK3W/3jZwmqtHZIpz/TS/wFiJwHkgniH4XrD1mWvaS2vuv7/AJ9WkvEJ0BGKf6dS3nX/B6cefV3t+tw8x8L2z+iDeY164dBy4RZRf2iWs9IDJZIhNOdRM1ouq4GrIu0T8BBOCwQXnd/LHF0v/GEyNq395wV/JrHlHYWi19Zq4/KkKIBXsUuRHtt34FWofa5BEhecocAIbIitmdJs+E9J5Qj6+YaJqpjO6+4v1MCfDCiXkdCM4OTR1TsCoueNK3RQUESDRhIF5jXWYHmy/IQfffJx+bwlPXGvLae/OuNx9Kw6YGRdi1gYoI9vL+/yJTK1ORmLub6C6K2WIHmC2JBDkaTaUmlUmE1mrcFKTJ+5M732jTTcqVCq5SGsUZtph/Fsen7cWIk6VtL0nmmOkT/bRVpxmMTZMu55QyFYDpJthIWoueJBOuGrUf7f9v2+pAud1OtM647exS/FLHROFUpD9mBMclfDUFIQ3sOu7C1qNC+tZX4Ji/cx/whiSMeUU3DeQlvsOhkzVcNcaxLE9SEm5oYDSpOQmot1SFRAjrq4MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(38100700002)(38350700002)(478600001)(6486002)(316002)(86362001)(41300700001)(52116002)(6666004)(6506007)(26005)(1076003)(2616005)(2906002)(4326008)(66946007)(66556008)(66476007)(8676002)(186003)(8936002)(5660300002)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VylpR08Q5VlEZxaNDWrCRY53AjT+wmcyEcoXx3vrBR4z9uZv8WsRRb9mymK5?=
 =?us-ascii?Q?SSwzAuKmAuugs2qG+H4jcaO0WrpkwAVS8PbDbABan59RvDcUiuooVgrY9siP?=
 =?us-ascii?Q?XIpjoJiMKQLJwIrmnw0yEFvtQti76Q1cJ5NBOkunlHgVY2zFT892HAkyUUg9?=
 =?us-ascii?Q?ejYSq/CXG0vmcD9rtDtFTBYTwyTT/OFNe0Em5EHcymtkdx7pnmWXwblzlyjF?=
 =?us-ascii?Q?MJO8Qnxoe19xxM12vl1BGAcP92R05fA7KSpRmBNM3mQRRVwkgv1aEX442R5G?=
 =?us-ascii?Q?Zh2I1VhqmFg1JZiyz9kA/QeUpC1gw+q9RWUTeFWmxwKp2dGqAohvKKMj2skP?=
 =?us-ascii?Q?5vTO0B2VJdt6/SqaoOT2bBS5mvXhz9NYt8JcQzNg7BF+ALeq2x//PCVWKZ+V?=
 =?us-ascii?Q?6TOugQCLLH0Rbfp2BCu+VjH9IVbCCzpSRAPZSB510i3yzJMwPiNpkPffLXP8?=
 =?us-ascii?Q?ZogQCdqJeWSAjHm9GMMiWoxDBzX/LVxUcaGvftPOnqxL1z6ZIZ60GjwAFt2C?=
 =?us-ascii?Q?EfgHOAIz3KSOXtBboBPoCwsR2pgp3p0/y8iraJvTW5v3kNW5CI1+h9NKFxJ3?=
 =?us-ascii?Q?kqL1jWoOhWX1lAati2gN2+rgnmkPsV2NEX7HL+BAFve8Q7JHVGsP0sPsNk2u?=
 =?us-ascii?Q?pQW7KlR6HpdsumXUP9/qBOb98/sBZOjW507ZpCWyE5ZB6jL2BjHP61sXKrLz?=
 =?us-ascii?Q?yPkmNW51gwzzYVGEvwtYaHm1/nLl+btCBxoGZ6JVFc8aXNjIu8FmHddFpJSr?=
 =?us-ascii?Q?N2iIH2XUjkFF9Ihr0bKMvlh1F/Qu3b0tdX0zuCbBHCgAmhpJ1lFUV/86c55M?=
 =?us-ascii?Q?Nh4K7FjRvx5vcMqagvg3uYW9OOPN8/eYvUHwmL0rWJIGji3isflOmE56PYM/?=
 =?us-ascii?Q?VUX7R5ucTYoDK1y2ioL+m6vTHQkEJ5unUlH+cpzj6rnZ+hnUyB7tdRYLRqT1?=
 =?us-ascii?Q?fF1SxiLtL3viEsqmi64yoNxxDf4TP0GgqAo7Okh0u3/PC9JaRr1M43Teb66u?=
 =?us-ascii?Q?48uPuP58PJGLrNL+wiVI+b5KdDoOdS3RWSFVQ2wcOH7hlnzjkEl8vFkp84Ga?=
 =?us-ascii?Q?SqFYaY/DaWTT7+e+x1jF6T1F0WlOfaqH4TCnNaPZiVT4er9ElmJgLxVVruqv?=
 =?us-ascii?Q?zZJevSC/k+svXF8OiO7WnIHaHohkX4akDnxTERNEGCZm0HDPywaBqwrqdkHT?=
 =?us-ascii?Q?AKvbd1dvwwxwoI09KjctYt8xKmFHTHQwiD68MeMoMr1wh5Ir5irLirn6SCp2?=
 =?us-ascii?Q?IEdAJyB8OcUd2Gwq35fvl+2RraRQDFL2Z9aPL1pyb9RUPzH8z+9IqlS/gTbg?=
 =?us-ascii?Q?pUMqFydJXo9pXYAgqhbUcLXGhYntwVf9+fmThG/JCNnQW/Q0bjlAovk3DnrQ?=
 =?us-ascii?Q?ItYdi0R9eq3A9VInr4VF+0cmn1/SVitIoFKnQUBM+CcZGRbvYMjSv+FV+r6/?=
 =?us-ascii?Q?FjTNVwxVo/LH8/xcO0kxRkm4dKQhwNwSkyeGZzG9P4DcWBZWWTbrx0klWJ0i?=
 =?us-ascii?Q?XsuBWIzxo2dlUbPJj2wwYjma7qkqa/lfzzIMf2n+AVEWa4L6AKGyu4AQ0pW5?=
 =?us-ascii?Q?VykfFtmHaptRoeBwV2lvlXXulazkNVepm9twV54j?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94333b34-3b95-4be9-debe-08da8f039758
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 05:58:01.6187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lo9HBrOiouGuHaklGCEJUr+LLZgBxwuxS5H1KQKvEV0rluPQIiRk0q+TfzMFgrXkqBxmicUXk0FxWi41Hz/+Ww==
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

Add i.MX93 BLK CTRL MIX node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index bb9e96ffb70a..93f96067456e 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -112,6 +112,11 @@ aips1: bus@44000000 {
 			#size-cells = <1>;
 			ranges;
 
+			anomix_ns_gpr: syscon@44210000 {
+				compatible = "fsl,imx93-aonmix-ns-syscfg", "syscon";
+				reg = <0x44210000 0x1000>;
+			};
+
 			mu1: mailbox@44230000 {
 				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
 				reg = <0x44230000 0x10000>;
@@ -174,6 +179,11 @@ aips2: bus@42000000 {
 			#size-cells = <1>;
 			ranges;
 
+			wakeupmix_gpr: syscon@42420000 {
+				compatible = "fsl,imx93-wakeupmix-syscfg", "syscon";
+				reg = <0x42420000 0x1000>;
+			};
+
 			mu2: mailbox@42440000 {
 				compatible = "fsl,imx93-mu", "fsl,imx8ulp-mu";
 				reg = <0x42440000 0x10000>;
-- 
2.37.1

