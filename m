Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFEC4B5ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 21:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiBNUNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 15:13:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiBNUNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 15:13:33 -0500
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC92124C0B;
        Mon, 14 Feb 2022 12:13:15 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id w6so3730182ljj.3;
        Mon, 14 Feb 2022 12:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wqUSZ1SFW0NVtpHilGjkTlF5P0e9ASySJ2SjHGW0nSw=;
        b=YIAQ1zoMH5dWivilhSnkKSw0ctqFeyghOXilT5ojvzNBk2EnLfoQon/bgeqsc8Km3W
         6jHN8k5Qeo7Fx15/trIUSKneHxu3rvCGNVAeQq65RusjDPnbBoETVPHcwtFvTIrA9oTL
         W/1oHNmeG3qOagVgIrpPbpoOncfvapoLBbkUkYCbaV0AjaEoQ2WM90rJFgzIDkubPIXN
         CY0rrLYo/vUGTjnHCd4JqzoYCfeLnKJHI13nGfqtGcEMuhWlSsv4iatlUtvk4K0c1cD0
         BGzncRcWz/ZswZJ/H44Qfmhwy+7Vzhh9X9USEhblozjd6Z3Z9SQFikB/rS/bIqZX4gPU
         N0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wqUSZ1SFW0NVtpHilGjkTlF5P0e9ASySJ2SjHGW0nSw=;
        b=hrI/up3TLm8gtieHD9m/w5c8W446xrswfsC56Fq/SOwf5Pu4hbyKiyO5E9162gr6r3
         fZOfV0ocOA7nqXEAs+EW4m1mtPQsKygdqtIh95UiZASRW8F4jipotXgEEC48O26+wTD2
         3cSzOI7bhlnD5ePWNAQe0XUGKTwKRTPhku+k54AR1ENOEk6RFrkAyAg+PYWu0vWiw8XA
         yo6WBQujGAwl2BXwBe3g90U2ELLWU0PEY6yXkG2QI8bdeZWs+cfH07ls7IYdWZGU2ul0
         5mkxklTERniW4mcwqgw7T4mGQRPD3YqoPOR4WlvmV6wGid5ERzmcWi4vrBxVJXITwG3d
         3g5Q==
X-Gm-Message-State: AOAM532HiT9PxONK77XODJm1n3oPlkTjHoZMLXeumXlaE/gxEu7JWmMg
        Hzg9Rq63LSewEfaEqoTCh35kHCP0xMmzfA==
X-Google-Smtp-Source: ABdhPJwYjRppPFpB8UmNIkcxwOS9n2u16iELvDzGqpJ83lEytB+M9F4emEDKG8XNnA9Ps3JOsWEvHg==
X-Received: by 2002:a17:907:c15:: with SMTP id ga21mr263554ejc.80.1644866797427;
        Mon, 14 Feb 2022 11:26:37 -0800 (PST)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id 17sm2683352eja.57.2022.02.14.11.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 11:26:36 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        hverkuil-cisco@xs4all.nl, jonas@kwiboo.se, nicolas@ndufresne.ca,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, Alex Bee <knaerzche@gmail.com>,
        jc@kynesim.co.uk
