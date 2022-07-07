Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C2556A26D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbiGGMvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbiGGMvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:51:02 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF632B639;
        Thu,  7 Jul 2022 05:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWNTeTsjg7lMvv9j74JDLyZ7BOpZhhtsCnkaiPWAGaaLMdMzyAHGPB/CyJMiajLt231hiTPGc6MJUnT+EEph2xmEQfmww+4cmCkoYwnT4nCckdybN2Apf5gRJhsZy7dq4ITUsk/w9MNy2cclgMJ/GVErk7CCs0gC5hf48DfiUDfDJwjrZ8KL8W3T/jGUQsCAWjC2docQIMnl2Wunz7N5diXi0WPoO5NuXR/kHgvy/Zb8Xk25bwOOIh15FgVgCgb3RCJoyjjWXvToeXcvRkrQaJDAQgo+pcoA8ClYTTBXc2QonBNzl7R9AGzDrJieQDLfJ1rC7OrnJhZc47aXOfOnTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeMkbbv231AWkOqZly/yWzLc9QP7p9ni0uYUOIYyD/A=;
 b=Eml77nTy9IylDChz4YO/r7axl5hhZnLpxKoYk2f04LA2M/iTznUSgJa8zAQsy5JAft/KNC+UKMsdBj1QYvfc7mD6VMr0CrsC/8dshnOWGurDbtGwKOFS+EAhuzoadx4v3n/WkGTQhVZxJuSIcu7UgOWUE+3PDxBZBakgUVK8sd57MKGiMYu+AczmIxsxTzsh+RtiHuJydEb4lPmqMM+m/xGPKWWgfefE7tQIKNNVQwkGm53G1xelknjarZ9+2tIvMV6WOFppVshcDlJmxsAtUEyNmEKfcbO/F5+Mer/p9WQQDmrbU4esNu1rrfrPigqcRnP62+QIdcdsA8x8cRv56w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeMkbbv231AWkOqZly/yWzLc9QP7p9ni0uYUOIYyD/A=;
 b=OVkTo2sD0ddZYoyeEMGsM8Dp8V9JiTU7R/3CGgE6K925o6uyfXH74vNM5sNvJkAwwwa6aoNuuvH9OPj9vRezGvC0GXqsoe1wXTgGEEcba4X26eBBaF/4eWqZB2pg/v0RvG/8Q9G5Io7tjo0tLhrW5pUThkDqlzOfJZuARuMo+AE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR04MB6418.eurprd04.prod.outlook.com (2603:10a6:208:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 12:50:58 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 12:50:57 +0000
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
        Oliver Graute <oliver.graute@kococonnector.com>,
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Viorel Suman <viorel.suman@oss.nxp.com>
Subject: [PATCH v8 02/15] dt-bindings: pinctrl: imx: Add fsl,scu-iomux yaml file
Date:   Thu,  7 Jul 2022 15:50:09 +0300
Message-Id: <20220707125022.1156498-3-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
References: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P192CA0026.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::31) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6491fb95-6042-4f38-318c-08da60175651
X-MS-TrafficTypeDiagnostic: AM0PR04MB6418:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KZlJ6gw4VhBnO81Rd9NyoL1nXS7i4+vj/sHLKnOiSZl8+Sh4EKyu8hCIAWCQ1RHmuRHGgBZyIJPd+hg0l9F7rCEeIw1p8mgyESvbCcogyUf43EQGy2p6SMJZDpW6UQA7q4fmJSh+179bmnIkWZrGhjUcaDChbmVmMs3R99hwPvFgkWLjCyFAMHQjlpNqRgqnEycf5gkcbuQgQznb15b7DkCFLOjPVuhL364GFffwc5SwUDX+VbN2qDjDJzwHMIjZepnqicPZvjchLJqVqCquDHDZ9d5Ex3qHsoGBqjyGtdLJZSEfx/aVmGSp1ewD/4rjncavUA75cenL1rtw/G+cCvnDzsIV3lUWHWHdDmrGtNvGlaTNn0m09jgfQAurigjMqSLjTdkZjeltUVv0ZqerY9dhkbQbS9mf4WT7MIMmBpGMRETsNaxCgvv2aCWK6C02Ux54ObrDISNV+CH3DyWiq5Ae3XWGg2Y6AGP/nVqNniaa1tvt6Fgp2tdSRa+tK4bVi7C7GPeMVCBfdxyDQh4y0u97jBHC+RtTPdCXKAMUh9MUC+lPuF+Su9tQJPbzwPtH6gRtxItCpNGUS+XUfETLSPugCShdkkAOd5AunILcxpzkirXq0S1C26sb9dUSJV0FC/uQXoNAKZRyzSe+BduM3ukGJo2kqgneTdAATwLY6HKIILKLs/l4ZqScMejh88bPNru575pAxfMhF5Eyeg/NAJKVYgzU3HRkKP/RtQt5V8GukeCBN8aQJwPVqczF1Q9fKEwo8ZZShqy+b+koQJcSlOROoU0vtMX+loiWuEGa58h7yMjbloCd5jIu5uqJSm5kRCdt6Ls9/pctiDi5GOgPlbASR3gTGzvnTKg9C3UYPPg1Abmooov0PKCkm4YhdzAeQj1CR1m9p1c1t8gUfOD1WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(6666004)(86362001)(5660300002)(966005)(38350700002)(6486002)(316002)(38100700002)(2906002)(41300700001)(7416002)(478600001)(921005)(7406005)(66946007)(66476007)(6512007)(66556008)(8676002)(4326008)(8936002)(186003)(52116002)(83380400001)(26005)(110136005)(2616005)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?mEem3csusPNSFg5QLav6g0lBfYf8A51cBOSOIjZpz1KoExiBCwMucwFVq7?=
 =?iso-8859-1?Q?r7vmQCh2QbV6+sgB2lJBQYaPp2islTwBSFf0w5efgnuUg/wHv7Fi+2k4gg?=
 =?iso-8859-1?Q?9pmATuAu03pXpJqrmAObWs7f7d1GkS+75108Ho6n7jWFTo5JPB4GnNl8H4?=
 =?iso-8859-1?Q?Bro3cGxPU9w/KUb4j4e9JtE3CeMfcPlJ/xBpuna9cl9XkM4lSkkzzqw06M?=
 =?iso-8859-1?Q?U9TUPJGvSSm761SPR9sC4o9z94n31JIoTX48Lc0/jDe1nnBXVwvgyPns6Y?=
 =?iso-8859-1?Q?WRX1L51vWZqgfC54HbuhpT4O/gLhZE2jb6dYDm76EmklnwVn7Kf0+gBu/j?=
 =?iso-8859-1?Q?mPRO+05mv+z8jg4/0aRRhG/W9+TYtuRfCuFFsdoOO9y1WXoh2N8tY5Ifw2?=
 =?iso-8859-1?Q?Z1fk1sD+TSqtVOI4Wgu29JAeHookl314PPTpBY5Bq8+Zj7dBSXp4L51rjU?=
 =?iso-8859-1?Q?Giub5ACJ30Qr1RnIaIjRz3xQeMCW7gjYt5cjDI1OYv0maFGOuK//DycZW3?=
 =?iso-8859-1?Q?bw4oL9SOI4n3R3ikka0Qpt2eTivTdsaUXcOq8lqiKOfAX5UtwaK63PzVxc?=
 =?iso-8859-1?Q?TiWrfjG8ICQFR/qO2SvDCVdPHWD+CHkvenIGJgpT3gxQZRurasS9ja7+MS?=
 =?iso-8859-1?Q?1xWS4mG1XYUljaaNVvJIlOrXccUAugh+dIBItby9vRKc3m59Zm26GwL7gU?=
 =?iso-8859-1?Q?zdVnDhTEo/fGb3G2itm0Woky+w0QcSOQKy22K25kB7r5+2ghI628DM4dKL?=
 =?iso-8859-1?Q?qBzdAYAesvEZfgGkFlQy5fPqnVVkn0TYE+86ZGm5sQIC2252tEYNasRyyd?=
 =?iso-8859-1?Q?EXUheo89B8euCbFFq0+6sXHDH4zdOyUG3YIw1it42bFk0m/DEkl2Po+ZOy?=
 =?iso-8859-1?Q?++4QjqpwdC+baUpVwOlLLo9HXBO5pzk7FUFX4Ycyo1IhRAKB9hqDX1LvcO?=
 =?iso-8859-1?Q?Hlh+/FEUPMHX0tMrtYnfvxUVPuB9FLW1jvrEhYVVKTQnlpG977f/6Oq6s9?=
 =?iso-8859-1?Q?RXyYeCapkPgMXpjdLt+kQ6DHjD+iqtrurRtJJgTHm88lcO11AiFNi+uW+d?=
 =?iso-8859-1?Q?wiL/CijyS3ZEGDgk92lfTTN8pBf15oVibLle+O0g+RpfSkh7tc7CQ5UEqW?=
 =?iso-8859-1?Q?IR87k1v/sHs4mGPPTxZH19oTeZhwpVAqwAV/0zTwVucn5i0Bn7Pbtm1unG?=
 =?iso-8859-1?Q?6qisKbHMODPfqws4vjNXhZXCuJUfbFe+Anib6xEiTFOXXnAyXDjLjxEBLd?=
 =?iso-8859-1?Q?/7B8o5KX2iaXdtem8E/rGmVFb01kP5ay9uFtSo072CDADCdEM4m7TzoArm?=
 =?iso-8859-1?Q?7oNrjrWLEp01KUxDBiTCgRdVpIkzJtkb4kWC8HLjs+CdgaItWi8/bMOHgJ?=
 =?iso-8859-1?Q?uaf4pGoOsusP9HXWzQXIDgkooJV9JV8jF4tK6FcXwFLKg4weeGt/WTRfj3?=
 =?iso-8859-1?Q?kWL5pDJYaS2JBOc/1BF3ALAUExlXT7TuNsqAwLXf3ahRiTDbHjDeyQQLHO?=
 =?iso-8859-1?Q?2IicvTsoylZmpT4SNJERBXyYTqTn8T24rRbHsASPKB7z32gBwhEBBRCAuj?=
 =?iso-8859-1?Q?b7c9rDXVz0zGQtkZYIWlVgGuAA8ju4KPdrnonoJvYhro7B/2ab8wtOOMp9?=
 =?iso-8859-1?Q?mJEOlpjoFiZbIdwyDwont0dtaDaimgaTLx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6491fb95-6042-4f38-318c-08da60175651
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 12:50:57.7678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pW/Va39VUjxSUR9kTwGXVfRFnvKqrEJCckhjvKwVCy+NFaG2+f44eFhkw3jcDyYi+lmnN2K4WachzzShIObMXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6418
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
separately the 'iomux/pinctrl' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/arm/freescale/fsl,scu.txt        | 40 ----------
 .../bindings/pinctrl/fsl,scu-pinctrl.yaml     | 74 +++++++++++++++++++
 2 files changed, 74 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index ef7f5222ac48..5ec2a031194e 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -79,33 +79,7 @@ Required properties:
 			See detailed Resource ID list from:
 			include/dt-bindings/firmware/imx/rsrc.h
 
