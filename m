Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5473476FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbhLPLNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbhLPLNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:13:38 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D1AC061746;
        Thu, 16 Dec 2021 03:13:38 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id m9so34770150iop.0;
        Thu, 16 Dec 2021 03:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pVwaRVsa/dCilPzHdFqGN9Zx3nJSGjB1MUq/Bb2332o=;
        b=cZVEJud2C0aEg+ZduYDuA4QjJMzZ2lC3neSwmZNaVBq6FvNN6qPcLZSYvbclDlSyU3
         AXZdMyrKQh9LariRRwTHSiGtGItJYRXHkY99B7zIBitRVwAs++9b+laiCYJHitzJly3w
         83cVRWIkpw+z7PKysXYz0Ao/g/CIkw7Y7ys+tsxsm8CGszJ8xz953p3w9/z4wp9nDvoz
         hwL4kFybhHqESG+/J0ZyMBdtTKyVCEmvwxnzPoKH98/v1snfM36ouIW2XAEfvVd7ky2l
         BMo+E7QiQLnv81f7NiKI/4kXngLJX8CGScY50USh/VwmlNYSUSEE6KLhQXeHAG27ztVw
         X0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pVwaRVsa/dCilPzHdFqGN9Zx3nJSGjB1MUq/Bb2332o=;
        b=cnfY1Uo5ZbRn2QNXCWrN9DO8GvFmThU852zzttYqqynZ+snCnqKNneIRWTi/YsF8Lc
         OGkFN7saAQteVu4MS27tFgyun5PkV4Siew4TJ1uSui8ktQgEwZ85BoS3UptT0kP5W1cP
         sc39vTubHRaL6wImXMzonwkE2T8hdEnzWhJL13qIB2mBN3GoIgNFpe+W+How/uzHmpJT
         nEt8qVBRmgZW5VWZfIrobYzgPSkY8+fOze0fmyaA0HcWIfN4JtUpcKMsXV/POXvi/aRN
         mA5uXIaioTyGVJkqjuEqKkG+dw3u2DQ4TTVn5Xut94l4wklXcliw9kij6Ts3BhsOrk+Z
         THbw==
X-Gm-Message-State: AOAM532weUEcL6w2ON3ppHLeargJp+L7DU8qy0/Esj3uAIOP0wOTzQs2
        EVOnU+PT6TuC7l5vPXEydfI+oLHBOPqXi7r2
X-Google-Smtp-Source: ABdhPJy4sVeIMJwIQeYCLkxihsRkUDA6hNdXUFrl/38M/QwdiwK4gdsBdINrQVePG+rQxgbfDGuQSg==
X-Received: by 2002:a05:6638:3784:: with SMTP id w4mr9112168jal.144.1639653217362;
        Thu, 16 Dec 2021 03:13:37 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:fe22:1652:55f7:5197])
        by smtp.gmail.com with ESMTPSA id h1sm3090946iow.31.2021.12.16.03.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 03:13:36 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     abel.vesa@nxp.com, aford@beaconembedded.com,
        benjamin.gaignard@collabora.com, hverkuil-cisco@xs4all.nl,
        Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH V2 09/10] media: hantro: Add support for i.MX8MM
Date:   Thu, 16 Dec 2021 05:12:54 -0600
Message-Id: <20211216111256.2362683-10-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216111256.2362683-1-aford173@gmail.com>
References: <20211216111256.2362683-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8MM has a G1 and G2 video decoder, so add support in
the driver for it with the post-processing removed.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index e7afda388ee5..118c4fa3d556 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -608,6 +608,8 @@ static const struct of_device_id of_hantro_match[] = {
 	{ .compatible = "rockchip,rk3399-vpu", .data = &rk3399_vpu_variant, },
 #endif
 #ifdef CONFIG_VIDEO_HANTRO_IMX8M
+	{ .compatible = "nxp,imx8mm-vpu-g1", .data = &imx8mm_vpu_g1_variant, },
+	{ .compatible = "nxp,imx8mm-vpu-g2", .data = &imx8mm_vpu_g2_variant },
 	{ .compatible = "nxp,imx8mq-vpu", .data = &imx8mq_vpu_variant, },
 	{ .compatible = "nxp,imx8mq-vpu-g1", .data = &imx8mq_vpu_g1_variant },
 	{ .compatible = "nxp,imx8mq-vpu-g2", .data = &imx8mq_vpu_g2_variant },
diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
index 96b14b43a4af..6ae1aeed2e16 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -299,6 +299,8 @@ enum hantro_enc_fmt {
 	ROCKCHIP_VPU_ENC_FMT_UYVY422 = 3,
 };
 
+extern const struct hantro_variant imx8mm_vpu_g1_variant;
+extern const struct hantro_variant imx8mm_vpu_g2_variant;
 extern const struct hantro_variant imx8mq_vpu_g1_variant;
 extern const struct hantro_variant imx8mq_vpu_g2_variant;
 extern const struct hantro_variant imx8mq_vpu_variant;
diff --git a/drivers/staging/media/hantro/imx8m_vpu_hw.c b/drivers/staging/media/hantro/imx8m_vpu_hw.c
index 4925f2a07d4c..dc7fc19283e8 100644
--- a/drivers/staging/media/hantro/imx8m_vpu_hw.c
+++ b/drivers/staging/media/hantro/imx8m_vpu_hw.c
@@ -347,3 +347,26 @@ const struct hantro_variant imx8mq_vpu_g2_variant = {
 	.clk_names = imx8mq_g2_clk_names,
 	.num_clocks = ARRAY_SIZE(imx8mq_g2_clk_names),
 };
+
+const struct hantro_variant imx8mm_vpu_g1_variant = {
+	.dec_fmts = imx8m_vpu_dec_fmts,
+	.num_dec_fmts = ARRAY_SIZE(imx8m_vpu_dec_fmts),
+	.codec = HANTRO_MPEG2_DECODER | HANTRO_VP8_DECODER |
+		 HANTRO_H264_DECODER,
+	.codec_ops = imx8mq_vpu_g1_codec_ops,
+	.irqs = imx8mq_irqs,
+	.num_irqs = ARRAY_SIZE(imx8mq_irqs),
+	.clk_names = imx8mq_g1_clk_names,
+	.num_clocks = ARRAY_SIZE(imx8mq_g1_clk_names),
+};
+
+const struct hantro_variant imx8mm_vpu_g2_variant = {
+	.dec_fmts = imx8m_vpu_g2_dec_fmts,
+	.num_dec_fmts = ARRAY_SIZE(imx8m_vpu_g2_dec_fmts),
+	.codec = HANTRO_HEVC_DECODER | HANTRO_VP9_DECODER,
+	.codec_ops = imx8mq_vpu_g2_codec_ops,
+	.irqs = imx8mq_g2_irqs,
+	.num_irqs = ARRAY_SIZE(imx8mq_g2_irqs),
+	.clk_names = imx8mq_g2_clk_names,
+	.num_clocks = ARRAY_SIZE(imx8mq_g2_clk_names),
+};
-- 
2.32.0

