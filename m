Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67B5542C6B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbiFHKBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbiFHKA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:00:28 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FCF344CC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:35:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h19so26310370edj.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kOg3HvH8j+WVCx/lSSBrh7BoztwaXs9YDBC9IWClIgg=;
        b=BYg8e6tB+8azsKp0NbkOtO6Sv9a3zM9cNkEsd/Zvy4TRu7dIMeJRCubIXz1+yJEHSm
         eaj8rvMkrQbvG2tDfOe0Sb+HPi67Wwzb2u4p/W+mTgTdUSft07yDROB3L9RVu4HrhY1N
         HrwEILSRfLabHhKX7K/nAJ2mDJqbWxirI90B8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kOg3HvH8j+WVCx/lSSBrh7BoztwaXs9YDBC9IWClIgg=;
        b=DGzclGkp59KJuqpvCs7FirKbbsM1fL2zZeZ7eI9ntltdSYb7BH51wgwGyRWkmV/KAO
         m1xOwQWdof7dvnAwKMNpNWA3sUSWIs+2qZMsoW/VlVBn59gwx4iZBYqfZ5B/1DoTzMTK
         z6Bd0zF26LczV5xT2IAOorlFvIlQtz2WD5bzsavhGLFXCJMiWJX1a+Iw/4vS1Cenq51y
         Umht3VuXJkLbEzWtuYOoKwwtuj6n4nSaQlKyHBaaW2dN1HT0nFdqVxbBHmWmanswvZ40
         jaZ4ontGjR/yPmyj1X1La8A4tBqMTTqRosj7sy/9k2x6T65dbXIaaPaVvo2/rhnBGYkx
         YAUQ==
X-Gm-Message-State: AOAM5332goscnxvroXXTqB4BY/kD2XEuQ6dPxGSiZm4NxBSHiZRKDEVw
        9S+yxEoDi3mY5QPeCi3vukQT02MBbjQLDsvTL2DEzQ==
X-Google-Smtp-Source: ABdhPJxbUUhlJQTDlzFDaW7RW91mrSfMojk1t+tvHzRVYL+0VnFJ2Vlg/w4Krtx80r04u4Z+7aAKFVKb/iNsqLSus5U=
X-Received: by 2002:a05:6402:cab:b0:42d:c842:8369 with SMTP id
 cn11-20020a0564020cab00b0042dc8428369mr37949645edb.181.1654680952985; Wed, 08
 Jun 2022 02:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220607090549.2345795-1-hsinyi@chromium.org> <20220607090549.2345795-9-hsinyi@chromium.org>
 <CAD=FV=Xe=iEh080QjE+Awgw0Q+Rb=xnrAj6OtO3EXp==XgvD0g@mail.gmail.com>
In-Reply-To: <CAD=FV=Xe=iEh080QjE+Awgw0Q+Rb=xnrAj6OtO3EXp==XgvD0g@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 8 Jun 2022 17:35:27 +0800
Message-ID: <CAJMQK-h3-9kSsN2r5+P84DeRNKwCm4pTPsri3tTQQLZjaieSEg@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] drm/mediatek: Config orientation property if panel
 provides it
To:     Doug Anderson <dianders@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 11:39 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Jun 7, 2022 at 2:06 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
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
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > ---
> > v4->v5:
> > - use the new function in v5.
> > - don't use drm_of_find_panel_or_bridge().
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index d9f10a33e6fa..998b1237e193 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > @@ -185,6 +185,7 @@ struct mtk_dsi {
> >         struct drm_encoder encoder;
> >         struct drm_bridge bridge;
> >         struct drm_bridge *next_bridge;
> > +       struct drm_panel *panel;
> >         struct drm_connector *connector;
> >         struct phy *phy;
> >
> > @@ -822,6 +823,10 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
> >                 ret = PTR_ERR(dsi->connector);
> >                 goto err_cleanup_encoder;
> >         }
> > +
> > +       /* Read panel orientation */
> > +       drm_connector_set_orientation_from_panel(dsi->connector, dsi->panel);
> > +
> >         drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
> >
> >         return 0;
> > @@ -836,6 +841,16 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
> >         int ret;
> >         struct drm_device *drm = data;
> >         struct mtk_dsi *dsi = dev_get_drvdata(dev);
> > +       struct device_node *panel_node;
> > +
> > +       /* Get panel if existed */
> > +       panel_node = of_graph_get_remote_node(dev->of_node, 0, 0);
> > +       if (panel_node) {
> > +               dsi->panel = of_drm_find_panel(panel_node);
> > +               if (IS_ERR(dsi->panel))
> > +                       dsi->panel = NULL;
> > +               of_node_put(panel_node);
> > +       }
>
> While the above works, it feels like we could do better. What about this?
>
> * We add _some_ way to determine if a bridge is actually a
> panel_bridge. If nothing else maybe this could be
> drm_bridge_is_panel() and it could just check if bridge.funcs ==
> panel_bridge_bridge_funcs
>
> * In drm_bridge_connector_init(), when we're looping through all the
> bridges we find the panel_bridge if it's there.
>
> * At the end of drm_bridge_connector_init() if we found a panel_bridge
> then we call a function like drm_panel_bridge_set_orientation().
>
>
> Then you can fully get rid of the mediatek patch, right? The above
> will only work if you're using a panel_bridge / bridge_connector, but
> that's "the future" anyway and we want to encourage people to
> transition to that.
>
This also works with the mtk dsi, and it's more generic. I'll drop
this patch and go with this implementation in the next version. Thanks
for the suggestion.

> -Doug
