Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F554C576C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiBZSS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiBZSSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:18:25 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8694013CA05;
        Sat, 26 Feb 2022 10:17:50 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id s1so9171494wrg.10;
        Sat, 26 Feb 2022 10:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aXqc/Aa9aaNrrCHTBVmSAtXCikpEnBmLxdEuX//VMWU=;
        b=jtr7I7oBaQCz1K7NodtGWIWvx6CuCVFmpkCqRc29oj0eixPTVLUs5vEwREXdFpwdjN
         ibe/afapjhfixepBK/jho5rwnuLm5dd+XbgyViSR9NoJ8+O6lDjEVwP9OZncY+ewMWzw
         MBb3KFvCfraCchfsT4z7L4eGE8uqmXezcE8C2vetJQOTDsJFe+PzIK4lMos4CdzdaJmc
         /CjH6tueilO+pHtAOzBr0We1Hgo432CCEYnlWkwMSU6oahg9noYNz9Bb2yFvGXUv3QGM
         X+ElAO0Fn8KemopfvoEYLXwkMGaBZAs+BpcRfM3Z8bPS4UyB9/hcVok2EN+JimRfZOHD
         ZO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aXqc/Aa9aaNrrCHTBVmSAtXCikpEnBmLxdEuX//VMWU=;
        b=omdPiccnY3UNUVv3G0C52yUKFj6KzJyB1hPYqmT5cSugiFw7FhjTjnv1tKEwIjqmpR
         0MCCUo0lN/LGCLI+9cCN5MkoTwpWOkDEVQSbge/jxaQifflZQauFViXwePq10yDPYPif
         PE2Yok93lZv12zi3s+e6Jg/Nk81BiEArVXrCeH5a0J5Jwky64MNsXsarhNOfhmSp6cDD
         IsQyc29/VzfHS+jtNB3RL17q2jjfRVaXEjipgm+sXI+e8Fy/m2JxC7Uoe9N6dyN8CT4V
         RyxiDK9Q/+G90Y7mfYauW0aRzE9Gz7UKxFMi3DJfbqeO8qeFcx6zv0zJ52bJb3YIOi6a
         pg6g==
X-Gm-Message-State: AOAM532fiLU4UcJuR0mvUJx5PbsUgiIdOn3kK+w4A0z5pd8Vjzd6jc6k
        /mklYJ5tTXW1zeu80hlnPL4=
X-Google-Smtp-Source: ABdhPJxu/yOz40F7BewccOOPmPsZ+nsr7S4T0cKSzHr7RVIH+u7AvaIFfSWZu2pJF2K0Wj9D+uT8/A==
X-Received: by 2002:adf:e804:0:b0:1ea:9c3b:8f41 with SMTP id o4-20020adfe804000000b001ea9c3b8f41mr10543899wrm.53.1645899468936;
        Sat, 26 Feb 2022 10:17:48 -0800 (PST)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id p18-20020adfba92000000b001e4ae791663sm5824814wrg.62.2022.02.26.10.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 10:17:48 -0800 (PST)
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
Subject: Re: Re: Re: [PATCH v3 09/14] media: uapi: Add V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET control
Date:   Sat, 26 Feb 2022 19:17:46 +0100
Message-ID: <7348885.EvYhyI6sBW@kista>
In-Reply-To: <1884298.PYKUYFuaPT@kista>
References: <20220225164600.1044663-1-benjamin.gaignard@collabora.com> <4378293.LvFx2qVVIh@kista> <1884298.PYKUYFuaPT@kista>
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

