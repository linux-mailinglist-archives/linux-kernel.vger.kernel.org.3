Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DB9547C03
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 22:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbiFLUkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 16:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbiFLUke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 16:40:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9C13EB92;
        Sun, 12 Jun 2022 13:40:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id h23so7497693ejj.12;
        Sun, 12 Jun 2022 13:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2jytHVm8ZuiwCARiy/dgP+cTcJmeud+YGOQOnyEwcxA=;
        b=GpY4ALNkJzEvUaHFW/O5CIpcZsTIXpDVZP49i7FVo8bGurcfZHFS9t7IT8KP9iu1Cc
         2oqJhTvsTHDyd7l5Y25IjiUe1oyaPBnKpQHELKvVywXrIU5eGWBZe15fDoHYrvmhnG1r
         7Rkga5RTqsYOL2tbtR0CL3PZ/ov0mJVD6UyCE8YyoDy11C8yfY01RFCM6sObulEkEPEl
         qvxRj4HiZxCrYp+Lpq/z3uE1v2/U8f0rHdG17VoMn1SmqKkLKBKKGrDXgjfHQR8K+wrO
         AOm65KD4tdozQl1dd+ICTBWfvRbwPAG60k800Nt7fIdHIex/14wPtFgE0MFhZXBEmQA0
         ovpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2jytHVm8ZuiwCARiy/dgP+cTcJmeud+YGOQOnyEwcxA=;
        b=Ps+Xix7hJ0dfO8B7UqgSHIrba9JxqPZHiG9W3kK/nvK0QiOgl9ftjtVkEu33SJv2l2
         crIy6twYc3c5cO/hh3BTUv7SKMMozkhUb1Byh8W1xF5M+w7l+rfDXOYu5+tijX6uctBM
         XnS5O5pbH4qx0aeNKtmJzXFgoZjykSsYjA3wxEQYKwYJ0h9I7q4vRqhihicLXDjHjfZ6
         TA1PzziQLXHuWDtzTCOTO+II44X/mcCq7bbwWltry57rHrsUBrQm464C1rPmjU0CrgId
         a2hFthIwDBtUlUyiHP/aBPhkecTzXLrfOkR9hqOSQamGaZPAGV3u7M/jq8SHeEI0N0FL
         1uZA==
X-Gm-Message-State: AOAM531pMDn5sdVcdK930iF7x8wJYQi3lWzhXiiUZ7bt//YvqUd+b9ob
        qIeuzSPpUUEUv6EtvXrQ91k=
X-Google-Smtp-Source: ABdhPJyZMq8l4+8JswvBLfHVqVHIy5eA61rvmP1XRt/vBtLQl8KZ0Q089dGMem6tMX5+in5sWOeZkg==
X-Received: by 2002:a17:907:971f:b0:6ff:2d30:4b37 with SMTP id jg31-20020a170907971f00b006ff2d304b37mr49917948ejc.7.1655066431322;
        Sun, 12 Jun 2022 13:40:31 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id b10-20020a170906d10a00b006f4c557b7d2sm2853979ejz.203.2022.06.12.13.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 13:40:30 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, hverkuil@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, mripard@kernel.org,
        paul.kocialkowski@bootlin.com, wens@csie.org, samuel@sholland.org,
        nicolas.dufresne@collabora.com, andrzej.p@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com
