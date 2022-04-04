Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E054F13DF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376291AbiDDLfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 07:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359676AbiDDLfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 07:35:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E153E3D497
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 04:33:13 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KX7qc626lz67yKr;
        Mon,  4 Apr 2022 19:30:20 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 4 Apr 2022 13:33:11 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 12:33:08 +0100
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <mst@redhat.com>, <jasowang@redhat.com>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        <chenxiang66@hisilicon.com>, <thunder.leizhen@huawei.com>,
        <jean-philippe@linaro.org>, <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RESEND v5 4/5] iommu: Allow max opt DMA len be set for a group via sysfs
Date:   Mon, 4 Apr 2022 19:27:13 +0800
Message-ID: <1649071634-188535-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1649071634-188535-1-git-send-email-john.garry@huawei.com>
References: <1649071634-188535-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to allow the maximum optimised DMA len be set for an IOMMU
group via sysfs.

This is much the same with the method to change the default domain type
for a group.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 .../ABI/testing/sysfs-kernel-iommu_groups     | 16 +++++
 drivers/iommu/iommu.c                         | 59 ++++++++++++++++++-
 include/linux/iommu.h                         |  6 ++
 3 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-iommu_groups b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
index b15af6a5bc08..ed6f72794f6c 100644
--- a/Documentation/ABI/testing/sysfs-kernel-iommu_groups
+++ b/Documentation/ABI/testing/sysfs-kernel-iommu_groups
@@ -63,3 +63,19 @@ Description:	/sys/kernel/iommu_groups/<grp_id>/type shows the type of default
 		system could lead to catastrophic effects (the users might
 		need to reboot the machine to get it to normal state). So, it's
 		expected that the users understand what they're doing.
