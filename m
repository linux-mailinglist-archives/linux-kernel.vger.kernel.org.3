Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A97C4D55A0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344832AbiCJXql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344551AbiCJXqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:46:37 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E6119E00A;
        Thu, 10 Mar 2022 15:45:36 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so6660434pju.2;
        Thu, 10 Mar 2022 15:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OXegA51qD+CyYO9M7fSmY5tcIBfLmUdoHlbWl+RWLYA=;
        b=Uya5BbF/Dea3p/slOxGOh0T5z35dl1DZwLwD64KB0b7uIeODxa63MztEUsLQQTBK5d
         D+RjR/B/DCsuUXe5VTqlL/sVZ3iPPAX+wmHNi4zmP0hvbQTRdsGTuBd7ORxEdJMxQFeg
         f1xCP90/4jcWi0d1L6liTOs8x1pwQLwnFecjcadNtFhxQA3ZKwLSWrUu/BOxU9K6a3IA
         iIADELN9Zu4tKQm0yfuEuHJKcQTydAKZJJMSbstWPtbiAgwGHFuqDWEF4jWAYDsCX00/
         F58vxhlnFriX7g9PPn/gcLj609Pg+h+n3ssPGc2FC26qCmURAEBWNMbfrkTooHiy+UVs
         /neA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OXegA51qD+CyYO9M7fSmY5tcIBfLmUdoHlbWl+RWLYA=;
        b=hZmhq0fztMAJugpCtlZupoZ78a6pJxz7fehiHl4rlw5rr5fonC3p3GkqqHIXDlhDON
         4pRrnBNQzzVitoDDgnQ4HAyOX+B+tlp7KKKM9QXpTP41mmf/Ps+P9MoYS0bpReSE7B21
         RSP/Tgrvm3d61JZd79Df3hbUoIuGhTn6+uTWBeYJi8NUWKl8VPxUWn28eKeVPz85KJfW
         KODOqfxqipNq/+chRIfsN0J1VALzeijRSeN0uyfKfOi5wl3wEuokICnfa9xEy76znqd7
         gjcy+YQY30FUTj6Xg+b5i089bSa2lga7nVw7Lhg4ixtM3AlBaz4AItyWQENHSNTYf30o
         FFbQ==
X-Gm-Message-State: AOAM533ofemZxKV7376MlXF879vIDdIosM3YHYTo/C2Qv7pRzxR592NT
        shMYPWfp152tsr9Y+ElkSxM=
X-Google-Smtp-Source: ABdhPJyMokPnWrLeEdPTbchYVoLn7v3pddlxvswdSoMvVNd5x9sSPY6XLBlteAA4HXr/Z8aINByJyA==
X-Received: by 2002:a17:90b:4b47:b0:1be:fccf:d1a8 with SMTP id mi7-20020a17090b4b4700b001befccfd1a8mr7586614pjb.33.1646955935191;
        Thu, 10 Mar 2022 15:45:35 -0800 (PST)
Received: from localhost ([2601:1c0:5200:a6:307:a401:7b76:c6e5])
        by smtp.gmail.com with ESMTPSA id p125-20020a622983000000b004f6c5d58225sm8252049pfp.90.2022.03.10.15.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 15:45:34 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] drm/msm/gpu: Rename runtime suspend/resume functions
Date:   Thu, 10 Mar 2022 15:46:04 -0800
Message-Id: <20220310234611.424743-2-robdclark@gmail.com>
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

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 89cfd84760d7..8859834b51b8 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -600,7 +600,7 @@ static const struct of_device_id dt_match[] = {
 };
 
 #ifdef CONFIG_PM
-static int adreno_resume(struct device *dev)
+static int adreno_runtime_resume(struct device *dev)
 {
 	struct msm_gpu *gpu = dev_to_gpu(dev);
 
@@ -616,7 +616,7 @@ static int active_submits(struct msm_gpu *gpu)
 	return active_submits;
 }
 
-static int adreno_suspend(struct device *dev)
+static int adreno_runtime_suspend(struct device *dev)
 {
 	struct msm_gpu *gpu = dev_to_gpu(dev);
 	int remaining;
@@ -635,7 +635,7 @@ static int adreno_suspend(struct device *dev)
 
 static const struct dev_pm_ops adreno_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(adreno_suspend, adreno_resume, NULL)
+	SET_RUNTIME_PM_OPS(adreno_runtime_suspend, adreno_runtime_resume, NULL)
 };
 
 static struct platform_driver adreno_driver = {
-- 
2.35.1

