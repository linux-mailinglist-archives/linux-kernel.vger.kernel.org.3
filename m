Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C56754CED0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356704AbiFOQf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239852AbiFOQfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:35:23 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5234E2D1E5;
        Wed, 15 Jun 2022 09:35:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id v17-20020a17090a899100b001ead067eaf9so2672584pjn.0;
        Wed, 15 Jun 2022 09:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXNiK5CoOd5h/K567StuCdpvu1byZQqmWfR+aD9BoLg=;
        b=m2hmwJKhxnLWptIU4bEaOprXB7AjROw7lct5pUQISGmydnU6CeitFPq3Qc9nBe1MQC
         PaaVmblRPW/g2e460HEqDMv1JWHDx+leQItVlqmFT92ZIOQ4mFuHkp/67ZK/on2CWJ57
         7cHTsZBoqA/i8uP47pfHx3HmdrA3/UMF6T5VWr7Saf5m5cn6uTuD64FNpK99mmvImEJp
         Ccu3KzYFY84/TZ/XWD1T0TNUh7Ldx3ruUETmYEfqVSxkJQHNqP4xxrNI8YMsVfFxYGgb
         FUoek2jo46bd3K8MhP0Z1sx8mK3GTsyfPGDDONzkL2tdDHbiUYLQTk06jL6veFjQXxIi
         a0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NXNiK5CoOd5h/K567StuCdpvu1byZQqmWfR+aD9BoLg=;
        b=OofSNZQcoeSd8RrnHMylTElLrbBrcOuGEUO7Ux2GiMQp02MfVXhEFKavbS2fbhEMKp
         VRkU6APmMi4f/KNTmwlX4Fx7NxyWiH1fcWx5NRcLWUMkjxOaGKmXnnWxt1IjbJ7QB0QW
         8Wjf1dWLYg+sfZLigSIRXDnqLtJBfEW/Hh0Iu17s17Od0rqcFTm8bNrIEvN1Bka1LT3L
         QQXnJOSU6oy6EiujBjNEonIFiGG/ERXJk4ZOwwslQDdDTT2Z+nenRE+irF+BQ+t6SJX+
         a9sF7n2RivDWkslJdUSsmBk7NRGW+zz4PQPbeub93Jw/C1DZ/Dg11JZla3uxTu6A6iqZ
         6FeA==
X-Gm-Message-State: AJIora8GH9K/YB55TJJfrBJ+Bo0UYima68aGRVQJBg4ilp6KLgp6xiZh
        YRhyRzEitI/VcShTs23UN2LIGQzGLYI=
X-Google-Smtp-Source: AGRyM1tLwthhtZmarB0uyNajKCWDIJw6HY2FWPaSR5DXQjf5zLnQlXHmthoGVTwOVaURRNFowOIaPw==
X-Received: by 2002:a17:90b:2349:b0:1e3:34f9:87e8 with SMTP id ms9-20020a17090b234900b001e334f987e8mr11146478pjb.217.1655310922780;
        Wed, 15 Jun 2022 09:35:22 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id v15-20020a63bf0f000000b003fdb97e6961sm9909464pgf.28.2022.06.15.09.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:35:21 -0700 (PDT)
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
        Jonathan Marek <jonathan@marek.ca>,
        Emma Anholt <emma@anholt.net>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Fix %d vs %u
Date:   Wed, 15 Jun 2022 09:35:28 -0700
Message-Id: <20220615163532.3013035-1-robdclark@gmail.com>
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

In debugging fence rollover, I noticed that GPU state capture and
devcore dumps were showing me negative fence numbers.  Let's fix that
and some related signed vs unsigned confusion.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index dd044d557c7c..ce3b508b7c2b 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -790,11 +790,11 @@ void adreno_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
 	for (i = 0; i < gpu->nr_rings; i++) {
 		drm_printf(p, "  - id: %d\n", i);
 		drm_printf(p, "    iova: 0x%016llx\n", state->ring[i].iova);
-		drm_printf(p, "    last-fence: %d\n", state->ring[i].seqno);
-		drm_printf(p, "    retired-fence: %d\n", state->ring[i].fence);
-		drm_printf(p, "    rptr: %d\n", state->ring[i].rptr);
-		drm_printf(p, "    wptr: %d\n", state->ring[i].wptr);
-		drm_printf(p, "    size: %d\n", MSM_GPU_RINGBUFFER_SZ);
+		drm_printf(p, "    last-fence: %u\n", state->ring[i].seqno);
+		drm_printf(p, "    retired-fence: %u\n", state->ring[i].fence);
+		drm_printf(p, "    rptr: %u\n", state->ring[i].rptr);
+		drm_printf(p, "    wptr: %u\n", state->ring[i].wptr);
+		drm_printf(p, "    size: %u\n", MSM_GPU_RINGBUFFER_SZ);
 
 		adreno_show_object(p, &state->ring[i].data,
 			state->ring[i].data_size, &state->ring[i].encoded);
-- 
2.36.1

