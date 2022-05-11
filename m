Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389F9523EAD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 22:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347654AbiEKURj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 16:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347655AbiEKURg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 16:17:36 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275CB6BFF7;
        Wed, 11 May 2022 13:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Db7IRlg62w6o82tJHpMCFdPcjFOzijYystUdPtkTbG6rjUoAdEd6WWisvPgXwLLRpc7mICsWtGBr89R+H5rZL4nY0635yG/eoS7qsyNSClWsqXtmK+wEdqPNlfthzsRbr9TnE6LBqnM12FFZXyACNQX6G3MVaTAJWoepUA4KWaUYbW7vkwtrWdSAe87uOS/sckcP0tLHRVDbLWCisYIuiBOxumBxNdPAqwxXRSDWQ2x916NrgTd6spphOi0To8VgFSyLkxSDxCQy+7mVOC8DigEckjoBpLQ8ot3NwyIB96URV9vVEmsKJ5UL5CXSJeUyhpP5ihozHppyuDalavI5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RCKwBfcrw1sdvT1Mz9H8po07BGyIj4b5tmfie7aNS0A=;
 b=Q3vHza/Gm6jqsI/iM5pSGWW0JReMQLW3uxoMbws3Vw9G7ugDXWyhZoUr5Xjg+gwn9oL/vVBWJjs2EBIs9E414MmznND7DWiQ8237pIbwZ2CNsrju/14SdoAjV1qXYaa0ALCLYFvw46dH3kcJ4YEyGoXCI/6uIXsQGxtb5dpcgwjt6Jq9JB7jzWAXzrICLdfQKddvUtXZaEkGcJvbpW/DRxJ8mWlDtfNG5tPYI20aCvItF+Lj1OElkhaLjpAXfEko1m2Reh+W0dXSQsEmGsRX+tfuv+H9OWD9Zk9WSWfjsIeSMnE9PVBPWYhczjASfuEwFdkUWW8o55FLGPapYAe7bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RCKwBfcrw1sdvT1Mz9H8po07BGyIj4b5tmfie7aNS0A=;
 b=B3R536DBnML6Al0xkaEASxfrEeAn41CtIWdK4glsffr/2w10TPN4Y8Fb6iloakzYVCrofX+9jyxzEbCa9klDqVC2rqu8ThHEqM6NBtxwsG3LXtBg5ZS1cutxXc1EOTFfoBlpp6PLIOpVCIAl6XoGVAUNLUtfHh0UsiKLp1b2RA4JO5CPQmiTMghdhW4wwhBiwLWjDqeNTIwRUjBTuP79rA8NaFCAB1jhPKkphlivl4UFQPDgw18BCOPePY9SqtM/KGU7g0010mKtjyTCXGQWF7eYPoFa873ol11e78M3Pn4m00k3gLS3aGj5mwasaE57dkdk6EoP9Afba3GA7hYf4A==
