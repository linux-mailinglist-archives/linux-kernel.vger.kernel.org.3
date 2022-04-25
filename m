Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CC250E432
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242804AbiDYPUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242873AbiDYPUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:20:15 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF996BABA4;
        Mon, 25 Apr 2022 08:17:00 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:e:60d7:2277:ba57:a2c0:3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 114AF1F431C4;
        Mon, 25 Apr 2022 16:16:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650899819;
        bh=UmvIinIkuSWeMLIsxuIACv1w2HkCY+hYynbPsEzqCY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VrWg80IjgoqHrYPMdAIK4XgC7ycga10CVgMzJSwUh6/MpAlc7ThUdiaTXJHmypMcs
         b3HRPJfCvhSVl+Ys8lOD/D8kxYV6nooBiZrscn1TC1J5mH/gikDYaHruqMPoSbNLs1
         sU2DBsc5RVJdSw/98MRJfCYvTqz3pXhtBXYHK4OZYg2bCbLHIgjfbbZFpmI7QCyyRI
         aVr4eIz5CHYFfYtvLiMNZo4gBsPPv0g7lTA3VHV2Slc9fCwAZ5aq8foJxORMaIJ/yp
         rF9kwHq4HYbOnABwHmNRLBNemitd8/rBqYhJfFH7HKdOyGNzJ7TXL7kTL7kAoE6DUC
         Aktb2kdzr77WA==
Date:   Mon, 25 Apr 2022 17:16:56 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v5 06/17] media: uapi: HEVC: Change pic_order_cnt
 definition in v4l2_hevc_dpb_entry
Message-ID: <20220425151656.pphta4u6qa5kymoa@basti-XPS-13-9310>
References: <20220407152940.738159-1-benjamin.gaignard@collabora.com>
 <20220407152940.738159-7-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220407152940.738159-7-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Benjamin,

On 07.04.2022 17:29, Benjamin Gaignard wrote:
>HEVC specifications say that:

s/HEVC specifications say that:/
   The HEVC specification describes the following:/

Greetings,
Sebastian

>"PicOrderCntVal is derived as follows:
>PicOrderCntVal = PicOrderCntMsb + slice_pic_order_cnt_lsb
>The value of PicOrderCntVal shall be in the range of −231 to 231 − 1, inclusive."
>
>To match with these definitions change __u16 pic_order_cnt[2]
>into __s32 pic_order_cnt_val.
>
>Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>---
>version 5:
>- change __u16 pic_order_cnt[2] into __s32 pic_order_cnt_val
> drivers/staging/media/hantro/hantro_g2_hevc_dec.c | 4 ++--
> drivers/staging/media/hantro/hantro_hevc.c        | 2 +-
> drivers/staging/media/hantro/hantro_hw.h          | 4 ++--
> drivers/staging/media/sunxi/cedrus/cedrus_h265.c  | 4 ++--
> include/media/hevc-ctrls.h                        | 2 +-
> 5 files changed, 8 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>index c524af41baf5..6f3c774aa3d9 100644
>--- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>+++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
>@@ -386,7 +386,7 @@ static int set_ref(struct hantro_ctx *ctx)
> 	 * pic_order_cnt[0] and ignore pic_order_cnt[1] used in field-coding.
> 	 */
> 	for (i = 0; i < decode_params->num_active_dpb_entries && i < ARRAY_SIZE(cur_poc); i++) {
>-		char poc_diff = decode_params->pic_order_cnt_val - dpb[i].pic_order_cnt[0];
>+		char poc_diff = decode_params->pic_order_cnt_val - dpb[i].pic_order_cnt_val;
>
> 		hantro_reg_write(vpu, &cur_poc[i], poc_diff);
> 	}
>@@ -413,7 +413,7 @@ static int set_ref(struct hantro_ctx *ctx)
> 	dpb_longterm_e = 0;
> 	for (i = 0; i < decode_params->num_active_dpb_entries &&
> 	     i < (V4L2_HEVC_DPB_ENTRIES_NUM_MAX - 1); i++) {
>-		luma_addr = hantro_hevc_get_ref_buf(ctx, dpb[i].pic_order_cnt[0]);
>+		luma_addr = hantro_hevc_get_ref_buf(ctx, dpb[i].pic_order_cnt_val);
> 		if (!luma_addr)
> 			return -ENOMEM;
>
>diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/staging/media/hantro/hantro_hevc.c
>index b6ec86d03d91..fadd40768579 100644
>--- a/drivers/staging/media/hantro/hantro_hevc.c
>+++ b/drivers/staging/media/hantro/hantro_hevc.c
>@@ -54,7 +54,7 @@ static void hantro_hevc_ref_init(struct hantro_ctx *ctx)
> }
>
> dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx,
>-				   int poc)
>+				   s32 poc)
> {
> 	struct hantro_hevc_dec_hw_ctx *hevc_dec = &ctx->hevc_dec;
> 	int i;
>diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
>index ed018e293ba0..a648c529662b 100644
>--- a/drivers/staging/media/hantro/hantro_hw.h
>+++ b/drivers/staging/media/hantro/hantro_hw.h
>@@ -131,7 +131,7 @@ struct hantro_hevc_dec_hw_ctx {
> 	struct hantro_aux_buf tile_bsd;
> 	struct hantro_aux_buf ref_bufs[NUM_REF_PICTURES];
> 	struct hantro_aux_buf scaling_lists;
>-	int ref_bufs_poc[NUM_REF_PICTURES];
>+	s32 ref_bufs_poc[NUM_REF_PICTURES];
> 	u32 ref_bufs_used;
> 	struct hantro_hevc_dec_ctrls ctrls;
> 	unsigned int num_tile_cols_allocated;
>@@ -337,7 +337,7 @@ int hantro_hevc_dec_init(struct hantro_ctx *ctx);
> void hantro_hevc_dec_exit(struct hantro_ctx *ctx);
> int hantro_g2_hevc_dec_run(struct hantro_ctx *ctx);
> int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx);
>-dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, int poc);
>+dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, s32 poc);
> int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_t addr);
> void hantro_hevc_ref_remove_unused(struct hantro_ctx *ctx);
> size_t hantro_hevc_chroma_offset(const struct v4l2_ctrl_hevc_sps *sps);
>diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>index 44f385be9f6c..d04521ffd920 100644
>--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>@@ -143,8 +143,8 @@ static void cedrus_h265_frame_info_write_dpb(struct cedrus_ctx *ctx,
> 	for (i = 0; i < num_active_dpb_entries; i++) {
> 		int buffer_index = vb2_find_timestamp(vq, dpb[i].timestamp, 0);
> 		u32 pic_order_cnt[2] = {
>-			dpb[i].pic_order_cnt[0],
>-			dpb[i].pic_order_cnt[1]
>+			dpb[i].pic_order_cnt_val & 0xffff,
>+			(dpb[i].pic_order_cnt_val >> 16) & 0xffff
> 		};
>
> 		cedrus_h265_frame_info_write_single(ctx, i, dpb[i].field_pic,
>diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
>index b3540167df9e..2812778b41f4 100644
>--- a/include/media/hevc-ctrls.h
>+++ b/include/media/hevc-ctrls.h
>@@ -138,7 +138,7 @@ struct v4l2_hevc_dpb_entry {
> 	__u64	timestamp;
> 	__u8	flags;
> 	__u8	field_pic;
>-	__u16	pic_order_cnt[2];
>+	__s32	pic_order_cnt_val;
> 	__u8	padding[2];
> };
>
>-- 
>2.32.0
>
