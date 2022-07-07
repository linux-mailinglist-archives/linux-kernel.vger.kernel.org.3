Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BB456A85F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbiGGQgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbiGGQgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:36:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6741E45054
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:36:45 -0700 (PDT)
Received: from hermes-devbox.fritz.box (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 290C766019BA;
        Thu,  7 Jul 2022 17:36:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657211803;
        bh=2wQM6XEEejfV8LYpxGFHtQpBTSKwot13+IyHpuiYCD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ve17BHAf5KRJstJ1jlE211WFFbp+2rBtP2t/SZIJX2VbFiL232u9jHaou5SCTdovK
         ddD8gtqXsek/EsVOmIugvVEw0cDSqiJdDa2/ctuS9mCCDIAHq128sYOXKYCZzeEIfs
         8r/ZYIUDk1xhWgHnQARgbFKne+5PTc8X3q69NHaI3V2/+hdZSVYN031l4ww177Qdt3
         cuQgG8WXhuIkSYTSjyBC2EGHpE47NM2zic87htOpOlkhEVgBwhwLYPCWnbbawg+tya
         8ju4HPKBe9fWSR4nE0q+UJn78mvvHxhlipS/TwLjho7RUdApT0qGqzlFJfYb0+eP5B
         6aRgi//Ne8ghA==
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
Subject: [PATCH v9 01/11] drm/i915/ttm: dont trample cache_level overrides during ttm move
Date:   Thu,  7 Jul 2022 16:35:56 +0000
Message-Id: <20220707163606.1474111-2-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707163606.1474111-1-bob.beckett@collabora.com>
References: <20220707163606.1474111-1-bob.beckett@collabora.com>
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

Various places within the driver override the default chosen cache_level.
Before ttm, these overrides were permanent until explicitly changed again
or for the lifetime of the buffer.

TTM movement code came along and decided that it could make that
decision at that time, which is usually well after object creation, so
overrode the cache_level decision and reverted it back to its default
decision.

Add logic to indicate whether the caching mode has been set by anything
other than the move logic. If so, assume that the code that overrode the
defaults knows best and keep it.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_object.c       | 1 +
 drivers/gpu/drm/i915/gem/i915_gem_object_types.h | 1 +
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c          | 1 +
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c     | 9 ++++++---
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
index 06b1b188ce5a..519887769c08 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
@@ -125,6 +125,7 @@ void i915_gem_object_set_cache_coherency(struct drm_i915_gem_object *obj,
 	struct drm_i915_private *i915 = to_i915(obj->base.dev);
 
 	obj->cache_level = cache_level;
+	obj->ttm.cache_level_override = true;
 
 	if (cache_level != I915_CACHE_NONE)
 		obj->cache_coherent = (I915_BO_CACHE_COHERENT_FOR_READ |
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
index 2c88bdb8ff7c..6632ed52e919 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object_types.h
@@ -605,6 +605,7 @@ struct drm_i915_gem_object {
 		struct i915_gem_object_page_iter get_io_page;
 		struct drm_i915_gem_object *backup;
 		bool created:1;
+		bool cache_level_override:1;
 	} ttm;
 
 	/*
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
index 4c25d9b2f138..27d59639177f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -1241,6 +1241,7 @@ int __i915_gem_ttm_object_init(struct intel_memory_region *mem,
 	i915_gem_object_init_memory_region(obj, mem);
 	i915_ttm_adjust_domains_after_move(obj);
 	i915_ttm_adjust_gem_after_move(obj);
+	obj->ttm.cache_level_override = false;
 	i915_gem_object_unlock(obj);
 
 	return 0;
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
index a10716f4e717..4c1de0b4a10f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
@@ -123,9 +123,12 @@ void i915_ttm_adjust_gem_after_move(struct drm_i915_gem_object *obj)
 	obj->mem_flags |= i915_ttm_cpu_maps_iomem(bo->resource) ? I915_BO_FLAG_IOMEM :
 		I915_BO_FLAG_STRUCT_PAGE;
 
-	cache_level = i915_ttm_cache_level(to_i915(bo->base.dev), bo->resource,
-					   bo->ttm);
-	i915_gem_object_set_cache_coherency(obj, cache_level);
+	if (!obj->ttm.cache_level_override) {
+		cache_level = i915_ttm_cache_level(to_i915(bo->base.dev),
+						   bo->resource, bo->ttm);
+		i915_gem_object_set_cache_coherency(obj, cache_level);
+		obj->ttm.cache_level_override = false;
+	}
 }
 
 /**
-- 
2.25.1

