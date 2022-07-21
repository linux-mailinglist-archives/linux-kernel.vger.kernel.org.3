Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9205C57D1EA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiGUQsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiGUQsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:48:50 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D7F88F3F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:48:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t1so3675838lft.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1c4NqFsQq1mqeLVqaBN4q3GogL5AF4iqMOI42mtV1ks=;
        b=K58M7u82t6s38vHDPjhyWIPtWJe5jwwdA+/oCAg+1F90YAkXIj0j3xQjuV87JP2KIj
         vw/mqL6vrXJvm5/3iuFzxj6nxE+nnNFmzulKJHJMl4YnmsQgu47zJReSVKf1YbY+V/Xy
         syQK/8cziYQEwK6nO2WZmNTbQsTDp6yHGDRmrYa9Uh9Drzij5oH/LrpFPlR5b7d8Ewt5
         Jokrly/12sz+Cgjw7e5de2x3yFmodFo+SZAA3njI4EZmqLSF8kdAfyIrzr8QFc1TnzJQ
         XB24LOXgbsq7q+3mb803tI/U26AsUKI8MHsOOLTTSsC30WNpuHQKwNM1NsLjooDEWt8+
         ifow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1c4NqFsQq1mqeLVqaBN4q3GogL5AF4iqMOI42mtV1ks=;
        b=bPHVSCquoj6EN7Juh7nrXf6rMihupNW1UcNVgIOa1iOgdC92z8EkgEF+VHw2F0jfpj
         OWXvQVMrn+69TxViUCURPqzU9G2ev+ZqfrrHB59omrxScgLBqCiCHmhSOGA/U0f2hhPG
         dQ8y2TFeIAvWlUv4rpYahFD6ldqOU0RfxDKZriFxI4bfKzk3qf8a5Gphe1ZZav8nqH4q
         xGOITQFzf+qrdxxOL+cqeaBbM3Eki7XHhXJ6poxhLp1f0Li6HG5A2qRysfYURnckHq53
         HT1thCuvbWShMB1anMou95xm5wB3gt+ldJLDTrCdX5Eh1pD865wEkelYIY0dMp7jRzaC
         Ffgw==
X-Gm-Message-State: AJIora+TgPW7bEeSWhAZOf++orm4bpNo/gnhqXMa/OCOKy/IpZw59ndT
        wnwafoKt4+6X4zOjWVLSup2kLFugWEon1YZ1LtvDlQ==
X-Google-Smtp-Source: AGRyM1vf94GzeFtRMIlmmxhByAj4WoC6FcVXZ0jwy7R2sxr9A9EAsQH+XJMiaqWAs2cKvs/94mFVMaKDWRwbZeQe1SQ=
X-Received: by 2002:a05:6512:15a8:b0:489:ed48:24 with SMTP id
 bp40-20020a05651215a800b00489ed480024mr21657228lfb.184.1658422127039; Thu, 21
 Jul 2022 09:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220720110246.762939-1-abel.vesa@linaro.org>
In-Reply-To: <20220720110246.762939-1-abel.vesa@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Jul 2022 18:48:10 +0200
Message-ID: <CAPDyKFoh8UV=QC6RhOkc=FSvoeqF_UiWp97h0Qp8dniB=sS+8A@mail.gmail.com>
Subject: Re: [RFC] PM: domains: Reverse the order of performance and enabling ops
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 at 13:03, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Rather than enabling and then setting the performance state, which usually
> translates into two different levels (voltages) in order to get to the
> one required by the consumer, we could give a chance to the providers to
> cache the performance state needed by the consumer and then, when powering
> on the power domain, the provider could use the cached level instead.

I don't think it's really clear what you want to do here. Let's see
what the discussion below brings us to, but for the next version
please elaborate a bit more in the commit message.

Although, if I understand correctly (also from our offlist
discussions), you want to make it possible to move from two calls,
into one call into the FW from the genpd provider. So it's basically
an optimization, which to me, certainly sounds worth doing.

Furthermore, to get the complete picture, in the Qcom case, we set a
"default" low performance level from the genpd's ->power_on()
callback, which is needed to enable basic functionality for some
consumers.

The second call that I refer to is made when genpd calls the
->set_performance() callback (from genpd_runtime_suspend()), which is
done by genpd to potentially set a new value for an aggregated
performance state of the PM domain. In case when there actually is a
new performance state set in this path, we end up calling the FW twice
for the Qcom case, where this first one is unnecessary.

Did I get that right?

> Also the drop_performance and power_off have to be reversed so that
> when the last active consumer suspends, the level doesn't actually drop
> until the pd is disabled.

I don't quite get what this part helps with, is it really needed to
improve the behaviour?

>
> For the power domains that do not provide the set_performance, things
> remain unchanged, as does for the power domains that only provide the
> set_performance but do not provide the power_on/off.

Right, good points!

I get back to review the code soon, just wanted to make sure I have
the complete picture first.

Kind regards
Uffe

>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/base/power/domain.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 5a2e0232862e..38647c304b73 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -939,8 +939,8 @@ static int genpd_runtime_suspend(struct device *dev)
>                 return 0;
>
>         genpd_lock(genpd);
> -       gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
>         genpd_power_off(genpd, true, 0);
> +       gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
>         genpd_unlock(genpd);
>
>         return 0;
> @@ -978,9 +978,8 @@ static int genpd_runtime_resume(struct device *dev)
>                 goto out;
>
>         genpd_lock(genpd);
> +       genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
>         ret = genpd_power_on(genpd, 0);
> -       if (!ret)
> -               genpd_restore_performance_state(dev, gpd_data->rpm_pstate);
>         genpd_unlock(genpd);
>
>         if (ret)
> @@ -1018,8 +1017,8 @@ static int genpd_runtime_resume(struct device *dev)
>  err_poweroff:
>         if (!pm_runtime_is_irq_safe(dev) || genpd_is_irq_safe(genpd)) {
>                 genpd_lock(genpd);
> -               gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
>                 genpd_power_off(genpd, true, 0);
> +               gpd_data->rpm_pstate = genpd_drop_performance_state(dev);
>                 genpd_unlock(genpd);
>         }
>
> @@ -2747,17 +2746,6 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>         dev->pm_domain->detach = genpd_dev_pm_detach;
>         dev->pm_domain->sync = genpd_dev_pm_sync;
>
> -       if (power_on) {
> -               genpd_lock(pd);
> -               ret = genpd_power_on(pd, 0);
> -               genpd_unlock(pd);
> -       }
> -
> -       if (ret) {
> -               genpd_remove_device(pd, dev);
> -               return -EPROBE_DEFER;
> -       }
> -
>         /* Set the default performance state */
>         pstate = of_get_required_opp_performance_state(dev->of_node, index);
>         if (pstate < 0 && pstate != -ENODEV && pstate != -EOPNOTSUPP) {
> @@ -2769,6 +2757,18 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>                         goto err;
>                 dev_gpd_data(dev)->default_pstate = pstate;
>         }
> +
> +       if (power_on) {
> +               genpd_lock(pd);
> +               ret = genpd_power_on(pd, 0);
> +               genpd_unlock(pd);
> +       }
> +
> +       if (ret) {
> +               genpd_remove_device(pd, dev);
> +               return -EPROBE_DEFER;
> +       }
> +
>         return 1;
>
>  err:
> --
> 2.34.3
>
