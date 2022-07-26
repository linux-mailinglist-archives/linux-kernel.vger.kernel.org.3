Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8625819D8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbiGZSiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239496AbiGZSiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:38:20 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E46F240B1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 11:38:18 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v13so13550843wru.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 11:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j6N0pmFjTqcYOHHvMWdXLEZrWTcV8zp2h7HHkht5ViE=;
        b=ywaywuIvS7cTnJS09uyXPae4Azt6+q5qheewgaxEG63GjCPCWxiOSFaVxxgQqqEYfu
         urv9iD3hLCtsJJFh0pVSLrBYkxq7fNYwyld086b2Nix6h0ovq9TPiW9p3JXjJYwinUZe
         lknDuVNOG27+uwOIqgrsDK4QQjv+E+2in2w4/W2g7BRYd/UugqIuINSjLIH3KCHvJwsR
         VqPbuyECorN43RDFaYM48Zyqy6uNMKKunutOgPdTHVMhpgAQAt6NB6zGCsVINiOZpX0z
         gPMPKzlMcFFiugwWs2sm7ao5q20kY0Vp23vBgOoGAhEELTDU3HCrcrYtqgDVC2r2pqNB
         gYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j6N0pmFjTqcYOHHvMWdXLEZrWTcV8zp2h7HHkht5ViE=;
        b=T6yuK6uaTX+mjXFxoZmb5z9kdgn3vuDHpKO6NJmQ9U9zRAimjWct9zJMPgJGgun2O9
         C2liYhu7A5LOmtryEqT18fefcAmUkNIqZY4ScPE6JKapi7v9AJ5cl+fPNxfYUnwEPKFI
         L2OWbA9oyHaJNC/0DT4ynErtqS95vL41jnAHYUTutR4IgjOgZmkW/S9s43rESaaSJU/R
         8NkhjGVCLrX/yFLnsNJK8bpAwBSOlBtkC1nzwrczUe6lbPHJAqMIiiyp/JwTKCQXh29t
         BErUIxJs1SkaH3w9J9mA8IYynZdYMD1/NkPfaEEmMb1D6kZh0cQGS/C9BUKWlkNpipcj
         +l4Q==
X-Gm-Message-State: AJIora809e2xn/Lvr4cKVh98/j3rNplxobXiaHzpcXpP4IrnRl5/7Mvu
        c+ImBXjUJQ61LduKvwskYuVXXw==
X-Google-Smtp-Source: AGRyM1vZ4aIjBeDsIxo7OnqgPf9xQ+rIuz4ELfoYfGifICmrCLqwNOCq5LZ24NUUVvCdIv0/R1aM5A==
X-Received: by 2002:adf:f0ce:0:b0:21e:5eeb:f33e with SMTP id x14-20020adff0ce000000b0021e5eebf33emr11456384wro.362.1658860696589;
        Tue, 26 Jul 2022 11:38:16 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id k19-20020a05600c1c9300b003a31fd05e0fsm4520683wms.2.2022.07.26.11.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 11:38:15 -0700 (PDT)
Date:   Tue, 26 Jul 2022 21:38:14 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [RFC] PM: domains: Reverse the order of performance and enabling
 ops
Message-ID: <YuA0luCtQ1J+ExBi@linaro.org>
References: <20220720110246.762939-1-abel.vesa@linaro.org>
 <CAPDyKFoh8UV=QC6RhOkc=FSvoeqF_UiWp97h0Qp8dniB=sS+8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoh8UV=QC6RhOkc=FSvoeqF_UiWp97h0Qp8dniB=sS+8A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-21 18:48:10, Ulf Hansson wrote:
> On Wed, 20 Jul 2022 at 13:03, Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > Rather than enabling and then setting the performance state, which usually
> > translates into two different levels (voltages) in order to get to the
> > one required by the consumer, we could give a chance to the providers to
> > cache the performance state needed by the consumer and then, when powering
> > on the power domain, the provider could use the cached level instead.
>
> I don't think it's really clear what you want to do here. Let's see
> what the discussion below brings us to, but for the next version
> please elaborate a bit more in the commit message.

Sorry about that. Will give more details in the next version.

>
> Although, if I understand correctly (also from our offlist
> discussions), you want to make it possible to move from two calls,
> into one call into the FW from the genpd provider. So it's basically
> an optimization, which to me, certainly sounds worth doing.
>
> Furthermore, to get the complete picture, in the Qcom case, we set a
> "default" low performance level from the genpd's ->power_on()
> callback, which is needed to enable basic functionality for some
> consumers.
>
> The second call that I refer to is made when genpd calls the
> ->set_performance() callback (from genpd_runtime_suspend()), which is
> done by genpd to potentially set a new value for an aggregated
> performance state of the PM domain. In case when there actually is a
> new performance state set in this path, we end up calling the FW twice
> for the Qcom case, where this first one is unnecessary.
>
> Did I get that right?

