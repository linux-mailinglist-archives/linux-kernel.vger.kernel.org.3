Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1F7581902
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239812AbiGZRu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239719AbiGZRuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:50:46 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3050B3134E;
        Tue, 26 Jul 2022 10:50:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id o12so13846794pfp.5;
        Tue, 26 Jul 2022 10:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVam+OtTXmVRJOOFcNCglGVq9lRc/LFnzlVeuJ/h90Y=;
        b=oFM3qcef0UrtwoUQpFLwuAqGgPddV/OrqybzZuPT93TR2DT36gdpEczUOyjwvntM1w
         9GHBp0hS4jsevM/OOdFK1ksSanwvcayuLU3p1y37o1c5CqkEoIM87qXwiKQl8mc98yE5
         I/9f9rUx6tUu4B2JrwbAO9tg+7ZwXmLRssZEvhWkOGS5EEmas/iGJLnx8ZaW/DpZoGRs
         2sn0Yb+J/I0tm9IUF79FwOC+0+kT1UEkLrp668+L+Py9mxDqfRNx+EcNLydL1c1Z8KP7
         m4jSOf3FsiRsVh+cKAsxEukBSeSoyY8lFuF9Ho6YqbzRIT6XQy6zs8NOgoPIFzuFA7ET
         fkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVam+OtTXmVRJOOFcNCglGVq9lRc/LFnzlVeuJ/h90Y=;
        b=d4f1AbAZCFcSG7eXVGwnoZaiiL/w74J0OuYhU2yincqg9xRgh/GyifbpZdVhsIijOV
         Tgv4Qe34TX6s+Tg8ysb3hvRuxP9ISEowdi+yCqJcjU8G951PCxt+51ZyFVmKcCmkeDSG
         ixQT+U0exd3xL2fs/AxKysyjpSimQZChOb35T/vqXsdmYB4b9FiivPwG0AgDbuPFh8WT
         1rVLOtq7fAe3m5GTLdfFbZ0XcwA10HtYtJw/ZJtKlVV8zJYqz7TB+wQFIM3kCqW8BvcH
         4DE46X1lDAvhnzyilAkb6rDO5zGFFFELfUnP/XEikX8jh744+UUXW/SdOoxb4s1NyPqO
         Q+9A==
X-Gm-Message-State: AJIora9o1OxtUSzo/7liLraQTjC39LZU5TIImaS+Q5wYCnizGaZzPqqH
        i6Nh4vFP7NHcHDKBV/vFsS8=
X-Google-Smtp-Source: AGRyM1thoGmetx5EzT1Yghxen/ubJ8Ysu0MSl3NADJmMTKowzZ5lzxTdb1KgOzIFyqMqC/S5LQqzAA==
X-Received: by 2002:a63:6a89:0:b0:419:d863:321a with SMTP id f131-20020a636a89000000b00419d863321amr15870269pgc.9.1658857835302;
        Tue, 26 Jul 2022 10:50:35 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id n7-20020a056a00212700b0052ab0a73752sm11989037pfj.198.2022.07.26.10.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:50:34 -0700 (PDT)
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
Subject: [PATCH v3 07/15] drm/msm/gem: Consolidate pin/unpin paths
Date:   Tue, 26 Jul 2022 10:50:31 -0700
Message-Id: <20220726175043.1027731-8-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220726175043.1027731-1-robdclark@gmail.com>
References: <20220726175043.1027731-1-robdclark@gmail.com>
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

