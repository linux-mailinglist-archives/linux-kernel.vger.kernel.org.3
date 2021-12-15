Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4065475A17
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243077AbhLON5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:57:44 -0500
Received: from mga01.intel.com ([192.55.52.88]:59291 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243063AbhLON5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639576663; x=1671112663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uJzg9P1HkKa0WovNdkyLnlktCCxwWkTtKq5X5AUPdb8=;
  b=GVpmcErxrtCgxAqcYgejfZkc6n9nxGpOYByz9oKin7A4Xk94YTI9SRAl
   653oOLjUR8VqWze+RiiQakNBonlGqV8NUlsXEqiKtKSw3WPgv/WQPLjtK
   8KuDH4BrV62ule3aaZsujuFcjnQatyxduPEMsIX0a/D1Iz/UwsA4DD6Kx
   XC8JxI9cwMBk5H/mjmpo2yj+ztlGTgGJwWks30obuOkCp7hAdsgJgKt4Q
   oOZ8LTdqVeQdstxm8zn3fEC1jTJXLE4ZZUqtG66TGSLcEjEGhLk3NKnCB
   fkFBWV19jgJdJPEP46XNLJdjPri4UL+av7kt4eBQMGTKgX+MMJmzde9ls
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10198"; a="263380413"
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="263380413"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 05:57:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,207,1635231600"; 
   d="scan'208";a="682502746"
Received: from sannilnx.jer.intel.com ([10.12.231.79])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 05:57:39 -0800
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] drm/i915/gsc: add gsc as a mei platform device
Date:   Wed, 15 Dec 2021 15:56:18 +0200
Message-Id: <20211215135622.1060229-2-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211215135622.1060229-1-alexander.usyskin@intel.com>
References: <20211215135622.1060229-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Winkler <tomas.winkler@intel.com>

GSC is a graphics system controller, based on CSE, it provides
a chassis controller for graphics discrete cards, as well as it
supports media protection (HDCP 2.2) on selected devices.

There are two MEI interfaces in GSC HECI1, the one that provides media
protection and HECI2 the one that provides firmware interface.

Both interfaces are on the BAR0 at offsets 0x00258000 and 0x00259000.
GSC is a GT Engine (class 4: instance 6). HECI1 interrupt is signaled
via bit 15 and HECI2 via bit 14 in the interrupt register.

This patch exports GSC as platform device for mei driver to bind to.

CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/i915/Kconfig             |   1 +
 drivers/gpu/drm/i915/Makefile            |   3 +
 drivers/gpu/drm/i915/gt/intel_gsc.c      | 156 +++++++++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_gsc.h      |  35 +++++
 drivers/gpu/drm/i915/gt/intel_gt.c       |   3 +
 drivers/gpu/drm/i915/gt/intel_gt.h       |   5 +
 drivers/gpu/drm/i915/gt/intel_gt_irq.c   |  14 ++
 drivers/gpu/drm/i915/gt/intel_gt_types.h |   2 +
 drivers/gpu/drm/i915/i915_driver.c       |  10 ++
 drivers/gpu/drm/i915/i915_drv.h          |   8 ++
 drivers/gpu/drm/i915/i915_pci.c          |   3 +-
 drivers/gpu/drm/i915/i915_reg.h          |   3 +
 drivers/gpu/drm/i915/intel_device_info.h |   2 +
 13 files changed, 244 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.h

diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index a4c94dc2e216..168e1c015eb6 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -27,6 +27,7 @@ config DRM_I915
 	select CEC_CORE if CEC_NOTIFIER
 	select VMAP_PFN
 	select DRM_TTM
+	select MFD_CORE
 	help
 	  Choose this option if you have a system that has "Intel Graphics
 	  Media Accelerator" or "HD Graphics" integrated graphics,
diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 213c5f9fae32..7f87f6f5fd60 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -193,6 +193,9 @@ i915-y += gt/uc/intel_uc.o \
 	  gt/uc/intel_huc_debugfs.o \
 	  gt/uc/intel_huc_fw.o
 
+# graphics security controller (GSC) support
+i915-y += gt/intel_gsc.o
+
 # modesetting core code
 i915-y += \
 	display/intel_atomic.o \
diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
new file mode 100644
index 000000000000..670b199ef99d
--- /dev/null
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright(c) 2019-2020, Intel Corporation. All rights reserved.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/mfd/core.h>
+#include <linux/irq.h>
+#include "i915_reg.h"
+#include "i915_drv.h"
+#include "gt/intel_gt.h"
+#include "intel_gsc.h"
+
+#define GSC_BAR_LENGTH  0x00000FFC
+
+static void gsc_irq_mask(struct irq_data *d)
+{
+	/* generic irq handling */
+}
+
+static void gsc_irq_unmask(struct irq_data *d)
+{
+	/* generic irq handling */
+}
+
+static struct irq_chip gsc_irq_chip = {
+	.name = "gsc_irq_chip",
+	.irq_mask = gsc_irq_mask,
+	.irq_unmask = gsc_irq_unmask,
+};
+
+static int gsc_irq_init(struct drm_i915_private *dev_priv, int irq)
+{
+	irq_set_chip_and_handler_name(irq, &gsc_irq_chip,
+				      handle_simple_irq, "gsc_irq_handler");
+
+	return irq_set_chip_data(irq, dev_priv);
+}
+
+/* gscfi (graphics system controller firmware interface) resources */
+static const struct resource gscfi_dg1_resources[] = {
+	DEFINE_RES_IRQ_NAMED(0, "gscfi-irq"),
+	DEFINE_RES_MEM_NAMED(GSC_DG1_HECI2_BASE,
+			     GSC_BAR_LENGTH,
+			     "gscfi-mmio"),
+};
+
+static const struct mfd_cell intel_gsc_dg1_cell[] = {
+	{
+		.id = 0,
+	},
+	{
+		.id = 1,
+		.name = "mei-gscfi",
+		.num_resources = ARRAY_SIZE(gscfi_dg1_resources),
+		.resources  = gscfi_dg1_resources,
+	}
+};
+
+static void intel_gsc_destroy_one(struct intel_gsc_intf *intf)
+{
+	if (intf->irq >= 0)
+		irq_free_desc(intf->irq);
+	intf->irq = -1;
+}
+
+static void intel_gsc_init_one(struct drm_i915_private *dev_priv,
+			       struct intel_gsc_intf *intf,
+			       unsigned int intf_id)
+{
+	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
+	int ret;
+
+	intf->irq = -1;
+	intf->id = intf_id;
+
+	if (intf_id == 0 && !HAS_HECI_PXP(dev_priv))
+		return;
+
+	dev_dbg(&pdev->dev, "init gsc one with id %d\n", intf_id);
+	intf->irq = irq_alloc_desc(0);
+	if (intf->irq < 0) {
+		dev_err(&pdev->dev, "gsc irq error %d\n", intf->irq);
+		return;
+	}
+
+	ret = gsc_irq_init(dev_priv, intf->irq);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "gsc irq init failed %d\n", ret);
+		goto fail;
+	}
+
+	ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
+			      &intel_gsc_dg1_cell[intf_id], 1,
+			      &pdev->resource[0], intf->irq, NULL);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "cell creation failed\n");
+		goto fail;
+	}
+
+	dev_dbg(&pdev->dev, "gsc init one done\n");
+	return;
+fail:
+	intel_gsc_destroy_one(intf);
+}
+
+static void intel_gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
+{
+	int ret;
+
+	if (intf_id >= INTEL_GSC_NUM_INTERFACES)
+		return;
+
+	if (!HAS_HECI_GSC(gt->i915))
+		return;
+
+	if (gt->gsc.intf[intf_id].irq <= 0) {
+		DRM_ERROR_RATELIMITED("error handling GSC irq: irq not set");
+		return;
+	}
+
+	ret = generic_handle_irq(gt->gsc.intf[intf_id].irq);
+	if (ret)
+		DRM_ERROR_RATELIMITED("error handling GSC irq: %d\n", ret);
+}
+
+void gsc_irq_handler(struct intel_gt *gt, u32 iir)
+{
+	if (iir & GSC_IRQ_INTF(0))
+		intel_gsc_irq_handler(gt, 0);
+	if (iir & GSC_IRQ_INTF(1))
+		intel_gsc_irq_handler(gt, 1);
+}
+
+void intel_gsc_init(struct intel_gsc *gsc, struct drm_i915_private *dev_priv)
+{
+	unsigned int i;
+
+	if (!HAS_HECI_GSC(dev_priv))
+		return;
+
+	for (i = 0; i < INTEL_GSC_NUM_INTERFACES; i++)
+		intel_gsc_init_one(dev_priv, &gsc->intf[i], i);
+}
+
+void intel_gsc_fini(struct intel_gsc *gsc)
+{
+	struct intel_gt *gt = gsc_to_gt(gsc);
+	unsigned int i;
+
+	if (!HAS_HECI_GSC(gt->i915))
+		return;
+
+	for (i = 0; i < INTEL_GSC_NUM_INTERFACES; i++)
+		intel_gsc_destroy_one(&gsc->intf[i]);
+}
diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.h b/drivers/gpu/drm/i915/gt/intel_gsc.h
new file mode 100644
index 000000000000..9e53f7fa3026
--- /dev/null
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright(c) 2019-2020, Intel Corporation. All rights reserved.
+ */
+#ifndef __INTEL_GSC_DEV_H__
+#define __INTEL_GSC_DEV_H__
+
+#include <linux/types.h>
+
+struct drm_i915_private;
+struct intel_gt;
+
+#define INTEL_GSC_NUM_INTERFACES 2
+/*
+ * The HECI1 bit corresponds to bit15 and HECI2 to bit14.
+ * The reason for this is to allow growth for more interfaces in the future.
+ */
+#define GSC_IRQ_INTF(_x)  BIT(15 - (_x))
+
+/**
+ * struct intel_gsc - graphics security controller
+ * @intf : gsc interface
+ */
+struct intel_gsc {
+	struct intel_gsc_intf {
+		int irq;
+		unsigned int id;
+	} intf[INTEL_GSC_NUM_INTERFACES];
+};
+
+void intel_gsc_init(struct intel_gsc *gsc, struct drm_i915_private *dev_priv);
+void intel_gsc_fini(struct intel_gsc *gsc);
+void gsc_irq_handler(struct intel_gt *gt, u32 iir);
+
+#endif /* __INTEL_GSC_DEV_H__ */
diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c b/drivers/gpu/drm/i915/gt/intel_gt.c
index f2422d48be32..4e2a999e6029 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt.c
@@ -435,6 +435,8 @@ void intel_gt_chipset_flush(struct intel_gt *gt)
 
 void intel_gt_driver_register(struct intel_gt *gt)
 {
+	intel_gsc_init(&gt->gsc, gt->i915);
+
 	intel_rps_driver_register(&gt->rps);
 
 	intel_gt_debugfs_register(gt);
@@ -755,6 +757,7 @@ void intel_gt_driver_unregister(struct intel_gt *gt)
 	intel_wakeref_t wakeref;
 
 	intel_rps_driver_unregister(&gt->rps);
+	intel_gsc_fini(&gt->gsc);
 
 	intel_pxp_fini(&gt->pxp);
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gt.h b/drivers/gpu/drm/i915/gt/intel_gt.h
index 74e771871a9b..0511d6abfeca 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt.h
@@ -34,6 +34,11 @@ static inline struct intel_gt *huc_to_gt(struct intel_huc *huc)
 	return container_of(huc, struct intel_gt, uc.huc);
 }
 
