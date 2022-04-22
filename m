Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7675150B1A6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444853AbiDVHdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444862AbiDVHcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:32:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD0350456;
        Fri, 22 Apr 2022 00:29:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2301E61F2F;
        Fri, 22 Apr 2022 07:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C218C385A4;
        Fri, 22 Apr 2022 07:29:38 +0000 (UTC)
Message-ID: <101c5840-37c7-1625-9856-2f6b5870b943@xs4all.nl>
Date:   Fri, 22 Apr 2022 09:29:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 10/24] media: h264: Sort p/b reflist using frame_num
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org
References: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
 <20220405204426.259074-11-nicolas.dufresne@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220405204426.259074-11-nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2022 22:44, Nicolas Dufresne wrote:
> In the reference list builder, frame_num refers to FrameNumWrap
> in the spec, which is the same as the pic_num for frame decoding.
> The same applies for long_term_pic_num and long_term_frame_idx.
> 
> Sort all type of references by frame_num so the sort can be reused
> for fields reflist were the sorting is done using frame_num instead.
> In short, pic_num is never actually used for building reference
> lists.
> 
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> ---
>  drivers/media/v4l2-core/v4l2-h264.c | 23 +++++++++++++----------
>  include/media/v4l2-h264.h           |  2 --
>  2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
> index bcf9b7774560..7e1eba03099a 100644
> --- a/drivers/media/v4l2-core/v4l2-h264.c
> +++ b/drivers/media/v4l2-core/v4l2-h264.c
> @@ -50,7 +50,6 @@ v4l2_h264_init_reflist_builder(struct v4l2_h264_reflist_builder *b,
>  		if (!(dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
>  			continue;
>  
> -		b->refs[i].pic_num = dpb[i].pic_num;
>  		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM)
>  			b->refs[i].longterm = true;
>  
> @@ -139,15 +138,19 @@ static int v4l2_h264_p_ref_list_cmp(const void *ptra, const void *ptrb,
>  	}
>  
>  	/*
> -	 * Short term pics in descending pic num order, long term ones in
> -	 * ascending order.
> +	 * For frames, short term pics are in descending pic num order and long
> +	 * term ones in ascending order. For fields, the same direction is used
> +	 * but with frame_num (wrapped). For frames, the value of pic_num and
> +	 * frame_num are the same (see formula (8-28) and (8-29)). For this
> +	 * reason we can use frame_num only and share this funciton between

funciton -> function

Regards,

	Hans

> +	 * frames and fields reflist.
>  	 */
>  	if (!builder->refs[idxa].longterm)
>  		return builder->refs[idxb].frame_num <
>  		       builder->refs[idxa].frame_num ?
>  		       -1 : 1;
>  
> -	return builder->refs[idxa].pic_num < builder->refs[idxb].pic_num ?
> +	return builder->refs[idxa].frame_num < builder->refs[idxb].frame_num ?
>  	       -1 : 1;
>  }
>  
> @@ -173,10 +176,10 @@ static int v4l2_h264_b0_ref_list_cmp(const void *ptra, const void *ptrb,
>  			return 1;
>  	}
>  
> -	/* Long term pics in ascending pic num order. */
> +	/* Long term pics in ascending frame num order. */
>  	if (builder->refs[idxa].longterm)
> -		return builder->refs[idxa].pic_num <
> -		       builder->refs[idxb].pic_num ?
> +		return builder->refs[idxa].frame_num <
> +		       builder->refs[idxb].frame_num ?
>  		       -1 : 1;
>  
>  	poca = v4l2_h264_get_poc(builder, ptra);
> @@ -218,10 +221,10 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
>  			return 1;
>  	}
>  
> -	/* Long term pics in ascending pic num order. */
> +	/* Long term pics in ascending frame num order. */
>  	if (builder->refs[idxa].longterm)
> -		return builder->refs[idxa].pic_num <
> -		       builder->refs[idxb].pic_num ?
> +		return builder->refs[idxa].frame_num <
> +		       builder->refs[idxb].frame_num ?
>  		       -1 : 1;
>  
>  	poca = v4l2_h264_get_poc(builder, ptra);
> diff --git a/include/media/v4l2-h264.h b/include/media/v4l2-h264.h
> index 4cef717b3f18..0d9eaa956123 100644
> --- a/include/media/v4l2-h264.h
> +++ b/include/media/v4l2-h264.h
> @@ -18,7 +18,6 @@
>   * @refs.top_field_order_cnt: top field order count
>   * @refs.bottom_field_order_cnt: bottom field order count
>   * @refs.frame_num: reference frame number
> - * @refs.pic_num: reference picture number
>   * @refs.longterm: set to true for a long term reference
>   * @refs: array of references
>   * @cur_pic_order_count: picture order count of the frame being decoded
> @@ -36,7 +35,6 @@ struct v4l2_h264_reflist_builder {
>  		s32 top_field_order_cnt;
>  		s32 bottom_field_order_cnt;
>  		int frame_num;
> -		u32 pic_num;
>  		u16 longterm : 1;
>  	} refs[V4L2_H264_NUM_DPB_ENTRIES];
>  