Received: from BN0PR02CA0028.namprd02.prod.outlook.com (2603:10b6:408:e4::33)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 20:17:32 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::f3) by BN0PR02CA0028.outlook.office365.com
 (2603:10b6:408:e4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Wed, 11 May 2022 20:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 20:17:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Wed, 11 May 2022 20:17:30 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 11 May 2022 13:17:30 -0700
Received: from sumitg-l4t.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Wed, 11 May 2022 13:17:27 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
        <kbuild-all@lists.01.org>
CC:     <sumitg@nvidia.com>, <bbasu@nvidia.com>, <vsethi@nvidia.com>,
        <jsequeira@nvidia.com>
Subject: [Patch v6 2/9] dt-bindings: arm: tegra: Add NVIDIA Tegra194 CBB1.0 binding
Date:   Thu, 12 May 2022 01:46:44 +0530
Message-ID: <20220511201651.30695-4-sumitg@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220511201651.30695-1-sumitg@nvidia.com>
References: <20220511201651.30695-1-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 535350f6-8e06-4ecc-3206-08da338b4775
X-MS-TrafficTypeDiagnostic: PH7PR12MB6418:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB641806B0AE005777B6E56E22B9C89@PH7PR12MB6418.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bZzqZuTl7oxC3Yv8NJIpbhZsi/JPNFTSgoQTyK68FZBDpf3CaOjtGmV/S+kCx6EMcE5oMAuWdxTrS6CnZlXifNa4BWv+UDAexmQwdKPSZ9Bh9bKgxNDICXuaiVCkDyfsWW8BxLWTmcvT6iszDcgjm6HgY5K65nI2aW5csuv8dfQRE0ptIjCTz7+OdZnOilygtXkDj5IU8im+IaKpJsfJJy/eTavFe38ms+u8/2NQhBNYkD5D+bmLyuTk/5ELhTspCVJCZwxYXMO88/FEHxiaYuxyCpHbr1BuVnYRbBj2rUTp7Ghb9Ih4307pInrzF1yusWCUEIYjYgWuXYIMXa9FjqHp/QBSOG6GyAUdryztDEGAB/ziU3DvRMf+lwjkqAX2d/blW6WBAKHR+lY7Ni3xspWkTA+2WzwQb/pFVoQ+WDng7J+o45OCUQzPNGHCc7nmooom+/vJievfqEdxD0WsrJJyiUL/MY6uazX3KEqf2x5MEB0lkECe2lv4pt7GAcBziKzHU1KOW6hSjGbnBwwmCExWqIz/ZKX/FzAByB1SdS3f1Gmrk+WU9zerZn1vHwh1QXH2vPk9sPLEJUk3sn+cejFBKJAqgRPTN9i1OyA6d4CriScQXhDOPvyj75NLP5fyRYlIoh0Aslt3n+06/sqc5T3srAqVet0rU25or75T2ijtva19C+ZlNUGqYH8pk+5uaWZUVI5BiqRpC9+NNTv1/ib/i7RjobVrFUzZaE10L6fG08MfgZ5cAPXkn4u7G7xzzXPHAspDmhzBbhYhCI0MTcso9BD/ENHvwMUYNp6vY/BIi1F0L8d01ZX1FNz8Vg/cC3x99BSnl+VB07//WPGBqA==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8676002)(83380400001)(81166007)(186003)(82310400005)(70586007)(70206006)(86362001)(4326008)(26005)(54906003)(47076005)(356005)(2906002)(40460700003)(426003)(336012)(110136005)(36756003)(5660300002)(2616005)(508600001)(7696005)(36860700001)(6666004)(1076003)(107886003)(8936002)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 20:17:31.6961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 535350f6-8e06-4ecc-3206-08da338b4775
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418
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

Add device-tree binding documentation to represent the
Control Backbone (CBB) version 1.0 used in Tegra194 SOC.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 .../arm/tegra/nvidia,tegra194-cbb.yaml        | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml

diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
new file mode 100644
index 000000000000..f967b45e83d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra194-cbb.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: NVIDIA Tegra194 CBB 1.0 bindings
+
+maintainers:
+  - Sumit Gupta <sumitg@nvidia.com>
+
+description: |+
+  The Control Backbone (CBB) is comprised of the physical path from an
+  initiator to a target's register configuration space. CBB 1.0 has
+  multiple hierarchical sub-NOCs (Network-on-Chip) and connects various
+  initiators and targets using different bridges like AXIP2P, AXI2APB.
+
+  This driver handles errors due to illegal register accesses reported
+  by the NOCs inside the CBB. NOCs reporting errors are cluster NOCs
+  "AON-NOC, SCE-NOC, RCE-NOC, BPMP-NOC, CV-NOC" and "CBB Central NOC"
+  which is the main NOC.
+
+  By default, the access issuing initiator is informed about the error
+  using SError or Data Abort exception unless the ERD (Error Response
+  Disable) is enabled/set for that initiator. If the ERD is enabled, then
+  SError or Data Abort is masked and the error is reported with interrupt.
+
+  - For CCPLEX (CPU Complex) initiator, the driver sets ERD bit. So, the
+    errors due to illegal accesses from CCPLEX are reported by interrupts.
+    If ERD is not set, then error is reported by SError.
+  - For other initiators, the ERD is disabled. So, the access issuing
+    initiator is informed about the illegal access by Data Abort exception.
+    In addition, an interrupt is also generated to CCPLEX. These initiators
+    include all engines using Cortex-R5 (which is ARMv7 CPU cluster) and
+    engines like TSEC (Security co-processor), NVDEC (NVIDIA Video Decoder
+    engine) etc which can initiate transactions.
+
+  The driver prints relevant debug information like Error Code, Error
+  Description, Master, Address, AXI ID, Cache, Protection, Security Group
+  etc on receiving error notification.
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
+      CCPLEX receives secure or nonsecure interrupt depending on error type.
+      A secure interrupt is received for SEC(firewall) & SLV errors and a
+      non-secure interrupt is received for TMO & DEC errors.
+    items:
+      - description: non-secure interrupt
+      - description: secure interrupt
+
+  nvidia,axi2apb:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description:
+      Specifies the node having all axi2apb bridges which need to be checked
+      for any error logged in their status register.
+
+  nvidia,apbmisc:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description:
+      Specifies the apbmisc node which need to be used for reading the ERD
+      register.
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
+    };
-- 
2.17.1

