Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9888854EB11
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378460AbiFPUZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378359AbiFPUZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:25:25 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47405B89C;
        Thu, 16 Jun 2022 13:25:24 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o10so3692534edi.1;
        Thu, 16 Jun 2022 13:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sAZFh7mRhO5VdJY5wXrg6fPzhaTdxWVtl/ssmKTkC2E=;
        b=aVu8/0A973NQhvzV7dzAKr2dc4KUJdszt215rjJG2bkTyzKpMVS3wnoWovAC62pSkN
         RxSGvgOR1u/lgWTebhjTL6GS9lrLNsJY7PDTx3YRXm9QpY1WnisvQGQCil+zs34uFCWM
         eXsSll5i8NdNUEIf8bgaHg9xmjYRwr0Cn8d5ItdLkaS09AuqPi/lLXfoeEOOgj0iJDY6
         X+hYj7y14a25bQgKFp0SrMEVLymk5n3mzM74/FWoP+n6laKr+XbhxvRRbrFrKIirT6dx
         zN0I3PSaaqiX5gaTBngJh7kJKt6Jd35dDXS2JO+0j7qwjULajFXOjMsdTEfFaE7pVx/0
         UhNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sAZFh7mRhO5VdJY5wXrg6fPzhaTdxWVtl/ssmKTkC2E=;
        b=6aq/JoxFjKTk7UEKj1FQExgNVWbVLGahczF4ngvlUSYwl6Sp5Vy4pB7zbc4+S0f1yA
         BY9UZK7V26naJGdv8xn1uWMBfouZ+ILbxdoHrMCQmjYrWxHFCKL2VugVb9NZ+6v6TBgI
         Lw5GtjRr5+3VCSTF9U5eoiDuRTx/bUATs2NVc2HqYuii8/meCTJzGzc3TaI1rIUqN2sS
         BpQbSrp9jHj8zCk2jrIm1e13mDPx5ZWC3sHlUAVmzEPKWZ7tDUyy5XtbS6CYAekYCWpq
         8I5uywDISPXVK20El9tclPVvRTbY+0Mz1W882cOzI6TPyVTAT0t6Uyf0pwdS8ItPmVhj
         c17Q==
X-Gm-Message-State: AJIora8ZM4wKiW1u7xXAPNpuavyGdZdweFg1OlcuMBOxh7UnH/41KxmT
        7zNvR0yyWicm6pbgOkdq90Y=
X-Google-Smtp-Source: AGRyM1tluECB6/LrDRgfOHkAH2SU+C/+t0SlvG7aCtZSgjSRv3yTIBFIjs19gLAgczPqeJqPGTV2Ng==
X-Received: by 2002:a05:6402:26cf:b0:431:5d99:2142 with SMTP id x15-20020a05640226cf00b004315d992142mr8821320edd.242.1655411123514;
        Thu, 16 Jun 2022 13:25:23 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906329500b006fe8a4ec62fsm1186760ejw.4.2022.06.16.13.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:25:23 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        benjamin.gaignard@collabora.com, nicolas.dufresne@collabora.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 4/7] media: hantro: postproc: Fix legacy regs configuration
Date:   Thu, 16 Jun 2022 22:25:10 +0200
Message-Id: <20220616202513.351039-5-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616202513.351039-1-jernej.skrabec@gmail.com>
References: <20220616202513.351039-1-jernej.skrabec@gmail.com>
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

Some postproc legacy registers were set in VP9 code. Move them to
postproc and fix their value.

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/hantro/hantro_g2_vp9_dec.c |  8 --------
 drivers/staging/media/hantro/hantro_postproc.c   | 10 ++++++++++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_g2_vp9_dec.c b/drivers/staging/media/hantro/hantro_g2_vp9_dec.c
index 91c21b634fab..c9cb11fd95af 100644
--- a/drivers/staging/media/hantro/hantro_g2_vp9_dec.c
+++ b/drivers/staging/media/hantro/hantro_g2_vp9_dec.c
@@ -515,16 +515,8 @@ static void
 config_bit_depth(struct hantro_ctx *ctx, const struct v4l2_ctrl_vp9_frame *dec_params)
 {
 	if (ctx->dev->variant->legacy_regs) {
-		u8 pp_shift = 0;
-
 		hantro_reg_write(ctx->dev, &g2_bit_depth_y, dec_params->bit_depth);
 		hantro_reg_write(ctx->dev, &g2_bit_depth_c, dec_params->bit_depth);
-		hantro_reg_write(ctx->dev, &g2_rs_out_bit_depth, dec_params->bit_depth);
-
-		if (dec_params->bit_depth > 8)
-			pp_shift = 16 - dec_params->bit_depth;
-
-		hantro_reg_write(ctx->dev, &g2_pp_pix_shift, pp_shift);
 		hantro_reg_write(ctx->dev, &g2_pix_shift, 0);
 	} else {
 		hantro_reg_write(ctx->dev, &g2_bit_depth_y_minus8, dec_params->bit_depth - 8);
diff --git a/drivers/staging/media/hantro/hantro_postproc.c b/drivers/staging/media/hantro/hantro_postproc.c
index b77cc55e43ea..8933b4af73ed 100644
--- a/drivers/staging/media/hantro/hantro_postproc.c
+++ b/drivers/staging/media/hantro/hantro_postproc.c
@@ -130,6 +130,16 @@ static void hantro_postproc_g2_enable(struct hantro_ctx *ctx)
 		hantro_write_addr(vpu, G2_RS_OUT_LUMA_ADDR, dst_dma);
 		hantro_write_addr(vpu, G2_RS_OUT_CHROMA_ADDR, dst_dma + chroma_offset);
 	}
+	if (ctx->dev->variant->legacy_regs) {
+		int out_depth = hantro_get_format_depth(ctx->dst_fmt.pixelformat);
+		u8 pp_shift = 0;
+
+		if (out_depth > 8)
+			pp_shift = 16 - out_depth;
+
+		hantro_reg_write(ctx->dev, &g2_rs_out_bit_depth, out_depth);
+		hantro_reg_write(ctx->dev, &g2_pp_pix_shift, pp_shift);
+	}
 	hantro_reg_write(vpu, &g2_out_rs_e, 1);
 }
 
-- 
2.36.1

