Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBA74FBEC6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347127AbiDKOSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347285AbiDKORg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:17:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678C6167D8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=91kRuIZ8XCQ0643wekcemX+6PKctajeMpBTs5GIrMZM=; b=3xwrnvkyhq4CAY4EiKqBowLaNA
        dZKe0QRLcBIYZrohXoR8zvKaFObGL/HUkOIArX9US7guDefJy702FfE7mvaiuKr05YGCjk39GhA5F
        ZsBn1EQMlYXD6LuTzS5edqWZD2uZa/5BEY/fKpTkBAHsIpdfBtP5vl1YYOOk9HfuRFNlpCrxoWB0Q
        wfPx+H7jeJtE4hv8CCXV3IidsJ38BdKJiurkmTzu6tO5q8NvTe6vUVJ6tjykMAz52FuinEdCunjCv
        95A/eUHGLp+Ezlkngfs5OmIWZ2hKFZKWYjB3c9HHeIIMeAVSkV6UoIKPoMwZEu0HpQQCNCcihlAu3
        gA7VpFsw==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nduox-009Kmx-4e; Mon, 11 Apr 2022 14:15:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/34] drm/i915/gvt: devirtualize ->dma_{,un}map_guest_page
Date:   Mon, 11 Apr 2022 16:13:50 +0200
Message-Id: <20220411141403.86980-22-hch@lst.de>
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

Just call the functions directly.  Also remove a pointless wrapper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/dmabuf.c    | 10 ++--------
 drivers/gpu/drm/i915/gvt/gtt.c       | 20 +++++++++----------
 drivers/gpu/drm/i915/gvt/gvt.h       |  4 ++++
 drivers/gpu/drm/i915/gvt/hypercall.h |  5 -----
 drivers/gpu/drm/i915/gvt/kvmgt.c     |  6 ++----
 drivers/gpu/drm/i915/gvt/mpt.h       | 29 ----------------------------
 6 files changed, 17 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.c b/drivers/gpu/drm/i915/gvt/dmabuf.c
index cc1a9ac0d2720..db93b63543276 100644
--- a/drivers/gpu/drm/i915/gvt/dmabuf.c
+++ b/drivers/gpu/drm/i915/gvt/dmabuf.c
@@ -54,12 +54,6 @@ static int vgpu_pin_dma_address(struct intel_vgpu *vgpu,
 	return ret;
 }
 
