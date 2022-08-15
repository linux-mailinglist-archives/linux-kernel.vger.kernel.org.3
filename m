Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C836594D61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 03:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244918AbiHPBZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 21:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244841AbiHPBZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 21:25:11 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6BDDAB8F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:14:54 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id l64so7558512pge.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=dTc3puoo2xv02+7+HIFO9LAkjK/P01/XbA/vkW8hPyo=;
        b=lUo9El7WmA0vaXppLobZTZwSSO4s3aBGpAdCeA3hM0xWiJE1bO0cX4scbqYfWAPcUv
         tCcM3DxIffFblEb6QQB5cyOd6W+L/5Cq0v34kx5zPkHZ7qe5mZyflu4PhCBZfSlHYZ6h
         U9AMe0FKCi93jdyTMnsrGn5mMtYnChc8odfjK8lj8WVBKHji3tEISpdoEqnfvqIOm6oo
         cso4B9WPu/wPNPLbjE/CZF7PAkFNeZD/YkWFhACAlvMWPJOwgPPu+HqFx51I/6vQj4LJ
         a4zevWUjQGkmiey6vsvoILQwBaYEJrlo6fC3TeQyY/3J1A+KhRuv29cQgRtNnvM7CIuq
         ccJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=dTc3puoo2xv02+7+HIFO9LAkjK/P01/XbA/vkW8hPyo=;
        b=Ok9ueLLCVkzCUxv7kfVT4L6p3WFt4RJxmyck9os9VLbq9TdbMaPAlzidCJawiUmDZf
         a1ijCSM1lPg4jVwvZBBacPGldPPd5RwozwwpeiaA182OO1/OVS6ChEBWksHE6sO6L8/Q
         /131Wwal/lyckjrkRKr+z9kshHVFwKKpgwHAZKPqmy4pf8cfjiPybS74JJ+IsNgtdW7Q
         FLwEHyJnN+QGJG0Cta04CtWB4+DWpVqThhLHdtOpCqwsKyase1A1PSMlEEu3uOwAl2G/
         515ELy3kdDZgIfIgsuTn1wrGJQjczamUkpEHPin/bGcd+Yy+0FgWvIbS2CnMj0MEJYIj
         alTA==
X-Gm-Message-State: ACgBeo3d42qffYA1ni6K+Mhk+Wdk/lm9hTkkxHJtHa7u7T6LLOw6ojF6
        YJNtJeY73YOl7tX7BJ1zjUk=
X-Google-Smtp-Source: AA6agR40Ony4nyLZFzq0XayICdaN3uMIdS5sXW5BLIENRDX2jxVXcH5BdrTr3WQTtUckfu7UWR7o0g==
X-Received: by 2002:a63:8049:0:b0:41b:e8db:d912 with SMTP id j70-20020a638049000000b0041be8dbd912mr15075841pgd.380.1660598094195;
        Mon, 15 Aug 2022 14:14:54 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902714400b0016ee26224a4sm7384427plm.305.2022.08.15.14.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 14:14:53 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] drm/prime: Wire up mmap_info support
Date:   Mon, 15 Aug 2022 14:15:13 -0700
Message-Id: <20220815211516.3169470-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220815211516.3169470-1-robdclark@gmail.com>
References: <20220815211516.3169470-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Just plumbing the thing thru an extra layer.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/drm_prime.c |  3 +++
 include/drm/drm_gem.h       | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index e3f09f18110c..4457fedde1ec 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -888,6 +888,9 @@ struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
 		.resv = obj->resv,
 	};
 
+	if (obj->funcs && obj->funcs->map_info)
+		exp_info.map_info = obj->funcs->map_info(obj);
+
 	return drm_gem_dmabuf_export(dev, &exp_info);
 }
 EXPORT_SYMBOL(drm_gem_prime_export);
diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index f28a48a6f846..a573ebfc529a 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -172,6 +172,17 @@ struct drm_gem_object_funcs {
 	 * This is optional but necessary for mmap support.
 	 */
 	const struct vm_operations_struct *vm_ops;
+
+	/**
+	 * @map_info:
+	 *
+	 * Return dma_buf_map_info indicating the coherency of an exported
+	 * dma-buf.
+	 *
+	 * This callback is optional.  If not provided, exported dma-bufs are
+	 * assumed to be DMA_BUF_MAP_INCOHERENT.
+	 */
+	enum dma_buf_map_info (*map_info)(struct drm_gem_object *obj);
 };
 
 /**
-- 
2.36.1

