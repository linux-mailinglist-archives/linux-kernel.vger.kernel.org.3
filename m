Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F16573FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiGMW5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiGMW5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:57:20 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880684F66B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:57:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRx8MtGyo3u+89hfNW8tOh/qjjuoa7DdP7YIN9aG9AjwDSDwkHoDMSBFd9OrcOgE9Aw6Z6FGkalxv+xBot3RzoWvxmuSvyaaUlNTmibwah+BNlvgc90V9cEZLHnmULyMcvZ7LlIRZQihG5q9j0GVkrMbrhxFIBd8K1qjFdhq9CL1TsEvrfSuN5am4aNidJhqCT/h3QWh5f/g0jyTwrgsQdJEaf5+/gPls1eRH4k31iIvP3iKDEcVIpnJxLlhW57mDRJPE1MAyzqGH0Np17wziIGfj3RrePOfqg5BGaevy7UIKh0p13LrhJfSfA/ZjFG7aKecRPaOc+URUVlWT7gN4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZEm+UAH24b0q2b9Q+/RLJN4DBSZgEBMNp3yqlweJJ4=;
 b=f80qhZ/kh52XTwnsHSkXKT4xIBtOQZYmV31xf1Q4eVdRJqaKyUx2apZE9b7GB1koIhIRssUdNaqx/wqqMnEr4BE4WUTxeYEqT/12AVrjoHfOvuUdWoSLAO5IiwZnKJpGYpfBmd7jy/ZgsyC4WVn3nHEuDhP8uyaLRSrQijhd8f5VGPjTNMIVFHHlmHcHn8kcWhZB6l0FDdRpo2pN4CpeYT+rmA2FWUh97vYvDyb06sdRtjAjGWFJm9QFB9a6n7iv+TEBotqLpsyRYknkkT4rjiscpLEZGs0nb41mVfTNDFUcjMlOCYUvek3Ro6T2F4uWOCGkC+h1Fn6YhmhEEVIQ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZEm+UAH24b0q2b9Q+/RLJN4DBSZgEBMNp3yqlweJJ4=;
 b=0Ez3ThGBTYK0MEAPzWpkFPDHALSNhL6Xo6Llb066xMZsR6yJvw6gaLPOx9DoDxVOMnz6uhylJISc6xCWGLdDhERCICjXTtXP4tEZ3yY1WpUmDMKKmDr89JP4lBI5eEyzV0UHTgiI21tInVOsnepwx3hKHwzIsBzVgYSJC6ka4vo=
Received: from BN8PR15CA0047.namprd15.prod.outlook.com (2603:10b6:408:80::24)
 by DS7PR12MB6008.namprd12.prod.outlook.com (2603:10b6:8:7f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 22:57:14 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::ef) by BN8PR15CA0047.outlook.office365.com
 (2603:10b6:408:80::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Wed, 13 Jul 2022 22:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 22:57:13 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 13 Jul
 2022 17:57:09 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
        <ashish.kalra@amd.com>, <jon.grimm@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 4/9] iommu/amd: Process all IVHDs before enabling IOMMU features
