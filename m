Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C89520DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 08:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbiEJG0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 02:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbiEJGZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 02:25:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B2836326
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 23:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652163689; x=1683699689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1H1VZfmh6IMSsHWOo2uEG/ch0molOpL33CJ2YDYCw0g=;
  b=gIHnK0Xneq1HgY5aFy5fvwGFmZKtWZzVdhtAuuF26WPhbwKjjxY5wf0S
   AQ1L5cSZi17rY7N7FflBAD3djfIRWnxUatij3HtulUaj3K7yFcJf8Lmsj
   8fI/l040LKz519BkT7kK6uh4vVxnr9pk+nYwOxXxFL4KsZZbwATpuOsS8
   6LP46s0jLjuyUOeNqIJU39UQI/mtr//hsTJI66RWwrubtk/iPF2sY7di7
   /XmSkUjcPljz4bTPUiv99YwtHijPrTp6HHYubGVnUmcAMMPWcPzFj2uGk
   Ndn6ePE78VGVKJT0G/Am5z0/sqtD3joxpLsDlVglcXqbnI9BB8m93VOf8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="332313098"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="332313098"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 23:21:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="552636647"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga002.jf.intel.com with ESMTP; 09 May 2022 23:21:24 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v6 10/12] iommu: Prepare IOMMU domain for IOPF
Date:   Tue, 10 May 2022 14:17:36 +0800
Message-Id: <20220510061738.2761430-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds some mechanisms around the iommu_domain so that the I/O page
fault handling framework could route a page fault to the domain and
call the fault handler from it.

Add pointers to the page fault handler and its private data in struct
iommu_domain. The fault handler will be called with the private data
as a parameter once a page fault is routed to the domain. Any kernel
component which owns an iommu domain could install handler and its
private parameter so that the page fault could be further routed and
handled.

A new helper iommu_get_domain_for_iopf() which retrieves attached domain
for a {device, PASID} pair is added. It will be used by the page fault
handling framework which knows {device, PASID} reported from the iommu
driver. We have a guarantee that the SVA domain doesn't go away during
IOPF handling, because unbind() waits for pending faults with
iopf_queue_flush_dev() before freeing the domain. Hence, there's no need
to synchronize life cycle of the iommu domains between the unbind() and
the interrupt threads.

This also prepares the SVA implementation to be the first consumer of
the per-domain page fault handling model.

Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h         | 12 +++++++
 drivers/iommu/io-pgfault.c    |  7 ++++
 drivers/iommu/iommu-sva-lib.c | 65 +++++++++++++++++++++++++++++++++++
 drivers/iommu/iommu.c         | 27 +++++++++++++++
 4 files changed, 111 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 392b8adc3495..9405034e3013 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -103,6 +103,9 @@ struct iommu_domain {
 #ifdef CONFIG_IOMMU_SVA
 	struct mm_struct *mm;
 #endif
+	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
+						      void *data);
+	void *fault_data;
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
@@ -687,6 +690,9 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 			      struct device *dev, ioasid_t pasid);
 void iommu_detach_device_pasid(struct iommu_domain *domain,
 			       struct device *dev, ioasid_t pasid);
+struct iommu_domain *
+iommu_get_domain_for_iopf(struct device *dev, ioasid_t pasid);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1056,6 +1062,12 @@ static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
 					     struct device *dev, ioasid_t pasid)
 {
 }
+
+static inline struct iommu_domain *
+iommu_get_domain_for_iopf(struct device *dev, ioasid_t pasid)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_SVA
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 1df8c1dcae77..aee9e033012f 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -181,6 +181,13 @@ static void iopf_handle_group(struct work_struct *work)
  * request completes, outstanding faults will have been dealt with by the time
  * the PASID is freed.
  *
+ * Any valid page fault will be eventually routed to an iommu domain and the
+ * page fault handler installed there will get called. The users of this
+ * handling framework should guarantee that the iommu domain could only be
+ * freed after the device has stopped generating page faults (or the iommu
+ * hardware has been set to block the page faults) and the pending page faults
+ * have been flushed.
+ *
  * Return: 0 on success and <0 on error.
  */
 int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index ef6ed87d04ba..32c836e4a60e 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -72,6 +72,69 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
 }
 EXPORT_SYMBOL_GPL(iommu_sva_find);
 
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
+	mm = domain->mm;
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
@@ -91,6 +154,8 @@ iommu_sva_alloc_domain(struct device *dev, struct mm_struct *mm)
 	mmgrab(mm);
 	domain->mm = mm;
 	domain->type = IOMMU_DOMAIN_SVA;
+	domain->iopf_handler = iommu_sva_handle_iopf;
+	domain->fault_data = domain;
 
 	return domain;
 }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 367d0ecf6e12..00d0262a1fe9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3172,3 +3172,30 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
 
 	iommu_group_put(group);
 }
+
+struct iommu_domain *iommu_get_domain_for_iopf(struct device *dev,
+					       ioasid_t pasid)
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
+	/*
+	 * Safe to fetch outside the group mutex because:
+	 *
+	 * - The xarray protects its internal state with RCU;
+	 * - The domain obtained is either NULL or fully formed;
+	 * - Current IOPF framework requires that all IOPFs should be quieted
+	 *   and flushed from the pending list before the domain is freed.
+	 */
+	domain = xa_load(&group->pasid_array, pasid);
+	iommu_group_put(group);
+
+	return domain;
+}
-- 
2.25.1

