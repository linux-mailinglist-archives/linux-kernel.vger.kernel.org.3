Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E871552693
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 23:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244361AbiFTVeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 17:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233809AbiFTVeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 17:34:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDA115709
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 14:34:13 -0700 (PDT)
Received: from hermes-devbox.fritz.box (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7D20766017D6;
        Mon, 20 Jun 2022 22:34:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655760851;
        bh=JT0TnJkB0rL8RAGj5L8WxKKfTjJ2qr1XwBthtCgxh3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MPAxmFo5Z9i/mCG0uVW4wFwnBmwfN1H5RM77P+9JrdL5Q+Elbm4negTsXns53uDoi
         JHpon/pxt4t3zw5s8sU5GHM+EGJbSAlP3y1azj+IMoPGRGHzIIC4keey9hOth/gHND
         mw8m2HQyALODDBwNkKHjpWAVK3N/VJvhREjOgc8Z0tnizOUc326JCW7XbYF9hN++JO
         BVSneZpihaDdwN8wXS3mjPbat1hLRGLGVru+tkCiy7PNpRQ/siUvlmSeUFMWd6WQZs
         8FrWPOu5djxOyuyb5mjAysDAjT7IvlXBcniXEaWMcerejLy93eP+tZDzRomHV212gU
         H+e5IGfLYUFWg==
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
Subject: [PATCH v7 02/10] drm/i915: limit ttm to dma32 for i965G[M]
Date:   Mon, 20 Jun 2022 21:33:32 +0000
Message-Id: <20220620213340.3199605-3-bob.beckett@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620213340.3199605-1-bob.beckett@collabora.com>
References: <20220620213340.3199605-1-bob.beckett@collabora.com>
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

i965G[M] cannot relocate objects above 4GiB.
Ensure ttm uses dma32 on these systems.

Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
---
 drivers/gpu/drm/i915/intel_region_ttm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_region_ttm.c b/drivers/gpu/drm/i915/intel_region_ttm.c
index 62ff77445b01..fd2ecfdd8fa1 100644
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

