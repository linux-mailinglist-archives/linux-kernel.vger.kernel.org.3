Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EAA5719E4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbiGLMYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbiGLMYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:24:20 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47242A5E6B;
        Tue, 12 Jul 2022 05:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657628658; x=1689164658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=1GXy2fCY/tz9CAmVku5gyITyTFE/cMolO+FZrOVG8xI=;
  b=RpG9Al0VLxui4uZi1MJz+VagQReD0ejvlfYUvjTSo2z1T6Hk4p0D82s3
   qigw8QofT3oMybIqLGXVEFoetc8KXUM39a6QcCPcGcl6w6xj3ii33Wiq/
   0GkM/7AZxt5Oc0RPKy4Au5iwM+FVwMmwUYqeIDDYel2DBkc5b+iepiSU5
   U=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 12 Jul 2022 05:24:17 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 12 Jul 2022 05:24:16 -0700
X-QCInternal: smtphost
Received: from vboma-linux.qualcomm.com ([10.204.65.94])
  by ironmsg01-blr.qualcomm.com with ESMTP; 12 Jul 2022 17:54:12 +0530
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 01C04900883; Tue, 12 Jul 2022 17:54:11 +0530 (IST)
From:   Viswanath Boma <quic_vboma@quicinc.com>
To:     video.upstream.external@qti.qualcomm.com,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vikash Garodia <quic_vgarodia@quicinc.com>,
        Viswanath Boma <quic_vboma@quicinc.com>
Subject: [PATCH 7/7] venus : Allow MIN/MAX settings for the v4l2 encoder controls defined range  .
Date:   Tue, 12 Jul 2022 17:53:47 +0530
Message-Id: <20220712122347.6781-7-quic_vboma@quicinc.com>
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

From: Vikash Garodia <quic_vgarodia@quicinc.com>

 Control MIN/MAX range defined as 0 to 1 ,as MIN value setting enabled
 for V4L2_CID_MPEG_VIDEO_H264_8X8_TRANSFORM .

 error details: fail: v4l2-test-controls.cpp(516): invalid maximum range check

Change-Id: I8db2585d35a72bf238cec4cd8f49661170e98a85
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
---
 drivers/media/platform/qcom/venus/venc_ctrls.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index 95fdad160732b..6dcbd3baa9c86 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -323,19 +323,6 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
 		if (ctr->profile.h264 != V4L2_MPEG_VIDEO_H264_PROFILE_HIGH &&
 		    ctr->profile.h264 != V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_HIGH)
 			return -EINVAL;
-
-		/*
-		 * In video firmware, 8x8 transform is supported only for
-		 * high profile(HP) and constrained high profile(CHP).
-		 * If client wants to disable 8x8 transform for HP/CHP,
-		 * it is better to set profile as main profile(MP).
-		 * Because there is no difference between HP and MP
-		 * if we disable 8x8 transform for HP.
-		 */
-
-		if (ctrl->val == 0)
-			return -EINVAL;
-
 		ctr->h264_8x8_transform = ctrl->val;
 		break;
 	default:
-- 
2.17.1

