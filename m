Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E504B6F41
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbiBOOhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:37:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiBOOhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:37:36 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918E710240A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:37:25 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j26so21634522wrb.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 06:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kynesim-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:references:in-reply-to
         :user-agent:mime-version:content-transfer-encoding;
        bh=fZmC+HY/NERZ64nERPlfEbLwH9AjnO7ggXig3TE1Gc8=;
        b=Qj2qpCSfkhbPBWQTHtAZIMKeJ984f4D6882j0JpPIklZeSxaRqHwjnrTD73gc1CZJD
         KGzFW+2NyR97PRKCnCHjse02/dOCt3xMGFqghJyy98+QlE2CMn3r+8PUq8rNPZAZYc83
         cJUx1CBNgFyFn43eMUEkQcuL9jfdtkmgV4EnzxrrGyXNB765T3PIf9SVfv/+rZTnlRS2
         H/RIfOuy0V0xiF291lUt+T+sWYapwCjMBZ+M4F0yF8Eo/GXTDRUsX6giwv0U/z7XXWzG
         i1fM6qlcF9D1CVVFYOb/IIVsPYIUPuAHQ8UMqqlUOsj+uQeyO6CLLgULF6dWRMiUau1R
         Mohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:references
         :in-reply-to:user-agent:mime-version:content-transfer-encoding;
        bh=fZmC+HY/NERZ64nERPlfEbLwH9AjnO7ggXig3TE1Gc8=;
        b=XClbklQm+fWPT2FbadZ6UA4U/QBEQ+eXbb0UmvTe6jk2pmPAliSbvxUJZUbwXFyMVj
         /gLKu2s9HXHHPrBICnuM4YJYkhLtOHIkq9cUf+xqv6Ht08EzmtiQ5eqUC/g2MrCqUTs6
         GSbtZieYBvomzGNi0sP6uu/nf9WL+rkeVJlVWh8r3rCh3Nd/+ATolnsXg4jJiE+Gml5x
         hFuSTyFOhvucLB1bvbA4FFZBumoS4SlzLcQVRBpY1rp0qbCtW5NL+lmLa6Vc2YXZ1q3P
         0oBE7fAtkN7u0wBGleAPf0FcfAOfe7+0xMteLgMf5jN4QW9hcmTf1zV2uKKRa368goRN
         iNeg==
X-Gm-Message-State: AOAM532kqVjIYgR7Wkkad0h+jwhdxcqciIrC9uyclcVTZYPxF6h7R/qU
        0SXhNM6UMxODTKM/bYfC4E1YQw==
X-Google-Smtp-Source: ABdhPJxGCHdyCAjm5ICWC8z8D1pHSpeqlAzG3GZGPGWRG/PZjZfte4/5dN0MF6akx9+OgP8T6TTm6g==
X-Received: by 2002:a5d:4682:: with SMTP id u2mr3636235wrq.10.1644935844140;
        Tue, 15 Feb 2022 06:37:24 -0800 (PST)
Received: from CTHALPA.outer.uphall.net (cpc1-cmbg20-2-0-cust759.5-4.cable.virginm.net. [86.21.218.248])
        by smtp.gmail.com with ESMTPSA id m22sm6289769wmq.35.2022.02.15.06.37.21
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 15 Feb 2022 06:37:22 -0800 (PST)
From:   John Cox <jc@kynesim.co.uk>
To:     =?utf-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        hverkuil-cisco@xs4all.nl, jonas@kwiboo.se, nicolas@ndufresne.ca,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, Alex Bee <knaerzche@gmail.com>
Subject: Re: [RFC] media: uapi: Move HEVC stateless controls out of staging
Date:   Tue, 15 Feb 2022 14:37:21 +0000
Message-ID: <andn0h1pjhbkuaejphce535gm6u8ptae8v@4ax.com>
References: <20220201123439.353854-1-benjamin.gaignard@collabora.com> <8038233.T7Z3S40VBb@kista> <903ca214-9576-33aa-8412-7c71c9d8ac09@collabora.com> <2302767.NG923GbCHz@kista>
In-Reply-To: <2302767.NG923GbCHz@kista>
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

On Mon, 14 Feb 2022 20:26:34 +0100, you wrote:

