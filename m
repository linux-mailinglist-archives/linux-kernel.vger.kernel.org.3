Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADA6493DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356029AbiASP6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:58:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:38643 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356004AbiASP6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642607918; x=1674143918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B4v1ILs3cwHuB7c9aIbNOF5J3PXj3gsTHCBR6G7h8oM=;
  b=NLaUykeIjDexzzIv802F3ZbFpaN6YO2pOdgHUTGFQv1QZeazid7Fxg0t
   JDDdX46z4rm/Lly5EW3X9NWePPBbYkuLdZV2V2gOpGLA3+vT825SlSovY
   9MgTQIsL+xxc1zmHywXGfADac6cpquaIEm8ExekkUgEk9prF3dtPY+TFz
   7E2NyFA9n3BtCv1N3qGhMNzbxoC+glNPLeJxiQRC4H4T5V5RQi2h3Nil3
   cb7IE2lwDQIKYmsnsUUjLNEvKD2a7iLVkvrsgac0H/ckAY0XxXBqZURuZ
   udLN3lSm31XY2vH6w6AOWYexszhb9Dapp6gPOP5E4onU/8h3RqEPVrNul
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="308436385"
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="308436385"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 07:58:37 -0800
X-IronPort-AV: E=Sophos;i="5.88,299,1635231600"; 
   d="scan'208";a="477420136"
Received: from sannilnx.jer.intel.com ([10.12.231.79])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 07:58:33 -0800
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
Subject: [PATCH v2 1/5] drm/i915/gsc: add gsc as a mei auxiliary device
Date:   Wed, 19 Jan 2022 17:58:03 +0200
Message-Id: <20220119155807.222657-2-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220119155807.222657-1-alexander.usyskin@intel.com>
References: <20220119155807.222657-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Winkler <tomas.winkler@intel.com>

GSC is a graphics system controller, it provides
a chassis controller for graphics discrete cards.

There are two MEI interfaces in GSC: HECI1 and HECI2.

Both interfaces are on the BAR0 at offsets 0x00258000 and 0x00259000.
GSC is a GT Engine (class 4: instance 6). HECI1 interrupt is signaled
via bit 15 and HECI2 via bit 14 in the interrupt register.

This patch exports GSC as auxiliary device for mei driver to bind to
for HECI2 interface.

CC: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Vitaly Lubart <vitaly.lubart@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/i915/Kconfig             |   1 +
 drivers/gpu/drm/i915/Makefile            |   3 +
 drivers/gpu/drm/i915/gt/intel_gsc.c      | 200 +++++++++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_gsc.h      |  37 +++++
 drivers/gpu/drm/i915/gt/intel_gt.c       |   3 +
 drivers/gpu/drm/i915/gt/intel_gt.h       |   5 +
 drivers/gpu/drm/i915/gt/intel_gt_irq.c   |  13 ++
 drivers/gpu/drm/i915/gt/intel_gt_types.h |   2 +
 drivers/gpu/drm/i915/i915_drv.h          |   8 +
 drivers/gpu/drm/i915/i915_pci.c          |   3 +-
 drivers/gpu/drm/i915/i915_reg.h          |   3 +
 drivers/gpu/drm/i915/intel_device_info.h |   2 +
 include/linux/mei_aux.h                  |  19 +++
 13 files changed, 298 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.h
 create mode 100644 include/linux/mei_aux.h

diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index a4c94dc2e216..92ae210d3e53 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -27,6 +27,7 @@ config DRM_I915
 	select CEC_CORE if CEC_NOTIFIER
 	select VMAP_PFN
 	select DRM_TTM
+	select AUXILIARY_BUS
 	help
 	  Choose this option if you have a system that has "Intel Graphics
 	  Media Accelerator" or "HD Graphics" integrated graphics,
diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 213c5f9fae32..d758d6c5fc45 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -193,6 +193,9 @@ i915-y += gt/uc/intel_uc.o \
 	  gt/uc/intel_huc_debugfs.o \
 	  gt/uc/intel_huc_fw.o
 
+# graphics system controller (GSC) support
+i915-y += gt/intel_gsc.o
+
 # modesetting core code
 i915-y += \
 	display/intel_atomic.o \
diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
new file mode 100644
index 000000000000..3fb1018dfe2d
--- /dev/null
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright(c) 2019-2022, Intel Corporation. All rights reserved.
+ */
+
+#include <linux/irq.h>
+#include <linux/mei_aux.h>
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
+struct intel_gsc_def {
+	const char *name;
+	const unsigned long bar;
+	size_t bar_size;
+};
+
+/* gscfi (graphics system controller firmware interface) resources */
+static const struct intel_gsc_def intel_gsc_def_dg1[] = {
+	{
+	},
+	{
+		.name = "mei-gscfi",
+		.bar = GSC_DG1_HECI2_BASE,
+		.bar_size = GSC_BAR_LENGTH,
+	}
+};
+
+static void intel_gsc_release_dev(struct device *dev)
+{
+	struct auxiliary_device *aux_dev = to_auxiliary_dev(dev);
+	struct mei_aux_device *adev = auxiliary_dev_to_mei_aux_dev(aux_dev);
+
+	kfree(adev);
+}
+
+static void intel_gsc_destroy_one(struct intel_gsc_intf *intf)
+{
+
+	if (intf->adev) {
+		auxiliary_device_delete(&intf->adev->aux_dev);
+		auxiliary_device_uninit(&intf->adev->aux_dev);
+		intf->adev = NULL;
+	}
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
+	struct mei_aux_device *adev;
+	struct auxiliary_device *aux_dev;
+	const struct intel_gsc_def *def;
+	int ret;
+
+	intf->irq = -1;
+	intf->id = intf_id;
+
+	if (intf_id == 0 && !HAS_HECI_PXP(dev_priv))
+		return;
+
+	def = &intel_gsc_def_dg1[intf_id];
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
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+	aux_dev = &adev->aux_dev;
+
+	adev->irq = intf->irq;
+	adev->bar.parent = &pdev->resource[0];
+	adev->bar.start = def->bar + pdev->resource[0].start;
+	adev->bar.end = adev->bar.start + def->bar_size - 1;
+	adev->bar.flags = IORESOURCE_MEM;
+	adev->bar.desc = IORES_DESC_NONE;
+
+	aux_dev = &adev->aux_dev;
+	aux_dev->name = def->name;
+	aux_dev->id = (pci_domain_nr(pdev->bus) << 16) |
+		      PCI_DEVID(pdev->bus->number, pdev->devfn);
+	aux_dev->dev.parent = &pdev->dev;
+	aux_dev->dev.release = intel_gsc_release_dev;
+
+	ret = auxiliary_device_init(aux_dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "gsc aux init failed %d\n", ret);
+		kfree(adev);
+		goto fail;
+	}
+
+	ret = auxiliary_device_add(aux_dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "gsc aux add failed %d\n", ret);
+		/* adev will be freed with the put_device() and .release sequence */
+		auxiliary_device_uninit(aux_dev);
+		goto fail;
+	}
+	intf->adev = adev;
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
index 000000000000..67cb2a75f839
--- /dev/null
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright(c) 2019-2022, Intel Corporation. All rights reserved.
+ */
+#ifndef __INTEL_GSC_DEV_H__
+#define __INTEL_GSC_DEV_H__
+
+#include <linux/types.h>
+
+struct drm_i915_private;
+struct intel_gt;
+struct mei_aux_device;
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
+		struct mei_aux_device *adev;
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
index 4814453ab5ab..218c2bf2cc0f 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt.c
@@ -436,6 +436,8 @@ void intel_gt_chipset_flush(struct intel_gt *gt)
 
 void intel_gt_driver_register(struct intel_gt *gt)
 {
+	intel_gsc_init(&gt->gsc, gt->i915);
+
 	intel_rps_driver_register(&gt->rps);
 
 	intel_gt_debugfs_register(gt);
@@ -756,6 +758,7 @@ void intel_gt_driver_unregister(struct intel_gt *gt)
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
index 699a74582d32..0978ca0a6c45 100644
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
@@ -238,6 +249,8 @@ void gen11_gt_irq_postinstall(struct intel_gt *gt)
 	intel_uncore_write(uncore, GEN11_VECS0_VECS1_INTR_MASK, ~dmask);
 	if (HAS_ENGINE(gt, VECS2) || HAS_ENGINE(gt, VECS3))
 		intel_uncore_write(uncore, GEN12_VECS2_VECS3_INTR_MASK, ~dmask);
+	if (HAS_HECI_GSC(gt->i915))
+		intel_uncore_write(uncore, GEN11_GUNIT_CSME_INTR_MASK, 0);
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
 
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 290dfd40c7b3..88da2e6f017b 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -1496,6 +1496,14 @@ IS_SUBPLATFORM(const struct drm_i915_private *i915,
 
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
index 960c358990bc..51961b8456b2 100644
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
index 5e57652b7807..45dbe0b18832 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -1768,6 +1768,8 @@
 #define GEN11_VEBOX2_RING_BASE		0x1d8000
 #define XEHP_VEBOX3_RING_BASE		0x1e8000
 #define XEHP_VEBOX4_RING_BASE		0x1f8000
+#define GSC_DG1_HECI1_BASE	0x00258000
+#define GSC_DG1_HECI2_BASE	0x00259000
 #define BLT_RING_BASE		0x22000
 
 
@@ -7270,6 +7272,7 @@ enum {
 #define OTHER_GUC_INSTANCE	0
 #define OTHER_GTPM_INSTANCE	1
 #define OTHER_KCR_INSTANCE	4
+#define OTHER_GSC_INSTANCE	6
 
 #define GEN11_INTR_IDENTITY_REG(x)	_MMIO(0x190060 + ((x) * 4))
 
diff --git a/drivers/gpu/drm/i915/intel_device_info.h b/drivers/gpu/drm/i915/intel_device_info.h
index 2a4e32b4ebfd..cb9bae0f2117 100644
--- a/drivers/gpu/drm/i915/intel_device_info.h
+++ b/drivers/gpu/drm/i915/intel_device_info.h
@@ -133,6 +133,8 @@ enum intel_ppgtt_type {
 	func(has_reset_engine); \
 	func(has_global_mocs); \
 	func(has_gt_uc); \
+	func(has_heci_pxp); \
+	func(has_heci_gscfi); \
 	func(has_l3_dpf); \
 	func(has_llc); \
 	func(has_logical_ring_contexts); \
diff --git a/include/linux/mei_aux.h b/include/linux/mei_aux.h
new file mode 100644
index 000000000000..587f25128848
--- /dev/null
+++ b/include/linux/mei_aux.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022, Intel Corporation. All rights reserved.
+ */
+#ifndef _LINUX_MEI_AUX_H
+#define _LINUX_MEI_AUX_H
+
+#include <linux/auxiliary_bus.h>
+
+struct mei_aux_device {
+	struct auxiliary_device aux_dev;
+	int irq;
+	struct resource bar;
+};
+
+#define auxiliary_dev_to_mei_aux_dev(auxiliary_dev) \
+	container_of(auxiliary_dev, struct mei_aux_device, aux_dev)
+
+#endif /* _LINUX_MEI_AUX_H */
-- 
2.32.0

