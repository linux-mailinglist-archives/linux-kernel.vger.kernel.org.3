Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D7C57804A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 12:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiGRKzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 06:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiGRKzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 06:55:07 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5F8DF60
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:55:05 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id w17so13120316ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 03:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65axDZrjnZBXcWUayw3QWyz90285gEottBlBhu/SSjw=;
        b=KOV72CPlJAzzABIbu0WidxJcA9FDNi+RPjMmY1JwIFq4HWTsbk1pXpuOMx8vfFC+2m
         ETOgPopA64TUimrM7ZNTmR5Zc+A6vS0qMSiH92/pZqRqflnU/WfrbQkXeDlZgQBeFtZW
         nRBbOmODI3dwNDqiCcbmH4nQFTsrEJ+mzCzdRM2a2dbEraNpUnm8aVzx39RdHoOnHA0z
         iSkafeqeEamKXA1cH65YNaoC3g0DWok1l5JymZNgHGDH3ftqDjUB7c19BGtMqTXy0MsH
         3N31glBP054j3nBIVo1tqDAnVf2e09+xu6xMHzXJg4WaauY8Lfm7ZbW32ku2bLqK7IBh
         2iBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65axDZrjnZBXcWUayw3QWyz90285gEottBlBhu/SSjw=;
        b=3X1GFJPRVoSgUu9z9Mgial0dhtBP2U62h/3DN3iaL5piDd0W+UBPbtenk6dP47AH81
         XVmUkj6c6F6debDkWlFNPUDizGLHAPV5m3J/FRRh1AuCDbJUoZrxIq9HnCpCOCocOzcI
         VYkP/YekONDRPSVxHjHBdHO/snpw+pTuHHqAAYFO2lYW3Zi9+ApkYQhAg5FuXAcNBNDI
         2GWFwVrOjjfthy8Mig9EjEG12E4HZqS3gC26bkFwwYQLXnk3ybKPhOhlxkIAtANr+5EI
         FKsFFkZ8bkTPjcpL13hZTBGJgfd7UFxUvLmLeZh/J7m5xY1DbQQZXUReqc9sj87iPZbh
         CABw==
X-Gm-Message-State: AJIora89+liqyNS8TPszdc2OGZv5BftjTXNKqdv1nuQcRro/SdWRup19
        AgPgzu5OlSNwRfc0ULeC1T7WvJhxVcE5PGbturmbJw==
X-Google-Smtp-Source: AGRyM1tvOUNdvPqHOEw1A9rLm7e4DBk5vbwRTdNKP1qGAo/AUT5hGNImOjZ4ODG65HsAHFNOTdXmh64ni2qNbjiPU3E=
X-Received: by 2002:a2e:9b0e:0:b0:25d:9ded:7b4f with SMTP id
 u14-20020a2e9b0e000000b0025d9ded7b4fmr8786108lji.4.1658141703976; Mon, 18 Jul
 2022 03:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220712121832.3659769-1-martin.kepplinger@puri.sm>
In-Reply-To: <20220712121832.3659769-1-martin.kepplinger@puri.sm>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Jul 2022 12:54:27 +0200
Message-ID: <CAPDyKFr0Lnp_3rUWcdZMcgtcFW050hOiGVZV_bVu=pqCLE8dEw@mail.gmail.com>
Subject: Re: [PATCH v2] power: domain: handle power supplies that need interrupts
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 at 14:19, Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:
>
> If the power-domains' power-supply node (regulator) needs
> interrupts to work, the current setup with noirq callbacks cannot
> work; for example a pmic regulator on i2c, when suspending, usually already
> times out during suspend_noirq:
>
> [   41.024193] buck4: failed to disable: -ETIMEDOUT
>
> So fix system suspend and resume for these power-domains by using the
> "outer" suspend/resume callbacks instead. Tested on the imx8mq-librem5
> board, but by looking at the dts, this will fix imx8mq-evk and possibly
> other boards too.
>
> Possibly one can find more changes than suspend/resume for this case. They
> can be added later when testing them.
>
> Initially system suspend problems had been discussed at
> https://lore.kernel.org/linux-arm-kernel/20211002005954.1367653-8-l.stach@pengutronix.de/
> which led to discussing the pmic that contains the regulators which
> serve as power-domain power-supplies:
> https://lore.kernel.org/linux-pm/573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm/T/
>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>
> revision history
> ----------------
> v2: (thank you Krzysztof)
> * rewrite: find possible regulators' interrupts property in parents
>   instead of inventing a new property.
>
> v1: (initial idea)
> https://lore.kernel.org/linux-arm-kernel/20220711094549.3445566-1-martin.kepplinger@puri.sm/T/#t
>
>
>  drivers/base/power/domain.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 3e86772d5fac..ca3e3500939d 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2298,6 +2298,28 @@ static bool genpd_present(const struct generic_pm_domain *genpd)
>         return ret;
>  }
>
> +/**
> + * of_genpd_get_power_supply_irq() - Adjust if power-supply needs interrupts
> + * @genpd: Pointer to PM domain associated with the PM domain provider.
> + */
> +static void of_genpd_get_power_supply_irq(struct generic_pm_domain *pd)
> +{
> +       struct device_node *dn;
> +
> +       dn = of_parse_phandle(pd->dev.of_node, "power-supply", 0);
> +       if (!dn)
> +               return;
> +
> +       while ((dn = of_get_next_parent(dn))) {
> +               if (of_get_property(dn, "interrupts", NULL)) {
> +                       pd->domain.ops.suspend = genpd_suspend_noirq;
> +                       pd->domain.ops.resume = genpd_resume_noirq;
> +                       pd->domain.ops.suspend_noirq = NULL;
> +                       pd->domain.ops.resume_noirq = NULL;
> +               }
> +       }
> +}
> +
>  /**
>   * of_genpd_add_provider_simple() - Register a simple PM domain provider
>   * @np: Device node pointer associated with the PM domain provider.
> @@ -2343,6 +2365,8 @@ int of_genpd_add_provider_simple(struct device_node *np,
>         genpd->provider = &np->fwnode;
>         genpd->has_provider = true;
>
> +       of_genpd_get_power_supply_irq(genpd);
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_genpd_add_provider_simple);
> @@ -2394,6 +2418,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>
>                 genpd->provider = &np->fwnode;
>                 genpd->has_provider = true;
> +
> +               of_genpd_get_power_supply_irq(genpd);
>         }
>
>         ret = genpd_add_provider(np, data->xlate, data);

Overall I understand the need for this, but let me suggest a slightly
different approach to solve this. See below.

I think the OF parsing looks quite platform specific. Rather than
adding this in the generic layer of genpd, I suggest that we move the
OF parsing into the genpd provider code.

Moreover, to inform genpd that it should use the other set of
callbacks for system suspend/resume, let's add a new genpd
configuration bit. The genpd provider should then set the genpd->flag,
prior to calling pm_genpd_init(), to let it know that it should pick
the other callbacks.

Does it make sense?

Kind regards
Uffe