Subject: Re: Re: [RFC] media: uapi: Move HEVC stateless controls out of staging
Date:   Mon, 14 Feb 2022 20:26:34 +0100
Message-ID: <2302767.NG923GbCHz@kista>
In-Reply-To: <903ca214-9576-33aa-8412-7c71c9d8ac09@collabora.com>
References: <20220201123439.353854-1-benjamin.gaignard@collabora.com> <8038233.T7Z3S40VBb@kista> <903ca214-9576-33aa-8412-7c71c9d8ac09@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 14. februar 2022 ob 18:25:01 CET je Benjamin Gaignard=20
napisal(a):
>=20
> Le 13/02/2022 =C3=A0 12:33, Jernej =C5=A0krabec a =C3=A9crit :
> > Hi Benjamin,
> >
> > CC: Alex, John
> >
> > Sorry for late response, but I've been very busy last week.
> >
> > First of all, thank you for doing this! It's about time that HEVC moves
> > forward.
> >
> > Dne torek, 01. februar 2022 ob 13:34:39 CET je Benjamin Gaignard=20
napisal(a):
> >> The HEVC stateless 'uAPI' was staging and marked explicitly in the
> >> V4L2 specification that it will change and is unstable.
> >>
> >> Note that these control IDs were never exported as a public API,
> >> they were only defined in kernel-local headers (hevc-ctrls.h).
> >>
> >> While moving the controls out of staging they are renamed and
> >> control IDs get new numbers.
> >> Drivers (Hantro, Cedrus) and Documentation are updated accordaly.
> > accordaly -> accordingly
> >
> >> Additional structures fields has been added for RKVDEC driver usage.
> > You should do separate patch for that, preceding this one. One patch=20
should
> > only do one thing.
>=20
> I will do that in v2
>=20
> >
> > I also suggest that you add additional patch for removing bit_size fiel=
d in
> > struct v4l2_ctrl_hevc_slice_params. Similar fields were already removed=
=20
from
> > MPEG2 and H264 structures. Bit size can be deduced from output buffer s=
ize=20
and
> > it doesn't hurt if bit size in Cedrus is set to bigger value than actua=
l=20
slice
> > bit size.
>=20
> ok
>=20
> >
> >> Hantro dedicated control is moving to hantro-media.h
> >> Since hevc-ctrls.h content has been dispatched in others file, remove =
it.
> >>
> >> fluster tests results on IMX8MQ is 77/147 for HEVC codec.
> >>
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > Note that Cedrus still needs additional information in order to decode=
=20
some
> > HEVC videos. Missing info is num_entry_point_offsets and list of all
> > entry_point_offset_minus1 (obviously, num_entry_point_offsets in size).
> >
> > I suggest that this is represented in a new control, which would use=20
dynamic
> > array feature, written by Hans. While Cedrus supports max. 256 entries,=
 it=20
can
> > be much bigger in theory, but in reality, it's much smaller (like 4-8
> > entries).
>=20
> I haven't seen yet any user for these fields but I will create a new cont=
rol=20
like
> #define V4L2_CID_STATELESS_HEVC_ENTRY_POINT	(V4L2_CID_CODEC_STATELESS_BAS=
E +=20
407)
>=20
> struct v4l2_ctrl_hevc_entry_point_offset {
> 	__u32	entry_point_offset_minus1;
> };

Yeah, Cedrus is currently the only mainline driver that needs that in order=
 to=20
fully work. I think John used num_entry_point_offsets in his (out of tree) =
RPi=20
HEVC decoding driver too.

Wouldn't be easier to just use u32 directly? This is just array of numbers,=
 so=20
nothing else will be added in that struct...

Anyway, once you add this, I'll quickly update driver to take advantage of =
it.

>=20
> and add it in the documentation:
> ``V4L2_CID_STATELESS_HEVC_ENTRY_POINT (struct)``
>      Specifies the i-th entry point offset in bytes and is represented by
>      offset_len_minus1 plus 1 bits.
>      This control is a dynamically sized array. The number of entry point
>      offsets is reported by the ``elems`` field.
>      This bitstream parameter is defined according to :ref:`hevc`.
>      They are described in section 7.4.7.1 "General slice segment header
>      semantics" of the specification.
>=20
> >
> > Last but not least, data_bit_offset should be better defined. Currently=
 it
> > points right after last header bit, just like Cedrus needs it. However,=
=20
there
> > is padding after that, at least 1 bit and 8 bits at most, so slice data=
=20
always
> > starts from byte aligned address. It probably make sense to rework that=
=20
field
> > to be byte offset, not bit, just like in VA-API. Note that RPi HEVC dri=
ver=20
also
> > uses byte aligned address directly. Cedrus would need some kind of=20
workaround
> > and only one that works is this one:
> > https://github.com/bootlin/libva-v4l2-request/blob/master/src/h265.c#L1=
91-L209
>=20
> If Cedrus driver is happy with this definition I will keep it like that.
> When providing offset in bit is more accurate and any driver can align th=
e=20
value
> if needed, the reverse (byte -> bit) isn't possible.

If I'm not mistaken, HEVC standard actually requires that slice data starts=
 at=20
byte aligned address, so nothing would be lost for correctness of uAPI.

I already had this discussion with John and IIRC conclusion was to have byt=
e=20
aligned value here. John, can you please confirm if my interpretation is=20
correct?

Best regards,
Jernej

>=20
> Regards,
> Benjamin
>=20
> >
> > Best regards,
> > Jernej
> >
> >
>=20


