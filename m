Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411764D1D66
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348401AbiCHQjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbiCHQjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:39:09 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFB64B1ED
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646757491; x=1678293491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qkoBji/qAVM+5IAIHA2GJqgBvfHl7DZb/CK2G9qovLI=;
  b=k4wuM1/cN1jWvR7WJrh4Z+KLJYbdw78kj5Dlisbi1xhJ7lTXvVrhnd1w
   thDuBt82nSZXeyWuqBhMD1Jer/eK3ZihTPm/HCb8vJFyV5QTxkpQ3t02W
   KhwSlJQkwXMqsnvcPKEi47w/wDNYmB+YTWsf4O53WDgTxOJd7RJQMzj3T
   Ecaqf4XsZq+sZNS5XqsGmUP60vP8ph5cbrqqDif/tu6ryGPDJbXY3N1u/
   abkPrKYkNfu7/3a2b0mPOS6uSWrmuD8/YHRQgmZ+1eRUa+lre7sO/lzqZ
   d4m1u6Agmb86/nNTeSVAmOFct7zOpIU2W849v0CiVLbW/qL2seqCS3boJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="253564380"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="253564380"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 08:38:11 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="537630774"
Received: from sannilnx.jer.intel.com ([10.12.231.73])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 08:38:07 -0800
From:   Alexander Usyskin <alexander.usyskin@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [PATCH v10 1/5] drm/i915/gsc: add gsc as a mei auxiliary device
Date:   Tue,  8 Mar 2022 18:36:50 +0200
Message-Id: <20220308163654.942820-2-alexander.usyskin@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220308163654.942820-1-alexander.usyskin@intel.com>
References: <20220308163654.942820-1-alexander.usyskin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Acked-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
---
 MAINTAINERS                              |   1 +
 drivers/gpu/drm/i915/Kconfig             |   1 +
 drivers/gpu/drm/i915/Makefile            |   3 +
 drivers/gpu/drm/i915/gt/intel_gsc.c      | 204 +++++++++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_gsc.h      |  37 ++++
 drivers/gpu/drm/i915/gt/intel_gt.c       |   3 +
 drivers/gpu/drm/i915/gt/intel_gt.h       |   5 +
 drivers/gpu/drm/i915/gt/intel_gt_irq.c   |  13 ++
 drivers/gpu/drm/i915/gt/intel_gt_regs.h  |   1 +
 drivers/gpu/drm/i915/gt/intel_gt_types.h |   2 +
 drivers/gpu/drm/i915/i915_drv.h          |   8 +
 drivers/gpu/drm/i915/i915_pci.c          |   3 +-
 drivers/gpu/drm/i915/i915_reg.h          |   2 +
 drivers/gpu/drm/i915/intel_device_info.h |   2 +
 include/linux/mei_aux.h                  |  19 +++
 15 files changed, 303 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.c
 create mode 100644 drivers/gpu/drm/i915/gt/intel_gsc.h
 create mode 100644 include/linux/mei_aux.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b1d296f92e9..d322e630d1d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9822,6 +9822,7 @@ S:	Supported
 F:	Documentation/driver-api/mei/*
 F:	drivers/misc/mei/
 F:	drivers/watchdog/mei_wdt.c
+F:	include/linux/mei_aux.h
 F:	include/linux/mei_cl_bus.h
 F:	include/uapi/linux/mei.h
 F:	samples/mei/*
diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 98c5450b8eac..2660a85175d9 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -30,6 +30,7 @@ config DRM_I915
 	select VMAP_PFN
 	select DRM_TTM
 	select DRM_BUDDY
+	select AUXILIARY_BUS
 	help
 	  Choose this option if you have a system that has "Intel Graphics
 	  Media Accelerator" or "HD Graphics" integrated graphics,
diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 1a771ee5b1d0..9be7b13d8822 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -196,6 +196,9 @@ i915-y += gt/uc/intel_uc.o \
 	  gt/uc/intel_huc_debugfs.o \
 	  gt/uc/intel_huc_fw.o
 
+# graphics system controller (GSC) support
+i915-y += gt/intel_gsc.o
+
 # modesetting core code
 i915-y += \
 	display/hsw_ips.o \
diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
new file mode 100644
index 000000000000..152804e7c41a
--- /dev/null
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
@@ -0,0 +1,204 @@
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
+static int gsc_irq_init(int irq)
+{
+	irq_set_chip_and_handler_name(irq, &gsc_irq_chip,
+				      handle_simple_irq, "gsc_irq_handler");
+
+	return irq_set_chip_data(irq, NULL);
+}
+
+struct intel_gsc_def {
+	const char *name;
+	unsigned long bar;
+	size_t bar_size;
+};
+
+/* gscfi (graphics system controller firmware interface) resources */
+static const struct intel_gsc_def intel_gsc_def_dg1[] = {
+	{
+		/* HECI1 not yet implemented. */
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
+static void intel_gsc_init_one(struct drm_i915_private *i915,
+			       struct intel_gsc_intf *intf,
+			       unsigned int intf_id)
+{
+	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
+	struct mei_aux_device *adev;
+	struct auxiliary_device *aux_dev;
+	const struct intel_gsc_def *def;
+	int ret;
+
+	intf->irq = -1;
+	intf->id = intf_id;
+
+	if (intf_id == 0 && !HAS_HECI_PXP(i915))
+		return;
+
+	def = &intel_gsc_def_dg1[intf_id];
+
+	if (!def->name) {
+		drm_warn_once(&i915->drm, "HECI%d is not implemented!\n", intf_id + 1);
+		return;
+	}
+
+	intf->irq = irq_alloc_desc(0);
+	if (intf->irq < 0) {
+		drm_err(&i915->drm, "gsc irq error %d\n", intf->irq);
+		return;
+	}
+
+	ret = gsc_irq_init(intf->irq);
+	if (ret < 0) {
+		drm_err(&i915->drm, "gsc irq init failed %d\n", ret);
+		goto fail;
+	}
+
+	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
+	if (!adev)
+		goto fail;
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
+		drm_err(&i915->drm, "gsc aux init failed %d\n", ret);
+		kfree(adev);
+		goto fail;
+	}
+
+	ret = auxiliary_device_add(aux_dev);
+	if (ret < 0) {
+		drm_err(&i915->drm, "gsc aux add failed %d\n", ret);
+		/* adev will be freed with the put_device() and .release sequence */
+		auxiliary_device_uninit(aux_dev);
+		goto fail;
+	}
+	intf->adev = adev;
+
+	return;
+fail:
+	intel_gsc_destroy_one(intf);
+}
+
+static void gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
+{
+	int ret;
+
+	if (intf_id >= INTEL_GSC_NUM_INTERFACES) {
+		drm_warn_once(&gt->i915->drm, "GSC irq: intf_id %d is out of range", intf_id);
+		return;
+	}
+
+	if (!HAS_HECI_GSC(gt->i915)) {
+		drm_warn_once(&gt->i915->drm, "GSC irq: not supported");
+		return;
+	}
+
+	if (gt->gsc.intf[intf_id].irq < 0) {
+		drm_err_ratelimited(&gt->i915->drm, "GSC irq: irq not set");
+		return;
+	}
+
+	ret = generic_handle_irq(gt->gsc.intf[intf_id].irq);
+	if (ret)
+		drm_err_ratelimited(&gt->i915->drm, "error handling GSC irq: %d\n", ret);
+}
+
+void intel_gsc_irq_handler(struct intel_gt *gt, u32 iir)
+{
+	if (iir & GSC_IRQ_INTF(0))
+		gsc_irq_handler(gt, 0);
+	if (iir & GSC_IRQ_INTF(1))
+		gsc_irq_handler(gt, 1);
+}
+
+void intel_gsc_init(struct intel_gsc *gsc, struct drm_i915_private *i915)
+{
+	unsigned int i;
+
+	if (!HAS_HECI_GSC(i915))
+		return;
+
+	for (i = 0; i < INTEL_GSC_NUM_INTERFACES; i++)
+		intel_gsc_init_one(i915, &gsc->intf[i], i);
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
index 000000000000..68582f912b21
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
+void intel_gsc_irq_handler(struct intel_gt *gt, u32 iir);
+
+#endif /* __INTEL_GSC_DEV_H__ */
diff --git a/drivers/gpu/drm/i915/gt/intel_gt.c b/drivers/gpu/drm/i915/gt/intel_gt.c
index 8a2483ccbfb9..fd83ab4b8849 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt.c
@@ -444,6 +444,8 @@ void intel_gt_chipset_flush(struct intel_gt *gt)
 
 void intel_gt_driver_register(struct intel_gt *gt)
 {
+	intel_gsc_init(&gt->gsc, gt->i915);
+
 	intel_rps_driver_register(&gt->rps);
 
 	intel_gt_debugfs_register(gt);
@@ -766,6 +768,7 @@ void intel_gt_driver_unregister(struct intel_gt *gt)
 	intel_wakeref_t wakeref;
 
 	intel_rps_driver_unregister(&gt->rps);
+	intel_gsc_fini(&gt->gsc);
 
 	intel_pxp_fini(&gt->pxp);
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gt.h b/drivers/gpu/drm/i915/gt/intel_gt.h
index 0f571c8ee22b..de779a505c21 100644
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
 void __intel_gt_init_early(struct intel_gt *gt, struct drm_i915_private *i915);
 int intel_gt_assign_ggtt(struct intel_gt *gt);
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_irq.c b/drivers/gpu/drm/i915/gt/intel_gt_irq.c
index e443ac4c8059..917b85d0c189 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_irq.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_irq.c
@@ -68,6 +68,9 @@ gen11_other_irq_handler(struct intel_gt *gt, const u8 instance,
 	if (instance == OTHER_KCR_INSTANCE)
 		return intel_pxp_irq_handler(&gt->pxp, iir);
 
+	if (instance == OTHER_GSC_INSTANCE)
+		return intel_gsc_irq_handler(gt, iir);
+
 	WARN_ONCE(1, "unhandled other interrupt instance=0x%x, iir=0x%x\n",
 		  instance, iir);
 }
@@ -184,6 +187,8 @@ void gen11_gt_irq_reset(struct intel_gt *gt)
 	intel_uncore_write(uncore, GEN11_VCS_VECS_INTR_ENABLE,	  0);
 	if (CCS_MASK(gt))
 		intel_uncore_write(uncore, GEN12_CCS_RSVD_INTR_ENABLE, 0);
+	if (HAS_HECI_GSC(gt->i915))
+		intel_uncore_write(uncore, GEN11_GUNIT_CSME_INTR_ENABLE, 0);
 
 	/* Restore masks irqs on RCS, BCS, VCS and VECS engines. */
 	intel_uncore_write(uncore, GEN11_RCS0_RSVD_INTR_MASK,	~0);
@@ -201,6 +206,8 @@ void gen11_gt_irq_reset(struct intel_gt *gt)
 		intel_uncore_write(uncore, GEN12_CCS0_CCS1_INTR_MASK, ~0);
 	if (HAS_ENGINE(gt, CCS2) || HAS_ENGINE(gt, CCS3))
 		intel_uncore_write(uncore, GEN12_CCS2_CCS3_INTR_MASK, ~0);
+	if (HAS_HECI_GSC(gt->i915))
+		intel_uncore_write(uncore, GEN11_GUNIT_CSME_INTR_MASK, ~0);
 
 	intel_uncore_write(uncore, GEN11_GPM_WGBOXPERF_INTR_ENABLE, 0);
 	intel_uncore_write(uncore, GEN11_GPM_WGBOXPERF_INTR_MASK,  ~0);
@@ -215,6 +222,7 @@ void gen11_gt_irq_postinstall(struct intel_gt *gt)
 {
 	struct intel_uncore *uncore = gt->uncore;
 	u32 irqs = GT_RENDER_USER_INTERRUPT;
+	const u32 gsc_mask = GSC_IRQ_INTF(0) | GSC_IRQ_INTF(1);
 	u32 dmask;
 	u32 smask;
 
@@ -233,6 +241,9 @@ void gen11_gt_irq_postinstall(struct intel_gt *gt)
 	intel_uncore_write(uncore, GEN11_VCS_VECS_INTR_ENABLE, dmask);
 	if (CCS_MASK(gt))
 		intel_uncore_write(uncore, GEN12_CCS_RSVD_INTR_ENABLE, smask);
+	if (HAS_HECI_GSC(gt->i915))
+		intel_uncore_write(uncore, GEN11_GUNIT_CSME_INTR_ENABLE,
+				   gsc_mask);
 
 	/* Unmask irqs on RCS, BCS, VCS and VECS engines. */
 	intel_uncore_write(uncore, GEN11_RCS0_RSVD_INTR_MASK, ~smask);
@@ -250,6 +261,8 @@ void gen11_gt_irq_postinstall(struct intel_gt *gt)
 		intel_uncore_write(uncore, GEN12_CCS0_CCS1_INTR_MASK, ~dmask);
 	if (HAS_ENGINE(gt, CCS2) || HAS_ENGINE(gt, CCS3))
 		intel_uncore_write(uncore, GEN12_CCS2_CCS3_INTR_MASK, ~dmask);
+	if (HAS_HECI_GSC(gt->i915))
+		intel_uncore_write(uncore, GEN11_GUNIT_CSME_INTR_MASK, 0);
 
 	/*
 	 * RPS interrupts will get enabled/disabled on demand when RPS itself
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_regs.h b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
index 19cd34f24263..a277fb480cc8 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_regs.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_regs.h
@@ -1483,6 +1483,7 @@
 #define   OTHER_GUC_INSTANCE			0
 #define   OTHER_GTPM_INSTANCE			1
 #define   OTHER_KCR_INSTANCE			4
+#define   OTHER_GSC_INSTANCE			6
 
 #define GEN11_IIR_REG_SELECTOR(x)		_MMIO(0x190070 + ((x) * 4))
 
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_types.h b/drivers/gpu/drm/i915/gt/intel_gt_types.h
index f20687796490..5556d55f76ea 100644
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
 
 	struct mutex tlb_invalidate_lock;
 
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 943267393ecb..1c000c15493d 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -1327,6 +1327,14 @@ IS_SUBPLATFORM(const struct drm_i915_private *i915,
 
 #define HAS_DMC(dev_priv)	(INTEL_INFO(dev_priv)->display.has_dmc)
 
+#define HAS_HECI_PXP(dev_priv) \
+	(INTEL_INFO(dev_priv)->has_heci_pxp)
+
+#define HAS_HECI_GSCFI(dev_priv) \
+	(INTEL_INFO(dev_priv)->has_heci_gscfi)
+
+#define HAS_HECI_GSC(dev_priv) (HAS_HECI_PXP(dev_priv) || HAS_HECI_GSCFI(dev_priv))
+
 #define HAS_MSO(i915)		(DISPLAY_VER(i915) >= 12)
 
 #define HAS_RUNTIME_PM(dev_priv) (INTEL_INFO(dev_priv)->has_runtime_pm)
diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index 67b89769f577..a948f566bd3d 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -901,7 +901,8 @@ static const struct intel_device_info rkl_info = {
 	.has_llc = 0, \
 	.has_pxp = 0, \
 	.has_snoop = 1, \
-	.is_dgfx = 1
+	.is_dgfx = 1, \
+	.has_heci_gscfi = 1
 
 static const struct intel_device_info dg1_info = {
 	GEN12_FEATURES,
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_reg.h
index 70484f6f2b8b..0ed305ff07a9 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -975,6 +975,8 @@
 #define GEN12_COMPUTE1_RING_BASE	0x1c000
 #define GEN12_COMPUTE2_RING_BASE	0x1e000
 #define GEN12_COMPUTE3_RING_BASE	0x26000
+#define GSC_DG1_HECI1_BASE	0x00258000
+#define GSC_DG1_HECI2_BASE	0x00259000
 #define BLT_RING_BASE		0x22000
 
 
diff --git a/drivers/gpu/drm/i915/intel_device_info.h b/drivers/gpu/drm/i915/intel_device_info.h
index f9b955810593..576d15a04c9e 100644
--- a/drivers/gpu/drm/i915/intel_device_info.h
+++ b/drivers/gpu/drm/i915/intel_device_info.h
@@ -141,6 +141,8 @@ enum intel_ppgtt_type {
 	func(has_flat_ccs); \
 	func(has_global_mocs); \
 	func(has_gt_uc); \
+	func(has_heci_pxp); \
+	func(has_heci_gscfi); \
 	func(has_guc_deprivilege); \
 	func(has_l3_dpf); \
 	func(has_llc); \
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

