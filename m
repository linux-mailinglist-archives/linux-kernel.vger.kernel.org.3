Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AFB4B7269
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239371AbiBOO6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:58:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbiBOO54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:57:56 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C02636F;
        Tue, 15 Feb 2022 06:57:45 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:6d7b:ae43:289b:7e7c] (unknown [IPv6:2a01:e0a:120:3210:6d7b:ae43:289b:7e7c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 737021F44B87;
        Tue, 15 Feb 2022 14:57:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644937064;
        bh=7KL/E1roB+Tsjv5A9j7TgPU3P6wRIqjJyd0pX11Row0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W0nxo3O4UtsEQgAxjOIXGmT/eRA0jwW5mEMbT+VUmSvNj8xiq27pUa4KAFWyH7OPn
         4Daj5t94TsJZbmYOS1TF4d7gzjtDT3bY5JxdaY6RK0d5XtIHQKrW5EWnfoZ9ereITe
         Eh0w4js6g04jJdWKoCcIRw1zBBp4TRYL+izfixRDrTJeVI7mPw0tpW7imawps52ujF
         qcoIBYHRAuNGXFP0GGmYAljY8qV9Sl99kAut50r/Gj5aUf9IwZLhymdhySZmwqTGBt
         iajVR8j8kKb66KF449rW9ZjqjX82OhPJZJyTN8eMPU2vgW4xEwgyoJ3r4aK/YCwrXN
         +1ZRQTPpgCQ3A==
Message-ID: <b498904f-8c0e-65e4-b35c-d03792820891@collabora.com>
Date:   Tue, 15 Feb 2022 15:57:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC v2 6/8] media: uapi: Remove bit_size field from
 v4l2_ctrl_hevc_slice_params
Content-Language: en-US
To:     John Cox <jc@kynesim.co.uk>
Cc:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, hverkuil-cisco@xs4all.nl,
        jonas@kwiboo.se, nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com
References: <20220215110103.241297-1-benjamin.gaignard@collabora.com>
 <20220215110103.241297-7-benjamin.gaignard@collabora.com>
 <t2dn0hddgq22nt6a7sr6kl44irm3c2lj1j@4ax.com>
 <99062279-a3c4-96f7-4c4b-f39e7f812e68@collabora.com>
 <mqen0ht146rbtukbd47tbtbiqvsmfta8oa@4ax.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <mqen0ht146rbtukbd47tbtbiqvsmfta8oa@4ax.com>
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


Le 15/02/2022 à 15:50, John Cox a écrit :
> On Tue, 15 Feb 2022 15:35:12 +0100, you wrote:
>
>> Le 15/02/2022 à 15:17, John Cox a écrit :
>>> Hi
>>>
>>>> The bit size of the slice could be deduced from the buffer payload
>>>> so remove bit_size field to avoid duplicated the information.
>>> I think this is a bad idea. In the future we are (I hope) going to want
>>> to have an array (variable) of slice headers all referring to the same
>>> bit buffer.  When we do that we will need this field.
>> I wonder if that could be considering like another decode mode and so
>> use an other control ?
> I, personally, would be in favour of making the slice header control a
> variable array just as it is.  If userland can't cope with multiple
> entries then just send them one at a time and the code looks exactly
> like it does at the moment and if the driver can't then set max array
> entries to 1.
>
> Having implemented this in rpi port of ffmpeg and the RPi V4L2 driver I
> can say with experience that the code and effort overhead is very low.
>
> Either way having a multiple slice header control in the UAPI is
> important for efficiency.

Removing this field was one the Jernej's remarks.
If he agree with you it won't be a big effort for me to remove this patch
from v3.

Regards,
Benjamin

>
> Regards
>
> John Cox
>
>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>> ---
>>>> .../userspace-api/media/v4l/ext-ctrls-codec.rst       |  3 ---
>>>> drivers/staging/media/sunxi/cedrus/cedrus_h265.c      | 11 ++++-------
>>>> include/uapi/linux/v4l2-controls.h                    |  3 +--
>>>> 3 files changed, 5 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> index 3296ac3b9fca..c3ae97657fa7 100644
>>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> @@ -2965,9 +2965,6 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
>>>>       :stub-columns: 0
>>>>       :widths:       1 1 2
>>>>
>>>> -    * - __u32
>>>> -      - ``bit_size``
>>>> -      - Size (in bits) of the current slice data.
>>>>       * - __u32
>>>>         - ``data_bit_offset``
>>>>         - Offset (in bits) to the video data in the current slice data.
>>>> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>>>> index 8ab2d9c6f048..db8c7475eeb8 100644
>>>> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>>>> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>>>> @@ -312,8 +312,8 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
>>>> 	const struct v4l2_hevc_pred_weight_table *pred_weight_table;
>>>> 	unsigned int width_in_ctb_luma, ctb_size_luma;
>>>> 	unsigned int log2_max_luma_coding_block_size;
>>>> +	size_t slice_bytes;
>>>> 	dma_addr_t src_buf_addr;
>>>> -	dma_addr_t src_buf_end_addr;
>>>> 	u32 chroma_log2_weight_denom;
>>>> 	u32 output_pic_list_index;
>>>> 	u32 pic_order_cnt[2];
>>>> @@ -370,8 +370,8 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
>>>>
>>>> 	cedrus_write(dev, VE_DEC_H265_BITS_OFFSET, 0);
>>>>
>>>> -	reg = slice_params->bit_size;
>>>> -	cedrus_write(dev, VE_DEC_H265_BITS_LEN, reg);
>>>> +	slice_bytes = vb2_get_plane_payload(&run->src->vb2_buf, 0);
>>>> +	cedrus_write(dev, VE_DEC_H265_BITS_LEN, slice_bytes);
>>> I think one of these must be wrong. bit_size is in bits,
>>> vb2_get_plane_payload is in bytes?
>> You are right it should be vb2_get_plane_payload() * 8 to get the size in bits.
>>
>> I will change that in v3.
>>
>>> Regards
>>>
>>> John Cox
>>>    
>>>> 	/* Source beginning and end addresses. */
>>>>
>>>> @@ -384,10 +384,7 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
>>>>
>>>> 	cedrus_write(dev, VE_DEC_H265_BITS_ADDR, reg);
>>>>
>>>> -	src_buf_end_addr = src_buf_addr +
>>>> -			   DIV_ROUND_UP(slice_params->bit_size, 8);
>>>> -
>>>> -	reg = VE_DEC_H265_BITS_END_ADDR_BASE(src_buf_end_addr);
>>>> +	reg = VE_DEC_H265_BITS_END_ADDR_BASE(src_buf_addr + slice_bytes);
>>>> 	cedrus_write(dev, VE_DEC_H265_BITS_END_ADDR, reg);
>>>>
>>>> 	/* Coding tree block address */
>>>> diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
>>>> index b1a3dc05f02f..27f5d272dc43 100644
>>>> --- a/include/uapi/linux/v4l2-controls.h
>>>> +++ b/include/uapi/linux/v4l2-controls.h
>>>> @@ -2457,7 +2457,6 @@ struct v4l2_hevc_pred_weight_table {
>>>> #define V4L2_HEVC_SLICE_PARAMS_FLAG_DEPENDENT_SLICE_SEGMENT	(1ULL << 9)
>>>>
>>>> struct v4l2_ctrl_hevc_slice_params {
>>>> -	__u32	bit_size;
>>>> 	__u32	data_bit_offset;
>>>>
>>>> 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
>>>> @@ -2484,7 +2483,7 @@ struct v4l2_ctrl_hevc_slice_params {
>>>> 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture timing SEI message */
>>>> 	__u8	pic_struct;
>>>>
>>>> -	__u8	reserved;
>>>> +	__u8	reserved[5];
>>>>
>>>> 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: General slice segment header */
>>>> 	__u32	slice_segment_addr;
