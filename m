Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2348E52C14E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbiERRi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241013AbiERRiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:38:19 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2063.outbound.protection.outlook.com [40.107.212.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE331FC2FC;
        Wed, 18 May 2022 10:38:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ER51z/XtdI91TWJ5eyedIFzzOfAabuRjXuPHxj8mikcIvctFAYIIY/zGvCE16QS/vwESI1MM5OIPJo8DSqYfUNf3VwClX9sLgTW0nBxj1261HxuWkcXACO4NX9DaDoCw6r84xp59VVhd1eTeempbGg+Adk/x4AQKjny+Hw+LxzOtlNnva39r7G2PAuZluFBEvIwnSe6HPPh0l5JNUjA2t+H81pWqLGulH+ogCGT2mPxftVYULPCeKW/sWGn7rsVw7mcbiQIehfw0YpaYjUwthe6QVV8Yd0FQLAbeVFXmH1a1xIUR8Keq3v32na+VwdZGrNGEd6mFmdvjceE4mLh5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWviY0WluoQQo/oALU5u7URdWEH12VU+/MSn9IQDLQk=;
 b=NfpHUTe0jPspeBJ/dzf7jl8fNlO8dKUaZTE8qylLS42vjKEvz05v+zSQFkByXDIXKDK0hbtvz08KglACmT8JtiDmOMqe1gWHf/k/14CgPRhavQEdxxo3QCiTKSHQGmyF2JRYm/03n+c2Kncv4kEVnh1ttY+fdq12ffUBAmo+XsmQs1wawEuhDbNQEFHkXmO6ZQjrJdYzm2PexVyXOEFAxGB8PBCgiu490cfAXcVFd84qb/cZdRTI/yySF7JlX+GMrYCuB3je2wKUYlC/eQXssWajFc06P593Dd9hxuYsQHBZibU6+ykXH6uThF0aIPbl/6D8yXxtxqDpLywX9wrwBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWviY0WluoQQo/oALU5u7URdWEH12VU+/MSn9IQDLQk=;
 b=N2txcc80+DY9IZ6BADr0aNmaWuT4c+3WOdqzkC7x8umo24uVUTOPeI70CgWx2CERRbcQbFPkumCrfdY5Bl3HiI79v+IvwTZKvCk4AQcoUXmWPVdcaGwPfOUuVYz/VYwPgSdoSE29qDYF6hhfQQBU8Hz4rHvNezGe3ennaxbGTuYTTYDkrNmFmfy1PCX2c/BRzU9OG/f9tsmU+2v3NonnAd0HRCPgQIyERpeAdCF2EhkkgvGVLI4/U6ev7i0k0WDYTj8HJIoYgM3BCHXsah4kfAClq3HobkGMC3T+oNuMriZ4ujnvnEZB1fKDDAHsYV17G/4kJY6/YWV8yze2rzAsSg==
Received: from DS7PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:3b7::12)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 17:38:16 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::8d) by DS7PR03CA0097.outlook.office365.com
 (2603:10b6:5:3b7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Wed, 18 May 2022 17:38:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 17:38:16 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 18 May
 2022 17:38:15 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 18 May
 2022 10:38:14 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Wed, 18 May
 2022 10:38:10 -0700
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
Subject: [PATCH 1/6] ASoC: tegra: Add binding doc for OPE module
Date:   Wed, 18 May 2022 23:06:07 +0530
Message-ID: <1652895372-29885-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652895372-29885-1-git-send-email-spujar@nvidia.com>
References: <1652895372-29885-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe669ecb-7f73-4e7a-0df1-08da38f530b4
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB617922AB63D059E96979691CA7D19@CY5PR12MB6179.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WmGAURSPJHb3S1neKHW8kX+EGHFWbeeJ/QvPcUr5Uh1mGPudpyGyEGCm9C7YTfn8v1QikgNuIdbCRL16BAEZncM8OLdwbsjiiL/E1QaOG0kVxjJeRHg/QEDQHD0GGL8Jz32a73hiXg8+9Wgt9VWyyl9YRjoxQlj+1+NQ/KPZyCCTsDyzOiyVm8Rd26HqgLUDmANQajGjG1gjNKLV7duvaspTpcFUYqubUdQqwmxupp0LZsCm7YreO9fn+NlULs+NftT4wbWsmrLGjCfJP50yIoUfLZeSQ3U7Vpy+JVbx7oCsKxSDWvslOy0y7jQTjojaBgCe1eDV0JROzCUg+FMenVlihLa4lSA3n3YCpDz2IMggDSSL7rb13xHR29nYQoudPsuBKSkmuT+jgJ0Fej8emeMH+npYxEUSMbn93yrh7GcKu0QyvolLcKQMLP16662v4FJgxaiiH8kRKOanvxBLkkev41PwonSo78bjBGcW4oxVdIGaCrd/0cEbzpSP3URJF+Am/wWG1QbQMNEEJWDJv9tjeIvifCQ3AuriAN1i9WTuxYDUAL6JGBHKRRRXYSQdA9+tD+HQmQHBQTDKFlTahqhmWWN1anh7Dd0MZziTBM29/Bijmd66BUJU74xrit3Bh4elChJwJl8C25mLXD3McRBLM1j7U5VS/xE3qQ+uqNZJN3qpfJieu3Ytuv3poXm3Emq9W7FHiklIhIOxxqdujYVywBgnxD2K0x2L66CBRTZ7tHFn2gJuO2nZEnCrv4pHgTQnv6/CsYvwntUMYK4v/5YycIN5D24HmRmwoGPfh0Req/MKSFR25cz4OkhYlX6iytXNPKnXthcTmOhzKyAm0Q==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(336012)(426003)(2616005)(107886003)(47076005)(186003)(7416002)(6666004)(2906002)(83380400001)(508600001)(7696005)(26005)(966005)(82310400005)(70586007)(8676002)(356005)(4326008)(86362001)(40460700003)(70206006)(81166007)(54906003)(5660300002)(316002)(36860700001)(8936002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 17:38:16.0345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe669ecb-7f73-4e7a-0df1-08da38f530b4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 .../bindings/sound/nvidia,tegra210-mbdrc.yaml      | 51 ++++++++++++
 .../bindings/sound/nvidia,tegra210-ope.yaml        | 91 ++++++++++++++++++++++
 .../bindings/sound/nvidia,tegra210-peq.yaml        | 52 +++++++++++++
 4 files changed, 198 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra210-peq.yaml

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
index 6df6f85..1fb93d9 100644
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ahub.yaml
@@ -110,6 +110,10 @@ patternProperties:
     type: object
     $ref: nvidia,tegra186-asrc.yaml#
 
+  '^ope@[0-9a-f]+$':
+    type: object
+    $ref: nvidia,tegra210-ope.yaml#
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml
new file mode 100644
index 00000000..199712ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-mbdrc.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra210-mbdrc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tegra210 MBDRC Device Tree Bindings
+
+description: |
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
+  $nodename:
+    pattern: "^mbdrc@[0-9a-f]*$"
+
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
+
+    mbdrc@702d8200 {
+        compatible = "nvidia,tegra210-mbdrc";
+        reg = <0x702d8200 0x200>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml
new file mode 100644
index 00000000..92488fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra210-ope.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tegra210 OPE Device Tree Bindings
+
+description: |
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
+  $nodename:
+    pattern: "^ope@[0-9a-f]*$"
+
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
+        description: |
+          OPE ACIF (Audio Client Interface) input port. This is connected
+          to corresponding ACIF output port on AHUB (Audio Hub).
+
+      port@1:
+        $ref: audio-graph-port.yaml#
+        unevaluatedProperties: false
+        description: |
+          OPE ACIF output port. This is connected to corresponding ACIF
+          input port on AHUB.
+
+patternProperties:
+  '^peq@[0-9a-f]+$':
+    type: object
+    $ref: nvidia,tegra210-peq.yaml#
+
+  '^mbdrc@[0-9a-f]+$':
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
+
+    ope@702d8000 {
+        compatible = "nvidia,tegra210-ope";
+        reg = <0x702d8000 0x100>;
+        sound-name-prefix = "OPE1";
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra210-peq.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra210-peq.yaml
new file mode 100644
index 00000000..0f78746
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra210-peq.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra210-peq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tegra210 PEQ Device Tree Bindings
+
+description: |
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
+  $nodename:
+    pattern: "^peq@[0-9a-f]*$"
+
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
+
+    peq@702d8100 {
+        compatible = "nvidia,tegra210-peq";
+        reg = <0x702d8100 0x100>;
+    };
+
+...
-- 
2.7.4

