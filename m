Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3688852FE07
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 18:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245207AbiEUQHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 12:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242468AbiEUQHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 12:07:41 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8612B77F25
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:07:40 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id t144so9933736oie.7
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WtHxkgszDV/EegSXqTlHrX9ymt7tXoHTWBFP3/bwxA4=;
        b=lTOKSmuIkOpF8HGnAK4WXY7YIjk+Rdv3RO9uuySN7BzJ82WWevpfmwsUArtp3eC8gx
         0G2vWcRb+6vO3KHLut2jIun8Gg49EwonSNy4+8uEkGOd/k3GqKQs6ggeNn3RJL+gI6S+
         f+eTiTvMAYJK7AtYTmRaQXs28Mi/y6P4nazqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WtHxkgszDV/EegSXqTlHrX9ymt7tXoHTWBFP3/bwxA4=;
        b=MpmagixgP7xj4o30rpX3kQCg2K8CUR/3FY/bx8OPqF6/53GN44HF5te2n7wAT5T84a
         LB06o5kYsE3SvG5JfAzk7ftyHhz+qfEpPJGLzOvLLBU62mpTcPvoA9WqNZJxxTOtXyJ3
         gfANTGv/Af4qK4rbkfCgW3NoYc5eXRBP24ondgqi63AOkFvTKyRv7fZWQhsaa3ip/Z02
         E3U7ClkOqENn79MMFHmDi1WrKhpnH/tGhNwQq1SEVLDHPAb7sQyBEYQbsGfXSxpq9qgZ
         REcQjmVWGUkSB2C8n5KyXn/oSE1eeuxcSn2uxj1Gm6IfStQAZqSw3HSpu6Uap3h+KjCz
         jA2g==
X-Gm-Message-State: AOAM530xSsGu1lFhyOLTLBsbpAxkqaxhMI/NRQD1qlVbRB8ylusOkatc
        ++vME/dOESvcc5p3JRKcfR+yNKwW6grP1gXFxT9WYg==
X-Google-Smtp-Source: ABdhPJzo3ZRqcn4z0kS5+pKUUuC+pU1x5U4P/AnteI6WarvgIBx5X2YbpZZ9DSM7a7O602u6Ra1kdYLTJgXe1y1AM2E=
X-Received: by 2002:a05:6808:2181:b0:326:901e:f5e7 with SMTP id
 be1-20020a056808218100b00326901ef5e7mr8605870oib.7.1653149259864; Sat, 21 May
 2022 09:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220422084720.959271-1-xji@analogixsemi.com> <20220422084720.959271-4-xji@analogixsemi.com>
 <CAG3jFytWGSUM9mevHewdmEe-hq3JgB74s7_f0fsEQqkXr9VUHg@mail.gmail.com>
 <CAG3jFyvEYbwkdGtiNR-6vFEXTLjcyT_viqp9qeVxFTu0PrJEVA@mail.gmail.com>
 <CAGXv+5E1cCNWD98fMDjC38y2UztZd=PNQ+=G=wrBYfoXkswvHA@mail.gmail.com>
 <20220425091419.GA967110@anxtwsw-Precision-3640-Tower> <CAG3jFyvTim7P_y2G1Br5j3Pwz4KzvRjWgci_qQ3m_YW=3Bog8A@mail.gmail.com>
