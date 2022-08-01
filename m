Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E92586E48
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiHAQIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiHAQIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:08:18 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AAF3D5AB;
        Mon,  1 Aug 2022 09:08:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8ygqKmIWzJX8JSs1AQKqV+QuLWQcxaSGTW5Il9MEuiOXhJsvSxY+vQgTKy+2OlOZX+ZkJCpVUmiMHz6zvjvdN5GKQ+dgmMYahuN9YuO0KWTGCLTB2Kf2KROWn7KsY75oCLJonk/P8YGWv05MztN3ldLDPcDP0YTkBLYei8v5v/RWsl1lk1MPJIpe6fMBnOAe5PCo5p7ggCx31E0sT8RFSO9oFPuyOXsmMdeZHCGcXg4Fss5iUzE5ZtvWIboi8R1aFrSsilsH7V7bnOEvfpBuAe/99v3vW7oOHjCc/BzseYGn4AqJoC4SmbCQe4iqDOqrD7fyDej/WVXKd6b8HpTtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fD3mig3DCyYWdwPJ2ne/4kIvNLm1ttgIinYcoBw9js=;
 b=PGSYWeANF774/ANh+b0lGYz/GZpasCvLEVjRJiK80zOb7HCJKfYrCkUau8z7H0EfY8PiOL/wwWHteGT0ptPmH+4DkxXHGoBGnuhbV1Dif6Tb3Ic2vW7jYQipG2591QWHUxf6R+mALp964W7Gc4e52aiH59QcMniv5H1MXR9B34X8HJgjItkq6PXFuumETvE7gyvgKSgtE7zx44QIqFFvNNxYXiwWCWsH0ygOn75y0JIwS9harBp5cCxEA2LFMCTXlsjwkADeLD/jF0nM3H778dKtOR3RI/W/uyDhf6rljiw3bNEPgfLEQdg06q8XVE5Um4MrFgAHAe/03T27VVJPkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=renesas.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fD3mig3DCyYWdwPJ2ne/4kIvNLm1ttgIinYcoBw9js=;
 b=C04ldufYtaUuZkV9+7BMPUQA8Lwa2PG0396IF6eRVRSqX0M8Hy0IXbpA2JUwy6d9aq/S6RhF+AISJB2BvYOH76OPR4k0w4O0wLBiHWq0zUF0ZBLxI3Mj0EkAYhWxDVSXNvnsoHsCLeLFrW1rSIJrdaj/FwAnLLIfrGITisNIsUyyMe1bbkK5q6Srb+Yd7V+BBUAeQYSJCUb2UZi28k3CAGxUYWAwun7Qd5YlNOhGThjSk0vKRx1rUVT6dCOFZ/NS5j1EVCQ+dj6mDk/xV9z6bouMLMvyShu1W6cZhUujDseDXZxWBcpd1GUotCUbsHrzkO9lP3D2WAAif4hVSHH/Kw==
Received: from BL0PR02CA0092.namprd02.prod.outlook.com (2603:10b6:208:51::33)
 by MWHPR1201MB0095.namprd12.prod.outlook.com (2603:10b6:301:4e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Mon, 1 Aug
 2022 16:08:15 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:208:51:cafe::db) by BL0PR02CA0092.outlook.office365.com
 (2603:10b6:208:51::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Mon, 1 Aug 2022 16:08:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5482.10 via Frontend Transport; Mon, 1 Aug 2022 16:08:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Mon, 1 Aug 2022 16:08:13 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Mon, 1 Aug 2022 09:08:13 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Mon, 1 Aug 2022 09:08:10 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 2/3] ASoC: dt-bindings: Add sample format conversion
