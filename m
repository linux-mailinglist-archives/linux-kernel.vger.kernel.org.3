Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B314CC0C3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 16:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiCCPHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 10:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiCCPHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 10:07:32 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FF7190B42
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 07:06:46 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v2-20020a7bcb42000000b0037b9d960079so5522036wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 07:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yAEFbpvN98ptmknkKWl0O8Ur86W+dj9ENZyY+Bs86R0=;
        b=o0pUsgTFfo0mMtoKAT6V2y6BbiJGS+D4eRwMFOQ3RVlyAN5pQgIOWsTGvLg6/NuKQi
         kbvz0eEqR0aDrvgCXts5123oTxoIu91hg5E8ZCEb5OiomSuIE9d+W8IMcDR6r2xf1Mz0
         Yty5i/UOYoj+1yj7SD6xjoyzwRsCxrrHQVoZljv+Jcmt0VNw4WXjrmfG2kpj7gJJyDvX
         LJbzgi/F79jhBdDtpIkoOJiTr+l//Eu1PpySZnDzENY1rLpztIf2azft/NmplAY3Pn7i
         K0kW6IzaFpZQDiunYOohxvHnuIe+ANIHvdYzhT4nq2UEe2hMYXlBiFqbtK392P/9SEvc
         3eHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yAEFbpvN98ptmknkKWl0O8Ur86W+dj9ENZyY+Bs86R0=;
        b=W5s/2Fd6sj/vWXmiGxD+J3qDI0GrQSY99jq8tXVbPavukYyJ0rKfmOrxTUVlo2wi92
         8Q9MlE9V0vz0ZaUy+IeNEVdB9SuoxPUKsx22EDzi+SBtdxqKN/ngTHtpVuXvJgujdUXi
         gopPVjKzhp0LyF6GIud4E1QaLCfXZTefwEglB/r8PktKey3zkUHHLn40gY+Nt29XbQDc
         laafFPqR0CQMc+KOWKXZdDn6jAhgFxSWvBVCdEYGRfbXcwdR50JFImA1gagxCgczBzTr
         keWsOXgdNsMmtP6c9vCgp4ricG+W1jnbU+3BR5Ds19mNk1Xt4nx0lzanoKjQ4KFiBvl6
         wrrQ==
X-Gm-Message-State: AOAM533HmPo9irVn9cK5FvdNbbi+GI0Pejnmb88VfZjmY5nN3rD5DXon
        LnQ+SPeahgU0O3h/LNOSxIWrQg==
X-Google-Smtp-Source: ABdhPJxJh+wjb/RhDLyVmVFa0rNu+SxFuWa1mMy7fQFAVaLREDjlrqbwyIo4DN/yfR6L1iyH6bpRnA==
X-Received: by 2002:a05:600c:1552:b0:381:c7ac:84b1 with SMTP id f18-20020a05600c155200b00381c7ac84b1mr3956478wmg.77.1646320005316;
        Thu, 03 Mar 2022 07:06:45 -0800 (PST)
Received: from localhost.localdomain (hst-221-14.medicom.bg. [84.238.221.14])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c511000b0038141b4a4edsm10757072wms.38.2022.03.03.07.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 07:06:44 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl, Nicolas Dufresne <nicolas@ndufresne.ca>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 4/6] venus: hfi_platform: Correct supported compressed format
Date:   Thu,  3 Mar 2022 17:06:34 +0200
Message-Id: <20220303150636.577063-5-stanimir.varbanov@linaro.org>
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

In multistream mode HFI supports TP10_UBWC on output2. Correct this
in supported formats capabilities list.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_platform_v4.c | 4 ++--
 drivers/media/platform/qcom/venus/hfi_platform_v6.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_platform_v4.c b/drivers/media/platform/qcom/venus/hfi_platform_v4.c
index 3f7f5277a50e..e3f0a90a567b 100644
--- a/drivers/media/platform/qcom/venus/hfi_platform_v4.c
+++ b/drivers/media/platform/qcom/venus/hfi_platform_v4.c
@@ -55,7 +55,7 @@ static const struct hfi_plat_caps caps[] = {
 	.fmts[3] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV12},
 	.fmts[4] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV21},
 	.fmts[5] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_P010},
-	.fmts[6] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_YUV420_TP10},
+	.fmts[6] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_YUV420_TP10_UBWC},
 	.num_fmts = 7,
 }, {
 	.codec = HFI_VIDEO_CODEC_VP8,
@@ -106,7 +106,7 @@ static const struct hfi_plat_caps caps[] = {
 	.fmts[3] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV12},
 	.fmts[4] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV21},
 	.fmts[5] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_P010},
-	.fmts[6] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_YUV420_TP10},
+	.fmts[6] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_YUV420_TP10_UBWC},
 	.num_fmts = 7,
 }, {
 	.codec = HFI_VIDEO_CODEC_MPEG2,
diff --git a/drivers/media/platform/qcom/venus/hfi_platform_v6.c b/drivers/media/platform/qcom/venus/hfi_platform_v6.c
index c10618e44f5d..4e8af645f8b9 100644
--- a/drivers/media/platform/qcom/venus/hfi_platform_v6.c
+++ b/drivers/media/platform/qcom/venus/hfi_platform_v6.c
@@ -55,7 +55,7 @@ static const struct hfi_plat_caps caps[] = {
 	.fmts[3] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV12},
 	.fmts[4] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV21},
 	.fmts[5] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_P010},
-	.fmts[6] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_YUV420_TP10},
+	.fmts[6] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_YUV420_TP10_UBWC},
 	.num_fmts = 7,
 }, {
 	.codec = HFI_VIDEO_CODEC_VP8,
@@ -106,7 +106,7 @@ static const struct hfi_plat_caps caps[] = {
 	.fmts[3] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV12},
 	.fmts[4] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_NV21},
 	.fmts[5] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_P010},
-	.fmts[6] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_YUV420_TP10},
+	.fmts[6] = {HFI_BUFFER_OUTPUT2, HFI_COLOR_FORMAT_YUV420_TP10_UBWC},
 	.num_fmts = 7,
 }, {
 	.codec = HFI_VIDEO_CODEC_MPEG2,
-- 
2.25.1

