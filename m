Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E06F4C40CD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238832AbiBYI67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238831AbiBYI64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:58:56 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3623E234027;
        Fri, 25 Feb 2022 00:58:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmtpTEFSkFTT5FblXQsBV3vIoPri0+FRKpvNpFVDgHCAHb1cWWFOSqY3YIlnxltdZSlptvso9kRqxho/0dLPFtadwW9lLdKR9nj6d7wUq02rXWYWdAjIg3vL94LOrcUGS3XeJx356qMOavQshDjr13HcbBnEh4ijyyRjluw8eqp69gRk+LAkzNyUmEp5akA6oSLSniZKdHCif/moCi4mE2XyABDHhu/o9n7rLXnnCmZ/ZsopHrRQW5uhicbnLGcDsd3MSA8YAwXGDMdwwOh0Kn+nA+r0/TsAuk8UEOqHF7Lvm7Yd6BEty/TB0s7syzO7RGvypim3zRAsZWP+U7LJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDYBNbs+SqYXb3AnoUMsLypvmiYwK9GKojPMpK1kE3M=;
 b=ezBh2JyAXZ3oOTbqO+gGmdtctDLArFHX5G6bI8XLIuYANNFgYEOr67Yf++vM+vDZRuuMHkizT1LeOdjyyjkUGHnGmgtuteg09blMwLKnuS9sSZrrgv3iKX5JF3dSFG94Yy3xnVnxb4kRnoaVtpW9h8qwNZgc0kHE9d+WhmZnI2xxovnNJyHYMkie47f9Kvm5Pxu3UvIWJkfGTLCCgCWbrrcQ7Wsi77z4H9JEmiBC2hIIBWREYOC0XAfOuJPJXfuOKPVWNgzy43VbsRqz2+aMmgU6Fs2KKLV0DazCAyA+PSeC0ufQJFtVKqYz8ynhjbmxfJdtQKx9dQ+no12qn6Cmiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDYBNbs+SqYXb3AnoUMsLypvmiYwK9GKojPMpK1kE3M=;
 b=HpQYFAVd6GDRJN9JXkBJIHuPJSUaqDtXsjCG1LrDVOwDyYQdGeyPsp/B6VuRSy4UPhvSoxEJMQr0DHB1dfoflWxpDekmybgA+kNLSUbebfGMTqS6t3f7/yKfAReW+6dGiRnLTqJY27ubD0L4aKh3K7xAmf9LAu8d62tDXLwvgBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB6PR0401MB2662.eurprd04.prod.outlook.com (2603:10a6:4:38::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 08:58:20 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Fri, 25 Feb 2022
 08:58:20 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] arm64: dts: imx8mq: add hdmi phy 27m clock
