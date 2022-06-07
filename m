Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAB553F4BA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 05:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbiFGDxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 23:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiFGDxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 23:53:36 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A8036680
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 20:53:33 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x5so16180232edi.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 20:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9MYKKs/mJS+dU49Ti3eZNlPXCXQtAudLKZ8OLFcffA=;
        b=e9VbSeOCyEGjSQuSXdWov23lcUaa1hJW/SEIpwIOXE6fNVSX8c/Qt6bwyFkCeYPj9f
         uZW1lHKHA7fAtkOVLd1mMLlNa3MmsEZ/OPZJAB+swfy/rxucVBgV0XYauth+RpKvfaIb
         ropuFGAd3HkulfYd5v05AsPc/dwrCVLv4B6ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9MYKKs/mJS+dU49Ti3eZNlPXCXQtAudLKZ8OLFcffA=;
        b=y0Qev3CAbfCr6CajqNBg7supcnMIZqw8Kptw3g0Zo5eRKe26F5Tig4F7iaJV/t1DXj
         ghqMJk6ujf6YDt2iPGBai+WPf3cR+hOr7pxm6RypNZlPPP+Mb2ovCZIfXLeJv0rNSf75
         6CiKOx3MgZDMI/Q12XcrjGiEJUrmI91wXQbik5zoHjCd0PCpVMAzh5nSb3v29P4FnLzl
         SnTXMmkX94tjG8B5o1AhRn6+W3vRDgNF++/Mh5mJajuqbkgmAT4Bn+vrQjrU/zzb17cg
         ebafdfBn8mivqPxNwFcVD6GKBXz8QyaP2qAxXJP5pyZ8dPy8rDBmW5d+4vRQewLOJbWR
         eyVw==
X-Gm-Message-State: AOAM533LGYub/1D3jVlyLvrv253pbQ5613v3vaSKDYIr2pKjEoZpKZGC
        kxrgYsyW422IBp0MLOkSA2LEbDBYKzghHf27wigg6w==
X-Google-Smtp-Source: ABdhPJwMJmYgnaR1jsEKX6HTo0Z7AD7f403tUj53vA5Pnco+78VKLJxJeaCB3D1cQJzbQS+707mem4Du4cc4ZrC/TJM=
X-Received: by 2002:a05:6402:149:b0:431:7dde:9b59 with SMTP id
 s9-20020a056402014900b004317dde9b59mr3404884edu.339.1654574011578; Mon, 06
 Jun 2022 20:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220606152431.1889185-1-hsinyi@chromium.org> <20220606152431.1889185-9-hsinyi@chromium.org>
 <Yp5WFA2H52nHVP3d@ravnborg.org>
In-Reply-To: <Yp5WFA2H52nHVP3d@ravnborg.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 7 Jun 2022 11:53:04 +0800
Message-ID: <CAJMQK-gZDR5QmJD4hbn2waB7ej7tmShObrhLMaHii6BSDcozrA@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] drm/mediatek: Config orientation property if panel
 provides it
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
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
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 7, 2022 at 3:31 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Hsin-Yi,
>
> On Mon, Jun 06, 2022 at 11:24:31PM +0800, Hsin-Yi Wang wrote:
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
>
> I do not know the best way to do what you need to do here.
> But it seems wrong to introduce a deprecated function
> (drm_of_find_panel_or_bridge), to set the rotation property early.
>
How about of_drm_find_panel()?

> I think you need to find a way to do this utilising the panel_bridge or
> something.
>
>         Sam
>
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_dsi.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> > index d9f10a33e6fa..c56282412bfa 100644
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
> > @@ -822,6 +823,12 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
> >               ret = PTR_ERR(dsi->connector);
> >               goto err_cleanup_encoder;
> >       }
> > +
> > +     /* Read panel orientation */
> > +     if (dsi->panel)
> > +             drm_connector_set_panel_orientation(dsi->connector,
> > +                             drm_panel_get_orientation(dsi->panel));
> > +
> >       drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
> >
> >       return 0;
> > @@ -837,6 +844,9 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
> >       struct drm_device *drm = data;
> >       struct mtk_dsi *dsi = dev_get_drvdata(dev);
> >
> > +     /* Get panel if existed */
> > +     drm_of_find_panel_or_bridge(dev->of_node, 0, 0, &dsi->panel, NULL);
> > +
> >       ret = mtk_dsi_encoder_init(drm, dsi);
> >       if (ret)
> >               return ret;
> > --
> > 2.36.1.255.ge46751e96f-goog
