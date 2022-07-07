Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A579956A2D0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbiGGMv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbiGGMvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:51:17 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2087.outbound.protection.outlook.com [40.107.21.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954FD2BB34;
        Thu,  7 Jul 2022 05:51:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4il9YkPz1o980Nkivo8EVCIVICmfGGskHGNSo+Gna3/7seElkn1XXYMD92kSS0LHItPTJnLgOsqMTnVQXuRb1cSRzBW5PiwXiVMmhiYfq7xjDbM4XB7ABcrqzFNBq4hWNGyFcVuDaD9ib1kaMh2bBLPeKmCzYvNYOtTPcfwGF1QiHb8FEDDAJ2b74KM3nBfKuj2vfJGIV/XaDAOenRvqZrJC1dy888pOljD6QUrR3p2Hg12aR8QYBM/x55/wQ+esMpj6aTpmJ0IkVJF0WnQSZJQfUKJx7SmCXb9kxDD8y/3mzAc1ArLq6YX896iXgqZS6e1JFcg/uwWEKJO1cOxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJEnC2yqFMxXIJHaEmgNVSL/KVFhwoIvTZtzI84NBls=;
 b=XzRcyndamh2W6OO/SLEIkw9qM69UjgWC3QvqlrLh27tocZ797xTRW3JHrWmmMNOZFcC3FcO4lBfE1S8Naw6JlLGCOK1EMZdI2QtQkRy5+UKoxxTl2v+QJ+6v9m78nXqDZKhXu5MLI2ARNCXdHhUNjsIxHl4QQlX6b1AAJsxrbHwSUHTd678B5otfHXNAdl8BH8L5ljeK4TJiK5/ydFhK+SKt8etWYeiQiFzZ9LIR1GMNERGUbrM8ii1R1LpG14BIkibtNexyrHWbJvTlIh7ZTszMrDFnlCEgDYCKhITKcSOmRtlcc2+4I7FuOgxqmtRqrVuHYCw6gdiE0FfJn/VheA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJEnC2yqFMxXIJHaEmgNVSL/KVFhwoIvTZtzI84NBls=;
 b=KAYajdKDyVJFEJ5LwxKM3S0amhxMwMsDX2meSFHYVr1vnvbDaEM2KT4jii3sgkmwsQJXHfPjKsVI504IufBTIwvKwr+UP1pG8Xi/iSlxUpqpu5+2puq6pSiZn4495p642QU0ix2olcCN+wwd/3/FNs31QN2CbTznUblAXHlGpgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR04MB6418.eurprd04.prod.outlook.com (2603:10a6:208:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 12:51:13 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 12:51:13 +0000
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
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Viorel Suman <viorel.suman@oss.nxp.com>
Subject: [PATCH v8 07/15] dt-bindings: thermal: Add fsl,scu-thermal yaml file
Date:   Thu,  7 Jul 2022 15:50:14 +0300
Message-Id: <20220707125022.1156498-8-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
References: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P192CA0026.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::31) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b3812bb-3367-432a-2261-08da60175f8e
X-MS-TrafficTypeDiagnostic: AM0PR04MB6418:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QU9Mq27fkPFc11Tp69IHXhpfMwvncwsS6iUkawe1NE52veNUM8XsyGKwxeAJODfe765DNbjfZ7Ak8DRRZvQa4bbO99hGDhu39ksH8T36hSj3LXXiohg7Io8fpUXyKnxAWY9qNi4a2vNmYfg4yrUY7U8nY70erh+En/12p4vZWeNNsbuHOWtqXifuFv/OFZhikCryIKsgzosNdqvcBsAXM7D0gz+ulXqI6HRJZow3YIU1eoOb8qXniuKWK59ZSpMSaXuzM+NMln8/ZM0Px3+rsX7vuH+CtDbFDHdeMWo5CjMmy7fNh/ULAG/ow4Lt95pTHI91yGVtpQuxfeUxsxTBKuKe+nA87aXm8XsG7K8ykwDYu7FSbGsAAO9o4d8ua8PyFsQK8d7XXqjVxXGQV9eX4PW8sMBlSYCDi1V7LdQxktchJbZifLmUjtHBeIP1D3LyEp/EAQpo0OzycbV4I7aegHvOwBJshFjVY8l2C7ggcZrsp+lu3s1qWGetnI+O2pKDWTyYPk5hf8nHFDfqUt/vdCkktTuMIMNmJxJMyV2pxg40u0PsaTe6JnEdsv6OrYNsmSo6aH6KJKuUs4QoQvr0HbXzWG2kOKMcg58EeADdYGX7Y5+rjHL1Aj21JMAtwnczk2EHwVqufv1Vf8/CugHMDgO05SjTrJGr8T21gX4/Wpu4FuGFNrumwNK2fZglnGZnkjn1BjOzIxMxXtPxWTCxy9kHWV/Vr7N7UQX8YmF5HXFytZFmtNPJlTIwqb5uAWtcz+RHT9b2kFIDCGO6PdbrsZ42lhH86GYMBl1NgZSes1QfP9ALsh84JpfyFeENFWiqHjTbEsHL+2VuFF5hig4tAAM1WN+YGOZ0Xqf2zIA6D4+djcWgirTZ5lX5Wzr0yagKTiRNie7LaFPQuyhfSBBQiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(86362001)(5660300002)(966005)(38350700002)(6486002)(316002)(38100700002)(2906002)(41300700001)(7416002)(478600001)(921005)(7406005)(66946007)(66476007)(6512007)(66556008)(8676002)(4326008)(8936002)(186003)(52116002)(83380400001)(26005)(110136005)(2616005)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+s0vXQr+bI+T81xaOhVvK2X05CWKOyhPKyxEVM5Ppl23sQZ9SN7TJ9NgmJ?=
 =?iso-8859-1?Q?Pl/VRkof7EQDwogCb099WyduHYt4WglG7u8zE9c1dLL2PE4hOtDirhUDa6?=
 =?iso-8859-1?Q?ZeBEUg7iPx1+zeCRSub+VUhsv4TuQnGKLQQe/GT8T6o1kGWqaG6981gH0r?=
 =?iso-8859-1?Q?Ah8sSMEHvWbef8rbET/MKjWCrIEtJMYs30YRKf3h79OiNv2c/Acvg7/1d2?=
 =?iso-8859-1?Q?Q8Kn9lc431KuLdnovP8lkdZWGI/4sMsY3AK4PqSvC6MPbQuOcyF7o3doWR?=
 =?iso-8859-1?Q?qmQjQGQlpC2JYpY7gY4/Xuucw2IGcZqJR9l+nnZtgCji57qsXiTf/Kxupl?=
 =?iso-8859-1?Q?nn6piO38fszS7eByrEF5mY2f6+85rjhRPWNrmBDUERgR9FBhKKdvbzvypW?=
 =?iso-8859-1?Q?Dr+bUienhQEhjvNF9gkf0n7xYEzsQuAxkI5UG6vs2rzZQpJrVHoAqXDaL1?=
 =?iso-8859-1?Q?uiFxYk6TtviAT4VcJZSKOhGmymoEbXrLVsbBNq+VMcHbIkpARAV8w6jLKB?=
 =?iso-8859-1?Q?zuEX3oEmD/i6njpD6rUTCecgyhXJx5WTVwzD5yWN7kFhd927X88KI5SIMb?=
 =?iso-8859-1?Q?DHPStzXz3waZGUK8qTP7nag+AKiLHl1qbWTa8tKwAuW4peEGa9mXV6/Diz?=
 =?iso-8859-1?Q?EK5M2cZ2rPQZBtslu5k0GWXBmbyEnOftCfz7XnvpGq1EF5aeM/Jw5fb/Zw?=
 =?iso-8859-1?Q?AtiRCfX0aKvXijEpnQwUW7SJilJfmentofzhInL6HeXhSjc4bCoYN6ASSg?=
 =?iso-8859-1?Q?ha7SIJRQFlw5pxJAAzuuHnPk/VRIL1ASn568boYv+p7269/K0l/3J37KGW?=
 =?iso-8859-1?Q?wy+iAx3c+FmVoBIfmndkXdxJUVvUj6Ufr5WBwWCL8c2BO2B9PrMeh6ZFol?=
 =?iso-8859-1?Q?DbJzT0Uv6J1X8K8Cyy2HFvsUwJCngftGVk+sFw6ey7hoFHx8axJjsypPbK?=
 =?iso-8859-1?Q?VSyf1A7qWML2ldc2SJEHpAK5yQ/bPfUs+/LCltnAYXFBWtwk8RwdPgCZbJ?=
 =?iso-8859-1?Q?pD4jX2SSBHHiyoY5vEB3TJnAgoKU3koMTQTm40z1u6Hu4koo0KKCaCGmk0?=
 =?iso-8859-1?Q?ML4GyjNY5DmHZnHHp/peQgGAOi/Oq6vRT376n2TZOfOpIo85o25du6VeJ8?=
 =?iso-8859-1?Q?cUUxBF8xF09jyYBHoGPDz3TAXUNPi5on0AiaCfmht5Su95E+Ypc+nZuQ1i?=
 =?iso-8859-1?Q?BynDJ9c1KuwKkqtJ6eB3EMG/ifkyICjnJB+mZzKElBTlCha5aKDOmmxwFu?=
 =?iso-8859-1?Q?ZjGsaNURl6SvF0AcgV5wTchmGzO2vHU0t6qigWxteWav+oCrnpDf1DMae0?=
 =?iso-8859-1?Q?bfy3ka4hkAWcvMsmiH2c6m490hMSSdJwheoRnHGzNsoA3XPeet8uGzjmEZ?=
 =?iso-8859-1?Q?wN67MnM54X3NUciPh2aHaHkcsyv5WR9xo9e3vqQKm0MrLEfPk2j+BRxl7D?=
 =?iso-8859-1?Q?cNjglFD1FXCcP0y7Ih6c+nFCX+Hr7W6oYff4ypUZv+M+QLHtkTlDotscxn?=
 =?iso-8859-1?Q?09SRYiE+UX8bf+rt684vaaTgjLkV1Uzey6CkmLp1sri7O9GtaOp81wjL3x?=
 =?iso-8859-1?Q?AS2AgfZHr2lqz6rw5mDGVAxQA01B44BVFfeW5WY1IQQvGm1g9/KT/7y8jc?=
 =?iso-8859-1?Q?SAMPwhF0DwmJh30ED82wH08L3452eI7jh7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3812bb-3367-432a-2261-08da60175f8e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 12:51:13.2511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8Qekc3hYJ/C5ZdtNZEPx2fjL5KAXFtSPjQAWDOP/7rCDnsVz4UQ/TGpxGO5431hJmH7KJFJYgTVpchjbYsz2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6418
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
separately the 'thermal' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/arm/freescale/fsl,scu.txt        | 16 --------
 .../bindings/thermal/fsl,scu-thermal.yaml     | 38 +++++++++++++++++++
 2 files changed, 38 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 6c0161fa4adf..03f927a33281 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -72,17 +72,6 @@ Required properties:
 Optional properties:
 - timeout-sec: contains the watchdog timeout in seconds.
 
-Thermal bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-Required properties:
-- compatible:			Should be :
-				  "fsl,imx8qxp-sc-thermal"
-				followed by "fsl,imx-sc-thermal";
-
-- #thermal-sensor-cells:	See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
-				for a description.
-
 Example (imx8qxp):
 -------------
 aliases {
@@ -114,11 +103,6 @@ firmware {
 			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
 			timeout-sec = <60>;
 		};
-
-		tsens: thermal-sensor {
-			compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
-			#thermal-sensor-cells = <1>;
-		};
 	};
 };
 
diff --git a/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml b/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml
new file mode 100644
index 000000000000..f9e4b3c8d0ee
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
+  - $ref: thermal-sensor.yaml#
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
+        compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
+        #thermal-sensor-cells = <1>;
+    };
-- 
2.25.1

