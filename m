Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A158C53DF8B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 03:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352098AbiFFBtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 21:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352107AbiFFBtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 21:49:31 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2042.outbound.protection.outlook.com [40.107.22.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083554F9E4;
        Sun,  5 Jun 2022 18:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ic4HynxaaKAw0U4SzwDVHCAKdvmQxPWAMk3GOUJnBA7JgCP2jI10fyy4aSt2R4hYKv+58OS0w6DqELhU/+01mZee5wp8tzATt+2ccDNJ7HgUjiUSb/CFH3QpHsUCLT3jvJTruLslSTZJC4rSUA8PYlgTES7oOhM/6/CYichZoYoQKTNTqn/s+hbijq9w1r9X9vgqMQ0XR5MAVIoGYWxMwLFNuKJGwZq0I1wk4MFSBhq2nG6r71ajVRsx8iVusO92o9Bf8QbcML5LS/u5JcNY+C4tu6P8o54ERpOZAcjl3SUQSd3qjJ05aYwYvpw1WExvcCig97kJWoLAS8UPvjE15Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdhSPfQYla9T1GDxpNkFztwMrm3sDs1C6hEx9QIlXxI=;
 b=bRt7l9B0ZMjeKjBFgL9UwnKXLaesMTHMdztYkNPFP/i2QAgX8ibUUzvF/7IWrUcahBRyAbY0sejbnNYTs6WnqrsMOKYMTHB+VwIta7vHuP+T/ZrfyJ7m9bAfDHM7OEwiCLWo4nAW1C0c1iCvdbWRtHY8NdVcT2y46B+Ad6fbo+tS4R7hUmxV9zvE9gJ0pf5jwc4ZdK4/KTzi4auaHX9/4qYDSZP2hCt2JlJcKuJwsBAiOyU+UHVuom03QEMbUff86jXjp75kOKhywBaFtXujLDvS93+mZLQMQonF6gIXYs6OGHfmzLKZph9sPLKU+PABL9feASOSxV/Ho+w3+4qQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdhSPfQYla9T1GDxpNkFztwMrm3sDs1C6hEx9QIlXxI=;
 b=XIPOlODwyy0BSNPOuAbVdHMhiJhKQKVQIZlOyhj5CFopkRNPqH3wnfgo1uoH9tBdut7VvQyvOp/oCErSSwVIDpE429ugoFnc6K+0nG2A9m3z72k1TIdnYrBpjSutX3VebOQv50eXJNcEW1TtvXXoGe4WsRsFk1xeK8RM2a4MPUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM6PR04MB4840.eurprd04.prod.outlook.com (2603:10a6:20b:11::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Mon, 6 Jun
 2022 01:49:19 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::f9cf:2b4f:f903:fd63]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::f9cf:2b4f:f903:fd63%4]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 01:49:19 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 6/7] arm64: dts: imx93: add src node
Date:   Mon,  6 Jun 2022 09:50:24 +0800
Message-Id: <20220606015025.180840-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220606015025.180840-1-peng.fan@oss.nxp.com>
References: <20220606015025.180840-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::6)
 To PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 516ef1b8-2614-421d-b75d-08da475ec4f7
