Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996AB530F59
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbiEWL3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbiEWL3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:29:21 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80077.outbound.protection.outlook.com [40.107.8.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925914EF45;
        Mon, 23 May 2022 04:29:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ARkKb5hO7cUBQpKPW21KT5l2X9PWQDbtgx7HBmuyUA1hddeeTlrKJRovHPkIGojtMXW8ywn++zEuTiaflzYDm6mioPOjdJAkzodKrY/jOIAQLOsK19zhDPwrdKrnc/xav5IBvilBv9x1Rsjafz8i16/vNuuYgcPyJ3DD1QkJAYagh+bmuMBN1NIkOv6hclPMuhLaEnuf2Cs4GOfM3L3tl142GCmj022MD1TuFOvDhGAm8SBNE4xWZVJQlLPEieh5Nb9W2vzGB20qOccarLYzKTP4MyKlFFVp3cNHJcT9pHzhAzpzHHPy5P2v25ZWc71Oe2ZW+XDXNDhDdf8lHO31ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBXTzykZ4wz6Q2RAzkqFYkAV0rofNDozqQWNFuJCWvs=;
 b=JMiz6VvwBYWFzGcWqSKO1GJclHvVfISQhyJ4o7fXmxyV3W74bltgG35rbxhjWHqUk1/5/pHvWZfEYf6yG4lSSiFndSqDub9d6AoI6EIeQm4GLNqqi7oWfJQlmW20OGnz+Sw7WTVoEtbleugoCflpddQbYHSZjjQGGNU2ytKclkAoO+emZcDkme6Me6OelA+UoN8RiMfc+KPPl1f/frCmCmlwJ4yZmAEp9lVGSP010WyPzlG2DGvy+28Ab/oBT+JTRd3VqY8y66ou/mNDxHICRGrClEgo7k0EXustMp7XcF/PLAGkRoeisIrH1kr0dJveuPhBXeEd+31fGMPOPkVwTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBXTzykZ4wz6Q2RAzkqFYkAV0rofNDozqQWNFuJCWvs=;
 b=N6YrUfh9Wxi8CnID0Y52KW86FQ7ciQNX04w/RwKfwMOhD9da+koPh6qc8o9WZ+OuP4O1lFd1j3A7CvptzHuCp306NUOLoOOBut0kRGWvOFyOB+0FLRpKZV70RF8M1LwhpdmxEb097soBurDTZlEu+4u7CgUoBsX76JbPkjCaSMk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6586.eurprd04.prod.outlook.com (2603:10a6:10:101::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22; Mon, 23 May
 2022 11:29:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%7]) with mapi id 15.20.5273.020; Mon, 23 May 2022
 11:29:10 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 6/7] arm64: dts: imx93: add src node
