Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008A2582893
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbiG0O0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiG0O0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:26:48 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1712BB2F;
        Wed, 27 Jul 2022 07:26:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJYwNedsuersceWKI31CfBevuyJQoLcXP2qsTEBgETkky3J4T6s6CPYiaFfH4U9Cwin7ZOrf/4Ehi7fg4595BuqIZ85B89ufkePqCcCDYDz2s+rblNgSL1+tzD3w3Y4GcBAp0uwsHgZ9QGN7XAbvRKsFgiCbeESD+axobEQ6YeWPe/0FbNXNfVIu//hk2VRalYsYaqzNdmf4N7vLQ67Do102fq/4JW1Ah+faH6LkJ14H4s6fCqxIkYuKt04dKFYsfZKONkaZowFcBr9w3MkIwew2uKtud4r1hvR5ZiuTj53hfvKNFEPTulYF81CtyE2AAf2E/5Trs/1GrzcVr/bVjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3aD8t/LRAS+RTeXX67+nt2C+BjTya53f44Ez2mn2pA=;
 b=m8xiPaZksy/Vcu6YKt5KGjWmq5/csT5MVBL+U+/j6e3FSbbqdlNLhQIYReZqfiPJPjHGKb7qpnNxUU7F2+q49Xh1Z/L1WI06ezjPxFJmOzmX1a6yESIc4B+v1Xbnus2FLrhNtMCm8PQ2fOQOIm10nOhGmooVcDThytuG6TsLylSBDT2t0QRYpzMuUb3uCbiA3H02lsav3kIO+2bov00TuZkWnFpGb0cQJWvA4GCPLrCRZHhiUylkWtO8xBVPmJEEU/63ZOlTMZERlEjXbKqwXg59bUvLz7upCI0LAM8tbezGfljec4q5RtZ7a2hMzCVSLhL3JMR1MBzJa32YwZNx3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=renesas.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3aD8t/LRAS+RTeXX67+nt2C+BjTya53f44Ez2mn2pA=;
 b=XGIV9fHFMDQhTtj0ze2pHxvFS3KZOPjbfmBb+LFXO6dpRXCC6V1UHNx7CWSLdZFjMNj+A+rcqnr8Umyj4sfpSzypI4I/UKJC3FjfiGhg7lvGBhQwD48D2JeLt/8Rb2jOEMcWHuZ6+l8CHOB18Z03GTwbN87DDHI/tOwwjCtilGFGet0cRVuqtdWGXBCKY18+09QX56m/gD/mez7pK0pJKAMf1FIGQHgyY8hm9T32HlZtHF3U9bsQmpWrcHT1KYKQzDLUPg229QNBE0A5u258+IFNfBAgvpSh5bPo96AZN+ZPMBS2mOtqaox00xbs8zOOpECt3gbZeHyo4ZdSbWXeGA==
Received: from MW2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:907::30) by
 MN2PR12MB3005.namprd12.prod.outlook.com (2603:10b6:208:c5::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.25; Wed, 27 Jul 2022 14:26:44 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::f5) by MW2PR16CA0017.outlook.office365.com
 (2603:10b6:907::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Wed, 27 Jul 2022 14:26:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5482.10 via Frontend Transport; Wed, 27 Jul 2022 14:26:44 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Wed, 27 Jul 2022 14:26:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Wed, 27 Jul 2022 07:26:41 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 27 Jul 2022 07:26:38 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 1/2] ASoC: dt-bindings: Add sample format conversion
