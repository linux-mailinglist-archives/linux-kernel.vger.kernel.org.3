Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E577565B2A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbiGDQRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbiGDQQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:16:52 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60085.outbound.protection.outlook.com [40.107.6.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B31C1260D;
        Mon,  4 Jul 2022 09:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJ75qjMBEnHQ+/Gus9D6S35kgMPMfcFqPLwTXpLOo2xUGFnozvQcODufPaj7aJ/4QduPvimEhNj08nARazejHGy29B8N34a/L3BHQkpvjiu+olVgsKN0916swVw+G1+uKmSjGkZXmoa3hRO8fVnhVtgkSkb9OCogj2ReTDc7l1aDM4ce5ErAzjM85iAuB2sM99TqVt7sbomZHHiM4+nytrGXIsQJZn4vQpsTHY2HL0Yce+ZoVuU+RGFlvnQ32qaetGjZLHxSKeCrbW64O/SFbSyaUCDFqqgS1vPXYTwg1S1ohwqqTq+PFWglZcepToVJ4dWjcsaMyY+Q75A/PSqoZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTEU/JpiS13xyBpzt6oetQ6aLL2fXlJRj2zpybb9LQ0=;
 b=dfUUdRc6B7u0a8qD5uJsiD9B0Q1ut4jZQSqhtIkt7mNjMx/Tuw7KdbSWxZMffzVXY+b08f5alnLpT+483GdwH9iNK8CP7rNm7HOO41ZqxSUfiHyW/BTSOkSxdQlnLUIh9VNBc68+QvDSyi9QSXmX+paDZo5FHga7QMKNccS4tbNJbA5qzeyS0qdxMrvqcPw7Am+G90PxUivAuJh1JXSgC8f2jLU5LZCR0Y+tIFXdW0dug1qlQ+EVeF+St7xSW2QTRj68/ClQB+kbpM/csWTuk9DSc3dr8Nvbd2Hf1nm97TtYTvBrzai4BC0XLgLWYVn5r+g8XlC7VHK/j8wSbFwBtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTEU/JpiS13xyBpzt6oetQ6aLL2fXlJRj2zpybb9LQ0=;
 b=gK0zT4eSlLraA3lOkUL7WztEkvhDFAQVgBklG5Sfxp9fNstVgjLkA+gyjWg9BEpnYPxf2P1JT5t/+6hTSRXz44aYDYMDFR5ZDjEcfTtoRARnFunRkjvXAKBtlJyOzEBwXgJRrd5M8+GivvL0KN7lfRZrlJ7mdz3zRvEz764cp60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM6PR04MB6293.eurprd04.prod.outlook.com (2603:10a6:20b:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 16:16:41 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 16:16:41 +0000
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
        Peng Fan <peng.fan@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Viorel Suman <viorel.suman@oss.nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v7 07/15] dt-bindings: thermal: Add fsl,scu-thermal yaml file
Date:   Mon,  4 Jul 2022 19:15:33 +0300
Message-Id: <20220704161541.943696-8-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704161541.943696-1-viorel.suman@oss.nxp.com>
References: <20220704161541.943696-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0008.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::21) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8402d1b8-bac7-46db-6b72-08da5dd8943d
X-MS-TrafficTypeDiagnostic: AM6PR04MB6293:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRcKX2RBOhZaAy89kBzWYQZGnnSbWlHV08fFZtL9KBPff7Tgn3U4rWKP4cZd3iRULs89xVhLFwne/1XLpzo9LQrYIuyjQ505RJOeSM37J18Mjwx/4wGP/HmTFYG4zTNmiwpp4LvR4gc39xbGshJS5ea6/ekuVRLZyvZFb836w37vMWRjp3mHMHgCT1ZOWejjwSUsQZqKlhkD75yDg2fBQId0+hc09tKj8K6iFO/qpz+h63pXx+2ZRNXTninQlkyP2ZfCf1dlaq2ItxnK20a+wNIOFFqJ2gyBBtM3lwapkK7/TwjxnGszC/YfB1ud37VbAAlyWDPNb77/ssPz3hP26qIHrYnhhDzyc0DkShKo3iX81KXGKKWZH0/LQMvFrPeRN0kf+O6PpdtEo17/zAiUF+8mCx7/Y6ba51+NgGfW4BezqwBRSQd2kt+nsOwNjazI3cIfaY+JlUWIElR4v8mtrMpy/P4c75mtmOKgYam4Ytp0XnEMTumB9+CPix2Ji0kqUy00HnMV7faL4svxsMTs5zSmdWh6X1RtCgwXwjnjxgms7aqykqZoS5Ll898LmLyNuj7apPFujqfflAfwFEltf+6R1TIH/F1TR5KC+yCyQ7r0/n8HJy6EyuOWXEnvHOoKgDwhbPynhOE56hkQ0GKWlnjmsY9iM0i8Amqlzua9iN0sVd1HoqyDDNBFwfa/IbNFoLCjnlIrHzH9mOzlXxbURlcu86Lqg+3VqiWeaOEF1vYAw6j1DAyy1Bq4Bgqswe+aR/W4/Y4xQmd/d1+ISfrWHSIKorFKiwGvQAgPMJlkQ6nKnquxZh5cjYTbUGSr6MmecXx4S0drk4wNtDz3gWkaGaPu0IJNB+NxTO3HDayx2NZA/AcmXmZLLI4yD2rQHnFO3eMP6h0drG3VeLMuUJMfVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(2616005)(186003)(1076003)(38100700002)(38350700002)(54906003)(110136005)(66476007)(66946007)(8676002)(4326008)(83380400001)(66556008)(316002)(86362001)(5660300002)(6512007)(7416002)(7406005)(6486002)(966005)(478600001)(8936002)(26005)(6666004)(6506007)(41300700001)(2906002)(921005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?KLsXQ+rtEeN3rltXMK5mcWrHuF/s6Y5EakUVMYNd+gNBPJsMJezuFoQtE7?=
 =?iso-8859-1?Q?XGEENzh397fJ9rj6RYvOJpcixzVrACl9SmjaZk/9RYrc4B8kc/u4jaIno8?=
 =?iso-8859-1?Q?uM9/Nmolwvzj/U5f1utsJizOAhBm63nbZ++H/GoauSSj+ZpqhEBaOfIOje?=
 =?iso-8859-1?Q?93uKUYI3EL1AzNYK4/GEX4869Qt3RRliwFur9ZZjsVSGLiG/t0m6rKpuaZ?=
 =?iso-8859-1?Q?KZZ4Hp5PGVAtWNKIPVecgtOlF37BCqyf48rsndUGqK7uCy67VrxRSknxcc?=
 =?iso-8859-1?Q?/yTZSx7sNoZoQTfx0g28ESH6tQHjg/Y0OR+uB99EEzI1Ixgxa2EHDTJ7lB?=
 =?iso-8859-1?Q?Gs8Yvcu/8UiYydQJD5dsp0YsiXjJKdGZEnVecS4LPaIqFM8nFp3XKldZ9P?=
 =?iso-8859-1?Q?u08jzzr+e1biPu+n8MpHQbEAHhOl53myxyVJrobbC7jtyWnSlM5EZeq2EP?=
 =?iso-8859-1?Q?6xqz4wxmLedEut07kaMTb0OkWj+SHx9TrW6HLuJQ0jzF0PhUTH6l75JJQu?=
 =?iso-8859-1?Q?AEbdao19sTtYsPJGaDpJiBLECcti333T7pzSGJzqF1Kez72Mdl4F5YYfil?=
 =?iso-8859-1?Q?qCrqOTHHG63xk9wcLEVPnjoOA2N3ecni4yByj3vSN5RLQTf0nLIz4zCtx5?=
 =?iso-8859-1?Q?FGYlK7jhme8orLBR6SD9DpDT3zyqFoEiXwhw+MGkPkN4ggPxMKj0SsB5jE?=
 =?iso-8859-1?Q?1cO4Qt61MlG9z4GYtABOHjP9HCZP50F/+q3Epvc6t73inWaosZY8y/6Fv4?=
 =?iso-8859-1?Q?8w+k9wfIHqiKWK2qqKnYskc7mB/xNVDwdDPXmAL2zzgj+9gllBvOaSFwp8?=
 =?iso-8859-1?Q?IMgz3DVyuP95hzXvW1y45ypFZcLaxPPsWE9Lpnb4d6lSTMyG2eL6FKdQll?=
 =?iso-8859-1?Q?BWOLqrHT6Yakmj3LTJ3emjXf+/dJnm90DCATUVvGWElRBxovDq1OvnQqMa?=
 =?iso-8859-1?Q?8CgDaJw01+vzwmtM3JmZWQ+Hvrv54OVZQkG3PDyZuTt/5FoQPm3YrX0btG?=
 =?iso-8859-1?Q?1n80mr69H+F/ArQ8JyHj4ZWxPUGIiFFjkmVcw5y7XNqVLa+cgIG1UxhhVe?=
 =?iso-8859-1?Q?9vqES6GpBnRZvW1VZ/Fstb7qmafIeE9cyT/V/GNwPmog9h25/Y4wSSl/Jv?=
 =?iso-8859-1?Q?KB/aLsWSK2WJhlKSISXn6/6mQrgdKphkK0s2+tPYpuO7wUV75Nx/QSoEx8?=
 =?iso-8859-1?Q?GC/+0ze8c0aIZ3SQbqEVSrgs3UnfUwrIolsdtbj7q2xKZrNYjVZ/TERUkj?=
 =?iso-8859-1?Q?FM5kej6iGEW3yjtU5zEuaY0PVqvNVyU+XuyMuaC/oKDU5mQLYRcDMN5kn2?=
 =?iso-8859-1?Q?ayJSbH6y79eKEf0uxV+dBDrxtM5CXkjRo5p51Yl72rgbbd+1LDVhVIBgvx?=
 =?iso-8859-1?Q?KUbdz3c1jMwl8abZYrnBBvmGmAGWFnVF5wLm8vEXqeiIF3N6bC0UUigNOl?=
 =?iso-8859-1?Q?rWM3ou29UhLwvvPfTx4iXspw48krz+Ni99/qGloz7kIoe7DCVLnCVGpCef?=
 =?iso-8859-1?Q?itc/2o0JGFDsSaykOqid03dReVb3gwzA6w9/uFkDfqQSuST67GGRxYqY5f?=
 =?iso-8859-1?Q?RBv35mrH746F82lrV/7444l3KWuY0zUAwlcpsezOwRoDPIk106Spt+U/MU?=
 =?iso-8859-1?Q?Dwl4cBIoihSryEdzw8P/nrypGYXa28P1Sy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8402d1b8-bac7-46db-6b72-08da5dd8943d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 16:16:40.9281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ha2+1oecnK9pERtk3dF/f6/ZjXtRFYiP1jtnZF4/aNJUb2LrklZLXu5CIwXw8Jqm7Sepp8LJ0zdYxnh77lg9IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6293
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

