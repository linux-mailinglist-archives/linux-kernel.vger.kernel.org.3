Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25324546810
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 16:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343864AbiFJOIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 10:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244292AbiFJOIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:08:47 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9D1DF96
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:08:45 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id q15so28650968wrc.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynesim-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:references:in-reply-to
         :user-agent:mime-version:content-transfer-encoding;
        bh=Dh7ytCWooIX35YNRESY2VG7oKkmeQTMTkqytRCSU7Qo=;
        b=IdovWcn93xCezzeAjZqOAAzu44aDEWMldf5MMaloZTHDpkqucrCngeIRu78PTqmIyH
         RkTbE/AaFYwsaYXY2is2pjeQV6YY151uwhHcbiXtw+nTNINAkFYyDqV+iXuVuV3FJERk
         nZmsSdD04XSRD/g4G9wLDwcmbKARURKhG22UHzt2Dgx3PleL7lPWQsJI08Xr1yHAh4tu
         2ocohVrNKcKH5iAjwti9IaoUUB8A8IB+U9fUoBo1CbIyBvY/K20mu7uC4f/3yr40id3R
         o/8WIPRhkg34ZDj8B5XR56aFnQYpPnXlAItSH4W6LwGpoFyS2Zn+24FYiexOVZEonzLr
         W2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:references
         :in-reply-to:user-agent:mime-version:content-transfer-encoding;
        bh=Dh7ytCWooIX35YNRESY2VG7oKkmeQTMTkqytRCSU7Qo=;
        b=nGPXi6sP0Ki+qSzOsJK8/7S15WveHmDxaBT6jkdUtb3SsCTXXtY768KRhTLi+aftZI
         wuQwtZehFZNGvuKpa+odUEkKXwjHHegxRj/ySy6HFrzTQKNCdzHC2xoN5Rd98jyfQ57R
         4MtKHPv/b1o+4Wl+EsXjGhvN1K4/Mnkz0QEEYBO/65fWykmJBvN/fjnaRrlg1PnxVKzT
         xSlYdxHjiOJcz3R+v6kPfW1I3BDVTuLjiFLnV48jhKJMai94VT5bUPI3WWTL9AfdGPK8
         67NKuTTH6WcrJbyDwYBU9X8u9LiTceJS9BT7v0euvKBJTJuAQjLn4ZIuAmWauIxEmF5z
         AltA==
X-Gm-Message-State: AOAM531GM8uJLwjDikcU2gjHq4hcL9EC5N9Emqob6m6GBKCqdvqmSnuP
        0nq1su1s+3RG1wRp48bCGVEg0+xiXnwh5eiV
X-Google-Smtp-Source: ABdhPJyzNxF1xL6rlGgbSWWh3ekinURLXh6JATjV77ZN4rQPw4Yi0mgCWc2hDnzWaohDxPyhNsQktg==
X-Received: by 2002:a5d:59a5:0:b0:218:3ffb:e6ea with SMTP id p5-20020a5d59a5000000b002183ffbe6eamr27273247wrr.715.1654870123989;
        Fri, 10 Jun 2022 07:08:43 -0700 (PDT)
Received: from CTHALPA.outer.uphall.net (cpc1-cmbg20-2-0-cust759.5-4.cable.virginm.net. [86.21.218.248])
        by smtp.gmail.com with ESMTPSA id q9-20020a5d6589000000b00219e758ff4fsm1914729wru.59.2022.06.10.07.08.42
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 10 Jun 2022 07:08:43 -0700 (PDT)
From:   John Cox <jc@kynesim.co.uk>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     =?utf-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org, nicolas.dufresne@collabora.com,
        andrzej.p@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Subject: Re: [PATCH v6 11/17] media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS control
