Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB96D4EA762
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiC2FrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiC2FrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:47:16 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2063.outbound.protection.outlook.com [40.107.95.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A13E33EAF;
        Mon, 28 Mar 2022 22:45:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V12TRRjmkzJGuSvjlX7YH0GZ+evIFUg35N7k1E1qQcMX4vQQproc9Dnv9Xa1xwLm6LvP2fY38TrKE/OB2tLV47C9DRiNGRb0IoJ6qX4MQWtWU/lagSIB5RBfOqDZyR+bAn+sz4DCjzRiugKN0LrkRjD+SXzePuEUpgjkVOyfaGr71zA/sBdieKDoEXgLFZmBzj1bfSXzVKcLsPyptdUciniY6wSvd+Hcj74YW5GkfT13cebreJeuryCDXiTj+ZkvJ+63L09domtJUB0HaOMStUj/SNcHNRT8uLPF7eYmyo+rQq1TWA3JyVWMR30DsStN8UpRQr/PIDwTmTCHRDowww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4PRT/Dig+WwuhflsuS9yPO+QUDtrUWhYA9SdVnvucYQ=;
 b=hnhLx6y9Hvv39lHkTPn+S4QHOK7g6eGuAtdKx51OyJYaPyJTsYs8hQXQN7P9u8eE3N9Ufd9a/oe3KzNuzxc0o4QQ4xD2V7kjeWYLyW9U54lAlrSUbmCF5N/P4kqVH/4A2piQtWtl8a6SC1eeWR8Q13NpqLpvkuv7BRs2MMfqTjd3eQE0xyy2IKM5o5ktXtpSNPMxHp+Umy/7e0pgoq1N6EGA3CgoLoC+sPm1F3Agq7km5rVmM8E3wKOY9NtApk/su/jTPvGBtO7UxO3iDM4UatRkPH2UFlzwA8VE2qzDQ3/froIDndNfgR6PAwOn3OwYowmELivdp943xO19ItMLUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4PRT/Dig+WwuhflsuS9yPO+QUDtrUWhYA9SdVnvucYQ=;
 b=SKurJ2xzSYUKHSP3vjs8rBq4cshvWeIdEZxTicexU8MqFspb7p9Z9Ez0oUhUgRqqOYDfxbmdMuCa9NaFj1Pa2sHpg9Zr7kQVFU9DoKT/Tk0xXsthxj1v7CP1fYJ2bMJJN1y8S6yysQtddw4AaMB6tFCOrwD92kjPtQ1QhmolBLESk7CPb9uBl9M+qeeniH4IFacC4oMb/n1B5JREYnoB5p2MumzTyhunCetk80BT2+DAat2TjMoUEfzehoCvT+cPfPX5imJEECVymRbEa1jG2anobwLgmN6gQYThFRyh7w6/CsfsVvj66S/Jw8WYPQr84o1D/V9JfGR6961+Iv/vug==
Received: from MW4P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::11)
 by DM5PR12MB1484.namprd12.prod.outlook.com (2603:10b6:4:11::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 05:45:30 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::e9) by MW4P223CA0006.outlook.office365.com
 (2603:10b6:303:80::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Tue, 29 Mar 2022 05:45:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 05:45:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 29 Mar
 2022 05:45:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 28 Mar
 2022 22:45:28 -0700
Received: from dipenp.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 28 Mar 2022 22:45:28 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v5 04/11] dt-bindings: Add HTE bindings
Date:   Mon, 28 Mar 2022 22:45:14 -0700
Message-ID: <20220329054521.14420-5-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220329054521.14420-1-dipenp@nvidia.com>
References: <20220329054521.14420-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40e7c1ff-43e1-4fed-a463-08da11475576
X-MS-TrafficTypeDiagnostic: DM5PR12MB1484:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB14848E2CFB74F1AA0069118CAE1E9@DM5PR12MB1484.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gskiGrH1mxtBCAAC9m90M3UTdseobkxFtwVp4895gH1aya9IJnyIhfEtfxYbDr5LQ9jV3l/NyiqHEm4VdysgL+1mUEBI7ZlB1r0LeiJAZQdKcFv0MkKocEwBjANq2Xs7e6hjBK/wIlhBtw2/Faca4DKhQvlChj2TmM11rQLGQAVYF7yQbgmNSjYDNvqnzA/Nn+z0RIIqHiO5ME0nsOIKjlM1KQR4hoN/G86eJu4DYZQwjo1X/AV0Y+sPUBHmwcPp1x6waokhgj862DcqfOGlcDm5YmQ665AdgTRcU4zWsip1dAK5V0yDRvn11fhNWNxFTn3JqiGJFdrReWY4aSVFMrm8tJ75x8tNQv0HuFqDix8TEWe0K7ehmFqNLTKPidFKSxk1FdaZ8BkUTDMfRKVDCzm/IO0tsjX4yEVGRdH6ncEnKrhYUgtdwsCQi6HbxIeiLfBu8bLUtmbEp/YHcnQcdUjmaSYcVIj1oZqsVGZ6jtVgevvQwSgWjdOuf8L7ht+ip+6WGyG+0SEnJ+MRHLhi8GxyPAhjnFpKnSG9Zg95vDsGnMwMYcjW4i8e31ij+nGldZImUDP1qoL1qEWK3XKW57YpS0lpYdH3W73HwD0oJ30d3Tf4j+VZcE146c7L1VRfKF1xzo2cyrIrsnMqJ5z+m5i5BV0AaI4USufDkOcMYEjF7L4jzB2DamDsSJfJ8s48ZpZ16b8I4ODWPj6nWRT8dYAewUmkBw59T4UI/3HbdAzCiAHewg5E58uUlN2+EkW6MDFI77kMejKv9EOAFfmeNqAh2nArhNm0RFpqs6wwICZGu/mG9Flwnbp1y2IqRmD4r5jEB+ruBQqmRtTnXgpnRJL5DoyD8WMqsjztlXZWBobvXtIi+UlLT/TN7+Tj+Dbb/ZVecePMUvUxY/0v/I4Ytw==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(86362001)(81166007)(316002)(356005)(40460700003)(110136005)(921005)(82310400004)(966005)(5660300002)(7416002)(508600001)(8676002)(2906002)(70206006)(4326008)(83380400001)(36860700001)(107886003)(70586007)(47076005)(2616005)(1076003)(8936002)(336012)(36756003)(186003)(26005)(7696005)(6666004)(426003)(2101003)(36900700001)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 05:45:29.9285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e7c1ff-43e1-4fed-a463-08da11475576
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1484
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Changes in v5:
- Addressed review comments.

 .../hte/hardware-timestamps-common.yaml       | 29 +++++++
 .../devicetree/bindings/hte/hte-consumer.yaml | 43 ++++++++++
 .../bindings/hte/nvidia,tegra194-hte.yaml     | 82 +++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
 create mode 100644 Documentation/devicetree/bindings/hte/hte-consumer.yaml
 create mode 100644 Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml

diff --git a/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml b/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
new file mode 100644
index 000000000000..e8a69ceccd56
--- /dev/null
+++ b/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
+description:
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
index 000000000000..be69f63aa8c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/hte/hte-consumer.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
+select: true
+
+description:
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
index 000000000000..ce6f1313f52d
--- /dev/null
+++ b/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
+description:
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

