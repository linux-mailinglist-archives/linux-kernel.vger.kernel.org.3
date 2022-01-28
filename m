Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC1849F794
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347892AbiA1KuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:50:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4543 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347878AbiA1KuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:50:01 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JlZ310Wymz67dnT;
        Fri, 28 Jan 2022 18:49:33 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Fri, 28 Jan 2022 11:49:58 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 10:49:57 +0000
From:   John Garry <john.garry@huawei.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH] iommu: Fix some W=1 warnings
Date:   Fri, 28 Jan 2022 18:44:33 +0800
Message-ID: <1643366673-26803-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code is mostly free of W=1 warning, so fix the following:

drivers/iommu/iommu.c:996: warning: expecting prototype for iommu_group_for_each_dev(). Prototype was for __iommu_group_for_each_dev() instead
drivers/iommu/iommu.c:3048: warning: Function parameter or member 'drvdata' not described in 'iommu_sva_bind_device'
drivers/iommu/ioasid.c:354: warning: Function parameter or member 'ioasid' not described in 'ioasid_get'
drivers/iommu/omap-iommu.c:1098: warning: expecting prototype for omap_iommu_suspend_prepare(). Prototype was for omap_iommu_prepare() instead

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 50ee27bbd04e..06fee7416816 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -349,6 +349,7 @@ EXPORT_SYMBOL_GPL(ioasid_alloc);
 
 /**
  * ioasid_get - obtain a reference to the IOASID
+ * @ioasid: the ID to get
  */
 void ioasid_get(ioasid_t ioasid)
 {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8b86406b7162..75741ce748d5 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -980,17 +980,6 @@ static int iommu_group_device_count(struct iommu_group *group)
 	return ret;
 }
 
-/**
- * iommu_group_for_each_dev - iterate over each device in the group
- * @group: the group
- * @data: caller opaque data to be passed to callback function
- * @fn: caller supplied callback function
- *
- * This function is called by group users to iterate over group devices.
- * Callers should hold a reference count to the group during callback.
- * The group->mutex is held across callbacks, which will block calls to
- * iommu_group_add/remove_device.
- */
 static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
 				      int (*fn)(struct device *, void *))
 {
@@ -1005,7 +994,17 @@ static int __iommu_group_for_each_dev(struct iommu_group *group, void *data,
 	return ret;
 }
 
-
+/**
+ * iommu_group_for_each_dev - iterate over each device in the group
+ * @group: the group
+ * @data: caller opaque data to be passed to callback function
+ * @fn: caller supplied callback function
+ *
+ * This function is called by group users to iterate over group devices.
+ * Callers should hold a reference count to the group during callback.
+ * The group->mutex is held across callbacks, which will block calls to
+ * iommu_group_add/remove_device.
+ */
 int iommu_group_for_each_dev(struct iommu_group *group, void *data,
 			     int (*fn)(struct device *, void *))
 {
@@ -3032,6 +3031,7 @@ EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
  * iommu_sva_bind_device() - Bind a process address space to a device
  * @dev: the device
  * @mm: the mm to bind, caller must hold a reference to it
+ * @drvdata: opaque data pointer to pass to bind callback
  *
  * Create a bond between device and address space, allowing the device to access
  * the mm using the returned PASID. If a bond already exists between @device and
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 91749654fd49..980e4af3f06b 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -1085,7 +1085,7 @@ static __maybe_unused int omap_iommu_runtime_resume(struct device *dev)
 }
 
 /**
- * omap_iommu_suspend_prepare - prepare() dev_pm_ops implementation
+ * omap_iommu_prepare - prepare() dev_pm_ops implementation
  * @dev:	iommu device
  *
  * This function performs the necessary checks to determine if the IOMMU
-- 
2.26.2

