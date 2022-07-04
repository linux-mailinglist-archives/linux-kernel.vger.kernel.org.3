Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840C7565B43
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbiGDQRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbiGDQRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:17:11 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B1710FD6;
        Mon,  4 Jul 2022 09:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRNEiuNEATPonBC9Z38MHtwyCjLAP/v4Qa/OJ3J1cTsVP+KrCvXYxRerbQpfFg86psAE8WVECzkq7zx92zcYiTydPkay02WyEJSZelmVw1Xufx59VXoWWcfWQIaMwdrs50r4Cc3eP68MXlRgthucsuw9gmH96gbpe5swcq6NgFFR/Mad7R5dBShe7JqJ/wmyV4N/X3AdB2N8JZQGhIUy3D+coKwvq6khDxrpMveLJpzZ6jdC3Um+NjYJ8JkigNgzbEhZHITbgfS9CqNhROXPbFbDzde4YviEQRIujag1XMjztRgcNUVRw0OcsvA2Fx8LmLAokAfdTOK83qYTfxl0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DT3GZRjvqevWlbCR2D1bXMUzASCzP5mlZRxuhVjx598=;
 b=T/NeClQoLSDmA4bnIHFFtbGM40kgUgHxqTkQBkA9NW6sKucexH0HoJ9DrAv8hcksjq857skDzsyc5dIaU7L7dvLtAym9obQrbyKOCuFDgvoEdkjppM+mEDP/GtfdwMxdCS3iigA8bDDdq8/9oFSYZkcle5T1k4vOCGtO2GcRAs7WNrTsKQ78b9QTSPTJS8M1F2YzmlEDp+wWEaUR3D7sUA89cbkp3R4Hr/UkyVdEhDDSOGBFZ1AA6j9NwmXgZNEMV5OlhkXKeQytzggq0hVizibwHIPRozQud61KNYYpDILQOwb8oZg4ybhjgue1AvkAyQPxwl1smXzYLXlCBOTzcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DT3GZRjvqevWlbCR2D1bXMUzASCzP5mlZRxuhVjx598=;
 b=Ucn6v/Q8CApWvOr1azkjRIKMb8DxnqS4VEQTArVaTT7UAG9YV0yHEwChd92WfInz1hIY0cegsxQgLGNWkqWtmd82c30zDXW/8lQH+GEti4maNgrjtkS9vN1rjr/vPpQ/k2tr7pSWG6UzMJoggxIg5y5nsl2vtWBYrpLkyZxkvjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AS8PR04MB8213.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 16:16:44 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 16:16:44 +0000
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
Subject: [PATCH v7 08/15] dt-bindings: watchdog: Add fsl,scu-wdt yaml file
Date:   Mon,  4 Jul 2022 19:15:34 +0300
Message-Id: <20220704161541.943696-9-viorel.suman@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 21ba7747-0a20-4d1f-c421-08da5dd89604
X-MS-TrafficTypeDiagnostic: AS8PR04MB8213:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DRwjTeJ8XJ6OceFJwmKBYcQlWgzoQuUC5SpnBfPbc298Frtd3nRVE3oBowLEFhkajkKNmoILonx/O/utufhY3T/L0SSfvM2fGcIlzD0VzJhKQO6l4j5KI/e7OF5V6kTa/rgYlAhitWKKA7wux8llD1ARBVOVQcUl7gaj7S4CmfYswwOZSD0EyE+kN8QqvS0YWvRHja+tDBqCEnAbEHmGHXxJfUZuvsoV3n5rp4fZi9Fw/uFl7iAHFj/oxqyYxAMv1wBS+xwH2jGXD+sdZXElKsTLIXJkFUHwnFfYPKYKmIwXpMJPebipOHm6Y/57ROyVokPn3qe8WZ/PoSKMKp+gkckML0+XnjZHxRm0Jq33VFfV1CZm6wEnJTX2eHrlT2qrznX8MXqNgLTqYxa3tvYYB3DR/tR9AoqiAFw0U3TGZIS8Nq/vUYwVjYfOwy1RsK48j1bdvG9p8ABgrxSMqWpuzS42E3IAFXb+fjZ2hfpXTqeImVxVErS3NRNgy6ghCZdJmC2RMKOl1maD+gSLrmC5aPcgJNjEVs9KAVHGPSHpvsFg7/a8qnHGferczH+1gW7x0faawGyq2TN1doFvyoz4fbqi6hq9GUJGJTX16DGVN3kyH5X8IpiQpJgoDbHFW1ES6PFfawQCOqT7PaJBE3lFvN+yMtwQDNx4/0PC+uj5VO6XMZtk6DwIr7BZ05AsCmKgWf+Q4Dr+Myulo16Ab8ys+6YJMhtcF2Q3SVLnoC2fQMp2/McC1k+mq/2UejGO211gGXtFeW3Kgps5BHoU8CnVboaSPpcvljk5ft1tAPeYd5yq3eny1FJz11P3QL6c1gHVggYPcDMDlzOB45A+iev6ragiS3bmoGBf92pdFTjIOHl0bMQuno/sniUCvSjCcXxccAy22XVm1jpBFGPoM1Rz1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(186003)(26005)(52116002)(2906002)(6506007)(6666004)(6512007)(1076003)(2616005)(41300700001)(86362001)(38350700002)(83380400001)(38100700002)(921005)(5660300002)(4326008)(316002)(8676002)(110136005)(66556008)(7416002)(7406005)(66946007)(54906003)(8936002)(66476007)(6486002)(478600001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?WAzWO3mv48EgIKyywldQoN2MEOmVbqxV2jd3Q71ANATOPZZZoVwfEAeUef?=
 =?iso-8859-1?Q?/VSaOg21gpEh25Lwn64/Ft2LRiTh4bTXc/e6h4n1Nw9t41obg37n2ffYea?=
 =?iso-8859-1?Q?qecUymIfx7thu7Y1DLms46xCbSwfaT2I6WjSuxaHTWF+BgNC1zvYwI1fvi?=
 =?iso-8859-1?Q?aWAJEoUkximKX1bbzI+F5SiWn573AOTexWvX+VBZ+iof7t0ON+sZh08dl2?=
 =?iso-8859-1?Q?UXtoxi5uDH3q/Nk5cO444kdYuQphQpK8HF7L6KZ/eqzoZiMZBc+686ERaT?=
 =?iso-8859-1?Q?LlTInJtQmXv3Yd4u9Nydx2a6kwDEBF7iY1GDa54Z7KMgl5DFTxidXUAQf8?=
 =?iso-8859-1?Q?tc5z8KB3DAjGa6cYLI//vk0z0DJYBiNb74qjzn5AeXSrBcEY1oUWOUmxYo?=
 =?iso-8859-1?Q?0VV9apU5dM3S5rMzE9XK/wCOUtAjpcDbvMWdGrs6Je8RloKoNsU+j/TTU5?=
 =?iso-8859-1?Q?Z7r31KJSUw+dV3zK5GieUVnEyppxRBwGrg6cktLBLyLBu5kXEFCHglyE6R?=
 =?iso-8859-1?Q?4TPMJgQSm6DjFmJ3nXLpOANNgmgoJQUvDVTA16/yq7nBEH145Gug/vn41s?=
 =?iso-8859-1?Q?0ylxB7mh7luGeEl4AnGHaPwm+Yax2AtEjvMZSh+ttUncc5v42TgXLGfGVK?=
 =?iso-8859-1?Q?UqU/wCuZQ2Zi8SPAvbuXa+92R2TFBmuKzYZY7Pf2SGD2i+aGtKMOv5NGKx?=
 =?iso-8859-1?Q?YRgeBz9tlR2KPa7UdJXSXdI24Hkjgj3fsJZ1Ywk5xiHxhSfEbIrU2f9R5x?=
 =?iso-8859-1?Q?8zWiLCVgZxpFYrqiEwWxJ0AdKZtMj3CQw44EQE5QTls/+aG6tO5yYK0C8C?=
 =?iso-8859-1?Q?c4X9v+x3iN6JwiQOqCb1jZ1GwAXAEias/dL+ZGJW/Px4AsEmn1dj0iFDTn?=
 =?iso-8859-1?Q?JTQOC/VhqbEmhT9/gIuxVywSz6Rn85MWyD8qwSDaocynuZ1In14UGq4TxL?=
 =?iso-8859-1?Q?hCpAoZ+BwAmeOKNkXsz7aEc0Eas/llrtX4AW+KOqWsXW/N9BgFXravGhVU?=
 =?iso-8859-1?Q?2W2tsbIienjUYoo2uy2w63229O4sN0J0jNw0TieBGXPIeD+E+589z7TMov?=
 =?iso-8859-1?Q?LJYY3SN1Nkwu5a8f7CF0hRCcQmCDTC61/GeAMrFeLjjSAQ04y7Teomk76r?=
 =?iso-8859-1?Q?7PJsYsX61uOqzkJeHSxjkHP1nHstJ8z/xfLwQ1/f6IKlBMlCQ4Q8AeshES?=
 =?iso-8859-1?Q?mG2HfCTYba83D0043FlZS/rVa3Ms4Wr9OYbVW88xs46TWW4H83evf46SJ8?=
 =?iso-8859-1?Q?eAnEofvOeiAeF7CQ3OxZzraCN6FIICPG7BcwONkyeBggA1SOz0pS2IccFK?=
 =?iso-8859-1?Q?87ADQaLvBYGUfJP68Qb+GaibyPOATU1GfsKNq6bxMrIsZ5+jykd0EKA/f9?=
 =?iso-8859-1?Q?XuVyV8zumcDpSjl77B5flzdQFAheJdGSXJyCG0XwawA1ZPsQFv8/bU5IoT?=
 =?iso-8859-1?Q?P2+7IQKTnHW0+d/NNr1jwt4zEbW/SDf96IeY3p60hAkxDJrRZ8e0bxnxJL?=
 =?iso-8859-1?Q?RmwP2FAVZ+bUbfSEp4U2QRx+h+exuLBJedbWjVN8ifK6FcqW8tOLw44wqW?=
 =?iso-8859-1?Q?RoyjKuKsTHCaMD7Sp2eyzGU3wc6rmGAKLfcV5276iypDIqzoiX/m8WJxe2?=
 =?iso-8859-1?Q?z00CA7V45ufCH1+T0iTrOGUmAxEtixTi2M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ba7747-0a20-4d1f-c421-08da5dd89604
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 16:16:43.9278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5MgsxImUtPZaYTCp8rhr8Ut5gzkIuF8UbIwFUamHRj1bIemxVXMeKN3nk3nnxkKm6Wy/wliB2kNWcMA2zmTT3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8213
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
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 .../bindings/arm/freescale/fsl,scu.txt        | 15 --------
 .../bindings/watchdog/fsl,scu-wdt.yaml        | 34 +++++++++++++++++++
 2 files changed, 34 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 03f927a33281..e1cc72741f1f 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -62,16 +62,6 @@ i.MX SCU Client Device Node:
 
 Client nodes are maintained as children of the relevant IMX-SCU device node.
 
-Watchdog bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-Required properties:
-- compatible: should be:
-              "fsl,imx8qxp-sc-wdt"
-              followed by "fsl,imx-sc-wdt";
-Optional properties:
-- timeout-sec: contains the watchdog timeout in seconds.
-
 Example (imx8qxp):
 -------------
 aliases {
@@ -98,11 +88,6 @@ firmware {
 			  &lsio_mu1 1 2
 			  &lsio_mu1 1 3
 			  &lsio_mu1 3 3>;
-
-		watchdog {
-			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
-			timeout-sec = <60>;
-		};
 	};
 };
 
diff --git a/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml
new file mode 100644
index 000000000000..f84c45d687d7
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
+  - $ref: watchdog.yaml#
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

