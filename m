Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11742569350
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiGFU2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiGFU2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:28:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A215B2558E;
        Wed,  6 Jul 2022 13:28:13 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:3a70:988d:42ce:f5cc] (unknown [IPv6:2a01:e0a:120:3210:3a70:988d:42ce:f5cc])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DB57B66015B5;
        Wed,  6 Jul 2022 21:28:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657139291;
        bh=mbUryPEs0snC50jCbdAQklXtgs2YsCGp2LLBeTrIpNc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FpJ1R9fk0f5LR02kULoB6wRBOn7m/RNjkRIAZ5OTzkm4B75wH7hQdcSNxjLoGFCBV
         WiZ86xabihBYBjbuDmmKFeeGXRoJEr+Ua71wDIRoOKDn1jG/+x0/B32xa2GHOx7Ups
         hMbHIxblUGdizjg2cS5S83i92xVihgsdZYCqA6bUS2TeT3826OmQHXe/rrpOYRK7+P
         OgQuBpzBTbr2jxW/k45yFIFezWe/gDkVBl83seOibkFVsHaqcEhVLQKo6F3wjxduGJ
         B5wEevu///Rqo8ZH3lB0MNgBlfDPOEr4a7n9Lx3H7c+HWhb6nhfopiCLRojTYagC0i
         8jnWtHh1cKjGg==
Message-ID: <2f479976-5f89-ba4b-a700-2c37e6f462b9@collabora.com>
Date:   Wed, 6 Jul 2022 22:28:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v10 11/17] media: uapi: Add
 V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
Content-Language: en-US
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-media <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        Collabora Kernel ML <kernel@collabora.com>
References: <20220705085420.272912-1-benjamin.gaignard@collabora.com>
 <4408380.LvFx2qVVIh@kista>
 <CAAEAJfDNHSBtJD_chSV0_UMTJWztyPFxjORRn0+dSrtcZCoYwg@mail.gmail.com>
 <1769918.8hzESeGDPO@kista>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <1769918.8hzESeGDPO@kista>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 06/07/2022 à 20:49, Jernej Škrabec a écrit :
> Dne sreda, 06. julij 2022 ob 20:39:41 CEST je Ezequiel Garcia napisal(a):
>> Hi Jernej,
>>
>> On Tue, Jul 5, 2022 at 1:11 PM Jernej Škrabec <jernej.skrabec@gmail.com>
> wrote:
>>> Dne torek, 05. julij 2022 ob 18:03:28 CEST je Benjamin Gaignard
> napisal(a):
>>>> Le 05/07/2022 à 17:45, Ezequiel Garcia a écrit :
>>>>> Hi guys,
>>>>>
>>>>> On Tue, Jul 05, 2022 at 10:54:14AM +0200, Benjamin Gaignard wrote:
>>>>>> The number of 'entry point offset' can be very variable.
>>>>>> Instead of using a large static array define a v4l2 dynamic array
>>>>>> of U32 (V4L2_CTRL_TYPE_U32).
>>>>>> The number of entry point offsets is reported by the elems field
>>>>>> and in struct v4l2_ctrl_hevc_slice_params.num_entry_point_offsets
>>>>>> field.
>>>>>>
>>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>>>> Acked-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>>>>>> Tested-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>>>>>> ---
>>>>>>
>>>>>>    .../userspace-api/media/v4l/ext-ctrls-codec.rst       | 11
>>>>>>    +++++++++++
>>>>>>    drivers/media/v4l2-core/v4l2-ctrls-defs.c             |  5 +++++
>>>>>>    include/media/hevc-ctrls.h                            |  5 ++++-
>>>>>>    3 files changed, 20 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git
>>>>>> a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>>>> b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst index
>>>>>> db0df7d9f27c..8df8d7fdfe70 100644
>>>>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>>>> @@ -3010,6 +3010,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field
>>>>>> -
>>>>>>
>>>>>>        * - __u32
>>>>>>        
>>>>>>          - ``data_bit_offset``
>>>>>>          - Offset (in bits) to the video data in the current slice
>>>>>>          data.
>>>>>>
>>>>>> +    * - __u32
>>>>>> +      - ``num_entry_point_offsets``
>>>>>> +      - Specifies the number of entry point offset syntax elements
>>>>>> in
>>>>>> the slice header.>
>>>>> This looks underdocumented. Somewhere in the docs it should be
>>>>> mentioned
>>>>> that the field 'num_entry_point_offsets' is linked to the control
>>>>> V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS.
>>>> This field is here because some drivers would like know the number of
>>>> entry point offsets without getting the entry point offsets data itself.
>>> Yeah, this field must be set even when entry points offset control isn't
>>> used. Additionally, if entry point offsets control is needed and if
>>> submitting multiple slices at once, length of entry point offsets array
>>> must be sum of num_entry_point_offsets of all slices in that job. Not
>>> sure where to put this explanation.
>> This confused me a bit: so you mean that this field (called
>> num_entry_point_offsets)
>> must be the sum of "num_entry_point_offsets" syntax elements for
>> slices in the request?
> No, it's the other way around. num_entry_point_offsets field has same meaning as
> in syntax. It's per slice property. I said that if there is control with all
> entry point offsets, it has to have number of elements, which is sum of all
> num_entry_point_offsets fields in slice array.
>
> Example (totaly made up):
>
> Frame has 4 slices, each with 16 entry points.
> App sends only 2 slices per job. Both num_entry_point_offsets fields in slice
> control will have value 16, but entry point offsets array control will have 32
> elements (16 entry points offsets from first and 16 entry point offsets from
> second slice).

Jernej I have used your previous answer to document this field in v11.

