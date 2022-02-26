Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8014C5734
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 18:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbiBZSAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiBZR76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 12:59:58 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C049140C9;
        Sat, 26 Feb 2022 09:59:22 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id n25-20020a05600c3b9900b00380f41e51e6so3593773wms.2;
        Sat, 26 Feb 2022 09:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9V9Jct16AZTz4K2DeDR/xCDxmdE9Vl1rLYHKFySR8Q8=;
        b=OS5rKUhE7WXuiZzAYW7cwzYiV8SBfaes2cbt2tE8S+TsEw1AJJ/EtauXm86t/sGGOk
         6Gtznw8XzXomN2E/jJX1Ab/F4luPeUHfombr9N4K93wAUclK1Q5xLFFAlq8pEUfN/85P
         nPPov3wToi44wYltDMShEha7ixTIYA0kQadq5sw8EiEUEo5T+zhVbzoouPd8RuNibsNc
         vjFiFWeAb1mlzc9ubE77Lg4FPwakw78ykg0kXAEL06cUaWCdknrUlqstev+v2hqB4Zvb
         eZG3EyajjZ2e4Y+1Akl3IqfS7qbDc7pvcencVFz3EUr+Kn+9K/kb4i0buxEI2YwpKCR9
         ZWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9V9Jct16AZTz4K2DeDR/xCDxmdE9Vl1rLYHKFySR8Q8=;
        b=cUECq/T4PFbb2QswJGm7U8b3JDcHvQW02cNiwh5tG1/qR+2TIyFueQmijiD/RCP0s+
         aZYNow0+dslgY/N64L2Wg5Sn/oatrQCc+WZoYAGiBWxUMTuLxhHZbn7buDL4mwWYNwF6
         5OxCB061+np1aZNZlZmpMC44x2d6pzB7VOMQnRY0QsFRxFNSw/k8/oQ1rzEVbHjRYQNT
         nuCsPEp/+elIDmPvCYDZYsCTpQUYeDvIRl7Aan9FFLOg2y5zCH5sIORLkFvjJTc03JeY
         id1yliYey2n1S0hg9P2OKo9H7NRLGwsvLMJQPEY8EuFqnxEz8CqyhA/WG6uxM0p47tfr
         1wGw==
X-Gm-Message-State: AOAM532lt6PNPIPUikOKnlcP/WVdqfEtrJZSV07IyfBqyh6+VPWD3vG4
        lRH8m8NOA73r9zKurUaBOVw=
X-Google-Smtp-Source: ABdhPJyTvdvsVl/KFu4YEwlfjU6HwwCb17kFxKDf8UAE6YUZfvMzy4E+dNh/VU3uZpPV3DhazFtIAw==
X-Received: by 2002:a05:600c:4281:b0:381:40e5:6cea with SMTP id v1-20020a05600c428100b0038140e56ceamr5143482wmc.151.1645898360547;
        Sat, 26 Feb 2022 09:59:20 -0800 (PST)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d6d0f000000b001ef7dca67fasm3741211wrq.114.2022.02.26.09.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 09:59:20 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jonas@kwiboo.se, nicolas@ndufresne.ca,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com, jc@kynesim.co.uk,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: Re: [PATCH v3 09/14] media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET control
Date:   Sat, 26 Feb 2022 18:59:18 +0100
Message-ID: <1884298.PYKUYFuaPT@kista>
In-Reply-To: <4378293.LvFx2qVVIh@kista>
References: <20220225164600.1044663-1-benjamin.gaignard@collabora.com> <20220225164600.1044663-10-benjamin.gaignard@collabora.com> <4378293.LvFx2qVVIh@kista>
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

Hi!

Dne petek, 25. februar 2022 ob 20:30:20 CET je Jernej =C5=A0krabec napisal(=
a):
> Hi!
>=20
> Dne petek, 25. februar 2022 ob 17:45:55 CET je Benjamin Gaignard napisal(=
a):
> > The number of 'entry point offset' could be very variable.
> > Rather than use a large static array define a v4l2 dynamic array
> > of integer control.
>=20
> I suggest we should be more specific and say U32 (V4L2_CTRL_TYPE_U32).
>=20
> > The number of entry point offsets is reported by the elems field.

I did few more tests and these are my findings:
1. dynamic array can't be set over size, specified in .dims array
2. entry point offsets are per slice, so if we make slices dynamic array, t=
hen=20
entry points would become two dimensional dynamic array
3. num_entry_point_offsets must be part of slice control, because it can be=
=20
zero, but size of array can't be
4. fortunately, not setting entry points doesn't impact decoding correctnes=
s.=20
This is in line what John told me about them.

Hans, can you comment points 1-3? I might misunderstand point 1.

In short, it seems like we don't really need entry points, even if they are=
=20
used in BSP library. In both cases, I got fluster score 119/138 (10-bit=20
excluded), so we can just drop this patch, although I'm a bit uneasy not=20
setting entry points...

Best regards,
Jernej

> >=20
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > ---
> >  .../userspace-api/media/v4l/ext-ctrls-codec.rst          | 9 +++++++++
> >  include/media/hevc-ctrls.h                               | 1 +
> >  2 files changed, 10 insertions(+)
> >=20
> > diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst =
b/
> Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > index 44a268a948c0..71f7dc1c1ccd 100644
> > --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > @@ -3128,6 +3128,15 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
> > =20
> >      \normalsize
> > =20
> > +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
>=20
> Here you have OFFSETS (plural) ...
>=20
> > +    Specifies the i-th entry point offset in bytes and is represented =
by
> > +    offset_len_minus1 plus 1 bits.
>=20
> You probably mean entry_point_offset_minus1? offset_len_minus1 just tells=
 how=20
> much bits need to be read for each element and it's not important for act=
ual=20
> decoding.
>=20
> > +    This control is a dynamically sized array. The number of entry poi=
nt
> > +    offsets is reported by the ``elems`` field.
> > +    This bitstream parameter is defined according to :ref:`hevc`.
> > +    They are described in section 7.4.7.1 "General slice segment header
> > +    semantics" of the specification.
> > +
> >  ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
> >      Specifies the HEVC scaling matrix parameters used for the scaling=
=20
> process
> >      for transform coefficients.
> > diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> > index 3016c1abb1d0..3f8a67924df3 100644
> > --- a/include/media/hevc-ctrls.h
> > +++ b/include/media/hevc-ctrls.h
> > @@ -20,6 +20,7 @@
> >  #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_BASE +=20
> 1012)
> >  #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE +=20
> 1015)
> >  #define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE +=20
1016)
> > +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET (V4L2_CID_CODEC_BAS=
E +=20
> 1017)
>=20
> ... and here you have OFFSET (singlular). I suggest plural form to be use=
d=20
in=20
> all places, including subject line of this commit.
>=20
> Additionally, it would be nice if control is initialized, like so:
> https://github.com/jernejsk/linux-1/commit/
> f938e162cd8dd77c9f6f1b248d80144840a37bce
>=20
> Best regards,
> Jernej
>=20
> > =20
> >  /* enum v4l2_ctrl_type type values */
> >  #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
> > --=20
> > 2.32.0
> >=20
> >=20
>=20
>=20
>=20


