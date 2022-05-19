Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1642052D361
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 14:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiESM7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 08:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237631AbiESM6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 08:58:30 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30CCD4104
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:57:22 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id w14so8912518lfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 05:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aR2yuG7QP+r0gTdgSYaStSwxJ8RwX7Q4zTzPF1+Nqpo=;
        b=ugf1SX9wx9gVA5R+ln6Qge7zlhYGL9u69t98IcOLpR2ZZuDf8lWSidfc/I1zpVDDlu
         LISZs8hVFvJmY51NVTHChdmyTjuJyPnVNH41hUkedD/zty+U1ScXHzS9LYxEQqXQXxyN
         8G8cJYqLju8kBpG/UiZTAywiABeYxP5o4pDDOep916FcuzV2YB2GhqN3YTmNqEp7CCgz
         h9F4cXdkbqYZlO3mkV027tkz+G5jpERUdi/iCNXiJ82J+lnASxPUkN9XC4ipILd/hJOv
         xO9v4qBzBuXHqNC2X7InYJm6HP7o2vIlAHSwJUYm8ItFSLeOwqajZAf4zDx8JW8ls6/N
         YwpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aR2yuG7QP+r0gTdgSYaStSwxJ8RwX7Q4zTzPF1+Nqpo=;
        b=tmz7BpMHV+XPXluAtuNx5icpmn0oM9GvEx7eUP82U2ZOaPm2DBOQt0jT3acYVD4R5B
         /JUyHULt+s6oxvLpr2XUgEr3mk88wFnehP/nk76Vv+haE4BuM1eqKZVf3eNyigibLR+B
         TjfoDZjZ29LtB0NHNC6/1VH3CW6oD40Eg7Y5v4LroeGf0zApZJm1xe24SB3LTVHs70Yc
         mpPZPiRVk/AnWUG8u/zFTL8pZ2szPwSIq/NX53Ze699pwSXPecXBbcySncMd5mILQtn+
         WUBY/uJw6N5zzHKmgxE2WwjcUzPYdu4opKJ76o+So0H8HSUJaPnmWiqVh7MqUJuutUgO
         5RiQ==
X-Gm-Message-State: AOAM533/Zye1ogxb+mmHaE1TAPQyx5SM2Eu7eCCjo4vIkhw7hyn3ygD/
        /peNWU7OEllykM2xf8RpbgmcrFEXJLsP1bTHKSPrnA==
X-Google-Smtp-Source: ABdhPJztFL7Pqq1gQj+cNoDZZBXAghknXzjA/pEu2EUSHDZR2mOUec0RwrCi6yWoH7KOlQioB5K2JxOh2ikuEeqNWRA=
X-Received: by 2002:a05:6512:3b27:b0:477:96e9:b962 with SMTP id
 f39-20020a0565123b2700b0047796e9b962mr3293651lfv.373.1652965040195; Thu, 19
 May 2022 05:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <1652275016-13423-1-git-send-email-quic_mkshah@quicinc.com> <1652275016-13423-5-git-send-email-quic_mkshah@quicinc.com>
In-Reply-To: <1652275016-13423-5-git-send-email-quic_mkshah@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 May 2022 14:56:44 +0200
Message-ID: <CAPDyKFp+38XR9osX91quAMG6CbLYaAcetgPqFM53rinfT4ar+Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] PM: domains: Store the closest hrtimer event of
 the domain CPUs
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        quic_lsrao@quicinc.com, quic_rjendra@quicinc.com
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

