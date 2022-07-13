Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A64573FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiGMW5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGMW5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:57:18 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E594F68C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:57:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SG36u+RoO97b9f74wj4xDlEryoJc4lQBR8eWqQcSziEG2v9Sc4nHPNY7Q8d3ltfS6ljzHdYJWmmaAx84yGOjKuz0PPLyGnXwgWgBgnVTECqYsWFwL/tsMqkHPiDKTmFVMm2dQMHvWAPwG1ehyG6yiw/MfIIDQflG1zZJFnVsbeY5JkiJdze4FBx66JSUXMlta9sZTwTKu0SOBhHs9bROqhX3ufvMBshc4HIdiFOTTENBoaq1Sjxw8wGDKpozcVgH5VGr7MEt7i+w1JFv6Ex4TJxN/cQIht/kOZW8Q5and/h/MzWVa2sXiXjXb9aJ4TyTWJ5C8iEr328uzkF+TPgrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LewIl7eqUWEQyB4Fqj4nrwqpbV+qMJOiMTu4eY/ZKL8=;
 b=GViU9ckf31GzCqugqMlgxGKJShjOphGyvjCRvg7K1ZHuEDxXISaVziog2sPEmLQMrek0seNsOhhWyNW3HfmfkDDnQ5E8NHbSyvPO0bIZnR9ExWRjVEwc6FUOmkCvBXspw9FSkF/4ax6GdEbQykQ5nr8Zf010lMbbhvNnxSzXPCO8t3AFSIcNxFdwpsoe9fa54fSw5UxBj8zZ5rYOS2+tah0xobEGuLJFGFwbJ4kmZqx5MF1g/dEeH2htOKcdxf+2nVEBOKOXJFaZfQuPSzuxKoBbuot/vgIBwOK4ATJClVVNqM36mg1tFstyOpnyN7rGIyd1OwDre6p/vPAimivflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LewIl7eqUWEQyB4Fqj4nrwqpbV+qMJOiMTu4eY/ZKL8=;
 b=Bv//sTNdaW05un7nKbHbTraApu0UkXajqKO9KFYx1K6ys94i5/Zx052Ksz3iDO5zeeTIh60MbUJvVC7HxJBzvnrwKf8jECTYAC+ABMypIs9eROq8a32yEXerl14NUiGxxRuUl9GSgM9WUG15N9MCKm7Z8LRpLt0u+y6aaQwzAVQ=
Received: from BN9PR03CA0536.namprd03.prod.outlook.com (2603:10b6:408:131::31)
 by MWHPR12MB1216.namprd12.prod.outlook.com (2603:10b6:300:10::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 22:57:12 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::74) by BN9PR03CA0536.outlook.office365.com
 (2603:10b6:408:131::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21 via Frontend
 Transport; Wed, 13 Jul 2022 22:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 22:57:12 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 13 Jul
 2022 17:57:08 -0500
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC:     <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
        <ashish.kalra@amd.com>, <jon.grimm@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 2/9] iommu/amd: Introduce Support for Extended Feature 2 Register
Date:   Wed, 13 Jul 2022 17:56:44 -0500
Message-ID: <20220713225651.20758-3-suravee.suthikulpanit@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3f6d4286-053f-432b-5c91-08da65230614
X-MS-TrafficTypeDiagnostic: MWHPR12MB1216:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H0uBxr/o4S0CVty1mglZ/9JxuyVjlQgdC7hHSXgDpKLAjoRz+86tXfqBW4jsa64eapqJXowWwF/XA27J5royY7rn29pYdjzunGx8SyteKzyE5sxyuXcDcBG/rhYq/gcwU5o+G5br8d/L0oxG/nwkBs7TmZ86MBlTPHo0om2FA6mSzma0++LzDjr9aHPvfesciXJSFUF9I/nHRfUVsxm2/tVlxYL38W9jZzvTESpboR0aejRx3dIx2ZpwE/IROrAirnboEM7jIst5aSt0rUfg8uc+gwMve6WVpX9IMUHICKCQkaGIXj/motrJOgWUgF1iKxj2Ulwf9bXNjiuKj+HoVg1lEbjdwcqIU2ycho4N01+i0xEGx+of12lX+e9MX+eMTOJlTxXfzOYZZ0mPnCxEDhGTqqfrxNQa0zxnL2IlQqG3PugH46gY2s7t71AfPluNqkqtHyuGA5LiWDP8maKrE6y6kNHxLjDCagC6bUyXI1jNoUfebEsq1/Lawg17ciK5MFlwjW4Q66Y8tJn5SABTole0B1aI9rg7ffsHwj8BYX3NKsu8BPjbQftcbqTPGGhMd5R//PKjEgH+LBayMPrJlXjbci9NDQoiZOSa+o3z5aHf/bljWMEm9UjN8M0gh/puS2G1MyHMw/Pdn0V6ackJStFzyS56vo9u3H5D//DrOzCrp7IkPGHkUCkB+gDxEG/JBGi/pygdP42AUlYpBSSTpFYT383j9rP0VeGRoLblRkAjhGBP1bcRMB4UhWhRIQc2+cmc4GXcu4d3BYa0MoNTKdUklTAQzd3DcY6gLpu+0b0766MLcEqDZYOmWX97RLaGML7YIo1Li+XZRuq4G9nnimtWNFDfA5TeDF33VKy8d7A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(39860400002)(40470700004)(46966006)(36840700001)(36860700001)(8936002)(8676002)(4326008)(110136005)(478600001)(40480700001)(36756003)(54906003)(316002)(5660300002)(83380400001)(44832011)(82740400003)(7696005)(47076005)(81166007)(356005)(1076003)(70206006)(26005)(2616005)(82310400005)(86362001)(426003)(16526019)(186003)(40460700003)(41300700001)(336012)(2906002)(6666004)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 22:57:12.5823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6d4286-053f-432b-5c91-08da65230614
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1216
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD IOMMU spec introduces additional extended feature register
in the IVRS IVHD offset 80h (for IVHD type 11h and 40h) and MMIO
offset 1A0h.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  4 ++++
 drivers/iommu/amd/init.c            | 24 ++++++++++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 7c830e3c7a91..3c1205ba636a 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -67,6 +67,7 @@
 #define MMIO_INTCAPXT_EVT_OFFSET	0x0170
 #define MMIO_INTCAPXT_PPR_OFFSET	0x0178
 #define MMIO_INTCAPXT_GALOG_OFFSET	0x0180
