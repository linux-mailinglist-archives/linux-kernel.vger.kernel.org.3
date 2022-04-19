Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F251507B60
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356984AbiDSU6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbiDSU6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:58:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D41741320;
        Tue, 19 Apr 2022 13:55:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I45GJ8dwJ8oAkEQdopi1o1+zthbz0hUGO8ZNop3cV5e5Sfm5mcN+jAdlT/6UnCBj45OY7kOLYBbsODWPbWF+ADg7XO7Na8XpXD240/LZEnm3yRVTg/zKoO3JGw1xOg8BsKVlXylXY8wcoolVXqqzBpiLvuvEUfMXGniRhiNaX5/yPUxZ7wRX8M6HqfAL+asXz1WlW9uyUhKR18Qub90JIxn6WUQS1d2CtWHTwSGHLKHQjSugDaPs8WHjpwfhd7xN2Dk95m/LXntOlZYyzy16P9TFl2K/2/wz/oGTcSRCJYIvDwcqNLpiCXltFkW65YT2LM+IzzmqtBwccs4YKBnC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/IK9aRbx7KFLOBpCoZe9AU0u3qKcMBHjaFIESar21E=;
 b=L+UJrOobj99TeMEXPgYGyZK+ToPjQUcKMIWt8kL4mM9ZSY400NtE0/kdkbqR06NdNr2XiHxKDv42t55OBvHqIWTOX2BBJD0M1XQ3EkTBCfi7ehsUYQCmB3oSCIZJcC0nwwewu1EMBSz9IlmIhIE/bclZ806C38dXJGCxrlWFrAS6e6IAtNx0or5kCmQFPRD9O1grnJO6FIK2HjLOVmqyMjVDAHw9EOGN05/r9rqn1IuQ37rnvBmnBNZkvEp48TWiU92vgX4+zlSbVxhFgxLnapYn8iv3S9vHugqQvXHDY0h0MgxJ99JmjESkGzwOzkMoLFARU2ZuPmYjBAdbty+H5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/IK9aRbx7KFLOBpCoZe9AU0u3qKcMBHjaFIESar21E=;
 b=C8TMvHQn4kTnq9CglG6Xd3L26CChsxsb1RDUTv+CnJQt4/rY9xNlE3eUgqIvDRPzYlcgbG/VrYxh0M+wT2xRWJS3XVcUWo3t3u2LwlmuPIFeBn3epYbonxZhmoYFHvS8t52VnOug9ITkZtPI/yWqgUjWNjoiaV7JFeCOVLBWfyonwbYlz376x+7IoKfiSVCLZbJIKC+pgrToCFk291NIueKXSHJ74H0gc/3oh0eTV1/SSUBPRivHQ7WDLiQqnNB+7D0sFAc0JDgs61/PMNapUQfmn4fvChPutemWDC/0XuOE+y7Ca0BNqge/Dlkalhx4WNjwF6Mf+OhHxmuBkP4zDg==
