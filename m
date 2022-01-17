Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D10D490BE2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240744AbiAQP4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240699AbiAQP4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:56:30 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB71C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:56:29 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id d187-20020a1c1dc4000000b003474b4b7ebcso526052wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=17LNy9CZCP/+ZCdmdAFt4lcNroP4x+vbh8EUReOHAKQ=;
        b=myzg5tHLPabWaZfbAFNqhMc5tgs6CACzdGcvLA+m1kDstDrK8nQWPQkzoDNMtDYf6L
         yFgffmK7U/OjMUNCP9iQkf0IVI8tuFdsfbYke8xMnp4a4WFDGW7AGLqoggHvpLUUiLIf
         0+sGkvCWroLz9UUWXBS16UGeSlgPtUb5KhhC2NFAwEU5YvlJFOJ8zCPGFf6yMA/zaA9B
         nJfrLqh4iQFndhY0RD6SgXSW2tHvAAC2xpUBVZaAg2PPshrR37yjLObNgt7UpU59aLC6
         8pvccvU0yC1GqeE/wdCUVQOCJ4LwSNk7JXY5iZ7U6/CEw5OCkNZAIAtVCb/uw4j+eh15
         tUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=17LNy9CZCP/+ZCdmdAFt4lcNroP4x+vbh8EUReOHAKQ=;
        b=EmWV1euzkUBGUFMxgggLGxsP246p6enJUcDNkcVRRoILNg8y0U7B6XVol4KjH/M4p7
         g8vBO810JsnMhrlLg5dZ6C613d57gIo4Obg1rP+5wiogYorE/iWWN75PM5P/IuikpK5D
         015wjtOxUINNbaCZMkm4OORx+jC7oeFJmMrTcODI7Fnfx3jVSQd304P5oWrVe9idU6H1
         C/J1KnAWxnCcCQSHYSHgQSp/6n66yx04a/W2KMlYrRwWawHQAaosagozsyO+0ypsCBAz
         YMOFM+W8Nhwnnd+9GbDVtHVzR78Og3+pn/N1cX4P30k2H9yz/GAuVUfMeLGMEv0exFxX
         MZxw==
X-Gm-Message-State: AOAM532Vits2gS01h7vZfPTXczowTld7SoUnlwmQ9XNYtnPdZjXqgQ/i
        CCm41zlGQD2mnY17n3JSe4j954iUD3CtcQ==
X-Google-Smtp-Source: ABdhPJyDp87Po46VaGOl6acuVZtXN+Q1xZ5oDZxrG5yNSi308OV+MzOqT4zgSdan/g2SlMojqms2Lw==
X-Received: by 2002:a5d:59ac:: with SMTP id p12mr8800161wrr.9.1642434988332;
        Mon, 17 Jan 2022 07:56:28 -0800 (PST)
Received: from localhost.localdomain (hst-221-60.medicom.bg. [84.238.221.60])
        by smtp.gmail.com with ESMTPSA id i82sm15542900wma.23.2022.01.17.07.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 07:56:27 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 2/6] venus: helpers: Add helper to check supported pixel formats
Date:   Mon, 17 Jan 2022 17:55:55 +0200
Message-Id: <20220117155559.234026-3-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117155559.234026-1-stanimir.varbanov@linaro.org>
References: <20220117155559.234026-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 84c3a511ec31..a5464385a716 100644
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

