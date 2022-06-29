Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E24F560624
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiF2Qpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiF2Qph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:45:37 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340193B032;
        Wed, 29 Jun 2022 09:45:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJZcZ9l4qV0fK7TCi8l2ktw0bBWGnj3HJzkEPcte78hCyXU6k6TnynVvDCD3uPMFCn1WTQdFzRNkkeR8wB4njr+ssLPm09iMrK/PiwFpb5B9jCl9lbDCIE8Dg/9bS8aKSWt9FCYstOC3F72l3WhpwigmDZygeCyi4F1y9DRDfetxXxO1uNX8oZ/1kbWZ7Exu9ns/uaN5PH8ftfQjzJDqDSI9fjUX2oB4vG2FxZURU54b0sHX651bvnbpeD4hQ2ddhIUuofwGshh2aGFAPOshztNGgl6mSLhLaV5T4kDUvjo2Wri0+7q11VkrAARIRaHvbhOwWy6URZLQVo+nFFbDkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWSGkM+Wql+2zKeaTrZVzKddpSQfm/ZaiQyCScHRp5o=;
 b=EeC3CpagZbc7Hr3G7eyeoto4BcIgTciJ/m8EwvUeL3uWoFeZMJRCrcOJxKwMH27ZSgKrgS797MgvYQ1a7b6LG3tpytUvhqlZ8cQVcPFlYzuCFaR6hkF/MBpDxQi+pSrZu/Q7fDQHAhDamF2fghvFJ/zHryVhY0KUu64HCWsaLiS10v2QnF2tuJXCQBfJxArJnxlF7cvZ+9wCBllgLPv12UUpLM4AO6sTsAUp+WTtxgpC2MI/kYszfktYYPtjEaiACkNwKwz2iqBuqm1+KI86hp42C2Em04XdBHKKNou4rrSZEqaiUMnKc0ZFZ51ijnSOaSZWoMjpmJQqnDBFpx+rJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWSGkM+Wql+2zKeaTrZVzKddpSQfm/ZaiQyCScHRp5o=;
 b=L2uxkBWuPtM+srwbtWuqMQJ7fsPAzROrjjy2rw1xw/UF/5NeSWVpZOVyoplKHx1g6TAtTc+bZRp6fohKNiq6wYCgjl0/iC3QAX2uObFUbxHQSJv9SgHYsKcp37Np6oLU8uvCeupQYu5C54MWqeLhr8Nm5o0WD4ecQz+l9gCTZjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by VI1PR04MB5840.eurprd04.prod.outlook.com (2603:10a6:803:e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 16:45:17 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 16:45:17 +0000
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
Subject: [PATCH v6 07/14] dt-bindings: thermal: Add fsl,scu-thermal yaml file
Date:   Wed, 29 Jun 2022 19:44:07 +0300
Message-Id: <20220629164414.301813-8-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f4435ec4-2714-474e-4357-08da59eebf43
X-MS-TrafficTypeDiagnostic: VI1PR04MB5840:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qcHSUpunp3f5I3f2DSWZg6eQE0KfTyrrj37NAloXKq1oBWIxnA0Il0w7dmftEB5U/0KhYEI1Fz/jLNKkjDUxdQ9RXuVwkZpRjvwGftKB0mKMvb0lDr2z/DghZk/B6ioMko1TNl7FVzcq0hFlMXq0bFZuCMRr49tqzclUp1FBh2tr6qOSRD4VFW1bmq0aCNU8crwxEEzG4cr6+C4cD6zJvrusLUvr1c0yojPz9U7ms/XHiNxAHhRm6kVY4J2dXpoL9GEYTlwqwLmF/uJ/VXelFnPOzNZX8C1xrIwO3ZH9TXBEZ4I+c2IeEX5B5pBadeAhjsFMy+moOV9ijDYmZ4vxaYG49jv9+ckcXUcK+LuhgmhnFHx66YVItXrtPjbxkWQuR4n/VuKdNIgxL7zt2DlNE1vumbqFrbYqLt0Ip/+nYCQqRZRB53WBsfY8dmctrY4KXI6wDIpng6rTJ7wu6phNkovgqAqVMX2Edszzem8aDkJXsxeMbsCsA2XMDmMRxgKJsK7IRDkdb/WBJp+RdLLGd9sv8cjzW42mLhMSpFzjnjFgNhBGDL2vJhKI8IpBPQ9rgiCp+ooLck+qFoNCBlxfJOjvfZSvoz3bFQA/2GtaSJx+NRs3Blnga6P+FGZAC6itziJ9yyn0chelEZSXyPFH4+cDwbThTfixgvnj0Qtnmyui8CyFO96Z/WjtfJVDf4TD9PGZTLqi1cy9n4jWenWWvoAqUErb3LtVEbBjK0BIUUNbEjoYUmuEJ0WE4KZGUZeDlnUI/oacx/FM66ylfqA4xXpiYnpa7vyquVgvln7txo2Z8LOnXrGLbe6gs8G+l7o2oQwEoT1yDEgJC/43c9LRuFx9BEKaft6GKmgOmv/fLKK3mQ84gbV5kyCXnHb8dNfw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(66946007)(6506007)(26005)(316002)(6512007)(66476007)(5660300002)(66556008)(6486002)(8676002)(8936002)(52116002)(921005)(38350700002)(41300700001)(186003)(2616005)(7416002)(478600001)(86362001)(110136005)(6666004)(83380400001)(966005)(1076003)(38100700002)(7406005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?eV0M4KQOGBm1N73qOyKlFI54cNm6MWd4dUcpMSEJcPrL4OAhvkY6LDVdwI?=
 =?iso-8859-1?Q?rPM6O7qM/SLtRDrFkIPjjGY2v83zrECuiEPXIa8F+sCxXzU1nx04K6NP3G?=
 =?iso-8859-1?Q?OGPy93vTlbp1rwMx7qmoYTtQkiFzNpqQSMHvBvh6t0HRwyhkepnVBbBV70?=
 =?iso-8859-1?Q?VbquTO1JrKQStRWAORFVkjqZmYxFOBt9i0cZ1o8drBtJTMrvH0EfNQdM67?=
 =?iso-8859-1?Q?NQ1sLoMfGdJTBHy/m9gRyzemBeZHxX1uoRoc9jXAe1faRCJ0Mrbv4S+Htk?=
 =?iso-8859-1?Q?i/3qpG7mBGoMBZJfd1giseKuS8JWB7ul4guCTKIUoOq8cJ/33NEIJsr73e?=
 =?iso-8859-1?Q?biJ2woTmEqQNBtpwOdps6grT4g2ObX7ijR9/h78fsfIz44fp4LodtEl252?=
 =?iso-8859-1?Q?5KrzC7eFK8Bx2MHCATmyO+cfzpKBLyRfXMiVUIcphuTzDCCwyS3JBkPm7n?=
 =?iso-8859-1?Q?IMva90JnVfBU3nwWqCnD3guxX/cpgG69QvyY+6uDmvlk/Vqzvp7y1sQyJo?=
 =?iso-8859-1?Q?TRFADmtaRH3uA99l6t0Mozf98oGeH9xsn4YjBj9hE71yP4i0YUQKKC8hjb?=
 =?iso-8859-1?Q?BjB+xygUnZrlxGep/F9lyUQ3Uv8weiCZDzein+hVrYA83JyAZljpa6xV+S?=
 =?iso-8859-1?Q?G4z4UhuMkHigzd45qHEM08guTGG9p8kJNLh4foq+7QpmvxCo7hedAoE4+O?=
 =?iso-8859-1?Q?yTGh+mwU07TNsq9xSH+3YPdWpMAL+1tsMGRrgDHfyU6fKSV91C8ojfTQup?=
 =?iso-8859-1?Q?qic4k5AgitYfWMknCQhzIhp7+X4VPArfhJFw3maVBkOqi6wLjAF3Aoy1I8?=
 =?iso-8859-1?Q?37cBgAxNl/cir7pjPp8CKblG4Kwft/9IckWPN4xWlxV1x16AIE82YwgaHU?=
 =?iso-8859-1?Q?tos+Dp+MFnZiMYvmID23p9b/uR7mFFp6hBwUePP1ha7lt5uPht4BySVdR2?=
 =?iso-8859-1?Q?qs2w0N0iCEXaQMOVF476+TWjPcfM/CEyO+I6RYn/6qFPhtWVQ+WstkKgXz?=
 =?iso-8859-1?Q?oDPZATyEGi3UjZS5tAgAVIDIZm49XdVcufDvyrG2u9eM3CL8X+N/T4b8xl?=
 =?iso-8859-1?Q?TU+CrruEcNRvL7ihfV6+WU5ek/ulaLT8aSw7M3Ctq0aSolpB5vAVdMTp9g?=
 =?iso-8859-1?Q?VXeWF6NqL8q9WJaZznaRWcTfEQzwui6+kcwIKShUNZTT/ZAUHtVxE5N+rK?=
 =?iso-8859-1?Q?xI5MMOQArtDr99Mj1N4XrkT2dFSWZ+XGj63SFDR+slYKcDqcR7ypCda8Wq?=
 =?iso-8859-1?Q?R+l6daCSaEaojLSxG2MKadnXJo85vA/n1GApqmsAFLotGms0h0zwZv/nnP?=
 =?iso-8859-1?Q?wMeWiMZUfZp2sf0C/nIhfkdpYY+Qh8E9byArAyP4+NVlECTz8GJSK1ZsbB?=
 =?iso-8859-1?Q?FUapdqCWKNTFAPQALY3Jn3S6zCmrRmRP/ycy4lcgo2e+1IvjMawEtSMO9O?=
 =?iso-8859-1?Q?ySgxTc4PaYFGFZDzgc4cn/UMQ22YLOQXm3ZagWpGcch0YVzCNatwcEE2wA?=
 =?iso-8859-1?Q?X4KN0kkgWIS1EhwgQpsasVWwEN4ahk1I5mYJk/81PbuyaRNVY5yWxQawCb?=
 =?iso-8859-1?Q?qeMVMwF44v7CgUkOWJ6I796qMPw/tyNzmrjJ/KFhPa8R059G4YWr9eSO16?=
 =?iso-8859-1?Q?5mTnDn10f0AVFaBnendot1kneaMeypOLP0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4435ec4-2714-474e-4357-08da59eebf43
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:45:17.3697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oybncnAw9WCoNQZjd93OGIsYInwxCK1MUMxDPBrJQkFgvc1HKYxG/heZYkrZ5Vuy8P0kJiB4HDyGfZDbY8kRZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5840
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
separately the 'thermal' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/thermal/fsl,scu-thermal.yaml     | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml b/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml
new file mode 100644
index 000000000000..50c462027aa6
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/fsl,scu-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Thermal bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+allOf:
+  - $ref: /schemas/thermal/thermal-sensor.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx8qxp-sc-thermal
+      - const: fsl,imx-sc-thermal
+
+  '#thermal-sensor-cells':
+    const: 1
+
+required:
+  - compatible
+  - '#thermal-sensor-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    thermal-sensor {
+        compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
+        #thermal-sensor-cells = <1>;
+    };
-- 
2.25.1

