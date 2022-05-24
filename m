Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FBA53319C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbiEXTN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238873AbiEXTNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:13:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D145DBFE
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:13:23 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id rq11so15181634ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nzsyUlkyiS/YzaEgtysgXXKOHxgS0XkeH6XhZ/9DzcI=;
        b=RAoVNQlaMYx37KumXh0hGrjUwAjD0INuS3O9Hxop0qlfjBSf2o+baBodGl+Ft/fYKU
         rM8ZNU7pRsVNKqt/TUCl31WwE347eoFxkd/3FBxIAYmOt8b/NafU1Hgb154V7KcDvCGf
         hA3sp8LCOpYW71ANq3ZzVex53wuQObEsodF0Hv0hPEHeo44VkLvCS53sOJDRzfl8Ad0q
         FHnxZ5KPFoCoqkhe2oX/69b0A7DQklL4H7zIBr9+nOpv+5U8gy0058MF3eaIIVn/vixc
         OhaGfs932+BEJ+OcHt/6P0v/3I4BSzn4A4AgSxzn09zrtYJuJpLmSyVz8uXaNzYGMP67
         f3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nzsyUlkyiS/YzaEgtysgXXKOHxgS0XkeH6XhZ/9DzcI=;
        b=6I9n+d+HjXEukPcDtppEOvJ9e8LKwLWs9W7gAq6JsOXM3lVP75lebniZyyn47rTuj1
         qK9k4IXRAc7WXtmZc/2rYPjbdh76TQjXTX5mAZpTC80HBYK5uikyY4sC67C/MJ2NjF+x
         +eOH2Q2boPsmb8QS/2GVpB0w4skaZnaamL21LA+HWepH+9hUZyTbqonoEF02OfqBKpRK
         oRfjMyd7K+QORGR/LxRo/vSt1jcQrM4Pwug8Cx/WFmzUPjJ+JSxI1od9gtx1vKCbZp7r
         9nToMbEjA6btswcD+moZ3ojziL/MXwcmaveuc0r4WQGHZS2nd/hGhZcq6i2zbZd28IKu
         guVA==
X-Gm-Message-State: AOAM530vLD7xIQXVSdl+/Rd3pzOjOsknfnt/FXVMMI32nrzswtNO1Uix
        4oExcdlsn1+ZahF6YUY2jIw=
X-Google-Smtp-Source: ABdhPJwhIiB5LNWsM05p3UmylLy75saiNErANV1vYibc3/Mqe36oT9Gg7y+M+UJk+GivHhVotPQUMw==
X-Received: by 2002:a17:907:7fa8:b0:6f3:e975:abfa with SMTP id qk40-20020a1709077fa800b006f3e975abfamr25545210ejc.86.1653419602162;
        Tue, 24 May 2022 12:13:22 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id p15-20020a05640210cf00b0042aaa3b741esm9769308edu.1.2022.05.24.12.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 12:13:21 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     mripard@kernel.org, wens@csie.org, airlied@linux.ie,
        Daniel Vetter <daniel@ffwll.ch>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, megi@xff.cz
Subject: Re: Re: Re: [PATCH] drm/sun4i: Fix blend registers corruption for DE2.0/DE3.0
Date:   Tue, 24 May 2022 21:13:20 +0200
Message-ID: <2827541.e9J7NaK4W3@kista>
In-Reply-To: <CAGphcdn=7r1p217m0DczgYZeGV+STe9PAAAuMjb0qXq2cteEwg@mail.gmail.com>
References: <20220524135249.49993-1-roman.o.stratiienko@globallogic.com> <2629819.mvXUDI8C0e@kista> <CAGphcdn=7r1p217m0DczgYZeGV+STe9PAAAuMjb0qXq2cteEwg@mail.gmail.com>
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

Don't top post, it's annoying and against rules.

Dne torek, 24. maj 2022 ob 19:10:06 CEST je Roman Stratiienko napisal(a):
> Please draft a test for the zpos issue you're mentioning.
>=20
> It's very easy to do with kmsxx using python wrapper.
>=20
> Or explain steps to reproduce here, I will write it by myself.

I'm talking about the issue which you, Ondrej Jirman and me all tried to fi=
x it=20
in the past one way or another:

https://patchwork.kernel.org/project/dri-devel/patch/20190914220337.646719-=
1-megous@megous.com/
https://patchwork.kernel.org/project/dri-devel/patch/20210106204630.1800284=
=2D1-jernej.skrabec@siol.net/

Best regards,
Jernej

