Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A0750DB1C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiDYI3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240736AbiDYI2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:28:06 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79155DF07
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:25:02 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2f7b815ac06so63970857b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 01:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PKUUhwBuA+ch0Uuq1T1DwshtjMaHDXX/uf2rDKBNDQ=;
        b=LfPW9WXgTpr+8/iVd5AE2JI65Goo9Kb2vfmKqdAD7xilZMOadB4Hs7hyaEuHJcebSq
         Jb6OAXCefLv+Q4wDL3KmNpjmMTgKBGfeHRrT+Wa1UxLqcTruKd81ztbl6lCMZFjlmDC4
         g9lfIGc9u5ZZt7MRgeKrf6IK7WUXWAptRCM0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PKUUhwBuA+ch0Uuq1T1DwshtjMaHDXX/uf2rDKBNDQ=;
        b=WTHR5e6rVADX2mHyvYaGWeyT1lbJaIDHxOKFsLEgOMlfRTDJUZsT5J+ZvHnaj+2Apy
         RvXM7l9VEedwzDRym64ODnBOKUNZsPk07x7GVhwcQVJfanlVDNdjw9aEEF2XuTjtL3MJ
         oRwQsT1wEVVb4SzP0o5J+mcueuCr0WLzw1Pf1UouJUUKdlw3y7C4p8N58Wr5ow3afY5U
         0Xv0AY7ooiagYJEm2ahWdhtOn4Es/dR52Y0bwxOsUBFeCcETcx0GRwFtNAdLERS2BuzS
         x2VaIetHKn8CAtP374wc4ZtYGAE3m+8miI6VxVB26JgLaaY0L65fQSAF7U0lvJnd/EMv
         L6RQ==
X-Gm-Message-State: AOAM531P7UcEd3cN85ojMwlw6Jl3JxWsEckHEEbs31PXiu8F7q71EzHa
        P+9nIiph01KO3lJz6nvHqQi94gLTYw3XlqSgcL+Ohg==
X-Google-Smtp-Source: ABdhPJxbt5i4+hFeo1dGmq14YTb4HSm9CGzOHMOg7ZYoAkkPlsj1JpB9JC+WReAMlPR0hNsAbsVPwv+zgr881d/xQJs=
X-Received: by 2002:a81:b044:0:b0:2d6:bd1f:5d8b with SMTP id
 x4-20020a81b044000000b002d6bd1f5d8bmr15448618ywk.27.1650875101688; Mon, 25
 Apr 2022 01:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220422084720.959271-1-xji@analogixsemi.com> <20220422084720.959271-4-xji@analogixsemi.com>
 <CAG3jFytWGSUM9mevHewdmEe-hq3JgB74s7_f0fsEQqkXr9VUHg@mail.gmail.com> <CAG3jFyvEYbwkdGtiNR-6vFEXTLjcyT_viqp9qeVxFTu0PrJEVA@mail.gmail.com>
In-Reply-To: <CAG3jFyvEYbwkdGtiNR-6vFEXTLjcyT_viqp9qeVxFTu0PrJEVA@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 25 Apr 2022 16:24:50 +0800
Message-ID: <CAGXv+5E1cCNWD98fMDjC38y2UztZd=PNQ+=G=wrBYfoXkswvHA@mail.gmail.com>
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

On Fri, Apr 22, 2022 at 10:13 PM Robert Foss <robert.foss@linaro.org> wrote:
>
> On Fri, 22 Apr 2022 at 16:01, Robert Foss <robert.foss@linaro.org> wrote:
> >
> > On Fri, 22 Apr 2022 at 10:49, Xin Ji <xji@analogixsemi.com> wrote:
> > >
> > > As V4L2_FWNODE_BUS_TYPE_PARALLEL not properly descript for DPI
> > > interface, this patch use new defined V4L2_FWNODE_BUS_TYPE_DPI for it.
> > >
> > > Fixes: fd0310b6fe7d ("drm/bridge: anx7625: add MIPI DPI input feature")
> > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > ---
> > >  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > index 376da01243a3..71df977e8f53 100644
> > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > @@ -1623,14 +1623,14 @@ static int anx7625_parse_dt(struct device *dev,
> > >
> > >         anx7625_get_swing_setting(dev, pdata);
> > >
> > > -       pdata->is_dpi = 1; /* default dpi mode */
> > > +       pdata->is_dpi = 0; /* default dsi mode */
> > >         pdata->mipi_host_node = of_graph_get_remote_node(np, 0, 0);
> > >         if (!pdata->mipi_host_node) {
> > >                 DRM_DEV_ERROR(dev, "fail to get internal panel.\n");
> > >                 return -ENODEV;
> > >         }
> > >
> > > -       bus_type = V4L2_FWNODE_BUS_TYPE_PARALLEL;
> > > +       bus_type = 0;
> > >         mipi_lanes = MAX_LANES_SUPPORT;
> > >         ep0 = of_graph_get_endpoint_by_regs(np, 0, 0);
> > >         if (ep0) {
> > > @@ -1640,8 +1640,8 @@ static int anx7625_parse_dt(struct device *dev,
> > >                 mipi_lanes = of_property_count_u32_elems(ep0, "data-lanes");
> > >         }
> > >
> > > -       if (bus_type == V4L2_FWNODE_BUS_TYPE_PARALLEL) /* bus type is Parallel(DSI) */
> > > -               pdata->is_dpi = 0;
> > > +       if (bus_type == V4L2_FWNODE_BUS_TYPE_DPI) /* bus type is DPI */
> > > +               pdata->is_dpi = 1;
> > >
> > >         pdata->mipi_lanes = mipi_lanes;
> > >         if (pdata->mipi_lanes > MAX_LANES_SUPPORT || pdata->mipi_lanes <= 0)
> >
> > Reviewed-by: Robert Foss <robert.foss@linaro.org>
>
> Acked-by: Robert Foss <robert.foss@linaro.org>

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

Confirmed this fixes the display on Juniper (Acer Chromebook Spin 311) on
mainline (next-20220422).

Xin, in the future, please send the whole series to all recipients of
all patches listed by get_maintainers.pl, not just the recipients of
each patch. In the case of this series, they should have been sent
to all of the mailing lists (media, devicetree, dri-devel) so that
everyone has the same, full view of the patches.

ChenYu
