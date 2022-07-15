Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B3857665C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiGORrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGORro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:47:44 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5732F3A5;
        Fri, 15 Jul 2022 10:47:43 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31c89111f23so54414037b3.0;
        Fri, 15 Jul 2022 10:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QLat8Q/2ROY2Kt2jHQc4a4l6+yIDdGjl086waEjxxKE=;
        b=XL/J2hlgksL1wbvaFMJVRCZJZjdsoBfyLKhywFoDx/Kv0npGAy3ykA3+yOdAaPLAYW
         dxLNfyQMUnTPsNlZzMw4C3QN8iBPLll5/kWGwkAqhh2Noy7nMESMVDNj2+SEi+JgNNAb
         jRUK5w6izhfqlkcvZihN4JK2tFiwAVhfhQ3FFPi7WSGla9uI4RoYKckBQoDWdmfKTAbR
         j84gf1h14OeVOllj9DJKod6Y2Q5/Y7AxTxJMmcCtH+eec9dqwou2nJEQQ41QienVe73z
         X3gM1O6D5YAZkDSv30PHPEgU1H/jrAF7C6g8NrECz2pP7dmqFuUj53ZnxInH5suRLBxG
         cuCg==
X-Gm-Message-State: AJIora+zweu0sLM5XIG5fLKU9kJR1EVkZQ3Akos8Xvp6bsMAI3TA4HyS
        kIcNxELkNelNUqr4n57j36ysrhghj0+IUTbVEaB3Ze7A
X-Google-Smtp-Source: AGRyM1u2kEEEFmdEOQxahhMYKJGY6tuAPHAaxtme8gcImgb36PXMz5xzib4wQEKqNyLKPEXkYJZobj+k727mYZWXYTc=
X-Received: by 2002:a81:17d0:0:b0:31c:c5e2:fc1e with SMTP id
 199-20020a8117d0000000b0031cc5e2fc1emr17548698ywx.196.1657907262218; Fri, 15
 Jul 2022 10:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220712121832.3659769-1-martin.kepplinger@puri.sm>
In-Reply-To: <20220712121832.3659769-1-martin.kepplinger@puri.sm>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jul 2022 19:47:31 +0200
Message-ID: <CAJZ5v0g_2Lwpdks6+NSuemxSKvdTbM0Rhot9vAy=psEiCn+MMQ@mail.gmail.com>
Subject: Re: [PATCH v2] power: domain: handle power supplies that need interrupts
To:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kevin Hilman <khilman@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, kernel@puri.sm,
        dl-linux-imx <linux-imx@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>, aford173@gmail.com,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 2:19 PM Martin Kepplinger
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

I need Ulf to look at this.  Ulf?

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
> --
> 2.30.2
>
