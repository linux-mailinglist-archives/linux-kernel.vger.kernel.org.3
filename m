Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5B155F997
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiF2HwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiF2HwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:52:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2593969A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656489125; x=1688025125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4dG8u4WuqlreDbxvltEqLapsgzPYKKWe1Wl/fUnZ9aQ=;
  b=D8PQMHv4ZvAd5XBnhYu8EABnsbxJpfhTkDnTWmSZaWbidYTewv9Wcc62
   3OJedp6NoHlwyAYRnq5uS2zs6SvqzUU5I6pistr0kfw2hdm0qWqlIg9Sa
   McSTKMoMQku85YtY57imMnwQ0JrR8Y60TNXHkSgqCgY14q+bKs2gwKjdE
   RpdKCS3yMPQz+OFVFl07F8G1sLM8T4zXqsxsJi3VSZIrDMk4kcegWgKIw
   lgThQXNp2FVW3WwLg+YRoUsKZHUUZ794OCHggYvKXxKomUdPJOSt5rYWu
   +31SrQ0C6cZOPwKy2XSoPxu2fwKW23aUBZ6nJzLN4nwvcoSR+af2u7SxT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="270719430"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="270719430"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 00:52:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="588209662"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 29 Jun 2022 00:52:03 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org, iommu@lists.linux.dev
Cc:     Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 06/11] iommu/vt-d: Acquiring lock in domain ID allocation helpers
Date:   Wed, 29 Jun 2022 15:47:20 +0800
Message-Id: <20220629074725.2331441-7-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
---
 drivers/iommu/intel/iommu.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a81bdddf1091..5681b8ef11f1 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1781,16 +1781,13 @@ static struct dmar_domain *alloc_domain(unsigned int type)
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
@@ -1799,7 +1796,8 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 		if (num >= ndomains) {
 			pr_err("%s: No free domain ids\n", iommu->name);
 			domain->iommu_refcnt[iommu->seq_id] -= 1;
-			return -ENOSPC;
+			ret = -ENOSPC;
+			goto out_unlock;
 		}
 
 		set_bit(num, iommu->domain_ids);
@@ -1808,7 +1806,9 @@ static int domain_attach_iommu(struct dmar_domain *domain,
 		domain_update_iommu_cap(domain);
 	}
 
-	return 0;
+out_unlock:
+	spin_unlock(&iommu->lock);
+	return ret;
 }
 
 static void domain_detach_iommu(struct dmar_domain *domain,
@@ -1816,9 +1816,7 @@ static void domain_detach_iommu(struct dmar_domain *domain,
 {
 	int num;
 
-	assert_spin_locked(&device_domain_lock);
-	assert_spin_locked(&iommu->lock);
-
+	spin_lock(&iommu->lock);
 	domain->iommu_refcnt[iommu->seq_id] -= 1;
 	if (domain->iommu_refcnt[iommu->seq_id] == 0) {
 		num = domain->iommu_did[iommu->seq_id];
@@ -1826,6 +1824,7 @@ static void domain_detach_iommu(struct dmar_domain *domain,
 		domain_update_iommu_cap(domain);
 		domain->iommu_did[iommu->seq_id] = 0;
 	}
+	spin_unlock(&iommu->lock);
 }
 
 static inline int guestwidth_to_adjustwidth(int gaw)
@@ -2477,9 +2476,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
 
 	spin_lock_irqsave(&device_domain_lock, flags);
 	info->domain = domain;
-	spin_lock(&iommu->lock);
 	ret = domain_attach_iommu(domain, iommu);
-	spin_unlock(&iommu->lock);
 	if (ret) {
 		spin_unlock_irqrestore(&device_domain_lock, flags);
 		return ret;
@@ -4183,10 +4180,7 @@ static void __dmar_remove_one_dev_info(struct device_domain_info *info)
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