>Dne ponedeljek, 14. februar 2022 ob 18:25:01 CET je Benjamin Gaignard=20
>napisal(a):
>>=20
>> Le 13/02/2022 =C3=A0 12:33, Jernej =C5=A0krabec a =C3=A9crit :
>> > Hi Benjamin,
>> >
>> > CC: Alex, John
>> >
>> > Sorry for late response, but I've been very busy last week.
>> >
>> > First of all, thank you for doing this! It's about time that HEVC =
moves
>> > forward.
>> >
>> > Dne torek, 01. februar 2022 ob 13:34:39 CET je Benjamin Gaignard=20
>napisal(a):
>> >> The HEVC stateless 'uAPI' was staging and marked explicitly in the
>> >> V4L2 specification that it will change and is unstable.
>> >>
>> >> Note that these control IDs were never exported as a public API,
>> >> they were only defined in kernel-local headers (hevc-ctrls.h).
>> >>
>> >> While moving the controls out of staging they are renamed and
>> >> control IDs get new numbers.
>> >> Drivers (Hantro, Cedrus) and Documentation are updated accordaly.
>> > accordaly -> accordingly
>> >
>> >> Additional structures fields has been added for RKVDEC driver =
usage.
>> > You should do separate patch for that, preceding this one. One patch=
=20
>should
>> > only do one thing.
>>=20
>> I will do that in v2
>>=20
>> >
>> > I also suggest that you add additional patch for removing bit_size =
field in
>> > struct v4l2_ctrl_hevc_slice_params. Similar fields were already =
removed=20
>from
>> > MPEG2 and H264 structures. Bit size can be deduced from output =
buffer size=20
>and
>> > it doesn't hurt if bit size in Cedrus is set to bigger value than =
actual=20
>slice
>> > bit size.
>>=20
>> ok
>>=20
>> >
>> >> Hantro dedicated control is moving to hantro-media.h
>> >> Since hevc-ctrls.h content has been dispatched in others file, =
remove it.
>> >>
>> >> fluster tests results on IMX8MQ is 77/147 for HEVC codec.
>> >>
>> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> > Note that Cedrus still needs additional information in order to =
decode=20
>some
>> > HEVC videos. Missing info is num_entry_point_offsets and list of all
>> > entry_point_offset_minus1 (obviously, num_entry_point_offsets in =
size).
>> >
>> > I suggest that this is represented in a new control, which would use=
=20
>dynamic
>> > array feature, written by Hans. While Cedrus supports max. 256 =
entries, it=20
>can
>> > be much bigger in theory, but in reality, it's much smaller (like =
4-8
>> > entries).
>>=20
>> I haven't seen yet any user for these fields but I will create a new =
control=20
>like
>> #define V4L2_CID_STATELESS_HEVC_ENTRY_POINT	=
(V4L2_CID_CODEC_STATELESS_BASE +=20
>407)
>>=20
>> struct v4l2_ctrl_hevc_entry_point_offset {
>> 	__u32	entry_point_offset_minus1;
>> };

Can we tell if this control is needed from userland? There's no great
point in filling it in if the driver isn't going to use it.

>Yeah, Cedrus is currently the only mainline driver that needs that in =
order to=20
>fully work. I think John used num_entry_point_offsets in his (out of =
tree) RPi=20
>HEVC decoding driver too.

num_entry_points is a useful field  (in the slice header preferably) for
the RPi hardware as whilst it doesn't need to know the offsets it does
need to construct a table with one entry per offset (for cabac state
purposes) so it needs to know how many there are. It is possible to
infer the number from the slice_segment address in the next slice header
but that involves keeping around more state from one request to the
next.

>Wouldn't be easier to just use u32 directly? This is just array of =
numbers, so=20
>nothing else will be added in that struct...
>
>Anyway, once you add this, I'll quickly update driver to take advantage =
of it.
>
>>=20
>> and add it in the documentation:
>> ``V4L2_CID_STATELESS_HEVC_ENTRY_POINT (struct)``
>>      Specifies the i-th entry point offset in bytes and is represented=
 by
>>      offset_len_minus1 plus 1 bits.
>>      This control is a dynamically sized array. The number of entry =
point
>>      offsets is reported by the ``elems`` field.
>>      This bitstream parameter is defined according to :ref:`hevc`.
>>      They are described in section 7.4.7.1 "General slice segment =
header
>>      semantics" of the specification.
>>=20
>> >
>> > Last but not least, data_bit_offset should be better defined. =
Currently it
>> > points right after last header bit, just like Cedrus needs it. =
However,=20
>there
>> > is padding after that, at least 1 bit and 8 bits at most, so slice =
data=20
>always
>> > starts from byte aligned address. It probably make sense to rework =
that=20
>field
>> > to be byte offset, not bit, just like in VA-API. Note that RPi HEVC =
driver=20
>also
>> > uses byte aligned address directly. Cedrus would need some kind of=20
>workaround
>> > and only one that works is this one:
>> > =
https://github.com/bootlin/libva-v4l2-request/blob/master/src/h265.c#L191=
-L209
>>=20
>> If Cedrus driver is happy with this definition I will keep it like =
that.
>> When providing offset in bit is more accurate and any driver can align=
 the=20
>value
>> if needed, the reverse (byte -> bit) isn't possible.
>
>If I'm not mistaken, HEVC standard actually requires that slice data =
starts at=20
>byte aligned address, so nothing would be lost for correctness of uAPI.
>
>I already had this discussion with John and IIRC conclusion was to have =
byte=20
>aligned value here. John, can you please confirm if my interpretation is=
=20
>correct?

Yes slice_segment_data only occurs afer slice_segment_header (7.3.6.1)
and that ends with byte_alignment().

Regards

John Cox

>Best regards,
>Jernej
>
>>=20
>> Regards,
>> Benjamin
>>=20
>> >
>> > Best regards,
>> > Jernej
>> >
>> >
>>=20
>