Date:   Mon, 23 May 2022 19:30:28 +0800
Message-Id: <20220523113029.842753-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523113029.842753-1-peng.fan@oss.nxp.com>
References: <20220523113029.842753-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:4:186::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 003aeb6a-7648-46d9-2c2c-08da3caf74de
X-MS-TrafficTypeDiagnostic: DB8PR04MB6586:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB65864CF3E93B2F0FE2E35EFEC9D49@DB8PR04MB6586.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P8E4OQuOZtESKIibZdV+zBv8SjSsdXiaFVhOfAxGhK7J7nrSH4PcCKtoEaacN5/ZYoUggE9KXqh/exGzTcqJLBq9XvyNruqzA++Xj8OHVAhHAbwuNyBW5UsIdV62eIvt9zaONiwi2tKq4QUreGcg0cDkh1MRLwk4qZXyw+2adM9kx94933625/19tiIxH9nbtZTNwh3LM/nGe9XokLYqZtLqgRM5V0/0PyjZ3Suxvo9oA6h1A7lA+rU9P4KyfHveNPaI2CToN9PWHrzFqVbfA/59sGiM7rNmeITYrvcJ3cEipY4sFgkt2Sx5ihm1Xc2RRi8lU4+rG/INVnxaQ/Qchu9DGX5VKv5zmczdcqptLyDP8MOkD09CzoGbZ4u5I/F7pN+fs9ikKjSGS9ZKV3rJ/vWqtsoiTyJ+f2GpInpcolH7NBvzmbMwjsay7CAwU97/CtcHhwRnwNojA3s6O7j2v/sTyVNzeQA9+P5jo01O4MhEcEMw6yIVsjoZ5rO3OvF5YoAQr2O1XAe7p9Jlbh7g8Drw0LyoY1SHXLIEJ9IsjDqK/LlIJTl6FVvithQiwhpABErfA3uwBUvQznU8im8aZJK5tCAd+oZdl8c72X8iH/HUbET1OP/kDIQOSllMgkVRui36Wb+g2+mcTMNBD7+GLIvzXFGgiXqyDpNf4bpW/xa6cjaAvkeKVzkyacwi2sKfaTvdFua0OcS5Qsu8uxBkvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(2906002)(52116002)(6666004)(2616005)(186003)(26005)(66556008)(66476007)(8676002)(4326008)(66946007)(5660300002)(1076003)(508600001)(6486002)(6506007)(6512007)(86362001)(83380400001)(38350700002)(38100700002)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YfZZSKjR5cmMLys75gzDFmgs5zpaKsfm9dsz91Etno1iEMcboDUGHifCM0iK?=
 =?us-ascii?Q?1S1xuhZ4u5qDp41eS07zv+znegDQs4NYGy69a9/s1bw4edkdH9RGIbKfbdkO?=
 =?us-ascii?Q?Kdov9gcD+Vn/7ugiKQCCgpKPGnZ1kk5r67K8iZ5zqoCJNQSzvlUsMAWpMn9M?=
 =?us-ascii?Q?Cj85EQYtYh6no94xTclDGxui072rOfIp/uTIz3+/uxDy+I9jYYfk/MajNEY3?=
 =?us-ascii?Q?1wfLhmbH4rMhEI8olp+PfRL2p3TB+s1qU6gktBKZagZ8oYavBXY/5rmec1g6?=
 =?us-ascii?Q?LN/n/Z+krZ+1dzid1052I/MbMFOKuSOPbteR3raXxQLbzHoZwtn2qgln6QYk?=
 =?us-ascii?Q?cD57unRyyG4pArcRI+wIxJKxzhEfBNr0GuZhXPsSN4aw9SWygYrYsDTyWy7N?=
 =?us-ascii?Q?Vz1H1+NetaMdc01ql3aZE84vJuFQ7JInonHrQU9L6vpcHf2Rox7jVHJU+v3W?=
 =?us-ascii?Q?os/8W26rhD81YJCyzixyTw/VVBPohUMR2umehl3gAh1hu052FnYDW3IaGPrd?=
 =?us-ascii?Q?UDdjLne95ZuFFVs4nVe6tkLjvgcaDwNp57F5TXBt4pOI5jp+7RwJyVwSTpbW?=
 =?us-ascii?Q?bQsA0pvrjrZlY7Eu8Jbqws50a7K70/GZGMC8OorhJMp4fxoDIrZJ8R0dGQhS?=
 =?us-ascii?Q?yQp060EBPuR4KWYAvBEmULZNjlcF2rAKRFTM3YkEBgTqO7u1oIVo07uc4LMf?=
 =?us-ascii?Q?76oAGaAXYbZJsfLtAa62nboyc+frxUaoKxBSUCrMSDtR0tREuYANF5aHlUBX?=
 =?us-ascii?Q?KDgR0zhIPzLfd18c8xWt0N+8q3PY6FatsNvp5NxcOYRARXnlcdDGacTq4Cga?=
 =?us-ascii?Q?S8va7udAJTAzjhoP2Zcy04aHXp/bFpu110PXu9HIQVIxpY5wrTtSIVO6gzQC?=
 =?us-ascii?Q?ESUciPPJGWzfIL0ND3O+eBTF/csikvjVDqorLVJ3A7x0rACKKc3zmgzPj4Th?=
 =?us-ascii?Q?gtCfnpp9Cjsxac8vrzQm1PhBv2NJSyTem+27qTYERMIk02bpoO4V0NFT8m63?=
 =?us-ascii?Q?Bo5DB31+mIYVVjfybMKRbcPqrhbxwWkTNIHki8g44J7pu4Ts2itkPBHy6h/X?=
 =?us-ascii?Q?Oux10nVpIN9rGzfJXBwbsIWoG2XK4A/W5X2snO9vPwWwVu3JpVgrlwr3icpi?=
 =?us-ascii?Q?wEONP1AGGQRDgb0HMr97wQjBfPw1DYPtK6fkue0miiepIX/+CI8snkvEaF5W?=
 =?us-ascii?Q?yRsV8LX1bZp8qhM/RaSJrw/cdZBJxSPlWZJX3z11gaoKS+DKRIVMMHOSWvIY?=
 =?us-ascii?Q?S2B/edcE/4h0+jGOL2/u+cPFRRe/EyNd+LtV+D3dMjYc3NogpFcP3GFFecFe?=
 =?us-ascii?Q?Rv/hyKeYqQKZ+NNp5cumt1WrGciB+MOwZEZyq6XrQHRNgtUQwn90w13Jji52?=
 =?us-ascii?Q?n1EkHb8vkNNgoZ0GWG3wcV0lqzhSGSi87UfbYGBmHTWcG2ayw0fTQQKfW6EX?=
 =?us-ascii?Q?zwfJvVpzKhYK4N1B0jgtLFHlq6UIJpbLM5As8/+ES5NHCmbeWd/oNZQ3fWyr?=
 =?us-ascii?Q?QSBUc4TMkTRbZ8tSuL7HTGis/Xau44eI9hYYTtd1xt1p3INoSV1NQQvS+DlS?=
 =?us-ascii?Q?YktMDeoOMmUg+2fFxiQxFHC/VNWNibgI5b7ZQ4uk7XAsl3GKm4u2VVyEsp73?=
 =?us-ascii?Q?2M2gvTgRhb9yYbmHfLZsgf4t0I2KjsKPLQs/yyj7h2K9ZkrTwxGDeH8OvrW2?=
 =?us-ascii?Q?3yJTQGKpV9li7XJ2fMe6LTnYBxIw8YnjVaDt3d3PWfCApAo6oE99WdE7uUO/?=
 =?us-ascii?Q?ZvYP/bf+yQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003aeb6a-7648-46d9-2c2c-08da3caf74de
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2022 11:29:10.6975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l43CgeHod3cnOHc0s1uBJ31fD2it4C9hugAeYsvQzLO6QZsqOlyvxz0X9iLZHechvI/09ufcqpHWLfcOjmaNtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6586
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93 SRC node

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index f83a07c7c9b1..85686b684966 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/imx93-power.h>
 
 #include "imx93-pinfunc.h"
 
@@ -161,6 +162,23 @@ clk: clock-controller@44450000 {
 				status = "okay";
 			};
 
+			src: src@44460000 {
+				compatible = "fsl,imx93-src", "syscon";
+				reg = <0x44460000 0x10000>;
+
+				slice {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					mediamix: power-domain@0 {
+						reg = <IMX93_POWER_DOMAIN_MEDIAMIX>;
+						#power-domain-cells = <0>;
+						clocks = <&clk IMX93_CLK_MEDIA_AXI>,
+							 <&clk IMX93_CLK_MEDIA_APB>;
+					};
+				};
+			};
+
 			anatop: anatop@44480000 {
 				compatible = "fsl,imx93-anatop", "syscon";
 				reg = <0x44480000 0x10000>;
-- 
2.25.1

