Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DD3530A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiEWHZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiEWHYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:24:08 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065383A70A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:18:06 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id er5so17852751edb.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 00:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZKmsQgynHPz6XZUH+OaLoKprNkWxD5xr7wLUims5Uew=;
        b=ZH2nfbwzmcSMItt2ozCdR2C6oxHIor0iq36N2in/oR4yEgbh+eudgGLAx+ea9L3egz
         jD1VNlarZRim2/v4nFpMz7Xv5EpRl6R7j7kaUUP4sF6sGbCFP9Za77PolNlY/X9/k2IA
         ohqz8ocX6ibJlZmF6UUiaVGfC56LEDCTW84kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZKmsQgynHPz6XZUH+OaLoKprNkWxD5xr7wLUims5Uew=;
        b=oLW++KE/e6cIf3z4OvgetKP/gh7xZQfwqalo45hOWsvySEyBTWPeJzwOh1r9cJ6etL
         kwHzyi+Xf+/SaCvhR8tRH66sf37QmmMsabErduV7FRfbLjnMyHekBUk/ARB9sEflfFPC
         Y/Hpf/mr3pW873a+JyVkpfBgiAdSTsAS7vytEUc8Zox/dSquo4wRBzS6yPitmjyCaWTa
         ZX0UlPBWjDjKZdkaIs/NVmzC9VylrX4f4AOXv6yIqnNJlFdTySLTCk46Gh+EZ3r3Gi+y
         0PNyK//AWcwyuu3KMbx6y7OEF9Uio4ATNDESwj6YYs36gHu+2l13PKPpGvqRL8KL/9s8
         S+tA==
X-Gm-Message-State: AOAM532norcz213RH5QOTA6idiVH6mVfP6/zz1vDvIF6upb9PFodB+aL
        JhJHJkkw8jciDvQfD8mBsyoe9cGZOLsy9uRq9fKkiQ==
X-Google-Smtp-Source: ABdhPJxm4iIXuOdQ2/oG1AGl+ysLJoT/7yQvP6EahZ2Gz296n7KCIMf8vvhjxppUwRqYgih0E8dqHJmCqEeNHwoCrqs=
X-Received: by 2002:a05:6402:290e:b0:42a:e401:6a07 with SMTP id
 ee14-20020a056402290e00b0042ae4016a07mr21850777edb.99.1653290284562; Mon, 23
 May 2022 00:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220422084720.959271-1-xji@analogixsemi.com> <20220422084720.959271-4-xji@analogixsemi.com>
 <CAG3jFytWGSUM9mevHewdmEe-hq3JgB74s7_f0fsEQqkXr9VUHg@mail.gmail.com>
 <CAG3jFyvEYbwkdGtiNR-6vFEXTLjcyT_viqp9qeVxFTu0PrJEVA@mail.gmail.com>
 <CAGXv+5E1cCNWD98fMDjC38y2UztZd=PNQ+=G=wrBYfoXkswvHA@mail.gmail.com>
 <20220425091419.GA967110@anxtwsw-Precision-3640-Tower> <CAG3jFyvTim7P_y2G1Br5j3Pwz4KzvRjWgci_qQ3m_YW=3Bog8A@mail.gmail.com>
 <CAKMK7uFHyYTnGtP+vCzo2Uan90DW-QZpPFPn5S9bQ5aPiY=qzA@mail.gmail.com>
 <CAKMK7uHFGsPMZf2SUF4HDXo3XuOLjP3-DLfyp=gB2qpKR964Eg@mail.gmail.com> <20220523031324.GA3738288@anxtwsw-Precision-3640-Tower>
