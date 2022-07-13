Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB743573791
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 15:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbiGMNiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 09:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiGMNio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 09:38:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131EA2189
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 06:38:41 -0700 (PDT)
Received: from hermes-devbox.fritz.box (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B804C66019D2;
        Wed, 13 Jul 2022 14:38:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657719520;
        bh=ha13NipozoxIlhmnqDQLSM1i3fj+EPxYLmpfjPykhKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OVFmbp1+WuzLJbSMWJc+wgjgL0pr/UqwkAbI8SS85WZAbSLXvX6GF6UZTS5YWbd33
         Tkvt74dPG8pxskKrjAhbk1ndSkP9O3E1hHuOQoxJvTOx5ko4MOn9muqgXBwn2zDFef
         ZLjZ+cU6kvsISJ/4xohMLhtPYqLrPwwu/fvaUG8dWYvwkg+ea361X1y7i81+rLuNHE
         xcjNsN96tRjpiYj9aKyk//6ByNFP7g5EVnYNJ4xNVyxBWmHIWBPEr2lax0iZbgnKrq
         H3SRWOmKjw77ePk+Yrl6KDk02HSbmiNYstSDVBw6QDgLkUifoJpmocOClU8MAeWfD2
         +jR1rV5TVn0Dw==
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
Subject: [PATCH v4 2/8] drm/i915: limit ttm to dma32 for i965G[M]
Date:   Wed, 13 Jul 2022 14:38:12 +0100
Message-Id: <20220713133818.3699604-3-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713133818.3699604-1-bob.beckett@collabora.com>
References: <20220713133818.3699604-1-bob.beckett@collabora.com>
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

i965G[M] cannot relocate objects above 4GiB.
Ensure ttm uses dma32 on these systems.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/i915/intel_region_ttm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_region_ttm.c b/drivers/gpu/drm/i915/intel_region_ttm.c
index 6873808a7015..642cd1587976 100644
--- a/drivers/gpu/drm/i915/intel_region_ttm.c
+++ b/drivers/gpu/drm/i915/intel_region_ttm.c
@@ -32,10 +32,15 @@
 int intel_region_ttm_device_init(struct drm_i915_private *dev_priv)
 {
 	struct drm_device *drm = &dev_priv->drm;
+	bool use_dma32 = false;
+
+	/* i965g[m] cannot relocate objects above 4GiB. */
+	if (IS_I965GM(dev_priv) || IS_I965G(dev_priv))
+		use_dma32 = true;
 
 	return ttm_device_init(&dev_priv->bdev, i915_ttm_driver(),
 			       drm->dev, drm->anon_inode->i_mapping,
-			       drm->vma_offset_manager, false, false);
+			       drm->vma_offset_manager, false, use_dma32);
 }
 
 /**
-- 
2.25.1

