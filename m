Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08996523EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347707AbiEKUTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347709AbiEKUSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:18:46 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D20C6D4D5;
        Wed, 11 May 2022 13:18:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qh/TcG85ZMrkKY2jaCKuyAQK3NCkYSgYBhZc8rLSVoU1EwANsxDEP8Sjjr3EyNSPcjl0tzbphz9R0P3OXuna54eDUYTiAVbOF8UEeKTF9LE5TZ50FlYFa8uUwUox/5MRIN7/FjEYeVn25wkFUVWWhOrIsyDMMOP7KR7Uou0ep6pUM2Y8sI1h8e24KPbhitWwlLJ6s9jY31CeMPtbj+VC/LFPFvLNfNiHeT4KMeglLebDRWtKnaKh/JzQOPNhGZStxt88KBwrePw/NMRwzWIR2Gpnb2PEHmcWOPfss/v57dEK66AxI8A/f+IdqLbJ0jJ4mlkG+qeM3t3I9qRXSJo6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qKwtvhieY0KcWMSvpqLpwBMndYeB2YgTP3vZk+1ppY=;
 b=fA9zXSVxLNVh5tX4qH5qftn8qRy5bqqh8iCg93pyJa5VBRTqEe/pUG8BSZvQaqZnIIFL+4mXOaQe/5HjCcR/dH0qSrAuoy/To1xT0pHt3aD3438EuSQfxYIBj6RVEcd+1jIdqer5Ie0FU/8LXttfBLmvUXBFhIcVRl3XhoPBCZ3vBgTuuunOpiKUCQIEqJyo5hdJnHWML52OD36CA4gLI4rAT3vKUL0+251b0nsFECrnq2kIAFNnYv+P4Kvz71USasBak3ZxwVSnN46gxNk0QSQ/dyBb4t6DlcvjfoSUscx0vQhWNBz0euS/kkGdhIoub/mb5vAMg9AhlhHYX8d0vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qKwtvhieY0KcWMSvpqLpwBMndYeB2YgTP3vZk+1ppY=;
 b=MVkVcs+CeC8X5cfUMXIjwsZExscPiZ6GnQkUOyXaFggoRmzHZ1ar74dYKQwoNull9MiOJs7gCK8wZzwrYXzp9dU9hWkR6huqhAtYyyvO0RoJ85azvr2dtJRs5ZCGECmNOzhtW4DNqo0mua12+tCNrlUO9FQ5Eli8Tk0rjJP8Mo+57VpaQ5p/Mx0qjIdIs0xpslxmGlffEAsZ4tsRSr5O4AuV6DkoHMktW2naPz+ZyH3rd8x06q9oaHLd7vPfFAfVMTW0NNijgPxVJgtx2ywq7Ekhfh7xiqSXz1QhtOQu7Zh9E4H7xZGNCWFkTkvGWGwEPuqMPBYr9gzEbg+wU8yMvQ==
Received: from BN8PR16CA0009.namprd16.prod.outlook.com (2603:10b6:408:4c::22)
 by BYAPR12MB5703.namprd12.prod.outlook.com (2603:10b6:a03:a5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 20:18:31 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::1d) by BN8PR16CA0009.outlook.office365.com
 (2603:10b6:408:4c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Wed, 11 May 2022 20:18:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 20:18:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Wed, 11 May 2022 20:18:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 13:18:29 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 11 May 2022 13:18:26 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v6 6/9] dt-bindings: arm: tegra: Add NVIDIA Tegra234 CBB2.0 binding
