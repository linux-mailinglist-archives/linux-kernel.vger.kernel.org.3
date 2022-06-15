Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F0C54C717
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355187AbiFOLDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348785AbiFOK72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:59:28 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70079.outbound.protection.outlook.com [40.107.7.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59EB51E6C;
        Wed, 15 Jun 2022 03:59:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RI29/d2xMkvksIrNUgXW8fR1mMYRzZxjitTXv9dgfr9trjcFaIVvS/ZzEArJ/LjZH+tpSodU6lFDJmRWOKRWPHL6Yv1XqfpV2e4ydi8EDATMK2fEOQk8vhmBFTHSAAHAI+BrHIssVX7Mt+n402fMC08ZUipCTRLzYmdfdTHzb47BITy0YM8NhvEdTkfNWUWJwo1N+4hhC/R/EsOhe0nsr9yW0AvzRB9HkyZySnODtfcysVWTTThur83umtX9UnUvbgh6CG03709ZFPQVaz6+cwQsp0BD93/lv/ABjWvOuFKw0TrT98qwQ8L891rN81SftWlG76C1oj24te9UvqRIVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5wUbaAZdJFlpGZaetcp4JEeTlgz0rwU5d7fK0zE0J0=;
 b=dGa7ZdtUrE8gXguH7HeruN7wEIP1wI9RfgYlX07soN+EQE6yDtuDb0aRvKAcFiING36yJYKRfPgz1sVRWQH/r7IFabmDJ7DtzDJ6i0TlZWbAUhokRaiN4UNsjiOyy/i8jb4Gm/5/w1IkkVPP5lBs12hE0bSID3Iu2ELfuXv3sQbL++KjvRrguxSP+7KKPmtx60pc4dXBH2+uxVSonO7GI8Q1Ye3fBTpDDr8t2vvs4aKjMeHCODPmoAng0HbSE7klYLZtq2KM3iE/s2IhpJobniU3VhOuI6F4xrgYKv6p0S1wNIRRc1FkeUru/0KmqR662al32AIt7aNYU4W3pEFoGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5wUbaAZdJFlpGZaetcp4JEeTlgz0rwU5d7fK0zE0J0=;
 b=f/NMqSE5tDJLjzYHgT26MPES4RopcqzqrKbz6JgJI9XDKshpGMLxZqMdV6MWGMR2KwEcY911zAoCK13blWvo8g9Szw5mlsMeGajPLXQDFgNAQvuKRxcRO9wUyPBo472jA1OYVU+DBp8gAOZUwMMQ7v0iOm0yjsChtUMm9icUQC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR0402MB3939.eurprd04.prod.outlook.com (2603:10a6:208:11::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.23; Wed, 15 Jun
 2022 10:59:24 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 10:59:24 +0000
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
        Abel Vesa <abel.vesa@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Peng Fan <peng.fan@nxp.com>, Shijie Qin <shijie.qin@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     LnxNXP@nxp.com
Subject: [PATCH v4 03/14] dt-bindings: pinctrl: imx: Add fsl,scu-iomux yaml file
Date:   Wed, 15 Jun 2022 13:58:23 +0300
Message-Id: <20220615105834.743045-4-viorel.suman@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615105834.743045-1-viorel.suman@nxp.com>
References: <20220615105834.743045-1-viorel.suman@nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0159.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::26) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cace893-3318-4e0b-2c51-08da4ebe1b88
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3939:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <AM0PR0402MB393901AA58C20924212AA66392AD9@AM0PR0402MB3939.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UILSb8VIkv1EPBOiTprCbvoUhZfwb2t7mVLdQoH+x+EdvwexAJh7lRJvxioMAlQizG/a+UoQodYCdD9nYjbuOT1pwlsFJf+Z96QQmbNYJYZ1DX9b875HMDpWoYwcbwjUZ70UoNg5UqtoWMh+YlbaZ4CRXKIVEyA1Bb0/FH5RC51wCPaF4Tvu4LXoK/OLOjE6I+E9Ig2suLEPXocShziMmseVw7o11pIesz8FL1TlnBCI/wB4nFj+nZCxsTF6EVfEe3uKbS+vGP2qBck+H0Og7EY9Rs5zcoNKr75tdCGljIFyKHBdR2q/W4dK4oxNYVf08U7lEBvMOmoRNHZyh3Os3J+QqrGEwq3OT7wgM7UYpaqthL8ir5wecAiaZAy/8zf/psirHF5TLUqHOQlLPQfYplWPUI4a32IiTUxUfEGPPqeSG8IlMTLACx4sjldipmsLvGaM0Q1OhdI1wzqosL03JUgbn2mxfNYEFsw3Y1lAv91aL80FhV3yNlS3ViU+6qaC9b5c2pnPVBIS5jDelvDJd+N3/GeHGm5hO6MgdfjmJXeXrg1kLwPXC+zRnSRSTwnox1FF9rr/pkspFj4mL58Pm9EZ/pGrTpzVYt74tQME4HlSms6mINZtttz8Z/W3cU28R1T8JmnS1hPl8URkkg0Exew2M7HBT/aR5cPAZ/M2iuTPLnXUip2k/7XtuJGhXPVijmFDUIvka7Y3XlsU5bkOGv0AsA4DiMV+N0qsgYVfwsEGRavnD2+RQqpr90/ThwHkWTFYk9ZHg/1I0FZ2T5hD0He3iGd/VRHoy4AZ8pElD5R9gngGYOGnRtyENtXGHo6wNHHaD7FddKo6x4vr2t1vHnIdvkmVEa8dADnc/BVtVBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(4326008)(66556008)(66476007)(66946007)(8676002)(316002)(1076003)(2616005)(8936002)(26005)(6486002)(38100700002)(966005)(6512007)(508600001)(38350700002)(6506007)(52116002)(86362001)(5660300002)(83380400001)(110136005)(921005)(2906002)(7406005)(7416002)(186003)(44832011)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ovfqj4RXL6R++FwpzSXun1ifGdLlWVzXZ7EC6TgLVL0Estlu3NJhL7uMur?=
 =?iso-8859-1?Q?iatI7iUEMOuCKdWMjQahdkV76D9YJbaolH5A5bKmkFDqePbUnIooqdJgUT?=
 =?iso-8859-1?Q?dkO69Iu0sVXhkM305zGGeWwUwQASQiqmyf70g+UBSKtTE3HGs/3YjuW0rl?=
 =?iso-8859-1?Q?E1ZiArtlhA6aVaWkPO+cmBXwI+Bn/t4X1bA9Nw5gYrXjNyCoiD6uGcnKWd?=
 =?iso-8859-1?Q?6ltwQ1mBb4xd/HTmzTPatUgS4cJdC3JI4SChBvNCnIG6cQ3t8QyVnnZ1X7?=
 =?iso-8859-1?Q?JnQaiH7d5gholdtt180oXgXXVoRhorQkOSTGrUkRoNmdj1rflhs/p/3N9q?=
 =?iso-8859-1?Q?jJWvmmrWTDo5DkeWV8q0C84PIZUAJxlbfP6u8SgBHzyvFBEXrNPop1VV+5?=
 =?iso-8859-1?Q?tskdnJyS+LQGNpGX5U8u1yLIX+brGycqa7W4/RaoaMTS3/gXzlWi2aO+T0?=
 =?iso-8859-1?Q?IcceDbUsUzkgzDDZQXO9QZUgQxoal1o4P9fDHavu7Z5c0X1hJANPhmjzh0?=
 =?iso-8859-1?Q?QMOupUEBEHqDX3EphWIZiCY8+UGQ28D/aNFliOjHIsenRt9fDiMpZQjITG?=
 =?iso-8859-1?Q?RlQuAAAwtnH4dbZQ1IWMDnKYXx9LpOwkZsObg4A2YB5fbNpk3x45xsyOHf?=
 =?iso-8859-1?Q?o9DEpVFM8sbzz+SfvlIZkmsS1wt/lMShb1LUy+69H1oCnO0uo+sJSQovhQ?=
 =?iso-8859-1?Q?DtAaReCq8P5SrH973JLyqRpBGVflDXI6jM4SESE1ip/1CUygMzAzc1dVtR?=
 =?iso-8859-1?Q?HrWvMsE7pxOXJFH1LioL/nALzy1H/DroC8UGcPAP8qxUbvVtSyV8uKh9rD?=
 =?iso-8859-1?Q?xq3SLXP0WkUOYu9DXD5FVtbmAFohV4fu1QbWVAeVYq/D3UkU369QdWOC7f?=
 =?iso-8859-1?Q?RelF7/IYnMWjL0ozkGFEeqGTTVYoI1NJd6JEBIVTuRTXKwvzn58JfoAcS7?=
 =?iso-8859-1?Q?t0jUIC+HUTqDYWZYNxGCDSE7PSXlpGbR8yFjXJouxgKJ1TRu3VsThk3Pk4?=
 =?iso-8859-1?Q?r18EqMHh8TTGMpPilD5HK5lKV+km9uUxRf2IR+aWIsEjR72Whtnr5F1APh?=
 =?iso-8859-1?Q?xDOjYTK4zOlrqjARPjlxueWatBpALzv39Hk9NEMatctmQpmjUvKKnhAQSS?=
 =?iso-8859-1?Q?MnflArhxxA53TOTvp+4irj3E7r927Sjd496X4ETe8/bfeMsYqZPEphSkIk?=
 =?iso-8859-1?Q?fjVIEeshDfd6fjwgaYmfQjQTzGJUjDg9Awv/DEOb6FjkY+1HdXFsSrPgKc?=
 =?iso-8859-1?Q?EuishZgVq88N+nNGfryYrn5UotRgzSyycIf2piOfLY0Y/3P6X4L8MNcnna?=
 =?iso-8859-1?Q?rK1sccXaC0hkqsLsyt4IMb08siVxE8ej6RJxBuXZnUWdG+J2DrCmEveuHq?=
 =?iso-8859-1?Q?FpV1Jd8xS1w4obRehJWawUCnZ2Ctyh17CMFZQ0dZS/lrPAppMYhrR1SZjs?=
 =?iso-8859-1?Q?H+j5mvE5f3irzt4j4q0WppvuG51opMTzCMH87heKih7FAqFC5GEmg+aje8?=
 =?iso-8859-1?Q?dtgIUDbUBfQymlto5527NDqxTQ+/fdmXtFj3Z60uMErMtGJpL0+IpPrLtF?=
 =?iso-8859-1?Q?ZufMSmeThNzib168WKGLUtto+1HpOaFtIfTgagJ3VO5oJPOIpHycdrFQao?=
 =?iso-8859-1?Q?4/f4F83W2Hr2IvRcZVyef/ZB5VKjxAHvQRFko6xYIqueHdEq4428Zt2AT0?=
 =?iso-8859-1?Q?LODTx9NEaS3bgWBB4cF1/lXDwBOZcQ8TYOhejc1LDjeQP2bsNqqeyklL00?=
 =?iso-8859-1?Q?19b0W8pjNl0AReuK+BIitueZDsrKl2ZOaN07GqaVFph84p9RyqC5K7870Q?=
 =?iso-8859-1?Q?x/ALEQDTJw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cace893-3318-4e0b-2c51-08da4ebe1b88
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 10:59:24.1039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiW/cdS2ltvmU5mupTFqqdwIP+YFUtLKYrB5ljAnAzKN9hkd/3pPt33mrJlwPxlahLkCmBHOwdUixFeN+7ZGDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3939
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
separately the 'iomux/pinctrl' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/pinctrl/fsl,scu-pinctrl.yaml     | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
new file mode 100644
index 000000000000..7a08c60da66f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
@@ -0,0 +1,47 @@
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
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx8qm-iomuxc
+          - fsl,imx8qxp-iomuxc
+          - fsl,imx8dxl-iomuxc
+
+patternProperties:
+  "grp$":
+    type: object
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/pinctrl/pads-imx8qxp.h>
+
+    pinctrl {
+             compatible = "fsl,imx8qxp-iomuxc";
+
+             pinctrl_lpuart0: lpuart0grp {
+                    fsl,pins = <
+                            IMX8QXP_UART0_RX_ADMA_UART0_RX   0x06000020
+                            IMX8QXP_UART0_TX_ADMA_UART0_TX   0x06000020
+                    >;
+             };
+    };
-- 
2.25.1