Date:   Fri, 25 Feb 2022 17:00:01 +0800
Message-Id: <20220225090002.2497057-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225090002.2497057-1-peng.fan@oss.nxp.com>
References: <20220225090002.2497057-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65c80fe4-a893-40f8-18f7-08d9f83cf85c
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2662:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2662BCFE6F0B53E8C3DCE35FC93E9@DB6PR0401MB2662.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2kefG1oIjSlhfvwYy+iDw90tSTVKOOpGowNFiaP/v7dL+zsa8gLw0Nh26S8jH3FJJ6tRosCYdzDswyWrXnVpyrW0zW9Z6L/GQGQvgFo//xXmTaDoesbWkLekW6IT/HpD/8j8Y/J5T7lS34mtkPYViLwbxqGV2Q+gkT9tGhefkymY60aehEuHGHmfGMNzID2gNLLgH4unekygFJYPl5jlQ0gfO6+sqYJps8ZZ9XMCYA1yJyMjM6fUVWBDr+K28sjJC0ZJcRy1bVFhD+JDGbR+rfapssGNG9pUcyNq49TjCOQTIBj61NXUMyjfLZ6OIxQbmLqsCzm2Y9P0ANAtwRox9mcyP1Ya4Q/vs3McNHMQuGKqIa76AH4mQ3q74LbO+vQbPfxMosayZ2a7TUnY218saR7Go3ZGumaT2fsCT28ac0xaoWWvF0UVpSiLB7ya9nC0UIpH3Ofz/XBjzQOUCrMsr6H3eljBNY+hgyE85p83ZRPVPNW1taeT6Uqr1VkNlNKIE5EBNYIGmONO+y+z6CqXCqZDpcp2hG/VjPIepsqWFFOoXoJnN+w5bnblBye/B+f3NpxIqUZV9SX03A/xf0sy60aukBJHqIltZU8YSfmSB+4xaZBU5tj6pM6pJ1yBv5Deye8tL4tGHwSPgnZklmU5x8DyqgOd88Yih4+4EA+cDO7FkpVNWQnRmuWxP54kC6DBVU3XcYP7UDr5+fnacRNM8kgb+oTk7sf8wWw3WSnAKT8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(2616005)(38100700002)(83380400001)(1076003)(186003)(86362001)(26005)(316002)(2906002)(66946007)(4326008)(7416002)(5660300002)(8936002)(66556008)(8676002)(4744005)(66476007)(6666004)(6506007)(52116002)(6512007)(508600001)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TUys7wQLgSf8CDzHqVYBXcPD0mcKvePpVM/wEJ7u5WMxhfqb48+x9736MUYK?=
 =?us-ascii?Q?CpDtFnPFe536dYg6jatNYpGLCfoJxzOQFtTUIcRTLP65wcRe1UOuUnYJYs7u?=
 =?us-ascii?Q?cqc1cOI3aAZBfW0sH9ZBqLMUAskOYWxqZl3utNoDxYuzbQVXTCkJmyX5BIAl?=
 =?us-ascii?Q?DINRDNB7WeuPoPG+be9j3RTZjeqYSu1yLc7XAhDT+6X1tVDP5NyxVtj+GFRg?=
 =?us-ascii?Q?Am9iKLbbspHhIUJ1GgUkYYag2kzYcCqyCybWKYIbAGu3VUNMdzOuYDU8DqBy?=
 =?us-ascii?Q?fzfVdvGDDDw2HlGZukPY9kA7eStdmPUWKiVwp5Sk2mysr7w8Z+lOZtcxwF3L?=
 =?us-ascii?Q?Bpm++35ZnDzB8mbbsgfb6DK+htLrNQK+1Y90ITOYivSIS1+Ch/MXUVcxJsCi?=
 =?us-ascii?Q?W5HRqYfqWtY3m+cdc6gEEZnlnhPlhHeN7TTwE7lICj5C8wNNT44wRqqzbcKm?=
 =?us-ascii?Q?Lca9dMufxh4tnIa6Nl1ZHl5hbouB4kcsHznrPxDpZt+Py3gbAkUhHhgfcgfq?=
 =?us-ascii?Q?ew+AVOflFozWazHIi/3sN/mI7DrJY75Wka+KahN/qPd9/QT+VR3ff5Q8ldxp?=
 =?us-ascii?Q?dGFU+p0rYIQDuRtqXThDflsk2QvmVhnkXuWboFBwx1GqhX9TK1A4v5PLZ5Bg?=
 =?us-ascii?Q?0s7F2OpyDyTKIAo5stEbdbkTy8/i4uogR9UXULJyoG7bx4BT5MT91V+lU0MW?=
 =?us-ascii?Q?ou8nsmn8fg+78lmUkIBRgLEmiJPVZyHGMxdXNCK6sTfm770fFz0JEIf1swYI?=
 =?us-ascii?Q?gt/b1jattIy2u2cx8eLZEGMmQjkU3wTze6wrpeFBAi/CCPkUJjYJjgqvuckf?=
 =?us-ascii?Q?13+umrEen9633f44p4oRb2J5MwUI2dy8BQKEu7I+qXsLtA6mYeV8+WgOUPbv?=
 =?us-ascii?Q?AYH4XqzqQWjMpvRRPbnduaD2OZ/s2vR5/xCOWtuyxFsF8RG1HGEDAh6MjYOG?=
 =?us-ascii?Q?b/ItSFBHDLg+6NMe3d41PJCdn0DbmhBXGTFu3C891scuxKiMulswI/pDq3b2?=
 =?us-ascii?Q?4bxKbuNZRO4hr6gjoJAEHI+P1FigmXPP63sr7zz3xSBBqEndmSUuzWfh7Snf?=
 =?us-ascii?Q?exJs8NOQ/H+xhUqLW18tuNw8VWrJUrME6+AgxBOSB9baAoOMoCP229gq9Xjy?=
 =?us-ascii?Q?lkqH5oyY5Uuft3E7Ydyne6WgTd0WPLLZgq4JEI9GdDK1ZM8KgeR6xDOOrUKJ?=
 =?us-ascii?Q?2ecWbcx0ta0lSv/kyzc8zgXbPGWdponTfmkAWs7UuwPL3FQVUFzzOZhR7evo?=
 =?us-ascii?Q?4Uw+pn58Vk3F8d2QwvwDcvGiFSf9K7Sec1umO9pFlwf4RMrzCAbr/IyLTtg5?=
 =?us-ascii?Q?ZZyfMlyg2d5FwiKAnTC1Lu697PF0ur+1tuoIyWPILttQICYSdTdiaXsBFP1D?=
 =?us-ascii?Q?SEs6GXfp+Js+K6QK341Y+zOQMF7aCxN/I+v1iQx6vTOUfKdkOIa5IiSCQvi9?=
 =?us-ascii?Q?ZxTAuhGuQgnC+9RJ5zrhYN2FNs1aEoGoSHKynadHC1rFk37PvW0f0oFfwz61?=
 =?us-ascii?Q?i+1+rL5wktRehvHX3Hf9i56Sb2x8Q++h+HJKT5MZQByCIkCyCtiMXeTua2OM?=
 =?us-ascii?Q?hIIXtCCAkDEqmJ1MK8dn71w41vgzDw07RlEIPqVal1+lWoCnNBcBMIJAOSbO?=
 =?us-ascii?Q?cs8z7m0GQI3bBmKr2bHCyY8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c80fe4-a893-40f8-18f7-08d9f83cf85c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 08:58:20.1115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bebAuHl2T5Tlxmk+2r3M02hcbMagK9MpXTM3ZsK8vjRiyheKCgYmlWsPnCph8RoIDJCdA5ylZV24XW8Q/XofzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2662
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The i.MX8MQ PLL support hdmi phy 27m as pll reference clock,
so add a fixed clock for it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 5b3e849f554d..1eca2b431467 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -63,6 +63,13 @@ osc_27m: clock-osc-27m {
 		clock-output-names = "osc_27m";
 	};
 
+	hdmi_phy_27m: clock-hdmi-phy-27m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <27000000>;
+		clock-output-names = "hdmi_phy_27m";
+	};
+
 	clk_ext1: clock-ext1 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-- 
2.25.1

