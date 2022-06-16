Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD9054E799
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377527AbiFPQoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236866AbiFPQn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:43:59 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F187B286C3;
        Thu, 16 Jun 2022 09:43:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJeSl6bUyiXlyPGgo+BxIotAto9kjWtNaOH6Xd0EpEys1Pfwwu2+D1sGfTTbcwYlNALBqBY+8qNZ4APr3B2f5zbx6mdVhFa2FBfweyJvDrjx4LpfxkpnGrTJa+N5rwasiwjkRwC8TDAAUjMUHmqbbs0Qkuc/wc17bdL6tdd1VBpy9+FGLFw50GSnZXis2GGoxIgfxNne2Z7uOXyNLKrz84n3YDyTvUejB7MwzD9kpZPNzr+ip0Lir/8xdy4/MaaYmt2wjTfb8IZYLKrJ+afi9Izw6C09zPmV+MoaEDMoaPT/D5iQbTZ9ebfRP+78X3aPH459fY5p9wZz5/dGddlPxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EzT+PaHe5icekHLA1ZJgt6MAMIzeFsGgUW+oG7l2+c=;
 b=T30LGJZTq0WYiLhvHtt+owmIpKnIJta4tb8vITJjMUWP7oN3Le0w8Gf4knYyEL8N3QORIFMWY4oQPX1DaHzth0xSnyf4q1wWKQZN+osWox8oMSV8heCQ3Jps6Pm+g/KcTbHdBD7huFbk1ghWnS6uniRQZHrzDj5tNMxh1rFNHMYRbjkvLNJQXRZm9DxhmbxoAMW9qQ6rDbHj7h86WPYE4B+EKLvdSL1nfGGkR/htayjzakZN6La1TrC8NKfL+uSDkG/FRaxpAYvMTStbU0Gjzyg8/VoJUwNoG4nCVV7tkKgJnqx7uOMZDWEVDMiBUxfwiNmO1gBj+KIfio+GpjhZmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EzT+PaHe5icekHLA1ZJgt6MAMIzeFsGgUW+oG7l2+c=;
 b=SlBCuHT3pno+lQn76JGGmwK1gZvCl+/O6dHTX3ZLeXS0b9TuMUnZQkVn6c3TP5SQKfWQbH8zj3Lo49STR+FrBpkj68LDdTnt2/zhmv1ekbfB3c4B4/Ipme3DrMrF+cntddphDVa5VCo1NRYEPUHZyboH0LSBwP3VSeIuktxXUI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by HE1PR0401MB2649.eurprd04.prod.outlook.com (2603:10a6:3:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Thu, 16 Jun
 2022 16:43:51 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 16:43:51 +0000
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
Subject: [PATCH v5 02/14] dt-bindings: clk: imx: Add fsl,scu-clk yaml file
Date:   Thu, 16 Jun 2022 19:42:51 +0300
Message-Id: <20220616164303.790379-3-viorel.suman@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: fd185296-23a5-4a57-3001-08da4fb764aa
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2649:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2649CB4BA837FB2DE415073692AC9@HE1PR0401MB2649.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZAYnMSY2mgtahjwy7pY27G8K1cH9J3Rgba5LC7lj0owndo9wtEGpda6X+MCJeaZnnFQ/T5a2kqwUAr16fksvAT8m7BAz89UeQGYoFBDeyNrgk+F4PxHcar5Mmxq6gt9oa3t0JQM2YJ+FsKTaf+fvt7hyFlTZr5ubSgUMc7wlY56nl3LtaoqEfj6pjOj30hGeWkww1gv0Az3zjamr2rEMED2BRDxsvRGT4VsLJdTjZ9WpW5IiJ4lasQDmc0K61XbaQrHI9OB06Sufx4R1EVkLBYCLltjyd0s17rMgVhHkSZoHg2qqxwHzOkKTnwqZG6cwZ/sk3RK7ALDANBV+lw49xinnNplVdYe9Nuy3W0A0QhCwtCcog05kIQNDz14GQDRktLmnwL0FiM51ffqc4xxStdo8NdL/E36veS/sWFzklud+1mpojOoIZqtmjRPLrV9fTIAA3Un33cWco2eJ+lhLpZSQD79g/y1mOR0w+L+FxxqJzAoOBbwt4ib+vPSws+OGvrebcTNRMOMDzofZBmD8nwI4ZYD7pmluon4kjeQwhsXfUZZLA3aLx8ctdsa00AXdgNVAdLgUStLUH2/H8rVX9x95ytmNMikkrDUdcPOWt/dFol+E6mcTyyHmsNvOnn1co4cqkbKgM1C8tDe0jgZUymLlNP8ITB3mm1rzZoOZBoOPvgq7hpBFKdEE68iJfGct1KRFNHBT6xYYIW0GnapGnBa2+IhFfgPEqPUDFkKZYUT4U/EOcTs9W0ydAKxIz9wwCFLIieu6iwhcq/IvW0QJpErfG32dRD3cmPmtKS+xI7T6zCrw82PYerxgF/siHmJsxvYDabayWXJ+yV8NBxZ/18bvSKC9Cwp+u7mtyuDN5SU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(86362001)(186003)(38100700002)(5660300002)(2616005)(26005)(7416002)(6512007)(66556008)(7406005)(2906002)(83380400001)(66946007)(38350700002)(316002)(110136005)(52116002)(6506007)(8676002)(508600001)(44832011)(4326008)(966005)(36756003)(6486002)(66476007)(8936002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?H1zYhySix9/X2ReRfKX6DdPcNoDexqbrNq8Va2zCdtRF7BVyomy1YsGa+O?=
 =?iso-8859-1?Q?PyKCqw5ulYCjSqlHEtuaXfYgY7oEwQ09h/l3Z78hqXfj/lfx7Hm0CsEzFN?=
 =?iso-8859-1?Q?IZMWnDjmp5MeHGRYfVtYD2ZdHrF+tBHCpX5DUJrgcQaBZdZtyhW0JWQQzS?=
 =?iso-8859-1?Q?7noSZg+p0TLfyBhuD/S1ainPxelsYM+YZoWOKE9b2lQAUTiMCxwwjnWpYv?=
 =?iso-8859-1?Q?4YJJtATebbvN2839Qyqbi+y8e4AU74S2ghn4LpUHkBCl6t/MZVtVqMnFas?=
 =?iso-8859-1?Q?EpbaQPNhypsOViAH3CBQVKjdnKT0NJM1g/pJbAND71IiwJBC5LCUsgPDtK?=
 =?iso-8859-1?Q?Ew5ONBnQ9NAWeEwseYzkyLLeDZBeZnvfmtXjpTyaS3Nuurf3agVrJ6u6Vr?=
 =?iso-8859-1?Q?ooUD7C37XJoJzhZ3ZKbmSdqE41bvCChkLiXi42KG2+le6AeDVCPPYfgnkd?=
 =?iso-8859-1?Q?tRl5ZppPhFqSlc6zbuaLpsGbkeYdoMMCS/KYF1fV5ze1tSQm/pcCxY2zzj?=
 =?iso-8859-1?Q?8UMB+TlLSvBnUvkk8jfRr89OIrwJgdQcRSryfo//O88asMBRJRmpMzihqi?=
 =?iso-8859-1?Q?6ljbO54SKzJcHKtrm5iHEaa3TbZjklMrLKtXA22npnJdcCkjdnxQbMaD8a?=
 =?iso-8859-1?Q?xZ8C16kTRBc/YVqduQ2ICenRQ8fT/08te3AvygsU/1xqAYVsohG4BCrRwp?=
 =?iso-8859-1?Q?T4N+LLZxhdXtwKgA2TqtFKU/P5sviClIyJZ05mU2kMG8vjur4OWRDPA/Lz?=
 =?iso-8859-1?Q?UkT8R/GaNPoSPZOXTXAYw/XTq7lqFkZTK3PBTt+9+WpVTzGAKFVdXnMRDu?=
 =?iso-8859-1?Q?5poVnOJkxCTY/R0iAg1XHrQqRFr+BVF3X7+o8W2FSZR4C3KdSa0op8iKOu?=
 =?iso-8859-1?Q?HgCBecDA8fecWVUcT7DS/JPPABcbQq9jqDazMSZAJmUmQywgeuwrGSnN/B?=
 =?iso-8859-1?Q?kl3QvOvwbHrspDpzbOAJ2jpDpZDSEnCkXYHWdp7qraIPkYbcZWNpGNVtBC?=
 =?iso-8859-1?Q?lJLtaA1kVFAfjuyL6SOypJsk83I8B6cNXpParEiWNW3cw0N8UMBU9eBrqs?=
 =?iso-8859-1?Q?ssXRV3/nc5UjRDJJ42a8K5Zu8WuOpm7LY/d0GwCXaXXbXvexxR1RcTLu85?=
 =?iso-8859-1?Q?K6jpTGuzPaZzgR76OQC/9i1QtMyeoPBWWpVOUjXl9cxuIFPsD87pO9NyH7?=
 =?iso-8859-1?Q?dXqQZ4ZSsS6bWjabWHHOJ2rPoxf4oLhEaQASXhoAtVlAXuRRSL1yPILkit?=
 =?iso-8859-1?Q?IwS/VvAqn8iF+PY9BmhntgBkcxkwZHnkkdse/9kWnt5Sh92j7AHPVWReKn?=
 =?iso-8859-1?Q?0W3b46g/J+g8DX5cgGbyF0k6GKER33nDu3YH4aBs6z1HzHiAdUMG2/DJgp?=
 =?iso-8859-1?Q?H4Pqo0Qs3UdeOjPzYN0XDJGnK2muiOJjE8yuUDx7zsGyOzReWLoubwXrAN?=
 =?iso-8859-1?Q?SCT3IK/Ct98FXcUQ7G3nOslC0ZlYUOKR8CRgYIHoYmY57PMf5okfoEx9GX?=
 =?iso-8859-1?Q?XuYyFPEWxgbXZZwTvyJJItlj8aS3Kfmlzt7ObIgOc4Bierfo1WylNoKKTb?=
 =?iso-8859-1?Q?A/V8TFV8ugNFS68E9SOIKkL++dH5VQmh6Efmt6RSfUjr8UEJ02iWEWGw5w?=
 =?iso-8859-1?Q?M5fj0oWcb5vsI82w03YKO/dv44b8Nd5VeelWg5z+mECTS6luKa27jWehOo?=
 =?iso-8859-1?Q?BMa+WumFzuroF3JIFBWkYrkHsDqGQ37BbwclCWD6c9hA40/VC79GAXD1bt?=
 =?iso-8859-1?Q?pT98siXp52vww6acBECU5DdJYnj/vK/Wag8jdniFJ5L3mQykyBOWMU3QN2?=
 =?iso-8859-1?Q?xQMCSlzsng=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd185296-23a5-4a57-3001-08da4fb764aa
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 16:43:51.4705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UGvkoaaQK59KENvqsS7zOEGDHg7Wbo1CLgDziX4U/j4dgOulGJmDcm2romdZwO+s3KcDOuEbxKQ0CUtSE9Z0UQ==
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
separately the 'clock' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/clock/fsl,scu-clk.yaml           | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml b/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
new file mode 100644
index 000000000000..8b59758eee4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
@@ -0,0 +1,58 @@
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
+    items:
+      - enum:
+          - fsl,imx8dxl-clk
+          - fsl,imx8qm-clk
+          - fsl,imx8qxp-clk
+      - const: fsl,scu-clk
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
+
+examples:
+  - |
+    clock-controller {
+           compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
+           #clock-cells = <2>;
+    };
-- 
2.25.1

