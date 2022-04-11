Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C428E4FBEC9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347096AbiDKOSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347119AbiDKOR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:17:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09A513CC7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Hlfn3thkAh/Fn2LiXS4XpRdA9j5TzzlFU/3uRtyPvtM=; b=XNegV1mkXwZncG/2z9LmhGh+iL
        nCMK1UCUYCDdEvYaYD8xjrmFvP/AaQN/qHn8LUMzAJjsQZT6pKMWhLE0qMiLIhbkNXjUckuCzPmK5
        DAagC2nRgwrivFTo1jNdu1AfpYzDdQ/73cuOzfryNygFgdlS01Mpk8g2PKSyyeo1m9UPOLwowBVPy
        PaDyZNQiPu9MyxUUXH643CxUp/1qwSc35yzD5WXRHVf8ePtIkDorhEHJT3aftItLX9KVVdiIMLHds
        JaRPhxG1oMs/Nwd2yppzJzmkKkL7uU2LSf7Kt4ECKEb1jM7moz4nf6jhtlHm5rXpapEagoVg7EZm0
        68CWLyDA==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nduoZ-009KYA-Ir; Mon, 11 Apr 2022 14:14:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/34] drm/i915/gvt: devirtualize ->{read,write}_gpa
Date:   Mon, 11 Apr 2022 16:13:42 +0200
Message-Id: <20220411141403.86980-14-hch@lst.de>
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

Just call the VFIO functions directly instead of through the method
table.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/cmd_parser.c |  4 +--
 drivers/gpu/drm/i915/gvt/execlist.c   | 12 ++++-----
 drivers/gpu/drm/i915/gvt/gtt.c        |  6 ++---
 drivers/gpu/drm/i915/gvt/gvt.h        | 37 +++++++++++++++++++++++++++
 drivers/gpu/drm/i915/gvt/hypercall.h  |  4 ---
 drivers/gpu/drm/i915/gvt/kvmgt.c      | 23 -----------------
 drivers/gpu/drm/i915/gvt/mmio.c       |  4 +--
 drivers/gpu/drm/i915/gvt/mpt.h        | 32 -----------------------
 drivers/gpu/drm/i915/gvt/opregion.c   | 10 +++-----
 drivers/gpu/drm/i915/gvt/scheduler.c  | 37 +++++++++++++--------------
 10 files changed, 72 insertions(+), 97 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/cmd_parser.c b/drivers/gpu/drm/i915/gvt/cmd_parser.c
