Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1015719E5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiGLMYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiGLMYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:24:18 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F398A5E46;
        Tue, 12 Jul 2022 05:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657628657; x=1689164657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=WubKUJ4j12eFTZdYGCF0XxgkVzipXBW3gt8uczrmXCM=;
  b=D6yR6bP+KYnp3mHt000oq1Rd+NdJvj0CVMT7iC5+MJqBmHYt8CbXWTWm
   rNrl4bBbf1z40GHc1JMjEd7QPsWTbD6eSaLc8GJDgkUQ0U+jZ5b2K0hJr
   0EBsD57kXVzIFwFqJeS4Xg12hL2bhCEnt669rDD+Y1M6MjX+0uOdQXI5I
   0=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 12 Jul 2022 05:24:16 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Jul 2022 05:24:14 -0700
X-QCInternal: smtphost
Received: from vboma-linux.qualcomm.com ([10.204.65.94])
  by ironmsg01-blr.qualcomm.com with ESMTP; 12 Jul 2022 17:54:11 +0530
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 77B85900883; Tue, 12 Jul 2022 17:54:10 +0530 (IST)
From:   Viswanath Boma <quic_vboma@quicinc.com>
To:     video.upstream.external@qti.qualcomm.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Viswanath Boma <quic_vboma@quicinc.com>
Subject: [PATCH 6/7] venus : Remove the capture plane settings for venc_g_parm/venc_s_parm
Date:   Tue, 12 Jul 2022 17:53:46 +0530
Message-Id: <20220712122347.6781-6-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220712122347.6781-1-quic_vboma@quicinc.com>
References: <20220712122347.6781-1-quic_vboma@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v4l2 compliance expecting settings for out buffer only and the same
 values will be propagated to capture buffer setting by h/w encoder .
 settings on cpature plane are optional , required only if
 offline-encoding supports.

 error details : fail: v4l2-test-formats.cpp(1350): !ret

Change-Id: I3d33bf1443cb5b20c3be6ce7c86df53aafb7918e
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
---
 drivers/media/platform/qcom/venus/venc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 4f10f5de7e3e6..420691f71121e 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -390,7 +390,7 @@ static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
 	struct v4l2_fract *timeperframe = &out->timeperframe;
 	u64 us_per_frame, fps;
 
-	if (a->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE &&
+	if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT &&
 	    a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
 		return -EINVAL;
 
@@ -422,7 +422,7 @@ static int venc_g_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
 {
 	struct venus_inst *inst = to_inst(file);
 
-	if (a->type != V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE &&
+	if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT &&
 	    a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
 		return -EINVAL;
 
-- 
2.17.1

