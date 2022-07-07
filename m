Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D703F56AC5E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbiGGUDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbiGGUCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:02:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEA11FCE4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 13:02:49 -0700 (PDT)
Received: from hermes-devbox.fritz.box (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A4C9D66019DD;
        Thu,  7 Jul 2022 21:02:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657224167;
        bh=vcV9d53cSiZS9S6xUBuwTwjcLWVgxyTlm1c7ldt4HDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DkdaUT9KatkLleaiwgAQXYI5tiMl4pr7LWT3/t9PDKeOVGNBCamBwHfChCGxn6FpO
         xP4dFE70BvWSXHUzda+yHPqbXv7s0MyYpPfGQM5sdl2Mh0bjDh43mfjst82FRUDgHL
         Wo4wESi3d3rPIRtRqT8qD263nLVzjRLyeH00YMZrrkf4LMukqm+4vZdL6xrGFaCc/j
         Qakp0dMbC37zF/3DArOAaGy0CAcJInWyhdWRCnZJoVh6F+lHRQ3bNcIVwUGpAl2xEH
         pI3qgQEyQve11NAxOk5QJLgygwc++0l8PXrWsEbb/r2ZMILOArx8k+iz5xe5XElcEZ
         pMyQXDuLsDWMg==
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
Subject: [PATCH v10 07/11] drm/i915: ttm move/clear logic fix
Date:   Thu,  7 Jul 2022 20:02:25 +0000
Message-Id: <20220707200230.1657555-8-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707200230.1657555-1-bob.beckett@collabora.com>
References: <20220707200230.1657555-1-bob.beckett@collabora.com>
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
index 81c67ca9edda..a3f8fc056dbc 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
@@ -3,6 +3,7 @@
  * Copyright © 2021 Intel Corporation
  */
 
+#include "drm/ttm/ttm_tt.h"
 #include <drm/ttm/ttm_bo_driver.h>
 
 #include "i915_deps.h"
@@ -476,6 +477,25 @@ __i915_ttm_move(struct ttm_buffer_object *bo,
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
@@ -526,7 +546,7 @@ int i915_ttm_move(struct ttm_buffer_object *bo, bool evict,
 		return PTR_ERR(dst_rsgt);
 
 	clear = !i915_ttm_cpu_maps_iomem(bo->resource) && (!ttm || !ttm_tt_is_populated(ttm));
-	if (!(clear && ttm && !(ttm->page_flags & TTM_TT_FLAG_ZERO_ALLOC))) {
+	if (!clear || allow_clear(obj, ttm, dst_mem)) {
 		struct i915_deps deps;
 
 		i915_deps_init(&deps, GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN);
-- 
2.25.1

