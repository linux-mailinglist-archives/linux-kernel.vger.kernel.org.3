Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E8C51C5B8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 19:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382409AbiEERKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 13:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382367AbiEERKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 13:10:35 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2054.outbound.protection.outlook.com [40.107.212.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D69E58E4C;
        Thu,  5 May 2022 10:06:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/D131k4jVkWsUPW5Mdy+GioqS2G9leJpZn8a7YCvsD/TyWdGPNd3oPOLj1aBoYnwHif2h9LDKv1oorzS8+2Z+JzGO/d+7l2R+yiJWiYVlwKwNXlW+pE8CtCZTnK7UEjlGCDPPJjLsqI1GEO5iFnJwzs+9PG/RiX3gzVfjjdcMeuzI+QJphbwpjAwIQlc7vBHQUrEUjnkGIfNmFBxnnOLLZl2py0TuaH0JLEYPSbyBqe5eQeHTFYqzSh/BQAzYEQhQttuYKMokC0JNGUgUlVr6X6GBM/zRqQiN+ok8Paco9aQD5CulHSpfFP7CNXgBQQspuqm0+iiUF7JsBBy8iMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2KBrdKJnqi/sr5Z9lw2Jj4KvhINWL7vuMhcbWuIfos=;
 b=E80d74BvL7Xy4iO5JHwYwrDkvwbAd0ApyELPA2KapUtNgr1LOSLt2vqWjDdY33pPVcuYd85DSSuKOax3XMAcs+dR74ZI5XGdabZ4miDTQT00duklnIuizrAexqOXFCNiGDaSC6EauRR8SBcCK3IVSuKmiayMxsxUnVnI5IOKgAe3iQqDLHjyU7plXpji6Nf+3az02GuE2t9dcwNV8aXRd3fMtXgi+eesBFVddSX4U0OIjD2jwBazSvpkl3DDwNg1RG3xiHeHT7FSEw7qV5yayF1GjSfy/e+vQnEZnnqIq3snnDeAlBziRI0UupFn7EjUjVjmP9SXioBRtcZ59AlSZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2KBrdKJnqi/sr5Z9lw2Jj4KvhINWL7vuMhcbWuIfos=;
 b=qKdFgOjnbSnr8n1Cjeh+Zf46C4x6GZm5PY7xGxp44v5n4OMcRLQojIik3nEZVHHuBRStJ5xqnohrb9vWH8E5FvIG2B89Vz+Bu+AdD6VBxCE2nyvB4fvqJxna9z8KEfOyMAu+mUl0ZThiqxrGSiSmLnmNeQ9e9sbSqHFSzS9pfFHioqUggsYHleMvNIOVvpfLK140sp1Rp2f9gpC/fEfX8rTZDCaOFQ9z0CVxQEKnxOg2sVB4sfKX7BiICeIxAhTR9zbA3bI4kwXv53vDTTy0mJS3hL51KK6y3dGg9BV4WINRpoQLBv+LCyX3fblyTkM6lI2vAa4Yva1uehYYw9WbZg==
Received: from DS7PR03CA0015.namprd03.prod.outlook.com (2603:10b6:5:3b8::20)
 by MWHPR1201MB0047.namprd12.prod.outlook.com (2603:10b6:301:54::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 5 May
 2022 17:06:53 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::cf) by DS7PR03CA0015.outlook.office365.com
 (2603:10b6:5:3b8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Thu, 5 May 2022 17:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 17:06:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 5 May 2022 17:06:52 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 10:06:52 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 5 May 2022 10:06:49 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v4 2/9] dt-bindings: arm: tegra: Add NVIDIA Tegra194 CBB1.0 binding
Date:   Thu, 5 May 2022 22:36:30 +0530
Message-ID: <20220505170637.26538-3-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220505170637.26538-1-sumitg@nvidia.com>
References: <20220505170637.26538-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66576b40-318c-4603-5662-08da2eb9a716
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0047:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB004794739BF40A0BDECC0F50B9C29@MWHPR1201MB0047.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: stMwq0wWoFRINhkNzXhDSpBXVvdqzT84HwD2XEE8s/2srrH5Bwek9NrDEQCJjL2/dEIEGoVBJ3Mbf7kA1R6NsujgW4o50Anaj5fBdTrjhY7cvEB47zFQfTuuU0AdNyYWPTDFZeLnToBE2EYa+oToC8QIvXpKoXQkdgmc5zrNSaZpiI5rsVGRylFJ9BW3Kl9urr4wzODtA2TTT8EqndjbYIucY7ktM00wPnOxWEX8CvONQKSeNutEpVIySYbXZ3VNztZRR6Cu8EYPDWyd2wU0iRIiHz+tl3CeKWNtrLtW0TASu5kHyNSr2CbRgZVY7GlukjwQGLUPltIuOkDrJ1AWWJiY/XwvZqWNc6BHUTOU0d1E2WCJAfUbtV4DcAdGck02y9M6F7ynCUvCrL5D7dvGUmXBOIVgQJRDQ+HYnmOEuf35qZnQwQGmWFgzr7HOY5hu58jrigzqQAfhTrNMPL8anNxXfxG3TWxtig9wpTy8cTomLHCI4MBUzNFzRpPPauIhP6bTZL3ejjpbLi1aoyvy3fEiRp+k9MeAc4unWuEMm2Nn/P3pxgXXcCsJdbGTATg/MV9xPT9JjcFbRU8GxXIE4JwHEmC5NV+VpIXxGxFOojmMVFTzb2QHAaP8eR5tbBjdduzoWCXc9PNg7r0yezldexY9sxlf/jliFoDPW7smLBd5JgzlqBcp51GW4poX+moDdJh73FKt+L3BZ1jRfNAn4X+zEBGKCy7pvtoT60C2F5Qb5hO3oQozRS+/3V4I/JQP00ETqO3/cHQXopteJMK3oN+7WMxSqGuCl7eEHGBZdmHQPU/WslS7B2eSvvC88HK2awhvrgI3Wh0BGqPsZ0+lSQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(81166007)(107886003)(2616005)(83380400001)(36860700001)(26005)(2906002)(82310400005)(36756003)(8936002)(5660300002)(508600001)(110136005)(70206006)(4326008)(7696005)(8676002)(70586007)(86362001)(356005)(6666004)(426003)(336012)(40460700003)(186003)(47076005)(1076003)(54906003)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 17:06:53.2339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66576b40-318c-4603-5662-08da2eb9a716
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0047
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device-tree binding documentation to represent the error handling
driver for Control Backbone (CBB) version 1.0 used in Tegra194 SOC.
The driver prints debug information about failed transactions due to
illegal register accesses on receiving interrupt from CBB.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../arm/tegra/nvidia,tegra194-cbb.yaml        | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
new file mode 100644
index 000000000000..3167f0450298
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra194-cbb.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NVIDIA Tegra194 CBB 1.0 device tree bindings
+
+maintainers:
+  - Sumit Gupta <sumitg@nvidia.com>
+
+description: |+
+  The Control Backbone (CBB) is comprised of the physical path from an initiator to a target's
+  register configuration space. CBB 1.0 has multiple hierarchical sub-NOCs (Network-on-Chip) and
+  connects various initiators and targets using different bridges like AXIP2P, AXI2APB.
+
+  This driver handles errors due to illegal register accesses reported by the NOCs inside the CBB.
+  NOCs reporting errors are cluster NOCs "AON-NOC, SCE-NOC, RCE-NOC, BPMP-NOC, CV-NOC" and "CBB
+  Central NOC" which is the main NOC.
+
+  By default, the access issuing initiator is informed about the error using SError or Data Abort
+  exception unless the ERD (Error Response Disable) is enabled/set for that initiator. If the ERD
+  is enabled, then SError or Data Abort is masked and the error is reported with interrupt.
+
+  - For CCPLEX (CPU Complex) initiator, the driver sets ERD bit. So, the errors due to illegal
+    accesses from CCPLEX are reported by interrupts. If ERD is not set, then error is reported by
+    SError.
+  - For other initiators, the ERD is disabled. So, the access issuing initiator is informed about
+    the illegal access by Data Abort exception. In addition, an interrupt is also generated to
+    CCPLEX. These initiators include all engines using Cortex-R5 (which is ARMv7 CPU cluster) and
+    engines like TSEC (Security co-processor), NVDEC (NVIDIA Video Decoder engine) etc which can
+    initiate transactions.
+
+  The driver prints relevant debug information like Error Code, Error Description, Master, Address,
+  AXI ID, Cache, Protection, Security Group etc on receiving error notification.
+
+properties:
+  $nodename:
+    pattern: "^[a-z]+-noc@[0-9a-f]+$"
+
+  compatible:
+    enum:
+      - nvidia,tegra194-cbb-noc
+      - nvidia,tegra194-aon-noc
+      - nvidia,tegra194-bpmp-noc
+      - nvidia,tegra194-rce-noc
+      - nvidia,tegra194-sce-noc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      CCPLEX receives secure or nonsecure interrupt depending on error type. A secure interrupt is
+      received for SEC(firewall) & SLV errors and a non-secure interrupt is received for TMO & DEC
+      errors.
+    items:
+      - description: non-secure interrupt
+      - description: secure interrupt
+
+  nvidia,axi2apb:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description:
+      Specifies the node having all axi2apb bridges which need to be checked for any error logged
+      in their status register.
+
+  nvidia,apbmisc:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description:
+      Specifies the apbmisc node which need to be used for reading ERD register.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - nvidia,axi2apb
+  - nvidia,apbmisc
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    cbb-noc@2300000 {
+        compatible = "nvidia,tegra194-cbb-noc";
+        reg = <0x02300000 0x1000>;
+        interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+        nvidia,axi2apb = <&axi2apb>;
+        nvidia,apbmisc = <&apbmisc>;
+        status = "okay";
+    };
-- 
2.17.1

