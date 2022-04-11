Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EF94FBEE0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347228AbiDKOUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347217AbiDKORb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:17:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8FB15739
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=goHHpI3WnE67v8nanm/rENsJPIStZtr1Ul7m3vMBtJ0=; b=2NAGCqhdgB8b4F/2Rwvj+R/2vh
        FDxGE8GIqEc3iEY9AGV6dI/c27YINZkmGyuMub2dU57o44VOhfs2RGgGZ+CJwz2JGxneizChac1gt
        BIQKnvuJTeKYTPNIS7d6enp6drlcqJYS1gP0zy58pcvDCwnwMDbZsXzELvbxlOcu1MrZCfE3YnhBk
        DcJyHlbEH4UfK6zxgVEhjfdbir2jrWPuL45lx2psjwiEnA27ypUHqC9d/+cMNo74/DmRfuK9pdu8M
        jF6duHGQTNyShG++26BoAr28sufIcfCl4JK0IkdGPpKjQbq3XmsUElsS9K3YdbzlSIjJY1DRIldkr
        fffkfBrA==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nduoo-009Ki9-Ao; Mon, 11 Apr 2022 14:15:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/34] drm/i915/gvt: devirtualize ->is_valid_gfn
Date:   Mon, 11 Apr 2022 16:13:47 +0200
Message-Id: <20220411141403.86980-19-hch@lst.de>
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

Just call the code directly and move towards the callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/gtt.c       | 20 ++++++++++++++++++--
 drivers/gpu/drm/i915/gvt/hypercall.h |  1 -
 drivers/gpu/drm/i915/gvt/kvmgt.c     | 17 -----------------
 drivers/gpu/drm/i915/gvt/mpt.h       | 17 -----------------
 4 files changed, 18 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 9b696e5705eb7..1360412f8ef8a 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -49,6 +49,22 @@
 static bool enable_out_of_sync = false;
 static int preallocated_oos_pages = 8192;
 
+static bool intel_gvt_is_valid_gfn(struct intel_vgpu *vgpu, unsigned long gfn)
+{
+	struct kvm *kvm = vgpu->kvm;
+	int idx;
+	bool ret;
+
+	if (!vgpu->attached)
+		return false;
+
+	idx = srcu_read_lock(&kvm->srcu);
+	ret = kvm_is_visible_gfn(kvm, gfn);
+	srcu_read_unlock(&kvm->srcu, idx);
+
+	return ret;
+}
+
 /*
  * validate a gm address and related range size,
  * translate it to host gm address
@@ -1331,7 +1347,7 @@ static int ppgtt_populate_spt(struct intel_vgpu_ppgtt_spt *spt)
 			ppgtt_set_shadow_entry(spt, &se, i);
 		} else {
 			gfn = ops->get_pfn(&ge);
-			if (!intel_gvt_hypervisor_is_valid_gfn(vgpu, gfn)) {
+			if (!intel_gvt_is_valid_gfn(vgpu, gfn)) {
 				ops->set_pfn(&se, gvt->gtt.scratch_mfn);
 				ppgtt_set_shadow_entry(spt, &se, i);
 				continue;
@@ -2315,7 +2331,7 @@ static int emulate_ggtt_mmio_write(struct intel_vgpu *vgpu, unsigned int off,
 		/* one PTE update may be issued in multiple writes and the
 		 * first write may not construct a valid gfn
 		 */
-		if (!intel_gvt_hypervisor_is_valid_gfn(vgpu, gfn)) {
+		if (!intel_gvt_is_valid_gfn(vgpu, gfn)) {
 			ops->set_pfn(&m, gvt->gtt.scratch_mfn);
 			goto out;
 		}
diff --git a/drivers/gpu/drm/i915/gvt/hypercall.h b/drivers/gpu/drm/i915/gvt/hypercall.h
index de63bd8dd05ba..c1a9eeed04607 100644
--- a/drivers/gpu/drm/i915/gvt/hypercall.h
+++ b/drivers/gpu/drm/i915/gvt/hypercall.h
@@ -55,7 +55,6 @@ struct intel_gvt_mpt {
 				dma_addr_t dma_addr);
 
 	int (*dma_pin_guest_page)(struct intel_vgpu *vgpu, dma_addr_t dma_addr);
-	bool (*is_valid_gfn)(struct intel_vgpu *vgpu, unsigned long gfn);
 };
 
 #endif /* _GVT_HYPERCALL_H_ */
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 1d1c026fd8258..93fd7f997c8a1 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1980,22 +1980,6 @@ static void kvmgt_dma_unmap_guest_page(struct intel_vgpu *vgpu,
 	mutex_unlock(&vgpu->cache_lock);
 }
 
-static bool kvmgt_is_valid_gfn(struct intel_vgpu *vgpu, unsigned long gfn)
-{
-	struct kvm *kvm = vgpu->kvm;
-	int idx;
-	bool ret;
-
-	if (!vgpu->attached)
-		return false;
-
-	idx = srcu_read_lock(&kvm->srcu);
-	ret = kvm_is_visible_gfn(kvm, gfn);
-	srcu_read_unlock(&kvm->srcu, idx);
-
-	return ret;
-}
-
 static const struct intel_gvt_mpt kvmgt_mpt = {
 	.host_init = kvmgt_host_init,
 	.host_exit = kvmgt_host_exit,
@@ -2005,7 +1989,6 @@ static const struct intel_gvt_mpt kvmgt_mpt = {
 	.dma_map_guest_page = kvmgt_dma_map_guest_page,
 	.dma_unmap_guest_page = kvmgt_dma_unmap_guest_page,
 	.dma_pin_guest_page = kvmgt_dma_pin_guest_page,
-	.is_valid_gfn = kvmgt_is_valid_gfn,
 };
 
 struct intel_gvt_host intel_gvt_host = {
diff --git a/drivers/gpu/drm/i915/gvt/mpt.h b/drivers/gpu/drm/i915/gvt/mpt.h
index 59369e8b3b692..1a796f2181ba8 100644
--- a/drivers/gpu/drm/i915/gvt/mpt.h
+++ b/drivers/gpu/drm/i915/gvt/mpt.h
@@ -157,21 +157,4 @@ intel_gvt_hypervisor_dma_pin_guest_page(struct intel_vgpu *vgpu,
 	return intel_gvt_host.mpt->dma_pin_guest_page(vgpu, dma_addr);
 }
 
-/**
- * intel_gvt_hypervisor_is_valid_gfn - check if a visible gfn
- * @vgpu: a vGPU
- * @gfn: guest PFN
- *
- * Returns:
- * true on valid gfn, false on not.
- */
-static inline bool intel_gvt_hypervisor_is_valid_gfn(
-		struct intel_vgpu *vgpu, unsigned long gfn)
-{
-	if (!intel_gvt_host.mpt->is_valid_gfn)
-		return true;
-
-	return intel_gvt_host.mpt->is_valid_gfn(vgpu, gfn);
-}
-
 #endif /* _GVT_MPT_H_ */
-- 
2.30.2