Regards,
Benjamin

>
> Best regards,
> Jernej
>
>> If this is the case, then perhaps it will be a mistake to name our V4L2
>> field exactly like the syntax element, since it this sum meaning.
>> Otherwise, developers would tend to get confused by it.
>>
>> What do you think?
>>
>> Thanks,
>> Ezequiel
>>
>>> Best regards,
>>> Jernej
>>>
>>>> Benjamin
>>>>
>>>>> Thanks,
>>>>> Ezequiel
>>>>>
>>>>>>        * - __u8
>>>>>>        
>>>>>>          - ``nal_unit_type``
>>>>>>          - Specifies the coding type of the slice (B, P or I).
>>>>>>
>>>>>> @@ -3150,6 +3153,14 @@ enum v4l2_mpeg_video_hevc_size_of_length_field
>>>>>> -
>>>>>>
>>>>>>        \normalsize
>>>>>>
>>>>>> +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
>>>>>> +    Specifies entry point offsets in bytes.
>>>>>> +    This control is a dynamically sized array. The number of entry
>>>>>> point
>>>>>> +    offsets is reported by the ``elems`` field.
>>>>>> +    This bitstream parameter is defined according to :ref:`hevc`.
>>>>>> +    They are described in section 7.4.7.1 "General slice segment
>>>>>> header
>>>>>> +    semantics" of the specification.
>>>>>> +
>>>>>>
>>>>>>    ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
>>>>>>    
>>>>>>        Specifies the HEVC scaling matrix parameters used for the
>>>>>>        scaling
>>>>>>        process
>>>>>>        for transform coefficients.
>>>>>>
>>>>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>>>> b/drivers/media/v4l2-core/v4l2-ctrls-defs.c index
>>>>>> d594efbcbb93..e22921e7ea61 100644
>>>>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>>>> @@ -1188,6 +1188,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>>>>>>
>>>>>>     case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:             return
>>> "HEVC Decode
>>>
>>>>>>     Parameters"; case V4L2_CID_STATELESS_HEVC_DECODE_MODE:
>>> return "HEVC
>>>
>>>>>>     Decode Mode"; case V4L2_CID_STATELESS_HEVC_START_CODE:
>>> return "HEVC
>>>
>>>>>>     Start Code";>>
>>>>>>
>>>>>> +  case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:       return
>>> "HEVC Entry
>>>
>>>>>> Point Offsets";>>
>>>>>>
>>>>>>     /* Colorimetry controls */
>>>>>>     /* Keep the order of the 'case's the same as in v4l2-controls.h!
>>> */
>>>
>>>>>> @@ -1518,6 +1519,10 @@ void v4l2_ctrl_fill(u32 id, const char **name,
>>>>>> enum v4l2_ctrl_type *type,>>
>>>>>>
>>>>>>     case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
>>>>>>             *type = V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS;
>>>>>>             break;
>>>>>>
>>>>>> +  case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:
>>>>>> +          *type = V4L2_CTRL_TYPE_U32;
>>>>>> +          *flags |= V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
>>>>>> +          break;
>>>>>>
>>>>>>     case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:
>>>>>>             *type = V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR;
>>>>>>             break;
>>>>>>
>>>>>> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
>>>>>> index a372c184689e..3a6601a46ced 100644
>>>>>> --- a/include/media/hevc-ctrls.h
>>>>>> +++ b/include/media/hevc-ctrls.h
>>>>>> @@ -20,6 +20,7 @@
>>>>>>
>>>>>>    #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS
>>> (V4L2_CID_CODEC_BASE +
>>>
>>>>>>    1012)
>>>>>>    #define V4L2_CID_STATELESS_HEVC_DECODE_MODE
>>>>>>    (V4L2_CID_CODEC_BASE
>>> +
>>>
>>>>>>    1015)
>>>>>>    #define V4L2_CID_STATELESS_HEVC_START_CODE
>>>>>>    (V4L2_CID_CODEC_BASE + 1016)> > >>
>>>>>> +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS
>>>>>> (V4L2_CID_CODEC_BASE
>>>>>> + 1017)>>
>>>>>>
>>>>>>    /* enum v4l2_ctrl_type type values */
>>>>>>    #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
>>>>>>
>>>>>> @@ -316,6 +317,8 @@ struct v4l2_hevc_pred_weight_table {
>>>>>>
>>>>>>     *
>>>>>>     * @bit_size: size (in bits) of the current slice data
>>>>>>     * @data_bit_offset: offset (in bits) to the video data in the
>>>>>>     current
>>>>>>     slice data>>
>>>>>>
>>>>>> + * @num_entry_point_offsets: specifies the number of entry point
>>>>>> offset
>>>>>> syntax + *                      elements in the slice
>>> header.
>>>
>>>>>>     * @nal_unit_type: specifies the coding type of the slice (B, P or
>>>>>>     I)
>>>>>>     * @nuh_temporal_id_plus1: minus 1 specifies a temporal identifier
>>>>>>     for
>>>>>>     the NAL unit * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
>>>>>>
>>>>>> @@ -358,7 +361,7 @@ struct v4l2_hevc_pred_weight_table {
>>>>>>
>>>>>>    struct v4l2_ctrl_hevc_slice_params {
>>>>>>    
>>>>>>     __u32   bit_size;
>>>>>>     __u32   data_bit_offset;
>>>>>>
>>>>>> -
>>>>>> +  __u32   num_entry_point_offsets;
>>>>>>
>>>>>>     /* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
>>>>>>     __u8    nal_unit_type;
>>>>>>     __u8    nuh_temporal_id_plus1;
>>>>>>
>>>>>> --
>>>>>> 2.32.0
>
