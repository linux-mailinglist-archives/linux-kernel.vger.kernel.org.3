Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AEE54E790
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239379AbiFPQon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238978AbiFPQoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:44:03 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2087.outbound.protection.outlook.com [40.107.22.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4479286CF;
        Thu, 16 Jun 2022 09:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIgrURcCob+7lKSKzyLThETeWFpe7xFv5ZeAdPLPF1YjIF4citfBjslQltRqmJN2Ig2peQAlByUY+ccs2osoAB3cEE8PZp91iN7xNZttvxlQeJms7yJaUCPSvo5J/6Zkt37FojDFQgRLe0p8qnyxRb8nOQzWpxVb1UadsLBYs8vNtuFFtW619eEMkajwhp0x7W2KnNlKDFNgUWK7RsSNSw+8X0pyIUF2jnUfCdDeA4UFzCrt5SWDf6uIibPyxNmEc0j4al5dGveDaj0vw9Vb/HIemRDJVeJK5QdKp4iFp1/KgNbyxXLjnbN06HCQxYGGOJ/KU1STnymK2DqD6ewm3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ga6YTzEhicQSaD2Q/12AVwYi2lKVZk8yry12MyVEVN8=;
 b=cdQeKGQk1jXKLFGvt96M2bt4aecB7ID+6JtfWK68IYWg26Et3hCSONvLNREZTUgC7HEcq4R19hXkRET5C5kLaHuRRLrzp5uaK4E0ceJQmU2dmRIZbHM7RtXUAe2EBw14WIfAqWQ9OaoweQKOGiNDx7d1QprXjsfB9uFASKWSyb4R7f1LZqdrgvD/AqfF+Fd02fFQJUIszhtMm29ClL5xBZuPnFAmoJS1d9NuRlD8EQfV5R2WN0gHYrJ8h4WNpP7fq9FZxvM4LHmStirFGxAurCHsOLIvxd/AvAOWdlVP3PQBQ1s49FJDclxdGKcxp+kP9ChvxN4qj3f3VSdUSRw3HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ga6YTzEhicQSaD2Q/12AVwYi2lKVZk8yry12MyVEVN8=;
 b=pVacQEtb9TU/3hTr05voykiZkTNx2dpykzD0S9UO68TxJ67filNEwNYa/QzPEKSlfg8KcToJKG/vJzyKzpU6pq4NsG3ubjyPT497zrQkmQI/Gy63FlVdEYa2HjwLiTsIXf4RIeQU28Oqqphr1b9UVV1utWBhQpkMnVpJBwYhFZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by HE1PR0401MB2649.eurprd04.prod.outlook.com (2603:10a6:3:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Thu, 16 Jun
 2022 16:44:00 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 16:44:00 +0000
From:   Viorel Suman <viorel.suman@nxp.com>
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
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v5 05/14] dt-bindings: nvmem: Add fsl,scu-ocotp yaml file
Date:   Thu, 16 Jun 2022 19:42:54 +0300
Message-Id: <20220616164303.790379-6-viorel.suman@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616164303.790379-1-viorel.suman@nxp.com>
References: <20220616164303.790379-1-viorel.suman@nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0029.eurprd04.prod.outlook.com
 (2603:10a6:208:122::42) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea222bcd-98fe-456c-dbc8-08da4fb769bf
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2649:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0401MB264911CFD60DF66E0DD12EB292AC9@HE1PR0401MB2649.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b2GSTFf2LmSTE8uvadaYciRYT8wbCMf88bNEA3FIXB1yAZT8ImuE1g3L3DdAdhR6DC8PTyQkSugNGMhyucQI7mXY5bCsbqCwugMxWMzpF5g6w+/swhwTGuIqmA0txxkzi6pKQuMxmws5z415yzBkoZsDN9KmuR7Hd/T92OyWpQPqGTWHIqNl/S4JvZk8//2y60JQyc7c4Ku2h7pDmhAfRfktfi7AlhULjXpIrc/E73+aBpS7Q07QgdZ2JvcM54fHGx4ZlT5bFDiEV+rzFN6NKHawkllGyxyyeMAXVlXyo1NNi36JJV62RruaJC6LOG+uBOV0V4Jtmx7uDnmPs+Df64ZTqn/qQA/aEA2FoAotAlausGoMokO46nMfFJKJebKxceTtGIZLQZX+E93VpzsOHiEmQLfCLMD+YqPqnErrrtuAJM8JVDyxsdAQwh5veTk74jzCN2UDgoIV3qUajMDDMJSEpdryAQUWF+Qsg9aKMbVwW7m//Vs97Q2sbAYCTQVY4LZU2+MsQzrRn58hRDsvZIu03F8XSqq4UJUOW6m2xt75PXLSft4f3YkhbGm0X8lI1KfjLnnu37r3CpU/y7p0FT8TDxtZrVy9fdD9rH6CXoUvWQ6Ids58koQyb7hUmjeNpDnNy9bL+chKE7NabebpmzjedY+Wq/J+1X0bAvwBgmEPlx/CWl20E15tPURgVmY5FL92BC1Aqmm+U8il80s5k2Guku23SO96SzF3J+9tpqSOhqxHKikYLnLOb+7JnqEvb3atEi3d8KxnW5/1I7BOk/3TIdxxBGuDOC7oDJ2D2HhyJipVqrdox9XxQqsvh1y3ZHCNPtUStHqBvCsfNfTcGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(86362001)(186003)(38100700002)(6666004)(5660300002)(2616005)(26005)(7416002)(6512007)(66556008)(7406005)(2906002)(83380400001)(66946007)(38350700002)(316002)(110136005)(52116002)(6506007)(8676002)(508600001)(44832011)(4326008)(966005)(36756003)(6486002)(66476007)(8936002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?loGNA9fjmQ38+fCarnhP1rUZXTcj3M91q5y6NUaq5MiOg8WDli28R7R+Og?=
 =?iso-8859-1?Q?jk6gjReuQtwZtsYQVSS0YAcXaQLRwQMhgDo1KmtXTfV6IrgrBvXaS3D31U?=
 =?iso-8859-1?Q?xC/fFKbaI18lp9vlhzUzaYSCtU6+dsQi7lpVawWvmNBzGNH9kdfMZILrbM?=
 =?iso-8859-1?Q?RIDmWY2ltTEsUq6423lm77SP/aqpUsg89kfXrPqr13MRkClopoWV0dc0He?=
 =?iso-8859-1?Q?NNGrLb1KszzeqRSZLfqN5ccar3HhJpCZDINvONdgja7Qd6HEgVg9hsdTq2?=
 =?iso-8859-1?Q?/sjZ7rTCT2/+quDILhCxQytiJG/mRFhlqdwg+rmfBg8ZOyTg3OsJEjULIB?=
 =?iso-8859-1?Q?mx/e4ZpRkxxxBsmlzbrpWW0STvuh36tegPNCe/I38BU6zYPHm5jfuwOb0p?=
 =?iso-8859-1?Q?Q7GtnZxZ+XUkKAP7P5CnFfm8ZlIvnJmUcDfC8jBqOKEjdPdzQFvo9Xl9za?=
 =?iso-8859-1?Q?U6ogTyRVoaJv3DclVj9Oh88CSO4PAHULoWOOtKA8gjkXMTj56GDmpGUlPX?=
 =?iso-8859-1?Q?0TOheeI9O9nOinV7HrhGiiPboHrrVxXpsztik+9YLciZA/5HvbMRfE5Usz?=
 =?iso-8859-1?Q?616anxHLS6lZ/aMQfns/kcRuUFSuNNa1FYSxsmIpQKWVG0TU8zcVzZvw6F?=
 =?iso-8859-1?Q?hVi1Ruk0bL4QI2c+rvR+YC+bhWeNSWznFYeX4gcyzH68JXN0WN+ESorbNI?=
 =?iso-8859-1?Q?MFebfPNpDPy8oMGml4iioNEh3u9KhoT2VP4Bzg8gWrZT92Laoq55YM9/e7?=
 =?iso-8859-1?Q?o5D/H2JH3nqY/To2s553Tsno4lMM4slxFj6R3yNaAdBaPuhhUJvAiJ6S93?=
 =?iso-8859-1?Q?zbjERFXQyFJmlu3k+FNTRE4pyNhpRBZO+ke1bZB+3U9blzKE2vrRVZIlA1?=
 =?iso-8859-1?Q?lTbuuRP4Z4m9sXjXp5ez+NLjZ70lA8lBshDGgp7W00keUAMLTcLLnWmWhT?=
 =?iso-8859-1?Q?sqN4/Hxu3sBfxYqlY29vbilkRmAu3EDJjk0BAZTpIbhkyEXYU5x0nY9R4W?=
 =?iso-8859-1?Q?eBf3D8zJt64dJZAyPyvSVQosIxqXof38nkDjoqPfJ6b5xXFbExGz8U8DRF?=
 =?iso-8859-1?Q?+il3Hiz0EJsZFCR+6RMBomxtkDVvYeSColuQLhPqOuMIbk73ZtTPQ/M1nm?=
 =?iso-8859-1?Q?pedl39tSMdOLBZCZbkZHd/ARIDXCl3rHe43p10Q9pAGnSAUDtUXmoiSB7a?=
 =?iso-8859-1?Q?9y1tjpA2YIpnyUOUHcWgJ5xrrcpBG00aTq9rTFCqSH4cINKzrdUVhMKnos?=
 =?iso-8859-1?Q?fSFVD5GAgP7Mk/1HMlbDur5WQMZMh3Guf/O5azCn1Owo4mkKbN8ww/C8qX?=
 =?iso-8859-1?Q?I4jWMqtC+j9oufnswa6eUL4Do4nG/obNrNvTFik6XgjHWZX8qH1UpdlJ5B?=
 =?iso-8859-1?Q?NrtMoRkGQP9j2DTOmkkiOndcEDXrLslUPFPG+9JN2M6gvmyO5jUnTg1eyl?=
 =?iso-8859-1?Q?+EIsle2O/Oa6WiglkgYpxjp2bAX/fr8VyXd5AvFbb9ixRqJHAyPq7N8D6f?=
 =?iso-8859-1?Q?hVNXfUmFDPjqzrUWU3hZ+2I7yNTxk1LcFfOekdUJ1Xyq8KPvhFvovfUB4y?=
 =?iso-8859-1?Q?/TZgGPDWvyyri3cRlj7+PVRGJray3dAUtuRQbhRMkCYdN6ZXOjVUn6QiCe?=
 =?iso-8859-1?Q?OfAY4TXOnPxmWuFmNIQRFY6d6n8MCMfudqxkNa82yVqUufl+XQNWT3Gjt0?=
 =?iso-8859-1?Q?MflvG9Ka8enpCr/Qa+fg7lJvS2mjU3VCeIh45kBNAVfoKM7sJJfcnZPxtU?=
 =?iso-8859-1?Q?vnfpJxZTZcMa6AEClvuKv5Pbx+r6iKU+7K58DwE7R+Q5issGyJJz8GUeyR?=
 =?iso-8859-1?Q?nH8RrSSBUw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea222bcd-98fe-456c-dbc8-08da4fb769bf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 16:43:59.9855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffal0XqWH/bIEYZkCyvRT8gfnHTs0s2IzVhpORbSMlv313KiDXMSPZeYRtsp3kC00kR73aX0mIWbd7G8m9Zmbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2649
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 .../bindings/nvmem/fsl,scu-ocotp.yaml         | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
new file mode 100644
index 000000000000..071171e55218
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
@@ -0,0 +1,49 @@
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
+properties:
+  compatible:
+    enum:
+      - fsl,imx8qm-scu-ocotp
+      - fsl,imx8qxp-scu-ocotp
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+patternProperties:
+  "^mac@[0-9a-f]*$":
+    type: object
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    imx8qx-ocotp {
+             compatible = "fsl,imx8qxp-scu-ocotp";
+             #address-cells = <1>;
+             #size-cells = <1>;
+
+             fec_mac0: mac@2c4 {
+                    reg = <0x2c4 6>;
+             };
+    };
-- 
2.25.1

