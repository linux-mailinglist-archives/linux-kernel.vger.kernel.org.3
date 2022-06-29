Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8126560645
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiF2QqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiF2Qpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:45:39 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2151B3B3F4;
        Wed, 29 Jun 2022 09:45:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKPBhpdTZJugYA0pabmXGTqWH5hVBniDsQxVVHtjfunh2u7BTrWYLhTlgzNr6Xfn0WuHI6xCSf2ad8bhThJLx5Nsl0/YOexqnH9ddrSDuC5X2dlQEkVwAb5H/TMjsBJ+KGCpMNEqc3iFml72qrw3tFp8UgTEpUc+Z8FXr6LE+ow2hK1K2cuOJFe317q0DKKa27f8J0oDFfj89OgWgvqgNClVvYJgWKP2USMe/8REJHvD1xEdAaCArClgIqwzX3XAiTvXK0EdArLLmfoSvkjWQxeCI3W8+4nITtVDO00S2KvVF/PXXiB2OM4Ft4mYjH/L2ma/F1nlGP5lGCnrWXB7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNBlNWQOxnUtse5Jf1EEZxiokgeq3c4mg8BDW7yrYBM=;
 b=TJyRmalmZGMCFEnS/6u4txpjjQM3YmHuvEd0i2quSW2FYIYTe4cJ8ZBoW3Zr/EMj2QMlIKXv083HvtG8BHJFcKuYr/dPov8yLSrI1KaEA/fn1aUFm64dxNUl+/Ij+gbLxAbpgOHSkt3EOJk3Uz1V4lrw2i63tUygrtiyYcIgJbsefN7C2xUdgjBe2cuqq9g34E4GAsueZhYJpaXuzGynjUWCKylD+o1JjqbRSmmTbVl2QkWTBAglsQ/k//ESQVHDNDuw9Rgu0flJT8NHpY3CUvcGkQbhxQizBBIY6S0GO2vNcUIpfhg+o8xqAWqdK9LzJOlivoV07x12q1FuVQg1Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNBlNWQOxnUtse5Jf1EEZxiokgeq3c4mg8BDW7yrYBM=;
 b=jf7O5o2UYhoh+F/ZDcuUsMQ7fVPYOHTFQ29F75eePH56JecMKycx1h8epwOIvpfbuHzuOB4xQ4lxNG4sk6/NxvnhofL5tD4MSM1USTEI1OFApp2kWAZittcz4LE+GI/mZIDuLbudTB/Vkt4WIMSREbx1F4kBJkGmSDkmj2GHxss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by VI1PR04MB5840.eurprd04.prod.outlook.com (2603:10a6:803:e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 16:45:20 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 16:45:20 +0000
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
Subject: [PATCH v6 08/14] dt-bindings: watchdog: Add fsl,scu-wdt yaml file
Date:   Wed, 29 Jun 2022 19:44:08 +0300
Message-Id: <20220629164414.301813-9-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: da75d4f8-a10a-4b6f-edf1-08da59eec0da
X-MS-TrafficTypeDiagnostic: VI1PR04MB5840:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DxpvTqZa60G0DnM08GxjVYm45/1LWa/mmwm64wxe+pbjv3FYExU5QurUq1mKnUopq9Y9NwM706wUlrRsT0aCZ7MEmrrFKevGQXM94N1TOxGrShPTQ2M8eEt68VqKjHfHPa7Lk+lbm+h1MnqvG0uO4A4lSVdQDefmIoEyX86PmGOb9bCkNligU0V43g9OAefkj5ji6+z5lNkxEjN+2UEgJjthgUyxoLZm+VhW+9R8R+XfegaiEdkkcMOqSr1za4z8aT59ec4+kJakU229TJbaGD84VjUnEip5RSywaaD/XHbrD/nxty/HgVaidLW17RGy3KFQcjQ+hraWj/rEBishIUnK7wJURhgrog4GmM5xXKyh1mvbJNSS+r4itIIm1A21xeF1Ej8hCEUIvL1wDKgydOxxniYqoGQTRyvtKnhS+COxnvbw/35Pq4nm82yZm3yd7/E1ItTUTthP+vZF3Pn1Yx7T24H0BF5a64gk1zL9qfyQsKcfU6+zr2gqfuAW5hbQRSbwNg/UrGRD/TdScDgC0bwFcst/SNmlHbkBGbnJPX04OZXrUOsnbNofJg1491hYD3v21rOtQjQl0HQmu/3oV/p5Wk/iJjdjKkAJvKJ8goLAPoX804rsnEWJEwtBJe4c/xBS5jAzhzeBpDO7E3j/ey093Ns36loap4eJmdcaZIz5VIWKT1UfBd7SFGu5r+jBfqTNbjGJp0Q0i6iBrMH31Kv8I3Nyl3WmGbq51zgeLvH1mxu4INMS0Rzz4ZzHH7zfSrIPzmTaQssfEHQZvwTzigbAeZPQuOgGOt7JASjbhQLzkz+4pPqhyy7iYQif/UWVVqq/+Xr4/R73gRDMNdoAnjtKTbYN2sb/7wawYiQ4cisUSxdWNK8PFZiFbd8L2Yb3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(66946007)(6506007)(26005)(316002)(6512007)(66476007)(5660300002)(66556008)(6486002)(8676002)(8936002)(52116002)(921005)(38350700002)(41300700001)(186003)(2616005)(7416002)(478600001)(86362001)(110136005)(6666004)(83380400001)(966005)(1076003)(38100700002)(7406005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?n3ej9vRxSyevHStG8rPbEbP0/OKJ1Cm6LJa8nsT8GqvsGyQ8aWFVjUsBOb?=
 =?iso-8859-1?Q?Qk00red7AChfRs3yrSyy4hzRFFKpqchyEjGl/i63RgTOsSPZTfHbXGreay?=
 =?iso-8859-1?Q?qlX/5tRiQlcj7okBx3t2Mu4W/kE76tcm0rlwKtA3I8YDP3yikuBdS6FirT?=
 =?iso-8859-1?Q?sxeS4fCnehUqRD+BhY7n75YlpYUwTg5IujPwWJIXkgWK2nBBABj5nGmgWi?=
 =?iso-8859-1?Q?tWNO08LVV8cPvN1f8oYvpLx6Q7/vESWNDwEZ9fktsLqn3fVDEOnfel6omn?=
 =?iso-8859-1?Q?Cu/kgD+XYS15Eh82f93XqVAlBd4QeOU+Gm/bBQ1OgHoARTtsqhf7aN6qUB?=
 =?iso-8859-1?Q?RTu9/htjFdu2JIWmwH+/hSJ1RdF4t2qjP4o08rVeA8w02HB4IOVymddD0r?=
 =?iso-8859-1?Q?9/1J/rSyvj6h8oWAn44Gs3QaMEWiyL21VdAHIIEcKQyXWnq2Oi7EULiKnj?=
 =?iso-8859-1?Q?Q7z6csy+3HcZDtLyBSVHb5KifmYNL0vMXAVNg0cAINdDYRtiS/N0sWbyLC?=
 =?iso-8859-1?Q?e9v+Gg6sOP0Q0C5j0rbB/pgm2hjtaOr5k48eqjK3yO7uQSWx8m/RkGnZSJ?=
 =?iso-8859-1?Q?8IMz5SkxTZn0wavVve/MV2yxr5l8PL2qgY98Ljx7KkPOUmZTr9NSzfWyaB?=
 =?iso-8859-1?Q?mqXDzKzwxNyeryZj8EyPTKv8+N3bSQNOve8T2oR0dyqJ4jf+F1cnY6IaWs?=
 =?iso-8859-1?Q?y6I/TLeL747qZPF/4lQnE2rGVuEGXzrZC2HoW+XL8ZDjTA8JLJ/jsV+q+Z?=
 =?iso-8859-1?Q?bf69/lYqq56qFLL5vqrPPHkB5RqPHihRzjFdS+vH0KNkJFpNl5qX8gR6r+?=
 =?iso-8859-1?Q?Iy2X8J8dFR7caWbUE/MEm47SiVJV4jieo/mxk3+3gvtwXnG4Cs9lYIWhV/?=
 =?iso-8859-1?Q?s60rFmY0ByLJPZi+BvRl7ny/or5rzOOl/iTFhZ6awgyuHJqTIuv60XifQ+?=
 =?iso-8859-1?Q?iBQjuBSlCubf29TjIVHIFXy/h2PY7Nn0q3CmST5Afd29bgO0Uo0NrcyLOd?=
 =?iso-8859-1?Q?Zme7sj73EzNJeqhPrdqP0B0RzK1i29WM2vRXTqghTEqCIwj+k/LnSFDrUG?=
 =?iso-8859-1?Q?PkZEni5Yvsl4qjy62X2hNijKZXZaEojEO+wI58QWL6dOuZzf5Pp2g+cYa6?=
 =?iso-8859-1?Q?E00cX06b34CeMrePYfv4li8b14OFtmXL9T+xhlg1xNAvLyQHvPNmzxNwp5?=
 =?iso-8859-1?Q?l2Ga46xFnZqCvw7tRMI5pyt77yaaRxg4O0d7pNk08FRQeUkHbNAYSHckWN?=
 =?iso-8859-1?Q?6iS1LjpIkEa5KALZ1z4E8E5gdxeYWA4grBMrQfwoxZ4A4nGDRvxmY4yZIy?=
 =?iso-8859-1?Q?FOYRMnzamQuZqI7bSsJ2lA0KNdVBkpRcU1XXrlKZmS7fuTmAyytjroq7JL?=
 =?iso-8859-1?Q?2r0un8oGa4zqtnmiY4gpuPdw2slqpLbbTUCH+ewtS2NcXHGH0Phebeiveg?=
 =?iso-8859-1?Q?eDPVJyfZy59gcBlmU2wzp43D3HIwThPM6mrbi2gfOfNCzJgDeeP/6R90gF?=
 =?iso-8859-1?Q?fzXRQK232XhTFjp1tsjlu+ffbA6DlXwtehXOS4h74U3wUVv27LK8tLih2V?=
 =?iso-8859-1?Q?/JuSGUlRyG5ZxJzesxAfNSfQkQM1nW5RiecHpP2EU2/Vj/as7+hQpuRv1T?=
 =?iso-8859-1?Q?BCbvHB4lrnw16ZLND0sQK0ggYLj2p8IN+/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da75d4f8-a10a-4b6f-edf1-08da59eec0da
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:45:20.0414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fS6Ij9JtkTbVSZ+qbgRdYWNhR077vQ/IK+/zvH/ZtafjPiNsde1UoIOFKM1GKdjzDhecO7XTpCh5zo+4GRRbQ==
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
separately the 'watchdog' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/watchdog/fsl,scu-wdt.yaml        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml
new file mode 100644
index 000000000000..6403c6f454db
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/fsl,scu-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Watchdog bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+allOf:
+  - $ref: /schemas/watchdog/watchdog.yaml
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx8qxp-sc-wdt
+      - const: fsl,imx-sc-wdt
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    watchdog {
+        compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
+        timeout-sec = <60>;
+    };
-- 
2.25.1

