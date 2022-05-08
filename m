Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A5D51F122
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 22:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiEHUaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 16:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiEHUaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 16:30:00 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820F4E02D;
        Sun,  8 May 2022 13:26:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bv19so23300457ejb.6;
        Sun, 08 May 2022 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p/y8kwDEE09pYlbLH2XHpoLmNt2slQabq1pX4LdThWs=;
        b=hqFpDUGBEQhnZoUyBAcPrbduVWYy9dYRR/YdtNDlpJs5Jat9FGkikcr3MXBH0vHRdl
         kven41XIGh+k7EnNM6yx9qPzoHcLUA8RxttHaqPIfHk18+anqdcYuQcEHvVYPSN7mFb7
         hkqNldEjKn8vvUa6Jn+QhnnvH7K4Ii/gXqEpeDsUgO/4EsFJcoB5W8mWgNXPdOgb6483
         UgJ0rKNMqa2t6LdGg2dHQZRx5T1h+P78KwDTAnGLihixIPLxAkW4gpntRN/RnCY3mqC7
         z8Xk/pcGxIo8KNImR9ZMB5N3hU6NoighFVIW5CpD3TTd+CpVU0S9TLZagIWg+coMLQzp
         9/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p/y8kwDEE09pYlbLH2XHpoLmNt2slQabq1pX4LdThWs=;
        b=KlPsgongyn+qQpjZz3PbJtZ7wAePbPx3EIB2lrU8OneIu7dJlyEQGRHTsOlDEpAvmD
         icaGpxr6ZEK67+cvU8QUBFYzkYq5Vtk78XKt0mrgjhht8BjHlRNbl+Nf0Fn53YfP3f1a
         VKoit3jER+HM3+r5nzEGw4kdvPldTQa4wAzGFCS9eQ4hd7Z1nFD1Cw20twGsEeV1Y+VZ
         /haMwZLsT8/pKeOhzAuYHhb/fZEA6gV52emmRYWPXENfRLc1evcAfpR/juW2HxtFDqnT
         tWAP2+1dFOp/sWNFQm8gUPRBEejN8QXa//npog/Gk1+jV+RN0tXQYUM19BR70dMerbzu
         Xd8A==
X-Gm-Message-State: AOAM532hd5uoIu+oJ90uy7dnJc9wHSMkBY7u4231epgQDtHcTFTYBCWW
        2fzLEVeWyxS38dPJqznd8zI=
X-Google-Smtp-Source: ABdhPJydrEwCCJRojJ77JBqDKeWn/RhmqedOu899Ka9w0LMyDl2haPSySeYYzb1AEfNu4Jb/9LBG9A==
X-Received: by 2002:a17:906:c284:b0:6f4:dcc3:7939 with SMTP id r4-20020a170906c28400b006f4dcc37939mr11576981ejz.444.1652041564100;
        Sun, 08 May 2022 13:26:04 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id eo10-20020a1709069b0a00b006f3ef214e1esm4341459ejc.132.2022.05.08.13.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 13:26:03 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/3] media: hantro: Add support for RK356x encoder
Date:   Sun,  8 May 2022 22:25:43 +0200
Message-Id: <20220508202544.501981-3-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220508202544.501981-1-frattaroli.nicolas@gmail.com>
References: <20220508202544.501981-1-frattaroli.nicolas@gmail.com>
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

The RK3566 and RK3568 SoCs come with a small Hantro instance which is
solely dedicated to encoding. This patch adds the necessary structs to
the Hantro driver to allow the JPEG encoder of it to function.

Through some sleuthing through the vendor's MPP source code and after
closer inspection of the TRM, it was determined that the hardware likely
supports VP8 and H.264 as well.

Tested with the following GStreamer command:

