Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B808B56725B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiGEPT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiGEPTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:19:54 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B599A13FB5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:19:51 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id t124so1848861vsb.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SKPvviyPL26CyA8l9iar2MIM4Wl98vso25xZ3nSjowU=;
        b=c0XNEbkP56Uqlf4jbginpW0oHEPYA0t7AvZsiEserqczx9y1nIzJpBNsL8Sc6nrkj/
         q2T/YS82/7XzUAAoKEyCWX539afsddUI2xsSnt4prcm+mjMFdB32eOuzeB/EZ8vX30kY
         bO58EClJSlDOewXEm7SqHBVP309Srux5rkhUkTWEs/pYyCk3AqY9lrqtJetO8Z3ofaun
         i8OVgiYO/LzH9Igm+AMI5uxUw8y8ljzUSEEYe2E3RO31MCWc39KO5uc6saJfMtQnpPuF
         rpxBWGIQYgfm4LUJSsPfHkADD/CwTH4HT3F1UUDv7UogtFBxSYJzExYvvgyVWz2CU6kS
         Io4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SKPvviyPL26CyA8l9iar2MIM4Wl98vso25xZ3nSjowU=;
        b=1qHFyrKSeYSlxNI0irseZrF5eDV2yC9VV4sP7L/pPX80Iu+V8wx610vmZUmE3fUvjC
         BZQvK/wecoKzxoH7Z30z14DOlFjczEs9cq/KIn91wN91QUDGNiPiALUvUtgGTQbYH+kq
         jdaWT15Ue2s2znd1B+E0d9vgDH3Qu0z6DlBQtxh/Fynq8mU/fl7qmpga3PonxXblAlxN
         7vpf+FYf74uJytSvMdm/kBEbOrRt0Ts4XAfbCNmilz5Q5hW1BiYa2+uzLJzMMfYzAiRZ
         uvHXFSwXvE60qymngByUilTJLYdzvZi7iT7QjpZQstPrtm5xpvkO7UKlqFjfLNDr2IZu
         x2ig==
X-Gm-Message-State: AJIora933r1cWwc8Gxm3uOcuyQ+6PdxZ8KIBweDH6x7+84PsiMLSy+ll
        z0pG9ct6jp9JRYry48XG4hcxWQ==
X-Google-Smtp-Source: AGRyM1tMBtr7MaG5fInbc7HrIJPJwBQ3Wz4TiiPGLX6OFZzB9OSAQ2Kvd7GK6x+gf0OnNgXpAqo5AA==
X-Received: by 2002:a67:b207:0:b0:356:51a5:993e with SMTP id b7-20020a67b207000000b0035651a5993emr19609454vsf.12.1657034390773;
        Tue, 05 Jul 2022 08:19:50 -0700 (PDT)
Received: from eze-laptop ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id b5-20020ab00b05000000b00382a8b1e590sm2980986uak.20.2022.07.05.08.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 08:19:49 -0700 (PDT)
Date:   Tue, 5 Jul 2022 12:19:44 -0300
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
Subject: Re: [PATCH v10 04/17] media: uapi: HEVC: Add missing fields in HEVC
 controls
Message-ID: <YsRWkP6pCMcP2Im2@eze-laptop>
References: <20220705085420.272912-1-benjamin.gaignard@collabora.com>
 <20220705085420.272912-5-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705085420.272912-5-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 10:54:07AM +0200, Benjamin Gaignard wrote:
> Complete the HEVC controls with missing fields from H.265 specifications.
> Even if these fields aren't used by the current mainlined drivers
> they will be required for (at least) the rkvdec driver.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

