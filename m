Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1EF55521C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377264AbiFVRMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377178AbiFVRMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:12:43 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6689D11F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZC8A4WiF+YEuvGc17U3Y4VkF0S2YbPQy2LmcxhdQIuAcYE+dwR+EgSsZvjYS1lW7SwIatkVOTASa2EtsanQwkN9fZgW0N/2SMhxmPBB/2GiBt1voMWVzHm1HauTxLBSnD1LoMp4SqqZeULu9ZL697IL3Kvypffsjpvw/vzmg1gsR6R2y1HOdOEF+mcMkzA7Vy1Cx1bhfyXZ0WhTD/f6J4El1/XMwMaG90axUalprUNbpeTAHW1Wf5lA4H8eoR7Q9PWaxIyqp1Rris5lniFTJefXIoRmITcduLczDafBOl0SqsfxuJ9z4wgUU+FP7CI2jyvDOopy1fS1spy+Lgsz/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jUN+O9+g8UL/pOyq3o36/tJDTYi5R3fpOm2swlj7jA=;
 b=OGJMccZos4QWbSkBCQ5zwujBHkfBntbB1N5tuFrWb0Mfmk/TCj7SfYlvbAR0wwTpfxJJ0nufgqtFDjpN12F+aHT5L9W9CENqiGULjy0k4gO+BxvDaEP1lJI5UAj3KAPCDMoZ9MaGAmYQnuWrkYn89xBQdopzA9dojA5didtEkPoqoTVhwtweqjl6V1Wdltfhs0Jggzoua+9FO9i41H0L4yXOiWXiiSP16xLY7mrWnfXTLrc0XpaN31VxneOtfJ+CzmrLr7wzfGKKLTYNF2/TjQKrCkhLlJHuHGirGPB6joFXx3EG3wLF2dzqC6mRGtM7SoNbQ8LOFz+pWDDiacUeKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jUN+O9+g8UL/pOyq3o36/tJDTYi5R3fpOm2swlj7jA=;
 b=P7MOeIm9qwfkSuhZI+ll/WpD/SWp6uf9Kc1JbMM5C/UTL6EyoB5Nknz0wyEqk9rOVCbzNa15G4gjcRzBidJXTGL6NaPyuqNi3mS6IeZtCbk9qSxKwssXOgJOwFmpILoFvYtXo2AL77jeEFkAAIDJGNrKmjZNgUQN8h2ihWjIszs=
Received: from MWHPR08CA0040.namprd08.prod.outlook.com (2603:10b6:300:c0::14)
 by BN6PR12MB1844.namprd12.prod.outlook.com (2603:10b6:404:fc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 22 Jun
 2022 17:12:39 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:c0:cafe::7d) by MWHPR08CA0040.outlook.office365.com
 (2603:10b6:300:c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Wed, 22 Jun 2022 17:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Wed, 22 Jun 2022 17:12:38 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 22 Jun
 2022 12:12:34 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <ashish.kalra@amd.com>,
        <vasant.hegde@amd.com>, <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 4/7] iommu/amd: Introduce function to check and enable SNP
Date:   Wed, 22 Jun 2022 12:11:28 -0500
Message-ID: <20220622171131.11870-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220622171131.11870-1-suravee.suthikulpanit@amd.com>
References: <20220622171131.11870-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3f3f0cad-d186-42ec-0c09-08da54726897
X-MS-TrafficTypeDiagnostic: BN6PR12MB1844:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1844FB8FAA775B633D8698E9F3B29@BN6PR12MB1844.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vifCCxRgWkbc9HfSZ0f31Qb/Ga9TraRQH6jTKWLiIofJSCcU0YRFzVy0RvMCBw3DD//QnhDmQRI3oEgXfhn6Wcz7oG/8c7fer05PrnwPI7NKciLfIKTIzoGmdyPumcE6A0Z9u2bGCS1AURDHJBCWJUthrQZmyNEb1p6793KYfeyaIrDG30TVYpB0QYGG3EtHAhbQie3hqRmOtZBIJ5/ua5GWzDh57UJtFmLEg4cOzaaupUqfq4UTDj+Wz0wm7b3oaZHHWDkpL3rGvw7SfcOYScgPt0yPiMFfCbcut5JnnU/y5Zcb3LQDUPSsqvZoobGBlIY9PsdfCdW0c74mZfpr+3AyIGtubHeSqT9wAxs4qyNKzpjhv/90HTimgzmFueulIuTOiuKUjhyw58/BN8+GcWbHaPn0APkEqYkyy5bXejs6o4aEL17aFl0MrISt8J19o6dfKIJpUEJxsWO2fkp9SKRHijh71cyftzp4qdy8fa/ugoyyIuGgAzf2Lm/8QqldEH1cTyO/x2XE4sRhQFtqCTsgoHoxRcXiWkraVrs70+fmh3y/GD02i3LGkubFFMaskFSD3Ul6flm5N7tVrgUhYgD/YQRj6gOHTBBcvgjqkMpkWpxo4bpk5MwiXiISTP+4FLQuFVT7n4rra2aYgGpTXCYbm+6vcOieOi6P8dqdfZKoFmkizEq/b+fRwkfhExlCOF77j15mFdhoJ8uFJw38r1HLIt7VByvAQvBkR40mBVVcrn0xVYKDzfSjjQM09RbqjGFoHLGc0q/RSUJ2HRJaHh9mNsTSKnilA46dWQMoz90=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(396003)(40470700004)(36840700001)(46966006)(82740400003)(40480700001)(44832011)(81166007)(8936002)(356005)(478600001)(47076005)(186003)(336012)(2616005)(5660300002)(83380400001)(16526019)(41300700001)(40460700003)(426003)(36860700001)(1076003)(6666004)(26005)(86362001)(7696005)(110136005)(2906002)(82310400005)(8676002)(54906003)(316002)(70586007)(70206006)(36756003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 17:12:38.2206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3f0cad-d186-42ec-0c09-08da54726897
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1844
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brijesh Singh <brijesh.singh@amd.com>

