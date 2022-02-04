Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D492A4A99AC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 14:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350655AbiBDNGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 08:06:14 -0500
Received: from mail-dm6nam10on2055.outbound.protection.outlook.com ([40.107.93.55]:45352
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347318AbiBDNGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 08:06:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLHUJSJKMyc2nhYu6Aw0wqMPLQt2hgaJXZRZJsZr3SwhgVSUijQ8F0F9Jl3/9Axhkn+jvdf0T2jTqu5FvNngJHtHiUoQH5gcuoda2vVk85JGbZQxCz0G65JOeYUWPyDJ0FqiAbGzefgytvdPFHJVob533qjO+pI0YXYDG/iRCzfEg2tFBFztYBpHA9Qe9o2wT7gFE+fb/KcQcS0HzPiT9zCV1oJ4dtBZHjCMFCDvaKiX4/Sxd/vS3VYCAitKtdjgaMKWBSL6VfOvuulpe2EtEJrGpknuaQgj7MFTLAB5lYpYbGk8lv9ohn0QshZVmeZuqCOmA5GfZ7rkRSmNfHW+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdJI5ur0mYlyE8KZosw09tYlAKu4OjZBFoQ1x1k1vsw=;
 b=gkzN0KLYmgH4OtZ+n5WZdaJqghA9jtA0Mh6brpwwqMUBBky0Ed0Lu1rutQHwC7xsWWrFR0g2XslLuUlchcD7xbyXcqVwZ0vCna+K6pRQUA8iXKLtnOTLzz92Uc0Zu6fNS6pEAZ3uDPJqXYLMEHNufu0rE6jb5o3G+GpkGjOV2whPwu0wxG2a5B30D29fdEDSesAt3RcFf5qbLlEGEGEkaiBDnwHlfs2B/Fe331eAuk/78OZDkZGByLO66l/F1P4sgV9e2101g+vcOv6FWcltElEbZ2GI9J/BFY5ntcdEtZ2XMz26lIsGyozns8EuZl8f1r4z0EnhPY90rlFr9KDXxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdJI5ur0mYlyE8KZosw09tYlAKu4OjZBFoQ1x1k1vsw=;
 b=XWQiJ8r2XrUoSauRT56jryqDLosjvczHJ41ZHNcO46yn7/tQUYER05ce17d5kOFuCgKrvxjUzn9ocZoa6u1NLd5miQG3l8LOHSBftdDnHcPHDnK9Fy4PIFceY2zU7OBuh+AFs39KYFxwy7pRaQGACzbXG1G2yc/OaE1unwcmLpk=
Received: from BN9PR03CA0384.namprd03.prod.outlook.com (2603:10b6:408:f7::29)
 by SJ0PR02MB7597.namprd02.prod.outlook.com (2603:10b6:a03:319::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 13:06:08 +0000
Received: from BN1NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::b9) by BN9PR03CA0384.outlook.office365.com
 (2603:10b6:408:f7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 13:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT045.mail.protection.outlook.com (10.13.2.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 13:06:07 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 4 Feb 2022 05:05:54 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 4 Feb 2022 05:05:54 -0800
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com
Received: from [10.140.9.2] (port=44286 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nFyEK-000Bmk-0t; Fri, 04 Feb 2022 05:02:24 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 1/2] PCI: xilinx-cpm: Update YAML schemas for Versal CPM5 Root Port
Date:   Fri, 4 Feb 2022 18:32:15 +0530
Message-ID: <20220204130216.2206-2-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220204130216.2206-1-bharat.kumar.gogada@xilinx.com>
References: <20220204130216.2206-1-bharat.kumar.gogada@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 753bd57e-1c18-4103-8d95-08d9e7df1bd8
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7597:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR02MB759746694825B370468F2C87A5299@SJ0PR02MB7597.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4lF5YJOCA1PU4cosJEKOmQkr8+fKowszVRQSzyTLF/pIrkwAQKtEF8QM3j2jDS9ObWN4lQWjQoLUuezULICYrUcQmqbeGW0LDN8yYQ08359Gq1DovFinyQCisJC8Q+NqpBgamhoEIPwwaeNjNd9UBgFsfKAm8s+69r98iZd7liwI+Cj0mXpQXbxbC2eW3mPN3unggsJ99GVwEx8jZAWRE+Z95LIsRI168ulc9K/MGCVOyh62R3LMzfLEpS0rgnVxLMHB+GPRy0P/EZCPukKNiUcTIK/1S+idDtjikbxJwyvm245WVA5q2FGdOXrYkfHmOF4T4+ym2uwruw90O3jq69ZYAzBVvZXXmK3gd4/KezZsg+MQ75HOyAb7/jfQVPFrJON35UkJqEllK08VVqVGXfSlEHFA93n5VMpg0nNijOEJnWKxosYc+IROhGTmQ4ev+FkltWqXgSd8kXQynBl42WnhjLhrIR2vRP0Q3edDEp9nTnLDqD2fCqNLAcpbXMVmoq/Gf3GXlU+ustHDTLd7uIrpHcqwZY4co0u071a0UlMuY45OMk5YQ7unMiXWwTZbjaPouIQ+XJjoE48R80onXpyYAtzqjPsEB++JU1jujko0DMCE7i7EAg1RUUDWoFwctJIY71aKHA1XYEJHrRF3VVyJLEVPAEZutt/+kTxv+igw7fGRUVXQz6YqXfrQ8/bgNrIsw+zwPrGcpGspt/X6ew==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(5660300002)(7696005)(83380400001)(356005)(6666004)(2616005)(336012)(426003)(26005)(107886003)(36756003)(1076003)(103116003)(186003)(70206006)(70586007)(82310400004)(4326008)(40460700003)(9786002)(54906003)(8936002)(110136005)(8676002)(508600001)(2906002)(316002)(36860700001)(47076005)(7636003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 13:06:07.9129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 753bd57e-1c18-4103-8d95-08d9e7df1bd8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT045.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7597
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx Versal Premium series has CPM5 block which supports Root port
functioning at Gen5 speed.
Add support for YAML schemas documentation for Versal CPM5 Root Port driver.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 .../bindings/pci/xilinx-versal-cpm.yaml       | 47 ++++++++++++++++---
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
index 32f4641085bc..97c7229d7f91 100644
--- a/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
+++ b/Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml
@@ -14,17 +14,21 @@ allOf:
 
 properties:
   compatible:
-    const: xlnx,versal-cpm-host-1.00
+    contains:
+      enum:
+        - xlnx,versal-cpm-host-1.00
+        - xlnx,versal-cpm5-host-1.00
 
   reg:
-    items:
-      - description: Configuration space region and bridge registers.
-      - description: CPM system level control and status registers.
+    description: |
+      Should contain cpm_slcr, cfg registers location and length.
+      For xlnx,versal-cpm5-host-1.00, it should also contain cpm_csr.
+    minItems: 2
+    maxItems: 3
 
   reg-names:
-    items:
-      - const: cfg
-      - const: cpm_slcr
+    minItems: 2
+    maxItems: 3
 
   interrupts:
     maxItems: 1
@@ -95,4 +99,33 @@ examples:
                                interrupt-controller;
                        };
                };
+
+              cpm5_pcie: pcie@fcdd0000 {
+                       compatible = "xlnx,versal-cpm5-host-1.00";
+                       device_type = "pci";
+                       #address-cells = <3>;
+                       #interrupt-cells = <1>;
+                       #size-cells = <2>;
+                       interrupts = <0 72 4>;
+                       interrupt-parent = <&gic>;
+                       interrupt-map-mask = <0 0 0 7>;
+                       interrupt-map = <0 0 0 1 &pcie_intc_1 0>,
+                                       <0 0 0 2 &pcie_intc_1 1>,
+                                       <0 0 0 3 &pcie_intc_1 2>,
+                                       <0 0 0 4 &pcie_intc_1 3>;
+                       bus-range = <0x00 0xff>;
+                       ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0 0x10000000>,
+                                <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0 0x80000000>;
+                       msi-map = <0x0 &its_gic 0x0 0x10000>;
+                       reg = <0x00 0xfcdd0000 0x00 0x1000>,
+                             <0x06 0x00000000 0x00 0x1000000>,
+                             <0x00 0xfce20000 0x00 0x1000000>;
+                       reg-names = "cpm_slcr", "cfg", "cpm_csr";
+
+                       pcie_intc_1: interrupt-controller {
+                               #address-cells = <0>;
+                               #interrupt-cells = <1>;
+                               interrupt-controller;
+                       };
+               };
     };
-- 
2.17.1

