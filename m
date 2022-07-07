Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F4856AC5C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbiGGUDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiGGUCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:02:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664BF1EADF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 13:02:48 -0700 (PDT)
Received: from hermes-devbox.fritz.box (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0FB3E66019CA;
        Thu,  7 Jul 2022 21:02:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657224167;
        bh=AgP5Riz/FHb587iBL1vYiW/g4qmDc92BtRCaR0jjFGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c3A3YQU43mD8tHoWDu6hmqoZ0rPpWu01rTbGnvF4TSgJEBEs96Y3CPDjSXrDMcPWp
         37wFTItIVXgx7iJ7Uu+rr4dNvNaqWjNqGIaHkvjsb7N6Tum3qOAQgo7oRsPruywZdi
         O/uzPKUQLt4w8PEuN+iIZHlnBxKXtgDdj8JEYd7zjzZgnltAXlLSXKK81era0eVTUz
         deeUuVlLP6ly6deQeqRczfX2LlfwqLtnwGl3a1RtbHDTmVxFl1TJn8exIgRhq8Jn4n
         KG9ZiNne4MMdXmVhXXC19GMzBCKqciKV1DRtknRjHvaVVPeyMLYGtUJgqEpNcI6L4H
         FQ4IGo4dW6zeg==
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
Subject: [PATCH v10 06/11] drm/i915: sanitize mem_flags for stolen buffers
Date:   Thu,  7 Jul 2022 20:02:24 +0000
Message-Id: <20220707200230.1657555-7-bob.beckett@collabora.com>
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

Stolen regions are not page backed or considered iomem.
Prevent flags indicating such.
This correctly prevents stolen buffers from attempting to directly map
them.

See i915_gem_object_has_struct_page() and i915_gem_object_has_iomem()
usage for where it would break otherwise.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
index 675e9ab30396..81c67ca9edda 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
@@ -14,6 +14,7 @@
 #include "gem/i915_gem_region.h"
 #include "gem/i915_gem_ttm.h"
 #include "gem/i915_gem_ttm_move.h"
+#include "gem/i915_gem_stolen.h"
 
 #include "gt/intel_engine_pm.h"
 #include "gt/intel_gt.h"
@@ -124,8 +125,9 @@ void i915_ttm_adjust_gem_after_move(struct drm_i915_gem_object *obj)
 
 	obj->mem_flags &= ~(I915_BO_FLAG_STRUCT_PAGE | I915_BO_FLAG_IOMEM);
 
-	obj->mem_flags |= i915_ttm_cpu_maps_iomem(bo->resource) ? I915_BO_FLAG_IOMEM :
-		I915_BO_FLAG_STRUCT_PAGE;
+	if (!i915_gem_object_is_stolen(obj))
+		obj->mem_flags |= i915_ttm_cpu_maps_iomem(bo->resource) ? I915_BO_FLAG_IOMEM :
+			I915_BO_FLAG_STRUCT_PAGE;
 
 	if (!obj->ttm.cache_level_override) {
 		cache_level = i915_ttm_cache_level(to_i915(bo->base.dev),
-- 
2.25.1

