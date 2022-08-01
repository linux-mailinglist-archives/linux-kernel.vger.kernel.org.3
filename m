Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB69586F34
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiHAREo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbiHAREf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:04:35 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B38205D0;
        Mon,  1 Aug 2022 10:04:33 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q22so2870284plr.9;
        Mon, 01 Aug 2022 10:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FldoPR8BVfM3iFKwCM1XMFRXAR81Z32eid0v1j3G9ms=;
        b=P5t1olBIPvtepOhoWbKkkUVf08sqYRhi/TWm0yi84qISkPToL9ZOLKl9vbFjIhS8b6
         bYTGbV0qB/1eFZxubi3BGt7V+ba/RPrbVnj2ybfRDE1e4/zGNVRt84kxHdnCLYh48VMh
         yGWtynCaP4Gs4beiBVSZtPZ0zuPSDeZMuSQBe8GFNhIaaWNaRxYXfhpdFWnH1+8BSYla
         B1QVJcxpfiKeMa0GZm7VYaXkCIdRz302vr8+YYr5MmLE0Q93QpYRn8tB1hjqLiaZg6Qv
         0gVNQbMUetaPGuhYCUUlsObNnTVxyaUBmhWs2DGHn17+baKEzk962HChc/qyqhDF4zRo
         8x3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FldoPR8BVfM3iFKwCM1XMFRXAR81Z32eid0v1j3G9ms=;
        b=RsUSqnbTjePgnUjADK1Mo70/+IQzcAsopR7GVcZf6bSo6YnJbzL0SsGOmGr/Qry9wV
         54l6giBqa20KKwKJZ2sOhy8TAeczViY1FgecVfr3C+Y3ZdqY18wOI8KEscHKZNlfqqee
         PFxJMJMjuaR1gL/F2bxFfvQl1VAjgMPheJEeMn6rbU7O7znFxdlCr5knqNgFQWvbPHvC
         E3KcMsYbj6XvIkxwAFQCKfS7XG05hJmLq784v53kbVoKwlghwfmhw5o5IN8BW1Ww0F9Q
         PQZVtJHTZryGuknEOeuvpH2oI1gBdUJT5Lo6rg4bxEBbnCYriivY+jVl4q1d/U3GsgO/
         Vfag==
X-Gm-Message-State: ACgBeo13qop/NEGPmW9TyB+QWjA1dZP8ezGhzYW2W3Mt09ln4R8jmopS
        P3f8GOewIksHf6MzmSllDB8=
X-Google-Smtp-Source: AA6agR7RKmYUgh7A3D15hwwh+KxJFk2yHczvexmfofd2/7qJwEl8Vx18v5W+zk5ElLXMIRH6WGWqOg==
X-Received: by 2002:a17:902:e945:b0:16b:f802:1660 with SMTP id b5-20020a170902e94500b0016bf8021660mr17490083pll.7.1659373473559;
        Mon, 01 Aug 2022 10:04:33 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902ced100b0016d9877d3bfsm9937250plg.32.2022.08.01.10.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 10:04:32 -0700 (PDT)
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
Subject: [PATCH v2 2/3] drm/prime: Wire up mmap_info support
Date:   Mon,  1 Aug 2022 10:04:56 -0700
Message-Id: <20220801170459.1593706-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220801170459.1593706-1-robdclark@gmail.com>
References: <20220801170459.1593706-1-robdclark@gmail.com>
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

