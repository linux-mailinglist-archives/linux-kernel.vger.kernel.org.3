Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13608532F79
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239873AbiEXRKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 13:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbiEXRKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:10:19 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740BB6EC52
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:10:18 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id f35so2543636qtb.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K0lOhhH0mvNxRbFwcsFwHWcmEkc9RJmnRgYMbyOeEIg=;
        b=ASCmvpRwySC2A/4kgnbYkTbzsTCfVOHLYkxqk4wBhEaqTgrlppWVKMBo/dVcb7TFpr
         9CO/lF2KwPzR9QIfcIhpF+Ytj/zfODYY6SXLPC5UEpPP8skDe1P/UIjXJaSHGLX9hDvo
         cTHQ9aVMbhh4acWRWfiYRy4JynbN2NLe7Dx9afwrks3XrqrQT9TeLRn8kCSlfEitCFFM
         okSFMH7iRS2fjm4wEjspZtJwzMu7V8NMKaoRfxe8g9ixwmFXvnaOZjH5YUYrS3BJtxVO
         jh9rUFlHFD3goZhZzX4RGMAmoRky1r/jcBujRdsBDkDqvpM9e32V0wU80QA2vv6I4tN7
         J5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K0lOhhH0mvNxRbFwcsFwHWcmEkc9RJmnRgYMbyOeEIg=;
        b=S3PsuD+lCE8LOZhzMppHawb2VhPTaSRSkDqhKMy3WAp8M3SaNDPWSVjb9g3Kmki5yv
         uDUPeR7CZGn/W6k5u92hS1MBELfS3KL+ii0OpwhbmwX3jTM0iYDTe61rhVQywFxitRgF
         pew6QGvQUl02QkH0qMhl3tAm2+B33WUayOvmCaVyF0tlyzfQL3yndztmmeVH7BubxpK+
         SQRkPZBcm5JWXQfJb0910mlVH/Zm8chPd0nBaGXkCSkhxeLf4IR9vLGrOff9AJn/I5De
         Cz0EwexWeI0MFy+BreNjBJNqp3u7M4P2NUHlk4G//2U/Ld/wqppapoiKLS050P1Mr08l
         /oFQ==
X-Gm-Message-State: AOAM5321xyzL3/zBk290B3b3seJwPk6k+jnXQntrggIeyYty8RDWZ8ET
        AIKPgSfYc9aSZW9qRQYGXPBbc0Svln2iY4ZA2Wc=
X-Google-Smtp-Source: ABdhPJyu8FyqAwJOeb8JJ04T7vWaRZryoWw321zFV3X1e7US8He114AqH57+0drNSh/v7P27LvLYGDwv7ostcABjs50=
X-Received: by 2002:a05:622a:5c8:b0:2f9:1e09:2c41 with SMTP id
 d8-20020a05622a05c800b002f91e092c41mr15206484qtb.284.1653412217342; Tue, 24
 May 2022 10:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220524135249.49993-1-roman.o.stratiienko@globallogic.com>
 <CAGphcd=wTPnTqNxP+TQ8YCDsT=7EUVssAKDpG2J_G=R-7N=YKQ@mail.gmail.com> <2629819.mvXUDI8C0e@kista>
In-Reply-To: <2629819.mvXUDI8C0e@kista>
From:   Roman Stratiienko <r.stratiienko@gmail.com>
Date:   Tue, 24 May 2022 20:10:06 +0300
Message-ID: <CAGphcdn=7r1p217m0DczgYZeGV+STe9PAAAuMjb0qXq2cteEwg@mail.gmail.com>
Subject: Re: Re: [PATCH] drm/sun4i: Fix blend registers corruption for DE2.0/DE3.0
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

Please draft a test for the zpos issue you're mentioning.

It's very easy to do with kmsxx using python wrapper.

Or explain steps to reproduce here, I will write it by myself.

Thanks.
Regards
Roman

