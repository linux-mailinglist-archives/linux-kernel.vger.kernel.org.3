Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48240587F58
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237453AbiHBPwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237420AbiHBPvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:51:40 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A6E2FFF9;
        Tue,  2 Aug 2022 08:51:37 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 23so12684593pgc.8;
        Tue, 02 Aug 2022 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=UVam+OtTXmVRJOOFcNCglGVq9lRc/LFnzlVeuJ/h90Y=;
        b=BoCEnVzSBi7RAIzSPvWu1Dvtj8JjCONeM/LqyJBSilhAbjziNWpZAwTchX2ZR8ZiDl
         4wVEJGxjI0oMdrAoAVmNDiKqKWp34jLzZGHz53YcrQgAkT3efp2mNUK2jXutL9fskOJp
         bhr528oiHsnAwhtqEx2f9ZGY8lFl9K876+DzX+e6F9xJpjz8WsAde4ikphP+JohNbOtO
         /ox2q+RvnzA9tcWwlJaiDlYoeaQpH2rvcvkd7jF2OVfBLSazlc4J3YSBF0pueFMSmGjH
         yHzndD6KRy9zu/X+UMSDSrsyuoUFv8zd5XBAr5fE8PFRT6SlKALwRjIU3szAUegzLGl3
         zD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=UVam+OtTXmVRJOOFcNCglGVq9lRc/LFnzlVeuJ/h90Y=;
        b=tuvevTNVaHleFDBhYrjVqpM8HLyU1NnFrxOklh6TDtLdizhKB9pP4l8T4yvLSJ0ZUW
         AZpNssFrouF1RWsj8tvY1Mx2EuU5TJ1/6M0gYHhfdPYiopyliv2Nzti5TEAH0AF6WwX0
         fW8/vPCx8R0E1JLVVmYN1XnOhwVvZTyrWHX7gq3mXwqbYkp/HQ8ryIld6IjeUy3+uiHi
         /SXI+r2dI3tBTB7xKBEXfpkRYCJeJkHN1UiprVXRMOSXMTM494v8WXmmYoGrDhbyjzUU
         o7xQP308kUpVnTp4yzb2h06BMypmnE0hwXXWlcAqQxer7wF4FR/YXeHGpGtGZz/nf9Ao
         PVuQ==
X-Gm-Message-State: AJIora/oGwpLP+rWunlmMT+ySUBI8ebzPiC7BZeusQVkO6wddiZDL2D9
        bAUNm4fyYrP71GzlRPBFzkTZxQ8xEVI=
X-Google-Smtp-Source: AGRyM1suvrACZI+8um7dDawoDINq49y8ixC51+7RqQbVR7tOyRb4TqHa90P8pk/gPS8JWY8Y7cVpeA==
X-Received: by 2002:a05:6a00:b4c:b0:52a:f6e7:818b with SMTP id p12-20020a056a000b4c00b0052af6e7818bmr21411240pfo.26.1659455496396;
        Tue, 02 Aug 2022 08:51:36 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id ck16-20020a17090afe1000b001f209699d89sm11202793pjb.18.2022.08.02.08.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:51:35 -0700 (PDT)
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
Subject: [PATCH v4 07/15] drm/msm/gem: Consolidate pin/unpin paths
Date:   Tue,  2 Aug 2022 08:51:40 -0700
Message-Id: <20220802155152.1727594-8-robdclark@gmail.com>
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

Avoid having multiple spots where we increment/decrement pin_count (and
associated LRU updating)

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 3da64c7f65a2..407b18a24dc4 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -190,7 +190,7 @@ static struct page **msm_gem_pin_pages_locked(struct drm_gem_object *obj)
 
 	p = get_pages(obj);
 	if (!IS_ERR(p)) {
-		msm_obj->pin_count++;
+		to_msm_bo(obj)->pin_count++;
 		update_lru(obj);
 	}
 
@@ -213,9 +213,7 @@ void msm_gem_unpin_pages(struct drm_gem_object *obj)
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
 	msm_gem_lock(obj);
-	msm_obj->pin_count--;
-	GEM_WARN_ON(msm_obj->pin_count < 0);
-	update_lru(obj);
+	msm_gem_unpin_locked(obj);
 	msm_gem_unlock(obj);
 }
 
@@ -436,14 +434,13 @@ int msm_gem_pin_vma_locked(struct drm_gem_object *obj, struct msm_gem_vma *vma)
 	if (GEM_WARN_ON(msm_obj->madv != MSM_MADV_WILLNEED))
 		return -EBUSY;
 
-	pages = get_pages(obj);
+	pages = msm_gem_pin_pages_locked(obj);
 	if (IS_ERR(pages))
 		return PTR_ERR(pages);
 
 	ret = msm_gem_map_vma(vma->aspace, vma, prot, msm_obj->sgt, obj->size);
-
-	if (!ret)
-		msm_obj->pin_count++;
+	if (ret)
+		msm_gem_unpin_locked(obj);
 
 	return ret;
 }
-- 
2.36.1

