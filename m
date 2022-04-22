Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3E050BD32
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449749AbiDVQg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448919AbiDVQgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:36:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C515F25A;
        Fri, 22 Apr 2022 09:34:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B20BB831B1;
        Fri, 22 Apr 2022 16:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0C6C385A0;
        Fri, 22 Apr 2022 16:33:56 +0000 (UTC)
Message-ID: <ca8b1403-ca58-a4b4-d2e2-1c682b5f0adb@xs4all.nl>
Date:   Fri, 22 Apr 2022 18:33:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 09/24] media: v4l2: Trace calculated p/b0/b1 initial
 reflist
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org
References: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
 <20220405204426.259074-10-nicolas.dufresne@collabora.com>
 <d7451087-45f1-9691-2289-999eb16ca8a0@xs4all.nl>
 <04819e457ee0135e5d0b337dccfaba69b2d46610.camel@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <04819e457ee0135e5d0b337dccfaba69b2d46610.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2022 16:58, Nicolas Dufresne wrote:
> Le vendredi 22 avril 2022 à 09:26 +0200, Hans Verkuil a écrit :
>> On 05/04/2022 22:44, Nicolas Dufresne wrote:
>>> Add debug print statements to print the content of P & B reference
>>> lists, to verify that the ordering of the generated reference lists is
>>> correct. This is especially important for the field decoding mode,
>>> where sorting is more complex.
>>>
>>> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>>> Tested-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>>> Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
>>> ---
>>>  drivers/media/v4l2-core/v4l2-h264.c | 86 +++++++++++++++++++++++++++++
>>>  1 file changed, 86 insertions(+)
>>>
>>> diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
>>> index 38d8dbda0045..bcf9b7774560 100644
>>> --- a/drivers/media/v4l2-core/v4l2-h264.c
>>> +++ b/drivers/media/v4l2-core/v4l2-h264.c
>>> @@ -241,6 +241,87 @@ static int v4l2_h264_b1_ref_list_cmp(const void *ptra, const void *ptrb,
>>>  	return poca < pocb ? -1 : 1;
>>>  }
>>>  
>>> +static char ref_type_to_char (u8 ref_type)
>>
>> Spurious space before (.
>>
>> Odd that checkpatch didn't catch that.
>>
>>> +{
>>> +	switch (ref_type) {
>>> +	case V4L2_H264_FRAME_REF:
>>> +		return 'f';
>>> +	case V4L2_H264_TOP_FIELD_REF:
>>> +		return 't';
>>> +	case V4L2_H264_BOTTOM_FIELD_REF:
>>> +		return 'b';
>>> +	}
>>> +
>>> +	return '?';
>>> +}
>>> +
>>> +static const char *format_ref_list_p(const struct v4l2_h264_reflist_builder *builder,
>>> +				     struct v4l2_h264_reference *reflist,
>>> +				     char *out_str, const int len)
>>> +{
>>> +	int n = 0, i;
>>> +
>>> +	n += snprintf(out_str + n, len - n, "|");
>>> +
>>> +	for (i = 0; i < builder->num_valid; i++) {
>>> +		/* this is pic_num for frame and frame_num (wrapped) for field,
>>> +		 * but for frame pic_num is equal to frame_num (wrapped).
>>> +		 */
>>> +		int frame_num = builder->refs[reflist[i].index].frame_num;
>>> +		bool longterm = builder->refs[reflist[i].index].longterm;
>>> +
>>> +		n += scnprintf(out_str + n, len - n, "%i%c%c|",
>>> +			       frame_num, longterm ? 'l' : 's',
>>> +			       ref_type_to_char (reflist[i].fields));
>>> +	}
>>> +
>>> +	return out_str;
>>> +}
>>> +
>>> +static void print_ref_list_p(const struct v4l2_h264_reflist_builder *builder,
>>> +			     struct v4l2_h264_reference *reflist)
>>> +{
>>> +	char buf[1024];
>>> +
>>> +	pr_debug("ref_pic_list_p (cur_poc %u%c) %s\n",
>>> +		 builder->cur_pic_order_count,
>>> +		 ref_type_to_char(builder->cur_pic_fields),
>>> +		 format_ref_list_p(builder, reflist, buf, sizeof(buf)));
>>> +}
>>> +
>>> +static const char *format_ref_list_b(const struct v4l2_h264_reflist_builder *builder,
>>> +				     struct v4l2_h264_reference *reflist,
>>> +				     char *out_str, const int len)
>>> +{
>>> +	int n = 0, i;
>>> +
>>> +	n += snprintf(out_str + n, len - n, "|");
>>> +
>>> +	for (i = 0; i < builder->num_valid; i++) {
>>> +		int frame_num = builder->refs[reflist[i].index].frame_num;
>>> +		u32 poc = v4l2_h264_get_poc(builder, reflist + i);
>>> +		bool longterm = builder->refs[reflist[i].index].longterm;
>>> +
>>> +		n += scnprintf(out_str + n, len - n, "%i%c%c|",
>>> +			       longterm ? frame_num : poc,
>>> +			       longterm ? 'l' : 's',
>>> +			       ref_type_to_char(reflist[i].fields));
>>> +	}
>>> +
>>> +	return out_str;
>>> +}
>>> +
>>> +static void print_ref_list_b(const struct v4l2_h264_reflist_builder *builder,
>>> +			     struct v4l2_h264_reference *reflist, u8 list_num)
>>> +{
>>> +	char buf[1024];
>>
>> I really don't like placing 1024 bytes on the stack. Can you find another way
>> of doing this? Perhaps using pr_cont or writing each format_ref_list item
>> on a separate line.
> 
> Thanks, I was strongly discourage of using pr_cont (which was my first
> approach). Rationales are well covered on LKLM and in the pr_cont documentation,
> so I won't say more then its not visually thread safe.
> 
> I would like to decline the second proposition, as having the lists spread out
> on up to 32 lines will make the trace very hard to use. What I may suggest, as I
> would really prefer keeping this trace useful, is to use an allocation instead.
> The performance does not matter, and I explicitly call this function inside the
> pr_debug call so it can be compiled out.

Allocation is probably best here.

Regards,

	Hans

> 
> My last resort otherwise would be to use 32 %s formaters, and pass each of the
> possible 32 entry (or empty string "") manually.
> 
> let me know what you believe is acceptable for you,
> Nicolas
> 
>>
>> Regards,
>>
>> 	Hans
>>
>>> +
>>> +	pr_debug("ref_pic_list_b%u (cur_poc %u%c) %s",
>>> +		 list_num, builder->cur_pic_order_count,
>>> +		 ref_type_to_char (builder->cur_pic_fields),
>>> +		 format_ref_list_b(builder, reflist, buf, sizeof(buf)));
>>> +}
>>> +
>>>  /**
>>>   * v4l2_h264_build_p_ref_list() - Build the P reference list
>>>   *
>>> @@ -261,6 +342,8 @@ v4l2_h264_build_p_ref_list(const struct v4l2_h264_reflist_builder *builder,
>>>  	       sizeof(builder->unordered_reflist[0]) * builder->num_valid);
>>>  	sort_r(reflist, builder->num_valid, sizeof(*reflist),
>>>  	       v4l2_h264_p_ref_list_cmp, NULL, builder);
>>> +
>>> +	print_ref_list_p(builder, reflist);
>>>  }
>>>  EXPORT_SYMBOL_GPL(v4l2_h264_build_p_ref_list);
>>>  
>>> @@ -296,6 +379,9 @@ v4l2_h264_build_b_ref_lists(const struct v4l2_h264_reflist_builder *builder,
>>>  	if (builder->num_valid > 1 &&
>>>  	    !memcmp(b1_reflist, b0_reflist, builder->num_valid))
>>>  		swap(b1_reflist[0], b1_reflist[1]);
>>> +
>>> +	print_ref_list_b(builder, b0_reflist, 0);
>>> +	print_ref_list_b(builder, b1_reflist, 1);
>>>  }
>>>  EXPORT_SYMBOL_GPL(v4l2_h264_build_b_ref_lists);
>>>  
>>
> 

