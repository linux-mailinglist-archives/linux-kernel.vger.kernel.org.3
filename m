Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FF64A67D4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 23:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240176AbiBAWWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 17:22:51 -0500
Received: from mail-bn8nam12on2083.outbound.protection.outlook.com ([40.107.237.83]:61057
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239192AbiBAWWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 17:22:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIqobsOJZP81tFSkRbBUAS+ooAb55zkGLeOVgte4RzKAH/oAetu8/NpNRFQAPT79sfEco1rdrcv6ynzxSw/ytNt2APsdGtBxPbp+ZVAv7J4vzFO46T7wnul20KEdIY8cNMyhKHcU/bNGl7Fi9FSX84xJ0DrIpcqslgdQgrJGui5kJPU5MmJsZn5ReCdRBDBZN4Mwy6Y1sInysgFa3GL3Uqt8rRV/HT3P9XES+nvdf/SsMyIUJIIyRnp4Zhbqc5XTmrG4j4BU52tIP7pYa7o7hg3h6pAqGG+Hj2tYcIF++6TB2Z8jKql4Len8bOUDCRbEq/H8CH534YlsLcF+AeAERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JiPD+dOGytDAOoDg74wOPFl2DcIBu8gJoeMuqUTxDhM=;
 b=m/fRZteItCgOmC5juN59gEhPvlNuL9QG5bDcJwMxRtCMw5kQPYb+7klS30HxwCkjWpV0sr0FZDycFlOL5AxXMPFc/MYTEBYFa6cud2gV8YHF6oQBJGI+NK3RNnOFklJO8HoPW54q9UPEg3kOs5jju7KXqfalQYIpD+vaVJtW178Yuaj53fxh8Zy4i/+m4fb/iCOHgMYESty0vDt4QgBKgdufLa+BvlLczSzL9K+N98m0X4SE7QOp5rDaPmAxuDYQl93VpjalrZLr+9vpj8L1j2ZE3gE6cvHYRwY2hHGRmCiyKdWXdziAuK+7wYDztTUiRlXXEG2ItMMq/wjk3cHWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JiPD+dOGytDAOoDg74wOPFl2DcIBu8gJoeMuqUTxDhM=;
 b=pkCz05aBhny60lnwOoWfJAHAM/fRWSqqj8QwwrO3l4JXLh3OL8Sicr3wdEYgPfij4Q2GcV1tqnyznv5OlRD1yqo03sSSOBopCScOjASiDFaNCLaHDzIwdHm9k858k782os3byROxX4VDJwJz3TSlrqUTag26mlTjOYSE4/i5cCu6hxqQdRm9w89xbbQuhW6QyoBLkf3i4KuysCGtvtDYMjSyVvQ8MNUEvowYAOsKlwczM4yuNHjdULL2qhJSe910pDjOD3HeeDg81c0ff9jOFpM/eOTR740K/L4L421MK3AZ3rn2OGbGM0QWcieA11p94/p5jBYF/5OaiaYw5PuOxw==
Received: from DM3PR12CA0123.namprd12.prod.outlook.com (2603:10b6:0:51::19) by
 BYAPR12MB3544.namprd12.prod.outlook.com (2603:10b6:a03:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 1 Feb
 2022 22:22:29 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::10) by DM3PR12CA0123.outlook.office365.com
 (2603:10b6:0:51::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22 via Frontend
 Transport; Tue, 1 Feb 2022 22:22:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Tue, 1 Feb 2022 22:22:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Feb
 2022 22:22:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 1 Feb 2022
 14:22:28 -0800
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 1 Feb 2022 14:22:27 -0800
From:   Dipen Patel <dipenp@nvidia.com>
To:     <smangipudi@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v4 04/11] dt-bindings: Add HTE bindings
Date:   Tue, 1 Feb 2022 14:26:23 -0800
Message-ID: <20220201222630.21246-5-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220201222630.21246-1-dipenp@nvidia.com>
References: <20220201222630.21246-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4b869a1-b6f0-4ab5-4288-08d9e5d155a0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3544:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB3544A77F43A4F34B62B664CAAE269@BYAPR12MB3544.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 639O4y+QoSqrRtR/Ihp3KsQyE1fSFBFpObOGXMerKeYai5vfoKcwKYHW4NMQ6zJX2FXBiqX+6aip0hnh8ZfA0G+8VQNuzq/bYNQF2Yh9t2xvjK0za25Wi4Q/XrTRD5hKe3jojR4MtHPsB73qEjdytneyfveD+AZ0Vse1f9b+oxgOejh1w/hD5YtxZIuI7mxfZjt+P8jIOCno2kNXEm3PfVaMOcDEvEg1kEnOE0lSrWBU6rc2Cc/Y1hNk2ebxJ3H2RpF3RnlCJJ2+xsRYohOltCrMM9w9wZ9gaDg/hGIeQIXNeSBfecaHM2MX4ioaaLHjhNeRvvS38P0QchX6kTsxjAg5vXiQQLrK2RllSELVeTHuSRpECq5eQYRjvGV0OYJEMOrWX/1F1e2IgXo8+UoHfQxJe6hOOx1JZtPTb3i141KrvsbB9Z9nng2pPQevMusSijdm58W8fPgH0mLD6vrom27YsczG2lkvHMgRmkrHGkntVNozufcrpQElbRxvUJH4LEtZ3JVDLxShRXPUZjbQYJaRmHzriI39s+B6DSQl4lT52fy6tMee6jhk8ukIIJhjKfHNHqUKUY8GaIbGUh9TT29qRKVCB8cpvGI21f6ax2dBxOnH6BtmjKHncBJ3aznTdGIvKdSS7hATHSGunN6nnNfuNa+UnRNrUaOHl5SidVDaQHGjaxspHutYBRSXbYp2oCu093zKplikD4c5k2bqbqZOuF56EQA9EtBSUzrBXPbUHAzMyAWGTFXDDLu6FcQwz6JFklD/DEqkfwxQWDrELKun+IDcakO9KReLJTCUD5JNABdPOk4QAP41AByPRyXIItm2uPyaEke/5yEriAKtnthadK9LpUyDWLs2AZ9nZnZDl9siEapIso/aXwDZB/39UBOuicX34y+cKAfblY/ylA==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36860700001)(82310400004)(8936002)(86362001)(8676002)(2906002)(81166007)(921005)(107886003)(4326008)(356005)(47076005)(83380400001)(7696005)(7416002)(70206006)(70586007)(26005)(1076003)(6666004)(966005)(508600001)(110136005)(36756003)(316002)(186003)(40460700003)(5660300002)(426003)(2616005)(336012)(83996005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 22:22:29.5721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b869a1-b6f0-4ab5-4288-08d9e5d155a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3544
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces HTE devicetree binding details for the HTE subsystem. It
includes examples for the consumers, binding details for the providers
and specific binding details for the Tegra194 based HTE providers.

Signed-off-by: Dipen Patel <dipenp@nvidia.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
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

