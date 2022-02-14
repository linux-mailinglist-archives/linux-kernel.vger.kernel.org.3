Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF65F4B5874
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357051AbiBNRZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:25:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357052AbiBNRZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:25:19 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C044652F5;
        Mon, 14 Feb 2022 09:25:06 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:1b99:5680:6d85:c710] (unknown [IPv6:2a01:e0a:120:3210:1b99:5680:6d85:c710])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6A6311F43D7B;
        Mon, 14 Feb 2022 17:25:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644859505;
        bh=jdV1152z3m5drM9712crBNhL7RePfA8EUYrTwKj1Ihk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=h5ZC0DX1y67GAbWOIqDGXj7/yYm7W1HC1Iwbe9T3exBxB84HJ+URLCdvjKItYDzuE
         M5H4UXbSD+2Rp0Ieop3kKsx/dJ5WYlJbva4GHQi9Vx7vZKq7oaAAZJoHGU7y/2ha7O
         h8uaokr1BKuv9UmP4BGvxKrnZ6zWahUyftTVU1Q6jqel3BpHwzDYB6Q7+bD41fvSPP
         DCmwdCBry3oNBJ9WcLqiQfOV6t1YQ9uqkL8h0oTord+ebvbzPTiL7ZDUkuzvsl2PDI
         9yu3gKXZL8MJ2MxDesTKfxR1Tvjt8B6Xu5+yDtHlbtGjcxybcyyE0K1FfeN4SqFacc
         H1D/EJpl7rJaA==
Message-ID: <903ca214-9576-33aa-8412-7c71c9d8ac09@collabora.com>
Date:   Mon, 14 Feb 2022 18:25:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC] media: uapi: Move HEVC stateless controls out of staging
Content-Language: en-US
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        hverkuil-cisco@xs4all.nl, jonas@kwiboo.se, nicolas@ndufresne.ca
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, Alex Bee <knaerzche@gmail.com>,
        jc@kynesim.co.uk
References: <20220201123439.353854-1-benjamin.gaignard@collabora.com>
 <8038233.T7Z3S40VBb@kista>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <8038233.T7Z3S40VBb@kista>
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


Le 13/02/2022 à 12:33, Jernej Škrabec a écrit :
> Hi Benjamin,
>
> CC: Alex, John
>
> Sorry for late response, but I've been very busy last week.
>
> First of all, thank you for doing this! It's about time that HEVC moves
> forward.
>
> Dne torek, 01. februar 2022 ob 13:34:39 CET je Benjamin Gaignard napisal(a):
>> The HEVC stateless 'uAPI' was staging and marked explicitly in the
>> V4L2 specification that it will change and is unstable.
>>
>> Note that these control IDs were never exported as a public API,
>> they were only defined in kernel-local headers (hevc-ctrls.h).
>>
>> While moving the controls out of staging they are renamed and
>> control IDs get new numbers.
>> Drivers (Hantro, Cedrus) and Documentation are updated accordaly.
> accordaly -> accordingly
>
>> Additional structures fields has been added for RKVDEC driver usage.
> You should do separate patch for that, preceding this one. One patch should
> only do one thing.

I will do that in v2

>
> I also suggest that you add additional patch for removing bit_size field in
> struct v4l2_ctrl_hevc_slice_params. Similar fields were already removed from
> MPEG2 and H264 structures. Bit size can be deduced from output buffer size and
> it doesn't hurt if bit size in Cedrus is set to bigger value than actual slice
> bit size.

ok

>
>> Hantro dedicated control is moving to hantro-media.h
>> Since hevc-ctrls.h content has been dispatched in others file, remove it.
>>
>> fluster tests results on IMX8MQ is 77/147 for HEVC codec.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Note that Cedrus still needs additional information in order to decode some
> HEVC videos. Missing info is num_entry_point_offsets and list of all
> entry_point_offset_minus1 (obviously, num_entry_point_offsets in size).
>
> I suggest that this is represented in a new control, which would use dynamic
> array feature, written by Hans. While Cedrus supports max. 256 entries, it can
> be much bigger in theory, but in reality, it's much smaller (like 4-8
> entries).

I haven't seen yet any user for these fields but I will create a new control like
#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT	(V4L2_CID_CODEC_STATELESS_BASE + 407)

struct v4l2_ctrl_hevc_entry_point_offset {
	__u32	entry_point_offset_minus1;
};

and add it in the documentation:
``V4L2_CID_STATELESS_HEVC_ENTRY_POINT (struct)``
     Specifies the i-th entry point offset in bytes and is represented by
     offset_len_minus1 plus 1 bits.
     This control is a dynamically sized array. The number of entry point
     offsets is reported by the ``elems`` field.
     This bitstream parameter is defined according to :ref:`hevc`.
     They are described in section 7.4.7.1 "General slice segment header
     semantics" of the specification.

>
> Last but not least, data_bit_offset should be better defined. Currently it
> points right after last header bit, just like Cedrus needs it. However, there
> is padding after that, at least 1 bit and 8 bits at most, so slice data always
> starts from byte aligned address. It probably make sense to rework that field
> to be byte offset, not bit, just like in VA-API. Note that RPi HEVC driver also
> uses byte aligned address directly. Cedrus would need some kind of workaround
> and only one that works is this one:
> https://github.com/bootlin/libva-v4l2-request/blob/master/src/h265.c#L191-L209

If Cedrus driver is happy with this definition I will keep it like that.
When providing offset in bit is more accurate and any driver can align the value
if needed, the reverse (byte -> bit) isn't possible.

Regards,
Benjamin

>
> Best regards,
> Jernej
>
>
