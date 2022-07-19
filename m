Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C88A5792BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbiGSFtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbiGSFtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:49:47 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70080.outbound.protection.outlook.com [40.107.7.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448CC30577;
        Mon, 18 Jul 2022 22:49:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jb9tiUn5gnzqUbNSVnvkDR6ezIPpOYPp0GkxwMm0VdMPWHq4w0xweQWzaCQZKfabdnV/s3Cv4+yZNtaeRAXJwag3BNwhBk+kvxaOWxz+s02sHLzUSmm3Q5jdbXZR1wc+YslT2Dkdd6Ne6npQWKwch/V2Vbk83BFSXDntn7/ziToNCXKZdiq7J1ta8F+9SwLKm1PuIYAqs8HxJ/gk9XRb3BLXODnzS9FOWB4xlTA5C2/C2B1pEy6OtCTEkZrjEkTE/XeJEuWk63lEjUYZRcA+X8eb/gUe2ilBwPoKO+cWdt9r6zMuLvtYNbTIjGi3NYXZG4XN1y7Tu7uth4pUdSoX+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wRmrwUUEOqu/CC1o5OCpDYo8aBR9yyGzsFWszkJRcgU=;
 b=GnzS05nl2hk6t3Aka094u22fa7hM1xrTzkImERAX4LcMUm+StKBmIxGyKstcXMU/EcIb+joE3aXqNLgNHoEfxk2HWfLE6PiRuFwC6DD/nyod6ByjKYME4TZrLEM+RUbRNUOaUKmGg93k2cExZEWRKpjRvehJolRsoB/wBChwd4sI71/zUX5BNWioEBbM4pJyGj6Q1KTYVodsMorgG9pjrGmHwwCy9piO7J4eGZVFf2JywZt58tcj9PqHz+sulPLvR2/kQBIbfX2nNrEU7GhZY0WgI4KUxWj8uGP5RZzUZ66zUOHCcrfdhIXj1jju8gRTAI2ILtpXd+jGLwl4R1bGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wRmrwUUEOqu/CC1o5OCpDYo8aBR9yyGzsFWszkJRcgU=;
 b=blglsc0uaiHK0O6aHSkDvYt5q5AEZrkhCiiiSc7rmVU/jQ8t7qmaMw9YRwEDxSbRTOAEyJYrmt+XKpihsRXtMtbuPn/btW4UgKnRmhXO6Qot2C3Unk4kXqE3xnP3uUzOxdiLnZPtqwvybGcln82yHr4Jq5Fpu9nechYsxDl69rQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2937.eurprd04.prod.outlook.com (2603:10a6:3:d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 05:49:43 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 05:49:43 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 3/7] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
Date:   Tue, 19 Jul 2022 13:50:50 +0800
Message-Id: <20220719055054.3855979-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220719055054.3855979-1-peng.fan@oss.nxp.com>
References: <20220719055054.3855979-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e788019d-5e59-4659-fc46-08da694a7a71
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2937:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6ytjq8NTk/tSrCBV8AV7HlXF9F2YssfTI8aIJeIgbAjaFR0Md+9LuqisRHzpLCflDNNUGEMedl8wJOrxZRVIrBDXdqg9pDDdX4WeeWcTUBJdDBIs4d+jgic7sHrs9tq0gcjR8yeRwjEETfXh6H2QPbDECX0Q6mu/q7t8KA9O2BlLyFkbtpztrrpAHXhHLaR7NAN3XN5fT53V0t19ylFi6LyQr40lXfFWT3hGY2bav/rLm/iPNb9xQhlvexxXPIqHhpIIXgXUHG16hQI/CnFynJJh0SOMJmo30sFAjr11fVYDKV1kDYAKf+lhfE8eflP2XDLhDtN+b71aJYm5983R4nPlyebQIjzP9LAhfs1d/fief/vXVZGtkAj/dTgL1CK4t8bIGB74kHwbSsMewKe9fm0a452tI/+DbdbjsfPNfxygBEse/WKv7CzOtASwi1y9wT1RXYZr3i+7namWenWIgl3Njeola2g6qvXhj6RhpSsqjsrjLvoFTyVY3Vlklqeb4TPqIWNQ3YSiwjR1oXgJGX9/DPGB0PauknOAixKnqiRdcB54zHHiuLKP5j5GGLhSl2usTX95zzqa8Itbcj8ttuVET6G/W0QY9sQGBBnVsazgac5AKoeYL+1jsZo2iDZUGusuB8SufV9dxaszB+Rs6yM7gjN3zkUR2k2qRmylLpNwBsVdIK52HmBBak/fyVVc0mjMBWGH0OYeIJY/9lEC9YoEjH88SN3Gw+56XMjX1ZVwBuHTkbDCbScIMrQZNSruW+0XuxIq0XgaA1mMbolwHtTMaiE9F6ZYz70sxCGw6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(41300700001)(7416002)(26005)(6512007)(6506007)(38100700002)(6666004)(2906002)(52116002)(38350700002)(2616005)(83380400001)(1076003)(186003)(316002)(66476007)(8936002)(478600001)(4326008)(86362001)(66556008)(8676002)(66946007)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6Gz9o292S5hDLsh/igSJ8vW8SMzcVqdIBOxKbmup+nbofJP3qochAvOqJvcD?=
 =?us-ascii?Q?8Z3Zsh1vghhsQZvBD5EyMq5vNdXloK7GqWdjUb5+EEapUhxZbob1W6PUshpk?=
 =?us-ascii?Q?4c/s0NiyB8gU/gw6ff+GPV+dIAOHeZ6ScqRSvosXu88zE3+n4kfYwXXIVQ5S?=
 =?us-ascii?Q?TcrHMOvfyA9B63JjQYbCXbJxdl9JVsYSW00pxNsXKtoVrQ/uBBY5SEMsswgl?=
 =?us-ascii?Q?1jb951f4q9OaKD+ovff+YqBYYdOjVeBuCIu8kcM6hlmBzYmxU01aKcsdDxv4?=
 =?us-ascii?Q?xyNeCirWZj8HRq0A50Grx3ElYGjdK0EkOy9AgHSwQY8w0cUwzt6EMaAYXY7/?=
 =?us-ascii?Q?59ScDrPdAbWDMbzrgDdmm8vbPhrZLngFvfAMBggmv3PRDGK/XP0KAb2tnyzh?=
 =?us-ascii?Q?tTO87Ih/8KPhQWlbB0GhRL77zupCFEClDY9pFgebFZmi49lNzMm6juKe8fEE?=
 =?us-ascii?Q?IJ+/cGibdO29abGZoBWsuK0mMmOdwjZcWZjFU4pTH0kVY9VT7j5pHkCP/CJk?=
 =?us-ascii?Q?cU1afiqZQnkornLQo65Wqu+G15Cw8yn9U5BoLFvfjH+ErFSG0sQUSsLN15PD?=
 =?us-ascii?Q?0pLwBFr0/YbI5sM4DQmuo0Ec0i1Yo0RKTXkZI0fJV7ipBkiPkaX4VtTFFXSG?=
 =?us-ascii?Q?CfVL5LEpawOnOmeTdhWbTigHdoCFVjndVlC5T3hsKvjcCaIXHgM8QzbeLRb9?=
 =?us-ascii?Q?dAoqSfSvXwHZ8Yg5shr6Ya+orweqNefKl9x5sbY3XmahAOSDEEAhchIq9guO?=
 =?us-ascii?Q?rsC7jo7CeG35xoj/CNNOSUuCWMmA8EagdiS5sOHLObq/Az7HRjO7+n11AQFh?=
 =?us-ascii?Q?KG5Q29+QC7jJTTdMVXLOSpw3vQYrCLApt/tP5/iCKC7uztbHOYIxJtzhVVQj?=
 =?us-ascii?Q?7EPTYAMFLV+FCEqXF0LYgTdxy8Uc5nAu7U07WnMUA3maQP+hNc4ENJI36T3/?=
 =?us-ascii?Q?4pzzgxN0Fe6w0ECXnegCuq8AwMVx+OPOc6f6J8ON0WNn9eJlGWkFCxbM3YUs?=
 =?us-ascii?Q?gDB2guz9SWfh2RQPmsxCNMfdctdBxwmHVxhtXNdIKljAVfVqE9E1/XEa1Onx?=
 =?us-ascii?Q?jTbDr2SZyVquHPkpuzuzH8nJw93BFGfJZm/RLj2yDUk+jxOPcTgwMOr4bExd?=
 =?us-ascii?Q?9e/WZiyDiMhlaF14KdACG4lrleJTB8kWa4g8cR9N5NGl6h39PA6Z7jnKeg2x?=
 =?us-ascii?Q?0n1FquJmTVScSl1C+pMAI78W7X5TnL+/x/xclJBcTHOlJhfFyDP39+URO6wN?=
 =?us-ascii?Q?SzaPynXaR6mdX9q+m4YQQnTmWcCy/wOlVj/hURMdSlCUjXLMjuG68YQRQiQd?=
 =?us-ascii?Q?O1jIqb6BbFeoYRBYXDWKO13pkvdtVVLbbCuBr2JSI8ZFXKNC2G6uoe5TLvqB?=
 =?us-ascii?Q?x+OBreN57p5pegiIXBkOjrU35FxYw5eXdfFbo64qU5qu9f6Zphns+PoU18tD?=
 =?us-ascii?Q?k21p1igmwXhnz5fM2hIckcgxDtc0ZO5bOd6T7qlC3do9WAoeXn0BhwT/UnPk?=
 =?us-ascii?Q?nw61kOmDSfYit44aQM9kT+YwHTNLHZ5RR5WZ4c5c3Nm9sScHWXLR0b3drLK+?=
 =?us-ascii?Q?5DrMZWhKvBlUESu7ncBH/DLLgCN1DAeiky5YC/G0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e788019d-5e59-4659-fc46-08da694a7a71
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 05:49:43.0865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cxIzj6fVty1B+NOxz2aIjJo28nv+dT6uDqBonyzvaiDQQhjPSUCR3itLCbNSbHqy0zaU5/VWwM32Omo9u8uuig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2937
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX8MP VPU blk ctrl module has similar design as i.MX8MM, so reuse
the i.MX8MM VPU blk ctrl yaml file. And add description for the items.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml      | 90 +++++++++++++++++--
 include/dt-bindings/power/imx8mp-power.h      |  4 +
 2 files changed, 85 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
index b3fb529b399c..14f92574286f 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
@@ -30,20 +30,13 @@ properties:
     maxItems: 4
 
   power-domain-names:
-    items:
-      - const: bus
-      - const: g1
-      - const: g2
-      - const: h1
+    maxItems: 4
 
   clocks:
     maxItems: 3
 
   clock-names:
-    items:
-      - const: g1
-      - const: g2
-      - const: h1
+    maxItems: 3
 
 required:
   - compatible
@@ -53,6 +46,85 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8mm-vpu-blk-ctrl
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: bus power domain
+            - description: G1 decoder power domain
+            - description: G2 decoder power domain
+            - description: H1 encoder power domain
+
+        power-domain-names:
+          items:
+            - const: bus
+            - const: g1
+            - const: g2
+            - const: h1
+
+        clocks:
+          items:
+            - description: G1 decoder clk
+            - description: G2 decoder clk
+            - description: H1 encoder clk
+
+        clock-names:
+          items:
+            - const: g1
+            - const: g2
+            - const: h1
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8mp-vpu-blk-ctrl
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: bus power domain
+            - description: G1 decoder power domain
+            - description: G2 decoder power domain
+            - description: VC8000E encoder power domain
+
+        power-domain-names:
+          items:
+            - const: bus
+            - const: g1
+            - const: g2
+            - const: vc8000e
+
+        clocks:
+          items:
+            - description: G1 decoder clk
+            - description: G2 decoder clk
+            - description: VC8000E encoder clk
+
+        clock-names:
+          items:
+            - const: g1
+            - const: g2
+            - const: vc8000e
+
+        interconnects:
+          items:
+            - description: G1 decoder interconnect
+            - description: G2 decoder interconnect
+            - description: VC8000E encoder interconnect
+
+        interconnect-names:
+          items:
+            - const: g1
+            - const: g2
+            - const: vc8000e
+
 additionalProperties: false
 
 examples:
diff --git a/include/dt-bindings/power/imx8mp-power.h b/include/dt-bindings/power/imx8mp-power.h
index 14b9c5ac9c82..2fe3c2abad13 100644
--- a/include/dt-bindings/power/imx8mp-power.h
+++ b/include/dt-bindings/power/imx8mp-power.h
@@ -52,4 +52,8 @@
 #define IMX8MP_HDMIBLK_PD_HDCP				7
 #define IMX8MP_HDMIBLK_PD_HRV				8
 
+#define IMX8MP_VPUBLK_PD_G1				0
+#define IMX8MP_VPUBLK_PD_G2				1
+#define IMX8MP_VPUBLK_PD_VC8000E			2
+
 #endif
-- 
2.25.1

