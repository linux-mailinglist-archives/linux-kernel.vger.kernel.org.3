Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179B154527A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244597AbiFIQwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238917AbiFIQw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:52:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E15D22848F
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 09:52:27 -0700 (PDT)
Received: from hermes-devbox.fritz.box (82-71-8-225.dsl.in-addr.zen.co.uk [82.71.8.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bbeckett)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7BD4E66017E0;
        Thu,  9 Jun 2022 17:52:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654793546;
        bh=JT0TnJkB0rL8RAGj5L8WxKKfTjJ2qr1XwBthtCgxh3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZUY7j0J4rtnKrcF9zN5/dZNwoipi8ZxGGyyoLbyyg48THwbRtwyMXrsBCjkW/C/6/
         jGGdtn0RIYATngU6r2GSqgWXuqz5G9Dkr9glRh4CSbQMkZFUIMvNAx3v+kPPOQrPWC
         prkiuxP9YmLeH5/ZkhiSwDwk8ZGrA65Z74GR3pAYMGoQ4zAC9mPfetZOZGOMGcfOia
         ZMYx68a6v2KNQqhMxxoTtRAQLm/4+2WIJ4Fqli9+JJ02tZczIEo8/1R3+yH7n2/4Ji
         NZLw/QfC8SQvOYc29b6aZ89oYxH7Jd9EugLW4uO0kH6sjv6zwXuyUaUqJtqQtcz4UW
         G6Wqsdn0DpTiw==
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
Subject: [PATCH v3 5/8] drm/i915: limit ttm to dma32 for i965G[M]
Date:   Thu,  9 Jun 2022 16:51:57 +0000
Message-Id: <20220609165200.842821-6-bob.beckett@collabora.com>
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

