Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDD5565AF2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbiGDQQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiGDQQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:16:45 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60048.outbound.protection.outlook.com [40.107.6.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28B61054A;
        Mon,  4 Jul 2022 09:16:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4t8C88d7PrnPpFEUm7jaBlsgmeVgZBHex+EWRGlHgYFI0fdFkmFD29gKj/6QYwwdx0V+o9hC84H1SAhOpcKIoU6cKuXfUdzAPVgzSdq3JQPUMtZJicL7tZ/DxgJ4Pgb1ocBe+lD3S8kr3A702ONkHrybw0z9m3eXB+e9gG/Ko9CAgQczsz7U1l5vA19Tn8JrML5w5R/LJz+BHI/BMzAhMWnhyJRRw6aE+5X+BwJGDey5TLW3yriIbixwYqaBWGVWKlG1XgyxxGX/wSre4kdGVPdgpxp0x2lMriTjpW8xsGO61OJrxYO8Sm5BMbi23WKwOkAgHOH53Yysoz5Au/ZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmWF8TJVOGZAxIFXFRmyH17AGE4XdhFSpByppolgW1M=;
 b=OtZkP6Kyhg/rcma2Nemo6BHuA4OXFCSDpK5Vn8BIbI4ZMLluirqWeUUvmPKr4HPS2o4UON+VMhQJrnD8CHbQ/Re4VcxEVun5Zgfi6uOO7qcgV1v7XXmKvPqWPJBGmQ3IFPSby61ZUkYoM8NkgrOtSlMONJ1uIzkKi+uIy9bw4x5rbYxpKDGuLEo9wxBruuq+FFGVNqc4Eqsc19Hpc/ceqNQtAl7+27rmJUOKmdCVXUkQHySn87HPt7srG0je6rllLuhihzrFiZ2yg+pz+RwFmHELK+vFZQWUxwPLAWJ062ZUm4bxWnim3OJVkwE8BN8bnfBjKiGYbrsDIloXLAJWEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmWF8TJVOGZAxIFXFRmyH17AGE4XdhFSpByppolgW1M=;
 b=AQ4v5cP6WmSN64mgrOmXYzqV9LU2uJMw42AYdNSlWhWrFiNaDDg76Y9G/nn6g+Mtf/1kpq99mROuY8w4DLJ7IMdqvS+IuObsPycZz74jw0c1XSMzzg9/5xrP4ixxSeTAGD/or19rXu/z4KWmnq2WTSk3hjdBC/yGZVhbwloTjzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM6PR04MB6293.eurprd04.prod.outlook.com (2603:10a6:20b:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 16:16:29 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 16:16:29 +0000
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
Subject: [PATCH v7 03/15] dt-bindings: input: Add fsl,scu-key yaml file
Date:   Mon,  4 Jul 2022 19:15:29 +0300
Message-Id: <20220704161541.943696-4-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 91985ba7-4ef4-49b1-7f6b-08da5dd88d16
X-MS-TrafficTypeDiagnostic: AM6PR04MB6293:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5ytV20PUwllLlkVGHYE5uOt2RkPDPEk8ut9ztSaRblqkmpQp4SJW010MuS1YlbMAKcs5/CjPrDALOYoGmkhfJp9AQb6J9sGpf851S567FULIhDUkqIdTlRy3ueTwnvjkHLEb2CF2lDZMLZBJTqzAtrTti9108rZHiS9cvnB9ESjQz4EHopj2Oqn5iqeXLBC4s0+KbCN8V2yodVEhr4NMb+7kNu0wMqTWg5YmMBbmnSqOE1unHjmAxaOn29VBuC91lB18U3lsh/xEnKhiXr+K8ILXTACD+yAe2aWbztOlgPZqhKGNwWCpGWqNwu5V40DLoiJlpk8gd1PU4jN6v22nGlkxvPiFt09Imuaebc8N+JPrqmgIyDCo4sVQ3Y6CAcrlJTjuNRzXU8DAzK2H8z4Y2tWbsMmDiUqM0Lpmb3jR1p4x9erpKPfgKd8rB0VLubShN9UudDaJAdQhc80Btz1NcWGyVDoWAtLemrwR4PlAfuYpNylkQGPxSQsJAR1QhkxO25e/1QadZ0S7kLDe65hQCYr3r1D/PoftHBRzJbzyH29u3/rRO4lfw19TQrInB66uBHSmiggHu+Kywd3w2QYQ84t0S2Mxesf3I80ZSl/9ITfeZ8UnkHF8Yc2p8bTCeSkkC0PYDlGFxzFqacHAmftI93Yi4+nPwrOEUQbItkDiJQxvE3aWwmCL2MnJAiLs+73Ac2cimEdCbGEIHE8GEnHlWKoDvT9Lgi9EsMoIN+Q1kDhxRFMHXLbqjeGt8uCKmddcPVGf4JTEHreMcwRujU90sZNyyxe2Uluk8In/uziUpUq4dNFDSFETJwNBDEc4PF1Sd9QwKS1u3SYjT2pp76h/b5Ahs1YwPiZXYWdzCnUz3eOcccPvZe8mJ/lvb4q9rc+Ez7OxpH/shU9U9P61arTHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(2616005)(186003)(1076003)(38100700002)(38350700002)(54906003)(110136005)(66476007)(66946007)(8676002)(4326008)(83380400001)(66556008)(316002)(86362001)(5660300002)(6512007)(7416002)(7406005)(6486002)(966005)(478600001)(8936002)(26005)(6506007)(41300700001)(2906002)(921005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6Dkg0P8dDfwcdytDPUnXA1ZvDFpgtAfDbncIIXsCkuV2KnQkVq4xhAtKD9?=
 =?iso-8859-1?Q?vqlI2MEh+H7JW6tsyOUKqOV8XaF+PNkJCoc7RnQyeafpoQen10REMH9Co8?=
 =?iso-8859-1?Q?Du4EcCEWkLTo0PDPQn6s1fDLlDH317tkqyVnKOeCJMqyFi2DonrCfE33vu?=
 =?iso-8859-1?Q?0mkSxD8xwu+5Nt66fMg3Ti1TiEaXoQndp9HoJ6Fjrps08xIqwgyxpaPK5F?=
 =?iso-8859-1?Q?SgEuOd3VcCNSM/H/1oCLLiw2JjdIuLP0xaYg/fhB0DxFWJ+jXcEoLtTtlE?=
 =?iso-8859-1?Q?zHKYUIhwMgGt2L14HOmdBiw9q3ngY/GsSYnGgv0iFEC6BUSElMpcZ7AkJA?=
 =?iso-8859-1?Q?STLX0aaac8ByP9MB23M89tA67v7s2cjOc84lMlBGyTm1naMJBw3f8+PjB7?=
 =?iso-8859-1?Q?fwyHRbCIgez/RCqPnlMs+1/Z8baUCK11qbBMBRD369RMc4SkoYAye36diT?=
 =?iso-8859-1?Q?0qYGCOOJ5duSoSnxhutbq7FxDw/PZ0ERNbFGVqzYDWodQSrxKyQbo7PcTX?=
 =?iso-8859-1?Q?foadBI2OMJjJeoNmXGVqSwEznZ8Uedg44srglXsGK33zWzchrOoTSMeiG1?=
 =?iso-8859-1?Q?elJ3BZJWts+YSHGBAD2h2Rv0R0kJBC6WnhESOMtvZOjq/nqsJyCtpqAM67?=
 =?iso-8859-1?Q?tvmu1wjHXwkxac/+UOuN/1BMwA2fMk9GkmVr84uDKConcHrS2wzr/1VCpv?=
 =?iso-8859-1?Q?aq2tv8+T2L95u7k/X/O04mMPPzwuobYbMk6utzgovUsx/SUBNcR9+QUctY?=
 =?iso-8859-1?Q?DMeljMkeRHRSze7vfaUYSGwiAd7SXn1XyadxDHcpOCsFzIZ0l36nK776LF?=
 =?iso-8859-1?Q?R2l8+PVf4NHF+QK5Vk6MbG0j5CmA3k7PAvGFNhBv3K0GXCOaUF+vExqXbE?=
 =?iso-8859-1?Q?JPrlGhA+ha12cJncGG7N/4YsTQ1eV8+b/cONzZmR6hRmZBF9SJqp8CpWiN?=
 =?iso-8859-1?Q?d2llXluNGJexoehJqRy7WnBqMwzKbEx3v2N7Cf0kQBzdc9cDEybvL8Uuud?=
 =?iso-8859-1?Q?jhYFzw+6VQPoAMqibI90nAmBbdI3RTaF1b9O12O7Se84MzU+7cuXv3I1JK?=
 =?iso-8859-1?Q?CUVxIm0pSffVywQXMB/0QHqa8R8x2Fu6ejaLSdvsbhxETczAcjavYtLLHC?=
 =?iso-8859-1?Q?IQt/CvL53v19uyl0kD2p4lFFLsYUTBfTPEPS5jFGy5I2Up+tz1jlslP6dj?=
 =?iso-8859-1?Q?w4zkNnM+DC8dU+FL6df4Q2m2A/v8EBGF02EQHE3JdGXM9uIwDxkxYXeJV4?=
 =?iso-8859-1?Q?M1eIGjcIFilMkE4w8waCowemdCyL//XNvhC986Vn9AoD8GnjMsYCBnG6Qh?=
 =?iso-8859-1?Q?u0DvKpWEyUIg1+Z2ZghR4v81opQD9pLvKo45j0IoHXZZw1WRxcfDJm1KaS?=
 =?iso-8859-1?Q?vox1HCTQM/B6RtlzOefZiEXiP44Rq93lh/sE8FqtLoLlYd+xcCA+/ASTP9?=
 =?iso-8859-1?Q?FejyCSBS/5XgP3TwmL8aUeDcDv1YSprFrrbeCWDWZmEVHoCYDO8IR54VlB?=
 =?iso-8859-1?Q?q/2uZw7dTe+6smnoxxZDiYTKrpSVf9J3lgRnPQMcB28RUjpHlEHd63+LH5?=
 =?iso-8859-1?Q?MxKyJGvhxMPmKfuUFdNCKPCHOiK5ZF9beT/Avkbp3A+R3Rl/3S1WFywk94?=
 =?iso-8859-1?Q?MNa8Dh66bRLSUbAhF1uk7jKtb7BKHr+ilZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91985ba7-4ef4-49b1-7f6b-08da5dd88d16
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 16:16:28.9914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udrhyysjinyZZN1K4FUzruyGuLqOl9DL7nOJw348Ui1pYAxJU9u5W/araDSRqX4sUse0zf6e2z+YYKZ7OKhZNw==
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
separately the 'keys' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/arm/freescale/fsl,scu.txt        | 14 -------
 .../bindings/input/fsl,scu-key.yaml           | 40 +++++++++++++++++++
 2 files changed, 40 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/fsl,scu-key.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 5ec2a031194e..572cb2e628bf 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -111,15 +111,6 @@ Required properties:
 Optional properties:
 - timeout-sec: contains the watchdog timeout in seconds.
 
-SCU key bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-Required properties:
-- compatible: should be:
-              "fsl,imx8qxp-sc-key"
-              followed by "fsl,imx-sc-key";
-- linux,keycodes: See Documentation/devicetree/bindings/input/input.yaml
-
 Thermal bindings based on SCU Message Protocol
 ------------------------------------------------------------
 
@@ -177,11 +168,6 @@ firmware {
 			compatible = "fsl,imx8qxp-sc-rtc";
 		};
 
-		scu_key: scu-key {
-			compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
-			linux,keycodes = <KEY_POWER>;
-		};
-
 		watchdog {
 			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
 			timeout-sec = <60>;
diff --git a/Documentation/devicetree/bindings/input/fsl,scu-key.yaml b/Documentation/devicetree/bindings/input/fsl,scu-key.yaml
new file mode 100644
index 000000000000..e6266d188266
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/fsl,scu-key.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/fsl,scu-key.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - SCU key bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+allOf:
+  - $ref: input.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx8qxp-sc-key
+      - const: fsl,imx-sc-key
+
+  linux,keycodes:
+    maxItems: 1
+
+required:
+  - compatible
+  - linux,keycodes
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/input/input.h>
+
+    keys {
+        compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
+        linux,keycodes = <KEY_POWER>;
+    };
-- 
2.25.1

