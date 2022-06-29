Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EA4560B90
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiF2VTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiF2VTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:19:10 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6DA12755;
        Wed, 29 Jun 2022 14:19:09 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 128so16213094pfv.12;
        Wed, 29 Jun 2022 14:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n2Zdhl1Vth3N791afpZ91OOSQKmJLxwVGhQJiS1zs08=;
        b=X6A1iyb7amxPMTinALXe9WnPvRw9BmErsaGGx5wSw/0hXZZaCfz/DVmu74S5girWgE
         1xZxKJDiSn5IA/bEthWfEZ+MfJAwG7eCqnKFIadsT0BQKA9fQtwX2OKx06xMcgbEXO1Y
         BqlAHohP5LmPnaAiMlcWxyipAY/YO6RVKVsL5wVhXtfZRX6o4/B1EoCTsD/knuQ2pvEC
         sXXz2UYxyEB5ADkdFUZBajYQtrCxSLCGegl+DX2pIK0UKbteu9r9zkSP/KvbGFNQVF8B
         eEzfNxfE9Qsd+YyHwAECfvUgMmDDN1hyXuK0N6R3yAirzjb6hydx+6SXKEMCUXq0NfS7
         uITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n2Zdhl1Vth3N791afpZ91OOSQKmJLxwVGhQJiS1zs08=;
        b=U8ayczgVtCoViQzMopUss9/Xb5Omx/m5MwjeSFeYCYXGEVlMHsorIx6F9W4iKIIN8m
         HDLtCDWEKKot31++7ut1s6I3rDQ0rIXnXrl6064Q9H3xAJ/jFLm4JsQCowGP18bTJPul
         P6QrTPV3aBPAVKWzXln87cvacut4DERbE0LbxLXtXd4m4Ccn/VK/7y9vVmf9bpr51Mr2
         /DTrBPZ4MXsnSjfBQTTMUZoOnGCLNdwWKfjye+m7KZ1h/7qD626sGCGDKy2qWDX3sWvt
         pR9opqGd+H75dvZn93TqpdjVeHYLmxpGvr+aw9qwUzlhNbfPpM3AFVdXOVm/xvAVPfVP
         dfrg==
X-Gm-Message-State: AJIora80jt4YNlmYH3q4yI5917QbhSn3YF9sHUL+u/s8CP2L/9jXST8x
        LqX2vEAa+D+Byk5csZRrwL0=
X-Google-Smtp-Source: AGRyM1tncV+wdkEe9ODsLbjt1i1UurGbKs3QCkDEr9bCikJKDnjX+qkvQ+UuSVzVwb1X86OO0T0qkw==
X-Received: by 2002:a65:4848:0:b0:3fc:52c3:6ca5 with SMTP id i8-20020a654848000000b003fc52c36ca5mr4493416pgs.264.1656537549190;
        Wed, 29 Jun 2022 14:19:09 -0700 (PDT)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id a8-20020a656408000000b003fd1111d73csm11868744pgv.4.2022.06.29.14.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:19:08 -0700 (PDT)
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
Subject: [PATCH 1/2] drm/msm/gpu: Capture all BO addr+size in devcore
Date:   Wed, 29 Jun 2022 14:19:15 -0700
Message-Id: <20220629211919.563585-2-robdclark@gmail.com>
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

It is useful to know what buffers userspace thinks are associated with
the submit, even if we don't care to capture their content.  This brings
things more inline with $debugfs/rd cmdstream dumping.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gpu.c | 36 ++++++++---------------------------
 1 file changed, 8 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index bdee6ea51b73..293f3380fafe 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -221,7 +221,7 @@ static void msm_gpu_devcoredump_free(void *data)
 }
 
 static void msm_gpu_crashstate_get_bo(struct msm_gpu_state *state,
-		struct msm_gem_object *obj, u64 iova, u32 flags)
+		struct msm_gem_object *obj, u64 iova, bool full)
 {
 	struct msm_gpu_state_bo *state_bo = &state->bos[state->nr_bos];
 
@@ -229,8 +229,7 @@ static void msm_gpu_crashstate_get_bo(struct msm_gpu_state *state,
 	state_bo->size = obj->base.size;
 	state_bo->iova = iova;
 
-	/* Only store data for non imported buffer objects marked for read */
-	if ((flags & MSM_SUBMIT_BO_READ) && !obj->base.import_attach) {
+	if (full) {
 		void *ptr;
 
 		state_bo->data = kvmalloc(obj->base.size, GFP_KERNEL);
@@ -276,34 +275,15 @@ static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
 	state->fault_info = gpu->fault_info;
 
 	if (submit) {
-		int i, nr = 0;
-
-		/* count # of buffers to dump: */
-		for (i = 0; i < submit->nr_bos; i++)
-			if (should_dump(submit, i))
-				nr++;
-		/* always dump cmd bo's, but don't double count them: */
-		for (i = 0; i < submit->nr_cmds; i++)
-			if (!should_dump(submit, submit->cmd[i].idx))
-				nr++;
-
-		state->bos = kcalloc(nr,
+		int i;
+
+		state->bos = kcalloc(submit->nr_bos,
 			sizeof(struct msm_gpu_state_bo), GFP_KERNEL);
 
 		for (i = 0; state->bos && i < submit->nr_bos; i++) {
-			if (should_dump(submit, i)) {
-				msm_gpu_crashstate_get_bo(state, submit->bos[i].obj,
-					submit->bos[i].iova, submit->bos[i].flags);
-			}
-		}
-
-		for (i = 0; state->bos && i < submit->nr_cmds; i++) {
-			int idx = submit->cmd[i].idx;
-
-			if (!should_dump(submit, submit->cmd[i].idx)) {
-				msm_gpu_crashstate_get_bo(state, submit->bos[idx].obj,
-					submit->bos[idx].iova, submit->bos[idx].flags);
-			}
+			msm_gpu_crashstate_get_bo(state, submit->bos[i].obj,
+						  submit->bos[i].iova,
+						  should_dump(submit, i));
 		}
 	}
 
-- 
2.36.1

