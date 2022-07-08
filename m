Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75CB56B918
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbiGHMBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 08:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237714AbiGHMAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:00:54 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EA29B18E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 05:00:52 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id o73-20020a4a2c4c000000b004284fd4e052so3987391ooo.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 05:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6MauRTxqZJVWRnLcZEPdOWjV0zGWMpnIXDwkFytfIIw=;
        b=pzuFqANPRZpBcOzi8kD9+Rcj5U+To/xA2H+4vMnLfYGnqwYTJtqlz4XHk8Z++szdOf
         X10I+9I0mRqV0ZgAr+GWFBseVQFQkYMSHMm3oHHYYjDn6/dxoUMZpEY4DIhmpfQ8/5/T
         9Dk64iD68OisJewkMW1vVzdVfNoThVty1B17IARvBXabxJN/u8q1dyo+pDnlmniRAKDA
         VT8AaiTqczPEwsQU1QW68UZOadwEQpQHMstsIONk09LwTyG9juZOgY1V71jY+3SDBrUo
         F+5pgEP1W6wAWppJ+AVmmVRNY1Wtmff+275kCITt8E3/MjnzGpyEGBEVVpQ++bb9UZxf
         9dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6MauRTxqZJVWRnLcZEPdOWjV0zGWMpnIXDwkFytfIIw=;
        b=ISDLANijTsbZSKnbDvnQCW9rP6pITZF8oSlwnnRZ41vHlEeM9D6Qg9x1sFK5NNUGCj
         Db5BfV/AIqibjcoQnfIxi7jds9JfWkukFs9Tnl2hecLfvI4o/xuZ4FXTDDINZsUWDM6u
         Wwc/SZHHSyThg8kAorBdugdqwGLGtJiNnwkr/PinBdTfbRqo1YZqdh3Lb4xLPACT0St3
         5pFTsWqovRxWnI7zWIG4tcNYa5FuVNlaI82tQK9vGJvDERPwPdiouyzh3sCx+Jezzpq1
         w3xj4mQYLa7o3rLSjh8jZ+4LVg3WXNqHzJGgWHW8iAHeErpypLVfMT9U+nLiOngsmZ+z
         mTyw==
X-Gm-Message-State: AJIora94dfBsm85sbDwR5sjetXEjCZCQY08HRXdDPOQFJAw8ZTUqYMDs
        r37y27oDe/gGpPTWwSQzFLgwwQ==
X-Google-Smtp-Source: AGRyM1tIi7U/tzN2kHzVbY/2pwhOSHhPeBqioCP6mz1og1DhqgVwVEAfdU36A/R+cx2ZjqIUXTBk6A==
X-Received: by 2002:a4a:96b3:0:b0:422:23d3:46de with SMTP id s48-20020a4a96b3000000b0042223d346demr1240112ooi.70.1657281650312;
        Fri, 08 Jul 2022 05:00:50 -0700 (PDT)
Received: from eze-laptop ([186.13.97.246])
        by smtp.gmail.com with ESMTPSA id m18-20020a9d7ad2000000b00618fa37308csm4085722otn.35.2022.07.08.05.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 05:00:49 -0700 (PDT)
Date:   Fri, 8 Jul 2022 09:00:42 -0300
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
Subject: Re: [PATCH v11 15/17] media: uapi: HEVC: fix padding in v4l2 control
 structures
Message-ID: <YsgcagtDlwrJClbi@eze-laptop>
References: <20220706093803.158810-1-benjamin.gaignard@collabora.com>
 <20220706093803.158810-16-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706093803.158810-16-benjamin.gaignard@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 11:38:01AM +0200, Benjamin Gaignard wrote:
> Fix padding where needed to remove holes and stay aligned on cache boundaries
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>

I've checked the holes using pahole and it looks good.

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Thanks,
Ezequiel

