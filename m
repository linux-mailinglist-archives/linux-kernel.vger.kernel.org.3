Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903D4527BAF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 04:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbiEPCBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 22:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239296AbiEPCB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 22:01:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90D312ADC
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 19:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652666484; x=1684202484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LHhv25RN3InxjHy86FN8zSgjz6xAFhg1jRNzCYo5Vn8=;
  b=VGZZWW0dZyrNP0ks7Ts0Z/5aQe79+AtW0RR/KMuGddpecxOkbh2tK9Hb
   JeB+nAs+JpDvbmUPDN6K4mn9DzkTVNLC8YGbb8qVmiX1hFkJI+2foVYwC
   hR3wnmHbpLNVxYYfmtJ1536Q3hIUpp9sqDDBZ3FWM92/yI+LIYblxOqSG
   96olpUgTdJt4pzrpUw069zLXHqJDTBq2X2UeX0SDTl6xvgCm/oCQnF7xB
   owfPZ50EXWjRtz/hTkEzDmYIfaQPzhFxzmc7t4IpnMSdjJhhNQ/I6wjCc
   jv/DTMUWanS9xoOiKFhrt6nAy4Jr63MJX+7qLeX6cvitk7gnPAuc6Y5qZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="270659010"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="270659010"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2022 19:01:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="713172177"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 15 May 2022 19:01:21 -0700
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
Subject: [PATCH 3/5] iommu: Make blocking domain static for iommu group
Date:   Mon, 16 May 2022 09:57:57 +0800
Message-Id: <20220516015759.2952771-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the blocking_domain static for an iommu group. It's allocated
when the first device joins the group and freed after the last device
leaves. Essentially the blocking domain is a dummy domain used to remove
the domain from IOMMU's device context. Unfortunately, some IOMMU devices
don't provide such capability. In this case, we use an UNMANAGED domain
without any mapping instead.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/iommu.c | 85 +++++++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8eba26be4363..dcbc55c9d8d7 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -604,8 +604,6 @@ static void iommu_group_release(struct kobject *kobj)
 
 	if (group->default_domain)
 		iommu_domain_free(group->default_domain);
-	if (group->blocking_domain)
-		iommu_domain_free(group->blocking_domain);
 
 	kfree(group->name);
 	kfree(group);
@@ -854,6 +852,46 @@ static bool iommu_is_attach_deferred(struct device *dev)
 	return false;
 }
 
+static int iommu_group_alloc_blocking_domain(struct iommu_group *group,
+					     struct device *dev)
+{
+	struct iommu_domain *domain;
+	const struct iommu_ops *iommu_ops = dev_iommu_ops(dev);
+	const struct iommu_domain_ops *ops = iommu_ops->blocking_domain_ops;
+
+	if (group->blocking_domain)
+		return 0;
+
+	if (ops->blocking_domain_detach) {
+		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+		if (domain)
+			domain->type = IOMMU_DOMAIN_BLOCKED;
+	} else {
+		domain = __iommu_domain_alloc(dev->bus, IOMMU_DOMAIN_UNMANAGED);
+	}
+
+	if (!domain)
+		return -ENOMEM;
+
+	domain->ops = ops;
+	group->blocking_domain = domain;
+
+	return 0;
+}
+
+static void iommu_group_free_blocking_domain(struct iommu_group *group,
+					     struct device *dev)
+{
+	struct iommu_domain *domain = group->blocking_domain;
+
+	if (domain->type == IOMMU_DOMAIN_BLOCKED)
+		kfree(domain);
+	else
+		iommu_domain_free(domain);
+
+	group->blocking_domain = NULL;
+}
+
 /**
  * iommu_group_add_device - add a device to an iommu group
  * @group: the group into which to add the device (reference should be held)
@@ -867,6 +905,12 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	int ret, i = 0;
 	struct group_device *device;
 
+	mutex_lock(&group->mutex);
+	ret = iommu_group_alloc_blocking_domain(group, dev);
+	mutex_unlock(&group->mutex);
+	if (ret)
+		return -ENODEV;
+
 	device = kzalloc(sizeof(*device), GFP_KERNEL);
 	if (!device)
 		return -ENOMEM;
@@ -961,6 +1005,8 @@ void iommu_group_remove_device(struct device *dev)
 			break;
 		}
 	}
+	if (list_empty(&group->devices))
+		iommu_group_free_blocking_domain(group, dev);
 	mutex_unlock(&group->mutex);
 
 	if (!device)
@@ -1961,12 +2007,16 @@ static void __iommu_group_set_core_domain(struct iommu_group *group)
 static int __iommu_attach_device(struct iommu_domain *domain,
 				 struct device *dev)
 {
+	const struct iommu_domain_ops *ops = domain->ops;
 	int ret;
 
-	if (unlikely(domain->ops->set_dev == NULL))
+	if (unlikely(ops->set_dev == NULL))
 		return -ENODEV;
 
-	ret = domain->ops->set_dev(domain, dev);
+	if (domain->type == IOMMU_DOMAIN_BLOCKED)
+		domain = iommu_get_domain_for_dev(dev);
+
+	ret = ops->set_dev(domain, dev);
 	if (!ret)
 		trace_attach_device_to_domain(dev);
 	return ret;
@@ -3146,29 +3196,6 @@ void iommu_device_unuse_default_domain(struct device *dev)
 	iommu_group_put(group);
 }
 
-static int __iommu_group_alloc_blocking_domain(struct iommu_group *group)
-{
-	struct group_device *dev =
-		list_first_entry(&group->devices, struct group_device, list);
-
-	if (group->blocking_domain)
-		return 0;
-
-	group->blocking_domain =
-		__iommu_domain_alloc(dev->dev->bus, IOMMU_DOMAIN_BLOCKED);
-	if (!group->blocking_domain) {
-		/*
-		 * For drivers that do not yet understand IOMMU_DOMAIN_BLOCKED
-		 * create an empty domain instead.
-		 */
-		group->blocking_domain = __iommu_domain_alloc(
-			dev->dev->bus, IOMMU_DOMAIN_UNMANAGED);
-		if (!group->blocking_domain)
-			return -EINVAL;
-	}
-	return 0;
-}
-
 /**
  * iommu_group_claim_dma_owner() - Set DMA ownership of a group
  * @group: The group.
@@ -3192,10 +3219,6 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
 			goto unlock_out;
 		}
 
-		ret = __iommu_group_alloc_blocking_domain(group);
-		if (ret)
-			goto unlock_out;
-
 		ret = __iommu_group_set_domain(group, group->blocking_domain);
 		if (ret)
 			goto unlock_out;
-- 
2.25.1

