Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4570565AFB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbiGDQQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbiGDQQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:16:27 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60077.outbound.protection.outlook.com [40.107.6.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0B510C2;
        Mon,  4 Jul 2022 09:16:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUpmiCfS5V5YcG4pM3WVx/HRXYZg490Kjp8TJDqJFTMP165LwzgmiZmz83aAWwcCk2PFxsUzSIfwHixX9QkKXSoTo0n8rHbBP8rOFAmsjNPEkVQfCiu9znMW/epN34+yrUGCLwHkH73yljm/i7WCPdt0fqJ+iUqZg37wtedbKHaiFtyai8iYWctKVATyOoOFYGI5weKJaPyOpu5hsGB1GLfYy+YwLiLknJcDWWb/M4hcwToj61SuDVoIPFbjtOCGJMQM4t4QNmlLKYWI6s+L+m+tLUMKvR8gcFiv849cH5d9VqXO1Rd6LVw8j49+R0jFAXjDJOYhkE/7B2KwqbV6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hP+skpiKxZajmZuw9jaj5gBNGQTFWQg7HrLu5cbhzY8=;
 b=GkRdLpq+ZvEpTJcNouCQ2gclx5jcs4grjuj+83cNsCp5MX5nM4kNroaC1xiRqWfShCiOLyPeH0hdAFXvwoaKP5mk9ZNlfXFRAc5SVi0mkNqMDzyj3WwEUVLCogb8L/HiUeDQf0szmkqurOUMbBRzYPTElQmtpifmvbSnBQE73giIZflquFAZWZsEPWsPeyrb6qu+1yOkEUMHv6X7HuS6q9mFYtXCxhbbzjBCVONNRdas/1tvMRyYTGMAIAVQpkk2MKn9EYx+lWB+xIrQbwaXMkKeGSkr03YWRF1nd8BJNkYQbwHpycK9kLhflsu9ACDu6qKE7gCGDsxRBK4eZP3Kkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hP+skpiKxZajmZuw9jaj5gBNGQTFWQg7HrLu5cbhzY8=;
 b=gy7dQFp7w94QSHAOqzLM8VvA2JPm8ST5Hl56X2q56oSasGJ/4G7dWar3zTMLNLhzjq2b21JDZqQ0OoQmsedYsNK6hCyZjNSPx5wVzYEyNtVunRV09QGuuazHYEpNdXwEj4pC9S+0zTRXTRAzbG8OZNeiL89Dletimiw6/1Rdok8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AS8PR04MB8213.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 16:16:23 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 16:16:23 +0000
From:   "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Viorel Suman <viorel.suman@oss.nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v7 01/15] dt-bindings: clk: imx: Add fsl,scu-clk yaml file
Date:   Mon,  4 Jul 2022 19:15:27 +0300
Message-Id: <20220704161541.943696-2-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704161541.943696-1-viorel.suman@oss.nxp.com>
References: <20220704161541.943696-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0008.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::21) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 285a98af-0557-4161-076c-08da5dd889a2
X-MS-TrafficTypeDiagnostic: AS8PR04MB8213:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZyWKvXJc0Lsl7SfeTYClQHnFKv4VBZz363PcykV1WB5qLzp5t09lu00f7kmOeWalcm4eN7Cs6cF28JwnmNPRTehkVq15JcmTstVcr+4OojdvBAzoHn4czwKJfOs0wYqgMxyR7YR2LLFRZGcJJGkH35OsG1Mes4mM0HIiagZ1I0dNOwLhkFYOzYEIuBjyPjhmjyFchIVIaUiI2NC1ditO0zAhVsN97ErpYygWNb6XIBLAJZZy990ihsrX2wwcjJDm4W5GaOEtn+2crsGuBu9r5wyUxhi/hn0BFzi6PUlZqQSV5hXBppCgI2Ye5gzB5cg/VZFfbRBEuscarNo9+NAcqOcKRkImY+cMEP/Xxb7TIXjwevNWXrJmzDSsDFYGWb2e0hWOJNTUvjdw8/Y0ap8Pc6cvzYbQSIgvYMCcqzSDvRqbAj0+JfU5peVpsj64FQjYq1PRqWvKzpwEmm5f/7yA25zLJhEeBFVgAKmLArhTrEE3y0StbKn172RO++0Hc2mjOKpulBTCelhw2r094A95BoF0hRZ3U4aaRfogsstu5ohD5ScQhZHokTf1x/LS7lGMilG9+m9nc989aWfEzH0CY6Y2VmwSUrmvRB1OfKOB86WqTmUtcECn/KOELRbvQ/uP2Jb6MDQYhPqXqamyrp+eZOxjibZU8mhtm/yDP73iEDQzxT1TyFQuZT8ThRoMdx2T7HPCUhE0JFpMFubWfvzOtJmzZcHHRYV5tBIBnMa/UbHKEO1zOSTFvBrPHTMhf33ejzOo5tvAGttWmu5L/zV/aZuDnESt06fcySgQ6Wv6WC+Kl0TbLCsXe1mvRgRliGlV86yw9ItZPAQHF1e7na3qORHHuFbYUb2kngbTOIl91CNDSfoKs2voqacJ5bmFQ6RGtvGp6ybqfvDt8vN3c/bTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(186003)(26005)(52116002)(2906002)(6506007)(6512007)(1076003)(2616005)(41300700001)(86362001)(38350700002)(83380400001)(38100700002)(921005)(5660300002)(4326008)(316002)(8676002)(110136005)(66556008)(7416002)(7406005)(66946007)(54906003)(8936002)(66476007)(6486002)(478600001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Qi0T+fi4cq2PRw9fLg+sHriFjdQywJbQnbwDjGdaUscCoSLlca37qwwiVh?=
 =?iso-8859-1?Q?qUSizwmIaTCSyuX4Z6IN/o7XjZu1XHbqM82GyvujA/H6VOjpXa7j8/Txgi?=
 =?iso-8859-1?Q?sl4q2TllsdwCGoOVp+qYCzu6MJ9fP9PCh8ToyeAwAZ+ukiT0QIU7d6XI+4?=
 =?iso-8859-1?Q?uih0MNEZcDLMOlqYMRaegPF2OTskDGFlpF2hIFw7BEkpN8SVZ4I7qw0TZq?=
 =?iso-8859-1?Q?igDot5JvTLG7kF/aMwgT+JvzHLaz+Q8lu8j55VPEoiZ0GF6obmYjNkG4A4?=
 =?iso-8859-1?Q?ADJzUNiGKSW1rp4M4g43zD/TXBJ4p7jnCYwoOOa//Yf3mvcCBdLeZZGrvr?=
 =?iso-8859-1?Q?xvYCopGY3NpDKhh83Qh4cDX6d9Te0wl/hvYzhbbaTI80FHXybac2Xhmvx7?=
 =?iso-8859-1?Q?t3TXwJ0ONja2PZgizr4n7k/U0fdwWPTs2ctEFM+xwqms5ON5RUe9YIqsn6?=
 =?iso-8859-1?Q?AvU6sOiqkibNZ5H5askDAjnmCkWbRkp2n7W1RqyV4CBkyM+dCH4rDMn4Y2?=
 =?iso-8859-1?Q?d8kLcW93Hc/b9Ygh3lv/CD4ixB6IybEadQaEYRyUJzeCwW8FhKoxasSo75?=
 =?iso-8859-1?Q?fDG6cAHKZLuCEIef55CiKVF1Xz3roJ3xnbKKnlfmXSu/OgyccQfhyIt6bh?=
 =?iso-8859-1?Q?UGj0320TefTtHKTXOvhF3xjl8vCtcOsSHawuc49rLGy9YOmzQTU9iVJ3wN?=
 =?iso-8859-1?Q?nPRLq14DTcKS/udTnObN/CzaeEwKrexA5jA46hF/AP4JolGLqwAflawmuC?=
 =?iso-8859-1?Q?t/mJw/U6yLVWwMDkghFkPf2Y4ATd8PfTmxKMOhAW+CkT/4VKWMRCA1Dv+Q?=
 =?iso-8859-1?Q?4JqkVe+GxS5f8MMiTjdm6vIa6DLURSSabr7cJZYkjbO+KbtUXG29MiCTwO?=
 =?iso-8859-1?Q?QGDXCOfQuOrnN82AAOF/ICGOxbI6LbJnJGnbzy2I+0g/SIjkM70UI66bjo?=
 =?iso-8859-1?Q?Z5pjg+HrqqpNvtLMiHj+hWMB4PbLS+35c/ScUmmm+V3RVlALJlxhuHa1qw?=
 =?iso-8859-1?Q?A2pJzKgsWRG+qYn0ibJr/XWJdncZEzeB7rZcqCY3ujB06FNj5CVNbgUdTd?=
 =?iso-8859-1?Q?uxlLysPIg35rxPMAm0Esj78mWOciX04HM6P4i4CGviCR6ln6E6cJtoycYh?=
 =?iso-8859-1?Q?qr0HywC5OX9JCoPDaZHcfUYA2IVOPrc+JzI/aI4RbTsMxEUh/Hik+nj2Lq?=
 =?iso-8859-1?Q?YDbVU92UymejORkhXTW7rn84y9ay+sas9QR48ZY1thJcqbonI48PVAk+jM?=
 =?iso-8859-1?Q?qZQQ6VV5MUtZHeVagRFi+Lhpv5Lxh0iGXVbocAVMpcizmfPZa55mpWt3MA?=
 =?iso-8859-1?Q?y4mBBdMCzrBFowWgi6Nt8qLmMMG1Shwu2+4ZIn9tTW8DfnZLMzDSM4QYC5?=
 =?iso-8859-1?Q?/hrX+z8LycgR8/2RNLw4f9cyZ5E0xE5dmVTgP47ydqNrJkNEh8+qEtSN0h?=
 =?iso-8859-1?Q?DENJwitJwwscOSd9GnRNoN3ldRy3Q8fvjpkQtmNSUYmkBUhTz9A4ufjZko?=
 =?iso-8859-1?Q?+DK7pHwUgJJUfdEtOLGmOUmlylxdvqZuvB2+7plkbzF9qbtsE/iA+qO1Gp?=
 =?iso-8859-1?Q?IcwoZkBzhaOC1oaSrMjjT75ObtuUlYoHsuqS14ujRqUFdPk30aCr6LCIZm?=
 =?iso-8859-1?Q?xalydo/L5x2XBrVsnzyM62f8+C22OdyiZt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 285a98af-0557-4161-076c-08da5dd889a2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 16:16:23.2106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DbiLNUgwDipQFxf23g2MVaWGm3IhtBCr3608gcMHl16mdD48RWY9XGHVaOid4zQ+W+bY46NwCv2kRP+dQqspfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8213
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

In order to replace the fsl,scu txt file from bindings/arm/freescale,
we need to split it between the right subsystems. This patch documents
separately the 'clock' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 .../bindings/arm/freescale/fsl,scu.txt        | 31 -------------
 .../bindings/clock/fsl,scu-clk.yaml           | 43 +++++++++++++++++++
 2 files changed, 43 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index a87ec15e28d2..ef7f5222ac48 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -79,29 +79,6 @@ Required properties:
 			See detailed Resource ID list from:
 			include/dt-bindings/firmware/imx/rsrc.h
 
-Clock bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-This binding uses the common clock binding[1].
-
-Required properties:
-- compatible:		Should be one of:
-			  "fsl,imx8dxl-clk"
-			  "fsl,imx8qm-clk"
-			  "fsl,imx8qxp-clk"
-			followed by "fsl,scu-clk"
-- #clock-cells:		Should be 2.
-			Contains the Resource and Clock ID value.
-- clocks:		List of clock specifiers, must contain an entry for
-			each required entry in clock-names
-- clock-names:		Should include entries "xtal_32KHz", "xtal_24MHz"
-
-The clock consumer should specify the desired clock by having the clock
-ID in its "clocks" phandle cell.
-
-See the full list of clock IDs from:
-include/dt-bindings/clock/imx8qxp-clock.h
-
 Pinctrl bindings based on SCU Message Protocol
 ------------------------------------------------------------
 
@@ -127,7 +104,6 @@ Required properties for Pinctrl sub nodes:
 			Please refer to i.MX8QXP Reference Manual for detailed
 			CONFIG settings.
 
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
 [2] Documentation/devicetree/bindings/power/power-domain.yaml
 [3] Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
 
@@ -208,11 +184,6 @@ firmware {
 			  &lsio_mu1 1 3
 			  &lsio_mu1 3 3>;
 
-		clk: clk {
-			compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
-			#clock-cells = <2>;
-		};
-
 		iomuxc {
 			compatible = "fsl,imx8qxp-iomuxc";
 
@@ -265,7 +236,5 @@ serial@5a060000 {
 	...
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
-	clocks = <&uart0_clk IMX_SC_R_UART_0 IMX_SC_PM_CLK_PER>;
-	clock-names = "ipg";
 	power-domains = <&pd IMX_SC_R_UART_0>;
 };
diff --git a/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml b/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
new file mode 100644
index 000000000000..f2c48460a399
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/fsl,scu-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Clock bindings based on SCU Message Protocol
+
+maintainers:
+  - Abel Vesa <abel.vesa@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+  This binding uses the common clock binding.
+  (Documentation/devicetree/bindings/clock/clock-bindings.txt)
+  The clock consumer should specify the desired clock by having the clock
+  ID in its "clocks" phandle cell. See the full list of clock IDs from
+  include/dt-bindings/clock/imx8qxp-clock.h
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx8dxl-clk
+          - fsl,imx8qm-clk
+          - fsl,imx8qxp-clk
+      - const: fsl,scu-clk
+
+  '#clock-cells':
+    const: 2
+
+required:
+  - compatible
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller {
+        compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
+        #clock-cells = <2>;
+    };
-- 
2.25.1

