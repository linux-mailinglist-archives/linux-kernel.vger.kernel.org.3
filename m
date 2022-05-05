Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9251451C5C2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244116AbiEERKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382381AbiEERKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:10:38 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5143580DD;
        Thu,  5 May 2022 10:06:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0d+YIVjT+ZIFbvNiYF/NCW9jiZl0Z+uXxy5ydUq39mW67YX0IOMlPOp3aT+SrnEpTMozGTKQSgjJWiEcgii6Wv/49L+foN37LUuVZnK6g2PebYmwPPwLw0cAy9Llh14kGLaHK5x6wKSePfzYOyHTxsYyno4fFC3gqCef1A0AUgrK7LqL9499fqgJVVetdh2ra3viQnfPpiAfWdvvM8etxPOtKM6eFIqn8V4Gp+kQwFBlChcPU3nuUScIUuEwMtdGzTn2fUkj/7S2TDN4czCeMY8VktahOb6l1AfA4joHFubwpxEVcf7iwBDVG+x2J+1RUxVaQviY66EnfVOUqT0Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJ+HB3gi2gpKQe8AtlogFINAov3Xcti/g37uMrBFLok=;
 b=V2cQ9Ie/n3WApiuaiJgo+j0mwIss1RYHq42IXkTCn1SXS3SUulaphC6CIT4udedmxC9Q32IwGTcPvcTCboY9qKndUpu7n7D6fG4WZDb98xDOtPzPTVE1OJVJT4/RFING2ghPPmvJSzrfDWkJhHYSf3XYXpxStse/9Eq/nycnaWcDJ3qJFVOKFbERWJXI8fPB9MOpshdZ/Oe/4Ca1qsxPRTY2/7/VVDSG0VU/XPVnn2z6BnWq+APzlHYM2Yfp6HrVAqlWbrzTmA7woBIrf8inuidEJz4/7iwRa0G/VwHCqo9VpzV/pIDbucReaqeiYUeYxg5FSYjUwC5n0fODrPFbjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJ+HB3gi2gpKQe8AtlogFINAov3Xcti/g37uMrBFLok=;
 b=JqvsjSUzTvGctOwgjtBvzW6a9ehP6keJZ5oJ/wo8ybgtry/uFvhg6ytiPVkU/MujEyD8YJuLxGqdV/nCFpStn2pevptYo8F/ewB1Mc+h2dQ0MEnlac/IdqOhyC+H80Pj5GFZyLWFhu/D6PZkeydFLbyNhoEMu+kCnU+Vx4g7f9nBOVnGS0a1Minb4ePg9H+1yo8wnlhk1MLe8ias9e72NDgUubkYwh9hN4wGZXw9kMWg43Edy8mBFOfq1cunAI9IEkyCxOiejW9+syrDu0CgYJvyOM8DpSYOdI159nUFXOI9t/QMgE2KMrtRRNQn4garA7fBIMIKYWTfjPlO6H03ig==
