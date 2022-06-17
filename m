Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B096654F55D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiFQKcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbiFQKcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:32:22 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0556AA57
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:32:18 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id hj18so7331475ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7uycaSN9iJurwFdQhz5RtglUFVEwCOI11ppJxZo3608=;
        b=lp5VBBWkFeiyeLHXbFMLHxIgQPWdyvIbt3dQIwUt9c8uFPwz+IrfcGPmVoYjN+nhL2
         IXPghsmlO7r72mhRBC5ktRalebTwS9luCPCtI/slO6vetYi4k1699uOx13DUTc3I6tvw
         Fw5zgCep/l0wo0FRNJ/JNClsoRWUoygeY1hZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7uycaSN9iJurwFdQhz5RtglUFVEwCOI11ppJxZo3608=;
        b=EnAHtIdq+vs2zAsWZrW/Shs3kbrcXSRNwzuBqAxdqVAdhfS/h8tMfYNtNiLr8yKVnY
         v13JOGY+9O1lpikmrxPIly7wxiSQfM47O19YhKm0a+ZxTbkKTTrC83H2moUdLzz7fnJw
         wNtdNvDZySFQFiNOXuiurlIe08YFWf9uiXApbydumr/uUvEpOoSEeUXtOBWb2vSxtd5R
         FS26/LPcOji8nEFtZ9+eYk5hdkPhOvSwlYap3alKLuQ/mh1Eg45cljxhk8ZfkyhVhciw
         0u115JbFltZqRqfcPusceCzT+Kl87qw4f4QbO+X5SD4B7+dIBGTsCv6w7qrifSliX6LS
         tVyA==
X-Gm-Message-State: AJIora/E7Q2xJqrQBk2t6SgKlFUMUEkf7d/rn7kdN9P80fEFflReQoxY
        /0rXcP28mvLxwVy/ztdgMKnTnDJxMK06+JRNCrgHR+maloI=
X-Google-Smtp-Source: AGRyM1vJezawLBpRfzaRxzuh1/FQUhahxawJvf0BNgHsS01ToALH1YZ+PHNDuR5+UilQehEhOeyv7ZocgsRIldm4/oY=
X-Received: by 2002:a17:907:96a8:b0:711:56b8:f72b with SMTP id
 hd40-20020a17090796a800b0071156b8f72bmr8887942ejc.152.1655461936837; Fri, 17
 Jun 2022 03:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220422084720.959271-1-xji@analogixsemi.com> <20220422084720.959271-4-xji@analogixsemi.com>
 <CAG3jFytWGSUM9mevHewdmEe-hq3JgB74s7_f0fsEQqkXr9VUHg@mail.gmail.com>
 <CAG3jFyvEYbwkdGtiNR-6vFEXTLjcyT_viqp9qeVxFTu0PrJEVA@mail.gmail.com>
 <CAGXv+5E1cCNWD98fMDjC38y2UztZd=PNQ+=G=wrBYfoXkswvHA@mail.gmail.com>
 <20220425091419.GA967110@anxtwsw-Precision-3640-Tower> <CAG3jFyvTim7P_y2G1Br5j3Pwz4KzvRjWgci_qQ3m_YW=3Bog8A@mail.gmail.com>
 <CAKMK7uFHyYTnGtP+vCzo2Uan90DW-QZpPFPn5S9bQ5aPiY=qzA@mail.gmail.com>
 <CAKMK7uHFGsPMZf2SUF4HDXo3XuOLjP3-DLfyp=gB2qpKR964Eg@mail.gmail.com>
 <20220523031324.GA3738288@anxtwsw-Precision-3640-Tower> <CAGXv+5EHghwSV+9Www9RvG74PkC7=AQuwn6sVG=cvCni-iwCyQ@mail.gmail.com>
 <CAG3jFysJLoQ2DMYw0oOfbQM3ifBmAhNLMxjPDEt12jq8sKCcSg@mail.gmail.com>
In-Reply-To: <CAG3jFysJLoQ2DMYw0oOfbQM3ifBmAhNLMxjPDEt12jq8sKCcSg@mail.gmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Jun 2022 18:32:05 +0800
Message-ID: <CAGXv+5EEB1-jUgUo3HGTu9JgeD46Nuu1PuwO9PYfOKeR3csBbw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/bridge: anx7625: Use DPI bus type
To:     Robert Foss <robert.foss@linaro.org>
Cc:     Xin Ji <xji@analogixsemi.com>, Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>, qwen@analogixsemi.com,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        bliang@analogixsemi.com,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
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

Hi,

