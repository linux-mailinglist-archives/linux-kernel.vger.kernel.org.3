Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE56504A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 02:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbiDRAzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 20:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235511AbiDRAz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 20:55:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C6213E89
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 17:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650243170; x=1681779170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bzKeQHa5qWTWSDpiVDQ6SnLMeCA91i1EIw+rja1W+U0=;
  b=JgtnDgkib9nLnbIUPi9Dk1b0KqRj/6XR8cl/M19cqwlYkwU9IMFI04B4
   1Z2qUk0utruZpsup7bpvUpsSmRORDb2ztju6+dR0cTQquWSpWK0Sfdj2f
   tW0hy0EIlH0NtpyJ4Oify5Sy4g/iAwo6mmbEJ3J8OhVa/fWCMt63DwqJA
   4G2700gfxH0ZIsaWgNpj6nC45kVAyBN9W/VGWD1QzFE6MbINxfmy5I0kQ
   Yo3BpKNZOZMgTx5GRFIu17xOIaOLMnyaBzxfizYcAb9JktXuBzevnMdNJ
   eHylGD3qNBq/5/FP9ITjo8G/L56HQr1IySgvgxz5HC82xfOZr8uU7Fxty
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="245313235"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="245313235"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 17:52:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="701651315"
Received: from allen-box.sh.intel.com ([10.239.159.48])
  by fmsmga001.fm.intel.com with ESMTP; 17 Apr 2022 17:52:48 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v8 09/11] vfio: Delete the unbound_list
Date:   Mon, 18 Apr 2022 08:49:58 +0800
Message-Id: <20220418005000.897664-10-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418005000.897664-1-baolu.lu@linux.intel.com>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

commit 60720a0fc646 ("vfio: Add device tracking during unbind") added the
unbound list to plug a problem with KVM where KVM_DEV_VFIO_GROUP_DEL
relied on vfio_group_get_external_user() succeeding to return the
vfio_group from a group file descriptor. The unbound list allowed
vfio_group_get_external_user() to continue to succeed in edge cases.

However commit 5d6dee80a1e9 ("vfio: New external user group/file match")
deleted the call to vfio_group_get_external_user() during
KVM_DEV_VFIO_GROUP_DEL. Instead vfio_external_group_match_file() is used
to directly match the file descriptor to the group pointer.

This in turn avoids the call down to vfio_dev_viable() during
KVM_DEV_VFIO_GROUP_DEL and also avoids the trouble the first commit was
trying to fix.

There are no other users of vfio_dev_viable() that care about the time
after vfio_unregister_group_dev() returns, so simply delete the
unbound_list entirely.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/vfio.c | 74 ++-------------------------------------------
 1 file changed, 2 insertions(+), 72 deletions(-)

diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
index 8a9347f732a5..b2f19d17d0c3 100644
--- a/drivers/vfio/vfio.c
+++ b/drivers/vfio/vfio.c
@@ -62,11 +62,6 @@ struct vfio_container {
 	bool				noiommu;
 };
 
