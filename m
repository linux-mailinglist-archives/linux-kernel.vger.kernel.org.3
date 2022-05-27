Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E93535E31
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350946AbiE0K0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350963AbiE0K0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:26:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0B31157E5;
        Fri, 27 May 2022 03:26:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8jTsmXrwv6xB786JZnr5VtQz1xFpFeqTdEHiNwODZ2N47PmNh5E5QJHa9qVCzlAUxXy4GPW9MwURwakkBGIsB6zYy/WiE29FqteFuZzAGFD+8Quhy83EfWIO7tuOkgPk1HpPEeXgO/zypgIvv7/0Z9cBGG7we/RrCQ+sLzQS4H4iMlGW/chQBOqwW1/YOKO9hCZlji3PCnCvtKUUW+W7z5YGT3ucXOjBCoejM6e9c6VKoQJPCrhPGsrM4V5htkaF3VucnH7a8Hh7iLc9QF7c563XDrljpLd8P/ZxItk9grbniNSbX3bMG05PdXxcNtcjcv3ApH94LBdzx6YZigzug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8ifelK40l1ocqWFhqR4MvnK4XKeeHqDwqvUb5TyT0Y=;
 b=Xio2hI1DQae7XR2/GI+f4+QhkCtC5LU3DbERym+yRWR9oRA1Px7R0gG5zwea+epFgT+ygNq9l7QFEIJqgsXC7HQp7ZMhDVZR0EpGTbJEWdt7eq1oHwXGTKGz4wQxoHn62rjbTO8Qgvjtc2tm3q1akHT6It/ahVl+VLWtg6bDDn6fyZxubpVUq7GRLdIONqnUUMs90/212S54a4mRdhfNkdO9k5iov9TZtzlH+Vkbavw2aJP5Zi7mjI+relxLJutDT4FLKlJgYCmnejFzNAqYvUDJQp0Zd/Ve+9mC8ju4p7Ku/CSUvAa9dtNyZo87xUau1ABGT5lYoJST040mtLzseA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8ifelK40l1ocqWFhqR4MvnK4XKeeHqDwqvUb5TyT0Y=;
 b=EDJDcteM7tJczoDgt0yMfLJnzA0poUGPPzDZZ2RvtplND0KaN+Ofwh8M6Xq58raIUr1ve7gfUIAnNaLeUSoXM/gY+yH+EUFKBQMJ/16bwATe+kg5lYemBxlMjpdyZ7sgatQJZ72+ooFFlpeP/77yx1PWw28L8GESk0GT4CSbJQi5YUik0JcW7BXOjpbhgAK1DkAny+b36rNgCBZ7hw7kUewP+fplFMU2hLFbmkM6N8Bxy34+l1Nw52V5S6hhdbON7jsx7nn17arWoB775nbwGTNh0oPmYzpAiNC2c9eMzQXl/BwkRNyrD0/jRMkIYIhtCEyjyTIUbtdHDTbhSGEZiQ==
Received: from DM5PR19CA0015.namprd19.prod.outlook.com (2603:10b6:3:151::25)
 by BN6PR12MB1250.namprd12.prod.outlook.com (2603:10b6:404:17::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 10:26:28 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::54) by DM5PR19CA0015.outlook.office365.com
 (2603:10b6:3:151::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.16 via Frontend
 Transport; Fri, 27 May 2022 10:26:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5293.13 via Frontend Transport; Fri, 27 May 2022 10:26:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 27 May
 2022 10:26:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 27 May
 2022 03:26:24 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Fri, 27 May
 2022 03:26:20 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <thierry.reding@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 1/6] ASoC: tegra: Add binding doc for OPE module
Date:   Fri, 27 May 2022 15:56:07 +0530
Message-ID: <1653647172-2569-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653647172-2569-1-git-send-email-spujar@nvidia.com>
References: <1653647172-2569-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71be836b-9dda-454b-4603-08da3fcb5c4d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1250:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB125029825494E95BE900A17CA7D89@BN6PR12MB1250.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: al3/924T+9zK4rrFUZ91ityhbHCUwvPYnsNZ04lmCLTHNyD4QrRr+ocjfdRw5rLCI1raehAJyhjECIVwUbPGVBE+j3jEwF4sE3kh7wiQQkqLSOf9Nd29pOHZT623of540SKbLOq4fzgzR9KS6Xbrg+DzxbCgNMlBlXTTFsc0/KUlVtLyA1wdp10IPn+Yz1G28VODEAS1P89qXuLoxb8NlWbJngR3B6KhMOM9LO9tGRkmxCLS2DL5IwrCbHfgyBkjbO8EPcS0hvv/xOZeDYhXzaKeZL8k31e14LekXyAeOaujN/TLiOsJCGXGhLS56iZYrvMxu44IHs40ng+iBpJgFGXqmKfO462yYjfHA1nEJA1toXZ1LW3FrjQqg35bDMyMTe3RoCMw32JqYAWWJV7Trqw0noIr6pKvYh1oztkJf6Q7fpIjSB8X4169iLJGrx7cA5xSRqp2pl+B6K2Ri0kezsvK2QqITSz0ZvejRJQiC6hkHgpha3z/yPWXGGlCXi4h32A9yI94kbLZRxnLRz5eaMRjNzmrsNeqm2jgJhbCVt0z8S2UUWlCA7CQiy5z3rSuKuHfkT0xHUK/4oF3uY2GOQWeilfqFNdWZXzxvwprK8jLwQ6hhtwaQnbJ6kANa8OsKjdJUiWZ30+pRlAIAl48Dq3pTWEEeLTIpOkf9/b7QmRjkbvkTr+4wmTREw1KZ614zqvXZIOKPdmOBnAS+NO1HZBNIDrIEe6UlaxFjs2Xmae7vcq/wai51pMHenVJaRZhMfpMphe/4yhe4YEJkWbhVG7KFbl5tF2eJc6DnAHRQi2DT07h4ryOq7kW6M253+p6QVuN05geY22Xmd1XxumvcQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(86362001)(36860700001)(4326008)(966005)(70586007)(70206006)(40460700003)(8676002)(82310400005)(5660300002)(54906003)(316002)(508600001)(36756003)(7416002)(7696005)(26005)(356005)(2906002)(81166007)(110136005)(2616005)(8936002)(83380400001)(107886003)(6666004)(47076005)(186003)(336012)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 10:26:28.4419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71be836b-9dda-454b-4603-08da3fcb5c4d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1250
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds YAML schema for DT bindings of Output Processing
Engine (OPE) module. It consists of Parametric Equalizer (PEQ)
and Multi Band Dynamic Range Compressor (MBDRC) sub blocks and
binding doc for these blocks are added as well. The OPE will be
registered as an ASoC component and can be plugged into an audio
path as per need via ALSA mixer controls. The DT bindings are
applicable on Tegra210 and later SoCs where OPE module is present.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 .../bindings/sound/nvidia,tegra210-ahub.yaml       |  4 +
 .../bindings/sound/nvidia,tegra210-mbdrc.yaml      | 47 ++++++++++++
 .../bindings/sound/nvidia,tegra210-ope.yaml        | 87 ++++++++++++++++++++++
 .../bindings/sound/nvidia,tegra210-peq.yaml        | 48 ++++++++++++
 4 files changed, 186 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-peq.yaml

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
index 6df6f85..47b6e71 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
@@ -110,6 +110,10 @@ patternProperties:
     type: object
     $ref: nvidia,tegra186-asrc.yaml#
 
