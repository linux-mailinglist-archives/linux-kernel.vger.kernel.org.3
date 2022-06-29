Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32493560B8E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiF2VTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiF2VTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:19:14 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2D512741;
        Wed, 29 Jun 2022 14:19:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id w24so16805088pjg.5;
        Wed, 29 Jun 2022 14:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+Uwf6eQjQK058s1L2C++JQ0GBO1KImV4TiG9qRxWtw=;
        b=mVmuzUMDRrBJK9xwOiiziy5zE88qL0C/KMDcIMMNmU4pZj1mhmGf7EdWVJmET6PlPt
         KrGFxAYShAmk6btJUE5o3MUTAYc0tdGVx7A4Rzs8bzulZkxez9VUVwegDyU9J8yh6Bsf
         PO78/ehntJEH+3bhU6/7r+VU/IUpN5/wI91whybvSbjKuJe/LkGXN3esaucGNk2x1yyd
         7cJaxAJb5c/ziPb+WUnPt0XcPALlmaIGNoHmkRwCKgP8iS8ENkWqS1tPZT/zzJSOVZEq
         nqZOiJJhnbm8tyX43Z2+6N1ZO+0nRRqgtPa+juv3PhEBttwaMIgRZ3hvW1g/2O2OBahe
         U8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+Uwf6eQjQK058s1L2C++JQ0GBO1KImV4TiG9qRxWtw=;
        b=DXsLvLT4DaQXdSHBo7t75T9STbmWdUJ2sWPBvvS+HetiYrT5XNNDUUlBnWczxzMvps
         YdOLTvU/Bp1kZ5xRO6shuymuE78OhcKv9eI7k1xgAZ3MNnm2oSaG3c6OrUkEvXmPay52
         8PhHhjL1UWcXJGqxPAWDAa184lHwxkfVr9q9YhgnFkYMLUgmEYrZ34eJklwR3n1eE481
         zVsgy3vGvKnb5ccMoB7CskWKPbPbpsktYvjebz5F+OB7bmZAED+uy4H1VNcYRNcxYtLl
         XP2UQd/RgYkn2A96IPoeFT++zSd4SVerSWuWuHeahuJCayMs+2D/HSA/Sj4tStOBg+oc
         EXbA==
X-Gm-Message-State: AJIora+X7N/d5w5yqV1M9PiGyZypsQ+ac1F8IxzgfnvNciqRkLC7LLY+
        39alwBfI2cweblSei5LsU/ya2ML776A=
X-Google-Smtp-Source: AGRyM1tS7i5vwWTt5lfaXv/i3Vu4G1d7d58QYntNci+z9/AHoAI3GSJpl870upg1wxSaM3vy9Mr9Jw==
X-Received: by 2002:a17:903:1c4:b0:16a:73fd:3c6c with SMTP id e4-20020a17090301c400b0016a73fd3c6cmr10961913plh.115.1656537552990;
        Wed, 29 Jun 2022 14:19:12 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id cp19-20020a056a00349300b005254ea64d4bsm11822958pfb.55.2022.06.29.14.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:19:11 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Emma Anholt <emma@anholt.net>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/msm/gpu: Add GEM debug label to devcore
Date:   Wed, 29 Jun 2022 14:19:16 -0700
Message-Id: <20220629211919.563585-3-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220629211919.563585-1-robdclark@gmail.com>
References: <20220629211919.563585-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

When trying to understand an iova fault devcore, once you figure out
which buffer we accessed beyond the end of, it is useful to see the
buffer's debug label.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 1 +
 drivers/gpu/drm/msm/msm_gpu.c           | 4 ++++
 drivers/gpu/drm/msm/msm_gpu.h           | 1 +
 3 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index dff33f0558f3..382fb7f9e497 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -824,6 +824,7 @@ void adreno_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
 			drm_printf(p, "  - iova: 0x%016llx\n",
 				state->bos[i].iova);
 			drm_printf(p, "    size: %zd\n", state->bos[i].size);
+			drm_printf(p, "    name: %-32s\n", state->bos[i].name);
 
 			adreno_show_object(p, &state->bos[i].data,
 				state->bos[i].size, &state->bos[i].encoded);
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 293f3380fafe..fba85f894314 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -229,6 +229,10 @@ static void msm_gpu_crashstate_get_bo(struct msm_gpu_state *state,
 	state_bo->size = obj->base.size;
 	state_bo->iova = iova;
 
+	BUILD_BUG_ON(sizeof(state_bo->name) != sizeof(obj->name));
+
+	memcpy(state_bo->name, obj->name, sizeof(state_bo->name));
+
 	if (full) {
 		void *ptr;
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index b837785cdb04..4816caed22d0 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -476,6 +476,7 @@ struct msm_gpu_state_bo {
 	size_t size;
 	void *data;
 	bool encoded;
+	char name[32];
 };
 
 struct msm_gpu_state {
-- 
2.36.1

