Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E43514856
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239294AbiD2Ljk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358588AbiD2Lii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:38:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C85C52;
        Fri, 29 Apr 2022 04:35:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgAMyv4tOVoqWXljf6qEHWWtWVpIiW9wUeg3uyMOYXmlqsKCZTEhYhHcgrUsQ2Nm8SZiy3iz9mAkvw9De0HK3ikwMVQViqxFirsuTnaV+lKSSLAiSM9OvPVdF+oBQgV+Ywa0zjo7l/6qCrCW/DBBMb/c3VdA75JMUjgk2SFmKdb0T3KEnwhBPDzmy0vHt61ODZCCvkY6qq2CVLgERgHdZFLeFhjxXoZm6MrQMrlPyAeZKUcWyJP+2QBSs8/3VQAfh1xujqtkao6YpWg592zFgXJ6tjsiVjBH4NTF2T0/eSXqzkzJqqDufpdnfEpNrDTqXIN7ZKg0vQ8Aciw8vwISSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9j6AHf/6v3YOnTiAnNG7RrJ9xs4nUzKOlEFDhQxkt/c=;
 b=UI+GyzM94ttC3/NZN2cvtn/b4yjx/oFm/KqogDcOeMWfBjfYJaIs3h/XKF9WTytTjbWP7vmx+Jvv5NEpf5uD3/+piLckQAvQXbA0xoGZwCuXZvfW0cIuOL4rxRs2JJ9e5Hs6QXjjUTxHaSKFoIQ8+AgSpEj0bbIHqkqwViCKrb1Wgtt7sYPOtDNt+ncBV1YzfTVqHeP3shFMptyzuOTSPXfuDICQ1qSE4cec/jjfcmKAgP8g+XKsC7A0pLwUznbs6VlrvpZ0P8q4t1kaqhWFqZ9TL+/8tPy0u0UY8R1crfAUSN8jq0hDCXv30kURlbW4oVNz55Re+gNFra1oXwmd+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9j6AHf/6v3YOnTiAnNG7RrJ9xs4nUzKOlEFDhQxkt/c=;
 b=SuQ3f5rMsQ0CwwSZCl7MtzDyA79UIM0kodHwNxP8zGsNDKIQIXfrrBisJ1CTEfpVKOnmJWwcLrknH9BvEQnXYmCaagu3QU+heUL3+zImTh6wgmHOjYqKj+TD2eg1IrxwQeR/vKYkG/SdtoOqfex67UnJStqM5j9MuUVsmSJLzTboo+FhEGZpuu8YZpsAa4g9ppXHQELDfgK3NkmxJXEsJzaV0uSLvthcy6jWxisKdX0CvFbVAmfqNzuV+wsTl3uQ0VH5/hov86rrZDTfa/rX8oexiv41YqLdFzzBtpB5rcQu1TUiEGMq74XPjPTOSnceLNAIwvrjnL01tp93/bOJ4Q==
Received: from BN0PR04CA0078.namprd04.prod.outlook.com (2603:10b6:408:ea::23)
 by MWHPR12MB1280.namprd12.prod.outlook.com (2603:10b6:300:12::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 11:35:05 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::7) by BN0PR04CA0078.outlook.office365.com
 (2603:10b6:408:ea::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Fri, 29 Apr 2022 11:35:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 11:35:04 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Fri, 29 Apr 2022 11:35:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 29 Apr 2022 04:35:02 -0700
Received: from amhetre.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 29 Apr 2022 04:34:57 -0700
From:   Ashish Mhetre <amhetre@nvidia.com>
To:     <krzysztof.kozlowski@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <digetx@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <dmitry.osipenko@collabora.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <vdumpa@nvidia.com>, <Snikam@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>
Subject: [Patch v10 3/4] dt-bindings: memory: tegra: Update validation for reg and reg-names
Date:   Fri, 29 Apr 2022 17:04:37 +0530
Message-ID: <20220429113438.13988-4-amhetre@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220429113438.13988-1-amhetre@nvidia.com>
References: <20220429113438.13988-1-amhetre@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0318f71f-72c3-41a3-70f7-08da29d44e2b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1280:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1280FDAAAEDC46AC7DAC1828CAFC9@MWHPR12MB1280.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GlOVTtsbYimHJdFiB/6OWqGCu6os/EFoqmy42L/fwRUatZgcO/DlZjcTcs3KGyN+Dtf0/wDKyr3vK0Rqp9f94fS0UIsGnmC3u7w5FOgFmabSCqvTcJgAy1E1UuTHS9oNODAURJZzejBPAoC8j9LRXyvLvY9YiyElTPCbdkcmiNC5WY7G9qZEOJgidKPa6lTCj5Lv4d5Emx0hXzjRRLdR6Bej5mg1cUKt2iDfVzKXbRLxxkSfJjwylk5uUC+yaXW7z9falxAYlAwdfB1BgJE22xXmMZlqNckXDz4v0N5uyVr12F7hArrGcBvPIk+GtheQTxqVrLJ4vn2R1USr6zQza8ixTMfLQxBh6suWQSjPec5eXAIuD84xZ0tzRiMgY51J0hG4V4xfv3/1blFotuwnScUFKqtSzI0mQXYvs4QEgbkC5wRYBfp4AyYhiD921h6gGhzOqbSJF7T4yPq504Y+Oag2ff0orSwLdWg+T/KwZl62wGAdCYtMMdfUXzGw3YmFq1NsTkcC6f5UX0YrtO9Yf7GJHUlpRUi4XM5ROq4yt7KeLAsLWIuwrqWC4v1bPMUJ1glJy+FlTO46mhql953Su52yO+R7slzVvzse3SkpSCV98mu4QjVz+LUuyUKsRyoh5eDApIzmXw/ZdpXFrr3swkbjz74TBlE2CYeTEJt2URfdrSTTW/11d/ZBcTBHHibiybFZb69tV5GEIAjHnrZK5cpUx+VKLF/eLi32FyeYOi8=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(5660300002)(81166007)(82310400005)(107886003)(316002)(8936002)(426003)(2616005)(47076005)(36860700001)(26005)(70586007)(70206006)(83380400001)(508600001)(336012)(110136005)(36756003)(1076003)(15650500001)(4326008)(8676002)(6666004)(40460700003)(186003)(921005)(356005)(86362001)(7696005)(2906002)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 11:35:04.6059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0318f71f-72c3-41a3-70f7-08da29d44e2b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1280
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