>=20
> Thanks.
> Regards
> Roman
>=20
> =D0=B2=D1=82, 24 =D0=BC=D0=B0=D1=8F 2022 =D0=B3. =D0=B2 19:21, Jernej =C5=
=A0krabec <jernej.skrabec@gmail.com>:
> >
> > Dne torek, 24. maj 2022 ob 17:31:13 CEST je Roman Stratiienko napisal(a=
):
> > > NAK for this. Further testing showed such an approach is not reliable
> > > due to .atomic_update() callback called only in case planes have some
> > > changes.
> >
> > Additionally, I think it would be better to fix underlaying zpos issue =
first
> > (attempted many times) and then worry about blending.
> >
> > Best regards,
> > Jernej
> >
> > >
> > > =D0=B2=D1=82, 24 =D0=BC=D0=B0=D1=8F 2022 =D0=B3. =D0=B2 16:52, Roman =
Stratiienko <r.stratiienko@gmail.com>:
> > > >
> > > > Corruption happens when plane zpos is updated
> > > >
> > > > Example scenario:
> > > >
> > > > Initial frame blender state:
> > > >     PLANE_ZPOS =3D {0, 1, 2, 3}
> > > >     BLD_ROUTE  =3D {0, 1, 2, 0}
> > > >     BLD_EN     =3D {1, 1, 1, 0}
> > > >
> > > > New frame commit (Only ZPOS has been changed):
> > > >
> > > >     PLANE_ZPOS =3D {0->2, 1->0, 2->1, 3}
> > > >
> > > > Expected results after plane state update:
> > > >                 Z0 Z1 Z2 Z3
> > > >     BLD_ROUTE =3D {1, 2, 0, 0}
> > > >     BLD_EN    =3D {1, 1, 1, 0}
> > > >
> > > > What is currently happening:
> > > >
> > > > 1. sun8i_vi_layer_enable(enabled=3Dtrue, zpos=3D2, old_zpos=3D0):
> > > >     BLD_ROUTE =3D {1->0, 1, 2->0, 0}
> > > >     BLD_EN    =3D {1->0, 1, 1->1, 0}
> > > >
> > > > 2. sun8i_ui_layer_enable(enabled=3Dtrue, zpos=3D0, old_zpos=3D1):
> > > >     BLD_ROUTE =3D {0->1, 1->0, 0, 0}
> > > >     BLD_EN    =3D {0->1, 1->0, 1, 0}
> > > >
> > > > 3. sun8i_ui_layer_enable(enabled=3Dtrue, zpos=3D1, old_zpos=3D2):
> > > >     BLD_ROUTE =3D {1, 0->2, 0->0, 0}
> > > >     BLD_EN    =3D {1, 0->2, 1->0, 0}
> > > >
> > > > After updating of all the planes we are ending up with BLD_EN[2]=3D=
0,
> > > > which makes this channel disabled.
> > > >
> > > > To fix this issue, clear BLEND registers before updating the planes
> > > > and do not clear the old state while processing every plane.
> > > >
> > > > Signed-off-by: Roman Stratiienko <roman.o.stratiienko@globallogic.c=
om>
> > > > ---
> > > >  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 16 +++++++++++++++
> > > >  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 28 +++
+----------------------
> > > >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 28 +++
+----------------------
> > > >  3 files changed, 24 insertions(+), 48 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/
sun4i/
> > sun8i_mixer.c
> > > > index f5e8aeaa3cdf..004377a000fc 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > > @@ -248,6 +248,21 @@ int sun8i_mixer_drm_format_to_hw(u32 format, u=
32
> > *hw_format)
> > > >         return -EINVAL;
> > > >  }
> > > >
> > > > +static void sun8i_atomic_begin(struct sunxi_engine *engine,
> > > > +                              struct drm_crtc_state *old_state)
> > > > +{
> > > > +       struct sun8i_mixer *mixer =3D engine_to_sun8i_mixer(engine);
> > > > +       u32 bld_base =3D sun8i_blender_base(mixer);
> > > > +
> > > > +       regmap_write(engine->regs,
> > > > +                    SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
> > > > +                    0);
> > > > +
> > > > +       regmap_write(engine->regs,
> > > > +                    SUN8I_MIXER_BLEND_ROUTE(bld_base),
> > > > +                    0);
> > > > +}
> > > > +
> > > >  static void sun8i_mixer_commit(struct sunxi_engine *engine)
> > > >  {
> > > >         DRM_DEBUG_DRIVER("Committing changes\n");
> > > > @@ -299,6 +314,7 @@ static struct drm_plane **sun8i_layers_init(str=
uct
> > drm_device *drm,
> > > >  }
> > > >
> > > >  static const struct sunxi_engine_ops sun8i_engine_ops =3D {
> > > > +       .atomic_begin   =3D sun8i_atomic_begin,
> > > >         .commit         =3D sun8i_mixer_commit,
> > > >         .layers_init    =3D sun8i_layers_init,
> > > >  };
> > > > diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/d=
rm/
> > sun4i/sun8i_ui_layer.c
> > > > index 7845c2a53a7f..b294a882626a 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> > > > @@ -24,8 +24,7 @@
> > > >  #include "sun8i_ui_scaler.h"
> > > >
> > > >  static void sun8i_ui_layer_enable(struct sun8i_mixer *mixer, int=20
channel,
> > > > -                                 int overlay, bool enable, unsigne=
d=20
int
> > zpos,
> > > > -                                 unsigned int old_zpos)
> > > > +                                 int overlay, bool enable, unsigne=
d=20
int
> > zpos)
> > > >  {
> > > >         u32 val, bld_base, ch_base;
> > > >
> > > > @@ -44,18 +43,6 @@ static void sun8i_ui_layer_enable(struct=20
sun8i_mixer
> > *mixer, int channel,
> > > >                            SUN8I_MIXER_CHAN_UI_LAYER_ATTR(ch_base,
> > overlay),
> > > >                            SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN, val);
> > > >
> > > > -       if (!enable || zpos !=3D old_zpos) {
> > > > -               regmap_update_bits(mixer->engine.regs,
> > > > -                                 =20
SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
> > > > -
> > SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
> > > > -                                  0);
> > > > -
> > > > -               regmap_update_bits(mixer->engine.regs,
> > > > -                                  SUN8I_MIXER_BLEND_ROUTE(bld_base=
),
> > > > -
> > SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
> > > > -                                  0);
> > > > -       }
> > > > -
> > > >         if (enable) {
> > > >                 val =3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
> > > >
> > > > @@ -291,31 +278,24 @@ static int sun8i_ui_layer_atomic_check(struct
> > drm_plane *plane,
> > > >  static void sun8i_ui_layer_atomic_disable(struct drm_plane *plane,
> > > >                                           struct drm_atomic_state=20
*state)
> > > >  {
> > > > -       struct drm_plane_state *old_state =3D
> > drm_atomic_get_old_plane_state(state,
> > > > -
> > plane);
> > > >         struct sun8i_ui_layer *layer =3D plane_to_sun8i_ui_layer(pl=
ane);
> > > > -       unsigned int old_zpos =3D old_state->normalized_zpos;
> > > >         struct sun8i_mixer *mixer =3D layer->mixer;
> > > >
> > > > -       sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay,
> > false, 0,
> > > > -                             old_zpos);
> > > > +       sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay,
> > false, 0);
> > > >  }
> > > >
> > > >  static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
> > > >                                          struct drm_atomic_state=20
*state)
> > > >  {
> > > > -       struct drm_plane_state *old_state =3D
> > drm_atomic_get_old_plane_state(state,
> > > > -
> > plane);
> > > >         struct drm_plane_state *new_state =3D
> > drm_atomic_get_new_plane_state(state,
> > > >
> > plane);
> > > >         struct sun8i_ui_layer *layer =3D plane_to_sun8i_ui_layer(pl=
ane);
> > > >         unsigned int zpos =3D new_state->normalized_zpos;
> > > > -       unsigned int old_zpos =3D old_state->normalized_zpos;
> > > >         struct sun8i_mixer *mixer =3D layer->mixer;
> > > >
> > > >         if (!new_state->visible) {
> > > >                 sun8i_ui_layer_enable(mixer, layer->channel,
> > > > -                                     layer->overlay, false, 0,=20
old_zpos);
> > > > +                                     layer->overlay, false, 0);
> > > >                 return;
> > > >         }
> > > >
> > > > @@ -328,7 +308,7 @@ static void sun8i_ui_layer_atomic_update(struct
> > drm_plane *plane,
> > > >         sun8i_ui_layer_update_buffer(mixer, layer->channel,
> > > >                                      layer->overlay, plane);
> > > >         sun8i_ui_layer_enable(mixer, layer->channel, layer->overlay,
> > > > -                             true, zpos, old_zpos);
> > > > +                             true, zpos);
> > > >  }
> > > >
> > > >  static const struct drm_plane_helper_funcs=20
sun8i_ui_layer_helper_funcs =3D
> > {
> > > > diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/d=
rm/
> > sun4i/sun8i_vi_layer.c
> > > > index bb7c43036dfa..4653244b2fd8 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > > @@ -18,8 +18,7 @@
> > > >  #include "sun8i_vi_scaler.h"
> > > >
> > > >  static void sun8i_vi_layer_enable(struct sun8i_mixer *mixer, int=20
channel,
> > > > -                                 int overlay, bool enable, unsigne=
d=20
int
> > zpos,
> > > > -                                 unsigned int old_zpos)
> > > > +                                 int overlay, bool enable, unsigne=
d=20
int
> > zpos)
> > > >  {
> > > >         u32 val, bld_base, ch_base;
> > > >
> > > > @@ -38,18 +37,6 @@ static void sun8i_vi_layer_enable(struct=20
sun8i_mixer
> > *mixer, int channel,
> > > >                            SUN8I_MIXER_CHAN_VI_LAYER_ATTR(ch_base,
> > overlay),
> > > >                            SUN8I_MIXER_CHAN_VI_LAYER_ATTR_EN, val);
> > > >
> > > > -       if (!enable || zpos !=3D old_zpos) {
> > > > -               regmap_update_bits(mixer->engine.regs,
> > > > -                                 =20
SUN8I_MIXER_BLEND_PIPE_CTL(bld_base),
> > > > -
> > SUN8I_MIXER_BLEND_PIPE_CTL_EN(old_zpos),
> > > > -                                  0);
> > > > -
> > > > -               regmap_update_bits(mixer->engine.regs,
> > > > -                                  SUN8I_MIXER_BLEND_ROUTE(bld_base=
),
> > > > -
> > SUN8I_MIXER_BLEND_ROUTE_PIPE_MSK(old_zpos),
> > > > -                                  0);
> > > > -       }
> > > > -
> > > >         if (enable) {
> > > >                 val =3D SUN8I_MIXER_BLEND_PIPE_CTL_EN(zpos);
> > > >
> > > > @@ -395,31 +382,24 @@ static int sun8i_vi_layer_atomic_check(struct
> > drm_plane *plane,
> > > >  static void sun8i_vi_layer_atomic_disable(struct drm_plane *plane,
> > > >                                           struct drm_atomic_state=20
*state)
> > > >  {
> > > > -       struct drm_plane_state *old_state =3D
> > drm_atomic_get_old_plane_state(state,
> > > > -
> > plane);
> > > >         struct sun8i_vi_layer *layer =3D plane_to_sun8i_vi_layer(pl=
ane);
> > > > -       unsigned int old_zpos =3D old_state->normalized_zpos;
> > > >         struct sun8i_mixer *mixer =3D layer->mixer;
> > > >
> > > > -       sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay,
> > false, 0,
> > > > -                             old_zpos);
> > > > +       sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay,
> > false, 0);
> > > >  }
> > > >
> > > >  static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
> > > >                                          struct drm_atomic_state=20
*state)
> > > >  {
> > > > -       struct drm_plane_state *old_state =3D
> > drm_atomic_get_old_plane_state(state,
> > > > -
> > plane);
> > > >         struct drm_plane_state *new_state =3D
> > drm_atomic_get_new_plane_state(state,
> > > >
> > plane);
> > > >         struct sun8i_vi_layer *layer =3D plane_to_sun8i_vi_layer(pl=
ane);
> > > >         unsigned int zpos =3D new_state->normalized_zpos;
> > > > -       unsigned int old_zpos =3D old_state->normalized_zpos;
> > > >         struct sun8i_mixer *mixer =3D layer->mixer;
> > > >
> > > >         if (!new_state->visible) {
> > > >                 sun8i_vi_layer_enable(mixer, layer->channel,
> > > > -                                     layer->overlay, false, 0,=20
old_zpos);
> > > > +                                     layer->overlay, false, 0);
> > > >                 return;
> > > >         }
> > > >
> > > > @@ -432,7 +412,7 @@ static void sun8i_vi_layer_atomic_update(struct
> > drm_plane *plane,
> > > >         sun8i_vi_layer_update_buffer(mixer, layer->channel,
> > > >                                      layer->overlay, plane);
> > > >         sun8i_vi_layer_enable(mixer, layer->channel, layer->overlay,
> > > > -                             true, zpos, old_zpos);
> > > > +                             true, zpos);
> > > >  }
> > > >
> > > >  static const struct drm_plane_helper_funcs=20
sun8i_vi_layer_helper_funcs =3D
> > {
> > > > --
> > > > 2.30.2
> > > >
> > >
> >
> >
>=20