Date:   Fri, 10 Jun 2022 15:08:42 +0100
Message-ID: <spj6ahd7nhjhi12nfvduliqomjpk1r6vlc@4ax.com>
References: <20220527143134.3360174-1-benjamin.gaignard@collabora.com> <20220527143134.3360174-12-benjamin.gaignard@collabora.com> <2102641.irdbgypaU6@kista> <c639efc2-2089-359d-44c6-e9d92e8fd22e@xs4all.nl> <c47b3218-069b-790e-8781-7b6d195ac8a7@xs4all.nl>
In-Reply-To: <c47b3218-069b-790e-8781-7b6d195ac8a7@xs4all.nl>
User-Agent: ForteAgent/8.00.32.1272
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 May 2022 15:49:57 +0200, you wrote:

>On 30/05/2022 11:18, Hans Verkuil wrote:
>> On 29/05/2022 08:40, Jernej =C5=A0krabec wrote:
>>> Hi!
>>>
>>> This series looks very good and I plan to test it shortly on Cedrus, =
but I=20
>>> have one major concern below.
>>>
>>> Dne petek, 27. maj 2022 ob 16:31:28 CEST je Benjamin Gaignard =
napisal(a):
>>>> The number of 'entry point offset' can be very variable.
>>>> Instead of using a large static array define a v4l2 dynamic array
>>>> of U32 (V4L2_CTRL_TYPE_U32).
>>>> The number of entry point offsets is reported by the elems field
>>>> and in struct v4l2_ctrl_hevc_slice_params.num_entry_point_offsets
>>>> field.
>>>
>>> Slice control by itself is variable length array, so you would =
actually need=20
>>> 2D variable array for entry points which is not supported. However, =
easy=20
>>> workaround for that is to flatten 2D array to 1D and either have =
another slice=20
>>> control field which would tell first entry point index for =
convenience or let=20
>>> driver calculate it by adding up all num_entry_point_offsets of =
previous=20
>>> slices.
>>>
>>> Hans, what do you think?
>>=20
>> If I would support 2D variable array sizes, wouldn't that be more =
elegant?
>>=20
>> The current implementation doesn't support that, but as the commit log=
 for
>> patch 1/17 says:
>>=20
>> "Currently dynamically sized arrays are limited to one dimensional =
arrays,
>> but that might change in the future if there is a need for it."
>>=20
>> Let me know if you agree, and I'll try to implement this. It's been a =
while
>> since I last looked at this, so I'm not sure how much work it is, but =
it is
>> probably worth a shot.
>
>Digging more into this made me realize that this doesn't actually help =
for this
>particular case.
>
>I would lean towards your second suggestion of adding up all =
num_entry_point_offsets
>of previous slices.

Whilst I don't personally need this array I also think that a 1-D array
is the correct answer here.  Any implementation that does need this info
is going to have to be going through the slice array and this array
together so adding the num_entry_point_offsets together is trivial.

Regards

John Cox

>Regards,
>
>	Hans
>
>>=20
>> Regards,
>>=20
>> 	Hans
>>=20
>>>
>>> Note, it seems that H265 decoding on Cedrus still works without entry=
 points,=20
>>> so this problem can be solved later. I'm not sure what we lose with =
that but=20
>>> it was suggested that this could influence speed or error resilience =
or both.=20
>>> However, I think we're close to solve it, so I'd like to do that now.
>>>
>>> Best regards,
>>> Jernej
>>>
>>>>
>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>>> ---
>>>>  .../userspace-api/media/v4l/ext-ctrls-codec.rst       | 11 =
+++++++++++
>>>>  drivers/media/v4l2-core/v4l2-ctrls-defs.c             |  5 +++++
>>>>  include/media/hevc-ctrls.h                            |  5 ++++-
>>>>  3 files changed, 20 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git =
a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/
>>> Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> index 0796b1563daa..05228e280f66 100644
>>>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
>>>> @@ -3010,6 +3010,9 @@ enum v4l2_mpeg_video_hevc_size_of_length_field=
 -
