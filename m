Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26FD4EA73D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 07:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiC2Fmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 01:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiC2Fmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:42:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41E324B0B7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648532449; x=1680068449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oNG4UW0zzEZch3nv0WWBRbW0DC9J7Xey5ODKkvnd/rY=;
  b=HAzIcBozggvYMzi3kPYDqqp7k76e+aCM/bMY5OgZAdmgHTedDVVLsv0l
   JPzDkjFpZATQ4FIDhhhFCf6uvCxpqZVxoPV8rqp+kW3ZhaO7SFtZKBS2c
   krWhQU89wov+RPLhFK5BNh4a37eHIH2On5QLR47DSHK5Kqcc+XPFfnkxj
   CohpGwlLLlh1J4w9cSU8ohImDrJ2nFIE9xPYFiwdzhWZE4obTqOCLH0XQ
   NcleAKBvgsp07MgP7+Bcp7MjeecjYgQx7DA5/Cf6jw77yRKCD9C7KdRlR
   N8TILagDOef3cHu+ueHEqqk5hWgldolrXe9+L/s/SHSNpPcD8z8leFIKP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="259137052"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="259137052"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 22:40:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="694603685"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2022 22:40:45 -0700
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
Subject: [PATCH RFC v2 10/11] iommu: Per-domain I/O page fault handling
Date:   Tue, 29 Mar 2022 13:37:59 +0800
Message-Id: <20220329053800.3049561-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tweak the I/O page fault handling framework to route the page faults to
the domain and call the page fault handler retrieved from the domain.
This makes the I/O page fault handling framework possible to serve more
usage scenarios as long as they have an IOMMU domain and install a page
fault handler in it. This also refactors the SVA implementation to be
the first consumer of the per-domain page fault handling model.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h         |  4 ++
 drivers/iommu/iommu-sva-lib.h |  1 -
 drivers/iommu/io-pgfault.c    | 70 +++++++---------------------------
 drivers/iommu/iommu-sva-lib.c | 71 +++++++++++++++++++++++++++--------
 4 files changed, 72 insertions(+), 74 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7e30b88d7bef..729d602fcba5 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -51,6 +51,8 @@ struct iommu_sva_cookie;
 typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
 			struct device *, unsigned long, int, void *);
 typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault *, void *);
