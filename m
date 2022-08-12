Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F8F590CD2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbiHLHpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237510AbiHLHpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:45:01 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00042.outbound.protection.outlook.com [40.107.0.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB6BA6C1E;
        Fri, 12 Aug 2022 00:45:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VA0K8QCASBPkRKzBtgLq230WQfzyd5SRvOXSFtL55DZ/npfngLXBXGDffP0WQ2OBs3PzXpvYCeDK4moO81yf4FLK9infRPUEy6g+0xGlbCTETbezaEuqRu3qo0+S+ImqBWzRL+t1Aqp7sgdhI5Ni2oMrcaTc4cdHZZpTQrHoBJroz0GQGBiWJgh/f/A8XQsi6u20WK2A0r1o6bgqc3ab0/S0WLdLuZsj9xELbhJ+8+NE3NAoIyiLudMUAahT21rotJfvplbl3hLFBdao4ETDYmGUyXYOBnC28osGjADovJsAdC+/L9g1DBUKBKw+IYKrUkcpbmjWkFqwhJuf7V8seA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wakm7D/EZfpADfiBjW47BP3QZhBuAPRGAgZi9bJE6n0=;
 b=fThW81xR8Y2OLua65j5vO+kQ25UXMg3zWmOMf1lWFUbkuZtQfwpujv5x6XfdrigDxbasX2BvkzpXRaPLiODeJ10nhgFjJc4Bycnh/aUogPjCUBM6f6FZTywFNGQp4ul9dXOa0Pbz6N893T5TlXcbDEQjZI+uy42/0lh+DMP4LygC6ERQz5VdcCEVwLp340HTesUoNc66OZF1gx3mbtrLlD7+GtrRYU2PrQVBmkBBFZGk0vHpfl2v/f76+ItHi8ytmFqBQBmXeMUGIsGVeEXVBX1t7YVpWkMUMQAhaoAV8jYQ6CNgXKty4s56npdsCTME8tx6TE/hY56I8/ahM1C38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wakm7D/EZfpADfiBjW47BP3QZhBuAPRGAgZi9bJE6n0=;
 b=eZBmfAARtF6/B+xp3nmN7ZCuf7DYniFJlGGj+VedXmuM3I1PN8uqhdiiUZMQaIxTmZswcGrphRnYqb2PP4ez2yjfG98fmgTXyioJyvBp4klGnZIE3Db3NFmhFowymH8YnGWg4+c4/hojNcl1yGPjwFCjFnN58fav6PRaqoVWEYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GV1PR04MB9181.eurprd04.prod.outlook.com (2603:10a6:150:25::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.21; Fri, 12 Aug
 2022 07:44:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 07:44:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 7/7] arm64: dts: imx93: add lpspi nodes
Date:   Fri, 12 Aug 2022 15:46:09 +0800
Message-Id: <20220812074609.53131-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812074609.53131-1-peng.fan@oss.nxp.com>
References: <20220812074609.53131-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a621c75-34ed-4b33-afad-08da7c368dab
X-MS-TrafficTypeDiagnostic: GV1PR04MB9181:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lKIDGOsFWVwFj5Gt+mKNnTbyFwHCG9gYzuB5gzRkwN0DZhCM/xXStAI0cPiLqoLlv+KmhfNxr4qTDjVGjCELUOCbW1eS2xYLAc48R9sJ5lxoOogD0vxm8ynuf/PFRajBhEqAhcRqIueZSONO7+3NpX8tCj9DPFwNvpdzWrnZuj2eg9bAaqQy89F+zOQLzCI4vkGIg2E8PAgqsCHcwsPgfOi9HEcvFbqe0BxdfosEFEudkyiEJs9aVG5Sk66DsO5DwbQZGsLhBLwK8dWkTyCINUOrMO51YS3twVKLLmvU+2iwnPryDx1EYAEdZ+OJ8qCZYMb/U0RCVj/7b8yj7yc/wTTQbnezK1XOuvLTUKybT2XyL7YtdbCxpFyx46kDUUCGfNZo2G67yIB+GRlyv/ww+6DgM8+Ju7hCJUDNKXJrVH7aOAx/U2PCoJZFW/s+AzRTqqXjRDi287F3xjvUeb2HkOWNPuytTzxFpkO/ElWbonmamTZx2Duh9uKn3g3OMxj2/3wF4TDh5Q2RHCdudWa1+erOPRP8sAZonlLuuQOAqrOJ9dsSPRFoehNDlVnhix9CMZD0gBJEYkKyyx2zShmTQAsvMXTlId9v1Tg0CY8m62U4RrBljJiE+mbc/gLbk/7r9bxxPlxAo3/YiisPdpS1V6uB3rcKQdggXEYTLvmyHUh5tVdObz6ds/Zzo6tw6SfU8ht0wTYhLd6nt0Apmie8ThCts+uq/yiEt8C7xakV8qOj2nwqaqBpgXWiqHCjsYFpz1QZVzpibgiNLn16ObmGbyAKFdXhrH55N5HP0Be9McA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(38350700002)(38100700002)(2906002)(5660300002)(8936002)(6486002)(83380400001)(6512007)(66556008)(8676002)(66476007)(2616005)(66946007)(4326008)(478600001)(186003)(41300700001)(52116002)(6666004)(26005)(86362001)(316002)(1076003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yfbTqQJ9DiLqJ3a+2Ek4+xcn3ps2nZCNVN8LC16lsUlxUwrGed8bhlOrRUqn?=
 =?us-ascii?Q?DRlff3pZygd4YgVHoJMlVVXp/sHzt2ynEoqv7W0R5dEMc7TpEoT0XhH95a6U?=
 =?us-ascii?Q?9lH5FgfrZDdihg/3IRGwaEBlL4H7N4/o7btIO02A3Wwddbmxdv1i1deY4/MC?=
 =?us-ascii?Q?5vI/UknSDi6FB0h0mWIXyRoFlK99R339VXUxYJiZRUwAq1260wblR/xqO1hz?=
 =?us-ascii?Q?Dj5S6kEoFSGCSQo6S1ybqCxfVoWmT+yHbud6ufQ2jReNzN7OVI4KAmi3tRMq?=
 =?us-ascii?Q?iNvDw5wzpmNXAPMlfN8M3hFDqrUX1gUo0z3x20MJPb7H7v88gwX3E2iY3cs+?=
 =?us-ascii?Q?FAYHakISP09fvLPohphxjVZNCc/rzIi+jVZ3vFrBOB+uyom9YUePPn5EqWKt?=
 =?us-ascii?Q?V0quieMfPIvZQmmWVlIsfbCDBk7BT4/St/CB4lp801lBYQ9UHdQjs247guuz?=
 =?us-ascii?Q?g/hW0eQwu0Fp5kzUyFWdaD6afFf1W1CP45M5b8W9a2p3D0QKcRKSUXBei9ep?=
 =?us-ascii?Q?8kxsE8YBBrJLJympo2NP2xNmU+naaCK2HLKDiWrQEWAVreVR8seDVjwqXUtt?=
 =?us-ascii?Q?4r+h2326siUaAnUBNMxSimaLgKA2aRohf7zO90t2WuLpbcWscE0bsu5oS6kw?=
 =?us-ascii?Q?aXfSuL5J3gEKzpDyfqYZFsj+1d1zrXrFHiDy/uE0LOhT5nEpBr2o4PPkArst?=
 =?us-ascii?Q?RNn6pIK/QGvM4I+Nm1bCdqDwc0/GqsKLJR7ReMR0cNjC8JZk+hdzXumpxfsn?=
 =?us-ascii?Q?Le6PPg5Amm/hqmFoESkfZh+xrqk3oeMBUXw2vBcVFoDvch8hZyCCopgki68/?=
 =?us-ascii?Q?QMuA7jOV2oKvOiwaG9aJf/K6RbkB1cjuo1+J0uD7v1gBOFTFguuH+PNk+372?=
 =?us-ascii?Q?NdKHkaJuCBk6HRGP8N7Hk2MFI3GFXp3JjkK3QdBO2d3MMRkwvUwOe0Dv+wGQ?=
 =?us-ascii?Q?4dCjw0LnERTJHTwxdTwm6L0WhqoS59pNzvMWNgJeimR3Y+zy3DxlHcwCLw5h?=
 =?us-ascii?Q?niFAHHVDgc7xZkiB7+w77/Gvaoy43V+dyk9Oi6lV/9JPC5BtktbfrGkDIlvh?=
 =?us-ascii?Q?WJ7BYSxS2VveJJptUBDrJ4SXPhdT885YLhfVMINroNwYC1NFavZ9wPIq1KJS?=
 =?us-ascii?Q?7HYgwWeKCxJDsyhl3D8jAYiW2qcQACzatTuZDTSHF5OgBMiaV+vCI0EIgo9c?=
 =?us-ascii?Q?jNTpXwT3IQEs1CboztrZrOKMgpurWKjVk3DKVdIBRrs2M9pv7as4VuAG1gPe?=
 =?us-ascii?Q?9sFpP1AGxx6FCRuD8TrYUhcCpAttu26duAT3igG0iIOE/YA8RWoLdB6CGIS8?=
 =?us-ascii?Q?iSYwRkXbKz0CQcKwnhe1ym6qbUJB7C0/VQ/szY3RF+WBK11CA/68Oo5Caalp?=
 =?us-ascii?Q?Qczf9UE4hBfR8bxqqSL+7SBIiE/0kkeiZAIX9jLiHW1+qCfEA9ETYd6fjHGQ?=
 =?us-ascii?Q?l9BzM5jQdOhdMAdCM6lpxSPz8QMxKaCDK0uYEgdkod2L6/dHoFsZKDkMaBf2?=
 =?us-ascii?Q?is6EndUqQM4KD3G6dErWA9+Nm7hqKNZty1jeDv4s1TYEwNUnvqoJ8MOuwpF9?=
 =?us-ascii?Q?tlgyaBMojR0dclTVKDD6hIwUH4oiu78WFeO9mkk0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a621c75-34ed-4b33-afad-08da7c368dab
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 07:44:57.5607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsZUkJt+gYlvpo0RVo9vmDsJ+SWnGyAhwlLc8/+MACaX3q/0/hvAEIuZUQy8VKsVFjVxIqqsC/CObvqgX1vufg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9181
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
index 3d1309d393a4..64fae970bfdd 100644
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

