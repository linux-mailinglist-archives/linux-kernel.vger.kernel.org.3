Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F68E4FBED5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347158AbiDKOTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347360AbiDKORr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:17:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1F513F5F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hqtGJWFU5UxJXTWiuv/FMcNVyUUv+JnqKyxlKX1n9BM=; b=pMtIWHOM5eXHf4PtHumQh0LlZo
        T9uf89kNIbGhHGnexNokhRRInSC7tfRLHE0FACINgwbqC4B636XCBWRwOdL27qHUIW8sI9zkjCtqk
        juc68yIkEEz2sQDwxQO+15rrsa4TRnDTCZPbxhm+3HELR41NXHatWk6J//nQ2In2mJipRImddhZ5G
        uLTPGOuFrD/Kvbazqc7DcMYvcgOl5JONv1zkE74nRL1nYRTMXK6SxgCTHt9BKnOjA+w503p+A+ol0
        Ya2YlA4I5fN0KvIGSN55uckItuJ3gKCX/NYpvmKFF1DSSo5XdaU14ZIeU6B5dpNWGXs2DAussFyCq
        nF+5r4rg==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndup6-009Ks8-4y; Mon, 11 Apr 2022 14:15:20 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/34] drm/i915/gvt: remove the extra vfio_device refcounting for dmabufs
Date:   Mon, 11 Apr 2022 16:13:53 +0200
Message-Id: <20220411141403.86980-25-hch@lst.de>
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

All the dmabufs are torn down when th VGPU is released, so there is
no need for extra refcounting here.

Based on an patch from Jason Gunthorpe.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/dmabuf.c | 12 ------------
 drivers/gpu/drm/i915/gvt/gvt.h    |  1 -
 2 files changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.c b/drivers/gpu/drm/i915/gvt/dmabuf.c
index 90443306a9ad4..01e54b45c5c1b 100644
--- a/drivers/gpu/drm/i915/gvt/dmabuf.c
+++ b/drivers/gpu/drm/i915/gvt/dmabuf.c
@@ -139,7 +139,6 @@ static void dmabuf_gem_object_free(struct kref *kref)
 			dmabuf_obj = list_entry(pos, struct intel_vgpu_dmabuf_obj, list);
 			if (dmabuf_obj == obj) {
 				list_del(pos);
-				vfio_device_put(vgpu->vfio_device);
 				idr_remove(&vgpu->object_idr,
 					   dmabuf_obj->dmabuf_id);
 				kfree(dmabuf_obj->info);
@@ -473,16 +472,6 @@ int intel_vgpu_query_plane(struct intel_vgpu *vgpu, void *args)
 
 	kref_init(&dmabuf_obj->kref);
 
-	mutex_lock(&vgpu->dmabuf_lock);
-	vgpu->vfio_device = vfio_device_get_from_dev(mdev_dev(vgpu->mdev));
-	if (!vgpu->vfio_device) {
-		gvt_vgpu_err("failed to get vfio device\n");
-		mutex_unlock(&vgpu->dmabuf_lock);
-		ret = -ENODEV;
-		goto out_free_info;
-	}
-	mutex_unlock(&vgpu->dmabuf_lock);
-
 	update_fb_info(gfx_plane_info, &fb_info);
 
 	INIT_LIST_HEAD(&dmabuf_obj->list);
@@ -587,7 +576,6 @@ void intel_vgpu_dmabuf_cleanup(struct intel_vgpu *vgpu)
 		dmabuf_obj->vgpu = NULL;
 
 		idr_remove(&vgpu->object_idr, dmabuf_obj->dmabuf_id);
-		vfio_device_put(vgpu->vfio_device);
 		list_del(pos);
 
 		/* dmabuf_obj might be freed in dmabuf_obj_put */
diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index 865997c5005d5..8565189e0c0dd 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -231,7 +231,6 @@ struct intel_vgpu {
 	struct kvm *kvm;
 	struct work_struct release_work;
 	atomic_t released;
-	struct vfio_device *vfio_device;
 	struct vfio_group *vfio_group;
 
 	struct kvm_page_track_notifier_node track_node;
-- 
2.30.2

