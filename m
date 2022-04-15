Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB6C5030D7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354520AbiDOVUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 17:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353572AbiDOVUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 17:20:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3019EDFD50
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:17:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id s25so10641011edi.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EfZB9gZ26i32vvI5wBO459/sXHKxXquhYVeMgZP1nIY=;
        b=MNDq7I+E+p6wsMtvTjH7DSkPLNzz2b6A6JAJCsbbgqxQyaGG5VKeOkbWnr407BBF8Y
         RRBhruC/M9VHiKDKPpJusoMXXIncG/YrsiTBGRIWnV8PMV4q2bD3ABWklQVcne2p9q47
         ShfAUu/vn20kTQM02/YkUxqyhfoPZFVoPqCOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EfZB9gZ26i32vvI5wBO459/sXHKxXquhYVeMgZP1nIY=;
        b=zHpjFu+LpXuX+svURkzLesGfp37R1K4U08G2UNzuQRVtA9UTzk94c7ING++rL7i+6H
         JoJtnqIFiaKJEHzLgVxKdyE/vh6fv5vrm3hUBZTx6FzNmJ5XVr0YZkninMzrCayGyu40
         G0I+jmkbBgHJw8RoKwFqSBwztpzKWGRGrhPhFoebtdfArPmhx0oa1tgcUArInjEa9BHU
         o9iOu998z5uDmj3ARJlFRoBH//Yb5HTffcvNXJ6HQx6FrXpNW7xdohapzihVe1adP2r4
         MbQHFw7gr2bvMN8BogspNgz8OaCJIlfNJ5LbKVxOZbRUrRZwrpl1vyhoTZzFIQWxiVXy
         N77w==
X-Gm-Message-State: AOAM531lebbnAP5mWs1R1vjQR+EKYxCq9B7fIUGTHC2mFBEnwvJGMDyR
        tQxZBJVLttMOSB8e3HqkyeqKm6wcBF/WXg==
X-Google-Smtp-Source: ABdhPJy0MOOxuFwj1jeqkA+gpH06FK/6dvkD2u1EOs8Rnq+azs0YDVGBiAKJr6mbymPTKXOREgCGDQ==
X-Received: by 2002:aa7:c04e:0:b0:400:4daf:bab1 with SMTP id k14-20020aa7c04e000000b004004dafbab1mr982932edo.101.1650057458356;
        Fri, 15 Apr 2022 14:17:38 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id gy10-20020a170906f24a00b006e894144707sm2049560ejb.53.2022.04.15.14.17.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 14:17:37 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id m33-20020a05600c3b2100b0038ec0218103so5626868wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 14:17:37 -0700 (PDT)
X-Received: by 2002:a05:600c:3d0e:b0:38f:f83b:e7dc with SMTP id
 bh14-20020a05600c3d0e00b0038ff83be7dcmr4734068wmb.29.1650057456890; Fri, 15
 Apr 2022 14:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220409023628.2104952-1-dianders@chromium.org>
 <20220408193536.RFC.4.Icea616f57331fbaa3d48c529f300c9a8ebd37fb5@changeid> <027b3ca1-fbd3-7bce-1ca0-ec92a5f23fee@linaro.org>
In-Reply-To: <027b3ca1-fbd3-7bce-1ca0-ec92a5f23fee@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Apr 2022 14:17:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xu7b=t1C4JHF4U9BsD9wFy_x_GseJFNytHdCKvnS9DoA@mail.gmail.com>
Message-ID: <CAD=FV=Xu7b=t1C4JHF4U9BsD9wFy_x_GseJFNytHdCKvnS9DoA@mail.gmail.com>
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

On Thu, Apr 14, 2022 at 5:51 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 09/04/2022 05:36, Douglas Anderson wrote:
> > Let's add support for being able to read the HPD pin even if it's
> > hooked directly to the controller. This will allow us to get more
> > accurate delays also lets us take away the waiting in the AUX transfer
> > functions of the eDP controller drivers.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >   drivers/gpu/drm/panel/panel-edp.c | 37 ++++++++++++++++++++++++++-----
> >   1 file changed, 31 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> > index 1732b4f56e38..4a143eb9544b 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -417,6 +417,19 @@ static int panel_edp_get_hpd_gpio(struct device *dev, struct panel_edp *p)
> >       return 0;
> >   }
> >
> > +static bool panel_edp_can_read_hpd(struct panel_edp *p)
> > +{
> > +     return !p->no_hpd && (p->hpd_gpio || (p->aux && p->aux->is_hpd_asserted));
> > +}
> > +
> > +static bool panel_edp_read_hpd(struct panel_edp *p)
> > +{
> > +     if (p->hpd_gpio)
> > +             return gpiod_get_value_cansleep(p->hpd_gpio);
> > +
> > +     return p->aux->is_hpd_asserted(p->aux);
> > +}
> > +
> >   static int panel_edp_prepare_once(struct panel_edp *p)
> >   {
> >       struct device *dev = p->base.dev;
> > @@ -441,13 +454,21 @@ static int panel_edp_prepare_once(struct panel_edp *p)
> >       if (delay)
> >               msleep(delay);
> >
> > -     if (p->hpd_gpio) {
> > +     if (panel_edp_can_read_hpd(p)) {
> >               if (p->desc->delay.hpd_absent)
> >                       hpd_wait_us = p->desc->delay.hpd_absent * 1000UL;
> >               else
> >                       hpd_wait_us = 2000000;
> >
> > -             err = readx_poll_timeout(gpiod_get_value_cansleep, p->hpd_gpio,
> > +             /*
> > +              * Extra max delay, mostly to account for ps8640. ps8640
> > +              * is crazy and the bridge chip driver itself has over 200 ms
> > +              * of delay if it needs to do the pm_runtime resume of the
> > +              * bridge chip to read the HPD.
> > +              */
> > +             hpd_wait_us += 3000000;
>
> I think this should come in a separate commit and ideally this should be
> configurable somehow. Other hosts wouldn't need such 'additional' delay.
>
> With this change removed:
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

What would you think about changing the API slightly? Instead of
is_hpd_asserted(), we change it to wait_hpd_asserted() and it takes a
timeout in microseconds. If you pass 0 for the timeout the function is
defined to behave the same as is_hpd_asserted() today--AKA a single
poll of the line.

-Doug
