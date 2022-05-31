Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095A3538BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 08:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244402AbiEaG6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 02:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiEaG6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 02:58:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8E170931;
        Mon, 30 May 2022 23:58:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: benjamin.gaignard)
        with ESMTPSA id 20D641F434F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653980329;
        bh=/YdiAxkbFFsJPIbUNtx17mCUZumnLJTtjHWjlaPVPpA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fOihRgNRYJpayg+EAICytygYOQ5MRP2tdgwYWmHMyoZ1pdood/Y6r6wtpvBCuXRHY
         Q0UpPtUk65r63U5/V7viFwdlAW1D9gyKNLvgsfeXncx2zGFbjwl7YfGWJ3/rTZDlTb
         dPo62pJsxSQ1E8+UMrl7PPGkMT9yPtYAm0NHe4ya0f/MjqZOC5mk0RjmJHgYjgT+1F
         ZpG9k0zP8aLKu75wy2NcXtivZXEe8BFyn6jXv2XJsfZ5aUWAmL0+bJD+M6G5KptwXr
         b7G+bLg2fj5aKOm31YRtwZ+bcWYWZQkVAMWr9fpD6F1pWYfxDSArYcj/kyGiP64jhU
         NNgBeFFjc+akA==
Message-ID: <b398272b-daf8-7499-b4fd-8a6f2af30053@collabora.com>
Date:   Tue, 31 May 2022 08:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 11/17] media: uapi: Add
 V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
Content-Language: en-US
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org, nicolas.dufresne@collabora.com,
        andrzej.p@collabora.com, Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
References: <20220527143134.3360174-1-benjamin.gaignard@collabora.com>
 <c639efc2-2089-359d-44c6-e9d92e8fd22e@xs4all.nl>
 <c47b3218-069b-790e-8781-7b6d195ac8a7@xs4all.nl> <5824953.lOV4Wx5bFT@kista>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <5824953.lOV4Wx5bFT@kista>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 30/05/2022 à 23:24, Jernej Škrabec a écrit :
> Dne ponedeljek, 30. maj 2022 ob 15:49:57 CEST je Hans Verkuil napisal(a):
>> On 30/05/2022 11:18, Hans Verkuil wrote:
>>> On 29/05/2022 08:40, Jernej Škrabec wrote:
>>>> Hi!
>>>>
>>>> This series looks very good and I plan to test it shortly on Cedrus, but
> I
>>>> have one major concern below.
>>>>
>>>> Dne petek, 27. maj 2022 ob 16:31:28 CEST je Benjamin Gaignard napisal(a):
>>>>> The number of 'entry point offset' can be very variable.
>>>>> Instead of using a large static array define a v4l2 dynamic array
>>>>> of U32 (V4L2_CTRL_TYPE_U32).
>>>>> The number of entry point offsets is reported by the elems field
>>>>> and in struct v4l2_ctrl_hevc_slice_params.num_entry_point_offsets
>>>>> field.
>>>> Slice control by itself is variable length array, so you would actually
> need
>>>> 2D variable array for entry points which is not supported. However, easy
>>>> workaround for that is to flatten 2D array to 1D and either have another
> slice
>>>> control field which would tell first entry point index for convenience or
> let
>>>> driver calculate it by adding up all num_entry_point_offsets of previous
>>>> slices.
>>>>
>>>> Hans, what do you think?
>>> If I would support 2D variable array sizes, wouldn't that be more elegant?
>>>
>>> The current implementation doesn't support that, but as the commit log for
>>> patch 1/17 says:
>>>
>>> "Currently dynamically sized arrays are limited to one dimensional arrays,
>>> but that might change in the future if there is a need for it."
>>>
>>> Let me know if you agree, and I'll try to implement this. It's been a
> while
>>> since I last looked at this, so I'm not sure how much work it is, but it
> is
>>> probably worth a shot.
>> Digging more into this made me realize that this doesn't actually help for
> this
>> particular case.
>>
>> I would lean towards your second suggestion of adding up all
> num_entry_point_offsets
>> of previous slices.
> Just one question/clarification about dynamic arrays - does driver need to
> reserve maximum amount of memory for dynamic array control at initialization
> time? If so, this would still be problematic, since there cound be a huge
> amount of entry points in theory.

When adding the control the driver could set .dims field to specify
the max number of accepted slices.
I have added '#define V4L2_HEVC_SLICE_MAX_COUNT 600' that you could use
for this field. It is the value we have found when using slices with RKVDEC
driver.

Regards,
Benjamin