>>>>      * - __u32
>>>>        - ``data_bit_offset``
>>>>        - Offset (in bits) to the video data in the current slice =
data.
>>>> +    * - __u32
>>>> +      - ``num_entry_point_offsets``
>>>> +      - Specifies the number of entry point offset syntax elements =
in the=20
>>> slice header.
>>>>      * - __u8
>>>>        - ``nal_unit_type``
>>>>        - Specifies the coding type of the slice (B, P or I).
>>>> @@ -3150,6 +3153,14 @@ enum =
v4l2_mpeg_video_hevc_size_of_length_field -
>>>> =20
>>>>      \normalsize
>>>> =20
>>>> +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
>>>> +    Specifies entry point offsets in bytes.
>>>> +    This control is a dynamically sized array. The number of entry =
point
>>>> +    offsets is reported by the ``elems`` field.
>>>> +    This bitstream parameter is defined according to :ref:`hevc`.
>>>> +    They are described in section 7.4.7.1 "General slice segment =
header
>>>> +    semantics" of the specification.
>>>> +
>>>>  ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
>>>>      Specifies the HEVC scaling matrix parameters used for the =
scaling=20
>>> process
>>>>      for transform coefficients.
>>>> diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c =
b/drivers/media/v4l2-
>>> core/v4l2-ctrls-defs.c
>>>> index d594efbcbb93..e22921e7ea61 100644
>>>> --- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>> +++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
>>>> @@ -1188,6 +1188,7 @@ const char *v4l2_ctrl_get_name(u32 id)
>>>>  	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:		return=20
>>> "HEVC Decode Parameters";
>>>>  	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:		return=20
>>> "HEVC Decode Mode";
>>>>  	case V4L2_CID_STATELESS_HEVC_START_CODE:		return=20
>>> "HEVC Start Code";
>>>> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:	return=20
>>> "HEVC Entry Point Offsets";
>>>> =20
>>>>  	/* Colorimetry controls */
>>>>  	/* Keep the order of the 'case's the same as in v4l2-controls.h!=20
>>> */
>>>> @@ -1518,6 +1519,10 @@ void v4l2_ctrl_fill(u32 id, const char =
**name, enum=20
>>> v4l2_ctrl_type *type,
>>>>  	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
>>>>  		*type =3D V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS;
>>>>  		break;
>>>> +	case V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS:
>>>> +		*type =3D V4L2_CTRL_TYPE_U32;
>>>> +		*flags |=3D V4L2_CTRL_FLAG_DYNAMIC_ARRAY;
>>>> +		break;
>>>>  	case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:
>>>>  		*type =3D V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR;
>>>>  		break;
>>>> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
>>>> index a3c829ef531a..1319cb99ae3f 100644
>>>> --- a/include/media/hevc-ctrls.h
>>>> +++ b/include/media/hevc-ctrls.h
>>>> @@ -20,6 +20,7 @@
>>>>  #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_BASE=20
>>> + 1012)
>>>>  #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE + =
1015)
>>>>  #define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE + =
1016)
>>>> +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS =
(V4L2_CID_CODEC_BASE +=20
>>> 1017)
>>>> =20
>>>>  /* enum v4l2_ctrl_type type values */
>>>>  #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
>>>> @@ -318,6 +319,8 @@ struct v4l2_hevc_pred_weight_table {
>>>>   *
>>>>   * @bit_size: size (in bits) of the current slice data
>>>>   * @data_bit_offset: offset (in bits) to the video data in the =
current slice=20
>>> data
>>>> + * @num_entry_point_offsets: specifies the number of entry point =
offset syntax
>>>> + *			     elements in the slice header.
>>>>   * @nal_unit_type: specifies the coding type of the slice (B, P or =
I)
>>>>   * @nuh_temporal_id_plus1: minus 1 specifies a temporal identifier =
for the=20
>>> NAL unit
>>>>   * @slice_type: see V4L2_HEVC_SLICE_TYPE_{}
>>>> @@ -360,7 +363,7 @@ struct v4l2_hevc_pred_weight_table {
>>>>  struct v4l2_ctrl_hevc_slice_params {
>>>>  	__u32	bit_size;
>>>>  	__u32	data_bit_offset;
>>>> -
>>>> +	__u32	num_entry_point_offsets;
>>>>  	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
>>>>  	__u8	nal_unit_type;
>>>>  	__u8	nuh_temporal_id_plus1;
>>>> --=20
>>>> 2.32.0
>>>>
>>>>
>>>
>>>
>>=20
