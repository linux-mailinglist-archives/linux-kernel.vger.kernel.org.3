Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772A94D0610
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbiCGSN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238310AbiCGSN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:13:57 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0A24DF68;
        Mon,  7 Mar 2022 10:13:02 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id t14so14298620pgr.3;
        Mon, 07 Mar 2022 10:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B6TsA2XdiYCsVCW3zF/aw39LpYtkoWg4fApwKJ6gmVw=;
        b=NPI9cJpZJGsl1RRJXCbjypAIObWaZrfLdzSTVP4Hl8FLRMVmD8hxJvJveN331QcppE
         qPQW4nt53HD/7XlOdvP7Wxi74RUHnFCJ5/gWZEp97N8iOKA2kh6WcINEwXJqcjo03jt6
         g3nH8X5TAifEYgahdO+5cjwPEbnOfcMtE7wKUACGy1hLYJqq7IXBB0O3gLS9YwQVRTV3
         5PDuMjV/QgR3r0XdnDzs7YZ7VM3bMu2O6lxtmJHubNz5fDqVw/lhAaIGulJQBoFcsh8B
         5RMuIPLgYcjn0V9iE2h6EvMy/G9I6xtWuYeKXYPY/4jdeMTLpMzD2aXMatk4vKnbao+G
         PLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B6TsA2XdiYCsVCW3zF/aw39LpYtkoWg4fApwKJ6gmVw=;
        b=zWxVtnMz9E3Y54yKz24P6hvBL/4V3gNbFcd/gvCAM2fCE/5ulzLEuIolbGPGY4lof+
         6uVz89gFNdtAdkJXK6tEsUxJH/r6sYEFKYFntd7eBPELaMQA5IcwzV9FOYpTKpa3rjEH
         Ywwcla2w9yst9sUKeBGEGOCRD/rVrCfZUREZKDwbE7NkVYzls0CMzkX5NTaU5lnV6P8v
         7ihDjaAfrJLP/Odgqv5d0eOPiUj/eGMPdqnxXdAYd7sNeoIJnL8917cEEtGSyb8Z3Cuh
         DpxXnpyjBdzwXOeyfnS+chsTkaYOks+9/P6hzP4xSI56sgt8ezugeyu4TzOxuTcKKxP1
         Ec7Q==
X-Gm-Message-State: AOAM530KolIFZZGmIfXKbY7Fnsv8p/c7gPSnzzC6GtFMtbGtc7S1jX2a
        DiE+6/67rI2TljGpntWWa4lUBWykz/r0Kux/s8U=
X-Google-Smtp-Source: ABdhPJwv8Oq73LsXdfaVk3NJmFp9gR6Y6EpdkcLPgyA9p4k18Xc3iMqj44R+bhPSTRJjFK2FsUjccNownQ2eZaZAYG4=
X-Received: by 2002:a63:c011:0:b0:378:74a6:9c31 with SMTP id
 h17-20020a63c011000000b0037874a69c31mr10811098pgg.585.1646676781529; Mon, 07
 Mar 2022 10:13:01 -0800 (PST)
MIME-Version: 1.0
References: <20220301153122.20660-1-cbranchereau@gmail.com>
 <20220301153122.20660-4-cbranchereau@gmail.com> <VM548R.0I9BAN681OS83@crapouillou.net>
In-Reply-To: <VM548R.0I9BAN681OS83@crapouillou.net>
From:   Christophe Branchereau <cbranchereau@gmail.com>
Date:   Mon, 7 Mar 2022 19:12:49 +0100
Message-ID: <CAFsFa85Wb7HcxCqGCYQoSOHOTLJY9xtUHc85PoxO3XTbr=HN4g@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drm/panel : innolux-ej030na and abt-y030xx067a :
 add .enable and .disable
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org
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

Hi Paul, it should in theory, but doesn't work in practice, the
display doesn't like having that bit set outside of the init sequence.

Feel free to experiment if you think you can make it work though, you
should have that panel on 1 or 2 devices I think.

KR
CB

