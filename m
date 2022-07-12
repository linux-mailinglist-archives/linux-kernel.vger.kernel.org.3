Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732F1570EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiGLAPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiGLAPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:15:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944A07D793
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584877; x=1689120877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VoY7bFDW0XhDxJcxsRT3+MNmRvmSbnHbKWNookuikwE=;
  b=S6fTdMcqBa+7I7nyU8XMHCz1CMotcS1LlP2ryGZxn6f0hqL9LlEPN5YA
   m6LQiG+UMgyulnAheAlRJbUkxy6I/EDEvAmGqcQpT6q2lVix9XjxUpEhO
   GNdCt0e9YpWRfYg1hxsG5S4vB/1BIYleaqLt5WMTFgx1b9ndlzaLO5502
   4BivNxK+lbPxQ4QN7i7YwMoXGf/h0c+p7dugmkx5A26PRh8c1IIlzFcz4
   AA9Elrns1+IcDuBXXmpwf8mymCPivvHAgIo1zOSr39gJzEjMwQUTAFqmm
   ySxAuYDyiVpMC8geDCypi8xAF0TznOuzR7Agg/WuAtVtZ/XS2ZmXIJbps
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="285929306"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="285929306"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:14:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="592445830"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2022 17:14:03 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 15/25] iommu/vt-d: Acquiring lock in pasid manipulation helpers
Date:   Tue, 12 Jul 2022 08:08:58 +0800
Message-Id: <20220712000908.3431936-16-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
References: <20220712000908.3431936-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu->lock is used to protect the per-IOMMU pasid directory table
and pasid table. Move the spinlock acquisition/release into the helpers
to make the code self-contained.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Link: https://lore.kernel.org/r/20220706025524.2904370-8-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/iommu.c |   2 -
 drivers/iommu/intel/pasid.c | 103 +++++++++++++++++++-----------------
 drivers/iommu/intel/svm.c   |   3 --
 3 files changed, 55 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7f03576e72d7..3d53de8c7634 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -2489,7 +2489,6 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 		}
 
 		/* Setup the PASID entry for requests without PASID: */
-		spin_lock(&iommu->lock);
 		if (hw_pass_through && domain_type_is_si(domain))
 			ret = intel_pasid_setup_pass_through(iommu, domain,
 					dev, PASID_RID2PASID);
@@ -2499,7 +2498,6 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 		else
 			ret = intel_pasid_setup_second_level(iommu, domain,
 					dev, PASID_RID2PASID);
-		spin_unlock(&iommu->lock);
 		if (ret) {
 			dev_err(dev, "Setup RID2PASID failed\n");
 			dmar_remove_one_dev_info(dev);
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 43f090381ec7..7792a1b2ebc4 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -450,17 +450,17 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
 	struct pasid_entry *pte;
 	u16 did, pgtt;
 
+	spin_lock(&iommu->lock);
 	pte = intel_pasid_get_entry(dev, pasid);
-	if (WARN_ON(!pte))
-		return;
-
-	if (!pasid_pte_is_present(pte))
+	if (WARN_ON(!pte) || !pasid_pte_is_present(pte)) {
+		spin_unlock(&iommu->lock);
 		return;
+	}
 
 	did = pasid_get_domain_id(pte);
 	pgtt = pasid_pte_get_pgtt(pte);
-
 	intel_pasid_clear_entry(dev, pasid, fault_ignore);
+	spin_unlock(&iommu->lock);
 
 	if (!ecap_coherent(iommu->ecap))
 		clflush_cache_range(pte, sizeof(*pte));
@@ -496,22 +496,6 @@ static void pasid_flush_caches(struct intel_iommu *iommu,
 	}
 }
 
-static inline int pasid_enable_wpe(struct pasid_entry *pte)
-{
-#ifdef CONFIG_X86
-	unsigned long cr0 = read_cr0();
-
-	/* CR0.WP is normally set but just to be sure */
-	if (unlikely(!(cr0 & X86_CR0_WP))) {
-		pr_err_ratelimited("No CPU write protect!\n");
-		return -EINVAL;
-	}
-#endif
-	pasid_set_wpe(pte);
-
-	return 0;
-};
-
 /*
  * Set up the scalable mode pasid table entry for first only
  * translation type.
@@ -528,39 +512,52 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 		return -EINVAL;
 	}
 
-	pte = intel_pasid_get_entry(dev, pasid);
-	if (WARN_ON(!pte))
+	if (flags & PASID_FLAG_SUPERVISOR_MODE) {
+#ifdef CONFIG_X86
+		unsigned long cr0 = read_cr0();
+
+		/* CR0.WP is normally set but just to be sure */
+		if (unlikely(!(cr0 & X86_CR0_WP))) {
+			pr_err("No CPU write protect!\n");
+			return -EINVAL;
+		}
+#endif
+		if (!ecap_srs(iommu->ecap)) {
+			pr_err("No supervisor request support on %s\n",
+			       iommu->name);
+			return -EINVAL;
+		}
+	}
+
+	if ((flags & PASID_FLAG_FL5LP) && !cap_5lp_support(iommu->cap)) {
+		pr_err("No 5-level paging support for first-level on %s\n",
+		       iommu->name);
 		return -EINVAL;
+	}
 
