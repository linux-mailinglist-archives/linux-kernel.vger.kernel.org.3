Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8765E4B71ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbiBOOwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:52:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239315AbiBOOvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:51:53 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA7329C90;
        Tue, 15 Feb 2022 06:51:18 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:6d7b:ae43:289b:7e7c] (unknown [IPv6:2a01:e0a:120:3210:6d7b:ae43:289b:7e7c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 26B781F44B73;
        Tue, 15 Feb 2022 14:51:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644936676;
        bh=BISiIxMthx3a38D0w6FQTgr0oYS0glTcHHhtZRUHEmI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=khtOgfbefSkpsF1Gw7AuGbcob/Pkcy7PJ6TJiFl8GjmzYMAO1otg6g9IdhIGlMPu9
         eesGO0llgkt7jVmbJtZa8/L7mykCviiOhoVavnSJivkqYMiHRGkbYMANjqvnFEDYvB
         X6px2CaO8tZ1YUwapVheciUKWAr5a66Oskry5j23gO/lFoqNo1zIVrtMXFg8Pxf1gn
         pHiFmZn4y1c6aduURue+oWWndNQCOZ/b4RgLMPqIprsnX7o39gPLJngdctX3PsKBbf
         LeYz8C7jx7hFLQrvRZdMU/Psr8a7VA6eYdFS9fzqb7HiKShp3PV6HWjygrePKdxb3c
         6aOcvuLs7wg/A==
Message-ID: <fe5017b0-6ea3-6b30-e04f-fad3aa769906@collabora.com>
Date:   Tue, 15 Feb 2022 15:51:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC] media: uapi: Move HEVC stateless controls out of staging
Content-Language: en-US
To:     John Cox <jc@kynesim.co.uk>,
        =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>
Cc:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        hverkuil-cisco@xs4all.nl, jonas@kwiboo.se, nicolas@ndufresne.ca,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, Alex Bee <knaerzche@gmail.com>
References: <20220201123439.353854-1-benjamin.gaignard@collabora.com>
 <8038233.T7Z3S40VBb@kista>
 <903ca214-9576-33aa-8412-7c71c9d8ac09@collabora.com>
 <2302767.NG923GbCHz@kista> <andn0h1pjhbkuaejphce535gm6u8ptae8v@4ax.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <andn0h1pjhbkuaejphce535gm6u8ptae8v@4ax.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 15/02/2022 à 15:37, John Cox a écrit :
> On Mon, 14 Feb 2022 20:26:34 +0100, you wrote:
>
>> Dne ponedeljek, 14. februar 2022 ob 18:25:01 CET je Benjamin Gaignard
>> napisal(a):
>>> Le 13/02/2022 à 12:33, Jernej Škrabec a écrit :
>>>> Hi Benjamin,
>>>>
>>>> CC: Alex, John
>>>>
>>>> Sorry for late response, but I've been very busy last week.
>>>>
>>>> First of all, thank you for doing this! It's about time that HEVC moves
>>>> forward.
>>>>
>>>> Dne torek, 01. februar 2022 ob 13:34:39 CET je Benjamin Gaignard
>> napisal(a):
>>>>> The HEVC stateless 'uAPI' was staging and marked explicitly in the
>>>>> V4L2 specification that it will change and is unstable.
>>>>>
>>>>> Note that these control IDs were never exported as a public API,
>>>>> they were only defined in kernel-local headers (hevc-ctrls.h).
>>>>>
>>>>> While moving the controls out of staging they are renamed and
>>>>> control IDs get new numbers.
>>>>> Drivers (Hantro, Cedrus) and Documentation are updated accordaly.
>>>> accordaly -> accordingly
>>>>
>>>>> Additional structures fields has been added for RKVDEC driver usage.
>>>> You should do separate patch for that, preceding this one. One patch
>> should
>>>> only do one thing.
>>> I will do that in v2
>>>
>>>> I also suggest that you add additional patch for removing bit_size field in
>>>> struct v4l2_ctrl_hevc_slice_params. Similar fields were already removed
>> from
>>>> MPEG2 and H264 structures. Bit size can be deduced from output buffer size
>> and
>>>> it doesn't hurt if bit size in Cedrus is set to bigger value than actual
>> slice
>>>> bit size.
>>> ok
>>>
>>>>> Hantro dedicated control is moving to hantro-media.h
>>>>> Since hevc-ctrls.h content has been dispatched in others file, remove it.
>>>>>
>>>>> fluster tests results on IMX8MQ is 77/147 for HEVC codec.
>>>>>
>>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>> Note that Cedrus still needs additional information in order to decode
>> some
>>>> HEVC videos. Missing info is num_entry_point_offsets and list of all
>>>> entry_point_offset_minus1 (obviously, num_entry_point_offsets in size).
>>>>
>>>> I suggest that this is represented in a new control, which would use
>> dynamic
>>>> array feature, written by Hans. While Cedrus supports max. 256 entries, it
>> can
>>>> be much bigger in theory, but in reality, it's much smaller (like 4-8
>>>> entries).
>>> I haven't seen yet any user for these fields but I will create a new control
>> like
>>> #define V4L2_CID_STATELESS_HEVC_ENTRY_POINT	(V4L2_CID_CODEC_STATELESS_BASE +
>> 407)
>>> struct v4l2_ctrl_hevc_entry_point_offset {
>>> 	__u32	entry_point_offset_minus1;
>>> };
> Can we tell if this control is needed from userland? There's no great
> point in filling it in if the driver isn't going to use it.
>
>> Yeah, Cedrus is currently the only mainline driver that needs that in order to
>> fully work. I think John used num_entry_point_offsets in his (out of tree) RPi
>> HEVC decoding driver too.
> num_entry_points is a useful field  (in the slice header preferably) for
> the RPi hardware as whilst it doesn't need to know the offsets it does
> need to construct a table with one entry per offset (for cabac state
> purposes) so it needs to know how many there are. It is possible to
> infer the number from the slice_segment address in the next slice header
> but that involves keeping around more state from one request to the
> next.