Received: from BN9PR03CA0299.namprd03.prod.outlook.com (2603:10b6:408:f5::34)
 by CH2PR12MB3815.namprd12.prod.outlook.com (2603:10b6:610:2e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 17:06:57 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::7e) by BN9PR03CA0299.outlook.office365.com
 (2603:10b6:408:f5::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27 via Frontend
 Transport; Thu, 5 May 2022 17:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 17:06:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 5 May 2022 17:06:56 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 10:06:55 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 5 May 2022 10:06:52 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>, Thierry Reding <treding@nvidia.com>
Subject: [Patch v4 3/9] dt-bindings: arm: tegra: Add NVIDIA Tegra194 axi2apb binding
Date:   Thu, 5 May 2022 22:36:31 +0530
Message-ID: <20220505170637.26538-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220505170637.26538-1-sumitg@nvidia.com>
References: <20220505170637.26538-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12fb3ef6-f7ad-4b53-6d8e-08da2eb9a956
X-MS-TrafficTypeDiagnostic: CH2PR12MB3815:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB38153E153797320B92ABCB71B9C29@CH2PR12MB3815.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gCzZsr0ZzprnUvftPBjLX64OW9nvSU9PXo57vek/Ok1+A8JMStoOLCTLhlnIXYK/c3L/4HRANNXUMWVQbOvUaLRKocXTN1YpqXAVIk8R5m1wm8fZVgvEk0v1ti11uH6x2drhVuRPjy7lnxxflwKbwbiKFWbpxCVAvUNxe0GM3p/G2VKdxj1l1KoUSTAT6gKqlUubeLH9hP8t2ZuR9Itw/hq7lgPjo2TS6sq75+lBb5xOHUo1JcEI2Dcl/RuGQZd4oEVcIBj6PZPKJmQvq27dz1fBVZSOv7OkqSAGT4LS/xz9I3oXcvSH67ESewx+x9OBsi3s2NPU39SfdmEw6tVQHfPDZ574dfh1r9Gv3FqpJozcbAQwFwNbbBKrT9+iT2JGLTBINf17jVP7LoGrd85T/5JDv2Mzc7jv5cmyuuGNAQgnZVpS1sQmZJuUamWA72q8P5kOyDfhdng6ohjQ3MEL3D5SOGmYVQgxOsFhfzezcFEGJ19q+p72XL0a3u3GG24efkQy4ufhgcsXjTgyQDVL+mBaURxGaWoxtB/6u/Lrzp5JvppPxD6jIjfvUo2X14RPWYJGrEfJ/XXke3xqMXwT4Ke7sTjQN3GQ3012wk+hr3QLBByczOOtw0fOcRM2Y97sv7bL9mYYtO9zyg14Vskriz57WkA8kD9TFuqSODKEnKCw0xCLsbgT31RKumwBnCIEHLvmuKnWm4jkJJ6ThRrU9NVPliyw/ityIYWTUrC90lFN0k9HRnb14dvpnQmsLVj08z3oHTTHXcUyXPJtB+lImLLmkVdTVFw6mK7Nn3f4bb+EC94InD3GQRQkAUm1XNTmrhtei2CvC65ZRFelTeuMIQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(426003)(2616005)(107886003)(1076003)(186003)(7696005)(8936002)(26005)(336012)(47076005)(6666004)(81166007)(356005)(86362001)(40460700003)(36860700001)(54906003)(82310400005)(110136005)(5660300002)(508600001)(316002)(2906002)(8676002)(4326008)(70206006)(70586007)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 17:06:56.9468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fb3ef6-f7ad-4b53-6d8e-08da2eb9a956
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3815
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding documentation to represent the axi2apb bridges
used by Control Backbone (CBB) 1.0 in Tegra194 SOC. All errors for APB
slaves are reported as slave error because APB bas single bit to report
error. So, CBB driver needs to further check error status registers of
all the axi2apb bridges to find error type.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 .../arm/tegra/nvidia,tegra194-axi2apb.yaml    | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
new file mode 100644
index 000000000000..788a13f8aa93
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra194-axi2apb.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NVIDIA Tegra194 AXI2APB bridge
+
+maintainers:
+  - Sumit Gupta <sumitg@nvidia.com>
+
+properties:
+  $nodename:
+    pattern: "^axi2apb@([0-9a-f]+)$"
+
+  compatible:
+    enum:
+      - nvidia,tegra194-axi2apb
+
+  reg:
+    maxItems: 6
+    description: Physical base address and length of registers for all bridges
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    axi2apb: axi2apb@2390000 {
+      compatible = "nvidia,tegra194-axi2apb";
+      reg = <0x02390000 0x1000>,
+            <0x023a0000 0x1000>,
+            <0x023b0000 0x1000>,
+            <0x023c0000 0x1000>,
+            <0x023d0000 0x1000>,
+            <0x023e0000 0x1000>;
+    };
-- 
2.17.1

