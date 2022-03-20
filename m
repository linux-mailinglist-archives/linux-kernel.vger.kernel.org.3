Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E5A4E1A78
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 07:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244839AbiCTGoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 02:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244840AbiCTGoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 02:44:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF344211EE8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 23:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647758568; x=1679294568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vJyVAk/j31H5Tr2Hz0IVnXHEkRGz8CGwz17yXeLe0U8=;
  b=Jv8xSpX1t/zP8tQFqpL/0KjeBduWWADsNvvMInHhi3Hd3fsYYPhK/Tbk
   R9ajYmK+eHgmpLmi8VcsCQdsbwCWoulJWq/Pn2ARCE+oDiF0gLKqy+P+6
   1WQQ/buM8noWUIw+pdwFJv3u53+prTSTqGO6ryOpSim4uNZE9362M+1JB
   /eE1jcfJUl9vWuRehM2DLbs72wAzWj4Ub91A+p/nGXglWOZACv873h4c2
   t9FLS+M4ho/8r5cmXzDedQvMZqA3qrn4IivbnN9IUdzG0SUQwMKLgdB1g
   lYE1bS1xby6f8ZoKfdcEpl0QIF93kq/oWRSiuh8LfNmslfsmYaR+NSY5G
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="254924013"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="254924013"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 23:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="691839884"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2022 23:42:45 -0700
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
Subject: [PATCH RFC 03/11] iommu: Add attach/detach_dev_pasid domain ops
Date:   Sun, 20 Mar 2022 14:40:22 +0800
Message-Id: <20220320064030.2936936-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attaching an IOMMU domain to a PASID of a device is a generic operation
for modern IOMMU drivers which support PASID-granular DMA address
translation. Currently visible usage scenarios include (but not limited):

 - SVA
 - kernel DMA with PASID
 - hardware-assist mediated device

This adds a pair of common domain ops for this purpose and implements a
couple of wrapper helpers for in-kernel usage.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h | 22 ++++++++++++++++++++++
 drivers/iommu/iommu.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 3e179b853380..e51845b9a146 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -268,6 +268,8 @@ struct iommu_ops {
  * struct iommu_domain_ops - domain specific operations
  * @attach_dev: attach an iommu domain to a device
  * @detach_dev: detach an iommu domain from a device
+ * @attach_dev_pasid: attach an iommu domain to a pasid of device
+ * @detach_dev_pasid: detach an iommu domain from a pasid of device
  * @map: map a physically contiguous memory region to an iommu domain
  * @map_pages: map a physically contiguous set of pages of the same size to
  *             an iommu domain.
@@ -285,6 +287,10 @@ struct iommu_ops {
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
 	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
+	int (*attach_dev_pasid)(struct iommu_domain *domain,
+				struct device *dev, ioasid_t id);
+	void (*detach_dev_pasid)(struct iommu_domain *domain,
+				 struct device *dev, ioasid_t id);
 
 	int (*map)(struct iommu_domain *domain, unsigned long iova,
 		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
@@ -678,6 +684,11 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
 void iommu_group_release_dma_owner(struct iommu_group *group);
 bool iommu_group_dma_owner_claimed(struct iommu_group *group);
 
+int iommu_attach_device_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid);
+void iommu_detach_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid);
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1046,6 +1057,17 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 {
 	return false;
 }
+
+static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
+					    struct device *dev, ioasid_t pasid)
+{
+	return -ENODEV;
+}
+
+static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
+					     struct device *dev, ioasid_t pasid)
+{
+}
 #endif /* CONFIG_IOMMU_API */
 
 /**
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0c42ece25854..78c71ee15f36 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3167,3 +3167,44 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
 	return user;
 }
 EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
+
+int iommu_attach_device_pasid(struct iommu_domain *domain,
+			      struct device *dev, ioasid_t pasid)
+{
+	struct iommu_group *group;
+	int ret = -EINVAL;
+
+	if (!domain->ops->attach_dev_pasid)
+		return -EINVAL;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return -ENODEV;
+
+	mutex_lock(&group->mutex);
+	if (iommu_group_device_count(group) != 1)
+		goto out_unlock;
+
+	ret = domain->ops->attach_dev_pasid(domain, dev, pasid);
+
+out_unlock:
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+
+	return ret;
+}
+
+void iommu_detach_device_pasid(struct iommu_domain *domain,
+			       struct device *dev, ioasid_t pasid)
+{
+	struct iommu_group *group;
+
+	group = iommu_group_get(dev);
+	if (WARN_ON(!group))
+		return;
+
+	mutex_lock(&group->mutex);
+	domain->ops->detach_dev_pasid(domain, dev, pasid);
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+}
-- 
2.25.1

