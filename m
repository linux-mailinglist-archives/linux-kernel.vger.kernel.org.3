Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CD750330F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiDPAPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 20:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiDPAPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 20:15:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E57C4B1CF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 17:12:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ks6so17788923ejb.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 17:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEfZQ7sh46e4BCqZ+u0nu8S8W6NzsVlQxblVYVMyAI0=;
        b=nMqyfMNyP0mFIWiOnHm2qjsizdjmYnQERx8vP1aRYxhgEuIW5CNZQray6vswaha8Wb
         hvqUho5Yw3VFj7Wyrgsd8wrWoRPQ21scvhZxdnZPptEAVGxdx/ouGIAM/ExiMkjhGhoE
         vN5/Xz7OoCTz9W9O09YUdH8vgBFooaaTLOx04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEfZQ7sh46e4BCqZ+u0nu8S8W6NzsVlQxblVYVMyAI0=;
        b=ZdXqrDAJeXPIHKAuu+r7hKHtaCJmuzytuABXJSpFakvMbjK2ZxQnqCEfP+XS94bB6U
         GHsAveishiRgDk+c68LIUvyMXiegFNotkjJd+Lk6FX5dNvelBsd3ogNZHKlS0/kQJty4
         xP2Pwvdiv6GbM0b19Du710kei9Tkrl9mSlZyCNNJBmtsa9LdAy1ttGJFyaNXlKLLvr6N
         UvMGIIRYJDzZGy3iZ5Ex33gEbGNd8FuVS0LbsVn8HhIEtc4Y20VDSA3MwhI0xXpB4Oxb
         LClj4ib1s9pDzTgqmVGSq9lJuMhDckX29nU3Vl2/NZ6XRh01BbVggA9+At0+yB+Gd+Lh
         7BRw==
X-Gm-Message-State: AOAM533U9YCac35jDtK9iUYL13/dAaR131PtYDHN7fwJsUWOCw8P+C6M
        Td4EeUlQspOj6QfCZYJOQPuh1LyYqo9xiw==
X-Google-Smtp-Source: ABdhPJwAKPohqL6F0KLABuYc7HjPZi8ESgaZbCxYkDYd8c7JrEaFiFrxCTt9/XzV5n9Mk6qvty4+Ow==
X-Received: by 2002:a17:906:6dc4:b0:6e8:465d:65c3 with SMTP id j4-20020a1709066dc400b006e8465d65c3mr1017433ejt.179.1650067946710;
        Fri, 15 Apr 2022 17:12:26 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id i3-20020a056402054300b00423133147cesm784666edx.38.2022.04.15.17.12.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 17:12:23 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so5798415wmn.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 17:12:23 -0700 (PDT)
X-Received: by 2002:a05:600c:3d0e:b0:38f:f83b:e7dc with SMTP id
 bh14-20020a05600c3d0e00b0038ff83be7dcmr5121467wmb.29.1650067942637; Fri, 15
 Apr 2022 17:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220409023628.2104952-1-dianders@chromium.org>
 <20220408193536.RFC.4.Icea616f57331fbaa3d48c529f300c9a8ebd37fb5@changeid>
 <027b3ca1-fbd3-7bce-1ca0-ec92a5f23fee@linaro.org> <CAD=FV=Xu7b=t1C4JHF4U9BsD9wFy_x_GseJFNytHdCKvnS9DoA@mail.gmail.com>
 <CAA8EJppyBTDeFVztS2rTihAwEjJdmJf1Md-Qa3x3MijVvbzSUQ@mail.gmail.com>
