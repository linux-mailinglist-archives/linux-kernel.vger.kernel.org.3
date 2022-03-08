Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9934F4D1DF4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 17:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbiCHQ41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 11:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348297AbiCHQ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:56:18 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD8A4EF51;
        Tue,  8 Mar 2022 08:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646758522; x=1678294522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Krx54VrV7dlrLmC7GO6l/PqPdu8mz9flBFKLOOJ8Ybs=;
  b=ef5k9NhdnXjzprtMR3b7seTByuzuTBNJpfp3olYqve1oZQJPr2D0vA/N
   dXErw/CErHMEEeJvcRwdHNSsw3Q4yUam7k5883Wffi8LK0ol/U8M1W+Fg
   mdGJH4Anl4iPvIOmoPjjWZLrjiUHlGlBgNY2pu2nSE59W09Ny7TaKjWc0
   M=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 08 Mar 2022 08:55:21 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 08 Mar 2022 08:55:19 -0800
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg02-blr.qualcomm.com with ESMTP; 08 Mar 2022 22:25:05 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id 94A1C53F1; Tue,  8 Mar 2022 22:25:02 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com
Subject: [PATCH v5 5/5] drm/msm/disp/dpu1: set mdp clk to the maximum frequency in opp table during probe
Date:   Tue,  8 Mar 2022 22:25:00 +0530
Message-Id: <1646758500-3776-6-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646758500-3776-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1646758500-3776-1-git-send-email-quic_vpolimer@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use max clock during probe/bind sequence from the opp table.
The clock will be scaled down when framework sends an update.

Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index d550f90..d9922b9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1221,6 +1221,7 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
 	struct dpu_kms *dpu_kms;
 	struct dss_module_power *mp;
 	int ret = 0;
+	unsigned long max_freq = ULONG_MAX;
 
 	dpu_kms = devm_kzalloc(&pdev->dev, sizeof(*dpu_kms), GFP_KERNEL);
 	if (!dpu_kms)
@@ -1243,6 +1244,8 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
 		return ret;
 	}
 
+	dev_pm_opp_find_freq_floor(dev, &max_freq);
+	dev_pm_opp_set_rate(dev, max_freq);
 	platform_set_drvdata(pdev, dpu_kms);
 
 	ret = msm_kms_init(&dpu_kms->base, &kms_funcs);
-- 
2.7.4

