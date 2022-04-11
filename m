Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247B84FC517
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349642AbiDKT2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349610AbiDKT1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:27:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4C513FB8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:25:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id 988FC1F43CCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649705109;
        bh=W1xeNHFFi2xCQW+DSKNFK1fRoffazm4NeTwtpFvqJkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BFtT30iW5ymMNLq/TNKy5KNfzD9fzG1lMnaxtGE2bW5d4Nr0FDQ2nGI1OhQFwfJbv
         /x0lhwaH3NBICgOTh2zA3TsMg08rLth+EBMeVNgJ7oAdk/wmJLLWRvt/M1CEuBqoAR
         2UoZbf91jGAZ9uqhEhEjTNsW/pNCyOQh9nKlFebY+4svlMD/HvLhAbLyk3zSNuyCwn
         vIc1LTpx6I0G/AkEgMSGXOOUYXMYZ8VBwo5NIfYn1K3V20aGgqXNMML1Yq0B7yVkZB
         QsyuaUaQFd9kXIL/0bGQ9tJ+XmTGDvrehIuMz7gPhf9oB2T+2UU2hn7ZIB0GVW2NVk
         FESl26IrBl69g==
From:   Robert Beckett <bob.beckett@collabora.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Robert Beckett <bob.beckett@collabora.com>,
        Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] drm/i915: ttm move/clear logic fix
Date:   Mon, 11 Apr 2022 19:24:51 +0000
Message-Id: <20220411192453.1000147-4-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411192453.1000147-1-bob.beckett@collabora.com>
References: <20220411192453.1000147-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ttm managed buffers start off with system resource definitions and ttm_tt
tracking structures allocated (though unpopulated).
currently this prevents clearing of buffers on first move to desired
placements.

The desired behaviour is to clear user allocated buffers and any kernel
buffers that specifically requests it only.
Make the logic match the desired behaviour.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c | 22 +++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
index 9fe8132de3b2..9cf85f91edb5 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
@@ -3,6 +3,7 @@
  * Copyright © 2021 Intel Corporation
  */
 
+#include "drm/ttm/ttm_tt.h"
 #include <drm/ttm/ttm_bo_driver.h>
 
 #include "i915_deps.h"
@@ -470,6 +471,25 @@ __i915_ttm_move(struct ttm_buffer_object *bo,
 	return fence;
 }
 
+static bool
+allow_clear(struct drm_i915_gem_object *obj, struct ttm_tt *ttm, struct ttm_resource *dst_mem)
+{
+	/* never clear stolen */
+	if (dst_mem->mem_type == I915_PL_STOLEN)
+		return false;
+	/*
+	 * we want to clear user buffers and any kernel buffers
+	 * that specifically request clearing.
+	 */
+	if (obj->flags & I915_BO_ALLOC_USER)
+		return true;
+
+	if (ttm && ttm->page_flags & TTM_TT_FLAG_ZERO_ALLOC)
+		return true;
+
+	return false;
+}
+
 /**
  * i915_ttm_move - The TTM move callback used by i915.
  * @bo: The buffer object.
@@ -520,7 +540,7 @@ int i915_ttm_move(struct ttm_buffer_object *bo, bool evict,
 		return PTR_ERR(dst_rsgt);
 
 	clear = !i915_ttm_cpu_maps_iomem(bo->resource) && (!ttm || !ttm_tt_is_populated(ttm));
-	if (!(clear && ttm && !(ttm->page_flags & TTM_TT_FLAG_ZERO_ALLOC))) {
+	if (!clear || allow_clear(obj, ttm, dst_mem)) {
 		struct i915_deps deps;
 
 		i915_deps_init(&deps, GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN);
-- 
2.25.1