+#define MMIO_EXT_FEATURES2	0x01A0
 #define MMIO_CMD_HEAD_OFFSET	0x2000
 #define MMIO_CMD_TAIL_OFFSET	0x2008
 #define MMIO_EVT_HEAD_OFFSET	0x2010
@@ -645,6 +646,9 @@ struct amd_iommu {
 	/* Extended features */
 	u64 features;
 
+	/* Extended features 2 */
+	u64 features2;
+
 	/* IOMMUv2 */
 	bool is_iommu_v2;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 3c82d9c5f1c0..92ab02f6c5dc 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -114,7 +114,7 @@ struct ivhd_header {
 
 	/* Following only valid on IVHD type 11h and 40h */
 	u64 efr_reg; /* Exact copy of MMIO_EXT_FEATURES */
-	u64 res;
+	u64 efr_reg2;
 } __attribute__((packed));
 
 /*
@@ -283,8 +283,10 @@ static bool check_feature_on_all_iommus(u64 mask)
 static void __init early_iommu_features_init(struct amd_iommu *iommu,
 					     struct ivhd_header *h)
 {
-	if (amd_iommu_ivinfo & IOMMU_IVINFO_EFRSUP)
+	if (amd_iommu_ivinfo & IOMMU_IVINFO_EFRSUP) {
 		iommu->features = h->efr_reg;
+		iommu->features2 = h->efr_reg2;
+	}
 	if (amd_iommu_ivinfo & IOMMU_IVINFO_DMA_REMAP)
 		amdr_ivrs_remap_support = true;
 }
@@ -1912,7 +1914,7 @@ static ssize_t amd_iommu_show_features(struct device *dev,
 				       char *buf)
 {
 	struct amd_iommu *iommu = dev_to_amd_iommu(dev);
-	return sprintf(buf, "%llx\n", iommu->features);
+	return sprintf(buf, "%llx:%llx\n", iommu->features2, iommu->features);
 }
 static DEVICE_ATTR(features, S_IRUGO, amd_iommu_show_features, NULL);
 
@@ -1939,16 +1941,18 @@ static const struct attribute_group *amd_iommu_groups[] = {
  */
 static void __init late_iommu_features_init(struct amd_iommu *iommu)
 {
-	u64 features;
+	u64 features, features2;
 
 	if (!(iommu->cap & (1 << IOMMU_CAP_EFR)))
 		return;
 
 	/* read extended feature bits */
 	features = readq(iommu->mmio_base + MMIO_EXT_FEATURES);
+	features2 = readq(iommu->mmio_base + MMIO_EXT_FEATURES2);
 
 	if (!iommu->features) {
 		iommu->features = features;
+		iommu->features2 = features2;
 		return;
 	}
 
@@ -1956,9 +1960,13 @@ static void __init late_iommu_features_init(struct amd_iommu *iommu)
 	 * Sanity check and warn if EFR values from
 	 * IVHD and MMIO conflict.
 	 */
-	if (features != iommu->features)
-		pr_warn(FW_WARN "EFR mismatch. Use IVHD EFR (%#llx : %#llx).\n",
-			features, iommu->features);
+	if (features != iommu->features ||
+	    features2 != iommu->features2) {
+		pr_warn(FW_WARN
+			"EFR mismatch. Use IVHD EFR (%#llx : %#llx), EFR2 (%#llx : %#llx).\n",
+			features, iommu->features,
+			features2, iommu->features2);
+	}
 }
 
 static int __init iommu_init_pci(struct amd_iommu *iommu)
@@ -2080,7 +2088,7 @@ static void print_iommu_info(void)
 		pci_info(pdev, "Found IOMMU cap 0x%x\n", iommu->cap_ptr);
 
 		if (iommu->cap & (1 << IOMMU_CAP_EFR)) {
-			pr_info("Extended features (%#llx):", iommu->features);
+			pr_info("Extended features (%#llx, %#llx):", iommu->features, iommu->features2);
 
 			for (i = 0; i < ARRAY_SIZE(feat_str); ++i) {
 				if (iommu_feature(iommu, (1ULL << i)))
-- 
2.32.0