On Wed, Mar 2, 2022 at 12:22 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Hi Christophe,
>
> Le mar., mars 1 2022 at 16:31:22 +0100, Christophe Branchereau
> <cbranchereau@gmail.com> a =C3=A9crit :
> > Following the introduction of bridge_atomic_enable in the ingenic
> > drm driver, the crtc is enabled between .prepare and .enable, if
> > it exists.
> >
> > Add it so the backlight is only enabled after the crtc is, to avoid
> > graphical issues.
> >
> > Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
> > ---
> >  drivers/gpu/drm/panel/panel-abt-y030xx067a.c  | 23 ++++++++++++--
> >  drivers/gpu/drm/panel/panel-innolux-ej030na.c | 31
> > ++++++++++++++++---
> >  2 files changed, 48 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> > b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> > index f043b484055b..b5736344e3ec 100644
> > --- a/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> > +++ b/drivers/gpu/drm/panel/panel-abt-y030xx067a.c
> > @@ -183,8 +183,6 @@ static int y030xx067a_prepare(struct drm_panel
> > *panel)
> >               goto err_disable_regulator;
> >       }
> >
> > -     msleep(120);
> > -
> >       return 0;
> >
> >  err_disable_regulator:
> > @@ -202,6 +200,25 @@ static int y030xx067a_unprepare(struct drm_panel
> > *panel)
> >       return 0;
> >  }
> >
> > +static int y030xx067a_enable(struct drm_panel *panel)
> > +{
> > +     if (panel->backlight) {
> > +             /* Wait for the picture to be ready before enabling backl=
ight */
> > +             msleep(120);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int y030xx067a_disable(struct drm_panel *panel)
> > +{
> > +     struct y030xx067a *priv =3D to_y030xx067a(panel);
> > +
> > +     regmap_clear_bits(priv->map, 0x06, REG06_XPSAVE);
>
> Shouldn't that be balanced by a regmap_set_bits() in the .enable()
> function?
>
> Cheers,
> -Paul
>
> > +
> > +     return 0;
> > +}
> > +
> >  static int y030xx067a_get_modes(struct drm_panel *panel,
> >                               struct drm_connector *connector)
> >  {
> > @@ -239,6 +256,8 @@ static int y030xx067a_get_modes(struct drm_panel
> > *panel,
> >  static const struct drm_panel_funcs y030xx067a_funcs =3D {
> >       .prepare        =3D y030xx067a_prepare,
> >       .unprepare      =3D y030xx067a_unprepare,
> > +     .enable         =3D y030xx067a_enable,
> > +     .disable        =3D y030xx067a_disable,
> >       .get_modes      =3D y030xx067a_get_modes,
> >  };
> >
> > diff --git a/drivers/gpu/drm/panel/panel-innolux-ej030na.c
> > b/drivers/gpu/drm/panel/panel-innolux-ej030na.c
> > index c558de3f99be..6de7370185cd 100644
> > --- a/drivers/gpu/drm/panel/panel-innolux-ej030na.c
> > +++ b/drivers/gpu/drm/panel/panel-innolux-ej030na.c
> > @@ -80,8 +80,6 @@ static const struct reg_sequence
> > ej030na_init_sequence[] =3D {
> >       { 0x47, 0x08 },
> >       { 0x48, 0x0f },
> >       { 0x49, 0x0f },
> > -
> > -     { 0x2b, 0x01 },
> >  };
> >
> >  static int ej030na_prepare(struct drm_panel *panel)
> > @@ -109,8 +107,6 @@ static int ej030na_prepare(struct drm_panel
> > *panel)
> >               goto err_disable_regulator;
> >       }
> >
> > -     msleep(120);
> > -
> >       return 0;
> >
> >  err_disable_regulator:
> > @@ -128,6 +124,31 @@ static int ej030na_unprepare(struct drm_panel
> > *panel)
> >       return 0;
> >  }
> >
> > +static int ej030na_enable(struct drm_panel *panel)
> > +{
> > +     struct ej030na *priv =3D to_ej030na(panel);
> > +
> > +     /* standby off */
> > +     regmap_write(priv->map, 0x2b, 0x01);
> > +
> > +     if (panel->backlight) {
> > +             /* Wait for the picture to be ready before enabling backl=
ight */
> > +             msleep(120);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int ej030na_disable(struct drm_panel *panel)
> > +{
> > +     struct ej030na *priv =3D to_ej030na(panel);
> > +
> > +     /* standby on */
> > +     regmap_write(priv->map, 0x2b, 0x00);
> > +
> > +     return 0;
> > +}
> > +
> >  static int ej030na_get_modes(struct drm_panel *panel,
> >                            struct drm_connector *connector)
> >  {
> > @@ -165,6 +186,8 @@ static int ej030na_get_modes(struct drm_panel
> > *panel,
> >  static const struct drm_panel_funcs ej030na_funcs =3D {
> >       .prepare        =3D ej030na_prepare,
> >       .unprepare      =3D ej030na_unprepare,
> > +     .enable         =3D ej030na_enable,
> > +     .disable        =3D ej030na_disable,
> >       .get_modes      =3D ej030na_get_modes,
> >  };
> >
> > --
> > 2.34.1
> >
>
>
