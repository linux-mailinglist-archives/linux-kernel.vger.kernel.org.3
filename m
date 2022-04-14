Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B48500846
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240843AbiDNI2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240793AbiDNI2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:28:17 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DB131DF3;
        Thu, 14 Apr 2022 01:25:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2DTrlP/OrJa+JNTIbSrSw6UugcVMU+KsPYsB32OJIUaULyMQ5btmT0pugvRWgMdvEuBcjcmH6V+JR99KDr7OIB7dFJ3H95NxvOh/d3UNWSHyIHi8ieO7+NnvnehRS6oLzGX9Bb8deydcZ5XOFbbazv/ZyKJyTAaK+TuqTnczHSy5C8VpXmEbpHSWzdv2hpJM+QU9sOYI/0kRCPu708dihzf7VGzRgt6JprxYzFtUSLRhuz6YDCHj/o/3LF3Q6As8f7gpyNybzSqBgHg9Ihi9tJXLj0cc/28ZEZe8Tm4o1ngbfGrgz809sJUEgPczVaPEjUKrg5UlJUYUkzjznQXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzjQx0gLM9mSOcdIPPeqN61HWy2KW7rSxZZ5e46I07k=;
 b=P8QeOJ7aWKEXT+ED/dpHOATsHySxwrtH76EpddyTgEMTkHIjLselcfEJHGgwkaQgriP6BcfGKHKIXFUgTsvy6SC22yXpnn42D0Y4vpEG2pzOSHwssfa77T2XeAsJCNCCflUTE+bHRar9Kgms+CgqAzZqjn9Ng596+eVGUi6tMqoSPA/I4i8A6f3nWU6iawRSq1r4WKnw9j2EaIHmWpJevHDFaxTo/+93jxVLm4NzFzUhVWso3Qi0qHBDfXvUIfuGwzbPMX5qEb3i/L6EEQiozmmDqlXx/R+kXwveAcARVASu7p50CnsJiMrSfV9KzSf8V1olYlS4LFdnjnQGomW/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzjQx0gLM9mSOcdIPPeqN61HWy2KW7rSxZZ5e46I07k=;
 b=ALVHW4an4mGGnodgMBftxrAEyiVX//GcOO38C/7RNlcUPJbndwi3s1jZvdrSDJTH/7/PRVSbLxSNTRiprf8zxKLFySv7Tt+za7jVkgjuIuTsbaz/IXTY92Bc2+Pk9f9zMBlyYZlI1siJVWgTqxC+9Lr2ImusUg+O2nk9mn5NiZfZcMMfJx6fvEQV5+bfI+tjK480kk7OlmdkqtdgaOFE9jNrtEZXJU2+XBrxzKL1sgcbK1yzUK5W+AgYjDU6wLCQyv4+nsWUtfVpYVruFHvIfPsfF87hkvsA0JETfkBqyIafy13NAs9xcP0mftKfp4z/Ibcbbl2PJaCC+4jaRO8Qag==