gst-launch-1.0 videotestsrc ! v4l2jpegenc ! matroskamux ! \
               filesink location=foo.mkv

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 drivers/staging/media/hantro/hantro_drv.c     |  1 +
 drivers/staging/media/hantro/hantro_hw.h      |  1 +
 .../staging/media/hantro/rockchip_vpu_hw.c    | 25 +++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index dc768884cb79..0b38b41136e2 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -628,6 +628,7 @@ static const struct of_device_id of_hantro_match[] = {
 	{ .compatible = "rockchip,rk3288-vpu", .data = &rk3288_vpu_variant, },
 	{ .compatible = "rockchip,rk3328-vpu", .data = &rk3328_vpu_variant, },
 	{ .compatible = "rockchip,rk3399-vpu", .data = &rk3399_vpu_variant, },
+	{ .compatible = "rockchip,rk3568-vepu", .data = &rk3568_vepu_variant, },
 #endif
 #ifdef CONFIG_VIDEO_HANTRO_IMX8M
 	{ .compatible = "nxp,imx8mm-vpu-g1", .data = &imx8mm_vpu_g1_variant, },
diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
index ed018e293ba0..b312da654d38 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -300,6 +300,7 @@ extern const struct hantro_variant rk3066_vpu_variant;
 extern const struct hantro_variant rk3288_vpu_variant;
 extern const struct hantro_variant rk3328_vpu_variant;
 extern const struct hantro_variant rk3399_vpu_variant;
+extern const struct hantro_variant rk3568_vepu_variant;
 extern const struct hantro_variant sama5d4_vdec_variant;
 extern const struct hantro_variant sunxi_vpu_variant;
 
diff --git a/drivers/staging/media/hantro/rockchip_vpu_hw.c b/drivers/staging/media/hantro/rockchip_vpu_hw.c
index 163cf92eafca..a97a4ea8ede4 100644
--- a/drivers/staging/media/hantro/rockchip_vpu_hw.c
+++ b/drivers/staging/media/hantro/rockchip_vpu_hw.c
@@ -417,6 +417,14 @@ static const struct hantro_codec_ops rk3399_vpu_codec_ops[] = {
 	},
 };
 
+static const struct hantro_codec_ops rk3568_jpeg_enc_codec_ops[] = {
+	[HANTRO_MODE_JPEG_ENC] = {
+		.run = rockchip_vpu2_jpeg_enc_run,
+		.reset = rockchip_vpu2_enc_reset,
+		.done = rockchip_vpu2_jpeg_enc_done,
+	},
+};
+
 /*
  * VPU variant.
  */
@@ -439,6 +447,10 @@ static const struct hantro_irq rockchip_vpu2_irqs[] = {
 	{ "vdpu", rockchip_vpu2_vdpu_irq },
 };
 
+static const struct hantro_irq rk3568_vepu_irqs[] = {
+	{ "vepu", rockchip_vpu2_vepu_irq },
+};
+
 static const char * const rk3066_vpu_clk_names[] = {
 	"aclk_vdpu", "hclk_vdpu",
 	"aclk_vepu", "hclk_vepu"
@@ -545,6 +557,19 @@ const struct hantro_variant rk3399_vpu_variant = {
 	.num_clocks = ARRAY_SIZE(rockchip_vpu_clk_names)
 };
 
+const struct hantro_variant rk3568_vepu_variant = {
+	.enc_offset = 0x0,
+	.enc_fmts = rockchip_vpu_enc_fmts,
+	.num_enc_fmts = ARRAY_SIZE(rockchip_vpu_enc_fmts),
+	.codec = HANTRO_JPEG_ENCODER,
+	.codec_ops = rk3568_jpeg_enc_codec_ops,
+	.irqs = rk3568_vepu_irqs,
+	.num_irqs = ARRAY_SIZE(rk3568_vepu_irqs),
+	.init = rockchip_vpu_hw_init,
+	.clk_names = rockchip_vpu_clk_names,
+	.num_clocks = ARRAY_SIZE(rockchip_vpu_clk_names)
+};
+
 const struct hantro_variant px30_vpu_variant = {
 	.enc_offset = 0x0,
 	.enc_fmts = rockchip_vpu_enc_fmts,
-- 
2.36.0

