Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB63850DB3A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiDYIda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbiDYIcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:32:47 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99D71EC53
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:29:25 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2f16645872fso140094617b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLjj604aJ7sHEbPUV47iK7rgaLEe0P0beg+dD9hS6lc=;
        b=SFhnKBXU/UoiSainjH14yGlXHVY1TCnE3bbkrsyj88ZPnfIBVGkpYgLUsRFdHl7cuf
         3Nh8YwXkIl/DRTq1xBF7XGETNWEBxYUp08qU5XOpj/yAVTxjsPN3YjsQvslxdSBYf4tJ
         GPUTy8e4URgKxFH+/l5/2SxcabWjluQtjFiNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLjj604aJ7sHEbPUV47iK7rgaLEe0P0beg+dD9hS6lc=;
        b=Tub2fXgMa+OHCECIQHzxgGX3wHDb4BM/zQyr0hJsvX23GWEOsxG0pTndIPxeyGIcBd
         WuUnxdme2E6s5NhcM7MT7hnTscZJOe+/38XW2b5irnjqSmvCQxYWsYOtu8GfkEjcBmQf
         HUpkDiUBPkhvy89OnRme7HxhnEc+dhASnzwzLsQAD4s6y1Ml7s8UgCvK8XbOU/SQ4bB8
         wAHymaWpUsQ9MBvu8Hy/2zMctPyxb8QkNbf/4kvznqHasA3xhvKKjnBQ258Lw5mxgtYi
         gfmzZyIc+2flbhq/XUQQ9+dEHeMYM/9cxFd9QUdnegO4qexJs2fGbX+6Ccy0/rIXUe17
         2J1Q==
X-Gm-Message-State: AOAM530EJIoburU9fEeg08dMC8Jzw75RCsEV4hSmvksa1/JanRkMBntq
        ehml9afaJ90GVDCtjZ2Q6wIPHR5LobmI2IJCZu3rIw==
X-Google-Smtp-Source: ABdhPJwqYRvt7Vb3m7Q6P1D51j+GjSTWnNRPZZoBEj0fljZ1FwsRCpSU/FqHs0B0mkHYdDgH/ZSj/w6EoS0MAahUiu4=
X-Received: by 2002:a81:b044:0:b0:2d6:bd1f:5d8b with SMTP id
 x4-20020a81b044000000b002d6bd1f5d8bmr15457087ywk.27.1650875364952; Mon, 25
 Apr 2022 01:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220422084720.959271-1-xji@analogixsemi.com> <20220422084720.959271-4-xji@analogixsemi.com>
 <CAG3jFytWGSUM9mevHewdmEe-hq3JgB74s7_f0fsEQqkXr9VUHg@mail.gmail.com>
 <CAG3jFyvEYbwkdGtiNR-6vFEXTLjcyT_viqp9qeVxFTu0PrJEVA@mail.gmail.com> <CAGXv+5E1cCNWD98fMDjC38y2UztZd=PNQ+=G=wrBYfoXkswvHA@mail.gmail.com>
In-Reply-To: <CAGXv+5E1cCNWD98fMDjC38y2UztZd=PNQ+=G=wrBYfoXkswvHA@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 25 Apr 2022 16:29:14 +0800
Message-ID: <CAGXv+5GUq=9v2q3A7aR+NK_oR=z7MpQQznjWa7bqWR1xEYoobw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/bridge: anx7625: Use DPI bus type
To:     Robert Foss <robert.foss@linaro.org>, Xin Ji <xji@analogixsemi.com>
Cc:     dri-devel@lists.freedesktop.org, Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>, qwen@analogixsemi.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        bliang@analogixsemi.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 4:24 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> On Fri, Apr 22, 2022 at 10:13 PM Robert Foss <robert.foss@linaro.org> wrote:
> >
> > On Fri, 22 Apr 2022 at 16:01, Robert Foss <robert.foss@linaro.org> wrote:
> > >
> > > On Fri, 22 Apr 2022 at 10:49, Xin Ji <xji@analogixsemi.com> wrote:
> > > >
> > > > As V4L2_FWNODE_BUS_TYPE_PARALLEL not properly descript for DPI
> > > > interface, this patch use new defined V4L2_FWNODE_BUS_TYPE_DPI for it.
> > > >
> > > > Fixes: fd0310b6fe7d ("drm/bridge: anx7625: add MIPI DPI input feature")
> > > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > > ---
> > > >  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
> > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > index 376da01243a3..71df977e8f53 100644
> > > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > @@ -1623,14 +1623,14 @@ static int anx7625_parse_dt(struct device *dev,
> > > >
> > > >         anx7625_get_swing_setting(dev, pdata);
> > > >
> > > > -       pdata->is_dpi = 1; /* default dpi mode */
> > > > +       pdata->is_dpi = 0; /* default dsi mode */
> > > >         pdata->mipi_host_node = of_graph_get_remote_node(np, 0, 0);
> > > >         if (!pdata->mipi_host_node) {
> > > >                 DRM_DEV_ERROR(dev, "fail to get internal panel.\n");
> > > >                 return -ENODEV;
> > > >         }
> > > >
> > > > -       bus_type = V4L2_FWNODE_BUS_TYPE_PARALLEL;
> > > > +       bus_type = 0;
> > > >         mipi_lanes = MAX_LANES_SUPPORT;
> > > >         ep0 = of_graph_get_endpoint_by_regs(np, 0, 0);
> > > >         if (ep0) {
> > > > @@ -1640,8 +1640,8 @@ static int anx7625_parse_dt(struct device *dev,
> > > >                 mipi_lanes = of_property_count_u32_elems(ep0, "data-lanes");
> > > >         }
> > > >
> > > > -       if (bus_type == V4L2_FWNODE_BUS_TYPE_PARALLEL) /* bus type is Parallel(DSI) */
> > > > -               pdata->is_dpi = 0;
> > > > +       if (bus_type == V4L2_FWNODE_BUS_TYPE_DPI) /* bus type is DPI */
> > > > +               pdata->is_dpi = 1;
> > > >
> > > >         pdata->mipi_lanes = mipi_lanes;
> > > >         if (pdata->mipi_lanes > MAX_LANES_SUPPORT || pdata->mipi_lanes <= 0)
> > >
> > > Reviewed-by: Robert Foss <robert.foss@linaro.org>
> >
> > Acked-by: Robert Foss <robert.foss@linaro.org>
>
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Confirmed this fixes the display on Juniper (Acer Chromebook Spin 311) on
> mainline (next-20220422).

Forgot to mention, this device uses the already supported but broken (by
previous DPI patch) DSI interface.
