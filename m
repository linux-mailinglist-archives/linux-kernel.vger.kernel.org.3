Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBAE567264
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiGEPWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiGEPWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:22:00 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4411118B0A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:21:58 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id j15so6007208vkp.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zHbKKGR+Wv/3OU+gW+VqdMcUxYMzP8bmEQJt54cYuBU=;
        b=zh64ulqMye88ggew4xToJ9pGFLWZY/NQ9Yaz4tTu8C/S11bO2LzpGtROkxTYiyLziv
         bpEmInz1UlKkT0cXaGCCTPLs/DA6J3zdXOgtaFp6sBizyG0O5wTLzaHupmw+jX9bcRRH
         5oT+vw1p21rnHupvnOjWgI7RkaVHan+GDqIh9voDM/iuN3FNHN8+Ih8S+l3JwY8abNaN
         zx3MxsNxiZa3TgH58WfYJQTSXcFoLcEFl1tihXt3hKlxONege8dja76GL9Ba6Z+zBupD
         EjtZunig7zpSENXeLotPYKAjUzqQ5MC8PxKifr1hv1N6gz4GKFrp2R4vtZx74/Bt5iEB
         r/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zHbKKGR+Wv/3OU+gW+VqdMcUxYMzP8bmEQJt54cYuBU=;
        b=IgQlHrv55jDgYAO1eEnPg4JQD0TSuSmSPA0BP4Gz2ZLPmqaDUtoUc/D6J+kLs8LWNX
         zlFGaCmK/BcCZrsm/f6lXPlWGnapYNzZAwDSp8U18PVDtTd4zdtGcQgg9gFryLdPCEKT
         oOltdREDviQoizSgKgbAMPdDkp9Ru8YeCO+NBzED07nFjHzSjT0S3tdR3uCFw1tD9nsU
         +7Mei52rc8RLkx4/e2Y75b9pvegtX0dQqDy9vbrhMT+MsyWSi/ZtTS1pgjOOP6tdEl85
         F1Dxxy8eP8ER8Yt36aXUn4+ebRO1pFhKnakKPnPeFY/U7CFTVMce2ZK65P9gCxp6uu7E
         xFWw==
X-Gm-Message-State: AJIora8wNevBjk5bs1PCJpTF3lVkAK2gUjZuyi+bAt60O2NKiWd1vYM6
        7R0SAIHSt2rWioFyAgCLyTq5JWOAcsHPV94Z
X-Google-Smtp-Source: AGRyM1vv1TQom6v/kGvdJ+vbVe2gwOtECASq1yaAWyDd4ax0uN1sm7T1n0ryHKYnK6V1qbtOUCHazg==
X-Received: by 2002:a1f:b493:0:b0:370:3d3d:c2c9 with SMTP id d141-20020a1fb493000000b003703d3dc2c9mr20615151vkf.10.1657034517256;
        Tue, 05 Jul 2022 08:21:57 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id y66-20020a1f3245000000b0036ca4583f08sm6849462vky.16.2022.07.05.08.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 08:21:56 -0700 (PDT)
Date:   Tue, 5 Jul 2022 12:21:51 -0300
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, hverkuil@xs4all.nl, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Subject: Re: [PATCH v10 06/17] media: uapi: HEVC: Change pic_order_cnt
 definition in v4l2_hevc_dpb_entry
Message-ID: <YsRXD50CusUmQMyx@eze-laptop>
References: <20220705085420.272912-1-benjamin.gaignard@collabora.com>
 <20220705085420.272912-7-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220705085420.272912-7-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 10:54:09AM +0200, Benjamin Gaignard wrote:
