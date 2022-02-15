Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F76D4B7263
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239439AbiBOOwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:52:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239301AbiBOOvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:51:52 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2A0105287
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:50:41 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id k127-20020a1ca185000000b0037bc4be8713so1629735wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynesim-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:references:in-reply-to
         :user-agent:mime-version:content-transfer-encoding;
        bh=5b8HakeV7BFbuxfk6iZTRI3Q5wA40DF8zLOKuqjUtUc=;
        b=IjtY+PAIfBxUZY6M3CGrhPbguGSRbYGqn9mARJ6RNP2WiIT9e9QO+SXVEsP3nAxJyJ
         s+A+WXD72nTH6BarbPg2ZiM/Fz/J76LLitnSHg+CYHPt5/8WZ+ZFBj9guT6c62fwtisv
         VmaDQ9d+c+GDS61cb3UqJJYNrEi8U4Te91rfj1t5BDTtYjQT9mR1B0OCrPG7XAcQhWlo
         eem4kpUJrsnu5XfwJtkaphRqskHEZASc8NpDIZYjrllV1786bWaC7cr2XocCHXlDkDsN
         JE6n9i3XM2ZZK0i89//jG2OkJ71nC3dPm3FR3P4oKJs5nzIJ9o9zw7DeJQU2ToMoSW43
         uovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:references
         :in-reply-to:user-agent:mime-version:content-transfer-encoding;
        bh=5b8HakeV7BFbuxfk6iZTRI3Q5wA40DF8zLOKuqjUtUc=;
        b=H/qAMjrwCBDfz5ZtjKN1e1f1XVFrlPCdO3RY5UlbeB93h3sy6mWjg+U3qMDI1DJxOG
         cu/pm5JLEuU+zfIEmvApu47vMghlGYaktapQelpQD73ikYyPKchyZKYZgBNLzFMl+mFY
         MHRmOBV6OqYhhExyzqnVE5mGXNaRLPjycuvScKDHWnvaLOS/BEFvDMruq6yZL/nQmSf1
         BuzNUQUy5DnsykIlWzRiZncwO/kh8tdzVDhHhb3DoqwJaT0XgM6DGjIUaKlkVY9Dnc+6
         sp9FCH6QP0TtaeIHiPovj0XYPKt4fOHMz52PNvxbL8Po/9P+KcrjQxfdYc6DX52iD97S
         3tnQ==
X-Gm-Message-State: AOAM5319NIYzmXW7EFo6CPbQyz6KkDbiJhNVgZUQgxiCNB2EAfJabArx
        kEUORHegtz+S8lNa1VsJxKLoig==
X-Google-Smtp-Source: ABdhPJw8FzNViu7HOP9ieeHSUewbjD3DG00BDusytqlmccRJ8zr+gR52hPS2zM5N891rbJqnM2m6cw==
X-Received: by 2002:a7b:c107:: with SMTP id w7mr3530831wmi.104.1644936639846;
        Tue, 15 Feb 2022 06:50:39 -0800 (PST)
Received: from CTHALPA.outer.uphall.net (cpc1-cmbg20-2-0-cust759.5-4.cable.virginm.net. [86.21.218.248])
        by smtp.gmail.com with ESMTPSA id n15sm19604601wmr.9.2022.02.15.06.50.37
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 15 Feb 2022 06:50:38 -0800 (PST)
From:   John Cox <jc@kynesim.co.uk>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, hverkuil-cisco@xs4all.nl,
        jonas@kwiboo.se, nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com
Subject: Re: [RFC v2 6/8] media: uapi: Remove bit_size field from v4l2_ctrl_hevc_slice_params
Date:   Tue, 15 Feb 2022 14:50:36 +0000
Message-ID: <mqen0ht146rbtukbd47tbtbiqvsmfta8oa@4ax.com>
References: <20220215110103.241297-1-benjamin.gaignard@collabora.com> <20220215110103.241297-7-benjamin.gaignard@collabora.com> <t2dn0hddgq22nt6a7sr6kl44irm3c2lj1j@4ax.com> <99062279-a3c4-96f7-4c4b-f39e7f812e68@collabora.com>
In-Reply-To: <99062279-a3c4-96f7-4c4b-f39e7f812e68@collabora.com>
User-Agent: ForteAgent/8.00.32.1272
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022 15:35:12 +0100, you wrote:

>
>Le 15/02/2022 =C3=A0 15:17, John Cox a =C3=A9crit=C2=A0:
>> Hi
>>
>>> The bit size of the slice could be deduced from the buffer payload
>>> so remove bit_size field to avoid duplicated the information.
>> I think this is a bad idea. In the future we are (I hope) going to =
want
>> to have an array (variable) of slice headers all referring to the same
>> bit buffer.  When we do that we will need this field.
>
>I wonder if that could be considering like another decode mode and so
>use an other control ?

I, personally, would be in favour of making the slice header control a
variable array just as it is.  If userland can't cope with multiple
entries then just send them one at a time and the code looks exactly
like it does at the moment and if the driver can't then set max array
entries to 1.

