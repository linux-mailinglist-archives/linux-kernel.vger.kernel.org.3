Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC444622BE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhK2VDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbhK2VBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:01:51 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B89C11FA3C;
        Mon, 29 Nov 2021 10:26:44 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q3so15980307wru.5;
        Mon, 29 Nov 2021 10:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rykXE60I0Y7JiVT/uJO8EW7eAhlfSUfHDqLyJscSYmA=;
        b=dRPLlC4HinvWIj2a5lnl5bEXhWSCXUyRk7gjn6BqyaXCyjdpJV0oWNVJPQXEjexDd+
         cn01j7Md/5mN3TIVlb56jirBgE1knom84xmY3TWJ/rBV0+8slu+g3CKiz5R3C2QeBJbU
         beFPhhjIuqWewPaU2IcLwGv1+0ahuQXoJeXXhGeu1BIS0dUKhGBxmad/QVY+6PtaX/g1
         diOwC0pbo3hEuvIGKvWPtcoF9nVrPmQQEoonlaipTE/cLwx0jxayhjIR+OTb719WkkzW
         5tZ6SFZiFMd3w9bBvkpg1Wtp3lgsjSWORUysIle7H7LBuggNq+dk4APD2LkZW9hgRI8k
         E1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rykXE60I0Y7JiVT/uJO8EW7eAhlfSUfHDqLyJscSYmA=;
        b=u9SvSpykO5HzPM8Q6x2IbuYSOzh+gJ4ebKkef78fyftMlgriAAOHCwiBzkb5yoI1wr
         LtfuiI+CGUzwOKiJC3zoEbNt+NElceQc8Sp2wBvfKDDWmXwqAdlCACEpT2Nu/aXWPnj9
         KWuIRrHeWtiBuoYcY2XmM3Og7hXd9O3Q6u6kP7nvRJBuLCDo5ba3QAOfirF6sXQA2Fzi
         A8fM9eWzP3SNVktpjtkx5IY9ktxmCrMWBPramKU6nHoTmRV/Gi2Yk2lS6uoVkJMCzmD1
         FYxXbHyaC7I5iyoEJDG1wuk1LgS01n++8O5Hd+QxerXGCEw/wZhe3/vsiYVwfwMe68YU
         XjhA==
X-Gm-Message-State: AOAM530KboVYiR+xcOXa0iqs/PsSlCedwClBZLGerjtk69mCzMX904Ez
        OlrMBefhpSAPSpjFe59as5tqvOWhgBl14g==
X-Google-Smtp-Source: ABdhPJz+0uIzSf32zqrfRT9HSUCgW367WqwSMk1yvA9xtCOVp1HgF06PUSo0bYW3cexLEeVJOI2kxg==
X-Received: by 2002:a5d:65c7:: with SMTP id e7mr35193975wrw.319.1638210402751;
        Mon, 29 Nov 2021 10:26:42 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id o12sm85907wmq.12.2021.11.29.10.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:26:42 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        mchehab@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, p.zabel@pengutronix.de, andrzej.p@collabora.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 3/9] media: hantro: vp9: use double buffering if needed
Date:   Mon, 29 Nov 2021 19:26:27 +0100
Message-Id: <20211129182633.480021-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129182633.480021-1-jernej.skrabec@gmail.com>
References: <20211129182633.480021-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some G2 variants need double buffering to be enabled in order to work
correctly, like that found in Allwinner H6 SoC.

Add platform quirk for that.

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/hantro/hantro.h            | 2 ++
 drivers/staging/media/hantro/hantro_g2_regs.h    | 1 +
 drivers/staging/media/hantro/hantro_g2_vp9_dec.c | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/staging/media/hantro/hantro.h b/drivers/staging/media/hantro/hantro.h
index 33eb3e092cc1..d03824fa3222 100644
--- a/drivers/staging/media/hantro/hantro.h
+++ b/drivers/staging/media/hantro/hantro.h
@@ -73,6 +73,7 @@ struct hantro_irq {
  * @num_clocks:			number of clocks in the array
  * @reg_names:			array of register range names
  * @num_regs:			number of register range names in the array
+ * @double_buffer:		core needs double buffering
  */
 struct hantro_variant {
 	unsigned int enc_offset;
@@ -94,6 +95,7 @@ struct hantro_variant {
 	int num_clocks;
 	const char * const *reg_names;
 	int num_regs;
+	unsigned int double_buffer : 1;
 };
 
 /**
diff --git a/drivers/staging/media/hantro/hantro_g2_regs.h b/drivers/staging/media/hantro/hantro_g2_regs.h
index 9c857dd1ad9b..15a391a4650e 100644
--- a/drivers/staging/media/hantro/hantro_g2_regs.h
+++ b/drivers/staging/media/hantro/hantro_g2_regs.h
@@ -270,6 +270,7 @@
 #define g2_apf_threshold	G2_DEC_REG(55, 0, 0xffff)
 
 #define g2_clk_gate_e		G2_DEC_REG(58, 16, 0x1)
+#define g2_double_buffer_e	G2_DEC_REG(58, 15, 0x1)
 #define g2_buswidth		G2_DEC_REG(58, 8,  0x7)
 #define g2_max_burst		G2_DEC_REG(58, 0,  0xff)
 
diff --git a/drivers/staging/media/hantro/hantro_g2_vp9_dec.c b/drivers/staging/media/hantro/hantro_g2_vp9_dec.c
index e04242d10fa2..d4fc649a4da1 100644
--- a/drivers/staging/media/hantro/hantro_g2_vp9_dec.c
+++ b/drivers/staging/media/hantro/hantro_g2_vp9_dec.c
@@ -847,6 +847,8 @@ config_registers(struct hantro_ctx *ctx, const struct v4l2_ctrl_vp9_frame *dec_p
 	hantro_reg_write(ctx->dev, &g2_clk_gate_e, 1);
 	hantro_reg_write(ctx->dev, &g2_max_cb_size, 6);
 	hantro_reg_write(ctx->dev, &g2_min_cb_size, 3);
+	if (ctx->dev->variant->double_buffer)
+		hantro_reg_write(ctx->dev, &g2_double_buffer_e, 1);
 
 	config_output(ctx, dst, dec_params);
 
-- 
2.34.1

