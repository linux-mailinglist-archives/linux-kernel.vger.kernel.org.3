Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDC7560911
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiF2S3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiF2S3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:29:21 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9321ADB4;
        Wed, 29 Jun 2022 11:29:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PElfTb3zk+u2iiFKgNPoDZy0yqByj+izvhQyWsOG/hd4gV8B6j5M389ZdHaP0bynULGuzo3foHfL1YevRPMDVpXAQ7tXHp4RwcZzeBgmplWsAbE9RxrKASoJY8hFeGWwNPKkWp+KSLm76aBkhShVUYOfSJuIgl2jfJxLn3StX3Vkv7qHRXIF4pLDO+e2b8YFSxEXTYP6Jk6iWBEjsxMXUZU2MLMvwbbvu/20GrC/X6SS1rD3t1GlZ72fQ1qN6ibjUBcGaUliI23zEFo6/SWrhUjE/FpsMKzi4a+tvzMZQ3PFtXLRaFPCdnnZwWy7U+bDL7+5ei3qvDGCk7/lFe5ptQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HzCDBaBfM/MyIeLgWm2EWN75YMiXT4Ne9LwLJiXw/U4=;
 b=FejwVUD7BusHav3LUdz7UvPmrqPWIrGRJU9jvzA31XBn/BXVScbLGexEpfJPB64Es/LdL8Uzqn0hgynvfkcc4YWbsUsGjgtXxTJ6+y+/R1Bn8rbKWNR8YgbG2CzcKVBskh506jMJEg7xos+YnAiey7XoimLZ+MD52AQp1iUSSaiSi/qY0DgS5QGGAPWY1avpyO1Y3jiOXtTDV+XSbNG5YKLjUcX4ZVTRzBQadtQdzaALutievIelPVWbxF4MylDkIGncJVFULExOvKhiLgZ0IgcxybFYthQr2b+1N9Rw455dxue292cC5Uw+j6LRU9sLw/nCFXUX235xyVpmXWqnMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 203.18.50.15) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HzCDBaBfM/MyIeLgWm2EWN75YMiXT4Ne9LwLJiXw/U4=;
 b=Qas27dJKuPnjAWWwrLshbah49X2Rhx940upTS7JXCcNcxLctBmmneOIzM64+ByAnM+VEyDzHbiB1ZnCKWWWL9sT3D2a8lV7AE1F5KM2woKEvaD7Aj6Qp+Gqsr61A54CftoTdxuTrQCialrVh04fja9o/7jNYmLQv9BPJaeIU09jWkiubTDFnssWUpbHRWAefc47cUNIXviv1qPrApQ2wlGfCM7VSXa2T/lTs/sCPnMWb6N0Odi7hr9G4p0yEpUtpb4xYPngD8uCc7j6asO9s5b4Jlc2VLyarfpJge8xAi0UB+pktnVdBcdch5xmgj4Ow1IIb2u35aJ+FDNR3ddigBA==
Received: from MW4PR03CA0299.namprd03.prod.outlook.com (2603:10b6:303:b5::34)
 by CY5PR12MB6598.namprd12.prod.outlook.com (2603:10b6:930:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 18:29:19 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::3c) by MW4PR03CA0299.outlook.office365.com
 (2603:10b6:303:b5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Wed, 29 Jun 2022 18:29:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 203.18.50.15)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 203.18.50.15 as permitted sender) receiver=protection.outlook.com;
 client-ip=203.18.50.15; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (203.18.50.15) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 18:29:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 29 Jun
 2022 18:29:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 29 Jun
 2022 11:29:14 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 29 Jun 2022 11:29:10 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <spujar@nvidia.com>, <akhilrajeev@nvidia.com>,
        <rgumasta@nvidia.com>, <pshete@nvidia.com>, <vidyas@nvidia.com>,
        <mperttunen@nvidia.com>, <mkumard@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <kkartik@nvidia.com>