+typedef enum iommu_page_response_code (*iommu_domain_iopf_handler_t)
+			(struct iommu_fault *, void *);
 
 struct iommu_domain_geometry {
 	dma_addr_t aperture_start; /* First address that can be mapped    */
@@ -102,6 +104,8 @@ struct iommu_domain {
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
 	struct iommu_sva_cookie *sva_cookie;
+	iommu_domain_iopf_handler_t fault_handler;
+	void *fault_data;
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
index 95d51f748dff..abef83ac1b2d 100644
--- a/drivers/iommu/iommu-sva-lib.h
+++ b/drivers/iommu/iommu-sva-lib.h
@@ -8,7 +8,6 @@
 #include <linux/ioasid.h>
 #include <linux/mm_types.h>
 
-struct mm_struct *iommu_sva_find(ioasid_t pasid);
 struct mm_struct *iommu_sva_domain_mm(struct iommu_domain *domain);
 
 /* I/O Page fault */
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 1df8c1dcae77..159e4f107fe3 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -69,62 +69,6 @@ static int iopf_complete_group(struct device *dev, struct iopf_fault *iopf,
 	return iommu_page_response(dev, &resp);
 }
 
-static enum iommu_page_response_code
-iopf_handle_single(struct iopf_fault *iopf)
-{
-	vm_fault_t ret;
-	struct mm_struct *mm;
-	struct vm_area_struct *vma;
-	unsigned int access_flags = 0;
-	unsigned int fault_flags = FAULT_FLAG_REMOTE;
-	struct iommu_fault_page_request *prm = &iopf->fault.prm;
-	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
-
-	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
-		return status;
-
-	mm = iommu_sva_find(prm->pasid);
-	if (IS_ERR_OR_NULL(mm))
-		return status;
-
-	mmap_read_lock(mm);
-
-	vma = find_extend_vma(mm, prm->addr);
-	if (!vma)
-		/* Unmapped area */
-		goto out_put_mm;
-
-	if (prm->perm & IOMMU_FAULT_PERM_READ)
-		access_flags |= VM_READ;
-
-	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
-		access_flags |= VM_WRITE;
-		fault_flags |= FAULT_FLAG_WRITE;
-	}
-
-	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
-		access_flags |= VM_EXEC;
-		fault_flags |= FAULT_FLAG_INSTRUCTION;
-	}
-
-	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
-		fault_flags |= FAULT_FLAG_USER;
-
-	if (access_flags & ~vma->vm_flags)
-		/* Access fault */
-		goto out_put_mm;
-
-	ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
-	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
-		IOMMU_PAGE_RESP_SUCCESS;
-
-out_put_mm:
-	mmap_read_unlock(mm);
-	mmput(mm);
-
-	return status;
-}
-
 static void iopf_handle_group(struct work_struct *work)
 {
 	struct iopf_group *group;
@@ -134,12 +78,24 @@ static void iopf_handle_group(struct work_struct *work)
 	group = container_of(work, struct iopf_group, work);
 
 	list_for_each_entry_safe(iopf, next, &group->faults, list) {
+		struct iommu_domain *domain;
+
+		domain = iommu_get_domain_for_dev_pasid(group->dev,
+							iopf->fault.prm.pasid);
+
+		if (!domain || !domain->fault_handler)
+			status = IOMMU_PAGE_RESP_INVALID;
+
 		/*
 		 * For the moment, errors are sticky: don't handle subsequent
 		 * faults in the group if there is an error.
 		 */
 		if (status == IOMMU_PAGE_RESP_SUCCESS)
-			status = iopf_handle_single(iopf);
+			status = domain->fault_handler(&iopf->fault,
+						       domain->fault_data);
+
+		if (domain)
+			iommu_put_domain_for_dev_pasid(domain);
 
 		if (!(iopf->fault.prm.flags &
 		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index 96e967e58aa9..a53574f9559a 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -60,25 +60,62 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm,
 	return ret;
 }
 
-/* ioasid_find getter() requires a void * argument */
-static bool __mmget_not_zero(void *mm)
+static enum iommu_page_response_code
+iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
 {
-	return mmget_not_zero(mm);
-}
+	vm_fault_t ret;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;
+	unsigned int access_flags = 0;
+	struct iommu_domain *domain = data;
+	unsigned int fault_flags = FAULT_FLAG_REMOTE;
+	struct iommu_fault_page_request *prm = &fault->prm;
+	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
 
-/**
- * iommu_sva_find() - Find mm associated to the given PASID
- * @pasid: Process Address Space ID assigned to the mm
- *
- * On success a reference to the mm is taken, and must be released with mmput().
- *
- * Returns the mm corresponding to this PASID, or an error if not found.
- */
-struct mm_struct *iommu_sva_find(ioasid_t pasid)
-{
-	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
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
 }
-EXPORT_SYMBOL_GPL(iommu_sva_find);
 
 static struct iommu_domain *
 iommu_sva_alloc_domain(struct device *dev, struct mm_struct *mm)
@@ -105,6 +142,8 @@ iommu_sva_alloc_domain(struct device *dev, struct mm_struct *mm)
 	INIT_LIST_HEAD(&cookie->bonds);
 	domain->type = IOMMU_DOMAIN_SVA;
 	domain->sva_cookie = cookie;
+	domain->fault_handler = iommu_sva_handle_iopf;
+	domain->fault_data = domain;
 	curr = xa_store(&sva_domain_array, mm->pasid, domain, GFP_KERNEL);
 	if (xa_err(curr))
 		goto err_xa_store;
-- 
2.25.1

