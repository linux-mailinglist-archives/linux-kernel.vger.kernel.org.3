Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96CE74FBECE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347120AbiDKOS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347336AbiDKORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:17:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E5F13E33
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=9sITjOZAVzZWKo/UOhPmxzW2/FNakovicgU8qOqzKnI=; b=tKiEUiYPFl7De0jxeHXdbq99Cq
        IxHqAOS5gq/GlCjn1Yf/gVH5qEqtR0YOKkbPUwPxDDVZ0mCNxdaHbbayS9o+kmHePL8dq4ud9oUkk
        7GyRI/X6iX2Z6gjUeSdXVK6kxTJtLbCrXrhOiVp5SiIqJnxbuUoKHfV8UoteexeVzONJJMNa282Qf
        VY30xN8tQ2lUl69y5fcHZP6+U51ijF+fhRIYZ8XN2BQ2ru0scl1uDXErI6fBFTANjuS7Ty83YtXUO
        FG7NTO995sPmXVbHuky5FnjHkULtFKCtHIhAfSzmKbW9P1+l7vdGOhXBqUgEn+uIcJbJraKMTrv6F
        cguwOJDg==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndup0-009Kp1-3x; Mon, 11 Apr 2022 14:15:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 22/34] drm/i915/gvt: devirtualize dma_pin_guest_page
Date:   Mon, 11 Apr 2022 16:13:51 +0200
Message-Id: <20220411141403.86980-23-hch@lst.de>
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

Just call the function directly and remove a pointless wrapper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/dmabuf.c    | 14 +-------------
 drivers/gpu/drm/i915/gvt/gvt.h       |  1 +
 drivers/gpu/drm/i915/gvt/hypercall.h |  2 --
 drivers/gpu/drm/i915/gvt/kvmgt.c     |  4 +---
 drivers/gpu/drm/i915/gvt/mpt.h       | 15 ---------------
 5 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.c b/drivers/gpu/drm/i915/gvt/dmabuf.c
index db93b63543276..90443306a9ad4 100644
--- a/drivers/gpu/drm/i915/gvt/dmabuf.c
+++ b/drivers/gpu/drm/i915/gvt/dmabuf.c
@@ -42,18 +42,6 @@
 
 #define GEN8_DECODE_PTE(pte) (pte & GENMASK_ULL(63, 12))
 
-static int vgpu_pin_dma_address(struct intel_vgpu *vgpu,
-				unsigned long size,
-				dma_addr_t dma_addr)
-{
-	int ret = 0;
-
-	if (intel_gvt_hypervisor_dma_pin_guest_page(vgpu, dma_addr))
-		ret = -EINVAL;
-
-	return ret;
-}
-
 static int vgpu_gem_get_pages(
 		struct drm_i915_gem_object *obj)
 {
@@ -89,7 +77,7 @@ static int vgpu_gem_get_pages(
 	for_each_sg(st->sgl, sg, page_num, i) {
 		dma_addr_t dma_addr =
 			GEN8_DECODE_PTE(readq(&gtt_entries[i]));
-		if (vgpu_pin_dma_address(vgpu, PAGE_SIZE, dma_addr)) {
+		if (intel_gvt_dma_pin_guest_page(vgpu, dma_addr)) {
 			ret = -EINVAL;
 			goto out;
 		}
diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index 4e42e6ac40772..938f572717377 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -767,6 +767,7 @@ void intel_gvt_debugfs_clean(struct intel_gvt *gvt);
 
 int intel_gvt_page_track_add(struct intel_vgpu *info, u64 gfn);
 int intel_gvt_page_track_remove(struct intel_vgpu *info, u64 gfn);
+int intel_gvt_dma_pin_guest_page(struct intel_vgpu *vgpu, dma_addr_t dma_addr);
 int intel_gvt_dma_map_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
 		unsigned long size, dma_addr_t *dma_addr);
 void intel_gvt_dma_unmap_guest_page(struct intel_vgpu *vgpu,
diff --git a/drivers/gpu/drm/i915/gvt/hypercall.h b/drivers/gpu/drm/i915/gvt/hypercall.h
index ba03b3368a955..d49437aeabac8 100644
--- a/drivers/gpu/drm/i915/gvt/hypercall.h
+++ b/drivers/gpu/drm/i915/gvt/hypercall.h
@@ -45,8 +45,6 @@ struct intel_vgpu;
 struct intel_gvt_mpt {
 	int (*host_init)(struct device *dev, void *gvt);
 	void (*host_exit)(struct device *dev, void *gvt);
-
-	int (*dma_pin_guest_page)(struct intel_vgpu *vgpu, dma_addr_t dma_addr);
 };
 
 #endif /* _GVT_HYPERCALL_H_ */
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index a02274036487f..606b2cb923d8e 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1921,8 +1921,7 @@ int intel_gvt_dma_map_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
 	return ret;
 }
 
-static int kvmgt_dma_pin_guest_page(struct intel_vgpu *vgpu,
-		dma_addr_t dma_addr)
+int intel_gvt_dma_pin_guest_page(struct intel_vgpu *vgpu, dma_addr_t dma_addr)
 {
 	struct gvt_dma *entry;
 	int ret = 0;
@@ -1968,7 +1967,6 @@ void intel_gvt_dma_unmap_guest_page(struct intel_vgpu *vgpu,
 static const struct intel_gvt_mpt kvmgt_mpt = {
 	.host_init = kvmgt_host_init,
 	.host_exit = kvmgt_host_exit,
-	.dma_pin_guest_page = kvmgt_dma_pin_guest_page,
 };
 
 struct intel_gvt_host intel_gvt_host = {
diff --git a/drivers/gpu/drm/i915/gvt/mpt.h b/drivers/gpu/drm/i915/gvt/mpt.h
index 26c1ee690f7e9..3be602a3f764a 100644
--- a/drivers/gpu/drm/i915/gvt/mpt.h
+++ b/drivers/gpu/drm/i915/gvt/mpt.h
@@ -71,19 +71,4 @@ static inline void intel_gvt_hypervisor_host_exit(struct device *dev, void *gvt)
 	intel_gvt_host.mpt->host_exit(dev, gvt);
 }
 
-/**
- * intel_gvt_hypervisor_dma_pin_guest_page - pin guest dma buf
- * @vgpu: a vGPU
- * @dma_addr: guest dma addr
- *
- * Returns:
- * 0 on success, negative error code if failed.
- */
-static inline int
-intel_gvt_hypervisor_dma_pin_guest_page(struct intel_vgpu *vgpu,
-					dma_addr_t dma_addr)
-{
-	return intel_gvt_host.mpt->dma_pin_guest_page(vgpu, dma_addr);
-}
-
 #endif /* _GVT_MPT_H_ */
-- 
2.30.2