Date:   Wed, 13 Jul 2022 17:56:46 -0500
Message-ID: <20220713225651.20758-5-suravee.suthikulpanit@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 44ed8d58-8409-45d8-ac63-08da652306a8
X-MS-TrafficTypeDiagnostic: DS7PR12MB6008:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7s43bRthSUf4dKjLzL2flhrkLanS0GEoPcyga+VttqaSEvf++E/BpBPWo1XxBtLw4i9ATKDS0AuiSNfRddD25mcvg7XwSrg45r5z5vxCumhWNRPJ/nrE160i1DNq+UpV66dYPknx1wbaPtFDc1q+CtUNFGymZ/PR8fPFyAyUguhoL9kKmFICqduVegbYa7CFbsEsbA8W1vaYmuhyC3iwwanR8+yZR71mfHjnrJpNm3aRSrMmdg9LiL6uLgcd772yHQ8kvTAGVUFmgKwrip03JOCm2rYTTQWXMo8lPSrAQR5RxmbLXehK8L+Tww6kFfuw3eZB6iKow1FjAPlwo5GDyG5C5/v6Nqk5euW8o1lGYcHFrwePK0sx58EGhL2StcBHi718/AF7Hwp0BTAA4JjGw0ETIL94+U7UfDU9TvnBf5iDTT7hwXLye75rXhgywIaqh5DBv3jPo9Nse3HBxuLs3jxKy2QuPthu4H+e5FjbljfdGYKpbm+FQZPCdliabAdKFZX50SY2ANn55uaLCoKRNaBetCIC5W+CioslldtGFh6O4ekFH26OminisF7gmNJ72vs2hFv7kSckNGIxcteo+BPQs0Tbc9hLHAkw8TXniQaAbU4zDRh2OjPzzxZOcICVvqjKm2WI6rXt1KHIXHJ4+dp9d6Zbwg3gtyQ3UlJU4x2sgKxUXysNdAvyJgyktkDN2/uM4zPbgLT8pC3j0heFxApJc6fD6XOLfVAU027JR7LplSTfiF/Xix4hFPzlWmyvqfJMUg0/cN80BKiGpk3cYz69jZ8Na99kMfNWARZlMA3WTJqx3OlDmdWLq02ZkzPcsX/jEoA7Zx7g5grX67dwBzzVM633Gx9g2otjSJUM3Go=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(136003)(396003)(376002)(40470700004)(46966006)(36840700001)(82740400003)(186003)(16526019)(47076005)(426003)(40460700003)(81166007)(83380400001)(86362001)(54906003)(36860700001)(8676002)(2906002)(336012)(40480700001)(4326008)(70206006)(110136005)(36756003)(70586007)(2616005)(8936002)(316002)(478600001)(356005)(5660300002)(6666004)(41300700001)(1076003)(7696005)(82310400005)(44832011)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 22:57:13.5699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ed8d58-8409-45d8-ac63-08da652306a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACPI IVRS table can contain multiple IVHD blocks. Each block contains
information used to initialize each IOMMU instance.

Currently, init_iommu_all sequentially process IVHD block and initialize
IOMMU instance one-by-one. However, certain features require all IOMMUs
to be configured in the same way system-wide. In case certain IVHD blocks
contain inconsistent information (most likely FW bugs), the driver needs
to go through and try to revert settings on IOMMUs that have already been
configured.

A solution is to split IOMMU initialization into 3 phases:

Phase1 : Processes information of the IVRS table for all IOMMU instances.
This allow all IVHDs to be processed prior to enabling features.

Phase2 : Early feature support check on all IOMMUs (using information in
IVHD blocks.

Phase3 : Iterates through all IOMMU instances and enabling features.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 741fee1abfc4..a0f4b5bbd98c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1721,7 +1721,6 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 				 struct acpi_table_header *ivrs_base)
 {
 	struct amd_iommu_pci_seg *pci_seg;
-	int ret;
 
 	pci_seg = get_pci_segment(h->pci_seg, ivrs_base);
 	if (pci_seg == NULL)
@@ -1802,6 +1801,13 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 	if (!iommu->mmio_base)
 		return -ENOMEM;
 
+	return init_iommu_from_acpi(iommu, h);
+}
+
+static int __init init_iommu_one_late(struct amd_iommu *iommu)
+{
+	int ret;
+
 	if (alloc_cwwb_sem(iommu))
 		return -ENOMEM;
 
@@ -1823,10 +1829,6 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 	if (amd_iommu_pre_enabled)
 		amd_iommu_pre_enabled = translation_pre_enabled(iommu);
 
-	ret = init_iommu_from_acpi(iommu, h);
-	if (ret)
-		return ret;
-
 	if (amd_iommu_irq_remap) {
 		ret = amd_iommu_create_irq_domain(iommu);
 		if (ret)
@@ -1837,7 +1839,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 	 * Make sure IOMMU is not considered to translate itself. The IVRS
 	 * table tells us so, but this is a lie!
 	 */
-	pci_seg->rlookup_table[iommu->devid] = NULL;
+	iommu->pci_seg->rlookup_table[iommu->devid] = NULL;
 
 	return 0;
 }
@@ -1882,6 +1884,7 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 	end += table->length;
 	p += IVRS_HEADER_LENGTH;
 
+	/* Phase 1: Process all IVHD blocks */
 	while (p < end) {
 		h = (struct ivhd_header *)p;
 		if (*p == amd_iommu_target_ivhd_type) {
@@ -1907,6 +1910,16 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 	}
 	WARN_ON(p != end);
 
+	/* Phase 2 : Early feature support check */
+	get_global_efr();
+
+	/* Phase 3 : Enabling IOMMU features */
+	for_each_iommu(iommu) {
+		ret = init_iommu_one_late(iommu);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
-- 
2.32.0

