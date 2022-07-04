Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AC5565B05
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbiGDQRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbiGDQQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:16:47 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60048.outbound.protection.outlook.com [40.107.6.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C44512086;
        Mon,  4 Jul 2022 09:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8kjGd0+ZB6EIqEbsGZH6iZcTWPid25J9DeqBWPUEhaCNwoWtVf7n2kVRBKXKGR3vjW5LcplohLoo6r6m6fPyI5JOw9hW+6FizOokU+hWb8LFLjd4DYi38XEl/l1rILXyQawKcZXBH07YVLLbtQvvW9VmksggdypxSmegm54+z43KpdFespA/nEt5WBTHv8ghOl/HxLDbJrmhdxI1eWGCQ6No6SIcwv5O3mYnhyuDroYgRIrW2JEmjiJ1QDDfNZnX/jdKTsuLscCpweRY3y6kzrygGY0pdnw/IZ9i+2wU70hiHknmXU+T4oBak2LCD59NBJc/3H/Z+vcGzgIlZFPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJpTf9kA6MpLhBFFGhAQ9sK3m0THoIk+tgQqVfmBBKI=;
 b=l1i5/c9br0v/dW38FBS8BbQ3zjeGSdjI9QEhEdQMfMjUvVw/kSO0hveV/VyEaJLhlj5xpJVnZixtHyxNtCTmBCEdwNFqGpmPeHidDNKwJPNRk23gK73/IpJItPUE89SkbA6a9Ctndqa3CJ3IKq8+7LZLyNA0H5gRES4o5JK+e0ORp87NYJn50UupPdJ4AUd6SaPIW3TZoeDo22Q/UPOEPjBF9Fx+0gh1mOVZRqMCzGy4rr3BH3Qwf/OQQBPyk4sejzZtUT2XiPhMe26cF609BZjaknhchPmNLHN5/0WC8JQ4SV9zo3ALzsEJ30t5qDFjKDLCHAU7UDw5awH8sWAhPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJpTf9kA6MpLhBFFGhAQ9sK3m0THoIk+tgQqVfmBBKI=;
 b=b54DV1Aqt6swL+nh2ZIbgI4ppBStovqTi0y9aUI2kqFb5mD/nkzm+WHXaTi/JiY9Q/Hn4pDYw35zLKuA0wMt/bLETbH6pp7WjcD9AaXsKSbYaMu2U48a/IgtkjfcK3tVOXTWjydG5QHDQJnoXDuEZL2keUL9cQgbQtUGSodqzIs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM6PR04MB6293.eurprd04.prod.outlook.com (2603:10a6:20b:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 16:16:35 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 16:16:35 +0000
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
Subject: [PATCH v7 05/15] dt-bindings: power: Add fsl,scu-pd yaml file
Date:   Mon,  4 Jul 2022 19:15:31 +0300
Message-Id: <20220704161541.943696-6-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2a53a769-c5f1-482a-f364-08da5dd890c8
X-MS-TrafficTypeDiagnostic: AM6PR04MB6293:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwDF4NFx+HVUw3SRzqftec9cByndfngfmyUg368ZaJe31YnOXIZDdVaJKM64hXUcCWjklJs8jvDLsqs2kKG5V+XYMnZDmzzYJbMTHnQUYu7FYd29qK4UF1H4hZnnstwnfRv522DHI3Le6MNCko72UugwnXhrseu6c7u1bQJUAmsXHeQgVbVN1xgdXLErOnV0vhNJJ8v4nnneBMfLf8dJBbwrhdzpxQzQoAPXld1AaDJ984dayBSq66LDiv0EaDyo6YJj2uh0teUpDleT8dfAf1UHzNY7kGe1xw9Mue40WiO4H1rZHAoycnHiKhmcr1Qk/z5n4TEzKzwlnfS4zRaT6uTadx0s1MbAJvipf+l8zjv48P65buh+SvtMWy073f4iQ51mxgABD3wRG0Y50Fi1x3SfJrh0RhUKwBuWBuMxoEktx3rdj5neIj1mD1OViUxnfIfy0qMQAiL7z7CQHcHyyeoNWCn2ub/1vaSzpkmwATxIVvOCKwIwKlxZywZx4+BiYMMpF/tP6ak1CRNILR7sy8Qduts/Gn2z9qaNXEfOpLP7jFAsF08JxrA1bOCHIlRwfYYGfv0uxO49wnRVPxFXz3MEp4LTn0mSKqkdihgS5t5Ha+Ay1pUF767mBoWCmVma/LzJsHA74rUKLS+NC7AuJ2oR9eK6RMcJ0F6HUZHl90PaACJDcSR7hKMnATYeUob8WjDx9VsUVQvwIwPMow8uhIxFgAhYCIHdp6HfdNR+Pyhaz2Uj6L59OJw8qDcKCG1IDNHStgO/PcJESBxICjGJif9YeggHv8CRS6i3kB2fczeXkSJF5HdLie3dlx2ZfxSx7ihtv8n0BNIsMO/dO/mOA7HcURkaomTqAwX8W80IPWM+Dd49Df8dmeCCN03NYJnAFVyOct7dtOLUM8ZrtnXmtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(2616005)(186003)(1076003)(38100700002)(38350700002)(54906003)(110136005)(66476007)(66946007)(8676002)(4326008)(83380400001)(66556008)(316002)(86362001)(5660300002)(6512007)(7416002)(7406005)(6486002)(966005)(478600001)(8936002)(26005)(6666004)(6506007)(41300700001)(2906002)(921005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?jhKDlE5Lap/HEWsCxJH4naTGhphaLOEL38iVnxCuqYsCwGLP9mDjX250yG?=
 =?iso-8859-1?Q?ftVZqnIxkw5R3CRglaANIdMuYj5v6+xOGHPsmkxa/Y7n3jaYiLpWrIEL6D?=
 =?iso-8859-1?Q?rYw2apiSt3J/YkFdeIhYamWAm/NlQfoNZQwUqDkcSE+n8VXJac38lOVHcn?=
 =?iso-8859-1?Q?RqpxUzNgCGkHIAOXAlJla40yHPpTT4cUtrrnUlS+704W97OajHsUpwAmdW?=
 =?iso-8859-1?Q?w1SJKAZY5IV/Y6ZJahu3uFGpCzcSvpGWnZCVAXG3LpD3hVLPp8I1IFSwo9?=
 =?iso-8859-1?Q?d2PDqWrPvmG1sebCzos9O5WQR3GqHlvGhSka+cQ7vzECplNTFcQIj18m/K?=
 =?iso-8859-1?Q?78ChAvnyLDhPSaYdcyLccgyQ6bCwUPoVmeI2+iA2GqTfLGBxWgt+2SQJov?=
 =?iso-8859-1?Q?y2Z0Iy9+EaacAKi6P7TVhK7NnppoCTtY00cyaY3+b73sSoCTKe4+YrxYFY?=
 =?iso-8859-1?Q?q/2+gewM3DFkutoH4ySN9s8yRfRTpOlodjqpadTygw47t2YD0Wt0pWKMUu?=
 =?iso-8859-1?Q?n4AUq6NgT8gpkP8tCy5CfxroQGyUnoc60fCgMK7XOv+PP1Atia79rZLlGu?=
 =?iso-8859-1?Q?22t9KoMB94eD5m+H+nPvF75ede9vF6WJiW6vAkQzykw+XITx2na56XSh5o?=
 =?iso-8859-1?Q?U5yGUgW+DMNKVsLmMsfltj6MwFDZL+s5tZRcc8R+ZIYOX8NcIFaevfDm6R?=
 =?iso-8859-1?Q?AtiFnUtsBbl+yqhnyd0vFKbkOK5tpwVErk/X0FuLBSVQUcqhbQMA8fWqlg?=
 =?iso-8859-1?Q?BAmBC1OQ2MhjHnwO3hGI2OvTeW4TR5AIfr+H3BntNr9P9+hU3On9lpepSC?=
 =?iso-8859-1?Q?7FjnxzyqqiYqLMDWyhLRtQ3AgufHjUNIOuq7pSr6qY8wiOh37cKX6s3NWl?=
 =?iso-8859-1?Q?JwUsynC3Ei+NdxJV+5U90osMTj0cevhqmELUgp1ccEp5f9v8wnApmwPgRR?=
 =?iso-8859-1?Q?aHxhkrSX4JnDnY+uUcoPmu8r+InTskrs6/35k7vtYUOpPgowI4GCRpesAB?=
 =?iso-8859-1?Q?0MztrhVf6Cp33uIHDIJMPTLV1ptgyiNu8rPAlviyfMCEYyz/Fob0o/GZly?=
 =?iso-8859-1?Q?GduxMGWSpwsvtS8z377En8px9QzwO/pIsE/B+JoKMEntdcsUKNUpcs0Q9s?=
 =?iso-8859-1?Q?dRRBa7pdmBdl5bogiaRgiRNEc5s4YNAPYFaLYzZWVHXePcWOQktzbGxEGI?=
 =?iso-8859-1?Q?uasmz1NfNYH7gmBXbPEUbBjQeV+sBZ7iOUZ7n6nUT+hCKZbo6d30TFvNH+?=
 =?iso-8859-1?Q?tdlh+5RFnyIW1iTGSq+g4PeWhP5zYPhO4fZo/VdioJCdxPLsqV1QS/vquE?=
 =?iso-8859-1?Q?EVuahlGlyn3eDQEz/5k70FHIfrZbIMZtoIAEqxmYgosAeV8NAkTlFXayUY?=
 =?iso-8859-1?Q?xnQPkN6Vk2o+FK16P+ZJEU5UCSqG0sbBIfTK5TM78tPmBEB+79irovARt7?=
 =?iso-8859-1?Q?nPXF79t8Iemb63Y57bBSM/+G//WsGHf/U308KXhM3hkwGdfey3ZtMaRC57?=
 =?iso-8859-1?Q?KkPauLCH+qkRVGQ9U5/BqdabX1pSZIxf/4iL3oXXrE1GAvtpiJENmWbbUN?=
 =?iso-8859-1?Q?UfTxByCYoePqw2rdbuNt3M4P02EWKyiqALKwaVUC6gjx6TYNkV2Kegfvqe?=
 =?iso-8859-1?Q?a1SkvHgjoCAzO6q8LAqPkLSyLTwSnAe4pd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a53a769-c5f1-482a-f364-08da5dd890c8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 16:16:35.1316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEAcfuP649sktJy+V3VZeKCfNiWkXw4g3nGRIE+R0tadl0Lwvd0rm6QlchcPyuVi+s+UdhhBX53jmm54f7UR2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6293
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
separately the 'power controller' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/arm/freescale/fsl,scu.txt        | 25 -----------
 .../devicetree/bindings/power/fsl,scu-pd.yaml | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,scu-pd.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 0841ad8bbd22..1a06f627b125 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -62,25 +62,6 @@ i.MX SCU Client Device Node:
 
 Client nodes are maintained as children of the relevant IMX-SCU device node.
 
-Power domain bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-This binding for the SCU power domain providers uses the generic power
-domain binding[2].
-
-Required properties:
-- compatible:		Should be one of:
-			  "fsl,imx8qm-scu-pd",
-			  "fsl,imx8qxp-scu-pd"
-			followed by "fsl,scu-pd"
-
-- #power-domain-cells:	Must be 1. Contains the Resource ID used by
-			SCU commands.
-			See detailed Resource ID list from:
-			include/dt-bindings/firmware/imx/rsrc.h
-
-[2] Documentation/devicetree/bindings/power/power-domain.yaml
-
 RTC bindings based on SCU Message Protocol
 ------------------------------------------------------------
 
@@ -135,11 +116,6 @@ firmware {
 			  &lsio_mu1 1 3
 			  &lsio_mu1 3 3>;
 
-		pd: imx8qx-pd {
-			compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
-			#power-domain-cells = <1>;
-		};
-
 		rtc: rtc {
 			compatible = "fsl,imx8qxp-sc-rtc";
 		};
@@ -158,5 +134,4 @@ firmware {
 
 serial@5a060000 {
 	...
-	power-domains = <&pd IMX_SC_R_UART_0>;
 };
diff --git a/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
new file mode 100644
index 000000000000..1f72b18ca0fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/fsl,scu-pd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Power domain bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+  Power domain bindings based on SCU Message Protocol
+
+allOf:
+  - $ref: power-domain.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx8qm-scu-pd
+          - fsl,imx8qxp-scu-pd
+      - const: fsl,scu-pd
+
+  '#power-domain-cells':
+    const: 1
+
+required:
+  - compatible
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    power-controller {
+        compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
+        #power-domain-cells = <1>;
+    };
-- 
2.25.1

