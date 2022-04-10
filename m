Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4654FAD46
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbiDJKap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237136AbiDJK36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:29:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7D863BF8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 03:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649586467; x=1681122467;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LBTukToFqW26M3LPZNT+iWr0f/beL6755SjAv9KaxvQ=;
  b=YQg29cFbfX8y6WvbDXQiA4bfBNHziNT2iBBBVTHG+AoY1XHEC3tJLWZl
   lf2GMhdtXswSX+cbziHvQbVnsjuJck0up3pI7qmrpwuC0X/m+JZnBOjC8
   kqrleS0DnHtR/Gdxs98r6l0iMij8Vl1K32OEG1fhes9LWBo6jTHNgCRmB
   f0oXgUzuZrhjiOO3Gc2rm3Wm0EVP+e4CStvHum2cJPQ8n+TCyrsjKT2Y/
   yF9Q4vG9Iz/vfDQ2XvdXfZTiU+A9o5vpN2Xg5xb8NsE+pkVRYOvWyji7e
   mNkkRyhTFNxCAMyS8Npuz7fWCLnkEO02+Hbe6dgQFmVgxPWz4Y9AWLFSO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="261398396"
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; 
   d="scan'208";a="261398396"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 03:27:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; 
   d="scan'208";a="699019649"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2022 03:27:42 -0700
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
Subject: [PATCH RFC v3 10/12] iommu: Prepare IOMMU domain for IOPF
Date:   Sun, 10 Apr 2022 18:24:41 +0800
Message-Id: <20220410102443.294128-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220410102443.294128-1-baolu.lu@linux.intel.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/iommu.h         | 19 ++++++++++
 drivers/iommu/iommu-sva-lib.c | 68 ++++++++++++++++++++++++++++++++++-
 drivers/iommu/iommu.c         | 29 +++++++++++++++
 3 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 57650b773f3f..e23ec718515d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -51,6 +51,8 @@ struct iommu_sva_ioas;
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
 typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault *, void *);
+typedef enum iommu_page_response_code (*iommu_domain_iopf_handler_t)
+			(struct iommu_fault *, void *);
 
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
@@ -102,6 +104,9 @@ struct iommu_domain {
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
 	struct iommu_sva_ioas *sva_ioas;
+	iommu_domain_iopf_handler_t iopf_handler;
+	void *fault_data;
+	refcount_t async_users;
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
@@ -680,6 +685,14 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
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
@@ -1044,6 +1057,12 @@ static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
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
index 8df39893726f..1206423acc12 100644
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
index 1c4db9148608..ba9a687490c9 100644
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

