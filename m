Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D5B572E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 08:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbiGMGfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 02:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbiGMGfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 02:35:33 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20043.outbound.protection.outlook.com [40.107.2.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDBBD2166;
        Tue, 12 Jul 2022 23:35:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pg0f4H+hMCP2vusABm7k0lh1snysKll6d3eKwbSivIqQwGBSitT9eicyUx7qxGelCkmEGly36vSmwv9ZWcVIyPjySdkAlJRQ2+zfKZHFDRFeAmlDnAzWcoR2X8UGUqZBfEoRNTzgeiqVhcJZ5NNp9sJja3/P5efbXGGY6QjIKDSEjJYDdV+aHDJ3140f4NPrlmTrY6LjOs2Y55qcSZaIXfT2haZDMjJtXlIXEv5R7A+rit0xIQHgoSajxpNeTgCJdMHByU8ubov2JfYRvzkrfRnsoCuKA5PgGG6HYmFBGdVKEBvK4Gf5Rfz8g5b8DQMV+1X89Mwo3llM39EwC4/L/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z73xfvq/dmxG8MXyokJzyrwD+9ifE4R45gocYCxmr4Y=;
 b=MvF+D1CCncEi9q3g1qSW5nbClOrXUu+ywhUzowNF11WtXnyuNiBLe2Y3VkrT6Qa9n+oLCLhl4cXgNZ02FMLsvLllJZRNrtLJFO3MTMOtQL8T+85uDjMjxZX9veXJvl3QrcLNhfej2FL/GhE+Ui/m4gFJMofMLVkZLhSUyuvErQRpK0jlpiirD7lkzS0GUvv3PA4mm90WAvgtvcPz8np0hbDB/10SggSRtRhk0tSJuQK7R1HSnKy/kFaidpNPnslqX/6h3259NH9kw28HBXbSbBRMCsecwVjaXQ31UqWO8KoFViPxIPBfGti8Ytm6tFFjKa7vWXnuqaBlqNhNuDmdYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z73xfvq/dmxG8MXyokJzyrwD+9ifE4R45gocYCxmr4Y=;
 b=coRqecFU+4er52kg+DS8GbDjOZfay9HyNmQQt6iZvAP5shlouHPvVUrFa+jYxENYQc7lDQX6ZutREYjGI97BLZwL3d2yC5JOAMkjCkpyjMU0sGRZtW96RyySqbvPYE8SiIZWwAhuY1wIQiym6a/ezdfL2x27ysUcr/ZU21HLjcs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7459.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 13 Jul
 2022 06:35:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fdd4:8557:334b:180d%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 06:35:28 +0000
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
Subject: [PATCH V2 2/6] dt-bindings: soc: imx: add i.MX8MP vpu blk ctrl
Date:   Wed, 13 Jul 2022 14:36:49 +0800
Message-Id: <20220713063653.2584488-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713063653.2584488-1-peng.fan@oss.nxp.com>
References: <20220713063653.2584488-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1P15301CA0052.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:3d::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 681b1b79-12b2-41f0-4f98-08da6499e01d
X-MS-TrafficTypeDiagnostic: AM8PR04MB7459:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lG493Lc5oOSvwRFMDKemfdeOWa6x8rO6Li7Ao2KqtmW/oXchBgYhamnbekTQCM8F9svxUe1KEbVZe1GBfLBbK7mCck+q6OAAxn0mDbWF5XFtmyLR9GZWReNnNWRdGh+Jy/ZdJvJfApNAMBsoFxAt3ygXZNYBbvTFtBAvGFFuDvScL4OxEWNhPq/SjFR3LZDvd3S17av/Q5mwU23+VeoGHf6Cbmnf3HYyZ/dfrRrLkYCxHG/YeaollpYJMxmEkiloUzWTL8Qd61G+qdQHml25gbLU82QHFUP1GT4SSwZH5jFFFSLjxnA4+TH14zzBg4ONfujzLH3OlJJpZ5/Rz4w5MgHuFWV4xFXTOerBjNB1XdmOvKZzNXbuHJyzUbnZk0+nrDZ5dXV/YFFVdIeo3LLCueVnMMw4jG5PzEpSOEO1ViUDZnbTilrVi06+pteETouROVd2Fbv0+Iv5HNfnyCQRTkMF//gerAu5W4HZRLWAaYUIbbwJ9Kuzn296PDx8YO+hioCMB5XCG7c5xOh4gXpexa5uieeVB3YxGZ4A6jQNdiBqpAZ38o+wsd4+N9QKu+4RHfL63DNJvbcQ4aJ2pKgmq80yz68OxxLZR8a+IZ1ShPhxq1W615B1lR+HyBeQpkEHEmTKMlC+Lfd7GmZTEQNHWIi3x4blHrS3mGu+rQw33yfsagkuCSv2ZLSnBQ2iRrPHz14fFhPC3klP8pCTJhf6T+s0lCnDFLAk1+7WOqHm/xm4XysB4FRzUxhSI3z/gCEli1qUCKPcMyQLMhLUtuMX1jFvjeDCqPraO+XdjaiXve77V4SvfgkH3TQjRETrAhZZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(7416002)(8936002)(5660300002)(83380400001)(2906002)(66946007)(8676002)(66476007)(66556008)(4326008)(478600001)(6486002)(6506007)(86362001)(52116002)(186003)(2616005)(26005)(1076003)(6512007)(316002)(38350700002)(38100700002)(6666004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qr1xm5u8lrurqN2yMt7feLCith2JiENbLGIVR4FTmp0CFlVq/+eFhKlOpNLE?=
 =?us-ascii?Q?Eqt91seFe4BNEUtCbbLQXPKVsJMJzLQ6k7sZBHLfS3kPpZzTcP1x5H7sUmF6?=
 =?us-ascii?Q?LIeaG5v4h+kfg6qpj3T2KqqB5xqf1+PWwa9LN9AchTEYFMpz2oj2vBfykzX0?=
 =?us-ascii?Q?5nxJ8HvtQ+KwvtwRaCJhQnZ76AQoNj1e5o9NsQW2ZowqZK7QntnHzYHBYehi?=
 =?us-ascii?Q?cHzm98WTRMVp3ipOECpnQDs2r20eOlYBHVoGspUZFNlZsaU71wLv8UmK9Fii?=
 =?us-ascii?Q?5jU2fz09cO3XaKy9/YaNaC1kd0K8dFAGQseF/4kImCqbU/Pa8LqO35zlGHHW?=
 =?us-ascii?Q?02sWN7CY2rWx2jLMLUhsx2pVxo8yGxHymkPMLptTniwIWGqrwUNIh1OutMar?=
 =?us-ascii?Q?KVzz3+24IVANyatEXPnHgUmzV9fYSoq9g2Tn4rl1FLeJ7xM7GcOEWhM7GAVO?=
 =?us-ascii?Q?mfnRTe6FhOj7Fv6+IHKmFvH2bM8uNHKUkPJ6NNQRV0kpxXPPODpl2pJrbnxE?=
 =?us-ascii?Q?geF9zY6XEAlf4DLWf8r6ud/DRR9LkzU0qjoaXYIAvY96+8XnoaG1vpnzcr3T?=
 =?us-ascii?Q?LMegBKkH8X8HHLpicu0X0ipJzdW+MN0VspD9npALvjMDNrfYgPDELxMB1EsZ?=
 =?us-ascii?Q?OMnViZEfar8QF87c0dBMUFtY4CqvSzqUTVc4layGqMdwwDUa3szTHJ705K8R?=
 =?us-ascii?Q?okG+VC1hY9LBK4Hfey6H5RprVMnLIwCgXMUbIufYpN6RoMe24wlOpjWBJgeB?=
 =?us-ascii?Q?LoHL5b8R39gcpFuP58g46RtOSjrK2GGfqBctJAZf9Mxc+7ENk/CwKpdeekHN?=
 =?us-ascii?Q?417Fuxd0rinKDAvNYkM1hDRgzQaPTisemNDUt0pGcilIlpV+Jc4x4c1Gwb2m?=
 =?us-ascii?Q?EfoZ5ud0AsLe6xc0xBQPqEk9nacyZOL+l+/haYocwYUhmSvGrlSYjiIibFRS?=
 =?us-ascii?Q?fWOzcId0aHRqi3Tb2FsCJkLwCzkSMB3YPP/eol2CNV3MDate+6bEkmqKnp+p?=
 =?us-ascii?Q?E9hwD1JNwnJn3RQulS+vQVGg6wFIzKyp+7+xlTaoE5WtqRn/krXe6gjHfIlu?=
 =?us-ascii?Q?V3AHraK8pzJlXtZWMK+yZfU01O/33qciRND99QcGhm4K3MP6Gy06kHIVRFR0?=
 =?us-ascii?Q?hyzXmAlVJT6TjAeHwt6VEri+zWtjWTQSMBconNFzuHrPpxpYfpaBeVJNbHQe?=
 =?us-ascii?Q?B4Ko6MInQw56qL1w9xTC9gQAWth0wTwCGZKNV5k/voih2oB/kZP1Ijr1UBep?=
 =?us-ascii?Q?bZZBW5CuM81VqEmkksnJQsXGkVeHLk2fY9ImWL77Av+s5qUUutQ4sSZMex8h?=
 =?us-ascii?Q?OVvKJUdUqD7Uw5l2FHwZ7vtOUoN3gK67wdthMWkGZlzNxdJCLHHi0UTc6zqH?=
 =?us-ascii?Q?IQqHVBzaj0cuJia5N/vIgUnmSOtT3UPcM2NbwOEGdbxPpix1NUMZMSSIL5Y+?=
 =?us-ascii?Q?KD/MInQnzNSmcC+1Ksn++FaRf9mZZH5oPemg8k2JifHUuPGauiI+z3U0m3Bk?=
 =?us-ascii?Q?kd8HQPBLvo5ouNah078nrBD9O9iyH7/2JaASSvaF5mz7ZyBTKHBT8BUJot+v?=
 =?us-ascii?Q?uCWlQqmb8yp1VWnTwklIZVHFLssfVQn0XZ5/GsC/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 681b1b79-12b2-41f0-4f98-08da6499e01d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 06:35:28.0702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Aticl5YLP9CSA8736fgdUa5LRvaRpnia7BPir55GTTgdQJhvvyelBhpqHspDep53h0xRvJvnHwPpW+0uQSKPBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7459
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 .../soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml      | 93 ++++++++++++++++---
 include/dt-bindings/power/imx8mp-power.h      |  4 +
 2 files changed, 86 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
index 26487daa64d9..d05930f61f95 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mm-vpu-blk-ctrl.yaml
@@ -28,24 +28,15 @@ properties:
 
   power-domains:
     minItems: 4
-    maxItems: 4
 
   power-domain-names:
-    items:
-      - const: bus
-      - const: g1
-      - const: g2
-      - const: h1
+    minItems: 4
 
   clocks:
     minItems: 3
-    maxItems: 3
 
   clock-names:
-    items:
-      - const: g1
-      - const: g2
-      - const: h1
+    minItems: 3
 
 required:
   - compatible
@@ -55,6 +46,86 @@ required:
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

