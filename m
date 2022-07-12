Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8685719DB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiGLMYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbiGLMYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:24:15 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058EBA5E45;
        Tue, 12 Jul 2022 05:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657628653; x=1689164653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=kjqCC1TQXN5pqJ5k6XuqzpdiFR+t5y37ltNwK7wmqWc=;
  b=EdU7zWR8UewuwuyIqU1vaIrbdyhYA9QrPGqGGl2DBP7EX/xyadYBQLBP
   TKLWN5Yfk1366dstRX22nf5thpuhEGAWg4RDRycl7r9tiKy8MtIZ2ogNL
   zk34NFpV+sHeIIJG0xSi7VwLxNMDBk7TsaOFYL0828q5KilQr/uPNcH0O
   Q=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 12 Jul 2022 05:24:12 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Jul 2022 05:24:10 -0700
X-QCInternal: smtphost
Received: from vboma-linux.qualcomm.com ([10.204.65.94])
  by ironmsg01-blr.qualcomm.com with ESMTP; 12 Jul 2022 17:54:06 +0530
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 3EC7F900883; Tue, 12 Jul 2022 17:54:05 +0530 (IST)
From:   Viswanath Boma <quic_vboma@quicinc.com>
To:     video.upstream.external@qti.qualcomm.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Viswanath Boma <quic_vboma@quicinc.com>
Subject: [PATCH 3/7] venus : CAPTURE Plane width/height alignment with OUT plane.
Date:   Tue, 12 Jul 2022 17:53:43 +0530
Message-Id: <20220712122347.6781-3-quic_vboma@quicinc.com>
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

From: Stanimir Varbanov <stanimir.varbanov@linaro.org>

 V4l2 encoder compliance set-format test cases failing as Capture plane width/height not aligned to OUT plane .

Change-Id: I7318a8a750f720e81b7b51520823b68ff13a2697
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
---
 drivers/media/platform/qcom/venus/venc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 21bff25e3f814..b56960d7f6c89 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -192,10 +192,8 @@ venc_try_fmt_common(struct venus_inst *inst, struct v4l2_format *f)
 	pixmp->height = clamp(pixmp->height, frame_height_min(inst),
 			      frame_height_max(inst));
 
-	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
-		pixmp->width = ALIGN(pixmp->width, 128);
-		pixmp->height = ALIGN(pixmp->height, 32);
-	}
+	pixmp->width = ALIGN(pixmp->width, 128);
+	pixmp->height = ALIGN(pixmp->height, 32);
 
 	pixmp->width = ALIGN(pixmp->width, 2);
 	pixmp->height = ALIGN(pixmp->height, 2);
-- 
2.17.1

