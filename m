Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DBA4C886A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbiCAJpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234023AbiCAJpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:45:12 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E038BF28
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 01:44:29 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id bn33so21097183ljb.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 01:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tjQCk98JCF7B3SGsqfK7HCesLKkHD86YZukO/DPNtQ0=;
        b=a8275fH6+9IRL38qqLDpyS1w3TvaCjlAatrh/47PQJbn4W9iIUucAQap9bigDyxECn
         TXaLOGyZ8vmF2KfxrLtFGMbL5xvYfDic9jf5mRMMfkkRR7Aybbrgh+tf+R6j/jj/lp4L
         uCUr0PvhEU0tGNaiPU9hT+w4+Op4ut5G5kMZnISMemoP4168OXOfw3jvBdq8JP1eoWq5
         proOhu5a2wmS5TdyBmY1plpSlnDUBG4ZO3Y+ZVYUWCg2oPG82YYwJxJ0G0ZJvfphr2ZA
         lNZQx/+ln4Ri5Yx37fm7l3jukl/i/7u/bCVcl0JY5Gv7mEpBKJJeu4xt2bHWs2p8eoHC
         +00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tjQCk98JCF7B3SGsqfK7HCesLKkHD86YZukO/DPNtQ0=;
        b=qG3QCpl+SOAI0O2r6IwOUmrMbD1A7U5UEhOYlcwFvmuXfpOf/Jg3AiF1ns620OUTMl
         mSl70zPA+4YtJLFdKg0eZyFZP7nY7wjbMfYON/XCxqPXS7K5L/XNDj/ekL+qjkWtUdqF
         /eERGm9XAmdrv1ESnHikxdMTkiftRMa87C+1sHkkZFRnnt38Qec2f4e+j0tiltfmKynr
         HUccJTA7cvQIbq+WhUWcu8sFhsLC/j2xPhbAde0rgYh0/a+Ot7O0EncVcDF59N/IuBLd
         XH9FOaIIxEQfy42ERe7ug7YAgU5KZnD3zdz4XAM/NTn2y8gfdaB0AV+BFQX/nNfDOhgE
         H6zQ==
X-Gm-Message-State: AOAM530yq3Ds+0x/VEhT0js5ln5yWoG3HGZ3+AEBZkeA6yM+iaeyw7J+
        DS61LuBwKcieCSfSYRSVDK+jrxRBG9stp6tZlCnopNYhD/ijCA==
X-Google-Smtp-Source: ABdhPJyupqbG0bQBQuInFjyG0YrLQq20BUN2lbd8XOqgYzbsx/NwNLqnc9QaRAEmfHcJbhpij1nqLzfCko4SgKUaGbQ=
X-Received: by 2002:a2e:86d4:0:b0:246:40eb:2c18 with SMTP id
 n20-20020a2e86d4000000b0024640eb2c18mr17093954ljj.16.1646127867471; Tue, 01
 Mar 2022 01:44:27 -0800 (PST)
MIME-Version: 1.0
References: <20220223080323.3717853-1-s.hauer@pengutronix.de> <20220223080858.GJ9136@pengutronix.de>
In-Reply-To: <20220223080858.GJ9136@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Mar 2022 10:43:50 +0100
Message-ID: <CAPDyKFpyCepZ_J4LNZzz-g90RLT1mVDMbQ-gNKweM8YnEWXqdg@mail.gmail.com>
Subject: Re: [PATCH] PM: domains: use dev_err_probe() to simplify error handling
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-kernel@vger.kernel.org, Kernel@pengutronix.de,
        "Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022 at 09:09, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> On Wed, Feb 23, 2022 at 09:03:23AM +0100, Sascha Hauer wrote:
> > From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> >
> > dev_err_probe() can reduce code size, makes the code easier to read
> > and has the added benefit of recording the defer reason for later
> > read out. Use it where appropriate.
> >
> > This also fixes an issue, where an error message in __genpd_dev_pm_attach
> > was not terminated by a line break.
> >
> > Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > ---
> >  drivers/base/power/domain.c | 21 ++++++---------------
> >  1 file changed, 6 insertions(+), 15 deletions(-)
>
> And of course:
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Next time, please add me on the to-list, otherwise it's likely that I
will fail to review your patch.

Kind regards
Uffe

>
> Sascha
>
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 5db704f02e712..29428ae91349d 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -2248,12 +2248,8 @@ int of_genpd_add_provider_simple(struct device_node *np,
> >       /* Parse genpd OPP table */
> >       if (genpd->set_performance_state) {
> >               ret = dev_pm_opp_of_add_table(&genpd->dev);
> > -             if (ret) {
> > -                     if (ret != -EPROBE_DEFER)
> > -                             dev_err(&genpd->dev, "Failed to add OPP table: %d\n",
> > -                                     ret);
> > -                     return ret;
> > -             }
> > +             if (ret)
> > +                     return dev_err_probe(&genpd->dev, ret, "Failed to add OPP table\n");
> >
> >               /*
> >                * Save table for faster processing while setting performance
> > @@ -2312,9 +2308,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
> >               if (genpd->set_performance_state) {
> >                       ret = dev_pm_opp_of_add_table_indexed(&genpd->dev, i);
> >                       if (ret) {
> > -                             if (ret != -EPROBE_DEFER)
> > -                                     dev_err(&genpd->dev, "Failed to add OPP table for index %d: %d\n",
> > -                                             i, ret);
> > +                             dev_err_probe(&genpd->dev, ret,
> > +                                           "Failed to add OPP table for index %d\n", i);
> >                               goto error;
> >                       }
> >
> > @@ -2672,12 +2667,8 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
> >       ret = genpd_add_device(pd, dev, base_dev);
> >       mutex_unlock(&gpd_list_lock);
> >
> > -     if (ret < 0) {
> > -             if (ret != -EPROBE_DEFER)
> > -                     dev_err(dev, "failed to add to PM domain %s: %d",
> > -                             pd->name, ret);
> > -             return ret;
> > -     }
> > +     if (ret < 0)
> > +             return dev_err_probe(dev, ret, "failed to add to PM domain %s\n", pd->name);
> >
> >       dev->pm_domain->detach = genpd_dev_pm_detach;
> >       dev->pm_domain->sync = genpd_dev_pm_sync;
> > --
> > 2.30.2
> >
> >
> >
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
