Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C084F49A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443483AbiDEWU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357369AbiDELQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:16:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B28172DAAA;
        Tue,  5 Apr 2022 03:41:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EBA11515;
        Tue,  5 Apr 2022 03:41:19 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 15C4E3F5A1;
        Tue,  5 Apr 2022 03:41:17 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, baolu.lu@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
Cc:     iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com, hch@lst.de
Subject: [PATCH v3 4/4] iommu/amd: Indicate whether DMA remap support is enabled
Date:   Tue,  5 Apr 2022 11:41:04 +0100
Message-Id: <674846bcefe8d85c1c4675cabaf507f09ab45514.1649089693.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1649089693.git.robin.murphy@arm.com>
References: <cover.1649089693.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

Bit 1 of the IVFS IVInfo field indicates that IOMMU has been used for
pre-boot DMA protection.

Export this capability to allow other places in the kernel to be able to
check for it on AMD systems.

Link: https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v4: Added to series from previous posting here:
https://lore.kernel.org/linux-iommu/20220318223104.7049-1-mario.limonciello@amd.com/

 drivers/iommu/amd/amd_iommu_types.h | 4 ++++
 drivers/iommu/amd/init.c            | 3 +++
 drivers/iommu/amd/iommu.c           | 2 ++
 3 files changed, 9 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 47108ed44fbb..72d0f5e2f651 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -407,6 +407,7 @@
 /* IOMMU IVINFO */
 #define IOMMU_IVINFO_OFFSET     36
 #define IOMMU_IVINFO_EFRSUP     BIT(0)
+#define IOMMU_IVINFO_DMA_REMAP  BIT(1)
 
 /* IOMMU Feature Reporting Field (for IVHD type 10h */
 #define IOMMU_FEAT_GASUP_SHIFT	6
@@ -449,6 +450,9 @@ extern struct irq_remap_table **irq_lookup_table;
 /* Interrupt remapping feature used? */
 extern bool amd_iommu_irq_remap;
 
+/* IVRS indicates that pre-boot remapping was enabled */
+extern bool amdr_ivrs_remap_support;
+
 /* kmem_cache to get tables with 128 byte alignement */
 extern struct kmem_cache *amd_iommu_irq_cache;
 
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index b4a798c7b347..0467918bf7fd 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -182,6 +182,7 @@ u32 amd_iommu_max_pasid __read_mostly = ~0;
 
 bool amd_iommu_v2_present __read_mostly;
 static bool amd_iommu_pc_present __read_mostly;
+bool amdr_ivrs_remap_support __read_mostly;
 
 bool amd_iommu_force_isolation __read_mostly;
 
@@ -326,6 +327,8 @@ static void __init early_iommu_features_init(struct amd_iommu *iommu,
 {
 	if (amd_iommu_ivinfo & IOMMU_IVINFO_EFRSUP)
 		iommu->features = h->efr_reg;
+	if (amd_iommu_ivinfo & IOMMU_IVINFO_DMA_REMAP)
+		amdr_ivrs_remap_support = true;
 }
 
 /* Access to l1 and l2 indexed register spaces */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e412a50dce59..81305c076de1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2141,6 +2141,8 @@ static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
 		return (irq_remapping_enabled == 1);
 	case IOMMU_CAP_NOEXEC:
 		return false;
+	case IOMMU_CAP_PRE_BOOT_PROTECTION:
+		return amdr_ivrs_remap_support;
 	default:
 		break;
 	}
-- 
2.28.0.dirty

