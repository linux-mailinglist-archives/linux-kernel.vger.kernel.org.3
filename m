Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C91A51257C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbiD0Wth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbiD0Wsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:48:53 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D425E2AE21;
        Wed, 27 Apr 2022 15:45:39 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id r13so6147580ejd.5;
        Wed, 27 Apr 2022 15:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SEsb2SgWolkRqj7dWyYbDSsU9Xv91zJdA8mUTyxyeSw=;
        b=aEKrgVIFzfcrqdNWBk+yt0k4UIxXu/l9JXBIdydEEKJhtT3JJ7J5Kbs/EkLl5I6c2i
         z3TR7WBb17BgE8T1h7HIn3HNNeCtacxjV9/5IKD3VyGbI/tkKQaIPmn9GhzppBAhsfet
         7o66wMZYwFkZVzqYXbgJsD7W8h782CmMCvo7jWS/URIqUP6KRNzQu8WExNO6RPFZMHtS
         VXAgqEQWKOTSTtlDQty6qCyMROioe+pQPZHw/MRY+OE4lJnqFo5ZJQ8vRBarpf8LWhBM
         JWCxP8SzZfD9Q0TgzuuKLi7p8k1pNqdO8/q/06Q2viSsqHfZCL7M76tUEaPXjqBHo/Qv
         Op1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SEsb2SgWolkRqj7dWyYbDSsU9Xv91zJdA8mUTyxyeSw=;
        b=XIzz6mPtsjAlPh2CjxKo+og3JoYwoCTismrcVqWdps9c1TuoY5bAhZBrrxm/gbdMUT
         oQ/4+cOp3CXpoAYOJJAmlToUAEehANAvMBLm3YM7jghI3vF6hirXemuN44e8YTMqcfup
         5bN4kKNgDcHvQTrnX6l0vK5BF4K7Gq9JbhukGMcfaxaCcdGdKkwA5qPzBAsz5ANioI9c
         wpG0zlGNbOmOHnOtMiySfd6+7qRm9fY8N0C4zLM1TnHWcfsl1XDE2AqRNSxHt3+0yLQq
         hkN6kpGh3OiTzKattTc2Z9bVgLhfR23MispB5/ZEQgk4oRurrca3Eh/x9dnb2XqNmeQ5
         iHvw==
X-Gm-Message-State: AOAM530oFzLzY15dR20f36uTOfiUr1Z2ypDppRtUjOpZBQIhfmThuHrE
        I/TqiUfkBrIOsbsw5rbI3HU=
X-Google-Smtp-Source: ABdhPJzTIKk2WZLdAghMr47bsyg/97696M6Bp2l3/n9Ropf3wqIzZufO2zQq2dPcsDeSYblym2EPPA==
X-Received: by 2002:a17:907:98cf:b0:6f3:9901:bc0c with SMTP id kd15-20020a17090798cf00b006f39901bc0cmr15581065ejc.315.1651099538353;
        Wed, 27 Apr 2022 15:45:38 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id t27-20020a1709063e5b00b006f3a94f5194sm3762594eji.77.2022.04.27.15.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 15:45:37 -0700 (PDT)
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
Subject: [PATCH 2/3] media: hantro: Add support for RK356x JPEG encoder
Date:   Thu, 28 Apr 2022 00:44:37 +0200
Message-Id: <20220427224438.335327-3-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427224438.335327-1-frattaroli.nicolas@gmail.com>
References: <20220427224438.335327-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RK3566 and RK3568 SoCs come with a small Hantro instance which
is solely dedicated to encoding JPEG. This patch adds the necessary
structs to the Hantro driver to allow it to function.

Tested with the following GStreamer command:

gst-launch-1.0 videotestsrc ! v4l2jpegenc ! matroskamux ! \
               filesink location=foo.mkv

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 drivers/staging/media/hantro/hantro_drv.c     |  1 +
 drivers/staging/media/hantro/hantro_hw.h      |  1 +
 .../staging/media/hantro/rockchip_vpu_hw.c    | 62 +++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index dc768884cb79..3add9babd7bb 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -628,6 +628,7 @@ static const struct of_device_id of_hantro_match[] = {
 	{ .compatible = "rockchip,rk3288-vpu", .data = &rk3288_vpu_variant, },
 	{ .compatible = "rockchip,rk3328-vpu", .data = &rk3328_vpu_variant, },
 	{ .compatible = "rockchip,rk3399-vpu", .data = &rk3399_vpu_variant, },
+	{ .compatible = "rockchip,rk3568-jpeg-vepu", .data = &rk3568_jpeg_vepu_variant, },
 #endif
 #ifdef CONFIG_VIDEO_HANTRO_IMX8M
 	{ .compatible = "nxp,imx8mm-vpu-g1", .data = &imx8mm_vpu_g1_variant, },
diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
index ed018e293ba0..dd7f1edfacf2 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -300,6 +300,7 @@ extern const struct hantro_variant rk3066_vpu_variant;
 extern const struct hantro_variant rk3288_vpu_variant;
 extern const struct hantro_variant rk3328_vpu_variant;
 extern const struct hantro_variant rk3399_vpu_variant;
+extern const struct hantro_variant rk3568_jpeg_vepu_variant;
 extern const struct hantro_variant sama5d4_vdec_variant;
 extern const struct hantro_variant sunxi_vpu_variant;
 
diff --git a/drivers/staging/media/hantro/rockchip_vpu_hw.c b/drivers/staging/media/hantro/rockchip_vpu_hw.c
index 163cf92eafca..10d3ea92a954 100644
--- a/drivers/staging/media/hantro/rockchip_vpu_hw.c
+++ b/drivers/staging/media/hantro/rockchip_vpu_hw.c
@@ -204,6 +204,43 @@ static const struct hantro_fmt rk3399_vpu_dec_fmts[] = {
 	},
 };
 
+static const struct hantro_fmt rk3568_jpeg_vepu_enc_fmts[] = {
+	{
+		.fourcc = V4L2_PIX_FMT_YUV420M,
+		.codec_mode = HANTRO_MODE_NONE,
+		.enc_fmt = ROCKCHIP_VPU_ENC_FMT_YUV420P,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_NV12M,
+		.codec_mode = HANTRO_MODE_NONE,
+		.enc_fmt = ROCKCHIP_VPU_ENC_FMT_YUV420SP,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_YUYV,
+		.codec_mode = HANTRO_MODE_NONE,
+		.enc_fmt = ROCKCHIP_VPU_ENC_FMT_YUYV422,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_UYVY,
+		.codec_mode = HANTRO_MODE_NONE,
+		.enc_fmt = ROCKCHIP_VPU_ENC_FMT_UYVY422,
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_JPEG,
+		.codec_mode = HANTRO_MODE_JPEG_ENC,
+		.max_depth = 2,
+		.header_size = JPEG_HEADER_SIZE,
+		.frmsize = {
+			.min_width = 96,
+			.max_width = 8192,
+			.step_width = MB_DIM,
+			.min_height = 32,
+			.max_height = 8192,
+			.step_height = MB_DIM,
+		},
+	},
+};
+
 static irqreturn_t rockchip_vpu1_vepu_irq(int irq, void *dev_id)
 {
 	struct hantro_dev *vpu = dev_id;
@@ -417,6 +454,14 @@ static const struct hantro_codec_ops rk3399_vpu_codec_ops[] = {
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
@@ -439,6 +484,10 @@ static const struct hantro_irq rockchip_vpu2_irqs[] = {
 	{ "vdpu", rockchip_vpu2_vdpu_irq },
 };
 
+static const struct hantro_irq rk3568_jpeg_vepu_irqs[] = {
+	{ "vepu", rockchip_vpu2_vepu_irq },
+};
+
 static const char * const rk3066_vpu_clk_names[] = {
 	"aclk_vdpu", "hclk_vdpu",
 	"aclk_vepu", "hclk_vepu"
@@ -545,6 +594,19 @@ const struct hantro_variant rk3399_vpu_variant = {
 	.num_clocks = ARRAY_SIZE(rockchip_vpu_clk_names)
 };
 
+const struct hantro_variant rk3568_jpeg_vepu_variant = {
+	.enc_offset = 0x0,
+	.enc_fmts = rk3568_jpeg_vepu_enc_fmts,
+	.num_enc_fmts = ARRAY_SIZE(rk3568_jpeg_vepu_enc_fmts),
+	.codec = HANTRO_JPEG_ENCODER,
+	.codec_ops = rk3568_jpeg_enc_codec_ops,
+	.irqs = rk3568_jpeg_vepu_irqs,
+	.num_irqs = ARRAY_SIZE(rk3568_jpeg_vepu_irqs),
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