Received: from BN9P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::28)
 by BL0PR12MB2356.namprd12.prod.outlook.com (2603:10b6:207:4d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Tue, 19 Apr
 2022 20:55:52 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::cb) by BN9P222CA0023.outlook.office365.com
 (2603:10b6:408:10c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Tue, 19 Apr 2022 20:55:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Tue, 19 Apr 2022 20:55:52 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Tue, 19 Apr
 2022 20:55:51 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Apr
 2022 13:55:50 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Tue, 19 Apr 2022 13:55:50 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <robert.moore@intel.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>
CC:     <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Besar Wicaksono" <bwicaksono@nvidia.com>
Subject: [PATCH 1/2] ACPICA: Add support for ARM Performance Monitoring Unit Table.
Date:   Tue, 19 Apr 2022 15:54:31 -0500
Message-ID: <20220419205432.46021-2-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220419205432.46021-1-bwicaksono@nvidia.com>
References: <20220419205432.46021-1-bwicaksono@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c52452d8-bbff-43b1-0fdb-08da2246fdca
X-MS-TrafficTypeDiagnostic: BL0PR12MB2356:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB23566F7D9E1E67316D6E1468A0F29@BL0PR12MB2356.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qObEJIVJkg6A1EWndOP+m7xZ6qzlAO4OVINrxm5rxN/whjMmCoqRJ++i9hBwpoWp3JpJWsTZglh9TX2z3bBCfIdz91wHeIrxx6zVn21mv2IdX4N5/tHE4wfOsOxblWvpmF2nTEjuH4GcSZRwXkFWvZuAJmirTOq/OAB58kbZYT6RwUlxsik/nJeA0uLXZ5vdTvy45KgqZP4DbT+ik1k5/0d/HUArl43u66MNCP0DATGYaL7CUYmN7yF/vE7+R+OPBa2zi85dPwXC0+nkFMReb+q/pEAgC2PXRanjwwLgof6EzryI7s7GPr/raiRZdWD62PM2Jx1TNWbTT0oJiqMYqqAiEHBXpe6Us5qjZTQVXVNhNXGq6Hfg7Ugmx3APJiM5HLwHp7bMfZyMXwoEsw+Fz5D+N2v8Hs3a/RBvkhgyqR49XeQ0Oh7KhH5U0zEZTS4N2b9HKgaHfddK6BvqNhT+NQM5LYmNpUtRbk4kkFJpweUn6vJxMDZDdIOgTV2JDFTJVUgL5orIHgcPhG+4Nov2ryAnFObmJmBMtghMyc11PDbFreNS5E1UiY+lEutmwx4YwAYTaTWwlc1UmP9k8B4yy9+XW/ptLp7hPTk/z1MSegbXlLCcZ0QzPEFY9FOW2cOJJvCOUnJ1b35nDhbK7RFQw36AHWpH682ImgbFUv/H4Akz2A3mgvLzv4NSyYVJdJBKX/GugIe9tzlFiD41KJJC/itnwuFTzmQzMuzsfjMvn/8SMasjN2g4sCvQUotCvcwI8hN8Vce6BZdRcOdZtj7/e8tFOsGaqi+W3HFG/99M7Ik=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(7416002)(86362001)(70206006)(7696005)(8936002)(356005)(81166007)(316002)(54906003)(966005)(508600001)(70586007)(110136005)(6666004)(186003)(40460700003)(426003)(8676002)(5660300002)(336012)(4326008)(47076005)(36860700001)(2616005)(1076003)(107886003)(82310400005)(26005)(36756003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 20:55:52.5404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c52452d8-bbff-43b1-0fdb-08da2246fdca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2356
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPICA commit 002165ecc0a3dc703bb24c789aaa02fdada01675

The specification of this table is described in
"ARM Performance Monitoring Unit Architecture 1.0 Platform Design Document"
ARM DEN0117.

This patch adds the necessary types and support for
compiling/disassembling APMT.

Link: https://github.com/acpica/acpica/commit/002165ec
Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 include/acpi/actbl2.h | 81 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 16847c8d9d5f..8fc5cf318c15 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -25,6 +25,7 @@
  * the wrong signature.
  */
 #define ACPI_SIG_AGDI           "AGDI"	/* Arm Generic Diagnostic Dump and Reset Device Interface */
+#define ACPI_SIG_APMT           "APMT"	/* Arm Performance Monitoring Unit table */
 #define ACPI_SIG_BDAT           "BDAT"	/* BIOS Data ACPI Table */
 #define ACPI_SIG_IORT           "IORT"	/* IO Remapping Table */
 #define ACPI_SIG_IVRS           "IVRS"	/* I/O Virtualization Reporting Structure */
@@ -258,6 +259,86 @@ struct acpi_table_agdi {
 
 #define ACPI_AGDI_SIGNALING_MODE (1)
 
+/*******************************************************************************
+ *
+ * APMT - ARM Performance Monitoring Unit Table
+ *
+ * Conforms to:
+ * ARM Performance Monitoring Unit Architecture 1.0 Platform Design Document
+ * ARM DEN0117 v1.0 November 25, 2021
+ *
+ ******************************************************************************/
+
+struct acpi_table_apmt {
+	struct acpi_table_header header;    /* Common ACPI table header */
+};
+
+#define ACPI_APMT_NODE_ID_LENGTH                4
+
+/*
+ * APMT subtables
+ */
+struct acpi_apmt_node {
+	u16                                  length;
+	u8                                   flags;
+	u8                                   type;
+	u32                                  id;
+	u64                                  inst_primary;
+	u32                                  inst_secondary;
+	u64                                  base_address0;
+	u64                                  base_address1;
+	u32                                  ovflw_irq;
+	u32                                  reserved;
+	u32                                  ovflw_irq_flags;
+	u32                                  proc_affinity;
+	u32                                  impl_id;
+};
+
+/* Masks for Flags field above */
+
+#define ACPI_APMT_FLAGS_DUAL_PAGE               (1<<0)
+#define ACPI_APMT_FLAGS_AFFINITY                (1<<1)
+#define ACPI_APMT_FLAGS_ATOMIC                  (1<<2)
+
+/* Values for Flags dual page field above */
+
+#define ACPI_APMT_FLAGS_DUAL_PAGE_NSUPP         (0<<0)
+#define ACPI_APMT_FLAGS_DUAL_PAGE_SUPP          (1<<0)
+
+/* Values for Flags processor affinity field above */
+#define ACPI_APMT_FLAGS_AFFINITY_PROC           (0<<1)
+#define ACPI_APMT_FLAGS_AFFINITY_PROC_CONTAINER (1<<1)
+
+/* Values for Flags 64-bit atomic field above */
+#define ACPI_APMT_FLAGS_ATOMIC_NSUPP            (0<<2)
+#define ACPI_APMT_FLAGS_ATOMIC_SUPP             (1<<2)
+
+/* Values for Type field above */
+
+enum acpi_apmt_node_type {
+	ACPI_APMT_NODE_TYPE_MC                      = 0x00,
+	ACPI_APMT_NODE_TYPE_SMMU                    = 0x01,
+	ACPI_APMT_NODE_TYPE_PCIE_ROOT               = 0x02,
+	ACPI_APMT_NODE_TYPE_ACPI                    = 0x03,
+	ACPI_APMT_NODE_TYPE_CACHE                   = 0x04,
+	ACPI_APMT_NODE_TYPE_COUNT
+};
+
+/* Masks for ovflw_irq_flags field above */
+
+#define ACPI_APMT_OVFLW_IRQ_FLAGS_MODE          (1<<0)
+#define ACPI_APMT_OVFLW_IRQ_FLAGS_TYPE          (1<<1)
+
+/* Values for ovflw_irq_flags mode field above */
+
+#define ACPI_APMT_OVFLW_IRQ_FLAGS_MODE_LEVEL    (0<<0)
+#define ACPI_APMT_OVFLW_IRQ_FLAGS_MODE_EDGE     (1<<0)
+
+/* Values for ovflw_irq_flags type field above */
+
+#define ACPI_APMT_OVFLW_IRQ_FLAGS_TYPE_WIRED    (0<<1)
+
+
 /*******************************************************************************
  *
  * BDAT - BIOS Data ACPI Table
-- 
2.17.1

