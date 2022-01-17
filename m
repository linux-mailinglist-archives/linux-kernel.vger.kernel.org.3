Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8857490BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240774AbiAQP4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240722AbiAQP4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:56:33 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9803FC061747
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:56:32 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c126-20020a1c9a84000000b00346f9ebee43so537083wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rvqvbFyOWR+3Qbb+TyNxDJR2+Ud4ue5zSaWeMig95K0=;
        b=BBtxp+pFpSM0neI/2Z1rX825zs5Up8KTErFQcKENOjeYS4tOucfqiafDxafovFP7Ci
         JDV6F5Zngga7EZ8fn0uPM9RpCb0c8I7g0923iT2tsWXzrsn2Y8sOTFUHacc5IZUfa1Fb
         1iYFyjJSvjcv2Z+90hTkK0d15++AlUSm/5EPTe4IrZBQTijGZWryFd4FUIwGqBCHEA2W
         ynPZ1RLfjKkF32T0Lv6/yQ6yn7X7dT4gp8T/3mIH4MNC1P7PepRjR+8rsWSc0/vY/tC0
         /JabFPPPwFlxGCBkI1QccLVt1BeozOVNWsTsOJ2uQNRhwvc0cBH7hHg/DDMNbAE+AGo9
         TRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rvqvbFyOWR+3Qbb+TyNxDJR2+Ud4ue5zSaWeMig95K0=;
        b=dtIQz/wNoXuZgiM1GBL/uSrdWzG9Az0hR/xfPRPULf8TQf4nrFH95nHlsWFP/lFqTJ
         Yrv8xSk9YXO1xKz7O1lcMwVrFnTlVPoHJ6Mbunx1oYv5H88i+b4SId54knQvU8/KqQ4H
         nJBjHUi60p3U+oaqtOEFg39vlcoC2CpF6hXEvKeEud84h/dMdJ5qkmE05XL6puQIPDv3
         RybRkl7CQyggMyKhrOKxqoXesPqHpi2QzFAzMyb/WaJCjFeKmuY5ixPYRhBJNQKJODnr
         2DSwuiGfHbQd5tJjGX+lUb3d2jTH/FgLCOxplbSl2Pm70RDK8jUBN546WvAjAuzSCXIQ
         B4qw==
X-Gm-Message-State: AOAM532Q3JL/EXA9Ac1/gi9NcM07JY2SBwQjFn1rYk0uK++o9nFgvV0J
        L6e2tvGf7V863u8ND98vD1jIRA==
X-Google-Smtp-Source: ABdhPJx+fjM8V4va8nZ7VMuYU+q6SyNy+4blveDGFF38Rw0mM4rY26o1C5AAnxWNi86ndCHqWHMIBg==
X-Received: by 2002:a1c:1d17:: with SMTP id d23mr20564746wmd.46.1642434991195;
        Mon, 17 Jan 2022 07:56:31 -0800 (PST)
Received: from localhost.localdomain (hst-221-60.medicom.bg. [84.238.221.60])
        by smtp.gmail.com with ESMTPSA id i82sm15542900wma.23.2022.01.17.07.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 07:56:30 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 5/6] venus: Add a handling of QC10C compressed format
Date:   Mon, 17 Jan 2022 17:55:58 +0200
Message-Id: <20220117155559.234026-6-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117155559.234026-1-stanimir.varbanov@linaro.org>
References: <20220117155559.234026-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds QC10C compressed pixel format in the Venus driver, and
make it possible to discover from v4l2 clients.

Note: The QC10C format shouldn't be possible to discpver by the
client if the decoded bitstream is not 10-bits.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 26 ++++-----------------
 drivers/media/platform/qcom/venus/vdec.c    | 19 ++++++++++++---
 2 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index adbfa4fbe139..69a9a9471a27 100644
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

