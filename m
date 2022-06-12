Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0995547AE2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbiFLPyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237801AbiFLPyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:54:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AB837A3F;
        Sun, 12 Jun 2022 08:54:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id fu3so6760300ejc.7;
        Sun, 12 Jun 2022 08:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yu3zJrhDtAIjX/JKOisZTmOJ2HJDDEs7iY4VN6uLHbw=;
        b=DjFhspefxnMPvrtG/Cq54juBFoMZEnZdNH0qgLkwgXorAY7kJKL8wRquMTwe7BXZZR
         yQ2GIETAe/tqKAI9RcKxHB8LrQnAblBbB3NgVfFmh2fAFmU6DFk96WeIEkCN3N2rHdaH
         Nv3gYpWFJBw61IXDe8XDkpAtuoePEM003GiozBojYP5PhdC3IUrjwzhab/rJa5oNiRA6
         1UW0LL8E8NtbIryj9KlkAIm3UAaXeOg9tfc8y3/C6rXXnwao5/L/UKvoyqIneoKFGqMu
         O1M3FpXhwX4b+gWdybOeLuz1N1bPFomUKUiverj14enBu2EWyfeEONA/QDUUeKlQRZGX
         S9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yu3zJrhDtAIjX/JKOisZTmOJ2HJDDEs7iY4VN6uLHbw=;
        b=b5OspUkWM4bDw5eaaEnewX7P1P2XzIW1Tzp+EVSTex/06tIPuy4GKNLv8ZGnBzqkvO
         5oWNGd0JdZFyYsxQpz0GJ+HF/V9cggJTblJ0wh+6+3PglrEmh79LeOc9GehEeT390bKQ
         9WIQGtXySJjyHNbV5eFQ06304QFkD5fgcnl4BWcsAG1jPRV8CRWiJ0rRR+Ov5KtjNP+Y
         qJvGpRMrvIrNcj7m/hQcJjrPTwFRiqwSBl3t1Jg/5R8LWo2oDFA8fOFUe4db7e2JmEH7
         F6VF2fRUb4GSYw+k+9+UUm9vsjB/hMvO2/rixwczJ6mrcOaJwr5mthsjz7Ndj66mI9RB
         ocDg==
X-Gm-Message-State: AOAM530MB+YLAio9VhEKcficZfDhx2S8m3I/xgZrOFuwBOGUwv6tiaoL
        OAPLKkl4o3FgafXaHXtLvJc=
X-Google-Smtp-Source: ABdhPJwGAuXg6rH05QmyRFfY9N1PE2VKrU+kgTIyjJ+KjV0DxbpO4OnSXeXX61PYBG8rkxAUYHYvqQ==
X-Received: by 2002:a17:906:7304:b0:6ff:a76:5b09 with SMTP id di4-20020a170906730400b006ff0a765b09mr50690145ejc.193.1655049280527;
        Sun, 12 Jun 2022 08:54:40 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id o1-20020a1709064f8100b006f3ef214de7sm2609459eju.77.2022.06.12.08.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 08:54:40 -0700 (PDT)
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
Subject: [PATCH v5 2/3] media: hantro: Add support for RK356x encoder
Date:   Sun, 12 Jun 2022 17:53:45 +0200
Message-Id: <20220612155346.16288-3-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220612155346.16288-1-frattaroli.nicolas@gmail.com>
References: <20220612155346.16288-1-frattaroli.nicolas@gmail.com>
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
index 52a960f6fa4a..8c7eb5591446 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -306,6 +306,7 @@ extern const struct hantro_variant rk3066_vpu_variant;
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