-Pinctrl bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-This binding uses the i.MX common pinctrl binding[3].
-
-Required properties:
-- compatible:		Should be one of:
-			"fsl,imx8qm-iomuxc",
-			"fsl,imx8qxp-iomuxc",
-			"fsl,imx8dxl-iomuxc".
-
-Required properties for Pinctrl sub nodes:
-- fsl,pins:		Each entry consists of 3 integers which represents
-			the mux and config setting for one pin. The first 2
-			integers <pin_id mux_mode> are specified using a
-			PIN_FUNC_ID macro, which can be found in
-			<dt-bindings/pinctrl/pads-imx8qm.h>,
-			<dt-bindings/pinctrl/pads-imx8qxp.h>,
-			<dt-bindings/pinctrl/pads-imx8dxl.h>.
-			The last integer CONFIG is the pad setting value like
-			pull-up on this pin.
-
-			Please refer to i.MX8QXP Reference Manual for detailed
-			CONFIG settings.
-
 [2] Documentation/devicetree/bindings/power/power-domain.yaml
-[3] Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
 
 RTC bindings based on SCU Message Protocol
 ------------------------------------------------------------
@@ -184,18 +158,6 @@ firmware {
 			  &lsio_mu1 1 3
 			  &lsio_mu1 3 3>;
 
-		iomuxc {
-			compatible = "fsl,imx8qxp-iomuxc";
-
-			pinctrl_lpuart0: lpuart0grp {
-				fsl,pins = <
-					SC_P_UART0_RX_ADMA_UART0_RX	0x06000020
-					SC_P_UART0_TX_ADMA_UART0_TX	0x06000020
-				>;
-			};
-			...
-		};
-
 		ocotp: imx8qx-ocotp {
 			compatible = "fsl,imx8qxp-scu-ocotp";
 			#address-cells = <1>;
@@ -234,7 +196,5 @@ firmware {
 
 serial@5a060000 {
 	...
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpuart0>;
 	power-domains = <&pd IMX_SC_R_UART_0>;
 };
diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
new file mode 100644
index 000000000000..45ea565ce238
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/fsl,scu-pinctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Pinctrl bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+  This binding uses the i.MX common pinctrl binding.
+  (Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt)
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qm-iomuxc
+      - fsl,imx8qxp-iomuxc
+      - fsl,imx8dxl-iomuxc
+
+patternProperties:
+  'grp$':
+    type: object
+    description:
+      Pinctrl node's client devices use subnodes for desired pin configuration.
+      Client device subnodes use below standard properties.
+
+    properties:
+      fsl,pins:
+        description:
+          each entry consists of 3 integers and represents the pin ID, the mux value
+          and pad setting for the pin. The first 2 integers - pin_id and mux_val - are
+          specified using a PIN_FUNC_ID macro, which can be found in
+          <include/dt-bindings/pinctrl/pads-imx8qxp.h>. The last integer is
+          the pad setting value like pull-up on this pin. Please refer to the
+          appropriate i.MX8 Reference Manual for detailed pad CONFIG settings.
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+        items:
+          items:
+            - description: |
+                "pin_id" indicates the pin ID
+            - description: |
+                "mux_val" indicates the mux value to be applied.
+            - description: |
+                "pad_setting" indicates the pad configuration value to be applied.
+
+    required:
+      - fsl,pins
+
+    additionalProperties: false
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    pinctrl {
+        compatible = "fsl,imx8qxp-iomuxc";
+
+        pinctrl_lpuart0: lpuart0grp {
+            fsl,pins = <
+                111 0 0x06000020
+                112 0 0x06000020
+            >;
+        };
+    };
-- 
2.25.1

