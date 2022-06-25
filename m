Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9F855AD2E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 00:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiFYWz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 18:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbiFYWzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 18:55:17 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD32D13F50;
        Sat, 25 Jun 2022 15:55:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a11-20020a17090acb8b00b001eca0041455so7631709pju.1;
        Sat, 25 Jun 2022 15:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mxFT+vmlgH8OMaHZf0MGM1sQcdQOD7qQazzf52IZIdo=;
        b=SrSp3snXs0pK5mdm23qDw9AEOirWroW+OI7UXjNb32EksivAx79AdLoB5oK0MkDDjR
         YbjthKdN+bYDvOC0ds1PUimv+YinYSVg5F5CYdOElJl+/SuxTzoJ9//7y2YAWIhCAiYo
         x6X9yQcbAP7deozdGdurCRza18wqBxQso10Fub8cyR1txrvbkjr7/H7qODDPyDMqYsEM
         InEBuyaU+Fz2XZrnuBshy+raVq51J16T56l0VYkCXMKKN0uv5al3kIgGYXXGveFVMnwA
         YMV3j4AswqGKsOxyeIo1oMLoL6Ztn7HYvnkrg46GQw5nOiAVPh9xT2lECwS7qVQ4ZduD
         UFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mxFT+vmlgH8OMaHZf0MGM1sQcdQOD7qQazzf52IZIdo=;
        b=WROFdZLTvOq8a1hXaXPymXg9GwW2+MWcEtoTH6+DQc7HhvluyJbeXKjfgieoZ33T42
         Bto03XnnK2khhBfgljSdh0pQr27thcRI5iMeFp5J8CD7qLQiXDqUUN5R1K7iBO94IjvG
         JGjkjj93tiEx4TMsR89zU58eJF3FYiZkiLJNc+5OHw2Er5DGzJEgHwr3h39OI3k+6jwi
         eGyTKIixdoP9MTFLanHA3nH6GQhsY5TBuJlReMgH4XDsiSe0u31jT+v49moSgpYOOEKN
         Ut7CPyBZ7hlgbcZ33SMTRyzPcOyq79SyZufgKK0EyX247FN7h68UojdYmyuWDbgKuCFW
         UfTg==
X-Gm-Message-State: AJIora+1YGJKeVKleQUN3bw4sNVEsN+Up94r9gnQplRBCv6EyeV5Y/Pg
        1xB4y+CF34y4nJ1KAnAKYhk=
X-Google-Smtp-Source: AGRyM1uKXZy+zqzm5xAuTM9oZrssykuV7f/ZFNRCHd/yi6B1VGx7yRW2GbsY3C+0S7YzScee+WKgaQ==
X-Received: by 2002:a17:90b:4c4c:b0:1ed:41ec:599d with SMTP id np12-20020a17090b4c4c00b001ed41ec599dmr4801210pjb.202.1656197716188;
        Sat, 25 Jun 2022 15:55:16 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id s144-20020a632c96000000b003c265b7d4f6sm4022256pgs.44.2022.06.25.15.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 15:55:15 -0700 (PDT)
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
Subject: [PATCH 07/15] drm/msm/gem: Rename update_inactive
Date:   Sat, 25 Jun 2022 15:54:42 -0700
Message-Id: <20220625225454.81039-8-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220625225454.81039-1-robdclark@gmail.com>
References: <20220625225454.81039-1-robdclark@gmail.com>
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

