Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C45598DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 22:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345855AbiHRUW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 16:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345754AbiHRUWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 16:22:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD601C0E56;
        Thu, 18 Aug 2022 13:22:48 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27IJxADI025815;
        Thu, 18 Aug 2022 20:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=12kXdZRBTG5i3DXr6DYowut10y2IN98X+YP+fIDvAdo=;
 b=lJlChWm9iTlmENNqCqfnH2fj1a69c3AZo4RaiG0KFV2EhdX2dus5Mrsc/ORNt62msZw7
 ZADQKKKrLsbLs1C1d0kk3TKrO73P7IkCoOQFbTaQxZzpRVj0/Tg5yYBmmJ4nchXu9A+W
 zw8jQcbH6x2QWLvIGpRDizLfbSQxDLHhZiuDn1dBclc+JauslNz3YFPs25ioFmbDsM85
 dxI0G/WpwfduBXCAlTPt5ion1fa1x1ItFycwE+vHzJpgIR+mtObmSWZBP4+qApOneqlh
 zjfNXynvs0Povn14lXq46MEWHLWHmMuuRU+cX1AdgcHLJ4UHcBoTP7OnilXP0hqzj0/y aA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j1hbqajje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 20:22:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 27IKMfkE020534
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 20:22:41 GMT
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 18 Aug 2022 13:22:36 -0700
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
CC:     Jordan Crouse <jordan@cosmicpenguin.net>,
        Matthias Kaehlcke <mka@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Douglas Anderson <dianders@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        "Abhinav Kumar" <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 2/7] drm/msm: Take single rpm refcount on behalf of all submits
Date:   Fri, 19 Aug 2022 01:52:10 +0530
Message-ID: <20220819015030.v5.2.Ifee853f6d8217a0fdacc459092bbc9e81a8a7ac7@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1660854135-1667-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1660854135-1667-1-git-send-email-quic_akhilpo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lPYInJLnPaqCCjbnJZ0JJLp38LnaqMoK
X-Proofpoint-ORIG-GUID: lPYInJLnPaqCCjbnJZ0JJLp38LnaqMoK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_14,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180074
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

(no changes since v3)

Changes in v3:
- New patch

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

