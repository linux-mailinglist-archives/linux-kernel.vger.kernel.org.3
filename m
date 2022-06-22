Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E23355551F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 21:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376858AbiFVTzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 15:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233302AbiFVTzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 15:55:41 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D065F2F034;
        Wed, 22 Jun 2022 12:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655927740; x=1687463740;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=2xf/FWcxnZUDXgio8gfJjR4b5NBPlvVQvX05MnYgdqs=;
  b=akAU/4VRsayoDQ5cyWQW/u+D1AZ1MMOaf+Cl3hkOEK3vwrZvdekBDlen
   I35yDvXCLetBRZdY+BkND0SACKq5Q3y2E3tK+b3RO8StL9SIJSLgQbYQj
   V+Oa/R7auS0AUvQTxzx7YtiAF0GXY3Hv2bJUSLyO+2ReUV2bGShKLburn
   s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Jun 2022 12:55:40 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 12:55:40 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 22 Jun 2022 12:55:39 -0700
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 22 Jun 2022 12:55:38 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <dianders@chromium.org>, <vkoul@kernel.org>, <daniel@ffwll.ch>,
        <airlied@linux.ie>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <bjorn.andersson@linaro.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_khsieh@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] drm/msm/dp: reset drm_dev to NULL at dp_display_unbind()
Date:   Wed, 22 Jun 2022 12:55:31 -0700
Message-ID: <1655927731-22396-1-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During msm initialize phase, dp_display_unbind() will be called to undo
initializations had been done by dp_display_bind() previously if there is
error happen at msm_drm_bind. Under this kind of circumstance, drm_device
may not be populated completed which causes system crash at drm_dev_dbg().
This patch reset drm_dev to NULL so that following drm_dev_dbg() will not
refer to any internal fields of drm_device to prevent system from crashing.
Below are panic stack trace,

[   53.584904] Unable to handle kernel paging request at virtual address 0000000070018001
.
[   53.702212] Hardware name: Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+) (DT)
[   53.710445] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   53.717596] pc : string_nocheck+0x1c/0x64
[   53.721738] lr : string+0x54/0x60
[   53.725162] sp : ffffffc013d6b650
[   53.728590] pmr_save: 000000e0
[   53.731743] x29: ffffffc013d6b650 x28: 0000000000000002 x27: 0000000000ffffff
[   53.739083] x26: ffffffc013d6b710 x25: ffffffd07a066ae0 x24: ffffffd07a419f97
[   53.746420] x23: ffffffd07a419f99 x22: ffffff81fef360d4 x21: ffffff81fef364d4
[   53.753760] x20: ffffffc013d6b6f8 x19: ffffffd07a06683c x18: 0000000000000000
[   53.761093] x17: 4020386678302f30 x16: 00000000000000b0 x15: ffffffd0797523c8
[   53.768429] x14: 0000000000000004 x13: ffff0000ffffff00 x12: ffffffd07a066b2c
[   53.775780] x11: 0000000000000000 x10: 000000000000013c x9 : 0000000000000000
[   53.783117] x8 : ffffff81fef364d4 x7 : 0000000000000000 x6 : 0000000000000000
[   53.790445] x5 : 0000000000000000 x4 : ffff0a00ffffff04 x3 : ffff0a00ffffff04
[   53.797783] x2 : 0000000070018001 x1 : ffffffffffffffff x0 : ffffff81fef360d4
[   53.805136] Call trace:
[   53.807667]  string_nocheck+0x1c/0x64
[   53.811439]  string+0x54/0x60
[   53.814498]  vsnprintf+0x374/0x53c
[   53.818009]  pointer+0x3dc/0x40c
[   53.821340]  vsnprintf+0x398/0x53c
[   53.824854]  vscnprintf+0x3c/0x88
[   53.828274]  __trace_array_vprintk+0xcc/0x2d4
[   53.832768]  trace_array_printk+0x8c/0xb4
[   53.836900]  drm_trace_printf+0x74/0x9c
[   53.840875]  drm_dev_dbg+0xfc/0x1b8
[   53.844480]  dp_pm_suspend+0x70/0xf8
[   53.848164]  dpm_run_callback+0x60/0x1a0
[   53.852222]  __device_suspend+0x304/0x3f4
[   53.856363]  dpm_suspend+0xf8/0x3a8
[   53.859959]  dpm_suspend_start+0x8c/0xc0

Fixes: a65c95ff88f2 ("drm/msm/dp: stop event kernel thread when DP unbind")
Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 2b72639..02fff70 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -316,6 +316,8 @@ static void dp_display_unbind(struct device *dev, struct device *master,
 
 	dp_power_client_deinit(dp->power);
 	dp_aux_unregister(dp->aux);
+	dp->drm_dev = NULL;
+	dp->aux->drm_dev = NULL;
 	priv->dp[dp->id] = NULL;
 }
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

