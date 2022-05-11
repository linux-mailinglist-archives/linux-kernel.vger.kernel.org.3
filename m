Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB27523EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347648AbiEKURw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347660AbiEKURr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:17:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80E56E8E0;
        Wed, 11 May 2022 13:17:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GF1s69u3lENknxNrc8BMuzFVwsI3h4pTzcu1A2sMqOOqni/RUvK70U3WV/uZw/nxnmJABz7acX/1kFIyNiK2yPUqI936gOlce0D0+SOS/pck7LByxBDQw9jY8B81kj3K1YnAEZh6MwL6acDEkoFOFWogrFFqb08nRdv1Fh2Xlx7KP9w+DesYgszcOPFMmawuIAVAa42u5RJmKQp4lnXiJLNtAgMEURfYfKvEbIgJVT1Foiqf0n7+oxTfDuuhmpVEJxCXbNJ5vuv621Bb3Sb/Qf144ztfa+g7cubh6nL8buDsGEo7u6H+e2uF036gAct/dXzrvr8X6yyHq8UUzU8zyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRt9K1Pqvch9Wb1zNz6KYCXj/EVOrzzMDWp2bnfIRdE=;
 b=cYGplDtt2h3B5I08Dt8IXgrLXGiZAIrZcnNFUJI9dA4N1NHg+4LX//KdWxWoWnmXUDt7RgyD3/ivCosKyC79dLZO8qXvr4wJKVWojEBIfJTBLIJRwvB34qxnyPNRV5nVMZPbW/KzeO2O43AFtnfECF/9X3dQzf/j5eoId2azE4P07FnMR1KZHKT3PnQsfonFGm2BHgFuiz0tN8QQ89bZ78oVmdEKT6ivpMEGHMB0/dkEY1usJc2k/WHQLkJRHgfe6w6Fm8w+SROoS+AewSKRA3gPY1+J+qL+BSeJVsZZY8Ra5NzwYHh9MUzmIz92bW0Y2D2E0xP8rA6EF/UGICeCwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRt9K1Pqvch9Wb1zNz6KYCXj/EVOrzzMDWp2bnfIRdE=;
 b=L+2J1tMi1Sd3jyT8IKSimGuHa2w0Ffv7maspMoXCGSlNHdYUV5bavyh/h49VX2HfrzkV6yiH8AV0Kwdmm2b1zUub8c7YsbfQI2QfjLLuNIV/Iv+25O8FTHZsYanSM+a80dKTKdgxonZdXa14OjTv+Jc2c5ASUQeO0ehDV6uPxPtS87qrBhkPvYuJYxWRA3vDC43/sCHA394Gul5DtJExxr07iL5plj+T/InTK6Ob/n2VZB5YZ8Qmj3c/JfaPlkA8UfJ19SFRdDZjvRY0ov3uhg6IiwaivvyTih2xyWUcainV1csnqRMsYedSK5kgwpE15OCX6PvpUzAOHsYKSnGi8A==
Received: from MW4PR03CA0012.namprd03.prod.outlook.com (2603:10b6:303:8f::17)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 20:17:41 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::2b) by MW4PR03CA0012.outlook.office365.com
 (2603:10b6:303:8f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Wed, 11 May 2022 20:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 20:17:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Wed, 11 May 2022 20:17:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 13:17:39 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 11 May 2022 13:17:36 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>, Thierry Reding <treding@nvidia.com>
Subject: [Patch v6 3/9] dt-bindings: arm: tegra: Add NVIDIA Tegra194 axi2apb binding
Date:   Thu, 12 May 2022 01:46:45 +0530
Message-ID: <20220511201651.30695-5-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220511201651.30695-1-sumitg@nvidia.com>
References: <20220511201651.30695-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d195d46a-ed08-4b7b-e020-08da338b4cd8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4566:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB45660102AB60932578E71455B9C89@MN2PR12MB4566.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sXAb+6ayUhrXqLs60wP5lP+JpaOdp/e3eWj71fxn75tOYI+UHyyi+snEqcfE+SIGQCFwmufHi/e9bANVhQPf93l7qF0HvcIzgQy3OO/efAA85dIZNLfZEVyh7uB2tEEIs4CNBzg4kS7UtDjWOMrJ+h538OGkw3V9u4AmlcH3vazK+TjHDF826d63TzL/PPTzojFAOgVI76tz92vYCrMOAn00P9LwAfxjzdorSLFktMBuiyxNNL/WoVHLoRjliD6Cg3XN0AmvqlO5Ljr1sBRYm56dndjKfLhqOqTH6+rwactQeLvzJkQWuDvMFUXCn/3vn11hbAlt2AMf+PQTaXKfO73RHTVLuZEcgJzt+RnMTGzTjZYJeEgUJpKLLw/p7EyEswF/AgiL54XBC5oReiUdXcwlx25SYQt/nOeMNN+ieeioGQUwCbk3EfuxyNAsljM3Pt4WIbtC1ixCCTfXmN+q6hvanmoQCNUSudsOD44KLZ/J7jhoSdKJPsSKtv1UYmR4YbV3ci5fxe7AxQkC+CUqLpCx8IR/dJUjcsd0mPrIdETosKToa+KTSg/kDWzxm8T/VntG+mFIXRAymuGG0J+vrwj5LpGRo/s+aWK4ZaQwxP17XGQbG+bBopKi6EtPg9g7J5ZWChHjuVJe/GmSo5zkNituP+mMzRJgNpyBvkvZbkelv7l3I1jvCMXHZiga+JR3pII9wG1Hx5j/KRSjzoA7yIYqbhJERhxBUkTDOU7NhraoJYQWLNL8T9jkpyy/grwC+0b6abkUrUNQqMDcuutUq8jFTNKc5T8zVD1w+wkmomBnnUg0GCbI80zHWglOfae1FK0jL11XlAdqO10LjDyxLg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(8936002)(508600001)(54906003)(316002)(36756003)(36860700001)(70586007)(110136005)(40460700003)(70206006)(86362001)(4326008)(8676002)(81166007)(6666004)(356005)(2906002)(336012)(426003)(82310400005)(47076005)(107886003)(26005)(2616005)(186003)(7696005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 20:17:40.7380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d195d46a-ed08-4b7b-e020-08da338b4cd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

