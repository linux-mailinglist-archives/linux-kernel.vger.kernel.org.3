Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A24545279
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245212AbiFIQwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237472AbiFIQw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:52:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6BD227CFC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 09:52:27 -0700 (PDT)
Received: from hermes-devbox.fritz.box (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CD5A666017BA;
        Thu,  9 Jun 2022 17:52:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654793546;
        bh=fNrnNmjm8O3impsJ3FwNrPFJIw42pnJblFgr2kI6zEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EpKGah8MRwcPqjQ95aCfc7Oks1XrRyNlKgTrhFsuhUw2s3yzaRTIoYsy++VgRqvQ5
         Oy/gXuwzxwXXFaonnGDftHH9qzCXCKjtF/MEMtxP/q7xQw0howdNcAsAVCn3P5hKYQ
         Kbc/xg4zKL+o1MMWxLTFRpwbLg/0h7jua9peemWb5Bt7Po3wzD8Zg/QJk8f53P5sD6
         ePj1vstZNyUg69igFYvoFsjGWRxMpGCvpoK1EZZwhk6myvgmc6GD+SBuFVTr4NgYqF
         ElfEg472OJdCcPK0tbEWwiQtU2I/u411NrTuCAXGhbk0Qckeh6POMRbPN0yY/KPU1M
         cn3s2ysIC8RwQ==
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
Subject: [PATCH v3 4/8] drm/i915: allow volatile buffers to use ttm pool allocator
Date:   Thu,  9 Jun 2022 16:51:56 +0000
Message-Id: <20220609165200.842821-5-bob.beckett@collabora.com>
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

Internal/volatile buffers should not be shmem backed.
If a volatile buffer is requested, allow ttm to use the pool allocator
to provide volatile pages as backing.
Fix i915_ttm_shrink to handle !is_shmem volatile buffers by purging.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
index 27d59639177f..8edce04a0509 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -309,7 +309,8 @@ static struct ttm_tt *i915_ttm_tt_create(struct ttm_buffer_object *bo,
 		page_flags |= TTM_TT_FLAG_ZERO_ALLOC;
 
 	caching = i915_ttm_select_tt_caching(obj);
-	if (i915_gem_object_is_shrinkable(obj) && caching == ttm_cached) {
+	if (i915_gem_object_is_shrinkable(obj) && caching == ttm_cached &&
+	    !i915_gem_object_is_volatile(obj)) {
 		page_flags |= TTM_TT_FLAG_EXTERNAL |
 			      TTM_TT_FLAG_EXTERNAL_MAPPABLE;
 		i915_tt->is_shmem = true;
@@ -531,9 +532,9 @@ static int i915_ttm_shrink(struct drm_i915_gem_object *obj, unsigned int flags)
 	if (!bo->ttm || bo->resource->mem_type != TTM_PL_SYSTEM)
 		return 0;
 
-	GEM_BUG_ON(!i915_tt->is_shmem);
+	GEM_BUG_ON(!i915_tt->is_shmem && obj->mm.madv != I915_MADV_DONTNEED);
 
-	if (!i915_tt->filp)
+	if (i915_tt->is_shmem && !i915_tt->filp)
 		return 0;
 
 	ret = ttm_bo_wait_ctx(bo, &ctx);
-- 
2.25.1

