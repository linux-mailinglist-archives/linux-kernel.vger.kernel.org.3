Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C2F518CFF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241839AbiECTRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbiECTRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:17:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56083FBC6
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 12:13:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: bbeckett)
        with ESMTPSA id 5E60C1F44697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651605222;
        bh=MwugLBh23dXXE1qsLkpJ+qfy/t4gW1mABUdWdV5evKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dc0PkMkZWCj0KBoGj/DAsdV/CPLSna0T5TiMp0x8GzaoSEYMBmmEPKJJ2tMf65CUw
         zr7lybq5exzd6qXWVQcf4dInaC9bNRB0ScdDOm7ylNTJOZijvxVKmTgIWP8Em6Rh8J
         lBpR8+I9hQMfe7H+O242dh7I3WsnR5UoHd2d4frt1BF+oFC3eCDZgOYQF7fMRFoO3T
         WLGhogv8KXDGO2xj7cVyGP49glbzbRWVSsNGiqwkGywsga9Kb9T3XRUes9WW3CXq77
         jxrvJ7v6hsUq9/i84fV++YhLzBqkmGideSIp/bGB3LQXDW6DXyTvo6DOxBcobcZ/Gx
         q4YAIUJEvrzyg==
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
Subject: [PATCH 3/4] drm/i915: allow volatile buffers to use ttm pool allocator
Date:   Tue,  3 May 2022 19:13:15 +0000
Message-Id: <20220503191316.1145124-4-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503191316.1145124-1-bob.beckett@collabora.com>
References: <20220503191316.1145124-1-bob.beckett@collabora.com>
MIME-Version: 1.0
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

internal buffers should be shmem backed.
if a volatile buffer is requested, allow ttm to use the pool allocator
to provide volatile pages as backing

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
index 4c25d9b2f138..fdb3a1c18cb6 100644
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
-- 
2.25.1

