Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B2A4E1A83
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 07:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244918AbiCTGpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 02:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244948AbiCTGo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 02:44:56 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2227A11156
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 23:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647758609; x=1679294609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vKdoL7uiyvYLFOvydHSnd0GHZVBK2y8vbn3OihTxHw0=;
  b=QuT8h2ropqwAycsaejVcUIsapHkKqLPU6vpjMjp3KOaLkfI5Q7V/Ir0c
   0jSfR7biiskho1YDz68QhVMmPZuKk7fX4IbwmdLPcSNhTdnfclPkfh1Ck
   cEix/uFYpGMlYJw5W7hgLlpDmFinETbptZRaothmXiAj64QAU4GZcUOPF
   3VxR+EOuMyhUoFqumTS4FZMTOVANmWFrWvqCgZTNN/b5/q5QDo+JBtXSk
   Ddq7u9nk+LZ7sLaK0jzi05HZdubqV3wQjrnyGB+isZwOvPnwC4L8Iny3t
   fCugq/rodJ8LvnFpMTAUA83+lgrG2ZgxWXYxLYE94RCIao3OHcEc52luW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10291"; a="254924040"
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="254924040"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2022 23:43:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,195,1643702400"; 
   d="scan'208";a="691839965"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2022 23:43:07 -0700
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
Subject: [PATCH RFC 09/11] iommu: Add iommu_get_domain_for_dev_pasid()
Date:   Sun, 20 Mar 2022 14:40:28 +0800
Message-Id: <20220320064030.2936936-10-baolu.lu@linux.intel.com>
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

This adds a helper to retrieve the iommu_domain which has been attached to
a {device, pasid}. One usage scenario of this helper exists in the I/O page
fault handling framework, where {device, pasid} was reported by hardware,
and software needs to retrieve the attached domain for further routing.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h |  8 ++++++++
 drivers/iommu/iommu.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 47c9aa5aa9c8..803e7b07605e 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -676,6 +676,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 			      struct device *dev, ioasid_t pasid);
 void iommu_detach_device_pasid(struct iommu_domain *domain,
 			       struct device *dev, ioasid_t pasid);
+struct iommu_domain *
+iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid);
 
 #else /* CONFIG_IOMMU_API */
 
@@ -1041,6 +1043,12 @@ static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
 					     struct device *dev, ioasid_t pasid)
 {
 }
+
+static inline struct iommu_domain *
+iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	return NULL;
+}
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IOMMU_SVA
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4f90b71c6f6e..508fdcabda5c 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -40,6 +40,7 @@ struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
 	struct list_head devices;
+	struct xarray pasid_array;
 	struct mutex mutex;
 	void *iommu_data;
 	void (*iommu_data_release)(void *iommu_data);
@@ -632,6 +633,7 @@ struct iommu_group *iommu_group_alloc(void)
 	mutex_init(&group->mutex);
 	INIT_LIST_HEAD(&group->devices);
 	INIT_LIST_HEAD(&group->entry);
+	xa_init(&group->pasid_array);
 
 	ret = ida_simple_get(&iommu_group_ida, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
@@ -3086,6 +3088,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 {
 	struct iommu_group *group;
 	int ret = -EINVAL;
+	void *curr;
 
 	if (!domain->ops->attach_dev_pasid)
 		return -EINVAL;
@@ -3098,7 +3101,16 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	if (iommu_group_device_count(group) != 1)
 		goto out_unlock;
 
+	xa_lock(&group->pasid_array);
+	curr = __xa_cmpxchg(&group->pasid_array, pasid, NULL,
+			    domain, GFP_KERNEL);
+	xa_unlock(&group->pasid_array);
+	if (curr)
+		goto out_unlock;
+
 	ret = domain->ops->attach_dev_pasid(domain, dev, pasid);
+	if (ret)
+		xa_erase(&group->pasid_array, pasid);
 
 out_unlock:
 	mutex_unlock(&group->mutex);
@@ -3118,6 +3130,25 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
 
 	mutex_lock(&group->mutex);
 	domain->ops->detach_dev_pasid(domain, dev, pasid);
+	xa_erase(&group->pasid_array, pasid);
+	mutex_unlock(&group->mutex);
+	iommu_group_put(group);
+}
+
+struct iommu_domain *
+iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	struct iommu_domain *domain;
+	struct iommu_group *group;
+
+	group = iommu_group_get(dev);
+	if (!group)
+		return NULL;
+
+	mutex_lock(&group->mutex);
+	domain = xa_load(&group->pasid_array, pasid);
 	mutex_unlock(&group->mutex);
 	iommu_group_put(group);
+
+	return domain;
 }
-- 
2.25.1

