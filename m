Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2607058542F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 19:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbiG2RH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 13:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238295AbiG2RHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:07:23 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8641873938;
        Fri, 29 Jul 2022 10:07:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d3so5144243pls.4;
        Fri, 29 Jul 2022 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FldoPR8BVfM3iFKwCM1XMFRXAR81Z32eid0v1j3G9ms=;
        b=HKz9QeN1B04S71KqwGZWo+wwf6kYkXxGdcKiMMHsrsr13IRifPJQhbh5KiqAal/DsE
         vmjJYbyNR97KhbEFgVt6sDx0Pw/eEnSBmdQG15mvI3z/WZaWhK4GWeFNA03PfPyOe5vu
         yTKimkqFzz72xhuoFlkIVRLFDeoQnq3XOJyLCDpX7m1tK4Kb4xNn9qopeHrIDF5PxWAm
         JZW/VRTDBeDZKYhtX4Xk349gSo/lWOrmUHKaG+44tHdLZEUNGvlJNmt/LwMdPDoQMNCC
         6fvIfU7eJFgMMkHB2vZYsWnHyfQTqJAKlMVd5pQHRv1+lWJdaWbpupNA3RegpyUILm1P
         MI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FldoPR8BVfM3iFKwCM1XMFRXAR81Z32eid0v1j3G9ms=;
        b=qVYjYlmuRUNsWYWE/Q1KBGI+Z+tX60VdAQUIsZl/qJ6os0ZDFDLO8CjRj0T5WTu67O
         JsUC5XrJHGvIUXEaidT32PZG63tDg6QS0J67rly4+FomwhqPvJbkQ0PJATx0Y2o9c9ol
         1DfuIHHYdraBJb6uWZhVQ4sLHy3ngSCQFNdvMFXJ6dACoO54x5SgGyM10rPgH0soBPyb
         JL0vOBKJpraSt7K8Y5e6py1bxDECJAIQ+0t5chEHxag1cx1nXCy2ipwPXygukRj1h+Yo
         1Fx98vO3HDX9qkpid8n8A8jvB28/ZVCaK9djgWqDoUlTQeHuCpo4RRet5iPaRzV1hyzv
         hwDQ==
X-Gm-Message-State: ACgBeo0wtcp/aQe9cbkjojy5XB2Vb6FjE101odc7OTZGY8jyyOAdMnj9
        Hjm5A8IDX7bY461Z07E/m0s=
X-Google-Smtp-Source: AA6agR56jDy8w/4vyMlbH3lvpqcpJ00Ke/e1+Z/3QybslmIHKNYd1sUZrzP7R7Q9uY7p/hqGynTRKw==
X-Received: by 2002:a17:90a:9709:b0:1f3:7ac:73dd with SMTP id x9-20020a17090a970900b001f307ac73ddmr5214940pjo.184.1659114442062;
        Fri, 29 Jul 2022 10:07:22 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id jz21-20020a17090b14d500b001f1ef42fd7bsm6183882pjb.36.2022.07.29.10.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 10:07:20 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-media@vger.kernel.org (open list:DMA BUFFER SHARING FRAMEWORK),
        linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
        FRAMEWORK)
Subject: [PATCH 2/3] drm/prime: Wire up mmap_info support
Date:   Fri, 29 Jul 2022 10:07:41 -0700
Message-Id: <20220729170744.1301044-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220729170744.1301044-1-robdclark@gmail.com>
References: <20220729170744.1301044-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Just plumbing the thing thru an extra layer.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_prime.c | 12 ++++++++++++
 include/drm/drm_drv.h       |  7 +++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index e3f09f18110c..f58586e131c5 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -784,6 +784,17 @@ int drm_gem_dmabuf_mmap(struct dma_buf *dma_buf, struct vm_area_struct *vma)
 }
 EXPORT_SYMBOL(drm_gem_dmabuf_mmap);
 
+static int drm_gem_dmabuf_mmap_info(struct dma_buf *dma_buf)
+{
+	struct drm_gem_object *obj = dma_buf->priv;
+	struct drm_device *dev = obj->dev;
+
+	if (!dev->driver->gem_prime_mmap_info)
+		return -ENOSYS;
+
+	return dev->driver->gem_prime_mmap_info(obj);
+}
+
 static const struct dma_buf_ops drm_gem_prime_dmabuf_ops =  {
 	.cache_sgt_mapping = true,
 	.attach = drm_gem_map_attach,
@@ -792,6 +803,7 @@ static const struct dma_buf_ops drm_gem_prime_dmabuf_ops =  {
 	.unmap_dma_buf = drm_gem_unmap_dma_buf,
 	.release = drm_gem_dmabuf_release,
 	.mmap = drm_gem_dmabuf_mmap,
+	.mmap_info = drm_gem_dmabuf_mmap_info,
 	.vmap = drm_gem_dmabuf_vmap,
 	.vunmap = drm_gem_dmabuf_vunmap,
 };
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index f6159acb8856..797c0f8c2dd0 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -355,6 +355,13 @@ struct drm_driver {
 	 */
 	int (*gem_prime_mmap)(struct drm_gem_object *obj, struct vm_area_struct *vma);
 
+	/**
+	 * @gem_prim_mmap_info:
+	 *
+	 * Get info about mmap setup by gem_prime_mmap.  See dma_buf_ops:mmap_info.
+	 */
+	int (*gem_prime_mmap_info)(struct drm_gem_object *obj);
+
 	/**
 	 * @dumb_create:
 	 *
-- 
2.36.1

