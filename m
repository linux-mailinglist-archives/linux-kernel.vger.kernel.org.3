Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B1D57A4DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238640AbiGSRSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbiGSRSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:18:42 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CDE46DB3;
        Tue, 19 Jul 2022 10:18:41 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b9so14163546pfp.10;
        Tue, 19 Jul 2022 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0sMFYlUXA/wvNrdz6yghIiBT/tIS2Mu/kejgpgcpcUk=;
        b=d84EtypEw3YOZPEj14Cy+1tsV890PI9GGysEyTiDevcf/6y9pLX+Tmvpsgqu5AW/tD
         qUDeeVgSBoYVbPh3CWfZKO4OgqcjG6RSiUlTuTtOFVJebfp5S8fdU00WUVwe4fCg3Ifu
         wEGveVZ9GNW56fW9MSs1WoMboIXkYzOfeT7x9GvipJ/BzCWYqMU/4N5At7FcYUPpHd8a
         o8d16yIryXMO3irpgmqMxpnkThB+LVwWueaxLNt9aoFu/Iyr5IWOZOSfWN7HcxaT3/rz
         /y3hsp8rF/ZQc5PQanfKzP6fMdbhUfU9UwzQJ6+7v6x7CxIiphESGfclC17n8EoKEtM6
         WbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0sMFYlUXA/wvNrdz6yghIiBT/tIS2Mu/kejgpgcpcUk=;
        b=dXss3v6duawsqPSDb6gO2N262QmafNJjvioq01cIJmwGHJZpFxLD9NTimX0jGCPmNr
         Y+7dqf6LPw4pBKH4FKZYX1qRE9kr5LIm2VBBKadIUdVWSu0K6M/AyxsU1hVDWeZQYhaF
         Zlj4soDCVJLS/mk/RWN8JwpoVm7lMDD8LpDO8d62vrnxgw6TgjNzW3+pFabTPyEdMZDW
         f4WmhZDb6oE065/OMyaLFFwmIqbm753qewtNzEBSWhDd22FEeCPigq7063acb4hlvwoc
         hJWRd9OLvGyMHjns8HwkybljE47fDKu61jMBM/DbuLlb3iT/S6VdymhrkbTML+qAlbdV
         8PTw==
X-Gm-Message-State: AJIora83EqyNlPUPBBlTKxh1Wa2TYhCSs3z1TOqwu+1UOv0d9Ow0BFPK
        X3y+SFVMlpSEloRVw3J2jAg=
X-Google-Smtp-Source: AGRyM1ua7TCIedMtFkEXgDnLA/rlwx26jhGhXrgdrpp2JJPABfQTwGlNH6fuH4j9MWpjRTpFMF5ESg==
X-Received: by 2002:a63:5620:0:b0:41a:4c1e:a821 with SMTP id k32-20020a635620000000b0041a4c1ea821mr3591003pgb.611.1658251120965;
        Tue, 19 Jul 2022 10:18:40 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id w65-20020a626244000000b0050dc762816dsm11702733pfb.71.2022.07.19.10.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 10:18:40 -0700 (PDT)
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
Subject: [PATCH v2 01/13] drm/msm: Reorder lock vs submit alloc
Date:   Tue, 19 Jul 2022 10:18:45 -0700
Message-Id: <20220719171900.289265-2-robdclark@gmail.com>
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

