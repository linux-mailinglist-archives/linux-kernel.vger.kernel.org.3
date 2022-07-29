Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33505584E57
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 11:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbiG2Jqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 05:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbiG2Jqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 05:46:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218C01F609
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:46:50 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b6so2260802wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 02:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MDmF5QS33jQXUS1JhSWwpGQuwX9A2sSaoTcMcLMYLUo=;
        b=AHIf9t8R8HvFvTEls/vPZQoIRWKv8OccNB22EVwKmTiKYnlXFrRQzYaFdU9SYXmkfX
         E6skP32PX2JpY5vBjW9aoCLTJjQ5pYz9SntC+kReOGoN2ODgPbB6AG5LqnmqzWaLs+iw
         pCizmcCsfaExO2MFKoztpJFcUoOrdlruG7oabJTebXXhyFFMlIOncHSIAgUPvbs3iAZN
         KRQPofoLo1kSgP+j2jsXWEoZ0leVgaj4Vlr+nkGY6NUnUUYoe0sxpEQgs0RbzNGEE4U6
         2BvM3QakSbPVdm5XpHlxby4hagYHeJeuggzFoucGNHHkzvZ6xmRckx4IUOgMjw3FLUOM
         zuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MDmF5QS33jQXUS1JhSWwpGQuwX9A2sSaoTcMcLMYLUo=;
        b=XlfCsoUNKyv0SY8np665cLO75iIAWONFYCYHmUdr0RjroY8R8ky5kW+aA+w9xKYpvz
         WhIagXW3UmdQwCgiPrnZefa45WbbkVyh2DbIv6Ys4B5vzojUnFGGaN64HU95748zkSYm
         h5y2mgzMORmWj9vr7W0YBfhtRccqZ7jPHQv5K//IIUbzxQ2Q2fqnpHIu0YjzL7ymyIP2
         EcTbYmErTXP5bxmeFLqgxyGkCpqfU6NqQjyXa+dxyo8TOOvHufovU6uYZ0Yb+2Duh4Sq
         yMfGtFJOKhgDWfrZMJeRGX4Vg2w1HQJyAwhy7zrvJ6Dvs4rnGZibA0Zh6317kWbg98Gi
         R2ow==
X-Gm-Message-State: AJIora+Nsii2J+TF+c6u2iKvGu+daNiq+D1LhHFuUeniifKwDsvAmryl
        UCRoGT8MHlB1YkQwT0opThClQw==
X-Google-Smtp-Source: AGRyM1sAyx7FlJtXRaY7CaO8hKhU5nQs933sHl5efssIYF82QqVT5gKLfrs0AvI8HnrNbkM5TRF3/w==
X-Received: by 2002:a1c:f710:0:b0:394:1960:e8a1 with SMTP id v16-20020a1cf710000000b003941960e8a1mr1917315wmh.154.1659088008519;
        Fri, 29 Jul 2022 02:46:48 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id x17-20020a5d60d1000000b0021e7e050404sm3537644wrt.117.2022.07.29.02.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 02:46:47 -0700 (PDT)
Date:   Fri, 29 Jul 2022 12:46:46 +0300
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
Message-ID: <20220729094646.xqlhfjzxo3gk4n27@linaro.org>
References: <20220720110246.762939-1-abel.vesa@linaro.org>
 <CAPDyKFoh8UV=QC6RhOkc=FSvoeqF_UiWp97h0Qp8dniB=sS+8A@mail.gmail.com>
 <YuA0luCtQ1J+ExBi@linaro.org>
 <CAPDyKFo4tryzYQK=q6aPGxocmoq=duC2B1RMh1QoV_maVCApjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFo4tryzYQK=q6aPGxocmoq=duC2B1RMh1QoV_maVCApjA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-28 13:37:38, Ulf Hansson wrote:
