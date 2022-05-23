Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1FD531098
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbiEWMyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbiEWMyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:54:17 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAF34C412
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:54:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gg20so13975463pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 05:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=I+vGqH+3C1E3CpD3/4I+O6QuVZ7joNauIQKwNIO0kKw=;
        b=seLJhlqbRbYAeGtnbCF7+eHcU1FPgfpxDnSQ6Lkt70sMtG5iAirhOkuWyyR8QYqkYR
         ahsTYUKJqZKvhqqgE0068ZprOrAdGyHjSbCnuLpgRwhv7hzXVL9RXZ0QNHPugsEzR+4g
         WeE+87Wub5gacPpRtSXnFgUJOfrOBU65hpRInaY3AOoIyqLKqpHIB4eTbaCmmbdzpBO7
         cpLMKLxulmZUVnSSj9MJT5raUx8L+BTgIMZnFvasxdN0AFE1CPPGci3GHJhA7OP8crqW
         P9or4uhjhUagV5LScIWr4lNj7huwvmHg46i5xakvGs9lxsErulPQtvWiWCaDCMVyRJT6
         YqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=I+vGqH+3C1E3CpD3/4I+O6QuVZ7joNauIQKwNIO0kKw=;
        b=7okXQBTuBrz0MgsDsok2hD2m4lCxeFugumIPTmQERxn1p+Zoys3Yywcxu2GHiAfOZL
         flePZdVGQxOx/5X/3REXTwkvFJIY46nAB83CkHK5ckhnXZbU9Ue3i3MLTdIxFCiDLOr3
         daWsuw6BSY81XEY91wc0lCHSkWCyofSNRanKIbQC37iiYkxKHs++jNIZnVkoGKepV4ZC
         qS+Xt1rw6VQJUk2WCEiwAt4GDkBAa+39vdKKCG5OllzUawIaGSDdFZf8BKexrlUOY9L3
         uRMO5oGVGGMYdgk8UN8C80kYOP4HerShrWMR/3W1JlYWIxzPdXoYm35ePYTYol4S1ltu
         enEw==
X-Gm-Message-State: AOAM533zW886ShBXOiual3Gae1jGV+008+ZNaoWg5M0CZ1d/SOM0rzbg
        ZO2ej2YNyg7N1+jC3JXNrxOATE5DA81h8WLNf5KOOQ==
X-Google-Smtp-Source: ABdhPJwMet/Wx069lnchRvkgjhCl6l69HHssjtZOQy/2qmA7Fm6Yx1UPvTaNVLMgv8Z0GzK0SmzM3++Vn5NXejPqCbA=
X-Received: by 2002:a17:903:1c6:b0:161:9fbc:5a6 with SMTP id
 e6-20020a17090301c600b001619fbc05a6mr22737538plh.65.1653310456152; Mon, 23
 May 2022 05:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220523084615.13510-1-robert.foss@linaro.org> <CAG3jFytkFcmYjj6AHye3imsTDyP1LxHQvAzjswuRBsVVHRTnKg@mail.gmail.com>
In-Reply-To: <CAG3jFytkFcmYjj6AHye3imsTDyP1LxHQvAzjswuRBsVVHRTnKg@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 23 May 2022 14:54:04 +0200
Message-ID: <CAG3jFytGDm29GVAQ5bs7XQ+hMDABd7btggFGN2pASBEzRPE50A@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Revert "drm/bridge: anx7625: Use DPI bus type"
To:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, xji@analogixsemi.com,
        hsinyi@chromium.org, sam@ravnborg.org, tzimmermann@suse.de,
        maxime@cerno.tech, jose.exposito89@gmail.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches need to be reverted since they were part (3/4 & 4/4)
of a series, that was partially (1/4 + 2/4) on the linux-media tree.
These two patches depend on the patches in the media tree, and will
not build without them, which leaves linux-drm-misc-next in a broken
state. Let's revert the two latter patches until rc1 has been branched
and the dependency wont cause issues any more.

On Mon, 23 May 2022 at 14:50, Robert Foss <robert.foss@linaro.org> wrote:
>
> On Mon, 23 May 2022 at 10:46, Robert Foss <robert.foss@linaro.org> wrote:
> >
> > This reverts commit a77c2af0994e24ee36c7ffb6dc852770bdf06fb1.
> > ---
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > index 01f46d9189c1..53a5da6c49dd 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -1623,14 +1623,14 @@ static int anx7625_parse_dt(struct device *dev,
> >
> >         anx7625_get_swing_setting(dev, pdata);
> >
> > -       pdata->is_dpi = 0; /* default dsi mode */
> > +       pdata->is_dpi = 1; /* default dpi mode */
> >         pdata->mipi_host_node = of_graph_get_remote_node(np, 0, 0);
> >         if (!pdata->mipi_host_node) {
> >                 DRM_DEV_ERROR(dev, "fail to get internal panel.\n");
> >                 return -ENODEV;
> >         }
> >
> > -       bus_type = 0;
> > +       bus_type = V4L2_FWNODE_BUS_TYPE_PARALLEL;
> >         mipi_lanes = MAX_LANES_SUPPORT;
> >         ep0 = of_graph_get_endpoint_by_regs(np, 0, 0);
> >         if (ep0) {
> > @@ -1640,8 +1640,8 @@ static int anx7625_parse_dt(struct device *dev,
> >                 mipi_lanes = of_property_count_u32_elems(ep0, "data-lanes");
> >         }
> >
> > -       if (bus_type == V4L2_FWNODE_BUS_TYPE_DPI) /* bus type is DPI */
> > -               pdata->is_dpi = 1;
> > +       if (bus_type == V4L2_FWNODE_BUS_TYPE_PARALLEL) /* bus type is Parallel(DSI) */
> > +               pdata->is_dpi = 0;
> >
> >         pdata->mipi_lanes = mipi_lanes;
> >         if (pdata->mipi_lanes > MAX_LANES_SUPPORT || pdata->mipi_lanes <= 0)
> > --
> > 2.34.1
> >
>
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
