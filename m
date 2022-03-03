Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793FF4CC0CB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiCCPH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiCCPHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:07:33 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D534B1903F4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:06:47 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r65so3342629wma.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 07:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RaGrefX44rEm0wu9mMJuIgGrRaikvNDSwTTA6I5onmc=;
        b=iQLNGn0tWI4UbbLemKwJopKnPXIK6nheNzTzHrT8vkbpBGYU/hUG56HnYeriqvXwBn
         ukQV4uk2XqPg1IYY2gQ7dA7zCxVQA9VAefi89ro1B74a8yukKgHhylzRLQKi4rcVh6UF
         NI7bvak1fBKABNQHpdM+MqV1a3R0qX/5xamzlcsDctZNb6jr+eOuwxgjOMdkwfwM+iRg
         otvzcIZJ05YXu31osASP0SQH4UAI5x4W7rmj74EOPCvO5edl6eofBwlPdZ4J7DyWdZ7t
         sIxsnRYXia+pZlL6teoLO4fjKrIP1P7cG+q/Qv/Zac7Tnd+79P1RnByWsBuSUnoodgW2
         hvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RaGrefX44rEm0wu9mMJuIgGrRaikvNDSwTTA6I5onmc=;
        b=Wgfdjxy0/eB3BcrrmHD58hHb/u2cbKklNQD9AwgE4kV2Hx3Bff+PiqUe2RRpcwR75g
         qWD/8YIOnayAwdH2f2KuMQ4zdX3I8IbH64DxA9JXMY/HYOUePkwLaOAA69+OsM+sRIYx
         ujaJMPe5WMgMjqJiCWP61fE2jEgM8HFhJ3QACGJj5hGCb/3dJKS8erZ4cKutp7icLHfz
         bfCTVYCLxv1ZFf+6fVKEaSm2GDcCOTm8GgRMiRTpAnx6FCWjWrk8J3ujzlzj1KXyvPEJ
         3NC0VU2WVYQ+LIRCDWr+StD7nxHRurs5qoMqPMdowTPe1zDCWOhsoYoFlh4TbbVvSDZX
         HJZQ==
X-Gm-Message-State: AOAM530xb2GIFhN4Ts5mKYJYGDol9ISmSl8v0EUi7FJbaiNzzBJ83BfI
        jh8Zu7dSDmWZuLzwGlxSEBeC7Q==
X-Google-Smtp-Source: ABdhPJyeVXsvKvr0st8E02wJKuejqcviu/T7Pj+MD4OwIM0plwJp9ylK47fRvkVMZ/n3NArQdUWyfg==
X-Received: by 2002:a05:600c:35c4:b0:381:782e:9645 with SMTP id r4-20020a05600c35c400b00381782e9645mr4130136wmq.63.1646320006414;
        Thu, 03 Mar 2022 07:06:46 -0800 (PST)
Received: from localhost.localdomain (hst-221-14.medicom.bg. [84.238.221.14])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c511000b0038141b4a4edsm10757072wms.38.2022.03.03.07.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:06:45 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl, Nicolas Dufresne <nicolas@ndufresne.ca>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 5/6] venus: Add a handling of QC10C compressed format
Date:   Thu,  3 Mar 2022 17:06:35 +0200
Message-Id: <20220303150636.577063-6-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303150636.577063-1-stanimir.varbanov@linaro.org>
References: <20220303150636.577063-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds QC10C compressed pixel format in the Venus driver, and
make it possible to discover from v4l2 clients.

Note: The QC10C format will be enumerable via VIDIOC_ENUM_FMT when
the bitstream is 10-bits and the headers are parsed.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 26 ++++-----------------
 drivers/media/platform/qcom/venus/vdec.c    | 19 ++++++++++++---
 2 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 7144747398b6..f5a938455d7c 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -594,6 +594,8 @@ static u32 to_hfi_raw_fmt(u32 v4l2_fmt)
 		return HFI_COLOR_FORMAT_NV21;
 	case V4L2_PIX_FMT_QC08C:
 		return HFI_COLOR_FORMAT_NV12_UBWC;
+	case V4L2_PIX_FMT_QC10C:
+		return HFI_COLOR_FORMAT_YUV420_TP10_UBWC;
 	default:
 		break;
 	}
