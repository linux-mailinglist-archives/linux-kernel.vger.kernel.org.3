Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1149354F720
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382193AbiFQL6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382153AbiFQL6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:58:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1103220FB;
        Fri, 17 Jun 2022 04:58:14 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:faf2:1a12:f903:cc5e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 41CDA6601809;
        Fri, 17 Jun 2022 12:58:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655467093;
        bh=kUbZWcRNMzi2WPQGtQkKDBy7v+BVLv+T6REBwhFVdjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bn5lVlUZ05Irb3YPu9DZK8DCwGHAWJN5F/jMYFiHf4nZ7ywixtkYyn9UlbgWqpYcf
         RupN7jPpa20cfQhciZPGk8VAUKDDu49b/xeoWP9zPNV+WUszpA0inmUIHFAzCr1G4m
         uIvezZsos/DGe+4Q7Kwa87uyhe4cc3MzJk88Eig7j9LLlDO3nfR4uWOYWr2ShFMW+B
         tvirxAg+q8poypQs7AHuhAavBsESEfT5yEp9OMrc8UYAGse/QGP68dF+4aUPprEdfQ
         Mh7WVsX/1pdMsOb8M0NsfSs1QmStYpCh31E1b0UjyacBYU/3UW5uxBNiot+5imMaYJ
         OaMHD5SPk47Tg==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH 4/7] media: hantro: postproc: Configure output regs to support 10bit
Date:   Fri, 17 Jun 2022 13:57:59 +0200
Message-Id: <20220617115802.396442-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220617115802.396442-1-benjamin.gaignard@collabora.com>
References: <20220617115802.396442-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move output format setting in postproc and make sure that
8/10bit configuration is correctly set.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/staging/media/hantro/hantro_g2_hevc_dec.c | 2 --
 drivers/staging/media/hantro/hantro_postproc.c    | 7 ++++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
index 8407ad45b7b7..c929f2974a01 100644
--- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
+++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
@@ -167,8 +167,6 @@ static void set_params(struct hantro_ctx *ctx)
 	hantro_reg_write(vpu, &g2_bit_depth_y_minus8, sps->bit_depth_luma_minus8);
 	hantro_reg_write(vpu, &g2_bit_depth_c_minus8, sps->bit_depth_chroma_minus8);
 
-	hantro_reg_write(vpu, &g2_output_8_bits, 0);
-
 	hantro_reg_write(vpu, &g2_hdr_skip_length, compute_header_skip_lenght(ctx));
 
 	min_log2_cb_size = sps->log2_min_luma_coding_block_size_minus3 + 3;
diff --git a/drivers/staging/media/hantro/hantro_postproc.c b/drivers/staging/media/hantro/hantro_postproc.c
index a0928c508434..09d8cf942689 100644
--- a/drivers/staging/media/hantro/hantro_postproc.c
+++ b/drivers/staging/media/hantro/hantro_postproc.c
@@ -114,6 +114,7 @@ static void hantro_postproc_g2_enable(struct hantro_ctx *ctx)
 	struct hantro_dev *vpu = ctx->dev;
 	struct vb2_v4l2_buffer *dst_buf;
 	int down_scale = down_scale_factor(ctx);
+	int out_depth;
 	size_t chroma_offset;
 	dma_addr_t dst_dma;
 
@@ -132,8 +133,9 @@ static void hantro_postproc_g2_enable(struct hantro_ctx *ctx)
 		hantro_write_addr(vpu, G2_RS_OUT_LUMA_ADDR, dst_dma);
 		hantro_write_addr(vpu, G2_RS_OUT_CHROMA_ADDR, dst_dma + chroma_offset);
 	}
+
+	out_depth = hantro_get_format_depth(ctx->dst_fmt.pixelformat);
 	if (ctx->dev->variant->legacy_regs) {
-		int out_depth = hantro_get_format_depth(ctx->dst_fmt.pixelformat);
 		u8 pp_shift = 0;
 
 		if (out_depth > 8)
@@ -141,6 +143,9 @@ static void hantro_postproc_g2_enable(struct hantro_ctx *ctx)
 
 		hantro_reg_write(ctx->dev, &g2_rs_out_bit_depth, out_depth);
 		hantro_reg_write(ctx->dev, &g2_pp_pix_shift, pp_shift);
+	} else {
+		hantro_reg_write(vpu, &g2_output_8_bits, out_depth > 8 ? 0 : 1);
+		hantro_reg_write(vpu, &g2_output_format, out_depth > 8 ? 1 : 0);
 	}
 	hantro_reg_write(vpu, &g2_out_rs_e, 1);
 }
-- 
2.32.0

