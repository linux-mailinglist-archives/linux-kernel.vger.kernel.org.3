Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64F84B0D93
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241518AbiBJM3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:29:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241204AbiBJM3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:29:09 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F46C21B8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:29:10 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBE11113E;
        Thu, 10 Feb 2022 04:29:09 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2229C3F73B;
        Thu, 10 Feb 2022 04:29:09 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        baolu.lu@linux.intel.com
Subject: [PATCH] iommu: Remove trivial ops->capable implementations
Date:   Thu, 10 Feb 2022 12:29:05 +0000
Message-Id: <8413578c6f8a7cf75530b00cba8f10f5b88f8517.1644495614.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
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

Implementing ops->capable to always return false is pointless since it's
the default behaviour anyway. Clean up the unnecessary implementations.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Spinning this out of my bus ops stuff (currently 30 patches and
counting...) since it would be better off alongside Baolu's cleanup
series to avoid conflicts, and I want to depend on those patches for
dev_iommu_ops() anyway.

 drivers/iommu/msm_iommu.c  | 6 ------
 drivers/iommu/tegra-gart.c | 6 ------
 drivers/iommu/tegra-smmu.c | 6 ------
 3 files changed, 18 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 06bde6b66732..22061ddbd5df 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -558,11 +558,6 @@ static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
 	return ret;
 }
 
-static bool msm_iommu_capable(enum iommu_cap cap)
-{
-	return false;
-}
-
 static void print_ctx_regs(void __iomem *base, int ctx)
 {
 	unsigned int fsr = GET_FSR(base, ctx);
@@ -672,7 +667,6 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
 }
 
 static struct iommu_ops msm_iommu_ops = {
-	.capable = msm_iommu_capable,
 	.domain_alloc = msm_iommu_domain_alloc,
 	.domain_free = msm_iommu_domain_free,
 	.attach_dev = msm_iommu_attach_dev,
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 6a358f92c7e5..bbd287d19324 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -238,11 +238,6 @@ static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
 	return pte & GART_PAGE_MASK;
 }
 
-static bool gart_iommu_capable(enum iommu_cap cap)
-{
-	return false;
-}
-
 static struct iommu_device *gart_iommu_probe_device(struct device *dev)
 {
 	if (!dev_iommu_fwspec_get(dev))
@@ -276,7 +271,6 @@ static void gart_iommu_sync(struct iommu_domain *domain,
 }
 
 static const struct iommu_ops gart_iommu_ops = {
-	.capable	= gart_iommu_capable,
 	.domain_alloc	= gart_iommu_domain_alloc,
 	.domain_free	= gart_iommu_domain_free,
 	.attach_dev	= gart_iommu_attach_dev,
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index e900e3c46903..43df44f918a1 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -272,11 +272,6 @@ static void tegra_smmu_free_asid(struct tegra_smmu *smmu, unsigned int id)
 	clear_bit(id, smmu->asids);
 }
 
-static bool tegra_smmu_capable(enum iommu_cap cap)
-{
-	return false;
-}
-
 static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 {
 	struct tegra_smmu_as *as;
@@ -967,7 +962,6 @@ static int tegra_smmu_of_xlate(struct device *dev,
 }
 
 static const struct iommu_ops tegra_smmu_ops = {
-	.capable = tegra_smmu_capable,
 	.domain_alloc = tegra_smmu_domain_alloc,
 	.domain_free = tegra_smmu_domain_free,
 	.attach_dev = tegra_smmu_attach_dev,
-- 
2.28.0.dirty