Date:   Thu, 12 May 2022 01:46:48 +0530
Message-ID: <20220511201651.30695-8-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220511201651.30695-1-sumitg@nvidia.com>
References: <20220511201651.30695-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a95bbbd4-bb6e-43eb-c162-08da338b6a73
X-MS-TrafficTypeDiagnostic: BYAPR12MB5703:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB57032EA693D423017C974A1DB9C89@BYAPR12MB5703.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OYUJNHayVcBFTfhdHbzTpMfnIoAuMKAcKcCvDvi07HUJMuvAy8vVsaogXMGKA/OVOYRQuRDr6kyq6Mj8VzPiJ6IrtpMd47e5uIC3CzwLds0G5QDIQ0YFJ+Y2w7A3/FVxdFLLFVyzns63FzbDf2aId73Ls7NhYXu9t3PEhKCF27b4sRbuiyHFELyDOF3AjfL0j0Zanv/rAUa8QFShROJJOBYSnXNLpaaQ/9ocvO3oOp7zSKsnKojHmF9PLnCdGUTQWXT96m1qQ79xhqQ47OI+r6omvjsQBBTVW4QPFiq6Fl1ccDLmGuCfSM9ddWEv1YtAOXCXrhpmcHS7kMoa0WzJcm+wQNNBdGRz3OfDCVNyUvjM9TSuPLij+YEyl1iPNp7pJBkz/z9w85J+yJmP1BleZwtPYKFesr/SA4Di1kY/2LrSa5P3rrUGRJv6MOxoxE8jnu0pAseqIhWePPSucrjiHNqiee9RLFEWpZedjajnn7MNPSSpU0PYR3qaLsytsByfsunDROnX7pOkB+mlgWyfdTkoA4ipUs9xJ3839+fsPbybc2F1+jdmd7mjZ9SEpe91Op1NC5tHl56kpnWQ8pF2nI7rMFEJCTm0OfAse1ufJD6x117zyELn8c33Ekf3+2MDIiHOU8VktvUe27+fa1G/x/1gkFpgOimtVov7tbh4ZmxUxlksWYgpwn/rMtPmqGg8xORaYWgns43153weG4rH/xtcA8HdYLnIlwksFXitXNg4DYhz9dr/L65hKIPfn9ZWx/t5M5PWfABtWS8uqJBDNpwuUIi0QGcTtTjrvIjomtX67hYODelZB3vBE0dP+l6K64sTwMpWKkMLK882rk/nMg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(82310400005)(26005)(36756003)(2906002)(6666004)(8676002)(47076005)(8936002)(508600001)(70206006)(356005)(81166007)(426003)(86362001)(186003)(40460700003)(1076003)(4326008)(336012)(110136005)(54906003)(7696005)(83380400001)(107886003)(5660300002)(2616005)(316002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 20:18:30.4069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a95bbbd4-bb6e-43eb-c162-08da338b6a73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB5703
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

Add device-tree binding documentation to represent
the Control Backbone (CBB) version 2.0 used in T234 SoC.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../arm/tegra/nvidia,tegra234-cbb.yaml        | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
new file mode 100644
index 000000000000..7b1fe50ffbe0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra234-cbb.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NVIDIA Tegra CBB 2.0 bindings
+
+maintainers:
+  - Sumit Gupta <sumitg@nvidia.com>
+
+description: |+
+  The Control Backbone (CBB) is comprised of the physical path from an
+  initiator to a target's register configuration space. CBB 2.0 consists
+  of multiple sub-blocks connected to each other to create a topology.
+  The Tegra234 SoC has different fabrics based on CBB 2.0 architecture
+  which include cluster fabrics BPMP, AON, PSC, SCE, RCE, DCE, FSI and
+  "CBB central fabric".
+
+  In CBB 2.0, each initiator which can issue transactions connects to a
+  Root Master Node (MN) before it connects to any other element of the
+  fabric. Each Root MN contains a Error Monitor (EM) which detects and
+  logs error. Interrupts from various EM blocks are collated by Error
+  Notifier (EN) which is per fabric and presents a single interrupt from
+  fabric to the SoC interrupt controller.
+
+  The driver handles errors from CBB due to illegal register accesses
+  and prints debug information about failed transaction on receiving
+  the interrupt from EN. Debug information includes Error Code, Error
+  Description, MasterID, Fabric, SlaveID, Address, Cache, Protection,
+  Security Group etc on receiving error notification.
+
+  If the Error Response Disable (ERD) is set/enabled for an initiator,
+  then SError or Data abort exception error response is masked and an
+  interrupt is used for reporting errors due to illegal accesses from
+  that initiator. The value returned on read failures is '0xFFFFFFFF'
+  for compatibility with PCIE.
+
+properties:
+  $nodename:
+    pattern: "^[a-z]+-fabric@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - nvidia,tegra234-aon-fabric
+      - nvidia,tegra234-bpmp-fabric
+      - nvidia,tegra234-cbb-fabric
+      - nvidia,tegra234-dce-fabric
+      - nvidia,tegra234-rce-fabric
+      - nvidia,tegra234-sce-fabric
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: secure interrupt from error notifier
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    cbb-fabric@1300000 {
+      compatible = "nvidia,tegra234-cbb-fabric";
+      reg = <0x13a00000 0x400000>;
+      interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+    };
-- 
2.17.1

