Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C48F573FCB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiGMW51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiGMW5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:57:17 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260484F67E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:57:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z48Pauh0ZV8p9CFOmT5tYGIzNcvmYjRbGqf/EkxMPdc3fuynC9Y/T3bwfUibJUcUIOaAWppgwdhkEC0TijmXOAlWDUqP6BP7CnQtYpZwREpVbKsyh0rYX/vjK3ASxcw/2uny5/o1Tdkc6sNK2ymIq2e0dj9vBlLS0hU3xHduZnG70PjW9FkfUz9SHrr0ize49eItnEgrbwb62m6iQzxIkgZsr6a65dwP67t8Tis+zq4ADQyiVP8Ep36AmKXHPZzjgqlSu7+8S5DxStjaVdyO+6Hem9pyjUXpx9He27SsedioXkk6vOI2vMADtC50SKvrO3FuCHtttliGHR2YZeWs5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKMTKGeDZkJqmQMfLSToVrwJb6498aYe4lnDyfX0l5U=;
 b=ng9688pOUfan3PUyVWmh5WK7K4R0Dxeq9V0/fs41WrDeqi/bn6NNr2ZvCpP8FBRCSR/a18z0b6oCjYrZaZ/piKdRERjkR00GooFDm8EHDVQQupc3UImgLDQQ9X5t7jlGiof/pfbbmvyB3E2KNA6J5xOERZD6AMGLWUfBdQMMkZDrrxMLrqP2wHv8EZYQ9sP4AbofFdWILZrDns6HvIDALTDhdufKufKHy5dz4rOcz7eYX/vN0q4FkPAOlFICLqHVqjHWaf0HUT4RmWQyTwjIK/9Jcm3pDQUJIE9XayMpobIrytGdFTzP2j87saOTU7iRIIo+mUcrwFT4F9DhVTKgjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKMTKGeDZkJqmQMfLSToVrwJb6498aYe4lnDyfX0l5U=;
 b=UE87tU+xdm0VOvPuQ/ZOSHG+CM6nxg14urfwZCivXXzc8XY3IptLPGLUhFFGp2YjUNvLUzI0aKq29svcIK8WmVYfGz3VzMknpCAl8kY7b62tUHVa/PzQKT5CM/foGoHNTb5JYyay+2rQLqimjCUh3y+kpoC8+6iGbh3wMB7sRDQ=
Received: from BN9PR03CA0523.namprd03.prod.outlook.com (2603:10b6:408:131::18)
 by BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 22:57:14 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::e9) by BN9PR03CA0523.outlook.office365.com
 (2603:10b6:408:131::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Wed, 13 Jul 2022 22:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 22:57:14 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 13 Jul
 2022 17:57:10 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
        <ashish.kalra@amd.com>, <jon.grimm@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 6/9] iommu/amd: Introduce function to check and enable SNP
Date:   Wed, 13 Jul 2022 17:56:48 -0500
Message-ID: <20220713225651.20758-7-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220713225651.20758-1-suravee.suthikulpanit@amd.com>
References: <20220713225651.20758-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 274ce875-7ea5-4e12-b084-08da652306ef
X-MS-TrafficTypeDiagnostic: BL3PR12MB6643:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OUbru3WK1yunu6SfYf8fHugWvpT3s1c8aOjjNuqXYE39dp04MF2AFB+TpHfQgBicv8eJbHD1qkOaXUDVTqOXc/s3M8QF3H9RT5OPvwKVLtVcRuHbmFiHUFGtw6DvfaSvPxmjEpQWtVXqQryG6NyKzvkjBjjpR29WIltBSqX7cPPncNVKnsjhE2AuQuJ2mLiKna8d3Kttzeq4LpTvEx2AyvznT4U3hERdqIelQDvcrm42Dq+rfkCL0omVAjZ8lFOJapIlgB7IYcKWJfR8d7CTxm7fCjtr3/zO/QfrHY9ewqPRd2mEihU2KybJo4TRJXgJzyT73KYHzhwiBPVkUf2aWGc/nDt21Dv8eTEm+zVAXZ8IkEEXSvUT5mPbGhMunRJWz5H+XwIxPBkrfdh75hBsn+ShbjlOC5zvJbxHPIu1S8AVpdJzxhxxk5NmFllcIb6a9zM/KtxiaDw45AGWoMuOXpe4eeva1VjjEFu4jJgf+cRx4xl/7i6+RCEA49Y9aO3W5fXokGVK3baNyKWExNz53gvroqPwA8WhFjW4WJWvFaJ6T2CNj1Kmn/UqIS8RhFWqubb+eUT5rY4P09WvHNM5wGYyP6xSMznwK5kc4hM9NtYJIRTMhtnLEFBHPbUnJB02moXEoumnLRB9n57dxXl62SgVZ7SPxfyOELfgcCT7YgVitrRREKQVFqZawPvTSpT41MLMtpzxWnfqEpMYS4boyOhWK0E6zslQtdK9f/ZrFSPJ1Y8Hu87RVFFPMZ3QVS3l/Fi2fNEtIVLZmsc4mv2E4gQNDT4AVqGFFr94njPCQU5VghYByEG4fFQ169FE0kAuG2bn1fOuW36Iz8E/6lsNZfBUHMjBD3PKe4hGHlUdsQk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(346002)(376002)(40470700004)(46966006)(36840700001)(426003)(70206006)(47076005)(83380400001)(186003)(82740400003)(81166007)(336012)(40480700001)(40460700003)(16526019)(36860700001)(4326008)(86362001)(6666004)(110136005)(8676002)(54906003)(316002)(70586007)(36756003)(8936002)(26005)(356005)(44832011)(5660300002)(82310400005)(2616005)(41300700001)(2906002)(478600001)(7696005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 22:57:14.0197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 274ce875-7ea5-4e12-b084-08da652306ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643
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
 drivers/iommu/amd/amd_iommu.h |  2 ++
 drivers/iommu/amd/init.c      | 42 +++++++++++++++++++++++++++++++++++
 include/linux/amd-iommu.h     |  4 ++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1b945d47741c..84e5bb1bf01b 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -140,4 +140,6 @@ extern struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 
 extern u64 amd_iommu_efr;
 extern u64 amd_iommu_efr2;
+
+extern bool amd_iommu_snp_en;
 #endif
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 2f338c8c3d10..1dd1c2b25898 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -168,6 +168,10 @@ static int amd_iommu_target_ivhd_type;
 u64 amd_iommu_efr;
 u64 amd_iommu_efr2;
 
+/* SNP is enabled on the system? */
+bool amd_iommu_snp_en;
+EXPORT_SYMBOL(amd_iommu_snp_en);
+
 LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
 					   system */
@@ -3553,3 +3557,41 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64
 
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
+	amd_iommu_snp_en = check_feature_on_all_iommus(FEATURE_SNP);
+	if (!amd_iommu_snp_en)
+		return -EINVAL;
+
+	pr_info("SNP enabled\n");
+
+	/* Enforce IOMMU v1 pagetable when SNP is enabled. */
+	if (amd_iommu_pgtable != AMD_IOMMU_V1) {
+		pr_warn("Force to using AMD IOMMU v1 page table due to SNP\n");
+		amd_iommu_pgtable = AMD_IOMMU_V1;
+	}
+
+	return 0;
+}
+#endif
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