+
+What:		/sys/kernel/iommu_groups/<grp_id>/max_opt_dma_size
+Date:		Feb 2022
+KernelVersion:	v5.18
+Contact:	iommu@lists.linux-foundation.org
+Description:	/sys/kernel/iommu_groups/<grp_id>/max_opt_dma_size shows the
+		max optimised DMA size for the default IOMMU domain associated
+		with the group.
+		Each IOMMU domain has an IOVA domain. The IOVA domain caches
+		IOVAs upto a certain size as a performance optimisation.
+		This sysfs file allows the range of the IOVA domain caching be
+		set, such that larger than default IOVAs may be cached.
+		A value of 0 means that the default caching range is chosen.
+		A privileged user could request the kernel the change the range
+		by writing to this file. For this to happen, the same rules
+		and procedure applies as in changing the default domain type.
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 10bb10c2a210..7c7258f19bed 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -48,6 +48,7 @@ struct iommu_group {
 	struct iommu_domain *default_domain;
 	struct iommu_domain *domain;
 	struct list_head entry;
+	size_t max_opt_dma_size;
 };
 
 struct group_device {
@@ -89,6 +90,9 @@ static int iommu_create_device_direct_mappings(struct iommu_group *group,
 static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
 static ssize_t iommu_group_store_type(struct iommu_group *group,
 				      const char *buf, size_t count);
+static ssize_t iommu_group_store_max_opt_dma_size(struct iommu_group *group,
+						  const char *buf,
+						  size_t count);
 
 #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
 struct iommu_group_attribute iommu_group_attr_##_name =		\
@@ -571,6 +575,12 @@ static ssize_t iommu_group_show_type(struct iommu_group *group,
 	return strlen(type);
 }
 
+static ssize_t iommu_group_show_max_opt_dma_size(struct iommu_group *group,
+				     char *buf)
+{
+	return sprintf(buf, "%zu\n", group->max_opt_dma_size);
+}
+
 static IOMMU_GROUP_ATTR(name, S_IRUGO, iommu_group_show_name, NULL);
 
 static IOMMU_GROUP_ATTR(reserved_regions, 0444,
@@ -579,6 +589,9 @@ static IOMMU_GROUP_ATTR(reserved_regions, 0444,
 static IOMMU_GROUP_ATTR(type, 0644, iommu_group_show_type,
 			iommu_group_store_type);
 
+static IOMMU_GROUP_ATTR(max_opt_dma_size, 0644, iommu_group_show_max_opt_dma_size,
+			iommu_group_store_max_opt_dma_size);
+
 static void iommu_group_release(struct kobject *kobj)
 {
 	struct iommu_group *group = to_iommu_group(kobj);
@@ -665,6 +678,10 @@ struct iommu_group *iommu_group_alloc(void)
 	if (ret)
 		return ERR_PTR(ret);
 
+	ret = iommu_group_create_file(group, &iommu_group_attr_max_opt_dma_size);
+	if (ret)
+		return ERR_PTR(ret);
+
 	pr_debug("Allocated group %d\n", group->id);
 
 	return group;
@@ -2087,6 +2104,11 @@ struct iommu_domain *iommu_get_dma_domain(struct device *dev)
 	return dev->iommu_group->default_domain;
 }
 
+size_t iommu_group_get_max_opt_dma_size(struct iommu_group *group)
+{
+	return group->max_opt_dma_size;
+}
+
 /*
  * IOMMU groups are really the natural working unit of the IOMMU, but
  * the IOMMU API works on domains and devices.  Bridge that gap by
@@ -2871,12 +2893,14 @@ EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
  * @prev_dev: The device in the group (this is used to make sure that the device
  *	 hasn't changed after the caller has called this function)
  * @type: The type of the new default domain that gets associated with the group
+ * @max_opt_dma_size: Set the IOMMU group max_opt_dma_size if non-zero
  *
  * Returns 0 on success and error code on failure
  *
  */
 static int iommu_change_dev_def_domain(struct iommu_group *group,
-				       struct device *prev_dev, int type)
+				       struct device *prev_dev, int type,
+				       unsigned long max_opt_dma_size)
 {
 	struct iommu_domain *prev_dom;
 	struct group_device *grp_dev;
@@ -2977,6 +3001,9 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 
 	group->domain = group->default_domain;
 
+	if (max_opt_dma_size)
+		group->max_opt_dma_size = max_opt_dma_size;
+
 	/*
 	 * Release the mutex here because ops->probe_finalize() call-back of
 	 * some vendor IOMMU drivers calls arm_iommu_attach_device() which
@@ -3003,6 +3030,7 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
 
 enum iommu_group_op {
 	CHANGE_GROUP_TYPE,
+	CHANGE_DMA_OPT_SIZE,
 };
 
 static int __iommu_group_store_type(const char *buf, struct iommu_group *group,
@@ -3031,7 +3059,24 @@ static int __iommu_group_store_type(const char *buf, struct iommu_group *group,
 		return -EINVAL;
 	}
 
-	return iommu_change_dev_def_domain(group, dev, type);
+	return iommu_change_dev_def_domain(group, dev, type, 0);
+}
+
+static int __iommu_group_store_max_opt_dma_size(const char *buf,
+						struct iommu_group *group,
+						struct device *dev)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 0, &val) || !val)
+		return -EINVAL;
+
+	if (device_is_bound(dev)) {
+		pr_err_ratelimited("Device is still bound to driver\n");
+		return -EINVAL;
+	}
+
+	return iommu_change_dev_def_domain(group, dev, __IOMMU_DOMAIN_SAME, val);
 }
 
 /*
@@ -3108,6 +3153,9 @@ static ssize_t iommu_group_store_common(struct iommu_group *group,
 	case CHANGE_GROUP_TYPE:
 		ret = __iommu_group_store_type(buf, group, dev);
 		break;
+	case CHANGE_DMA_OPT_SIZE:
+		ret = __iommu_group_store_max_opt_dma_size(buf, group, dev);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -3124,3 +3172,10 @@ static ssize_t iommu_group_store_type(struct iommu_group *group,
 {
 	return iommu_group_store_common(group, CHANGE_GROUP_TYPE, buf, count);
 }
+
+static ssize_t iommu_group_store_max_opt_dma_size(struct iommu_group *group,
+						  const char *buf,
+						  size_t count)
+{
+	return iommu_group_store_common(group, CHANGE_DMA_OPT_SIZE, buf, count);
+}
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index b141cf71c7af..6915e68c40b7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -430,6 +430,7 @@ extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
 				   struct device *dev, ioasid_t pasid);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
+extern size_t iommu_group_get_max_opt_dma_size(struct iommu_group *group);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		     phys_addr_t paddr, size_t size, int prot);
 extern int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
@@ -725,6 +726,11 @@ static inline struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
 	return NULL;
 }
 
+static inline size_t iommu_group_get_max_opt_dma_size(struct iommu_group *group)
+{
+	return 0;
+}
+
 static inline int iommu_map(struct iommu_domain *domain, unsigned long iova,
 			    phys_addr_t paddr, size_t size, int prot)
 {
-- 
2.26.2

