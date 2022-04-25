Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52A950DA9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 09:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241595AbiDYH4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 03:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241529AbiDYH4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 03:56:13 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2085.outbound.protection.outlook.com [40.107.223.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD79286E7;
        Mon, 25 Apr 2022 00:51:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebM5hmFDHG/LO6XNPOzrkGSL0A+uzNC7Zboa/5N8NwFja6YZUI1g/eOvoZmEF8Wv6byoxcNtJyQq94x+pfNT7N35m2G73VujiLQbBz1VEblkwbdqPAfC4tbtLT7Bm2NCxeBeUq3E5vPpOxPAOR4h8cZvLhpeTljfd/siAtflf7Fq5rfJ9fqcFJLn4mxUSVDBhZAph84L33+PjSrLZFG9pWHym407uLHuQvg5zdX0EYORNi6bGZ9xiF6FcdEDejUbjyc5qDCha1GSHXoxa43s2a78gC9Y6SzyutlM6LGcwfyLP/BEN5uQWMMhiPN43z6WxQyPqyUAZW8jJrcEbpqz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzuCm4yVpVFKBkytQo9xgpMccstwcTJ5D7pBWDmy3Rs=;
 b=WPYH/T76mPGuIeetNi+/x2N0DMyBsbIGyh31AdserLCUV/HIcrVn0eH9T0PPjTinyI/tYXV98ns452NEtUF58B556A0tVd3KGGOCWfr7kTXUaD0jyd6kZaHxrHphrdSCbuGKYs/qFLCQA+/12Tv4+37NJsW1FH1xl8Cnhq4cyce0StG0O6H2yjUzS+wJcDT22dUcI+SL8eE4l6sbXY/FRFxGIHspzzSi7k6cNkmFNq+kEBz7aZD5Uy4OKrikxc4EFsNAexq9ghg3MpQLqvigfCd38EuO5k9CClzKRLWPQpcKDbERli6BmE30mYem7H2Uium+8lOVk3dYeKmOZTUhpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzuCm4yVpVFKBkytQo9xgpMccstwcTJ5D7pBWDmy3Rs=;
 b=apPNIfBF7emnTQKcW6cZHySyrGhAlToFcnQKWbSPvRtdFdTuwCg+Pr+fqDTiNciZa8KJUTbDQNgwgq/Se8cz7PArMxcJZbmZVPO3QI4g8FBbMv9gMmxQ4h2bcsEoxQy2vBKbo9f9cXWfaJ6EoMMxcS/ZbT23Utlsp4K8jRus8YPaOLViwU1QtL6GLt3gIBR5PW/hKTIiT9kWJsecucaw6/ByNGCKPXPdHOpkOcrtNMS99IfxvL5ZGbqnX+3TnhN39ePQVtgkvJ/S6XzqP96NfNop00khfzETRNlBJTqgEnQ+hslqQoG9eETAEsn2RuZMDYVcppDNw4QOku3wUC9YaA==
Received: from BN8PR07CA0020.namprd07.prod.outlook.com (2603:10b6:408:ac::33)
 by MN2PR12MB2910.namprd12.prod.outlook.com (2603:10b6:208:af::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 07:51:18 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::c1) by BN8PR07CA0020.outlook.office365.com
 (2603:10b6:408:ac::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Mon, 25 Apr 2022 07:51:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 07:51:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 25 Apr
 2022 07:51:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 25 Apr
 2022 00:51:16 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Mon, 25 Apr 2022 00:51:12 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.osipenko@collabora.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v8 3/4] dt-bindings: memory: tegra: Update validation for reg and reg-names
Date:   Mon, 25 Apr 2022 13:20:35 +0530
Message-ID: <20220425075036.30098-4-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220425075036.30098-1-amhetre@nvidia.com>
References: <20220425075036.30098-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0213c8f6-f19a-432c-8f19-08da269061d2
X-MS-TrafficTypeDiagnostic: MN2PR12MB2910:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2910FB1C11DFA82B1481158BCAF89@MN2PR12MB2910.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 03zQPxw407xxvDqjzapzj5ytf+9ed+jTYm/zKwotAlIKW2zK87Dh7V0WN1D1W92G3gOLbjVG64eQydd+NnhYklf67JB/w0ipKuSEOEkDpZgLGuR/jkuo+pengNJwyCe6ZMBubQVPm6ImelF2kCfLEWeiMIj21KUW3HxHKmu1GmFS9WUOMTPKkyFt8kXEBnKKmsF6C2eXJYeKwwRHhOzUi7dqhGbX28h9SVzpZERpu3H/WZukTDAxPCrQbotKFHu1I22x7aU02IxQ9QPz0imTKUCSaYkltSVQJges+1Cl4G/msT8xVglg1XVTcz/CnyCm5zqYEdSgBfgE/1aEeHQz2UEkFf3jQfe3msg2+ZDwCQHzBlU83wWl2iEcVLXhtR+ooW2ueORnbDZmjDZA4Dr8hFOwMILHwDKT6skQNZ/S4RH0QmIl+P8OfJywBf2g4SHNozXqeV273Pdz7nmiyhAVvwJzZy0EEzewdkoZ0ijgqT8t5sQxxL7oDbqgGFebVmXZ+198KCRK/GZaT5wK/3ZdEkkVec1mHst3kH5QHE6ebdWIzFnztgxeaUmwxBFa/KiESsNMqdiKb+ySakXZCkm3ke7+Y/tWmA/1LEpriDQtdxaa1HLLbdnRcBDz7s+fVtu82AWopkgrlDh7eo7m5wJGgL2DOKnADY6EHUAbDsz3RkXFC+zi/8P707J4ZwFT127oFfBAmz1yZo7HOGUFQnxVIGTCUTb8Csuiq7mY8af8NkQ=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(316002)(336012)(82310400005)(107886003)(7696005)(508600001)(26005)(5660300002)(36756003)(83380400001)(36860700001)(8936002)(81166007)(86362001)(426003)(47076005)(2616005)(2906002)(1076003)(54906003)(8676002)(4326008)(6666004)(356005)(921005)(15650500001)(70586007)(186003)(110136005)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 07:51:18.2963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0213c8f6-f19a-432c-8f19-08da269061d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2910
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

