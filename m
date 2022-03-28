Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C364E97FE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242947AbiC1N0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiC1NZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:25:58 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09554A936
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:24:16 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id jx9so14035479pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k900ko74APDJL4JS5btQb2Wg1Egu6wfcKSVm5IbK2EA=;
        b=rsvGCdQblbOi9loD5mWsZDLJ4r3zmPAD7vHlyAMcMYsegyeasWQrNaR7wJTFA7gJ12
         IPDPPIfzhslRgyFkhMQmfNip/+tOL+lj9AibCS4mU2P041Dd9D4ZlxXaYr4Twm7le6rX
         fcdPIDgNLid+O/idfK/mojljObclRdUp9xRvehJ5EJQYjaCJCOv7kRl+HMfX6FJOEsb3
         ms72DLYYSgHYnrYsizR16FwF58lkjdzll7VTkJ02YFkGq2uGnusUE500nIU07qQmhQW3
         pJCY2oYVgKOD7cbBL1f40WPajZ3RObnH57ZJqoM2rJ7PcSytOSHwO1f0G0Jm7HDumEPD
         U9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k900ko74APDJL4JS5btQb2Wg1Egu6wfcKSVm5IbK2EA=;
        b=KoyF8iUuLy3TeJmeRK9tHqu0vpJxeyv7FUP5yq8chmHbiWwDxveGsWXDNQKPCGhyy9
         J6LOhBmnRinA2vJXBwAv2Ib19AVo/QCgbfQToOZUL33s/xpz7xVBNZKxa1LzSqx2zceg
         zfU3Fzp8GEEaLctDb0o2xwRRFmxdoXT2SRbddBlRbgpnlSrHNfiKl7RjKqqtvisl7x6F
         vY64t6GoCuZtEGZcl/1Ud+HgRsECNO4Xz6UTc9Iivm42uXbUYG/WAtgQpQa6lYw1Z0Lz
         sV1nTcLTgVoiZD5nS5S5raTZeE+lIggWXqZnZucvhTYLO0W+mXHRUHLFC3fmxWT4HPYX
         fLzQ==
X-Gm-Message-State: AOAM530Km0A0LrF5Ip0kGw/lUkQkgyPcM4PfIUylBpBbNQji9MyAUIK6
        kdP0eeTqnF+gRzStOOE/MVryqSW5jBIE5yTtZiHE4Q==
X-Google-Smtp-Source: ABdhPJwaF0wKQv33ANB5bA5bv4gTewTbmKGymsUnbTOlgelkOBHzHnvY0GanmDJKGKE2vLrSA5BhQg/dZPp1c4z2LGg=
X-Received: by 2002:a17:90b:3e85:b0:1c7:7eab:2649 with SMTP id
 rj5-20020a17090b3e8500b001c77eab2649mr29250564pjb.232.1648473856349; Mon, 28
 Mar 2022 06:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220317175852.799432-1-jose.exposito89@gmail.com> <4bd97d512e95845d7dd5a44d7713c59832676ada.camel@oss.nxp.com>
In-Reply-To: <4bd97d512e95845d7dd5a44d7713c59832676ada.camel@oss.nxp.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 28 Mar 2022 15:24:05 +0200
Message-ID: <CAG3jFysp1xas4eVcRh5rysbgrhLAEJvsfYjHU=gHDT_JECaEUg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: nwl-dsi: switch to devm_drm_of_get_bridge
To:     Liu Ying <victor.liu@oss.nxp.com>
Cc:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        andrzej.hajda@intel.com, narmstrong@baylibre.com,
        laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        p.zabel@pengutronix.de, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Mar 2022 at 10:25, Liu Ying <victor.liu@oss.nxp.com> wrote:
>
> On Thu, 2022-03-17 at 18:58 +0100, Jos=C3=A9 Exp=C3=B3sito wrote:
> > The function "drm_of_find_panel_or_bridge" has been deprecated in
> > favor of "devm_drm_of_get_bridge".
> >
> > Switch to the new function and reduce boilerplate.
> >
> > Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> >
> > ---
> >
> > v2: (Thanks to Liu Ying)
> >
> >  - Rebase on top of drm-misc-next
> >  - Remove drm_of_panel_bridge_remove
> > ---
> >  drivers/gpu/drm/bridge/nwl-dsi.c | 23 ++++-------------------
> >  1 file changed, 4 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c
> > b/drivers/gpu/drm/bridge/nwl-dsi.c
> > index e34fb09b90b9..de62e3fc6a59 100644
> > --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> > +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> > @@ -912,19 +912,11 @@ static int nwl_dsi_bridge_attach(struct
> > drm_bridge *bridge,
> >  {
> >       struct nwl_dsi *dsi =3D bridge_to_dsi(bridge);
> >       struct drm_bridge *panel_bridge;
> > -     struct drm_panel *panel;
> > -     int ret;
> > -
> > -     ret =3D drm_of_find_panel_or_bridge(dsi->dev->of_node, 1, 0,
> > &panel,
> > -                                       &panel_bridge);
> > -     if (ret)
> > -             return ret;
> >
> > -     if (panel) {
> > -             panel_bridge =3D drm_panel_bridge_add(panel);
> > -             if (IS_ERR(panel_bridge))
> > -                     return PTR_ERR(panel_bridge);
> > -     }
> > +     panel_bridge =3D devm_drm_of_get_bridge(dsi->dev, dsi->dev-
> > >of_node,
> > +                                           1, 0);
> > +     if (IS_ERR(panel_bridge))
> > +             return PTR_ERR(panel_bridge);
> >
> >       if (!panel_bridge)
> >               return -EPROBE_DEFER;
>
> I don't think panel_bridge can be NULL here, so this check can be
> removed.  However, even if this patch is not applied, the check is not
> necessary.  I think it can be removed with a separate patch.

Jos=C3=A9, do you mind clearing up if this check is needed, and then
spinning a v3 removing this snippet if it is needed?

Rob.
