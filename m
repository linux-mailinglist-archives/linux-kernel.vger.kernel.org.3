Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3778C53EE54
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 21:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiFFTIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 15:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbiFFTIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 15:08:50 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C522AC7
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 12:08:48 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id s8so15667515oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 12:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=U+d48J6VO4jwWOwK4nY7MppUng+HS6f87TdgczeTWfA=;
        b=jbYQLfVc8E3vRnH/nAaGpEpu3GBx4LeR4+rgdiFOihSxweRGcyNUDXo8oXTht50+6z
         vCTaJSGT4TIKqAoQCMUYxwZN9KwxGDwPDjCxGedcYvmUQ583rhPZD1tmOJE3v34dIpjn
         C98AM8dS6nf6IlEL28J7wSLX2wRF8ySv7yZOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=U+d48J6VO4jwWOwK4nY7MppUng+HS6f87TdgczeTWfA=;
        b=S5u9bg641T1WeRuibSX1cUZMGz+U0u0Za0XzTmag6495KLeCGIfhTe4aaxDBV25s86
         k9R1kh/tFaaJiHyAgCAy1D5yoiYgtvbIfOmNaSuz1cq1EXR3Ecmmd7PFjK+nkBuSGwAD
         oUQLQr1AOc9ZsDbjy9pVBdpjYAW6NuopR7f+F2986VSQB6xSWxRHoO1tSV7TU5OCUaSp
         sb+EaMPREdXd1x04znqLTXSJlONdoqhL+R+P5ZAPNOgXYNmB9sXPVNGUs7g26IX/u87t
         dUFQW5oVnwX5O6Jqsy0REBl8Abwlym2pAAy0NCK4flhLCS0b2HcyH5EdhEFqIULbrRsk
         H07A==
X-Gm-Message-State: AOAM530QqgzfW2IizfhNmpX4Qk4/ZinsF+z9kV547R+4xOyhRgLniR9/
        Aowq0PVcoCv4W+SkAGmyDnT1aGrrhKG70irXm+jvnA==
X-Google-Smtp-Source: ABdhPJy4c94CssdxgDB7cICSjvhkR/T7a00ZnGxM1AaOQjnzXXHNZCZXMZRtPZa2NcP41pwS569R9SzLPrA11kDyVIA=
X-Received: by 2002:a05:6808:e87:b0:32e:4789:d2c with SMTP id
 k7-20020a0568080e8700b0032e47890d2cmr11740857oil.193.1654542527131; Mon, 06
 Jun 2022 12:08:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 Jun 2022 12:08:46 -0700
MIME-Version: 1.0
In-Reply-To: <20220606152431.1889185-5-hsinyi@chromium.org>
References: <20220606152431.1889185-1-hsinyi@chromium.org> <20220606152431.1889185-5-hsinyi@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 6 Jun 2022 12:08:46 -0700
Message-ID: <CAE-0n51xPADPVcBH7QRh96t7q=mx4VhxrEb1cZENcsu7Z=Nv0A@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] drm/panel: lvds: Implement .get_orientation callback
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
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

Quoting Hsin-Yi Wang (2022-06-06 08:24:27)
> diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
> index f11252fb00fe..491b64c2c8d6 100644
> --- a/drivers/gpu/drm/panel/panel-lvds.c
> +++ b/drivers/gpu/drm/panel/panel-lvds.c
> @@ -99,15 +99,30 @@ static int panel_lvds_get_modes(struct drm_panel *panel,
>         drm_display_info_set_bus_formats(&connector->display_info,
>                                          &lvds->bus_format, 1);
>         connector->display_info.bus_flags = lvds->bus_flags;
> +
> +       /*
> +        * drm drivers are expected to call drm_panel_get_orientation() to get
> +        * panel's orientation then drm_connector_set_panel_orientation() to
> +        * set the property before drm_dev_register(). Otherwise there will be
> +        * a WARN_ON if orientation is set after drm is registered.
> +        */

Should this comment also be a "TODO: Remove once all drm drivers call
drm_connector_set_panel_orientation()"?

>         drm_connector_set_panel_orientation(connector, lvds->orientation);
>
>         return 1;
>  }
>
> +static enum drm_panel_orientation panel_lvds_get_orientation,(struct drm_panel *panel)

Stray comma here                                            ---^

> +{
> +       struct panel_lvds *lvds = to_panel_lvds(panel);
> +
> +       return lvds->orientation;
> +}
> +