-static void vgpu_unpin_dma_address(struct intel_vgpu *vgpu,
-				   dma_addr_t dma_addr)
-{
-	intel_gvt_hypervisor_dma_unmap_guest_page(vgpu, dma_addr);
-}
-
 static int vgpu_gem_get_pages(
 		struct drm_i915_gem_object *obj)
 {
@@ -114,7 +108,7 @@ static int vgpu_gem_get_pages(
 		for_each_sg(st->sgl, sg, i, j) {
 			dma_addr = sg_dma_address(sg);
 			if (dma_addr)
-				vgpu_unpin_dma_address(vgpu, dma_addr);
+				intel_gvt_dma_unmap_guest_page(vgpu, dma_addr);
 		}
 		sg_free_table(st);
 		kfree(st);
@@ -136,7 +130,7 @@ static void vgpu_gem_put_pages(struct drm_i915_gem_object *obj,
 		int i;
 
 		for_each_sg(pages->sgl, sg, fb_info->size, i)
-			vgpu_unpin_dma_address(vgpu,
+			intel_gvt_dma_unmap_guest_page(vgpu,
 					       sg_dma_address(sg));
 	}
 
diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index f6f3b22a70d26..9c5cc28009758 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1013,7 +1013,7 @@ static inline void ppgtt_invalidate_pte(struct intel_vgpu_ppgtt_spt *spt,
 	if (!pfn || pfn == vgpu->gtt.scratch_pt[type].page_mfn)
 		return;
 
-	intel_gvt_hypervisor_dma_unmap_guest_page(vgpu, pfn << PAGE_SHIFT);
+	intel_gvt_dma_unmap_guest_page(vgpu, pfn << PAGE_SHIFT);
 }
 
 static int ppgtt_invalidate_spt(struct intel_vgpu_ppgtt_spt *spt)
@@ -1212,8 +1212,8 @@ static int split_2MB_gtt_entry(struct intel_vgpu *vgpu,
 		return PTR_ERR(sub_spt);
 
 	for_each_shadow_entry(sub_spt, &sub_se, sub_index) {
-		ret = intel_gvt_hypervisor_dma_map_guest_page(vgpu,
-				start_gfn + sub_index, PAGE_SIZE, &dma_addr);
+		ret = intel_gvt_dma_map_guest_page(vgpu, start_gfn + sub_index,
+						   PAGE_SIZE, &dma_addr);
 		if (ret) {
 			ppgtt_invalidate_spt(spt);
 			return ret;
@@ -1258,8 +1258,8 @@ static int split_64KB_gtt_entry(struct intel_vgpu *vgpu,
 	ops->set_64k_splited(&entry);
 
 	for (i = 0; i < GTT_64K_PTE_STRIDE; i++) {
-		ret = intel_gvt_hypervisor_dma_map_guest_page(vgpu,
-					start_gfn + i, PAGE_SIZE, &dma_addr);
+		ret = intel_gvt_dma_map_guest_page(vgpu, start_gfn + i,
+						   PAGE_SIZE, &dma_addr);
 		if (ret)
 			return ret;
 
@@ -1313,8 +1313,7 @@ static int ppgtt_populate_shadow_entry(struct intel_vgpu *vgpu,
 	}
 
 	/* direct shadow */
-	ret = intel_gvt_hypervisor_dma_map_guest_page(vgpu, gfn, page_size,
-						      &dma_addr);
+	ret = intel_gvt_dma_map_guest_page(vgpu, gfn, page_size, &dma_addr);
 	if (ret)
 		return -ENXIO;
 
@@ -2245,8 +2244,7 @@ static void ggtt_invalidate_pte(struct intel_vgpu *vgpu,
 
 	pfn = pte_ops->get_pfn(entry);
 	if (pfn != vgpu->gvt->gtt.scratch_mfn)
-		intel_gvt_hypervisor_dma_unmap_guest_page(vgpu,
-						pfn << PAGE_SHIFT);
+		intel_gvt_dma_unmap_guest_page(vgpu, pfn << PAGE_SHIFT);
 }
 
 static int emulate_ggtt_mmio_write(struct intel_vgpu *vgpu, unsigned int off,
@@ -2337,8 +2335,8 @@ static int emulate_ggtt_mmio_write(struct intel_vgpu *vgpu, unsigned int off,
 			goto out;
 		}
 
-		ret = intel_gvt_hypervisor_dma_map_guest_page(vgpu, gfn,
-							PAGE_SIZE, &dma_addr);
+		ret = intel_gvt_dma_map_guest_page(vgpu, gfn, PAGE_SIZE,
+						   &dma_addr);
 		if (ret) {
 			gvt_vgpu_err("fail to populate guest ggtt entry\n");
 			/* guest driver may read/write the entry when partial
diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index a8a8728cd54a8..4e42e6ac40772 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -767,6 +767,10 @@ void intel_gvt_debugfs_clean(struct intel_gvt *gvt);
 
 int intel_gvt_page_track_add(struct intel_vgpu *info, u64 gfn);
 int intel_gvt_page_track_remove(struct intel_vgpu *info, u64 gfn);
+int intel_gvt_dma_map_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
+		unsigned long size, dma_addr_t *dma_addr);
+void intel_gvt_dma_unmap_guest_page(struct intel_vgpu *vgpu,
+		dma_addr_t dma_addr);
 
 #include "trace.h"
 #include "mpt.h"
diff --git a/drivers/gpu/drm/i915/gvt/hypercall.h b/drivers/gpu/drm/i915/gvt/hypercall.h
index ded13a63ab663..ba03b3368a955 100644
--- a/drivers/gpu/drm/i915/gvt/hypercall.h
+++ b/drivers/gpu/drm/i915/gvt/hypercall.h
@@ -46,11 +46,6 @@ struct intel_gvt_mpt {
 	int (*host_init)(struct device *dev, void *gvt);
 	void (*host_exit)(struct device *dev, void *gvt);
 
-	int (*dma_map_guest_page)(struct intel_vgpu *vgpu, unsigned long gfn,
-				  unsigned long size, dma_addr_t *dma_addr);
-	void (*dma_unmap_guest_page)(struct intel_vgpu *vgpu,
-				dma_addr_t dma_addr);
-
 	int (*dma_pin_guest_page)(struct intel_vgpu *vgpu, dma_addr_t dma_addr);
 };
 
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index fbef3d3dfb1f5..a02274036487f 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1874,7 +1874,7 @@ void intel_vgpu_detach_regions(struct intel_vgpu *vgpu)
 	vgpu->region = NULL;
 }
 
-static int kvmgt_dma_map_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
+int intel_gvt_dma_map_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
 		unsigned long size, dma_addr_t *dma_addr)
 {
 	struct gvt_dma *entry;
@@ -1950,7 +1950,7 @@ static void __gvt_dma_release(struct kref *ref)
 	__gvt_cache_remove_entry(entry->vgpu, entry);
 }
 
-static void kvmgt_dma_unmap_guest_page(struct intel_vgpu *vgpu,
+void intel_gvt_dma_unmap_guest_page(struct intel_vgpu *vgpu,
 		dma_addr_t dma_addr)
 {
 	struct gvt_dma *entry;
@@ -1968,8 +1968,6 @@ static void kvmgt_dma_unmap_guest_page(struct intel_vgpu *vgpu,
 static const struct intel_gvt_mpt kvmgt_mpt = {
 	.host_init = kvmgt_host_init,
 	.host_exit = kvmgt_host_exit,
-	.dma_map_guest_page = kvmgt_dma_map_guest_page,
-	.dma_unmap_guest_page = kvmgt_dma_unmap_guest_page,
 	.dma_pin_guest_page = kvmgt_dma_pin_guest_page,
 };
 
diff --git a/drivers/gpu/drm/i915/gvt/mpt.h b/drivers/gpu/drm/i915/gvt/mpt.h
index d2723ac8bb044..26c1ee690f7e9 100644
--- a/drivers/gpu/drm/i915/gvt/mpt.h
+++ b/drivers/gpu/drm/i915/gvt/mpt.h
@@ -71,35 +71,6 @@ static inline void intel_gvt_hypervisor_host_exit(struct device *dev, void *gvt)
 	intel_gvt_host.mpt->host_exit(dev, gvt);
 }
 
-/**
- * intel_gvt_hypervisor_dma_map_guest_page - setup dma map for guest page
- * @vgpu: a vGPU
- * @gfn: guest pfn
- * @size: page size
- * @dma_addr: retrieve allocated dma addr
- *
- * Returns:
- * 0 on success, negative error code if failed.
- */
-static inline int intel_gvt_hypervisor_dma_map_guest_page(
-		struct intel_vgpu *vgpu, unsigned long gfn, unsigned long size,
-		dma_addr_t *dma_addr)
-{
-	return intel_gvt_host.mpt->dma_map_guest_page(vgpu, gfn, size,
-						      dma_addr);
-}
-
-/**
- * intel_gvt_hypervisor_dma_unmap_guest_page - cancel dma map for guest page
- * @vgpu: a vGPU
- * @dma_addr: the mapped dma addr
- */
-static inline void intel_gvt_hypervisor_dma_unmap_guest_page(
-		struct intel_vgpu *vgpu, dma_addr_t dma_addr)
-{
-	intel_gvt_host.mpt->dma_unmap_guest_page(vgpu, dma_addr);
-}
-
 /**
  * intel_gvt_hypervisor_dma_pin_guest_page - pin guest dma buf
  * @vgpu: a vGPU
-- 
2.30.2

