Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BF7552DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348452AbiFUJGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346012AbiFUJGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:06:48 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57D215A34;
        Tue, 21 Jun 2022 02:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655802408; x=1687338408;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=K61hZq+5YAjJeBhqEVmDHQoYLRAUk2L5vlwYe0VhwEA=;
  b=k5aNZkgjWWyMaaZtXdMmPa0ycqqRhgb4aoICVWZ340bZOE20MG6HakT7
   ZRxT8WIL1PUziANEMtRmzNo3DR89zc1kEsInENxqfbfFHPZGufZT6nxrI
   P86102htxVnwnKTylc5m+IITaFoe/C1tfp3qGETPw/cVCutC2BQSEr6MM
   M=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 21 Jun 2022 02:06:48 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Jun 2022 02:06:45 -0700
X-QCInternal: smtphost
Received: from kalyant-linux.qualcomm.com ([10.204.66.210])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Jun 2022 14:36:30 +0530
Received: by kalyant-linux.qualcomm.com (Postfix, from userid 94428)
        id 2CFC741B2; Tue, 21 Jun 2022 02:06:29 -0700 (PDT)
From:   Kalyan Thota <quic_kalyant@quicinc.com>
To:     y@qualcomm.com, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Cc:     Kalyan Thota <quic_kalyant@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_vpolimer@quicinc.com, dmitry.baryshkov@linaro.org,
        quic_abhinavk@quicinc.com
Subject: [v1 1/2] drm/msm/disp/dpu1: add dspp support for sc7280
Date:   Tue, 21 Jun 2022 02:06:26 -0700
Message-Id: <1655802387-15275-1-git-send-email-quic_kalyant@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <y>
References: <y>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add destination side post processing hw block support in sc7280.

This hwblock enablement is necessary to support color features
like CT Matix (Ex: Night Light feature)

Change-Id: Iba7d5e1693b06cede2891f5b998466070a77c6ef
Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index a4fe77c..021eb2f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -928,7 +928,7 @@ static const struct dpu_lm_cfg sm8150_lm[] = {
 
 static const struct dpu_lm_cfg sc7280_lm[] = {
 	LM_BLK("lm_0", LM_0, 0x44000, MIXER_SC7180_MASK,
-		&sc7180_lm_sblk, PINGPONG_0, 0, 0),
+		&sc7180_lm_sblk, PINGPONG_0, 0, DSPP_0),
 	LM_BLK("lm_2", LM_2, 0x46000, MIXER_SC7180_MASK,
 		&sc7180_lm_sblk, PINGPONG_2, LM_3, 0),
 	LM_BLK("lm_3", LM_3, 0x47000, MIXER_SC7180_MASK,
@@ -1792,6 +1792,8 @@ static void sc7280_cfg_init(struct dpu_mdss_cfg *dpu_cfg)
 		.ctl = sc7280_ctl,
 		.sspp_count = ARRAY_SIZE(sc7280_sspp),
 		.sspp = sc7280_sspp,
+		.dspp_count = ARRAY_SIZE(sc7180_dspp),
+		.dspp = sc7180_dspp,
 		.mixer_count = ARRAY_SIZE(sc7280_lm),
 		.mixer = sc7280_lm,
 		.pingpong_count = ARRAY_SIZE(sc7280_pp),
-- 
2.7.4

