Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19735818ED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239661AbiGZRuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbiGZRuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:50:19 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348F01837C;
        Tue, 26 Jul 2022 10:50:18 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id v18so852687plo.8;
        Tue, 26 Jul 2022 10:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0sMFYlUXA/wvNrdz6yghIiBT/tIS2Mu/kejgpgcpcUk=;
        b=qKzbaVbj2FqDQNpoZXlQDXFmYvzhQt9kBkAgNM5HpdZcgiFRDhU0/4Qj7uc9AbTFzm
         LpCGdtiKh31TqhbhfY8oNi1QybojWeRNFmGtMP6QIMwLXqzlpFsCe1BrG5qPfoncZKJm
         FnWc7dWSDJpS4S1ulnwyyhO5mhakPmTr7k5oPC+ERKTlerG6uZ2yZzSsjxH4+YgytEAW
         zbF1LxjqA4Bu9u+OxhYGOpedTE4qXRHrzjgNt082tSsWNcCq1RE6R5qrLespsop+ifF+
         CN40MpZ4Cvh3bPohGU4kswtdTihEhHPKJENdXb1bhcyqMOadR3ND5J19VZCAFdJwTeq5
         pCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0sMFYlUXA/wvNrdz6yghIiBT/tIS2Mu/kejgpgcpcUk=;
        b=M1/HH/ft2gBghLHPd2mp64vgRPbiu2E3kY9V8kaV13Ww6TvWISYwJLnw2sPalZR9Sm
         sS6ZkwyS/gnee7X9G0+S94WY1IEpK3yBt5EHjeHOUdoWCYGGnDqLiDTMijl+FZAXXMjB
         GETEjdLgIk+lqdyuUhip1lvJKeVUS7Rj9/i1evGS3B9p4/ePCWGzbPVtEAHneGmC2wAH
         7svmCud073VTBBDkWG9NIzIeR/RujdQUzX6H2huwgpeVVTmFkZ8TevK3p9TpyfeulRhs
         rdZaAVoF86N7ORmDbyKK67jrBCDjKIKGcWBAb7IcOvR9PHVsvOvdmOqktbOnHoG88FGH
         1aPg==
X-Gm-Message-State: AJIora8LV5gqFyVwBkRT7ZGrAvFW49U5t5pOyUWWzIoaTMRP9+FucGV9
        5pKBnRyVqlQv5avpNwFBTzg=
X-Google-Smtp-Source: AGRyM1sZDbuBr9wwnSiGFXCobcSa90BEIVqoUlk917vKZ8OD+txMCJFw3yYMZvIZ7BBOke9bm4mE4A==
X-Received: by 2002:a17:90b:3a8d:b0:1f2:bda7:da0d with SMTP id om13-20020a17090b3a8d00b001f2bda7da0dmr347806pjb.102.1658857817633;
        Tue, 26 Jul 2022 10:50:17 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id lp6-20020a17090b4a8600b001f2173d897asm371289pjb.43.2022.07.26.10.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 10:50:16 -0700 (PDT)
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
Subject: [PATCH v3 01/15] drm/msm: Reorder lock vs submit alloc
Date:   Tue, 26 Jul 2022 10:50:25 -0700
Message-Id: <20220726175043.1027731-2-robdclark@gmail.com>
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

