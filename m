Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAE357F418
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 10:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiGXI0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 04:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbiGXIZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 04:25:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706B51A813
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 01:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658651135; x=1690187135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iynaWmsFAvWvVmnLHnrMHCVjixzCMaBjnI0XHbn+xvY=;
  b=YunS7w0Gx84cRXvphR6HSKNB+7Z+iLFn0DqtR8lyjLfPf+90KuGlC75/
   xSs+CSoHTuJSGMw1cTTZR1kreTg5olbkxH+bhNUbiNeWL/5wJZu8MkdaH
   Ry4xICcG6WzPQ/iZz+iZGuu9hK4oz5mvvgnqtw4Ym5RlqffiFXmBnPYvJ
   CRPAAC46T7Z/bUmjyDDHeXdj/GqLWVFGFLDnm80qfipSaQlD3YPCQUXVM
   xUlQ5pvp28RTHj70jVCJ1IvjvmUkH01qqvlQ6vX/vbi9ilpFT1v5352ZQ
   qWnTRMGPu1MBrYk9RhrBKS0uB0AIrEcEQ14mwgPddbJiW5ACT60ktrydg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="288708517"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="288708517"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 01:25:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="657756433"
Received: from twinkler-lnx.jer.intel.com ([10.12.87.143])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 01:25:30 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: [PATCH v6 13/14] drm/i915/gsc: allocate extended operational memory in LMEM
Date:   Sun, 24 Jul 2022 11:24:27 +0300
Message-Id: <20220724082428.218628-14-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220724082428.218628-1-tomas.winkler@intel.com>
References: <20220724082428.218628-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GSC requires more operational memory than available on chip.
Reserve 4M of LMEM for GSC operation. The memory is provided to the
GSC as struct resource to the auxiliary data of the child device.

Cc: Alan Previn <alan.previn.teres.alexis@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/i915/gt/intel_gsc.c | 91 ++++++++++++++++++++++++++---
 drivers/gpu/drm/i915/gt/intel_gsc.h |  3 +
 2 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.c b/drivers/gpu/drm/i915/gt/intel_gsc.c
index bfc307e49bf9..f89d760084e6 100644
--- a/drivers/gpu/drm/i915/gt/intel_gsc.c
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.c
@@ -7,6 +7,7 @@
 #include <linux/mei_aux.h>
 #include "i915_drv.h"
 #include "i915_reg.h"
+#include "gem/i915_gem_region.h"
 #include "gt/intel_gsc.h"
 #include "gt/intel_gt.h"
 
@@ -36,12 +37,68 @@ static int gsc_irq_init(int irq)
 	return irq_set_chip_data(irq, NULL);
 }
 
+static int
+gsc_ext_om_alloc(struct intel_gsc *gsc, struct intel_gsc_intf *intf, size_t size)
+{
+	struct intel_gt *gt = gsc_to_gt(gsc);
+	struct drm_i915_gem_object *obj;
+	void *vaddr;
+	int err;
+
+	obj = i915_gem_object_create_lmem(gt->i915, size, I915_BO_ALLOC_CONTIGUOUS);
+	if (IS_ERR(obj)) {
+		drm_err(&gt->i915->drm, "Failed to allocate gsc memory\n");
+		return PTR_ERR(obj);
+	}
+
+	err = i915_gem_object_pin_pages_unlocked(obj);
+	if (err) {
+		drm_err(&gt->i915->drm, "Failed to pin pages for gsc memory\n");
+		goto out_put;
+	}
+
+	vaddr = i915_gem_object_pin_map_unlocked(obj, i915_coherent_map_type(gt->i915, obj, true));
+	if (IS_ERR(vaddr)) {
+		err = PTR_ERR(vaddr);
+		drm_err(&gt->i915->drm, "Failed to map gsc memory\n");
+		goto out_unpin;
+	}
+
+	memset(vaddr, 0, obj->base.size);
+
+	i915_gem_object_unpin_map(obj);
+
+	intf->gem_obj = obj;
+
+	return 0;
+
+out_unpin:
+	i915_gem_object_unpin_pages(obj);
+out_put:
+	i915_gem_object_put(obj);
+	return err;
+}
+
+static void gsc_ext_om_destroy(struct intel_gsc_intf *intf)
+{
+	struct drm_i915_gem_object *obj = fetch_and_zero(&intf->gem_obj);
+
+	if (!obj)
+		return;
+
+	if (i915_gem_object_has_pinned_pages(obj))
+		i915_gem_object_unpin_pages(obj);
+
+	i915_gem_object_put(obj);
+}
+
 struct gsc_def {
 	const char *name;
 	unsigned long bar;
 	size_t bar_size;
 	bool use_polling;
 	bool slow_fw;
+	size_t lmem_size;
 };
 
 /* gsc resources and definitions (HECI1 and HECI2) */