Received: from BN9PR03CA0237.namprd03.prod.outlook.com (2603:10b6:408:f8::32)
 by BYAPR12MB2647.namprd12.prod.outlook.com (2603:10b6:a03:6f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 08:25:51 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::a8) by BN9PR03CA0237.outlook.office365.com
 (2603:10b6:408:f8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Thu, 14 Apr 2022 08:25:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 08:25:50 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 14 Apr
 2022 08:25:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 14 Apr
 2022 01:25:49 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 14 Apr 2022 01:25:44 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <akhilrajeev@nvidia.com>,
        <rgumasta@nvidia.com>, <pshete@nvidia.com>, <vidyas@nvidia.com>,
        <mperttunen@nvidia.com>, <mkumard@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <kkartik@nvidia.com>
Subject: [PATCH 1/6] dt-bindings: timer: Add Tegra186 & Tegra234 Timer
Date:   Thu, 14 Apr 2022 13:55:33 +0530
Message-ID: <1649924738-17990-2-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649924738-17990-1-git-send-email-kkartik@nvidia.com>
References: <1649924738-17990-1-git-send-email-kkartik@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a5da73c-aa77-4628-2116-08da1df0627a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2647:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2647E94B994B39DA4EB0BBFECDEF9@BYAPR12MB2647.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hyPvy4B4Qvo9ruAhjFiMqCXW+YrWXk+0ikgZbHU4w7/Cao+R0JbiBzywNoshAEFXXD4R8NZ8jiZA7JCLg8WcWbBTArLLxwMDva27OamsivlelK2bdOgZShj3TyT5te5hlcx9Cgikd8eFqJDpNQLtWYmgo4ovYNlkgMu72svIgLgDlnrcOqNJFWSKwpIgbKH2q33WOFwqN1XQK8cdfHaWSpVFbLRHFYSFbE4sGJ3aSWyvoF3L/qRy4gsdH30FUsTmhfczJ68MMkIQVYL40viC+Rxqi5YW0fbhOBOH9FQVuJFM9iFKkM+9adA5BEsHHLUyebZQR7CQkYdzonlaanWqOtTwbT83yDx+TmryTg8WxYwFZYx8OlI1p60huEuyQIkmaVUrmGik9sMr6A7SJIELjMrDO8G5LVD42xMywdtCBum/4LV3DQpmUIDCSEa437WMG+HSwDn7NHiRVxE92TEzYfBfWamGDSw078oekwSg8EwMxjZE50Ip9ljiefRlr45QwUnBL+TNc1Dl+/06V98HZghf3/DI+kE+zkGVceWAF45ZoYySFTkJFB4etpli3+m+rynDnkTSEOaxH4eVZMvBGvqeLucY9epwXYR9A124sJNykIqTpQh3+ZTihkgNY5FlcIo876z4617O5UVA54vCtuJxAxWIrpOm10Ms1eBSI6bs/+fd+12jk7BBN/vppsovTAoqlZwTfGKryxC+GJVZrmk/PfIduf88HBzA/+75L81S+5VGzWV9uGJBfyUe/iMrSjGrdxVu85pYNa4X4Fqfci+3r6gy65BgOD1bnCyINO+xjzBXNgpgDOwseNPylIuDV23yBkt+Wc490/+5xwlA5vAohhPdmGsynjixUtMNdvE=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(336012)(26005)(47076005)(86362001)(5660300002)(356005)(82310400005)(8936002)(36756003)(6666004)(7696005)(36860700001)(2616005)(186003)(2906002)(40460700003)(70586007)(7049001)(921005)(316002)(426003)(110136005)(8676002)(70206006)(508600001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 08:25:50.6155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5da73c-aa77-4628-2116-08da1df0627a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2647
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 .../bindings/timer/nvidia,tegra186-timer.yaml | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml b/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
new file mode 100644
index 000000000000..7841a68d19f3
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
@@ -0,0 +1,116 @@
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
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nvidia,tegra186-timer
+    then:
+      properties:
+        interrupts:
+          # Either a single combined interrupt or up to 14 individual interrupts
+          minItems: 1
+          maxItems: 10
+          description: >
+            A list of 10 interrupts; one per each timer channels 0 through 9.
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nvidia,tegra234-timer
+    then:
+      properties:
+        interrupts:
+          # Either a single combined interrupt or up to 16 individual interrupts
+          minItems: 1
+          maxItems: 16
+          description: >
+            A list of 16 interrupts; one per each timer channels 0 through 15.
+
+properties:
+  compatible:
+    oneOf:
+      - const: nvidia,tegra186-timer
+        description: >
+          The Tegra186 timer provides ten 29-bit timer counters and one 32-bit
+          timestamp counter. Each NV timer selects its timing reference signal
+          from the 1 MHz reference generated by USEC, TSC or either clk_m or
+          OSC. Each TMR can be programmed to generate one-shot, periodic, or
+          watchdog interrupts.
+      - const: nvidia,tegra234-timer
+        description: >
+          The Tegra234 timer provides sixteen 29-bit timer counters and one 32-bit
+          timestamp counter. Each NV timer selects its timing reference signal
+          from the 1 MHz reference generated by USEC, TSC or either clk_m or
+          OSC. Each TMR can be programmed to generate one-shot, periodic, or
+          watchdog interrupts.
+
+  reg:
+    maxItems: 1
+
+  interrupts: true
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
+        status = "disabled";
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
+        status = "disabled";
+    };
-- 
2.17.1

