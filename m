Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DADC5719E3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiGLMY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbiGLMYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:24:15 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3F7A5E46;
        Tue, 12 Jul 2022 05:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657628654; x=1689164654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=kj0kBuJRKrJztfeW6tmf/UDwOX6Y3wrCB1UmnidfQ4A=;
  b=gYfvoA5ykL+odve0mrXQQ5JzwlmVILM8bsedolmpx6iBtoXnT+BVw//L
   xhJ+dgeWS8ofRRUiZjDYw/53t3p7HIMgpzNtDtXdBtI2vL9isGDlnIJ8I
   3IFcRnkEYOOyXqJejrT17sOrao5rtdbfDWdQ+2mlmwIpXg7MTq4r1hL+8
   Y=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 12 Jul 2022 05:24:14 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Jul 2022 05:24:12 -0700
X-QCInternal: smtphost
Received: from vboma-linux.qualcomm.com ([10.204.65.94])
  by ironmsg01-blr.qualcomm.com with ESMTP; 12 Jul 2022 17:54:04 +0530
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 36917900883; Tue, 12 Jul 2022 17:54:03 +0530 (IST)
From:   Viswanath Boma <quic_vboma@quicinc.com>
To:     video.upstream.external@qti.qualcomm.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Viswanath Boma <quic_vboma@quicinc.com>
Subject: [PATCH 2/7] venus : Addition of control support - V4L2_CID_MIN_BUFFERS_FOR_OUTPUT
Date:   Tue, 12 Jul 2022 17:53:42 +0530
Message-Id: <20220712122347.6781-2-quic_vboma@quicinc.com>
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

  V4l2 encoder compliance expecting minimum buffers support for the application to allocate
  buffers as per the control support values.

Change-Id: Idb41ff7dce8b8138f28df01d045eae6facf7e93d
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
---
 drivers/media/platform/qcom/venus/venc_ctrls.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index 37ba7d97f99b2..95fdad160732b 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -355,7 +355,7 @@ int venc_ctrl_init(struct venus_inst *inst)
 	struct v4l2_ctrl_hdr10_mastering_display p_hdr10_mastering = { {34000, 13250, 7500 },
 	{ 16000, 34500, 3000 }, 15635,	16450, 10000000, 500 };
 
-	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 58);
+	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 59);
 	if (ret)
 		return ret;
 
@@ -435,6 +435,9 @@ int venc_ctrl_init(struct venus_inst *inst)
 		V4L2_MPEG_VIDEO_VP8_PROFILE_3,
 		0, V4L2_MPEG_VIDEO_VP8_PROFILE_0);
 
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+		V4L2_CID_MIN_BUFFERS_FOR_OUTPUT, 4, 11, 1, 4);
+
 	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
 		V4L2_CID_MPEG_VIDEO_BITRATE, BITRATE_MIN, BITRATE_MAX,
 		BITRATE_STEP, BITRATE_DEFAULT);
-- 
2.17.1