Date:   Wed, 27 Jul 2022 19:56:22 +0530
Message-ID: <1658931983-31647-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658931983-31647-1-git-send-email-spujar@nvidia.com>
References: <1658931983-31647-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cd28919-a952-4711-19cb-08da6fdc0813
X-MS-TrafficTypeDiagnostic: MN2PR12MB3005:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FgPx2XfvxGOB9A2GDKvVLSMuzbWjORVzkqMLnY4MEWiUTyeuM33LeOTsv2TfzOen+1qz6UJt9LdU/1NztP8yy3/u+49Njbtc+Wu+a1eR97XfGb6rzMCbDady+ZbZAqlm7hNmXEzOQeaW2IyhG3cR2Wixf8xelRD0HRWywlRQOp84ZKY0lMaOG1+OULAL2qVMk3EouZOfy980TsqbZ+SuYWJhJl5d4f4hzQL/n5pZQJC9N65/9/kWvSJM/yMyPaWpM93vHkfID6O6vbRtxpJA8Oiw1CGcANNWdyYWh+8ZlqHeOvx20g2uIrhWv3b5afF6XGucxsahXN/YWUHQUiQTxrvvQMRo3XQ58oix4dRepjRxva0y8UP4Zf21GJCrDUb68/xuT0OZJRwwWm1b2AzWNtFuNYvtrTBWNZiWolYsi7NmuyOvI4FDD7Lc5jr4B3GGDh4aeBT5AM8YZYmY6exOS2I0MVryXYJ2xcZ2KimNHqrYHbByiIYTXYrpRtZv77WNm/KpngCeHyvukx+zi5RcT3mFF0nFixmKhdvNcCqvnicQa7z1BOw2yXZBVnpVJP0FbWbBk1zGzPxLqWBkytW0TyRCy/l/cKYXk2ZDwEQCD/8Qu1BgITcF2n+s4iXtdZ8b+l1YIB6w3w4RUexOAvKjI9M+bbkJOOLMqva5x0sy2l+RyUXmkScLjAjCfBz1mLmL8aKgD2H2vZCMEqGJJablNJ0TjckpBisbhGVB37dO/HWc03eVMzTn98y2Z/x8mXxjyF6zvCtASYEQWz8AkAlnsgc39+ChcmKV9YQb9sbEMODAd3Zrv4R5ucJinXBaVPZgiW4Y5VpZJnPPYqXYtqs5+A==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(39860400002)(136003)(36840700001)(46966006)(40470700004)(7416002)(8936002)(5660300002)(70586007)(70206006)(82310400005)(8676002)(4326008)(40480700001)(40460700003)(186003)(2906002)(36860700001)(356005)(81166007)(86362001)(36756003)(316002)(82740400003)(110136005)(54906003)(2616005)(26005)(426003)(336012)(47076005)(107886003)(41300700001)(478600001)(7696005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2022 14:26:44.4210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd28919-a952-4711-19cb-08da6fdc0813
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3005
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Presently "convert-channels" and "convert-rate" DT bindings are available
for channel and rate fixups respectively.

Similarly add "convert-sample-format" binding to fixup DAI sample format
as well. This is added to simple-card and audio-graph based sound cards.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../devicetree/bindings/sound/audio-graph-port.yaml | 21 +++++++++++++++++++++
 .../devicetree/bindings/sound/audio-graph.yaml      | 11 +++++++++++
 .../devicetree/bindings/sound/simple-card.yaml      | 15 +++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
index 5c36867..d7491038 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
@@ -24,6 +24,17 @@ properties:
   convert-channels:
     description: CPU to Codec rate channels.
     $ref: /schemas/types.yaml#/definitions/uint32
+  convert-sample-format:
+    description: CPU to Codec sample format.
+      Value    Format
+        0        S8
+        2        S16_LE
+        6        S24_LE
+        10       S32_LE
+        32       S24_3LE
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 2, 6, 10, 32]
+
 patternProperties:
   "^endpoint(@[0-9a-f]+)?":
     $ref: /schemas/graph.yaml#/$defs/endpoint-base
@@ -70,6 +81,16 @@ patternProperties:
       convert-channels:
         description: CPU to Codec rate channels.
         $ref: /schemas/types.yaml#/definitions/uint32
+      convert-sample-format:
+        description: CPU to Codec sample format.
+          Value    Format
+            0        S8
+            2        S16_LE
+            6        S24_LE
+            10       S32_LE
+            32       S24_3LE
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 2, 6, 10, 32]
 
       dai-tdm-slot-width-map:
         description: Mapping of sample widths to slot widths. For hardware
diff --git a/Documentation/devicetree/bindings/sound/audio-graph.yaml b/Documentation/devicetree/bindings/sound/audio-graph.yaml
index 4b46794..df8a994 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph.yaml
@@ -32,6 +32,17 @@ properties:
   convert-channels:
     description: CPU to Codec rate channels.
     $ref: /schemas/types.yaml#/definitions/uint32
+  convert-sample-format:
+    description: CPU to Codec sample format.
+      Value    Format
+        0        S8
+        2        S16_LE
+        6        S24_LE
+        10       S32_LE
+        32       S24_3LE
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 2, 6, 10, 32]
+
   pa-gpios:
     maxItems: 1
   hp-det-gpio:
diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
index b261d49..6decd73 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.yaml
+++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
@@ -77,6 +77,17 @@ definitions:
     description: CPU to Codec rate channels.
     $ref: /schemas/types.yaml#/definitions/uint32
 
+  convert-sample-format:
+    description: CPU to Codec sample format.
+      Value    Format
+        0        S8
+        2        S16_LE
+        6        S24_LE
+        10       S32_LE
+        32       S24_3LE
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 2, 6, 10, 32]
+
   prefix:
     description: "device name prefix"
     $ref: /schemas/types.yaml#/definitions/string
@@ -191,6 +202,8 @@ properties:
     $ref: "#/definitions/convert-rate"
   simple-audio-card,convert-channels:
     $ref: "#/definitions/convert-channels"
+  simple-audio-card,convert-sample-format:
+    $ref: "#/definitions/convert-sample-format"
   simple-audio-card,prefix:
     $ref: "#/definitions/prefix"
   simple-audio-card,pin-switches:
@@ -234,6 +247,8 @@ patternProperties:
         $ref: "#/definitions/convert-rate"
       convert-channels:
         $ref: "#/definitions/convert-channels"
+      convert-sample-format:
+        $ref: "#/definitions/convert-sample-format"
       prefix:
         $ref: "#/definitions/prefix"
       pin-switches:
-- 
2.7.4

