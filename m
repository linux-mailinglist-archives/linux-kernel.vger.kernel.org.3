Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374794B93B2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 23:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbiBPWOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 17:14:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiBPWOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 17:14:14 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3D72AED8A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 14:14:01 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso3725470pjg.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 14:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4VcCHzkbx92lKzN5iSgXZZP1r2m6Tf5NY9ub+af1qNE=;
        b=alnOtElqFTR7tub9zwA5y2rQNa2AuphIVynD+IFhZH5iTb2z4/Tz/fN30KE3MZ/Hs0
         wPLl+MGfJqBc2Fp0hgok4YyGs29o6EMznRGh17e/uDhTHstLK+SUCtPhefSOr1rcfQHw
         GzRNELKEkw8tlB/4BtEPzfOVB6f2wrBZyKp1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4VcCHzkbx92lKzN5iSgXZZP1r2m6Tf5NY9ub+af1qNE=;
        b=1HCHSO671kNwLyo/R/DO5fnI5ht5YFI55Vn98sSnoTBNJvr364SvzjL79wV5lkwNPy
         nEnJ1VBs2A9B+cWcErEYOXfdIKjDHXTiOubToCawPbTlqwRdGWsPtUU/u/XS9Yf2lydV
         DbOYVr+fJlgJ5+LCKeiSoGBFG520gK266LBTEslWU3HjmC9uVML3b+KBAHdUSc0gYnqy
         vbMN8X0hidyQdaujZYE9oolXjVH9RzJWQZXVpjLqIVopxaip7EPmE/Bof0LweoElCyq+
         X8CPFs0/jSgOFrZ9LhnTHxnN4xnRkQk2odAkbmy2zbXUyRZm4BP985VvPYA8d55oHuf5
         tIkg==
X-Gm-Message-State: AOAM531FdjpXLqPteSpdB3ycd9SdJouVjFpGo3PV9bKbE3jJUAFlChY9
        kEphwP6L5G6+NxNyshkMfHZHvw==
X-Google-Smtp-Source: ABdhPJwFkhpu+gfz4+Q3Zh6Blan0TvjKrac1gpFy9X+Ca8I2pJuSpvGTKbw6B6DwuXIf8uZU8jEMeg==
X-Received: by 2002:a17:902:ab92:b0:14d:8c80:dbff with SMTP id f18-20020a170902ab9200b0014d8c80dbffmr20543plr.89.1645049641286;
        Wed, 16 Feb 2022 14:14:01 -0800 (PST)
Received: from localhost ([2620:15c:202:201:20:e0d2:8c14:1e68])
        by smtp.gmail.com with UTF8SMTPSA id mz16sm55296pjb.53.2022.02.16.14.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 14:14:00 -0800 (PST)
Date:   Wed, 16 Feb 2022 14:13:58 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        amit daniel kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pierre.Gondois@arm.com, Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/2] thermal: cooling: Check Energy Model type in
 cpufreq_cooling and devfreq_cooling
Message-ID: <Yg13JoHLmeFGPOAW@google.com>
References: <20220207073036.14901-1-lukasz.luba@arm.com>
 <20220207073036.14901-2-lukasz.luba@arm.com>
 <YgG+TmLrCSXX4Bvt@google.com>
 <4a7d4e94-1461-5bac-5798-29998af9793a@arm.com>
 <YgKnnFl7Gp8AS30X@google.com>
 <e4532f65-7f8a-7e89-97c1-85cc61462040@arm.com>
 <YgQ9XLcto9v0fyTf@google.com>
 <d120110a-7d01-0cfd-f7eb-d160e17ec2a8@arm.com>
 <CAD=FV=VntGw1_AzJPpdOk0zSpOVZRH2X1JNg84JX+zCeU1jvXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=VntGw1_AzJPpdOk0zSpOVZRH2X1JNg84JX+zCeU1jvXg@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 09:33:50AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Wed, Feb 16, 2022 at 7:35 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >
> > Hi Matthias,
> >
> > On 2/9/22 10:17 PM, Matthias Kaehlcke wrote:
> > > On Wed, Feb 09, 2022 at 11:16:36AM +0000, Lukasz Luba wrote:
> > >>
> > >>
> > >> On 2/8/22 5:25 PM, Matthias Kaehlcke wrote:
> > >>> On Tue, Feb 08, 2022 at 09:32:28AM +0000, Lukasz Luba wrote:
> > >>>>
> > >>>>
> >
> > [snip]
> >
> > >>>> Could you point me to those devices please?
> > >>>
> > >>> arch/arm64/boot/dts/qcom/sc7180-trogdor-*
> > >>>
> > >>> Though as per above they shouldn't be impacted by your change, since the
> > >>> CPUs always pretend to use milli-Watts.
> > >>>
> > >>> [skipped some questions/answers since sc7180 isn't actually impacted by
> > >>>    the change]
> > >>
> > >> Thank you Matthias. I will investigate your setup to get better
> > >> understanding.
> > >
> > > Thanks!
> > >
> >
> > I've checked those DT files and related code.
> > As you already said, this patch is safe for them.
> > So we can apply it IMO.
> >
> >
> > -------------Off-topic------------------
> > Not in $subject comments:
> >
> > AFAICS based on two files which define thermal zones:
> > sc7180-trogdor-homestar.dtsi
> > sc7180-trogdor-coachz.dtsi
> >
> > only the 'big' cores are used as cooling devices in the
> > 'skin_temp_thermal' - the CPU6 and CPU7.
> >
> > I assume you don't want to model at all the power usage
> > from the Little cluster (which is quite big: 6 CPUs), do you?
> > I can see that the Little CPUs have small dyn-power-coeff
> > ~30% of the big and lower max freq, but still might be worth
> > to add them to IPA. You might give them more 'weight', to
> > make sure they receive more power during power split.

In experiments we saw that including the little cores as cooling
devices for 'skin_temp_thermal' didn't have a significant impact on
thermals, so we left them out.

> > You also don't have GPU cooling device in that thermal zone.
> > Based on my experience if your GPU is a power hungry one,
> > e.g. 2-4Watts, you might get better results when you model
> > this 'hot' device (which impacts your temp sensor reported value).
> 
> I think the two boards you point at (homestar and coachz) are just the
> two that override the default defined in the SoC dtsi file. If you
> look in sc7180.dtsi you'll see 'gpuss1-thermal' which has a cooling
> map. You can also see the cooling maps for the littles.

Yep, plus thermal zones with cooling maps for the big cores.

> I guess we don't have a `dynamic-power-coefficient` for the GPU,
> though? Seems like we should, but I haven't dug through all the code
> here...

To my knowledge the SC7x80 GPU doesn't register an energy model, which is
one of the reasons the GPU wasn't included as cooling device for
'skin_temp_thermal'.
