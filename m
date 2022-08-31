Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD725A801B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbiHaOZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiHaOYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:24:47 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B87ED7CFA;
        Wed, 31 Aug 2022 07:24:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQGVdwj6WqnvBz9XGG9zQxhZLO/WgaQ2fQzFInSiUzXhyumY1X3yd7KOHoNVawPeDeP8eQQssCw9RUdioS+Yhd1GDtHl3lmQZQPv+A3mYE7Zjl+65uCT/rigHjhcUGEhWqdbnyUhTO89bu6PubxzrRkk85yVh57WXmrDk5Y/c1toVCto5zD49Sab4FN7ENVAjgXK0xEOEO/n/Gfy8K3BfTGwEI2hx5mQKCPXwtbxNe5ugWzQDq+GE8IZtLXMnyO0wjC7f/R3rzcbSq1Rcr3l1Gs4HW42+ClgL7c/kEm/OA4u6b1KcblV8G4NNwo9ntPTi5MwzDAkJsTKXsw9y103yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPtVOo/UFcBpXo6vMPGzpBZYIptv6UiNwBozCnNiJ0M=;
 b=PHi6kD8vrBe9U2adT6Fti7WGGohiLA+0WB8GEiBfxuIa4L9Hyd5c/xk/Y0nAfhx8PPIZxe4o1ajZO43PaPllgykQ7t5xJkDIsAocnca7CuNdyCuxsXiX8eay/N1CLVSCnMrt+JtUFK+KVXKOFTACBGlPXCJ+KeLCC9grcdQyWawJ5iyvDHF+tRK2j/WugM9GkesHyikQWdTg6zPH73rskwN15nOharoZDgQLYqQkUbwMIG80/u37pSxq4ufp8+SwHh/o+DnxjxakH2p51YH/C9SWJ7sNOp8Q9F2wrQeaAjNe9MQcYpanctaeX+19VbFJm2lCavOeZqqNLjrr0IvJew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPtVOo/UFcBpXo6vMPGzpBZYIptv6UiNwBozCnNiJ0M=;
 b=AmoFhvto1U5TyUjE0McAG80RaYE1OmHQDmfa2NnmjRPjj6yUnTPugTPi6icYkpUB1vm5FFqZHYwgSVW2Dyw5dk/QO4La+OWmwD5uC03NcLQvjmrdsKQWj/UaBoGExSGMyrXq6GdlPOP2/7Qe+2UISNOmseTeVaTasYSFiHNBGEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0401MB2394.eurprd04.prod.outlook.com (2603:10a6:3:25::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 14:24:37 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:24:36 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 5/6] arm64: dts: imx8ulp: add mailbox node
