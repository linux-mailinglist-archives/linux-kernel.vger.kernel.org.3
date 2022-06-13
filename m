Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A96549DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239477AbiFMTqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344732AbiFMTqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:46:39 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8980A3206B;
        Mon, 13 Jun 2022 11:17:31 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d14so8294463eda.12;
        Mon, 13 Jun 2022 11:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=04TdR76m0s+utzyAIg4+tjqhY/fa77Y2+5Qo2pJbp30=;
        b=ixWl1Vcyq/rsWbO+AUe8+lAesQZCwvLltHgldPMIDXk+HX3Fron25eAX1GOOayhNju
         QB4Vm0HqM0g863YOq74/eVmhyOIQFU0WHyqQH05WEwvIcAY+mNY/jSIU3eVsqbMabWu9
         oL4x4MzGDWWZtUH4s4sMqLny6+6kdPgW54q9TgYcOhbjpHNBlMtG0nFEHm1pGa4oaBr9
         Q25ZKshkRyBlLm/fNvnNf7IXWwTCm1yb06tfy5c2ZKLmddiKeBlWhOWNykaDyAKYvaLy
         5R9+9TC+eKDyCdpZ7tXT3iQ0B37ix1InWZ23I5NwFyMOV50aXR0Mie7q00IXkfQ0YHa3
         AvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=04TdR76m0s+utzyAIg4+tjqhY/fa77Y2+5Qo2pJbp30=;
        b=HoSnIqHFR9g1fv4fK4c2u2xJ76UE2b11vC3W5DIbizZjVl0c6ygDVaXF6EqhypMOgo
         M+m5oTBiu8Xw9p4XmyWk2Vjkrv3X7C6ALmOihf7azdqHRGo/nTRiNj3IZNxjfMBj0Jch
         3prnUQA3REODAQfFk51a8QiehfAYQR3tyozMn+eKrtRZThvlZLvTB3OdoAyjEyVR2dGf
         jU3UvnXNMvG0xVS6vzDOPndiIfAfz0lUf5src4lL9Ft5vvhT6oU+kq1Tc3IV5H2Jclov
         ubpMehgUIvh6JVkNvfbkvc3MdWinjGGscWhUFXx89EfqPPQgsKeR1MF+zNB4WTexkPLM
         Wd1Q==
X-Gm-Message-State: AOAM530SqBy8USJx/b8zpBGlyvE0fHqhI6CReIkjuvFipawj+Q5r/5dh
        yeS1KDO27DRNloC+1Y6Pv74=
X-Google-Smtp-Source: ABdhPJyJfjpFJHiSXK9jnFkPNEEH+e/FB0EhCEk05XpAU9FqMrJeJbdJzkSOyRGzo5XaqodpkvLzug==
X-Received: by 2002:a05:6402:e88:b0:434:d7de:8d0b with SMTP id h8-20020a0564020e8800b00434d7de8d0bmr1151160eda.149.1655144250007;
        Mon, 13 Jun 2022 11:17:30 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id x24-20020aa7dad8000000b0042dd482d0c4sm5393678eds.80.2022.06.13.11.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 11:17:29 -0700 (PDT)
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
Subject: Re: Re: Re: [PATCH v6 16/17] media: uapi: Change data_bit_offset definition
Date:   Mon, 13 Jun 2022 20:17:27 +0200
Message-ID: <3180718.44csPzL39Z@kista>
In-Reply-To: <11997092.O9o76ZdvQC@kista>
References: <20220527143134.3360174-1-benjamin.gaignard@collabora.com> <c330e3e1-e10c-5930-2d1d-6260cb8d64b8@collabora.com> <11997092.O9o76ZdvQC@kista>
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

