Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE5F5096C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384480AbiDUF2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384444AbiDUF1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:27:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E53CDFC4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 22:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650518682; x=1682054682;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yWorkmiiC890Ep05G/cKMLBSlmy02ohHYOAKjdgnE+g=;
  b=SdyJdcUeDIXQWL5q5sbmugtUeq83aChVmG6iKrg4Pr8+k7BdCKmYhS79
   EB/4DHzHb6oxEmasKLk4TM/vlErI1Ymg0u161+nXYDDR8c1BIOPsmioBz
   jPHa42JQYndRuD0ZKnKmpw1abLRlk87tTpQ2WCWcxcLToLzD3lxNxfTfA
   q999O5IgaA2L1wfl9f9QXvJb8pWdFpzaa15vaw+EQMDfwYDbF/4Uavu/3
   KHF9KRqMJ9eqmiafjFg0lKdQSrTVrSfhxb/gwgHCHlerbcq+dANUdw7QC
   e7sAAjto3UBJznDIq1Ln4qWI57fkQOpg/B1s200bDbKCKqZREg/bHwkEe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="246135717"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="246135717"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 22:24:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="702944181"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 20 Apr 2022 22:24:39 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v4 10/12] iommu: Prepare IOMMU domain for IOPF
Date:   Thu, 21 Apr 2022 13:21:19 +0800
Message-Id: <20220421052121.3464100-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
References: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds some mechanisms around the iommu_domain so that the I/O page
fault handling framework could route a page fault to the domain and
call the fault handler from it.

It includes:

- A reference counter for the iommu domain. The page fault handler is
  a different context from the bind()/unbind() thread. A reference
  counter is added to struct iommu_domain so that the life cycle of
  the iommu_domain could be synced between different threads.

- A pointer to the page fault handler and its private data. The fault
  handler will be called with the private data as a parameter once a
  page fault is routed to the domain. Any kernel component which owns
  an iommu domain could install handler and its parameter so that the
  page fault could be further routed or handled.

This also prepares the SVA implementation to be the first consumer of
the per-domain page fault handling model.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h         | 18 ++++++++++
 drivers/iommu/iommu-sva-lib.c | 68 ++++++++++++++++++++++++++++++++++-
 drivers/iommu/iommu.c         | 29 +++++++++++++++
 3 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 57650b773f3f..4278a6310a7b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -102,6 +102,10 @@ struct iommu_domain {
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
 	struct iommu_sva_ioas *sva_ioas;
+	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
+						      void *data);
+	void *fault_data;
+	refcount_t async_users;
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
@@ -680,6 +684,14 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 			      struct device *dev, ioasid_t pasid);
 void iommu_detach_device_pasid(struct iommu_domain *domain,
 			       struct device *dev, ioasid_t pasid);
+struct iommu_domain *
+iommu_get_domain_for_dev_pasid_async(struct device *dev, ioasid_t pasid);
+
+static inline void iommu_domain_put_async(struct iommu_domain *domain)
+{
+	if (refcount_dec_and_test(&domain->async_users))
+		iommu_domain_free(domain);
+}
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1044,6 +1056,12 @@ static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
 					     struct device *dev, ioasid_t pasid)
 {
 }
+
+static inline struct iommu_domain *
+iommu_get_domain_for_dev_pasid_async(struct device *dev, ioasid_t pasid)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_SVA
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index e90d53436a22..1024c61519dc 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -138,6 +138,69 @@ void iommu_sva_ioas_put(struct iommu_sva_ioas *ioas)
 	}
 }
 
+/*
+ * I/O page fault handler for SVA
+ *
+ * Copied from io-pgfault.c with mmget_not_zero() added before
+ * mmap_read_lock().
+ */
+static enum iommu_page_response_code
+iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
+{
+	vm_fault_t ret;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	unsigned int access_flags = 0;
+	struct iommu_domain *domain = data;
+	unsigned int fault_flags = FAULT_FLAG_REMOTE;
+	struct iommu_fault_page_request *prm = &fault->prm;
+	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
+
+	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
+		return status;
+
+	mm = iommu_sva_domain_mm(domain);
+	if (IS_ERR_OR_NULL(mm) || !mmget_not_zero(mm))
+		return status;
+
+	mmap_read_lock(mm);
+
+	vma = find_extend_vma(mm, prm->addr);
+	if (!vma)
+		/* Unmapped area */
+		goto out_put_mm;
+
+	if (prm->perm & IOMMU_FAULT_PERM_READ)
+		access_flags |= VM_READ;
+
+	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
+		access_flags |= VM_WRITE;
+		fault_flags |= FAULT_FLAG_WRITE;
+	}
+
+	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
+		access_flags |= VM_EXEC;
+		fault_flags |= FAULT_FLAG_INSTRUCTION;
+	}
+
+	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
+		fault_flags |= FAULT_FLAG_USER;
+
+	if (access_flags & ~vma->vm_flags)
+		/* Access fault */
+		goto out_put_mm;
+
+	ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
+	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
+		IOMMU_PAGE_RESP_SUCCESS;
+
+out_put_mm:
+	mmap_read_unlock(mm);
+	mmput(mm);
+
+	return status;
+}
+
 /*
  * IOMMU SVA driver-oriented interfaces
  */
@@ -157,6 +220,9 @@ iommu_sva_alloc_domain(struct device *dev, struct iommu_sva_ioas *ioas)
 	/* The caller must hold a reference to ioas. */
 	domain->sva_ioas = ioas;
 	domain->type = IOMMU_DOMAIN_SVA;
+	domain->iopf_handler = iommu_sva_handle_iopf;
+	domain->fault_data = domain;
+	refcount_set(&domain->async_users, 1);
 
 	return domain;
 }
@@ -271,7 +337,7 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 	if (refcount_dec_and_test(&handle->users)) {
 		list_del(&handle->node);
 		iommu_detach_device_pasid(domain, dev, ioas->pasid);
-		iommu_domain_free(domain);
+		iommu_domain_put_async(domain);
 		kfree(handle);
 	}
 	mutex_unlock(&iommu_sva_lock);
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7ed0a61351a5..f12c7851d16d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3173,3 +3173,32 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
 
 	iommu_group_put(group);
 }
+
+/*
+ * Get the attached domain for asynchronous usage, for example the I/O
+ * page fault handling framework. The caller get a reference counter
+ * of the domain automatically on a successful return and should put
+ * it with iommu_domain_put() after usage.
+ */
+struct iommu_domain *
+iommu_get_domain_for_dev_pasid_async(struct device *dev, ioasid_t pasid)
+{
+	struct iommu_domain *domain;
+	struct iommu_group *group;
+
+	if (!pasid_valid(pasid))
+		return NULL;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return NULL;
+
+	mutex_lock(&group->mutex);
+	domain = xa_load(&group->pasid_array, pasid);
+	if (domain)
+		refcount_inc(&domain->async_users);
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return domain;
+}
-- 
2.25.1

