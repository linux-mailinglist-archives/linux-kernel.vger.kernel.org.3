Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC7C53AAAA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355964AbiFAQDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348848AbiFAQC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:02:58 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7199035274;
        Wed,  1 Jun 2022 09:02:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: benjamin.gaignard)
        with ESMTPSA id 2B4D71F4104F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654099375;
        bh=QstXEK7vK9peaXuxwekF4t4rKyDGtTDzVurNPkvZNRU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bdRflAAGzQHFImM59JNtJ14nwKlXDWazj5QOV2ETaiLTpb2k/9J8u3r9Q5bGn8Qdw
         FC4bX0OMU0Y6K5p4xrIjBMciBTuirqvcXSNPkQx/lKv9+lVnim8QB4OUl9/E0/glqi
         64l71Rs9K5i+dVo8LibUxoP0iwXOYpuooJ1hpeXLtWvw3R/PYHL7keG0PZvOWka0BS
         j+BkhVmKdBGpV07VDbzUzsflGoJZ1vgTOM0EFHWKSbp5NXogW58iSE4+ZcMIglwIX9
         PfH0zADgzTol8Agsap2/mYLdR3/YjcSPDAjolLhoN0r6520Yt1CUp44gr0+Xt0kC4Q
         rLucgpnxOH9sA==
Message-ID: <aa6eaada-ad4e-9d47-62e8-2a709e5f190f@collabora.com>
Date:   Wed, 1 Jun 2022 18:02:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 09/17] media: uapi: HEVC: Define
 V4L2_CID_STATELESS_HEVC_SLICE_PARAMS as a dynamic array
Content-Language: en-US
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
References: <20220527143134.3360174-1-benjamin.gaignard@collabora.com>
 <20220527143134.3360174-10-benjamin.gaignard@collabora.com>
 <2630478.mvXUDI8C0e@kista> <8069971.T7Z3S40VBb@kista>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <8069971.T7Z3S40VBb@kista>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 01/06/2022 à 17:43, Jernej Škrabec a écrit :
> Dne nedelja, 29. maj 2022 ob 11:19:12 CEST je Jernej Škrabec napisal(a):
>> Dne petek, 27. maj 2022 ob 16:31:26 CEST je Benjamin Gaignard napisal(a):
>>> Make explicit that V4L2_CID_STATELESS_HEVC_SLICE_PARAMS control is
>>> a dynamic array control type.
>>> Some drivers may be able to receive multiple slices in one control
>>> to improve decoding performance.
>>>
>>> Define the max size of the dynamic that can driver can set in .dims = {}.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>> ---
>>> version 6:
>>> - Set V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag automatically when using
>>>    V4L2_CID_STATELESS_HEVC_SLICE_PARAMS control.
>>> - Add a define for max slices count
>>>
>>>   Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 2 ++
>>>   drivers/media/v4l2-core/v4l2-ctrls-defs.c                 | 1 +
>>>   include/media/hevc-ctrls.h                                | 5 +++++
>>>   3 files changed, 8 insertions(+)
>>>
>>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/
>> Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> index 06b967de140c..0796b1563daa 100644
>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> @@ -2986,6 +2986,8 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>>       These bitstream parameters are defined according to :ref:`hevc`.
>>>       They are described in section 7.4.7 "General slice segment header
>>>       semantics" of the specification.
>>> +    This control is a dynamically sized 1-dimensional array,
>>> +    V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
>>>   
>>>   .. c:type:: v4l2_ctrl_hevc_slice_params
>>>   
>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/
> v4l2-
>> core/v4l2-ctrls-defs.c
>>> index 9f55503cd3d6..d594efbcbb93 100644
>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>> @@ -1510,6 +1510,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum
>> v4l2_ctrl_type *type,
>>>   		break;
>>>   	case V4L2_CID_STATELESS_HEVC_SLICE_PARAMS:
>>>   		*type = V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS;
>>> +		*flags |= V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
>> This change breaks Cedrus. I'll check what needs to be changed.
> Please include the change bellow to keep Cedrus working. I'll expand support
> for more slices later.

That will be in version 7. Thanks.
I will wait for more reviews on the others patches before send it.

Regards,
Benjamin

>
>   Best regards,
>   Jernej
>
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> @@ -178,6 +178,7 @@ static const struct cedrus_control cedrus_controls[] = {
>          {
>                  .cfg = {
>                          .id     = V4L2_CID_STATELESS_HEVC_SLICE_PARAMS,
> +                       .dims   = { 1 },
>                  },
>                  .codec          = CEDRUS_CODEC_H265,
>          },
>   
>>>   		break;
>>>   	case V4L2_CID_STATELESS_HEVC_SCALING_MATRIX:
>>>   		*type = V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX;
>>> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
>>> index 0dbd5d681c28..140151609c96 100644
>>> --- a/include/media/hevc-ctrls.h
>>> +++ b/include/media/hevc-ctrls.h
>>> @@ -311,9 +311,14 @@ struct v4l2_hevc_pred_weight_table {
>>>   #define
> V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_LOOP_FILTER_ACROSS_SLICES_ENABLED
>> (1ULL << 8)
>>>   #define V4L2_HEVC_SLICE_PARAMS_FLAG_DEPENDENT_SLICE_SEGMENT	(1ULL <<
>> 9)
>>>   
>>> +#define V4L2_HEVC_SLICE_MAX_COUNT	600
>>> +
>>>   /**
>>>    * v4l2_ctrl_hevc_slice_params - HEVC slice parameters
>>>    *
>>> + * This control is a dynamically sized 1-dimensional array,
>>> + * V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
>>> + *
>>>    * @bit_size: size (in bits) of the current slice data
>>>    * @data_bit_offset: offset (in bits) to the video data in the current
> slice
>> data
>>>    * @nal_unit_type: specifies the coding type of the slice (B, P or I)
>>> -- 
>>> 2.32.0
>>>
>>>
>>
>>
>