+  '^processing-engine@[0-9a-f]+$':
+    type: object
+    $ref: nvidia,tegra210-ope.yaml#
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml
new file mode 100644
index 0000000..0d55328
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra210-mbdrc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tegra210 MBDRC Device Tree Bindings
+
+description:
+  The Multi Band Dynamic Range Compressor (MBDRC) is part of Output
+  Processing Engine (OPE) which interfaces with Audio Hub (AHUB) via
+  Audio Client Interface (ACIF). MBDRC can be used as a traditional
+  single full band or a dual band or a multi band dynamic processor.
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Mohan Kumar <mkumard@nvidia.com>
+  - Sameer Pujar <spujar@nvidia.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: nvidia,tegra210-mbdrc
+      - items:
+          - enum:
+              - nvidia,tegra234-mbdrc
+              - nvidia,tegra194-mbdrc
+              - nvidia,tegra186-mbdrc
+          - const: nvidia,tegra210-mbdrc
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    dynamic-range-compressor@702d8200 {
+        compatible = "nvidia,tegra210-mbdrc";
+        reg = <0x702d8200 0x200>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml
new file mode 100644
index 0000000..7cbc756
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra210-ope.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tegra210 OPE Device Tree Bindings
+
+description:
+  The Output Processing Engine (OPE) is one of the AHUB client. It has
+  PEQ (Parametric Equalizer) and MBDRC (Multi Band Dynamic Range Compressor)
+  sub blocks for data processing.
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Mohan Kumar <mkumard@nvidia.com>
+  - Sameer Pujar <spujar@nvidia.com>
+
+allOf:
+  - $ref: name-prefix.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - const: nvidia,tegra210-ope
+      - items:
+          - enum:
+              - nvidia,tegra234-ope
+              - nvidia,tegra194-ope
+              - nvidia,tegra186-ope
+          - const: nvidia,tegra210-ope
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  ranges: true
+
+  sound-name-prefix:
+    pattern: "^OPE[1-9]$"
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    properties:
+      port@0:
+        $ref: audio-graph-port.yaml#
+        unevaluatedProperties: false
+        description:
+          OPE ACIF (Audio Client Interface) input port. This is connected
+          to corresponding ACIF output port on AHUB (Audio Hub).
+
+      port@1:
+        $ref: audio-graph-port.yaml#
+        unevaluatedProperties: false
+        description:
+          OPE ACIF output port. This is connected to corresponding ACIF
+          input port on AHUB.
+
+patternProperties:
+  '^equalizer@[0-9a-f]+$':
+    type: object
+    $ref: nvidia,tegra210-peq.yaml#
+
+  '^dynamic-range-compressor@[0-9a-f]+$':
+    type: object
+    $ref: nvidia,tegra210-mbdrc.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    processing-engine@702d8000 {
+        compatible = "nvidia,tegra210-ope";
+        reg = <0x702d8000 0x100>;
+        sound-name-prefix = "OPE1";
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-peq.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-peq.yaml
new file mode 100644
index 0000000..fea4c63
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-peq.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra210-peq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tegra210 PEQ Device Tree Bindings
+
+description:
+  The Parametric Equalizer (PEQ) is a cascade of biquad filters with
+  each filter tuned based on certain parameters. It can be used to
+  equalize the irregularities in the speaker frequency response.
+  PEQ sits inside Output Processing Engine (OPE) which interfaces
+  with Audio Hub (AHUB) via Audio Client Interface (ACIF).
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Mohan Kumar <mkumard@nvidia.com>
+  - Sameer Pujar <spujar@nvidia.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: nvidia,tegra210-peq
+      - items:
+          - enum:
+              - nvidia,tegra234-peq
+              - nvidia,tegra194-peq
+              - nvidia,tegra186-peq
+          - const: nvidia,tegra210-peq
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    equalizer@702d8100 {
+        compatible = "nvidia,tegra210-peq";
+        reg = <0x702d8100 0x100>;
+    };
+
+...
-- 
2.7.4

