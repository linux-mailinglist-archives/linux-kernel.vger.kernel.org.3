Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C939505D75
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346960AbiDRRVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346942AbiDRRVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:21:52 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006BC326D3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:19:10 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bv19so28023674ejb.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hShcqueyqrsgg0nlHOYglfRVrKUYvQyqRq0mzAsVRd8=;
        b=HkdEVtZ6KkJEkKw+oi3Jy0KdkO1wNb3rdQY4K8vz/R7uCo9kDsXnY8g39eEzLmMcTq
         dGcYe9e/RhyQVYYkUK4yqqjgLNYpx4D173zLxpH7n+P6Cv6vbSC4YdLTk9SKTIJYznap
         Eg4nu5KLYsfS7W9EKvMvZzjaa+I7IjnQVCEek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hShcqueyqrsgg0nlHOYglfRVrKUYvQyqRq0mzAsVRd8=;
        b=hx1+fW6mtFQO6qPSBpj/CzCGAYNRNMdokvZ7aYg975wJSeYhV/7JkxUue51AzLheN4
         oMkIyXlyzwdpK58nusNQ8um5Tyb9I9f1oEeLXzZaluGx25Mq5Mr5nHw7b8I7FhOiS/Fw
         QD86oVVZYV545WTL1kOf2fwi4nyejOM9vsMBD/6il/O1gjX7HMvbATDxW7dBIlBmHYlC
         UMF+7AyBK5LMz3vr+uC/dPEF5Mm2Gaq9BKacELoUnmm/okWDVOPD7kuyOl380spmh4uV
         aVlhLHDGg10az+xAGdT6AykCCKzJxu6tTOGPmZZnBvTZuibY6HVY1SaulT+sfgmrzLae
         YUNg==
X-Gm-Message-State: AOAM5325bQbUKm4I73E947x5O+p1dwK9qWUVdjs15ywVIjuydCKRRUm0
        FYRxXCtzQYju/BtM00VaoxstUO7UIDiBTa2/
X-Google-Smtp-Source: ABdhPJwaa64G742YCupjsZ5EpDK4n1zfleBj8tPj/Y91SXfbcxhjp9yslHJzzGn97j9EWPwoPLiABg==
X-Received: by 2002:a17:907:6090:b0:6e8:abda:8933 with SMTP id ht16-20020a170907609000b006e8abda8933mr10134350ejc.46.1650302349006;
        Mon, 18 Apr 2022 10:19:09 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id p17-20020a17090635d100b006efcc06218dsm583665ejb.18.2022.04.18.10.19.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 10:19:07 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id n40-20020a05600c3ba800b0038ff1939b16so7945870wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:19:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4f08:b0:391:fe3c:40e6 with SMTP id
 l8-20020a05600c4f0800b00391fe3c40e6mr14330057wmq.34.1650302346548; Mon, 18
 Apr 2022 10:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220409023628.2104952-1-dianders@chromium.org>
 <20220408193536.RFC.4.Icea616f57331fbaa3d48c529f300c9a8ebd37fb5@changeid>
 <027b3ca1-fbd3-7bce-1ca0-ec92a5f23fee@linaro.org> <CAD=FV=Xu7b=t1C4JHF4U9BsD9wFy_x_GseJFNytHdCKvnS9DoA@mail.gmail.com>
 <CAA8EJppyBTDeFVztS2rTihAwEjJdmJf1Md-Qa3x3MijVvbzSUQ@mail.gmail.com>
 <CAD=FV=XbCggB6kVwE8jj3DO3GWXj=_LeXatST3S9h91kh32nEw@mail.gmail.com> <835fa3cd-0777-1dea-972f-3e24d5aeda3a@linaro.org>
In-Reply-To: <835fa3cd-0777-1dea-972f-3e24d5aeda3a@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 18 Apr 2022 10:18:54 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VP+tcrCwBQeF+QTBcsTraZVzxQqnAKBQQ_Hb6CyUQ0BA@mail.gmail.com>
Message-ID: <CAD=FV=VP+tcrCwBQeF+QTBcsTraZVzxQqnAKBQQ_Hb6CyUQ0BA@mail.gmail.com>
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

