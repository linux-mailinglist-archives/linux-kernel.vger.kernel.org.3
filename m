Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EC1564F7E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 10:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiGDIPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 04:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiGDIPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 04:15:04 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B718B4B5;
        Mon,  4 Jul 2022 01:13:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boDOI6RF6amDgFv7PaLlkgeCZnUMuXO56mOE46o+r2uFAW2vn9M0wnpYLCmW3DEY1Pg84iB3JYfJ5BKzuKDJeZjJ7hSYLF2TMOkIt6qWfK+bW+I+3tYqqZuul6g3AqDBf5CtEOzHwnAk+EuHBu/zVa8y4+WJxBndpnbxO1pStvTo0fUDzuefGsGyZLWug0KMKY3J9HNsS8W7fd1oM7o7nwOPRhO1nIc7HI+zgGcB7cYuf6qDoPvJXLLep4pnVHTRbklrC6b9tu6Tk+I7zt4lG0HWgvI2Z55jp4YZNPchweMqQh1LAiBcMTCyKFyzkQExEgOdgJ6ffqQfsRga8rpK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6nS0nOjtzGvc9KOnnvqvU7gcFs3mfcwHuJftAPzNRU=;
 b=Si7x2F+AH0SESnA8dS1OPxQXF0jmTtaYCD3qz7BcQopdsc8G+w7OVZ2734ImT0OSymPnDqrQmIr3ElVw03AJMhr/RL/Z22aIsqQWU8gv2d/d38bNwUARKuu8L8PAZUMHb20sz6qC9deoqNTRVJ84uOhGMXhUMR2vnv0cU1eqP7Tf1GAnLJVXrq/0Q00xHmFyHXLCtt8XuTim4RXSAjLEDu4o20DZ1hVPWHP/D3g0HYLFEc05idd84TZ6FB0iGS5okBZ2cEQNFYN2j3RQcyvo4toSjAio6eBNhwaOac5I+XHnRGdBB0+OdfHYMhMRCLV8m4pTNJI7o2bit2gFa4syuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6nS0nOjtzGvc9KOnnvqvU7gcFs3mfcwHuJftAPzNRU=;
 b=l1LPF2jZeIWDpWDW2TRXTHZWHyxw5GwjDoQBmg5l8+NNZAynHecBXjtSSF/GeDA1C8LHgxO0u1MxdkNNUmfXx39m9FuPQfs0FamXaE6rwVXeIlJedX7l4vvGor9fpWeJrodJDeae96kETnSUvI5VH+a2gXe0fUr9tSM0UUrw8kY0JwJnEn0NwgDbP7faoDWnCpctEW87DaaVwg1amW+qv7PwxxHchq6w/vqZDUurghxxAMsd404CY/r6jhVJ9hC3FrcfeMwlmtK1+VPb7/rkU2W7IpDThcw+RpEAWMnYCfwl43XerhKI42xAjswfxG0U21Z7tk2aI/03HjuLjlrQsA==
