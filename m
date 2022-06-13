Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6310454A0F4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351698AbiFMVMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351048AbiFMVL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:11:57 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665293DDDC;
        Mon, 13 Jun 2022 13:50:22 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id l4so5543565pgh.13;
        Mon, 13 Jun 2022 13:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZmwXvgLLBC7TADCPkXTU2hZQHv34ij//8HIDEtsV3fg=;
        b=d4SK5QkUQl4YuJ5khcaFrQapCV8SM63zlqRjeOcI9zoh06FmMqpOvdLTMXBdxba3Gp
         KUnYizKkLIF419F1zA6l4tHwGs0rDfnMp9sWokkyqAUHQ6i23NSuOzFZkwzTnnem7M3Z
         C4SRDjxVroJVNHZbdGP5H5tW5ILZSO5vpca7JWzFw3UIl4+t9a2qEoWGvQ2Q+JIGnCaU
         Xocf8oekLGO2iA1zStcBA4ruy69//oC9IZ2z9xRCLQxlXY7HfD8LGUgn+agiTmVTboaQ
         zxa9rxnZonyLUvKJBBII++QCt3dI3TIr12x3YJ/BGFO0g6kjVtBAi+7Uogl+2PQHP7it
         +LAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZmwXvgLLBC7TADCPkXTU2hZQHv34ij//8HIDEtsV3fg=;
        b=7QdY+xnfC2MqsGMkgG0Fb071s3ojXZ8hJUc9tkDvKL1JdTSWzkc8trfdWFD13GchkA
         Yf/5au0idus3g28jCjQysoMocpNYXX72MxbBWT/nnuxV5UInSgOs4sJK7dt8BrjY9Yzx
         oBPP8UhnyYI8WLAF9DEZWanI9xf0vGvxCIIFTitJJOEU1bHlas/03+m8/v94UdEiB06A
         RtdFW+VY1FAuE0Zk17Zq3MEtPw+PUSEVdQ6TMSu2SlpTGVmEaL4L13toy/3g89TnZ450
         wpKHKsKmV569bJytVVMfH2NHkNuWA/r/ZxIIci8h7/cOhLQzBfr1Y4G8QiQ2+KBPFd+S
         j0Ig==
X-Gm-Message-State: AOAM5306bWMV895Z5vaZmuqim3smSQ1Ik7bl44zvPl3zei/E03sWzx2b
        LMISSzOOxMsJ0uvzA+gth/c=
X-Google-Smtp-Source: ABdhPJzm1ncJI/Zv5ZahCXdnEdUzbwnLxSHxpjYu4I8xjvCMgyZ73IgE2hbkPio67Zoi84w6qPuTJw==
X-Received: by 2002:a65:6b92:0:b0:39c:c97b:1b57 with SMTP id d18-20020a656b92000000b0039cc97b1b57mr1281744pgw.517.1655153421701;
        Mon, 13 Jun 2022 13:50:21 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090264c200b0016641a37e71sm5509262pli.225.2022.06.13.13.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 13:50:20 -0700 (PDT)
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
Subject: [PATCH] drm/msm/gem: Drop obj lock in msm_gem_free_object()
Date:   Mon, 13 Jun 2022 13:50:32 -0700
Message-Id: <20220613205032.2652374-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
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

The only reason we grabbed the lock was to satisfy a bunch of places
that WARN_ON() if called without the lock held.  But this angers lockdep
which doesn't realize no one else can be holding the lock by the time we
end up destroying the object (and sees what would otherwise be a locking
inversion between reservation_ww_class_mutex and fs_reclaim).

Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/14
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.c |  8 --------
 drivers/gpu/drm/msm/msm_gem.h | 14 +++++++++++++-
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 3ef7ada59392..ccc7e6d8cc30 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1020,8 +1020,6 @@ static void msm_gem_free_object(struct drm_gem_object *obj)
 	list_del(&msm_obj->mm_list);
 	mutex_unlock(&priv->mm_lock);
 
-	msm_gem_lock(obj);
-
 	/* object should not be on active list: */
 	GEM_WARN_ON(is_active(msm_obj));
 
@@ -1037,17 +1035,11 @@ static void msm_gem_free_object(struct drm_gem_object *obj)
 
 		put_iova_vmas(obj);
 
-		/* dma_buf_detach() grabs resv lock, so we need to unlock
-		 * prior to drm_prime_gem_destroy
-		 */
-		msm_gem_unlock(obj);
-
 		drm_prime_gem_destroy(obj, msm_obj->sgt);
 	} else {
 		msm_gem_vunmap(obj);
 		put_pages(obj);
 		put_iova_vmas(obj);
-		msm_gem_unlock(obj);
 	}
 
 	drm_gem_object_release(obj);
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index d608339c1643..432032ad4aed 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -229,7 +229,19 @@ msm_gem_unlock(struct drm_gem_object *obj)
 static inline bool
 msm_gem_is_locked(struct drm_gem_object *obj)
 {
-	return dma_resv_is_locked(obj->resv);
+	/*
+	 * Destroying the object is a special case.. msm_gem_free_object()
+	 * calls many things that WARN_ON if the obj lock is not held.  But
+	 * acquiring the obj lock in msm_gem_free_object() can cause a
+	 * locking order inversion between reservation_ww_class_mutex and
+	 * fs_reclaim.
+	 *
+	 * This deadlock is not actually possible, because no one should
+	 * be already holding the lock when msm_gem_free_object() is called.
+	 * Unfortunately lockdep is not aware of this detail.  So when the
+	 * refcount drops to zero, we pretend it is already locked.
+	 */
+	return dma_resv_is_locked(obj->resv) || (kref_read(&obj->refcount) == 0);
 }
 
 static inline bool is_active(struct msm_gem_object *msm_obj)
-- 
2.36.1

