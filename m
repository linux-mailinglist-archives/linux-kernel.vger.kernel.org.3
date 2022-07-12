Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D645719E2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbiGLMY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiGLMYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:24:18 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEA5A5E52;
        Tue, 12 Jul 2022 05:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657628656; x=1689164656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=NZcIxal9HP23HwdA1OYoFpYvchF31b6+LHpnoM9W5FA=;
  b=pmaJnJqG6JnmtfXgqPqYaN8mOG+7R5GHBUC6b2yY4fmyOeeBQPj+2f8Z
   URKxgqFRKt5+hp9GSW2CZcRgIpEjo3QO6/u/rrbmwgqT860CoX4a2u9bh
   qTeuvTIrokwwrArl7GmaInCCvZ/JS/ZoIcHmMmNWkXT/wOtwTA7nUnI7s
   M=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 12 Jul 2022 05:24:16 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Jul 2022 05:24:14 -0700
X-QCInternal: smtphost
Received: from vboma-linux.qualcomm.com ([10.204.65.94])
  by ironmsg01-blr.qualcomm.com with ESMTP; 12 Jul 2022 17:54:07 +0530
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id BEF5E900883; Tue, 12 Jul 2022 17:54:06 +0530 (IST)
From:   Viswanath Boma <quic_vboma@quicinc.com>
To:     video.upstream.external@qti.qualcomm.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Viswanath Boma <quic_vboma@quicinc.com>
Subject: [PATCH 4/7] venus : Addition of EOS Event support for Encoder
Date:   Tue, 12 Jul 2022 17:53:44 +0530
Message-Id: <20220712122347.6781-4-quic_vboma@quicinc.com>
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

 V4l2 encoder compliance expecting End of sream  Event registration  support for Encoder.

Change-Id: I85f7732a2ec08eba47c0d37181f739e90a7ab63a
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
---
 drivers/media/platform/qcom/venus/venc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index b56960d7f6c89..30ddb84c24997 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -507,6 +507,20 @@ static int venc_enum_frameintervals(struct file *file, void *fh,
 	return 0;
 }
 
+static int venc_subscribe_event(struct v4l2_fh *fh,
+				const struct v4l2_event_subscription *sub)
+{
+
+	switch (sub->type) {
+	case V4L2_EVENT_EOS:
+		return v4l2_event_subscribe(fh, sub, 2, NULL);
+	case V4L2_EVENT_CTRL:
+		return v4l2_ctrl_subscribe_event(fh, sub);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int
 venc_encoder_cmd(struct file *file, void *fh, struct v4l2_encoder_cmd *cmd)
 {
@@ -572,7 +586,7 @@ static const struct v4l2_ioctl_ops venc_ioctl_ops = {
 	.vidioc_g_parm = venc_g_parm,
 	.vidioc_enum_framesizes = venc_enum_framesizes,
 	.vidioc_enum_frameintervals = venc_enum_frameintervals,
-	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
+	.vidioc_subscribe_event = venc_subscribe_event,
 	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
 	.vidioc_encoder_cmd = venc_encoder_cmd,
 };
-- 
2.17.1

