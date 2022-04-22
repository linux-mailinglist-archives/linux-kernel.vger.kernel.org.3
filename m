Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5C850C223
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiDVWKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiDVWHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:07:07 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77712194FC;
        Fri, 22 Apr 2022 13:52:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pg9K45torT02b06MbhteXdk4ne7tweyrbj1os/d01jtLeGE2Ohz/bS3gDLTVWM02IvpUslOfwQY+cTvJqUDDzi7F5j4T+dyhLIKD9tZfeYZAe3iuaLrI+IdeiNucQ9bd3uSDMPLY50eJT0HGjpO4OI7ZMbE8Vy21fRSQElrij/tGGCIh7MckaWmge4/yONCMxxz5PPk40luiga4hO68m9sktZh0aW8nSXQsuooueh3h5u2dgIUgntYQQ8se9iw4X73DVaAYPnRip19pe3ZXXjyIMnNCuGYo3PGGztVk/PfEKYK8tZW27Xgw2paxfGNVOO36inprx8DCTixT5pMencw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXKhVFbLShXF/MPAQNimjb3pDXyUq51Veq+zl/hyVNM=;
 b=ioDr1AFON7HHw7Ej0TOL8k0cAdShZQXBfq+4XixuaXm6lHaTEWPIJNYGMdz6aC4vxJkUiFA2zjxmHwttqCRB6zyWCWV4yoPtf3EfwBzelDXiKGCcQgfK3xOpLQDjMoV63294iV58A3CCV16DcqY2u25iyRrFOMS7vYaweMsLNuA5epI2dRh1wosQ2zM5XhuKRdqUdHoZxv+0tuwKi8I7a3rKuynwsThE9zPTbJVAc4HIkJny7EVUUdiWs9+EqpJ42Sera07wO3ES0AS3YXbHsvliY0c61FzjZWgPOe3qRKjAz7b8tMCsyAcZsUQFSrZWLNwP1AvA9zv6C3qgRzWoLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=temperror action=none header.from=nvidia.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXKhVFbLShXF/MPAQNimjb3pDXyUq51Veq+zl/hyVNM=;
 b=OW7XOGmEPKgVCjB36SZWIJsMMv67k+b3R0qhrCMVx6z176wvtESYEUKqzEDttG1n5jYb/cQnSObUxm6jq0e8NqDLsUpM3HfIBEf5zGCRbQmF8Onvdd21a3193zxgRSWFCgvBWVqQMfe524oW2WTwKla34UWlCasLwaLhse4e8xm7FIvzODCtdVRTEyL3/cLqPrZiWJLR59sgww9jE1AOMuT876MvYl+965A6DT/VHbstJHQHaPwXeLOQqwuGCihF1+TDUf4+GhlcybraiHVUEdHMrBH7YH0PSL/Ap2KXqUwcJBBj78/JVZQYHhG0GTQczGXinAHpvwrrdLSUTnKBhQ==
