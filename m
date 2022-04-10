Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F084FAD42
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 12:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbiDJKag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 06:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbiDJKaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 06:30:00 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91BA673C6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 03:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649586470; x=1681122470;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fu4u8Ef1jDF1toZsT/ipKFrMQ506PRwLTHT/98exNN8=;
  b=YMzaN3Y/A7X7DUBXo5EPAxGfNurUsS37DsSaiU5gigAYvsN8++yH7EJ7
   m4abliaFs9c1wmcZhTE8y6k9mIbor/QypAc1fQtIuHmVdME5kpVn31XBP
   vHPmk9C7BKdqc3tvwh3ChgeoU8HlpN5zkFBaV77ZzDm6CDi3z6SjKs2tN
   6bI2GAVoeJBmzum6YE6/bW+NX708s529am5+8SQ+7UFzQO6u8Xbz6yhI7
   NVAZeeZqahd/SFTaz7BYS+GKeSKux64EtdlwIjv7htiJP1rT4WRbyJfaB
   HJ2Ty2LOQrz/Jmb9jE8ef6eyTMQ2U9SPJxJgE7dJgJvm7HXf75pIwSOpQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="261398405"
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; 
   d="scan'208";a="261398405"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 03:27:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; 
   d="scan'208";a="699019653"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2022 03:27:46 -0700
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
Subject: [PATCH RFC v3 11/12] iommu: Per-domain I/O page fault handling
Date:   Sun, 10 Apr 2022 18:24:42 +0800
Message-Id: <20220410102443.294128-12-baolu.lu@linux.intel.com>
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

Tweak the I/O page fault handling framework to route the page faults to
the domain and call the page fault handler retrieved from the domain.
This makes the I/O page fault handling framework possible to serve more
usage scenarios as long as they have an IOMMU domain and install a page
fault handler in it. Some unused functions are also removed to avoid
dead code.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu-sva-lib.h |  1 -
 drivers/iommu/io-pgfault.c    | 69 ++++++-----------------------------
 drivers/iommu/iommu-sva-lib.c | 20 ----------
 3 files changed, 12 insertions(+), 78 deletions(-)

diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
index 0f33472e5212..90d4bd3a61b1 100644
--- a/drivers/iommu/iommu-sva-lib.h
+++ b/drivers/iommu/iommu-sva-lib.h
@@ -8,7 +8,6 @@
 #include <linux/ioasid.h>
 #include <linux/mm_types.h>
 
-struct mm_struct *iommu_sva_find(ioasid_t pasid);
 struct mm_struct *iommu_sva_domain_mm(struct iommu_domain *domain);
 
 /* I/O Page fault */
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 1df8c1dcae77..fc1b2bdeedf8 100644
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
@@ -134,12 +78,23 @@ static void iopf_handle_group(struct work_struct *work)
 	group = container_of(work, struct iopf_group, work);
 
 	list_for_each_entry_safe(iopf, next, &group->faults, list) {
+		struct iommu_domain *domain;
+
+		domain = iommu_get_domain_for_dev_pasid_async(group->dev,
+				iopf->fault.prm.pasid);
+		if (!domain || !domain->iopf_handler)
+			status = IOMMU_PAGE_RESP_INVALID;
+
 		/*
 		 * For the moment, errors are sticky: don't handle subsequent
 		 * faults in the group if there is an error.
 		 */
 		if (status == IOMMU_PAGE_RESP_SUCCESS)
-			status = iopf_handle_single(iopf);
+			status = domain->iopf_handler(&iopf->fault,
+						      domain->fault_data);
+
+		if (domain)
+			iommu_domain_put_async(domain);
 
 		if (!(iopf->fault.prm.flags &
 		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index 1206423acc12..4c9d89f375df 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -69,26 +69,6 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm,
 	return ret;
 }
 
-/* ioasid_find getter() requires a void * argument */
-static bool __mmget_not_zero(void *mm)
-{
-	return mmget_not_zero(mm);
-}
-
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
-}
-EXPORT_SYMBOL_GPL(iommu_sva_find);
-
 /*
  * Get or put an ioas for a shared memory.
  */
-- 
2.25.1

