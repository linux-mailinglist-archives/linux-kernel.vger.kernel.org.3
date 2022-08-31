Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AC85A7ABB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiHaJ7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbiHaJ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:58:56 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50044.outbound.protection.outlook.com [40.107.5.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBD8C6E8B;
        Wed, 31 Aug 2022 02:58:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiIM73LAzgF2x+Y39IAj/gdxv65gu6m41tBA26mXGgydOXqMJbaj71zlUV30n5SDDq30B6mMnGCTlpdh8JrL6HN8i6h30VzlzhC+FIk0NFbA1Ll8Od+IDf4GUcHxB43HS2eetGd+Y7YTQxD1pE9cEzvJ7jOD6Uv+dwyFzAlWKrj2tXzbt8qUEMYM78FxzZKAOsvAggpjoJmGSVoewHz4yYkZqCrQxOJ8wx4wWtn16T741L/B67FyMDHiePgCHGaBwW2EwS7AvAH8lFveR5qc2a4epymi3BU4Hf7kaJTrzRQu62yaCHjLegSMao89cfnEqCvZfV6Oax4SKCb3YGsdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mh4cu+ewd+aVMhvDICL1Sz0c69YEAgEF8iwcoJq2wag=;
 b=TB3kGo/+DFYVBDJS1pLzoUhY4R92jC4DzTgafdph18jYAy+onyQd2OcsAMsOCEATC6r0VOmzAyt0yl5UqDGD1MGpHAlk/nhzaeoQjlAs2ugxTV43qYRXOi/y3kgUzOLGX0vXXgHeVL5Dduy1orJWqIaqPs18eSY1ZlUocukeHJZjr6gSC4dCq6MTFxyQkwjIy7jKxSQn5SK3inMRjRpHTKyZBTfo/0LvqGN4YCi7D5PZdAVGSYO34kA9zSr1oNoqpt3O/kMqWKgVLghUu3H/FW5/Y/MPXr3eUtT60X/ULYfk+846eVMuy+5yVakXy/b2PsYvsEkj/LdgTAxWqhmmWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mh4cu+ewd+aVMhvDICL1Sz0c69YEAgEF8iwcoJq2wag=;
 b=J7pVYVky9Mt25wJ4fKC44X32ZWUjE38Lxw86tECU4fCUQdWPy5bxwqcKWlWSfF12FFzkrs2NmVsr0sUoZXjBh6oUEABE0rHzwTNxubfZwh1dkx3hWvO/Ip6H7RHuf3bpRklCa+/DBu+fSzpVfin5rL0sLqN0948JfJ9A6DTRNiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5671.eurprd04.prod.outlook.com (2603:10a6:20b:a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 09:58:51 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 09:58:51 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/6] arm64: dts: imx8ulp: drop undocumented property in cgc
Date:   Wed, 31 Aug 2022 18:00:11 +0800
Message-Id: <20220831100016.3649852-2-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 34a49651-88e7-4919-9c7a-08da8b3767f8
X-MS-TrafficTypeDiagnostic: AM6PR04MB5671:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PHZ6acZQ4zgLKt47wAe2SlihYpBG4tECmHO8fE+ApvqMVn+EDu1+r6xjFwMwxjQL/Xuk0C6p+6nNw63tJgFVZlJdviXCaMC9NNppKXkys5ys76bzbh0nnUkUuNKhkJIZd+bKIiZI08dXkgHDWp56Ji1bCxJ228ImTniOcSp1UsKkdIvufX+iKmjlTECaG9V4ZKDXdWhWveC3M+9KE6OvvTZLo4dLMLoojFezOGG7Gc/4dlAFpFoBsVHYdgZ7eJJ/xIIQsXfocLzvXLdBh1QInoit115/mz0gzvoRQf6WaXjOFJTuIlcvRDRWo278fvHh+p/nhsKXct09NmkyStQR/OcXTb4wKT7Y3zEPBstwbcmJxQDAclJEoAJ56JPpCUw5OePvun2U0n92m2qDNpIuTjDn0aUkws7uRF7KB9agQVY1xAhEQUvcZfFpE97M2s3VcmEqnolWB1I8rQu8xduOdlZHO82k5UKa2DVx5XlCZ/aCEVrYrZjxE2n5OMnxVWNX+u4xJ+0R6hIX/+2sfqfZ2pymb+4mOjXcniy/vTmCjBLLea/EEX9xGcMkJEvS/y3WipCSHiS5zlrq1j8RZZeoGHanmXkaFhbvOfS2KU0rKlNR2CES11mHm2W5BVkXR5w/+//rJwQiJEpEp2KZdxspHZj3aAL8Aa08XC3vCrVB7Qd7UjLeVsDz2My1JK5KaALMgCcaX32xowz3gm5K15Vwm3vdxtg70NtwcD2uerkI4SeGboWj4VIEnz4oszHe9yOOF8dbGK9IZgW1GTNVGLHFSUgay1306UKmFmGOWCCHHLI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(4326008)(66476007)(8936002)(5660300002)(66556008)(2906002)(66946007)(8676002)(2616005)(1076003)(316002)(6486002)(41300700001)(6666004)(6506007)(52116002)(86362001)(6512007)(26005)(186003)(478600001)(38350700002)(83380400001)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hVMncT0bWZfp8gaRY7IepsfeWOKeg74iIsQPWF09s2P4KPChGZAuCXoXO27T?=
 =?us-ascii?Q?EeLSgboFm6QLQzQ5bsABerFT/bEJ82DA+F5TCaMzqHbp9tdTjsstjm+gfz61?=
 =?us-ascii?Q?xEqqbI7nFrQviN9iZ/lhlT9N8bfjlloyIeeR00O08fxCnGnk+A6e2FUP1ASq?=
 =?us-ascii?Q?BIhoAtaga8mZHvrRABZoEMVDOHGhOqNIV7uNIfzcz6A2VzFaXvKQYAnalO+R?=
 =?us-ascii?Q?NiFVAsKI/nnw4aoZmTzlvLgbDT08wgXtLDq4ihlxzsYE5eDJJGLlh2qowii0?=
 =?us-ascii?Q?8qWaY8f8NkhLlueNZiKzCMoyiios0DMEx4sPH+n+UNyU/io6qNHvlwG5WnkZ?=
 =?us-ascii?Q?f9TgCs/vZqxCnglt8eKSu4L2b/VdDW/J8KxwHMAa7cwjmj9i7KH+7ZBwbo6n?=
 =?us-ascii?Q?E5bfmmwU9M3eoMnTfXqUpbGZBQ7p9NUWUXv77BmdqIbP/aMJGPJcax1Lig/F?=
 =?us-ascii?Q?NDsI+J2NbC27nNE9sfYTRZ7pC6YGxtCXDl17hJfuJ/4ybdFJOmv+eBkZlaJz?=
 =?us-ascii?Q?uWT3Abw9khBkDS0LTc2QTr5qCsRxoKa+2pzi8xGK+vrO5ze1MWSD/NZLmbjB?=
 =?us-ascii?Q?rYlf8SADF/xOx5uAQ4hTHadFFICWcC/RgJXV2/kP1zbSC9A7dqyAeHxwEs++?=
 =?us-ascii?Q?h0LC7gEV00C8kmocFsFmwD3Wugetikw46Q/Jlp/9BkhVhVeCqGU/kyecNR53?=
 =?us-ascii?Q?WJc2SEsPcQ5qhgSNcuf5jcWxKLvvCI5eOTrvtaQ7V5loITRLzKVvbwPRF0h9?=
 =?us-ascii?Q?VO7oF9kjFa3ckDROkYF65ndLejFxdzk9y71wmzYhHJ7fcQ80JW95dynW3W0d?=
 =?us-ascii?Q?vDn4fP0PmniSjKDu8GjEeymPCODnN0t29AigGvp/JuATRxVDGKoLtpEsFpqU?=
 =?us-ascii?Q?lsgiA+bh0qMPBluW5JrxzogCnMJUznakyUcb4++5NDikmAUgCJeIP06E+0nT?=
 =?us-ascii?Q?viXTR1CnuKGeSiGOOnXt6Vsf09fX2jkAT0bHuje0ttESWBBLY2jl0wJ4/jMi?=
 =?us-ascii?Q?INoeDQbl31pVMyWWW3go5gDN1Kh5hOQMEYSqZW+LL5NTPMVR9Z0Jry2+xopC?=
 =?us-ascii?Q?c2TkqG+1N4zzZ51e4sqz4B/qTYe2Z7y2QQCZLLOIk0lqQ+iW4x+emTLNn4r3?=
 =?us-ascii?Q?SkbsIdBr3DY7kn1s3o7VIREFBiOPeMlErRcEKZN7c/RljyZi4fsz2SpBu2gv?=
 =?us-ascii?Q?dRXCo55miPsrtAGYwmTp8/ddLDKhrjialARYRtvf9Cmmveqda1zCF0Fc+Wa4?=
 =?us-ascii?Q?b/gWuakHFPAVZ6ZlyBlejoyrsz4370vqpdC7yPsDGwA8WtQQ7RItknmGxi78?=
 =?us-ascii?Q?8CDg39H1wlNHNru7/3n60VDzOiMsztViSoCrXwUjy9l5pqtPmrWDmRQOZRm/?=
 =?us-ascii?Q?zzVLDR2weVL8ZlPibjhZ9csgRts509j6Q8UU95186vMgzNXo/D/Svdm7eYWJ?=
 =?us-ascii?Q?xSo4VSkOkVEgSfENw8dD/C+Y7jR5qFBIPHgE2wRpV+rL74jM21ygAOfFlD8E?=
 =?us-ascii?Q?0KuRcsczuTmNoSEApmZ7y676VGh7ESfzqENt6ZbGaxJMqRfQqjTtNnLX9Xwl?=
 =?us-ascii?Q?PdmashLpLJxLADqY5UjQ3C/BrLrYFV/3QMCwdw/E?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34a49651-88e7-4919-9c7a-08da8b3767f8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 09:58:51.3582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIaImjKnBejWzr0NoowU4R8oCj8Z73b8JMXTp8bVm/YKVuZyXo4PmojSu1OBOw5q7su7gXe0T/PRNEzaVcDhLA==
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

The clocks and clocks-names are not documented in binding doc,
and the clk-imx8ulp driver not use the undocumented property,
so drop them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 3e8a1e4f0fc2..8460a3cba107 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -164,8 +164,6 @@ wdog3: watchdog@292a0000 {
 			cgc1: clock-controller@292c0000 {
 				compatible = "fsl,imx8ulp-cgc1";
 				reg = <0x292c0000 0x10000>;
-				clocks = <&rosc>, <&sosc>, <&frosc>, <&lposc>;
-				clock-names = "rosc", "sosc", "frosc", "lposc";
 				#clock-cells = <1>;
 			};
 
@@ -416,8 +414,6 @@ per_bridge5: bus@2d800000 {
 			cgc2: clock-controller@2da60000 {
 				compatible = "fsl,imx8ulp-cgc2";
 				reg = <0x2da60000 0x10000>;
-				clocks = <&sosc>, <&frosc>;
-				clock-names = "sosc", "frosc";
 				#clock-cells = <1>;
 			};
 
-- 
2.37.1