>
> Best regards,
> Jernej
>
>> Regards,
>>
>> 	Hans
>>
>>> Regards,
>>>
>>> 	Hans
>>>
>>>> Note, it seems that H265 decoding on Cedrus still works without entry
> points,
>>>> so this problem can be solved later. I'm not sure what we lose with that
> but
>>>> it was suggested that this could influence speed or error resilience or
> both.
>>>> However, I think we're close to solve it, so I'd like to do that now.
>>>>
>>>> Best regards,
>>>> Jernej
>>>>
>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>>> ---
>>>>>   .../userspace-api/media/v4l/ext-ctrls-codec.rst       | 11 +++++++++++
>>>>>   drivers/media/v4l2-core/v4l2-ctrls-defs.c             |  5 +++++
>>>>>   include/media/hevc-ctrls.h                            |  5 ++++-
>>>>>   3 files changed, 20 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/
>>>> Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>>> index 0796b1563daa..05228e280f66 100644
>>>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>>> @@ -3010,6 +3010,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>>>>       * - __u32
>>>>>         - ``data_bit_offset``
>>>>>         - Offset (in bits) to the video data in the current slice data.
>>>>> +    * - __u32
>>>>> +      - ``num_entry_point_offsets``
>>>>> +      - Specifies the number of entry point offset syntax elements in the
>>>> slice header.
>>>>>       * - __u8
>>>>>         - ``nal_unit_type``
>>>>>         - Specifies the coding type of the slice (B, P or I).
>>>>> @@ -3150,6 +3153,14 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>>>>   
>>>>>       \normalsize
>>>>>   
>>>>> +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
>>>>> +    Specifies entry point offsets in bytes.
>>>>> +    This control is a dynamically sized array. The number of entry
> point
>>>>> +    offsets is reported by the ``elems`` field.
>>>>> +    This bitstream parameter is defined according to :ref:`hevc`.
>>>>> +    They are described in section 7.4.7.1 "General slice segment header
>>>>> +    semantics" of the specification.
>>>>> +
>>>>>   ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
>>>>>       Specifies the HEVC scaling matrix parameters used for the scaling
>>>> process
>>>>>       for transform coefficients.
>>>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/
> v4l2-
>>>> core/v4l2-ctrls-defs.c
>>>>> index d594efbcbb93..e22921e7ea61 100644
>>>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>>> @@ -1188,6 +1188,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>>>>>   	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:		return
>>>> "HEVC Decode Parameters";
>>>>>   	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:		return
>>>> "HEVC Decode Mode";
>>>>>   	case V4L2_CID_STATELESS_HEVC_START_CODE:		return
>>>> "HEVC Start Code";
>>>>> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:	return
>>>> "HEVC Entry Point Offsets";
>>>>>   
>>>>>   	/* Colorimetry controls */
>>>>>   	/* Keep the order of the 'case's the same as in v4l2-controls.h!
>>>> */
>>>>> @@ -1518,6 +1519,10 @@ void v4l2_ctrl_fill(u32 id, const char **name,
> enum
>>>> v4l2_ctrl_type *type,
>>>>>   	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
>>>>>   		*type = V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS;
>>>>>   		break;
>>>>> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:
>>>>> +		*type = V4L2_CTRL_TYPE_U32;
>>>>> +		*flags |= V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
>>>>> +		break;
>>>>>   	case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:
>>>>>   		*type = V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR;
>>>>>   		break;
>>>>> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
>>>>> index a3c829ef531a..1319cb99ae3f 100644
>>>>> --- a/include/media/hevc-ctrls.h
>>>>> +++ b/include/media/hevc-ctrls.h
>>>>> @@ -20,6 +20,7 @@
>>>>>   #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_BASE
>>>> + 1012)
>>>>>   #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE
> + 1015)
>>>>>   #define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE + 1016)
>>>>> +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (V4L2_CID_CODEC_BASE
> +
>>>> 1017)
>>>>>   
>>>>>   /* enum v4l2_ctrl_type type values */
>>>>>   #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
>>>>> @@ -318,6 +319,8 @@ struct v4l2_hevc_pred_weight_table {
>>>>>    *
>>>>>    * @bit_size: size (in bits) of the current slice data
>>>>>    * @data_bit_offset: offset (in bits) to the video data in the current
> slice
>>>> data
>>>>> + * @num_entry_point_offsets: specifies the number of entry point offset
> syntax
>>>>> + *			     elements in the slice header.
>>>>>    * @nal_unit_type: specifies the coding type of the slice (B, P or I)
>>>>>    * @nuh_temporal_id_plus1: minus 1 specifies a temporal identifier for
> the
>>>> NAL unit
>>>>>    * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
>>>>> @@ -360,7 +363,7 @@ struct v4l2_hevc_pred_weight_table {
>>>>>   struct v4l2_ctrl_hevc_slice_params {
>>>>>   	__u32	bit_size;
>>>>>   	__u32	data_bit_offset;
>>>>> -
>>>>> +	__u32	num_entry_point_offsets;
>>>>>   	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
>>>>>   	__u8	nal_unit_type;
>>>>>   	__u8	nuh_temporal_id_plus1;
>>>>> -- 
>>>>> 2.32.0
>>>>>
>>>>>
>>>>
>>
>
