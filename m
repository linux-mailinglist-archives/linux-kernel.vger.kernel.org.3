Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D298B57C9A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbiGULRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiGULR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:17:28 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A3C81B13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 04:17:26 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id n18so2266550lfq.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 04:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Gnykwqd+vC3rtS/nAL/QcRf2AMrtCwB3O4EvfAVjzA=;
        b=SsWd2HFWk3HD7Vve3jWvBMiFYz2xlV1iuCcNI1hf1Pe3eQbCY9fQ6y7s2p7dtloGaW
         K4KbTs3WKfikTRIKNZ+c8UE9rh+Ynrqla9S2D4c+Vii0LGxdgvElm3SIgY73d7fC5Hw+
         Faov0A3TvfEWzaTXZzYFobBNw1zCI07mvWpShuCzlXHOzPyb5LOU37S7KEQybaXfnSph
         ob/sxUFS8ezn1s5fLLEZQ+0MPEDfRhXJ/uIjm63zIsywl1Z90Z3CvfRG5xxNn80j/42a
         iWOddqGBdLUFKgWlOFOGqeV7NixO73OVyVZSdN17uhfhC/8p2XPCoCst9b4MeM1mXiPH
         +EEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Gnykwqd+vC3rtS/nAL/QcRf2AMrtCwB3O4EvfAVjzA=;
        b=blfdtxRL6z2DE/LqT84w2pFO1osB61pfUtyy97/PAjiX4xTzLa3J0w/xKpsmycdpGT
         JQKT+ogMub32hhry05Jkk377Rersbk2H8kIzemaT+LobdMhN44JmN9sqs3obAhW0NokI
         ZZMyTG7Zq9qJBHolKc3www4q847XYoobjVPKne1T9dfhbYol3hFejtCIvVdV5wRSWBW5
         xBi+7fTI/z/LkzpMmILorQWBTiZ2L0/caG7Tna3SFqA4lXrCpBpsFkgutwGQDX1pBYZ5
         EH474C81lUBTJAwBqWn7rD+m95bDKDbxEahnTERhQ+1NBedlpRBuZjyTduZxo4M1m0M3
         F8NA==
X-Gm-Message-State: AJIora8m9omIo6Rkagc3gAbDWEPopoFPuTWqaGJ6EQkzOfmx9N5bKWsS
        aPoLUkAAfeq5IT+XwZUoPwOYND5cNpRrHcDNrCel7A==
X-Google-Smtp-Source: AGRyM1u4WCa5dVOpwiSGbwj5+e4+HoZPSzrKuwLqe3XWV/GuvfojaqnCF6tjyW1ACqqbj1qL8pgL9f4sBUpYR3ASWo0=
X-Received: by 2002:a05:6512:32c6:b0:48a:18a1:2d2b with SMTP id
 f6-20020a05651232c600b0048a18a12d2bmr19594098lfg.373.1658402244436; Thu, 21
 Jul 2022 04:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220721043608.1527686-1-martin.kepplinger@puri.sm> <20220721043608.1527686-3-martin.kepplinger@puri.sm>
In-Reply-To: <20220721043608.1527686-3-martin.kepplinger@puri.sm>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Jul 2022 13:16:47 +0200
Message-ID: <CAPDyKFouWMVcbDyrs=KgC+R4E61nb45Y0yOjt3PZ3JfcRyY9dA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] power: domain: handle genpd correctly when needing interrupts
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     rafael@kernel.org, khilman@kernel.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, pavel@ucw.cz,
        kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Thu, 21 Jul 2022 at 06:37, Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:
