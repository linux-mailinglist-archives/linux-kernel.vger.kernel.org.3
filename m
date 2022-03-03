Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7768B4CC0C2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbiCCPHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbiCCPHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:07:30 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E2A1903E8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:06:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d3so8327453wrf.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 07:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KmYcedTQoSyAqjz5oetiys3ZELl3vsdNtkFgjZlFb18=;
        b=ZDQ5LnWgv99ECsMqA2bZoVRRKKLc2/GI3k2R8y1d3BIId9HfJEx9R3/obf6DnMfvJp
         F6wAUJI8lufeIPgzkmiCtums00UVs6EQmNghSdNNfnM/ChXXYMRcGW/2F/EyQmeIulxa
         PlPBOG+6pY2MWdTKdF1dxEW1JOREA0MGiLLmFgZKTOfqDnjmwhIqjANqJyMQEN2uxC1z
         tWvTxL3rhWddFD+4+FIRlx1TQcop7eo2HH7A5b9wBQZEEW9FxWneJ9XAtkMnEtGOM5af
         xToK6jfwX5zgM1TF7sY4mBUmCG+WuMt7e99p14fymzcus/JnMFIzMLrMRDX89YCqU3nP
         py8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KmYcedTQoSyAqjz5oetiys3ZELl3vsdNtkFgjZlFb18=;
        b=yW2vidzPoC3XLa/so0H1kN9z6Mdg79HxffTsKQ0GZD8RQKETPapBV0TTIpflDw9IL7
         8t2sH6hTg5CTgqpjPkHwG266pwbdf6FCg/vJEqk+48z5fmt+dQziExXs1Zj4mFdjJNVj
         urXgyJG61gFfysHek2xA08UO9VjSzhC1U04gEQJxznXglDPB+9JE5s2uiE2jvl464LA9
         kQgy61Y3HbRkt0Mli7TKla8a1ZhQe+nKzuNzy1CnryfcXPfoCKBO8kKD/9bU8G4wsYbB
         /ARtk4kPjgsXnfEdvpEmy8gjOEzgPgToGE8xY0AN86QSXfRpSEqTTRThJm2rYKE0a8UZ
         +ZZg==
X-Gm-Message-State: AOAM530IpqZFPBqp4ZBM+geQEg4aBprD/4yzjJoE1F3BC9B9fEuPevUy
        wnWtUmLwKI3AxAsRaaR+nuSO4Q==
X-Google-Smtp-Source: ABdhPJy3AvLCQnaka630O6+QzMT92wO8uOcRIXkU98w9RvIajiEp6AN75CjyRTj55SJZjkvHOzW/Cw==
X-Received: by 2002:a5d:64e9:0:b0:1f0:3580:98c9 with SMTP id g9-20020a5d64e9000000b001f0358098c9mr5792218wri.716.1646320003246;
        Thu, 03 Mar 2022 07:06:43 -0800 (PST)
Received: from localhost.localdomain (hst-221-14.medicom.bg. [84.238.221.14])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c511000b0038141b4a4edsm10757072wms.38.2022.03.03.07.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:06:42 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl, Nicolas Dufresne <nicolas@ndufresne.ca>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 2/6] venus: helpers: Add helper to check supported pixel formats
Date:   Thu,  3 Mar 2022 17:06:32 +0200
Message-Id: <20220303150636.577063-3-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303150636.577063-1-stanimir.varbanov@linaro.org>
References: <20220303150636.577063-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to check supported pixel format per codec and session
type.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/helpers.c | 23 +++++++++++++++++++++
 drivers/media/platform/qcom/venus/helpers.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
index 0bca95d01650..52b198a194b3 100644
--- a/drivers/media/platform/qcom/venus/helpers.c
+++ b/drivers/media/platform/qcom/venus/helpers.c
@@ -1797,6 +1797,29 @@ int venus_helper_get_out_fmts(struct venus_inst *inst, u32 v4l2_fmt,
 }
 EXPORT_SYMBOL_GPL(venus_helper_get_out_fmts);
 
+bool venus_helper_check_format(struct venus_inst *inst, u32 v4l2_pixfmt)
+{
+	struct venus_core *core = inst->core;
+	u32 fmt = to_hfi_raw_fmt(v4l2_pixfmt);
+	struct hfi_plat_caps *caps;
+	u32 buftype;
+
+	if (!fmt)
+		return false;
+
+	caps = venus_caps_by_codec(core, inst->hfi_codec, inst->session_type);
+	if (!caps)
+		return false;
+
+	if (inst->session_type == VIDC_SESSION_TYPE_DEC)
+		buftype = HFI_BUFFER_OUTPUT2;
+	else
+		buftype = HFI_BUFFER_OUTPUT;
+
+	return find_fmt_from_caps(caps, buftype, fmt);
+}
+EXPORT_SYMBOL_GPL(venus_helper_check_format);
+
 int venus_helper_set_stride(struct venus_inst *inst,
 			    unsigned int width, unsigned int height)
 {
diff --git a/drivers/media/platform/qcom/venus/helpers.h b/drivers/media/platform/qcom/venus/helpers.h
index 32619c3e8c97..358e4f39c9c0 100644
--- a/drivers/media/platform/qcom/venus/helpers.h
+++ b/drivers/media/platform/qcom/venus/helpers.h
@@ -55,6 +55,7 @@ void venus_helper_init_instance(struct venus_inst *inst);
 int venus_helper_session_init(struct venus_inst *inst);
 int venus_helper_get_out_fmts(struct venus_inst *inst, u32 fmt, u32 *out_fmt,
 			      u32 *out2_fmt, bool ubwc);
+bool venus_helper_check_format(struct venus_inst *inst, u32 v4l2_pixfmt);
 int venus_helper_alloc_dpb_bufs(struct venus_inst *inst);
 int venus_helper_free_dpb_bufs(struct venus_inst *inst);
 int venus_helper_intbufs_alloc(struct venus_inst *inst);
-- 
2.25.1