Received: from DM6PR06CA0005.namprd06.prod.outlook.com (2603:10b6:5:120::18)
 by CY4PR12MB1640.namprd12.prod.outlook.com (2603:10b6:910:11::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 20:52:25 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::be) by DM6PR06CA0005.outlook.office365.com
 (2603:10b6:5:120::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 22 Apr 2022 20:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 20:52:23 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 22 Apr
 2022 20:52:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 22 Apr
 2022 13:52:22 -0700
Received: from dipenp.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 22 Apr 2022 13:52:22 -0700
From:   Dipen Patel <dipenp@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <smangipudi@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <warthog618@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <robh+dt@kernel.org>
CC:     Dipen Patel <dipenp@nvidia.com>
Subject: [PATCH v6 04/10] dt-bindings: Add HTE bindings
Date:   Fri, 22 Apr 2022 13:52:15 -0700
Message-ID: <20220422205221.952-5-dipenp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220422205221.952-1-dipenp@nvidia.com>
References: <20220422205221.952-1-dipenp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3cee2b8-9b59-4838-841b-08da24a2007c
X-MS-TrafficTypeDiagnostic: CY4PR12MB1640:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB16409094DCE6EF38C1749CAAAEF79@CY4PR12MB1640.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSVEdOHR6uoJGBO4/nmvUX0MPy5C5ZvbRi52x9m3YNsXmrQVG2LyVZI/0OwY84Fq+zGOoI8S7jjJeovQBLnl/VqGOm6vO1CiTimWEidV2ezvBNhdroMyKafj28A11RnLkfybnXZfEfW8aIma28KYzM25Pf0f6kBpuMU0iSQpml4BBjiCL2KyU+tPTyS024uIgRA8/g4BmfshUrBybyRZhbOV06Mms4ZN1dEMN5X+Q0FyDuS3GWwnmWabyKntezy3g5IrDXgzjyh7K5XAfYhAQmaW3ZZd2Jyr5JaMbjFVCsZaxkJdMZ1nrk9fniiT6BJDsIefo+KmDDwiHgu7uzutPJu0uK8DC4iRLmKtdesm7v9R0rLbrD3arirgYBcVroEgcGkwitdu+PUGyCfillEsS3hyhl3+uzKunHOvlYQqAPkuLxs6txU4ne0ZpHhFJ4bwoh/82+lV9Mfisb0RoPaUnRdTDuHFRu2qtrXnxH+87BfLQg05t5ugH5ks03gYIoj+hYZvuWxhVObiNZUQUGfyAT8sHMmbpueK64UzGQGSMcGWR15CHzp+xc1BEEZJwaqYDmpbMCyxKGZKq6HO2/4S02PmTYiQWFr+ek4PyrpZcfYxEssetGoSuxC3PrPDmQ/+nxX+CxZSv3S7MwVHUk59EF6x0jeMHAiRF6Q5IcLCKv5fSqD+/W9tD3IdOQcM5PoTOpZU7VniZNrIzbSFRT8j2Nd7jG3GP4ah1mMYfd0uuPzVm/YSiv+gQPpleWhiP9ULu47mnCTmN6ZXh73qAIRSZVrOgtOKXeMzh1VyjIOQ0bagziu90L0c52A2mQ1WfYJ6KFoSZK1GMn+pVr3Dj12xeCe2IcKL8t93S2JebTjPbkPLmxa1ISQX2YSv4Vlt7dnJnfc8cCIXvkHPbLn9x7l0sA==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(426003)(2906002)(83380400001)(63370400001)(81166007)(921005)(356005)(316002)(36756003)(36860700001)(336012)(82310400005)(110136005)(70206006)(40460700003)(63350400001)(966005)(508600001)(26005)(186003)(5660300002)(7416002)(7696005)(6666004)(47076005)(1076003)(70586007)(86362001)(4326008)(8676002)(107886003)(2616005)(8936002)(36900700001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 20:52:23.6558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3cee2b8-9b59-4838-841b-08da24a2007c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1640
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

Changes in v6:
- Removed hardware prefix from the property as per review comments.

 .../hte/hardware-timestamps-common.yaml       | 29 ++++++
 .../devicetree/bindings/hte/hte-consumer.yaml | 39 ++++++++
 .../bindings/hte/nvidia,tegra194-hte.yaml     | 88 +++++++++++++++++++
 3 files changed, 156 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
 create mode 100644 Documentation/devicetree/bindings/hte/hte-consumer.yaml
 create mode 100644 Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml

diff --git a/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml b/Documentation/devicetree/bindings/hte/hardware-timestamps-common.yaml
new file mode 100644
index 000000000000..3e26de605f08
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
+    pattern: "^timestamp(@.*|-[0-9a-f])?$"
+
+  "#timestamp-cells":
+    description:
+      Number of cells in a HTE specifier.
+
+required:
+  - "#timestamp-cells"
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/hte/hte-consumer.yaml b/Documentation/devicetree/bindings/hte/hte-consumer.yaml
new file mode 100644
index 000000000000..68d764ac040a
--- /dev/null
+++ b/Documentation/devicetree/bindings/hte/hte-consumer.yaml
@@ -0,0 +1,39 @@
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
+properties:
+  timestamps:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      The list of HTE provider phandle. The first cell must represent the
+      provider phandle followed by the line identifiers. The meaning of the
+      line identifier and exact number of arguments must be specified in the
+      HTE provider device tree binding document.
+
+  timestamp-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description:
+      An optional string property to label each line specifier present in the
+      timestamp property.
+
+dependencies:
+  timestamp-names: [ timestamps ]
+
+additionalProperties: true
+
+examples:
+  - |
+    hte_tegra_consumer {
+              timestamps = <&tegra_hte_aon 0x9>, <&tegra_hte_lic 0x19>;
+              timestamp-names = "hte-gpio", "hte-i2c";
+    };
diff --git a/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
new file mode 100644
index 000000000000..69e8402d95e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/hte/nvidia,tegra194-hte.yaml
@@ -0,0 +1,88 @@
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
+  Tegra SoC has two instances of generic hardware timestamping engines (GTE)
+  known as GTE GPIO and GTE IRQ, which can monitor subset of GPIO and on chip
+  IRQ lines for the state change respectively, upon detection it will record
+  timestamp (taken from system counter) in its internal hardware FIFO. It has
+  a bitmap array arranged in 32bit slices where each bit represent signal/line
+  to enable or disable for the hardware timestamping. The GTE GPIO monitors
+  GPIO lines from the AON (always on) GPIO controller.
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
+  '#timestamp-cells':
+    description:
+      This represents number of line id arguments as specified by the
+      consumers. For the GTE IRQ, this is IRQ number as mentioned in the
+      SoC technical reference manual. For the GTE GPIO, its value is same as
+      mentioned in the nvidia GPIO device tree binding document.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - nvidia,slices
+  - "#timestamp-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    tegra_hte_aon: timestamp@c1e0000 {
+              compatible = "nvidia,tegra194-gte-aon";
+              reg = <0xc1e0000 0x10000>;
+              interrupts = <0 13 0x4>;
+              nvidia,int-threshold = <1>;
+              nvidia,slices = <3>;
+              #timestamp-cells = <1>;
+    };
+
+  - |
+    tegra_hte_lic: timestamp@3aa0000 {
+              compatible = "nvidia,tegra194-gte-lic";
+              reg = <0x3aa0000 0x10000>;
+              interrupts = <0 11 0x4>;
+              nvidia,int-threshold = <1>;
+              nvidia,slices = <11>;
+              #timestamp-cells = <1>;
+    };
+
+...
-- 
2.17.1