Date:   Mon, 1 Aug 2022 21:37:31 +0530
Message-ID: <1659370052-18966-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1659370052-18966-1-git-send-email-spujar@nvidia.com>
References: <1659370052-18966-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 018c11c1-1bb7-45b0-c63d-08da73d809f3
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0095:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iBjPsp/GUUXWBzdycElROdABaAgBNWv5ROBYJrMpKt+bcohVhNUl91i3yPb5m49jZp52W1VCgGC0B62cE4Q62r8uuSzoHGra2z2pG2HgXPxxwwUwDOG9TMBkKwJYxJuPxSiBYj0widr3xcbFdsoibHE3tbV3mGOmlhuWYSeT7U8Luj3og9/T27/PXUwqHGX5T4oM43mynnYWwJf0a1wLLaPvtcL+H+Mcb4Z2Hev0nNopEXl3iZtiSemypNN0qSMbGraSDz65lXFp9XLpC+jwmP4EYoEFzP8+XWiIy7TYIRrmvMF6Pb0B9L2KE8ImCYGbTLWfILc1r71uDmpdc57X5ftEteJh9WqJ/NwprvIQCzOokdYcOpsetQEtxRrbRjBa5Yx8JaA6YSQAVjzzCSVKRxE1SZdHX1rX1bNrbDBtD9OrzyRQF79P+WAgNhkEZxIia/ghRRaM5Rh7+fAdrVe8YIDoQXPsvGfIPcCp/rP0zL45YNZ06OAJJ9fZFZ5IVTkrHNV0NKFI8NCUfjYMXbuiSUvx41YGlFqQqFr6hhGlZ3a3EN0KB19NOu2nIXu0IYA/JIOfvaOVchMWRtPMgR2XW3V6N5n/CWV1oyGUNsXAF3fv5zayIsSq46SS8ycT+YRRb2mxdSpu1eftkIQAK/ATHMn9dMisgLvhGwlFdshiPLZ6JUJvDl79Sb9C3C/FAL5z3AnYzuzN96L+FjcKEtjtbrMYnx66HH6+vetDkdxckS+kunfXVkFgkrE+pLIrhUt74bdEc8J/spUT82PsAd/06jvONNBL+8h1fronxuP3MrRGasfcIAeN4zGHRWXRniaQ3S2A6EPT2thFBPnpNxgUng==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(376002)(46966006)(40470700004)(36840700001)(478600001)(2616005)(26005)(7696005)(41300700001)(6666004)(186003)(47076005)(107886003)(336012)(426003)(7416002)(5660300002)(82310400005)(2906002)(40460700003)(40480700001)(82740400003)(70206006)(110136005)(54906003)(8936002)(316002)(8676002)(70586007)(4326008)(36756003)(86362001)(81166007)(356005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 16:08:14.2041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 018c11c1-1bb7-45b0-c63d-08da73d809f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0095
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
 Documentation/devicetree/bindings/sound/audio-graph-port.yaml |  4 ++++
 Documentation/devicetree/bindings/sound/audio-graph.yaml      |  2 ++
 Documentation/devicetree/bindings/sound/dai-params.yaml       | 10 ++++++++++
 Documentation/devicetree/bindings/sound/simple-card.yaml      |  4 ++++
 4 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
index 30a644d9..8e64192 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
@@ -22,6 +22,8 @@ properties:
     $ref: "/schemas/sound/dai-params.yaml#/properties/dai-sample-rate"
   convert-channels:
     $ref: "/schemas/sound/dai-params.yaml#/properties/dai-channels"
+  convert-sample-format:
+    $ref: "/schemas/sound/dai-params.yaml#/properties/dai-sample-format"
 
 patternProperties:
   "^endpoint(@[0-9a-f]+)?":
@@ -67,6 +69,8 @@ patternProperties:
         $ref: "/schemas/sound/dai-params.yaml#/properties/dai-sample-rate"
       convert-channels:
         $ref: "/schemas/sound/dai-params.yaml#/properties/dai-channels"
+      convert-sample-format:
+        $ref: "/schemas/sound/dai-params.yaml#/properties/dai-sample-format"
 
       dai-tdm-slot-width-map:
         description: Mapping of sample widths to slot widths. For hardware
diff --git a/Documentation/devicetree/bindings/sound/audio-graph.yaml b/Documentation/devicetree/bindings/sound/audio-graph.yaml
index a9cd52e..93ddd55 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph.yaml
@@ -30,6 +30,8 @@ properties:
     $ref: "/schemas/sound/dai-params.yaml#/properties/dai-sample-rate"
   convert-channels:
     $ref: "/schemas/sound/dai-params.yaml#/properties/dai-channels"
+  convert-sample-format:
+    $ref: "/schemas/sound/dai-params.yaml#/properties/dai-sample-format"
 
   pa-gpios:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/sound/dai-params.yaml b/Documentation/devicetree/bindings/sound/dai-params.yaml
index aae60cb..933957d 100644
--- a/Documentation/devicetree/bindings/sound/dai-params.yaml
+++ b/Documentation/devicetree/bindings/sound/dai-params.yaml
@@ -19,6 +19,16 @@ properties:
     minimum: 1
     maximum: 32
 
+  dai-sample-format:
+    description: Audio sample format used by DAI
+    $ref: /schemas/types.yaml#/definitions/string
+    enum:
+      - s8
+      - s16_le
+      - s24_le
+      - s24_3le
+      - s32_le
+
   dai-sample-rate:
     description: Audio sample rate used by DAI
     $ref: /schemas/types.yaml#/definitions/uint32
diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
index ab03a2b..ec21190 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.yaml
+++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
@@ -183,6 +183,8 @@ properties:
     $ref: "/schemas/sound/dai-params.yaml#/properties/dai-sample-rate"
   simple-audio-card,convert-channels:
     $ref: "/schemas/sound/dai-params.yaml#/properties/dai-channels"
+  simple-audio-card,convert-sample-format:
+    $ref: "/schemas/sound/dai-params.yaml#/properties/dai-sample-format"
   simple-audio-card,prefix:
     $ref: "#/definitions/prefix"
   simple-audio-card,pin-switches:
@@ -226,6 +228,8 @@ patternProperties:
         $ref: "/schemas/sound/dai-params.yaml#/properties/dai-sample-rate"
       convert-channels:
         $ref: "/schemas/sound/dai-params.yaml#/properties/dai-channels"
+      convert-sample-format:
+        $ref: "/schemas/sound/dai-params.yaml#/properties/dai-sample-format"
       prefix:
         $ref: "#/definitions/prefix"
       pin-switches:
-- 
2.7.4