On Mon, May 23, 2022 at 4:37 PM Robert Foss <robert.foss@linaro.org> wrote:
>
> On Mon, 23 May 2022 at 09:18, Chen-Yu Tsai <wenst@chromium.org> wrote:
> >
> > On Mon, May 23, 2022 at 11:13 AM Xin Ji <xji@analogixsemi.com> wrote:
> > >
> > > On Sat, May 21, 2022 at 06:28:42PM +0200, Daniel Vetter wrote:
> > > > On Sat, 21 May 2022 at 18:07, Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > >
> > > > > On Tue, 17 May 2022 at 18:09, Robert Foss <robert.foss@linaro.org> wrote:
> > > > > >
> > > > > > On Mon, 25 Apr 2022 at 11:14, Xin Ji <xji@analogixsemi.com> wrote:
> > > > > > >
> > > > > > > On Mon, Apr 25, 2022 at 04:24:50PM +0800, Chen-Yu Tsai wrote:
> > > > > > > > On Fri, Apr 22, 2022 at 10:13 PM Robert Foss <robert.foss@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, 22 Apr 2022 at 16:01, Robert Foss <robert.foss@linaro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, 22 Apr 2022 at 10:49, Xin Ji <xji@analogixsemi.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > As V4L2_FWNODE_BUS_TYPE_PARALLEL not properly descript for DPI
> > > > > > > > > > > interface, this patch use new defined V4L2_FWNODE_BUS_TYPE_DPI for it.
> > > > > > > > > > >
> > > > > > > > > > > Fixes: fd0310b6fe7d ("drm/bridge: anx7625: add MIPI DPI input feature")
> > > > > > > > > > > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > > > > > > > > > > ---
> > > > > > > > > > >  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
> > > > > > > > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > > > > > > > index 376da01243a3..71df977e8f53 100644
> > > > > > > > > > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > > > > > > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > > > > > > > > > @@ -1623,14 +1623,14 @@ static int anx7625_parse_dt(struct device *dev,
> > > > > > > > > > >
> > > > > > > > > > >         anx7625_get_swing_setting(dev, pdata);
> > > > > > > > > > >
> > > > > > > > > > > -       pdata->is_dpi = 1; /* default dpi mode */
> > > > > > > > > > > +       pdata->is_dpi = 0; /* default dsi mode */
> > > > > > > > > > >         pdata->mipi_host_node = of_graph_get_remote_node(np, 0, 0);
> > > > > > > > > > >         if (!pdata->mipi_host_node) {
> > > > > > > > > > >                 DRM_DEV_ERROR(dev, "fail to get internal panel.\n");
> > > > > > > > > > >                 return -ENODEV;
> > > > > > > > > > >         }
> > > > > > > > > > >
> > > > > > > > > > > -       bus_type = V4L2_FWNODE_BUS_TYPE_PARALLEL;
> > > > > > > > > > > +       bus_type = 0;
> > > > > > > > > > >         mipi_lanes = MAX_LANES_SUPPORT;
> > > > > > > > > > >         ep0 = of_graph_get_endpoint_by_regs(np, 0, 0);
> > > > > > > > > > >         if (ep0) {
> > > > > > > > > > > @@ -1640,8 +1640,8 @@ static int anx7625_parse_dt(struct device *dev,
> > > > > > > > > > >                 mipi_lanes = of_property_count_u32_elems(ep0, "data-lanes");
> > > > > > > > > > >         }
> > > > > > > > > > >
> > > > > > > > > > > -       if (bus_type == V4L2_FWNODE_BUS_TYPE_PARALLEL) /* bus type is Parallel(DSI) */
> > > > > > > > > > > -               pdata->is_dpi = 0;
> > > > > > > > > > > +       if (bus_type == V4L2_FWNODE_BUS_TYPE_DPI) /* bus type is DPI */
> > > > > > > > > > > +               pdata->is_dpi = 1;
> > > > > > > > > > >
> > > > > > > > > > >         pdata->mipi_lanes = mipi_lanes;
> > > > > > > > > > >         if (pdata->mipi_lanes > MAX_LANES_SUPPORT || pdata->mipi_lanes <= 0)
> > > > > > > > > >
> > > > > > > > > > Reviewed-by: Robert Foss <robert.foss@linaro.org>
> > > > > > > > >
> > > > > > > > > Acked-by: Robert Foss <robert.foss@linaro.org>
> > > > > > > >
> > > > > > > > Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> > > > > > > >
> > > > > > > > Confirmed this fixes the display on Juniper (Acer Chromebook Spin 311) on
> > > > > > > > mainline (next-20220422).
> > > > > > > >
> > > > > > > > Xin, in the future, please send the whole series to all recipients of
> > > > > > > > all patches listed by get_maintainers.pl, not just the recipients of
> > > > > > > > each patch. In the case of this series, they should have been sent
> > > > > > > > to all of the mailing lists (media, devicetree, dri-devel) so that
> > > > > > > > everyone has the same, full view of the patches.
> > > > > > > Hi ChenYu, OK, I'll send to all media, devicetree, dri-devel next time.
> > > > > > > Thanks,
> > > > > > > Xin
> > > > > > > >
> > > > > > > > ChenYu
> > > > > >
> > > > > > Applied 3/4 + 4/4 to drm-misc-next.
> > > > >
> > > > > This patch doesn't even compile. Can you pls fix this up asap? Also
> > > > > pls compile-test before pushing ...
> > > >
> > > > Marek says the prerequisite landed through linux-media, and that's why
> > > > it compilers on linux-next but not in drm-misc-next.
> > > >
> > > > Don't do that.
> > > >
> > > > Instead:
> > > > - merge all patches through one branch, with the foreign patches acked
> > > > for that merge patch
> > > > - wait until you can backmerge all the dependencies
> > > > - do a topic branch
> > > >
> > > > This probably needs to be reverted here and instead merged through
> > > > linux-media. Or you wait until -rc1 and then apply it to
> > > > drm-misc-next.
> > > > -Daniel
> > > Hi Daniel, I use git send-email to upstream patch and automatically
> > > generated reviewer list, so patch 1/4 and 2/4 send to linux-media, and
> > > these 2 patches already merged in linux-media.
> >
> > This is one of the reasons why you should always send the "full" series
> > to all recipients. That way people, especially maintainers, are more
> > likely to notice build time cross tree dependencies like this one, and
> > work towards a common resolution.
>
> This mistake is mine, and I think the best solution is to revert 3+4 until rc1.

I think we can reland the patches now?

ChenYu

> I'll send out the revert patches to the ML right away.
>
>
> Rob.
