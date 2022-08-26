Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D695A27E6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 14:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344268AbiHZMgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 08:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344214AbiHZMf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 08:35:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BD5C4815
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 05:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661517352; x=1693053352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dClFrh17TT/mhJK1T6hifUb1FM1C9tDrQAw2UO796mw=;
  b=Z3NFA1XlSDu8STAVsfzWIBaw0dk1HtXATGDrVFw7UZSdCmYVxxsHk6le
   404GQFm+q0Z2B6nRGrOBiGCZnOV16XdycgDsbMDLAJSlxRB0F86koTKOi
   02UcLS1/T+eGxb/rqbJp0AqsI8amPmeJWSBs7l7t/X4Sr/bNLAnEQQwKC
   Dg1SqJ3wZUU7E8KaHE27wSjxa8offnkEVmSlfibmhE6F7seJNm0VG7nSF
   jwDnLhqathfIh3zNQ3eDb36WtEUthKruzn9Dtc010/CpHSYZGmdnmKlLg
   Pbd97UWThqLDqd1qj9AVRB1bRHc4SmtZF9d68vqGXsBTk6orXEuiswfFG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="356210178"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="356210178"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 05:35:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="606751961"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 26 Aug 2022 05:35:48 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Eric Auger <eric.auger@redhat.com>, Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v2 2/3] iommu: Retire detach_dev domain ops
Date:   Fri, 26 Aug 2022 20:30:13 +0800
Message-Id: <20220826123014.52709-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826123014.52709-1-baolu.lu@linux.intel.com>
References: <20220826123014.52709-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As no IOMMU driver provides detach_dev domain ops callback now, retire
this callback and make the detach_dev calls in iommu core through the
blocking domain.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h |  2 --
 drivers/iommu/iommu.c | 31 ++++---------------------------
 2 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 266ef281cbd5..1e9fecfb23a7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -274,7 +274,6 @@ struct iommu_ops {
 /**
  * struct iommu_domain_ops - domain specific operations
  * @attach_dev: attach an iommu domain to a device
- * @detach_dev: detach an iommu domain from a device
  * @set_dev_pasid: set an iommu domain to a pasid of device
  * @map: map a physically contiguous memory region to an iommu domain
  * @map_pages: map a physically contiguous set of pages of the same size to
@@ -295,7 +294,6 @@ struct iommu_ops {
  */
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
-	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
 	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
 			     ioasid_t pasid);
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9e84f58440dd..ad34e4df1aad 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2047,16 +2047,6 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
 	return 0;
 }
 
-static void __iommu_detach_device(struct iommu_domain *domain,
-				  struct device *dev)
-{
-	if (iommu_is_attach_deferred(dev))
-		return;
-
-	domain->ops->detach_dev(domain, dev);
-	trace_detach_device_from_domain(dev);
-}
-
 void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
 {
 	struct iommu_group *group;
@@ -2149,15 +2139,6 @@ int iommu_attach_group(struct iommu_domain *domain, struct iommu_group *group)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_group);
 
-static int iommu_group_do_detach_device(struct device *dev, void *data)
-{
-	struct iommu_domain *domain = data;
-
-	__iommu_detach_device(domain, dev);
-
-	return 0;
-}
-
 static int __iommu_group_set_domain(struct iommu_group *group,
 				    struct iommu_domain *new_domain)
 {
@@ -2167,17 +2148,13 @@ static int __iommu_group_set_domain(struct iommu_group *group,
 		return 0;
 
 	/*
-	 * New drivers should support default domains and so the detach_dev() op
-	 * will never be called. Otherwise the NULL domain represents some
-	 * platform specific behavior.
+	 * The NULL domain represents some platform specific behavior.
+	 * Attaching the blocking domain instead.
 	 */
 	if (!new_domain) {
-		if (WARN_ON(!group->domain->ops->detach_dev))
+		if (WARN_ON(!group->blocking_domain))
 			return -EINVAL;
-		__iommu_group_for_each_dev(group, group->domain,
-					   iommu_group_do_detach_device);
-		group->domain = NULL;
-		return 0;
+		new_domain = group->blocking_domain;
 	}
 
 	/*
-- 
2.25.1

