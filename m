Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C293535968
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343612AbiE0Gek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343504AbiE0GeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:34:19 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069B7ED791
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 23:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653633257; x=1685169257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9f5hL9z5d19jdu/plR8UsfSukdVmRN5xbUanYDDkUoY=;
  b=BZgdbsN6T3ceyW2k9jmAgO60kV0hx8gOXJcby4YuwJNxyYiWd+1KL/n2
   aqMMx5vtz0hMjifgSa/RFgUOCqTwrnLZhT0eE3qsKYtRIR/h8O7esjmWG
   v0hEqTmFCw6qHpDUo1j6MWak3/qHLfoNLkodAHs+OflIlAcRoxgIB7/1e
   sPcd3k960lPHtnXFj9SaBouowoVRPXYGfCjH9XViq9Wm0yDIFjPQR+1KG
   vPqvjNBoP+glqTkdTvzInR2Ml48LlVlyBAljQKHekTupyGrHuud8sAXgn
   buMkULkCBU7fkIC34ve9wMw3+Xrq8hGQoQd+uuxdCceAodailc+c1N7DY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="335044884"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="335044884"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 23:34:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="718688485"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 23:34:11 -0700
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
Subject: [PATCH 06/12] iommu/vt-d: Acquiring lock in domain ID allocation helpers
Date:   Fri, 27 May 2022 14:30:13 +0800
Message-Id: <20220527063019.3112905-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu->lock is used to protect the per-IOMMU domain ID resource.
Move the spinlock acquisition/release into the helpers where domain
IDs are allocated and freed. The device_domain_lock is irrelevant to
domain ID resources, remove its assertion as well.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 2d5f02b85de8..0da937ce0534 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1774,16 +1774,13 @@ static struct dmar_domain *alloc_domain(unsigned int type)
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
@@ -1792,7 +1789,8 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 		if (num >= ndomains) {
 			pr_err("%s: No free domain ids\n", iommu->name);
 			domain->iommu_refcnt[iommu->seq_id] -= 1;
-			return -ENOSPC;
+			ret = -ENOSPC;
+			goto out_unlock;
 		}
 
 		set_bit(num, iommu->domain_ids);
@@ -1801,7 +1799,9 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 		domain_update_iommu_cap(domain);
 	}
 
-	return 0;
+out_unlock:
+	spin_unlock(&iommu->lock);
+	return ret;
 }
 
 static void domain_detach_iommu(struct dmar_domain *domain,
@@ -1809,9 +1809,7 @@ static void domain_detach_iommu(struct dmar_domain *domain,
 {
 	int num;
 
-	assert_spin_locked(&device_domain_lock);
-	assert_spin_locked(&iommu->lock);
-
+	spin_lock(&iommu->lock);
 	domain->iommu_refcnt[iommu->seq_id] -= 1;
 	if (domain->iommu_refcnt[iommu->seq_id] == 0) {
 		num = domain->iommu_did[iommu->seq_id];
@@ -1819,6 +1817,7 @@ static void domain_detach_iommu(struct dmar_domain *domain,
 		domain_update_iommu_cap(domain);
 		domain->iommu_did[iommu->seq_id] = 0;
 	}
+	spin_unlock(&iommu->lock);
 }
 
 static inline int guestwidth_to_adjustwidth(int gaw)
@@ -2471,9 +2470,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 
 	spin_lock_irqsave(&device_domain_lock, flags);
 	info->domain = domain;
-	spin_lock(&iommu->lock);
 	ret = domain_attach_iommu(domain, iommu);
-	spin_unlock(&iommu->lock);
 	if (ret) {
 		spin_unlock_irqrestore(&device_domain_lock, flags);
 		return ret;
@@ -4158,7 +4155,6 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 {
 	struct dmar_domain *domain;
 	struct intel_iommu *iommu;
-	unsigned long flags;
 
 	assert_spin_locked(&device_domain_lock);
 
@@ -4179,10 +4175,7 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
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

