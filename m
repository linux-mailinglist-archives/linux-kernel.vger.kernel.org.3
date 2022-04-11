Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E14C4FBECB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347069AbiDKOS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347122AbiDKOR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:17:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE8513E3E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=35IBAUnex6kXDSHlwi8o9RppFKkvZlsNITZ27ystrBo=; b=yJlEP5IoESb36TsLC4Q/y56fR5
        gbeSQg5PoKCwM5ZTfRgV+m79Q1sfhBuq8kzuHGU0sq5SF5H32t+yH8xtK2/ZkjT9wrDOn7dVQ0MLM
        1IrHgvxyrIvnDj0kFW3BVMQShleQ4DhBF5ge0pQEttyhFNqwbL1qgQHO29Oz7i5VyNDRwgiABUQ5Z
        Upt2uFDI3B4/RPBJgkdQlePvHFT9WO787xIAaN2Q4eerakSBb+sgjwSeU1RhmzVe9XJQzhvyGjRX8
        g/24lMI+dezQonFZhIIFHtE+o+oys8u6tU3q+dbwGUvSD8tP3ICxA2dKGe9Nobn3jCxEl6QYF9SmM
        EPWv0K4w==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nduoc-009KZn-I9; Mon, 11 Apr 2022 14:14:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/34] drm/i915/gvt: devirtualize ->{get,put}_vfio_device
Date:   Mon, 11 Apr 2022 16:13:43 +0200
Message-Id: <20220411141403.86980-15-hch@lst.de>
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

Just open code the calls to the VFIO APIs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/dmabuf.c    | 12 ++++++-----
 drivers/gpu/drm/i915/gvt/hypercall.h |  2 --
 drivers/gpu/drm/i915/gvt/kvmgt.c     | 22 --------------------
 drivers/gpu/drm/i915/gvt/mpt.h       | 30 ----------------------------
 4 files changed, 7 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.c b/drivers/gpu/drm/i915/gvt/dmabuf.c
index c95c25d2addbc..cc1a9ac0d2720 100644
--- a/drivers/gpu/drm/i915/gvt/dmabuf.c
+++ b/drivers/gpu/drm/i915/gvt/dmabuf.c
@@ -29,7 +29,7 @@
  */
 
 #include <linux/dma-buf.h>
-#include <linux/vfio.h>
+#include <linux/mdev.h>
 
 #include <drm/drm_fourcc.h>
 #include <drm/drm_plane.h>
