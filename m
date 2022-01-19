Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FC0493855
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 11:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353547AbiASKXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 05:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345318AbiASKXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 05:23:44 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93131C061574;
        Wed, 19 Jan 2022 02:23:43 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c71so8977154edf.6;
        Wed, 19 Jan 2022 02:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lFHQBay/q6+NnOl2SII/Ps5xmFarxwMCV5ET8Tr+2Ks=;
        b=l6aA2GXwD+dROz0YFw7ehLY4dgmbv+40TX9Ts7qiofcKfAz1LVs0R3DSVj2z1JgvrI
         UTJYZGGFgMga7wQ7dNkAuQ28hO/tbaI25Iom3JFsi5NJV6vJKBchKpoAdJ1kSh3Sa4sQ
         1xC9a22YkHOilOyROJcXMRvr0SpynVcs42gKIiD35iZn3XEjjpkyGKhdS5xUqKSHeOZr
         SOyxQrHyxMc2Srp/Oa8yMQj8Zfb7gwRDiVRFJDh2zWdAWVp8VEEXb09XRX+UxHdwllWt
         0wGpb2TGO8/vDZrYoKQDorxodoQqpbl8pn0WJs5BtEvipjuuGG/2wdUrIeBkhAjEFouW
         rU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lFHQBay/q6+NnOl2SII/Ps5xmFarxwMCV5ET8Tr+2Ks=;
        b=1UTIrMDJX5TyZDA0TntakoAfaYFDXiVWfd1AeFn6ivjznjqQUd7K44Ex+bjM/fE1ue
         3v0411An1f3mFjNdypU0kHJg80lavKu2l3kfK7T5S7uxFmYxoxHv/wYXqCGkrUcPNB+L
         WRyF3xSlvCvUUYlV3GKf5xJ3PtBME6i500Djwgnz47QvSb+/FLQ8WOEBB+TvRSvRZFBk
         V6VQWPw42Lk4x7Zcq9Z39F8IJMvlmAAdM3i1SE+92IFIov1N5inBLRV22YfOMT5Bfk3Q
         XUlHg4f74mLC7bhFq8gjiVWNeMGuE4N5h7yXRmYjVXMMUvEe//sWH3h6enHW2NZkFGFS
         rkTQ==
X-Gm-Message-State: AOAM530jbG0EOpOBket4OcgVuIFDAVSaOyi4YOjUZYb4KeFNy38vGUjC
        Uo10VLyWKUJwYwF33YI0/eU=
X-Google-Smtp-Source: ABdhPJy5WBJKHzb6nGWtktk0x3HF73uuNdLuGC6azC1gyuoMx0eXFpasQ2c/ScKtGXV4Kkoc8E5bcA==
X-Received: by 2002:a17:906:9750:: with SMTP id o16mr23715220ejy.410.1642587822170;
        Wed, 19 Jan 2022 02:23:42 -0800 (PST)
Received: from localhost.localdomain ([46.249.74.23])
        by smtp.gmail.com with ESMTPSA id b4sm3456546ejb.131.2022.01.19.02.23.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jan 2022 02:23:41 -0800 (PST)
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
To:     tomba@kernel.org, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, merlijn@wizzup.org, tony@atomide.com,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH 1/3] drm: omapdrm: simplify omap_gem_pin
Date:   Wed, 19 Jan 2022 12:23:09 +0200
Message-Id: <1642587791-13222-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1642587791-13222-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <1642587791-13222-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move tiler related code to its own function.

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 drivers/gpu/drm/omapdrm/omap_gem.c | 75 +++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index b0fa174..bb12cb4 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -750,6 +750,46 @@ void omap_gem_dma_sync_buffer(struct drm_gem_object *obj,
 	}
 }
 
+static int omap_gem_pin_tiler(struct drm_gem_object *obj)
+{
+	struct omap_gem_object *omap_obj = to_omap_bo(obj);
+	u32 npages = obj->size >> PAGE_SHIFT;
+	enum tiler_fmt fmt = gem2fmt(omap_obj->flags);
+	struct tiler_block *block;
+	int ret;
+
+	BUG_ON(omap_obj->block);
+
+	if (omap_obj->flags & OMAP_BO_TILED_MASK) {
+		block = tiler_reserve_2d(fmt, omap_obj->width, omap_obj->height,
+					 PAGE_SIZE);
+	} else {
+		block = tiler_reserve_1d(obj->size);
+	}
+
+	if (IS_ERR(block)) {
+		ret = PTR_ERR(block);
+		dev_err(obj->dev->dev, "could not remap: %d (%d)\n", ret, fmt);
+		goto fail;
+	}
+
+	/* TODO: enable async refill.. */
+	ret = tiler_pin(block, omap_obj->pages, npages, omap_obj->roll, true);
+	if (ret) {
+		tiler_release(block);
+		dev_err(obj->dev->dev, "could not pin: %d\n", ret);
+		goto fail;
+	}
+
+	omap_obj->dma_addr = tiler_ssptr(block);
+	omap_obj->block = block;
+
+	DBG("got dma address: %pad", &omap_obj->dma_addr);
+
+fail:
+	return ret;
+}
+
 /**
  * omap_gem_pin() - Pin a GEM object in memory
  * @obj: the GEM object
@@ -774,11 +814,6 @@ int omap_gem_pin(struct drm_gem_object *obj, dma_addr_t *dma_addr)
 
 	if (!omap_gem_is_contiguous(omap_obj) && priv->has_dmm) {
 		if (refcount_read(&omap_obj->dma_addr_cnt) == 0) {
-			u32 npages = obj->size >> PAGE_SHIFT;
-			enum tiler_fmt fmt = gem2fmt(omap_obj->flags);
-			struct tiler_block *block;
-
-			BUG_ON(omap_obj->block);
 
 			refcount_set(&omap_obj->dma_addr_cnt, 1);
 
@@ -786,35 +821,9 @@ int omap_gem_pin(struct drm_gem_object *obj, dma_addr_t *dma_addr)
 			if (ret)
 				goto fail;
 
-			if (omap_obj->flags & OMAP_BO_TILED_MASK) {
-				block = tiler_reserve_2d(fmt,
-						omap_obj->width,
-						omap_obj->height, PAGE_SIZE);
-			} else {
-				block = tiler_reserve_1d(obj->size);
-			}
-
-			if (IS_ERR(block)) {
-				ret = PTR_ERR(block);
-				dev_err(obj->dev->dev,
-					"could not remap: %d (%d)\n", ret, fmt);
-				goto fail;
-			}
-
-			/* TODO: enable async refill.. */
-			ret = tiler_pin(block, omap_obj->pages, npages,
-					omap_obj->roll, true);
-			if (ret) {
-				tiler_release(block);
-				dev_err(obj->dev->dev,
-						"could not pin: %d\n", ret);
+			ret = omap_gem_pin_tiler(obj);
+			if (ret)
 				goto fail;
-			}
-
-			omap_obj->dma_addr = tiler_ssptr(block);
-			omap_obj->block = block;
-
-			DBG("got dma address: %pad", &omap_obj->dma_addr);
 		} else {
 			refcount_inc(&omap_obj->dma_addr_cnt);
 		}
-- 
1.9.1

