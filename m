Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30244C5C6C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 15:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiB0Ov1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 09:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiB0OvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 09:51:14 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BC45D5EF;
        Sun, 27 Feb 2022 06:50:37 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id vz16so20155426ejb.0;
        Sun, 27 Feb 2022 06:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f4pmLOZiHwkHk74rBhVutCXZ7DM+WmiqJLeo0YFOJ70=;
        b=FXv4REFbBkfc0m5qyfEujO0JGMnojRG5hR4dsvRLsEJ75GA57elwyolO200jUPuS3X
         +495TTzbW3fGbTIOJzY3U5eB5rtPwRfeOQtDykJrzjgIDBUgB4Z6Yw6a4hXd7GthWnVa
         C9iH7oo9SoPsvNhSMNyNuZJe8cypIDbbNepqYxpRrKnDu5MfAZibZZprlc/H281eDHTa
         9v2DbSDvhJpZQrHnHWrw/r9PGJEDF0fq8+6IrTNNuJp7VYapzL5IiIgYGUGcpgyGops6
         3eSgUoMqzBSuna7WlR2TkDB5tFMfUOhazQ6AQPWEl/gp6D4xdSsqyUMjlAvLF+Nm/hPF
         0M2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4pmLOZiHwkHk74rBhVutCXZ7DM+WmiqJLeo0YFOJ70=;
        b=mtDhOAiZfU3DpZH41VLl/JQCpJuMSjyQ1oN9bOoD4L79hoXDTCh5cd5/CMgyOPuK7w
         ejhaK7104W4nG1p0qnv+XsuVbez8xw3jRkyaXIdcXFQhrn9XpUqgrw8DmqasxicGbAGU
         wdqdiVITmPI94FfQwoNtx8XvRe+9QPl/u1fsq/4UlKI1gUAHYkEjbyHC+QnrDC7XhmRF
         ri9D2P6hgt2UkXY1uPueLz3VJs6aCfGzg5+KlDBzV/xyRRIlg2KoMCdvYamdpWwRc0xv
         iuPxktORF8rWEUwEwEbRpjw4nKylWVTXCOXnB/5K6fLjeCccrqOKo1fQZ5E0cjomdSbE
         m0tw==
X-Gm-Message-State: AOAM532EEdI6vqOO//DDBn4+O8mucFUBmjnwzFfzxg3O02O1Ho932VIi
        rtgb5dFHaiwDuVLS3ko3D/s=
X-Google-Smtp-Source: ABdhPJz7b0SKhTXBjs0rS08oJaEy68HRnT3gkOVNb9lfTI0Os0GoXnzvKwvmvEfx3CIQyLG6wudkcQ==
X-Received: by 2002:a17:906:fb8a:b0:6b5:d269:bb48 with SMTP id lr10-20020a170906fb8a00b006b5d269bb48mr12677338ejb.91.1645973436442;
        Sun, 27 Feb 2022 06:50:36 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709063e8100b006ce06ed8aa7sm3501887ejj.142.2022.02.27.06.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 06:50:36 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, nicolas@ndufresne.ca, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, wens@csie.org, samuel@sholland.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [RFC PATCH 6/8] media: hantro: Store VP9 bit depth in context
Date:   Sun, 27 Feb 2022 15:49:24 +0100
Message-Id: <20220227144926.3006585-7-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227144926.3006585-1-jernej.skrabec@gmail.com>
References: <20220227144926.3006585-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have proper infrastructure for postprocessing 10-bit
formats, store VP9 bit depth in context.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/hantro/hantro_drv.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index 6a51f39dde56..305090365e74 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -320,6 +320,24 @@ static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
 	return 0;
 }
 
+static int hantro_vp9_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct hantro_ctx *ctx;
+
+	ctx = container_of(ctrl->handler,
+			   struct hantro_ctx, ctrl_handler);
+
+	switch (ctrl->id) {
+	case V4L2_CID_STATELESS_VP9_FRAME:
+		ctx->bit_depth = ctrl->p_new.p_vp9_frame->bit_depth;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct v4l2_ctrl_ops hantro_ctrl_ops = {
 	.try_ctrl = hantro_try_ctrl,
 };
@@ -332,6 +350,10 @@ static const struct v4l2_ctrl_ops hantro_hevc_ctrl_ops = {
 	.s_ctrl = hantro_hevc_s_ctrl,
 };
 
+static const struct v4l2_ctrl_ops hantro_vp9_ctrl_ops = {
+	.s_ctrl = hantro_vp9_s_ctrl,
+};
+
 static const struct hantro_ctrl controls[] = {
 	{
 		.codec = HANTRO_JPEG_ENCODER,
@@ -478,6 +500,7 @@ static const struct hantro_ctrl controls[] = {
 		.codec = HANTRO_VP9_DECODER,
 		.cfg = {
 			.id = V4L2_CID_STATELESS_VP9_FRAME,
+			.ops = &hantro_vp9_ctrl_ops,
 		},
 	}, {
 		.codec = HANTRO_VP9_DECODER,
-- 
2.35.1

