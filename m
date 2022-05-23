Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABA55313F2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238481AbiEWQGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbiEWQGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:06:11 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4ED186CB
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:06:08 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-e93bbb54f9so18986616fac.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wfWyXqKDw6KMyeqQToN3+pb4tfYQnyQoFUsrYr2tg34=;
        b=kU/xLlvMMyizZPnrw/4g+bnPtd5LqlyHH+Wc94Nexqf4uQOgnwARiQhcDDDorC42GV
         f+4eN4fP6cKJUo1p5XyyBY5O+rFnPqiEyC9e6YUpIxAbC67AnnKN5mqBPvGl846M+Ft8
         Th/vxhr4vaBwomnkON2BJHdsPuv4Y2lnbNQAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wfWyXqKDw6KMyeqQToN3+pb4tfYQnyQoFUsrYr2tg34=;
        b=WqER5JR5T34eZ+fk79hphIsi7YtqDD3R+VBFsYbAzpk+HmArrFx6nvNqthsvCpxZ/G
         d1E+IXlsjldp5mOrsnN6nhyn9t79Q/N+FsnIXoQGNYlTJlzy3TTMksnphYFCUpiAOaER
         EWan1bvTOs22Lo2hz/aOEZUvQk44U4mhZmGt15niv7AWm8jLwMosEvxs1Y2qiW4YQgOm
         m6bElUFFFemUDCsP8tg86aLPa4RZS1NEpaS7t0wZbPJKc+NQXbzvR1Y2ib9CXH17Ioy6
         pZ9k4JUzkPRs7SLnXjhhdsiYaNoBRqCFqlopVhcGeXDAggxK6gRakRb95Se/UHMs851c
         Qt4A==
X-Gm-Message-State: AOAM5308MQYBkga0zV4sC0zmNt56vGXuxATVcnTNwFYTBIvOJZJqSBgp
        jsGExEuQl3ePtGGF6kJ7y4qEMPw67Fv3Lt+fgyM74Q==
X-Google-Smtp-Source: ABdhPJxCSCqEX0AX/mFMKV9Nszvd1kSvfb5PoopVXRLMDu0j/BF8/r6jTeX7U8ExRKBQB1j15KZ26tYC51B1MxbiPjE=
X-Received: by 2002:a05:6870:eaa5:b0:da:b3f:2b45 with SMTP id
 s37-20020a056870eaa500b000da0b3f2b45mr13576965oap.228.1653321967446; Mon, 23
 May 2022 09:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220523084615.13510-1-robert.foss@linaro.org>
 <CAG3jFytkFcmYjj6AHye3imsTDyP1LxHQvAzjswuRBsVVHRTnKg@mail.gmail.com> <CAG3jFytGDm29GVAQ5bs7XQ+hMDABd7btggFGN2pASBEzRPE50A@mail.gmail.com>
In-Reply-To: <CAG3jFytGDm29GVAQ5bs7XQ+hMDABd7btggFGN2pASBEzRPE50A@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Mon, 23 May 2022 18:05:56 +0200
Message-ID: <CAKMK7uGmnM1GXi_6yovZApBo34B5ojrN1KZOqpKBDgUUDorQ6w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Revert "drm/bridge: anx7625: Use DPI bus type"
To:     Robert Foss <robert.foss@linaro.org>
Cc:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, xji@analogixsemi.com,
        hsinyi@chromium.org, sam@ravnborg.org, tzimmermann@suse.de,
        maxime@cerno.tech, jose.exposito89@gmail.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, 23 May 2022 at 14:54, Robert Foss <robert.foss@linaro.org> wrote:
> These two patches need to be reverted since they were part (3/4 & 4/4)
> of a series, that was partially (1/4 + 2/4) on the linux-media tree.
> These two patches depend on the patches in the media tree, and will
> not build without them, which leaves linux-drm-misc-next in a broken
> state. Let's revert the two latter patches until rc1 has been branched

"rc1 has been backmerged into drm-misc-next" is missing here.

> and the dependency wont cause issues any more.

With explainer and sob added to both:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>
> On Mon, 23 May 2022 at 14:50, Robert Foss <robert.foss@linaro.org> wrote:
> >
> > On Mon, 23 May 2022 at 10:46, Robert Foss <robert.foss@linaro.org> wrote:
> > >
> > > This reverts commit a77c2af0994e24ee36c7ffb6dc852770bdf06fb1.
> > > ---
> > >  drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > index 01f46d9189c1..53a5da6c49dd 100644
> > > --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> > > @@ -1623,14 +1623,14 @@ static int anx7625_parse_dt(struct device *dev,
> > >
> > >         anx7625_get_swing_setting(dev, pdata);
> > >
> > > -       pdata->is_dpi = 0; /* default dsi mode */
> > > +       pdata->is_dpi = 1; /* default dpi mode */
> > >         pdata->mipi_host_node = of_graph_get_remote_node(np, 0, 0);
> > >         if (!pdata->mipi_host_node) {
> > >                 DRM_DEV_ERROR(dev, "fail to get internal panel.\n");
> > >                 return -ENODEV;
> > >         }
> > >
> > > -       bus_type = 0;
> > > +       bus_type = V4L2_FWNODE_BUS_TYPE_PARALLEL;
> > >         mipi_lanes = MAX_LANES_SUPPORT;
> > >         ep0 = of_graph_get_endpoint_by_regs(np, 0, 0);
> > >         if (ep0) {
> > > @@ -1640,8 +1640,8 @@ static int anx7625_parse_dt(struct device *dev,
> > >                 mipi_lanes = of_property_count_u32_elems(ep0, "data-lanes");
> > >         }
> > >
> > > -       if (bus_type == V4L2_FWNODE_BUS_TYPE_DPI) /* bus type is DPI */
> > > -               pdata->is_dpi = 1;
> > > +       if (bus_type == V4L2_FWNODE_BUS_TYPE_PARALLEL) /* bus type is Parallel(DSI) */
> > > +               pdata->is_dpi = 0;
> > >
> > >         pdata->mipi_lanes = mipi_lanes;
> > >         if (pdata->mipi_lanes > MAX_LANES_SUPPORT || pdata->mipi_lanes <= 0)
> > > --
> > > 2.34.1
> > >
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