Subject: Re: Re: [PATCH v6 16/17] media: uapi: Change data_bit_offset definition
Date:   Sun, 12 Jun 2022 22:40:29 +0200
Message-ID: <11997092.O9o76ZdvQC@kista>
In-Reply-To: <c330e3e1-e10c-5930-2d1d-6260cb8d64b8@collabora.com>
References: <20220527143134.3360174-1-benjamin.gaignard@collabora.com> <7385576.EvYhyI6sBW@kista> <c330e3e1-e10c-5930-2d1d-6260cb8d64b8@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 01. junij 2022 ob 18:33:22 CEST je Benjamin Gaignard napisal(a):
>=20
> Le 01/06/2022 =C3=A0 18:17, Jernej =C5=A0krabec a =C3=A9crit :
> > Dne nedelja, 29. maj 2022 ob 08:45:57 CEST je Jernej =C5=A0krabec napis=
al(a):
> >> Dne petek, 27. maj 2022 ob 16:31:33 CEST je Benjamin Gaignard napisal(=
a):
> >>> 'F.7.3.6.1 General slice segment header syntax' section of HEVC
> >>> specification describes that a slice header always end aligned on
> >>> byte boundary, therefore we only need to provide the data offset in=20
bytes.
> >>>
> >>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >>> ---
> >>>   Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 4 ++--
> >>>   drivers/staging/media/sunxi/cedrus/cedrus_h265.c          | 2 +-
> >>>   include/media/hevc-ctrls.h                                | 4 ++--
> >>>   3 files changed, 5 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rs=
t b/
> >> Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> >>> index 48a8825a001b..37079581c661 100644
> >>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> >>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> >>> @@ -3008,8 +3008,8 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
> >>>         - ``bit_size``
> >>>         - Size (in bits) of the current slice data.
> >>>       * - __u32
> >>> -      - ``data_bit_offset``
> >>> -      - Offset (in bits) to the video data in the current slice data.
> >>> +      - ``data_byte_offset``
> >>> +      - Offset (in bytes) to the video data in the current slice dat=
a.
> >>>       * - __u32
> >>>         - ``num_entry_point_offsets``
> >>>         - Specifies the number of entry point offset syntax elements =
in=20
the
> >> slice header.
> >>> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drive=
rs/
> >> staging/media/sunxi/cedrus/cedrus_h265.c
> >>> index 411601975124..835454239f73 100644
> >>> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> >>> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> >>> @@ -405,7 +405,7 @@ static void cedrus_h265_setup(struct cedrus_ctx=20
*ctx,
> >>>   	/* Initialize bitstream access. */
> >>>   	cedrus_write(dev, VE_DEC_H265_TRIGGER,
> >> VE_DEC_H265_TRIGGER_INIT_SWDEC);
> >>>  =20
> >>> -	cedrus_h265_skip_bits(dev, slice_params->data_bit_offset);
> >>> +	cedrus_h265_skip_bits(dev, slice_params->data_byte_offset * 8);
> >> While it's true that actual data starts on 8-bit aligned address, Cedr=
us=20
for
> >> some reason needs offset which points at the end of the header, before
> >> alignment. There is very simple way to determine that, but unfortunate=
ly
> > this
> >> means reading source buffer.
> >>
> >> In short, above code won't work. I'll provide a fix.
> > Please include following fix http://ix.io/3Z8x otherwise Cedrus will fa=
il=20
to
> > decode slice.

=46luster testing show that this patch isn't completely fine. I also have s=
ome=20
other issues, which need control values comparisons. It would be best, if y=
ou=20
can wait until I finish comparison. Old, hackish HEVC patches have high flu=
ster=20
score whereas new, based on stable uAPI, has low and CPU also locks up...

Best regards,
Jernej

> >
> > Other than fix in previous e-mail and this one, code looks good and I'l=
l be
> > able to add missing functionality to Cedrus without much trouble in fol=
low=20
up
> > series.
>=20
> Thanks for the patch it will be in version 7.
>=20
> Regards,
> Benjamin
>=20
> >
> > Best regards,
> > Jernej
> >
> >>>  =20
> >>>   	/* Bitstream parameters. */
> >>>  =20
> >>> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> >>> index 9abca1a75bd4..936ff693967b 100644
> >>> --- a/include/media/hevc-ctrls.h
> >>> +++ b/include/media/hevc-ctrls.h
> >>> @@ -312,7 +312,7 @@ struct v4l2_hevc_pred_weight_table {
> >>>    * V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
> >>>    *
> >>>    * @bit_size: size (in bits) of the current slice data
> >>> - * @data_bit_offset: offset (in bits) to the video data in the curre=
nt
> > slice
> >> data
> >>> + * @data_byte_offset: offset (in bytes) to the video data in the cur=
rent
> >> slice data
> >>>    * @num_entry_point_offsets: specifies the number of entry point of=
fset
> > syntax
> >>>    *			     elements in the slice header.
> >>>    * @nal_unit_type: specifies the coding type of the slice (B, P or =
I)
> >>> @@ -356,7 +356,7 @@ struct v4l2_hevc_pred_weight_table {
> >>>    */
> >>>   struct v4l2_ctrl_hevc_slice_params {
> >>>   	__u32	bit_size;
> >>> -	__u32	data_bit_offset;
> >>> +	__u32	data_byte_offset;
> >>>   	__u32	num_entry_point_offsets;
> >>>   	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
> >>>   	__u8	nal_unit_type;
> >>> --=20
> >>> 2.32.0
> >>>
> >>>
> >>
> >>
> >
>=20


