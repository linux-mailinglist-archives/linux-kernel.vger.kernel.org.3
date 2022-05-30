Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B149B537898
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiE3JSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiE3JSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:18:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FD062CFD;
        Mon, 30 May 2022 02:18:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DC4A60FB5;
        Mon, 30 May 2022 09:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEC3C385B8;
        Mon, 30 May 2022 09:18:38 +0000 (UTC)
Message-ID: <c639efc2-2089-359d-44c6-e9d92e8fd22e@xs4all.nl>
Date:   Mon, 30 May 2022 11:18:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 11/17] media: uapi: Add
 V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
Content-Language: en-US
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org, nicolas.dufresne@collabora.com,
        andrzej.p@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
References: <20220527143134.3360174-1-benjamin.gaignard@collabora.com>
 <20220527143134.3360174-12-benjamin.gaignard@collabora.com>
 <2102641.irdbgypaU6@kista>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <2102641.irdbgypaU6@kista>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2022 08:40, Jernej Škrabec wrote:
> Hi!
> 
> This series looks very good and I plan to test it shortly on Cedrus, but I 
> have one major concern below.
> 
> Dne petek, 27. maj 2022 ob 16:31:28 CEST je Benjamin Gaignard napisal(a):
>> The number of 'entry point offset' can be very variable.
>> Instead of using a large static array define a v4l2 dynamic array
>> of U32 (V4L2_CTRL_TYPE_U32).
>> The number of entry point offsets is reported by the elems field
>> and in struct v4l2_ctrl_hevc_slice_params.num_entry_point_offsets
>> field.
> 
> Slice control by itself is variable length array, so you would actually need 
> 2D variable array for entry points which is not supported. However, easy 
> workaround for that is to flatten 2D array to 1D and either have another slice 
> control field which would tell first entry point index for convenience or let 
> driver calculate it by adding up all num_entry_point_offsets of previous 
> slices.
> 
> Hans, what do you think?

If I would support 2D variable array sizes, wouldn't that be more elegant?

The current implementation doesn't support that, but as the commit log for
patch 1/17 says:

"Currently dynamically sized arrays are limited to one dimensional arrays,
but that might change in the future if there is a need for it."

Let me know if you agree, and I'll try to implement this. It's been a while
since I last looked at this, so I'm not sure how much work it is, but it is
probably worth a shot.

Regards,

	Hans

> 
> Note, it seems that H265 decoding on Cedrus still works without entry points, 
> so this problem can be solved later. I'm not sure what we lose with that but 
> it was suggested that this could influence speed or error resilience or both. 
> However, I think we're close to solve it, so I'd like to do that now.
> 
> Best regards,
> Jernej
> 
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>>  .../userspace-api/media/v4l/ext-ctrls-codec.rst       | 11 +++++++++++
>>  drivers/media/v4l2-core/v4l2-ctrls-defs.c             |  5 +++++
>>  include/media/hevc-ctrls.h                            |  5 ++++-
>>  3 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/
> Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> index 0796b1563daa..05228e280f66 100644
>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>> @@ -3010,6 +3010,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>      * - __u32
>>        - ``data_bit_offset``
>>        - Offset (in bits) to the video data in the current slice data.
>> +    * - __u32
>> +      - ``num_entry_point_offsets``
>> +      - Specifies the number of entry point offset syntax elements in the 
> slice header.
>>      * - __u8
>>        - ``nal_unit_type``
>>        - Specifies the coding type of the slice (B, P or I).
>> @@ -3150,6 +3153,14 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>  
>>      \normalsize
>>  
>> +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
>> +    Specifies entry point offsets in bytes.
>> +    This control is a dynamically sized array. The number of entry point
>> +    offsets is reported by the ``elems`` field.
>> +    This bitstream parameter is defined according to :ref:`hevc`.
>> +    They are described in section 7.4.7.1 "General slice segment header
>> +    semantics" of the specification.
>> +
>>  ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
>>      Specifies the HEVC scaling matrix parameters used for the scaling 
> process
>>      for transform coefficients.
>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-
> core/v4l2-ctrls-defs.c
>> index d594efbcbb93..e22921e7ea61 100644
>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>> @@ -1188,6 +1188,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>>  	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:		return 
> "HEVC Decode Parameters";
>>  	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:		return 
> "HEVC Decode Mode";
>>  	case V4L2_CID_STATELESS_HEVC_START_CODE:		return 
> "HEVC Start Code";
>> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:	return 
> "HEVC Entry Point Offsets";
>>  
>>  	/* Colorimetry controls */
>>  	/* Keep the order of the 'case's the same as in v4l2-controls.h! 
> */
>> @@ -1518,6 +1519,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum 
> v4l2_ctrl_type *type,
>>  	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
>>  		*type = V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS;
>>  		break;
>> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:
>> +		*type = V4L2_CTRL_TYPE_U32;
>> +		*flags |= V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
>> +		break;
>>  	case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:
>>  		*type = V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR;
>>  		break;
>> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
>> index a3c829ef531a..1319cb99ae3f 100644
>> --- a/include/media/hevc-ctrls.h
>> +++ b/include/media/hevc-ctrls.h
>> @@ -20,6 +20,7 @@
>>  #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_BASE 
> + 1012)
>>  #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE + 1015)
>>  #define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE + 1016)
>> +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (V4L2_CID_CODEC_BASE + 
> 1017)
>>  
>>  /* enum v4l2_ctrl_type type values */
>>  #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
>> @@ -318,6 +319,8 @@ struct v4l2_hevc_pred_weight_table {
>>   *
>>   * @bit_size: size (in bits) of the current slice data
>>   * @data_bit_offset: offset (in bits) to the video data in the current slice 
> data
>> + * @num_entry_point_offsets: specifies the number of entry point offset syntax
>> + *			     elements in the slice header.
>>   * @nal_unit_type: specifies the coding type of the slice (B, P or I)
>>   * @nuh_temporal_id_plus1: minus 1 specifies a temporal identifier for the 
> NAL unit
>>   * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
>> @@ -360,7 +363,7 @@ struct v4l2_hevc_pred_weight_table {
>>  struct v4l2_ctrl_hevc_slice_params {
>>  	__u32	bit_size;
>>  	__u32	data_bit_offset;
>> -
>> +	__u32	num_entry_point_offsets;
>>  	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
>>  	__u8	nal_unit_type;
>>  	__u8	nuh_temporal_id_plus1;
>> -- 
>> 2.32.0
>>
>>
> 
> 

