Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB1D53AB14
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356129AbiFAQda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350575AbiFAQd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:33:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8A965D3E;
        Wed,  1 Jun 2022 09:33:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: benjamin.gaignard)
        with ESMTPSA id 185571F443D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654101205;
        bh=/k2OEvYaoBLK0+XQCL14qvZ3P2lVQFrna6Q3sC0KYJY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LhYjdTfziVYE4CSpnF0AFdDiN/mKl0eldKoNIk27TXvwqz1y4BkuAQWECFdQUJrXH
         l+KzGfLMIjl9SgtEZPAeu3cXPpYv3N1xd2/l5sAy4/HOYN44VXAOX24VG3Tb8aCUky
         rlbdm0bNTY2cZB1ywfHARxEW2jQ1ksKfE0ItQY/uJ8FLSQFHIFIksy3j2wPBv4GXvp
         8/RYhcdch23W59SgxPTZojCScv8DXBdfqWLR8hf3fp8FEczZ4E14KACkdwYIV3qG9x
         NnGuqoG0gwOc9ruYBeto8uA/uJTIo0w97QR4M/HKTaJepg9b2JYNe4qOAvGa+15AoT
         J+WGVXVFha9kA==
Message-ID: <c330e3e1-e10c-5930-2d1d-6260cb8d64b8@collabora.com>
Date:   Wed, 1 Jun 2022 18:33:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v6 16/17] media: uapi: Change data_bit_offset definition
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
 <20220527143134.3360174-17-benjamin.gaignard@collabora.com>
 <3175529.44csPzL39Z@kista> <7385576.EvYhyI6sBW@kista>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <7385576.EvYhyI6sBW@kista>
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


Le 01/06/2022 à 18:17, Jernej Škrabec a écrit :
> Dne nedelja, 29. maj 2022 ob 08:45:57 CEST je Jernej Škrabec napisal(a):
>> Dne petek, 27. maj 2022 ob 16:31:33 CEST je Benjamin Gaignard napisal(a):
>>> 'F.7.3.6.1 General slice segment header syntax' section of HEVC
>>> specification describes that a slice header always end aligned on
>>> byte boundary, therefore we only need to provide the data offset in bytes.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>> ---
>>>   Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 4 ++--
>>>   drivers/staging/media/sunxi/cedrus/cedrus_h265.c          | 2 +-
>>>   include/media/hevc-ctrls.h                                | 4 ++--
>>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/
>> Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> index 48a8825a001b..37079581c661 100644
>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> @@ -3008,8 +3008,8 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>>         - ``bit_size``
>>>         - Size (in bits) of the current slice data.
>>>       * - __u32
>>> -      - ``data_bit_offset``
>>> -      - Offset (in bits) to the video data in the current slice data.
>>> +      - ``data_byte_offset``
>>> +      - Offset (in bytes) to the video data in the current slice data.
>>>       * - __u32
>>>         - ``num_entry_point_offsets``
>>>         - Specifies the number of entry point offset syntax elements in the
>> slice header.
>>> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/
>> staging/media/sunxi/cedrus/cedrus_h265.c
>>> index 411601975124..835454239f73 100644
>>> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>>> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>>> @@ -405,7 +405,7 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
>>>   	/* Initialize bitstream access. */
>>>   	cedrus_write(dev, VE_DEC_H265_TRIGGER,
>> VE_DEC_H265_TRIGGER_INIT_SWDEC);
>>>   
>>> -	cedrus_h265_skip_bits(dev, slice_params->data_bit_offset);
>>> +	cedrus_h265_skip_bits(dev, slice_params->data_byte_offset * 8);
>> While it's true that actual data starts on 8-bit aligned address, Cedrus for
>> some reason needs offset which points at the end of the header, before
>> alignment. There is very simple way to determine that, but unfortunately
> this
>> means reading source buffer.
>>
>> In short, above code won't work. I'll provide a fix.
> Please include following fix http://ix.io/3Z8x otherwise Cedrus will fail to
> decode slice.
>
> Other than fix in previous e-mail and this one, code looks good and I'll be
> able to add missing functionality to Cedrus without much trouble in follow up
> series.

Thanks for the patch it will be in version 7.

Regards,
Benjamin

>
> Best regards,
> Jernej
>
>>>   
>>>   	/* Bitstream parameters. */
>>>   
>>> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
>>> index 9abca1a75bd4..936ff693967b 100644
>>> --- a/include/media/hevc-ctrls.h
>>> +++ b/include/media/hevc-ctrls.h
>>> @@ -312,7 +312,7 @@ struct v4l2_hevc_pred_weight_table {
>>>    * V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
>>>    *
>>>    * @bit_size: size (in bits) of the current slice data
>>> - * @data_bit_offset: offset (in bits) to the video data in the current
> slice
>> data
>>> + * @data_byte_offset: offset (in bytes) to the video data in the current
>> slice data
>>>    * @num_entry_point_offsets: specifies the number of entry point offset
> syntax
>>>    *			     elements in the slice header.
>>>    * @nal_unit_type: specifies the coding type of the slice (B, P or I)
>>> @@ -356,7 +356,7 @@ struct v4l2_hevc_pred_weight_table {
>>>    */
>>>   struct v4l2_ctrl_hevc_slice_params {
>>>   	__u32	bit_size;
>>> -	__u32	data_bit_offset;
>>> +	__u32	data_byte_offset;
>>>   	__u32	num_entry_point_offsets;
>>>   	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
>>>   	__u8	nal_unit_type;
>>> -- 
>>> 2.32.0
>>>
>>>
>>
>>
>
