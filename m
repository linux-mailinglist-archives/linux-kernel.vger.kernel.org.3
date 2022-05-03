Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7017C518D01
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241857AbiECTR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbiECTRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:17:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5859D3FBC2
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 12:13:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id C70741F44696
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651605222;
        bh=BrrXl1DLuwtCYL3AG6Wnkjfr67V6wrEn6XhtxDa0d10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zc9y73Udd/drhxC7bTQdfTAS9cQJ2nVw2h1o9lDw8hZEmzE2FmnWW0Pe/yaSSdqvQ
         6F8am+JSUZm9ymPswX7A4A2OYdGm3Xv87B0Y5jN75vwyOXfnaX0bPZBiHaHaL/rKV4
         BdWEq2FFSPYDsRciFWANMAwyK5Ns3hYsKlAmiDN62Vex3YXWWUYwirUQbrX5lwH1cV
         Xq6Nfw2Rvp//j/wkJEAlqqqZDXq2ZwphegPoqaQ+A6qRsXN+QELY6SDPoU8m3Cuv4G
         Lo4moZ3Oj3yAV/9wDfDjiPHKI/8PBMJJhVKjfOZ9vUR2zeXBNuE+ai91gG/W0EhX+5
         vKiuS4JJko3qg==
From:   Robert Beckett <bob.beckett@collabora.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Robert Beckett <bob.beckett@collabora.com>,
        Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/i915: setup ggtt scratch page after memory regions
Date:   Tue,  3 May 2022 19:13:14 +0000
Message-Id: <20220503191316.1145124-3-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503191316.1145124-1-bob.beckett@collabora.com>
References: <20220503191316.1145124-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reorder scratch page allocation so that memory regions are available
to allocate the buffers

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/i915/gt/intel_gt_gmch.c | 20 ++++++++++++++++++--
 drivers/gpu/drm/i915/gt/intel_gt_gmch.h |  6 ++++++
 drivers/gpu/drm/i915/i915_driver.c      | 16 ++++++++++------
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_gt_gmch.c b/drivers/gpu/drm/i915/gt/intel_gt_gmch.c
index 18e488672d1b..5411df1734ac 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_gmch.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_gmch.c
@@ -440,8 +440,6 @@ static int ggtt_probe_common(struct i915_ggtt *ggtt, u64 size)
 	struct drm_i915_private *i915 = ggtt->vm.i915;
 	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
 	phys_addr_t phys_addr;
-	u32 pte_flags;
-	int ret;
 
 	GEM_WARN_ON(pci_resource_len(pdev, 0) != gen6_gttmmadr_size(i915));
 	phys_addr = pci_resource_start(pdev, 0) + gen6_gttadr_offset(i915);
@@ -463,6 +461,24 @@ static int ggtt_probe_common(struct i915_ggtt *ggtt, u64 size)
 	}
 
 	kref_init(&ggtt->vm.resv_ref);
+
+	return 0;
+}
+
+/**
+ * i915_ggtt_setup_scratch_page - setup ggtt scratch page
+ * @i915: i915 device
+ */
+int i915_ggtt_setup_scratch_page(struct drm_i915_private *i915)
+{
+	struct i915_ggtt *ggtt = to_gt(i915)->ggtt;
+	u32 pte_flags;
+	int ret;
+
+	/* gen5- scratch setup currently happens in @intel_gtt_init */
+	if (GRAPHICS_VER(i915) <= 5)
+		return 0;
+
 	ret = setup_scratch_page(&ggtt->vm);
 	if (ret) {
 		drm_err(&i915->drm, "Scratch setup failed\n");
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_gmch.h b/drivers/gpu/drm/i915/gt/intel_gt_gmch.h
index 75ed55c1f30a..c6b79cb78637 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_gmch.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_gmch.h
@@ -15,6 +15,7 @@ int intel_gt_gmch_gen6_probe(struct i915_ggtt *ggtt);
 int intel_gt_gmch_gen8_probe(struct i915_ggtt *ggtt);
 int intel_gt_gmch_gen5_probe(struct i915_ggtt *ggtt);
 int intel_gt_gmch_gen5_enable_hw(struct drm_i915_private *i915);
+int i915_ggtt_setup_scratch_page(struct drm_i915_private *i915);
 
 /* Stubs for non-x86 platforms */
 #else
@@ -41,6 +42,11 @@ static inline int intel_gt_gmch_gen5_enable_hw(struct drm_i915_private *i915)
 	/* No HW should be enabled for this case yet, return fail */
 	return -ENODEV;
 }
+
+static inline int i915_ggtt_setup_scratch_page(struct drm_i915_private *i915)
+{
+	return 0;
+}
 #endif
 
 #endif /* __INTEL_GT_GMCH_H__ */
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index 90b0ce5051af..f67476b2f349 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -69,6 +69,7 @@
 #include "gem/i915_gem_mman.h"
 #include "gem/i915_gem_pm.h"
 #include "gt/intel_gt.h"
+#include "gt/intel_gt_gmch.h"
 #include "gt/intel_gt_pm.h"
 #include "gt/intel_rc6.h"
 
@@ -589,12 +590,16 @@ static int i915_driver_hw_probe(struct drm_i915_private *dev_priv)
 
 	ret = intel_gt_tiles_init(dev_priv);
 	if (ret)
-		goto err_mem_regions;
+		goto err_ggtt;
+
+	ret = i915_ggtt_setup_scratch_page(dev_priv);
+	if (ret)
+		goto err_ggtt;
 
 	ret = i915_ggtt_enable_hw(dev_priv);
 	if (ret) {
 		drm_err(&dev_priv->drm, "failed to enable GGTT\n");
-		goto err_mem_regions;
+		goto err_ggtt;
 	}
 
 	pci_set_master(pdev);
@@ -646,11 +651,10 @@ static int i915_driver_hw_probe(struct drm_i915_private *dev_priv)
 err_msi:
 	if (pdev->msi_enabled)
 		pci_disable_msi(pdev);
-err_mem_regions:
-	intel_memory_regions_driver_release(dev_priv);
 err_ggtt:
 	i915_ggtt_driver_release(dev_priv);
 	i915_gem_drain_freed_objects(dev_priv);
+	intel_memory_regions_driver_release(dev_priv);
 	i915_ggtt_driver_late_release(dev_priv);
 err_perf:
 	i915_perf_fini(dev_priv);
@@ -896,9 +900,9 @@ int i915_driver_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	intel_modeset_driver_remove_nogem(i915);
 out_cleanup_hw:
 	i915_driver_hw_remove(i915);
-	intel_memory_regions_driver_release(i915);
 	i915_ggtt_driver_release(i915);
 	i915_gem_drain_freed_objects(i915);
+	intel_memory_regions_driver_release(i915);
 	i915_ggtt_driver_late_release(i915);
 out_cleanup_mmio:
 	i915_driver_mmio_release(i915);
@@ -955,9 +959,9 @@ static void i915_driver_release(struct drm_device *dev)
 
 	i915_gem_driver_release(dev_priv);
 
-	intel_memory_regions_driver_release(dev_priv);
 	i915_ggtt_driver_release(dev_priv);
 	i915_gem_drain_freed_objects(dev_priv);
+	intel_memory_regions_driver_release(dev_priv);
 	i915_ggtt_driver_late_release(dev_priv);
 
 	i915_driver_mmio_release(dev_priv);
-- 
2.25.1

