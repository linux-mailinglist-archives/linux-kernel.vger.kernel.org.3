Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358C95662A8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 07:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiGEFMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 01:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiGEFME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 01:12:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7122213D11
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 22:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656997923; x=1688533923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fTrtMAAJhQfGMMOU6j85FQf2LBXIcS+qto9gmyXkZP4=;
  b=CAF63RQQUDOs11Ojrk/PPoyfcOZooAA0Oz7hKj0ce4HIFkqHhWWzWZrB
   mXcmpRCEC6lSBtN7gOMKTULU0jsw5vo1EUvqTfO6k3Xh12mGMjdvrbq1c
   kcW6ITQ/ge1kSAe8MoOEx4gCbMwl2AqXmWbq+VgJTOkyDn70awvMWUVhG
   Tv/IERN93a+r8ktEq65ZvbqFcfwvzxs8Mf017QFm43FjEiERBG0hJylB1
   4GV8e4uAIoRuw6y17a/ZWYIDYn2EmOsHLqTTEdYJW/j6ARC9dzhwL9e3e
   6f2kLJq1z7G3ynerWAuI6vcD8NX5U3HbSwTVFlOIzXB0hoMjmrYTEfnu/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="263046104"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="263046104"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 22:12:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="542807440"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga003.jf.intel.com with ESMTP; 04 Jul 2022 22:11:58 -0700
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
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v10 05/12] iommu: Add IOMMU SVA domain support
Date:   Tue,  5 Jul 2022 13:07:03 +0800
Message-Id: <20220705050710.2887204-6-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sva iommu_domain represents a hardware pagetable that the IOMMU
hardware could use for SVA translation. This adds some infrastructure
to support SVA domain in the iommu common layer. It includes:

- Extend the iommu_domain to support a new IOMMU_DOMAIN_SVA domain
  type. The IOMMU drivers that support allocation of the SVA domain
  should provide its own sva domain specific iommu_domain_ops.
- Add a helper to allocate an SVA domain. The iommu_domain_free()
  is still used to free an SVA domain.

The report_iommu_fault() should be replaced by the new
iommu_report_device_fault(). Leave the existing fault handler with the
existing users and the newly added SVA members excludes it.

Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Tony Zhu <tony.zhu@intel.com>
---
 include/linux/iommu.h | 24 ++++++++++++++++++++++--
 drivers/iommu/iommu.c | 20 ++++++++++++++++++++
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f2b5aa7efe43..42f0418dc22c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -64,6 +64,8 @@ struct iommu_domain_geometry {
 #define __IOMMU_DOMAIN_PT	(1U << 2)  /* Domain is identity mapped   */
 #define __IOMMU_DOMAIN_DMA_FQ	(1U << 3)  /* DMA-API uses flush queue    */
 
+#define __IOMMU_DOMAIN_SVA	(1U << 4)  /* Shared process address space */
+
 /*
  * This are the possible domain-types
  *
@@ -77,6 +79,8 @@ struct iommu_domain_geometry {
  *				  certain optimizations for these domains
  *	IOMMU_DOMAIN_DMA_FQ	- As above, but definitely using batched TLB
  *				  invalidation.
+ *	IOMMU_DOMAIN_SVA	- DMA addresses are shared process address
+ *				  spaces represented by mm_struct's.
  */
 #define IOMMU_DOMAIN_BLOCKED	(0U)
 #define IOMMU_DOMAIN_IDENTITY	(__IOMMU_DOMAIN_PT)
@@ -86,15 +90,23 @@ struct iommu_domain_geometry {
 #define IOMMU_DOMAIN_DMA_FQ	(__IOMMU_DOMAIN_PAGING |	\
 				 __IOMMU_DOMAIN_DMA_API |	\
 				 __IOMMU_DOMAIN_DMA_FQ)
+#define IOMMU_DOMAIN_SVA	(__IOMMU_DOMAIN_SVA)
 
 struct iommu_domain {
 	unsigned type;
 	const struct iommu_domain_ops *ops;
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
-	iommu_fault_handler_t handler;
-	void *handler_token;
 	struct iommu_domain_geometry geometry;
 	struct iommu_dma_cookie *iova_cookie;
+	union {
+		struct {
+			iommu_fault_handler_t handler;
+			void *handler_token;
+		};
+		struct {	/* IOMMU_DOMAIN_SVA */
+			struct mm_struct *mm;
+		};
+	};
 };
 
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
@@ -685,6 +697,8 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
 void iommu_group_release_dma_owner(struct iommu_group *group);
 bool iommu_group_dma_owner_claimed(struct iommu_group *group);
 
+struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
+					    struct mm_struct *mm);
 int iommu_attach_device_pasid(struct iommu_domain *domain, struct device *dev,
 			      ioasid_t pasid);
 void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
@@ -1063,6 +1077,12 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 	return false;
 }
 
+static inline struct iommu_domain *
+iommu_sva_domain_alloc(struct device *dev, struct mm_struct *mm)
+{
+	return NULL;
+}
+
 static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
 					    struct device *dev, ioasid_t pasid)
 {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index be48b09371f4..10479c5e4d23 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/cc_platform.h>
 #include <trace/events/iommu.h>
+#include <linux/sched/mm.h>
 
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
@@ -1957,6 +1958,8 @@ EXPORT_SYMBOL_GPL(iommu_domain_alloc);
 
 void iommu_domain_free(struct iommu_domain *domain)
 {
+	if (domain->type == IOMMU_DOMAIN_SVA)
+		mmdrop(domain->mm);
 	iommu_put_dma_cookie(domain);
 	domain->ops->free(domain);
 }
@@ -3274,6 +3277,23 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
 
+struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
+					    struct mm_struct *mm)
+{
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	struct iommu_domain *domain;
+
+	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
+	if (!domain)
+		return NULL;
+
+	domain->type = IOMMU_DOMAIN_SVA;
+	mmgrab(mm);
+	domain->mm = mm;
+
+	return domain;
+}
+
 static bool iommu_group_immutable_singleton(struct iommu_group *group,
 					    struct device *dev)
 {
-- 
2.25.1

