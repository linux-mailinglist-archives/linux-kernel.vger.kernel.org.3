Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120ED5379FF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbiE3Le5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbiE3Lez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:34:55 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84FC80229
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:34:53 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id c62so10543635vsc.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qavSBhjyJguHpZQtpsLoQunCmJj0UaxeZNUkFbvKHQI=;
        b=nylRUfykXAR4BPxN2kUQcQBx4UFaWucm9OU50Q26J8eVjUxEfey2e3vXkpeXlJPdBw
         yk04wEP2nFeCYhiVSzO2zQEQN7BleasMfad4K+q10YYI80QpMv9sXRHHxhDiw+J4mjqe
         y47MsyfOZhDnFZ0lbA46oIfYX2KDrn8RZ59ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qavSBhjyJguHpZQtpsLoQunCmJj0UaxeZNUkFbvKHQI=;
        b=5MClguokXHuzrGIeuiJRCGePayCXHD5nXxS4gLpBzPGEH/VlKr4DD0FNZJg1rWjVIh
         FkN71+jbV0h3ukAVGyHU6UaWE+IUMFoGAmpkymjag/pib6c4Yd3pQIV6T+truWqXBRMJ
         vRmrqm3YD/ChA/1rUAGUZuEewLJtJ0nIYhrRiesVpxAD0k/83m9llGXAXSvOeRkRx6WB
         5LH0H1x+DcedhyCuDFXjFKaEZXsvtZzm/gsMQKE83dCm0BIlC8CpAVPyRyUAu0FHwvXG
         0KQ04Rmp4ozNFyfOOJGsfkXwrydrtDtcNLYovWVnxKJ+d2fQBcvZBvcLooE9sCZQswNb
         4Mbw==
X-Gm-Message-State: AOAM533fsYRAB5mfHw+IVZ1ZyiEzF5JobpH7RM8JAficzocE7vwQNq6O
        5KjPtvM3ByrWIuxxjSS9FMvutujZpgErSRF+d6f/XQ==
X-Google-Smtp-Source: ABdhPJz7U/gg2bILW7eDQUEq+WiZSAg270VcwmISAU4Df/YG59TiLQ7aY2VN1tkTv7lkJuqBw4E/tvdvjiwMPfduP50=
X-Received: by 2002:a05:6102:1008:b0:335:e260:9ff1 with SMTP id
 q8-20020a056102100800b00335e2609ff1mr21708870vsp.32.1653910493009; Mon, 30
 May 2022 04:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220530081910.3947168-1-hsinyi@chromium.org> <a8d1fe13-e747-016a-2d45-bfb50f23f2d9@redhat.com>
In-Reply-To: <a8d1fe13-e747-016a-2d45-bfb50f23f2d9@redhat.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 30 May 2022 19:34:27 +0800
Message-ID: <CAJMQK-iM-ip7edA2mBOhp-8maWKG5+kTceZUM5U6BOLLBq1H4Q@mail.gmail.com>
Subject: Re: [PATCH v10 0/4] Separate panel orientation property creating and
 value setting
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
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
        Jani Nikula <jani.nikula@linux.intel.com>,
        Emil Velikov <emil.l.velikov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 4:53 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 5/30/22 10:19, Hsin-Yi Wang wrote:
> > Some drivers, eg. mtk_drm and msm_drm, rely on the panel to set the
> > orientation. Panel calls drm_connector_set_panel_orientation() to create
> > orientation property and sets the value. However, connector properties
> > can't be created after drm_dev_register() is called. The goal is to
> > separate the orientation property creation, so drm drivers can create it
> > earlier before drm_dev_register().
>
> Sorry for jumping in pretty late in the discussion (based on the v10
> I seem to have missed this before).
>
> This sounds to me like the real issue here is that drm_dev_register()
> is getting called too early?
>
Right.

> To me it seems sensible to delay calling drm_dev_register() and
> thus allowing userspace to start detecting available displays +
> features until after the panel has been probed.
>

Most panels set this value very late, in .get_modes callback (since it
is when the connector is known), though the value was known during
panel probe.

I think we can also let drm check if they have remote panel nodes: If
there is a panel and the panel sets the orientation, let the drm read
this value and set the property. Does this workflow sound reasonable?

The corresponding patch to implement this:
https://patchwork.kernel.org/project/linux-mediatek/patch/20220530113033.124072-1-hsinyi@chromium.org/

Thanks

> I see a devicetree patch in this series, so I guess that the panel
> is described in devicetree. Especially in the case of devicetree
> I would expect the kernel to have enough info to do the right
> thing and make sure the panel is probed before calling
> drm_dev_register() ?
>
> Regards,
>
> Hans
>
>
>
>
> >
> > After this series, drm_connector_set_panel_orientation() works like
> > before. It won't affect existing callers of
> > drm_connector_set_panel_orientation(). The only difference is that
> > some drm drivers can call drm_connector_init_panel_orientation_property()
> > earlier.
> >
> > Hsin-Yi Wang (4):
> >   gpu: drm: separate panel orientation property creating and value
> >     setting
> >   drm/mediatek: init panel orientation property
> >   drm/msm: init panel orientation property
> >   arm64: dts: mt8183: Add panel rotation
> >
> >  .../arm64/boot/dts/mediatek/mt8183-kukui.dtsi |  1 +
> >  drivers/gpu/drm/drm_connector.c               | 58 ++++++++++++++-----
> >  drivers/gpu/drm/mediatek/mtk_dsi.c            |  7 +++
> >  drivers/gpu/drm/msm/dsi/dsi_manager.c         |  4 ++
> >  include/drm/drm_connector.h                   |  2 +
> >  5 files changed, 59 insertions(+), 13 deletions(-)
> >
>
