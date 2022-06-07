Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F99D54027D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 17:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344138AbiFGPcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 11:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344135AbiFGPcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 11:32:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29CB21817
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 08:32:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id q1so35984185ejz.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8mWAcxmdEaXtXEf9bkpBT1dXxrFHE82EQI8/Jd/D+m0=;
        b=GPfz/jg87i8Zik3e8kzVXPFh+GLz9PHfv82fQeGPkCn0GfiS5QUaw/pZFKY3MMdomI
         /LuGFP+pL0A4/djAMIc8djgLEpFxw3hqlfiemCoHbAJraq7EEdYsE7sHKSJQfkCWxDhT
         erwf8YK192cyUffD1u6jI914YqFVstgnWVijI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mWAcxmdEaXtXEf9bkpBT1dXxrFHE82EQI8/Jd/D+m0=;
        b=KQxpBwrd4DaU+BnhnM/aLafJq2mrOGEKqVPtC2w4DA9uOyoOa6srnPV9p5cNjcN8LX
         exVI8bCZk6AoowoSOgkQoeAqI8LovX/jaJ51GP5f6rplKrnFu0RmZFJ/uLky9dF/oKTY
         XrUEt3VBMpvOT7FfJEnoRF2I38advjBKliA0KcmKI64kTsL3PAnStUffU3C9nr57eGwk
         //NUwrUT0efcQXDKkse3/lS4O0JN6TeQxYlakxBYOANiGHhRiuyEDxWUeTROcl3sjCwJ
         Z+Q8bn6v1MEoaSUgRmFwXY8clf8lZN8OFLhWYxZ5IddMw0tk0uzQKgcBTywIpxu5GsOI
         RPsQ==
X-Gm-Message-State: AOAM5323PaEWqeBe/aChqir47AGIV9wLVRUfNI7dz5elgkm+OyTJQvdE
        hPLYTT+oIuEagjoVZByWvdJ4M5xXhWpqmSQ0
X-Google-Smtp-Source: ABdhPJwlI/rAgygpa+1JTSiPMCBy+NQqqBJ40ySYMlIP6/beNGctCs+oM/xDWFRsAnADHDIUWOWkuQ==
X-Received: by 2002:a17:907:720a:b0:6ff:2e1c:f22f with SMTP id dr10-20020a170907720a00b006ff2e1cf22fmr27663171ejc.16.1654615954355;
        Tue, 07 Jun 2022 08:32:34 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id a26-20020a1709062b1a00b006f3ef214db4sm6978997ejg.26.2022.06.07.08.32.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 08:32:32 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id p10so24688840wrg.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 08:32:32 -0700 (PDT)
X-Received: by 2002:a5d:608d:0:b0:218:3cfa:afe9 with SMTP id
 w13-20020a5d608d000000b002183cfaafe9mr12177876wrt.422.1654615951748; Tue, 07
 Jun 2022 08:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220607090549.2345795-1-hsinyi@chromium.org> <20220607090549.2345795-9-hsinyi@chromium.org>
In-Reply-To: <20220607090549.2345795-9-hsinyi@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Jun 2022 08:32:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xe=iEh080QjE+Awgw0Q+Rb=xnrAj6OtO3EXp==XgvD0g@mail.gmail.com>
Message-ID: <CAD=FV=Xe=iEh080QjE+Awgw0Q+Rb=xnrAj6OtO3EXp==XgvD0g@mail.gmail.com>
Subject: Re: [PATCH v5 8/8] drm/mediatek: Config orientation property if panel
 provides it
To:     Hsin-Yi Wang <hsinyi@chromium.org>
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

Hi,

On Tue, Jun 7, 2022 at 2:06 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Panel orientation property should be set before drm_dev_register().
> Mediatek drm driver calls drm_dev_register() in .bind(). However, most
> panels sets orientation property relatively late, mostly in .get_modes()
> callback, since this is when they are able to get the connector and
> binds the orientation property to it, though the value should be known
> when the panel is probed.
>
> Let the drm driver check if the remote end point is a panel and if it
> contains the orientation property. If it does, set it before
> drm_dev_register() is called.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> v4->v5:
> - use the new function in v5.
> - don't use drm_of_find_panel_or_bridge().
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index d9f10a33e6fa..998b1237e193 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -185,6 +185,7 @@ struct mtk_dsi {
>         struct drm_encoder encoder;
>         struct drm_bridge bridge;
>         struct drm_bridge *next_bridge;
> +       struct drm_panel *panel;
>         struct drm_connector *connector;
>         struct phy *phy;
>
> @@ -822,6 +823,10 @@ static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
>                 ret = PTR_ERR(dsi->connector);
>                 goto err_cleanup_encoder;
>         }
> +
> +       /* Read panel orientation */
> +       drm_connector_set_orientation_from_panel(dsi->connector, dsi->panel);
> +
>         drm_connector_attach_encoder(dsi->connector, &dsi->encoder);
>
>         return 0;
> @@ -836,6 +841,16 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>         int ret;
>         struct drm_device *drm = data;
>         struct mtk_dsi *dsi = dev_get_drvdata(dev);
> +       struct device_node *panel_node;
> +
> +       /* Get panel if existed */
> +       panel_node = of_graph_get_remote_node(dev->of_node, 0, 0);
> +       if (panel_node) {
> +               dsi->panel = of_drm_find_panel(panel_node);
> +               if (IS_ERR(dsi->panel))
> +                       dsi->panel = NULL;
> +               of_node_put(panel_node);
> +       }

While the above works, it feels like we could do better. What about this?

* We add _some_ way to determine if a bridge is actually a
panel_bridge. If nothing else maybe this could be
drm_bridge_is_panel() and it could just check if bridge.funcs ==
panel_bridge_bridge_funcs

* In drm_bridge_connector_init(), when we're looping through all the
bridges we find the panel_bridge if it's there.

* At the end of drm_bridge_connector_init() if we found a panel_bridge
then we call a function like drm_panel_bridge_set_orientation().


Then you can fully get rid of the mediatek patch, right? The above
will only work if you're using a panel_bridge / bridge_connector, but
that's "the future" anyway and we want to encourage people to
transition to that.

-Doug