X-MS-TrafficTypeDiagnostic: AM6PR04MB4840:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB4840D421396C92EE590C2723C9A29@AM6PR04MB4840.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZmGNcYdxHWdI6FSEkwsMerWyVF0f2SnNw+WEILcNn19hwIctjvOIiUXJoQMWBIyWwWArbnxXe6mx9p6NFTL5ySUaCxULD1Rub3w9A34QZlEUdos035pxk+r/dw134IZerHcfkyyKWASbwtftjTcSXD28fUIrWAv+vKmbT+RRAymJC4qjVOCA8mB75N890us3RQMN+6u2x8SC1drD8Q/QX8c0RR6ku7hg6cARc7QOkggy/jVpmLv+JITspZKSUayNhknYhrEA2e9sTyIYGHGm57MxRDG6toFpyhG6EsxRDMzzLkO5heQ5ko58RiG0RjlqKoCYWekjyXwDc+xgvPMDySNnqpVotwcKYxcMMITWgP2t8MoEknzv5A2uqLB333tX0MPiUlstfyMLgzASzCYJdw+MhYmDPLnbZCybyNIU6OcnaJUdbJEk0C3+pV+uJtKSFiaHhr3/uvtS5j1kB219PqYlLxHAzSjV0Ql3j1pBYczsE3xYfkCojqUcjhjK3tZBEA8kH/VhrgcZkCtkPQvPrHKicnIkLUJG4nhfizsDkWxEReZpyZ8fLUxdIZcCe4NuyPOArq64z+MnYWVVbpnYcHhVk+sFMrafDYH7C7kmR0bRNDX/VtsuokHV7RLx+ChkVkPAtQYn/IApNAtR26+Uq+8lNsNkE5447JX/HmPJc6zZbo82j8jKqxqqUqCHyZVQg5cJ2y1K4Xat3GL9qrx/8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(8936002)(66946007)(7416002)(66476007)(66556008)(5660300002)(2906002)(8676002)(186003)(316002)(26005)(83380400001)(1076003)(6512007)(508600001)(38100700002)(38350700002)(6506007)(6486002)(52116002)(86362001)(4326008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?luXVdeeQKkvunI8PsU9xQiWOSIuqjbesddN8UOO0+pV9hggkECoQVnI3NEwX?=
 =?us-ascii?Q?71i+X2yc14gJ6q6mcySwxut+EaQAB+1So1W50JWDisNK+C6zj2ePJT8KdxmJ?=
 =?us-ascii?Q?BtYso324K3A9weS0D/Rhj1qa7yw0oK6nGq5iwXJPOr/jdamPRHXWimfaxtYq?=
 =?us-ascii?Q?ph8K+MclQl835CUOx2cQijB1znHvz5p+qOp3G8gg4PyqiIxrTOxwaZyHMjlf?=
 =?us-ascii?Q?/MJcBowY7kDK3ZJRf9o0LdW+vXFtux5PciGpTUTmtrKD6vapuewXoMNKeIOq?=
 =?us-ascii?Q?nPK3sgXi6upOooTfP6l+6xNB+Y+pJi4l1b8PqpHuq6Y6oRVg+hN0B2Nrwacc?=
 =?us-ascii?Q?NseGkMHdqGYNYFW6FgO2tgvEzdKE4EzFc7ezBHeWndxky9Uu/65tjXxqyJs3?=
 =?us-ascii?Q?99S9Z3fqElJ9atFemTVyVatQEdC50biVhIjmYXZQjzCTdh8EzAUaTstk9jmk?=
 =?us-ascii?Q?rQfrhpxZnMVtFZKnmSxmNvj3vh8w5/OFzlErNgqDGeozVAwPdAn3HZgTM933?=
 =?us-ascii?Q?v8GqgqXROV+GFbCuUOlS5Qixxo01Q9JjFR79661AAHEGMSqtzOpm5lXX/+Oc?=
 =?us-ascii?Q?IGjEYmX2Y7cR+NKkdT4xAGzLIJjNefgIFcRTaAJWJp6DPyeX4T5Pq50K6OQ3?=
 =?us-ascii?Q?SE4WOwI3CoBDk0goNctVR/TkTUFAWbOuAGNMPm9lydzvEWKVYoRXHQyzc+BA?=
 =?us-ascii?Q?iGra2neNjJU8g4n+H6qwcvyG76QSRk6QeDxW1mdF9YDrA1OWh/PGlJcmuLuG?=
 =?us-ascii?Q?CkDlxJMILVJJdDi6XpF2LFWuqAZQQVivwRtYApbc6z4p5+/+w+ypJIbyTR2L?=
 =?us-ascii?Q?fh2BafIyGuTRgNTRoPyFSkH0CBprufpztnJZ3ppch8WqrhG1/yk2xdyFNwRc?=
 =?us-ascii?Q?OdKWGm2y2Fgs0AwXbdr/Dke/n0eYCYCZXPnvn4ENsOFjWDxu954yrNmieLU1?=
 =?us-ascii?Q?Z3MIBzGbS57reiI81j9KgMUfMDObMTzOitqw+LAt1B16fyTM825y3HRF68HI?=
 =?us-ascii?Q?EuWPrfjZIzLLSt1d4H+nXG90gYgVpbOzR4Ppr86x13lRWQmfzKmJPnvHZ2h2?=
 =?us-ascii?Q?QX/EBUrXRBk4u24GAjEqa+ApLK+z8uoFHJvfJSk0Ldrn7MHjWMterpft+VbO?=
 =?us-ascii?Q?8kPrqd4Bv2f5PDM3ChyrCR58XxvZuHZ+7jPVf6jQivty/kXdSbpyi+AZyitD?=
 =?us-ascii?Q?QmWU6pbCl7yIvPOr4f56T6qvVTB9E6dufLvA5B4XSzFuSMNqnjcUhsHN0zMc?=
 =?us-ascii?Q?yNAI+2dscnWGHCjIlEoQN9Vk70RPGplzknW2S+3ueXgsne8GJUn4yOnFrJHJ?=
 =?us-ascii?Q?Y4hGs4M0awz1b+CAa3Qu23F1bQnY+Po5Tk6lhexewrcPXXudR7BWjSulNwne?=
 =?us-ascii?Q?6P16/USiuRXPOHWjT3l69Oo/7tMm+qIi/jxASUVw2Wys4Pu11HmurYviIHRd?=
 =?us-ascii?Q?WELjALLm26BaxzNj6BCCaxiNQLHntQSIPNmGcaCGeHXICEaAjakYKH5N8I/5?=
 =?us-ascii?Q?5giCvI3LK0hbTyFF7AT5Xc127W02OV932WhiVz7shjWlFlExPx93BJGtIxql?=
 =?us-ascii?Q?MJLWEX097Ril8mRr7YytRENe2iSPHCqillIqyiO+6YD9ew7AT55VMrbkSZDr?=
 =?us-ascii?Q?Lcg2Y7rh5MdX0pF3N9RCpDSm51nSHIVlgXT5cTobBfOXT7UE8Uv/elrTC2Il?=
 =?us-ascii?Q?WyIb982O7xASkL7m2MnMprY/L9MktjriUqwKjNEHorreN73dwZQIScM55YsO?=
 =?us-ascii?Q?4HMRnrJORw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516ef1b8-2614-421d-b75d-08da475ec4f7
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 01:49:19.2005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7gRh7jOqEHKQ4xKrWfxdxqjtm36FrzB4JSDumJyOJNzDeUTZngUNlL1105F5/rwdry06eyMUaByNE8Q3pZ9Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4840
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
index f83a07c7c9b1..8f0658e95e0d 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/fsl,imx93-power.h>
 
 #include "imx93-pinfunc.h"
 
@@ -161,6 +162,23 @@ clk: clock-controller@44450000 {
 				status = "okay";
 			};
 
+			src: system-controller@44460000 {
+				compatible = "fsl,imx93-src", "syscon";
+				reg = <0x44460000 0x10000>;
+
+				slices {
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