Dne nedelja, 12. junij 2022 ob 22:40:29 CEST je Jernej =C5=A0krabec napisal=
(a):
> Dne sreda, 01. junij 2022 ob 18:33:22 CEST je Benjamin Gaignard napisal(a=
):
> >=20
> > Le 01/06/2022 =C3=A0 18:17, Jernej =C5=A0krabec a =C3=A9crit :
> > > Dne nedelja, 29. maj 2022 ob 08:45:57 CEST je Jernej =C5=A0krabec nap=
isal(a):
> > >> Dne petek, 27. maj 2022 ob 16:31:33 CEST je Benjamin Gaignard=20
napisal(a):
> > >>> 'F.7.3.6.1 General slice segment header syntax' section of HEVC
> > >>> specification describes that a slice header always end aligned on
> > >>> byte boundary, therefore we only need to provide the data offset in=
=20
> bytes.
> > >>>
> > >>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > >>> ---
> > >>>   Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 4 ++--
> > >>>   drivers/staging/media/sunxi/cedrus/cedrus_h265.c          | 2 +-
> > >>>   include/media/hevc-ctrls.h                                | 4 ++--
> > >>>   3 files changed, 5 insertions(+), 5 deletions(-)
> > >>>
> > >>> diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.=
rst=20
b/
> > >> Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > >>> index 48a8825a001b..37079581c661 100644
> > >>> --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > >>> +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > >>> @@ -3008,8 +3008,8 @@ enum v4l2_mpeg_video_hevc_size_of_length_fiel=
d -
> > >>>         - ``bit_size``
> > >>>         - Size (in bits) of the current slice data.
> > >>>       * - __u32
> > >>> -      - ``data_bit_offset``
> > >>> -      - Offset (in bits) to the video data in the current slice da=
ta.
> > >>> +      - ``data_byte_offset``
> > >>> +      - Offset (in bytes) to the video data in the current slice d=
ata.
> > >>>       * - __u32
> > >>>         - ``num_entry_point_offsets``
> > >>>         - Specifies the number of entry point offset syntax element=
s in=20
> the
> > >> slice header.
> > >>> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/
drivers/
> > >> staging/media/sunxi/cedrus/cedrus_h265.c
> > >>> index 411601975124..835454239f73 100644
> > >>> --- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > >>> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
> > >>> @@ -405,7 +405,7 @@ static void cedrus_h265_setup(struct cedrus_ctx=
=20
> *ctx,
> > >>>   	/* Initialize bitstream access. */
> > >>>   	cedrus_write(dev, VE_DEC_H265_TRIGGER,
> > >> VE_DEC_H265_TRIGGER_INIT_SWDEC);
> > >>>  =20
> > >>> -	cedrus_h265_skip_bits(dev, slice_params->data_bit_offset);
> > >>> +	cedrus_h265_skip_bits(dev, slice_params->data_byte_offset * 8);
> > >> While it's true that actual data starts on 8-bit aligned address,=20
Cedrus=20
> for
> > >> some reason needs offset which points at the end of the header, befo=
re
> > >> alignment. There is very simple way to determine that, but=20
unfortunately
> > > this
> > >> means reading source buffer.
> > >>
> > >> In short, above code won't work. I'll provide a fix.
> > > Please include following fix http://ix.io/3Z8x otherwise Cedrus will =
fail=20
> to
> > > decode slice.
>=20
> Fluster testing show that this patch isn't completely fine. I also have s=
ome=20
> other issues, which need control values comparisons. It would be best, if=
=20
you=20
> can wait until I finish comparison. Old, hackish HEVC patches have high=20
fluster=20
> score whereas new, based on stable uAPI, has low and CPU also locks up...

=46urther testing showed that I make a mistake in ffmpeg code. uAPI and sug=
gested=20
changes are fine. It's gtg.

Sorry for the false alarm!
=20
Best regards,
Jernej

>=20
> > >
> > > Other than fix in previous e-mail and this one, code looks good and I=
'll=20
be
> > > able to add missing functionality to Cedrus without much trouble in=20
follow=20
> up
> > > series.
> >=20
> > Thanks for the patch it will be in version 7.
> >=20
> > Regards,
> > Benjamin
> >=20
> > >
> > > Best regards,
> > > Jernej
> > >
> > >>>  =20
> > >>>   	/* Bitstream parameters. */
> > >>>  =20
> > >>> diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> > >>> index 9abca1a75bd4..936ff693967b 100644
> > >>> --- a/include/media/hevc-ctrls.h
> > >>> +++ b/include/media/hevc-ctrls.h
> > >>> @@ -312,7 +312,7 @@ struct v4l2_hevc_pred_weight_table {
> > >>>    * V4L2_CTRL_FLAG_DYNAMIC_ARRAY flag must be set when using it.
> > >>>    *
> > >>>    * @bit_size: size (in bits) of the current slice data
> > >>> - * @data_bit_offset: offset (in bits) to the video data in the cur=
rent
> > > slice
> > >> data
> > >>> + * @data_byte_offset: offset (in bytes) to the video data in the=20
current
> > >> slice data
> > >>>    * @num_entry_point_offsets: specifies the number of entry point =
offset
> > > syntax
> > >>>    *			     elements in the slice header.
> > >>>    * @nal_unit_type: specifies the coding type of the slice (B, P o=
r I)
> > >>> @@ -356,7 +356,7 @@ struct v4l2_hevc_pred_weight_table {
> > >>>    */
> > >>>   struct v4l2_ctrl_hevc_slice_params {
> > >>>   	__u32	bit_size;
> > >>> -	__u32	data_bit_offset;
> > >>> +	__u32	data_byte_offset;
> > >>>   	__u32	num_entry_point_offsets;
> > >>>   	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
> > >>>   	__u8	nal_unit_type;
> > >>> --=20
> > >>> 2.32.0
> > >>>
> > >>>
> > >>
> > >>
> > >
> >=20
>=20
>=20
>=20


