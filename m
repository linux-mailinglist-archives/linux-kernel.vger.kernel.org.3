Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF18465D50
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355287AbhLBEVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355392AbhLBEVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:21:06 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F76DC061758;
        Wed,  1 Dec 2021 20:17:40 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id s11so20494027ilv.3;
        Wed, 01 Dec 2021 20:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7v2+oft1GyYB1gu7XPgznWpvyo9VLPmaTWLL02YmVJw=;
        b=Gupu/bzhRAKFcPwbw5mC7IDkKK8us81cRORt6i+p7IoMrk8zDKiV5GV8qkktwNHnUA
         2ZL83W7wFPJAMVjV8jq+Dw6vo9zSTTGEZtqpnnFPhHj70hTf1Njo5jjZdqQ6WBb4KCRj
         x0PtXchV37xjSFhuYOpDjf4v2cZlXyfSW3UOhmF/AO/I1oS9nDCLOqicvkiWFB8YFhRd
         pfPPB6f50rCbIiry07JjWOL3qS6HQDn9O61TV/sqFY8cxPjPZe6qTZTrP7k1pPERTFTL
         9fdduFoyW+g75vcKrj9iTIjJCQWUZMjggTA5hphpMJQTG1PW3VirtI/hAKFmjhJn9U85
         WwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7v2+oft1GyYB1gu7XPgznWpvyo9VLPmaTWLL02YmVJw=;
        b=b7NdDHjbloSj0dUUIXX2XlzdVUbHecop2dAP+x5/mYZp8dpSvfwimhMdGjFOpElpt4
         mZvAthY6DX7BU9nsf6MLJlwbVMywBJqUvDFJnqzBxe+f6seDCHYnFY6G7H6cQo+EKULs
         YTZ3ignGC2pWFO7aUQmzH8Sde61uGg/jozj8hdbyPny1VTmc7DIyRQVwEbZy1D0bcplD
         Suqta6mXkV/VavMbhuHyQGABBKxE0PEG4Uqs5BWRceJUd2Dd8iW2WelesF+PjpwIxR+K
         TOKN2AV80xDZvPpNga8VgIXFJGJFDz+uPyLdJYRxCAmBCIbwnLUZsGrUYd269FHbu+GS
         IRKw==
X-Gm-Message-State: AOAM530sxKi5wgmLMSBDLPN3Y8MbkfIYd8Jlzk/y/lW2HXOCtDM1n+K2
        KU5nsAXWNnxyKZRUuSrvGopLKfj/vec4WMqw
X-Google-Smtp-Source: ABdhPJwyqu5GR98KMLnf7FhHNm5+n5eVJzHi8UAH/XrT//TI/a/UD/bGqdf0toD3ZEVtLzF9P54kEg==
X-Received: by 2002:a92:c5ad:: with SMTP id r13mr12527595ilt.53.1638418659259;
        Wed, 01 Dec 2021 20:17:39 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:c405:2c26:c2b8:506e])
        by smtp.gmail.com with ESMTPSA id t14sm1030603ilh.62.2021.12.01.20.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 20:17:38 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     ezequiel@vanguardiasur.com.ar, tharvey@gateworks.com,
        nicolas@ndufresne.ca, aford@beaconembedded.com,
        hverkuil-cisco@xs4all.nl, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev
Subject: [RFC V3 1/2] media: hantro: Add support for i.MX8M Mini
Date:   Wed,  1 Dec 2021 22:16:26 -0600
Message-Id: <20211202041627.291625-2-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211202041627.291625-1-aford173@gmail.com>
References: <20211202041627.291625-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Mini has a similar implementation of the Hantro G1 and
G2 decoders, but the Mini uses the vpu-blk-ctrl for handling the
VPU resets through the power domain system.  As such, there are
functions present in the 8MQ that are not applicable to the Mini
which requires the driver to have a different compatible flags.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index ab2467998d29..44b604d25a33 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -608,6 +608,8 @@ static const struct of_device_id of_hantro_match[] = {
 	{ .compatible = "rockchip,rk3399-vpu", .data = &rk3399_vpu_variant, },
 #endif
 #ifdef CONFIG_VIDEO_HANTRO_IMX8M
+	{ .compatible = "nxp,imx8mm-vpu", .data = &imx8mm_vpu_variant, },
+	{ .compatible = "nxp,imx8mm-vpu-g2", .data = &imx8mm_vpu_g2_variant },
 	{ .compatible = "nxp,imx8mq-vpu", .data = &imx8mq_vpu_variant, },
 	{ .compatible = "nxp,imx8mq-vpu-g2", .data = &imx8mq_vpu_g2_variant },
 #endif
diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
index dbe51303724b..05cfafd9f1d7 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -299,6 +299,8 @@ enum hantro_enc_fmt {
 	ROCKCHIP_VPU_ENC_FMT_UYVY422 = 3,
 };
 
+extern const struct hantro_variant imx8mm_vpu_g2_variant;
+extern const struct hantro_variant imx8mm_vpu_variant;
 extern const struct hantro_variant imx8mq_vpu_g2_variant;
 extern const struct hantro_variant imx8mq_vpu_variant;
 extern const struct hantro_variant px30_vpu_variant;
diff --git a/drivers/staging/media/hantro/imx8m_vpu_hw.c b/drivers/staging/media/hantro/imx8m_vpu_hw.c
index 1a43f6fceef9..871df29dcfc7 100644
--- a/drivers/staging/media/hantro/imx8m_vpu_hw.c
+++ b/drivers/staging/media/hantro/imx8m_vpu_hw.c
@@ -271,6 +271,38 @@ static const struct hantro_codec_ops imx8mq_vpu_g2_codec_ops[] = {
 	},
 };
 
