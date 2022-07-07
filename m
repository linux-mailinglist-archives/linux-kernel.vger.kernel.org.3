Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA2F56A265
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbiGGMvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiGGMu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:50:58 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89E829C8A;
        Thu,  7 Jul 2022 05:50:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FONDt/r4pgh4JJ06Dsp2J8fPITRKVWqQ8p2RMCZxTX9Q6OERpEcoSk+s1odOnBTapzYMH8CcFV05r6d6EXeeZI9+MOKGiwnAtULIV4+QoKP0+IMuXwpI9BAet/5sHKzn5HvTUghdy6rkZBw8/2qSl4DABqhG3eLzdUZvip/z6z1aycTLd0Hc4NNwIykunvIuZ2IH+sHFjvb7OxuShOZQjC9n0IOSOZcSYNpuPkPujXWqwVlVuuWrHNeo44jwSdxe7DkQgxQ5y1KVtFoywoyhDc9lzRJi9HrNf6jpBhDFoYXsLJgh+Q2igWVBvWQncd0zl5iWqYr/sMFSVxpuU3pkQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qp5odMkK0cVlovcm2p9ZxncL1AdsW1Jx0NTID7E6cgs=;
 b=Y4jaCq1m9DaWX5aeiJsMv069x8pCUftePb/WTMIo0OPNynqeam3djRfzp24/sitIBZECKdZiG5ut8Jl3yvqnIBj5Qqjg0SlfbntaaEAwK6tpXVJVwD6P5Wg1q66czhv9gSzhpbk+BtNERBKHgou52ZBc+wifLT9NWQ6PEbS2LgmNPgrslWCLoIaxLE762Les4xLYNwsxhfB/oSR8Se65hbT8r9vFIrv7tKDjqu7JisBtV0h9uNG7UFq2xuB0Xv7LCP+go13S7L3LxM13QL2rHWlKtC12RTcvulppneBXn/iiktnaWlIXeGaG78smYdYSNHcfNfMvuFOEJ4orbyNATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qp5odMkK0cVlovcm2p9ZxncL1AdsW1Jx0NTID7E6cgs=;
 b=BTt1SB8bPH808vHJ1Y+chEQju7xpBEQNOWosV2y+mcoEhs59metLv1Pt+fHx70XYrajHYA9mkPqhKA8mnpptvZEDprQRD1cHXRMA8fE7y6QqO4dej62HPkmW4nK8WchWQQ1lVZ0OKk0MB83BCJbGc1pVvJRQAbEur9EByL2sGBw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR04MB6418.eurprd04.prod.outlook.com (2603:10a6:208:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 12:50:54 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 12:50:54 +0000
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
Subject: [PATCH v8 01/15] dt-bindings: clk: imx: Add fsl,scu-clk yaml file
Date:   Thu,  7 Jul 2022 15:50:08 +0300
Message-Id: <20220707125022.1156498-2-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8901c54b-59d4-42a8-931d-08da601753ff
X-MS-TrafficTypeDiagnostic: AM0PR04MB6418:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C4DRhIFRettsswXc5GGsuiIinrSdC+ZP9szpg2ce93akEJRxsA6075oyTszL4yisPJ1KDDPMWRCn8H0gkGWdfte5R2xUNg0hQT88lb25IgiRU1MWax40PFyGBHMqk9so1l1UdQCeIS9OqOduEpWfrt+KdzO77igk818ZhKhtuOemScKyJ7YUNBoX4ILRgi021b5MBxotryL3QblD+CPuNtl0zkyKNQOKHOoQ7Gg65r04PQ29rR081qDVCRtNzUjimMNjTg1Dv6Odq4PFWmBNYucZQtNgn1olU085nQjCzhRfRzl1Gb+yJdVeUYEsWeLzL4LdDuYpplUrYCBy6ZSGNUulFrykEEPngOFsx8gdVl5UcA1zojm4YEVaRBSF0PjeaCMWrnFbRdkmBY5Gi0QSomfgFshyRR5BvGWgp/7xx39HdXz6YLbFqsYZ4+JjO+kbmwPj7pdM+w+7Z9cnH26V0e+8qbDcjx+EEbEBU7vhq7bEWGKqhkvX5YqHgtVA4QglhGQQylw/waTTAaiatxx4DI825Ju08/gsfT7T2mGiDODxsm8OEQHMdm5dRqpoL78ODNMHVxsA99cvm/javREuTmi6eCanPcMbYqofy9dWam083Oaq9gPYm9szgJpM8EqRGnYYuhm12QRCnrv8b3c6/n3W95mBLJ9YiWGwDghakJCcOEaVbH6B44rq4OZ5nJqffkhubukcqmDiZslUFnjV2/ChFe2v5UghL6MlL6/3oVhQVRjkCHzkIEKudSy9DHIqyvV1TbtT16GG4CsNmfnrE4CZdgL67Di4lfzMSWmXcgWwNj9GMmE3yYPxMEiE6o3cgnb5YWXehUJpBi/W/e51KIRF+SOeoGO297i5JCVARgrvcPJHrso45RfdCGI0vVAxbkCoupgsHwO9LEFE4Zb6eQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(6666004)(86362001)(5660300002)(966005)(38350700002)(6486002)(316002)(38100700002)(2906002)(41300700001)(7416002)(478600001)(921005)(7406005)(66946007)(66476007)(6512007)(66556008)(8676002)(4326008)(8936002)(186003)(52116002)(83380400001)(26005)(110136005)(2616005)(6506007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?egDD1v8IAwVTzCtJ/Js4B/uynbLx1QoNwzgBNa42UyG5UimVfuAi8d0uju?=
 =?iso-8859-1?Q?r5Aaejm4bRiON++3N/VfqZWdEoNHbWFIIlwV3fh7Q4TATQos1zsrzHaaPU?=
 =?iso-8859-1?Q?LBtXeAkvOwcsE1a8dfDS+MG8kpQdPzRkv6DYv6cE3UykSg0sGSMhA8DnPv?=
 =?iso-8859-1?Q?vuQxAbAXnyy+++lNvMznuyWAbvkQthaNd9aCe4jMcbUW/1A9P+m3D12SQC?=
 =?iso-8859-1?Q?F2NgnQ31NSmYnM2Tk8EiHmRTuotRzp7ajRGTU+hDvg2vJnq1E2aHDO14dI?=
 =?iso-8859-1?Q?QzG7P9OmEqFr1uNQPoUlob7vgOqjWUj6T6aIt3rotOtsob+8KN5Y/c9dl7?=
 =?iso-8859-1?Q?n1lDi4JkETTCUTqvOevzbwRWdDezx9NAf1prQmObgICPjrW4Ui54MUMhhQ?=
 =?iso-8859-1?Q?bKMU0MxBq5pqXUktA3/5Vo3N+Sx6vJatyjDktLqyiek15heA9/0ueI9JS/?=
 =?iso-8859-1?Q?0tt6KsO/S7fdjX4NT0DiE3EXazzyaJ+XgWznktyACRKua0qFcqYS5uIHWZ?=
 =?iso-8859-1?Q?k5VilS0wPMGkcvVx3WxPulk3Tj/D3cESkhLxsIhOXANokRNf0t/iabHSpk?=
 =?iso-8859-1?Q?pm3qE9mmam19GJfKVQd3gKn1PP8DBftWZuApm7PIgIvK92yH3e408oOv+I?=
 =?iso-8859-1?Q?hVCXWrkb8ShW5rfD+FzAYjXajMtOcSCaxmNHbuXz84U1hi2OC80vs5y714?=
 =?iso-8859-1?Q?Vjtmh1rxHXHjCqp9RODFD4uTQ1CoV1HHyQGKwL0So/6A18SNBRf1o210Cz?=
 =?iso-8859-1?Q?x9AHge3DWUc6HMxkQ6y4j15HBEDwVY/K7V2XWbzJLS/FTvljbp6UDpqRnk?=
 =?iso-8859-1?Q?Kd2Us93IGWFLZFidzHpFXy9YLL5pz667LBrN6P0Ux/Mme2r/B5zun4193K?=
 =?iso-8859-1?Q?/bTs0XSm8X6q4T5TvsE6PaOx08TUWByEI/QSfH3lE072xTbUHtjBHZB6VY?=
 =?iso-8859-1?Q?hQaXH7G5JOJRMu66HLlqS3JbbGV1psoWbXF9Kg7tFUki9mKvxqw5zmY9PD?=
 =?iso-8859-1?Q?TGAPx3QIaC0SbPW3AeVlM5mKx/u+WZbFPHpdonxnidQ8MltAkQr5imRC7w?=
 =?iso-8859-1?Q?AYZhUIkLurIa46y6+ULc3FSx1n5VAttXab6oq+Bbb3qkCR2KPZOciJeDRc?=
 =?iso-8859-1?Q?6mEKyzsMbHFHJfC/SEgcyjnFq3te3bxgIGaTPDr2hY/N/odEqCTcP3bR/V?=
 =?iso-8859-1?Q?PoTFgnR7voRnJSW7aZQH/Flw/oTYJfB//kyzsbMD2tX0uQjKezsgJUNbsD?=
 =?iso-8859-1?Q?+993GszeeoQlLqXufn0KTKOFqQIw68rhPez8UVGTp7YSS10TFLrIOuFEcC?=
 =?iso-8859-1?Q?chYNdhwgOLyrd6maGTADwmJsi0jNq34pSbuP1uvGs4PSZuEMXeEkInGMOU?=
 =?iso-8859-1?Q?Dy7JDREE7pCQR2T0Fhx74oPLQEcSO8xGUdmsWTO95oeRIX5pFrsY7azaFD?=
 =?iso-8859-1?Q?WWwiJsu772zhOC7OFGw37n5WgvKKfeTvotM8kbEG0c8LLEh/MorwakIG5z?=
 =?iso-8859-1?Q?7A+26hx9hSTe6SJnjTuZKgU7XGGmy+QpuFTQmn1eViBEKwKiD3P2S+3tvq?=
 =?iso-8859-1?Q?LrAMGBiTT4R63k/l9++6YkTWWN+8dlGWw9IjcKX6lXzxQr2bk+xcA3aHqB?=
 =?iso-8859-1?Q?G87mM3WuLR5FqW7E0zVl6Lzd58uvMsMaiv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8901c54b-59d4-42a8-931d-08da601753ff
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 12:50:54.0337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ShCgDFX7Y1wAZtDI7N1aLgCONAzOqZf8iJseYvAPSat0BXLeHzJzyvO8NnKzTujolDaIHazGTRkRwWYCsE4Gw==
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
separately the 'clock' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/arm/freescale/fsl,scu.txt        | 31 -------------
 .../bindings/clock/fsl,scu-clk.yaml           | 43 +++++++++++++++++++
 2 files changed, 43 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index a87ec15e28d2..ef7f5222ac48 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -79,29 +79,6 @@ Required properties:
 			See detailed Resource ID list from:
 			include/dt-bindings/firmware/imx/rsrc.h
 
-Clock bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-This binding uses the common clock binding[1].
-
-Required properties:
-- compatible:		Should be one of:
-			  "fsl,imx8dxl-clk"
-			  "fsl,imx8qm-clk"
-			  "fsl,imx8qxp-clk"
-			followed by "fsl,scu-clk"
-- #clock-cells:		Should be 2.
-			Contains the Resource and Clock ID value.
-- clocks:		List of clock specifiers, must contain an entry for
-			each required entry in clock-names
-- clock-names:		Should include entries "xtal_32KHz", "xtal_24MHz"
-
-The clock consumer should specify the desired clock by having the clock
-ID in its "clocks" phandle cell.
-
-See the full list of clock IDs from:
-include/dt-bindings/clock/imx8qxp-clock.h
-
 Pinctrl bindings based on SCU Message Protocol
 ------------------------------------------------------------
 
@@ -127,7 +104,6 @@ Required properties for Pinctrl sub nodes:
 			Please refer to i.MX8QXP Reference Manual for detailed
 			CONFIG settings.
 
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
 [2] Documentation/devicetree/bindings/power/power-domain.yaml
 [3] Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
 
@@ -208,11 +184,6 @@ firmware {
 			  &lsio_mu1 1 3
 			  &lsio_mu1 3 3>;
 
-		clk: clk {
-			compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
-			#clock-cells = <2>;
-		};
-
 		iomuxc {
 			compatible = "fsl,imx8qxp-iomuxc";
 
@@ -265,7 +236,5 @@ serial@5a060000 {
 	...
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lpuart0>;
-	clocks = <&uart0_clk IMX_SC_R_UART_0 IMX_SC_PM_CLK_PER>;
-	clock-names = "ipg";
 	power-domains = <&pd IMX_SC_R_UART_0>;
 };
diff --git a/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml b/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
new file mode 100644
index 000000000000..f2c48460a399
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
@@ -0,0 +1,43 @@
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
+  ID in its "clocks" phandle cell. See the full list of clock IDs from
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
+required:
+  - compatible
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller {
+        compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
+        #clock-cells = <2>;
+    };
-- 
2.25.1