In-Reply-To: <20220523031324.GA3738288@anxtwsw-Precision-3640-Tower>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 23 May 2022 15:17:53 +0800
Message-ID: <CAGXv+5EHghwSV+9Www9RvG74PkC7=AQuwn6sVG=cvCni-iwCyQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/bridge: anx7625: Use DPI bus type
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Robert Foss <robert.foss@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>, qwen@analogixsemi.com,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        bliang@analogixsemi.com,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 11:13 AM Xin Ji <xji@analogixsemi.com> wrote:
>
> On Sat, May 21, 2022 at 06:28:42PM +0200, Daniel Vetter wrote:
> > On Sat, 21 May 2022 at 18:07, Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Tue, 17 May 2022 at 18:09, Robert Foss <robert.foss@linaro.org> wrote:
> > > >
> > > > On Mon, 25 Apr 2022 at 11:14, Xin Ji <xji@analogixsemi.com> wrote:
> > > > >
> > > > > On Mon, Apr 25, 2022 at 04:24:50PM +0800, Chen-Yu Tsai wrote:
> > > > > > On Fri, Apr 22, 2022 at 10:13 PM Robert Foss <robert.foss@linaro.org> wrote:
> > > > > > >
> > > > > > > On Fri, 22 Apr 2022 at 16:01, Robert Foss <robert.foss@linaro.org> wrote:
> > > > > > > >
> > > > > > > > On Fri, 22 Apr 2022 at 10:49, Xin Ji <xji@analogixsemi.com> wrote:
> > > > > > > > >
> > > > > > > > > As V4L2_FWNODE_BUS_TYPE_PARALLEL not properly descript for DPI
> > > > > > > > > interface, this patch use new defined V4L2_FWNODE_BUS_TYPE_DPI for it.
> > > > > > > > >
> > > > > > > > > Fixes: fd0310b6fe7d ("drm/bridge: anx7625: add MIPI DPI input feature")
> > > > > > > > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > > > > > > > ---
> > > > > > > > >  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
> > > > > > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > > > > > index 376da01243a3..71df977e8f53 100644
> > > > > > > > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > > > > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > > > > > @@ -1623,14 +1623,14 @@ static int anx7625_parse_dt(struct device *dev,
> > > > > > > > >
> > > > > > > > >         anx7625_get_swing_setting(dev, pdata);
> > > > > > > > >
> > > > > > > > > -       pdata->is_dpi = 1; /* default dpi mode */
> > > > > > > > > +       pdata->is_dpi = 0; /* default dsi mode */
> > > > > > > > >         pdata->mipi_host_node = of_graph_get_remote_node(np, 0, 0);
> > > > > > > > >         if (!pdata->mipi_host_node) {
> > > > > > > > >                 DRM_DEV_ERROR(dev, "fail to get internal panel.\n");
> > > > > > > > >                 return -ENODEV;
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > -       bus_type = V4L2_FWNODE_BUS_TYPE_PARALLEL;
> > > > > > > > > +       bus_type = 0;
> > > > > > > > >         mipi_lanes = MAX_LANES_SUPPORT;
> > > > > > > > >         ep0 = of_graph_get_endpoint_by_regs(np, 0, 0);
> > > > > > > > >         if (ep0) {
> > > > > > > > > @@ -1640,8 +1640,8 @@ static int anx7625_parse_dt(struct device *dev,
> > > > > > > > >                 mipi_lanes = of_property_count_u32_elems(ep0, "data-lanes");
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > -       if (bus_type == V4L2_FWNODE_BUS_TYPE_PARALLEL) /* bus type is Parallel(DSI) */
> > > > > > > > > -               pdata->is_dpi = 0;
> > > > > > > > > +       if (bus_type == V4L2_FWNODE_BUS_TYPE_DPI) /* bus type is DPI */
> > > > > > > > > +               pdata->is_dpi = 1;
> > > > > > > > >
> > > > > > > > >         pdata->mipi_lanes = mipi_lanes;
> > > > > > > > >         if (pdata->mipi_lanes > MAX_LANES_SUPPORT || pdata->mipi_lanes <= 0)
> > > > > > > >
> > > > > > > > Reviewed-by: Robert Foss <robert.foss@linaro.org>
> > > > > > >
> > > > > > > Acked-by: Robert Foss <robert.foss@linaro.org>
> > > > > >
> > > > > > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > > > > >
> > > > > > Confirmed this fixes the display on Juniper (Acer Chromebook Spin 311) on
> > > > > > mainline (next-20220422).
> > > > > >
> > > > > > Xin, in the future, please send the whole series to all recipients of
> > > > > > all patches listed by get_maintainers.pl, not just the recipients of
> > > > > > each patch. In the case of this series, they should have been sent
> > > > > > to all of the mailing lists (media, devicetree, dri-devel) so that
> > > > > > everyone has the same, full view of the patches.
> > > > > Hi ChenYu, OK, I'll send to all media, devicetree, dri-devel next time.
> > > > > Thanks,
> > > > > Xin
> > > > > >
> > > > > > ChenYu
> > > >
> > > > Applied 3/4 + 4/4 to drm-misc-next.
> > >
> > > This patch doesn't even compile. Can you pls fix this up asap? Also
> > > pls compile-test before pushing ...
> >
> > Marek says the prerequisite landed through linux-media, and that's why
> > it compilers on linux-next but not in drm-misc-next.
> >
> > Don't do that.
> >
> > Instead:
> > - merge all patches through one branch, with the foreign patches acked
> > for that merge patch
> > - wait until you can backmerge all the dependencies
> > - do a topic branch
> >
> > This probably needs to be reverted here and instead merged through
> > linux-media. Or you wait until -rc1 and then apply it to
> > drm-misc-next.
> > -Daniel
> Hi Daniel, I use git send-email to upstream patch and automatically
> generated reviewer list, so patch 1/4 and 2/4 send to linux-media, and
> these 2 patches already merged in linux-media.

This is one of the reasons why you should always send the "full" series
to all recipients. That way people, especially maintainers, are more
likely to notice build time cross tree dependencies like this one, and
work towards a common resolution.


ChenYu