+static const struct hantro_codec_ops imx8mm_vpu_codec_ops[] = {
+	[HANTRO_MODE_MPEG2_DEC] = {
+		.run = hantro_g1_mpeg2_dec_run,
+		.init = hantro_mpeg2_dec_init,
+		.exit = hantro_mpeg2_dec_exit,
+	},
+	[HANTRO_MODE_VP8_DEC] = {
+		.run = hantro_g1_vp8_dec_run,
+		.init = hantro_vp8_dec_init,
+		.exit = hantro_vp8_dec_exit,
+	},
+	[HANTRO_MODE_H264_DEC] = {
+		.run = hantro_g1_h264_dec_run,
+		.init = hantro_h264_dec_init,
+		.exit = hantro_h264_dec_exit,
+	},
+};
+
+static const struct hantro_codec_ops imx8mm_vpu_g2_codec_ops[] = {
+	[HANTRO_MODE_HEVC_DEC] = {
+		.run = hantro_g2_hevc_dec_run,
+		.init = hantro_hevc_dec_init,
+		.exit = hantro_hevc_dec_exit,
+	},
+	[HANTRO_MODE_VP9_DEC] = {
+		.run = hantro_g2_vp9_dec_run,
+		.done = hantro_g2_vp9_dec_done,
+		.init = hantro_vp9_dec_init,
+		.exit = hantro_vp9_dec_exit,
+	},
+};
+
 /*
  * VPU variants.
  */
@@ -286,6 +318,11 @@ static const struct hantro_irq imx8mq_g2_irqs[] = {
 static const char * const imx8mq_clk_names[] = { "g1", "g2", "bus" };
 static const char * const imx8mq_reg_names[] = { "g1", "g2", "ctrl" };
 
+static const char * const imx8mm_g1_clk_names[] = { "g1", "bus" };
+static const char * const imx8mm_g1_reg_names[] = { "g1" };
+static const char * const imx8mm_g2_clk_names[] = { "g2", "bus" };
+static const char * const imx8mm_g2_reg_names[] = { "g2" };
+
 const struct hantro_variant imx8mq_vpu_variant = {
 	.dec_fmts = imx8m_vpu_dec_fmts,
 	.num_dec_fmts = ARRAY_SIZE(imx8m_vpu_dec_fmts),
@@ -321,3 +358,31 @@ const struct hantro_variant imx8mq_vpu_g2_variant = {
 	.clk_names = imx8mq_clk_names,
 	.num_clocks = ARRAY_SIZE(imx8mq_clk_names),
 };
+
+const struct hantro_variant imx8mm_vpu_variant = {
+	.dec_fmts = imx8m_vpu_dec_fmts,
+	.num_dec_fmts = ARRAY_SIZE(imx8m_vpu_dec_fmts),
+	.codec = HANTRO_MPEG2_DECODER | HANTRO_VP8_DECODER |
+		 HANTRO_H264_DECODER,
+	.codec_ops = imx8mm_vpu_codec_ops,
+	.irqs = imx8mq_irqs,
+	.num_irqs = ARRAY_SIZE(imx8mq_irqs),
+	.clk_names = imx8mm_g1_clk_names,
+	.num_clocks = ARRAY_SIZE(imx8mm_g1_clk_names),
+	.reg_names = imx8mm_g1_reg_names,
+	.num_regs = ARRAY_SIZE(imx8mm_g1_reg_names),
+};
+
+const struct hantro_variant imx8mm_vpu_g2_variant = {
+	.dec_offset = 0x0,
+	.dec_fmts = imx8m_vpu_g2_dec_fmts,
+	.num_dec_fmts = ARRAY_SIZE(imx8m_vpu_g2_dec_fmts),
+	.codec = HANTRO_HEVC_DECODER | HANTRO_VP9_DECODER,
+	.codec_ops = imx8mq_vpu_g2_codec_ops,
+	.irqs = imx8mq_g2_irqs,
+	.num_irqs = ARRAY_SIZE(imx8mq_g2_irqs),
+	.clk_names = imx8mm_g2_clk_names,
+	.num_clocks = ARRAY_SIZE(imx8mm_g2_clk_names),
+	.reg_names = imx8mm_g2_reg_names,
+	.num_regs = ARRAY_SIZE(imx8mm_g2_reg_names),
+};
-- 
2.32.0

