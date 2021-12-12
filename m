Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A18471A0B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 13:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhLLMfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 07:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhLLMfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 07:35:42 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9678EC061714;
        Sun, 12 Dec 2021 04:35:41 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b40so26117832lfv.10;
        Sun, 12 Dec 2021 04:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pQx1BqhBorBJ+//DcHPTf2i5wSW2AXCJx+6ojtYTS24=;
        b=c4m7usWougVAshzHmUAaPl6c0Y9WlruaqYs5cG7sd/HjAn9+p3bJd7tLAlteMJbopX
         K7ar3NjAWgcW4+diHxVN0yEb+afTw6p18WmP9DwoRUorCzXo0aIhxhXJmMMGSBoPeFop
         TK0fwne6yWd6yG2i+/0Vzdhfe9el1U6FiE57Msy3CcMhjN18tg1dfezHNLeE0I770w2d
         lv2OSVrbC/xmea8ySNNZn0TqC/3Gv1U3UfKyhigXaBi05zbGTPoLkYViqZroomkzDrh8
         2JeHZsIy+zynYi0kVglWyTsC9HbE0sODBvczsvlyUjSFeY0cjy9L9c+OUTb23uoSaAE6
         uUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pQx1BqhBorBJ+//DcHPTf2i5wSW2AXCJx+6ojtYTS24=;
        b=RUYb4jdBBOWrbAb1QJWdwglxiU+zoOPrIbLR72kMlH4PQ7la3fumz9A/4f+5VrlyJp
         OItJYYrFMiG+RqbSyYb0nxEexLVaADYdluaUc2XDHf8s1suQ7kf4w1rqJHQX2HFn4ULN
         nzH4ohCSXj+3dyR+EfQd+S7+GMOO0VJk0S5RwQtua/FykY0HISH9G9ktB+FExXuLUV4l
         4V8hHjRYpHWDLF2knboQrU1YMPpn5AC2T4WDX1CAEngcx8q8HlLWUlvosS+OgsrbVtGA
         7TqvzxycJN0T+UrAYShlSnXsd0K8bptXdBLtVB9KwjOlHgxJ8FRXxJuXAIqz3vcoSzBX
         8dMw==
X-Gm-Message-State: AOAM531YNxvoy0bmp7ilG9VThtz6mKbhx/3TAb9TxCHiUblvC1rs0szT
        WIQGuKFsAWBfUb8aW49YyZiDu5GRtp8=
X-Google-Smtp-Source: ABdhPJz3q7hvbeME5MhYOX8Jg8ui+2KSpcLZPl5dXaG7zOY9lghqPn4lTTSpqlsyQF61GeY8r+Kj2w==
X-Received: by 2002:a05:6512:3f04:: with SMTP id y4mr25045765lfa.227.1639312539536;
        Sun, 12 Dec 2021 04:35:39 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id o15sm1024230lfk.175.2021.12.12.04.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 04:35:39 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] media: venus: hfi: Constify {dec,enc}_bufsize_ops
Date:   Sun, 12 Dec 2021 13:35:34 +0100
Message-Id: <20211212123534.4473-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dec_bufsize_ops and enc_bufsize_ops are never modified. Make them
const to allow the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 .../platform/qcom/venus/hfi_plat_bufs_v6.c    | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
index ea25c451222b..e42546d7f3dc 100644
--- a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
+++ b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
@@ -1063,51 +1063,51 @@ struct enc_bufsize_ops {
 	u32 (*persist)(void);
 };
 
-static struct dec_bufsize_ops dec_h264_ops = {
+static const struct dec_bufsize_ops dec_h264_ops = {
 	.scratch = h264d_scratch_size,
 	.scratch1 = h264d_scratch1_size,
 	.persist1 = h264d_persist1_size,
 };
 
-static struct dec_bufsize_ops dec_h265_ops = {
+static const struct dec_bufsize_ops dec_h265_ops = {
 	.scratch = h265d_scratch_size,
 	.scratch1 = h265d_scratch1_size,
 	.persist1 = h265d_persist1_size,
 };
 
-static struct dec_bufsize_ops dec_vp8_ops = {
+static const struct dec_bufsize_ops dec_vp8_ops = {
 	.scratch = vpxd_scratch_size,
 	.scratch1 = vp8d_scratch1_size,
 	.persist1 = vp8d_persist1_size,
 };
 
-static struct dec_bufsize_ops dec_vp9_ops = {
+static const struct dec_bufsize_ops dec_vp9_ops = {
 	.scratch = vpxd_scratch_size,
 	.scratch1 = vp9d_scratch1_size,
 	.persist1 = vp9d_persist1_size,
 };
 
-static struct dec_bufsize_ops dec_mpeg2_ops = {
+static const struct dec_bufsize_ops dec_mpeg2_ops = {
 	.scratch = mpeg2d_scratch_size,
 	.scratch1 = mpeg2d_scratch1_size,
 	.persist1 = mpeg2d_persist1_size,
 };
 
-static struct enc_bufsize_ops enc_h264_ops = {
+static const struct enc_bufsize_ops enc_h264_ops = {
 	.scratch = h264e_scratch_size,
 	.scratch1 = h264e_scratch1_size,
 	.scratch2 = enc_scratch2_size,
 	.persist = enc_persist_size,
 };
 
-static struct enc_bufsize_ops enc_h265_ops = {
+static const struct enc_bufsize_ops enc_h265_ops = {
 	.scratch = h265e_scratch_size,
 	.scratch1 = h265e_scratch1_size,
 	.scratch2 = enc_scratch2_size,
 	.persist = enc_persist_size,
 };
 
-static struct enc_bufsize_ops enc_vp8_ops = {
+static const struct enc_bufsize_ops enc_vp8_ops = {
 	.scratch = vp8e_scratch_size,
 	.scratch1 = vp8e_scratch1_size,
 	.scratch2 = enc_scratch2_size,
@@ -1185,7 +1185,7 @@ static int bufreq_dec(struct hfi_plat_buffers_params *params, u32 buftype,
 	enum hfi_version version = params->version;
 	u32 codec = params->codec;
 	u32 width = params->width, height = params->height, out_min_count;
-	struct dec_bufsize_ops *dec_ops;
+	const struct dec_bufsize_ops *dec_ops;
 	bool is_secondary_output = params->dec.is_secondary_output;
 	bool is_interlaced = params->dec.is_interlaced;
 	u32 max_mbs_per_frame = params->dec.max_mbs_per_frame;
@@ -1255,7 +1255,7 @@ static int bufreq_enc(struct hfi_plat_buffers_params *params, u32 buftype,
 		      struct hfi_buffer_requirements *bufreq)
 {
 	enum hfi_version version = params->version;
-	struct enc_bufsize_ops *enc_ops;
+	const struct enc_bufsize_ops *enc_ops;
 	u32 width = params->width;
 	u32 height = params->height;
 	bool is_tenbit = params->enc.is_tenbit;
-- 
2.34.1

