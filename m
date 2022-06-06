Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1F653E8E1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbiFFKRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbiFFKQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:16:42 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBA317429C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:16:18 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id x75so7097452qkb.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 03:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fc/OFAn0RvDAWJQtQ9B+1H+QxhmbSSJd9Hi613D0Bsw=;
        b=KrxENmFO1QgWlWAeJCa+rew4MZ/Z6QR5iukbATFS7s8iFV0QZVhYSMTmzPhd5oC4vh
         pluEXGxwfa233uFAQC3uo6A93DOqHr7hgYBAbzJUH58UH3mPrCPIVvNDuM7oLTNmQa7l
         CecyCYcK7uRWxaElpG8gA8i2i8Js7+SHCbLtQkjxJ83RaYMhitJ4mWe0/mI5iItK7/A7
         Uqk6v4YhCRui45xPLmv5UQgd/pqIvyOay2Bu6Sgwjw3K3vhO3YGilYTE+TBLuTvy8EEI
         0YdfITyCJtezho5vU/xHQy1xidYG5aeW8gwlcT7H8lKWf8zswK9T3hPvhYvG/NDMjiED
         Ia8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fc/OFAn0RvDAWJQtQ9B+1H+QxhmbSSJd9Hi613D0Bsw=;
        b=7GjmWGopX80HtvmEdw/6JZ5zM/homBtvb9ab9Zf/3qg1VDf+tAoNiLa0v9OccqL7j4
         C4Iay+mLYTnBwpwwsJNCnavcOcGweBTGI1CNcCsKqHKoRe6kRdVaPmQhxH3d2eDPDGSs
         8gBwVgjvweUDC/PDrd+Xj4yUtd0s2xuzTgsQjJzzmjtJ+rjkonM16lf8n0D65PenFf8V
         6IREexKbLTdZWD3Es7ft4ksFovhS5zz70Nz9NK4Sktbkayz5IjvaaCw1EPjvgqVqFlSF
         bR3LkL5znIh5fcMIMTzlJ150HyMNKJdDLPG9cGan5ZCNXqd5NZzjTjPuVxGV8hHSlxsQ
         UTyg==
X-Gm-Message-State: AOAM531w505MFtohBhDrWc7yfxasWuaCm4uXnMyoD1Xx68URie5xTiXQ
        xNL0y8+nc1nLa2Ixo4aB8LJJ5zWVONPZyRZEkRE=
X-Google-Smtp-Source: ABdhPJzvmmwoAzRBHaAGyreIeKWdCWu7b5koSZ6XfRTIpHHHC8VvO+dYQd2nZJ945oooKEFeorywlbdLzYHZ6TmHgjw=
X-Received: by 2002:a37:a1c4:0:b0:6a6:ac4f:1d3f with SMTP id
 k187-20020a37a1c4000000b006a6ac4f1d3fmr6832834qke.666.1654510577365; Mon, 06
 Jun 2022 03:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220605094018.9782-1-r.stratiienko@gmail.com> <5826286.lOV4Wx5bFT@jernej-laptop>
In-Reply-To: <5826286.lOV4Wx5bFT@jernej-laptop>
From:   Roman Stratiienko <r.stratiienko@gmail.com>
Date:   Mon, 6 Jun 2022 13:16:06 +0300
Message-ID: <CAGphcdm=sOyppe8sAYMK6aeRXpxiHvj-h-Es6nigCNKBxdBNZQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/sun4i: Enable output signal premultiplication for DE2/DE3
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc:     mripard@kernel.org, wens@csie.org, airlied@linux.ie,
        Daniel Vetter <daniel@ffwll.ch>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, megi@xff.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

=D0=B2=D1=81, 5 =D0=B8=D1=8E=D0=BD. 2022 =D0=B3. =D0=B2 23:23, Jernej =C5=
=A0krabec <jernej.skrabec@gmail.com>:
>
> Dne nedelja, 05. junij 2022 ob 11:40:18 CEST je Roman Stratiienko napisal=
(a):
> > Otherwise alpha value is discarded, resulting incorrect pixel
> > apperance on the display.
> >
> > This also fixes missing transparency for the most bottom layer.
>
> Can you explain that a bit more?

Well... I would recommend reading Bartosz Ciechanowski's blog
https://ciechanow.ski/alpha-compositing/ or the Porter-Duff's 1984
whitepaper itself.

HINT: That magic numbers from sun8i_mixer.h ( 0x03010301 ) corresponds
to SOURCE OVER mode.

As you can see from the blending equation it outputs both pixel value
and alpha value (non-premultiplied data mode).

Also single-layer non-premultiplied buffers may have for example
(R255,G255,B255,A2) pixel value, which should be sent as {R2, G2, B2}
through the physical display interface.

When OUTCTL.PREMULTI disabled pixel, the RGB values passes as is, and
even 100% transparent data {R255, G255, B255, A0} will appear as 100%
opaque white.

>Also, BSP driver never enables this bit. What are we doing differently?

Are you sure the BSP does not have an issues with presenting
transparent buffers?
Does the sunxi even have a customer-feedback mechanism and publicly
available stable BSP with all the fixes?

Regards,
Roman

>
> >
> > Test applications and videos w/ w/o this patch are available at [1].
> >
> > [1]: https://github.com/GloDroid/glodroid_tests/issues/1
>
> As stated in other emails, commit messages should not contain external li=
nks
> (per patch rules).
>
> Best regards,
> Jernej
>
> > Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> >
> > ---
> > Changelog:
> >
> > V2: Added code hunk missing in v1
> > ---
> >  drivers/gpu/drm/sun4i/sun8i_mixer.c | 5 +++--
> >  drivers/gpu/drm/sun4i/sun8i_mixer.h | 1 +
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > b/drivers/gpu/drm/sun4i/sun8i_mixer.c index 6b1711a9a71f..ba2932aaed08
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > @@ -320,8 +320,9 @@ static void sun8i_mixer_mode_set(struct sunxi_engin=
e
> > *engine, else
> >               val =3D 0;
> >
> > -     regmap_update_bits(engine->regs,
> SUN8I_MIXER_BLEND_OUTCTL(bld_base),
> > -                        SUN8I_MIXER_BLEND_OUTCTL_INTERLACED,
> val);
> > +     val |=3D SUN8I_MIXER_BLEND_OUTCTL_PREMULTIPLY;
> > +
> > +     regmap_write(engine->regs, SUN8I_MIXER_BLEND_OUTCTL(bld_base),
> val);
> >
> >       DRM_DEBUG_DRIVER("Switching display mixer interlaced mode %s\n",
> >                        interlaced ? "on" : "off");
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> > b/drivers/gpu/drm/sun4i/sun8i_mixer.h index ebfc276b2464..bc12c95af6f3
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> > @@ -65,6 +65,7 @@
> >  #define SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(n)  (0xf << ((n) << 2))
> >  #define SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(n)        ((n) << 2)
> >
> > +#define SUN8I_MIXER_BLEND_OUTCTL_PREMULTIPLY BIT(0)
> >  #define SUN8I_MIXER_BLEND_OUTCTL_INTERLACED  BIT(1)
> >
> >  #define SUN50I_MIXER_BLEND_CSC_CTL_EN(ch)    BIT(ch)
>
>
>
>
