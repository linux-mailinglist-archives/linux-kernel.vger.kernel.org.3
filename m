Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5054FBEDB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344351AbiDKOUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347162AbiDKOR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:17:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1DC1402A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Kv6GNbS30/pIlnLK0Y1uVYsIcMB4S+TS81GFGBhjP44=; b=LzJkzIH0M4GyQzUoBoVON25m+H
        tf1lqlitVu2zF8wrWENfbhP+GlRUuK5SW/pkS/eoUrr3AS3q4Q7MSnbcKm3hkfNgEwTt7WSknIz8a
        o69+Eu1M6BdNWoKOf8VkA/IOn+KNgW7KrodStQBALaFagP5tEedXB3vwES1A1wdNEr7fHUmvxnKT5
        TSUqBQuKwicqWwMk/u4ncg0M8Jf0vHZTKmHmmA3Aee5+OqDUqBK3LPxktX/KrVK/FulfIHm/GQpWp
        XhEvGbI6yDlTJUXiQuhfhv5phEfsWDwSMTVgBdWRiXckDtKLyWnjErfDehVz18tUi73iyVbHZVjh1
        Bs3S/cHQ==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nduoi-009KeN-Ee; Mon, 11 Apr 2022 14:14:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/34] drm/i915/gvt: devirtualize ->detach_vgpu
Date:   Mon, 11 Apr 2022 16:13:45 +0200
Message-Id: <20220411141403.86980-17-hch@lst.de>
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

Just call the function directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/gvt.h       |  1 +
 drivers/gpu/drm/i915/gvt/hypercall.h |  1 -
 drivers/gpu/drm/i915/gvt/kvmgt.c     |  3 +--
 drivers/gpu/drm/i915/gvt/mpt.h       | 16 ----------------
 drivers/gpu/drm/i915/gvt/vgpu.c      |  2 +-
 5 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index d389c9c3822bc..52ef88d2bf21a 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -581,6 +581,7 @@ void populate_pvinfo_page(struct intel_vgpu *vgpu);
 
 int intel_gvt_scan_and_shadow_workload(struct intel_vgpu_workload *workload);
 void enter_failsafe_mode(struct intel_vgpu *vgpu, int reason);
+void intel_vgpu_detach_regions(struct intel_vgpu *vgpu);
 
 enum {
 	GVT_FAILSAFE_UNSUPPORTED_GUEST,
diff --git a/drivers/gpu/drm/i915/gvt/hypercall.h b/drivers/gpu/drm/i915/gvt/hypercall.h
index 091249a924a85..08c622c4079bb 100644
--- a/drivers/gpu/drm/i915/gvt/hypercall.h
+++ b/drivers/gpu/drm/i915/gvt/hypercall.h
@@ -45,7 +45,6 @@ struct intel_vgpu;
 struct intel_gvt_mpt {
 	int (*host_init)(struct device *dev, void *gvt);
 	void (*host_exit)(struct device *dev, void *gvt);
-	void (*detach_vgpu)(struct intel_vgpu *vgpu);
 	int (*inject_msi)(struct intel_vgpu *vgpu, u32 addr, u16 data);
 	int (*enable_page_track)(struct intel_vgpu *vgpu, u64 gfn);
 	int (*disable_page_track)(struct intel_vgpu *vgpu, u64 gfn);
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 006db16c7d036..4a6fed80c629a 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1858,7 +1858,7 @@ static bool kvmgt_guest_exit(struct intel_vgpu *info)
 	return true;
 }
 
-static void kvmgt_detach_vgpu(struct intel_vgpu *vgpu)
+void intel_vgpu_detach_regions(struct intel_vgpu *vgpu)
 {
 	int i;
 
@@ -2022,7 +2022,6 @@ static bool kvmgt_is_valid_gfn(struct intel_vgpu *vgpu, unsigned long gfn)
 static const struct intel_gvt_mpt kvmgt_mpt = {
 	.host_init = kvmgt_host_init,
 	.host_exit = kvmgt_host_exit,
-	.detach_vgpu = kvmgt_detach_vgpu,
 	.inject_msi = kvmgt_inject_msi,
 	.enable_page_track = kvmgt_page_track_add,
 	.disable_page_track = kvmgt_page_track_remove,
diff --git a/drivers/gpu/drm/i915/gvt/mpt.h b/drivers/gpu/drm/i915/gvt/mpt.h
index 9738aa3377b4b..78efcf1e69469 100644
--- a/drivers/gpu/drm/i915/gvt/mpt.h
+++ b/drivers/gpu/drm/i915/gvt/mpt.h
@@ -71,22 +71,6 @@ static inline void intel_gvt_hypervisor_host_exit(struct device *dev, void *gvt)
 	intel_gvt_host.mpt->host_exit(dev, gvt);
 }
 
-/**
- * intel_gvt_hypervisor_detach_vgpu - call hypervisor to release vGPU
- * related stuffs inside hypervisor.
- *
- * Returns:
- * Zero on success, negative error code if failed.
- */
-static inline void intel_gvt_hypervisor_detach_vgpu(struct intel_vgpu *vgpu)
-{
-	/* optional to provide */
-	if (!intel_gvt_host.mpt->detach_vgpu)
-		return;
-
-	intel_gvt_host.mpt->detach_vgpu(vgpu);
-}
-
 #define MSI_CAP_CONTROL(offset) (offset + 2)
 #define MSI_CAP_ADDRESS(offset) (offset + 4)
 #define MSI_CAP_DATA(offset) (offset + 8)
diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
index 69c1af3d67043..46da19b3225d2 100644
--- a/drivers/gpu/drm/i915/gvt/vgpu.c
+++ b/drivers/gpu/drm/i915/gvt/vgpu.c
@@ -293,7 +293,7 @@ void intel_gvt_destroy_vgpu(struct intel_vgpu *vgpu)
 	intel_vgpu_clean_opregion(vgpu);
 	intel_vgpu_reset_ggtt(vgpu, true);
 	intel_vgpu_clean_gtt(vgpu);
-	intel_gvt_hypervisor_detach_vgpu(vgpu);
+	intel_vgpu_detach_regions(vgpu);
 	intel_vgpu_free_resource(vgpu);
 	intel_vgpu_clean_mmio(vgpu);
 	intel_vgpu_dmabuf_cleanup(vgpu);
-- 
2.30.2

