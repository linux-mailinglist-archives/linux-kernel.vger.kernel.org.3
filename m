Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA5C4FBEE3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347203AbiDKOTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347439AbiDKOSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:18:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCBE140BD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bDhlcl+bt5AovkNQyHLY7HhQmDrORwFpoPCuK+is4HU=; b=zS4totNsO3mryATD0fUJHdZ8gH
        hmuUokPtl2nKZc4+yVys7uQjTYCbuNF5GYtzPQpb7SnU8HzStnMBR+jQfIQGo5YwljQPueHlqc8ij
        CDe1kf7csGCgIroxWduFjI5f4G3njkm45X0D+VnZ/oS0NGTyW4/BZW+Woek2HfAaWSfFgEIKKebwg
        vvlb1n6vioCeelU6ahaK+QnA3o7teS5XGhj4M0oOl5H8RApQwIcx5HFhLFYRO4iZkNxwL/vmhvg8r
        /yIg2Ls8Dzaq7KU+oArjxWaeVGrUWtb7YHA2K/5sTwCPQzev+SHljJUKznyz1xKfleZbPWqOCX1zz
        T+Tdh/oA==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndupS-009L01-W6; Mon, 11 Apr 2022 14:15:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 32/34] vfio/mdev: Remove mdev_parent_ops
Date:   Mon, 11 Apr 2022 16:14:01 +0200
Message-Id: <20220411141403.86980-33-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220411141403.86980-1-hch@lst.de>
References: <20220411141403.86980-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

The last useful member in this struct is the supported_type_groups, move
it to the mdev_driver and delete mdev_parent_ops.

Replace it with mdev_driver as an argument to mdev_register_device()

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 .../driver-api/vfio-mediated-device.rst       | 24 ++++--------------
 drivers/gpu/drm/i915/gvt/kvmgt.c              |  7 +-----
 drivers/s390/cio/vfio_ccw_ops.c               |  7 +-----
 drivers/s390/crypto/vfio_ap_ops.c             |  9 ++-----
 drivers/vfio/mdev/mdev_core.c                 | 13 ++++------
 drivers/vfio/mdev/mdev_private.h              |  2 +-
 drivers/vfio/mdev/mdev_sysfs.c                |  6 ++---
 include/linux/mdev.h                          | 25 +++----------------
 samples/vfio-mdev/mbochs.c                    |  9 ++-----
 samples/vfio-mdev/mdpy.c                      |  9 ++-----
 samples/vfio-mdev/mtty.c                      |  9 ++-----
 11 files changed, 28 insertions(+), 92 deletions(-)

diff --git a/Documentation/driver-api/vfio-mediated-device.rst b/Documentation/driver-api/vfio-mediated-device.rst
index 5a6e18a651a18..784bbeb22adcf 100644
--- a/Documentation/driver-api/vfio-mediated-device.rst
+++ b/Documentation/driver-api/vfio-mediated-device.rst
@@ -105,6 +105,7 @@ structure to represent a mediated device's driver::
      struct mdev_driver {
 	     int  (*probe)  (struct mdev_device *dev);
 	     void (*remove) (struct mdev_device *dev);
+	     struct attribute_group **supported_type_groups;
 	     struct device_driver    driver;
      };
 
@@ -119,30 +120,15 @@ to register and unregister itself with the core driver:
 
     extern void mdev_unregister_driver(struct mdev_driver *drv);
 
-The mediated bus driver is responsible for adding mediated devices to the VFIO
-group when devices are bound to the driver and removing mediated devices from
-the VFIO when devices are unbound from the driver.
-
-
-Physical Device Driver Interface
---------------------------------
-
-The physical device driver interface provides the mdev_parent_ops[3] structure
-to define the APIs to manage work in the mediated core driver that is related
-to the physical device.
-
-The structures in the mdev_parent_ops structure are as follows:
-
-* dev_attr_groups: attributes of the parent device
-* mdev_attr_groups: attributes of the mediated device
-* supported_config: attributes to define supported configurations
-* device_driver: device driver to bind for mediated device instances
+The mediated bus driver's probe function should create a vfio_device on top of
+the mdev_device and connect it to an appropriate implementation of
+vfio_device_ops.
 
 When a driver wants to add the GUID creation sysfs to an existing device it has
 probe'd to then it should call::
 
 	extern int  mdev_register_device(struct device *dev,
-	                                 const struct mdev_parent_ops *ops);
+	                                 struct mdev_driver *mdev_driver);
 
 This will provide the 'mdev_supported_types/XX/create' files which can then be
 used to trigger the creation of a mdev_device. The created mdev_device will be
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index f033031c676da..0787ba5c301f5 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1723,12 +1723,7 @@ static struct mdev_driver intel_vgpu_mdev_driver = {
 	},
 	.probe		= intel_vgpu_probe,
 	.remove		= intel_vgpu_remove,
