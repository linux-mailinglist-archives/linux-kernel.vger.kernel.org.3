Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7549560634
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiF2Qpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiF2Qpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:45:35 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7707838D8F;
        Wed, 29 Jun 2022 09:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfTFRnvAnZVzl0JK5qmyyjBg6Lzl2xXvKVP1k6W5Ti5FqlukWXjp5ranSxvHLoye/6y8ImExjcLwQ3qKPdRUpK5GO44k7ITrbnHG01rIhST1fEB77p5XmtuG41+ezzPNKjgUU94jNrW+bHoextXjLmKEepynYdtl/fgitVvrl9j0h+A9sl/DfZbCh9kwebr9YpoWxFjKmt4RziACdqPnIR2Mv9hF20qOec/4CfJzcFb2bbsFohsWWPtWB1kbdN/JJvWK4mOj6qf7IKvJg5I9TpKnMosQ4nxeyscRHXvnth4AzeAB7z28QkDSzIj0crYulHjMDHwdsXhKKk1Gf/Skkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LL59ZnDchDz7JDYQGwrlDxVHIAAO0P0ymT+T4x2uWdE=;
 b=HqCmL3sCSWEPTIHi9mPPv+hE5GGI4f7jeuf7WrcS3thAS8BQOV4L5pzpapGZE/l+whP+xD34+gZ/rnujd9tMGhV9Yks2kKgLZLEeDm1hY4RxUrnBTg5MPUsNxfB7VjcGKd3xwZ4pf0nFHxNQzpWjTfdiJGJ05nE3abv68FL4CDvDLGyB7MNyLObG0E6INbHYteF/oVmwMgzfXsGhw93S5l5wY2dnFP58p3Hma8iK1oo3KDFfIAyegPoevwohSarxTFfWLGrX0HP+NcXQpmIQrdsh26p5wYcyUqALldHro0GdcoxB0/U8L8KBk4pzt+WtdKn9Be/HA33YfzRp7pnX9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LL59ZnDchDz7JDYQGwrlDxVHIAAO0P0ymT+T4x2uWdE=;
 b=ju7kpJ+Da8RrwUFLGuSyqhtSfaHAlLaHSMgtC22K9OAMGdksWDPNTGz5IaXS5JSUAnEF4+hW46/z7BNSy7zm55PmlLNYHk5av98J9+/9M6qoajnYHUNIO5zWQw5nKg9RwSR1ZXUEMNncZT36H35/b6q1etttoByBw1Fj9HMTU4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by VI1PR04MB5840.eurprd04.prod.outlook.com (2603:10a6:803:e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 16:45:11 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 16:45:11 +0000
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
Subject: [PATCH v6 05/14] dt-bindings: power: Add fsl,scu-pd yaml file
Date:   Wed, 29 Jun 2022 19:44:05 +0300
Message-Id: <20220629164414.301813-6-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d46d9d3b-546a-4ba9-a24f-08da59eebbe6
X-MS-TrafficTypeDiagnostic: VI1PR04MB5840:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GxkaETkmnb8bZvYwhpxPqNmtakHxfvfoosJh03+920+l7TF32edsOzyjLzU1dod/CJwwPqhrz3xChpr6ovhgZ0EiAzjxOpc6nATCAoY2mdylGJLeHT2CmEbNuASQV6PlOiDUN0BofGoYEizvtk3R7ErUU6cxRn/fOGanQmxpvX4tAiiHk7E4FYYF+C8gXOl90Z9WmD8xMFTCV1XorvX2QSKnmWgvomkCwYSb/0B7/hyzVtqRnSick7dg8IY2ZV32QnygYXgght4gGVxBTt/0Hxp2STEZ0Wv6hYZI1P4rMBGXnNzRPED3YqGYJGTK6cfH+W6HTVdYFjiZR0+LTmcdkL2JNWsfx2ruu+8DCimJhxo/aeX0Ts/6gwn73l0sxvOKYpXwCa+t4X0bYyFVyJ7DaMrumzcY9yFDViNqT0Imdaoc7NtTuGbLuPhQRCgnY7dVoJ3ePz0MfYK6usbmbzsJdExo6TowQ9HpaMx5OyjLvupuR8k5dgc098ympATKxpvejSemUZNmHt3CUvhJRUi3NWi4cHY5njnQk8WTUp7+S7dYYA8r6za7SuvWVwxnlqb5xxDGN8b/VjHSd9WufabYLdRuLxiZNcrBrjCJBhr0QTnadKkWA+nTOdKWNp5zCl8bNb6oz02gJgz9+J2R/G+CJ14M+gq8zVzqIg75o+IIM/t8KFRghjxOF9zjrIjlq+RvTNC9Gcpjn3KtO+/4bD9/mBk4B7Y3Cs1g5tZbRdPStj1mi0v8sTU6uGNvNZi9HBFxgoTTgVVnwxHv7m9vOCdCDttVsMTdiNFzKoPuCqKR+p8ZlSAigjomlSbE4uxDcXo4hIgAyvGytpp5tnVhx4qe7FznsiZuGF2ERYmBHvlo12ApjYfj7+p7g6fCt0XOKUBo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(66946007)(6506007)(26005)(316002)(6512007)(66476007)(5660300002)(66556008)(6486002)(8676002)(8936002)(52116002)(921005)(38350700002)(41300700001)(186003)(2616005)(7416002)(478600001)(86362001)(110136005)(6666004)(83380400001)(966005)(1076003)(38100700002)(7406005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?V1l750qH8W6CeY+1uFKAHimq6StQMuj+BYwCssqsQSVgeAh19uyO12xKvB?=
 =?iso-8859-1?Q?nwTgvUgOWHQElzQfv627G5+f/foVn6u7GDtPdiUrjkQ/2VvUKSuo89zH1G?=
 =?iso-8859-1?Q?7XtMHQ0G2AiFDrfIcXgv+b1i91QINM6kTvcLUy3GaSiDIQ7vtkwVWUA1ji?=
 =?iso-8859-1?Q?0jMWzMQocerle3Kcv+lMoTwpuM7RdNnm29ZGC0jM8KoN35r/Fvhvq1wK+4?=
 =?iso-8859-1?Q?3j7oiyj+avrYf/ek9+3R8p8KWycYJ6OAy0Ndq880JhGiLhkTB/52Zd9oxK?=
 =?iso-8859-1?Q?Gx2ycsxoc69VhwogqAv/WSkxdAAq4fpgMGVFKNauHsuETC1NDGszAoitLd?=
 =?iso-8859-1?Q?HMFS+W0nmXT8mPE9ogDLczH4EQUGSX+hsI9YG+Lfwh5nL/IQTTanS3lXkm?=
 =?iso-8859-1?Q?vW7U1gY5rRmvJqLmmGn60gP3MeOyv1jSVK/5v3w5OUky3ao1clP7H8ABkT?=
 =?iso-8859-1?Q?1Lfx1hVFSFG7/T+hr9o2LbgQqLbGhKrFCKDbMJeNhnDDmeryEXpAwhLt6q?=
 =?iso-8859-1?Q?emJ3iumIJMbgP2D02nXKphUv2zYuPz3QyxFjXCIXoXRlSIIngQBV9M4BIu?=
 =?iso-8859-1?Q?xZ/4yV6QmvpyTjwlpvuUiBZuWeuiTcnwObSg7Up00NFnbjHqkiUZq2AJjn?=
 =?iso-8859-1?Q?JSdfh/yK3Xm9OetDUiGZSThf+wcSqbwvxOU31SuO2h61lvI0m0sLdt4IA+?=
 =?iso-8859-1?Q?Fbo9MtXLw9h57nBNxO/cdvXPPVr+cnqg+U+j1kwp4k8VuqL0M5wayWgxFq?=
 =?iso-8859-1?Q?e+JYu8RXuu6vrw5I/NI1IDdaGEgKVhCjQiZ4xd21GlNOWNYXvvpC0cUt/6?=
 =?iso-8859-1?Q?eHUH+UFNA9NvKV+kxBN9YymfDPW62Y+/wpj6shAN2qeJOG8PqYKmNZkvmr?=
 =?iso-8859-1?Q?PO7hrLEUhNtIjMArsFb0u3mjueO3H3TGS7CDQK0unfkGkCNXqHv2UPaKGS?=
 =?iso-8859-1?Q?y1LJvnedGBam0ufvB1Dp+321eahibXWnj71lPSR8tse9Kr4urBaKbDjAgF?=
 =?iso-8859-1?Q?Vm1INhk5LqPkfA9iLqZXcYcbz/x4eGm3QhbxRCOYzeSCJ7bCad4j6lfvPu?=
 =?iso-8859-1?Q?9h+zoa2dAoTarAWz2kj7jZ+2k3a8R0fINOJQXeaFy6Xg+g8i9Bh6ACDHQj?=
 =?iso-8859-1?Q?XnuXdWhEtvqXYFni47v0bw1SVBtTJlrXRCUJ8EEDZQz2Hj6O5jo8DiOo5h?=
 =?iso-8859-1?Q?I2fMEbFpAC1EtzHi5ElHNOOvugfnedM7j/3eTZt3/8jvh7NNGmWB+TC3Aw?=
 =?iso-8859-1?Q?KbqCpS+3BczrXYqafEv2zlPwnXNXNseNg51DA8zX1+fecdGxZNmQEJ2Zw9?=
 =?iso-8859-1?Q?pj2C78kPZplhsxK3dTU+ezkVQaNoxRbJSGlbPaj6sweAggR7Lsug+YeS7H?=
 =?iso-8859-1?Q?tNt7JddWaZbJJcoKGoOm5FLNJMGP83KIaCl/yDw3H5dz9EvaDT2p9+ihTv?=
 =?iso-8859-1?Q?+n3EZqHlctfgzsIgHBFsovi9e5QqPYN+NYUSKLJxRYUcr1eYoA64mFLACu?=
 =?iso-8859-1?Q?8pGIFxz/+O7X+29LYz52SBWKEf0+2bQWTbRyMz8OQy/nD4kGhh7oWPqNk+?=
 =?iso-8859-1?Q?ayaqI0LpKFAiTXYrWzKBke3bnAjopNu9qb11pq78NRskPZ3MAYuZO600RL?=
 =?iso-8859-1?Q?LdPXI3PR1/sDe+ok/COL1AEXMiiuwexS8b?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46d9d3b-546a-4ba9-a24f-08da59eebbe6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:45:11.7295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/i4xFNlRHlBf/PuO0jcR6WadNJtlsb2Z5G8BrerKkj/nRzSXm7i8lrk45lZtxb1U4HGo8wtXjxic6sKKfYF7w==
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
separately the 'power controller' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../devicetree/bindings/power/fsl,scu-pd.yaml | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,scu-pd.yaml

diff --git a/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
new file mode 100644
index 000000000000..031c7a5a59cb
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
+        compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
+        #power-domain-cells = <1>;
+    };
-- 
2.25.1