In-Reply-To: <CAA8EJppyBTDeFVztS2rTihAwEjJdmJf1Md-Qa3x3MijVvbzSUQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Apr 2022 17:12:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XbCggB6kVwE8jj3DO3GWXj=_LeXatST3S9h91kh32nEw@mail.gmail.com>
Message-ID: <CAD=FV=XbCggB6kVwE8jj3DO3GWXj=_LeXatST3S9h91kh32nEw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/6] drm/panel-edp: Take advantage of
 is_hpd_asserted() in struct drm_dp_aux
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Robert Foss <robert.foss@linaro.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 15, 2022 at 3:12 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Sat, 16 Apr 2022 at 00:17, Doug Anderson <dianders@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, Apr 14, 2022 at 5:51 PM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On 09/04/2022 05:36, Douglas Anderson wrote:
> > > > Let's add support for being able to read the HPD pin even if it's
> > > > hooked directly to the controller. This will allow us to get more
> > > > accurate delays also lets us take away the waiting in the AUX transfer
> > > > functions of the eDP controller drivers.
> > > >
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > >
> > > >   drivers/gpu/drm/panel/panel-edp.c | 37 ++++++++++++++++++++++++++-----
> > > >   1 file changed, 31 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> > > > index 1732b4f56e38..4a143eb9544b 100644
> > > > --- a/drivers/gpu/drm/panel/panel-edp.c
> > > > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > > > @@ -417,6 +417,19 @@ static int panel_edp_get_hpd_gpio(struct device *dev, struct panel_edp *p)
> > > >       return 0;
> > > >   }
> > > >
> > > > +static bool panel_edp_can_read_hpd(struct panel_edp *p)
> > > > +{
> > > > +     return !p->no_hpd && (p->hpd_gpio || (p->aux && p->aux->is_hpd_asserted));
> > > > +}
> > > > +
> > > > +static bool panel_edp_read_hpd(struct panel_edp *p)
> > > > +{
> > > > +     if (p->hpd_gpio)
> > > > +             return gpiod_get_value_cansleep(p->hpd_gpio);
> > > > +
> > > > +     return p->aux->is_hpd_asserted(p->aux);
> > > > +}
> > > > +
> > > >   static int panel_edp_prepare_once(struct panel_edp *p)
> > > >   {
> > > >       struct device *dev = p->base.dev;
> > > > @@ -441,13 +454,21 @@ static int panel_edp_prepare_once(struct panel_edp *p)
> > > >       if (delay)
> > > >               msleep(delay);
> > > >
> > > > -     if (p->hpd_gpio) {
> > > > +     if (panel_edp_can_read_hpd(p)) {
> > > >               if (p->desc->delay.hpd_absent)
> > > >                       hpd_wait_us = p->desc->delay.hpd_absent * 1000UL;
> > > >               else
> > > >                       hpd_wait_us = 2000000;
> > > >
> > > > -             err = readx_poll_timeout(gpiod_get_value_cansleep, p->hpd_gpio,
> > > > +             /*
> > > > +              * Extra max delay, mostly to account for ps8640. ps8640
> > > > +              * is crazy and the bridge chip driver itself has over 200 ms
> > > > +              * of delay if it needs to do the pm_runtime resume of the
> > > > +              * bridge chip to read the HPD.
> > > > +              */
> > > > +             hpd_wait_us += 3000000;
> > >
> > > I think this should come in a separate commit and ideally this should be
> > > configurable somehow. Other hosts wouldn't need such 'additional' delay.
> > >
> > > With this change removed:
> > >
> > > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >
> > What would you think about changing the API slightly? Instead of
> > is_hpd_asserted(), we change it to wait_hpd_asserted() and it takes a
> > timeout in microseconds. If you pass 0 for the timeout the function is
> > defined to behave the same as is_hpd_asserted() today--AKA a single
> > poll of the line.
>
> This might work. Can you check it, please?

Cool. I'll spin with this. Hopefully early next week unless my inbox
blows up. ...or my main PC's SSD like happened this week. ;-)


> BTW: are these changes dependent on the first part of the patchset? It
> might be worth splitting the patchset into two parts.

Definitely not. As per the cover letter, this is two series jammed
into one. I'm happy to split them up. The 2nd half seems much less
controversial.

-Doug