> The HEVC specification describes the following:
> "PicOrderCntVal is derived as follows:
> PicOrderCntVal = PicOrderCntMsb + slice_pic_order_cnt_lsb
> The value of PicOrderCntVal shall be in the range of −2^31 to 2^31 − 1, inclusive."
> 
> To match with these definitions change __u16 pic_order_cnt[2]
> into __s32 pic_order_cnt_val.
> Change v4l2_ctrl_hevc_slice_params->slice_pic_order_cnt to __s32 too.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Good catch.

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> ---
>  Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 2 +-
>  drivers/staging/media/hantro/hantro_g2_hevc_dec.c         | 7 +++----
>  drivers/staging/media/hantro/hantro_hevc.c                | 2 +-
>  drivers/staging/media/hantro/hantro_hw.h                  | 4 ++--
>  drivers/staging/media/sunxi/cedrus/cedrus_h265.c          | 4 ++--
>  include/media/hevc-ctrls.h                                | 4 ++--
>  6 files changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index 868669ae6831..3dfb81a93935 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -3010,7 +3010,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>      * - __u8
>        - ``colour_plane_id``
>        -
> -    * - __u16
> +    * - __s32
>        - ``slice_pic_order_cnt``
>        -
>      * - __u8
> diff --git a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> index 5df6f08e26f5..d28653d04d20 100644
> --- a/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> +++ b/drivers/staging/media/hantro/hantro_g2_hevc_dec.c
> @@ -390,11 +390,10 @@ static int set_ref(struct hantro_ctx *ctx)
>  			 !!(pps->flags & V4L2_HEVC_PPS_FLAG_LOOP_FILTER_ACROSS_TILES_ENABLED));
>  
>  	/*
> -	 * Write POC count diff from current pic. For frame decoding only compute
> -	 * pic_order_cnt[0] and ignore pic_order_cnt[1] used in field-coding.
> +	 * Write POC count diff from current pic.
>  	 */
>  	for (i = 0; i < decode_params->num_active_dpb_entries && i < ARRAY_SIZE(cur_poc); i++) {
> -		char poc_diff = decode_params->pic_order_cnt_val - dpb[i].pic_order_cnt[0];
> +		char poc_diff = decode_params->pic_order_cnt_val - dpb[i].pic_order_cnt_val;
>  
>  		hantro_reg_write(vpu, &cur_poc[i], poc_diff);
>  	}
> @@ -421,7 +420,7 @@ static int set_ref(struct hantro_ctx *ctx)
>  	dpb_longterm_e = 0;
>  	for (i = 0; i < decode_params->num_active_dpb_entries &&
>  	     i < (V4L2_HEVC_DPB_ENTRIES_NUM_MAX - 1); i++) {
> -		luma_addr = hantro_hevc_get_ref_buf(ctx, dpb[i].pic_order_cnt[0]);
> +		luma_addr = hantro_hevc_get_ref_buf(ctx, dpb[i].pic_order_cnt_val);
>  		if (!luma_addr)
>  			return -ENOMEM;
>  
> diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/staging/media/hantro/hantro_hevc.c
> index 1df87ca88ebf..5984c5fa6f83 100644
> --- a/drivers/staging/media/hantro/hantro_hevc.c
> +++ b/drivers/staging/media/hantro/hantro_hevc.c
> @@ -33,7 +33,7 @@ void hantro_hevc_ref_init(struct hantro_ctx *ctx)
>  }
>  
>  dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx,
> -				   int poc)
> +				   s32 poc)
>  {
>  	struct hantro_hevc_dec_hw_ctx *hevc_dec = &ctx->hevc_dec;
>  	int i;
> diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
> index a2e0f0836281..33d156ccbfeb 100644
> --- a/drivers/staging/media/hantro/hantro_hw.h
> +++ b/drivers/staging/media/hantro/hantro_hw.h
> @@ -145,7 +145,7 @@ struct hantro_hevc_dec_hw_ctx {
>  	struct hantro_aux_buf tile_bsd;
>  	struct hantro_aux_buf ref_bufs[NUM_REF_PICTURES];
>  	struct hantro_aux_buf scaling_lists;
> -	int ref_bufs_poc[NUM_REF_PICTURES];
> +	s32 ref_bufs_poc[NUM_REF_PICTURES];
>  	u32 ref_bufs_used;
>  	struct hantro_hevc_dec_ctrls ctrls;
>  	unsigned int num_tile_cols_allocated;
> @@ -357,7 +357,7 @@ void hantro_hevc_dec_exit(struct hantro_ctx *ctx);
>  int hantro_g2_hevc_dec_run(struct hantro_ctx *ctx);
>  int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx);
>  void hantro_hevc_ref_init(struct hantro_ctx *ctx);
> -dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, int poc);
> +dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, s32 poc);
>  int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_t addr);
>  int hantro_hevc_validate_sps(struct hantro_ctx *ctx, const struct v4l2_ctrl_hevc_sps *sps);
>  
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> index 44f385be9f6c..411601975124 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> @@ -143,8 +143,8 @@ static void cedrus_h265_frame_info_write_dpb(struct cedrus_ctx *ctx,
>  	for (i = 0; i < num_active_dpb_entries; i++) {
>  		int buffer_index = vb2_find_timestamp(vq, dpb[i].timestamp, 0);
>  		u32 pic_order_cnt[2] = {
> -			dpb[i].pic_order_cnt[0],
> -			dpb[i].pic_order_cnt[1]
> +			dpb[i].pic_order_cnt_val,
> +			dpb[i].pic_order_cnt_val
>  		};
>  
>  		cedrus_h265_frame_info_write_single(ctx, i, dpb[i].field_pic,
> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> index 45734bd8fdfc..01c1795c57a9 100644
> --- a/include/media/hevc-ctrls.h
> +++ b/include/media/hevc-ctrls.h
> @@ -138,7 +138,7 @@ struct v4l2_hevc_dpb_entry {
>  	__u64	timestamp;
>  	__u8	flags;
>  	__u8	field_pic;
> -	__u16	pic_order_cnt[2];
> +	__s32	pic_order_cnt_val;
>  	__u8	padding[2];
>  };
>  
> @@ -181,7 +181,7 @@ struct v4l2_ctrl_hevc_slice_params {
>  	/* ISO/IEC 23008-2, ITU-T Rec. H.265: General slice segment header */
>  	__u8	slice_type;
>  	__u8	colour_plane_id;
> -	__u16	slice_pic_order_cnt;
> +	__s32	slice_pic_order_cnt;
>  	__u8	num_ref_idx_l0_active_minus1;
>  	__u8	num_ref_idx_l1_active_minus1;
>  	__u8	collocated_ref_idx;
> -- 
> 2.32.0
> 
