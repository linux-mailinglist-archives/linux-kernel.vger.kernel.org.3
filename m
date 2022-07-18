Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10539577DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiGRIkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiGRIj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:39:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB199643D;
        Mon, 18 Jul 2022 01:39:57 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:4754:89ee:32c6:e620])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0E3E46601A5B;
        Mon, 18 Jul 2022 09:39:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658133596;
        bh=uFJlbVh28vCvFCrRB8E+09sC5cWGQ1vzKMAhwWbTrnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=en7H5Elc+qGELDbGLd51olcR3g8KbpdjWOzCYbHjm99EixTXWf5J5VdxBsi7bT6VS
         JbnvXXsKuuWn7K0xQ+dQmSrp8hSUoGKKZkUr04sOHVbsJex4nfJyd+HcX1C0046WKL
         ZscW11lfFHu6RvYorQpmkUusU9Q4S1035An9uaIYXuCoEoUmdX3qoHxxvua2AjmL3Q
         ICkPvOQcZI4eyrQDoDCXNT1ONilzP32nzqiJbyfYvKgmAykUHa4REd+1k9q3mwWhwC
         5F2owl8FWSRMCvvm3nfvCKpRCvIzWOeh/CTk8+yUHnCBHPz5sZJ6hyB55DEDYVP9sS
         2/GTHrxfydvVQ==
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
Subject: [PATCH v2 4/7] media: hantro: postproc: Configure output regs to support 10bit
Date:   Mon, 18 Jul 2022 10:39:42 +0200
Message-Id: <20220718083945.200845-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220718083945.200845-1-benjamin.gaignard@collabora.com>
References: <20220718083945.200845-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move output format setting in postproc and make sure that
8/10bit configuration is correctly set.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/staging/media/hantro/hantro_g2_hevc_dec.c | 2 --
 drivers/staging/media/hantro/hantro_postproc.c    | 7 ++++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
index a917079a6ed3..a9d4ac84a8d8 100644
--- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
+++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
@@ -167,8 +167,6 @@ static void set_params(struct hantro_ctx *ctx)
 	hantro_reg_write(vpu, &g2_bit_depth_y_minus8, sps->bit_depth_luma_minus8);
 	hantro_reg_write(vpu, &g2_bit_depth_c_minus8, sps->bit_depth_chroma_minus8);
 
-	hantro_reg_write(vpu, &g2_output_8_bits, 0);
-
 	hantro_reg_write(vpu, &g2_hdr_skip_length, compute_header_skip_length(ctx));
 
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

