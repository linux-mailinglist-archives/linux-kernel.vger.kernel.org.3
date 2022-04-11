Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68D14FBECC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347023AbiDKORE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347026AbiDKOQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:16:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB38413DD3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=99Fm3UPQ61trWTmW4kEBMqv2veMwhRCyi09HwjcmZNg=; b=zNLV03frlzxA8V+uiM//HP8uJx
        v3MvP9Qcoi3SJV39jFbUu+2+ftje84OIRAYUogy7n6wF6fv/t7+D6rgOGCx+682dPXoPi9IJQIvlS
        xd6vKCv8BUIW0hFXrkJm411e4d1s5/DYRR7no+yoSA4KlZ6Kp5jkILQJgxmh0lkbYhpuQgHG8+wJ3
        0x69V1Il+qpq0vYU4Q55pyxV7jvk6AX4ZUftj0z7YnhmKjxsg4znETYYivfBrqrI6amjQQIQlJFr7
        FjXxvW2oRJaOEWFjo4RCujWkpsDR8TlyXaJt0eIjHY7Qu03fHor+lYqWCdtq++OFHnE2of/9uFH+/
        ZX9go3Sw==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nduoE-009KNG-MP; Mon, 11 Apr 2022 14:14:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/34] drm/i915/gvt: move the gvt code into kvmgt.ko
Date:   Mon, 11 Apr 2022 16:13:35 +0200
Message-Id: <20220411141403.86980-7-hch@lst.de>
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

Instead of having an option to build the gvt code into the main i915
module, just move it into the kvmgt.ko module.  This only requires
a new struct with three entries that the KVMGT modules needs to register
with the main i915 module, and a proper list of GVT-enabled devices
instead of global device pointer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/Kconfig                |  36 ++--
 drivers/gpu/drm/i915/Makefile               |   2 +-
 drivers/gpu/drm/i915/gvt/Makefile           |   5 +-
 drivers/gpu/drm/i915/gvt/gvt.c              |  55 ++----
 drivers/gpu/drm/i915/gvt/gvt.h              |   6 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c            |  14 +-
 drivers/gpu/drm/i915/gvt/mpt.h              |   3 -
 drivers/gpu/drm/i915/i915_driver.c          |   7 -
 drivers/gpu/drm/i915/i915_drv.h             |   1 +
 drivers/gpu/drm/i915/intel_gvt.c            | 200 +++++++++++++-------
 drivers/gpu/drm/i915/intel_gvt.h            |  17 +-
 drivers/gpu/drm/i915/intel_gvt_mmio_table.c |   1 +
 12 files changed, 193 insertions(+), 154 deletions(-)

diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 98c5450b8eacc..be122f541cf97 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -102,40 +102,30 @@ config DRM_I915_USERPTR
 	  If in doubt, say "Y".
 
 config DRM_I915_GVT
-	bool "Enable Intel GVT-g graphics virtualization host support"
+	bool
+
+config DRM_I915_GVT_KVMGT
+	tristate "Enable KVM host support Intel GVT-g graphics virtualization"
 	depends on DRM_I915
 	depends on X86
 	depends on 64BIT
-	default n
+	depends on KVM
+	depends on VFIO_MDEV
+	select DRM_I915_GVT
+	select KVM_EXTERNAL_WRITE_TRACKING
+
 	help
 	  Choose this option if you want to enable Intel GVT-g graphics
 	  virtualization technology host support with integrated graphics.
 	  With GVT-g, it's possible to have one integrated graphics
-	  device shared by multiple VMs under different hypervisors.
-
-	  Note that at least one hypervisor like Xen or KVM is required for
-	  this driver to work, and it only supports newer device from
-	  Broadwell+. For further information and setup guide, you can
-	  visit: http://01.org/igvt-g.
+	  device shared by multiple VMs under KVM.
 
-	  Now it's just a stub to support the modifications of i915 for
-	  GVT device model. It requires at least one MPT modules for Xen/KVM
-	  and other components of GVT device model to work. Use it under
-	  you own risk.
+	  Note that this driver only supports newer device from Broadwell on.
+	  For further information and setup guide, you can visit:
+	  http://01.org/igvt-g.
 
 	  If in doubt, say "N".
 
