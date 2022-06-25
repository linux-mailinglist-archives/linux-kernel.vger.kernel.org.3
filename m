Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7306255AD38
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 00:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiFYWzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 18:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbiFYWz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 18:55:26 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D8E13F4E;
        Sat, 25 Jun 2022 15:55:21 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 23so5659169pgc.8;
        Sat, 25 Jun 2022 15:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVam+OtTXmVRJOOFcNCglGVq9lRc/LFnzlVeuJ/h90Y=;
        b=IAhdRKg3wq32mnlusa8itT5j46bSw9XZvICjmv6qzqx3ihb0k18YtsvJ9pv5AnYsiE
         upVCMq8I+5PAKNimjSpuQ6XPiQG3N9qa7mAeRGB9s7CwnE3DoviY27XD5sqvfDHZ4Nkf
         zVMujpzshIWAFBlYTYrFc9q56eHrdNx45XKwEh/ahh+bZvVdIDIbjcHuDy2peQvuPlif
         Z5m9OrjQ0btB+MMpt1MCjnqtxlrKg6Xnw+MoZkJgW49rmB3n1jaG9fmilTU3knT+roFv
         Vn4uBH52BfUb9YXg56XqC+dchDK57hQ/d/+q43gaAktx4gHxTdxhpQtHoodt0X0TM+ZC
         cZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVam+OtTXmVRJOOFcNCglGVq9lRc/LFnzlVeuJ/h90Y=;
        b=YoKduwH0Xeowvr1ZHoLPmXYvkmBj8de+I5A8evqnLiG2mYcH8kqijdWztgumcggU4k
         wN1Y4sCljioxFQhoWbCR86EvHdKMy5K1rgBhJ4WswK6u/vOyH8a9dlR9T3P7COBeNoDC
         rLH8GI9Pa7DWbB1VboybdbOea7CS0QvKjobwFBZ7WCHlGNNXOW6SX71nKLDTlKzzzSlI
         dPuuU21ecL2Up9QOVx+dD7TcoG26tQlStoV7ke5KzxpgqbNTivAHj/YN9k+K5wdBIaK8
         42UFSMp2GzUwin6CKkdiUKLscjegj7/dIGZojT37e2qN1iClOeB6F2rcnxyt1zd6AhCR
         tRBg==
X-Gm-Message-State: AJIora+v1Ti8foT3Hc+bj751C31KW6ewGVJJnnQ/C3aNFvXJXgybyq85
        ytncQbpOdt9H45hLZsNiNV4=
X-Google-Smtp-Source: AGRyM1vJfS4+n8zLuln5hMJjECb+kROUTmxBGlhggzcyYs1vAP2R+nd5a1cbQBRWp0l+C057exRgnQ==
X-Received: by 2002:a05:6a00:234f:b0:525:1f7c:f2bf with SMTP id j15-20020a056a00234f00b005251f7cf2bfmr6603024pfj.14.1656197721362;
        Sat, 25 Jun 2022 15:55:21 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id n24-20020a170902969800b0016a034ae481sm4197148plp.176.2022.06.25.15.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 15:55:20 -0700 (PDT)
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
Subject: [PATCH 09/15] drm/msm/gem: Consolidate pin/unpin paths
Date:   Sat, 25 Jun 2022 15:54:44 -0700
Message-Id: <20220625225454.81039-10-robdclark@gmail.com>
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