> + Dmitry, Thierry
>
> On Tue, 26 Jul 2022 at 20:38, Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > On 22-07-21 18:48:10, Ulf Hansson wrote:
> > > On Wed, 20 Jul 2022 at 13:03, Abel Vesa <abel.vesa@linaro.org> wrote:
> > > >
> > > > Rather than enabling and then setting the performance state, which usually
> > > > translates into two different levels (voltages) in order to get to the
> > > > one required by the consumer, we could give a chance to the providers to
> > > > cache the performance state needed by the consumer and then, when powering
> > > > on the power domain, the provider could use the cached level instead.
> > >
> > > I don't think it's really clear what you want to do here. Let's see
> > > what the discussion below brings us to, but for the next version
> > > please elaborate a bit more in the commit message.
> >
> > Sorry about that. Will give more details in the next version.
> >
> > >
> > > Although, if I understand correctly (also from our offlist
> > > discussions), you want to make it possible to move from two calls,
> > > into one call into the FW from the genpd provider. So it's basically
> > > an optimization, which to me, certainly sounds worth doing.
> > >
> > > Furthermore, to get the complete picture, in the Qcom case, we set a
> > > "default" low performance level from the genpd's ->power_on()
> > > callback, which is needed to enable basic functionality for some
> > > consumers.
> > >
> > > The second call that I refer to is made when genpd calls the
> > > ->set_performance() callback (from genpd_runtime_suspend()), which is
> > > done by genpd to potentially set a new value for an aggregated
> > > performance state of the PM domain. In case when there actually is a
> > > new performance state set in this path, we end up calling the FW twice
> > > for the Qcom case, where this first one is unnecessary.
> > >
> > > Did I get that right?
> >
> > Actually, for every ->power_on, there is a ->set_performance right after.
> >
> > For example, on genpd_runtime_suspend, this is done:
> >
> >         genpd_lock(genpd);
> >         ret = genpd_power_on(genpd, 0);
> >         if (!ret)
> >                 genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
> >         genpd_unlock(genpd);
> >
> > And same thing on __genpd_dev_pm_attach.
>
> I guess you refer to genpd_runtime_resume(), but never mind, I get it.

Yes, I meant _resume.

>
> Note that, I only wanted to highlight  that genpd doesn't necessarily
> invoke the ->set_performance() callback at genpd_runtime_resume(). It
> depends on whether there is a new performance level to be set for the
> device (which also needs to aggregate to a new level for the genpd in
> question).

Yes, I get that. But if there is no new performance level to be set, the
order doesn't matter. Right?

>
> >
> > Now, TBH, I can't think of any scenario where a consumer would want its PD powered,
> > (which implies a non-zero voltage level) and then changed to a higher performance
> > level (higher voltage).
> >
> > In most scenarios, though, the consumer needs the PD powered on to a specific voltage
> > level.
>
> Yes, this sounds reasonable to me too.
>
> However, in some cases there are certain orders of how things need to
> be "powered on", there may be clocks etc that need to be managed
> carefully to not break HW or cause glitches, for example.

Totally agree. Maybe this would be another reason for the
->set_performance to be called before the ->power_on. Think about it
as the equivalent of clk_prepare in the CCF. Makes sense to have an
initial preparation before actually enabling the PD. And this
preparation should include the performance level as information passed
to the provider.

>
> I have looped in Dmitry and Thierry to see if they think the change
> should be fine for Tegra platforms too.
>

Good. But the tegra usecase uses only the ->set_performance and does not
use ->power_on and ->power_off for that specific PD. So I don't think
their usecase will be affected by the order reverse.

> >
> > Based on the two statements above, we need ->set_performance to actually act as
> > a way to tell the provider to which voltage level to power on the power domain
> > when the ->power_on will be called.
> >
> > So my suggestion with this patch is to reverse the order, do ->set_performance first
> > and then ->power_on, this way the provider receives the voltage level required by
> > a consumer before the request to power on the PD. Then a provider might use that
> > info when powering on/off that PD.
>
> Yes, that should work fine. At least for the power on scenario. Let's
> discuss more about the power off scenario below.
>
> >
> > >
> > > > Also the drop_performance and power_off have to be reversed so that
> > > > when the last active consumer suspends, the level doesn't actually drop
> > > > until the pd is disabled.
> > >
> > > I don't quite get what this part helps with, is it really needed to
> > > improve the behaviour?
> >
> > Again, why would a consumer need its PD voltage dropped before being powered off?
>
> Similar to powering on a device/PM domain, we need to be careful about
> the order of how we turn things off. Other than that, you are probably
> right.

Again, there are multiple qcom providers that use these and all of them
need the order reversed. Other than the that, there is the tegra single
PD case which would not be impacted, as I explained above.

>
> However, I don't quite understand how reversing the order of calling
> the ->power_off() callback and the ->set_performance_state() would
> help the provider to implement this. See more below.
>

Please correct me where I'm wrong, but here is the most popular scenario as
I see it.

Device A needs the PD enabled at the lowest performance level, so
->set_performance passes on that information to the provider and then,
on ->power_on, the provider uses that performance level to power on that
PD. This can be done by a single call to FW on power_on.

Now lets assume there is another device (B) that needs same PD at the
highest performance level, so genpd calls into the provider performance
call, which checks if the PD is on and if so, it writes the new value to
FW.

On power off, lets assume device B runtime suspends first, so the
->set_performance will 'release' that higher performance level, so the
provider will do another call to FW (since the PD is enabled) with the
lowest performance level, which is still needed by device B. In this case,
the ->power_off will not even be called.

When the last active consumer suspends (in our case here, device A), ->power_off
will be called first disabling the PD, then the ->set_performance will
'release' that lowest perf level the device A requested but will not
call to FW since the PD is already disabled. This would make
sure there are not two calls with two different levels to the FW.

