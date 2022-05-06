Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188F451D654
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 13:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391225AbiEFLQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 07:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391194AbiEFLQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 07:16:27 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAFD57163;
        Fri,  6 May 2022 04:12:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iv5W4dcHGboEyRFbsBkZsvlmT69i5zbeNUE31p6gttQvo4y7vUaqJ3FUn4XvEGQ0rvBNDc9nbO0M1Wpk7z1mUBUE7ELDbeT08OBkaG1U8vR572hEwoMEv3VA8QluEdr6jj2JcaDNScKP8GCIik1bj6UPU3lF4EwJoLve9KB4PcALadWlKwseI/jLTcgzzONJVGwi4ETwpcscb95LaiJRcb9OGd7JzveqzUe78twQSVnntsnWjjwZT7vKCkStd1WilXvlW2rDM/BeVhBRbEtjsiUmewmYRG7x8w7tNLDkR6WIwYu4LfelziErE1rQB8vfgoekaXQzX0P/ZEPj0Z2b/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJ+HB3gi2gpKQe8AtlogFINAov3Xcti/g37uMrBFLok=;
 b=bP9oGFAeWyCwWi/R9knmXo+oxijqnxtfSHPshXokcd/EBZ/5P5ch4ym/WY7UY0nvDv0qiSgp7TA7VixU8Ytmxb+1yTF1nA4UuwKa3dEP+M7HD3pu1eS/fEHjGAJK4OsbcaK84rB3+kDmyXpsIcsJAEXHz88fRWQpIuh6+YMkjstA3v82vKHlr1YRixKuuoBJhy+s02k6nYwPNGrzuy68vGn1EtSbMUEg9WAMXvhidfQqrFZUuZsFEGah8CqNU9lcpBxfoJPZDvd0gU+1ufFrbVX8sYhFgbp59VuVfCSOWxLAIMLLPGTJhMclZcB0MAeJtRsN+K4XPrTW5njsDYAXtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJ+HB3gi2gpKQe8AtlogFINAov3Xcti/g37uMrBFLok=;
 b=OZ/RFuE2xe5WFfYea4ROx23YesW/0xG0lG59FfwzU5hCKDllL326X2hhc8nCC/AmXGxjxcj6al0MI03WCbDaaGiBm1NRcuHbotHjTt9Jhs3aJjmvUph2Yyqxn4ZOZ+YTOiI/7VstMy4mn5xZ3mPZMeNF2zYJxalbW+FcJcaUdWKWS7Gu5bupT0wDN96cL7Y253CWaog0z7/QdMI8PzhZfjH57Rzsxkaq5XgAe9PHejJSur8qkYHirK5RcH7Gbh3nannv6HEE2TtIXiKcx4wCJmF2flRrGAAoIMCB0QhX9Jb11oSgx9euMwHlfhyHX1gMuzqqIEYvTo1VYpB9u7j0xg==
Received: from BN9PR03CA0849.namprd03.prod.outlook.com (2603:10b6:408:13d::14)
 by MWHPR1201MB0158.namprd12.prod.outlook.com (2603:10b6:301:56::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Fri, 6 May
 2022 11:12:42 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::74) by BN9PR03CA0849.outlook.office365.com
 (2603:10b6:408:13d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Fri, 6 May 2022 11:12:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 11:12:41 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Fri, 6 May 2022 11:12:40 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 6 May 2022 04:12:39 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 6 May 2022 04:12:36 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>, Thierry Reding <treding@nvidia.com>
Subject: [Patch v5 3/9] dt-bindings: arm: tegra: Add NVIDIA Tegra194 axi2apb binding
Date:   Fri, 6 May 2022 16:42:11 +0530
Message-ID: <20220506111217.8833-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220506111217.8833-1-sumitg@nvidia.com>
References: <20220506111217.8833-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5409d04b-2817-476d-39c9-08da2f515688
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0158:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB015806F293B6600FBA75C71BB9C59@MWHPR1201MB0158.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GNI5PjJVydS0vJHMod94X4eV2Bhtnpzyt4v9k1n8zXG91PPQhS/0IyBQ7uknNaEgLQbaOEBL7SRuHf+L3eiwgl0MKXvT0J54FrLImpDJsaCu/OxjdcdWzlZvFuz+215p7z/h6nYaDnKiRRJANYOLTL3C05Gqe53KdU0Ccat17LjGx24XWqpXh68jf5pE1Dr61WEJzNXiuO+eWiVoUfVXKsieMxfjgiF9YXYWBon4//Ol8X4WJX3pc/ZrLR+ovbywcYdK26uip3lnj2ZWLG5VGXXYLi49FKUnuGL46J874MPKxm17Gq2j/HAy461z4e8WkAz+wSZZo7W5x+2c1RL0E2KhrwcCv+JkE9zv/VTumCtISrE6l29QPoeyFQg7oVj68VOyvArZ2F5doQp5TD/O9MBXQBt8rZ9yuB/l0ZvkmG2HEtWxLXaBuxGHUVwHKsNJHPvEtS83GssaAIjSILGrMBieXs+Z00LOg9tgxbVPuv9CDxU8/ti5nDQygZmipFIVdmhtAdM1LDHwdPZHJgmnEMjtDRlKNVckZwMiX9QomBeQqy/em1MA3Buz6jTdS+mwe6vQdeACmVXUY1eAbFfSeqr81azD63KfoqtG0KvPtbO97aGOI/Dty63hqfKeUVRsq8ZyUra0jlRQvHCFdyDySgLJ+WbIZXQDPC/KgUHlegdFMmurCg8Yzo3LleO3hNHVaD+jsEQwFjl3QQswadabQXXmUdw3Pg1i8HemBgqYtVFL7t4Mnbt7rOgS6Nt31sjhpamwetUwCBggdmoiEzeFlE6C97EmGr0mxmTnJGZbfIJiRDP4KxwLbXGaQisA63IQdBfpMK8vqELTIlCTvbmeLQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(54906003)(86362001)(107886003)(2906002)(81166007)(4326008)(70206006)(8676002)(70586007)(316002)(36860700001)(508600001)(356005)(40460700003)(336012)(82310400005)(36756003)(26005)(5660300002)(186003)(7696005)(426003)(47076005)(2616005)(6666004)(1076003)(8936002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 11:12:41.5252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5409d04b-2817-476d-39c9-08da2f515688
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0158
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