-struct vfio_unbound_dev {
-	struct device			*dev;
-	struct list_head		unbound_next;
-};
-
 struct vfio_group {
 	struct device 			dev;
 	struct cdev			cdev;
@@ -79,8 +74,6 @@ struct vfio_group {
 	struct notifier_block		nb;
 	struct list_head		vfio_next;
 	struct list_head		container_next;
-	struct list_head		unbound_list;
-	struct mutex			unbound_lock;
 	atomic_t			opened;
 	wait_queue_head_t		container_q;
 	enum vfio_group_type		type;
@@ -340,16 +333,8 @@ vfio_group_get_from_iommu(struct iommu_group *iommu_group)
 static void vfio_group_release(struct device *dev)
 {
 	struct vfio_group *group = container_of(dev, struct vfio_group, dev);
-	struct vfio_unbound_dev *unbound, *tmp;
-
-	list_for_each_entry_safe(unbound, tmp,
-				 &group->unbound_list, unbound_next) {
-		list_del(&unbound->unbound_next);
-		kfree(unbound);
-	}
 
 	mutex_destroy(&group->device_lock);
-	mutex_destroy(&group->unbound_lock);
 	iommu_group_put(group->iommu_group);
 	ida_free(&vfio.group_ida, MINOR(group->dev.devt));
 	kfree(group);
@@ -381,8 +366,6 @@ static struct vfio_group *vfio_group_alloc(struct iommu_group *iommu_group,
 	refcount_set(&group->users, 1);
 	INIT_LIST_HEAD(&group->device_list);
 	mutex_init(&group->device_lock);
-	INIT_LIST_HEAD(&group->unbound_list);
-	mutex_init(&group->unbound_lock);
 	init_waitqueue_head(&group->container_q);
 	group->iommu_group = iommu_group;
 	/* put in vfio_group_release() */
@@ -571,19 +554,8 @@ static int vfio_dev_viable(struct device *dev, void *data)
 	struct vfio_group *group = data;
 	struct vfio_device *device;
 	struct device_driver *drv = READ_ONCE(dev->driver);
-	struct vfio_unbound_dev *unbound;
-	int ret = -EINVAL;
 
-	mutex_lock(&group->unbound_lock);
-	list_for_each_entry(unbound, &group->unbound_list, unbound_next) {
-		if (dev == unbound->dev) {
-			ret = 0;
-			break;
-		}
-	}
-	mutex_unlock(&group->unbound_lock);
-
-	if (!ret || !drv || vfio_dev_driver_allowed(dev, drv))
+	if (!drv || vfio_dev_driver_allowed(dev, drv))
 		return 0;
 
 	device = vfio_group_get_device(group, dev);
@@ -592,7 +564,7 @@ static int vfio_dev_viable(struct device *dev, void *data)
 		return 0;
 	}
 
-	return ret;
+	return -EINVAL;
 }
 
 /*
@@ -634,7 +606,6 @@ static int vfio_iommu_group_notifier(struct notifier_block *nb,
 {
 	struct vfio_group *group = container_of(nb, struct vfio_group, nb);
 	struct device *dev = data;
-	struct vfio_unbound_dev *unbound;
 
 	switch (action) {
 	case IOMMU_GROUP_NOTIFY_ADD_DEVICE:
@@ -663,28 +634,6 @@ static int vfio_iommu_group_notifier(struct notifier_block *nb,
 			__func__, iommu_group_id(group->iommu_group),
 			dev->driver->name);
 		break;
-	case IOMMU_GROUP_NOTIFY_UNBOUND_DRIVER:
-		dev_dbg(dev, "%s: group %d unbound from driver\n", __func__,
-			iommu_group_id(group->iommu_group));
-		/*
-		 * XXX An unbound device in a live group is ok, but we'd
-		 * really like to avoid the above BUG_ON by preventing other
-		 * drivers from binding to it.  Once that occurs, we have to
-		 * stop the system to maintain isolation.  At a minimum, we'd
-		 * want a toggle to disable driver auto probe for this device.
-		 */
-
-		mutex_lock(&group->unbound_lock);
-		list_for_each_entry(unbound,
-				    &group->unbound_list, unbound_next) {
-			if (dev == unbound->dev) {
-				list_del(&unbound->unbound_next);
-				kfree(unbound);
-				break;
-			}
-		}
-		mutex_unlock(&group->unbound_lock);
-		break;
 	}
 	return NOTIFY_OK;
 }
@@ -889,29 +838,10 @@ static struct vfio_device *vfio_device_get_from_name(struct vfio_group *group,
 void vfio_unregister_group_dev(struct vfio_device *device)
 {
 	struct vfio_group *group = device->group;
-	struct vfio_unbound_dev *unbound;
 	unsigned int i = 0;
 	bool interrupted = false;
 	long rc;
 
-	/*
-	 * When the device is removed from the group, the group suddenly
-	 * becomes non-viable; the device has a driver (until the unbind
-	 * completes), but it's not present in the group.  This is bad news
-	 * for any external users that need to re-acquire a group reference
-	 * in order to match and release their existing reference.  To
-	 * solve this, we track such devices on the unbound_list to bridge
-	 * the gap until they're fully unbound.
-	 */
-	unbound = kzalloc(sizeof(*unbound), GFP_KERNEL);
-	if (unbound) {
-		unbound->dev = device->dev;
-		mutex_lock(&group->unbound_lock);
-		list_add(&unbound->unbound_next, &group->unbound_list);
-		mutex_unlock(&group->unbound_lock);
-	}
-	WARN_ON(!unbound);
-
 	vfio_device_put(device);
 	rc = try_wait_for_completion(&device->comp);
 	while (rc <= 0) {
-- 
2.25.1

