Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC96854B129
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245161AbiFNM25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbiFNM2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:28:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE23377EA;
        Tue, 14 Jun 2022 05:28:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA60EB81874;
        Tue, 14 Jun 2022 12:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D73C3411B;
        Tue, 14 Jun 2022 12:28:03 +0000 (UTC)
Message-ID: <366fca22-e22d-9963-423b-252274fa9d9e@xs4all.nl>
Date:   Tue, 14 Jun 2022 14:28:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v8 04/17] media: uapi: HEVC: Add missing fields in HEVC
 controls
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
References: <20220614083614.240641-1-benjamin.gaignard@collabora.com>
 <20220614083614.240641-5-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220614083614.240641-5-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 10:36, Benjamin Gaignard wrote:
> Complete the HEVC controls with missing fields from H.265 specifications.
> Even if these fields aren't used by the current mainlined drivers
> they will be required for (at least) the rkvdec driver.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 6:
> - Add short_term_ref_pic_set_size and long_term_ref_pic_set_size
>   in v4l2_ctrl_hevc_decode_params structure.
> 
>  .../media/v4l/ext-ctrls-codec.rst             | 32 +++++++++++++++++++
>  include/media/hevc-ctrls.h                    |  8 ++++-
>  2 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> index 6183f43f4d73..aa7556e200c9 100644
> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> @@ -2683,6 +2683,16 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>      :stub-columns: 0
>      :widths:       1 1 2
>  
> +    * - __u8
> +      - ``video_parameter_set_id``
> +      - Specifies the value of the vps_video_parameter_set_id of the active VPS
> +        as descibed in section "7.4.3.2.1 General sequence parameter set RBSP semantics"

descibed -> described

This same typo occurs several times in this patch and in patch 17/17.

Regards,

	Hans

> +        of H.265 specifications.
> +    * - __u8
> +      - ``seq_parameter_set_id``
> +      - Provides an identifier for the SPS for reference by other syntax elements
> +        as descibed in section "7.4.3.2.1 General sequence parameter set RBSP semantics"
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

