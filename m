Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6650454C6B0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349505AbiFOLAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238189AbiFOK7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:59:42 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038B551E6C;
        Wed, 15 Jun 2022 03:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8qB+qWusjPa6Tl3B1F0rV31/pPkBxsD33/QomDeCK0GmQwRo9lmSlvjMALTJJdH9RpmRNM/w7vanLHucJoCaWwuVXx3Ldb03l9/poa2K+ui4MqvFGx7xXuW2U5K7FBhk2WpwSIufdzM5rMctCXyvcO6C56M7Lt1TvCqV1S9Wz/u8R3BFuXxCnzXSbKxdfPWE7JnbXOzdQXT1k23RGtcgip4QgP5xFyPZL/54FipTimlnlkd1j0ycznZp9cbkOE7JwR70gHEoSQW5nnFIxBHScvtKsqgXRKn8jwqr+7HEk3aZ1crbUB3K7R4+mJB13e/u7EWtr7hvsqHr1Kh+ssx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/HH53XkBWHBvSuWeHYKpmfMVqMgzYPu1bmOgPNFPqs=;
 b=BFYfqh2qNiuCiV0fJARe2LZZ5Ii+6ENGfv95/5LiwFJVDVbxIHZVGOREOGRJraWuqzqtGHKuuqk6NuFpr8j58DkvA7nUyucgrYBPR15De3wBG/Fns0xMSi5ZtSFz2GyGBsFVn1uZFyPCseCZu1DtNuyD1gONev336/pZcKMo3FXk7xyHXmuPuES8eqE46mxf85ZvfSTQZDFd9NOnR1RQPZO1WwiWfUOWcMohcdb4lS0sDgCDzUWP80tHPLhweN1YZqy8v5hmoWxipUDUNVd4S0srYaUIJyzLF8jhd91OpEB08uh6ycWwifZxUVArwILIN1BChqxus5dJn/51A4q9Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/HH53XkBWHBvSuWeHYKpmfMVqMgzYPu1bmOgPNFPqs=;
 b=QZuW+HUPXF9jFVPS/FKgd8Bn/xGy97eHzl0keUZdwLuHMjpO7ynZ9yQcQyW1/tg/pXhi8uTYIfyxYKDtWKx2RSq4tHV85FK+9lxJBlPRIJx1pHbSLDumpdKJxAQKJq3nLEGwCSYjHXglXOxUCYtHsq2wYESClvkTGqZaNhkPHzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB3PR0402MB3948.eurprd04.prod.outlook.com (2603:10a6:8:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Wed, 15 Jun
 2022 10:59:39 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 10:59:39 +0000
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
Subject: [PATCH v4 08/14] dt-bindings: thermal: Add fsl,scu-thermal yaml file
Date:   Wed, 15 Jun 2022 13:58:28 +0300
Message-Id: <20220615105834.743045-9-viorel.suman@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 332688ab-78aa-441f-3208-08da4ebe24b9
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3948:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <DB3PR0402MB394882AC13780756343378D592AD9@DB3PR0402MB3948.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIKCj7za6NnxVWf0oR5AU87lUftz9UYviO9LDGFSY++0F97l6UhC49Tz22YLbzjW5aOaQ/74wHVAvVHd9mpoLfn5bp2t7tjS0pqmXfpFLdB+EjR067gvrV+9suJ01S4rxBvPuB+VtdsGYu4gFjjzCGeFkOHKKV0yVSJkkcM89dW+cbNEl1rQxVqmv26/2pWwZhl/UnUxcjf0WAFxyYLTKorqov+4UGlcC1DmOj8w1Qm5jb/WxTVk7/3maedozlH6wh8ZBXiJxJUrOsIU5p649Mff8doHCpAGcNEoDGjAfLgQN1LlIqfjHW0ItW/M7vMjYWTtrCoYbkqXXk4NV24y1uOOKden8ZoGqpQhrtK9r+epnHR1+S+D/Hd3vVPLljkLgmyMTjjFuVJMIfMbCoYdiab5n2ff1r60JJdsBUh5IjbnXcy8g7TgruPRgduf4kC0kO3GtgvhDMkIH97NIcv4nGzetjeN6rzzIbIKRQLiFIIgIaxScZMAdUj2g6hrcMD6ZRdadVQ1c4bK1dH2X3wSr3px2ZQV5ptX9GBiPe1y8zT6CxifqNBC4DGHCTrOVNrf6HHJVJj3lloS+3xKBpxdQ2lvkN2FbRyEYtuepPeXfTw5bhGAPgpZunphWP6eT//IibyFXxYVqrN77zzfCo32padBKVLOIvAWsIk410kIRHylUtFnppKjRj1srF+NeeG7NM9wPnjvDZZUHHX6IfC2qqDTwDQc5XygAcRW9hbKnJw+JKGLfWfnHzAUAUr2uz/zTilDqD6lW1TrBov85kvxnOcN5WRCPNZNiOu74uKKc3cCc8KVe72qBPehoMQUZ5DprRGzIU+oV9qlabZrVt2BVwB6Gy05W2pwucxhbliT5mg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(26005)(52116002)(6512007)(44832011)(7416002)(2616005)(4326008)(6486002)(6666004)(508600001)(186003)(83380400001)(1076003)(8676002)(966005)(6506007)(7406005)(2906002)(38100700002)(38350700002)(66476007)(316002)(66556008)(86362001)(36756003)(66946007)(921005)(8936002)(110136005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qmu/K0V3D56cjaYPFSVY8+Tazvxm4bSGuM3Ec7jCvsK+UVm7HHGb32Lh0e?=
 =?iso-8859-1?Q?PYXhq82pjM36g+H6TdQSql0hf2yvm7uakzA2uUgSy/Sgd0v+Ck8/41caew?=
 =?iso-8859-1?Q?81nqD2nCpA4aSU/CGZDaEG7hjgcwkr5GsbpSf8e1xEKyMDabLeUA+DIz/f?=
 =?iso-8859-1?Q?qsUWK31wXm0CaUyfeV0A+OWkTgMyNrczeMnCsNYa/EOX31is0hI1rHZEd5?=
 =?iso-8859-1?Q?LtEj6Yf/SBHP2U04DkF1eIO0BOTUWG+kWcBBaUeiUEvZHu72fA0nVcJM/T?=
 =?iso-8859-1?Q?VhZohe5zhE2TglKTFra0eF4jzL5n6i0X6poOPFFSJ00OE0+XEFzlx6v9i3?=
 =?iso-8859-1?Q?+FQ9AGnns3O715Pu1h022UpRuQHW8xvOCIEpsmzqkKQndXiN2am4YObgTx?=
 =?iso-8859-1?Q?FsX7vggTm0jx0D1piom4DxssjOmOtYA4Pz1N1Pa5XIXNdoy2THUrEFWDfl?=
 =?iso-8859-1?Q?648KB+9XKcncAoR6uwYZNrdwjAryidRL0Book9xMbQTWaucS5zDdtFV4MJ?=
 =?iso-8859-1?Q?2lEDg8AoXKTG1b18zHrpg1RXRIeKKyKTI+6O34Ll+V/kt0oT3k9Vjd6BJI?=
 =?iso-8859-1?Q?IFveJXXKJ4qSPKsEVkfNsUnuajjV0Hu0x0iYazl2TwqCw+U5RDbY5JuQPK?=
 =?iso-8859-1?Q?+cOVkbGjHL3vsnns/iFZC3H9O8rspYMMa1xnrpap1pyah7XQrHnm7gOyUf?=
 =?iso-8859-1?Q?S/pocSYqEXC+vakGikLWG+IP/evx5RQAFLpx/53o9Kej3rbjy7AollEKNT?=
 =?iso-8859-1?Q?e2wkdh72Cr38t6xhClGHmZVw6c4fTnZVYwecCTQ+MhjQsnTsbCzPxfezKI?=
 =?iso-8859-1?Q?unzjbqtubQA0SD0u2Q294YD8NsF5UZYeq7abhkPyc3ve/15nuFQgjyoxk0?=
 =?iso-8859-1?Q?5AJ+hGDmR4OqZddxNYbtMxWQFwjE8YcNTnrxwiXwcsqyGVFL7GOTGKMLch?=
 =?iso-8859-1?Q?kPlbQEwwj6IcX6/VyNMCAJXN91rbvlW/s95oW4rMQEPK5BR1YAM0FkFgsB?=
 =?iso-8859-1?Q?zQ0vNLd7RWr8h8T126HGZyjhvOQxEuzphXIE4iKMueiagSq7hfyLy5AqgX?=
 =?iso-8859-1?Q?oKmIyddPUiMm0XTAUZBrUBq8j93aIVCDHZj78GSkCREf6XoDKlTj7uvQaq?=
 =?iso-8859-1?Q?H/fy2hqZcyGVWMaSBIfzfIOPYKmd/A9VoKj2VtQ0MgjkAY0oO7cBKC7XAI?=
 =?iso-8859-1?Q?s3AjZUNlHRIsOX+7lAc1OdisDlRV93nYYro3IzpbszP0dGGIAkbFqC5FJF?=
 =?iso-8859-1?Q?u0KdDZx9y8SejKGQASvzzvRchickcWeF5+dWeyfpFoiAQonJ+vV+hpYAl7?=
 =?iso-8859-1?Q?kc3MKtCKNOGOSW6874N/eGH+MHoNuts6y6/eOqUtVNx3RbuCAoZeA+BymC?=
 =?iso-8859-1?Q?IA+hhK780YCSOLoINEIAbo55jhhvG/kAV+HPy1ypie9fZ55LzeSXVkjCCx?=
 =?iso-8859-1?Q?T1JmSx4a3qnmTRhNwPIlaLYTUpWYxg0aDSsKDdO8cIc/OhRsVDBnDnw1vN?=
 =?iso-8859-1?Q?57tG7w62K9HgCLIIQenKHFHj2NYbjdM3JBeMChHv4h4Mh60yghmXTBLXQI?=
 =?iso-8859-1?Q?HOSN9FI/nhdDpsIKhQzZh5lFyJaJtJRkRXSU725LrSoUoV5dwxynFflgrD?=
 =?iso-8859-1?Q?djRbjV4IHs28rrQj0P0j83xdJ7k+7PrJ3FhgKSE3R/9Za7OK92B0H1tP5/?=
 =?iso-8859-1?Q?X/gHeV/l9caILr/AVX+wcXLIZE0h3Np5b72KQ9cLB26JHH+N1mFZ7QBdFZ?=
 =?iso-8859-1?Q?18bQ6PCOuFN5xgimFLTEk1PrMUo8LqU+Epo3fW5EtQ1eGbseQU9jHYoLMN?=
 =?iso-8859-1?Q?XO6u5LTr+A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332688ab-78aa-441f-3208-08da4ebe24b9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 10:59:39.4622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7WVJYPBqFBr1odFqfXWo2oNxa8Y0SROvruskku+Lzhkri3uObgiLeFB1uBTuummu3zc8OW4tAS03+CNT1c/rQ==
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

