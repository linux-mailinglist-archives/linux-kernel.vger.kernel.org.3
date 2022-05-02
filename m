Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE2E516996
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 05:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357023AbiEBDfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 23:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiEBDfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 23:35:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C6364E5
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 20:32:06 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ks7tT4rXtzhYC2;
        Mon,  2 May 2022 11:31:45 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 2 May 2022 11:32:04 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 2 May 2022 11:32:03 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] drm/i915: use IOMEM_ERR_PTR() directly
Date:   Mon, 2 May 2022 11:43:28 +0800
Message-ID: <20220502034328.78486-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use IOMEM_ERR_PTR() instead of self defined IO_ERR_PTR().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/gpu/drm/i915/i915_vma.c | 4 ++--
 drivers/gpu/drm/i915/i915_vma.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
index 94fcdb7bd21d..639605c89b7b 100644
--- a/drivers/gpu/drm/i915/i915_vma.c
+++ b/drivers/gpu/drm/i915/i915_vma.c
@@ -541,7 +541,7 @@ void __iomem *i915_vma_pin_iomap(struct i915_vma *vma)
 	int err;
 
 	if (WARN_ON_ONCE(vma->obj->flags & I915_BO_ALLOC_GPU_ONLY))
-		return IO_ERR_PTR(-EINVAL);
+		return IOMEM_ERR_PTR(-EINVAL);
 
 	if (!i915_gem_object_is_lmem(vma->obj)) {
 		if (GEM_WARN_ON(!i915_vma_is_map_and_fenceable(vma))) {
@@ -594,7 +594,7 @@ void __iomem *i915_vma_pin_iomap(struct i915_vma *vma)
 err_unpin:
 	__i915_vma_unpin(vma);
 err:
-	return IO_ERR_PTR(err);
+	return IOMEM_ERR_PTR(err);
 }
 
 void i915_vma_flush_writes(struct i915_vma *vma)
diff --git a/drivers/gpu/drm/i915/i915_vma.h b/drivers/gpu/drm/i915/i915_vma.h
index 67ae7341c7e0..8e74972fdca3 100644
--- a/drivers/gpu/drm/i915/i915_vma.h
+++ b/drivers/gpu/drm/i915/i915_vma.h
@@ -331,7 +331,6 @@ static inline bool i915_node_color_differs(const struct drm_mm_node *node,
  * Returns a valid iomapped pointer or ERR_PTR.
  */
 void __iomem *i915_vma_pin_iomap(struct i915_vma *vma);
-#define IO_ERR_PTR(x) ((void __iomem *)ERR_PTR(x))
 
 /**
  * i915_vma_unpin_iomap - unpins the mapping returned from i915_vma_iomap
-- 
2.35.3

