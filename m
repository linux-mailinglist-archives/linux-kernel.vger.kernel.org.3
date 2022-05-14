Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E98527154
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 15:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiENNhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 09:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiENNg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 09:36:57 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A953422B01;
        Sat, 14 May 2022 06:36:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id c12so12992499edv.10;
        Sat, 14 May 2022 06:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fWumciIhP+oFBoIFbUXRMlzycA/gM0riZhiqo5gNScU=;
        b=V3ukrmo1UeLvhuLRQplrZ9DIj98TdIzk1/sq4otyZfc0INqVtkaSqdln+UYidsqJyy
         dPCMjq1+6XjKslck4xtsaIs2N2W2nnx/hXs/z0YGTPmPiNkB3lz9D+q0vlWSWxNU8LRL
         MHxVzkMIc00XFQm78Z97YHgA2c5EVUFWvLRgB9p4oMR+YJ4fb9tZRde7SSsjlb26li2g
         7w9UO67aufDizFWDU6WZjdvybkhtpTYDx6w+cWVPcY3zKfOaHU4eEBLWwJBenhvFu7C9
         kCIgc4Hl5dbQasSFP9GABY8O5sroUn1bdXtjAuNdupA0w3GUm8w9HLOoOBVKp25uEvy1
         3epQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fWumciIhP+oFBoIFbUXRMlzycA/gM0riZhiqo5gNScU=;
        b=4GbfhivGiWEs+KQhh/+P5TDDRfmHPUqYwPVI3LJ64UNGuy4pVYPiO2jvUdlm+Hlm/Y
         kn9LNnGR5UbeR0uWxmlvd5tlYV43Ios39VsnYQ5LCMPq+k3Nv3luCtNJjT8EILYcFnnr
         Wsl2Phv8Rmhh/QQWzPipToRPVaW8TrZctmp4aomkWeYgv3hhcMjjPTD182goyyYFEqXt
         VwOlEnRCMjksWckdasin1KpvikT4BRkc9F0bRGYgcYLbW2Z9ssVOc7iety2YyvupgscA
         6ehBXtF4zBf2JjgW2W93mmLlXyPOj52GXjEX9YdSZiiXym71akKbi2/Q1CJBSoHFzZI4
         9Erw==
X-Gm-Message-State: AOAM531QcOQPIkLvNEMco9dVJdrQ6501DD9KUmq59OS7wORJPOLMLiME
        My6pmtrLeVenKBJgLYOG3iA=
X-Google-Smtp-Source: ABdhPJyD0WYz9/D9X12wXHaejif0/1Ip2LueFcJDATsZp1cXy8onWFmfrxR+gjZLn4/sKxCh+pc4Zw==
X-Received: by 2002:a05:6402:3214:b0:428:9d92:e5c5 with SMTP id g20-20020a056402321400b004289d92e5c5mr3819742eda.108.1652535414308;
        Sat, 14 May 2022 06:36:54 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id ci18-20020a170907267200b006f3ef214e49sm1736739ejc.175.2022.05.14.06.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 06:36:53 -0700 (PDT)
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
Subject: [PATCH v4 2/3] media: hantro: Add support for RK356x encoder
Date:   Sat, 14 May 2022 15:36:03 +0200
Message-Id: <20220514133604.174905-3-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514133604.174905-1-frattaroli.nicolas@gmail.com>
References: <20220514133604.174905-1-frattaroli.nicolas@gmail.com>
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
index ac232b5f7825..1112e8d0c821 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -638,6 +638,7 @@ static const struct of_device_id of_hantro_match[] = {
 	{ .compatible = "rockchip,rk3288-vpu", .data = &rk3288_vpu_variant, },
 	{ .compatible = "rockchip,rk3328-vpu", .data = &rk3328_vpu_variant, },
 	{ .compatible = "rockchip,rk3399-vpu", .data = &rk3399_vpu_variant, },
+	{ .compatible = "rockchip,rk3568-vepu", .data = &rk3568_vepu_variant, },
 	{ .compatible = "rockchip,rk3568-vpu", .data = &rk3568_vpu_variant, },
 #endif
 #ifdef CONFIG_VIDEO_HANTRO_IMX8M
diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
index c5dc77125fb7..38988be04d39 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -300,6 +300,7 @@ extern const struct hantro_variant rk3066_vpu_variant;
 extern const struct hantro_variant rk3288_vpu_variant;
 extern const struct hantro_variant rk3328_vpu_variant;
 extern const struct hantro_variant rk3399_vpu_variant;
+extern const struct hantro_variant rk3568_vepu_variant;
 extern const struct hantro_variant rk3568_vpu_variant;
 extern const struct hantro_variant sama5d4_vdec_variant;
 extern const struct hantro_variant sunxi_vpu_variant;
diff --git a/drivers/staging/media/hantro/rockchip_vpu_hw.c b/drivers/staging/media/hantro/rockchip_vpu_hw.c
index fc96501f3bc8..b39813d53e57 100644
--- a/drivers/staging/media/hantro/rockchip_vpu_hw.c
+++ b/drivers/staging/media/hantro/rockchip_vpu_hw.c
@@ -417,6 +417,14 @@ static const struct hantro_codec_ops rk3399_vpu_codec_ops[] = {
 	},
 };
 
+static const struct hantro_codec_ops rk3568_vepu_codec_ops[] = {
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
+	.codec_ops = rk3568_vepu_codec_ops,
+	.irqs = rk3568_vepu_irqs,
+	.num_irqs = ARRAY_SIZE(rk3568_vepu_irqs),
+	.init = rockchip_vpu_hw_init,
+	.clk_names = rockchip_vpu_clk_names,
+	.num_clocks = ARRAY_SIZE(rockchip_vpu_clk_names)
+};
+
 const struct hantro_variant rk3568_vpu_variant = {
 	.dec_offset = 0x400,
 	.dec_fmts = rk3399_vpu_dec_fmts,
-- 
2.36.1