Actually, for every ->power_on, there is a ->set_performance right after.

For example, on genpd_runtime_suspend, this is done:

	genpd_lock(genpd);
	ret = genpd_power_on(genpd, 0);
	if (!ret)
        	genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
	genpd_unlock(genpd);

And same thing on __genpd_dev_pm_attach.

Now, TBH, I can't think of any scenario where a consumer would want its PD powered,
(which implies a non-zero voltage level) and then changed to a higher performance
level (higher voltage).

In most scenarios, though, the consumer needs the PD powered on to a specific voltage
level.

Based on the two statements above, we need ->set_performance to actually act as
a way to tell the provider to which voltage level to power on the power domain
when the ->power_on will be called.

So my suggestion with this patch is to reverse the order, do ->set_performance first
and then ->power_on, this way the provider receives the voltage level required by
a consumer before the request to power on the PD. Then a provider might use that
info when powering on/off that PD.

>
> > Also the drop_performance and power_off have to be reversed so that
> > when the last active consumer suspends, the level doesn't actually drop
> > until the pd is disabled.
>
> I don't quite get what this part helps with, is it really needed to
> improve the behaviour?

Again, why would a consumer need its PD voltage dropped before being powered off?

I think it makes more sense for the ->set_performance in this case to act as a
way to tell the provider that a specific device has yeilded its voltage level
request. That way the provider can drop the voltage to the minimum requested by
the active consumers of that PD.

>
> >
> > For the power domains that do not provide the set_performance, things
> > remain unchanged, as does for the power domains that only provide the
> > set_performance but do not provide the power_on/off.
>
> Right, good points!
>
> I get back to review the code soon, just wanted to make sure I have
> the complete picture first.
>
> Kind regards
> Uffe
>
> >
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/base/power/domain.c | 30 +++++++++++++++---------------
> >  1 file changed, 15 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 5a2e0232862e..38647c304b73 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -939,8 +939,8 @@ static int genpd_runtime_suspend(struct device *dev)
> >                 return 0;
> >
> >         genpd_lock(genpd);
> > -       gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
> >         genpd_power_off(genpd, true, 0);
> > +       gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
> >         genpd_unlock(genpd);
> >
> >         return 0;
> > @@ -978,9 +978,8 @@ static int genpd_runtime_resume(struct device *dev)
> >                 goto out;
> >
> >         genpd_lock(genpd);
> > +       genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
> >         ret = genpd_power_on(genpd, 0);
> > -       if (!ret)
> > -               genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
> >         genpd_unlock(genpd);
> >
> >         if (ret)
> > @@ -1018,8 +1017,8 @@ static int genpd_runtime_resume(struct device *dev)
> >  err_poweroff:
> >         if (!pm_runtime_is_irq_safe(dev) || genpd_is_irq_safe(genpd)) {
> >                 genpd_lock(genpd);
> > -               gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
> >                 genpd_power_off(genpd, true, 0);
> > +               gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
> >                 genpd_unlock(genpd);
> >         }
> >
> > @@ -2747,17 +2746,6 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
> >         dev->pm_domain->detach = genpd_dev_pm_detach;
> >         dev->pm_domain->sync = genpd_dev_pm_sync;
> >
> > -       if (power_on) {
> > -               genpd_lock(pd);
> > -               ret = genpd_power_on(pd, 0);
> > -               genpd_unlock(pd);
> > -       }
> > -
> > -       if (ret) {
> > -               genpd_remove_device(pd, dev);
> > -               return -EPROBE_DEFER;
> > -       }
> > -
> >         /* Set the default performance state */
> >         pstate = of_get_required_opp_performance_state(dev->of_node, index);
> >         if (pstate < 0 && pstate != -ENODEV && pstate != -EOPNOTSUPP) {
> > @@ -2769,6 +2757,18 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
> >                         goto err;
> >                 dev_gpd_data(dev)->default_pstate = pstate;
> >         }
> > +
> > +       if (power_on) {
> > +               genpd_lock(pd);
> > +               ret = genpd_power_on(pd, 0);
> > +               genpd_unlock(pd);
> > +       }
> > +
> > +       if (ret) {
> > +               genpd_remove_device(pd, dev);
> > +               return -EPROBE_DEFER;
> > +       }
> > +
> >         return 1;
> >
> >  err:
> > --
> > 2.34.3
> >
>
