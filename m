Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71926585430
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 19:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbiG2RHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 13:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238301AbiG2RH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 13:07:28 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11B579EE1;
        Fri, 29 Jul 2022 10:07:25 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso8979394pjo.1;
        Fri, 29 Jul 2022 10:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=mcGjaEjlp9E6N37UMib26cBF56AyQFK+2CInJ6FUTCo=;
        b=qHCdQY3WlD0nJ+rn80athOrlbowIL0rs8FhkpgPJ9TYkDkOSEweR4R8EDy0KurACP1
         n59UAWHzz6oBskR78bMIkTVPeug25bs4DvwgH6PBj6JwTR3BuZCKX4jZYxcJQRoTSsoB
         EO102Ezzrh4+I044jkXZiL02C9FLZRyslCHTMx1j1WtJYGMxqJIWdGY8gr6wHV6hs+T7
         1emmRtbUDGqpCaa7DIORSJRX219g92FvZ8cmIwneiVeIWpc4wZW2Z7p9R7lVfbzCTLBy
         8VhRaW2OrcTpPvbbwkahlviDe3eIT8o6pPpWjPeGvjaGn0HRkdBBpuWyjt1APQaq71VF
         sHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=mcGjaEjlp9E6N37UMib26cBF56AyQFK+2CInJ6FUTCo=;
        b=etW2bUhtbh8tr7YjraNq5+AjY/VOdbyunvQZ2FINezIGZ1C+8+QsDVksCIj2Bty9Tq
         QpdCULgAJMnPQ1CD0085KG12zY0LCrxZKI0db9drSIAxxPMBh0kCN8s1Ud7VU5blxPY7
         9saEKWy5ToI0n9Egzw+E1OCdFUuQAuXxyr1LlVp5TzTSqgNN0UU+8jYi1AZzlVYLxk0g
         vSW1UiRx3qksG/Bg84fldz6T2bajSeykVlgVUofVknTtCpf9PTeFzNZb761gfGXXWbjO
         Gt0WFzno4IrUEihX6AtKFoc+aKz5t6iVkTjhcCg58RHFaFgZzyvGqUCCf+9XjJ0OZxPJ
         lgiQ==
X-Gm-Message-State: ACgBeo0GXf2kHvVLdOm0PeiKgjeOr1lLgnb3LGyArgv8DKrIrVofktZl
        X/YaBrFkKayaWaQXCfrKurc=
X-Google-Smtp-Source: AA6agR7Ol2NVPUvGRtSIxjQvMtgte0Ibyz5jmLGwxyIAGSEGA6qUhCfnNE3RpvIl5YX2vO02JAWceg==
X-Received: by 2002:a17:90a:d155:b0:1f2:4741:3b74 with SMTP id t21-20020a17090ad15500b001f247413b74mr5710102pjw.201.1659114445182;
        Fri, 29 Jul 2022 10:07:25 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id g18-20020a63fa52000000b0041a13b1d451sm2805355pgk.59.2022.07.29.10.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 10:07:24 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] drm/msm/prime: Add mmap_info support
Date:   Fri, 29 Jul 2022 10:07:42 -0700
Message-Id: <20220729170744.1301044-4-robdclark@gmail.com>
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

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_drv.c       |  1 +
 drivers/gpu/drm/msm/msm_drv.h       |  1 +
 drivers/gpu/drm/msm/msm_gem_prime.c | 11 +++++++++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 1ca4a92ba96e..4979aa8187ec 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1044,6 +1044,7 @@ static const struct drm_driver msm_driver = {
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
 	.gem_prime_import_sg_table = msm_gem_prime_import_sg_table,
 	.gem_prime_mmap     = msm_gem_prime_mmap,
+	.gem_prime_mmap_info= msm_gem_prime_mmap_info,
 #ifdef CONFIG_DEBUG_FS
 	.debugfs_init       = msm_debugfs_init,
 #endif
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 7330d7b5de8e..b4ace34ec889 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -271,6 +271,7 @@ void msm_gem_shrinker_init(struct drm_device *dev);
 void msm_gem_shrinker_cleanup(struct drm_device *dev);
 
 int msm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
+int msm_gem_prime_mmap_info(struct drm_gem_object *obj);
 struct sg_table *msm_gem_prime_get_sg_table(struct drm_gem_object *obj);
 int msm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map);
 void msm_gem_prime_vunmap(struct drm_gem_object *obj, struct iosys_map *map);
diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/msm_gem_prime.c
index c1d91863df05..2bacab7a1921 100644
--- a/drivers/gpu/drm/msm/msm_gem_prime.c
+++ b/drivers/gpu/drm/msm/msm_gem_prime.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/dma-buf.h>
+#include <uapi/linux/dma-buf.h>
 
 #include <drm/drm_prime.h>
 
@@ -26,6 +27,16 @@ int msm_gem_prime_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
 	return drm_gem_prime_mmap(obj, vma);
 }
 
+int msm_gem_prime_mmap_info(struct drm_gem_object *obj)
+{
+	struct msm_gem_object *msm_obj = to_msm_bo(obj);
+
+	if (msm_obj->flags & MSM_BO_WC)
+		return DMA_BUF_VM_PROT_WC;
+
+	return DMA_BUF_VM_PROT_CACHED;
+}
+
 struct sg_table *msm_gem_prime_get_sg_table(struct drm_gem_object *obj)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
-- 
2.36.1

