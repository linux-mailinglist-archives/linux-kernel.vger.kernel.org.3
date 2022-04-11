Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AC94FBECA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347095AbiDKOR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347069AbiDKOQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:16:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93F513E1F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6zgsjJTtDs8gomf56UMEyIQlcQ9YsIVad5sV5zYKAUA=; b=E4J0AVo3+3bnaHlpVco0N/nSDW
        S4L+Ny1iPPpI4lHvV99QshUDotPmjl2+Gnu4rMy4xsulE0dmRzMVWNz2TB2pwoiI9h+cDBEydNT9M
        V5NpgCQKl5DBMhEENvXdPh5FLc4UxFBtj6+YB2DmsSxQyka3jaflqliEZrW34hFfQ00avQE6fchld
        Mg0LizZgkfo1DBj6E6dBzmIGNxwHiMqjNUCyrBslvatG/iSSb/Ytd3P+4ECq16gUn1lo6d8Ml+/SQ
        REKhjaMVFlBZSUGAd5O49FVnWV8M+8Cfe6OeqNqfUJ5BDwnXZ0MdMYxlAZROpIrSL8vajU+eg6CM2
        IDuaTVrw==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nduoH-009KPA-Oz; Mon, 11 Apr 2022 14:14:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/34] drm/i915/gvt: remove intel_gvt_ops
Date:   Mon, 11 Apr 2022 16:13:36 +0200
Message-Id: <20220411141403.86980-8-hch@lst.de>
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

Remove these pointless indirect alls by just calling the only instance
of each method directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/gvt.c       | 20 +--------------
 drivers/gpu/drm/i915/gvt/gvt.h       | 24 ------------------
 drivers/gpu/drm/i915/gvt/hypercall.h |  2 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c     | 37 +++++++++++-----------------
 drivers/gpu/drm/i915/gvt/mpt.h       |  5 ++--
 5 files changed, 19 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gvt.c b/drivers/gpu/drm/i915/gvt/gvt.c
index c3308058f4616..9259f2a17398d 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.c
+++ b/drivers/gpu/drm/i915/gvt/gvt.c
@@ -39,23 +39,6 @@
 #include <linux/vfio.h>
 #include <linux/mdev.h>
 