@@ -157,7 +157,7 @@ static void dmabuf_gem_object_free(struct kref *kref)
 			dmabuf_obj = list_entry(pos, struct intel_vgpu_dmabuf_obj, list);
 			if (dmabuf_obj == obj) {
 				list_del(pos);
-				intel_gvt_hypervisor_put_vfio_device(vgpu);
+				vfio_device_put(vgpu->vfio_device);
 				idr_remove(&vgpu->object_idr,
 					   dmabuf_obj->dmabuf_id);
 				kfree(dmabuf_obj->info);
@@ -492,9 +492,11 @@ int intel_vgpu_query_plane(struct intel_vgpu *vgpu, void *args)
 	kref_init(&dmabuf_obj->kref);
 
 	mutex_lock(&vgpu->dmabuf_lock);
-	if (intel_gvt_hypervisor_get_vfio_device(vgpu)) {
-		gvt_vgpu_err("get vfio device failed\n");
+	vgpu->vfio_device = vfio_device_get_from_dev(mdev_dev(vgpu->mdev));
+	if (!vgpu->vfio_device) {
+		gvt_vgpu_err("failed to get vfio device\n");
 		mutex_unlock(&vgpu->dmabuf_lock);
+		ret = -ENODEV;
 		goto out_free_info;
 	}
 	mutex_unlock(&vgpu->dmabuf_lock);
@@ -603,7 +605,7 @@ void intel_vgpu_dmabuf_cleanup(struct intel_vgpu *vgpu)
 		dmabuf_obj->vgpu = NULL;
 
 		idr_remove(&vgpu->object_idr, dmabuf_obj->dmabuf_id);
-		intel_gvt_hypervisor_put_vfio_device(vgpu);
+		vfio_device_put(vgpu->vfio_device);
 		list_del(pos);
 
 		/* dmabuf_obj might be freed in dmabuf_obj_put */
diff --git a/drivers/gpu/drm/i915/gvt/hypercall.h b/drivers/gpu/drm/i915/gvt/hypercall.h
index 61e493e2de852..fd903d52f4314 100644
--- a/drivers/gpu/drm/i915/gvt/hypercall.h
+++ b/drivers/gpu/drm/i915/gvt/hypercall.h
@@ -60,8 +60,6 @@ struct intel_gvt_mpt {
 
 	int (*set_opregion)(struct intel_vgpu *vgpu);
 	int (*set_edid)(struct intel_vgpu *vgpu, int port_num);
-	int (*get_vfio_device)(struct intel_vgpu *vgpu);
-	void (*put_vfio_device)(struct intel_vgpu *vgpu);
 	bool (*is_valid_gfn)(struct intel_vgpu *vgpu, unsigned long gfn);
 };
 
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index e4e3d0cc66fc8..1f70cbd51a3fa 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -662,18 +662,6 @@ static int intel_vgpu_register_reg(struct intel_vgpu *vgpu,
 	return 0;
 }
 
-static int kvmgt_get_vfio_device(struct intel_vgpu *vgpu)
-{
-	vgpu->vfio_device = vfio_device_get_from_dev(
-		mdev_dev(vgpu->mdev));
-	if (!vgpu->vfio_device) {
-		gvt_vgpu_err("failed to get vfio device\n");
-		return -ENODEV;
-	}
-	return 0;
-}
-
-
 static int kvmgt_set_opregion(struct intel_vgpu *vgpu)
 {
 	void *base;
@@ -730,14 +718,6 @@ static int kvmgt_set_edid(struct intel_vgpu *vgpu, int port_num)
 	return ret;
 }
 
-static void kvmgt_put_vfio_device(struct intel_vgpu *vgpu)
-{
-	if (WARN_ON(!vgpu->vfio_device))
-		return;
-
-	vfio_device_put(vgpu->vfio_device);
-}
-
 static int intel_vgpu_create(struct mdev_device *mdev)
 {
 	struct intel_vgpu *vgpu = NULL;
@@ -2052,8 +2032,6 @@ static const struct intel_gvt_mpt kvmgt_mpt = {
 	.dma_pin_guest_page = kvmgt_dma_pin_guest_page,
 	.set_opregion = kvmgt_set_opregion,
 	.set_edid = kvmgt_set_edid,
-	.get_vfio_device = kvmgt_get_vfio_device,
-	.put_vfio_device = kvmgt_put_vfio_device,
 	.is_valid_gfn = kvmgt_is_valid_gfn,
 };
 
diff --git a/drivers/gpu/drm/i915/gvt/mpt.h b/drivers/gpu/drm/i915/gvt/mpt.h
index 72388ceec5966..2196187203af1 100644
--- a/drivers/gpu/drm/i915/gvt/mpt.h
+++ b/drivers/gpu/drm/i915/gvt/mpt.h
@@ -242,36 +242,6 @@ static inline int intel_gvt_hypervisor_set_edid(struct intel_vgpu *vgpu,
 	return intel_gvt_host.mpt->set_edid(vgpu, port_num);
 }
 
-/**
- * intel_gvt_hypervisor_get_vfio_device - increase vfio device ref count
- * @vgpu: a vGPU
- *
- * Returns:
- * Zero on success, negative error code if failed.
- */
-static inline int intel_gvt_hypervisor_get_vfio_device(struct intel_vgpu *vgpu)
-{
-	if (!intel_gvt_host.mpt->get_vfio_device)
-		return 0;
-
-	return intel_gvt_host.mpt->get_vfio_device(vgpu);
-}
-
-/**
- * intel_gvt_hypervisor_put_vfio_device - decrease vfio device ref count
- * @vgpu: a vGPU
- *
- * Returns:
- * Zero on success, negative error code if failed.
- */
-static inline void intel_gvt_hypervisor_put_vfio_device(struct intel_vgpu *vgpu)
-{
-	if (!intel_gvt_host.mpt->put_vfio_device)
-		return;
-
-	intel_gvt_host.mpt->put_vfio_device(vgpu);
-}
-
 /**
  * intel_gvt_hypervisor_is_valid_gfn - check if a visible gfn
  * @vgpu: a vGPU
-- 
2.30.2