In v2 I have remove the structure and only keep a dynamic v4l2 control (an array
of integer). Control num_elems could be used as num_entry_points field.
Userland can test if the driver implement the control to decide to fill or not.
It is already the case in GStreamer for Hantro dedicate control.

>
>> Wouldn't be easier to just use u32 directly? This is just array of numbers, so
>> nothing else will be added in that struct...
>>
>> Anyway, once you add this, I'll quickly update driver to take advantage of it.
>>
>>> and add it in the documentation:
>>> ``V4L2_CID_STATELESS_HEVC_ENTRY_POINT (struct)``
>>>       Specifies the i-th entry point offset in bytes and is represented by
>>>       offset_len_minus1 plus 1 bits.
>>>       This control is a dynamically sized array. The number of entry point
>>>       offsets is reported by the ``elems`` field.
>>>       This bitstream parameter is defined according to :ref:`hevc`.
>>>       They are described in section 7.4.7.1 "General slice segment header
>>>       semantics" of the specification.
>>>
>>>> Last but not least, data_bit_offset should be better defined. Currently it
>>>> points right after last header bit, just like Cedrus needs it. However,
>> there
>>>> is padding after that, at least 1 bit and 8 bits at most, so slice data
>> always
>>>> starts from byte aligned address. It probably make sense to rework that
>> field
>>>> to be byte offset, not bit, just like in VA-API. Note that RPi HEVC driver
>> also
>>>> uses byte aligned address directly. Cedrus would need some kind of
>> workaround
>>>> and only one that works is this one:
>>>> https://github.com/bootlin/libva-v4l2-request/blob/master/src/h265.c#L191-L209
>>> If Cedrus driver is happy with this definition I will keep it like that.
>>> When providing offset in bit is more accurate and any driver can align the
>> value
>>> if needed, the reverse (byte -> bit) isn't possible.
>> If I'm not mistaken, HEVC standard actually requires that slice data starts at
>> byte aligned address, so nothing would be lost for correctness of uAPI.
>>
>> I already had this discussion with John and IIRC conclusion was to have byte
>> aligned value here. John, can you please confirm if my interpretation is
>> correct?
> Yes slice_segment_data only occurs afer slice_segment_header (7.3.6.1)
> and that ends with byte_alignment().

I have done a patch for that change in v2.

Regards,

Benjamin

>
> Regards
>
> John Cox
>
>> Best regards,
>> Jernej
>>
>>> Regards,
>>> Benjamin
>>>
>>>> Best regards,
>>>> Jernej
>>>>
>>>>