+static inline struct intel_gt *gsc_to_gt(struct intel_gsc *gsc)
+{
+	return container_of(gsc, struct intel_gt, gsc);
+}
+
 void intel_gt_init_early(struct intel_gt *gt, struct drm_i915_private *i915);
 void intel_gt_init_hw_early(struct intel_gt *gt, struct i915_ggtt *ggtt);
 int intel_gt_probe_lmem(struct intel_gt *gt);
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_irq.c b/drivers/gpu/drm/i915/gt/intel_gt_irq.c
index 699a74582d32..7797fd45d1db 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_irq.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_irq.c
@@ -68,6 +68,9 @@ gen11_other_irq_handler(struct intel_gt *gt, const u8 instance,
 	if (instance == OTHER_KCR_INSTANCE)
 		return intel_pxp_irq_handler(&gt->pxp, iir);
 
+	if (instance == OTHER_GSC_INSTANCE)
+		return gsc_irq_handler(gt, iir);
+
 	WARN_ONCE(1, "unhandled other interrupt instance=0x%x, iir=0x%x\n",
 		  instance, iir);
 }
@@ -182,6 +185,8 @@ void gen11_gt_irq_reset(struct intel_gt *gt)
 	/* Disable RCS, BCS, VCS and VECS class engines. */
 	intel_uncore_write(uncore, GEN11_RENDER_COPY_INTR_ENABLE, 0);
 	intel_uncore_write(uncore, GEN11_VCS_VECS_INTR_ENABLE,	  0);
