Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9EB54C712
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348848AbiFOLCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348958AbiFOK7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:59:40 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C686B51E6C;
        Wed, 15 Jun 2022 03:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrbF8/TjYuguKLLOVLQtWfCJxcAW9TeM7oLju5j6j7hyA4jg8qTTlCtp4gGmCqO2mfb7DD3RPGCBpB1h9PMBGrCjACULCkmwLl2SNOTv+598pxneH/SmAmYAoyN/LgoE3TWL/dRATMLvxEF6afBKFUG7FMirL3H3my8alzyxYDzNShnYDEZ0HkCJYpyboKZ9aCH7+g5FITjhVsCa9Mf2xyfUZFAw1L5FPDEpSN1hEPGGYHMGb7CZPU7v3xUnr9xc/yMGMbXH8xtDTf95VeASbouk8v0WUHRluCWovizMTI7HZzCGdVr5XxVuKi+hhnfUNxo9M0vfz0DOSSZQEarFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5x/1RxaPX0UIG8HgVPFH956p0wIEXaxlqmAU5EfXBI=;
 b=WPLqzYfYoE+fXwWCUqIETP8ynDWieSlytO3W5aKUXsAgeyTFgWomlXPYLW4JtkTP+yJAZBUc23Vd1OdML8fVIKNOaJZvZ0tujrN8TpVj53ZeHkidG2sviZKw2k7Fi3MacAjg2Qz75GoPwhlXH9phokCn25Uc8wNJjoPegbUofhsxLiRZKkLi5mB5pZPO4UXNE2TUhODPFbYGlWHGU9ap1nDYLHUtzKBNHXi6eblomZITtw5CzpEb4HwwSwWW6ZLFMs93yDxj3BomEjMZHO+gQiuE7ONvZ1MpqRi7WLnHTtBUD1RZ1MjQVdp4iWpBNxTkLh1ZkoiwM9ekkSPtPfbffw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5x/1RxaPX0UIG8HgVPFH956p0wIEXaxlqmAU5EfXBI=;
 b=Xah9U4VK/NwuGhKKtqaHJini/irZoNbD4v/47wh8nl5275iPr966c2p3Ytb5bu5P6WOJHtPYQUxHF2IzhfZUG1+E1dwaLuj6RpPjIacCr5RpoL7isXLQCvl1NA/3aJ3rE9ZWmbH+Kjv3JDgv9q1gUJO5xi+el37hTwvCXL91nTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB3PR0402MB3948.eurprd04.prod.outlook.com (2603:10a6:8:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Wed, 15 Jun
 2022 10:59:36 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 10:59:36 +0000
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
Subject: [PATCH v4 07/14] dt-bindings: rtc: Add fsl,scu-rtc yaml file
Date:   Wed, 15 Jun 2022 13:58:27 +0300
Message-Id: <20220615105834.743045-8-viorel.suman@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5ca86ccd-dc58-478b-8d6d-08da4ebe22c4
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3948:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <DB3PR0402MB39483530714951BB32443A0192AD9@DB3PR0402MB3948.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TPYP1xzzdtpkgX47fJZOFL9sRfkUnGv3+ecSAAL6Y0mCsFNsnmHe4vHruWEXUOG2Lh8HHITGH2PzF8FjWw1i4oEET8sAMfmgVelhBrLpthggaXT23EBapVbIqN4vtFNyG4qZI/VVX2q6y6sHqfs7nZTMpf+wbRr//LvftQiYSF5BXQwzIN5AZmgZO3a5AZhZBhk+K5O//xCSdq1rxJV9nL6HSYVMjfJEa8y964QNM1UR0d225ftwUylSNHRoDCZcW3znOTNcljhlBVIKKDi1/0ZvnPpvxMU9n6/cyqGOKg6OjgyUw2i/d2rT6ZmtC4wyhRlh3GlyU4y/+PVXaFDgo93m4zHU62Ke3iIf2wHCIP3XsHF3qY5Tqi5UVUaGmhUfCef2iL6w8adrKfuj7r+gpIV0N0h1pCqXNeWublPoJS5XNjVNeIWzWeiBZu7hixhfREYkzzHR/ZZ8YANn8hMWN6OgeEpfjgJEy7j+6Tj7lkXV2Duwf589EuI4if/Ssytvy+S7fD/Jo5QcD+cCE3nERFM45zkzeXgXNzXU4/PGJHh/4z060YVGYkawLRjSU3A2r3T7Wyvkfw8nQGB8rxZ1GK9CQyJ6XQLYpJm3dHNG2VwRimPIjz5dL9fV5LiHCyQUVmjds9h4g614SXaT3sgfc2mH7aXLNmiNSVaVMRO4bn7JEDOhmBOXNlIqU9lwzGG4UOfcwV1qMkjPZcdfNglLBanN8THfcbQpMh91qxrNciTCZx5XPEMvajUD5zzLpg6iDiRXvehKoX+F9tWlVyp+MUYCg+QpLH4NX6WiDb4rH9KHBNDvvcWTzcdaRnpr+/8ZCFOLCCD6crG81a+LUKzgz4vaRzlk++CTdulvfpupEZA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(26005)(52116002)(6512007)(44832011)(7416002)(2616005)(4326008)(6486002)(6666004)(508600001)(186003)(83380400001)(1076003)(8676002)(966005)(6506007)(7406005)(2906002)(38100700002)(38350700002)(66476007)(316002)(66556008)(86362001)(36756003)(66946007)(921005)(8936002)(110136005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zds5FyvZDs6DZ3I41yxCs1Vc1AIE8Yso85jmCJiSYUyzBpxyLB+cqNDkNS?=
 =?iso-8859-1?Q?chI6Z68YKzCzem5f/u3AmoUXzD7CWILLh+Vr+fLlIWmECxI2x26o9X6HQE?=
 =?iso-8859-1?Q?8++phzBIb0TPULCH8mhTQiayY8w7Dh5ijHQUsHcOFT+cEJ4R77iqZsJsIM?=
 =?iso-8859-1?Q?GLqTP1o2EW9Tx0GWICwAK2jYfj3IWNb81b+RoQdPcyIpXch2JebHgkdBMd?=
 =?iso-8859-1?Q?k379+WUqzzv7ZWblY3bKuRtDKH5szBVuYaAF4mbxoyvtFqTSAENEs4Q/8U?=
 =?iso-8859-1?Q?NJaYvuNfG1u7rpZm7PZuyF2lTjZSKng8Jf/Ljmw2FeA65/5jpRZngpyMKu?=
 =?iso-8859-1?Q?a35N9K4ZjXcC94TY+XBuu621LwKUMjeJKDX3UHe2GexkmUDVMuwSSwAgbi?=
 =?iso-8859-1?Q?23rltW2vT/qqfwTVE/HwKxN4u+L9B1srCePamJHt5OBNjop/zgK4b3pAxi?=
 =?iso-8859-1?Q?U/87IiQC/SZnvRB88cjR7aMPrJ9IMeb1xvQO3yFzqKfvf2+AtuT7GiTTnt?=
 =?iso-8859-1?Q?Y+XNXtSuofGvh8MQC/HQd95dHyuLdrznoWumNAHjhEnKnKi1akPns64Lgw?=
 =?iso-8859-1?Q?vMtceiJb7R7oUj6lvtbNVyC4pD43aF0wRx8n/HRTuvKMWLWZW9VUd+4xD0?=
 =?iso-8859-1?Q?VC3kWBnZCgTk7vKPzh4S5gxevcuDlEniclINUgAedpuf66xACli3U1uNuA?=
 =?iso-8859-1?Q?Cq6klra7rEDypawfcaQcfY2SQE53jRvy4fqF4JU7N4tQxbB+YcVAYejAHv?=
 =?iso-8859-1?Q?+WhmpSkaAnS3S1NknojveDxDyzF+xqdlJyPcCZG+8BC6NEkdoBdGUy+WiQ?=
 =?iso-8859-1?Q?9lFHw2KuKeUI9hp8NG205CRMs3QZ222Iktr79iqGE2Qt1P4jW1t0XaIw7F?=
 =?iso-8859-1?Q?U4yMtJ7vg0MfB32v6iloIDHPgD9orPqDnOh98jkNWxd0UYbjb2dWKp+Kzp?=
 =?iso-8859-1?Q?5MscwNiA8pxYcvZqgRQueJlh32kMSXVgMQdVT76BePX+oE9S4YVoSFQqxT?=
 =?iso-8859-1?Q?tBoC3Negqo+HafVVwVCU6C+q64ce5tx8Af/oS62D3O6GZ80WiLO/kxwE0h?=
 =?iso-8859-1?Q?UKPRlwPbvpOsIclEkmsn5WjPTwaJtx6aT9K+arVFP7k81pQBLBueGuS6Zs?=
 =?iso-8859-1?Q?7vFaLMsb11GpNP8surWgSVzbwKraqaltZYgY7eT6h2J1QjZqKRPPApwp42?=
 =?iso-8859-1?Q?ifnx/6M5u/SmdpB15dOLyQuIndj4/zrsGk6cX1THbms/xP1+gddr/5S/Je?=
 =?iso-8859-1?Q?w2qJNi77XqyI7C9hOro3NNEy1cUYdE3ISZwUTAF1zDEb+ECBGE9JuZyuTo?=
 =?iso-8859-1?Q?z2T5u4KD7fzuueLQQVvrynWRUR8XOeXx4cjAteKKkgVIV4WvGPW1LzWQaZ?=
 =?iso-8859-1?Q?58tam1qaOdIItYduIpq7JJszi43UJG1PN04pKeDR+1Jh9o2jrssM31/w/4?=
 =?iso-8859-1?Q?p53KB45ZOfH+srNK/Ng9MfJ056UITremgdFHDcn0+drfQ7uZ/RTD6GxlAG?=
 =?iso-8859-1?Q?HLYPP50hwHqNRSoBY3eFMvBobMaDVvjJz38PTl8vjtTM8sN9wITDJseL4S?=
 =?iso-8859-1?Q?EBpAt9yzTKjsaPNTbANIhHjES/qZJboT299QPQ8eQX9J/jHA/f2JkBeOTZ?=
 =?iso-8859-1?Q?bor60bmWDGk++lWz3QeoEDe4u5Vo5EZFw44R2RNo9eBr2Xxti0PG3I2AKr?=
 =?iso-8859-1?Q?hgL0px5zGDFcafCSbWOkmZTDxip5tVkvDt4at1CQIxOTsOexfycQ1yrdpA?=
 =?iso-8859-1?Q?HTvTX5Lcj8dzplQQGbxpwc1HyoyptImT9Sz1tkfDWEWGMErodVs9TlLja+?=
 =?iso-8859-1?Q?fkzP0rSOrQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca86ccd-dc58-478b-8d6d-08da4ebe22c4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 10:59:36.2124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYJXhRay2VR9xdrSSROC9vGlXJg2eNgM/I8NDrz9PoRqLvRMoxwOQftFQqPDKN3bVNpP7cRbprALgfaYOf/6rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3948
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
separately the 'rtc' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../devicetree/bindings/rtc/fsl,scu-rtc.yaml  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
new file mode 100644
index 000000000000..a2594fdd486f
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/fsl,scu-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - RTC bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+properties:
+  compatible:
+    const: fsl,imx8qxp-sc-rtc
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    rtc {
+             compatible = "fsl,imx8qxp-sc-rtc";
+    };
-- 
2.25.1

