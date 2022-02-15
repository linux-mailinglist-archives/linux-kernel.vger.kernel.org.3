Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3E24B6D12
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 14:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238114AbiBONIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 08:08:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238115AbiBONIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 08:08:53 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB7BC24A1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 05:08:42 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id h11so14731229ilq.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 05:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h8vn3ZFW8UjLnMLsgl86dcA80MaxOlksJ/pmKV8vWGU=;
        b=Xw6MjLP9Kt6wH/XPSkTrQGGvUPWDpKraFYxM4d6yH3RKbYA/YECy72aCJttKSuP587
         10FtshqY75bNZ0wPI428PCyMW2OAb6yh/TT1o8uOiXl/AYRQtBPDYcnJeIpx7cQYKuhp
         wqae+oOmMT9dVZpOYgXDUMAKab0DYkhYdVNJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8vn3ZFW8UjLnMLsgl86dcA80MaxOlksJ/pmKV8vWGU=;
        b=E6gcQVIAfk1BqwwzUhSqXj6J93KCHv7N/x+NBPh8U+++xuqrJnpArqzioWr15DjVZ9
         9xMEHge5ZFmS6uoxgNL5DsllwsmJzt/A69jQd2UCopgmDaYjn6tGyST2ObzIlNnoRn5A
         O1qwehUn3n5XyxyGE0re0lSyDGnwjeyh/DlNt9nk369wacNOCooePFk2Yp+ttrgf5ouH
         EWv8M4ncjSNUDPNzpz9Z2/YNNrJ08Z9m+vw8bGSXF+YNCovWFNd0yACmdCQentAShaY3
         8tpluZ3FT+A0zfnBLeu+yp3YEISJnfi/nlyDONAJ0knkMFKIpKs9J+6IuO3WguEeB/r6
         jrNQ==
X-Gm-Message-State: AOAM531J9+O88/duHbFLifh71WQHqDqHk7mjIWL+2Ohrnxxzi1tzF93v
        7Moh83L2RJJ1tXqDaDx3lz4N80171hvyBM61TZplUg==
X-Google-Smtp-Source: ABdhPJyn0t3qtaQoYKT56xmJWFr+oDNaEgC/gP1GxkSxrJmyzV5aD6tH7GwuIxyug6WO9KvMRXh2z7t2mVNvKMkI28E=
X-Received: by 2002:a05:6e02:18c6:: with SMTP id s6mr2544341ilu.230.1644930522121;
 Tue, 15 Feb 2022 05:08:42 -0800 (PST)
MIME-Version: 1.0
References: <20220208084234.1684930-1-hsinyi@chromium.org> <87leydhqt3.fsf@collabora.com>
 <CAJMQK-igpiYj-pkgG9amrQuVzf1Mc9BDDOwOdKLUbceKr=CHiQ@mail.gmail.com> <87czjoixno.fsf@collabora.com>
In-Reply-To: <87czjoixno.fsf@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 15 Feb 2022 21:08:16 +0800
Message-ID: <CAJMQK-gvvvhj2dsu8bkT6ytj=0MZaRFmsVOqJVrtVo4Y+XCEdQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] gpu: drm: separate panel orientation property
 creating and value setting
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Simon Ser <contact@emersion.fr>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 12:03 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Hsin-Yi Wang <hsinyi@chromium.org> writes:
>
> > On Tue, Feb 15, 2022 at 9:17 AM Gabriel Krisman Bertazi
> > <krisman@collabora.com> wrote:
> >>
> >> Hsin-Yi Wang <hsinyi@chromium.org> writes:
> >>
> >> > drm_dev_register() sets connector->registration_state to
> >> > DRM_CONNECTOR_REGISTERED and dev->registered to true. If
> >> > drm_connector_set_panel_orientation() is first called after
> >> > drm_dev_register(), it will fail several checks and results in following
> >> > warning.
> >>
> >> Hi,
> >>
> >> I stumbled upon this when investigating the same WARN_ON on amdgpu.
> >> Thanks for the patch :)
> >>
> >> > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> >> > index a50c82bc2b2fec..572ead7ac10690 100644
> >> > --- a/drivers/gpu/drm/drm_connector.c
> >> > +++ b/drivers/gpu/drm/drm_connector.c
> >> > @@ -1252,7 +1252,7 @@ static const struct drm_prop_enum_list dp_colorspaces[] = {
> >> >   *   INPUT_PROP_DIRECT) will still map 1:1 to the actual LCD panel
> >> >   *   coordinates, so if userspace rotates the picture to adjust for
> >> >   *   the orientation it must also apply the same transformation to the
> >> > - *   touchscreen input coordinates. This property is initialized by calling
> >> > + *   touchscreen input coordinates. This property value is set by calling
> >> >   *   drm_connector_set_panel_orientation() or
> >> >   *   drm_connector_set_panel_orientation_with_quirk()
> >> >   *
> >> > @@ -2341,8 +2341,8 @@ EXPORT_SYMBOL(drm_connector_set_vrr_capable_property);
> >> >   * @connector: connector for which to set the panel-orientation property.
> >> >   * @panel_orientation: drm_panel_orientation value to set
> >> >   *
> >> > - * This function sets the connector's panel_orientation and attaches
> >> > - * a "panel orientation" property to the connector.
> >> > + * This function sets the connector's panel_orientation value. If the property
> >> > + * doesn't exist, it will try to create one.
> >> >   *
> >> >   * Calling this function on a connector where the panel_orientation has
> >> >   * already been set is a no-op (e.g. the orientation has been overridden with
> >> > @@ -2373,19 +2373,12 @@ int drm_connector_set_panel_orientation(
> >> >       info->panel_orientation = panel_orientation;
> >> >
> >> >       prop = dev->mode_config.panel_orientation_property;
> >> > -     if (!prop) {
> >> > -             prop = drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
> >> > -                             "panel orientation",
> >> > -                             drm_panel_orientation_enum_list,
> >> > -                             ARRAY_SIZE(drm_panel_orientation_enum_list));
> >> > -             if (!prop)
> >> > -                     return -ENOMEM;
> >> > -
> >> > -             dev->mode_config.panel_orientation_property = prop;
> >> > -     }
> >> > +     if (!prop &&
> >> > +         drm_connector_init_panel_orientation_property(connector) < 0)
> >> > +             return -ENOMEM;
> >> >
> >>
> >> In the case where the property has not been created beforehand, you
> >> forgot to reinitialize prop here, after calling
> >> drm_connector_init_panel_orientation_property().  This means
> > hi Gabriel,
> >
> > drm_connector_init_panel_orientation_property() will create prop if
> > it's null. If prop fails to be created there, it will return -ENOMEM.
>
> Yes.  But *after the property is successfully created*, the prop variable is still
> NULL.  And then you call the following, using prop, which is still NULL:
>
> >> > +     drm_object_property_set_value(&connector->base, prop,
> >> > +                                   info->panel_orientation);
>
> This will do property->dev right on the first line of code, and dereference the
> null prop pointer.

Ah, right. Sorry that I totally missed this.
I'll fix it in the next version if the idea of this patch is accepted.
There might be another preferred solution for this.

>
> You must do
>
>   prop = dev->mode_config.panel_orientation_property;
>
> again after drm_connector_init_panel_orientation_property successfully
> returns, or call drm_object_property_set_value using
> dev->mode_config.panel_orientation_property directly:
>
>   drm_object_property_set_value(&connector->base,
>                         dev->mode_config.panel_orientation_property
>                         info->panel_orientation);
>
> --
> Gabriel Krisman Bertazi
