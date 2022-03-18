Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0753F4DE027
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 18:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbiCRRob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 13:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239714AbiCRRo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 13:44:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE72E9F3A3;
        Fri, 18 Mar 2022 10:43:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B36D1515;
        Fri, 18 Mar 2022 10:43:08 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 254333F7B4;
        Fri, 18 Mar 2022 10:43:07 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, baolu.lu@linux.intel.com,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
Cc:     iommu@lists.linux-foundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com, hch@lst.de
Subject: [PATCH v2 1/2] iommu: Add capability for pre-boot DMA protection
Date:   Fri, 18 Mar 2022 17:42:57 +0000
Message-Id: <797c70d255f946c4d631f2ffc67f277cfe0cb97c.1647624084.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
In-Reply-To: <cover.1647624084.git.robin.murphy@arm.com>
References: <cover.1647624084.git.robin.murphy@arm.com>
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

VT-d's dmar_platform_optin() actually represents a combination of
properties fairly well standardised by Microsoft as "Pre-boot DMA
Protection" and "Kernel DMA Protection"[1]. As such, we can provide
interested consumers with an abstracted capability rather than
driver-specific interfaces that won't scale. We name it for the former
aspect since that's what external callers are most likely to be
interested in; the latter is for the IOMMU layer to handle itself.

Also use this as an opportunity to draw a line in the sand and add a
new interface so as not to introduce any more callers of iommu_capable()
which I also want to get rid of. For now it's a quick'n'dirty wrapper
function, but will evolve to subsume the internal interface in future.

[1] https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-kernel-dma-protection

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v2: New patch

 drivers/iommu/intel/iommu.c | 2 ++
 include/linux/iommu.h       | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 0c7975848972..20d8e1f60068 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4817,6 +4817,8 @@ static bool intel_iommu_capable(enum iommu_cap cap)
 		return domain_update_iommu_snooping(NULL);
 	if (cap == IOMMU_CAP_INTR_REMAP)
 		return irq_remapping_enabled == 1;
+	if (cap == IOMMU_CAP_PRE_BOOT_PROTECTION)
+		return dmar_platform_optin();
 
 	return false;
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4a25f8241207..e16d54e15fee 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -107,6 +107,8 @@ enum iommu_cap {
 					   transactions */
 	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
 	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
+	IOMMU_CAP_PRE_BOOT_PROTECTION,	/* Firmware says it used the IOMMU for
+					   DMA protection and we should too */
 };
 
 /* These are the possible reserved region types */
@@ -1042,6 +1044,11 @@ static inline size_t iommu_map_sgtable(struct iommu_domain *domain,
 	return iommu_map_sg(domain, iova, sgt->sgl, sgt->orig_nents, prot);
 }
 
+static inline bool dev_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	return device_iommu_mapped(dev) && iommu_capable(dev->bus, cap);
+}
+
 #ifdef CONFIG_IOMMU_DEBUGFS
 extern	struct dentry *iommu_debugfs_dir;
 void iommu_debugfs_setup(void);
-- 
2.28.0.dirty