> ---
>  .../media/v4l/ext-ctrls-codec.rst             |  6 ++---
>  drivers/media/v4l2-core/v4l2-ctrls-core.c     | 15 -------------
>  include/media/hevc-ctrls.h                    | 22 ++++++++++++-------
>  3 files changed, 17 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index 59e751c38d06..d5ef91ae3539 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -3513,9 +3513,6 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>      * - __u8
>        - ``num_active_dpb_entries``
>        - The number of entries in ``dpb``.
> -    * - struct :c:type:`v4l2_hevc_dpb_entry`
> -      - ``dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
> -      - The decoded picture buffer, for meta-data about reference frames.
>      * - __u8
>        - ``num_poc_st_curr_before``
>        - The number of reference pictures in the short-term set that come before
> @@ -3539,6 +3536,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>        - ``poc_lt_curr[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
>        - PocLtCurr as described in section 8.3.2 "Decoding process for reference
>          picture set": provides the index of the long term references in DPB array.
> +    * - struct :c:type:`v4l2_hevc_dpb_entry`
> +      - ``dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX]``
> +      - The decoded picture buffer, for meta-data about reference frames.
>      * - __u64
>        - ``flags``
>        - See :ref:`Decode Parameters Flags <hevc_decode_params_flags>`
> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> index c5c5407584ff..1f85828d6694 100644
> --- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
> +++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
> @@ -536,7 +536,6 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
>  	struct v4l2_ctrl_h264_decode_params *p_h264_dec_params;
>  	struct v4l2_ctrl_hevc_sps *p_hevc_sps;
>  	struct v4l2_ctrl_hevc_pps *p_hevc_pps;
> -	struct v4l2_ctrl_hevc_slice_params *p_hevc_slice_params;
>  	struct v4l2_ctrl_hdr10_mastering_display *p_hdr10_mastering;
>  	struct v4l2_ctrl_hevc_decode_params *p_hevc_decode_params;
>  	struct v4l2_area *area;
> @@ -814,8 +813,6 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
>  			p_hevc_pps->pps_beta_offset_div2 = 0;
>  			p_hevc_pps->pps_tc_offset_div2 = 0;
>  		}
> -
> -		zero_padding(*p_hevc_pps);
>  		break;
>  
>  	case V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS:
> @@ -824,21 +821,9 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
>  		if (p_hevc_decode_params->num_active_dpb_entries >
>  		    V4L2_HEVC_DPB_ENTRIES_NUM_MAX)
>  			return -EINVAL;
> -
> -		for (i = 0; i < p_hevc_decode_params->num_active_dpb_entries;
> -		     i++) {
> -			struct v4l2_hevc_dpb_entry *dpb_entry =
> -				&p_hevc_decode_params->dpb[i];
> -
> -			zero_padding(*dpb_entry);
> -		}
>  		break;
>  
>  	case V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS:
> -		p_hevc_slice_params = p;
> -
> -		zero_padding(p_hevc_slice_params->pred_weight_table);
> -		zero_padding(*p_hevc_slice_params);
>  		break;
>  
>  	case V4L2_CTRL_TYPE_HDR10_CLL_INFO:
> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> index 9239e8b649e0..7358cbfc3e4d 100644
> --- a/include/media/hevc-ctrls.h
> +++ b/include/media/hevc-ctrls.h
> @@ -105,6 +105,7 @@ enum v4l2_stateless_hevc_start_code {
>   * @chroma_format_idc: specifies the chroma sampling
>   * @sps_max_sub_layers_minus1: this value plus 1 specifies the maximum number
>   *                             of temporal sub-layers
> + * @reserved: padding field. Should be zeroed by applications.
>   * @flags: see V4L2_HEVC_SPS_FLAG_{}
>   */
>  struct v4l2_ctrl_hevc_sps {
> @@ -133,6 +134,7 @@ struct v4l2_ctrl_hevc_sps {
>  	__u8	chroma_format_idc;
>  	__u8	sps_max_sub_layers_minus1;
>  
> +	__u8	reserved[6];
>  	__u64	flags;
>  };
>  
> @@ -192,6 +194,7 @@ struct v4l2_ctrl_hevc_sps {
>   *			divided by 2
>   * @log2_parallel_merge_level_minus2: this value plus 2 specifies the value of
>   *                                    the variable Log2ParMrgLevel
> + * @reserved: padding field. Should be zeroed by applications.
>   * @flags: see V4L2_HEVC_PPS_FLAG_{}
>   */
>  struct v4l2_ctrl_hevc_pps {
> @@ -210,8 +213,7 @@ struct v4l2_ctrl_hevc_pps {
>  	__s8	pps_beta_offset_div2;
>  	__s8	pps_tc_offset_div2;
>  	__u8	log2_parallel_merge_level_minus2;
> -
> -	__u8	padding[4];
> +	__u8	reserved;
>  	__u64	flags;
>  };
>  
> @@ -239,14 +241,15 @@ struct v4l2_ctrl_hevc_pps {
>   * @timestamp: timestamp of the V4L2 capture buffer to use as reference.
>   * @flags: long term flag for the reference frame
>   * @field_pic: whether the reference is a field picture or a frame.
> + * @reserved: padding field. Should be zeroed by applications.
>   * @pic_order_cnt_val: the picture order count of the reference.
>   */
>  struct v4l2_hevc_dpb_entry {
>  	__u64	timestamp;
>  	__u8	flags;
>  	__u8	field_pic;
> +	__u16	reserved;
>  	__s32	pic_order_cnt_val;
> -	__u8	padding[2];
>  };
>  
>  /**
> @@ -285,8 +288,6 @@ struct v4l2_hevc_pred_weight_table {
>  	__s8	delta_chroma_weight_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
>  	__s8	chroma_offset_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
>  
> -	__u8	padding[6];
> -
>  	__u8	luma_log2_weight_denom;
>  	__s8	delta_chroma_log2_weight_denom;
>  };
> @@ -339,6 +340,7 @@ struct v4l2_hevc_pred_weight_table {
>   * @slice_tc_offset_div2: specify the deblocking parameter offsets for tC divided by 2
>   * @pic_struct: indicates whether a picture should be displayed as a frame or as one or
>   *		more fields
> + * @reserved0: padding field. Should be zeroed by applications.
>   * @slice_segment_addr: specifies the address of the first coding tree block in
>   *			the slice segment
>   * @ref_idx_l0: the list of L0 reference elements as indices in the DPB
> @@ -349,6 +351,7 @@ struct v4l2_hevc_pred_weight_table {
>   *				picture include in the SPS
>   * @pred_weight_table: the prediction weight coefficients for inter-picture
>   *		       prediction
> + * @reserved1: padding field. Should be zeroed by applications.
>   * @flags: see V4L2_HEVC_SLICE_PARAMS_FLAG_{}
>   */
>  struct v4l2_ctrl_hevc_slice_params {
> @@ -379,17 +382,18 @@ struct v4l2_ctrl_hevc_slice_params {
>  	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture timing SEI message */
>  	__u8	pic_struct;
>  
> +	__u8	reserved0[3];
>  	/* ISO/IEC 23008-2, ITU-T Rec. H.265: General slice segment header */
>  	__u32	slice_segment_addr;
>  	__u8	ref_idx_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
>  	__u8	ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
>  	__u16	short_term_ref_pic_set_size;
>  	__u16	long_term_ref_pic_set_size;
> -	__u8	padding;
>  
>  	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Weighted prediction parameter */
>  	struct v4l2_hevc_pred_weight_table pred_weight_table;
>  
> +	__u8	reserved1[2];
>  	__u64	flags;
>  };
>  
> @@ -406,7 +410,6 @@ struct v4l2_ctrl_hevc_slice_params {
>   * @long_term_ref_pic_set_size: specifies the size of long-term reference
>   *				pictures set include in the SPS of the first slice
>   * @num_active_dpb_entries: the number of entries in dpb
> - * @dpb: the decoded picture buffer, for meta-data about reference frames
>   * @num_poc_st_curr_before: the number of reference pictures in the short-term
>   *			    set that come before the current frame
>   * @num_poc_st_curr_after: the number of reference pictures in the short-term
> @@ -417,6 +420,8 @@ struct v4l2_ctrl_hevc_slice_params {
>   * @poc_st_curr_after: provides the index of the short term after references
>   *		       in DPB array
>   * @poc_lt_curr: provides the index of the long term references in DPB array
> + * @reserved: padding field. Should be zeroed by applications.
> + * @dpb: the decoded picture buffer, for meta-data about reference frames
>   * @flags: see V4L2_HEVC_DECODE_PARAM_FLAG_{}
>   */
>  struct v4l2_ctrl_hevc_decode_params {
> @@ -424,13 +429,14 @@ struct v4l2_ctrl_hevc_decode_params {
>  	__u16	short_term_ref_pic_set_size;
>  	__u16	long_term_ref_pic_set_size;
>  	__u8	num_active_dpb_entries;
> -	struct	v4l2_hevc_dpb_entry dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
>  	__u8	num_poc_st_curr_before;
>  	__u8	num_poc_st_curr_after;
>  	__u8	num_poc_lt_curr;
>  	__u8	poc_st_curr_before[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
>  	__u8	poc_st_curr_after[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
>  	__u8	poc_lt_curr[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
> +	__u8	reserved[4];
> +	struct	v4l2_hevc_dpb_entry dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
>  	__u64	flags;
>  };
>  
> -- 
> 2.32.0
> 
