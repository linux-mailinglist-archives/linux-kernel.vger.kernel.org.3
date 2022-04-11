Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4846F4FBEC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347125AbiDKOSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347266AbiDKORe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:17:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9929016580
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=J1iGiahf1zMxKy2YAv7Ox/u+v/al350AuwkUozSQ6eM=; b=SaJIRlenSEGA+pmb7JqNaNe4sr
        0Z/R/kkXoZ8wG+XHw924HaCaSfuHzn4CI9iXjWDhtJx/bM59f4LVARSq9PSzqKAvPftixD0h5RhoB
        qUWTr0ENayglbzxCy0Zs3BasTHwyhHX9QsgD/9nIILmLQI7ne2ZYW6eQCyczFO2OnZj42lF8aUKq2
        eWt+F5Qu+PFbQGIij6KII0XbYO4Icals2OugcxlzjI7V6sUt1IV/4Nt1cPc0re4pvvPZcvIOhgH9M
        HvZN9YaCQMbH7847mhQC1DESpuSwUp0LDmsWY0bYDghvIuZiK2oC+gfRVk5JT/SlBX87mL/4WZ159
        9V6JpklA==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nduou-009KlJ-28; Mon, 11 Apr 2022 14:15:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/34] drm/i915/gvt: devirtualize ->{enable,disable}_page_track
Date:   Mon, 11 Apr 2022 16:13:49 +0200
Message-Id: <20220411141403.86980-21-hch@lst.de>
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

Just call the kvmgt functions directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/gvt.h        |  3 +++
 drivers/gpu/drm/i915/gvt/hypercall.h  |  2 --
 drivers/gpu/drm/i915/gvt/kvmgt.c      |  6 ++----
 drivers/gpu/drm/i915/gvt/mpt.h        | 28 ---------------------------
 drivers/gpu/drm/i915/gvt/page_track.c |  8 ++++----
 5 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index 52ef88d2bf21a..a8a8728cd54a8 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -765,6 +765,9 @@ void intel_gvt_debugfs_remove_vgpu(struct intel_vgpu *vgpu);
 void intel_gvt_debugfs_init(struct intel_gvt *gvt);
 void intel_gvt_debugfs_clean(struct intel_gvt *gvt);
 
+int intel_gvt_page_track_add(struct intel_vgpu *info, u64 gfn);
+int intel_gvt_page_track_remove(struct intel_vgpu *info, u64 gfn);
+
 #include "trace.h"
 #include "mpt.h"
 
diff --git a/drivers/gpu/drm/i915/gvt/hypercall.h b/drivers/gpu/drm/i915/gvt/hypercall.h
index dbde492cafc84..ded13a63ab663 100644
--- a/drivers/gpu/drm/i915/gvt/hypercall.h
+++ b/drivers/gpu/drm/i915/gvt/hypercall.h
@@ -45,8 +45,6 @@ struct intel_vgpu;
 struct intel_gvt_mpt {
 	int (*host_init)(struct device *dev, void *gvt);
 	void (*host_exit)(struct device *dev, void *gvt);
-	int (*enable_page_track)(struct intel_vgpu *vgpu, u64 gfn);
-	int (*disable_page_track)(struct intel_vgpu *vgpu, u64 gfn);
 
 	int (*dma_map_guest_page)(struct intel_vgpu *vgpu, unsigned long gfn,
 				  unsigned long size, dma_addr_t *dma_addr);
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 6d4c67270172a..fbef3d3dfb1f5 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1702,7 +1702,7 @@ static void kvmgt_host_exit(struct device *dev, void *gvt)
 	intel_gvt_cleanup_vgpu_type_groups((struct intel_gvt *)gvt);
 }
 
-static int kvmgt_page_track_add(struct intel_vgpu *info, u64 gfn)
+int intel_gvt_page_track_add(struct intel_vgpu *info, u64 gfn)
 {
 	struct kvm *kvm = info->kvm;
 	struct kvm_memory_slot *slot;
@@ -1732,7 +1732,7 @@ static int kvmgt_page_track_add(struct intel_vgpu *info, u64 gfn)
 	return 0;
 }
 
