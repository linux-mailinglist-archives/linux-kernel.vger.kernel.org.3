Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180E14ECE87
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351145AbiC3Utt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351131AbiC3Utq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:49:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD59746B2B;
        Wed, 30 Mar 2022 13:48:00 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id jx9so21906944pjb.5;
        Wed, 30 Mar 2022 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SGa5BVmzMUOjfF5fklYjMnwty8EXXy2NltxcnqNLnSI=;
        b=DSd0Nzz9hIrhZxIZfNCcmrP6ngFJEnXjmtoQvedf5AXNAco5uLpIdKfMnlFhduseHm
         ghdLVjUhcyu+e1ldHlAqMbqU+D/xstz3gB16jtbSryEdaXLNy44Aud1Uyr8hUDLIvxKJ
         bKZ+rbXZt2JSjOCWFu1wfmmUopJu7uW8SicjmuK+3Z1G3CAxIwxGJiUp+EHDrmZxC8LZ
         BFc7YfLczqNkUfPtfqyMxkf7GqmUzMt+rUYEp7+0jJ6gmOUEQuo2Ra8qRrc8eKo5Nida
         ll7sQlqQ0Hz8mi6RrtbNn8Xdw69ESHzWNJCkWHvxeS7upUM1aD9ca9AjgLm/ZnIPlnJm
         ydXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SGa5BVmzMUOjfF5fklYjMnwty8EXXy2NltxcnqNLnSI=;
        b=xUpdeIbIGeRsuw4K0oM3hZ22M6BypWE3tqdiGKxw0BV7XAiGy9erOUmvjzIiEJ9WS9
         RgoI1j7ICvKW4mFYCKkkIBbSUZPnRDbZ0NhAeDkBCY2Q6ZKW74Nc5x1O4WKNlmVXnxhp
         c8WqBQOuvlyStHuw+u73nqZxl0xR3IT+jG10t8wA3nxAOs+3QqfVkrCAve2ouFbHGfC2
         Gm4hf6Z/g9esa6kary3ShsQ6rYHSFIFJFugkWAr/gNx1mOFrp96ykODC15COnz8lJKvd
         SQevc46y60xMnG3g4RdYNUGbmmFy1XhOnfBRBWvovrKSOwmp5X8XZFkeeiOpUhV3aCK7
         lUoA==
X-Gm-Message-State: AOAM531cnQfr1sAlC56EO08oXjfGh+jt4lxjm8O1tjEvCMlBdIt7qrQe
        X0H/rFiTuCm0KuKXN1M6oDU=
X-Google-Smtp-Source: ABdhPJz4skMp1REpP6c7Chg16yU1uOCWTgymMz/5cLiay5QYtR+SyDD1L5Qm4FsQDK0GEkCXZL4plw==
X-Received: by 2002:a17:902:d4c1:b0:153:d493:3f1 with SMTP id o1-20020a170902d4c100b00153d49303f1mr1601609plg.102.1648673280201;
        Wed, 30 Mar 2022 13:48:00 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id y9-20020a056a00180900b004faa45a2230sm25216397pfa.210.2022.03.30.13.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 13:47:59 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 03/10] drm/msm/gem: Convert some missed GEM_WARN_ON()s
Date:   Wed, 30 Mar 2022 13:47:48 -0700
Message-Id: <20220330204804.660819-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330204804.660819-1-robdclark@gmail.com>
References: <20220330204804.660819-1-robdclark@gmail.com>
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

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index f914ddbaea89..64906594fc65 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -44,7 +44,7 @@ void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
 	unsigned size = vma->node.size << PAGE_SHIFT;
 
 	/* Print a message if we try to purge a vma in use */
-	if (WARN_ON(vma->inuse > 0))
+	if (GEM_WARN_ON(vma->inuse > 0))
 		return;
 
 	/* Don't do anything if the memory isn't mapped */
@@ -61,7 +61,7 @@ void msm_gem_purge_vma(struct msm_gem_address_space *aspace,
 void msm_gem_unmap_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma)
 {
-	if (!WARN_ON(!vma->iova))
+	if (!GEM_WARN_ON(!vma->iova))
 		vma->inuse--;
 }
 
@@ -73,7 +73,7 @@ msm_gem_map_vma(struct msm_gem_address_space *aspace,
 	unsigned size = npages << PAGE_SHIFT;
 	int ret = 0;
 
-	if (WARN_ON(!vma->iova))
+	if (GEM_WARN_ON(!vma->iova))
 		return -EINVAL;
 
 	/* Increase the usage counter */
@@ -100,7 +100,7 @@ msm_gem_map_vma(struct msm_gem_address_space *aspace,
 void msm_gem_close_vma(struct msm_gem_address_space *aspace,
 		struct msm_gem_vma *vma)
 {
-	if (WARN_ON(vma->inuse > 0 || vma->mapped))
+	if (GEM_WARN_ON(vma->inuse > 0 || vma->mapped))
 		return;
 
 	spin_lock(&aspace->lock);
@@ -120,7 +120,7 @@ int msm_gem_init_vma(struct msm_gem_address_space *aspace,
 {
 	int ret;
 
-	if (WARN_ON(vma->iova))
+	if (GEM_WARN_ON(vma->iova))
 		return -EBUSY;
 
 	spin_lock(&aspace->lock);
-- 
2.35.1

