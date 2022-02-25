Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E234B4C49DE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 16:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242529AbiBYP7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 10:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242508AbiBYP66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 10:58:58 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4218186440;
        Fri, 25 Feb 2022 07:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645804706; x=1677340706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=VDbp786rZJt995Eu/NdhIPojDHjLi2BsoWetqwF1jHE=;
  b=OZRErQREuQ+WKjBCaKwnncBP74vE7k4y3gbHKQOLf5NBiJtMt3NG6/6p
   I88S3psm6id8HOciriHEsybydx3ckEP4rnLh9OKCnf6P0P4Kn2K9n5Sy/
   OtKfl5GVWEqsEj7rY4cWeYHjkbMtVNQ7j7KnV1dZ2+ftKAKDryKM1Oo+9
   8=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 25 Feb 2022 07:58:25 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 25 Feb 2022 07:58:24 -0800
X-QCInternal: smtphost
Received: from vpolimer-linux.qualcomm.com ([10.204.67.235])
  by ironmsg01-blr.qualcomm.com with ESMTP; 25 Feb 2022 21:28:17 +0530
Received: by vpolimer-linux.qualcomm.com (Postfix, from userid 463814)
        id CF14453E9; Fri, 25 Feb 2022 21:28:16 +0530 (IST)
From:   Vinod Polimera <quic_vpolimer@quicinc.com>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com
Subject: [PATCH v2 2/2] drm/msm/disp/dpu1: set mdp clk to the maximum frequency in opp table
Date:   Fri, 25 Feb 2022 21:27:50 +0530
Message-Id: <1645804670-21898-3-git-send-email-quic_vpolimer@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1645804670-21898-1-git-send-email-quic_vpolimer@quicinc.com>
References: <1645804670-21898-1-git-send-email-quic_vpolimer@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use max clock during resume sequence from the opp table.
The clock will be scaled down when framework sends an update.

Fixes: 62fbdce91("arm64: dts: qcom: sc7280: add display dt nodes")

Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index d550f90..3288f52 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1319,6 +1319,7 @@ static int __maybe_unused dpu_runtime_resume(struct device *dev)
 	struct drm_device *ddev;
 	struct dss_module_power *mp = &dpu_kms->mp;
 	int i;
+	unsigned long max_freq = ULONG_MAX;
 
 	ddev = dpu_kms->dev;
 
@@ -1333,6 +1334,8 @@ static int __maybe_unused dpu_runtime_resume(struct device *dev)
 		return rc;
 	}
 
+	dev_pm_opp_find_freq_floor(dev, &max_freq);
+	dev_pm_opp_set_rate(dev, max_freq);
 	dpu_vbif_init_memtypes(dpu_kms);
 
 	drm_for_each_encoder(encoder, ddev)
-- 
2.7.4

