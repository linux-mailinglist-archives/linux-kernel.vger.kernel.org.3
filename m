Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F42A54397F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343576AbiFHQuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343561AbiFHQtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:49:49 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50053.outbound.protection.outlook.com [40.107.5.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5279A5046E;
        Wed,  8 Jun 2022 09:49:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdkF12jbix5bA9ch/wqqTkN1I5lyT7ngjyrkxgp1mrL5O2VLWHZ5jACbrntiEhIR1rQvsRXYSacI1rqbJLauPGbX+IdoJgq0OjF1qwm/HjgKgGs29woqaxG7mtg0cZRxguv8l87hX6WqHcX9lyfJjWOUM53H4kx0XdaoDGlNZz0ew0h9mRst2lCG7rT2PHffJu6+g4j1Has+34r3Ko/3Au1uL7aQLdp2do0SqmDhpmp9qO88A5KnohaDlDDKfHnGIuJUaL8w/Oa4EPW58TdlhoDpex0+ygiRvj/UP4xk4+v/euyWRUXbT2+z45jZD8G11Gs9L0hqxLlKtqY4ZryVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHJ7KKr3BTTj3gzs1gKfNtuSo9XmUvSvM1x8yKxpDQM=;
 b=UvWrnzCZDKo4vcdkJwVQVFguwqMSOII1F+SiwK6L2xvILWxP9CIcilBpj9Riku3X8Kt/3zh7u8SMol0itasOGMwG4EdHxVL8Sj3GKK4J3Ej8kGqjeKqWIVsm3GdHEZ7S4TYL4SLXvJlYjCe1CJMccM7IUAcfVetyvX4YlsJ94HPzGbQUSZt5oplJXet0xI9ZLQMS1LfqjKCAkjLbTbxyJ3KQatcDElVpmhQybuRzYS5py7dsRV8Wt2t2CHTvORtxBOjPAZTWr+85yjKoEtNC3wHXWoUoFzDgqdrWc0PXjOauqx+kbd0jx2+52dCRqwnOcbZvcA1Gx1yBd/44chVV4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHJ7KKr3BTTj3gzs1gKfNtuSo9XmUvSvM1x8yKxpDQM=;
 b=YlhdoTF53Ep+4KHQuMY35NXonJMgxILvkH8J844rY76NpzFfZ9ikr+E87Qmq8Irjl0Y1+zr5ZfQv7KSMw8tfMcD8eaEH5V3I3+9sA+AZp2pZEoJEfBVTFsu/52X5xfckhulL7lKt9BDKqjoy1alTRJINf1euWAmRbiwHMjNNv2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DBAPR04MB7431.eurprd04.prod.outlook.com (2603:10a6:10:1a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 16:49:46 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 16:49:45 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v2 02/10] dt-bindings: clk: imx: Add fsl,scu-clk yaml file
Date:   Wed,  8 Jun 2022 19:49:20 +0300
Message-Id: <20220608164928.2706697-3-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220608164928.2706697-1-abel.vesa@nxp.com>
References: <20220608164928.2706697-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0701CA0052.eurprd07.prod.outlook.com
 (2603:10a6:203:2::14) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8f651de-93d1-401a-3300-08da496ee49b
X-MS-TrafficTypeDiagnostic: DBAPR04MB7431:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB74316DFBCF68B4B659566C00F6A49@DBAPR04MB7431.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adQ6Irj5oQDrSsRcGzlALNj4+iRZH+1sagm+jxmUOOV8z0b5IpDja11E6G7CI0KnMDfWWj2/xhkuPeM68CERLc/rcc77aoOjPeheo8ROYzwHCiNocZYXUt7kXsEUn7JcU+pEGYlpHyrn7Xe+nhyeNXVgBNNWZWPOhM15dW7SKYS0vHKUUJw3B32PF4a/qTgA7Wip1xl1mA4rKvPxnxB9LHAJyLA5GozbkGY+0h1biOozvdebzpMNseOZHPNBIx0IT7A5FqB9575bWpmubbQe9EWUF+Q5AsOiVz1jq1iE3AiviNY8ICZaVES93p9n6hSEihHyYLpiDdpNF0P18N6xfpLCgGZKZCfBm1oa5zt8CjKrGIE8FzWfss8NoZ8tG1XHzuZeY7tdFiilinO6p7/zVKpRdFGRivM+e2JpQ2M9NjsNXUUdS6HMMtoudFzNLmnX54yoAh58TdFLzzj7hPhxX0WaRWJIPUr6yzaECUhmoBNxJrL9vSbw+brY5w9Cb/nkhvoyh9upjyGbmJzb7AAD+oP/fu6w3AvhZB93VgNiUFxEqp0dMfMomKVzdCKNKc3m4S7/N6jZQAs+AlUKM9KRulk1oFnoHp2cjaWWrBY3Tz9nSNUR4oE5AOj30qYx4vBhMkH3fxkBfYarPpYFR2ROvt/rSVkWI2OM/ebXzCBSnkaX4E++U49vELxGE3+IdAjBaznt/c+4dSdCc4QHFmLd2LHHOQ5xbXeitrASteX2i14d1zzWB82+uKfFwLhBCZXrYs/aaaG1ZPanDsS4IM/Ui04BLQqtOjEtK4X2uTxGaU1nA09R7FJbhBQreXBYpaCnPY9gQm8o/TQNU2bjWUPsQgfZi0ZnBsoa1Y8eF/3Iccc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(83380400001)(66556008)(52116002)(38350700002)(44832011)(4326008)(110136005)(1076003)(508600001)(8676002)(86362001)(6486002)(966005)(186003)(2616005)(6666004)(66476007)(38100700002)(2906002)(8936002)(7416002)(54906003)(26005)(921005)(6512007)(316002)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4aXrkl3g56HuYnHiYYDR0AWzwa56UL3+NVnDaHM/Wuw+aN3sKFrffQ2oFOdr?=
 =?us-ascii?Q?F2Bmesdx61UFnd741Z4k0onGZJ2LTCqJvHdNn5xPtsh6B0YfNa/4fGQdAslf?=
 =?us-ascii?Q?pivkLsoozWok2UuyiTI8/JC6hgkDxbq6jyRFsMoxa2NUMlddkOhV6v5Tvksn?=
 =?us-ascii?Q?yA1AzSihwSF6ucphnaYZHxG5Kp+EG6lZhK3oZ65J42cOIPQUnT1jgNNMXf7i?=
 =?us-ascii?Q?M0/XyEYHk+RftNHJSnhdDFfMH04DiALnubOy5O7loCMKPmYOsFbcMVCZX3g4?=
 =?us-ascii?Q?w09708gV59Ntl4xxmdX5WrpowaGCXzvjmTZT0h0+p0W9iz+0V+jFl0lU1CkM?=
 =?us-ascii?Q?p8EDGmdCsubtAjey8vOIUzdMWtfxrL8XGhWKzfjW43zXxO6Sm9DBm1sK/Tbl?=
 =?us-ascii?Q?EcuEADiHrBgYdL2MmfEwYFXBrDIPqsJBDXrocGKrtJYdsCcvt0KZMz4vVT/2?=
 =?us-ascii?Q?MmNJvnCCdLHeY7KspE/Gj1/MLwCpF3d21+gqBWUnMQkRA07HjC09caRvXLfX?=
 =?us-ascii?Q?6wPRj2qZ6LMEcsvKylr0vqooNRnIXZOQgXN6cppNLnyC5Cy5fS8u/OLHFIog?=
 =?us-ascii?Q?NG7O5wo62DyfesNpUqWnHD6/bjotue/JLYv2eZVZJ2m1eBFlH/D4JAba0b+O?=
 =?us-ascii?Q?Lx8/jdgQY4365306x1k12Q9tJ/xaGtsAfeerZk9nIDZe7nwAcGGLOBk4oFTT?=
 =?us-ascii?Q?cYiThVrCnZYjwxEBwKjiqzuu5RDk99vtdGV7jCN0KtDM+4Aw1yaE63bmOgzP?=
 =?us-ascii?Q?DHVpj7IRU2Thu7khiOJEoFwkkvZXERkp3abhFfOdP73wO9CoSvG5E1ZGCyFH?=
 =?us-ascii?Q?xKG2f49v79HwplsKbxvyy5N6EN83b/OuZVCQkAswDtw7WdBpiKlR/llyZlMf?=
 =?us-ascii?Q?+ZCnjqgJ05Nks0TVGaOdeaBUDQdCHwIXlygfr0NMk+Zd2QWTyhPGZ3pcrTu8?=
 =?us-ascii?Q?T0Gl0yxvLIFW0JMaEbuZBIPFDnAD+t026iRI9CCRe9EQaxBj/+rlhrPfVzo6?=
 =?us-ascii?Q?RJcusOzTQuPrR9dMF2o/7eS9Mr1L9mOdqmS0GJU6Z25j2Qs5ziuUvZkhDt3q?=
 =?us-ascii?Q?h2pZQ2gEgBA1VlSaInkWX+LJxiN3EzGwkC5mhwjL9toyMnQGiwFIgkJmdff8?=
 =?us-ascii?Q?cyGxKoEIE07Zs5SVhcBFv5XRu83yekyt1504Pjr0UPBU9YhYpSuosHZhk6+C?=
 =?us-ascii?Q?k1aKyhFLVZUzRtM2l28gJ8DJkjowgPDCLH4NBEynzYdh0DzR2Hp700kzMr6s?=
 =?us-ascii?Q?iUJ1K1U/EEVvy6H/63B7A5xKyt1bZ3vmzVu7c7ywGxo1kbXDc9lryMDtz/vK?=
 =?us-ascii?Q?p8VAXXfABkatHkvV5kDt7wO8yAmyoR2T9DMUYOwysnNO2E6YUu4SkBw0PEoH?=
 =?us-ascii?Q?ZcJ3QUNOOe/T3dutz7cFDDoyszCYGKv6LJ92R9l0YI82qPYt12Khl/ER4Q4Q?=
 =?us-ascii?Q?knJTo5EQuol9/ZILtJvnmhYioHPC9t0EIrgU3lIv1MbMwj5AW+IWHMkSSkWD?=
 =?us-ascii?Q?epHzaq3uXVRN2U6EWWw76fb86I0srhzXlsOY0Lati3stvGlotfM0EJ4blemw?=
 =?us-ascii?Q?slWuMr1R6C7Oi95pY7s9VBoSj073Ia5avLUxx50kfNdpJBrZWeTY4cVaPUbP?=
 =?us-ascii?Q?Po/JpmoRRJnyYqeQGcg57RXAnbEr39ptGJOF+lvD5KSuag+dIcKRXmCTC4vN?=
 =?us-ascii?Q?6kdjGDFvaLtA/Jzl/xvp7AqeaU8HL64vaYgNQStUlQjaQmBt8B5+LX3GNvWz?=
 =?us-ascii?Q?j6Bwms4qZw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f651de-93d1-401a-3300-08da496ee49b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 16:49:45.8827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSj3G90PGTzVz/hlhxwDqjoC47WDRzEj1+ahgT5r/MJMOnjSwQfdMsXUjuND7jc4dUcTxuD0fmAGzn+ngkxszw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7431
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to replace the fsl,scu txt file from bindings/arm/freescale,
we need to split it between the right subsystems. This patch documents
separately the 'clock' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/clock/fsl,scu-clk.yaml           | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml b/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
new file mode 100644
index 000000000000..c5902733b7cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/fsl,scu-clk.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Clock bindings based on SCU Message Protocol
+
+maintainers:
+  - Abel Vesa <abel.vesa@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+  This binding uses the common clock binding.
+  (Documentation/devicetree/bindings/clock/clock-bindings.txt)
+  The clock consumer should specify the desired clock by having the clock
+  ID in its "clocks" phandle cell.
+  See the full list of clock IDs from
+  include/dt-bindings/clock/imx8qxp-clock.h
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx8dxl-clk
+              - fsl,imx8qm-clk
+              - fsl,imx8qxp-clk
+          - const: fsl,scu-clk
+
+  '#clock-cells':
+    const: 2
+
+  clocks:
+    items:
+      - description: XTAL 32KHz
+      - description: XTAL 24MHz
+    minItems: 1
+
+  clock-names:
+    items:
+      enum:
+        - xtal_32KHz
+        - xtal_24Mhz
+    minItems: 1
+    maxItems: 2
+
+required:
+  - compatible
+  - '#clock-cells'
+
+additionalProperties: false
-- 
2.34.3

