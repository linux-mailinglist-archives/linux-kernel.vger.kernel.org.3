Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E671F591342
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238708AbiHLPqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbiHLPqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:46:44 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7163C89CF1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 08:46:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bv3so1624583wrb.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 08:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=wY2wJzljookmEC1F1StVR6S14+jQKj2NtRY3+c8Hbi8=;
        b=lpxXAbpCNtbOaH6gsk2CtWK/121Dhziate1za29ZN4EwS1Nh7qOdiIeumOxYdWUSIs
         ddjnAkcSVSErsMbWtTK2C+KmgM7RKzlWCMbmd2HAt8gOZj3JOX6V2LD/Oz6+NftlWlDA
         30zCmSYBa3RY480Fshf/os9ONeu7vEb0a3t8Ov8zAYprFZB37Zfb90nH+nw+L/jtvgdI
         OohUVKbrHT+7xlxc5LbyeWAJhAFCDw9qnxL+HMqi8OSOe9Fm1Y+BfmU5520WZ1tDbGhS
         7Or+3iDQ0EMZtmXL8yw8JGh44xoW7XBTPR8I8qZ/5WLpkZXLu+T75Nx5WS5WsEBCNZ4a
         PAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=wY2wJzljookmEC1F1StVR6S14+jQKj2NtRY3+c8Hbi8=;
        b=4T/xXOaIK8ZZIb88JZnvCRhy67aJpOO4Oc7B7dAPeFsqxpm2j+9j0JmYm2YykxjV4q
         M7KsFlbu8F9gcx6WbNniooCn6b+bTtNItq1jskQEPiL0SciUsOeO3W5yXa2SWwQ3i544
         bYFs4+/0WX8bTfbV80T2ejlWyiHUyYHwcmgPfsNsXJrDxvvz6joAs3nkZ3SdaEDlgyp0
         EfnybPFptacXUHS718FxR7TSUBqL/5ro+ORlEJwJCyyfFeoVZb2tAAfNp4KjUXWpb76l
         A4juaYTdnwCMUunid6DgD0hmaHrW6Ti4UZna0ISg58Q6gGXaarKJ4Y497hg54V9HX6Dc
         rjaA==
X-Gm-Message-State: ACgBeo3CUGgDt5SJJetZLprEcpqjgVey6Goz/JpKf8bJ3F8qJ4A/fyUT
        rhMiBb+/33hNU6DCrf03Deu2zQ==
X-Google-Smtp-Source: AA6agR5gbGTPIqyZkksnw4a+qwWfoYdh9dWlz6KZzWyFUk0pdF+Gim4VBmdYjganxKzB2Z5yIH6UhA==
X-Received: by 2002:a5d:6dc9:0:b0:21e:6e6d:f3da with SMTP id d9-20020a5d6dc9000000b0021e6e6df3damr2428211wrz.234.1660319199801;
        Fri, 12 Aug 2022 08:46:39 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id i5-20020a1c3b05000000b003a503a64e5esm10320854wma.15.2022.08.12.08.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 08:46:38 -0700 (PDT)
Date:   Fri, 12 Aug 2022 18:46:37 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RFC] PM: domains: Reverse the order of performance and enabling
 ops
Message-ID: <YvZ13R9st43MHBKJ@linaro.org>
References: <20220720110246.762939-1-abel.vesa@linaro.org>
 <CAPDyKFoh8UV=QC6RhOkc=FSvoeqF_UiWp97h0Qp8dniB=sS+8A@mail.gmail.com>
 <YuA0luCtQ1J+ExBi@linaro.org>
 <CAPDyKFo4tryzYQK=q6aPGxocmoq=duC2B1RMh1QoV_maVCApjA@mail.gmail.com>
 <20220729094646.xqlhfjzxo3gk4n27@linaro.org>
 <CAPDyKFoEzvD1PRGEc4NQmAGnewZtxyW226vWRWndAijSn=fbNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoEzvD1PRGEc4NQmAGnewZtxyW226vWRWndAijSn=fbNw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-08-12 15:14:30, Ulf Hansson wrote:
> On Fri, 29 Jul 2022 at 11:46, Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > On 22-07-28 13:37:38, Ulf Hansson wrote:
> > > + Dmitry, Thierry
> > >
> > > On Tue, 26 Jul 2022 at 20:38, Abel Vesa <abel.vesa@linaro.org> wrote:
> > > >
> > > > On 22-07-21 18:48:10, Ulf Hansson wrote:
> > > > > On Wed, 20 Jul 2022 at 13:03, Abel Vesa <abel.vesa@linaro.org> wrote:
> > > > > >
> > > > > > Rather than enabling and then setting the performance state, which usually
> > > > > > translates into two different levels (voltages) in order to get to the
> > > > > > one required by the consumer, we could give a chance to the providers to
> > > > > > cache the performance state needed by the consumer and then, when powering
> > > > > > on the power domain, the provider could use the cached level instead.
> > > > >
> > > > > I don't think it's really clear what you want to do here. Let's see
> > > > > what the discussion below brings us to, but for the next version
> > > > > please elaborate a bit more in the commit message.
> > > >
> > > > Sorry about that. Will give more details in the next version.
> > > >
> > > > >
> > > > > Although, if I understand correctly (also from our offlist
> > > > > discussions), you want to make it possible to move from two calls,
> > > > > into one call into the FW from the genpd provider. So it's basically
> > > > > an optimization, which to me, certainly sounds worth doing.
> > > > >
> > > > > Furthermore, to get the complete picture, in the Qcom case, we set a
> > > > > "default" low performance level from the genpd's ->power_on()
> > > > > callback, which is needed to enable basic functionality for some
> > > > > consumers.
> > > > >
> > > > > The second call that I refer to is made when genpd calls the
> > > > > ->set_performance() callback (from genpd_runtime_suspend()), which is
> > > > > done by genpd to potentially set a new value for an aggregated
> > > > > performance state of the PM domain. In case when there actually is a
> > > > > new performance state set in this path, we end up calling the FW twice
> > > > > for the Qcom case, where this first one is unnecessary.
> > > > >
> > > > > Did I get that right?
> > > >
> > > > Actually, for every ->power_on, there is a ->set_performance right after.
> > > >
> > > > For example, on genpd_runtime_suspend, this is done:
> > > >
> > > >         genpd_lock(genpd);
> > > >         ret = genpd_power_on(genpd, 0);
> > > >         if (!ret)
> > > >                 genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
> > > >         genpd_unlock(genpd);
> > > >
> > > > And same thing on __genpd_dev_pm_attach.
> > >
> > > I guess you refer to genpd_runtime_resume(), but never mind, I get it.
> >
> > Yes, I meant _resume.
> >
> > >
> > > Note that, I only wanted to highlight  that genpd doesn't necessarily
> > > invoke the ->set_performance() callback at genpd_runtime_resume(). It
> > > depends on whether there is a new performance level to be set for the
> > > device (which also needs to aggregate to a new level for the genpd in
> > > question).
> >
> > Yes, I get that. But if there is no new performance level to be set, the
> > order doesn't matter. Right?
> >
> > >
> > > >
> > > > Now, TBH, I can't think of any scenario where a consumer would want its PD powered,
> > > > (which implies a non-zero voltage level) and then changed to a higher performance
> > > > level (higher voltage).
> > > >
> > > > In most scenarios, though, the consumer needs the PD powered on to a specific voltage
> > > > level.
> > >
> > > Yes, this sounds reasonable to me too.
> > >
> > > However, in some cases there are certain orders of how things need to
> > > be "powered on", there may be clocks etc that need to be managed
> > > carefully to not break HW or cause glitches, for example.
> >
> > Totally agree. Maybe this would be another reason for the
> > ->set_performance to be called before the ->power_on. Think about it
> > as the equivalent of clk_prepare in the CCF. Makes sense to have an
> > initial preparation before actually enabling the PD. And this
> > preparation should include the performance level as information passed
> > to the provider.
> >
> > >
> > > I have looped in Dmitry and Thierry to see if they think the change
> > > should be fine for Tegra platforms too.
> > >
> >
> > Good. But the tegra usecase uses only the ->set_performance and does not
> > use ->power_on and ->power_off for that specific PD. So I don't think
> > their usecase will be affected by the order reverse.
> >
> > > >
> > > > Based on the two statements above, we need ->set_performance to actually act as
> > > > a way to tell the provider to which voltage level to power on the power domain
> > > > when the ->power_on will be called.
> > > >
> > > > So my suggestion with this patch is to reverse the order, do ->set_performance first
> > > > and then ->power_on, this way the provider receives the voltage level required by
> > > > a consumer before the request to power on the PD. Then a provider might use that
> > > > info when powering on/off that PD.
> > >
> > > Yes, that should work fine. At least for the power on scenario. Let's
> > > discuss more about the power off scenario below.
> > >
> > > >
> > > > >
> > > > > > Also the drop_performance and power_off have to be reversed so that
> > > > > > when the last active consumer suspends, the level doesn't actually drop
> > > > > > until the pd is disabled.
> > > > >
> > > > > I don't quite get what this part helps with, is it really needed to
> > > > > improve the behaviour?
> > > >
> > > > Again, why would a consumer need its PD voltage dropped before being powered off?
> > >
> > > Similar to powering on a device/PM domain, we need to be careful about
> > > the order of how we turn things off. Other than that, you are probably
> > > right.
> >
> > Again, there are multiple qcom providers that use these and all of them
> > need the order reversed. Other than the that, there is the tegra single
> > PD case which would not be impacted, as I explained above.
> >
> > >
> > > However, I don't quite understand how reversing the order of calling
> > > the ->power_off() callback and the ->set_performance_state() would
> > > help the provider to implement this. See more below.
> > >
> >
> > Please correct me where I'm wrong, but here is the most popular scenario as
> > I see it.
> >
> > Device A needs the PD enabled at the lowest performance level, so
> > ->set_performance passes on that information to the provider and then,
> > on ->power_on, the provider uses that performance level to power on that
> > PD. This can be done by a single call to FW on power_on.
> >
> > Now lets assume there is another device (B) that needs same PD at the
> > highest performance level, so genpd calls into the provider performance
> > call, which checks if the PD is on and if so, it writes the new value to
> > FW.
> >
> > On power off, lets assume device B runtime suspends first, so the
> > ->set_performance will 'release' that higher performance level, so the
> > provider will do another call to FW (since the PD is enabled) with the
> > lowest performance level, which is still needed by device B. In this case,
> 
> /s/device B/device A (I assume)
> 
> > the ->power_off will not even be called.
> 
> Right.
> 
> >
> > When the last active consumer suspends (in our case here, device A), ->power_off
> > will be called first disabling the PD, then the ->set_performance will
> > 'release' that lowest perf level the device A requested but will not
> > call to FW since the PD is already disabled. This would make
> > sure there are not two calls with two different levels to the FW.
> 
> I understand what you want to achieve, but I think the ->power_off()
> scenario may be a bit more tricky.
> 
> For example, it would be perfectly fine for genpd to keep the PM
> domain powered-on, even when the device A gets runtime suspended (a
> genpd governor may prevent it). In other words, we may end up not
> getting the ->power_off() callback invoked at all, even if there are
> no runtime resumed devices in the PM domain.
> 
> Could this lead to problems on the provider side, when trying to take
> into account the different combinations of sequences?