-static int kvmgt_page_track_remove(struct intel_vgpu *info, u64 gfn)
+int intel_gvt_page_track_remove(struct intel_vgpu *info, u64 gfn)
 {
 	struct kvm *kvm = info->kvm;
 	struct kvm_memory_slot *slot;
@@ -1968,8 +1968,6 @@ static void kvmgt_dma_unmap_guest_page(struct intel_vgpu *vgpu,
 static const struct intel_gvt_mpt kvmgt_mpt = {
 	.host_init = kvmgt_host_init,
 	.host_exit = kvmgt_host_exit,
-	.enable_page_track = kvmgt_page_track_add,
-	.disable_page_track = kvmgt_page_track_remove,
 	.dma_map_guest_page = kvmgt_dma_map_guest_page,
 	.dma_unmap_guest_page = kvmgt_dma_unmap_guest_page,
 	.dma_pin_guest_page = kvmgt_dma_pin_guest_page,
diff --git a/drivers/gpu/drm/i915/gvt/mpt.h b/drivers/gpu/drm/i915/gvt/mpt.h
index 2d4bb6eaa08e3..d2723ac8bb044 100644
--- a/drivers/gpu/drm/i915/gvt/mpt.h
+++ b/drivers/gpu/drm/i915/gvt/mpt.h
@@ -71,34 +71,6 @@ static inline void intel_gvt_hypervisor_host_exit(struct device *dev, void *gvt)
 	intel_gvt_host.mpt->host_exit(dev, gvt);
 }
 
-/**
- * intel_gvt_hypervisor_enable_page_track - track a guest page
- * @vgpu: a vGPU
- * @gfn: the gfn of guest
- *
- * Returns:
- * Zero on success, negative error code if failed.
- */
-static inline int intel_gvt_hypervisor_enable_page_track(
-		struct intel_vgpu *vgpu, unsigned long gfn)
-{
-	return intel_gvt_host.mpt->enable_page_track(vgpu, gfn);
-}
-
-/**
- * intel_gvt_hypervisor_disable_page_track - untrack a guest page
- * @vgpu: a vGPU
- * @gfn: the gfn of guest
- *
- * Returns:
- * Zero on success, negative error code if failed.
- */
-static inline int intel_gvt_hypervisor_disable_page_track(
-		struct intel_vgpu *vgpu, unsigned long gfn)
-{
-	return intel_gvt_host.mpt->disable_page_track(vgpu, gfn);
-}
-
 /**
  * intel_gvt_hypervisor_dma_map_guest_page - setup dma map for guest page
  * @vgpu: a vGPU
diff --git a/drivers/gpu/drm/i915/gvt/page_track.c b/drivers/gpu/drm/i915/gvt/page_track.c
index 84856022528ee..3375b51c75f1e 100644
--- a/drivers/gpu/drm/i915/gvt/page_track.c
+++ b/drivers/gpu/drm/i915/gvt/page_track.c
@@ -87,7 +87,7 @@ void intel_vgpu_unregister_page_track(struct intel_vgpu *vgpu,
 	track = radix_tree_delete(&vgpu->page_track_tree, gfn);
 	if (track) {
 		if (track->tracked)
-			intel_gvt_hypervisor_disable_page_track(vgpu, gfn);
+			intel_gvt_page_track_remove(vgpu, gfn);
 		kfree(track);
 	}
 }
@@ -112,7 +112,7 @@ int intel_vgpu_enable_page_track(struct intel_vgpu *vgpu, unsigned long gfn)
 	if (track->tracked)
 		return 0;
 
-	ret = intel_gvt_hypervisor_enable_page_track(vgpu, gfn);
+	ret = intel_gvt_page_track_add(vgpu, gfn);
 	if (ret)
 		return ret;
 	track->tracked = true;
@@ -139,7 +139,7 @@ int intel_vgpu_disable_page_track(struct intel_vgpu *vgpu, unsigned long gfn)
 	if (!track->tracked)
 		return 0;
 
-	ret = intel_gvt_hypervisor_disable_page_track(vgpu, gfn);
+	ret = intel_gvt_page_track_remove(vgpu, gfn);
 	if (ret)
 		return ret;
 	track->tracked = false;
@@ -172,7 +172,7 @@ int intel_vgpu_page_track_handler(struct intel_vgpu *vgpu, u64 gpa,
 
 	if (unlikely(vgpu->failsafe)) {
 		/* Remove write protection to prevent furture traps. */
-		intel_vgpu_disable_page_track(vgpu, gpa >> PAGE_SHIFT);
+		intel_gvt_page_track_remove(vgpu, gpa >> PAGE_SHIFT);
 	} else {
 		ret = page_track->handler(page_track, gpa, data, bytes);
 		if (ret)
-- 
2.30.2

