Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7BB587F45
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbiHBPvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiHBPvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:51:22 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986DE18367;
        Tue,  2 Aug 2022 08:51:21 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 12so12707365pga.1;
        Tue, 02 Aug 2022 08:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0sMFYlUXA/wvNrdz6yghIiBT/tIS2Mu/kejgpgcpcUk=;
        b=QhffYyjcWnjYLPwBjsriZPzqgu1BVBqKuCmvl6T++1mJy47oPOFf0+O+nUMsJcr7k+
         iv6xi+pVebH6fO1Co6ZrG26mIE/wFc//uVYI3wTapnnRB0zoKv3giOauEVcR68HIDs6O
         iQZjnfU+B+MdeNbAT/HlqplnYniHOFBw1Dp3dwcG9dq/G9ig3u1AgaBDBA94SJoze+CU
         0Rbwl1sM+VC7Mo2Vz+ybyPmKzSok4oDvyGR+wYYEYd7IMdx+3/Vj8Nb2pbRO0/iD/0AX
         bWDjNV89jF6M2fU4zFsEeH6UaXCPfUKymx2zedVyMfylgaFlofvwUC3b5oMS+ryBIn0i
         +9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0sMFYlUXA/wvNrdz6yghIiBT/tIS2Mu/kejgpgcpcUk=;
        b=ksbI/F9AlzVgNJjns5FDiE/2LXOrJqe7FuqjEt3uiTPH9jQC+a1R6I4cNuucWDzzsv
         kYtY2Dlab4DZ+yu9ihItYHSEHi3s6op6D0cnp37iJhbcm7T0qc/9Pbxej6y1vnv7LrpC
         Rmw4fEQzz08zX0G780S8ExyTVkkjXpwdWsD8ojd5BeciFqC9qDhqRqRIMnnt7CX5D/HT
         98AhDSKF8e9ifq55qCulow9072rBZFycounq2OtemSX60DX8J/knjTAHJJD8on3cFPb2
         Cj1wfeo/DpMCuVtes0g5EQpw93zlrpSD2rjoV1V8JepXWjFuCz2l10EnI/FBclYztgls
         Uq0Q==
X-Gm-Message-State: ACgBeo2WFTNRl8XeNgczOPT/iBeTcN/P4SSgzw3V65gagTrHWgxoW+Rv
        XV51aI4aqa2R2MAcI4QvEX4=
X-Google-Smtp-Source: AA6agR6rcDJDhvHJ166iKlgdxWV6djHRkq1yorJlZyS1sgkkWqCGcAl4IEbOloIhRp46PbcH+Fn4mQ==
X-Received: by 2002:a63:83c1:0:b0:41c:192e:68f2 with SMTP id h184-20020a6383c1000000b0041c192e68f2mr8179318pge.606.1659455481019;
        Tue, 02 Aug 2022 08:51:21 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id x16-20020a17090a165000b001f334aa9170sm9537315pje.48.2022.08.02.08.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:51:20 -0700 (PDT)
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
Subject: [PATCH v4 01/15] drm/msm: Reorder lock vs submit alloc
Date:   Tue,  2 Aug 2022 08:51:34 -0700
Message-Id: <20220802155152.1727594-2-robdclark@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220802155152.1727594-1-robdclark@gmail.com>
References: <20220802155152.1727594-1-robdclark@gmail.com>
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