Correct me if I'm wrong, but even if a genpd governor would prevent
the power_off to be called, if we do the reversal, since the power
domain is not off, the provider would lower the performance state and
that's it. The responsability falls on the provider, but so does with
the current order of the calls.

So I don't see how this could lead to problems compared to the current
order of the calls.

Maybe I missunderstood your point, so please correct me if I'm getting
this wrong.

> 
> >
> > Now, most of this depends on the provider's way of doing things.
> > But in order to allow the provider to do what is described above, it
> > needs to know about the perf level before it is asked to power on a PD.
> > Same applies to powering off.
> >
> > > >
> > > > I think it makes more sense for the ->set_performance in this case to act as a
> > > > way to tell the provider that a specific device has yeilded its voltage level
> > > > request. That way the provider can drop the voltage to the minimum requested by
> > > > the active consumers of that PD.
> > >
> > > The genpd provider can know if the PM domain is powered on or off,
> > > when the ->set_performance_state() callback is invoked. If it's
> > > powered off, it may then decide to "cache" the request for the
> > > performance level request, until it gets powered on.
> >
> > But the ->set_performance is called only after ->power_on, so the PD
> > will always be on when ->set_performance checks. And this is what my
> > patch is trying to change actually.
> >
> > >
> > > Although, I don't see how a genpd provider should be able to cache a
> > > performance state request, when the PM domain is already powered on
> > > (which is what you propose, if I understand correctly), that simply
> > > doesn't work for the other scenarios.
> >
> > I explained this above. The provider will need to check if the PD is on
> > and only write to FW if it is. Otherwise it will cache the value for
> > when the power_on is called.
> 
> As indicated above, it looks to me that you may need to check a
> combination of things at the provider side. Is relying on whether
> genpd is on/off to decide when to apply or cache a performance state,
> really sufficient? I could certainly be wrong though.

I don't think there is any change from this point of view, when compared
to the current order. Even with the current order, the provider would
either cache the performance state if the power domain is off, or would
apply it if the power domain is on.

> 
> Perhaps if you can provide a corresponding patch for the genpd
> provider side too, that can help to convince me.

The qcom-rpmhpd actually does that even now. On set_performance, it caches
the performance state (corner) if the power domain is disabled, and it
applies (aggregates the corner) if the power domain is enabled.

> 
> [...]
> 
> Kind regards
> Uffe