Subject: [PATCH v2 1/6] dt-bindings: timer: Add Tegra186 & Tegra234 Timer
Date:   Wed, 29 Jun 2022 23:58:59 +0530
Message-ID: <1656527344-28861-2-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1656527344-28861-1-git-send-email-kkartik@nvidia.com>
References: <1656527344-28861-1-git-send-email-kkartik@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98435ca9-c36e-4ff4-f97c-08da59fd4783
X-MS-TrafficTypeDiagnostic: CY5PR12MB6598:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W5FrsudLE7i+y3Jbx11m27iUrHrU6Lsn7b6eV3huQwWuWr6Rec49Oqfb1d8AMDBeg5wVRjM2LvY3y9o7dzdQAuh7prj/TXNAfyc/37XDnx4rDocbhwmOYC+WFARTCQjY3if8V2qCvsDB5h3skHcq0qlMaGVuTwaISFbCYmW6QgBljPHq+j+BD7/vuWBVW4pujT2GnLwVMxSdADNHGdxnGXditJsm8zPyqXVP5HGODi3Bkt7IOvAmufvuGvF0lQbOMVK/OEG7bgufN0IrWmQWSv1dbUSbHFJR2Srk98NIPPVUooh/6+NHCO5Kv0JkkCtAQAh71a4gCNgVnaHw8oMd+TUEP9RnGp8wjW12ALGedbR5NMuMv/7Uk67DsZgklnw5TqoYa1PhUYSUR0ztFhmMKVd48ah+MZ1HibxR7pPme+O6wmEj/+HjeezYHV0E0M4TQksRTwfp/0JLXzql+JAcDDVrLNVAtC0QduxW7WXr2FCAfu9uxOrqH8j5by7gctUbXRQRyE0j0CzEaQqG/ZQZEN13+VjlZ6lwQNb1abdMOLjzo3jtsyitCQDGI3kr9K7ROpALjVDOZzCrrRSwh60Ptei5cQfWQZL8heTYWsjFWzYLBD+Fo7f/f5LdfhwlF2Dq4ddEgdoENc6BBewZpWZ0u45SSmc0vtwzC2BjuE7SO8ghMm+2lnCh4C6tFmuG2FB2ZzLCbah9KEAeVRiR63KAj3MIMOYlTGmNJx2tPFF5F2eM6Kb4s7fB+eM2g3X3L1oJ1VouvWeaMZ2NwdZgZoeQZssx5c4FLczaYdDaR52Asw024z6hJbyvIO87cNs+8f870aVqKEQP5J6t3eaLVgh1b0IQOuZAcU/8hRpGORK6y9/6i5AtiYyRcu7rPeMxAtQRjEV/IKdE5kGyEWLIHqKbJKyt71KRfNNgoYDYeynN5VGURjgpPqo13vITG+k/PCPB
X-Forefront-Antispam-Report: CIP:203.18.50.15;CTRY:HK;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:hkhybrid04.nvidia.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(136003)(346002)(40470700004)(36840700001)(46966006)(2906002)(70586007)(478600001)(70206006)(8936002)(40460700003)(36756003)(40480700001)(5660300002)(316002)(110136005)(82310400005)(8676002)(2616005)(86362001)(7049001)(26005)(6666004)(186003)(47076005)(41300700001)(336012)(426003)(82740400003)(7696005)(921005)(356005)(36860700001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 18:29:18.4338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98435ca9-c36e-4ff4-f97c-08da59fd4783
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[203.18.50.15];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6598
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 .../bindings/timer/nvidia,tegra186-timer.yaml | 111 ++++++++++++++++++
 1 file changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml b/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
new file mode 100644
index 000000000000..5dc091532cd7
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra186-timer.yaml
@@ -0,0 +1,111 @@
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
+          minItems: 1
+          maxItems: 16
+          description: >
+            A list of 16 interrupts; one per each timer channels 0 through 15.
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

