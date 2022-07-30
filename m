Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126215859D1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbiG3Jlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbiG3Jl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:41:28 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5392911C14;
        Sat, 30 Jul 2022 02:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659174087; x=1690710087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=x5l1wkmdsRZBunkWcYFQkbtqD5PkHotLXuooX3FGyRs=;
  b=wtuBP6QsoxN2hAfVqcn/DJpwgrmy/c26jvAD3rWr6mJcgVfFKV/S9QjN
   yZ2BvS6ie8b6TeKTjGJz81TOSVAai3s+/HMV9alhHNKEepUfNt659cVZa
   C7Vh6V7eWrtNA68P2fM3C5dfQTk9BXQA5sB8gH9RLieK1GTuaS1cXULbO
   M=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 30 Jul 2022 02:41:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 02:41:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 30 Jul 2022 02:41:26 -0700
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 30 Jul 2022 02:41:21 -0700
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
Subject: [PATCH v3 3/8] drm/msm: Correct pm_runtime votes in recover worker
Date:   Sat, 30 Jul 2022 15:10:46 +0530
Message-ID: <20220730150952.v3.3.Ib07ecec3d5c17cb0e1efa6fcddaaa019ec2fb556@changeid>
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

In the scenario where there is one a single submit which is hung, gpu is
power collapsed when it is retired. Because of this, by the time we call
reover(), gpu state would be already clear. Fix this by correctly
managing the pm runtime votes.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---

(no changes since v1)

 drivers/gpu/drm/msm/msm_gpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index e1dd3cc..1945efb 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -398,7 +398,6 @@ static void recover_worker(struct kthread_work *work)
 	/* Record the crash state */
 	pm_runtime_get_sync(&gpu->pdev->dev);
 	msm_gpu_crashstate_capture(gpu, submit, comm, cmd);
-	pm_runtime_put_sync(&gpu->pdev->dev);
 
 	kfree(cmd);
 	kfree(comm);
@@ -446,6 +445,8 @@ static void recover_worker(struct kthread_work *work)
 		}
 	}
 
+	pm_runtime_put_sync(&gpu->pdev->dev);
+
 	mutex_unlock(&gpu->lock);
 
 	msm_gpu_retire(gpu);
-- 
2.7.4

