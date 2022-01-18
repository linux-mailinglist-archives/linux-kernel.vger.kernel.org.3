Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D974912A0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 01:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243908AbiARASv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 19:18:51 -0500
Received: from mail-mw2nam10on2046.outbound.protection.outlook.com ([40.107.94.46]:41153
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243853AbiARASp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 19:18:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxIiBSieFfht+xAMxrvanB7k+j9pprShQQ4j3GNqgE4aNJsOouXVV4aGvvXaib8hTGjpi8Vpu0G1+UBEXdZ7VI+53pP7xwHDIKz+9hkukS8iulebO2Xxs/x/ViDT8FDEOBSCbK10S5nFuvC4FQsH6DN6Ir8tq3XmdqN+9XcqoUsxECQyzGsWkN6l2P7cgjp8l5hWCP98awiEj7Z4JCzmEz2yJC/CcVPP3IL+5Ti4jR3gQYbOrKNzp6H5oeEiMEWUd2xinIN+GW3UVtmjMN7Jy7G386ELg9U4LxfHDevrvLdJ6n12RL+lLNmxF3sFZViJjJ0N+rQBT9aTS8uEXIQpQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09ascasylkK7Ga+v4u5DabRgic8M8Id9ON1Q4Wg/toI=;
 b=GYP13IlIOVheUgqtMy6cYLv9Y0UYg2vu/SeYcZ4zIv8CYplpfIuew10oxq0lT/Xvi/MZrOkUAmlM5jCfD5OPM4EFze0oC5jlQ3L5vxsJ/ufisgFvVilwhcpo+2aA0eIOMiu+ryM46XZ+05ND8EFtXOx+q3Adl8hDOQVWdakF1trK3Ot/hdmswZou/hgRuvrfWYFQxYc0fqDXKNotF79n33IYSpvgh5r0gVdH7FA9AHO+fjj/K1fAAkRKTQ0X7J4DKtu24WpF83vLpprXEfUxAvml3vW7mItgHya3GaCuaFrxEG/Hdq/k63uliK28F5NeSQ7Ytp0xBqmHyn/e6crliA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09ascasylkK7Ga+v4u5DabRgic8M8Id9ON1Q4Wg/toI=;
 b=Je5dUHq2tcy/HajmVi/TNqN+UGkf4dwhtVOwgmodBDzRb3awrpIsd+y0fPUmwBHixuhylCcaRUpLGuD3L7qudo4WYBkk6bAe+LxNcQE9NIx+eqqIZsezbIbJy9jde697dBiM/yMmiV+6+Y21eGDDtr1CcXgLgAOpfUO2OCVoXRSth8xHhjKExsvTUryZxNFaNfEETu+q7zw7ThFBCQinDe1dyWhnOczu5jdauwXea86wKgtvyR3QQyX+9RkRGqUXLj2stoSqf4U2eIhWsKZzFQeffil68WHLKV5Cs/Ysvvs5X2dPC9/9xc6BHD9otBaF/KcCECkS7um6mwWjm9yQbQ==
Received: from BN9P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::20)
 by BN8PR12MB3316.namprd12.prod.outlook.com (2603:10b6:408:42::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 00:18:42 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::3e) by BN9P220CA0015.outlook.office365.com
 (2603:10b6:408:13e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Tue, 18 Jan 2022 00:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 00:18:42 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 18 Jan
 2022 00:18:42 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 18 Jan
 2022 00:18:41 +0000
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 18 Jan 2022 00:18:41 +0000
From:   Dipen Patel <dipenp@nvidia.com>
To:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [RFC v4 04/11] dt-bindings: Add HTE bindings
Date:   Mon, 17 Jan 2022 16:22:07 -0800
Message-ID: <20220118002214.18271-5-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118002214.18271-1-dipenp@nvidia.com>
References: <20220118002214.18271-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36deffff-55df-4a73-6349-08d9da1815be
X-MS-TrafficTypeDiagnostic: BN8PR12MB3316:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3316571751065D78DD57666DAE589@BN8PR12MB3316.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xckvoSRaSb8BI6IWqlgv6Rh9cDxa7KXSo2oOo+ZQ6AF1NeUINBCgl98T/asF?=
 =?us-ascii?Q?17eRTKLDUkiifcOMAUDEDy+dN+OgrnYp+lh8OBq31RFz2MnX5sih+UL4EzY4?=
 =?us-ascii?Q?Iojvc4NNcanbEsMkfEvxa2RWnUJ+lnAwYeZPO+3Hr6kCsU3Pkmu0BHC3eHMS?=
 =?us-ascii?Q?O9+IyVzUqEC/iozNpyMNAeGbEOPUqd1GptheD3kzz5Db3bnTAiXQGGOFOEG2?=
 =?us-ascii?Q?lPoatH4VNcGnrKq6EiOPPNW+rfOUvFmLNJd/+EVpP4QdUGpoh3mCzomXMGku?=
 =?us-ascii?Q?wSf5VA1YhCKo7GH3m3JPi3oHDJBjYezvKuexJz5BNmdNHGN50U3nl5WfmrdR?=
 =?us-ascii?Q?gPKAKcI4fBTbyJle7VfDIsNHlQGplaL+oPruLYZgnXRudLQwRvyx2+FucmXT?=
 =?us-ascii?Q?K01jY5GReP6DiIhjCMFFc7TIcQgujTvpH9DWCHK+N0kPCHkmzx/tXxYCJ+Xa?=
 =?us-ascii?Q?KjQhRKNhLnmCwmgNt4DAZxwJ7wIsEPa0dQnDgjXo3NhJk8pV8QZvgg3sX+1L?=
 =?us-ascii?Q?R2oGBVCH1bHTv0TdDiO+3VQdHpd3hSh8oi9+1vrN7TTpgjTyTIAk4XJH94wY?=
 =?us-ascii?Q?WSx7CAYe451jLciuawkylOasRnKCLlpTjOIYkNmgIbUCLAosOb1ZWPIUdjsr?=
 =?us-ascii?Q?LSil+o7FtiaDpwa1zClsOTBFRsiydkQV5Dd3C/0IirebwSBh2fPPtNo1rzKr?=
 =?us-ascii?Q?uDxArtYX92lFkbFx3T1fmnekjW4UQUHCVFaoP8+/F3qej/E61i3eyw3Afte8?=
 =?us-ascii?Q?P8UGT91a4l+SFj/JueQP611szlgfDFmnIXLXoCVJ9CAxEVHq4wCmNf1B4he3?=
 =?us-ascii?Q?WdaolNIMMvcoAPUvsquzQEoGVoCMjBT+pcqB4mLwgyYcserbQVFz/5dx3Fu7?=
 =?us-ascii?Q?/yLQhSGxNppYyIqdczbg622nq7qkPhD/sN9c5MI2OL9K7LLZ4dPrjk9bv++8?=
 =?us-ascii?Q?bl2PgUimraSUuRaJ9/AdeYVgs1fAeG6XZZX/AacOv0s=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(70586007)(26005)(36756003)(186003)(70206006)(86362001)(921005)(2616005)(426003)(81166007)(5660300002)(4326008)(316002)(40460700001)(508600001)(2906002)(107886003)(336012)(8936002)(7696005)(47076005)(110136005)(36860700001)(7416002)(966005)(83380400001)(6666004)(8676002)(356005)(1076003)(82310400004)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 00:18:42.6786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36deffff-55df-4a73-6349-08d9da1815be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3316
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces HTE devicetree binding details for the HTE subsystem. It
includes examples for the consumers, binding details for the providers
and specific binding details for the Tegra194 based HTE providers.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Replace hte with hardware-timestamp for property names
- Renamed file
- Removed example from the common dt binding file.

Changes in v3:
- Addressed grammatical errors.
- Removed double plural from the respective properties.
- Added dual license.
- Prefixed "nvidia" in nvidia specific properties.

Changes in v4:
- Corrected make dt_binding_check error.

 .../hte/hardware-timestamps-common.yaml       | 29 +++++++
 .../devicetree/bindings/hte/hte-consumer.yaml | 44 ++++++++++
 .../bindings/hte/nvidia,tegra194-hte.yaml     | 82 +++++++++++++++++++
 3 files changed, 155 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
 create mode 100644 Documentation/devicetree/bindings/hte/hte-consumer.yaml
 create mode 100644 Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml

diff --git a/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml b/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
new file mode 100644
index 000000000000..ee6f94890695
--- /dev/null
+++ b/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hte/hardware-timestamps-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hardware timestamp providers
+
+maintainers:
+  - Dipen Patel <dipenp@nvidia.com>
+
+description: |
+  Some devices/SoCs have hardware time stamping engines which can use hardware
+  means to timestamp entity in realtime. The entity could be anything from
+  GPIOs, IRQs, Bus and so on. The hardware timestamp engine (HTE) present
+  itself as a provider with the bindings described in this document.
+
+properties:
+  $nodename:
+    pattern: "^hardware-timestamp(@.*|-[0-9a-f])?$"
+
+  "#hardware-timestamp-cells":
+    description:
+      Number of cells in a HTE specifier.
+
+required:
+  - "#hardware-timestamp-cells"
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/hte/hte-consumer.yaml b/Documentation/devicetree/bindings/hte/hte-consumer.yaml
new file mode 100644
index 000000000000..bb1232b31455
--- /dev/null
+++ b/Documentation/devicetree/bindings/hte/hte-consumer.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hte/hte-consumer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HTE Consumer Device Tree Bindings
+
+maintainers:
+  - Dipen Patel <dipenp@nvidia.com>
+
+description: |
+  HTE properties should be named "hardware-timestamps". The exact meaning of
+  each hardware-timestamps property must be documented in the device tree
+  binding for each device. An optional property "hardware-timestamp-names" may
+  contain a list of strings to label each of the HTE devices listed in the
+  "hardware-timestamps" property.
+
+properties:
+  hardware-timestamps:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      The list of HTE provider phandle. The provider must document the number
+      of cell that must be passed in this property along with phandle.
+
+  hardware-timestamp-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description:
+      An optional string property.
+
+required:
+  - hardware-timestamps
+
+dependencies:
+  hardware-timestamp-names: [ hardware-timestamps ]
+
+additionalProperties: true
+
+examples:
+  - |
+    hte_irq_consumer {
+              hardware-timestamps = <&tegra_hte_lic 0x19>;
+              hardware-timestamp-names = "hte-irq";
+    };
diff --git a/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
new file mode 100644
index 000000000000..c7d2acdb862e
--- /dev/null
+++ b/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hte/nvidia,tegra194-hte.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tegra194 on chip generic hardware timestamping engine (HTE)
+
+maintainers:
+  - Dipen Patel <dipenp@nvidia.com>
+
+description: |
+  Tegra194 SoC has multiple generic hardware timestamping engines (GTE) which
+  can monitor subset of GPIO and on chip IRQ lines for the state change, upon
+  detection it will record timestamp (taken from system counter) in its
+  internal hardware FIFO. It has a bitmap array arranged in 32bit slices where
+  each bit represent signal/line to enable or disable for the hardware
+  timestamping.
+
+properties:
+  compatible:
+    enum:
+      - nvidia,tegra194-gte-aon
+      - nvidia,tegra194-gte-lic
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  nvidia,int-threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      HTE device generates its interrupt based on this u32 FIFO threshold
+      value. The recommended value is 1.
+    minimum: 1
+    maximum: 256
+
+  nvidia,slices:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      HTE lines are arranged in 32 bit slice where each bit represents different
+      line/signal that it can enable/configure for the timestamp. It is u32
+      property and depends on the HTE instance in the chip. The value 3 is for
+      GPIO GTE and 11 for IRQ GTE.
+    enum: [3, 11]
+
+  '#hardware-timestamp-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - nvidia,slices
+  - "#hardware-timestamp-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    tegra_hte_aon: hardware-timestamp@c1e0000 {
+              compatible = "nvidia,tegra194-gte-aon";
+              reg = <0xc1e0000 0x10000>;
+              interrupts = <0 13 0x4>;
+              nvidia,int-threshold = <1>;
+              nvidia,slices = <3>;
+              #hardware-timestamp-cells = <1>;
+    };
+
+  - |
+    tegra_hte_lic: hardware-timestamp@3aa0000 {
+              compatible = "nvidia,tegra194-gte-lic";
+              reg = <0x3aa0000 0x10000>;
+              interrupts = <0 11 0x4>;
+              nvidia,int-threshold = <1>;
+              nvidia,slices = <11>;
+              #hardware-timestamp-cells = <1>;
+    };
+
+...
-- 
2.17.1