-};
-
-static const struct mdev_parent_ops intel_vgpu_mdev_ops = {
-	.owner			= THIS_MODULE,
 	.supported_type_groups	= gvt_vgpu_type_groups,
-	.device_driver		= &intel_vgpu_mdev_driver,
 };
 
 int intel_gvt_page_track_add(struct intel_vgpu *info, u64 gfn)
@@ -2131,7 +2126,7 @@ static int intel_gvt_init_device(struct drm_i915_private *i915)
 	if (ret)
 		goto out_destroy_idle_vgpu;
 
-	ret = mdev_register_device(i915->drm.dev, &intel_vgpu_mdev_ops);
+	ret = mdev_register_device(i915->drm.dev, &intel_vgpu_mdev_driver);
 	if (ret)
 		goto out_cleanup_vgpu_type_groups;
 
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index d8589afac272f..c4d60cdbf247b 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -656,17 +656,12 @@ struct mdev_driver vfio_ccw_mdev_driver = {
 	},
 	.probe = vfio_ccw_mdev_probe,
 	.remove = vfio_ccw_mdev_remove,
-};
-
-static const struct mdev_parent_ops vfio_ccw_mdev_ops = {
-	.owner			= THIS_MODULE,
-	.device_driver		= &vfio_ccw_mdev_driver,
 	.supported_type_groups  = mdev_type_groups,
 };
 
 int vfio_ccw_mdev_reg(struct subchannel *sch)
 {
-	return mdev_register_device(&sch->dev, &vfio_ccw_mdev_ops);
+	return mdev_register_device(&sch->dev, &vfio_ccw_mdev_driver);
 }
 
 void vfio_ccw_mdev_unreg(struct subchannel *sch)
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 6e08d04b605d6..ee0a3bf8f476c 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1496,12 +1496,7 @@ static struct mdev_driver vfio_ap_matrix_driver = {
 	},
 	.probe = vfio_ap_mdev_probe,
 	.remove = vfio_ap_mdev_remove,
-};
-
-static const struct mdev_parent_ops vfio_ap_matrix_ops = {
-	.owner			= THIS_MODULE,
-	.device_driver		= &vfio_ap_matrix_driver,
-	.supported_type_groups	= vfio_ap_mdev_type_groups,
+	.supported_type_groups = vfio_ap_mdev_type_groups,
 };
 
 int vfio_ap_mdev_register(void)
@@ -1514,7 +1509,7 @@ int vfio_ap_mdev_register(void)
 	if (ret)
 		return ret;
 
-	ret = mdev_register_device(&matrix_dev->device, &vfio_ap_matrix_ops);
+	ret = mdev_register_device(&matrix_dev->device, &vfio_ap_matrix_driver);
 	if (ret)
 		goto err_driver;
 	return 0;
diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
index 8b1e86b9e8bc0..19a20ff420b7f 100644
--- a/drivers/vfio/mdev/mdev_core.c
+++ b/drivers/vfio/mdev/mdev_core.c
@@ -109,12 +109,12 @@ static int mdev_device_remove_cb(struct device *dev, void *data)
 /*
  * mdev_register_device : Register a device
  * @dev: device structure representing parent device.
- * @ops: Parent device operation structure to be registered.
+ * @mdev_driver: Device driver to bind to the newly created mdev
  *
  * Add device to list of registered parent devices.
  * Returns a negative value on error, otherwise 0.
  */
-int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
+int mdev_register_device(struct device *dev, struct mdev_driver *mdev_driver)
 {
 	int ret;
 	struct mdev_parent *parent;
@@ -122,9 +122,7 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
 	char *envp[] = { env_string, NULL };
 
 	/* check for mandatory ops */
-	if (!ops || !ops->supported_type_groups)
-		return -EINVAL;
-	if (!ops->device_driver)
+	if (!mdev_driver->supported_type_groups)
 		return -EINVAL;
 
 	dev = get_device(dev);
@@ -151,7 +149,7 @@ int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops)
 	init_rwsem(&parent->unreg_sem);
 
 	parent->dev = dev;
