Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4F850F2CB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbiDZHm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344129AbiDZHmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:42:15 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2942133E69;
        Tue, 26 Apr 2022 00:39:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5tN7rYuRDELi2V8loNMK62HjO/+bP2QlRUgoGuoKT7gUC/Uuct6494veU4svqhUrPsVO+xiI/hyyQO3kAzCFiE3pJXKdqzE6uSGgFROFWXUzsepdHDZJIgLXqaPejxiaCuisl6jM71LRbcZGA4gtheKh0hM+zLrTQKO6Fz2YGhxUQll49ZKd0saGc8bxnc71oBAX/OPpVNkTMrp+feLbxCptpJ8qIe73TIIg+rqtY1gzxnYDiK7HuEyVL7ZXHQpHYQGG+Adf8iDswVXS/WsgtHZzPboqmKwHOPS5zRbHSBOt/Yz8sVwW2P9pbjeR1DGUBwwzfMntESTsGgwfh4UWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9j6AHf/6v3YOnTiAnNG7RrJ9xs4nUzKOlEFDhQxkt/c=;
 b=Esw9d1fQkyndyGPefe4o01jkaZjSzV3UVA88iHEfbZOVZFrmoHs1ghbuUEgdO8Xn97MAr0mFUD/T4OkBG/DJ+/MuJF8uRa9lAMAfe4pbTfdxRjafCrMPZkVaNILZ5rq6bL5+7g5v/KRbyKOGCPtab+kCGTIuJs5ve5H/xK6E1IK9/0oSkwZix9rG2QbJmtqSSKPGUMFOh5GThB6gabCguaoDvTXTIq+xlO48UCnVOMuo/donpZe9wSxtHupaeQl7Wp5UDrQX56Ra80xqYi8qL7vgKSWxp0a3Wse682xaMFO8m7w6NqU2mf/3kKVljMeQVu86eGSvXESaXvMWBXgJwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9j6AHf/6v3YOnTiAnNG7RrJ9xs4nUzKOlEFDhQxkt/c=;
 b=aktZFHh3TktTgwsCuDrekOQsVZqcVrek3Gymgq/Bsll1Bqzitr8FYDpSDFp7ei4Kj9IPj8KTehVRSnOAN60CebJH2UUbjvqPHAOaroOletWzdgxWc2YG6beoe53fOYBZQ/qTtW0/ILMW/s5w3uPR79LwN4UKws34amVo9FF9hTV+TQiXJyOcYSiaGTaz3EZg8d+7s1ovsBdmP1eeqvQ7B+3+uCd67Xdj885UY+CAUCHEjR7/2V3gR810CRpdxlYYZYTDHVeAwKnFRkztuPnnb7m8R+jw8EKI76+zJ27MCXeIoe6RnjWmzMtrsnxwe270AY8/dZeeZXBHfCHK2dCIkw==
Received: from MW4PR02CA0017.namprd02.prod.outlook.com (2603:10b6:303:16d::24)
 by DM5PR1201MB0041.namprd12.prod.outlook.com (2603:10b6:4:56::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 07:39:01 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::c) by MW4PR02CA0017.outlook.office365.com
 (2603:10b6:303:16d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Tue, 26 Apr 2022 07:39:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Tue, 26 Apr 2022 07:39:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Tue, 26 Apr 2022 07:39:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 26 Apr 2022 00:39:00 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 26 Apr 2022 00:38:56 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.osipenko@collabora.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v9 3/4] dt-bindings: memory: tegra: Update validation for reg and reg-names
Date:   Tue, 26 Apr 2022 13:08:26 +0530
Message-ID: <20220426073827.25506-4-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220426073827.25506-1-amhetre@nvidia.com>
References: <20220426073827.25506-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06d3196b-a47c-4245-dc7d-08da2757d4b6
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0041:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00415588E56CC6ECD6A8DE1ECAFB9@DM5PR1201MB0041.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l1a5F1hQOy5L8GMCun/y0c4PJJssQDLg6KMrH1SKmmQ8rsIpBOUIZCLQMwBhD0Q2LsHpi72wEHZu9/Y7MU3GxYTODii9ihM8NhaHCzVQuKSO9ieYvT4WTsoNzcrquhAgXSVqTAPepnoCXBJY7OjlAKNCTFEuhHr1bsg3m+P9+g8G6orj2Ph4L6uzCycS3rWZJGIZkBvJ64rUNiMNmnySv6LnMT7of3RSJGZdzb+K6P1TUqi9Emt+Gap5Amusb3BU+o6vrHTOyXOYTi8seIX6RfuWPRhEqshgVJ20oZzdbrpmP9NQTP6eMTxeIsKv9v+2S8libG4gjLE9lAV6OfBfDvSZozMb9h36ouAPcJFZhvQpiXuXS1ms+uDzsESGUvdj+dFnrxZ6aZKkkbUfMkcAMAzWISUtbSwilnhZ2ugtUmCihR/KuQwTBtXYYUdjTQlAKOorGNfrECpGTK2rurquAHGrYu4lrDazDodwAqQGU6M9f52up01mdx57dNTkL7ZKrv6ph1Nw/7xFwYk0xUkwQ8M7engLYv17YdGUpu7QGL9alGF2c+2q+h0iaQX30ieGOWKvh7SyQC4JCfBRPRlhs+Rte1rLjPa7Wc+wFitBN42ReK15YoLE9lEwkm/DwnK3C9H9YQmz8SmdMCIUoNjFmHE/aNvgx/vHnMDvGcUHEaP7htEaKZVXNn6kmDxHH/Pa10PllA1EN1AkPFFWjNF9sTlg6SNPNPNwk++AYKHonzA=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(81166007)(5660300002)(107886003)(54906003)(40460700003)(36756003)(82310400005)(2906002)(921005)(356005)(47076005)(426003)(15650500001)(336012)(1076003)(316002)(110136005)(2616005)(36860700001)(6666004)(7696005)(8676002)(4326008)(70206006)(70586007)(26005)(186003)(86362001)(83380400001)(8936002)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 07:39:00.9488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d3196b-a47c-4245-dc7d-08da2757d4b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0041
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
So update the reg minItems and maxItems accordingly in tegra186
devicetree documentation. Also update validation for reg-names added for
these corresponding reg items.
ABI change due to new bindings is intended but backward compatibility is
preserved in driver.

Reviewed-by: Rob Herring <robh@kernel.org>
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

