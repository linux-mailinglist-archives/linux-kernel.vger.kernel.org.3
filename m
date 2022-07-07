Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF62856A854
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbiGGQg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236027AbiGGQgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:36:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD334D4C7
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:36:45 -0700 (PDT)
Received: from hermes-devbox.fritz.box (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7EF1566019C6;
        Thu,  7 Jul 2022 17:36:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657211804;
        bh=x5DY8lqdscLPNZjf5Ukvpn+M8BELAAg44M2twj/KzYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dB6WqyfoGeOIBLkJFALwwSlluSy82NL38D243B17dNo8/3QjF84XKM196k5KT/S3K
         dkZhhNFX5zByloLMVGawXxjc/M0oNo1RECrDroPsIJh6wCztDmzgrUtegN0I3h4cy4
         BEHkGXALp0eAC5bmHrAzazCWxgBhQ+Nr7ri5Ns4B2KxpBnKTCU18ff0oweL9+CU4ox
         vjCxApRAOHP2kuhetXChqUFLJ3XHiG4zQiEvWBkTdZTIkhID1r+edT8NEoqTsGODio
         dwUJtzKQP5XxnxbNoKVjmHt6MfkNJFZkWpCcutS4wm09IGmT/McpjpRHd63b9cddwV
         X/zl4M+mYo2sQ==
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
Subject: [PATCH v9 03/11] drm/i915/ttm: only trust snooping for dgfx when deciding default cache_level
Date:   Thu,  7 Jul 2022 16:35:58 +0000
Message-Id: <20220707163606.1474111-4-bob.beckett@collabora.com>
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

By default i915_ttm_cache_level() decides I915_CACHE_LLC if HAS_SNOOP.
This is divergent from existing backends code which only considers
HAS_LLC.
Testing shows that trusting snooping on gen5- is unreliable and bsw via
ggtt mappings, so limit DGFX for now and maintain previous behaviour.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
index 4c1de0b4a10f..40249fa28a7a 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm_move.c
@@ -46,7 +46,9 @@ static enum i915_cache_level
 i915_ttm_cache_level(struct drm_i915_private *i915, struct ttm_resource *res,
 		     struct ttm_tt *ttm)
 {
-	return ((HAS_LLC(i915) || HAS_SNOOP(i915)) &&
+	bool can_snoop = HAS_SNOOP(i915) && IS_DGFX(i915);
+
+	return ((HAS_LLC(i915) || can_snoop) &&
 		!i915_ttm_gtt_binds_lmem(res) &&
 		ttm->caching == ttm_cached) ? I915_CACHE_LLC :
 		I915_CACHE_NONE;
-- 
2.25.1