Dne sobota, 26. februar 2022 ob 18:59:18 CET je Jernej =C5=A0krabec napisal=
(a):
> Hi!
>=20
> Dne petek, 25. februar 2022 ob 20:30:20 CET je Jernej =C5=A0krabec napisa=
l(a):
> > Hi!
> >=20
> > Dne petek, 25. februar 2022 ob 17:45:55 CET je Benjamin Gaignard=20
napisal(a):
> > > The number of 'entry point offset' could be very variable.
> > > Rather than use a large static array define a v4l2 dynamic array
> > > of integer control.
> >=20
> > I suggest we should be more specific and say U32 (V4L2_CTRL_TYPE_U32).
> >=20
> > > The number of entry point offsets is reported by the elems field.
>=20
> I did few more tests and these are my findings:
> 1. dynamic array can't be set over size, specified in .dims array
> 2. entry point offsets are per slice, so if we make slices dynamic array,=
=20
then=20
> entry points would become two dimensional dynamic array
> 3. num_entry_point_offsets must be part of slice control, because it can =
be=20
> zero, but size of array can't be

Clarification: num_entry_point_offsets is needed in any case, even without =
entry=20
point list.

> 4. fortunately, not setting entry points doesn't impact decoding=20
correctness.=20
> This is in line what John told me about them.
>=20
> Hans, can you comment points 1-3? I might misunderstand point 1.
>=20
> In short, it seems like we don't really need entry points, even if they a=
re=20
> used in BSP library. In both cases, I got fluster score 119/138 (10-bit=20
> excluded), so we can just drop this patch, although I'm a bit uneasy not=
=20
> setting entry points...
>=20
> Best regards,
> Jernej
>=20
> > >=20
> > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > > ---
> > >  .../userspace-api/media/v4l/ext-ctrls-codec.rst          | 9 +++++++=
++
> > >  include/media/hevc-ctrls.h                               | 1 +
> > >  2 files changed, 10 insertions(+)
> > >=20
> > > diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rs=
t b/
> > Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > > index 44a268a948c0..71f7dc1c1ccd 100644
> > > --- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > > +++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
> > > @@ -3128,6 +3128,15 @@ enum v4l2_mpeg_video_hevc_size_of_length_field=
 -
> > > =20
> > >      \normalsize
> > > =20
> > > +``V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSETS (integer)``
> >=20
> > Here you have OFFSETS (plural) ...
> >=20
> > > +    Specifies the i-th entry point offset in bytes and is represente=
d by
> > > +    offset_len_minus1 plus 1 bits.
> >=20
> > You probably mean entry_point_offset_minus1? offset_len_minus1 just tel=
ls=20
how=20
> > much bits need to be read for each element and it's not important for=20
actual=20
> > decoding.
> >=20
> > > +    This control is a dynamically sized array. The number of entry=20
point
> > > +    offsets is reported by the ``elems`` field.
> > > +    This bitstream parameter is defined according to :ref:`hevc`.
> > > +    They are described in section 7.4.7.1 "General slice segment hea=
der
> > > +    semantics" of the specification.
> > > +
> > >  ``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
> > >      Specifies the HEVC scaling matrix parameters used for the scalin=
g=20
> > process
> > >      for transform coefficients.
> > > diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
> > > index 3016c1abb1d0..3f8a67924df3 100644
> > > --- a/include/media/hevc-ctrls.h
> > > +++ b/include/media/hevc-ctrls.h
> > > @@ -20,6 +20,7 @@
> > >  #define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_BASE +=
=20
> > 1012)
> > >  #define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE +=20
> > 1015)
> > >  #define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_BASE=20
+=20
> 1016)
> > > +#define V4L2_CID_STATELESS_HEVC_ENTRY_POINT_OFFSET (V4L2_CID_CODEC_B=
ASE=20
+=20
> > 1017)
> >=20
> > ... and here you have OFFSET (singlular). I suggest plural form to be u=
sed=20
> in=20
> > all places, including subject line of this commit.
> >=20
> > Additionally, it would be nice if control is initialized, like so:
> > https://github.com/jernejsk/linux-1/commit/
> > f938e162cd8dd77c9f6f1b248d80144840a37bce
> >=20
> > Best regards,
> > Jernej
> >=20
> > > =20
> > >  /* enum v4l2_ctrl_type type values */
> > >  #define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
> > > --=20
> > > 2.32.0
> > >=20
> > >=20
> >=20
> >=20
> >=20
>=20
>=20
>=20


