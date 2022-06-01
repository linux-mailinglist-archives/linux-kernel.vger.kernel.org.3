Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC0C53A060
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351050AbiFAJad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351066AbiFAJa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:30:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AF58A336
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:30:25 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id fu3so1021725ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 02:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RTq2qApdr0XDjYdhICkGJiEtvpG4jeHig+budTOXpzw=;
        b=N5bZXB4HEnh1aE629ihk0RNtGOggnXdOo8MhyhV/pnh0CS3sIL/F0HjMn6dkeMJhys
         uvLvUCgQ22KIadzabZUoW8aH9DgEKYOj0O7xEDoueNU6mwjz5rjcJ9pvqB5Ab7qEQqf2
         RzK5un4TdNweT81vZseW8sNyrkZ8icMt397oM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTq2qApdr0XDjYdhICkGJiEtvpG4jeHig+budTOXpzw=;
        b=b8mAALY452MSEW3q8skoEq1oW2/MpL6/SAd1Yh/C2Rf3DyRO6Pn4V+Tx3Dyj383mQh
         n2AGrB6/rkOBPKKbFMbDByiyZ1OGooI9LtKmvtMJpjHGJ9kC3d1H1n5pYA/tE1HyHj8y
         lxUZUUEE3+drjbeOuE5fkEmCkzakGdk5cqt5cZE6NDvFmihamGv2p6/BkCMzsxO0gTky
         TctVBqjPbbcnHCacKQTwlSTFKtigHlKEMUQWHpQ+SJHFhNxXm5f+gVw6XnS1wHwHZ1WB
         qyyykKz+05ZetvEPA70jHz+7YC+0U+Wze1nWtumpsLJtxWeHi5Ph58AL0AXz66if+2z1
         6Bdw==
X-Gm-Message-State: AOAM53280B0sWBDHaitMET+0K4owpIzFZDLWWQuFte1PlqWBLVcGrb7O
        r1K57cilrMaAyiPrAddKQ4NLBZ9W6GdyVgFGuXA8rw==
X-Google-Smtp-Source: ABdhPJxO4OEEAdvJqMndbTEvHBclpdxbIJVkiSSJC2U5lu+FvyjTBUCrzqDl4iM+Hnoyelw7MdIsxnbVinBAcMcjCA0=
X-Received: by 2002:a17:907:160c:b0:6fe:c56f:751 with SMTP id
 hb12-20020a170907160c00b006fec56f0751mr46232867ejc.746.1654075824444; Wed, 01
 Jun 2022 02:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220601081823.1038797-1-hsinyi@chromium.org> <20220601081823.1038797-9-hsinyi@chromium.org>
 <c890efc4-dfda-cab1-8a46-527e3e02168a@redhat.com>
In-Reply-To: <c890efc4-dfda-cab1-8a46-527e3e02168a@redhat.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 1 Jun 2022 17:29:58 +0800
Message-ID: <CAJMQK-iNFyScoh5pZkWA9cPmdmz+YNhuDH-v0fveSfCT0udZFA@mail.gmail.com>
Subject: Re: [PATCH 8/8] drm/mediatek: Config orientation property if panel
 provides it
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Wed, Jun 1, 2022 at 4:57 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 6/1/22 10:18, Hsin-Yi Wang wrote:
> > Panel orientation property should be set before drm_dev_register().
> > Mediatek drm driver calls drm_dev_register() in .bind(). However, most
> > panels sets orientation property relatively late, mostly in .get_modes()
> > callback, since this is when they are able to get the connector and
> > binds the orientation property to it, though the value should be known
> > when the panel is probed.
> >
> > Let the drm driver check if the remote end point is a panel and if it
> > contains the orientation property. If it does, set it before
> > drm_dev_register() is called.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> > The concept is the same as the previous version.
> > https://patchwork.kernel.org/project/linux-mediatek/patch/20220530113033.124072-1-hsinyi@chromium.org/
> > The only difference is, it now uses the panel API instead of parsing
> > orientation from the driver.
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index bd3f5b485085..12836a697f56 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -185,6 +185,7 @@ struct mtk_dsi {
> >       struct drm_encoder encoder;
> >       struct drm_bridge bridge;
> >       struct drm_bridge *next_bridge;
> > +     struct drm_panel *panel;
> >       struct drm_connector *connector;
> >       struct phy *phy;
> >
> > @@ -822,6 +823,16 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
> >               ret = PTR_ERR(dsi->connector);
> >               goto err_cleanup_encoder;
> >       }
> > +
> > +     /* Read panel orientation */
> > +     if (dsi->panel) {
> > +             enum drm_panel_orientation orientation;
> > +
> > +             orientation = drm_panel_get_orientation(dsi->panel);
> > +             if (orientation != DRM_MODE_PANEL_ORIENTATION_UNKNOWN)
> > +                     drm_connector_set_panel_orientation(dsi->connector, orientation);
> > +     }
> > +
> >       drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
> >
> >       return 0;
>
> drm_connector_set_panel_orientation() is a no-op when called with
> DRM_MODE_PANEL_ORIENTATION_UNKNOWN, so the check for this is not
> necessary. This allows this to be simplified to:
>
>         /* Read panel orientation */
>         if (dsi->panel)
>                 drm_connector_set_panel_orientation(dsi->connector,
>                                                     drm_panel_get_orientation(dsi->panel));
>
>
> Note since drm_panel_get_orientation() checks for a NULL panel, you could even
> drop the "if (dsi->panel)", but I think the meaning of the code is more
> clear with that present.
>
Will update this
>
>
>
>
>
> > @@ -837,6 +848,9 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
> >       struct drm_device *drm = data;
> >       struct mtk_dsi *dsi = dev_get_drvdata(dev);
> >
> > +     /* Get panel if existed */
> > +     ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0, &dsi->panel, NULL);
> > +
>
> Check ret? or maybe not assign to ret ?    I understand some errors are expected
> so maybe something like:
>
>         if (ret && ret != -ENODEV)
>                 return ret;
>
I will choose not to assign ret. In some cases that the end point is a
bridge (not panel), since we assign NULL to the bridge, we will get
EPROBE_DEFER.

If the panel fails at this stage,
drm_connector_set_panel_orientation() is just a no-op. Let dsi still
be able to be binded.


> ?
>
> Note -ENODEV is probably not the right error the check for!
>
> Regards,
>
> Hans
>
>
>
> >       ret = mtk_dsi_encoder_init(drm, dsi);
> >       if (ret)
> >               return ret;
>
