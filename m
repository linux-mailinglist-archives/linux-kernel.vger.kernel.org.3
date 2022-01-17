Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC39490BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbiAQP5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240687AbiAQP4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:56:31 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7067C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:56:30 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id o7-20020a05600c510700b00347e10f66d1so207420wms.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u9C5eDXIt2JgC7f+jIHCQcIVT6TGBlNH+TmJyzYUodM=;
        b=OdCqkOj4K90mnj5dm3duSXPek6dgVb5LEjJtgmAXFsCUstfgZIgkL28sB2bwtDwXwe
         8MT82sm2vqzLK1lIFNm6bJ7PC6OZu1ZFmMLhFHmmukgix4slEwRllFRqMjMxi3s1Uo+f
         82hUfVR/C/tCPoQTs7BYoinPllnplmOYAMF4AUTjDetX21Nd582emqILyXL1qkseUbrF
         H/QIH82XBqjLjjKXjo1KvE1Phmb3UzPrdkPCRE00FY+a2Q2IDDBKI3Pqg2deh52M1lRr
         HbAaBx8QB9PJoF5FbNYvQWUCN/6fGzZ3v+i4Qt47J/iukCylWgKGgf2y8BK9ZeiEDn46
         0B+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u9C5eDXIt2JgC7f+jIHCQcIVT6TGBlNH+TmJyzYUodM=;
        b=aqpsB9ATU3SwcpNE5K/B7dH41fQ7K+KdEJwwNWcPrt/tMtdp6hIMmhRiSgHHYBXAAf
         INhb4dc/lNELBKegcyzJCXGL0eY4qHCnz2M0bw6Jh7oKUIQ+miKRRAViALHzfD+eXE5D
         1UNIaF84wDuCQF9CBO2F49pZRzVKpNbYhs7slcpp0Z3CryH3kdykfF213Ix3X3u4/8Z4
         WWHvLpXSWv2d+nlWd9W6JRvIlYAMTHcsNHZyPqvqkJ5GObNBY8Flxgbo1PrEWJOyiTmj
         z/dz4ffijf1NPfm6jXU/H05NHKlfxLw2zHhR4npzeZJYZQ4E30MFhWvHmJBuQMj64oa0
         Clbg==
X-Gm-Message-State: AOAM530bCwQIUgDOdFeWcHnWyZQFaPlXl58SYT5ThZUeK2VZ6grGco9S
        0GbyQbvF2gFnoT5eX4GGQ8y2Yg==
X-Google-Smtp-Source: ABdhPJyNrlg1CEHuchAifM/k9e7/o2NvgG+Y4sNgoOIRDRpbH99Avz/yXfx9+SWEEVnGDqHJz/Oh0Q==
X-Received: by 2002:a5d:4c4d:: with SMTP id n13mr20277570wrt.641.1642434989257;
        Mon, 17 Jan 2022 07:56:29 -0800 (PST)
Received: from localhost.localdomain (hst-221-60.medicom.bg. [84.238.221.60])
        by smtp.gmail.com with ESMTPSA id i82sm15542900wma.23.2022.01.17.07.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 07:56:28 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 3/6] venus: Add a handling of QC08C compressed format
Date:   Mon, 17 Jan 2022 17:55:56 +0200
Message-Id: <20220117155559.234026-4-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117155559.234026-1-stanimir.varbanov@linaro.org>
References: <20220117155559.234026-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds QC08C compressed pixel format in the Venus driver, and
make it possible to discover from v4l2 clients.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c |  2 ++
 drivers/media/platform/qcom/venus/vdec.c    | 18 +++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index a5464385a716..adbfa4fbe139 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -592,6 +592,8 @@ static u32 to_hfi_raw_fmt(u32 v4l2_fmt)
 		return HFI_COLOR_FORMAT_NV12;
 	case V4L2_PIX_FMT_NV21:
 		return HFI_COLOR_FORMAT_NV21;
+	case V4L2_PIX_FMT_QC08C:
+		return HFI_COLOR_FORMAT_NV12_UBWC;
 	default:
 		break;
 	}
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 91da3f509724..eb02e45a512b 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -31,6 +31,10 @@
  */
 static const struct venus_format vdec_formats[] = {
 	{
+		.pixfmt = V4L2_PIX_FMT_QC08C,
+		.num_planes = 1,
+		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
+	}, {
 		.pixfmt = V4L2_PIX_FMT_NV12,
 		.num_planes = 1,
 		.type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
@@ -106,6 +110,10 @@ find_format(struct venus_inst *inst, u32 pixfmt, u32 type)
 	    !venus_helper_check_codec(inst, fmt[i].pixfmt))
 		return NULL;
 
+	if (V4L2_TYPE_IS_CAPTURE(type) &&
+	    !venus_helper_check_format(inst, fmt[i].pixfmt))
+		return NULL;
+
 	return &fmt[i];
 }
 
@@ -124,8 +132,12 @@ find_format_by_index(struct venus_inst *inst, unsigned int index, u32 type)
 
 		if (fmt[i].type != type)
 			continue;
-		valid = type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE ||
-			venus_helper_check_codec(inst, fmt[i].pixfmt);
+
+		if (V4L2_TYPE_IS_OUTPUT(type))
+			valid = venus_helper_check_codec(inst, fmt[i].pixfmt);
+		else if (V4L2_TYPE_IS_CAPTURE(type))
+			valid = venus_helper_check_format(inst, fmt[i].pixfmt);
+
 		if (k == index && valid)
 			break;
 		if (valid)
@@ -1525,7 +1537,7 @@ static const struct hfi_inst_ops vdec_hfi_ops = {
 static void vdec_inst_init(struct venus_inst *inst)
 {
 	inst->hfi_codec = HFI_VIDEO_CODEC_H264;
-	inst->fmt_out = &vdec_formats[6];
+	inst->fmt_out = &vdec_formats[7];
 	inst->fmt_cap = &vdec_formats[0];
 	inst->width = frame_width_min(inst);
 	inst->height = ALIGN(frame_height_min(inst), 32);
-- 
2.25.1