Date:   Wed, 31 Aug 2022 22:25:51 +0800
Message-Id: <20220831142552.43393-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831142552.43393-1-peng.fan@oss.nxp.com>
References: <20220831142552.43393-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 566bd8ce-739f-41f6-61f7-08da8b5c883f
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2394:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nPQSFEZhV7rl77Au/qP91X7WZDaoC69f7BEHgRNLbnV5P46C6NyF5AQxKLsFBRZJZkdknRJu/L0feWUuj5cp3w+HlqrB7Tii9B7arp/I3pbM2k0o7KhRagjuP9TpPeskw8Ksf1SSLIyfLSKSJmrbydvHUhZPDRX6fwowiZSM6KJtBEbymFC8TEuZ8xyG02JHgSfSgbW4L53E6Zkix2pzQRihoYzujZMY1FC+VtO2/0GZDeYyDFypBW98tgLglIrp3IZ1+LPPqerUizM4LuBYJZVCf8RN/N0W1uRPKyo9tmRokVsNxX/REJOzWbjCfcYRoVA/KlpsJFHynCxOMnmutHXAvRyYDIi4egAY6EcKF1Ee7IuhEA+wS6gb9CNGoPKd3W9Vp6v1ucny5S5Ztkb6amJwAfx3GrTacj+r83HOKhUpQBFnsz8wI9ltOrT5wkoHDKsVdNK84duzd1HUt7cf+W99FRr278ozaAMGNoK8kQUN+m4uOcJgapc5PXLGCe9VI8jVC76cIn3uCm2TM/KhS5XeP+MfOPN/iUdsCKHW42LGq6gf9P+6eu4FPf4cNo5OcT9SYmvkwJ4x8RwsxmnQA0UUozao2+9jYFqweFpogfdHhsY4HgjbYD46Cgq2kdXwI/POtMJCIf7jxm61YG9o3JxGCCzGhXKeyjE8LJz2H+uw0nSQxs032sGnqNZh+b9m7rAGXJPtxirTC0C7L8G/U3Ow966MqfT/2HQppyiJI628lncCvw/OccQCboDmbie713apRlwt453VLCFK8I8jBHR5k+2egsGQ/8sj9WubEzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(316002)(83380400001)(1076003)(186003)(6486002)(8936002)(41300700001)(2616005)(15650500001)(52116002)(6506007)(5660300002)(6512007)(2906002)(26005)(86362001)(8676002)(4326008)(66476007)(66946007)(66556008)(6666004)(478600001)(38100700002)(38350700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CqIbhTq66Sr7zc5+G04sUYT+P5e551lqeNCVLpUq1nbc2913G69WrWMDrwZE?=
 =?us-ascii?Q?7fA3hnOLxam2NHV0TBc8B/9HDFvQPMNbNY++/lW+ChlcoM4dFETdTiJBPWb6?=
 =?us-ascii?Q?OfM/bKEZwnO/4PyhCsgh0SKgLagZMdQs9g0Yh+i4MRveNZtob6u9aY2CzxSV?=
 =?us-ascii?Q?Xo2OB6Ps75s74cWdBJstuyMTHTFjWWLZxMcFbyOZTMt5MafqL5EnATdFiKFf?=
 =?us-ascii?Q?Bt7ear4zigDmKOnKRAl9qS2jgHtVp3SqQAQV/W6hihNyexZvYXsX53XQ5Lu1?=
 =?us-ascii?Q?x1p3GRoCWyn7Xlkr+RUjtFL/lI6+sSwOshAEq/8yRJwIld9mI/ra25j+YwB3?=
 =?us-ascii?Q?6xEIDy2tLcEmEkhXohno1TY5Jl5xtm2k33YOjiEvZGKJ5vVshuQEzQgFiWUf?=
 =?us-ascii?Q?JutsnmvSKU1GZ9q2jMoaL5M/EKGAoIyEjhFjeb4lX7HeVW+NSfzqOjMRHFjh?=
 =?us-ascii?Q?06U6ZfdbjCy/Vy7f1VxOTqRndxeGq8Ku0GiSAxhCMQr5x4ZL24O7L6alWTBi?=
 =?us-ascii?Q?Jl/cHQSJODATBf23j9gn4ItFiTlu9kJa8V7+1WPEBb0Moqz1jYjZP8CGFMn8?=
 =?us-ascii?Q?Reh19ns3Vk0oV5mvYU77lakdwq7IlapINTCuHn5MaNPGWPnGLBbvsUyEsfKR?=
 =?us-ascii?Q?lVE+OwkPJ3o92knb0bq0cVMsCaNUGzOnRRQLhIKN1274di7437Hp6Kmm9E+n?=
 =?us-ascii?Q?3/VXg6vIDrXmCDYGENDOS/OJQaqfVC0VnYDUCJz6ELeXMtoH1dNy1mERVU2/?=
 =?us-ascii?Q?pdW5/wZ81k/1uy5WY9idHLwCSJanllRX5IvNVKfrjwxxkne3aqVYy+wx5IxW?=
 =?us-ascii?Q?KP567IVA+qjIC4tyntBsS7efImZcsLxukzhAnzdzwxiA9lwneIl57sVwgDS0?=
 =?us-ascii?Q?kn/GDgEsIW2BisapQEO06Skh5bBOPGya5TtDVeKB+T/xj8+mfjrM9fjUwSmi?=
 =?us-ascii?Q?7RuclQHK+KNwdxy3e4SaSMaDv3J2RCoq4bd88QbkDVS5GYlgGqpkalUSXXB+?=
 =?us-ascii?Q?16IZcj+o6eFajV24w0XSaC3yUfCLFAUYlvLWIGsnjFYCQhHAPraK4C9nSP49?=
 =?us-ascii?Q?JP06dOCw/1qTvNhaWExxajN9jsJ+5KQa50k1yGzKzudE1BcrcqwMyDE2RYFE?=
 =?us-ascii?Q?3w0sp3EkXp/KaB4MrDkVgZ87FOQYfbmSUwqqmaAGlZ/DKs8O7oQLA34J52Cp?=
 =?us-ascii?Q?lqWUDlgO+zv4f4yaE/ywv7RnrWWICKvo79z3hMlcfcpwrD3Wy29lBlPzzL4O?=
 =?us-ascii?Q?m3iyPEa4aAfme5NV1NckTHH2L0jIN2f9M7VEoUCY7cVh8/yawl8E8YyW7SzY?=
 =?us-ascii?Q?BBbK60kXYRUXaoQv9K0JxuTXKi5MPfy3CsJVeVV1GkqZjdmF8ER3eWGQP78+?=
 =?us-ascii?Q?uwQazj6xDG9ZbFBtJ40/me0n0BYuNhbFHy/KHt+Y+klqtEc/2DeS++9ZZEoN?=
 =?us-ascii?Q?8O2vjihv0UCckMd1v7chS3gNomu03t6yN1C4VN+6TghYyaWHwXiVr1w/wVky?=
 =?us-ascii?Q?BQSJNbi52ZPYZ4Q5PuZt3ns2OJPpnMebPhLGpm7Pa4ik+NWCEx3+dghnlTJw?=
 =?us-ascii?Q?WbMKZbU/qVgRn1m3C+/4qXi6fJTnt9T7V7d7O7l3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 566bd8ce-739f-41f6-61f7-08da8b5c883f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 14:24:36.7172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBa0DR+BImJCZSdQsRie2P7RwpMToaMj6KQ8Qk8Gz6AnfSck9Q6tYDERUy5R5z+OPwKpcppBkAZpxwLXiclLuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2394
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add Sentinel Message Unit(MU), Generic MU nodes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index abec8ad4a8de..d95c0e9b15d6 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -152,6 +152,13 @@ soc: soc@0 {
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x40000000>;
 
+		s4muap: mailbox@27020000 {
+			compatible = "fsl,imx8ulp-mu-s4";
+			reg = <0x27020000 0x10000>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <2>;
+		};
+
 		per_bridge3: bus@29000000 {
 			compatible = "simple-bus";
 			reg = <0x29000000 0x800000>;
@@ -159,6 +166,23 @@ per_bridge3: bus@29000000 {
 			#size-cells = <1>;
 			ranges;
 
+			mu: mailbox@29220000 {
+				compatible = "fsl,imx8ulp-mu";
+				reg = <0x29220000 0x10000>;
+				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+				#mbox-cells = <2>;
+				status = "disabled";
+			};
+
+			mu3: mailbox@29230000 {
+				compatible = "fsl,imx8ulp-mu";
+				reg = <0x29230000 0x10000>;
+				interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc3 IMX8ULP_CLK_MU3_A>;
+				#mbox-cells = <2>;
+				status = "disabled";
+			};
+
 			wdog3: watchdog@292a0000 {
 				compatible = "fsl,imx8ulp-wdt", "fsl,imx7ulp-wdt";
 				reg = <0x292a0000 0x10000>;
-- 
2.37.1

