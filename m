Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFD854E7A5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377602AbiFPQov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377412AbiFPQoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:44:13 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30049.outbound.protection.outlook.com [40.107.3.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9672CDD6;
        Thu, 16 Jun 2022 09:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2rQX9LwEPRa3N4p+f3QxQKn82Cv9/tzOUkF5UsZQe2uu4G06DBAv9gKAW8/bw/Wg+59R0v1k07Wm+wxGrgOdUI3OQKsWDRy7I2vvnzpxgl752eIfm3CB8Dp2m2wkBUr/7X6+OFNlJuF120mn7Pg2ufQDh0Sp7mvMJA/HddGVISWxa/STSzfSRPua26hTOB/HMLwHOsW9Ak4evKtkqe9y1O8SCuDaP1kMSBF2/Dg/ysA5+WWRInXUiNiXymF+7+ZpM2wBPCGBY75pxNsm0BKoVmpxq2E8JrR9pRfb6b6ZF9rNKsyhghd2RWCPVmoZ66EhNjSR489KbmwY3kkcHH87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/HH53XkBWHBvSuWeHYKpmfMVqMgzYPu1bmOgPNFPqs=;
 b=U3C6ccLGBJ0sQTcc20NNc+i+eDBxba9xdd2aIkU6gNwlN4ePsSkoC6IyIzTC+bGX6oDwQH7gLfMKcO+DnS4uIfv63VbxqUQJ0lJopA0X32JUAuP+U3fcIL2d/OTrXu0Hg7cw+bj3tvGLW2zvDJgSg0OQIFQvB+Tb8TyZyoRd6t8hNzc9RlFl5zmGAy8AsGbyJFY8wUgwBIZmuy4UAzb89K5Hv6u+psnK/6KmLhH8kwSHCx31HUYJ6PCg1HdGQGC6XzFsmza1eBSKHAyfepZq690rFv1BnXxTcCwgjWImbZmsw+sT+mWhvud1OXAU/8SXzw4nvdD8U+c1TJ5S0QwlZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/HH53XkBWHBvSuWeHYKpmfMVqMgzYPu1bmOgPNFPqs=;
 b=He1nZ2HoADlzua4K1lfaPZ7ypvxS5UfXClJJJHS3V3WLWK6M6mF0gex42AfOdDyNBcSooFIbl93UXDQUV8X0td+6TFCwCqgV6n3oiRmEeHoWWBwTUyBCploVqN685MSW+sYqit7c/3B6tDuei6wLMHTk5X+xsn/QzS3bwvVE0Mw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by HE1PR0401MB2649.eurprd04.prod.outlook.com (2603:10a6:3:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Thu, 16 Jun
 2022 16:44:08 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 16:44:08 +0000
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
Subject: [PATCH v5 08/14] dt-bindings: thermal: Add fsl,scu-thermal yaml file
Date:   Thu, 16 Jun 2022 19:42:57 +0300
Message-Id: <20220616164303.790379-9-viorel.suman@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: aed2b33b-e29d-4282-9c0f-08da4fb76ec9
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2649:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0401MB264933B4D6D030C5F98BC16492AC9@HE1PR0401MB2649.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJ/inWsAcJaUAhldvHXxEz+u3RnosHctHIBHS5y8Nepd1XA7nxUXbDsTXci2PFC9P77yRyaZdPfS9EPLeqHeIrmbsQWpFUnuvAph0lB2ewFbN38mokBOIqRDnbqZ13qZ8d5JNukgWgTfsh7Ouzy7mdi3cHmnrHQKEpGga5iL9pzOFc2rG3XKHR1jPURe/c0Ko+2o337BpBi9vjGSy3RmF1ru3AYLxL54aESq6qVgrN875XjrJpk2yCbTl+5horainzzqFf3rjIH9crY8BT+TLJF5T7w49BlJLlBzoXdlRqCyMlwwGgb/AdWwDEywW9rVVqTG6ElsYf9IVt0AISiYZ4iwBKDDQMiJPiNOzA1THS1LfV1wgiUURDNIuXXcU8v+lot2U0y5PSnkIkVY2mwcvvrqUdjNN+71sT+7cZoPPPIHhUV2GsyJ2aRR2C7CF6vkJDg6MwxMym4ImaRrwAjAr58TW1W/C/ovU4171Ewtc8nZbmxkK7sPlL3ZohJ7ky9C1olZmhB5e8nsnFD4ru2ksmWaH7YRS23Yeht7gNgxy+4AeBGqIubaKHvWAh0QYn/6pIpd3s8T6aXtmvga1aEOHDkGM2SO+ZB10iqEZckOLwTBxS0PDG8ByTlvhzXp3erwlf+nCpmm1ncTJVlMtPCk61T1JtfkJoKjSg2wN2V0hNaiMcB9lpk4iH4N/4bxFscgBf5oy2G3Pf2piZdsPhHHXAdWahZOE1wkN5LhFHy8BSoQOn45JjBmA1BT/vgux1x6qqvO7jBIQn+atPq5NClKAS/WLY90ozHdHubhtokSdt9J/jppc9Q9/5dzxAIsxv1jj2s3vpF9CPFKbgsQ02URV5bfreq8KT7q82VnvMwaWfk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(86362001)(186003)(38100700002)(6666004)(5660300002)(2616005)(26005)(7416002)(6512007)(66556008)(7406005)(2906002)(83380400001)(66946007)(38350700002)(316002)(110136005)(52116002)(6506007)(8676002)(508600001)(44832011)(4326008)(966005)(36756003)(6486002)(66476007)(8936002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?2hQMM9OIl85RO0JoDCtoSWKItjxOj0hr8VgSiRCszxkViyTgdpHxw8FqvD?=
 =?iso-8859-1?Q?JLpVjwUeWFdZfnt/ypiNjrHNgVLGb6slR+eBKcMQeGqYOe8EBbnpF3HHPN?=
 =?iso-8859-1?Q?ggrHe0Ir+rpJD4TeW1aOkyyfTjQzlLTT1tLvSEq2No8nIsiqBKDm9qsZWH?=
 =?iso-8859-1?Q?gda8njpuj/fICkEzZ9Du5+V2iw6m3aqgpDkv2CqAORujwEJ5zhRiCt5MOa?=
 =?iso-8859-1?Q?8j/yCyC6sc/arWtFN6GPUNxsAW7yJXYDnuMGvc0CZqgSz142L3Qbl0vo2P?=
 =?iso-8859-1?Q?mTX79NMiOCytJDjmbZO9qkhgmUItzAa9GokJLN3E0khMghXY0q7kDMeSig?=
 =?iso-8859-1?Q?TZEbJkuMn14Uy35tBg+d7rHZWZLZRc7p024croi/fz2EGhkSjS25w4KWxE?=
 =?iso-8859-1?Q?cF2DqTZpTJUm9Xs+dxsGfKnN3Mx7VdbjI7zA3JPePyEDhptgSWH5kjQ8QR?=
 =?iso-8859-1?Q?0fliUKkLSMyT9dR/XEn7+NhJuNnKA5uhwcFPxj7jUJ6jo576l7cDtIq2ZF?=
 =?iso-8859-1?Q?eCNhI6EfnApUfISj1jg3UoWTs8lc/5DIWBD3k/O7G9eLKeV+/e04uaj6Ux?=
 =?iso-8859-1?Q?W0VQqubkPxUtYi2C+QC8MZNune83ViCTvnvFZK3Bh3EcivbCOZZfgkdnim?=
 =?iso-8859-1?Q?bmooxL3tshCmLkCVr8XtQMRwuyAe5niaKHgXPCjxi5TUUmQ+37DGHluNxa?=
 =?iso-8859-1?Q?c4x0Pg6pkgy7F3LtB06pvnmaPAock+3QNHoC3elyp44wvVl35AU35JHwd/?=
 =?iso-8859-1?Q?IJnAYCwZM3WcgZDVECAcoS9/txJNqllXbJhkuIuXj49XKMISqn3tZOHeu4?=
 =?iso-8859-1?Q?F0W1kkyW/dDodG1ZVznctDrhLyxeNYEBpXwGgf3Vs4MoHmxgnr+tmkrus1?=
 =?iso-8859-1?Q?zD68QlGKw6vv0eh/33kIEHGkQEDrFeDsQCLAJYLWZ2ZtUoabZTd71Rb6uJ?=
 =?iso-8859-1?Q?qjT0WzCgPZskdwBLkhJWwJLK2hVUey3lF5GTyAjU0Iul0AckEBsHSh6RZn?=
 =?iso-8859-1?Q?S70T8HndVyBplvW8MLogIsFwb8uxfV/eItP50FSbrxfjx62d18eVavAj/b?=
 =?iso-8859-1?Q?c6IlsVzeOC3vZt2y5E+eLnDWGN3VPUg00jLqBdvH1rJJLuelJF09dURSrI?=
 =?iso-8859-1?Q?6UJK+uoTRYLtIENN+zH52Z9ftUmqmCnXSpYch2CYgYdiFstioyPGb3jTD2?=
 =?iso-8859-1?Q?zZx2xUhxzisBQZUdcXAjl4BP4zgsPXJN4CYvwnyaT9N27/nLkrgW50Pfgq?=
 =?iso-8859-1?Q?48dzJjCNngL5NiHC9prPziVe/Z/Jj47LihjtiWZYb9bH77Ih0mTp+yiVAe?=
 =?iso-8859-1?Q?d8UTvJiGbc0OgOhVDO2TuYJdVx0VhOU4JnVtX7rn9GnHgWHqDEZmqDVnCU?=
 =?iso-8859-1?Q?sjVJxtu0bgw3hLirWvszORo+QZcX0XrDZrYD96Fka1LY75pEIHJss+Cr4f?=
 =?iso-8859-1?Q?e9StDN420/5xtaqpqL58poUj26Jxr778NKKWTnooJr6Ptr76ii2wNtw1on?=
 =?iso-8859-1?Q?DhNstgv3LUjEdiAKKByryTagGV33MXpC7dVB0nrrO7KKI1BHLSA22Eysiq?=
 =?iso-8859-1?Q?icQ423fx8U0/yju80fFX7GH5XM4hOmETq1gKm8VYWrU7yWxwhMVhgVS8IW?=
 =?iso-8859-1?Q?ptxVSevNkurxBpotu60p8egvbhtj4Re4xngA3dUIvehyQXD44DsYis4UiD?=
 =?iso-8859-1?Q?y4A0qoQ4S4syIdFa2JJwxAU2l7X/lc+8yjdN7O44CrXvj3hg75GgO1v183?=
 =?iso-8859-1?Q?b3VzQK/WPJirTot9FhDzqkKDmSVpDdf5AKgvrC65fe8vSWTO2oKd37ABFm?=
 =?iso-8859-1?Q?QGt5Uu8gnA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed2b33b-e29d-4282-9c0f-08da4fb76ec9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 16:44:08.4537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7jgsFnUYNj28c02ns5EUDKwttjWLTxHvr2dP2TK0fmXtev6v8NdAeRm35RLEzfMzXogDjoHI7s29083+QbIlXQ==
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
separately the 'thermal' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/thermal/fsl,scu-thermal.yaml     | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml b/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml
new file mode 100644
index 000000000000..8f2646a18ef0
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
+             compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
+             #thermal-sensor-cells = <1>;
+    };
-- 
2.25.1

