Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249F65737A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbiGMNjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbiGMNip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:38:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4685645E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:38:43 -0700 (PDT)
Received: from hermes-devbox.fritz.box (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 730B66601A3B;
        Wed, 13 Jul 2022 14:38:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657719522;
        bh=wMtiwAPPFkbj5c6Y/VFgLDdO9V1ZdhLdYyD12xWGZnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VkI6Ufhg1JdkgWJsynvx452joDHC+ZRzNriatrw3ve0kT+8VrY9RZFqB+6FmZG4kP
         ieNqkP2D/WcwD3R3f2obJv/4kqaA9joUTwDHFUYhsxxMrb12v5bJqIt47fQLMldRf0
         Uqgz95jQoOa7tA4dRSu+Y/LTn5TVpcpRkn+0r22xRdfcU/yZgnZtSB8HNvdEeCBuE2
         yKE+cSZutm5kWlfaSFyzPl5OFtf1nXQkvo4oWLEMYJzdQsvZyc4pj3gbp5hdaN9G+f
         fKI8pQ1mYpoKgKW1AXwyJaPDJkuIHY5u+1MQb08+/H66LiNhpK3zLKduiPEwINTyG5
         BjNhzIPLw1jRQ==
From:   Robert Beckett <bob.beckett@collabora.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     kernel@collabora.com, Robert Beckett <bob.beckett@collabora.com>,
        Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/8] drm/i915: setup ggtt scratch page after memory regions
Date:   Wed, 13 Jul 2022 14:38:15 +0100
Message-Id: <20220713133818.3699604-6-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713133818.3699604-1-bob.beckett@collabora.com>
References: <20220713133818.3699604-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder scratch page allocation so that memory regions are available
to allocate the buffers

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/i915/gt/intel_ggtt.c | 20 ++++++++++++++++++--
 drivers/gpu/drm/i915/gt/intel_gtt.h  |  1 +
 drivers/gpu/drm/i915/i915_driver.c   | 16 ++++++++++------
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_ggtt.c b/drivers/gpu/drm/i915/gt/intel_ggtt.c
index 15a915bb4088..c4ad03e53236 100644
--- a/drivers/gpu/drm/i915/gt/intel_ggtt.c
+++ b/drivers/gpu/drm/i915/gt/intel_ggtt.c
@@ -866,8 +866,6 @@ static int ggtt_probe_common(struct i915_ggtt *ggtt, u64 size)
 	struct drm_i915_private *i915 = ggtt->vm.i915;
 	struct pci_dev *pdev = to_pci_dev(i915->drm.dev);
 	phys_addr_t phys_addr;
-	u32 pte_flags;
-	int ret;
 
 	GEM_WARN_ON(pci_resource_len(pdev, 0) != gen6_gttmmadr_size(i915));
 	phys_addr = pci_resource_start(pdev, 0) + gen6_gttadr_offset(i915);
@@ -889,6 +887,24 @@ static int ggtt_probe_common(struct i915_ggtt *ggtt, u64 size)
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
diff --git a/drivers/gpu/drm/i915/gt/intel_gtt.h b/drivers/gpu/drm/i915/gt/intel_gtt.h
index e639434e97fd..4ebdf70b5273 100644
--- a/drivers/gpu/drm/i915/gt/intel_gtt.h
+++ b/drivers/gpu/drm/i915/gt/intel_gtt.h
@@ -579,6 +579,7 @@ void intel_ggtt_unbind_vma(struct i915_address_space *vm,
 			   struct i915_vma_resource *vma_res);
 
 int i915_ggtt_probe_hw(struct drm_i915_private *i915);
+int i915_ggtt_setup_scratch_page(struct drm_i915_private *i915);
 int i915_ggtt_init_hw(struct drm_i915_private *i915);
 int i915_ggtt_enable_hw(struct drm_i915_private *i915);
 void i915_ggtt_enable_guc(struct i915_ggtt *ggtt);
diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index deb8a8b76965..fa0956840fcc 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -69,6 +69,7 @@
 #include "gem/i915_gem_mman.h"
 #include "gem/i915_gem_pm.h"
 #include "gt/intel_gt.h"
+#include "gt/intel_gtt.h"
 #include "gt/intel_gt_pm.h"
 #include "gt/intel_rc6.h"
 
@@ -609,12 +610,16 @@ static int i915_driver_hw_probe(struct drm_i915_private *dev_priv)
 
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
@@ -675,11 +680,10 @@ static int i915_driver_hw_probe(struct drm_i915_private *dev_priv)
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
@@ -928,9 +932,9 @@ int i915_driver_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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
@@ -987,9 +991,9 @@ static void i915_driver_release(struct drm_device *dev)
 
 	i915_gem_driver_release(dev_priv);
 
-	intel_memory_regions_driver_release(dev_priv);
 	i915_ggtt_driver_release(dev_priv);
 	i915_gem_drain_freed_objects(dev_priv);
+	intel_memory_regions_driver_release(dev_priv);
 	i915_ggtt_driver_late_release(dev_priv);
 
 	i915_driver_mmio_release(dev_priv);
-- 
2.25.1

