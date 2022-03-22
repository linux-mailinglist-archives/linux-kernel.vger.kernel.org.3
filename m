Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FE04E378C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbiCVD3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiCVD26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:28:58 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18500E8864;
        Mon, 21 Mar 2022 20:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647919650; x=1679455650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=5oVRZuucaffVlCcq38pjgMlQwwxBCMH83akkiqAngfI=;
  b=gBB8+0x+xqlrSGo/gDZ0zWYXwlfcNWDoDFg92KOIJQXkcJ8DJFbI9Lcm
   LvMiGkAveMw6oVqPHB2CEOSHF6a9eJ7r9UyWE38xiads2w4S2urK7Pqk3
   8A49IHQ/7u5lfjuLmPpBKQQmeaOwXPX0v9P1Cm4izcyo1eyDWDYC/K+lw
   k=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 21 Mar 2022 20:27:30 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Mar 2022 20:27:28 -0700
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg02-blr.qualcomm.com with ESMTP; 22 Mar 2022 08:57:13 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 2E7BD34EC; Tue, 22 Mar 2022 08:57:13 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dmitry.baryshkov@linaro.org, dianders@chromium.org,
        quic_kalyant@quicinc.com
Subject: [PATCH v7 1/5] drm/msm/disp/dpu1: set mdp clk to the maximum frequency in opp table during probe
Date:   Tue, 22 Mar 2022 08:57:07 +0530
Message-Id: <1647919631-14447-2-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647919631-14447-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1647919631-14447-1-git-send-email-quic_vpolimer@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set mdp clock to max clock rate during probe/bind sequence from the
opp table so that rails are not at undetermined state. Since we do not
know what will be the rate set in boot loader, it would be ideal to
vote at max frequency. There could be a firmware display programmed
in bootloader and we want to transition it to kernel without underflowing.
The clock will be scaled down later when framework sends an update.

Fixes: 25fdd5933e4c ("drm/msm: Add SDM845 DPU support")
Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index e29796c..9c346ce 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1202,7 +1202,9 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *ddev = priv->dev;
 	struct dpu_kms *dpu_kms;
+	struct dev_pm_opp *opp;
 	int ret = 0;
+	unsigned long max_freq = ULONG_MAX;
 
 	dpu_kms = devm_kzalloc(&pdev->dev, sizeof(*dpu_kms), GFP_KERNEL);
 	if (!dpu_kms)
@@ -1225,6 +1227,12 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
 	}
 	dpu_kms->num_clocks = ret;
 
+	opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
+	if (!IS_ERR(opp))
+		dev_pm_opp_put(opp);
+
+	dev_pm_opp_set_rate(dev, max_freq);
+
 	platform_set_drvdata(pdev, dpu_kms);
 
 	ret = msm_kms_init(&dpu_kms->base, &kms_funcs);
-- 
2.7.4

