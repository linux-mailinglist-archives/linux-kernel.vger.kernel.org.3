Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7880755AD2D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 00:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiFYWzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 18:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbiFYWzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 18:55:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D3C13F48;
        Sat, 25 Jun 2022 15:55:05 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so8923823pjl.5;
        Sat, 25 Jun 2022 15:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0sMFYlUXA/wvNrdz6yghIiBT/tIS2Mu/kejgpgcpcUk=;
        b=GQt6oqpuPd7BalfkhrFIglCcDVmBgoM6XHzayugipkCTfvQjl515fBlP39DiLFsur3
         myq2zbGCo76BxFBgnhNNAWh9mHReWt6+gRLJOGDl0qyn4cC22OPU/0ukSuEbdcCERIvU
         pcD+ozk7aOV683I80mko7pd+PgiPACsq69uFzBKmzjRDow6YdubYoI4OsfzmkFDbn2eg
         agBI1QNF1bpSGY6Im7LSONGB4a2NXBbWeCGLQ4et26B+ebhYghMLgduwJn+mqMkHkHO0
         J5mRSVf+bxzEFll7zA65xg6QVsR0eH43woejDQZu9mxDM2AtR5oNMeFCvG+h2Tj2KMZ5
         pQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0sMFYlUXA/wvNrdz6yghIiBT/tIS2Mu/kejgpgcpcUk=;
        b=36+GvRN/vUJ8ptjxCL3aOhcdE0MV6drNVZlnRN3aF/8ZQpmm0SyQTYSDyqAbjGS05Q
         97h04Ai9wwVK1w8sx/V/+uvIw+/kJQOGJCB1MglvLB6G6rShikATFh2yVezYuQVAgTYp
         cCpLDFZ1X6vHty6mb5TfMYeRt+tLv3AT/DuDxSM0dOfCrGTSSO6MAecs4FCk+yGCoved
         0v4uiiE6AWxu9Qs2+qsckK68LQTUSB6WpLeMyki4FqHyArhG+oFRHcluVkz9ggjbhSXP
         DGfybWtmmHidbg76/DZa0pbW1QWZzvJcmjMev24VU9p5vc93frmsRA3xrb8V/qpzVs3I
         5jUw==
X-Gm-Message-State: AJIora94vz2cvfdgf0t5UELcCyHw9N7bkPhBKNl6reImQOwn07jWjrVF
        foBmf/jUozmpccySFJIYQew=
X-Google-Smtp-Source: AGRyM1uZjrPT7IbukdgxEedllvo2flhBCmo451rTjSu6KE4nw1gjSM+UMs5lCcNWhxWhTir9koR+wQ==
X-Received: by 2002:a17:90b:1805:b0:1ed:1391:c8b7 with SMTP id lw5-20020a17090b180500b001ed1391c8b7mr12364162pjb.193.1656197705225;
        Sat, 25 Jun 2022 15:55:05 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id w30-20020aa79a1e000000b005253bf1e4d0sm4152412pfj.24.2022.06.25.15.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 15:55:04 -0700 (PDT)
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
Subject: [PATCH 03/15] drm/msm: Reorder lock vs submit alloc
Date:   Sat, 25 Jun 2022 15:54:38 -0700
Message-Id: <20220625225454.81039-4-robdclark@gmail.com>
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

This lets us drop the NORETRY.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index c9e4aeb14f4a..b7c61a99d274 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -36,7 +36,7 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
 	if (sz > SIZE_MAX)
 		return ERR_PTR(-ENOMEM);
 
-	submit = kzalloc(sz, GFP_KERNEL | __GFP_NOWARN | __GFP_NORETRY);
+	submit = kzalloc(sz, GFP_KERNEL);
 	if (!submit)
 		return ERR_PTR(-ENOMEM);
 
@@ -771,25 +771,21 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	trace_msm_gpu_submit(pid_nr(pid), ring->id, submitid,
 		args->nr_bos, args->nr_cmds);
 
-	ret = mutex_lock_interruptible(&queue->lock);
-	if (ret)
-		goto out_post_unlock;
-
 	if (args->flags & MSM_SUBMIT_FENCE_FD_OUT) {
 		out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
 		if (out_fence_fd < 0) {
 			ret = out_fence_fd;
-			goto out_unlock;
+			return ret;
 		}
 	}
 
-	submit = submit_create(dev, gpu, queue, args->nr_bos,
-		args->nr_cmds);
-	if (IS_ERR(submit)) {
-		ret = PTR_ERR(submit);
-		submit = NULL;
-		goto out_unlock;
-	}
+	submit = submit_create(dev, gpu, queue, args->nr_bos, args->nr_cmds);
+	if (IS_ERR(submit))
+		return PTR_ERR(submit);
+
+	ret = mutex_lock_interruptible(&queue->lock);
+	if (ret)
+		goto out_post_unlock;
 
 	submit->pid = pid;
 	submit->ident = submitid;
@@ -965,9 +961,9 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 	if (ret && (out_fence_fd >= 0))
 		put_unused_fd(out_fence_fd);
 	mutex_unlock(&queue->lock);
+out_post_unlock:
 	if (submit)
 		msm_gem_submit_put(submit);
-out_post_unlock:
 	if (!IS_ERR_OR_NULL(post_deps)) {
 		for (i = 0; i < args->nr_out_syncobjs; ++i) {
 			kfree(post_deps[i].chain);
-- 
2.36.1

