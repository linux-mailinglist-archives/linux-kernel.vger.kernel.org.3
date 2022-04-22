Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DC950B1B1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444874AbiDVHe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386165AbiDVHe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:34:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03D2515B0;
        Fri, 22 Apr 2022 00:32:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50547B82A89;
        Fri, 22 Apr 2022 07:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AD7C385A4;
        Fri, 22 Apr 2022 07:31:59 +0000 (UTC)
Message-ID: <43bba7a4-4eae-9e36-a1ae-60e3ffe30491@xs4all.nl>
Date:   Fri, 22 Apr 2022 09:31:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 11/24] media: v4l2: Reorder field reflist
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org
References: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
 <20220405204426.259074-12-nicolas.dufresne@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220405204426.259074-12-nicolas.dufresne@collabora.com>
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
> As per spec, the field reflist requires interleaving top and bottom
> field in a specific way that does not fit inside the sort operation.
> The process consist of alternating references parity, starting with
> a reference of the same parity as the current picture. This
> processs is done twice, once for short term references and a second
> time for the long term references.
> 
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> ---
>  drivers/media/v4l2-core/v4l2-h264.c | 42 +++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
> index 7e1eba03099a..d2d1f3bed7e8 100644
> --- a/drivers/media/v4l2-core/v4l2-h264.c
> +++ b/drivers/media/v4l2-core/v4l2-h264.c
> @@ -244,6 +244,40 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
>  	return poca < pocb ? -1 : 1;
>  }
>  
> +/*
> + * The references need to be reordered so that references are alternating
> + * between top and bottom field references starting with the current picture
> + * parity. This has to be * done for short term and long term references
                             ^
Spurious *.

Regards,

	Hans

> + * separately.
> + */
> +static void reorder_field_reflist(const struct v4l2_h264_reflist_builder *b,
> +				  struct v4l2_h264_reference *reflist)
> +{
> +	struct v4l2_h264_reference tmplist[V4L2_H264_REF_LIST_LEN];
> +	u8 lt, i = 0, j = 0, k = 0;
> +
> +	memcpy(tmplist, reflist, sizeof(tmplist[0]) * b->num_valid);
> +
> +	for (lt = 0; lt <= 1; lt++) {
> +		do {
> +			for (; i < b->num_valid && b->refs[tmplist[i].index].longterm == lt; i++) {
> +				if (tmplist[i].fields == b->cur_pic_fields) {
> +					reflist[k++] = tmplist[i++];
> +					break;
> +				}
> +			}
> +
> +			for (; j < b->num_valid && b->refs[tmplist[j].index].longterm == lt; j++) {
> +				if (tmplist[j].fields != b->cur_pic_fields) {
> +					reflist[k++] = tmplist[j++];
> +					break;
> +				}
> +			}
> +		} while ((i < b->num_valid && b->refs[tmplist[i].index].longterm == lt) ||
> +			 (j < b->num_valid && b->refs[tmplist[j].index].longterm == lt));
> +	}
> +}
> +
>  static char ref_type_to_char (u8 ref_type)
>  {
>  	switch (ref_type) {
> @@ -346,6 +380,9 @@ v4l2_h264_build_p_ref_list(const struct v4l2_h264_reflist_builder *builder,
>  	sort_r(reflist, builder->num_valid, sizeof(*reflist),
>  	       v4l2_h264_p_ref_list_cmp, NULL, builder);
>  
> +	if (builder->cur_pic_fields != V4L2_H264_FRAME_REF)
> +		reorder_field_reflist(builder, reflist);
> +
>  	print_ref_list_p(builder, reflist);
>  }
>  EXPORT_SYMBOL_GPL(v4l2_h264_build_p_ref_list);
> @@ -379,6 +416,11 @@ v4l2_h264_build_b_ref_lists(const struct v4l2_h264_reflist_builder *builder,
>  	sort_r(b1_reflist, builder->num_valid, sizeof(*b1_reflist),
>  	       v4l2_h264_b1_ref_list_cmp, NULL, builder);
>  
> +	if (builder->cur_pic_fields != V4L2_H264_FRAME_REF) {
> +		reorder_field_reflist(builder, b0_reflist);
> +		reorder_field_reflist(builder, b1_reflist);
> +	}
> +
>  	if (builder->num_valid > 1 &&
>  	    !memcmp(b1_reflist, b0_reflist, builder->num_valid))
>  		swap(b1_reflist[0], b1_reflist[1]);

