Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE2554E7AC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377953AbiFPQo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377149AbiFPQoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:44:12 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30040.outbound.protection.outlook.com [40.107.3.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE578289A6;
        Thu, 16 Jun 2022 09:44:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAlwB+BwfsR94wPuto4nDbdXLvJYRTZMWvMSgX5J+cdg61YQfoRJiZXQQtzxVti5insFLpg29UKzxVfclE04V3fx51KKlPIbma9E8iv6bncndzaWSNNbojMsN5Dpq/F4Xp86CrLtzuI2DA2SGhKhbigcio/2uOYSBY9/HKHv1miCla/jgKFAPUVUiunSEN7n2ij3VhD9kevFK22ynJPU4Pohs0P7sFixuMfsSmgAZAVIq2n1pstpgaSuHMfQ4EtDxyYNPbvFp8Jby/c32s9K08Lwb+59/RWwfzt7uhp3a8+snUmsvQ98lWwZgu3YrRLgOTLbcCS5RDkMzXZCjfnM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3T6PGykkr0EN1epJe4PHAp2+NCMB8Im8icnjXlm7uuI=;
 b=XzlZmpPSLRQLwdAdX502S307DCZMeknvt10kJ70yn35Q+oF8NBZLEJmOuc/ax+FY3UPXF8RDgHuw6fdxmzNVhl/5V4ddBN2aHkcF8F8k1/jWOtYFxLz0cjX+Bhsg1juD/vbJXNnSl4rQL4RoAlHNU6j37Jhen6grI+B6j+h+AmXjvHnCNzXrIsdACutqeltT0cQGN72NaR21SjXJ9UmRRjcwVF8f9/5AQbHVYfXP8va4ZwggpLHRrDn4TGxLvqsQaAxn7GvH/1/oBhQBmzy7993qI2iB4eXgKwb/orre6SblbPHgbmA+pBcS8AQQPBmIcKhYtJGTefRnomAsLjFMTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3T6PGykkr0EN1epJe4PHAp2+NCMB8Im8icnjXlm7uuI=;
 b=nxgm/TPZIhizh+i/AVd+XZqyj9l4za3omYJLOdjku8/QMgNzFDhZlzcB22I7fRpGNTOaLCVskLOOm53V1FrxUQS7orGB7rOxFopxrIhFvaDwtaqmMQkbgyLT1mkUT2++dgU7qUhPlwISVHy5T33MCddoser99eJqO4fLHp7CCNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by HE1PR0401MB2649.eurprd04.prod.outlook.com (2603:10a6:3:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Thu, 16 Jun
 2022 16:44:03 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 16:44:03 +0000
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
Subject: [PATCH v5 06/14] dt-bindings: power: Add fsl,scu-pd yaml file
Date:   Thu, 16 Jun 2022 19:42:55 +0300
Message-Id: <20220616164303.790379-7-viorel.suman@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9e021d97-701e-4747-5d73-08da4fb76b6f
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2649:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2649DD825EA378A0F650470092AC9@HE1PR0401MB2649.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A41yLLaUAZ+vl6JmOoymR8FRWDqWldYMrZv/l3cxFij/2hsbWCdsF7YyIPDobLNr+ja4PkjpNxc0D5KBMcliO8kxNv9CX6kIrAbKCpuHtLUQnu6fqoTy+0ZO2LUlTkmMvbx7Y5/ba8p2sB34euAp6X3YT8eVNR/MYbHYdWj+SQtLn9+/ys/LYhiebnK+eKDTPfYXrKA7aiLlU2WUqW6HhZVmBzU4WBHCIGTIakiSBA91xbTWQxvMM1ru5UVRBkZfZvLGMVuxc2gLozDURvPemvoZtW0Y44MUFp79YAg9zRUSAvzaY4GgZJFK8DIzAND8sHPA0YjngSE1jwFOA1A658UsXlDoy+jyActVawUZtzs6dU3UdDqWSvEoXdQOx9uPlDU40IVRUzAZVuRALU7UJOkQ4z3276aGKyMibhBOmz9q4tJIPNTpCTngMylLRNr/ML9HxDuE/H1XxajV/Hm0UpLhy81HJv4aaImat0qrbSod1L7rtDteDaZelNS4MZDBLFLLBz5IZBIPASEZHncWGHJqn4T5uZK7j2DkCzLTb88LwNojRlL36cSLLTZ9kTjHT53SGKlwP17LJ4XulD2PCXhoBbNxk1V5ybURKjzPF6Kdturvm9iU6fL8U3YCEs/AzNgkepNdckCscSxIboKt+TYZxmcnIVsINm6S5LXI+bhbB82+TkTl7pksoOJuadNzNxLieXEorJawa+t1B7hrm7BDKiKav/ZIFDkR7ZVrDdymFkeGcgiwyCUkplA40cm0l2p3yv8Ly0MpvOrTHnboG27XchNfPJF9CP5eTffCBwXBAG7m4UnJmqHQs/HOZVQVB38FvWVgtxAn8ef3tYf4dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(86362001)(186003)(38100700002)(6666004)(5660300002)(2616005)(26005)(7416002)(6512007)(66556008)(7406005)(2906002)(83380400001)(66946007)(38350700002)(316002)(110136005)(52116002)(6506007)(8676002)(508600001)(44832011)(4326008)(966005)(36756003)(6486002)(66476007)(8936002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?/GP40tAls+LlIqxZ42terLuhLJHXgxTstc2G2iF7qHmg8jigIwZTSk84OA?=
 =?iso-8859-1?Q?DVnai7YgBu7RB9OkKqYIgc82OG30StvccL2mfZmBVi2k0TI+ka3ucMbwRw?=
 =?iso-8859-1?Q?iG0BfgJZRXh7HCjCxx3ARgcuGnsJMwB10z20fHLMd4tVspy3buJkG9QzH5?=
 =?iso-8859-1?Q?KFxk6lvyAp2JpwhRJtn/7Zz33zju8LQDSTP9qwJSDZAp7B9Dnpr/971kwe?=
 =?iso-8859-1?Q?cm+O/UrfpXKI53yJRMboQWr0m0gdmTNqtEoCVHbKAdqtyvi6HZPIy0RvCJ?=
 =?iso-8859-1?Q?IDJs8ZYj8yKCLh1xMruEmLJxhfWHvz+zu3ajznCJZz62a+p9/wqgVnBwWg?=
 =?iso-8859-1?Q?oXYq9NjopwaE+O/+yu/gdiBRgcyoxiYar6RhrJF8w1E1fOwm1M5X9sKFo8?=
 =?iso-8859-1?Q?NGBmbFjcV6vCtFF8S9t1/p31bp6UUXkOOZzFTETZ/ziayQcfxBwevAn1oB?=
 =?iso-8859-1?Q?EAQeqxneBoRLyJrPUx07R9ZwrSrT9W2bjwGP9g0KeEwxvD00stPa/W0jBA?=
 =?iso-8859-1?Q?lrI2xQPlXREHpbrlJW4eRssy6VVy7n28iXfuMXdZxagS3pn0PPAcGFnM1X?=
 =?iso-8859-1?Q?Jc9Hvd3O4vD/QJsQQbNleMtpLIINK+sfnAnUM6kRfz/hx4Q7BTAZU1NDf+?=
 =?iso-8859-1?Q?tq9xnL4jBQO0G1yBPXDjpdab8yr2xU0vOckt/ffdLdahBF6rYFTD16vIw9?=
 =?iso-8859-1?Q?/QMuDnGzwcCHEBSYXCFX6VMD5qI5HSuqW62YWxI5jT7/FIQMgFge9tcd8J?=
 =?iso-8859-1?Q?8Ej/Kri41k0bVcyctzdUf8NiqX0abhDrh+BbNbrGZEVBIF+9YPwo3Ky5PT?=
 =?iso-8859-1?Q?rVXnuW63D5olYruAaqtWPAOoUbOCK9uF8M2El5vsUfdix9mEjkqIOrBgKJ?=
 =?iso-8859-1?Q?fOvso9l3UyMyL3fa5K9QuncJcihqFbo9W60iYqu5uTcrHaZW9MdQei0NMI?=
 =?iso-8859-1?Q?xCqDcFWLS968auvThihothIxeIFBm2boAIRJ7/9ntKOMOgzoNMs/62/uG3?=
 =?iso-8859-1?Q?wR7IIKSVbGtFaeDMSwQzOcIJpvrIcBtCxePVupXw+3Xy5Abu0w4MiP5wiJ?=
 =?iso-8859-1?Q?iy1EOWsAzU5KuvKMiHCPfSBQZCV0GB7f64ACbJPXwa/qMteASP7YFT3OMZ?=
 =?iso-8859-1?Q?qmFGErB2wQH4Kwa2fyXAxHHqCJcFwgnxhqJU3BgeCWlWerd3LBSDOc8gk+?=
 =?iso-8859-1?Q?PfHyVederL4Ug7pdw6x37QueL89g0mXHvCeBnrHG/J2hZP50UPmowNLJMk?=
 =?iso-8859-1?Q?soi75LHGLhGGEzbwV2Zwk1sr+SpgEpYpbH0Vidp8G/rwpSUERE3ciXV1lH?=
 =?iso-8859-1?Q?1hCt/ULEXrrgVp1Mk+L8QtYdFRI/enle8bq+UX7DSYuIBhwKVTEud/ESx3?=
 =?iso-8859-1?Q?B8HUbynTgtkgDPNGQoDq8pGXDj9TPj0H0+NIwigseVEKh8MWODDXLHZ/U2?=
 =?iso-8859-1?Q?wFljmaFqh+oOshSf90q/2iolMOpQNlZbcx3HZcShzttqXNAUt/Qfse7usY?=
 =?iso-8859-1?Q?OORmBrcyFdEGHGTgRoGJ965WmgnBPeZzAsKa8GabAEi16ix0zhLpmP7wAe?=
 =?iso-8859-1?Q?uoJb7kOe0KkDWLyozTQdyUVTkOMpVR2PgyZJ1rafRKf6tQ2Jdja5qMTN1U?=
 =?iso-8859-1?Q?zbqDEb2WZiGnElLADCh5R/q7zygointXJVkpHnfHIGEWco7QIMds6wWsW4?=
 =?iso-8859-1?Q?DKh9c1/ZWQAMrALjGS9AxX4jBpdFmt3tmuekK3jSg8OpKHxRvTik7Q/OTJ?=
 =?iso-8859-1?Q?H/BDDYAXkCqDKx5EBZoTePouaz0BChzsLZHZcLE2kzjsd2WJNzuUfai2oQ?=
 =?iso-8859-1?Q?p0y25QPXDQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e021d97-701e-4747-5d73-08da4fb76b6f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 16:44:02.7978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSmNjZvmDYDXSWHLiJobwuAfUyHBc1Jwmr8pt7MUrY6/KWaLJi/6NDjQ8y+HMfZQJjrhw5hA4u4dSLpUjNWzWg==
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
separately the 'power controller' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../devicetree/bindings/power/fsl,scu-pd.yaml | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,scu-pd.yaml

diff --git a/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
new file mode 100644
index 000000000000..9d3cb51d7b37
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
+  - $ref: /schemas/power/power-domain.yaml
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
+             compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
+             #power-domain-cells = <1>;
+    };
-- 
2.25.1