@@ -1176,7 +1178,8 @@ int venus_helper_set_format_constraints(struct venus_inst *inst)
 	if (!IS_V6(inst->core))
 		return 0;
 
-	if (inst->opb_fmt == HFI_COLOR_FORMAT_NV12_UBWC)
+	if (inst->opb_fmt == HFI_COLOR_FORMAT_NV12_UBWC ||
+	    inst->opb_fmt == HFI_COLOR_FORMAT_YUV420_TP10_UBWC)
 		return 0;
 
 	pconstraint.buffer_type = HFI_BUFFER_OUTPUT2;
@@ -1747,27 +1750,6 @@ int venus_helper_get_out_fmts(struct venus_inst *inst, u32 v4l2_fmt,
 	if (!caps)
 		return -EINVAL;
 
-	if (inst->bit_depth == VIDC_BITDEPTH_10 &&
-	    inst->session_type == VIDC_SESSION_TYPE_DEC) {
-		found_ubwc =
-			find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT,
-					   HFI_COLOR_FORMAT_YUV420_TP10_UBWC);
-		found = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT2,
-					   HFI_COLOR_FORMAT_NV12);
-		if (found_ubwc && found) {
-			/*
-			 * Hard-code DPB buffers to be 10bit UBWC and decoder
-			 * output buffers in 8bit NV12 until V4L2 is able to
-			 * expose compressed/tiled formats to applications.
-			 */
-			*out_fmt = HFI_COLOR_FORMAT_YUV420_TP10_UBWC;
-			*out2_fmt = HFI_COLOR_FORMAT_NV12;
-			return 0;
-		}
-
-		return -EINVAL;
-	}
-
 	if (ubwc) {
 		ubwc_fmt = fmt | HFI_COLOR_FORMAT_UBWC_BASE;
 		found_ubwc = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT,
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index eb02e45a512b..c8261c6cb0fb 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -35,6 +35,10 @@ static const struct venus_format vdec_formats[] = {
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
 	}, {
+		.pixfmt = V4L2_PIX_FMT_QC10C,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+	},{
 		.pixfmt = V4L2_PIX_FMT_NV12,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
@@ -114,6 +118,10 @@ find_format(struct venus_inst *inst, u32 pixfmt, u32 type)
 	    !venus_helper_check_format(inst, fmt[i].pixfmt))
 		return NULL;
 
+	if (V4L2_TYPE_IS_CAPTURE(type) && fmt[i].pixfmt == V4L2_PIX_FMT_QC10C &&
+	    !(inst->bit_depth == VIDC_BITDEPTH_10))
+		return NULL;
+
 	return &fmt[i];
 }
 
@@ -133,11 +141,16 @@ find_format_by_index(struct venus_inst *inst, unsigned int index, u32 type)
 		if (fmt[i].type != type)
 			continue;
 
-		if (V4L2_TYPE_IS_OUTPUT(type))
+		if (V4L2_TYPE_IS_OUTPUT(type)) {
 			valid = venus_helper_check_codec(inst, fmt[i].pixfmt);
-		else if (V4L2_TYPE_IS_CAPTURE(type))
+		} else if (V4L2_TYPE_IS_CAPTURE(type)) {
 			valid = venus_helper_check_format(inst, fmt[i].pixfmt);
 
+			if (fmt[i].pixfmt == V4L2_PIX_FMT_QC10C &&
+			    !(inst->bit_depth == VIDC_BITDEPTH_10))
+				valid = false;
+		}
+
 		if (k == index && valid)
 			break;
 		if (valid)
@@ -1537,7 +1550,7 @@ static const struct hfi_inst_ops vdec_hfi_ops = {
 static void vdec_inst_init(struct venus_inst *inst)
 {
 	inst->hfi_codec = HFI_VIDEO_CODEC_H264;
-	inst->fmt_out = &vdec_formats[7];
+	inst->fmt_out = &vdec_formats[8];
 	inst->fmt_cap = &vdec_formats[0];
 	inst->width = frame_width_min(inst);
 	inst->height = ALIGN(frame_height_min(inst), 32);
-- 
2.25.1

