Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710B5545277
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344349AbiFIQwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbiFIQw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:52:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DADE44A0A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 09:52:26 -0700 (PDT)
Received: from hermes-devbox.fritz.box (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5DCC666017D3;
        Thu,  9 Jun 2022 17:52:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654793544;
        bh=5MPDE6PLauo4xeTXuzQqjxRuaatIiJJgaRF7Azzw0o0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RlkP1xHXyos7Ke4dm5wGk0GT576pUmbcE2uyzbC20aAskIonfza2gSq4uf5I6Mkls
         l5OC82mjgKt6TFTNt+Sq9iiQX1af0na3XOgHUTU0xevMxQwFTs8q+HnEmkihWGsrQ9
         2R4oYIcKKoDqbS7RSLSiYJ16ap5U8P99DdxmT32hkvjQZqOuwtswWrLdk3UoMw6Xew
         D3qcIpkWSghfDmvaEFhphJ3W84exgaQ+XaCWvr9TGsH4tBJur1XZoH3P+gijGL2zDt
         sQ5B4bDoDUMpaTedzRtl1S2FloqhE3HLHj830GthW/sd0OWm/bfkPkkb0ZYsFTbZ73
         /GNT8okcGtrXQ==
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
Subject: [PATCH v3 2/8] drm/i915: add gen6 ppgtt dummy creation function
Date:   Thu,  9 Jun 2022 16:51:54 +0000
Message-Id: <20220609165200.842821-3-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609165200.842821-1-bob.beckett@collabora.com>
References: <20220609165200.842821-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Internal gem objects will soon just be volatile system memory region
objects.
To enable this, create a separate dummy object creation function
for gen6 ppgtt. The object only exists as a fake object pointing to ggtt
and gains no benefit in going via the internal backend.
Instead, create a dummy gem object and avoid having to maintain a custom
ops api in the internal backend, which makes later refactoring easier.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/i915/gt/gen6_ppgtt.c | 43 ++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
index 1bb766c79dcb..f3b660cfeb7f 100644
--- a/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
+++ b/drivers/gpu/drm/i915/gt/gen6_ppgtt.c
@@ -372,6 +372,45 @@ static const struct drm_i915_gem_object_ops pd_dummy_obj_ops = {
 	.put_pages = pd_dummy_obj_put_pages,
 };
 
+static struct drm_i915_gem_object *
+i915_gem_object_create_dummy(struct drm_i915_private *i915, phys_addr_t size)
+{
+	static struct lock_class_key lock_class;
+	struct drm_i915_gem_object *obj;
+	unsigned int cache_level;
+
+	GEM_BUG_ON(!size);
+	GEM_BUG_ON(!IS_ALIGNED(size, PAGE_SIZE));
+
+	if (overflows_type(size, obj->base.size))
+		return ERR_PTR(-E2BIG);
+
+	obj = i915_gem_object_alloc();
+	if (!obj)
+		return ERR_PTR(-ENOMEM);
+
+	drm_gem_private_object_init(&i915->drm, &obj->base, size);
+	i915_gem_object_init(obj, &pd_dummy_obj_ops, &lock_class, 0);
+	obj->mem_flags |= I915_BO_FLAG_STRUCT_PAGE;
+
+	/*
+	 * Mark the object as volatile, such that the pages are marked as
+	 * dontneed whilst they are still pinned. As soon as they are unpinned
+	 * they are allowed to be reaped by the shrinker, and the caller is
+	 * expected to repopulate - the contents of this object are only valid
+	 * whilst active and pinned.
+	 */
+	i915_gem_object_set_volatile(obj);
+
+	obj->read_domains = I915_GEM_DOMAIN_CPU;
+	obj->write_domain = I915_GEM_DOMAIN_CPU;
+
+	cache_level = HAS_LLC(i915) ? I915_CACHE_LLC : I915_CACHE_NONE;
+	i915_gem_object_set_cache_coherency(obj, cache_level);
+
+	return obj;
+}
+
 static struct i915_page_directory *
 gen6_alloc_top_pd(struct gen6_ppgtt *ppgtt)
 {
@@ -383,9 +422,7 @@ gen6_alloc_top_pd(struct gen6_ppgtt *ppgtt)
 	if (unlikely(!pd))
 		return ERR_PTR(-ENOMEM);
 
-	pd->pt.base = __i915_gem_object_create_internal(ppgtt->base.vm.gt->i915,
-							&pd_dummy_obj_ops,
-							I915_PDES * SZ_4K);
+	pd->pt.base = i915_gem_object_create_dummy(ppgtt->base.vm.gt->i915, I915_PDES * SZ_4K);
 	if (IS_ERR(pd->pt.base)) {
 		err = PTR_ERR(pd->pt.base);
 		pd->pt.base = NULL;
-- 
2.25.1

