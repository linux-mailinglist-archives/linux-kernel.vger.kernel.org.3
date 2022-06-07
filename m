Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A574F53F3AA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 03:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiFGByo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 21:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbiFGByT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:54:19 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6D26FD03
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 18:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654566855; x=1686102855;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZhVJrH8ZIL7/etGs0byavRR7lBKr0I4+Mu5OuvDVjHU=;
  b=dXOCkGDysil5aDrQbtqhMiO4MBNVnnSexPa+voPVty265TCyuWqUBWOh
   Q3L553CxXNnF1D7aCDOrljDDLckaJBkMl1t8BytrG0O6wrVqpQ6rLJyv7
   bi3rEHvDy2hQQpLcVUR5aLn5iRcb/kEjQKTzIajQvSv6eOW7qy3W/RF3c
   viZ9YCCT0g6htWclUT+XGQ7YsOANj064rGWobDDbedE1Gnw23q0VUg46t
   0Xi1NznqoKGDxdtnLvVgNE/ayTCs5nKMosWdhIq3VLWufwz+ClUgCSqOE
   0PJMLMvQ1ER9vwA9jfT2jI9sg3LXQJwNJIkOdIO8GWt6dmF/FS1UyU0qM
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="302064150"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="302064150"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 18:54:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="635886324"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jun 2022 18:54:11 -0700
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
Subject: [PATCH v8 10/11] iommu: Per-domain I/O page fault handling
Date:   Tue,  7 Jun 2022 09:49:41 +0800
Message-Id: <20220607014942.3954894-11-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

The iommu_get_domain_for_dev_pasid() which retrieves attached domain
for a {device, PASID} pair is used. It will be used by the page fault
handling framework which knows {device, PASID} reported from the iommu
driver. We have a guarantee that the SVA domain doesn't go away during
IOPF handling, because unbind() waits for pending faults with
iopf_queue_flush_dev() before freeing the domain. Hence, there's no need
to synchronize life cycle of the iommu domains between the unbind() and
the interrupt threads.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/iommu/io-pgfault.c | 64 +++++---------------------------------
 1 file changed, 7 insertions(+), 57 deletions(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index aee9e033012f..4f24ec703479 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -69,69 +69,18 @@ static int iopf_complete_group(struct device *dev, struct iopf_fault *iopf,
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
+	struct iommu_domain *domain;
 	struct iopf_fault *iopf, *next;
 	enum iommu_page_response_code status = IOMMU_PAGE_RESP_SUCCESS;
 
 	group = container_of(work, struct iopf_group, work);
+	domain = iommu_get_domain_for_dev_pasid(group->dev,
+				group->last_fault.fault.prm.pasid);
+	if (!domain || !domain->iopf_handler)
+		status = IOMMU_PAGE_RESP_INVALID;
 
 	list_for_each_entry_safe(iopf, next, &group->faults, list) {
 		/*
@@ -139,7 +88,8 @@ static void iopf_handle_group(struct work_struct *work)
 		 * faults in the group if there is an error.
 		 */
 		if (status == IOMMU_PAGE_RESP_SUCCESS)
-			status = iopf_handle_single(iopf);
+			status = domain->iopf_handler(&iopf->fault,
+						      domain->fault_data);
 
 		if (!(iopf->fault.prm.flags &
 		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
-- 
2.25.1