To support SNP, IOMMU needs to be enabled, and prohibits IOMMU
configurations where DTE[Mode]=0, which means it cannot be supported with
IOMMU passthrough domain (a.k.a IOMMU_DOMAIN_IDENTITY),
and when AMD IOMMU driver is configured to not use the IOMMU host (v1) page
table. Otherwise, RMP table initialization could cause the system to crash.

The request to enable SNP support in IOMMU must be done before PCI
initialization state of the IOMMU driver because enabling SNP affects
how IOMMU driver sets up IOMMU data structures (i.e. DTE).

Unlike other IOMMU features, SNP feature does not have an enable bit in
the IOMMU control register. Instead, the IOMMU driver introduces
an amd_iommu_snp_en variable to track enabling state of SNP.

Introduce amd_iommu_snp_enable() for other drivers to request enabling
the SNP support in IOMMU, which checks all prerequisites and determines
if the feature can be safely enabled.

Please see the IOMMU spec section 2.12 for further details.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  5 ++++
 drivers/iommu/amd/init.c            | 44 +++++++++++++++++++++++++++--
 drivers/iommu/amd/iommu.c           |  4 +--
 include/linux/amd-iommu.h           |  4 +++
 4 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 73b729be7410..ce4db2835b36 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -463,6 +463,9 @@ extern bool amd_iommu_irq_remap;
 /* kmem_cache to get tables with 128 byte alignement */
 extern struct kmem_cache *amd_iommu_irq_cache;
 
+/* SNP is enabled on the system? */
+extern bool amd_iommu_snp_en;
+
 #define PCI_SBDF_TO_SEGID(sbdf)		(((sbdf) >> 16) & 0xffff)
 #define PCI_SBDF_TO_DEVID(sbdf)		((sbdf) & 0xffff)
 #define PCI_SEG_DEVID_TO_SBDF(seg, devid)	((((u32)(seg) & 0xffff) << 16) | \
@@ -1013,4 +1016,6 @@ extern struct amd_irte_ops irte_32_ops;
 extern struct amd_irte_ops irte_128_ops;
 #endif
 
+extern struct iommu_ops amd_iommu_ops;
+
 #endif /* _ASM_X86_AMD_IOMMU_TYPES_H */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 013c55e3c2f2..c62fb4470519 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -95,8 +95,6 @@
  * out of it.
  */
 
-extern const struct iommu_ops amd_iommu_ops;
-
 /*
  * structure describing one IOMMU in the ACPI table. Typically followed by one
  * or more ivhd_entrys.
@@ -168,6 +166,9 @@ static int amd_iommu_target_ivhd_type;
 
 static bool amd_iommu_snp_sup;
 
+bool amd_iommu_snp_en;
+EXPORT_SYMBOL(amd_iommu_snp_en);
+
 LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
 					   system */
@@ -3549,3 +3550,42 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64
 
 	return iommu_pc_get_set_reg(iommu, bank, cntr, fxn, value, true);
 }
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+int amd_iommu_snp_enable(void)
+{
+	/*
+	 * The SNP support requires that IOMMU must be enabled, and is
+	 * not configured in the passthrough mode.
+	 */
+	if (no_iommu || iommu_default_passthrough()) {
+		pr_err("SNP: IOMMU is disabled or configured in passthrough mode, SNP cannot be supported");
+		return -EINVAL;
+	}
+
+	/*
+	 * Prevent enabling SNP after IOMMU_ENABLED state because this process
+	 * affect how IOMMU driver sets up data structures and configures
+	 * IOMMU hardware.
+	 */
+	if (init_state > IOMMU_ENABLED) {
+		pr_err("SNP: Too late to enable SNP for IOMMU.\n");
+		return -EINVAL;
+	}
+
+	amd_iommu_snp_en = amd_iommu_snp_sup;
+	if (!amd_iommu_snp_en)
+		return -EINVAL;
+
+	pr_info("SNP enabled\n");
+
+	/* Enforce IOMMU v1 pagetable when SNP is enabled. */
+	if (amd_iommu_pgtable != AMD_IOMMU_V1) {
+		pr_warn("Force to using AMD IOMMU v1 page table due to SNP\n");
+		amd_iommu_pgtable = AMD_IOMMU_V1;
+		amd_iommu_ops.pgsize_bitmap = AMD_IOMMU_PGSIZES;
+	}
+
+	return 0;
+}
+#endif
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 86045dc50a0f..0792cd618dba 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -71,7 +71,7 @@ LIST_HEAD(acpihid_map);
  * Domain for untranslated devices - only allocated
  * if iommu=pt passed on kernel cmd line.
  */
-const struct iommu_ops amd_iommu_ops;
+struct iommu_ops amd_iommu_ops;
 
 static ATOMIC_NOTIFIER_HEAD(ppr_notifier);
 int amd_iommu_max_glx_val = -1;
@@ -2412,7 +2412,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
 	return 0;
 }
 
-const struct iommu_ops amd_iommu_ops = {
+struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
 	.probe_device = amd_iommu_probe_device,
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 58e6c3806c09..953e6f12fa1c 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -206,4 +206,8 @@ int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn,
 		u64 *value);
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+int amd_iommu_snp_enable(void);
+#endif
+
 #endif /* _ASM_X86_AMD_IOMMU_H */
-- 
2.32.0

