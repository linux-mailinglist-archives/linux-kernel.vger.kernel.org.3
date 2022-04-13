Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCB74FF3D6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiDMJoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbiDMJnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:43:19 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5335C37008;
        Wed, 13 Apr 2022 02:40:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxXscnrnp1E8IL2cQQN/gtirLZE4nO3RmTL/LYy8ZdBxGsslZJsXIxtuuyZkllVMR93pXSo02O9HKU9j1GZkfk4DsjN+jU+8MqJNy/xHSDyYDEPiZliI3HIheVsVPdj5Ea5AWC6qzB4Dwmh6+j/7iFxa6ScUx615NeW+UovRBLpQFwWxVZuRw9Wa4a5u2+IhAT1W/WirJuF4de8EfdLvaGBjIh7IYm6j9yerl1vEqcxau+ksOI4V8RCpxIRK9BYCuIyrcYj1AnKolm7VDKCkHwQl87TqmO9nEFJUcqDDG9gTcbiudmqXIfkPcROsOE8A9NfFg8n5t45nJdVy27yG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0V4+rBQEU9VXpY1zd8XDrO/huXqBhCJ9JEUQQJ9RFk=;
 b=BpV8Z2Nsmd7Sk3vqpeAUT0bXbuvfVP5csIG/JpbwlHRX/oyKMG+JvYa4YF2RwDeP/d63Hh0QotE2+4nEAViZGpN+bj729a/ZIETGIBG8L1Y0S767wDJkQqFq9cXgGCqFNZWcpQF+wpLpyizBwq2mFOJOITrR58dsOXDlbhuvVxrVmAIrTd3QpcZJnzJAN0rUgiv4TLegIY41CS2+0vGc0gAN181xb/q9E/EDb7bIO+MYRpPGX3K851TdVfT5Enn4BIOe6w8dGsCqwphrFVWDkc5Lme+HUgDzQB/3UAu6wjj3UIbHecVdgSvimDMEBRIbzbd9pp+kmi3FVj2K2VUAbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0V4+rBQEU9VXpY1zd8XDrO/huXqBhCJ9JEUQQJ9RFk=;
 b=qg4/yNdpGVmnEZVESxerQZENJz0YAAhjbzkbE2iNYWmBZ0x2Aycwnt5jY6vUa3ZK0xTHB/T45xrw1dwEwsv3I3k0l2yasVRYVikvQCQDi6Dpb/ibFlAbMfjpjIBNjdP2keqHqqiv71QOGpdh6yXv2DXhooXcztQdwI3+bI/LW5dnN8AJkKYzHex8gjwTfNGyXctAmcrv/Ylgpbhm4vK9eNB+aGLdaVoKZHLUmENRTWmd3nABHOsceojxcJnp/7d/aKqJ1k1JRBpxLmp/C5A67va+nTHcgP7PIjDWJFRsK/s08deXM7HsJRUTaJnsZe+AmD8uNs96fpTVyb7DfX6yrw==
Received: from BN7PR02CA0034.namprd02.prod.outlook.com (2603:10b6:408:20::47)
 by DM6PR12MB4745.namprd12.prod.outlook.com (2603:10b6:5:7b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 09:40:49 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::b1) by BN7PR02CA0034.outlook.office365.com
 (2603:10b6:408:20::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Wed, 13 Apr 2022 09:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 09:40:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Apr
 2022 09:40:47 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Apr
 2022 02:40:46 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 13 Apr 2022 02:40:43 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <dmitry.osipenko@collabora.com>, <digetx@gmail.com>,
        <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v7 3/4] dt-bindings: memory: Update reg/reg-names validation