On Wed, 11 May 2022 at 15:17, Maulik Shah <quic_mkshah@quicinc.com> wrote:
>
> The arch timer can not wake up the Qualcomm Technologies, Inc. (QTI)
> SoCs when the deepest CPUidle modes results in the SoC also to enter
> the low power mode.
>
> RSC is part of CPU subsystem and APSS rsc device is attached to cluster
> power domain. RSC has to setup next hrtimer wakeup in CONTROL_TCS which
> can wakeup the SoC from deepest low power states. The CONTROL_TCS does
> this by writing next wakeup in always on domain timer when the SoC is
> entering the low power state.
>
> Add dev_pm_genpd_get_next_hrtimer() to get the genpd wakeup time.
>
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> ---
>  drivers/base/power/domain.c          | 24 ++++++++++++++++++++++++
>  drivers/base/power/domain_governor.c |  1 +
>  include/linux/pm_domain.h            |  7 +++++++
>  3 files changed, 32 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 18cd796..f0d70d0 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -487,6 +487,29 @@ void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_genpd_set_next_wakeup);
>
> +/**
> + * dev_pm_genpd_get_next_hrtimer - Return genpd domain next_hrtimer.
> + *
> + * @dev: Device to handle
> + *
> + * Returns the aggregated domain wakeup time for CPU PM domain
> + * when all the subdomains are off.

To further clarify when this function should be used, I think that we
should state that it should typically be called from a consumer of a
genpd on/off-notifier at GENPD_NOTIFY_PRE_OFF. This also means that
the genpd's lock is being held across the function.

> + */
> +ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev)
> +{
> +       struct generic_pm_domain *genpd;
> +
> +       genpd = dev_to_genpd_safe(dev);
> +       if (!genpd)
> +               return KTIME_MAX;
> +
> +       if (atomic_read(&genpd->sd_count) > 0)
> +               return KTIME_MAX;

This above isn't needed, assuming we clarify the description of the
function and when it should be called.

> +
> +       return genpd->next_hrtimer;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_genpd_get_next_hrtimer);
> +
>  static int _genpd_power_on(struct generic_pm_domain *genpd, bool timed)
>  {
>         unsigned int state_idx = genpd->state_idx;
> @@ -1998,6 +2021,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>         genpd->max_off_time_changed = true;
>         genpd->provider = NULL;
>         genpd->has_provider = false;
> +       genpd->next_hrtimer = KTIME_MAX;
>         genpd->accounting_time = ktime_get_mono_fast_ns();
>         genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
>         genpd->domain.ops.runtime_resume = genpd_runtime_resume;
> diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> index cd08c58..a4c7dd8 100644
> --- a/drivers/base/power/domain_governor.c
> +++ b/drivers/base/power/domain_governor.c
> @@ -363,6 +363,7 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>                                 domain_wakeup = next_hrtimer;
>                 }
>         }
> +       genpd->next_hrtimer = domain_wakeup;

There should be no point to set this, unless cpu_power_down_ok() are
returning true. Therefore I suggest you move this a few lines further
down, where cpu_power_down_ok() actually returns true.

>
>         /* The minimum idle duration is from now - until the next wakeup. */
>         idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, now));
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 043d48e..6d9fb79 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -17,6 +17,7 @@
>  #include <linux/notifier.h>
>  #include <linux/spinlock.h>
>  #include <linux/cpumask.h>
> +#include <linux/time64.h>
>
>  /*
>   * Flags to control the behaviour of a genpd.
> @@ -136,6 +137,7 @@ struct generic_pm_domain {
>         struct gpd_dev_ops dev_ops;
>         s64 max_off_time_ns;    /* Maximum allowed "suspended" time. */
>         ktime_t next_wakeup;    /* Maintained by the domain governor */
> +       ktime_t next_hrtimer;   /* Next hrtimer for the CPU PM domain */
>         bool max_off_time_changed;
>         bool cached_power_down_ok;
>         bool cached_power_down_state_idx;
> @@ -228,6 +230,7 @@ int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
>  int dev_pm_genpd_add_notifier(struct device *dev, struct notifier_block *nb);
>  int dev_pm_genpd_remove_notifier(struct device *dev);
>  void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next);
> +ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev);
>
>  extern struct dev_power_governor simple_qos_governor;
>  extern struct dev_power_governor pm_domain_always_on_gov;
> @@ -289,6 +292,10 @@ static inline int dev_pm_genpd_remove_notifier(struct device *dev)
>  static inline void dev_pm_genpd_set_next_wakeup(struct device *dev, ktime_t next)
>  { }
>
> +static inline ktime_t dev_pm_genpd_get_next_hrtimer(struct device *dev)
> +{
> +       return KTIME_MAX;
> +}
>  #define simple_qos_governor            (*(struct dev_power_governor *)(NULL))
>  #define pm_domain_always_on_gov                (*(struct dev_power_governor *)(NULL))
>  #endif
> --
> 2.7.4
>

Kind regards
Uffe