index 2459213b6c87f..b9eb75a2b4002 100644
--- a/drivers/gpu/drm/i915/gvt/cmd_parser.c
+++ b/drivers/gpu/drm/i915/gvt/cmd_parser.c
@@ -1011,7 +1011,7 @@ static int cmd_reg_handler(struct parser_exec_state *s,
 	if (GRAPHICS_VER(s->engine->i915) == 9 &&
 	    intel_gvt_mmio_is_sr_in_ctx(gvt, offset) &&
 	    !strncmp(cmd, "lri", 3)) {
-		intel_gvt_hypervisor_read_gpa(s->vgpu,
+		intel_gvt_read_gpa(s->vgpu,
 			s->workload->ring_context_gpa + 12, &ctx_sr_ctl, 4);
 		/* check inhibit context */
 		if (ctx_sr_ctl & 1) {
@@ -1775,7 +1775,7 @@ static int copy_gma_to_hva(struct intel_vgpu *vgpu, struct intel_vgpu_mm *mm,
 		copy_len = (end_gma - gma) >= (I915_GTT_PAGE_SIZE - offset) ?
 			I915_GTT_PAGE_SIZE - offset : end_gma - gma;
 
-		intel_gvt_hypervisor_read_gpa(vgpu, gpa, va + len, copy_len);
+		intel_gvt_read_gpa(vgpu, gpa, va + len, copy_len);
 
 		len += copy_len;
 		gma += copy_len;
diff --git a/drivers/gpu/drm/i915/gvt/execlist.c b/drivers/gpu/drm/i915/gvt/execlist.c
index 66d354c4195b4..274c6ef42400b 100644
--- a/drivers/gpu/drm/i915/gvt/execlist.c
+++ b/drivers/gpu/drm/i915/gvt/execlist.c
@@ -159,12 +159,12 @@ static void emulate_csb_update(struct intel_vgpu_execlist *execlist,
 	hwsp_gpa = intel_vgpu_gma_to_gpa(vgpu->gtt.ggtt_mm,
 					 vgpu->hws_pga[execlist->engine->id]);
 	if (hwsp_gpa != INTEL_GVT_INVALID_ADDR) {
-		intel_gvt_hypervisor_write_gpa(vgpu,
-					       hwsp_gpa + I915_HWS_CSB_BUF0_INDEX * 4 + write_pointer * 8,
-					       status, 8);
-		intel_gvt_hypervisor_write_gpa(vgpu,
-					       hwsp_gpa + INTEL_HWS_CSB_WRITE_INDEX(execlist->engine->i915) * 4,
-					       &write_pointer, 4);
+		intel_gvt_write_gpa(vgpu,
+			hwsp_gpa + I915_HWS_CSB_BUF0_INDEX * 4 + write_pointer * 8,
+			status, 8);
+		intel_gvt_write_gpa(vgpu,
+			hwsp_gpa + INTEL_HWS_CSB_WRITE_INDEX(execlist->engine->i915) * 4,
+			&write_pointer, 4);
 	}
 
 	gvt_dbg_el("vgpu%d: w pointer %u reg %x csb l %x csb h %x\n",
diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index d4082f4b9be19..9b696e5705eb7 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -314,7 +314,7 @@ static inline int gtt_get_entry64(void *pt,
 		return -EINVAL;
 
 	if (hypervisor_access) {
-		ret = intel_gvt_hypervisor_read_gpa(vgpu, gpa +
+		ret = intel_gvt_read_gpa(vgpu, gpa +
 				(index << info->gtt_entry_size_shift),
 				&e->val64, 8);
 		if (WARN_ON(ret))
@@ -339,7 +339,7 @@ static inline int gtt_set_entry64(void *pt,
 		return -EINVAL;
 
 	if (hypervisor_access) {
-		ret = intel_gvt_hypervisor_write_gpa(vgpu, gpa +
+		ret = intel_gvt_write_gpa(vgpu, gpa +
 				(index << info->gtt_entry_size_shift),
 				&e->val64, 8);
 		if (WARN_ON(ret))
@@ -1497,7 +1497,7 @@ static int attach_oos_page(struct intel_vgpu_oos_page *oos_page,
 	struct intel_gvt *gvt = spt->vgpu->gvt;
 	int ret;
 
-	ret = intel_gvt_hypervisor_read_gpa(spt->vgpu,
+	ret = intel_gvt_read_gpa(spt->vgpu,
 			spt->guest_page.gfn << I915_GTT_PAGE_SHIFT,
 			oos_page->mem, I915_GTT_PAGE_SIZE);
 	if (ret)
diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index cda70ea3d1747..ea07f45138056 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -35,6 +35,7 @@
 
 #include <uapi/linux/pci_regs.h>
 #include <linux/kvm_host.h>
+#include <linux/vfio.h>
 
 #include "i915_drv.h"
 #include "intel_gvt.h"
@@ -720,6 +721,42 @@ static inline bool intel_gvt_mmio_is_cmd_write_patch(
 	return gvt->mmio.mmio_attribute[offset >> 2] & F_CMD_WRITE_PATCH;
 }
 
+/**
+ * intel_gvt_read_gpa - copy data from GPA to host data buffer
+ * @vgpu: a vGPU
+ * @gpa: guest physical address
+ * @buf: host data buffer
+ * @len: data length
+ *
+ * Returns:
+ * Zero on success, negative error code if failed.
+ */
+static inline int intel_gvt_read_gpa(struct intel_vgpu *vgpu, unsigned long gpa,
+		void *buf, unsigned long len)
+{
+	if (!vgpu->attached)
+		return -ESRCH;
+	return vfio_dma_rw(vgpu->vfio_group, gpa, buf, len, false);
+}
+
+/**
+ * intel_gvt_write_gpa - copy data from host data buffer to GPA
+ * @vgpu: a vGPU
+ * @gpa: guest physical address
+ * @buf: host data buffer
+ * @len: data length
+ *
+ * Returns:
+ * Zero on success, negative error code if failed.
+ */
+static inline int intel_gvt_write_gpa(struct intel_vgpu *vgpu,
+		unsigned long gpa, void *buf, unsigned long len)
+{
+	if (!vgpu->attached)
+		return -ESRCH;
+	return vfio_dma_rw(vgpu->vfio_group, gpa, buf, len, true);
+}
+
 void intel_gvt_debugfs_remove_vgpu(struct intel_vgpu *vgpu);
 void intel_gvt_debugfs_init(struct intel_gvt *gvt);
 void intel_gvt_debugfs_clean(struct intel_gvt *gvt);
diff --git a/drivers/gpu/drm/i915/gvt/hypercall.h b/drivers/gpu/drm/i915/gvt/hypercall.h
index 9f04757598251..61e493e2de852 100644
--- a/drivers/gpu/drm/i915/gvt/hypercall.h
+++ b/drivers/gpu/drm/i915/gvt/hypercall.h
@@ -49,10 +49,6 @@ struct intel_gvt_mpt {
 	int (*inject_msi)(struct intel_vgpu *vgpu, u32 addr, u16 data);
 	int (*enable_page_track)(struct intel_vgpu *vgpu, u64 gfn);
 	int (*disable_page_track)(struct intel_vgpu *vgpu, u64 gfn);
-	int (*read_gpa)(struct intel_vgpu *vgpu, unsigned long gpa, void *buf,
-			unsigned long len);
-	int (*write_gpa)(struct intel_vgpu *vgpu, unsigned long gpa, void *buf,
-			 unsigned long len);
 	unsigned long (*gfn_to_mfn)(struct intel_vgpu *vgpu, unsigned long gfn);
 
 	int (*dma_map_guest_page)(struct intel_vgpu *vgpu, unsigned long gfn,
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index ed010ab13310b..e4e3d0cc66fc8 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -39,7 +39,6 @@
 #include <linux/spinlock.h>
 #include <linux/eventfd.h>
 #include <linux/uuid.h>
-#include <linux/vfio.h>
 #include <linux/mdev.h>
 #include <linux/debugfs.h>
 
@@ -2024,26 +2023,6 @@ static void kvmgt_dma_unmap_guest_page(struct intel_vgpu *vgpu,
 	mutex_unlock(&vgpu->cache_lock);
 }
 
-static int kvmgt_rw_gpa(struct intel_vgpu *vgpu, unsigned long gpa,
-			void *buf, unsigned long len, bool write)
-{
-	if (!vgpu->attached)
-		return -ESRCH;
-	return vfio_dma_rw(vgpu->vfio_group, gpa, buf, len, write);
-}
-
-static int kvmgt_read_gpa(struct intel_vgpu *vgpu, unsigned long gpa,
-			void *buf, unsigned long len)
-{
-	return kvmgt_rw_gpa(vgpu, gpa, buf, len, false);
-}
-
-static int kvmgt_write_gpa(struct intel_vgpu *vgpu, unsigned long gpa,
-			void *buf, unsigned long len)
-{
-	return kvmgt_rw_gpa(vgpu, gpa, buf, len, true);
-}
-
 static bool kvmgt_is_valid_gfn(struct intel_vgpu *vgpu, unsigned long gfn)
 {
 	struct kvm *kvm = vgpu->kvm;
@@ -2067,8 +2046,6 @@ static const struct intel_gvt_mpt kvmgt_mpt = {
 	.inject_msi = kvmgt_inject_msi,
 	.enable_page_track = kvmgt_page_track_add,
 	.disable_page_track = kvmgt_page_track_remove,
-	.read_gpa = kvmgt_read_gpa,
-	.write_gpa = kvmgt_write_gpa,
 	.gfn_to_mfn = kvmgt_gfn_to_pfn,
 	.dma_map_guest_page = kvmgt_dma_map_guest_page,
 	.dma_unmap_guest_page = kvmgt_dma_unmap_guest_page,
diff --git a/drivers/gpu/drm/i915/gvt/mmio.c b/drivers/gpu/drm/i915/gvt/mmio.c
index 5db0ef83d5227..9acc00505fde1 100644
--- a/drivers/gpu/drm/i915/gvt/mmio.c
+++ b/drivers/gpu/drm/i915/gvt/mmio.c
@@ -139,7 +139,7 @@ int intel_vgpu_emulate_mmio_read(struct intel_vgpu *vgpu, u64 pa,
 	}
 
 	if (drm_WARN_ON_ONCE(&i915->drm, !reg_is_mmio(gvt, offset))) {
-		ret = intel_gvt_hypervisor_read_gpa(vgpu, pa, p_data, bytes);
+		ret = intel_gvt_read_gpa(vgpu, pa, p_data, bytes);
 		goto out;
 	}
 
@@ -215,7 +215,7 @@ int intel_vgpu_emulate_mmio_write(struct intel_vgpu *vgpu, u64 pa,
 	}
 
 	if (drm_WARN_ON_ONCE(&i915->drm, !reg_is_mmio(gvt, offset))) {
-		ret = intel_gvt_hypervisor_write_gpa(vgpu, pa, p_data, bytes);
+		ret = intel_gvt_write_gpa(vgpu, pa, p_data, bytes);
 		goto out;
 	}
 
diff --git a/drivers/gpu/drm/i915/gvt/mpt.h b/drivers/gpu/drm/i915/gvt/mpt.h
index ba0c31c4a705c..72388ceec5966 100644
--- a/drivers/gpu/drm/i915/gvt/mpt.h
+++ b/drivers/gpu/drm/i915/gvt/mpt.h
@@ -152,38 +152,6 @@ static inline int intel_gvt_hypervisor_disable_page_track(
 	return intel_gvt_host.mpt->disable_page_track(vgpu, gfn);
 }
 
-/**
- * intel_gvt_hypervisor_read_gpa - copy data from GPA to host data buffer
- * @vgpu: a vGPU
- * @gpa: guest physical address
- * @buf: host data buffer
- * @len: data length
- *
- * Returns:
- * Zero on success, negative error code if failed.
- */
-static inline int intel_gvt_hypervisor_read_gpa(struct intel_vgpu *vgpu,
-		unsigned long gpa, void *buf, unsigned long len)
-{
-	return intel_gvt_host.mpt->read_gpa(vgpu, gpa, buf, len);
-}
-
-/**
- * intel_gvt_hypervisor_write_gpa - copy data from host data buffer to GPA
- * @vgpu: a vGPU
- * @gpa: guest physical address
- * @buf: host data buffer
- * @len: data length
- *
- * Returns:
- * Zero on success, negative error code if failed.
- */
-static inline int intel_gvt_hypervisor_write_gpa(struct intel_vgpu *vgpu,
-		unsigned long gpa, void *buf, unsigned long len)
-{
-	return intel_gvt_host.mpt->write_gpa(vgpu, gpa, buf, len);
-}
-
 /**
  * intel_gvt_hypervisor_gfn_to_mfn - translate a GFN to MFN
  * @vgpu: a vGPU
diff --git a/drivers/gpu/drm/i915/gvt/opregion.c b/drivers/gpu/drm/i915/gvt/opregion.c
index 286ac6d7c6ced..d2bed466540ab 100644
--- a/drivers/gpu/drm/i915/gvt/opregion.c
+++ b/drivers/gpu/drm/i915/gvt/opregion.c
@@ -421,14 +421,14 @@ int intel_vgpu_emulate_opregion_request(struct intel_vgpu *vgpu, u32 swsci)
 				INTEL_GVT_OPREGION_SCIC;
 	parm_pa = (vgpu_opregion(vgpu)->gfn[0] << PAGE_SHIFT) +
 				INTEL_GVT_OPREGION_PARM;
-	ret = intel_gvt_hypervisor_read_gpa(vgpu, scic_pa, &scic, sizeof(scic));
+	ret = intel_gvt_read_gpa(vgpu, scic_pa, &scic, sizeof(scic));
 	if (ret) {
 		gvt_vgpu_err("guest opregion read error %d, gpa 0x%llx, len %lu\n",
 			ret, scic_pa, sizeof(scic));
 		return ret;
 	}
 
-	ret = intel_gvt_hypervisor_read_gpa(vgpu, parm_pa, &parm, sizeof(parm));
+	ret = intel_gvt_read_gpa(vgpu, parm_pa, &parm, sizeof(parm));
 	if (ret) {
 		gvt_vgpu_err("guest opregion read error %d, gpa 0x%llx, len %lu\n",
 			ret, scic_pa, sizeof(scic));
@@ -465,16 +465,14 @@ int intel_vgpu_emulate_opregion_request(struct intel_vgpu *vgpu, u32 swsci)
 	parm = 0;
 
 out:
-	ret = intel_gvt_hypervisor_write_gpa(vgpu, scic_pa, &scic,
-					     sizeof(scic));
+	ret = intel_gvt_write_gpa(vgpu, scic_pa, &scic, sizeof(scic));
 	if (ret) {
 		gvt_vgpu_err("guest opregion write error %d, gpa 0x%llx, len %lu\n",
 			ret, scic_pa, sizeof(scic));
 		return ret;
 	}
 
-	ret = intel_gvt_hypervisor_write_gpa(vgpu, parm_pa, &parm,
-					     sizeof(parm));
+	ret = intel_gvt_write_gpa(vgpu, parm_pa, &parm, sizeof(parm));
 	if (ret) {
 		gvt_vgpu_err("guest opregion write error %d, gpa 0x%llx, len %lu\n",
 			ret, scic_pa, sizeof(scic));
diff --git a/drivers/gpu/drm/i915/gvt/scheduler.c b/drivers/gpu/drm/i915/gvt/scheduler.c
index 679476da06401..d6fe94cd0fdb6 100644
--- a/drivers/gpu/drm/i915/gvt/scheduler.c
+++ b/drivers/gpu/drm/i915/gvt/scheduler.c
@@ -150,10 +150,10 @@ static int populate_shadow_context(struct intel_vgpu_workload *workload)
 
 	sr_oa_regs(workload, (u32 *)shadow_ring_context, true);
 #define COPY_REG(name) \
-	intel_gvt_hypervisor_read_gpa(vgpu, workload->ring_context_gpa \
+	intel_gvt_read_gpa(vgpu, workload->ring_context_gpa \
 		+ RING_CTX_OFF(name.val), &shadow_ring_context->name.val, 4)
 #define COPY_REG_MASKED(name) {\
-		intel_gvt_hypervisor_read_gpa(vgpu, workload->ring_context_gpa \
+		intel_gvt_read_gpa(vgpu, workload->ring_context_gpa \
 					      + RING_CTX_OFF(name.val),\
 					      &shadow_ring_context->name.val, 4);\
 		shadow_ring_context->name.val |= 0xffff << 16;\
@@ -167,7 +167,7 @@ static int populate_shadow_context(struct intel_vgpu_workload *workload)
 		COPY_REG(rcs_indirect_ctx);
 		COPY_REG(rcs_indirect_ctx_offset);
 	} else if (workload->engine->id == BCS0)
-		intel_gvt_hypervisor_read_gpa(vgpu,
+		intel_gvt_read_gpa(vgpu,
 				workload->ring_context_gpa +
 				BCS_TILE_REGISTER_VAL_OFFSET,
 				(void *)shadow_ring_context +
@@ -178,7 +178,7 @@ static int populate_shadow_context(struct intel_vgpu_workload *workload)
 	/* don't copy Ring Context (the first 0x50 dwords),
 	 * only copy the Engine Context part from guest
 	 */
-	intel_gvt_hypervisor_read_gpa(vgpu,
+	intel_gvt_read_gpa(vgpu,
 			workload->ring_context_gpa +
 			RING_CTX_SIZE,
 			(void *)shadow_ring_context +
@@ -245,7 +245,7 @@ static int populate_shadow_context(struct intel_vgpu_workload *workload)
 		continue;
 
 read:
-		intel_gvt_hypervisor_read_gpa(vgpu, gpa_base, dst, gpa_size);
+		intel_gvt_read_gpa(vgpu, gpa_base, dst, gpa_size);
 		gpa_base = context_gpa;
 		gpa_size = I915_GTT_PAGE_SIZE;
 		dst = context_base + (i << I915_GTT_PAGE_SHIFT);
@@ -911,8 +911,7 @@ static void update_guest_pdps(struct intel_vgpu *vgpu,
 	gpa = ring_context_gpa + RING_CTX_OFF(pdps[0].val);
 
 	for (i = 0; i < 8; i++)
-		intel_gvt_hypervisor_write_gpa(vgpu,
-				gpa + i * 8, &pdp[7 - i], 4);
+		intel_gvt_write_gpa(vgpu, gpa + i * 8, &pdp[7 - i], 4);
 }
 
 static __maybe_unused bool
@@ -1007,13 +1006,13 @@ static void update_guest_context(struct intel_vgpu_workload *workload)
 		continue;
 
 write:
-		intel_gvt_hypervisor_write_gpa(vgpu, gpa_base, src, gpa_size);
+		intel_gvt_write_gpa(vgpu, gpa_base, src, gpa_size);
 		gpa_base = context_gpa;
 		gpa_size = I915_GTT_PAGE_SIZE;
 		src = context_base + (i << I915_GTT_PAGE_SHIFT);
 	}
 
-	intel_gvt_hypervisor_write_gpa(vgpu, workload->ring_context_gpa +
+	intel_gvt_write_gpa(vgpu, workload->ring_context_gpa +
 		RING_CTX_OFF(ring_header.val), &workload->rb_tail, 4);
 
 	shadow_ring_context = (void *) ctx->lrc_reg_state;
@@ -1028,7 +1027,7 @@ static void update_guest_context(struct intel_vgpu_workload *workload)
 	}
 
 #define COPY_REG(name) \
-	intel_gvt_hypervisor_write_gpa(vgpu, workload->ring_context_gpa + \
+	intel_gvt_write_gpa(vgpu, workload->ring_context_gpa + \
 		RING_CTX_OFF(name.val), &shadow_ring_context->name.val, 4)
 
 	COPY_REG(ctx_ctrl);
@@ -1036,7 +1035,7 @@ static void update_guest_context(struct intel_vgpu_workload *workload)
 
 #undef COPY_REG
 
-	intel_gvt_hypervisor_write_gpa(vgpu,
+	intel_gvt_write_gpa(vgpu,
 			workload->ring_context_gpa +
 			sizeof(*shadow_ring_context),
 			(void *)shadow_ring_context +
@@ -1573,7 +1572,7 @@ static void read_guest_pdps(struct intel_vgpu *vgpu,
 	gpa = ring_context_gpa + RING_CTX_OFF(pdps[0].val);
 
 	for (i = 0; i < 8; i++)
-		intel_gvt_hypervisor_read_gpa(vgpu,
+		intel_gvt_read_gpa(vgpu,
 				gpa + i * 8, &pdp[7 - i], 4);
 }
 
@@ -1644,10 +1643,10 @@ intel_vgpu_create_workload(struct intel_vgpu *vgpu,
 		return ERR_PTR(-EINVAL);
 	}
 
-	intel_gvt_hypervisor_read_gpa(vgpu, ring_context_gpa +
+	intel_gvt_read_gpa(vgpu, ring_context_gpa +
 			RING_CTX_OFF(ring_header.val), &head, 4);
 
-	intel_gvt_hypervisor_read_gpa(vgpu, ring_context_gpa +
+	intel_gvt_read_gpa(vgpu, ring_context_gpa +
 			RING_CTX_OFF(ring_tail.val), &tail, 4);
 
 	guest_head = head;
@@ -1674,11 +1673,11 @@ intel_vgpu_create_workload(struct intel_vgpu *vgpu,
 	gvt_dbg_el("ring %s begin a new workload\n", engine->name);
 
 	/* record some ring buffer register values for scan and shadow */
-	intel_gvt_hypervisor_read_gpa(vgpu, ring_context_gpa +
+	intel_gvt_read_gpa(vgpu, ring_context_gpa +
 			RING_CTX_OFF(rb_start.val), &start, 4);
-	intel_gvt_hypervisor_read_gpa(vgpu, ring_context_gpa +
+	intel_gvt_read_gpa(vgpu, ring_context_gpa +
 			RING_CTX_OFF(rb_ctrl.val), &ctl, 4);
-	intel_gvt_hypervisor_read_gpa(vgpu, ring_context_gpa +
+	intel_gvt_read_gpa(vgpu, ring_context_gpa +
 			RING_CTX_OFF(ctx_ctrl.val), &ctx_ctl, 4);
 
 	if (!intel_gvt_ggtt_validate_range(vgpu, start,
@@ -1701,9 +1700,9 @@ intel_vgpu_create_workload(struct intel_vgpu *vgpu,
 	workload->rb_ctl = ctl;
 
 	if (engine->id == RCS0) {
-		intel_gvt_hypervisor_read_gpa(vgpu, ring_context_gpa +
+		intel_gvt_read_gpa(vgpu, ring_context_gpa +
 			RING_CTX_OFF(bb_per_ctx_ptr.val), &per_ctx, 4);
-		intel_gvt_hypervisor_read_gpa(vgpu, ring_context_gpa +
+		intel_gvt_read_gpa(vgpu, ring_context_gpa +
 			RING_CTX_OFF(rcs_indirect_ctx.val), &indirect_ctx, 4);
 
 		workload->wa_ctx.indirect_ctx.guest_gma =
-- 
2.30.2

