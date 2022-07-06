Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E015680A0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiGFH5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGFH5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:57:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C666BC9E;
        Wed,  6 Jul 2022 00:57:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1648FB81B31;
        Wed,  6 Jul 2022 07:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2787C341C8;
        Wed,  6 Jul 2022 07:56:57 +0000 (UTC)
Message-ID: <e63f409e-4e9c-78c1-dc1c-92efa4fff744@xs4all.nl>
Date:   Wed, 6 Jul 2022 09:56:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v10 11/17] media: uapi: Add
 V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     mchehab@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
References: <20220705085420.272912-1-benjamin.gaignard@collabora.com>
 <20220705085420.272912-12-benjamin.gaignard@collabora.com>
 <YsRclobW7gL/Dtlr@eze-laptop>
 <6ae43dcd-9b1d-ce30-8c3e-a8c313ef5b0a@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <6ae43dcd-9b1d-ce30-8c3e-a8c313ef5b0a@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 7/5/22 18:03, Benjamin Gaignard wrote:
> 
> Le 05/07/2022 à 17:45, Ezequiel Garcia a écrit :
>> Hi guys,
>>
>> On Tue, Jul 05, 2022 at 10:54:14AM +0200, Benjamin Gaignard wrote:
>>> The number of 'entry point offset' can be very variable.
>>> Instead of using a large static array define a v4l2 dynamic array
>>> of U32 (V4L2_CTRL_TYPE_U32).
>>> The number of entry point offsets is reported by the elems field
>>> and in struct v4l2_ctrl_hevc_slice_params.num_entry_point_offsets
>>> field.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>>> Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>>> ---
>>>   .../userspace-api/media/v4l/ext-ctrls-codec.rst       | 11 +++++++++++
>>>   drivers/media/v4l2-core/v4l2-ctrls-defs.c             |  5 +++++
>>>   include/media/hevc-ctrls.h                            |  5 ++++-
>>>   3 files changed, 20 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> index db0df7d9f27c..8df8d7fdfe70 100644
>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> @@ -3010,6 +3010,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>>       * - __u32
>>>         - ``data_bit_offset``
>>>         - Offset (in bits) to the video data in the current slice data.
>>> +    * - __u32
>>> +      - ``num_entry_point_offsets``
>>> +      - Specifies the number of entry point offset syntax elements in the slice header.
>> This looks underdocumented. Somewhere in the docs it should be mentioned
>> that the field 'num_entry_point_offsets' is linked to the control
>> V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS.
> 
> This field is here because some drivers would like know the number of
> entry point offsets without getting the entry point offsets data itself.

I agree with Ezequiel that this needs to be documented a bit better, esp. by
having a reference to the control (and vice versa, probably). That puts this
into better context.

I assume you'll post a v11?

Regards,

	Hans

> 
> Benjamin
> 
>>
>> Thanks,
>> Ezequiel
>>
>>>       * - __u8
>>>         - ``nal_unit_type``
>>>         - Specifies the coding type of the slice (B, P or I).
>>> @@ -3150,6 +3153,14 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>>   
>>>       \normalsize
>>>   
>>> +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
>>> +    Specifies entry point offsets in bytes.
>>> +    This control is a dynamically sized array. The number of entry point
>>> +    offsets is reported by the ``elems`` field.
>>> +    This bitstream parameter is defined according to :ref:`hevc`.
>>> +    They are described in section 7.4.7.1 "General slice segment header
>>> +    semantics" of the specification.
>>> +
>>>   ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
>>>       Specifies the HEVC scaling matrix parameters used for the scaling process
>>>       for transform coefficients.
>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>> index d594efbcbb93..e22921e7ea61 100644
>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>> @@ -1188,6 +1188,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>>>   	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:		return "HEVC Decode Parameters";
>>>   	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:		return "HEVC Decode Mode";
>>>   	case V4L2_CID_STATELESS_HEVC_START_CODE:		return "HEVC Start Code";
>>> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:	return "HEVC Entry Point Offsets";
>>>   
>>>   	/* Colorimetry controls */
>>>   	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
>>> @@ -1518,6 +1519,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
>>>   	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
>>>   		*type = V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS;
>>>   		break;
>>> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:
>>> +		*type = V4L2_CTRL_TYPE_U32;
>>> +		*flags |= V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
>>> +		break;
>>>   	case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:
>>>   		*type = V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR;
>>>   		break;
>>> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
>>> index a372c184689e..3a6601a46ced 100644
>>> --- a/include/media/hevc-ctrls.h
>>> +++ b/include/media/hevc-ctrls.h
>>> @@ -20,6 +20,7 @@
>>>   #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_BASE + 1012)
>>>   #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE + 1015)
>>>   #define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE + 1016)
>>> +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (V4L2_CID_CODEC_BASE + 1017)
>>>   
>>>   /* enum v4l2_ctrl_type type values */
>>>   #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
>>> @@ -316,6 +317,8 @@ struct v4l2_hevc_pred_weight_table {
>>>    *
>>>    * @bit_size: size (in bits) of the current slice data
>>>    * @data_bit_offset: offset (in bits) to the video data in the current slice data
>>> + * @num_entry_point_offsets: specifies the number of entry point offset syntax
>>> + *			     elements in the slice header.
>>>    * @nal_unit_type: specifies the coding type of the slice (B, P or I)
>>>    * @nuh_temporal_id_plus1: minus 1 specifies a temporal identifier for the NAL unit
>>>    * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
>>> @@ -358,7 +361,7 @@ struct v4l2_hevc_pred_weight_table {
>>>   struct v4l2_ctrl_hevc_slice_params {
>>>   	__u32	bit_size;
>>>   	__u32	data_bit_offset;
>>> -
>>> +	__u32	num_entry_point_offsets;
>>>   	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
>>>   	__u8	nal_unit_type;
>>>   	__u8	nuh_temporal_id_plus1;
>>> -- 
>>> 2.32.0
>>>