Received: from DS7PR06CA0020.namprd06.prod.outlook.com (2603:10b6:8:2a::21) by
 CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14; Mon, 4 Jul 2022 08:13:54 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::d2) by DS7PR06CA0020.outlook.office365.com
 (2603:10b6:8:2a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Mon, 4 Jul 2022 08:13:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5395.14 via Frontend Transport; Mon, 4 Jul 2022 08:13:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 4 Jul
 2022 08:13:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 4 Jul 2022
 01:13:53 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Mon, 4 Jul 2022 01:13:48 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <mperttunen@nvidia.com>,
        <rgumasta@nvidia.com>, <amhetre@nvidia.com>,
        <akhilrajeev@nvidia.com>, <pshete@nvidia.com>, <vidyas@nvidia.com>,
        <sumitg@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>
Subject: [PATCH v3 1/6] dt-bindings: timer: Add Tegra186 & Tegra234 Timer
Date:   Mon, 4 Jul 2022 13:43:37 +0530
Message-ID: <1656922422-25823-2-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656922422-25823-1-git-send-email-kkartik@nvidia.com>
References: <1656922422-25823-1-git-send-email-kkartik@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9e0784d-cef4-4d9b-5b65-08da5d95231b
X-MS-TrafficTypeDiagnostic: CH2PR12MB4293:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YDelr710ZIxg5QIUk3MxlnuybKbkqz8LTm1tdESOjrjarDCshgiTfUK7HoyN?=
 =?us-ascii?Q?IVUwDvf6W7kPh/ZcYSEJ4llP3S5js1PfxXW7s2o3GEY8CeNWeAsSCBUt8jUo?=
 =?us-ascii?Q?VDldBUVcUVfCnX73dZjhpIPHlP7DBNnomMChG30b9m+P4wggR4Jp6CZmj7kB?=
 =?us-ascii?Q?d/yrjT4eYHjyAbF/yzWSQd+iNdHYHkC3lTeqRbRLxGQD5+7VF8yk6UejBeqD?=
 =?us-ascii?Q?pPY9G7krb1YBLw7wO//a6Qyn8vNk9nxj8Q7PNDQd8z10N9musXXe/wwShiNX?=
 =?us-ascii?Q?gI6CEAbRPg3DC5oz+shcwnoib6wiXuudKIaX125mTG0PwUZfz0IUFOuexLni?=
 =?us-ascii?Q?bfFvRiLYqATnCeAzecincVOYZNg9oAQp6mT/PGIl54YaJqpPefES7TEaCjx7?=
 =?us-ascii?Q?V43xjaal5ARc2BbaqVQtP/z2S0covjzgR7uneNYDAXG20u1JdTT7u6wylUc7?=
 =?us-ascii?Q?t48UcnX64AGs0HiMOSBF8WiU0kVPVeTA7MdAhN+Emh7KUDF2r2pGnlt2EoCy?=
 =?us-ascii?Q?86P/AbR3uD4H9McRON6UiHm7e8Uc2BevXguPmQHS1CyPbiHx6djrFH4RuKwe?=
 =?us-ascii?Q?1KY5ZmPtED9kP55hw6cY/urAOMUNXsXhdAZf8gHF8w4y4B9Cq1UmHPihX5bP?=
 =?us-ascii?Q?E47QmpCkAZjWezlBsgCrvpG1fWepZoEbHNEtYGQ+IwcGwYX6wTG2+oWCOpTN?=
 =?us-ascii?Q?cZQ/oD+Z9dW9d3QgTzwIjsjdGWI29d63VNhfEQKSjoeBFO0m6OIB6Aph5Vk6?=
 =?us-ascii?Q?DTpsInb29pc1ry302NZcPPk+0HPZ2PmmJ+OfsgwUUTGP2PohmJdZ7zM6uRbJ?=
 =?us-ascii?Q?mlnlipjUN4KBrZlbCU8Cdswf4wOo8AxCCC0aLZNlt6K9EIBrPBqHWQDRWIQo?=
 =?us-ascii?Q?TcfI+LoSwRr5ehKTLg+bxIbwUe9GGS/JvIxb3dqDDLyNnMTiBCaR7LCQEke9?=
 =?us-ascii?Q?z7sC/xIF1UghgvBMD2Bz0/n+Ef6QpzYow+zemSQiYP4=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(40470700004)(36840700001)(46966006)(478600001)(5660300002)(81166007)(8936002)(82740400003)(356005)(110136005)(921005)(316002)(40460700003)(86362001)(426003)(70586007)(70206006)(8676002)(47076005)(336012)(2616005)(186003)(26005)(41300700001)(82310400005)(2906002)(7696005)(40480700001)(36860700001)(6666004)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 08:13:54.5602
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e0784d-cef4-4d9b-5b65-08da5d95231b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra186 timer provides ten 29-bit timer counters and one 32-bit
timestamp counter. The Tegra234 timer provides sixteen 29-bit timer
counters and one 32-bit timestamp counter. Each NV timer selects its
timing reference signal from the 1 MHz reference generated by USEC,
TSC or either clk_m or OSC. Each TMR can be programmed to generate
one-shot, periodic, or watchdog interrupts.

Signed-off-by: Kartik <kkartik@nvidia.com>
---
 .../bindings/timer/nvidia,tegra186-timer.yaml | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml b/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
new file mode 100644
index 000000000000..db8b5595540f
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/timer/nvidia,tegra186-timer.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NVIDIA Tegra186 timer
+
+maintainers:
+  - Thierry Reding <treding@nvidia.com>
+
+description: >
+  The Tegra timer provides 29-bit timer counters and a 32-bit timestamp
+  counter. Each NV timer selects its timing reference signal from the 1 MHz
+  reference generated by USEC, TSC or either clk_m or OSC. Each TMR can be
+  programmed to generate one-shot, periodic, or watchdog interrupts.
+
+
+properties:
+  compatible:
+    oneOf:
+      - const: nvidia,tegra186-timer
+        description: >
+          The Tegra186 timer provides ten 29-bit timer counters.
+      - const: nvidia,tegra234-timer
+        description: >
+          The Tegra234 timer provides sixteen 29-bit timer counters.
+
+  reg:
+    maxItems: 1
+
+  interrupts: true
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nvidia,tegra186-timer
+    then:
+      properties:
+        interrupts:
+          maxItems: 10
+          description: >
+            One per each timer channels 0 through 9.
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nvidia,tegra234-timer
+    then:
+      properties:
+        interrupts:
+          maxItems: 16
+          description: >
+            One per each timer channels 0 through 15.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    timer@3010000 {
+        compatible = "nvidia,tegra186-timer";
+        reg = <0x03010000 0x000e0000>;
+        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    timer@2080000 {
+        compatible = "nvidia,tegra234-timer";
+        reg = <0x02080000 0x00121000>;
+        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.17.1