Now, most of this depends on the provider's way of doing things.
But in order to allow the provider to do what is described above, it
needs to know about the perf level before it is asked to power on a PD.
Same applies to powering off.

> >
> > I think it makes more sense for the ->set_performance in this case to act as a
> > way to tell the provider that a specific device has yeilded its voltage level
> > request. That way the provider can drop the voltage to the minimum requested by
> > the active consumers of that PD.
>
> The genpd provider can know if the PM domain is powered on or off,
> when the ->set_performance_state() callback is invoked. If it's
> powered off, it may then decide to "cache" the request for the
> performance level request, until it gets powered on.

But the ->set_performance is called only after ->power_on, so the PD
will always be on when ->set_performance checks. And this is what my
patch is trying to change actually.

>
> Although, I don't see how a genpd provider should be able to cache a
> performance state request, when the PM domain is already powered on
> (which is what you propose, if I understand correctly), that simply
> doesn't work for the other scenarios.

I explained this above. The provider will need to check if the PD is on
and only write to FW if it is. Otherwise it will cache the value for
when the power_on is called.

>
> >
> > >
> > > >
> > > > For the power domains that do not provide the set_performance, things
> > > > remain unchanged, as does for the power domains that only provide the
> > > > set_performance but do not provide the power_on/off.
> > >
> > > Right, good points!
> > >
> > > I get back to review the code soon, just wanted to make sure I have
> > > the complete picture first.
> > >
> > > Kind regards
> > > Uffe
> > >
> > > >
> > > > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > > > ---
> > > >  drivers/base/power/domain.c | 30 +++++++++++++++---------------
> > > >  1 file changed, 15 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > > index 5a2e0232862e..38647c304b73 100644
> > > > --- a/drivers/base/power/domain.c
> > > > +++ b/drivers/base/power/domain.c
> > > > @@ -939,8 +939,8 @@ static int genpd_runtime_suspend(struct device *dev)
> > > >                 return 0;
> > > >
> > > >         genpd_lock(genpd);
> > > > -       gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
> > > >         genpd_power_off(genpd, true, 0);
> > > > +       gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
> > > >         genpd_unlock(genpd);
> > > >
> > > >         return 0;
> > > > @@ -978,9 +978,8 @@ static int genpd_runtime_resume(struct device *dev)
> > > >                 goto out;
> > > >
> > > >         genpd_lock(genpd);
> > > > +       genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
> > > >         ret = genpd_power_on(genpd, 0);
> > > > -       if (!ret)
> > > > -               genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
> > > >         genpd_unlock(genpd);
> > > >
> > > >         if (ret)
> > > > @@ -1018,8 +1017,8 @@ static int genpd_runtime_resume(struct device *dev)
> > > >  err_poweroff:
> > > >         if (!pm_runtime_is_irq_safe(dev) || genpd_is_irq_safe(genpd)) {
> > > >                 genpd_lock(genpd);
> > > > -               gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
> > > >                 genpd_power_off(genpd, true, 0);
> > > > +               gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
> > > >                 genpd_unlock(genpd);
> > > >         }
> > > >
> > > > @@ -2747,17 +2746,6 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
> > > >         dev->pm_domain->detach = genpd_dev_pm_detach;
> > > >         dev->pm_domain->sync = genpd_dev_pm_sync;
> > > >
> > > > -       if (power_on) {
> > > > -               genpd_lock(pd);
> > > > -               ret = genpd_power_on(pd, 0);
> > > > -               genpd_unlock(pd);
> > > > -       }
> > > > -
> > > > -       if (ret) {
> > > > -               genpd_remove_device(pd, dev);
> > > > -               return -EPROBE_DEFER;
> > > > -       }
> > > > -
> > > >         /* Set the default performance state */
> > > >         pstate = of_get_required_opp_performance_state(dev->of_node, index);
> > > >         if (pstate < 0 && pstate != -ENODEV && pstate != -EOPNOTSUPP) {
> > > > @@ -2769,6 +2757,18 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
> > > >                         goto err;
> > > >                 dev_gpd_data(dev)->default_pstate = pstate;
> > > >         }
> > > > +
> > > > +       if (power_on) {
> > > > +               genpd_lock(pd);
> > > > +               ret = genpd_power_on(pd, 0);
> > > > +               genpd_unlock(pd);
> > > > +       }
> > > > +
> > > > +       if (ret) {
> > > > +               genpd_remove_device(pd, dev);
> > > > +               return -EPROBE_DEFER;
> > > > +       }
> > > > +
> > > >         return 1;
> > > >
> > > >  err:
> > > > --
> > > > 2.34.3
> > > >
> > >