-config DRM_I915_GVT_KVMGT
-	tristate "Enable KVM/VFIO support for Intel GVT-g"
-	depends on DRM_I915_GVT
-	depends on KVM
-	depends on VFIO_MDEV
-	select KVM_EXTERNAL_WRITE_TRACKING
-	default n
-	help
-	  Choose this option if you want to enable KVMGT support for
-	  Intel GVT-g.
-
 config DRM_I915_PXP
 	bool "Enable Intel PXP support"
 	depends on DRM_I915
diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index a6cab2d9a9d19..23c5c7de3069e 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -326,7 +326,7 @@ include $(src)/gvt/Makefile
 endif
 
 obj-$(CONFIG_DRM_I915) += i915.o
-obj-$(CONFIG_DRM_I915_GVT_KVMGT) += gvt/kvmgt.o
+obj-$(CONFIG_DRM_I915_GVT_KVMGT) += kvmgt.o
 
 # header test
 
diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
index f2f6ea02714ec..cecedd9830f7c 100644
--- a/drivers/gpu/drm/i915/gvt/Makefile
+++ b/drivers/gpu/drm/i915/gvt/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-i915-y += \
+kvmgt-y += \
 	gvt/gvt.o \
 	gvt/aperture_gm.o \
 	gvt/handlers.o \
@@ -22,4 +22,5 @@ i915-y += \
 	gvt/debugfs.o \
 	gvt/fb_decoder.o \
 	gvt/dmabuf.o \
-	gvt/page_track.o
+	gvt/page_track.o \
+	gvt/kvmgt.o
diff --git a/drivers/gpu/drm/i915/gvt/gvt.c b/drivers/gpu/drm/i915/gvt/gvt.c
index b4b13e4a94e34..c3308058f4616 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.c
+++ b/drivers/gpu/drm/i915/gvt/gvt.c
@@ -39,8 +39,6 @@
 #include <linux/vfio.h>
 #include <linux/mdev.h>
 
