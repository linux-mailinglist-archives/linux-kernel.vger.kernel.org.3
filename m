Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333E14D55A8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344856AbiCJXqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344854AbiCJXqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:46:45 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B0819E03F;
        Thu, 10 Mar 2022 15:45:43 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id s8so6431524pfk.12;
        Thu, 10 Mar 2022 15:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sc+BLeBhOeunpwNV1naAxApoyho4RIVwZsup23KixGA=;
        b=i/kCIR2M9+f6iR0IxrdfD6uzdUTkXYHeSmmSe0xEfqNmiGuvFwvEa9Rhc7SjtoyDRm
         iSWmf2YUwJTqDGe5yr62zNAIiPpSnKRmbpMcjNLvMsY5+aM8+89n6AjSPTudJ35s0cJ/
         cDBM6keO22ne0gjnhQGSRsVh3eyxL68tm3z7MsqZgKk9hEN2wBW+GYS5nQ81KHZBpB0U
         C4Oq5c3OhQiC3wPgyLyYCR5OQ8I894o2dkYOtOIBXyh4UkGY+Ko+6mEPpwpaiHban9ou
         FuN7FOqQk45kn4IvAWIWVJ7ZQs1Nstlv+EjKVvMQ2F7RPEnvRR0zDpw9qgXZPs/dM8Cw
         Jx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sc+BLeBhOeunpwNV1naAxApoyho4RIVwZsup23KixGA=;
        b=4cmVGO+nAFvQyL8eJHwg2DLyVBNztombRvxryklM8YPxM1cWZRPsd7/4mKI8l+KJYZ
         l+sSYs3kG9P3xobH++4Rj/lbJc05DbCy1I/y140xT/Ffl94BQA60kusUghtCxBHZRzmT
         zJ+UHj5ckB2C7P1qBfGof6pmBAOS0AVB2gfXt61S+o2/v8Yv5OENVqMA8HxFQTEXGlUQ
         9RBTsudRRBOSxprCfUQqzHCyhHgmZLxhi2gwk4mfcMk6mMP2+/hJ17n3ny8/1WDphyOx
         QIQcJe20ZcRlTw3xsRqbkDv9nBY3ggwxzM3ET0dyoQoNShD/cVrpQrC0CGU2JvWmaLuQ
         3qqw==
X-Gm-Message-State: AOAM533JbAKBwaSC4UtPoNQTNrZ9LkidgnZ9K9Q2uMKDv7oS6UPxVji9
        Rj6Um1nhlgZqap60s4gZTxCct/M1b5E=
X-Google-Smtp-Source: ABdhPJyrhezjAT6CU0w7i5q6gN4DLMtI4haYY25Kw92sxxE/XVe1+QHeusf/BWUEj++yK+OMlHBWTw==
X-Received: by 2002:a63:89:0:b0:37c:54f9:25b6 with SMTP id 131-20020a630089000000b0037c54f925b6mr6190197pga.494.1646955942569;
        Thu, 10 Mar 2022 15:45:42 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id q14-20020a056a00150e00b004f741b5c071sm8767891pfu.86.2022.03.10.15.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 15:45:41 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] drm/msm/gpu: Remove mutex from wait_event condition
Date:   Thu, 10 Mar 2022 15:46:06 -0800
Message-Id: <20220310234611.424743-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310234611.424743-1-robdclark@gmail.com>
References: <20220310234611.424743-1-robdclark@gmail.com>
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

The mutex wasn't really protecting anything before.  Before the previous
patch we could still be racing with the scheduler's kthread, as that is
not necessarily frozen yet.  Now that we've parked the sched threads,
the only race is with jobs retiring, and that is harmless, ie.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 0440a98988fc..661dfa7681fb 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -607,15 +607,6 @@ static int adreno_runtime_resume(struct device *dev)
 	return gpu->funcs->pm_resume(gpu);
 }
 
-static int active_submits(struct msm_gpu *gpu)
-{
-	int active_submits;
-	mutex_lock(&gpu->active_lock);
-	active_submits = gpu->active_submits;
-	mutex_unlock(&gpu->active_lock);
-	return active_submits;
-}
-
 static int adreno_runtime_suspend(struct device *dev)
 {
 	struct msm_gpu *gpu = dev_to_gpu(dev);
@@ -669,7 +660,7 @@ static int adreno_system_suspend(struct device *dev)
 	suspend_scheduler(gpu);
 
 	remaining = wait_event_timeout(gpu->retire_event,
-				       active_submits(gpu) == 0,
+				       gpu->active_submits == 0,
 				       msecs_to_jiffies(1000));
 	if (remaining == 0) {
 		dev_err(dev, "Timeout waiting for GPU to suspend\n");
-- 
2.35.1

