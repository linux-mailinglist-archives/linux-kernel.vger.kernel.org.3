Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D7B4F6D7B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbiDFVyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236794AbiDFVwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:52:35 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD3C6301;
        Wed,  6 Apr 2022 14:46:34 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ch16-20020a17090af41000b001ca867ef52bso5105148pjb.0;
        Wed, 06 Apr 2022 14:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SGa5BVmzMUOjfF5fklYjMnwty8EXXy2NltxcnqNLnSI=;
        b=MvEz2sRys8Cf+kjOTGfK5cpnMa8Cz8YyPjD5o0PIpnAh+WViNlKo1cpH4q/b9Vn17R
         eghzzzCphg03L7+nsjGEU4xuGShLQ/s37990xC/QepF5g/UtHsNjyx7JdVdM/qJ/3vTv
         SwNys3fitq9ckBboY4fplKs+Pbq58I4ZqngUloTpcSdc5eN20XvVEQtzHAMSIZy0y4rb
         HaFFITbgHCz/snKItOzrurDcri37NSNRY1y08Ioi9IlZezhRH4G52RqA0Jd7VoEDY98I
         cwC9bC0aZqXsFHGRpHWlrgl4w+J3xHJIkwn3b8h/ZWD8foE3ojkIs6i2/rZfUU4+Oun5
         J9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SGa5BVmzMUOjfF5fklYjMnwty8EXXy2NltxcnqNLnSI=;
        b=YFyPVXposR419kl75CImYThwGs2FGs7wX9SGi+U/lD+FdjxoROV118eVPmq8+ppAVB
         yFjVeJ3GwKBy9Ed1T43AUKZRXpT4A6CizbCHs9Ii7DKMzdsoTVKdwOaQOFzAx+LMLxZw
         q6R52ZS+Mn6lQDohzDRBsebrRgjz6eX3zBBl6dczDG841/uo9F4dwL3g1E2aFRV05h9P
         WeddQYx3aepBeGSfKm8eR1IUZ0JWTiipAX+bCa/uuu5QYbRh+2xYHaE/yCOAVjy+o9/Y
         3ex/nWfHMwdqofs6KykAiuo3rAF4kDZZjqA8mrRagDIR2hDspT1XBZsdKGj6RxrxCbQc
         6a2w==
X-Gm-Message-State: AOAM532M5Fv8w30J8F27ZPzHqUqfQqpFyOAPIul+EBZeC42P7KMCmmTH
        iFPgyOU2qBIYTaDSW7j+35NWBnJqemc=
X-Google-Smtp-Source: ABdhPJznLjxldtpJNTkYDLuyaByw5EOTGFDXgk+G2XgzI4IV923npb5/84RhqLsmH8lqMsfjZysuqg==
X-Received: by 2002:a17:90b:3652:b0:1ca:b7d1:16b3 with SMTP id nh18-20020a17090b365200b001cab7d116b3mr12389271pjb.34.1649281593606;
        Wed, 06 Apr 2022 14:46:33 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090a3fc600b001ca88b0bdfesm6642463pjm.13.2022.04.06.14.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:46:32 -0700 (PDT)
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
Subject: [PATCH v3 03/10] drm/msm/gem: Convert some missed GEM_WARN_ON()s
Date:   Wed,  6 Apr 2022 14:46:19 -0700
Message-Id: <20220406214636.1156978-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406214636.1156978-1-robdclark@gmail.com>
References: <20220406214636.1156978-1-robdclark@gmail.com>
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

