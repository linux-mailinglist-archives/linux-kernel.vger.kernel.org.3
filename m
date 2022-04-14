Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C214501863
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiDNQK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347078AbiDNQJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:09:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467B11066F8;
        Thu, 14 Apr 2022 08:51:08 -0700 (PDT)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:aefc:13d9:b947:5c76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 68C011F47BB1;
        Thu, 14 Apr 2022 16:51:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649951466;
        bh=0MdOcwSw6al69IA+FsMeVjUYxtwt5yjgyejYGRWyDoo=;
        h=From:To:Cc:Subject:Date:From;
        b=IDdHmQZi+s+WqBuPzdQn1KevORA6zg93AhFiALrwcMFF4ZDBI8Fa7Kgo2lQqe1PpE
         jSyAPFrfpSci05WVuvHv6yxOEcn9GKLIg/6QzZU9pJ6jMo4/al3SuS3cL65ENpUHyB
         zXoh0uulcsqUssQeLoEqFER1a3fm4iSIWLA9LiCyUMkxw+csgDSZ4H09+RSYEsw8zP
         IElE2rTldKR2yhNVsKYCRoa8I2ulE+hBI7BBezwxgo4el+MTPIcCbK6KeRKClAgzvl
         XDRvgfrdDCPk0qIJO8ZYtG+5iNDaeC15+74YIiqzPLRm1F7Fm+4VQCKHwOs4z4uyyJ
         oxc52d3BvIwdw==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        jon@nanocrew.net, aford173@gmail.com, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] media: hantro: HEVC: Fix output frame chroma offset
Date:   Thu, 14 Apr 2022 17:50:59 +0200
Message-Id: <20220414155059.1172593-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hantro decoder doesn't take care of the requested and aligned size
of the capture buffer.
Stop using the bitstream width/height and use capture frame size
stored in the context to get the correct values.

hantro_hevc_chroma_offset() and hantro_hevc_motion_vectors_offset()
are only used in hantro_g2_hevc_dec.c so take the opportunity
to move them here.

fluster HEVC score goes up from 77 to 85 successful tests (over 147)
with this patch.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 .../staging/media/hantro/hantro_g2_hevc_dec.c | 19 ++++++++++++++++---
 drivers/staging/media/hantro/hantro_hevc.c    | 17 -----------------
 drivers/staging/media/hantro/hantro_hw.h      |  2 --
 3 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
index c524af41baf5..6deb31b7b993 100644
--- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
+++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
@@ -8,6 +8,20 @@
 #include "hantro_hw.h"
 #include "hantro_g2_regs.h"
 
+#define G2_ALIGN	16
+
+static size_t hantro_hevc_chroma_offset(struct hantro_ctx *ctx)
+{
+	return ctx->dst_fmt.width * ctx->dst_fmt.height;
+}
+
+static size_t hantro_hevc_motion_vectors_offset(struct hantro_ctx *ctx)
+{
+	size_t cr_offset = hantro_hevc_chroma_offset(ctx);
+
+	return ALIGN((cr_offset * 3) / 2, G2_ALIGN);
+}
+
 static void prepare_tile_info_buffer(struct hantro_ctx *ctx)
 {
 	struct hantro_dev *vpu = ctx->dev;
@@ -335,7 +349,6 @@ static void set_ref_pic_list(struct hantro_ctx *ctx)
 static int set_ref(struct hantro_ctx *ctx)
 {
 	const struct hantro_hevc_dec_ctrls *ctrls = &ctx->hevc_dec.ctrls;
-	const struct v4l2_ctrl_hevc_sps *sps = ctrls->sps;
 	const struct v4l2_ctrl_hevc_pps *pps = ctrls->pps;
 	const struct v4l2_ctrl_hevc_decode_params *decode_params = ctrls->decode_params;
 	const struct v4l2_hevc_dpb_entry *dpb = decode_params->dpb;
@@ -343,8 +356,8 @@ static int set_ref(struct hantro_ctx *ctx)
 	struct hantro_dev *vpu = ctx->dev;
 	struct vb2_v4l2_buffer *vb2_dst;
 	struct hantro_decoded_buffer *dst;
-	size_t cr_offset = hantro_hevc_chroma_offset(sps);
-	size_t mv_offset = hantro_hevc_motion_vectors_offset(sps);
+	size_t cr_offset = hantro_hevc_chroma_offset(ctx);
+	size_t mv_offset = hantro_hevc_motion_vectors_offset(ctx);
 	u32 max_ref_frames;
 	u16 dpb_longterm_e;
 	static const struct hantro_reg cur_poc[] = {
diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/staging/media/hantro/hantro_hevc.c
index b49a41d7ae91..5d446b599219 100644
--- a/drivers/staging/media/hantro/hantro_hevc.c
+++ b/drivers/staging/media/hantro/hantro_hevc.c
@@ -27,23 +27,6 @@
 
 #define UNUSED_REF	-1
 
-#define G2_ALIGN		16
-
-size_t hantro_hevc_chroma_offset(const struct v4l2_ctrl_hevc_sps *sps)
-{
-	int bytes_per_pixel = sps->bit_depth_luma_minus8 == 0 ? 1 : 2;
-
-	return sps->pic_width_in_luma_samples *
-	       sps->pic_height_in_luma_samples * bytes_per_pixel;
-}
-
-size_t hantro_hevc_motion_vectors_offset(const struct v4l2_ctrl_hevc_sps *sps)
-{
-	size_t cr_offset = hantro_hevc_chroma_offset(sps);
-
-	return ALIGN((cr_offset * 3) / 2, G2_ALIGN);
-}
-
 static void hantro_hevc_ref_init(struct hantro_ctx *ctx)
 {
 	struct hantro_hevc_dec_hw_ctx *hevc_dec = &ctx->hevc_dec;
diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
index ed018e293ba0..8fc6c9ab63f0 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -340,8 +340,6 @@ int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx);
 dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, int poc);
 int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_t addr);
 void hantro_hevc_ref_remove_unused(struct hantro_ctx *ctx);
-size_t hantro_hevc_chroma_offset(const struct v4l2_ctrl_hevc_sps *sps);
-size_t hantro_hevc_motion_vectors_offset(const struct v4l2_ctrl_hevc_sps *sps);
 
 static inline unsigned short hantro_vp9_num_sbs(unsigned short dimension)
 {
-- 
2.32.0

