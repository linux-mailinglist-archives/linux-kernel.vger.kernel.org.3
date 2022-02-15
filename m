Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663A14B616E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 04:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbiBODPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 22:15:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiBODPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 22:15:39 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830DFAC910
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 19:15:30 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id f37so8030787lfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 19:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n+P11z1Rjs9Tcih/Zook2fZ60KP4QhmCWOTSK5iKxWk=;
        b=N4nYj7rNTC5uHpVcGL9QlugWcvGRZTp+CiKvYeKf6QUKM4NHmpN97jHR5JAyLwHU0G
         majfPSjK77b6t7X4lhovHCqFEO9SKlCLRi0DdE6BDr2pljCbwZc8Y9ndC4l5LcpZmSKW
         hvN2WlQweb/oFJ9OJ7+bDCb4FLOS9Ok0j1ryA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+P11z1Rjs9Tcih/Zook2fZ60KP4QhmCWOTSK5iKxWk=;
        b=5slY3Ka5DjU1nHxNY9LtmcjCU5Led/yP80qiC0WYZFQWV/ZKmm/X2SB2uUrIt8uEBt
         pmA5XZ51Zat1QPr/LteXxTo+hbURSGHYYbhFW9UL/SabSeBx6l+Fa5P+bO4Cv31dw58h
         hKRhdfa2DgYv3E/vgEhCNVrz23VknQppo16WP1QEqfrdf7hQahuMrU7+r0zF8/9tXbHM
         hDR66aar+kTeXkJ27n/qZjxlXuEJwOFejH9QHUAIhMAwONo02IN0Aqx0jtz45YUKHGb5
         N2JR4b4PceT9I7qEH33Imu9NekZBO3sbVFGH26lVir/3A6jDlc/YPxjslopzrqkbTetC
         pB4g==
X-Gm-Message-State: AOAM531qWL5BImDHd/0pJOBxlshU185DNolvSmVievcG4tHOO9rp4kFK
        9fQ10lvGa1rWTLmbCHqY7CUgcelVciSNb/Y+OTHAsg==
X-Google-Smtp-Source: ABdhPJzcbB9EByvT8Z4nbkpVZTyBXtRJOPYoyd47w64TJMSIQNnBwmZMUvf0GIvBRqtwNFPqBweHvkB8bEuLFTrC7OU=
X-Received: by 2002:a05:6512:1699:: with SMTP id bu25mr1543879lfb.403.1644894928818;
 Mon, 14 Feb 2022 19:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20220208084234.1684930-1-hsinyi@chromium.org> <87leydhqt3.fsf@collabora.com>
In-Reply-To: <87leydhqt3.fsf@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 15 Feb 2022 11:15:02 +0800
Message-ID: <CAJMQK-igpiYj-pkgG9amrQuVzf1Mc9BDDOwOdKLUbceKr=CHiQ@mail.gmail.com>
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

On Tue, Feb 15, 2022 at 9:17 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Hsin-Yi Wang <hsinyi@chromium.org> writes:
>
> > drm_dev_register() sets connector->registration_state to
> > DRM_CONNECTOR_REGISTERED and dev->registered to true. If
> > drm_connector_set_panel_orientation() is first called after
> > drm_dev_register(), it will fail several checks and results in following
> > warning.
>
> Hi,
>
> I stumbled upon this when investigating the same WARN_ON on amdgpu.
> Thanks for the patch :)
>
> > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> > index a50c82bc2b2fec..572ead7ac10690 100644
> > --- a/drivers/gpu/drm/drm_connector.c
> > +++ b/drivers/gpu/drm/drm_connector.c
> > @@ -1252,7 +1252,7 @@ static const struct drm_prop_enum_list dp_colorspaces[] = {
> >   *   INPUT_PROP_DIRECT) will still map 1:1 to the actual LCD panel
> >   *   coordinates, so if userspace rotates the picture to adjust for
> >   *   the orientation it must also apply the same transformation to the
> > - *   touchscreen input coordinates. This property is initialized by calling
> > + *   touchscreen input coordinates. This property value is set by calling
> >   *   drm_connector_set_panel_orientation() or
> >   *   drm_connector_set_panel_orientation_with_quirk()
> >   *
> > @@ -2341,8 +2341,8 @@ EXPORT_SYMBOL(drm_connector_set_vrr_capable_property);
> >   * @connector: connector for which to set the panel-orientation property.
> >   * @panel_orientation: drm_panel_orientation value to set
> >   *
> > - * This function sets the connector's panel_orientation and attaches
> > - * a "panel orientation" property to the connector.
> > + * This function sets the connector's panel_orientation value. If the property
> > + * doesn't exist, it will try to create one.
> >   *
> >   * Calling this function on a connector where the panel_orientation has
> >   * already been set is a no-op (e.g. the orientation has been overridden with
> > @@ -2373,19 +2373,12 @@ int drm_connector_set_panel_orientation(
> >       info->panel_orientation = panel_orientation;
> >
> >       prop = dev->mode_config.panel_orientation_property;
> > -     if (!prop) {
> > -             prop = drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
> > -                             "panel orientation",
> > -                             drm_panel_orientation_enum_list,
> > -                             ARRAY_SIZE(drm_panel_orientation_enum_list));
> > -             if (!prop)
> > -                     return -ENOMEM;
> > -
> > -             dev->mode_config.panel_orientation_property = prop;
> > -     }
> > +     if (!prop &&
> > +         drm_connector_init_panel_orientation_property(connector) < 0)
> > +             return -ENOMEM;
> >
>
> In the case where the property has not been created beforehand, you
> forgot to reinitialize prop here, after calling
> drm_connector_init_panel_orientation_property().  This means
hi Gabriel,

drm_connector_init_panel_orientation_property() will create prop if
it's null. If prop fails to be created there, it will return -ENOMEM.

> drm_object_property_set_value() will be called with a NULL second argument
> and Oops the kernel.
>
>
> > -     drm_object_attach_property(&connector->base, prop,
> > -                                info->panel_orientation);
> > +     drm_object_property_set_value(&connector->base, prop,
> > +                                   info->panel_orientation);
>
>
> --
> Gabriel Krisman Bertazi
