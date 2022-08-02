Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4228587F53
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbiHBPvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiHBPve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:51:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7931A1ADA1;
        Tue,  2 Aug 2022 08:51:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id z19so13854216plb.1;
        Tue, 02 Aug 2022 08:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=mxFT+vmlgH8OMaHZf0MGM1sQcdQOD7qQazzf52IZIdo=;
        b=WN+R3EX30Oabvdp1q7dZCqfGguppdYSI4OwmuufkGnHDq2mRy4WcoOGHk63Zj8uGVv
         BMncLyRJeFdmKS+j1O0CiGCa3yZVVru13iDEQKGjvusLjaxi4dehJMcY5j0AN747MhS/
         FtaY50KoEXxF0riKhylVa4yF7/tNv9ZLyUDqoFULnqtiEJYJZbxemb/SaflrZTC6upC0
         xw82VGZlbO8bYPREZvAAI9Z//xn5akLF6lMZrou4Eldc/zvpXFlKXDaEdOG+tpTpooeP
         5al8QBx/WTUTbwVhLTtfHOJ9ir2BhsZj8ViV0f9nhYuW7cNvHhquBnOe6E8MB/Ihab3R
         Rk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=mxFT+vmlgH8OMaHZf0MGM1sQcdQOD7qQazzf52IZIdo=;
        b=4SQfRkpC6zedX6FmwWG53/4qu4YlflCqM0OsRqoWWwBawtZXnz9+poG+Kl6MAAqAHX
         hpZjUGXJBZkFMq0mDnKZ+zWJjfWzRuosItpj4CXDVwTWohGMTLsQcXZUMVEbMrK+yB8D
         4RqrZZiY89lUDOzbb6SuTKJWhx67Abm8Qmt7BQ7JO/NC8RL0BiToFkESBlnBoCQV3rqU
         KXWuo4SEMAjrNdmZEEqXTnNbxV189lCxAwNvxeO+sst8pRB3gehwdsXWlAypJCITgFKd
         ymixJqGcm4JhrMspRg5HaqC0IHVAp5pzznO21D5xUWsEe9rPhe6hXreY0GAmjCtO0NYm
         cjPw==
X-Gm-Message-State: ACgBeo0X//U1JmqsjDC8CU4vJb53TTGJAyhUybLIq85WhiCTjFfsHP4d
        lCSG3QmUaHvfYkgNTfjN1pjsYuc8bp8=
X-Google-Smtp-Source: AA6agR7pFLKO2uUqgp9rOlOUlR1Ah2c0yTxM50D66GE+OjvyQPhVV2ETDK0/78IyRlsx9x0Cxt8rvg==
X-Received: by 2002:a17:90a:4291:b0:1f2:2a19:fc95 with SMTP id p17-20020a17090a429100b001f22a19fc95mr114509pjg.29.1659455491353;
        Tue, 02 Aug 2022 08:51:31 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b0016d62ba5665sm12235660plh.254.2022.08.02.08.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:51:30 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 05/15] drm/msm/gem: Rename update_inactive
Date:   Tue,  2 Aug 2022 08:51:38 -0700
Message-Id: <20220802155152.1727594-6-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220802155152.1727594-1-robdclark@gmail.com>
References: <20220802155152.1727594-1-robdclark@gmail.com>
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

Really what this is doing is updating various LRU lists.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index b55d252aef17..97467364dc0a 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -19,7 +19,7 @@
 #include "msm_gpu.h"
 #include "msm_mmu.h"
 
-static void update_inactive(struct msm_gem_object *msm_obj);
+static void update_lru(struct drm_gem_object *obj);
 
 static dma_addr_t physaddr(struct drm_gem_object *obj)
 {
@@ -132,7 +132,7 @@ static struct page **get_pages(struct drm_gem_object *obj)
 		if (msm_obj->flags & MSM_BO_WC)
 			sync_for_device(msm_obj);
 
-		update_inactive(msm_obj);
+		update_lru(obj);
 	}
 
 	return msm_obj->pages;
@@ -193,7 +193,7 @@ struct page **msm_gem_get_pages(struct drm_gem_object *obj)
 
 	if (!IS_ERR(p)) {
 		msm_obj->pin_count++;
-		update_inactive(msm_obj);
+		update_lru(obj);
 	}
 
 	msm_gem_unlock(obj);
@@ -207,7 +207,7 @@ void msm_gem_put_pages(struct drm_gem_object *obj)
 	msm_gem_lock(obj);
 	msm_obj->pin_count--;
 	GEM_WARN_ON(msm_obj->pin_count < 0);
-	update_inactive(msm_obj);
+	update_lru(obj);
 	msm_gem_unlock(obj);
 }
 
@@ -449,7 +449,7 @@ void msm_gem_unpin_locked(struct drm_gem_object *obj)
 	msm_obj->pin_count--;
 	GEM_WARN_ON(msm_obj->pin_count < 0);
 
-	update_inactive(msm_obj);
+	update_lru(obj);
 }
 
 struct msm_gem_vma *msm_gem_get_vma_locked(struct drm_gem_object *obj,
@@ -658,7 +658,7 @@ static void *get_vaddr(struct drm_gem_object *obj, unsigned madv)
 			goto fail;
 		}
 
-		update_inactive(msm_obj);
+		update_lru(obj);
 	}
 
 	return msm_obj->vaddr;
@@ -730,7 +730,7 @@ int msm_gem_madvise(struct drm_gem_object *obj, unsigned madv)
 	 * between inactive lists
 	 */
 	if (msm_obj->active_count == 0)
-		update_inactive(msm_obj);
+		update_lru(obj);
 
 	msm_gem_unlock(obj);
 
@@ -757,7 +757,7 @@ void msm_gem_purge(struct drm_gem_object *obj)
 	put_iova_vmas(obj);
 
 	msm_obj->madv = __MSM_MADV_PURGED;
-	update_inactive(msm_obj);
+	update_lru(obj);
 
 	drm_gem_free_mmap_offset(obj);
 
@@ -792,7 +792,7 @@ void msm_gem_evict(struct drm_gem_object *obj)
 
 	put_pages(obj);
 
-	update_inactive(msm_obj);
+	update_lru(obj);
 }
 
 void msm_gem_vunmap(struct drm_gem_object *obj)
@@ -835,13 +835,14 @@ void msm_gem_active_put(struct drm_gem_object *obj)
 	GEM_WARN_ON(!msm_gem_is_locked(obj));
 
 	if (--msm_obj->active_count == 0) {
-		update_inactive(msm_obj);
+		update_lru(obj);
 	}
 }
 
-static void update_inactive(struct msm_gem_object *msm_obj)
+static void update_lru(struct drm_gem_object *obj)
 {
-	struct msm_drm_private *priv = msm_obj->base.dev->dev_private;
+	struct msm_drm_private *priv = obj->dev->dev_private;
+	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
 	GEM_WARN_ON(!msm_gem_is_locked(&msm_obj->base));
 
-- 
2.36.1