In-Reply-To: <CAG3jFyvTim7P_y2G1Br5j3Pwz4KzvRjWgci_qQ3m_YW=3Bog8A@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Sat, 21 May 2022 18:07:29 +0200
Message-ID: <CAKMK7uFHyYTnGtP+vCzo2Uan90DW-QZpPFPn5S9bQ5aPiY=qzA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/bridge: anx7625: Use DPI bus type
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Xin Ji <xji@analogixsemi.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>, qwen@analogixsemi.com,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Chen-Yu Tsai <wenst@chromium.org>, bliang@analogixsemi.com,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022 at 18:09, Robert Foss <robert.foss@linaro.org> wrote:
>
> On Mon, 25 Apr 2022 at 11:14, Xin Ji <xji@analogixsemi.com> wrote:
> >
> > On Mon, Apr 25, 2022 at 04:24:50PM +0800, Chen-Yu Tsai wrote:
> > > On Fri, Apr 22, 2022 at 10:13 PM Robert Foss <robert.foss@linaro.org> wrote:
> > > >
> > > > On Fri, 22 Apr 2022 at 16:01, Robert Foss <robert.foss@linaro.org> wrote:
> > > > >
> > > > > On Fri, 22 Apr 2022 at 10:49, Xin Ji <xji@analogixsemi.com> wrote:
> > > > > >
> > > > > > As V4L2_FWNODE_BUS_TYPE_PARALLEL not properly descript for DPI
> > > > > > interface, this patch use new defined V4L2_FWNODE_BUS_TYPE_DPI for it.
> > > > > >
> > > > > > Fixes: fd0310b6fe7d ("drm/bridge: anx7625: add MIPI DPI input feature")
> > > > > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > > > > ---
> > > > > >  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
> > > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > > index 376da01243a3..71df977e8f53 100644
> > > > > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > > @@ -1623,14 +1623,14 @@ static int anx7625_parse_dt(struct device *dev,
> > > > > >
> > > > > >         anx7625_get_swing_setting(dev, pdata);
> > > > > >
> > > > > > -       pdata->is_dpi = 1; /* default dpi mode */
> > > > > > +       pdata->is_dpi = 0; /* default dsi mode */
> > > > > >         pdata->mipi_host_node = of_graph_get_remote_node(np, 0, 0);
> > > > > >         if (!pdata->mipi_host_node) {
> > > > > >                 DRM_DEV_ERROR(dev, "fail to get internal panel.\n");
> > > > > >                 return -ENODEV;
> > > > > >         }
> > > > > >
> > > > > > -       bus_type = V4L2_FWNODE_BUS_TYPE_PARALLEL;
> > > > > > +       bus_type = 0;
> > > > > >         mipi_lanes = MAX_LANES_SUPPORT;
> > > > > >         ep0 = of_graph_get_endpoint_by_regs(np, 0, 0);
> > > > > >         if (ep0) {
> > > > > > @@ -1640,8 +1640,8 @@ static int anx7625_parse_dt(struct device *dev,
> > > > > >                 mipi_lanes = of_property_count_u32_elems(ep0, "data-lanes");
> > > > > >         }
> > > > > >
> > > > > > -       if (bus_type == V4L2_FWNODE_BUS_TYPE_PARALLEL) /* bus type is Parallel(DSI) */
> > > > > > -               pdata->is_dpi = 0;
> > > > > > +       if (bus_type == V4L2_FWNODE_BUS_TYPE_DPI) /* bus type is DPI */
> > > > > > +               pdata->is_dpi = 1;
> > > > > >
> > > > > >         pdata->mipi_lanes = mipi_lanes;
> > > > > >         if (pdata->mipi_lanes > MAX_LANES_SUPPORT || pdata->mipi_lanes <= 0)
> > > > >
> > > > > Reviewed-by: Robert Foss <robert.foss@linaro.org>
> > > >
> > > > Acked-by: Robert Foss <robert.foss@linaro.org>
> > >
> > > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > >
> > > Confirmed this fixes the display on Juniper (Acer Chromebook Spin 311) on
> > > mainline (next-20220422).
> > >
> > > Xin, in the future, please send the whole series to all recipients of
> > > all patches listed by get_maintainers.pl, not just the recipients of
> > > each patch. In the case of this series, they should have been sent
> > > to all of the mailing lists (media, devicetree, dri-devel) so that
> > > everyone has the same, full view of the patches.
> > Hi ChenYu, OK, I'll send to all media, devicetree, dri-devel next time.
> > Thanks,
> > Xin
> > >
> > > ChenYu
>
> Applied 3/4 + 4/4 to drm-misc-next.

This patch doesn't even compile. Can you pls fix this up asap? Also
pls compile-test before pushing ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
