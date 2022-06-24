Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E90D55A117
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiFXSpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiFXSpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:45:18 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C14362710;
        Fri, 24 Jun 2022 11:45:16 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id l4so3145922pgh.13;
        Fri, 24 Jun 2022 11:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2PJf9ZqRPQG5hDGmci7MSLL4PtNxINmMcqph4ZWlr04=;
        b=jXC2+LI0A2PyLqhkgdZINUMyFwAOJeqF4mFW2PL3mHngL8oxti+0LA2nwoV+XGBY7U
         P9s6b9HcySIZ2AD7j2bNedeADazLvFNVoClgcFPHfoRfsFRohhSsnTd6QL0c12VFDlXJ
         9BEszLvKhHZCQXyR717cbQ7OCpa81vAkyFSQ6uolQMgvpaHmzSQ0pNhlCooNGpf2S43s
         XrxaWgS8NjXRYeuP0D+osvjmk2ThPimDmZH6p49iZk2fRchwr5MuwtqsVvCDQMClNqU1
         bTIZn9E/TTVTZxSUnqouCCoLIoWwxXsPIkV9lqboA+leXFrXXBzbzjBAGTUgNSSmFblI
         4zQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2PJf9ZqRPQG5hDGmci7MSLL4PtNxINmMcqph4ZWlr04=;
        b=11bVkVHALN1Rwl/8dxsoJ5/KdH6R/cQsdS/SwuK2BKYR4nbrmnYM80LYOs4GXcbF+8
         PlC8bwsu+bf95wmIFVyRWjGHtq9R3JXfO1mhLwXdKcXs7zvtYp3MAIUs038JdNmf/D9H
         UWAJm1LaO9CusTaU9D3nzCMzSnKyYWs/TxfHcqDwsfpq9C2uuMlykEJ3i0lispZzYUlz
         C+Jo56ZsbwVWHE0e+eYyRm3iMliozDkapDcxn+xIrgKLcET/kqT63MlJCTqsPfrZzoEd
         vWcqS01oW7I5wEqYqTfTd5snqkkVFoipUMMx4sM8Im/qVu5Fbz8ZS1tmuQifAeTgMYao
         5u7w==
X-Gm-Message-State: AJIora/ojiwFHU4rr02R4aQsj2/NzqZe5/ssJlKu/0ns1sezsa9ZL71h
        uzf5oXcfDV+SlHv124odcG0/W5S0tb8=
X-Google-Smtp-Source: AGRyM1tkOLhGf4SvybcPUuKUjF3i9l9HXNkyA6Q7ggGzOp7H0Rifvhib5L2DGPqO1fC+16R/pvEpDA==
X-Received: by 2002:a05:6a00:1ac7:b0:525:4ef2:175 with SMTP id f7-20020a056a001ac700b005254ef20175mr548025pfv.50.1656096315791;
        Fri, 24 Jun 2022 11:45:15 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902650800b00168a651316csm2130525plk.270.2022.06.24.11.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 11:45:14 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/gem: Fix error return on fence id alloc fail
Date:   Fri, 24 Jun 2022 11:45:28 -0700
Message-Id: <20220624184528.4036837-1-robdclark@gmail.com>
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

This was a typo, we didn't actually want to return zero.

Fixes: a61acbbe9cf8 ("drm/msm: Track "seqno" fences by idr")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 3c3a0cfade36..c9e4aeb14f4a 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -928,7 +928,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 						    INT_MAX, GFP_KERNEL);
 	}
 	if (submit->fence_id < 0) {
-		ret = submit->fence_id = 0;
+		ret = submit->fence_id;
 		submit->fence_id = 0;
 	}
 
-- 
2.36.1