-static const struct intel_gvt_ops intel_gvt_ops = {
-	.emulate_cfg_read = intel_vgpu_emulate_cfg_read,
-	.emulate_cfg_write = intel_vgpu_emulate_cfg_write,
-	.emulate_mmio_read = intel_vgpu_emulate_mmio_read,
-	.emulate_mmio_write = intel_vgpu_emulate_mmio_write,
-	.vgpu_create = intel_gvt_create_vgpu,
-	.vgpu_destroy = intel_gvt_destroy_vgpu,
-	.vgpu_release = intel_gvt_release_vgpu,
-	.vgpu_reset = intel_gvt_reset_vgpu,
-	.vgpu_activate = intel_gvt_activate_vgpu,
-	.vgpu_deactivate = intel_gvt_deactivate_vgpu,
-	.vgpu_query_plane = intel_vgpu_query_plane,
-	.vgpu_get_dmabuf = intel_vgpu_get_dmabuf,
-	.write_protect_handler = intel_vgpu_page_track_handler,
-	.emulate_hotplug = intel_vgpu_emulate_hotplug,
-};
-
 static void init_device_info(struct intel_gvt *gvt)
 {
 	struct intel_gvt_device_info *info = &gvt->device_info;
@@ -252,8 +235,7 @@ static int intel_gvt_init_device(struct drm_i915_private *i915)
 
 	intel_gvt_debugfs_init(gvt);
 
-	ret = intel_gvt_hypervisor_host_init(i915->drm.dev, gvt,
-					     &intel_gvt_ops);
+	ret = intel_gvt_hypervisor_host_init(i915->drm.dev, gvt);
 	if (ret)
 		goto out_destroy_idle_vgpu;
 
diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index dc36a791467b9..97150a1297ebb 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -556,30 +556,6 @@ void populate_pvinfo_page(struct intel_vgpu *vgpu);
 int intel_gvt_scan_and_shadow_workload(struct intel_vgpu_workload *workload);
 void enter_failsafe_mode(struct intel_vgpu *vgpu, int reason);
 
-struct intel_gvt_ops {
-	int (*emulate_cfg_read)(struct intel_vgpu *, unsigned int, void *,
-				unsigned int);
-	int (*emulate_cfg_write)(struct intel_vgpu *, unsigned int, void *,
-				unsigned int);
-	int (*emulate_mmio_read)(struct intel_vgpu *, u64, void *,
-				unsigned int);
-	int (*emulate_mmio_write)(struct intel_vgpu *, u64, void *,
-				unsigned int);
-	struct intel_vgpu *(*vgpu_create)(struct intel_gvt *,
-				struct intel_vgpu_type *);
-	void (*vgpu_destroy)(struct intel_vgpu *vgpu);
-	void (*vgpu_release)(struct intel_vgpu *vgpu);
-	void (*vgpu_reset)(struct intel_vgpu *);
-	void (*vgpu_activate)(struct intel_vgpu *);
-	void (*vgpu_deactivate)(struct intel_vgpu *);
-	int (*vgpu_query_plane)(struct intel_vgpu *vgpu, void *);
-	int (*vgpu_get_dmabuf)(struct intel_vgpu *vgpu, unsigned int);
-	int (*write_protect_handler)(struct intel_vgpu *, u64, void *,
-				     unsigned int);
-	void (*emulate_hotplug)(struct intel_vgpu *vgpu, bool connected);
-};
-
-
 enum {
 	GVT_FAILSAFE_UNSUPPORTED_GUEST,
 	GVT_FAILSAFE_INSUFFICIENT_RESOURCE,
diff --git a/drivers/gpu/drm/i915/gvt/hypercall.h b/drivers/gpu/drm/i915/gvt/hypercall.h
index 3179831536458..395bce9633faa 100644
--- a/drivers/gpu/drm/i915/gvt/hypercall.h
+++ b/drivers/gpu/drm/i915/gvt/hypercall.h
@@ -42,7 +42,7 @@ struct device;
  * both Xen and KVM by providing dedicated hypervisor-related MPT modules.
  */
 struct intel_gvt_mpt {
-	int (*host_init)(struct device *dev, void *gvt, const void *ops);
+	int (*host_init)(struct device *dev, void *gvt);
 	void (*host_exit)(struct device *dev, void *gvt);
 	int (*attach_vgpu)(void *vgpu, unsigned long *handle);
 	void (*detach_vgpu)(void *vgpu);
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index fa8b326eb2197..9ed13c86d4765 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -55,8 +55,6 @@
 MODULE_IMPORT_NS(DMA_BUF);
 MODULE_IMPORT_NS(I915_GVT);
 
-static const struct intel_gvt_ops *intel_gvt_ops;
-
 /* helper macros copied from vfio-pci */
 #define VFIO_PCI_OFFSET_SHIFT   40
 #define VFIO_PCI_OFFSET_TO_INDEX(off)   (off >> VFIO_PCI_OFFSET_SHIFT)
@@ -621,9 +619,9 @@ static int handle_edid_regs(struct intel_vgpu *vgpu,
 					gvt_vgpu_err("invalid EDID blob\n");
 					return -EINVAL;
 				}
-				intel_gvt_ops->emulate_hotplug(vgpu, true);
+				intel_vgpu_emulate_hotplug(vgpu, true);
 			} else if (data == VFIO_DEVICE_GFX_LINK_STATE_DOWN)
-				intel_gvt_ops->emulate_hotplug(vgpu, false);
+				intel_vgpu_emulate_hotplug(vgpu, false);
 			else {
 				gvt_vgpu_err("invalid EDID link state %d\n",
 					regs->link_state);
@@ -825,7 +823,7 @@ static int intel_vgpu_create(struct mdev_device *mdev)
 		goto out;
 	}
 
-	vgpu = intel_gvt_ops->vgpu_create(gvt, type);
+	vgpu = intel_gvt_create_vgpu(gvt, type);
 	if (IS_ERR_OR_NULL(vgpu)) {
 		ret = vgpu == NULL ? -EFAULT : PTR_ERR(vgpu);
 		gvt_err("failed to create intel vgpu: %d\n", ret);
@@ -852,7 +850,7 @@ static int intel_vgpu_remove(struct mdev_device *mdev)
 	if (handle_valid(vgpu->handle))
 		return -EBUSY;
 
-	intel_gvt_ops->vgpu_destroy(vgpu);
+	intel_gvt_destroy_vgpu(vgpu);
 	return 0;
 }
 
@@ -955,7 +953,7 @@ static int intel_vgpu_open_device(struct mdev_device *mdev)
 	if (ret)
 		goto undo_group;
 
-	intel_gvt_ops->vgpu_activate(vgpu);
+	intel_gvt_activate_vgpu(vgpu);
 
 	atomic_set(&vdev->released, 0);
 	return ret;
@@ -1000,7 +998,7 @@ static void __intel_vgpu_release(struct intel_vgpu *vgpu)
 	if (atomic_cmpxchg(&vdev->released, 0, 1))
 		return;
 
-	intel_gvt_ops->vgpu_release(vgpu);
+	intel_gvt_release_vgpu(vgpu);
 
 	ret = vfio_unregister_notifier(mdev_dev(vdev->mdev), VFIO_IOMMU_NOTIFY,
 					&vdev->iommu_notifier);
@@ -1074,10 +1072,10 @@ static int intel_vgpu_bar_rw(struct intel_vgpu *vgpu, int bar, u64 off,
 	int ret;
 
 	if (is_write)
-		ret = intel_gvt_ops->emulate_mmio_write(vgpu,
+		ret = intel_vgpu_emulate_mmio_write(vgpu,
 					bar_start + off, buf, count);
 	else
-		ret = intel_gvt_ops->emulate_mmio_read(vgpu,
+		ret = intel_vgpu_emulate_mmio_read(vgpu,
 					bar_start + off, buf, count);
 	return ret;
 }
@@ -1133,10 +1131,10 @@ static ssize_t intel_vgpu_rw(struct mdev_device *mdev, char *buf,
 	switch (index) {
 	case VFIO_PCI_CONFIG_REGION_INDEX:
 		if (is_write)
-			ret = intel_gvt_ops->emulate_cfg_write(vgpu, pos,
+			ret = intel_vgpu_emulate_cfg_write(vgpu, pos,
 						buf, count);
 		else
-			ret = intel_gvt_ops->emulate_cfg_read(vgpu, pos,
+			ret = intel_vgpu_emulate_cfg_read(vgpu, pos,
 						buf, count);
 		break;
 	case VFIO_PCI_BAR0_REGION_INDEX:
@@ -1704,7 +1702,7 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
 
 		return ret;
 	} else if (cmd == VFIO_DEVICE_RESET) {
-		intel_gvt_ops->vgpu_reset(vgpu);
+		intel_gvt_reset_vgpu(vgpu);
 		return 0;
 	} else if (cmd == VFIO_DEVICE_QUERY_GFX_PLANE) {
 		struct vfio_device_gfx_plane_info dmabuf;
@@ -1717,7 +1715,7 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
 		if (dmabuf.argsz < minsz)
 			return -EINVAL;
 
-		ret = intel_gvt_ops->vgpu_query_plane(vgpu, &dmabuf);
+		ret = intel_vgpu_query_plane(vgpu, &dmabuf);
 		if (ret != 0)
 			return ret;
 
@@ -1725,14 +1723,10 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
 								-EFAULT : 0;
 	} else if (cmd == VFIO_DEVICE_GET_GFX_DMABUF) {
 		__u32 dmabuf_id;
-		__s32 dmabuf_fd;
 
 		if (get_user(dmabuf_id, (__u32 __user *)arg))
 			return -EFAULT;
-
-		dmabuf_fd = intel_gvt_ops->vgpu_get_dmabuf(vgpu, dmabuf_id);
-		return dmabuf_fd;
-
+		return intel_vgpu_get_dmabuf(vgpu, dmabuf_id);
 	}
 
 	return -ENOTTY;
@@ -1783,7 +1777,7 @@ static struct mdev_parent_ops intel_vgpu_mdev_ops = {
 	.ioctl			= intel_vgpu_ioctl,
 };
 
-static int kvmgt_host_init(struct device *dev, void *gvt, const void *ops)
+static int kvmgt_host_init(struct device *dev, void *gvt)
 {
 	int ret;
 
@@ -1791,7 +1785,6 @@ static int kvmgt_host_init(struct device *dev, void *gvt, const void *ops)
 	if (ret)
 		return ret;
 
-	intel_gvt_ops = ops;
 	intel_vgpu_mdev_ops.supported_type_groups = gvt_vgpu_type_groups;
 
 	ret = mdev_register_device(dev, &intel_vgpu_mdev_ops);
@@ -1883,7 +1876,7 @@ static void kvmgt_page_track_write(struct kvm_vcpu *vcpu, gpa_t gpa,
 					struct kvmgt_guest_info, track_node);
 
 	if (kvmgt_gfn_is_write_protected(info, gpa_to_gfn(gpa)))
-		intel_gvt_ops->write_protect_handler(info->vgpu, gpa,
+		intel_vgpu_page_track_handler(info->vgpu, gpa,
 						     (void *)val, len);
 }
 
diff --git a/drivers/gpu/drm/i915/gvt/mpt.h b/drivers/gpu/drm/i915/gvt/mpt.h
index 1b5617bb27450..0e3966e1fec8b 100644
--- a/drivers/gpu/drm/i915/gvt/mpt.h
+++ b/drivers/gpu/drm/i915/gvt/mpt.h
@@ -51,13 +51,12 @@
  * Returns:
  * Zero on success, negative error code if failed
  */
-static inline int intel_gvt_hypervisor_host_init(struct device *dev,
-						 void *gvt, const void *ops)
+static inline int intel_gvt_hypervisor_host_init(struct device *dev, void *gvt)
 {
 	if (!intel_gvt_host.mpt->host_init)
 		return -ENODEV;
 
-	return intel_gvt_host.mpt->host_init(dev, gvt, ops);
+	return intel_gvt_host.mpt->host_init(dev, gvt);
 }
 
 /**
-- 
2.30.2

