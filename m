Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5BF51C5CF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382621AbiEERLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382505AbiEERKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:10:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1EC167D8;
        Thu,  5 May 2022 10:07:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBSaj+HmCxHDFd8KjeYov0T8d7GMg5sNaTviU5e+3JHHealXU0h52a2ZpL8seRPjs6dNjCD7uNmpv1ShTmFxGSXifStKBzKUy4Wh65nwvVK0nRxAjoBybP6v6icHygswwWqkz8GH2y31L27bR7Ms0cNVIxzyYQYSXTkRo2UpqYWXEG7o/Vo/aZgQxT8cF84CMmQqTrpDDSQyJ3lAVPhOZJL5Gz8b1WphJmffCl8fcPiJmVLSTv8IBJBbIQCFGe6C6cW8eY0GJFRg01ZWkrutWJ3IkqX0WK8E/iZl5/M/vR3ZPBS0I0UxZwOL/E3+9608vxual+sf0UFQUss4Pgc1qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAwJwAK226raxGh5NoBwO9QVUpnql59xp5WX7VgSuHc=;
 b=RxQWoFH+aRQntZlNIlRp8tu1rEXoJ3y1bzYkgkV+UxJ3q35OZWMYr4OGmOji/XHeIyO4t7yaBOvDgJiFbVxjkiBy6GO/GZgzjZUb/XEodrMdzyIYygUbRJDWaKtUdtoJftZYPvqCWVU+Z+YPVOod5mV41NKekkw3XR4Zr2LeLW+5BGwYyUbEIl79NLFDwYTeoxgw6W7nxoy/wZGxaaeAsRCl16DzY2ChU+1Rc1a/67CtAWmosrHz6RUrmVu0QMHaMZI9Ch6Cj+VqXgBqUhvdGyNd28Jy6uJE/MYJMXmXCWwTqYYxhjmgiLiia/V9yH1MwAHJo6StyJh3eI6foPgHqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAwJwAK226raxGh5NoBwO9QVUpnql59xp5WX7VgSuHc=;
 b=A52p3K5zHZ7aHDpUYeiu055NqqNKDXzJxucRayX8L/WPF6AL87FsZETUxPKSugYoVjfJRQPpSlGrIPS+n3qEmAQgRmkDrkj5qRhi10+aLGjsybPbxA3tL4RkqBY+RQxXgFgNZG7dZxMdSUXP5iel/ZxSFVXbN6ZmFkwVxOM2YhZf5fE+bkokTEGqckoZ3442nXc70OZbJzcoP032eMSbLkspNyQA8DhuploZ5GlHMsT1mZqlCZ7SxIY1s5KrygDtNsS5Nz+6Ivkv3d83+/57n/olik971rrjCrEnfXcHZRmqLNoAEXC+9hNFkoFC8yQg6rGCePRQ/qqXEI+s9AGhVA==
Received: from DS7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::15) by
 BY5PR12MB3923.namprd12.prod.outlook.com (2603:10b6:a03:194::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 17:07:12 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::f5) by DS7P222CA0012.outlook.office365.com
 (2603:10b6:8:2e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Thu, 5 May 2022 17:07:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 17:07:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 5 May 2022 17:07:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 10:07:05 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 5 May 2022 10:07:03 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v4 6/9] dt-bindings: arm: tegra: Add NVIDIA Tegra234 CBB2.0 binding
