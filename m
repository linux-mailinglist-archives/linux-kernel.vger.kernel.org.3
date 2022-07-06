Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4ED567C45
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 05:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiGFDA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 23:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiGFDAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 23:00:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E191BE85
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 20:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657076407; x=1688612407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yJXUA+NuM0V10Ayu1Uk2puf2SUIVOwGMq3d3tn/fE84=;
  b=GrGdeQ07LZqKRULEzmb/QK2Uu+MYdfVjWallutsgZPfQEbsolnZuQ/aQ
   Q/KpIKYdlc86W2q+vEjGxr0P7GszAFV6VfZ0bhomUKmCUHoFuT1ExsQjX
   SPU2DDPs7ThRFwia3LtXMR9ZWHlbEzLDc4nMTlwyMD2fuPlwk7eMY3LkU
   V823PK0Khs/pCQBSLAybUkPX9BZDUw7WFd4gK4JPub7H3e7tipIpxezOQ
   rDAYbeSLShVgn4GJyK7ZoEJD/0giTkEaU8jav6T6ADU41wlH1MYooqFV0
   nZEec7534egixYlAZpCCcGfdwknoZBH67YefRGl8pGybDaTaetqN+2wmd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="272409573"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="272409573"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 20:00:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="567875034"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga006.jf.intel.com with ESMTP; 05 Jul 2022 20:00:04 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org, iommu@lists.linux.dev
Cc:     Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 06/11] iommu/vt-d: Acquiring lock in domain ID allocation helpers
Date:   Wed,  6 Jul 2022 10:55:19 +0800
Message-Id: <20220706025524.2904370-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
References: <20220706025524.2904370-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The iommu->lock is used to protect the per-IOMMU domain ID resource.
Moving the lock into the ID alloc/free helpers makes the code more
compact. At the same time, the device_domain_lock is irrelevant to
the domain ID resource, remove its assertion as well.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 93f01082dce1..7f03576e72d7 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1779,16 +1779,13 @@ static struct dmar_domain *alloc_domain(unsigned int type)
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
@@ -1797,7 +1794,8 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 		if (num >= ndomains) {
 			pr_err("%s: No free domain ids\n", iommu->name);
 			domain->iommu_refcnt[iommu->seq_id] -= 1;
-			return -ENOSPC;
+			ret = -ENOSPC;
+			goto out_unlock;
 		}
 
 		set_bit(num, iommu->domain_ids);
@@ -1806,7 +1804,9 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 		domain_update_iommu_cap(domain);
 	}
 
-	return 0;
+out_unlock:
+	spin_unlock(&iommu->lock);
+	return ret;
 }
 
 static void domain_detach_iommu(struct dmar_domain *domain,
@@ -1814,9 +1814,7 @@ static void domain_detach_iommu(struct dmar_domain *domain,
 {
 	int num;
 
-	assert_spin_locked(&device_domain_lock);
-	assert_spin_locked(&iommu->lock);
-
+	spin_lock(&iommu->lock);
 	domain->iommu_refcnt[iommu->seq_id] -= 1;
 	if (domain->iommu_refcnt[iommu->seq_id] == 0) {
 		num = domain->iommu_did[iommu->seq_id];
@@ -1824,6 +1822,7 @@ static void domain_detach_iommu(struct dmar_domain *domain,
 		domain_update_iommu_cap(domain);
 		domain->iommu_did[iommu->seq_id] = 0;
 	}
+	spin_unlock(&iommu->lock);
 }
 
 static inline int guestwidth_to_adjustwidth(int gaw)
@@ -2472,9 +2471,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 
 	spin_lock(&device_domain_lock);
 	info->domain = domain;
-	spin_lock(&iommu->lock);
 	ret = domain_attach_iommu(domain, iommu);
-	spin_unlock(&iommu->lock);
 	if (ret) {
 		spin_unlock(&device_domain_lock);
 		return ret;
@@ -4178,10 +4175,7 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
 	}
 
 	list_del(&info->link);
-
-	spin_lock(&iommu->lock);
 	domain_detach_iommu(domain, iommu);
-	spin_unlock(&iommu->lock);
 }
 
 static void dmar_remove_one_dev_info(struct device *dev)
-- 
2.25.1

