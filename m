Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EF251B3B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbiEDXrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355236AbiEDXnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:43:14 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97899201B6
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 16:39:37 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id i24so2314784pfa.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 16:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcjXks/OZvIeQ48LeUZ4ev10sgtmh+A/DjFdnPkrArc=;
        b=bkT3tVCvUqtfkwZTFOYCuIFr5GfsuH2RuNfy5q7qIlKAzjusR5Eitvd1OX4suoZW+0
         wTAkdVmqLOABMMkpP3JAuJb+PjizMv8UVdZ21s4mXhiWgcKp+C/qfOQUTtlzKfgeY2NC
         uKsJAWTey0OhoScc3BvWdUAr/VUBoVav0ZvLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZcjXks/OZvIeQ48LeUZ4ev10sgtmh+A/DjFdnPkrArc=;
        b=mSiXlVkZqIppMjdoEAxzNs/b4dd1c84Z/6FiKbhG0PrxU6fninWgpOirgYTD+fYF9T
         bJAT12Ubs3YtTu9P6ISA+aWwDc09ub3SaceUJnj/5KiyMAy5Q83bKSck/zftoBCksAR3
         I7ZKWhrzOTxW57Uj3edXSLQw5QbrIt76H94k1/b9Pua7KcsMmyJF6ehwkRWnWHr5Ve6x
         l4JQwJhrjUVPoD5wnaqZ4WCfmjkXfefnlmJaV6COSg3c2s/L6PZefEZ45H+stBAH3qP3
         Yrx7gSFdgGrCcMKrNsSs067DORmZg3xXguXYToFgrW7CMEIA15nwMtJ27B9ZJjqqBSHr
         540Q==
X-Gm-Message-State: AOAM5320a0Aa+B9abdC3GpQ0mKLCnIqzA7IEB9chcXaq/3WWogZVnL75
        +oginSEW+ntg9M6tiD5IAqO5Mg==
X-Google-Smtp-Source: ABdhPJydJo1xmGq3cPW9J7N2vJNGEG+YilKeqMLd+36+LvTQilr9AnAml998OgsrGgm+ZXNXvZOYHQ==
X-Received: by 2002:a63:8348:0:b0:3c6:6c7:9e40 with SMTP id h69-20020a638348000000b003c606c79e40mr2040249pge.224.1651707577099;
        Wed, 04 May 2022 16:39:37 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:1da3:6a8e:557c:da09])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902e74100b0015e8d4eb1bbsm65321plf.5.2022.05.04.16.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 16:39:36 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Xu Wang <vulab@iscas.ac.cn>, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/msm: Fix shutdown
Date:   Wed,  4 May 2022 16:39:30 -0700
Message-Id: <20220504163900.v2.1.Iaebd35e60160fc0f2a50fac3a0bf3b298c0637c8@changeid>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When rebooting on my sc7280-herobrine based device, I got a
crash. Upon debugging, I found that I was in msm_drv_shutdown() and my
"pdev" was the one associated with mdss_probe().

From source, I found that mdss_probe() has the line:
  platform_set_drvdata(pdev, mdss);
...where "mdss" is of type "struct msm_mdss *".

Also from source, I saw that in msm_drv_shutdown() we have the line:
  struct msm_drm_private *priv = platform_get_drvdata(pdev);

This is a mismatch and is the root of the problem.

Further digging made it apparent that msm_drv_shutdown() is only
supposed to be used for parts of the msm display framework that also
call msm_drv_probe() but mdss_probe() doesn't call
msm_drv_probe(). Let's remove the shutdown functon from msm_mdss.c.

Digging a little further, code inspection found that two drivers that
use msm_drv_probe() weren't calling msm_drv_shutdown(). Let's add it
to them.

Fixes: 6874f48bb8b0 ("drm/msm: make mdp5/dpu devices master components")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
---

Changes in v2:
- Fixed the Fixes tag.

 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  | 1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 1 +
 drivers/gpu/drm/msm/msm_mdss.c           | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 143d6643be53..2b9d931474e0 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1350,6 +1350,7 @@ MODULE_DEVICE_TABLE(of, dpu_dt_match);
 static struct platform_driver dpu_driver = {
 	.probe = dpu_dev_probe,
 	.remove = dpu_dev_remove,
+	.shutdown = msm_drv_shutdown,
 	.driver = {
 		.name = "msm_dpu",
 		.of_match_table = dpu_dt_match,
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 9b7bbc3adb97..3d5621a68f85 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -1009,6 +1009,7 @@ MODULE_DEVICE_TABLE(of, mdp5_dt_match);
 static struct platform_driver mdp5_driver = {
 	.probe = mdp5_dev_probe,
 	.remove = mdp5_dev_remove,
+	.shutdown = msm_drv_shutdown,
 	.driver = {
 		.name = "msm_mdp",
 		.of_match_table = mdp5_dt_match,
diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 20f154dda9cf..0454a571adf7 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -397,7 +397,6 @@ MODULE_DEVICE_TABLE(of, mdss_dt_match);
 static struct platform_driver mdss_platform_driver = {
 	.probe      = mdss_probe,
 	.remove     = mdss_remove,
-	.shutdown   = msm_drv_shutdown,
 	.driver     = {
 		.name   = "msm-mdss",
 		.of_match_table = mdss_dt_match,
-- 
2.36.0.464.gb9c8b46e94-goog