Date:   Wed, 13 Apr 2022 15:10:11 +0530
Message-ID: <20220413094012.13589-4-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220413094012.13589-1-amhetre@nvidia.com>
References: <20220413094012.13589-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 832ec0bb-91df-4b1c-7349-08da1d31b0fd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4745:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4745B59950367117EC2A4351CAEC9@DM6PR12MB4745.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6JM7VCtXIyK6d7fEfJOlx0fzaiPVgUOlShxaGfCU2kuOqE80rlwaeeHx1WUn3oOKDT56R6oH7891+B7aeJbTa5crgG5x4OeP7xulq6/Yd87NEmX5nswenms6YTm6Z7JZ+hOOWUEu9m/0J8+cLEPk/ZdWLcJm6tvcYG0A15f9/cKlsWeRH1ShP4poa3HZxc5ESuAfPmr9u+RJvQDVXA1W5nV3SOs9EqoixmIOPNqXyr2xNFhdK8wNWsQ/MdkO88O0ic1brwFEHf6LFfeLAYDRe4GIPgYp5TyjSX5v+XZGv4t5EgFzb/wdf9Zm3jZAhMpr70ELIlXBz6N+24NKL5ihvepO6aCuJQEzfN6jHErMmM3p90xMjteaVqHHT6UZZWqxafMpXqu4EkaFhqm2STFQnfpVdDoZ7J1wcOzATBCshQFn5YVISTI0TiNZ/A+NG/t1wJkLsPiKLAOcqDOA+L+UHMmY/hNB64tV/vvVcPcOKY2jirVIlQ+f/GqymQIfMa+TSt4jnRTWPWiGjlg7DPu06Cza6TTgRutycHnYlMn3Q+RR0A4qHos2qD8nCP07tIxpU6uj4qJfWND99NVZ1Dpe8TWdZCcOE8AB98uChK6ZRVxpIrk8h74CMSAH/V9H2c1TaLbzmJy0H3T9BG0P2FnkukCXLRaLdYgKeQL9eJlkMu20bXmdydCLIpfvWxhBKfDBxn0/rOYNTq3y2a5CIPMXiwoXpUy8HS736HZdVDyzghnOEPnQG02X/LE3yAKkNe3M0yoOn6hqpBpCLSSNAjNygg==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(1076003)(2616005)(8936002)(356005)(86362001)(107886003)(83380400001)(81166007)(921005)(36860700001)(47076005)(40460700003)(426003)(336012)(186003)(26005)(8676002)(70586007)(316002)(4326008)(2906002)(70206006)(15650500001)(5660300002)(82310400005)(36756003)(7696005)(508600001)(54906003)(110136005)(6666004)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 09:40:48.4631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 832ec0bb-91df-4b1c-7349-08da1d31b0fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4745
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From tegra186 onwards, memory controller support multiple channels.
Reg items are updated with address and size of these channels.
Tegra186 has overall 5 memory controller channels. Tegra194 and tegra234
have overall 17 memory controller channels each.
There is 1 reg item for memory controller stream-id registers.
So update the reg maxItems to 18 in tegra186 devicetree documentation.
Also update validation for reg-names added for these corresponding reg
items.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 .../nvidia,tegra186-mc.yaml                   | 80 +++++++++++++++++--
 1 file changed, 74 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
index 13c4c82fd0d3..c7cfa6c2cd81 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
@@ -34,8 +34,12 @@ properties:
           - nvidia,tegra234-mc
 
   reg:
-    minItems: 1
-    maxItems: 3
+    minItems: 6
+    maxItems: 18
+
+  reg-names:
+    minItems: 6
+    maxItems: 18
 
   interrupts:
     items:
@@ -142,7 +146,18 @@ allOf:
     then:
       properties:
         reg:
-          maxItems: 1
+          maxItems: 6
+          description: 5 memory controller channels and 1 for stream-id registers
+
+        reg-names:
+          maxItems: 6
+          items:
+            - const: sid
+            - const: broadcast
+            - const: ch0
+            - const: ch1
+            - const: ch2
+            - const: ch3
 
   - if:
       properties:
@@ -151,7 +166,30 @@ allOf:
     then:
       properties:
         reg:
-          minItems: 3
+          minItems: 18
+          description: 17 memory controller channels and 1 for stream-id registers
+
+        reg-names:
+          minItems: 18
+          items:
+            - const: sid
+            - const: broadcast
+            - const: ch0
+            - const: ch1
+            - const: ch2
+            - const: ch3
+            - const: ch4
+            - const: ch5
+            - const: ch6
+            - const: ch7
+            - const: ch8
+            - const: ch9
+            - const: ch10
+            - const: ch11
+            - const: ch12
+            - const: ch13
+            - const: ch14
+            - const: ch15
 
   - if:
       properties:
@@ -160,13 +198,37 @@ allOf:
     then:
       properties:
         reg:
-          minItems: 3
+          minItems: 18
+          description: 17 memory controller channels and 1 for stream-id registers
+
+        reg-names:
+          minItems: 18
+          items:
+            - const: sid
+            - const: broadcast
+            - const: ch0
+            - const: ch1
+            - const: ch2
+            - const: ch3
+            - const: ch4
+            - const: ch5
+            - const: ch6
+            - const: ch7
+            - const: ch8
+            - const: ch9
+            - const: ch10
+            - const: ch11
+            - const: ch12
+            - const: ch13
+            - const: ch14
+            - const: ch15
 
 additionalProperties: false
 
 required:
   - compatible
   - reg
+  - reg-names
   - interrupts
   - "#address-cells"
   - "#size-cells"
@@ -182,7 +244,13 @@ examples:
 
         memory-controller@2c00000 {
             compatible = "nvidia,tegra186-mc";
-            reg = <0x0 0x02c00000 0x0 0xb0000>;
+            reg = <0x0 0x02c00000 0x0 0x10000>,    /* MC-SID */
+                  <0x0 0x02c10000 0x0 0x10000>,    /* Broadcast channel */
+                  <0x0 0x02c20000 0x0 0x10000>,    /* MC0 */
+                  <0x0 0x02c30000 0x0 0x10000>,    /* MC1 */
+                  <0x0 0x02c40000 0x0 0x10000>,    /* MC2 */
+                  <0x0 0x02c50000 0x0 0x10000>;    /* MC3 */
+            reg-names = "sid", "broadcast", "ch0", "ch1", "ch2", "ch3";
             interrupts = <GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
 
             #address-cells = <2>;
-- 
2.17.1

