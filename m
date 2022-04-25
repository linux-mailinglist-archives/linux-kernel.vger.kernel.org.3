Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B677950E09B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241953AbiDYMpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241947AbiDYMp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:45:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 034C7DB0D6;
        Mon, 25 Apr 2022 05:42:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C37B911FB;
        Mon, 25 Apr 2022 05:42:21 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5BFC73F5A1;
        Mon, 25 Apr 2022 05:42:20 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org
Cc:     baolu.lu@linux.intel.com, andreas.noever@gmail.com,
        michael.jamet@intel.com, mika.westerberg@linux.intel.com,
        YehezkelShB@gmail.com, iommu@lists.linux-foundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, hch@lst.de
Subject: [PATCH v4 4/4] iommu/amd: Indicate whether DMA remap support is enabled
Date:   Mon, 25 Apr 2022 13:42:05 +0100
Message-Id: <ce7627fa1c596878ca6515dd9d4381a45b6ee38c.1650878781.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.35.3.dirty
In-Reply-To: <cover.1650878781.git.robin.murphy@arm.com>
References: <cover.1650878781.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v4: No change

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
index a1ada7bff44e..991f10ce350e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2162,6 +2162,8 @@ static bool amd_iommu_capable(enum iommu_cap cap)
 		return (irq_remapping_enabled == 1);
 	case IOMMU_CAP_NOEXEC:
 		return false;
+	case IOMMU_CAP_PRE_BOOT_PROTECTION:
+		return amdr_ivrs_remap_support;
 	default:
 		break;
 	}
-- 
2.35.3.dirty