@@ -74,6 +131,7 @@ static const struct gsc_def gsc_def_dg2[] = {
 		.name = "mei-gsc",
 		.bar = DG2_GSC_HECI1_BASE,
 		.bar_size = GSC_BAR_LENGTH,
+		.lmem_size = SZ_4M,
 	},
 	{
 		.name = "mei-gscfi",
@@ -90,26 +148,32 @@ static void gsc_release_dev(struct device *dev)
 	kfree(adev);
 }
 
-static void gsc_destroy_one(struct intel_gsc_intf *intf)
+static void gsc_destroy_one(struct drm_i915_private *i915,
+			    struct intel_gsc *gsc, unsigned int intf_id)
 {
+	struct intel_gsc_intf *intf = &gsc->intf[intf_id];
+
 	if (intf->adev) {
 		auxiliary_device_delete(&intf->adev->aux_dev);
 		auxiliary_device_uninit(&intf->adev->aux_dev);
 		intf->adev = NULL;
 	}
+
 	if (intf->irq >= 0)
 		irq_free_desc(intf->irq);
 	intf->irq = -1;
+
+	gsc_ext_om_destroy(intf);
 }
 
-static void gsc_init_one(struct drm_i915_private *i915,
-			 struct intel_gsc_intf *intf,
+static void gsc_init_one(struct drm_i915_private *i915, struct intel_gsc *gsc,
 			 unsigned int intf_id)
 {
 	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
 	struct mei_aux_device *adev;
 	struct auxiliary_device *aux_dev;
 	const struct gsc_def *def;
+	struct intel_gsc_intf *intf = &gsc->intf[intf_id];
 	int ret;
 
 	intf->irq = -1;
@@ -141,7 +205,7 @@ static void gsc_init_one(struct drm_i915_private *i915,
 	intf->irq = irq_alloc_desc(0);
 	if (intf->irq < 0) {
 		drm_err(&i915->drm, "gsc irq error %d\n", intf->irq);
-		return;
+		goto fail;
 	}
 
 	ret = gsc_irq_init(intf->irq);
@@ -155,6 +219,19 @@ static void gsc_init_one(struct drm_i915_private *i915,
 	if (!adev)
 		goto fail;
 
+	if (def->lmem_size) {
+		dev_dbg(&pdev->dev, "setting up GSC lmem\n");
+
+		if (gsc_ext_om_alloc(gsc, intf, def->lmem_size)) {
+			dev_err(&pdev->dev, "setting up gsc extended operational memory failed\n");
+			kfree(adev);
+			goto fail;
+		}
+
+		adev->ext_op_mem.start = i915_gem_object_get_dma_address(intf->gem_obj, 0);
+		adev->ext_op_mem.end = adev->ext_op_mem.start + def->lmem_size;
+	}
+
 	adev->irq = intf->irq;
 	adev->bar.parent = &pdev->resource[0];
 	adev->bar.start = def->bar + pdev->resource[0].start;
@@ -188,7 +265,7 @@ static void gsc_init_one(struct drm_i915_private *i915,
 
 	return;
 fail:
-	gsc_destroy_one(intf);
+	gsc_destroy_one(i915, gsc, intf->id);
 }
 
 static void gsc_irq_handler(struct intel_gt *gt, unsigned int intf_id)
@@ -229,7 +306,7 @@ void intel_gsc_init(struct intel_gsc *gsc, struct drm_i915_private *i915)
 		return;
 
 	for (i = 0; i < INTEL_GSC_NUM_INTERFACES; i++)
-		gsc_init_one(i915, &gsc->intf[i], i);
+		gsc_init_one(i915, gsc, i);
 }
 
 void intel_gsc_fini(struct intel_gsc *gsc)
@@ -241,5 +318,5 @@ void intel_gsc_fini(struct intel_gsc *gsc)
 		return;
 
 	for (i = 0; i < INTEL_GSC_NUM_INTERFACES; i++)
-		gsc_destroy_one(&gsc->intf[i]);
+		gsc_destroy_one(gt->i915, gsc, i);
 }
diff --git a/drivers/gpu/drm/i915/gt/intel_gsc.h b/drivers/gpu/drm/i915/gt/intel_gsc.h
index 68582f912b21..fcac1775e9c3 100644
--- a/drivers/gpu/drm/i915/gt/intel_gsc.h
+++ b/drivers/gpu/drm/i915/gt/intel_gsc.h
@@ -20,11 +20,14 @@ struct mei_aux_device;
 
 /**
  * struct intel_gsc - graphics security controller
+ *
+ * @gem_obj: scratch memory GSC operations
  * @intf : gsc interface
  */
 struct intel_gsc {
 	struct intel_gsc_intf {
 		struct mei_aux_device *adev;
+		struct drm_i915_gem_object *gem_obj;
 		int irq;
 		unsigned int id;
 	} intf[INTEL_GSC_NUM_INTERFACES];
-- 
2.35.3