On Fri, Apr 15, 2022 at 5:14 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 16/04/2022 03:12, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Apr 15, 2022 at 3:12 PM Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> >>
> >> On Sat, 16 Apr 2022 at 00:17, Doug Anderson <dianders@chromium.org> wrote:
> >>>
> >>> Hi,
> >>>
> >>> On Thu, Apr 14, 2022 at 5:51 PM Dmitry Baryshkov
> >>> <dmitry.baryshkov@linaro.org> wrote:
> >>>>
> >>>> On 09/04/2022 05:36, Douglas Anderson wrote:
> >>>>> Let's add support for being able to read the HPD pin even if it's
> >>>>> hooked directly to the controller. This will allow us to get more
> >>>>> accurate delays also lets us take away the waiting in the AUX transfer
> >>>>> functions of the eDP controller drivers.
> >>>>>
> >>>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >>>>> ---
> >>>>>
> >>>>>    drivers/gpu/drm/panel/panel-edp.c | 37 ++++++++++++++++++++++++++-----
> >>>>>    1 file changed, 31 insertions(+), 6 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
> >>>>> index 1732b4f56e38..4a143eb9544b 100644
> >>>>> --- a/drivers/gpu/drm/panel/panel-edp.c
> >>>>> +++ b/drivers/gpu/drm/panel/panel-edp.c
> >>>>> @@ -417,6 +417,19 @@ static int panel_edp_get_hpd_gpio(struct device *dev, struct panel_edp *p)
> >>>>>        return 0;
> >>>>>    }
> >>>>>
> >>>>> +static bool panel_edp_can_read_hpd(struct panel_edp *p)
> >>>>> +{
> >>>>> +     return !p->no_hpd && (p->hpd_gpio || (p->aux && p->aux->is_hpd_asserted));
> >>>>> +}
> >>>>> +
> >>>>> +static bool panel_edp_read_hpd(struct panel_edp *p)
> >>>>> +{
> >>>>> +     if (p->hpd_gpio)
> >>>>> +             return gpiod_get_value_cansleep(p->hpd_gpio);
> >>>>> +
> >>>>> +     return p->aux->is_hpd_asserted(p->aux);
> >>>>> +}
> >>>>> +
> >>>>>    static int panel_edp_prepare_once(struct panel_edp *p)
> >>>>>    {
> >>>>>        struct device *dev = p->base.dev;
> >>>>> @@ -441,13 +454,21 @@ static int panel_edp_prepare_once(struct panel_edp *p)
> >>>>>        if (delay)
> >>>>>                msleep(delay);
> >>>>>
> >>>>> -     if (p->hpd_gpio) {
> >>>>> +     if (panel_edp_can_read_hpd(p)) {
> >>>>>                if (p->desc->delay.hpd_absent)
> >>>>>                        hpd_wait_us = p->desc->delay.hpd_absent * 1000UL;
> >>>>>                else
> >>>>>                        hpd_wait_us = 2000000;
> >>>>>
> >>>>> -             err = readx_poll_timeout(gpiod_get_value_cansleep, p->hpd_gpio,
> >>>>> +             /*
> >>>>> +              * Extra max delay, mostly to account for ps8640. ps8640
> >>>>> +              * is crazy and the bridge chip driver itself has over 200 ms
> >>>>> +              * of delay if it needs to do the pm_runtime resume of the
> >>>>> +              * bridge chip to read the HPD.
> >>>>> +              */
> >>>>> +             hpd_wait_us += 3000000;
> >>>>
> >>>> I think this should come in a separate commit and ideally this should be
> >>>> configurable somehow. Other hosts wouldn't need such 'additional' delay.
> >>>>
> >>>> With this change removed:
> >>>>
> >>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>
> >>> What would you think about changing the API slightly? Instead of
> >>> is_hpd_asserted(), we change it to wait_hpd_asserted() and it takes a
> >>> timeout in microseconds. If you pass 0 for the timeout the function is
> >>> defined to behave the same as is_hpd_asserted() today--AKA a single
> >>> poll of the line.
> >>
> >> This might work. Can you check it, please?
> >
> > Cool. I'll spin with this. Hopefully early next week unless my inbox
> > blows up. ...or my main PC's SSD like happened this week. ;-)
> >
> >
> >> BTW: are these changes dependent on the first part of the patchset? It
> >> might be worth splitting the patchset into two parts.
> >
> > Definitely not. As per the cover letter, this is two series jammed
> > into one. I'm happy to split them up. The 2nd half seems much less
> > controversial.
>
> Great, let's get it in then. As you have time.

Breadcrumbs: I've posted this as:

https://lore.kernel.org/r/20220418171757.2282651-1-dianders@chromium.org

-Doug