-	parent->ops = ops;
+	parent->mdev_driver = mdev_driver;
 
 	if (!mdev_bus_compat_class) {
 		mdev_bus_compat_class = class_compat_register("mdev_bus");
@@ -249,7 +247,7 @@ int mdev_device_create(struct mdev_type *type, const guid_t *uuid)
 	int ret;
 	struct mdev_device *mdev, *tmp;
 	struct mdev_parent *parent = type->parent;
-	struct mdev_driver *drv = parent->ops->device_driver;
+	struct mdev_driver *drv = parent->mdev_driver;
 
 	mutex_lock(&mdev_list_lock);
 
@@ -271,7 +269,6 @@ int mdev_device_create(struct mdev_type *type, const guid_t *uuid)
 	mdev->dev.parent  = parent->dev;
 	mdev->dev.bus = &mdev_bus_type;
 	mdev->dev.release = mdev_device_release;
-	mdev->dev.groups = parent->ops->mdev_attr_groups;
 	mdev->type = type;
 	/* Pairs with the put in mdev_device_release() */
 	kobject_get(&type->kobj);
diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_private.h
index 6999c89db7b16..5a7ffd4e770fd 100644
--- a/drivers/vfio/mdev/mdev_private.h
+++ b/drivers/vfio/mdev/mdev_private.h
@@ -15,7 +15,7 @@ void mdev_bus_unregister(void);
 
 struct mdev_parent {
 	struct device *dev;
-	const struct mdev_parent_ops *ops;
+	struct mdev_driver *mdev_driver;
 	struct kref ref;
 	struct list_head next;
 	struct kset *mdev_types_kset;
diff --git a/drivers/vfio/mdev/mdev_sysfs.c b/drivers/vfio/mdev/mdev_sysfs.c
index 66eef08833a4e..5a3873d1a275a 100644
--- a/drivers/vfio/mdev/mdev_sysfs.c
+++ b/drivers/vfio/mdev/mdev_sysfs.c
@@ -97,7 +97,7 @@ static struct mdev_type *add_mdev_supported_type(struct mdev_parent *parent,
 {
 	struct mdev_type *type;
 	struct attribute_group *group =
-		parent->ops->supported_type_groups[type_group_id];
+		parent->mdev_driver->supported_type_groups[type_group_id];
 	int ret;
 
 	if (!group->name) {
@@ -154,7 +154,7 @@ static struct mdev_type *add_mdev_supported_type(struct mdev_parent *parent,
 static void remove_mdev_supported_type(struct mdev_type *type)
 {
 	struct attribute_group *group =
-		type->parent->ops->supported_type_groups[type->type_group_id];
+		type->parent->mdev_driver->supported_type_groups[type->type_group_id];
 
 	sysfs_remove_files(&type->kobj,
 			   (const struct attribute **)group->attrs);
@@ -168,7 +168,7 @@ static int add_mdev_supported_type_groups(struct mdev_parent *parent)
 {
 	int i;
 
-	for (i = 0; parent->ops->supported_type_groups[i]; i++) {
+	for (i = 0; parent->mdev_driver->supported_type_groups[i]; i++) {
 		struct mdev_type *type;
 
 		type = add_mdev_supported_type(parent, i);
diff --git a/include/linux/mdev.h b/include/linux/mdev.h
index 69df1fa2cb6f9..1f6f57a3c3168 100644
--- a/include/linux/mdev.h
+++ b/include/linux/mdev.h
@@ -30,26 +30,6 @@ unsigned int mdev_get_type_group_id(struct mdev_device *mdev);
 unsigned int mtype_get_type_group_id(struct mdev_type *mtype);
 struct device *mtype_get_parent_dev(struct mdev_type *mtype);
 
-/**
- * struct mdev_parent_ops - Structure to be registered for each parent device to
- * register the device to mdev module.
- *
- * @owner:		The module owner.
- * @device_driver:	Which device driver to probe() on newly created devices
- * @mdev_attr_groups:	Attributes of the mediated device.
- * @supported_type_groups: Attributes to define supported types. It is mandatory
- *			to provide supported types.
- *
- * Parent device that support mediated device should be registered with mdev
- * module with mdev_parent_ops structure.
- **/
-struct mdev_parent_ops {
-	struct module   *owner;
-	struct mdev_driver *device_driver;
-	const struct attribute_group **mdev_attr_groups;
-	struct attribute_group **supported_type_groups;
-};
-
 /* interface for exporting mdev supported type attributes */
 struct mdev_type_attribute {
 	struct attribute attr;
@@ -74,12 +54,15 @@ struct mdev_type_attribute mdev_type_attr_##_name =		\
  * struct mdev_driver - Mediated device driver
  * @probe: called when new device created
  * @remove: called when device removed
+ * @supported_type_groups: Attributes to define supported types. It is mandatory
+ *			to provide supported types.
  * @driver: device driver structure
  *
  **/
 struct mdev_driver {
 	int (*probe)(struct mdev_device *dev);
 	void (*remove)(struct mdev_device *dev);
+	struct attribute_group **supported_type_groups;
 	struct device_driver driver;
 };
 
@@ -98,7 +81,7 @@ static inline const guid_t *mdev_uuid(struct mdev_device *mdev)
 
 extern struct bus_type mdev_bus_type;
 
-int mdev_register_device(struct device *dev, const struct mdev_parent_ops *ops);
+int mdev_register_device(struct device *dev, struct mdev_driver *mdev_driver);
 void mdev_unregister_device(struct device *dev);
 
 int mdev_register_driver(struct mdev_driver *drv);
diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
index e90c8552cc312..344c2901a82bf 100644
--- a/samples/vfio-mdev/mbochs.c
+++ b/samples/vfio-mdev/mbochs.c
@@ -1412,12 +1412,7 @@ static struct mdev_driver mbochs_driver = {
 	},
 	.probe = mbochs_probe,
 	.remove	= mbochs_remove,
-};
-
-static const struct mdev_parent_ops mdev_fops = {
-	.owner			= THIS_MODULE,
-	.device_driver		= &mbochs_driver,
-	.supported_type_groups	= mdev_type_groups,
+	.supported_type_groups = mdev_type_groups,
 };
 
 static const struct file_operations vd_fops = {
@@ -1462,7 +1457,7 @@ static int __init mbochs_dev_init(void)
 	if (ret)
 		goto err_class;
 
-	ret = mdev_register_device(&mbochs_dev, &mdev_fops);
+	ret = mdev_register_device(&mbochs_dev, &mbochs_driver);
 	if (ret)
 		goto err_device;
 
diff --git a/samples/vfio-mdev/mdpy.c b/samples/vfio-mdev/mdpy.c
index fe5d43e797b6d..e8c46eb2e2468 100644
--- a/samples/vfio-mdev/mdpy.c
+++ b/samples/vfio-mdev/mdpy.c
@@ -723,12 +723,7 @@ static struct mdev_driver mdpy_driver = {
 	},
 	.probe = mdpy_probe,
 	.remove	= mdpy_remove,
-};
-
-static const struct mdev_parent_ops mdev_fops = {
-	.owner			= THIS_MODULE,
-	.device_driver          = &mdpy_driver,
-	.supported_type_groups	= mdev_type_groups,
+	.supported_type_groups = mdev_type_groups,
 };
 
 static const struct file_operations vd_fops = {
@@ -771,7 +766,7 @@ static int __init mdpy_dev_init(void)
 	if (ret)
 		goto err_class;
 
-	ret = mdev_register_device(&mdpy_dev, &mdev_fops);
+	ret = mdev_register_device(&mdpy_dev, &mdpy_driver);
 	if (ret)
 		goto err_device;
 
diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
index 4f227dc267859..f42a59ed2e3fe 100644
--- a/samples/vfio-mdev/mtty.c
+++ b/samples/vfio-mdev/mtty.c
@@ -1301,12 +1301,7 @@ static struct mdev_driver mtty_driver = {
 	},
 	.probe = mtty_probe,
 	.remove	= mtty_remove,
-};
-
-static const struct mdev_parent_ops mdev_fops = {
-	.owner                  = THIS_MODULE,
-	.device_driver		= &mtty_driver,
-	.supported_type_groups  = mdev_type_groups,
+	.supported_type_groups = mdev_type_groups,
 };
 
 static void mtty_device_release(struct device *dev)
@@ -1357,7 +1352,7 @@ static int __init mtty_dev_init(void)
 	if (ret)
 		goto err_class;
 
-	ret = mdev_register_device(&mtty_dev.dev, &mdev_fops);
+	ret = mdev_register_device(&mtty_dev.dev, &mtty_driver);
 	if (ret)
 		goto err_device;
 	return 0;
-- 
2.30.2

