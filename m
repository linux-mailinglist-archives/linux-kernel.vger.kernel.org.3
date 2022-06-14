Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1F554A73A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 05:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbiFNC7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 22:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355562AbiFNC6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 22:58:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C22F38F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655175353; x=1686711353;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L3qriFSIL9Rs/CZrpXk8fQv7+QTkDASTys7GisGLWzc=;
  b=ENIpEzokfjnPp0HAjHc14AUBnZzrp+EK33BvFOCwAJSM/cbT/xTQoUMa
   ZVRgjDmYXz5PZG1WVMhhZOYa2YUbMJ2YRz4KJGSXrEkh135eo7IPon7rY
   Y/qnKZsQKRkKKe1RxVIYTjDx1vhP5WHh5oDqQIhX4q425RCFtaxdjXC5l
   jrYA6GQrp5k0vLpB3NnVorLpavG0uouZBqU3si11k7RFjmkYhd+afxRuc
   v2nuAQbZntdQZTuMSEGrI7s0JzpVshULAJczgQQO3z0jNBUu5cthRGwrS
   QgNmaYdnDbs4QUbhLezHGWhsOz0VoJdzCKgDILrNIB7p21GPoSQGaLNkU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258930348"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="258930348"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 19:55:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="588166546"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2022 19:55:50 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 06/12] iommu/vt-d: Acquiring lock in domain ID allocation helpers
Date:   Tue, 14 Jun 2022 10:51:31 +0800
Message-Id: <20220614025137.1632762-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu->lock is used to protect the per-IOMMU domain ID resource.
Moving the lock into the ID alloc/free helpers makes the code more
compact. At the same time, the device_domain_lock is irrelevant to
the domain ID resource, remove its assertion as well.

On the other hand, the iommu->lock is never used in interrupt context,
there's no need to use the irqsave variant of the spinlock calls.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index b2ef8af0c3f3..8fdaa01ef10d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1782,16 +1782,13 @@ static struct dmar_domain *alloc_domain(unsigned int type)
 	return domain;
 }
 
-/* Must be called with iommu->lock */
 static int domain_attach_iommu(struct dmar_domain *domain,
 			       struct intel_iommu *iommu)
 {
 	unsigned long ndomains;
-	int num;
-
-	assert_spin_locked(&device_domain_lock);
-	assert_spin_locked(&iommu->lock);
+	int num, ret = 0;
 
+	spin_lock(&iommu->lock);
 	domain->iommu_refcnt[iommu->seq_id] += 1;
 	if (domain->iommu_refcnt[iommu->seq_id] == 1) {
 		ndomains = cap_ndoms(iommu->cap);
@@ -1800,7 +1797,8 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 		if (num >= ndomains) {
 			pr_err("%s: No free domain ids\n", iommu->name);
 			domain->iommu_refcnt[iommu->seq_id] -= 1;
-			return -ENOSPC;
+			ret = -ENOSPC;
+			goto out_unlock;
 		}
 
 		set_bit(num, iommu->domain_ids);
@@ -1809,7 +1807,9 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 		domain_update_iommu_cap(domain);
 	}
 
-	return 0;
+out_unlock:
+	spin_unlock(&iommu->lock);
+	return ret;
 }
 
 static void domain_detach_iommu(struct dmar_domain *domain,
@@ -1817,9 +1817,7 @@ static void domain_detach_iommu(struct dmar_domain *domain,
 {
 	int num;
 
-	assert_spin_locked(&device_domain_lock);
-	assert_spin_locked(&iommu->lock);
-
+	spin_lock(&iommu->lock);
 	domain->iommu_refcnt[iommu->seq_id] -= 1;
 	if (domain->iommu_refcnt[iommu->seq_id] == 0) {
 		num = domain->iommu_did[iommu->seq_id];
@@ -1827,6 +1825,7 @@ static void domain_detach_iommu(struct dmar_domain *domain,
 		domain_update_iommu_cap(domain);
 		domain->iommu_did[iommu->seq_id] = 0;
 	}
+	spin_unlock(&iommu->lock);
 }
 
 static inline int guestwidth_to_adjustwidth(int gaw)
@@ -2479,9 +2478,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 
 	spin_lock_irqsave(&device_domain_lock, flags);
 	info->domain = domain;
-	spin_lock(&iommu->lock);
 	ret = domain_attach_iommu(domain, iommu);
-	spin_unlock(&iommu->lock);
 	if (ret) {
 		spin_unlock_irqrestore(&device_domain_lock, flags);
 		return ret;
@@ -4166,7 +4163,6 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 {
 	struct dmar_domain *domain;
 	struct intel_iommu *iommu;
-	unsigned long flags;
 
 	assert_spin_locked(&device_domain_lock);
 
@@ -4187,10 +4183,7 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	}
 
 	list_del(&info->link);
-
-	spin_lock_irqsave(&iommu->lock, flags);
 	domain_detach_iommu(domain, iommu);
-	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
 static void dmar_remove_one_dev_info(struct device *dev)
-- 
2.25.1