-	/* Caller must ensure PASID entry is not in use. */
-	if (pasid_pte_is_present(pte))
+	spin_lock(&iommu->lock);
+	pte = intel_pasid_get_entry(dev, pasid);
+	if (!pte) {
+		spin_unlock(&iommu->lock);
+		return -ENODEV;
+	}
+
+	if (pasid_pte_is_present(pte)) {
+		spin_unlock(&iommu->lock);
 		return -EBUSY;
+	}
 
 	pasid_clear_entry(pte);
 
 	/* Setup the first level page table pointer: */
 	pasid_set_flptr(pte, (u64)__pa(pgd));
 	if (flags & PASID_FLAG_SUPERVISOR_MODE) {
-		if (!ecap_srs(iommu->ecap)) {
-			pr_err("No supervisor request support on %s\n",
-			       iommu->name);
-			return -EINVAL;
-		}
 		pasid_set_sre(pte);
-		if (pasid_enable_wpe(pte))
-			return -EINVAL;
-
+		pasid_set_wpe(pte);
 	}
 
-	if (flags & PASID_FLAG_FL5LP) {
-		if (cap_5lp_support(iommu->cap)) {
-			pasid_set_flpm(pte, 1);
-		} else {
-			pr_err("No 5-level paging support for first-level\n");
-			pasid_clear_entry(pte);
-			return -EINVAL;
-		}
-	}
+	if (flags & PASID_FLAG_FL5LP)
+		pasid_set_flpm(pte, 1);
 
 	if (flags & PASID_FLAG_PAGE_SNOOP)
 		pasid_set_pgsnp(pte);
@@ -572,6 +569,8 @@ int intel_pasid_setup_first_level(struct intel_iommu *iommu,
 	/* Setup Present and PASID Granular Transfer Type: */
 	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_FL_ONLY);
 	pasid_set_present(pte);
+	spin_unlock(&iommu->lock);
+
 	pasid_flush_caches(iommu, pte, pasid, did);
 
 	return 0;
@@ -629,15 +628,17 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	pgd_val = virt_to_phys(pgd);
 	did = domain->iommu_did[iommu->seq_id];
 
+	spin_lock(&iommu->lock);
 	pte = intel_pasid_get_entry(dev, pasid);
 	if (!pte) {
-		dev_err(dev, "Failed to get pasid entry of PASID %d\n", pasid);
+		spin_unlock(&iommu->lock);
 		return -ENODEV;
 	}
 
-	/* Caller must ensure PASID entry is not in use. */
-	if (pasid_pte_is_present(pte))
+	if (pasid_pte_is_present(pte)) {
+		spin_unlock(&iommu->lock);
 		return -EBUSY;
+	}
 
 	pasid_clear_entry(pte);
 	pasid_set_domain_id(pte, did);
@@ -654,6 +655,8 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
 	if (pasid != PASID_RID2PASID)
 		pasid_set_sre(pte);
 	pasid_set_present(pte);
+	spin_unlock(&iommu->lock);
+
 	pasid_flush_caches(iommu, pte, pasid, did);
 
 	return 0;
@@ -669,15 +672,17 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 	u16 did = FLPT_DEFAULT_DID;
 	struct pasid_entry *pte;
 
+	spin_lock(&iommu->lock);
 	pte = intel_pasid_get_entry(dev, pasid);
 	if (!pte) {
-		dev_err(dev, "Failed to get pasid entry of PASID %d\n", pasid);
+		spin_unlock(&iommu->lock);
 		return -ENODEV;
 	}
 
-	/* Caller must ensure PASID entry is not in use. */
-	if (pasid_pte_is_present(pte))
+	if (pasid_pte_is_present(pte)) {
+		spin_unlock(&iommu->lock);
 		return -EBUSY;
+	}
 
 	pasid_clear_entry(pte);
 	pasid_set_domain_id(pte, did);
@@ -692,6 +697,8 @@ int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
 	 */
 	pasid_set_sre(pte);
 	pasid_set_present(pte);
+	spin_unlock(&iommu->lock);
+
 	pasid_flush_caches(iommu, pte, pasid, did);
 
 	return 0;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 82288a50660d..64072e628bbd 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -394,11 +394,8 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
 	sflags = (flags & SVM_FLAG_SUPERVISOR_MODE) ?
 			PASID_FLAG_SUPERVISOR_MODE : 0;
 	sflags |= cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
-	spin_lock(&iommu->lock);
 	ret = intel_pasid_setup_first_level(iommu, dev, mm->pgd, mm->pasid,
 					    FLPT_DEFAULT_DID, sflags);
-	spin_unlock(&iommu->lock);
-
 	if (ret)
 		goto free_sdev;
 
-- 
2.25.1

