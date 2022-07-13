Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8463F5737F8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbiGMNvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbiGMNuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:50:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099A514D3C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:50:44 -0700 (PDT)
Received: from hermes-devbox.fritz.box (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 80BEB66019BF;
        Wed, 13 Jul 2022 14:50:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657720243;
        bh=uwyKpWlNH8QK8xQy7lI/WZGpczdTFtV/IRUxiesx9gY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XgTnw6wlQ/AA3P4NVbhMSJJGJT7StIXLfdSrRA7iEk/eC0sCupkCs28FO/0VnF7Ze
         iWNS0M8zEo3y9Me3Wu+mwdcB3lCjz0eXnReuugnnMow0aRQD3bwwaw7YlD+UJQTnzP
         O+2bhlAjFOktoDgcLEKpA0+b+8ra5lymJDoKVwp1tOSO7pS8iyQB4JQrjSpLGG78Xo
         J9EsIO0yF6Ffkn+V0c0Kf0UuTCb0pwheQpejhyl7GAsNlrL1tV6MLJRVKKMusTcTw7
         NyobeSE8OscKUF/sA7ac7x6hCdTb0KVw7FsHvltZQBrDkn3/VhLp41J8IOjMPrq50U
         d1KRIRf+DyPeA==
From:   Robert Beckett <bob.beckett@collabora.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     kernel@collabora.com, Robert Beckett <bob.beckett@collabora.com>,
        Matthew Auld <matthew.auld@intel.com>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= 
        <thomas.hellstrom@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v11 06/10] drm/i915: ttm move/clear logic fix
Date:   Wed, 13 Jul 2022 14:50:18 +0100
Message-Id: <20220713135022.3710682-7-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713135022.3710682-1-bob.beckett@collabora.com>
References: <20220713135022.3710682-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c | 22 +++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
index 18d574ac167f..6671345b2abe 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
@@ -3,6 +3,7 @@
  * Copyright © 2021 Intel Corporation
  */
 
+#include "drm/ttm/ttm_tt.h"
 #include <drm/ttm/ttm_bo_driver.h>
 
 #include "i915_deps.h"
@@ -546,6 +547,25 @@ __i915_ttm_move(struct ttm_buffer_object *bo,
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
@@ -596,7 +616,7 @@ int i915_ttm_move(struct ttm_buffer_object *bo, bool evict,
 		return PTR_ERR(dst_rsgt);
 
 	clear = !i915_ttm_cpu_maps_iomem(bo->resource) && (!ttm || !ttm_tt_is_populated(ttm));
-	if (!(clear && ttm && !(ttm->page_flags & TTM_TT_FLAG_ZERO_ALLOC))) {
+	if (!clear || allow_clear(obj, ttm, dst_mem)) {
 		struct i915_deps deps;
 
 		i915_deps_init(&deps, GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN);
-- 
2.25.1

