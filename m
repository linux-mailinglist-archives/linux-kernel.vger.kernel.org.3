Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462AA54BD20
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 23:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358442AbiFNV6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237959AbiFNV6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:58:16 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8621B1D322
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:58:15 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id z11so7576220ilq.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dh0EwzPz3kqagP+w6qwTm8phrVMK+QxhIfwoboe697M=;
        b=OYiWPsiSfA672A8Ec/CxKQHsYFYdfR8PBm9YnzByfBJE63ZFeEC4Wkh1leHLQaPk0c
         qrwPp9Royg8qntCuq7K3zRL3/P5RF3CLDXgzwYexeyFSPsGRR24wDzWc4kPDt57PybJe
         7+G8/Jty/jyysvXv5N5jjYXx2xw5seJMd5LsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dh0EwzPz3kqagP+w6qwTm8phrVMK+QxhIfwoboe697M=;
        b=ObVS34rxVYskdGDshrvur+2itqHg9tKgVjU25tPcsvnXoxE95bYBgLyK1PdgD+C2Fr
         fGwiIUojG9BC5mFBEtCEKjtqlsjIN/vj/RMpSQJ4taHKfTW8PHiM2lcF5nGidcUwmhwR
         tuewKB4TlTZQCBmvxdiE/3+IZjmcf60Igbn/HUIkfi9JWB0SPnH1yYnYFTW+qeoa3Y5P
         1N6XOHuLDcRHfrW96XoqRsWur4lPQXeKGJ3sSDEU8FPOHegmkh8/nhuRguvmu/+1zefI
         QiUk886QBLBL/481CVZeaFXxwSRGAiLzTyX7qoEO7pADdqa36bNjacOdNOkti+19rX+T
         ILMg==
X-Gm-Message-State: AJIora+5GYtuz2fTnqMELCaxEfCbNvbWzbtURERW1coUxt1/S1OKmKny
        jum68NJ0PeQuClUjHeHgpcpdOlvziv75Ql3r
X-Google-Smtp-Source: AGRyM1sGjUxp65904RW0tCUaTsQXZuT4aEDA8TKbI6vENpyQQxwqz+h+WTayFhQxIZhV3MTyv2zHtw==
X-Received: by 2002:a92:c567:0:b0:2d1:c3df:eff8 with SMTP id b7-20020a92c567000000b002d1c3dfeff8mr4152153ilj.84.1655243894759;
        Tue, 14 Jun 2022 14:58:14 -0700 (PDT)
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com. [209.85.166.177])
        by smtp.gmail.com with ESMTPSA id g18-20020a02c552000000b00332122c106dsm5393218jaj.152.2022.06.14.14.58.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 14:58:13 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id d6so7584546ilm.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:58:13 -0700 (PDT)
X-Received: by 2002:a05:6e02:1a6f:b0:2d3:ada4:2f11 with SMTP id
 w15-20020a056e021a6f00b002d3ada42f11mr4211456ilv.256.1655243893406; Tue, 14
 Jun 2022 14:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220418171757.2282651-1-dianders@chromium.org>
 <20220418101725.v3.2.Icea616f57331fbaa3d48c529f300c9a8ebd37fb5@changeid> <eb66c55c-cecb-0af0-8800-0a9e59d67a9b@linaro.org>
In-Reply-To: <eb66c55c-cecb-0af0-8800-0a9e59d67a9b@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Jun 2022 14:57:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UhjnhZ8sERSugPbYomCMaYJig5_QYx_0=ZWAuNyaB+ww@mail.gmail.com>
Message-ID: <CAD=FV=UhjnhZ8sERSugPbYomCMaYJig5_QYx_0=ZWAuNyaB+ww@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drm/panel-edp: Take advantage of
 wait_hpd_asserted() in struct drm_dp_aux
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        Philip Chen <philipchen@chromium.org>,
        Robert Foss <robert.foss@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 2, 2022 at 8:12 AM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 18/04/2022 20:17, Douglas Anderson wrote:
> > Let's add support for being able to read the HPD pin even if it's
> > hooked directly to the controller. This will allow us to get more
> > accurate delays also lets us take away the waiting in the AUX transfer
> > functions of the eDP controller drivers.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> > ---
> >
> > (no changes since v2)
> >
> > Changes in v2:
> > - Change is_hpd_asserted() to wait_hpd_asserted()
> >
> >   drivers/gpu/drm/panel/panel-edp.c | 33 +++++++++++++++++++++----------
> >   1 file changed, 23 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> > index 1732b4f56e38..086e0bf52fb9 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -417,6 +417,11 @@ static int panel_edp_get_hpd_gpio(struct device *dev, struct panel_edp *p)
> >       return 0;
> >   }
> >
> > +static bool panel_edp_can_read_hpd(struct panel_edp *p)
> > +{
> > +     return !p->no_hpd && (p->hpd_gpio || (p->aux && p->aux->wait_hpd_asserted));
> > +}
> > +
> >   static int panel_edp_prepare_once(struct panel_edp *p)
> >   {
> >       struct device *dev = p->base.dev;
> > @@ -441,17 +446,21 @@ static int panel_edp_prepare_once(struct panel_edp *p)
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
> > -                                      hpd_asserted, hpd_asserted,
> > -                                      1000, hpd_wait_us);
> > -             if (hpd_asserted < 0)
> > -                     err = hpd_asserted;
> > +             if (p->hpd_gpio) {
> > +                     err = readx_poll_timeout(gpiod_get_value_cansleep,
> > +                                              p->hpd_gpio, hpd_asserted,
> > +                                              hpd_asserted, 1000, hpd_wait_us);
> > +                     if (hpd_asserted < 0)
> > +                             err = hpd_asserted;
> > +             } else {
> > +                     err = p->aux->wait_hpd_asserted(p->aux, hpd_wait_us);
> > +             }
>
> I'm close to thinking that this construct deserves a separate helper.

Just to close the loop: I didn't try to create a helper for v5. I'm
not completely convinced that this will be common. I would tend to
expect that having HPD handled by a GPIO is somewhat rare. It's also
fairly rare to have a panel that's not handled by the generic
panel-edp. We ended up with the GPIO on trogdor because of the weird
debouncing on sn85dsi86 and we ended up with one case of not using
edp-panel on trogdor because of the weird power sequencing of the
Samsung OLED panel that's on homestar.

I'd also note that the generic eDP panel has a special case for
"timeout" which we don't have on the Samsung panel to handle at least
one panel I found that sometimes simply didn't come up but then
_would_ come up on a retry...

That doesn't mean we couldn't abstract it out later, of course. ;-)

-Doug


-Doug