+	if (HAS_HECI_GSC(gt->i915))
+		intel_uncore_write(uncore, GEN11_GUNIT_CSME_INTR_ENABLE, 0);
 
 	/* Restore masks irqs on RCS, BCS, VCS and VECS engines. */
 	intel_uncore_write(uncore, GEN11_RCS0_RSVD_INTR_MASK,	~0);
@@ -195,6 +200,8 @@ void gen11_gt_irq_reset(struct intel_gt *gt)
 	intel_uncore_write(uncore, GEN11_VECS0_VECS1_INTR_MASK,	~0);
 	if (HAS_ENGINE(gt, VECS2) || HAS_ENGINE(gt, VECS3))
 		intel_uncore_write(uncore, GEN12_VECS2_VECS3_INTR_MASK, ~0);
+	if (HAS_HECI_GSC(gt->i915))
+		intel_uncore_write(uncore, GEN11_GUNIT_CSME_INTR_MASK, ~0);
 
 	intel_uncore_write(uncore, GEN11_GPM_WGBOXPERF_INTR_ENABLE, 0);
 	intel_uncore_write(uncore, GEN11_GPM_WGBOXPERF_INTR_MASK,  ~0);
@@ -209,6 +216,7 @@ void gen11_gt_irq_postinstall(struct intel_gt *gt)
 {
 	struct intel_uncore *uncore = gt->uncore;
 	u32 irqs = GT_RENDER_USER_INTERRUPT;
+	const u32 gsc_mask = GSC_IRQ_INTF(0) | GSC_IRQ_INTF(1);
 	u32 dmask;
 	u32 smask;
 
@@ -225,6 +233,9 @@ void gen11_gt_irq_postinstall(struct intel_gt *gt)
 	/* Enable RCS, BCS, VCS and VECS class interrupts. */
 	intel_uncore_write(uncore, GEN11_RENDER_COPY_INTR_ENABLE, dmask);
 	intel_uncore_write(uncore, GEN11_VCS_VECS_INTR_ENABLE, dmask);
+	if (HAS_HECI_GSC(gt->i915))
+		intel_uncore_write(uncore, GEN11_GUNIT_CSME_INTR_ENABLE,
+				   gsc_mask);
 
 	/* Unmask irqs on RCS, BCS, VCS and VECS engines. */
 	intel_uncore_write(uncore, GEN11_RCS0_RSVD_INTR_MASK, ~smask);
@@ -238,6 +249,9 @@ void gen11_gt_irq_postinstall(struct intel_gt *gt)
 	intel_uncore_write(uncore, GEN11_VECS0_VECS1_INTR_MASK, ~dmask);
 	if (HAS_ENGINE(gt, VECS2) || HAS_ENGINE(gt, VECS3))
 		intel_uncore_write(uncore, GEN12_VECS2_VECS3_INTR_MASK, ~dmask);
+	if (HAS_HECI_GSC(gt->i915))
+		intel_uncore_write(uncore, GEN11_GUNIT_CSME_INTR_MASK, 0);
+
 	/*
 	 * RPS interrupts will get enabled/disabled on demand when RPS itself
 	 * is enabled/disabled.
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_types.h b/drivers/gpu/drm/i915/gt/intel_gt_types.h
index 14216cc471b1..9dbd5422e56d 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_types.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_types.h
@@ -16,6 +16,7 @@
 #include <linux/workqueue.h>
 
 #include "uc/intel_uc.h"
+#include "intel_gsc.h"
 
 #include "i915_vma.h"
 #include "intel_engine_types.h"
@@ -72,6 +73,7 @@ struct intel_gt {
 	struct i915_ggtt *ggtt;
 
 	struct intel_uc uc;
+	struct intel_gsc gsc;
 
 	struct i915_wa_list wa_list;
 
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index ca3b599f6c38..c802e3ebdff7 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -29,6 +29,7 @@
 
 #include <linux/acpi.h>
 #include <linux/device.h>
+#include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/oom.h>
 #include <linux/pci.h>
@@ -68,6 +69,7 @@
 #include "gt/intel_gt.h"
 #include "gt/intel_gt_pm.h"
 #include "gt/intel_rc6.h"
+#include "gt/intel_gsc.h"
 
 #include "pxp/intel_pxp_pm.h"
 
@@ -713,6 +715,8 @@ static void i915_driver_register(struct drm_i915_private *dev_priv)
  */
 static void i915_driver_unregister(struct drm_i915_private *dev_priv)
 {
+	struct pci_dev *pdev = to_pci_dev(dev_priv->drm.dev);
+
 	i915_switcheroo_unregister(dev_priv);
 
 	intel_unregister_dsm_handler();
@@ -720,6 +724,12 @@ static void i915_driver_unregister(struct drm_i915_private *dev_priv)
 	intel_runtime_pm_disable(&dev_priv->runtime_pm);
 	intel_power_domains_disable(dev_priv);
 
+	/*
+	 * mfd devices may be registered individually either by gt or display,
+	 * but they are unregistered all at once from i915
+	 */
+	mfd_remove_devices(&pdev->dev);
+
 	intel_display_driver_unregister(dev_priv);
 
 	intel_gt_driver_unregister(&dev_priv->gt);
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index e99996dfd43a..a204cbd29962 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -1516,6 +1516,14 @@ IS_SUBPLATFORM(const struct drm_i915_private *i915,
 
 #define HAS_DMC(dev_priv)	(INTEL_INFO(dev_priv)->display.has_dmc)
 
+#define HAS_HECI_PXP(dev_priv) \
+	(INTEL_INFO(dev_priv)->has_heci_pxp)
+
+#define HAS_HECI_GSCFI(dev_priv) \
+	(INTEL_INFO(dev_priv)->has_heci_gscfi)
+
+#define HAS_HECI_GSC(dev_priv) (HAS_HECI_PXP(dev_priv) || HAS_HECI_GSCFI(dev_priv))
+
 #define HAS_MSO(i915)		(GRAPHICS_VER(i915) >= 12)
 
 #define HAS_RUNTIME_PM(dev_priv) (INTEL_INFO(dev_priv)->has_runtime_pm)
diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index eeee028a5ad7..a13cba8f4791 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -899,7 +899,8 @@ static const struct intel_device_info rkl_info = {
 	.has_llc = 0, \
 	.has_pxp = 0, \
 	.has_snoop = 1, \
-	.is_dgfx = 1
+	.is_dgfx = 1, \
+	.has_heci_gscfi = 1
 
 static const struct intel_device_info dg1_info = {
 	GEN12_FEATURES,
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 9e5ccf86088c..7a8df1ef819e 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -2530,6 +2530,8 @@ static inline bool i915_mmio_reg_valid(i915_reg_t reg)
 #define GEN11_VEBOX2_RING_BASE		0x1d8000
 #define XEHP_VEBOX3_RING_BASE		0x1e8000
 #define XEHP_VEBOX4_RING_BASE		0x1f8000
+#define GSC_DG1_HECI1_BASE	0x00258000
+#define GSC_DG1_HECI2_BASE	0x00259000
 #define BLT_RING_BASE		0x22000
 #define RING_TAIL(base)		_MMIO((base) + 0x30)
 #define RING_HEAD(base)		_MMIO((base) + 0x34)
@@ -8139,6 +8141,7 @@ enum {
 #define OTHER_GUC_INSTANCE	0
 #define OTHER_GTPM_INSTANCE	1
 #define OTHER_KCR_INSTANCE	4
+#define OTHER_GSC_INSTANCE	6
 
 #define GEN11_INTR_IDENTITY_REG(x)	_MMIO(0x190060 + ((x) * 4))
 
diff --git a/drivers/gpu/drm/i915/intel_device_info.h b/drivers/gpu/drm/i915/intel_device_info.h
index c121d7309dd2..fb6437390c24 100644
--- a/drivers/gpu/drm/i915/intel_device_info.h
+++ b/drivers/gpu/drm/i915/intel_device_info.h
@@ -130,6 +130,8 @@ enum intel_ppgtt_type {
 	func(has_reset_engine); \
 	func(has_global_mocs); \
 	func(has_gt_uc); \
+	func(has_heci_pxp); \
+	func(has_heci_gscfi); \
 	func(has_l3_dpf); \
 	func(has_llc); \
 	func(has_logical_ring_contexts); \
-- 
2.32.0