> ---
> version 9:
> - fix typo
> 
>  .../media/v4l/ext-ctrls-codec.rst             | 32 +++++++++++++++++++
>  include/media/hevc-ctrls.h                    |  8 ++++-
>  2 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index 6183f43f4d73..cff742142a55 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -2683,6 +2683,16 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>      :stub-columns: 0
>      :widths:       1 1 2
>  
> +    * - __u8
> +      - ``video_parameter_set_id``
> +      - Specifies the value of the vps_video_parameter_set_id of the active VPS
> +        as described in section "7.4.3.2.1 General sequence parameter set RBSP semantics"
> +        of H.265 specifications.
> +    * - __u8
> +      - ``seq_parameter_set_id``
> +      - Provides an identifier for the SPS for reference by other syntax elements
> +        as described in section "7.4.3.2.1 General sequence parameter set RBSP semantics"
> +        of H.265 specifications.
>      * - __u16
>        - ``pic_width_in_luma_samples``
>        -
> @@ -2822,6 +2832,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>      :stub-columns: 0
>      :widths:       1 1 2
>  
> +    * - __u8
> +      - ``pic_parameter_set_id``
> +      - Identifies the PPS for reference by other syntax elements.
>      * - __u8
>        - ``num_extra_slice_header_bits``
>        -
> @@ -3048,6 +3061,15 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>      * - __u8
>        - ``ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
>        - The list of L1 reference elements as indices in the DPB.
> +    * - __u16
> +      - ``short_term_ref_pic_set_size``
> +      - Specifies the size, in bits, of the short-term reference picture set, described as st_ref_pic_set()
> +        in the specification, included in the slice header or SPS (section 7.3.6.1).
> +    * - __u16
> +      - ``long_term_ref_pic_set_size``
> +      - Specifies the size, in bits, of the long-term reference picture set include in the slice header
> +        or SPS. It is the number of bits in the conditional block if(long_term_ref_pics_present_flag)
> +        in section 7.3.6.1 of the specification.
>      * - __u8
>        - ``padding``
>        - Applications and drivers must set this to zero.
> @@ -3385,6 +3407,16 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>        - ``pic_order_cnt_val``
>        - PicOrderCntVal as described in section 8.3.1 "Decoding process
>          for picture order count" of the specification.
> +    * - __u16
> +      - ``short_term_ref_pic_set_size``
> +      - Specifies the size, in bits, of the short-term reference picture set, of the first slice
> +        described as st_ref_pic_set() in the specification, included in the slice header
> +        or SPS (section 7.3.6.1).
> +    * - __u16
> +      - ``long_term_ref_pic_set_size``
> +      - Specifies the size, in bits, of the long-term reference picture set, of the first slice
> +        included in the slice header or SPS. It is the number of bits in the conditional block
> +        if(long_term_ref_pics_present_flag) in section 7.3.6.1 of the specification.
>      * - __u8
>        - ``num_active_dpb_entries``
>        - The number of entries in ``dpb``.
> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> index 01ccda48d8c5..752a8d10782c 100644
> --- a/include/media/hevc-ctrls.h
> +++ b/include/media/hevc-ctrls.h
> @@ -58,6 +58,8 @@ enum v4l2_mpeg_video_hevc_start_code {
>  /* The controls are not stable at the moment and will likely be reworked. */
>  struct v4l2_ctrl_hevc_sps {
>  	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Sequence parameter set */
> +	__u8	video_parameter_set_id;
> +	__u8	seq_parameter_set_id;
>  	__u16	pic_width_in_luma_samples;
>  	__u16	pic_height_in_luma_samples;
>  	__u8	bit_depth_luma_minus8;
> @@ -108,6 +110,7 @@ struct v4l2_ctrl_hevc_sps {
>  
>  struct v4l2_ctrl_hevc_pps {
>  	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture parameter set */
> +	__u8	pic_parameter_set_id;
>  	__u8	num_extra_slice_header_bits;
>  	__u8	num_ref_idx_l0_default_active_minus1;
>  	__u8	num_ref_idx_l1_default_active_minus1;
> @@ -199,7 +202,8 @@ struct v4l2_ctrl_hevc_slice_params {
>  	__u32	slice_segment_addr;
>  	__u8	ref_idx_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
>  	__u8	ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
> -
> +	__u16	short_term_ref_pic_set_size;
> +	__u16	long_term_ref_pic_set_size;
>  	__u8	padding;
>  
>  	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Weighted prediction parameter */
> @@ -214,6 +218,8 @@ struct v4l2_ctrl_hevc_slice_params {
>  
>  struct v4l2_ctrl_hevc_decode_params {
>  	__s32	pic_order_cnt_val;
> +	__u16	short_term_ref_pic_set_size;
> +	__u16	long_term_ref_pic_set_size;
>  	__u8	num_active_dpb_entries;
>  	struct	v4l2_hevc_dpb_entry dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
>  	__u8	num_poc_st_curr_before;
> -- 
> 2.32.0
> 