=D0=B2=D1=82, 24 =D0=BC=D0=B0=D1=8F 2022 =D0=B3. =D0=B2 19:21, Jernej =C5=
=A0krabec <jernej.skrabec@gmail.com>:
>
> Dne torek, 24. maj 2022 ob 17:31:13 CEST je Roman Stratiienko napisal(a):
> > NAK for this. Further testing showed such an approach is not reliable
> > due to .atomic_update() callback called only in case planes have some
> > changes.
>
> Additionally, I think it would be better to fix underlaying zpos issue fi=
rst
> (attempted many times) and then worry about blending.
>
> Best regards,
> Jernej
>
> >
> > =D0=B2=D1=82, 24 =D0=BC=D0=B0=D1=8F 2022 =D0=B3. =D0=B2 16:52, Roman St=
ratiienko <r.stratiienko@gmail.com>:
> > >
> > > Corruption happens when plane zpos is updated
> > >
> > > Example scenario:
> > >
> > > Initial frame blender state:
> > >     PLANE_ZPOS =3D {0, 1, 2, 3}
> > >     BLD_ROUTE  =3D {0, 1, 2, 0}
> > >     BLD_EN     =3D {1, 1, 1, 0}
> > >
> > > New frame commit (Only ZPOS has been changed):
> > >
> > >     PLANE_ZPOS =3D {0->2, 1->0, 2->1, 3}
> > >
> > > Expected results after plane state update:
> > >                 Z0 Z1 Z2 Z3
> > >     BLD_ROUTE =3D {1, 2, 0, 0}
> > >     BLD_EN    =3D {1, 1, 1, 0}
> > >
> > > What is currently happening:
> > >
> > > 1. sun8i_vi_layer_enable(enabled=3Dtrue, zpos=3D2, old_zpos=3D0):
> > >     BLD_ROUTE =3D {1->0, 1, 2->0, 0}
> > >     BLD_EN    =3D {1->0, 1, 1->1, 0}
> > >
> > > 2. sun8i_ui_layer_enable(enabled=3Dtrue, zpos=3D0, old_zpos=3D1):
> > >     BLD_ROUTE =3D {0->1, 1->0, 0, 0}
> > >     BLD_EN    =3D {0->1, 1->0, 1, 0}
> > >
> > > 3. sun8i_ui_layer_enable(enabled=3Dtrue, zpos=3D1, old_zpos=3D2):
> > >     BLD_ROUTE =3D {1, 0->2, 0->0, 0}
> > >     BLD_EN    =3D {1, 0->2, 1->0, 0}
> > >
> > > After updating of all the planes we are ending up with BLD_EN[2]=3D0,
> > > which makes this channel disabled.
> > >
> > > To fix this issue, clear BLEND registers before updating the planes
> > > and do not clear the old state while processing every plane.
> > >
> > > Signed-off-by: Roman Stratiienko <roman.o.stratiienko@globallogic.com=
>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 16 +++++++++++++++
> > >  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 28 ++++--------------------=
--
> > >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 28 ++++--------------------=
--
> > >  3 files changed, 24 insertions(+), 48 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/su=
n4i/
> sun8i_mixer.c
> > > index f5e8aeaa3cdf..004377a000fc 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > @@ -248,6 +248,21 @@ int sun8i_mixer_drm_format_to_hw(u32 format, u32
> *hw_format)
> > >         return -EINVAL;
> > >  }
> > >
> > > +static void sun8i_atomic_begin(struct sunxi_engine *engine,
> > > +                              struct drm_crtc_state *old_state)
> > > +{
> > > +       struct sun8i_mixer *mixer =3D engine_to_sun8i_mixer(engine);
> > > +       u32 bld_base =3D sun8i_blender_base(mixer);
> > > +
> > > +       regmap_write(engine->regs,
> > > +                    SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
> > > +                    0);
> > > +
> > > +       regmap_write(engine->regs,
> > > +                    SUN8I_MIXER_BLEND_ROUTE(bld_base),
> > > +                    0);
> > > +}
> > > +
> > >  static void sun8i_mixer_commit(struct sunxi_engine *engine)
> > >  {
> > >         DRM_DEBUG_DRIVER("Committing changes\n");
> > > @@ -299,6 +314,7 @@ static struct drm_plane **sun8i_layers_init(struc=
t
> drm_device *drm,
> > >  }
> > >
> > >  static const struct sunxi_engine_ops sun8i_engine_ops =3D {
> > > +       .atomic_begin   =3D sun8i_atomic_begin,
> > >         .commit         =3D sun8i_mixer_commit,
> > >         .layers_init    =3D sun8i_layers_init,
> > >  };
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm=
/
> sun4i/sun8i_ui_layer.c
> > > index 7845c2a53a7f..b294a882626a 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > > @@ -24,8 +24,7 @@
> > >  #include "sun8i_ui_scaler.h"
> > >
> > >  static void sun8i_ui_layer_enable(struct sun8i_mixer *mixer, int cha=
nnel,
> > > -                                 int overlay, bool enable, unsigned =
int
> zpos,
> > > -                                 unsigned int old_zpos)
> > > +                                 int overlay, bool enable, unsigned =
int
> zpos)
> > >  {
> > >         u32 val, bld_base, ch_base;
> > >
> > > @@ -44,18 +43,6 @@ static void sun8i_ui_layer_enable(struct sun8i_mix=
er
> *mixer, int channel,
> > >                            SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base,
> overlay),
> > >                            SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
> > >
> > > -       if (!enable || zpos !=3D old_zpos) {
> > > -               regmap_update_bits(mixer->engine.regs,
> > > -                                  SUN8I_MIXER_BLEND_PIPE_CTL(bld_bas=
e),
> > > -
> SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
> > > -                                  0);
> > > -
> > > -               regmap_update_bits(mixer->engine.regs,
> > > -                                  SUN8I_MIXER_BLEND_ROUTE(bld_base),
> > > -
> SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
> > > -                                  0);
> > > -       }
> > > -
> > >         if (enable) {
> > >                 val =3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
> > >
> > > @@ -291,31 +278,24 @@ static int sun8i_ui_layer_atomic_check(struct
> drm_plane *plane,
> > >  static void sun8i_ui_layer_atomic_disable(struct drm_plane *plane,
> > >                                           struct drm_atomic_state *st=
ate)
> > >  {
> > > -       struct drm_plane_state *old_state =3D
> drm_atomic_get_old_plane_state(state,
> > > -
> plane);
> > >         struct sun8i_ui_layer *layer =3D plane_to_sun8i_ui_layer(plan=
e);
> > > -       unsigned int old_zpos =3D old_state->normalized_zpos;
> > >         struct sun8i_mixer *mixer =3D layer->mixer;
> > >
> > > -       sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay,
> false, 0,
> > > -                             old_zpos);
> > > +       sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay,
> false, 0);
> > >  }
> > >
> > >  static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
> > >                                          struct drm_atomic_state *sta=
te)
> > >  {
> > > -       struct drm_plane_state *old_state =3D
> drm_atomic_get_old_plane_state(state,
> > > -
> plane);
> > >         struct drm_plane_state *new_state =3D
> drm_atomic_get_new_plane_state(state,
> > >
> plane);
> > >         struct sun8i_ui_layer *layer =3D plane_to_sun8i_ui_layer(plan=
e);
> > >         unsigned int zpos =3D new_state->normalized_zpos;
> > > -       unsigned int old_zpos =3D old_state->normalized_zpos;
> > >         struct sun8i_mixer *mixer =3D layer->mixer;
> > >
> > >         if (!new_state->visible) {
> > >                 sun8i_ui_layer_enable(mixer, layer->channel,
> > > -                                     layer->overlay, false, 0, old_z=
pos);
> > > +                                     layer->overlay, false, 0);
> > >                 return;
> > >         }
> > >
> > > @@ -328,7 +308,7 @@ static void sun8i_ui_layer_atomic_update(struct
> drm_plane *plane,
> > >         sun8i_ui_layer_update_buffer(mixer, layer->channel,
> > >                                      layer->overlay, plane);
> > >         sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay,
> > > -                             true, zpos, old_zpos);
> > > +                             true, zpos);
> > >  }
> > >
> > >  static const struct drm_plane_helper_funcs sun8i_ui_layer_helper_fun=
cs =3D
> {
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm=
/
> sun4i/sun8i_vi_layer.c
> > > index bb7c43036dfa..4653244b2fd8 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > @@ -18,8 +18,7 @@
> > >  #include "sun8i_vi_scaler.h"
> > >
> > >  static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int cha=
nnel,
> > > -                                 int overlay, bool enable, unsigned =
int
> zpos,
> > > -                                 unsigned int old_zpos)
> > > +                                 int overlay, bool enable, unsigned =
int
> zpos)
> > >  {
> > >         u32 val, bld_base, ch_base;
> > >
> > > @@ -38,18 +37,6 @@ static void sun8i_vi_layer_enable(struct sun8i_mix=
er
> *mixer, int channel,
> > >                            SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base,
> overlay),
> > >                            SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN, val);
> > >
> > > -       if (!enable || zpos !=3D old_zpos) {
> > > -               regmap_update_bits(mixer->engine.regs,
> > > -                                  SUN8I_MIXER_BLEND_PIPE_CTL(bld_bas=
e),
> > > -
> SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
> > > -                                  0);
> > > -
> > > -               regmap_update_bits(mixer->engine.regs,
> > > -                                  SUN8I_MIXER_BLEND_ROUTE(bld_base),
> > > -
> SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
> > > -                                  0);
> > > -       }
> > > -
> > >         if (enable) {
> > >                 val =3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
> > >
> > > @@ -395,31 +382,24 @@ static int sun8i_vi_layer_atomic_check(struct
> drm_plane *plane,
> > >  static void sun8i_vi_layer_atomic_disable(struct drm_plane *plane,
> > >                                           struct drm_atomic_state *st=
ate)
> > >  {
> > > -       struct drm_plane_state *old_state =3D
> drm_atomic_get_old_plane_state(state,
> > > -
> plane);
> > >         struct sun8i_vi_layer *layer =3D plane_to_sun8i_vi_layer(plan=
e);
> > > -       unsigned int old_zpos =3D old_state->normalized_zpos;
> > >         struct sun8i_mixer *mixer =3D layer->mixer;
> > >
> > > -       sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay,
> false, 0,
> > > -                             old_zpos);
> > > +       sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay,
> false, 0);
> > >  }
> > >
> > >  static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
> > >                                          struct drm_atomic_state *sta=
te)
> > >  {
> > > -       struct drm_plane_state *old_state =3D
> drm_atomic_get_old_plane_state(state,
> > > -
> plane);
> > >         struct drm_plane_state *new_state =3D
> drm_atomic_get_new_plane_state(state,
> > >
> plane);
> > >         struct sun8i_vi_layer *layer =3D plane_to_sun8i_vi_layer(plan=
e);
> > >         unsigned int zpos =3D new_state->normalized_zpos;
> > > -       unsigned int old_zpos =3D old_state->normalized_zpos;
> > >         struct sun8i_mixer *mixer =3D layer->mixer;
> > >
> > >         if (!new_state->visible) {
> > >                 sun8i_vi_layer_enable(mixer, layer->channel,
> > > -                                     layer->overlay, false, 0, old_z=
pos);
> > > +                                     layer->overlay, false, 0);
> > >                 return;
> > >         }
> > >
> > > @@ -432,7 +412,7 @@ static void sun8i_vi_layer_atomic_update(struct
> drm_plane *plane,
> > >         sun8i_vi_layer_update_buffer(mixer, layer->channel,
> > >                                      layer->overlay, plane);
> > >         sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay,
> > > -                             true, zpos, old_zpos);
> > > +                             true, zpos);
> > >  }
> > >
> > >  static const struct drm_plane_helper_funcs sun8i_vi_layer_helper_fun=
cs =3D
> {
> > > --
> > > 2.30.2
> > >
> >
>
>
