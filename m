Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EC454527B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344184AbiFIQw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240054AbiFIQwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:52:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EABA1A077C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 09:52:30 -0700 (PDT)
Received: from hermes-devbox.fritz.box (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 216E566017E5;
        Thu,  9 Jun 2022 17:52:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654793547;
        bh=r6lF+wb4oVIUvBtEdpQAsS/+HQWGO3JeX6KjqiaMQi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W479OxaloJIRtn+QLhu/mMOxk+k2mMSeShI5tQYfD75WB6misfuqCpyYl+o57B+gF
         Ik7wPBr89mVxyAlhT0cncPrh5PoMk/DbHcIbLrELFGxHyxL014AGDL7+2VmwxTO887
         3gJGiMrLfNnNOQ7zVwn7HiBzTOMEHejw8xKym+iADwgXhwt7/LNN1gJMLEYYqNqvkj
         9Cd9JZhC5TwRW3l4z4yf11EDc50zX/oBQ8L61Ie7I9e2U6P6zgznubDVdLgzu0KVHI
         X5uEuikwhKsZv1fhNn4OlKPItuw9HltSKehjhyWtCtD/PNkjYBczrCVWpIUnx0ri+u
         g3yqS6FVty5Ug==
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
Subject: [PATCH v3 6/8] drm/i915/gem: further fix mman selftest
Date:   Thu,  9 Jun 2022 16:51:58 +0000
Message-Id: <20220609165200.842821-7-bob.beckett@collabora.com>
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

In commit 450cede7f380 ("drm/i915/gem: Fix the mman selftest") we fixed up
the mman selftest to allocate user buffers via smem only if we have lmem,
otherwise it uses internal buffers.

As the commit message asserts, we should only be using buffers that
userland should be able to create.
Internal buffers are not intended to be used by userland.

Instead, fix the code to always create buffers from smem.
In the case of integrated, this will create them from the shmem non-ttm
backend, which is fine.

This also fixes up the code to allow conversion of internal backend to
ttm without breaking this test.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 .../gpu/drm/i915/gem/selftests/i915_gem_mman.c  | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
index 5bc93a1ce3e3..ee2ad1281f97 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
@@ -594,17 +594,12 @@ static enum i915_mmap_type default_mapping(struct drm_i915_private *i915)
 }
 
 static struct drm_i915_gem_object *
-create_sys_or_internal(struct drm_i915_private *i915,
-		       unsigned long size)
+create_sys(struct drm_i915_private *i915, unsigned long size)
 {
-	if (HAS_LMEM(i915)) {
-		struct intel_memory_region *sys_region =
-			i915->mm.regions[INTEL_REGION_SMEM];
+	struct intel_memory_region *sys_region =
+		i915->mm.regions[INTEL_REGION_SMEM];
 
-		return __i915_gem_object_create_user(i915, size, &sys_region, 1);
-	}
-
-	return i915_gem_object_create_internal(i915, size);
+	return __i915_gem_object_create_user(i915, size, &sys_region, 1);
 }
 
 static bool assert_mmap_offset(struct drm_i915_private *i915,
@@ -615,7 +610,7 @@ static bool assert_mmap_offset(struct drm_i915_private *i915,
 	u64 offset;
 	int ret;
 
-	obj = create_sys_or_internal(i915, size);
+	obj = create_sys(i915, size);
 	if (IS_ERR(obj))
 		return expected && expected == PTR_ERR(obj);
 
@@ -717,7 +712,7 @@ static int igt_mmap_offset_exhaustion(void *arg)
 	}
 
 	/* Fill the hole, further allocation attempts should then fail */
-	obj = create_sys_or_internal(i915, PAGE_SIZE);
+	obj = create_sys(i915, PAGE_SIZE);
 	if (IS_ERR(obj)) {
 		err = PTR_ERR(obj);
 		pr_err("Unable to create object for reclaimed hole\n");
-- 
2.25.1

