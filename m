Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D300553B09
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354195AbiFUUBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352902AbiFUUBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:01:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0B92983F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:01:16 -0700 (PDT)
Received: from hermes-devbox.fritz.box (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 889F6660181F;
        Tue, 21 Jun 2022 21:01:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655841674;
        bh=NNjcoDidsEevqXEiV8GzBg83apsOHvIp6XGvRc7cnZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atDjEUv05QVeHsBif7hEhci7xWp5Ojll9NC3qg6ZPklJ/EZgJ7J9R6xpWo2gc79Ab
         p++Pe05XyrhU+ZNBDIlfnWJ0W2BQbWnmPPARbghW9YLE4XsejCOoGBN2PZfVeBUAkE
         273Mkyy3UjzohQ2fTzXxVGPfDzbbfQpSet5wJank2AXdnCeAgWf7IKdJVvp1Kjvtpb
         5gEJazjRoTiL+PIBdF0BAk+/kjtIVaYL7WZbalMVT3GrfPCdds3WBigZoXIqbXrNpp
         bu5laLMqcISSPw/77ht1w7IDnLAqHCz8/dFGB7CRl9JtXPBPDRx1ZLJQCULiaP+9ZA
         6EQYl18gTWCHQ==
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
Subject: [PATCH v8 04/10] drm/i915/gem: selftest should not attempt mmap of private regions
Date:   Tue, 21 Jun 2022 20:00:52 +0000
Message-Id: <20220621200058.3536182-5-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621200058.3536182-1-bob.beckett@collabora.com>
References: <20220621200058.3536182-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During testing make can_mmap consider whether the region is private.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
index 5bc93a1ce3e3..76181e28c75e 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
@@ -869,6 +869,9 @@ static bool can_mmap(struct drm_i915_gem_object *obj, enum i915_mmap_type type)
 	struct drm_i915_private *i915 = to_i915(obj->base.dev);
 	bool no_map;
 
+	if (obj->mm.region && obj->mm.region->private)
+		return false;
+
 	if (obj->ops->mmap_offset)
 		return type == I915_MMAP_TYPE_FIXED;
 	else if (type == I915_MMAP_TYPE_FIXED)
-- 
2.25.1

