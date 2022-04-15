Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3818150316C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 01:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356329AbiDOWOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 18:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiDOWOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 18:14:36 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74674473B8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 15:12:06 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ebf3746f87so94368947b3.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 15:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HsqXPexxYMVzLMlPpbKlOEvSDCYnqmBjUtOeVDxLnZs=;
        b=xhQ2AvW2Z1zqui2BTplZgbziBOulqJ1GuEv2l+ti0mytPxdwPTOduV9Lrd4EgKLZdZ
         vj5ZF1Q43oH0HPPhlIrcQRoilFOuoQgXAQYZSIaQJabLjs5hzu0wl1IDPDAgAuxVnyLa
         bz3LtuVl/3q62ZTWdbmPPYEV4Rsa8vuMAjxYIVi1dzDNcrIffKYS/QFyrZeg+N4c/EZQ
         JVZDNcplKTS6kZzFpXT+zas/cBQ7qUNYRWhMYcz652wAwfwVX2z6TwMiwoFRNsmvjR38
         tm7xFqAV7CjcM5ru5ce2mlRxMMR8gY/krWL7n1RMuLyGTX1O7lwAgPRUjb4uXkEwp+h9
         7nUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HsqXPexxYMVzLMlPpbKlOEvSDCYnqmBjUtOeVDxLnZs=;
        b=kIgpha/KSHISUteEH4qJdGNmoavBXW3u9YdEY8jd5Pypjsn1svXJ4DNE24g2U0E7Hf
         AScH5B2oxQtho0N+uVbEs8tii1X2Tz4x+JBm+f3hBsGlbvPvDR+pPbRg1okoGwVEXzYX
         2GaT6FLVbMk5dh98SLVXswoPSAsS+hrthdi97sVwuqY7p/BKc6gZD45f8YGQvvDayfoz
         jY7SZ5pkB3DB8aw0TtlantLc07G8iXeKUIdAWFz/4UXOTvO1RVRgVpzcZFVnMuMnADFa
         LuovsoFjHdrdQ81x2JbCRbkmNmyttCVSjC0cNpwhdGaFscYoNyH31x8nZ/9BoZ3UmQkm
         Sz6Q==
X-Gm-Message-State: AOAM533nFMh69qEug63OLrixsgwCjyWRGKLYEVSRIhboy2BhmZUShGyP
        sj/rYlbSUjwo08hy9qh/F1mUPb0HQ0ulerDhmWb+0g==
X-Google-Smtp-Source: ABdhPJzVoea4GIffohnCRr22ILa4ZrD82KPISDU+95GM4vH11cc3D6jmkGCqIQXE5NvprUoyY23DR23ZMd3mngkY9ts=
X-Received: by 2002:a81:753:0:b0:2eb:ebe9:ff4f with SMTP id
 80-20020a810753000000b002ebebe9ff4fmr886197ywh.255.1650060725233; Fri, 15 Apr
 2022 15:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220409023628.2104952-1-dianders@chromium.org>
 <20220408193536.RFC.4.Icea616f57331fbaa3d48c529f300c9a8ebd37fb5@changeid>
 <027b3ca1-fbd3-7bce-1ca0-ec92a5f23fee@linaro.org> <CAD=FV=Xu7b=t1C4JHF4U9BsD9wFy_x_GseJFNytHdCKvnS9DoA@mail.gmail.com>
In-Reply-To: <CAD=FV=Xu7b=t1C4JHF4U9BsD9wFy_x_GseJFNytHdCKvnS9DoA@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 16 Apr 2022 01:11:54 +0300
Message-ID: <CAA8EJppyBTDeFVztS2rTihAwEjJdmJf1Md-Qa3x3MijVvbzSUQ@mail.gmail.com>
Subject: Re: [RFC PATCH 4/6] drm/panel-edp: Take advantage of
 is_hpd_asserted() in struct drm_dp_aux
To:     Doug Anderson <dianders@chromium.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Apr 2022 at 00:17, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Apr 14, 2022 at 5:51 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On 09/04/2022 05:36, Douglas Anderson wrote:
> > > Let's add support for being able to read the HPD pin even if it's
> > > hooked directly to the controller. This will allow us to get more
> > > accurate delays also lets us take away the waiting in the AUX transfer
> > > functions of the eDP controller drivers.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > >   drivers/gpu/drm/panel/panel-edp.c | 37 ++++++++++++++++++++++++++-----
> > >   1 file changed, 31 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> > > index 1732b4f56e38..4a143eb9544b 100644
> > > --- a/drivers/gpu/drm/panel/panel-edp.c
> > > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > > @@ -417,6 +417,19 @@ static int panel_edp_get_hpd_gpio(struct device *dev, struct panel_edp *p)
> > >       return 0;
> > >   }
> > >
> > > +static bool panel_edp_can_read_hpd(struct panel_edp *p)
> > > +{
> > > +     return !p->no_hpd && (p->hpd_gpio || (p->aux && p->aux->is_hpd_asserted));
> > > +}
> > > +
> > > +static bool panel_edp_read_hpd(struct panel_edp *p)
> > > +{
> > > +     if (p->hpd_gpio)
> > > +             return gpiod_get_value_cansleep(p->hpd_gpio);
> > > +
> > > +     return p->aux->is_hpd_asserted(p->aux);
> > > +}
> > > +
> > >   static int panel_edp_prepare_once(struct panel_edp *p)
> > >   {
> > >       struct device *dev = p->base.dev;
> > > @@ -441,13 +454,21 @@ static int panel_edp_prepare_once(struct panel_edp *p)
> > >       if (delay)
> > >               msleep(delay);
> > >
> > > -     if (p->hpd_gpio) {
> > > +     if (panel_edp_can_read_hpd(p)) {
> > >               if (p->desc->delay.hpd_absent)
> > >                       hpd_wait_us = p->desc->delay.hpd_absent * 1000UL;
> > >               else
> > >                       hpd_wait_us = 2000000;
> > >
> > > -             err = readx_poll_timeout(gpiod_get_value_cansleep, p->hpd_gpio,
> > > +             /*
> > > +              * Extra max delay, mostly to account for ps8640. ps8640
> > > +              * is crazy and the bridge chip driver itself has over 200 ms
> > > +              * of delay if it needs to do the pm_runtime resume of the
> > > +              * bridge chip to read the HPD.
> > > +              */
> > > +             hpd_wait_us += 3000000;
> >
> > I think this should come in a separate commit and ideally this should be
> > configurable somehow. Other hosts wouldn't need such 'additional' delay.
> >
> > With this change removed:
> >
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>
> What would you think about changing the API slightly? Instead of
> is_hpd_asserted(), we change it to wait_hpd_asserted() and it takes a
> timeout in microseconds. If you pass 0 for the timeout the function is
> defined to behave the same as is_hpd_asserted() today--AKA a single
> poll of the line.

This might work. Can you check it, please?

BTW: are these changes dependent on the first part of the patchset? It
might be worth splitting the patchset into two parts.

-- 
With best wishes
Dmitry
