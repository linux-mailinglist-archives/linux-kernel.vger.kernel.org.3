Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92025859CD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbiG3Jly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbiG3JlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:41:23 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8559B167C4;
        Sat, 30 Jul 2022 02:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659174082; x=1690710082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=burYLZ2wEq5G7eIec0n1L7h1e9hZ66FpmzZiqkY+HqM=;
  b=opppkFuQB62NHFHdX6kc68JB0/FBmbgBTdO+BiTJ5prjtNltkDp981lp
   6JhghijxXUKmtVB096jT/DeLv+x39jwIBDXpcWNr5o+U8BO3OAz5qOo/q
   VXRwCMa6kats8Mt/qdG3fXUGRKLX9uRSPRKjFBtjJVpDUD7yaumQd8dI2
   A=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 30 Jul 2022 02:41:22 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 02:41:21 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 30 Jul 2022 02:41:20 -0700
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 30 Jul 2022 02:41:15 -0700
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Douglas Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/8] drm/msm: Take single rpm refcount on behalf of all submits
Date:   Sat, 30 Jul 2022 15:10:45 +0530
Message-ID: <20220730150952.v3.2.Ifee853f6d8217a0fdacc459092bbc9e81a8a7ac7@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1659174051-27816-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1659174051-27816-1-git-send-email-quic_akhilpo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of separate refcount for each submit, take single rpm refcount
on behalf of all the submits. This makes it easier to drop the rpm
refcount during recovery in an upcoming patch.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---

(no changes since v1)

 drivers/gpu/drm/msm/msm_gpu.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index c8cd9bf..e1dd3cc 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -663,11 +663,12 @@ static void retire_submit(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
 	mutex_lock(&gpu->active_lock);
 	gpu->active_submits--;
 	WARN_ON(gpu->active_submits < 0);
-	if (!gpu->active_submits)
+	if (!gpu->active_submits) {
 		msm_devfreq_idle(gpu);
-	mutex_unlock(&gpu->active_lock);
+		pm_runtime_put_autosuspend(&gpu->pdev->dev);
+	}
 
-	pm_runtime_put_autosuspend(&gpu->pdev->dev);
+	mutex_unlock(&gpu->active_lock);
 
 	msm_gem_submit_put(submit);
 }
@@ -756,14 +757,17 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 
 	/* Update devfreq on transition from idle->active: */
 	mutex_lock(&gpu->active_lock);
-	if (!gpu->active_submits)
+	if (!gpu->active_submits) {
+		pm_runtime_get(&gpu->pdev->dev);
 		msm_devfreq_active(gpu);
+	}
 	gpu->active_submits++;
 	mutex_unlock(&gpu->active_lock);
 
 	gpu->funcs->submit(gpu, submit);
 	gpu->cur_ctx_seqno = submit->queue->ctx->seqno;
 
+	pm_runtime_put(&gpu->pdev->dev);
 	hangcheck_timer_reset(gpu);
 }
 
-- 
2.7.4

