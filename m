Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE264AD2C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348836AbiBHIH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348858AbiBHIH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:07:26 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC539C03FEC1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:07:25 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id o10so13317408ilh.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2nn1yw6s4IptKKkqexjsVuYGnZXdnpYECt5wmy4nCLI=;
        b=RbemnSrhXrKKcmiNAQChCDTCfg6l6ls5LgDIaRQkZLTLaWYDjG6MM8osL8JkLF3bCp
         /Kq4sd9uU0NEZm+Wz8RgynFJAbap5ItA1CILACu+hFiwrULXgQ7eCzkQ14TNBanKSWIw
         TjONrz2gQtSvRje+DKUublwrHeFhbhnyVgZ3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2nn1yw6s4IptKKkqexjsVuYGnZXdnpYECt5wmy4nCLI=;
        b=v1E/qBxVFI3XWHWZNXlcPLD1FqqzgXmSgyz5FdQDbhX8yOZbr6SrB1EBz5LqFDdoaK
         cskxaUAIZ4L73jL+kCcCldo09baSdev/gETAgTuXjsmElfdiAz6WEA8cmvSHRmnwL/AF
         pYBdTdArzLKVJ/u2Ij0/YmNwQ8hz9BRgaeIu5c8EtfmnhLXUFY5tevgVj5YoL7mIDb7x
         /jLW/oytxbZGTgsWHe+YvLdeDKd2htEN1AI/XfZdOeiBFAQGrR/qW2dTviLI+rGNnnYL
         lAB5uUl/170OuHZyc08tBmThFmiewnvZwu5XqslvGdJSNGd2EBou7pAUP8O52/EFK13F
         p3dw==
X-Gm-Message-State: AOAM530M5Lb60PLSlgXMesyPODeSWqXYYDXFxnC4tcAFHskVFxEsoj7x
        6AmV3GiQyavidTb7XmbrT3yrmLsMKLqIVPIogGZgTA==
X-Google-Smtp-Source: ABdhPJzX6bk4eNvEnp69aytew5yHADtPJVvGPNtbE4EZRnOFljwbLJwfYxI5lISAClkMzxAfRIq8Gdm85/RAs5cGYNM=
X-Received: by 2002:a05:6e02:18c6:: with SMTP id s6mr1637885ilu.230.1644307645048;
 Tue, 08 Feb 2022 00:07:25 -0800 (PST)
MIME-Version: 1.0
References: <20220208073714.1540390-1-hsinyi@chromium.org> <YgIhJb3+MckKD4dC@intel.com>
In-Reply-To: <YgIhJb3+MckKD4dC@intel.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 8 Feb 2022 16:06:59 +0800
Message-ID: <CAJMQK-hzjtZrXC+sdcs39kF6nvUzkNcgNXFXPzTUQHzr8f6ZkA@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v7 1/3] gpu: drm: separate panel orientation
 property creating and value setting
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree@vger.kernel.org, Simon Ser <contact@emersion.fr>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Harry Wentland <harry.wentland@amd.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 8, 2022 at 3:52 PM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Tue, Feb 08, 2022 at 03:37:12PM +0800, Hsin-Yi Wang wrote:
> > +int drm_connector_init_panel_orientation_property(
> > +     struct drm_connector *connector)
> > +{
> > +     struct drm_device *dev =3D connector->dev;
> > +     struct drm_property *prop;
> > +
> > +     prop =3D drm_property_create_enum(dev, DRM_MODE_PROP_IMMUTABLE,
> > +                     "panel orientation",
> > +                     drm_panel_orientation_enum_list,
> > +                     ARRAY_SIZE(drm_panel_orientation_enum_list));
> > +     if (!prop)
> > +             return -ENOMEM;
> > +
> > +     dev->mode_config.panel_orientation_property =3D prop;
>
> Leak when called multiple times. I guess you could just put
> this into drm_connector_create_standard_properties() instead
> and avoid that issue entirely.
>
I'll add a check for dev->mode_config.panel_orientation_property to
avoid the leak issue if called multiple times.
If we add in drm_connector_create_standard_properties(), we still need
another function to attach the property earlier for bridge/connectors
that require this property, since not all bridge/connectors need this
property.

> --
> Ville Syrj=C3=A4l=C3=A4
> Intel
