Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45A950B9D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354535AbiDVORN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448537AbiDVORB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:17:01 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9575AA56
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:13:58 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id s17so11108292plg.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zXfqWdJ/GLvoUjS9UlqMERMZ6c4eq4qtAdP5ouoRFc4=;
        b=yIL5pQgjVaJ1DFw/YwfK1UT/MWPCZp6d/YcNkK4HhELe/z4lnFdIq7Fl3CX3OwML/u
         zgEFZi9dezIwX82IHBOHOCczRcHGp77leR3ZNiGwFBJ1hYaJ/WECNZI9zi7UTNR9qRlO
         fNk0poWubxKn+BH+FNcvz1oqYx1V4R0VEM3+UVEhLgqRRWWrlLrBzk/3okzTSKxW1Mxs
         kALuYQ3cSA63urCDTDVQeebyfVxkXnTCmHeV/Pcnon7I6SrOotxDXeTYdDjFN0c+4K36
         DcatoPPpF9Ix9ID3GgeAdSPV66Mk77nQvlOOTYw5vo+4L4sekwajdyLFb4vCuE3pc0gx
         w3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zXfqWdJ/GLvoUjS9UlqMERMZ6c4eq4qtAdP5ouoRFc4=;
        b=JsJZzZoM5BVz4tJZTU0+Iz1mWtfHBugjZSOD24eXlDXEu5sE++7giatyAgt8yn+5Up
         p6WI2ZArzdsYzMPhonFuL10mhszjGNFh8kZuMmJCn0r+kvt5h6FRdDgjhnZkEWYJPWNn
         hrF/KNFH5B51LeGqIDbi4r776vBhm25iTjWhXC5dMRt4HJADNpkgpPb+BMCOTEbw5I2q
         XqsxA/aSkEKYJAK9OoD8TnITliDaE/uxHSBmdADGtXzlX1Lzo6YhS5LSo5CGA1+AoUW2
         SFPepE2xSlb+0VeZoaXF8UTuicj80m/jVLDPfEX/6S+BWaDIIiejkIcuii1OP2N0W+Ya
         99yQ==
X-Gm-Message-State: AOAM533tenfmvaia24YIrpnO+WosEOokPAXrcwZcMluje9TBBH7U26fH
        QIRV8+zG/4rV9ACi8YLSxEDRhDKPBx/x9c2rhr60Fg==
X-Google-Smtp-Source: ABdhPJzaKXh6kEeQvJ0coQDYWC9K1l7I0I2hJf8QO31KN+Ct4SXnJgNEKwRmPz9WuOlwyHrfPm7yIiMj6+T+6kV/VcM=
X-Received: by 2002:a17:90a:6501:b0:1ca:a7df:695c with SMTP id
 i1-20020a17090a650100b001caa7df695cmr5673540pjj.152.1650636837577; Fri, 22
 Apr 2022 07:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220422084720.959271-1-xji@analogixsemi.com> <20220422084720.959271-4-xji@analogixsemi.com>
 <CAG3jFytWGSUM9mevHewdmEe-hq3JgB74s7_f0fsEQqkXr9VUHg@mail.gmail.com>
In-Reply-To: <CAG3jFytWGSUM9mevHewdmEe-hq3JgB74s7_f0fsEQqkXr9VUHg@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 22 Apr 2022 16:13:46 +0200
Message-ID: <CAG3jFyvEYbwkdGtiNR-6vFEXTLjcyT_viqp9qeVxFTu0PrJEVA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/bridge: anx7625: Use DPI bus type
To:     Xin Ji <xji@analogixsemi.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, bliang@analogixsemi.com,
        qwen@analogixsemi.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 at 16:01, Robert Foss <robert.foss@linaro.org> wrote:
>
> On Fri, 22 Apr 2022 at 10:49, Xin Ji <xji@analogixsemi.com> wrote:
> >
> > As V4L2_FWNODE_BUS_TYPE_PARALLEL not properly descript for DPI
> > interface, this patch use new defined V4L2_FWNODE_BUS_TYPE_DPI for it.
> >
> > Fixes: fd0310b6fe7d ("drm/bridge: anx7625: add MIPI DPI input feature")
> > Signed-off-by: Xin Ji <xji@analogixsemi.com>
> > ---
> >  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > index 376da01243a3..71df977e8f53 100644
> > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > @@ -1623,14 +1623,14 @@ static int anx7625_parse_dt(struct device *dev,
> >
> >         anx7625_get_swing_setting(dev, pdata);
> >
> > -       pdata->is_dpi = 1; /* default dpi mode */
> > +       pdata->is_dpi = 0; /* default dsi mode */
> >         pdata->mipi_host_node = of_graph_get_remote_node(np, 0, 0);
> >         if (!pdata->mipi_host_node) {
> >                 DRM_DEV_ERROR(dev, "fail to get internal panel.\n");
> >                 return -ENODEV;
> >         }
> >
> > -       bus_type = V4L2_FWNODE_BUS_TYPE_PARALLEL;
> > +       bus_type = 0;
> >         mipi_lanes = MAX_LANES_SUPPORT;
> >         ep0 = of_graph_get_endpoint_by_regs(np, 0, 0);
> >         if (ep0) {
> > @@ -1640,8 +1640,8 @@ static int anx7625_parse_dt(struct device *dev,
> >                 mipi_lanes = of_property_count_u32_elems(ep0, "data-lanes");
> >         }
> >
> > -       if (bus_type == V4L2_FWNODE_BUS_TYPE_PARALLEL) /* bus type is Parallel(DSI) */
> > -               pdata->is_dpi = 0;
> > +       if (bus_type == V4L2_FWNODE_BUS_TYPE_DPI) /* bus type is DPI */
> > +               pdata->is_dpi = 1;
> >
> >         pdata->mipi_lanes = mipi_lanes;
> >         if (pdata->mipi_lanes > MAX_LANES_SUPPORT || pdata->mipi_lanes <= 0)
>
> Reviewed-by: Robert Foss <robert.foss@linaro.org>

Acked-by: Robert Foss <robert.foss@linaro.org>