Having implemented this in rpi port of ffmpeg and the RPi V4L2 driver I
can say with experience that the code and effort overhead is very low.

Either way having a multiple slice header control in the UAPI is
important for efficiency.

Regards

John Cox

>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>> ---
>>> .../userspace-api/media/v4l/ext-ctrls-codec.rst       |  3 ---
>>> drivers/staging/media/sunxi/cedrus/cedrus_h265.c      | 11 =
++++-------
>>> include/uapi/linux/v4l2-controls.h                    |  3 +--
>>> 3 files changed, 5 insertions(+), 12 deletions(-)
>>>
>>> diff --git =
a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst =
b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> index 3296ac3b9fca..c3ae97657fa7 100644
>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>> @@ -2965,9 +2965,6 @@ enum v4l2_mpeg_video_hevc_size_of_length_field =
-
>>>      :stub-columns: 0
>>>      :widths:       1 1 2
>>>
>>> -    * - __u32
>>> -      - ``bit_size``
>>> -      - Size (in bits) of the current slice data.
>>>      * - __u32
>>>        - ``data_bit_offset``
>>>        - Offset (in bits) to the video data in the current slice =
data.
>>> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c =
b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>>> index 8ab2d9c6f048..db8c7475eeb8 100644
>>> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>>> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
>>> @@ -312,8 +312,8 @@ static void cedrus_h265_setup(struct cedrus_ctx =
*ctx,
>>> 	const struct v4l2_hevc_pred_weight_table *pred_weight_table;
>>> 	unsigned int width_in_ctb_luma, ctb_size_luma;
>>> 	unsigned int log2_max_luma_coding_block_size;
>>> +	size_t slice_bytes;
>>> 	dma_addr_t src_buf_addr;
>>> -	dma_addr_t src_buf_end_addr;
>>> 	u32 chroma_log2_weight_denom;
>>> 	u32 output_pic_list_index;
>>> 	u32 pic_order_cnt[2];
>>> @@ -370,8 +370,8 @@ static void cedrus_h265_setup(struct cedrus_ctx =
*ctx,
>>>
>>> 	cedrus_write(dev, VE_DEC_H265_BITS_OFFSET, 0);
>>>
>>> -	reg =3D slice_params->bit_size;
>>> -	cedrus_write(dev, VE_DEC_H265_BITS_LEN, reg);
>>> +	slice_bytes =3D vb2_get_plane_payload(&run->src->vb2_buf, 0);
>>> +	cedrus_write(dev, VE_DEC_H265_BITS_LEN, slice_bytes);
>> I think one of these must be wrong. bit_size is in bits,
>> vb2_get_plane_payload is in bytes?
>
>You are right it should be vb2_get_plane_payload() * 8 to get the size =
in bits.
>
>I will change that in v3.
>
>>
>> Regards
>>
>> John Cox
>>  =20
>>> 	/* Source beginning and end addresses. */
>>>
>>> @@ -384,10 +384,7 @@ static void cedrus_h265_setup(struct cedrus_ctx =
*ctx,
>>>
>>> 	cedrus_write(dev, VE_DEC_H265_BITS_ADDR, reg);
>>>
>>> -	src_buf_end_addr =3D src_buf_addr +
>>> -			   DIV_ROUND_UP(slice_params->bit_size, 8);
>>> -
>>> -	reg =3D VE_DEC_H265_BITS_END_ADDR_BASE(src_buf_end_addr);
>>> +	reg =3D VE_DEC_H265_BITS_END_ADDR_BASE(src_buf_addr + slice_bytes);
>>> 	cedrus_write(dev, VE_DEC_H265_BITS_END_ADDR, reg);
>>>
>>> 	/* Coding tree block address */
>>> diff --git a/include/uapi/linux/v4l2-controls.h =
b/include/uapi/linux/v4l2-controls.h
>>> index b1a3dc05f02f..27f5d272dc43 100644
>>> --- a/include/uapi/linux/v4l2-controls.h
>>> +++ b/include/uapi/linux/v4l2-controls.h
>>> @@ -2457,7 +2457,6 @@ struct v4l2_hevc_pred_weight_table {
>>> #define V4L2_HEVC_SLICE_PARAMS_FLAG_DEPENDENT_SLICE_SEGMENT	(1ULL << =
9)
>>>
>>> struct v4l2_ctrl_hevc_slice_params {
>>> -	__u32	bit_size;
>>> 	__u32	data_bit_offset;
>>>
>>> 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
>>> @@ -2484,7 +2483,7 @@ struct v4l2_ctrl_hevc_slice_params {
>>> 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture timing SEI message */
>>> 	__u8	pic_struct;
>>>
>>> -	__u8	reserved;
>>> +	__u8	reserved[5];
>>>
>>> 	/* ISO/IEC 23008-2, ITU-T Rec. H.265: General slice segment header =
*/
>>> 	__u32	slice_segment_addr;
