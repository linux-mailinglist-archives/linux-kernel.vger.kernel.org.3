Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB765439A4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343554AbiFHQuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343610AbiFHQuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:50:01 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00046.outbound.protection.outlook.com [40.107.0.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411E26162B;
        Wed,  8 Jun 2022 09:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNcC+HXFSMwtw8f36+LTBJpcLH5VAKdk4lYkMDrg39jff/dS84d3r8Seix0S5YuOGzSExMIHw9sB4vfs2TuDrestFSJ6oFDzmphIcA3H0nlp+buXgrhiA/3qkqAz0nEIM6jTnKnhI6UiPZFlfr0MrCXRFq+qfryMsfy5nTz82tNZNlLeLVtatAxSExPhiPx9US2bawThgl8IJj+11/mqYdNQMGIpvcV25jNu54xMTPidmdzUROZ75uktkhJ7D6GJknw4O6tu2/PWC2w8e1mwYh9FxmxKJNuWrqCnYYn7CHVavF6AJhR9tH4I2WqX/fEbEc86sVTdfIZ3drB62q5GKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppV26iAs/5FNK/kFZF7sjD13BugCz9zmLI30xJLdhsc=;
 b=nXONxThXMyNK+zTIkxA7geD0kWYymomL+J+ZSrmF7lrP8oV87w8QDo/W29EDljyM+gJYGmx6jcZ8yAVtb3yNVkORgm3YYHXPLUc/oRlARbNA4nkfFt27RFyedwyRkwusrJqmpR9UK6HKrwD96cn1T4BP+Gj8fxdOkRuH7XWcwN/51FHdZzeySrhtQIsc+gvxR5awIjwigoDqvd+FXt4lq6gzV3ReKd33xlmSop0Kc1SRBYMdX/Xc1r4rCWONXPK6hX4Tf9Xg0RK9jVol+b/lIHMt1HYQqv0EHI1C2JMGE+a6ieDSAAU0Z0LFx1zmerQ80lp3+5ZRPLYvvjNRwcj40w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppV26iAs/5FNK/kFZF7sjD13BugCz9zmLI30xJLdhsc=;
 b=VaCIXlxD704Ck0VoswOXmRj1xDp94tZ80VYpOjroanL1HDihwXU/rcwwRrEJzVi+5aBLhRBd0t4KUr0CT/8cW6Td/q2wbz31oFg88Pi1M22B3VkQsNJxF4gG7JlciDWIUFepBIO8aAzT90OYyPOECxDFAS0SfCzUFZLNd07WMLU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DBAPR04MB7431.eurprd04.prod.outlook.com (2603:10a6:10:1a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 16:49:57 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 16:49:57 +0000
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
Subject: [PATCH v2 08/10] dt-bindings: thermal: Add fsl,scu-thermal yaml file
Date:   Wed,  8 Jun 2022 19:49:26 +0300
Message-Id: <20220608164928.2706697-9-abel.vesa@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 32065ef4-ba6b-4da7-1192-08da496eeb52
X-MS-TrafficTypeDiagnostic: DBAPR04MB7431:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB743161E0564BF636A4B77831F6A49@DBAPR04MB7431.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SrYSyBQAB23WPPHBOFEGNsVegJR60SY84JQK+tHHcpgd9zv8Hawk0du1hN2E9bydylSTHL21w4EUIla61Jg/N3ZdRjoTtgn3DEMQKShQE8gSIVyCbmZc0heKlOUILAXo1m/HK+JaKuKL15Pwsj4wb8HmMCb1N2QSG34mvuhPF93le+xdI369Avd8nj20w6Z16ReWkm9FHOoN0KUBNv234CVi4Be9HflmVPGErz24jGoVOh9HGYY8YCryVylX0Z+/ldPzW6Mw+sdehfkibUNbppieEyfCnQ9qVu7zxSRX5nqZzqJjnUteRqpWg5BW6QyiEJaixDqt+Flap6d1t148C9lG3+4bOStfiOTlxau/s/ChHE+uaoSt0vLy8wVgsb8nDHG4JzsxtAfeSi5kS5ZarXjTXXKJthKyB9R/DdXZJ6pNdtJvYQY5y/WQYrEGGRJR5WGRckIZzAYTTTLMNMTG2i9WqXXws9XL9rlO9sXExTponS6uu34+GDi2Z3nXVUHiEvhaDNlfPzL2rEkSSWiVmJZIndrL3lJg5WeTlXdKNdGBiFI4D2JX+RNpJavpukE+n5NyxmVkjbdIBhDe65icyHiu+yB/VNPLvldoU7zl0EwOZjmHbHg9JQBzu5xMgTs5kCAIyoOnk15LGOUrYQoHonvVyZPBxMMJBbDbOC4gE9c2suTLdSLUDqq/o5aMYDAqFsVt+7Uvj7SKkM6yhLTBxHrMXMqbhIHFzJAYpMHzO3NpkkrTtb6QtzQ9iawQVYMl5yrRsO6Y6LWsE5iVV8DczWUatR028dFDBbcaROeUkG1rAxeohz0mxptQqt14IiEty6OblcjL1BOlWaQhf6L6eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(83380400001)(66556008)(52116002)(38350700002)(44832011)(4326008)(110136005)(1076003)(508600001)(8676002)(86362001)(6486002)(966005)(186003)(2616005)(6666004)(66476007)(38100700002)(2906002)(8936002)(7416002)(54906003)(26005)(921005)(6512007)(316002)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?igewx40sQ8yB40OQaQJbR9XwCBALXxFhDgKYcBfcbIDURm3C/fiF6iD+RzVw?=
 =?us-ascii?Q?ADzFa2op1H6Xk0vJrQtfq9hh+YTeF65rHwqg5UPpov38jv80iR2KFo5+O/WL?=
 =?us-ascii?Q?UjyETjJR+nrmVMEp01MT2eUpgF2GFpsQmUuFyrrKkIR1j8P8RmdIKlUh3NB5?=
 =?us-ascii?Q?irpbIbc644QRvXEKjQ/W0i54nb6hC/wCuxQLkjHQxmNhldfac9VjKVm62aIW?=
 =?us-ascii?Q?5dUk0jMv4hROGMqD0qinbMOfpHs+B+d3w1McJClO6sEUaDCCZ+0dA7mXCfhE?=
 =?us-ascii?Q?ym/wnMew7+gvjqvP94rjgvaYWSPb8rH4iWtXiK009mT7Vd9mayfn6yDLCR3z?=
 =?us-ascii?Q?mbNmmSfrk22drKiS5g6zLScyQO9GhXzrQqPiDPix0pxpyKMz8SB5eno27RsJ?=
 =?us-ascii?Q?B/v57OfXS1p0gwJaJM8t/pjvS6oE04zaYek1ewtd9ypyIYxSKnE2fzkFv+2v?=
 =?us-ascii?Q?S8FVxTBQy+aQB05GN1lXbiu1mNTZw9eZh2lTHw9DBeL3069o0e1QsGNPQCr3?=
 =?us-ascii?Q?AqyWpQXlRWo1/b9NSzstBeUMxRLn2HFwmuLSAxhgphRD8ucC8JBkG/aO5M3w?=
 =?us-ascii?Q?FUX485naIZKrZOCn9rgnOamUHV96YzsblaFmSb18cQMIi3aXWKb3L0hfPtBr?=
 =?us-ascii?Q?bFEXHlYqaWIbwS841Ccq3jA5KHSbsY/vI1GcKJZ07NJeDWbRFaRo3Y4u6HPP?=
 =?us-ascii?Q?0xMWiH8SVBoo8PEV2QH4DcW0AIrN1zwxQOuSSgcu34Sf42SnvyUmbmVgurn9?=
 =?us-ascii?Q?zyfI+uFTgC9Lqgd+pcXfb+qzR4Pm3hwaEcd+8ABIQMTOE8MM01M0CG2GRbxf?=
 =?us-ascii?Q?zZPAF4IU8g36S/DYE4Zvubkx53AKf6M2CGNYTQ4fXa+ZZrF8MyMv2f/IsfJY?=
 =?us-ascii?Q?yUKJBSCIEh0lTSSXwlcitOdCFoBER81NmbKRsUvBYzfA8DVTtsb5+ASqVzN0?=
 =?us-ascii?Q?U0QFTegNad7lcUsTuxeqmJaUOf+iA8t003CnpX1HWwcmIZZEw3+bsR+wv/Fw?=
 =?us-ascii?Q?6cXn7W6IFbX8AoiYfzfsnrRh6oMP0rsFtLtFx8h56Ep0xLLMrlafi5BC6Ima?=
 =?us-ascii?Q?IOwdUPzPYj83xk3s2i1Y4/bWYHltRsIubqTdbU6Yafe2V5Cljop8L0a3wshE?=
 =?us-ascii?Q?uW+myHvecPbrqojqWUW1UlInt3VELilJ9puzbl5U6T9aakejxDmeNs4QGS3l?=
 =?us-ascii?Q?f823gO3D8Dh8IAa2vdy1vM6ePCLlFeSaguOJNOMCo0kr2Z/R8IsD1qPipGa3?=
 =?us-ascii?Q?wNr0SfT/4K8zOjzItE3VQhH7VJV8wtctI5Yeuc/baX/oXYmx2E5Rlk7HNIml?=
 =?us-ascii?Q?2OVqeSTUMyHfurh7OeqlItg6CsLGgB0Zoj/FmbSUIZh+btJE3nynieToEFHi?=
 =?us-ascii?Q?QyaVGZF0TOwAC1OK5ElQeB394R7CREbe5OPVJTq1iabWAzGKf0SlVaxIkgBz?=
 =?us-ascii?Q?eaow1Kiq7VopbR6Uqvo/y7sXMGnz1giUyMK3A9isVI7Sf2vOgtzUl5+vdd4S?=
 =?us-ascii?Q?oEhQvc7NH3cMFBR90nHJlxlX3tmMyE+WsbfQ91qVXr0gKMXloei1UIzbLU/6?=
 =?us-ascii?Q?0vGx3FXz7/A0gfY5WzFfgF3vYmoydws89fuAI4oB8SqDtIujJkappmqeZYda?=
 =?us-ascii?Q?U5NITN0qqfUvSWJjPb9xcpJLMz6RVVgPWKaOj1bAqWkstnM76OINwP+vWtR+?=
 =?us-ascii?Q?GB9XdxAXiR1C3c7RmZTl8JWfOVsNPPgx+mnGW9oY12vwEafAxh/hB6e7iple?=
 =?us-ascii?Q?dRz2J5O2dA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32065ef4-ba6b-4da7-1192-08da496eeb52
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 16:49:57.1632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JRacoWlW2Gv93njOnYgvNmQgbm8Xa6wi4fZCU1eEL8317sr2xmLmIbxSe9tpGyQYCCxquz5WElWtB93Oi9ktbg==
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
separately the 'thermal' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/thermal/fsl,scu-thermal.yaml     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml b/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml
new file mode 100644
index 000000000000..948a15a7f71c
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/fsl,scu-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Thermal bindings based on SCU Message Protocol
+
+maintainers:
+  - Rafael J. Wysocki <rafael@kernel.org>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+allOf:
+  - $ref: /schemas/thermal/thermal-sensor.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: fsl,imx8qxp-sc-thermal
+          - const: fsl,imx-sc-thermal
+
+  '#thermal-sensor-cells':
+    const: 1
+
+required:
+  - compatible
+  - '#thermal-sensor-cells'
+
+additionalProperties: false
-- 
2.34.3