-struct intel_gvt_host intel_gvt_host;
-
 static const struct intel_gvt_ops intel_gvt_ops = {
 	.emulate_cfg_read = intel_vgpu_emulate_cfg_read,
 	.emulate_cfg_write = intel_vgpu_emulate_cfg_write,
@@ -147,13 +145,14 @@ static int init_service_thread(struct intel_gvt *gvt)
  * resources owned by a GVT device.
  *
  */
-void intel_gvt_clean_device(struct drm_i915_private *i915)
+static void intel_gvt_clean_device(struct drm_i915_private *i915)
 {
 	struct intel_gvt *gvt = fetch_and_zero(&i915->gvt);
 
 	if (drm_WARN_ON(&i915->drm, !gvt))
 		return;
 
+	intel_gvt_hypervisor_host_exit(i915->drm.dev, gvt);
 	intel_gvt_destroy_idle_vgpu(gvt->idle_vgpu);
 	intel_gvt_clean_vgpu_types(gvt);
 
@@ -181,7 +180,7 @@ void intel_gvt_clean_device(struct drm_i915_private *i915)
  * Zero on success, negative error code if failed.
  *
  */
-int intel_gvt_init_device(struct drm_i915_private *i915)
+static int intel_gvt_init_device(struct drm_i915_private *i915)
 {
 	struct intel_gvt *gvt;
 	struct intel_vgpu *vgpu;
@@ -253,11 +252,17 @@ int intel_gvt_init_device(struct drm_i915_private *i915)
 
 	intel_gvt_debugfs_init(gvt);
 
+	ret = intel_gvt_hypervisor_host_init(i915->drm.dev, gvt,
+					     &intel_gvt_ops);
+	if (ret)
+		goto out_destroy_idle_vgpu;
+
 	gvt_dbg_core("gvt device initialization is done\n");
-	intel_gvt_host.dev = i915->drm.dev;
-	intel_gvt_host.initialized = true;
 	return 0;
 
+out_destroy_idle_vgpu:
+	intel_gvt_destroy_idle_vgpu(gvt->idle_vgpu);
+	intel_gvt_debugfs_clean(gvt);
 out_clean_types:
 	intel_gvt_clean_vgpu_types(gvt);
 out_clean_thread:
@@ -281,39 +286,17 @@ int intel_gvt_init_device(struct drm_i915_private *i915)
 	return ret;
 }
 
-int
-intel_gvt_pm_resume(struct intel_gvt *gvt)
+static void intel_gvt_pm_resume(struct drm_i915_private *i915)
 {
+	struct intel_gvt *gvt = i915->gvt;
+
 	intel_gvt_restore_fence(gvt);
 	intel_gvt_restore_mmio(gvt);
 	intel_gvt_restore_ggtt(gvt);
-	return 0;
-}
-
-int
-intel_gvt_register_hypervisor(const struct intel_gvt_mpt *m)
-{
-	int ret;
-	void *gvt;
-
-	if (!intel_gvt_host.initialized)
-		return -ENODEV;
-
-	intel_gvt_host.mpt = m;
-	gvt = (void *)kdev_to_i915(intel_gvt_host.dev)->gvt;
-
-	ret = intel_gvt_hypervisor_host_init(intel_gvt_host.dev, gvt,
-					     &intel_gvt_ops);
-	if (ret < 0)
-		return -ENODEV;
-	return 0;
 }
-EXPORT_SYMBOL_GPL(intel_gvt_register_hypervisor);
 
-void
-intel_gvt_unregister_hypervisor(void)
-{
-	void *gvt = (void *)kdev_to_i915(intel_gvt_host.dev)->gvt;
-	intel_gvt_hypervisor_host_exit(intel_gvt_host.dev, gvt);
-}
-EXPORT_SYMBOL_GPL(intel_gvt_unregister_hypervisor);
+const struct intel_vgpu_ops intel_gvt_vgpu_ops = {
+	.init_device	= intel_gvt_init_device,
+	.clean_device	= intel_gvt_clean_device,
+	.pm_resume	= intel_gvt_pm_resume,
+};
diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index 554baf26cab35..dc36a791467b9 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -58,8 +58,6 @@
 #define GVT_MAX_VGPU 8
 
 struct intel_gvt_host {
-	struct device *dev;
-	bool initialized;
 	const struct intel_gvt_mpt *mpt;
 };
 
@@ -728,9 +726,9 @@ void intel_gvt_debugfs_remove_vgpu(struct intel_vgpu *vgpu);
 void intel_gvt_debugfs_init(struct intel_gvt *gvt);
 void intel_gvt_debugfs_clean(struct intel_gvt *gvt);
 
-int intel_gvt_pm_resume(struct intel_gvt *gvt);
-
 #include "trace.h"
 #include "mpt.h"
 
+extern const struct intel_vgpu_ops intel_gvt_vgpu_ops;
+
 #endif
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index e3f0c555ed5f6..fa8b326eb2197 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -49,8 +49,12 @@
 #include <drm/drm_edid.h>
 
 #include "i915_drv.h"
+#include "intel_gvt.h"
 #include "gvt.h"
 
+MODULE_IMPORT_NS(DMA_BUF);
+MODULE_IMPORT_NS(I915_GVT);
+
 static const struct intel_gvt_ops *intel_gvt_ops;
 
 /* helper macros copied from vfio-pci */
@@ -2242,16 +2246,18 @@ static const struct intel_gvt_mpt kvmgt_mpt = {
 	.is_valid_gfn = kvmgt_is_valid_gfn,
 };
 
+struct intel_gvt_host intel_gvt_host = {
+	.mpt		= &kvmgt_mpt,
+};
+
 static int __init kvmgt_init(void)
 {
-	if (intel_gvt_register_hypervisor(&kvmgt_mpt) < 0)
-		return -ENODEV;
-	return 0;
+	return intel_gvt_set_ops(&intel_gvt_vgpu_ops);
 }
 
 static void __exit kvmgt_exit(void)
 {
-	intel_gvt_unregister_hypervisor();
+	intel_gvt_clear_ops(&intel_gvt_vgpu_ops);
 }
 
 module_init(kvmgt_init);
diff --git a/drivers/gpu/drm/i915/gvt/mpt.h b/drivers/gpu/drm/i915/gvt/mpt.h
index e6c5a792a49a5..1b5617bb27450 100644
--- a/drivers/gpu/drm/i915/gvt/mpt.h
+++ b/drivers/gpu/drm/i915/gvt/mpt.h
@@ -394,7 +394,4 @@ static inline bool intel_gvt_hypervisor_is_valid_gfn(
 	return intel_gvt_host.mpt->is_valid_gfn(vgpu->handle, gfn);
 }
 
-int intel_gvt_register_hypervisor(const struct intel_gvt_mpt *);
-void intel_gvt_unregister_hypervisor(void);
-
 #endif /* _GVT_MPT_H_ */
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 62b3f332bbf5c..46b7315de6969 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -468,11 +468,6 @@ static void i915_driver_mmio_release(struct drm_i915_private *dev_priv)
 	pci_dev_put(dev_priv->bridge_dev);
 }
 
-static void intel_sanitize_options(struct drm_i915_private *dev_priv)
-{
-	intel_gvt_sanitize_options(dev_priv);
-}
-
 /**
  * i915_set_dma_info - set all relevant PCI dma info as configured for the
  * platform
@@ -566,8 +561,6 @@ static int i915_driver_hw_probe(struct drm_i915_private *dev_priv)
 		}
 	}
 
-	intel_sanitize_options(dev_priv);
-
 	/* needs to be done before ggtt probe */
 	intel_dram_edram_detect(dev_priv);
 
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 0830020c11c02..204cf703323e5 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -434,6 +434,7 @@ struct i915_virtual_gpu {
 	u32 caps;
 	u32 *initial_mmio;
 	u8 *initial_cfg_space;
+	struct list_head entry;
 };
 
 struct i915_selftest_stash {
diff --git a/drivers/gpu/drm/i915/intel_gvt.c b/drivers/gpu/drm/i915/intel_gvt.c
index 65daab2c4d9eb..7c03d975069eb 100644
--- a/drivers/gpu/drm/i915/intel_gvt.c
+++ b/drivers/gpu/drm/i915/intel_gvt.c
@@ -24,7 +24,10 @@
 #include "i915_drv.h"
 #include "i915_vgpu.h"
 #include "intel_gvt.h"
-#include "gvt/gvt.h"
+#include "gem/i915_gem_dmabuf.h"
+#include "gt/intel_context.h"
+#include "gt/intel_ring.h"
+#include "gt/shmem_utils.h"
 
 /**
  * DOC: Intel GVT-g host support
@@ -41,6 +44,10 @@
  * doc is available on https://01.org/group/2230/documentation-list.
  */
 
+static LIST_HEAD(intel_gvt_devices);
+static const struct intel_vgpu_ops *intel_gvt_ops;
+static DEFINE_MUTEX(intel_gvt_mutex);
+
 static bool is_supported_device(struct drm_i915_private *dev_priv)
 {
 	if (IS_BROADWELL(dev_priv))
@@ -59,33 +66,6 @@ static bool is_supported_device(struct drm_i915_private *dev_priv)
 	return false;
 }
 
-/**
- * intel_gvt_sanitize_options - sanitize GVT related options
- * @dev_priv: drm i915 private data
- *
- * This function is called at the i915 options sanitize stage.
- */
-void intel_gvt_sanitize_options(struct drm_i915_private *dev_priv)
-{
-	if (!dev_priv->params.enable_gvt)
-		return;
-
-	if (intel_vgpu_active(dev_priv)) {
-		drm_info(&dev_priv->drm, "GVT-g is disabled for guest\n");
-		goto bail;
-	}
-
-	if (!is_supported_device(dev_priv)) {
-		drm_info(&dev_priv->drm,
-			 "Unsupported device. GVT-g is disabled\n");
-		goto bail;
-	}
-
-	return;
-bail:
-	dev_priv->params.enable_gvt = 0;
-}
-
 static void free_initial_hw_state(struct drm_i915_private *dev_priv)
 {
 	struct i915_virtual_gpu *vgpu = &dev_priv->vgpu;
@@ -165,59 +145,106 @@ static int save_initial_hw_state(struct drm_i915_private *dev_priv)
 	return ret;
 }
 
-/**
- * intel_gvt_init - initialize GVT components
- * @dev_priv: drm i915 private data
- *
- * This function is called at the initialization stage to create a GVT device.
- *
- * Returns:
- * Zero on success, negative error code if failed.
- *
- */
-int intel_gvt_init(struct drm_i915_private *dev_priv)
+static void intel_gvt_init_device(struct drm_i915_private *dev_priv)
 {
-	int ret;
-
-	if (i915_inject_probe_failure(dev_priv))
-		return -ENODEV;
-
 	if (!dev_priv->params.enable_gvt) {
 		drm_dbg(&dev_priv->drm,
 			"GVT-g is disabled by kernel params\n");
-		return 0;
+		return;
+	}
+
+	if (intel_vgpu_active(dev_priv)) {
+		drm_info(&dev_priv->drm, "GVT-g is disabled for guest\n");
+		return;
+	}
+
+	if (!is_supported_device(dev_priv)) {
+		drm_info(&dev_priv->drm,
+			 "Unsupported device. GVT-g is disabled\n");
+		return;
 	}
 
 	if (intel_uc_wants_guc_submission(&to_gt(dev_priv)->uc)) {
 		drm_err(&dev_priv->drm,
-			"i915 GVT-g loading failed due to Graphics virtualization is not yet supported with GuC submission\n");
-		return -EIO;
+			"Graphics virtualization is not yet supported with GuC submission\n");
+		return;
 	}
 
-	ret = save_initial_hw_state(dev_priv);
-	if (ret) {
-		drm_dbg(&dev_priv->drm, "Fail to save initial HW state\n");
-		goto err_save_hw_state;
+	if (save_initial_hw_state(dev_priv)) {
+		drm_dbg(&dev_priv->drm, "Failed to save initial HW state\n");
+		return;
 	}
 
-	ret = intel_gvt_init_device(dev_priv);
-	if (ret) {
+	if (intel_gvt_ops->init_device(dev_priv))
 		drm_dbg(&dev_priv->drm, "Fail to init GVT device\n");
-		goto err_init_device;
+}
+
+static void intel_gvt_clean_device(struct drm_i915_private *dev_priv)
+{
+	if (dev_priv->gvt)
+		intel_gvt_ops->clean_device(dev_priv);
+	free_initial_hw_state(dev_priv);
+}
+
+int intel_gvt_set_ops(const struct intel_vgpu_ops *ops)
+{
+	struct drm_i915_private *dev_priv;
+
+	mutex_lock(&intel_gvt_mutex);
+	if (intel_gvt_ops) {
+		mutex_unlock(&intel_gvt_mutex);
+		return -EINVAL;
 	}
+	intel_gvt_ops = ops;
 
-	return 0;
+	list_for_each_entry(dev_priv, &intel_gvt_devices, vgpu.entry)
+		intel_gvt_init_device(dev_priv);
+	mutex_unlock(&intel_gvt_mutex);
 
-err_init_device:
-	free_initial_hw_state(dev_priv);
-err_save_hw_state:
-	dev_priv->params.enable_gvt = 0;
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(intel_gvt_set_ops, I915_GVT);
+
+void intel_gvt_clear_ops(const struct intel_vgpu_ops *ops)
+{
+	struct drm_i915_private *dev_priv;
+
+	mutex_lock(&intel_gvt_mutex);
+	if (intel_gvt_ops != ops) {
+		mutex_unlock(&intel_gvt_mutex);
+		return;
+	}
+
+	list_for_each_entry(dev_priv, &intel_gvt_devices, vgpu.entry)
+		intel_gvt_clean_device(dev_priv);
+
+	intel_gvt_ops = NULL;
+	mutex_unlock(&intel_gvt_mutex);
+}
+EXPORT_SYMBOL_NS_GPL(intel_gvt_clear_ops, I915_GVT);
 
-static inline bool intel_gvt_active(struct drm_i915_private *dev_priv)
+/**
+ * intel_gvt_init - initialize GVT components
+ * @dev_priv: drm i915 private data
+ *
+ * This function is called at the initialization stage to create a GVT device.
+ *
+ * Returns:
+ * Zero on success, negative error code if failed.
+ *
+ */
+int intel_gvt_init(struct drm_i915_private *dev_priv)
 {
-	return dev_priv->gvt;
+	if (i915_inject_probe_failure(dev_priv))
+		return -ENODEV;
+
+	mutex_lock(&intel_gvt_mutex);
+	list_add_tail(&dev_priv->vgpu.entry, &intel_gvt_devices);
+	if (intel_gvt_ops)
+		intel_gvt_init_device(dev_priv);
+	mutex_unlock(&intel_gvt_mutex);
+
+	return 0;
 }
 
 /**
@@ -230,11 +257,10 @@ static inline bool intel_gvt_active(struct drm_i915_private *dev_priv)
  */
 void intel_gvt_driver_remove(struct drm_i915_private *dev_priv)
 {
-	if (!intel_gvt_active(dev_priv))
-		return;
-
+	mutex_lock(&intel_gvt_mutex);
 	intel_gvt_clean_device(dev_priv);
-	free_initial_hw_state(dev_priv);
+	list_del(&dev_priv->vgpu.entry);
+	mutex_unlock(&intel_gvt_mutex);
 }
 
 /**
@@ -247,6 +273,46 @@ void intel_gvt_driver_remove(struct drm_i915_private *dev_priv)
  */
 void intel_gvt_resume(struct drm_i915_private *dev_priv)
 {
-	if (intel_gvt_active(dev_priv))
-		intel_gvt_pm_resume(dev_priv->gvt);
+	mutex_lock(&intel_gvt_mutex);
+	if (dev_priv->gvt)
+		intel_gvt_ops->pm_resume(dev_priv);
+	mutex_unlock(&intel_gvt_mutex);
 }
+
+/*
+ * Exported here so that the exports only get created when GVT support is
+ * actually enabled.
+ */
+EXPORT_SYMBOL_NS_GPL(i915_gem_object_alloc, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(i915_gem_object_create_shmem, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(i915_gem_object_init, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(i915_gem_object_ggtt_pin_ww, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(i915_gem_object_pin_map, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(i915_gem_object_set_to_cpu_domain, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(__i915_gem_object_flush_map, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(__i915_gem_object_set_pages, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(i915_gem_gtt_insert, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(i915_gem_prime_export, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(i915_gem_ww_ctx_init, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(i915_gem_ww_ctx_backoff, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(i915_gem_ww_ctx_fini, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(i915_ppgtt_create, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(i915_request_add, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(i915_request_create, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(i915_request_wait, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(i915_reserve_fence, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(i915_unreserve_fence, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(i915_vm_release, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(_i915_vma_move_to_active, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(intel_context_create, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(__intel_context_do_pin, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(__intel_context_do_unpin, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(intel_ring_begin, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(intel_runtime_pm_get, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(intel_runtime_pm_put_unchecked, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(intel_uncore_forcewake_for_reg, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(intel_uncore_forcewake_get, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(intel_uncore_forcewake_put, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(shmem_pin_map, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(shmem_unpin_map, I915_GVT);
+EXPORT_SYMBOL_NS_GPL(__px_dma, I915_GVT);
diff --git a/drivers/gpu/drm/i915/intel_gvt.h b/drivers/gpu/drm/i915/intel_gvt.h
index 7665d7cf0bdd4..0244346421d75 100644
--- a/drivers/gpu/drm/i915/intel_gvt.h
+++ b/drivers/gpu/drm/i915/intel_gvt.h
@@ -39,12 +39,19 @@ struct intel_gvt_mmio_table_iter {
 
 int intel_gvt_init(struct drm_i915_private *dev_priv);
 void intel_gvt_driver_remove(struct drm_i915_private *dev_priv);
-int intel_gvt_init_device(struct drm_i915_private *dev_priv);
-void intel_gvt_clean_device(struct drm_i915_private *dev_priv);
 int intel_gvt_init_host(void);
-void intel_gvt_sanitize_options(struct drm_i915_private *dev_priv);
 void intel_gvt_resume(struct drm_i915_private *dev_priv);
 int intel_gvt_iterate_mmio_table(struct intel_gvt_mmio_table_iter *iter);
+
+struct intel_vgpu_ops {
+	int (*init_device)(struct drm_i915_private *dev_priv);
+	void (*clean_device)(struct drm_i915_private *dev_priv);
+	void (*pm_resume)(struct drm_i915_private *i915);
+};
+
+int intel_gvt_set_ops(const struct intel_vgpu_ops *ops);
+void intel_gvt_clear_ops(const struct intel_vgpu_ops *ops);
+
 #else
 static inline int intel_gvt_init(struct drm_i915_private *dev_priv)
 {
@@ -55,10 +62,6 @@ static inline void intel_gvt_driver_remove(struct drm_i915_private *dev_priv)
 {
 }
 
-static inline void intel_gvt_sanitize_options(struct drm_i915_private *dev_priv)
-{
-}
-
 static inline void intel_gvt_resume(struct drm_i915_private *dev_priv)
 {
 }
diff --git a/drivers/gpu/drm/i915/intel_gvt_mmio_table.c b/drivers/gpu/drm/i915/intel_gvt_mmio_table.c
index d29491a6d2093..f7db964d90d46 100644
--- a/drivers/gpu/drm/i915/intel_gvt_mmio_table.c
+++ b/drivers/gpu/drm/i915/intel_gvt_mmio_table.c
@@ -1288,3 +1288,4 @@ int intel_gvt_iterate_mmio_table(struct intel_gvt_mmio_table_iter *iter)
 err:
 	return ret;
 }
+EXPORT_SYMBOL_NS_GPL(intel_gvt_iterate_mmio_table, I915_GVT);
-- 
2.30.2

