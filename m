Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F6F57A4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238867AbiGSRTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbiGSRTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:19:06 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C583A57275;
        Tue, 19 Jul 2022 10:18:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c3so13255835pfb.13;
        Tue, 19 Jul 2022 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVam+OtTXmVRJOOFcNCglGVq9lRc/LFnzlVeuJ/h90Y=;
        b=ZBhwD7ytYU8o+a2Bt2oJHeG9MY40h6GSVLZqXzGXTC0FFRkECyQUdR7BCabQaLBaYg
         7d0/+Arfy1ACzhn0His7fTdu34dZxSC327lOlWQq8ssDW3XXLRVK/WpBrr98LHXPvw6z
         SK4isVMaL8HQiH6CB9T3e3aBK5BX0cbpBcDImxm30hhGsSgH24tVRlpqQFqOFFLBoA0/
         hDchYdRDp5FC/mEwqjiWoEBUv83V+UHPKRsoihuk010s54MtfIITOBBLcXl3n8Wwhwyg
         9pKmGGmB5biVLhfrOKUfj4M8ZqAJBxSnynwmbr2hCUQVaAW3lJmL6hymNjcX8ukUvPly
         ceHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVam+OtTXmVRJOOFcNCglGVq9lRc/LFnzlVeuJ/h90Y=;
        b=kI6o2Q1qQeA3/Ji3I0IrWSHcBfbgDX2nVAbRRFuP4QTfvh8xC3S7YHmwgj/J2xKvdo
         5J+GPbfgSLkqSEXiK81m7SHmQ5y9iPnvUKCk34sTfjlchEgolyD7D7POoCtpB9SbHsTt
         +7MxS3lab8x3dUw7uygM6EWx7QvZJ2iiCoK94RN7howchyOtLekOQvqKwkzbEquCe0ck
         N+L578RxEe/OqN/DzmgDdJVCvwRephN8YnIeBxN2SyFZYhw40X9tjdi0aaXI4hREWVeq
         d9wr0TzxGbic/uajVLf2bZdqdDCaoWEHD46RXlQ/tIMHN3azPKofRyWVP/rS1wxC4HGB
         EAuQ==
X-Gm-Message-State: AJIora+AQTO8/NLA9tAV5ESxJRv3q/tO70tWQ7J6e/JcSFX8VMUx+nLb
        EQL/ACronZAzStIiQOi3SkhCOalBz/4=
X-Google-Smtp-Source: AGRyM1ujYcxPDjQPBqvE6HN7KMwZ0j+SwqlhLBBk4FEbT8ggh686jbNbt4OEn2htkgDny2yEA6sthw==
X-Received: by 2002:aa7:961d:0:b0:528:ce2b:d9ce with SMTP id q29-20020aa7961d000000b00528ce2bd9cemr35016532pfg.83.1658251137144;
        Tue, 19 Jul 2022 10:18:57 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id x23-20020a1709027c1700b001696751796asm11896202pll.139.2022.07.19.10.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 10:18:56 -0700 (PDT)
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
Subject: [PATCH v2 07/13] drm/msm/gem: Consolidate pin/unpin paths
Date:   Tue, 19 Jul 2022 10:18:51 -0700
Message-Id: <20220719171900.289265-8-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220719171900.289265-1-robdclark@gmail.com>
References: <20220719171900.289265-1-robdclark@gmail.com>
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

