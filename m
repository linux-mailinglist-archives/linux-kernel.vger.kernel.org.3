Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706565719D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiGLMYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbiGLMYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:24:15 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42D8A5E4B;
        Tue, 12 Jul 2022 05:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657628655; x=1689164655;
  h=from:to:cc:subject:date:message-id;
  bh=2yikxSz6ZKr6BUHyL9FxMlsxNJSMOiov0y0jJpxJzvk=;
  b=rHT12QZlUxE/h+tZOj6Dd7zXCJjMU+3Wo7q2BcCLLhtyrIRyKA70bnMh
   CSDtb8xjNtuqceizI5fGWGni6PI23eDdk4Y9O3OUMopn4ZL7f3OfU8P/q
   LcrcWGqaQD8wmFAzfzdP7H3Po19m6d5o1forg4MmRpDQJfc/kyHRfeSL9
   4=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 12 Jul 2022 05:24:14 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Jul 2022 05:24:13 -0700
X-QCInternal: smtphost
Received: from vboma-linux.qualcomm.com ([10.204.65.94])
  by ironmsg01-blr.qualcomm.com with ESMTP; 12 Jul 2022 17:54:00 +0530
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id B69F1900883; Tue, 12 Jul 2022 17:53:59 +0530 (IST)
From:   Viswanath Boma <quic_vboma@quicinc.com>
To:     video.upstream.external@qti.qualcomm.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Viswanath Boma <quic_vboma@quicinc.com>
Subject: [PATCH 1/7] venus : Add default values for the control V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY
Date:   Tue, 12 Jul 2022 17:53:41 +0530
Message-Id: <20220712122347.6781-1-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanimir Varbanov <stanimir.varbanov@linaro.org>

 V4l2 encoder compliance expecting default values of colormetry for the control.

Change-Id: I1db0d4940b54e033d646ce39d60dc488afba8d58
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
---
 drivers/media/platform/qcom/venus/venc_ctrls.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index ea5805e71c143..37ba7d97f99b2 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -352,6 +352,8 @@ static const struct v4l2_ctrl_ops venc_ctrl_ops = {
 int venc_ctrl_init(struct venus_inst *inst)
 {
 	int ret;
+	struct v4l2_ctrl_hdr10_mastering_display p_hdr10_mastering = { {34000, 13250, 7500 },
+	{ 16000, 34500, 3000 }, 15635,	16450, 10000000, 500 };
 
 	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 58);
 	if (ret)
@@ -580,7 +582,7 @@ int venc_ctrl_init(struct venus_inst *inst)
 
 	v4l2_ctrl_new_std_compound(&inst->ctrl_handler, &venc_ctrl_ops,
 				   V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY,
-				   v4l2_ctrl_ptr_create(NULL));
+				   v4l2_ctrl_ptr_create((void *)&p_hdr10_mastering));
 
 	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
 			  V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD, 0,
-- 
2.17.1

