Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98494FBEC2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 16:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347057AbiDKORT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 10:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347079AbiDKORB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 10:17:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E0313E88
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 07:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zk2JcYuzSoUUJtzlalPF3LdlCCzgz8L6zByOy1v9jos=; b=JJNfo/vbA27uN+qV66soBKsCtj
        a9FtpKP1Z5hxieWuUTsfq8CHl7W7jDj5ezaMgLgr4cuE3K1ipUGUyBkWMoyYRzL3OKUJr+qnnmcQq
        wJu4sYDBqAx6x+8sEoZPM22/3M8kmtdRh56FW+CwsWNS4Ws7BpOTy8hANarVl7U8NFa1jKAeI1Hwd
        L4OVCoYO3k1HBK5VDcED1q4JmACjL+5BMpqKOrGJIbqC8nW5ArN5eTpOhS9cVzWeVroh7cB/9mFHh
        wDtA25KHL94KJLSvnp/QytmBS498h+NEwxdFLsp0Ijo5n59yHDf5AciyYwWRihVq2afLKaBQH0bIk
        RTlXYXFQ==;
Received: from [2001:4bb8:18e:76f5:3747:ef85:d03d:53e4] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nduoN-009KS2-Gj; Mon, 11 Apr 2022 14:14:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/34] drm/i915/gvt: remove the unused from_virt_to_mfn op
Date:   Mon, 11 Apr 2022 16:13:38 +0200
Message-Id: <20220411141403.86980-10-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/i915/gvt/hypercall.h |  1 -
 drivers/gpu/drm/i915/gvt/kvmgt.c     |  6 ------
 drivers/gpu/drm/i915/gvt/mpt.h       | 12 ------------
 3 files changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/hypercall.h b/drivers/gpu/drm/i915/gvt/hypercall.h
index f1a4926f6f1be..27890a5e2d828 100644
--- a/drivers/gpu/drm/i915/gvt/hypercall.h
+++ b/drivers/gpu/drm/i915/gvt/hypercall.h
@@ -47,7 +47,6 @@ struct intel_gvt_mpt {
 	int (*attach_vgpu)(void *vgpu, unsigned long *handle);
 	void (*detach_vgpu)(void *vgpu);
 	int (*inject_msi)(unsigned long handle, u32 addr, u16 data);
-	unsigned long (*from_virt_to_mfn)(void *p);
 	int (*enable_page_track)(unsigned long handle, u64 gfn);
 	int (*disable_page_track)(unsigned long handle, u64 gfn);
 	int (*read_gpa)(unsigned long handle, unsigned long gpa, void *buf,
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 9ed13c86d4765..f7b8ce87bc330 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -2192,11 +2192,6 @@ static int kvmgt_write_gpa(unsigned long handle, unsigned long gpa,
 	return kvmgt_rw_gpa(handle, gpa, buf, len, true);
 }
 
-static unsigned long kvmgt_virt_to_pfn(void *addr)
-{
-	return PFN_DOWN(__pa(addr));
-}
-
 static bool kvmgt_is_valid_gfn(unsigned long handle, unsigned long gfn)
 {
 	struct kvmgt_guest_info *info;
@@ -2223,7 +2218,6 @@ static const struct intel_gvt_mpt kvmgt_mpt = {
 	.attach_vgpu = kvmgt_attach_vgpu,
 	.detach_vgpu = kvmgt_detach_vgpu,
 	.inject_msi = kvmgt_inject_msi,
-	.from_virt_to_mfn = kvmgt_virt_to_pfn,
 	.enable_page_track = kvmgt_page_track_add,
 	.disable_page_track = kvmgt_page_track_remove,
 	.read_gpa = kvmgt_read_gpa,
diff --git a/drivers/gpu/drm/i915/gvt/mpt.h b/drivers/gpu/drm/i915/gvt/mpt.h
index bb0e9e71d13e2..6d062cf71de92 100644
--- a/drivers/gpu/drm/i915/gvt/mpt.h
+++ b/drivers/gpu/drm/i915/gvt/mpt.h
@@ -140,18 +140,6 @@ static inline int intel_gvt_hypervisor_inject_msi(struct intel_vgpu *vgpu)
 	return 0;
 }
 
-/**
- * intel_gvt_hypervisor_set_wp_page - translate a host VA into MFN
- * @p: host kernel virtual address
- *
- * Returns:
- * MFN on success, INTEL_GVT_INVALID_ADDR if failed.
- */
-static inline unsigned long intel_gvt_hypervisor_virt_to_mfn(void *p)
-{
-	return intel_gvt_host.mpt->from_virt_to_mfn(p);
-}
-
 /**
  * intel_gvt_hypervisor_enable_page_track - track a guest page
  * @vgpu: a vGPU
-- 
2.30.2