>
> If for example the power-domains' power-supply node (regulator) needs
> interrupts to work, the current setup with noirq callbacks cannot
> work; for example a pmic regulator on i2c, when suspending, usually already
> times out during suspend_noirq:
>
> [   41.024193] buck4: failed to disable: -ETIMEDOUT
>
> So fix system suspend and resume for these power-domains by using the
> "outer" suspend/resume callbacks instead. Tested on the imx8mq-librem5 board,
> but by looking at the dts, this will fix imx8mq-evk and possibly many other
> boards too.
>
> This is designed so that genpd providers just say "this genpd needs
> interrupts" (by setting the flag) - without implying an implementation.
>
> Initially system suspend problems had been discussed at
> https://lore.kernel.org/linux-arm-kernel/20211002005954.1367653-8-l.stach@pengutronix.de/
> which led to discussing the pmic that contains the regulators which
> serve as power-domain power-supplies:
> https://lore.kernel.org/linux-pm/573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm/T/
>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  drivers/base/power/domain.c | 13 +++++++++++++
>  include/linux/pm_domain.h   |  5 +++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 5a2e0232862e..ef77700e0def 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -130,6 +130,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
>  #define genpd_is_active_wakeup(genpd)  (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
>  #define genpd_is_cpu_domain(genpd)     (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
>  #define genpd_is_rpm_always_on(genpd)  (genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
> +#define genpd_irq_on(genpd)            (genpd->flags & GENPD_FLAG_IRQ_ON)
>
>  static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
>                 const struct generic_pm_domain *genpd)
> @@ -2079,6 +2080,13 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>                 genpd->dev_ops.start = pm_clk_resume;
>         }
>
> +       if (genpd_irq_on(genpd)) {
> +               genpd->domain.ops.suspend = genpd_suspend_noirq;
> +               genpd->domain.ops.resume = genpd_resume_noirq;
> +               genpd->domain.ops.suspend_noirq = NULL;
> +               genpd->domain.ops.resume_noirq = NULL;

Please move this a few lines above, just before we assign the _*noirq
callbacks. In this way you don't need to reset thosepointers.

> +       }
> +
>         /* The always-on governor works better with the corresponding flag. */
>         if (gov == &pm_domain_always_on_gov)
>                 genpd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
> @@ -2769,6 +2777,11 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
>                         goto err;
>                 dev_gpd_data(dev)->default_pstate = pstate;
>         }
> +
> +       if (pd->domain.ops.suspend_noirq && (pd->flags & GENPD_FLAG_IRQ_ON))
> +               dev_err(dev, "PM domain %s needs irqs but uses noirq suspend\n",
> +                       pd->name);
> +

This doesn't make sense, as it can never happen according to what we
do in pm_genpd_init().

What Lucas suggested in the other thread was to log a warning if a
device's (that gets attached to genpd) bus/driver has _*noirq
callbacks. That would make sense.

Thinking more about this, perhaps we should move to use the
_*late/early callbacks instead for genpd. This would decrease the
window of potential problematic consumers users (drivers/buses).

>         return 1;
>
>  err:
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 76bc9e3ef5ff..03bb86e43550 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -61,6 +61,10 @@
>   * GENPD_FLAG_MIN_RESIDENCY:   Enable the genpd governor to consider its
>   *                             components' next wakeup when determining the
>   *                             optimal idle state.
> + *
> + * GENPD_FLAG_IRQ_ON:          genpd needs irqs to be able to manage power
> + *                             on/off. Use the outer suspend/resume callbacks
> + *                             instead of noirq for example.
>   */
>  #define GENPD_FLAG_PM_CLK              BIT(0)
>  #define GENPD_FLAG_IRQ_SAFE            BIT(1)
> @@ -69,6 +73,7 @@
>  #define GENPD_FLAG_CPU_DOMAIN          BIT(4)
>  #define GENPD_FLAG_RPM_ALWAYS_ON       BIT(5)
>  #define GENPD_FLAG_MIN_RESIDENCY       BIT(6)
> +#define GENPD_FLAG_IRQ_ON              BIT(7)
>
>  enum gpd_status {
>         GENPD_STATE_ON = 0,     /* PM domain is on */
> --
> 2.30.2
>

Kind regards
Uffe