Date:   Thu, 5 May 2022 22:36:34 +0530
Message-ID: <20220505170637.26538-7-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220505170637.26538-1-sumitg@nvidia.com>
References: <20220505170637.26538-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f0a9f9b-5ba8-42ed-ad3c-08da2eb9b15e
X-MS-TrafficTypeDiagnostic: BY5PR12MB3923:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB392317550FFA4845B4787DE9B9C29@BY5PR12MB3923.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBh6EgMm7k1PxWf36Lvoq9k5JfAPhVqp7IM+3DVUt4Vg8RL83Ya1R6SbHGBpLRFRu0GcZnLlHmwi3bnPZ8NkMRji9oCRNNGHqDqdp2Lns0QDZEgpzJjz8lh+waKVxEG3mfioxgs3UBYbPiNb9/89nvU0y69Twz8LVu7xmMmKX7DdY7qDDHB2r1+lT02cHG674v4xhdW7m57lF7tHAKi65xiqdcdNHjTzAqzUKBDcEL+HShfphW0auAkaTXFybVT529S176SQXkM/rWyLCd9V/2gx371O1UOzpaINsQYd7eVDOupwJf/HPUwj488Laj2s8tkQISyWEzNGXqRT5G3jBlJuO3pdcMYplYdsJcjSo1ZCI95Krru4SZqFHZ5wYMt48OBi0EdYtYGe0monhkZBKFuhZwXw7KSpKGgIIzO2jwIOUolGLer8ZzP44EYb1QsCNiUAjGAG5C2wnaZxGu4it59snHxkID1gw6dDSueKvn0vE5RDdq8ehXdjiw1LdF8v0wwAEC5lgMF+PQpUAAV2a0ewRzNiVgH0XH1fI+dSzT2Ns4MazCE27FP6w6N9cpren1PaZosNi4+ARoj8aPAygW0gOKb4wDYzTPfjM7xchazBTtSKhMKmYqPHWhhmcYgSZWHAtYT/a2GXxUhmeG1xQvpMgOvjKmV2Mf8eXsnzXHswugAHMpBRPiLgDhK5FmDLF82F+PuTCNKtO2ReCoGLmy8fRe3dfu6Gqwu5LWsvkmP/4xU/07N5joboNT0qKJHjED4f/PS9Q1q/VE7UFe3ho4+8SJ2QfWuzeGhZ3zdSJyMuWZOSq3P/9M5kQHJPyyGwh7DvxEOi2z9BLUbTw04BRA==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2616005)(70586007)(47076005)(356005)(4326008)(81166007)(70206006)(8676002)(110136005)(5660300002)(316002)(54906003)(508600001)(336012)(6666004)(40460700003)(426003)(8936002)(7696005)(2906002)(83380400001)(36860700001)(82310400005)(107886003)(36756003)(1076003)(26005)(186003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 17:07:10.4696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0a9f9b-5ba8-42ed-ad3c-08da2eb9b15e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3923
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding documentation to represent CBB2.0 (Control
Backbone) error handling driver. The driver prints debug information
about failed transaction on receiving interrupt from CBB2.0.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../arm/tegra/nvidia,tegra234-cbb.yaml        | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
new file mode 100644
index 000000000000..fa4383be19d8
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra234-cbb.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NVIDIA Tegra CBB 2.0 Error handling driver device tree bindings
+
+maintainers:
+  - Sumit Gupta <sumitg@nvidia.com>
+
+description: |+
+  The Control Backbone (CBB) is comprised of the physical path from an initiator to a target's
+  register configuration space. CBB 2.0 consists of multiple sub-blocks connected to each other
+  to create a topology. The Tegra234 SoC has different fabrics based on CBB2.0 architecture which
+  include cluster fabrics BPMP, AON, PSC, SCE, RCE, DCE, FSI and "CBB central fabric".
+
+  In CBB 2.0, each initiator which can issue transactions connects to a Root Master Node (MN)
+  before it connects to any other element of the fabric. Each Root MN contains a Error Monitor
+  (EM) which detects and logs error. Interrupts from various EM blocks are collated by Error
+  Notifier (EN) which is per fabric and presents a single interrupt from fabric to the SoC
+  interrupt controller.
+
+  The driver handles errors from CBB due to illegal register accesses and prints debug information
+  about failed transaction on receiving the interrupt from EN. Debug information includes Error
+  Code, Error Description, MasterID, Fabric, SlaveID, Address, Cache, Protection, Security Group
+  etc on receiving error notification.
+
+  If the Error Response Disable (ERD) is set/enabled for an initiator, then SError or Data abort
+  exception error response is masked and an interrupt is used for reporting errors due to illegal
+  accesses from that initiator. The value returned on read failures is '0xFFFFFFFF' for
+  compatibility with PCIE.
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
+additionalProperties: true
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
+      status = "okay";
+    };
-- 
2.17.1

