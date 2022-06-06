Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41B553E6A0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240196AbiFFO73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240204AbiFFO7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:59:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7827A3082C6;
        Mon,  6 Jun 2022 07:59:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZndErJfwl61j9jDRe56y7DNkc2KamoJz6GG0dqpL+Jy2UYCdtxJnbdJF1okkWxr7hSjTKsOesb6C0sPCAemawZHvLVNCKyOXuC4LzJIvGTSGzdiply0lrLJ8jBi4mrdv7LmBCaZzYWp/M80Suwpx2tCdFooWrkngmNQ9ukP/CxAF0EHA5TBpOSL9vrJpfUssAN++VrSrAOI3+Ov31D+wXfKY7LKKbAy1+iTDXc3WCR+JWI6q6muf8+PFrrGcoQco/CvYIvoCYoKkkXIp84GZdRCPESeBSCGlfUwIOJ/l0SZOy6ldxL6M+SfM3TxSMOai7ZXZE3TUw+1Re57AQ0GMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3Q9aPmCQOX7CrGYLdrBQOeCpg07gSTLhnB4eccVBEU=;
 b=MiIAhY0QPi8F89+8NQI1Kuz04grMkCma9SBaFWnIFaqp+FsjyiuivCTSjYzQkpoQ6xfttgwVeYwZgUG3dtBZA20XsLry4axTmkMxoAG/h2UFBuI6yl60eK7bsjnOVlNY9g/jTmZHn+ugwNdI4ATFTaMxepAOBMxWiCRm1q7pE0mzrQ1feW++m9i56G0+HpHouCautYy6iwHycRs555qJP5TQgdQYar6abLWmOQurJFmKtWWs4x2m4ZPRJ2RriapSvlW0Dh4EMMoPOfFnX0+aJQan4Ww5cIRCCCmjRLtPiRWXB0+pUtStUemLA6e5cMY9ZfENsIldXlZEins+nSYEqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3Q9aPmCQOX7CrGYLdrBQOeCpg07gSTLhnB4eccVBEU=;
 b=rcsJfbEKAhkWu/o3egnWQQ7GgZy5UmZGWOmBe5kgxhDjlx0dB6HJGZTjJ0a+5iFgcpDLJbXKyZGW1hOZP3K33vI0T5Vvd/rTs/Yxjhj4GKCqU0sqBvkBUqQkThflSEqIS/uEylH/50NoumQ6w71i/udtgy5YYY76fsb4i+sB7IPPK+awLST8SixSD4WA73iBKs4qvQiS0Ne51bd+k1hLtstb0CmS1efOgi0qtqm5nVDjrkPvnYMwoDWNsLZFYn/ImkFzKY8ntTdDZiRtuvgl9pY6YliUhWEtAX553BFMm7QFJWqdL9BrqSjRKCoTXHLjRn3y7Py98rDohRVK0C2Qog==
Received: from CO2PR04CA0190.namprd04.prod.outlook.com (2603:10b6:104:5::20)
 by MWHPR12MB1759.namprd12.prod.outlook.com (2603:10b6:300:113::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Mon, 6 Jun
 2022 14:59:17 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::b7) by CO2PR04CA0190.outlook.office365.com
 (2603:10b6:104:5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Mon, 6 Jun 2022 14:59:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 14:59:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 6 Jun
 2022 14:59:16 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 07:59:15 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Mon, 6 Jun
 2022 07:59:12 -0700
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
Subject: [RESEND PATCH v3 1/6] ASoC: tegra: Add binding doc for OPE module
Date:   Mon, 6 Jun 2022 20:28:52 +0530
Message-ID: <1654527537-31038-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654527537-31038-1-git-send-email-spujar@nvidia.com>
References: <1654527537-31038-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02fc83bb-2397-4d17-de67-08da47cd20cb
X-MS-TrafficTypeDiagnostic: MWHPR12MB1759:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB17598B8D550357CA71AC7601A7A29@MWHPR12MB1759.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yO6ao+Tl1l+yjf2MjDcddnX6tLiRPGQJ5hE3ts+3J7ic8/41ODAHUQxovziOgZWJVneTH0ltR/D0wffBBb/g8I9zrmn1OCgyxjl3b928ZFBicPqhjP5NGx0hEgzr6RGVSNs75WgwhdO91rJQ9qjvMeWyNokSDmMF8D7ml6/88KpoXZ+VRno/9H8cYWjJUdU/h1Q5Bj/HL3F4a/Pt3FE4m4sCbZJ6UNAjQQrAkwex5QzWoR1WggQrbYcD6Av2AdjZRVy+uhnJsMIO2r47NBP2FkpzLaw8jgXifhW2HpZcouYb3zpMjT/APpcvS5lQRtWzBVXwmRWiV98nwUbLITeb7eAs9cImv3Vv+fEWM0dV7GCAkb2eEtG59jJONjpkGmTtkI74KsgA2Yh8VLOY46kErqbxEY35Aq8x7+S20Ksx/qtLFHjxfLrGIMALEfQdtJfmV6csgwaWAasydzMhcr8pnhEC1Tp+8TvdDD5+aCU1gzaucNKtX0+hhv32BwMYJk0kCNIr8+6HpsJoEEMnvv+3GrD6dUWkEmqQaM4r0K9kfhzj7PItZouPmb3ujl9pE+fICTlQhc8vB+f35U6BxK2nB3mvunwh8IOKW0T7F9G4eSb4J1CRtpOR9Iw1+o2+6Ovdf5IzD6pEqYqTd/OFXFo1SZNlYbAWHD1YHhLqFS6aLYdbJqNrCwq14Ko6JBOwbHn5FVAC2I5xWAgF5sbBZgzX+adfq3IKITEtMZ4566d0NQNoGKfM0ZaM+QARStvfmkfml4+cymBegzTp+ObaUbJs9gj19JSijyyg3qNaUMz8ZOjYKp+EkXD6oZJgT6cWyXyp0Cr+tyJDYoWT4MrGC6xX7w==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(336012)(47076005)(107886003)(6666004)(426003)(36756003)(7416002)(966005)(186003)(2616005)(83380400001)(26005)(36860700001)(7696005)(81166007)(110136005)(40460700003)(8936002)(356005)(316002)(82310400005)(508600001)(4326008)(86362001)(8676002)(70206006)(54906003)(5660300002)(70586007)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:59:16.9196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fc83bb-2397-4d17-de67-08da47cd20cb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1759
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 0000000..5b91986
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra210-mbdrc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tegra210 MBDRC
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
index 0000000..9dc9ba5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra210-ope.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tegra210 OPE
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
index 0000000..1e373c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-peq.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra210-peq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tegra210 PEQ
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

