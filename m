Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4273653C517
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 08:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241553AbiFCGge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 02:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbiFCGgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 02:36:32 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22866377EA;
        Thu,  2 Jun 2022 23:36:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D56EuylqmdAH822p4nuKoE8lhVi9/npiyvxX6st3dFNyJdUgrR0iNDGKOEf2c+dpvA8RuAJ++xmLYgv7zG8B5Pa7NY3XNDCxDkpWsZrhZs20NvoH+KQ/TDOpEyiQ0pEg5e/08yszIhJA8WQFEJ5e0YmGHJzE0omyAxLDIwPiz8OD/kPOwBMhiE1vRQkLQZTwJo5dQ0HpKN0p1FKPYL1zywWSWvxetbc2Pm/1lZWw0w3D2qdZOCLfxDTG/uxuoigrl3IbKJbw3ZtD34c7oEoU9K3Fdh3T8wiIyCFFiHaFaEf4QfrbaqeV8UFhoLA5IoUpWur6Uu/aA7V/VtbixDJrZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3Q9aPmCQOX7CrGYLdrBQOeCpg07gSTLhnB4eccVBEU=;
 b=fPqyDZ504OXuZrtJ9heDWElEvwkk3pAeWASCSdp+digHP+EZOXb++T1wOTOuhEJrdvRazaAnzuqj1JTCNV7PJySsjz+GyFk6trlqbZxWBxzyLZpxzQUfZl/W7BoYV7ClgSZF2BZWBJlZkk6aDxJ5Mf+hnysy9QYzGyltVc/W2h6+dkGd7wh0e5fNaqcYaaFqodqK8/T2oDok8Sa6ln9Cji6SMd+vZb/nYwF0jpVmdz5Zw7P1OseH3qvwUoEW92eHW4KpYBfG3HearBWikJxSykSWCxiBq0ZCRC5S+qEWpYl3nWKTT96d2G9JRcb/eyyzg1KXOvLKf2DMdOLaEddhVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3Q9aPmCQOX7CrGYLdrBQOeCpg07gSTLhnB4eccVBEU=;
 b=aioUo/XKCPJ7EdEq/bKHbLj7YnlEMth9FWQ9zkEGU9v02IVd6CkVysAibDl0aKmuhQx3iJ9SQPDCsECt87IMq9nNK+lzFDtSze+yTOf7Sez+cUmiVIhhvb7UQr828oOzvMaeZFtahuWIHzb87qjl8eB4h02dz8kF8goW5IpVvQPSzKX19UxOIMGxOIUySwNSp2iVom8RLJdCTUvEtb6LX+dp8rumpSn+M8ELRt2wKRzUlIyP+8+RSGbiExhqahGYDO0M4tb7+DGiAo4/9N602Hr+X1m/KugAe5dnfDGKG2607gdhfSjwnLtr50KriNoqU+I2c9J3jzXzeiIEZUEUig==
Received: from DM6PR11CA0027.namprd11.prod.outlook.com (2603:10b6:5:190::40)
 by DM5PR1201MB2539.namprd12.prod.outlook.com (2603:10b6:3:ea::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 06:36:29 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::f0) by DM6PR11CA0027.outlook.office365.com
 (2603:10b6:5:190::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13 via Frontend
 Transport; Fri, 3 Jun 2022 06:36:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Fri, 3 Jun 2022 06:36:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 3 Jun
 2022 06:36:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 2 Jun 2022
 23:36:27 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 2 Jun 2022 23:36:23 -0700
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
Subject: [PATCH v3 1/6] ASoC: tegra: Add binding doc for OPE module
Date:   Fri, 3 Jun 2022 12:06:07 +0530
Message-ID: <1654238172-16293-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654238172-16293-1-git-send-email-spujar@nvidia.com>
References: <1654238172-16293-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fb85fd2-ec7a-4b1a-1b3d-08da452b63f1
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2539:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2539EAF876EEE65AD65B24A5A7A19@DM5PR1201MB2539.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yK3mbqNNgHZ3eqdgY8jPXxEu6vowQyis2C2gr9NbTS2j+9HkQ/Y14VAjja7UPvso7M12RlA4t1x4lJo5zFyB7M7H8+ha25oAoSfIIJADTZ0TuJgDwiPjz7uMqQ3MNnQqwMx+4FCY3gf9PwOtU3ZDcniXYB7CtCXfhj5x+3yfIUaYREWmLjxrPAjft4oOWzJJt8BNUB5wX5E+yVAv7VOvSSemvclPsVknNqzI+C9PKANJReSvfnSvcHfQ+U9b1R7d0yO0R7dqV/x6P2CESTnzoM09XIyHefTjurN1C2hhrxu9qKW5ba2vVsk698DnxPQh0b2ISJUmL9/E/YJ1FkZrnqsj5i9mKWV6RE2nScX++3daqSD22+WPheFOtbAwpOZDPCnZuHtZZm+XUhhrTbu6Y/AYKmmDOVVoCI5+D/vf0VAw91sMNOeU3WJOFC65E6baj2Xz8cztgu9iO6BinPYSuldzS4Ml+uPUrXRLpW92vpT9ZAPwNgjUiWr/If73RGOAbUlXr2K2LGmSdh9igQiwGmK8G8hVsaz5xBxSYU0doJ5T/KxKIk1JH4baRb/9uVfohvgHT0vyroBR4rL1jtqwjK6bIkELqwBr//Yyzx/Sbrh34dTZngRthpcoWjK1FcoMuXTTW/UePhnwIY6fUgz84nGyMEH2yhEp32LvuY+PgrEHxmyZNFJSc06GsIdZdHp+RnlERsMGBNPn8pvrJNgtrsWIftialZkiSZNf6dWkg/LDSkOrR0BqOhlN86FFANi9q+aAN+TDIKaTCc++jA98gi6t+eY6schDA2pxdXduUNuxAmZoLX28/rfrVmQTB7BWh5XU0cYK9qSR8TabmX9suA==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2906002)(86362001)(356005)(83380400001)(81166007)(316002)(26005)(36756003)(4326008)(70586007)(7696005)(70206006)(82310400005)(966005)(5660300002)(186003)(40460700003)(54906003)(110136005)(6666004)(36860700001)(7416002)(8936002)(8676002)(2616005)(107886003)(508600001)(336012)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2022 06:36:28.7908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb85fd2-ec7a-4b1a-1b3d-08da452b63f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2539
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

