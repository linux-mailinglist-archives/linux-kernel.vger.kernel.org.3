Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBC756061A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiF2QpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiF2QpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:45:13 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70045.outbound.protection.outlook.com [40.107.7.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F5535878;
        Wed, 29 Jun 2022 09:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6MxrZfi125DxOqnmrE2wbpZRzlDvzuwTnlL2bRb4W313tXzEwU8AD0KRhOYzAS8hoh7jpXIGQwl4ivs+7ICfhpsgyrJEFAhbMxhKbNdo0eDC9oslkm3VMZMRoE+N7BDLzAVrI942iwD/MFoF8QMrphZo8gh1CqL/mbpYUo4zSYoqfFoBzJqmKJctZDvkvSQMeCjqAf7D4/k67On55XwzDGqh684cmceyx0TH+gmBb3pnKireag8VrqgfYJiEjp+a1I7jo6Q86mwmrMGcjel/einMHEonQSH/nu0NIgej2XebKuYt92FILL6X209J0j6HDiX/GwbixN6CrrzCWCXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UQ5TfUU6mYJxqgCveH4le0geBXS3OyOGkrMhHW7Z6Y=;
 b=BeyZuau0njSDChVG/qdduozBUGtRVzUg+Tme+Iz0A/u+ZZdcMnyb1RSsA6qcPMsC/D45DtOvIMCaVj7yygJuNt9P5ag9hT58td2ELm9jCBb5pY/jDk7+H13XtbEJRX92IgBuOZnarfMk/vqpJAA4dOAubLEa95msjbSykMoy1QfOFel1cL6zCb4CqtybKJWLtiC2gg0jubna53u1OJTx2Sz6FJ0Czifox2vkAl4O1G1pf3TOWyo/PY1FrTPMVP6pZUZdsP4h2YPu1NVOm+XuI1BnsuvJ/eFHgalKPuc5XMnjNnGWMmZr1kN7W9Ss4iNvgsiS+brQ/Q321YN3/ugGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UQ5TfUU6mYJxqgCveH4le0geBXS3OyOGkrMhHW7Z6Y=;
 b=U77yD0Y/JH4zqoBpxWAKx9NoPqMqzjNtfmq3KMoiD88rqqteGwwsozCiWMDOpH1zkn3CfhQv53a+aORPDxFPSRzR9OIKggAbq8SMNY8cGvi8oDTaNEEurYuJtglc1T8ODoJDNrCMtddfqD8tkSJeNvAHQyPlN88jaP1eoK4yW7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR04MB6401.eurprd04.prod.outlook.com (2603:10a6:208:172::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 16:45:08 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 16:45:08 +0000
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
        Liu Ying <victor.liu@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 04/14] dt-bindings: nvmem: Add fsl,scu-ocotp yaml file
Date:   Wed, 29 Jun 2022 19:44:04 +0300
Message-Id: <20220629164414.301813-5-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::33) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8708d87-0968-4ada-e949-08da59eeb9fd
X-MS-TrafficTypeDiagnostic: AM0PR04MB6401:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xosRIUytEIKmXjA5Ly5dhQiqTLU18jqLPs0Cu3JI2X0mo6DQl9I4hpfXrqaJJTi28KdNueF3fVQmdjIvOV8iS2t4fQXedHN40vogmf5tdTlScccE52IxbcZh5aWC+bYY+20l5eOZqWQ9rLX0AaMP6Bvof0tyLhUnqfJULlYLIdcTHwnh0EUCq9VwIsg7YeVg0b/IcorXkPEYEsDPC7Bv755gzZqKENcV10auLoKNyL50EVYihmO6fckOraYepeAM5jYcNLLsAFUTEkPOvW0ITmMjMPdeNU0c3WdnaiSnaqFgaTQfcrWKUgJV0qTUwKd8e6hbqYqeNpoZ2zWh91k4KjPEOoZtThFI5sI8Q93OG+Bks/GxeS3LRV/23hU74BNhyXBNjwQQUBP0Q96RZhQbFOpD7RVSKVeQF5x6KaPjgV2mtrU/MSS3op3yZtD8T0+P7V7OhXZhieCeGLj8FyafbVfFPsmFShkKOWkm9nyrErHbOLtqx6YClz4CxEpKR7e9M8KFyhYNLlKDMoghRwLfe8hq1Xza061smuDPNzKFPzuKSqSB5OdfbJY+mTjOSgjhZh2hjefU1dNzWKAjTyNy9DPwS0JwAGJH99OlvMx6VfR8QVTZC3K0cpLNKls+6T7AUeGLfyCeBv732B1jWhfRAzPokBu616FWqEiiXFK43n9oK+Qi64t4ipqIBpqGtjeI7mLVc5Amo8PrXUavrN3dmJsEHt8Y/tTSdVXpUVcHBqWhiUA/j1toMd6p0IEjsFnfV+Yw5JllnYyPPvlqhqxyQPmuBOeztgia9X5Hcr7loBgmQfCUZc6N6AA2GfMpt6yqYzitufcNkryKA9XC2K13Po7UtzkbFYBDJlag3aF1TK96rD/s7DNXlaq1S3rXMmN7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(5660300002)(7416002)(38350700002)(110136005)(38100700002)(8936002)(316002)(2906002)(66946007)(66556008)(66476007)(52116002)(7406005)(8676002)(921005)(83380400001)(6512007)(26005)(6506007)(186003)(2616005)(478600001)(966005)(1076003)(6486002)(6666004)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9kn+t/vTN9Fq8o+O887TWXJ4h1YyoaQ9BN5DYchrO1QBjARcs2dlndXJqL?=
 =?iso-8859-1?Q?g5OCpGzalZJgHDimCf9oOLbrnlNNb3ZAFW43vJMoGVNcPJl8EoZfPDhSUi?=
 =?iso-8859-1?Q?CH2Azo7g6cf06ALk5opayo5ZvcRfXoTDOosg6k25kLek/t4vMAcneufrdI?=
 =?iso-8859-1?Q?dU57dT/AGFV0k3j+V/zbKXyyTzPgD6bH2+bbiINHbaC8ys0pLFwokq5son?=
 =?iso-8859-1?Q?asm7H2/5AKxKC8kNSWgEJKdNzqRqr8PD7CHVz/iIktsaZfZ9Xf4t4JfQeE?=
 =?iso-8859-1?Q?IJy1MUqereOkoxTHuBloO78oDD7g6gPCGNesGG+kOfGpHm6zYYaPMyTdnL?=
 =?iso-8859-1?Q?p1nKCWlpCMOyggZ2pxl0vlZgdg4Wla+6Pp+bTBv1dqpp77RPTSJ6coD6yv?=
 =?iso-8859-1?Q?n7yI6nwm3AuATAXv72Hg58NrpwlAikAmcP/l4gcnMSwbIoQX/w0SHArCpO?=
 =?iso-8859-1?Q?XnGqyczSLxRCs0ZhjGPU0bmCkZzqyr6nyzSp2pbKP2/vSZVivcj00e+4nc?=
 =?iso-8859-1?Q?zxYvF5tbRbKwIwiHbAK5kF/gLHe/MH2du4qVMcsiBq9mgRIrq7qGoM7dCL?=
 =?iso-8859-1?Q?lm7V+jyfDtMrAc48or/UDPTlgfyrhTS+t2SLysIFxiHurIW9TijfwH4294?=
 =?iso-8859-1?Q?cZs+oBlvlgF99U+K/xwIUvMtWc5VhrYm73phQuswRjqp4b/TjF0pKIuh74?=
 =?iso-8859-1?Q?fyp9bzO9TACU/QrHJySuIQzZr6pT6n8F2YhCSW9831oiQJwxuvE57BBYXs?=
 =?iso-8859-1?Q?TXCEip2RF6gELEIHa19G6kNHnybSGLGSjb+xERrIV64f4IPbz3Xtm+5Dhh?=
 =?iso-8859-1?Q?mb8y2jS/GyEjw8oLhKOzlPlK8JI1/xMdILg7q4bkV3f5GDZmUb0k/JH07w?=
 =?iso-8859-1?Q?zUfGBIRz5jS+/+eGiJdRXnOXklIHO88YJQadswBbKI1+K+YtoxRtBm4jD5?=
 =?iso-8859-1?Q?dOGspy0APXsHtACj9iubuEl6UMdDVUdXQMEQqUCOKc7xOkG+lwsuyO4KgX?=
 =?iso-8859-1?Q?fjK/GjTrw0LfJr2gJww/7UEs5cOhBPB3LIseer9dGeq/Q0rmEY53AlG1Eo?=
 =?iso-8859-1?Q?/eq/p0CAPIG+NIKWeY9LTFhLZWoPJ/pV2tErXNsMnyZjR8PQoJjL/sBjNp?=
 =?iso-8859-1?Q?qPBrYx8LJwPU+nKlNedLCnu13PQN5u+6tUddsOWKuJm1uxGU/iBILnAGN2?=
 =?iso-8859-1?Q?/VJkvI2X8ddHmNcX233wdjxN2xL1K8MeT5y5wlLc5qIWGM0xn1BR2Eoqtn?=
 =?iso-8859-1?Q?poRniq43OpbpYeaH7AirNHN8/ouNPjSj5mZbNWmb3mRj/UsiKTQ447TRu3?=
 =?iso-8859-1?Q?MyQHmAMKUCaml1yLzd583ptlKlZD5uZMNd6lrcgF7MIrs8lsTGoLu5oPFy?=
 =?iso-8859-1?Q?+GfTvCh8ry9PHQrB/6Pu8IzP1LPxSA+XLdaGAllKNkNyYSWRgSK/3pYma9?=
 =?iso-8859-1?Q?/9na7w0t/l9tL5pSgMJicfhV7i3vFo+OD7x4aIYj+8WOwraB33J6yrmps4?=
 =?iso-8859-1?Q?sSxFNjXHh5EPe3XOf4MGhvb4A0nEpAR+kOdqcEGLwTbbbQ7kl9oFw8jcBG?=
 =?iso-8859-1?Q?IdZZlFe6s9awjY/HANdlr1DinFmNSz6hOyD1ulWop/XWuZQLa1GRvR9hEE?=
 =?iso-8859-1?Q?SB8+0CynVas++uYE06dbdwtxsP+ziqYUVB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8708d87-0968-4ada-e949-08da59eeb9fd
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:45:08.5266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvKOR98p8GAqhFIFgsku7f5sTv8xp+JJEcg76272t09gzppGQF67VasKSJiUe8+OdpC1nT3AUA6YelQB05vuhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6401
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
separately the 'ocotp' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/nvmem/fsl,scu-ocotp.yaml         | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
new file mode 100644
index 000000000000..a8972acb1b01
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/fsl,scu-ocotp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - OCOTP bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+  Detailed bindings are described in bindings/nvmem/nvmem.txt
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qm-scu-ocotp
+      - fsl,imx8qxp-scu-ocotp
+
+patternProperties:
+  '^mac@[0-9a-f]*$':
+    type: object
+    description:
+      MAC address.
+
+    properties:
+      reg:
+        description:
+          Byte offset within OCOTP where the MAC address is stored
+        maxItems: 1
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    imx8qx-ocotp {
+        compatible = "fsl,imx8qxp-scu-ocotp";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        fec_mac0: mac@2c4 {
+            reg = <0x2c4 6>;
+        };
+    };
-- 
2.25.1

