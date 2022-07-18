Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE13F57819F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiGRMIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiGRMIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:08:07 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F2E240A4;
        Mon, 18 Jul 2022 05:08:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 871D8DF67F;
        Mon, 18 Jul 2022 05:07:59 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U0NUDL-x45sf; Mon, 18 Jul 2022 05:07:58 -0700 (PDT)
Message-ID: <06ee17dfd5f5fb0cb3db4ddfee863c7b8351096e.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1658146078; bh=RCI3Sddocud6yQEbFUjII8wgubmlHfYg4RGudGkMD68=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CCY+pdrZ0UssUf9cZRMTgkrNZp1iU8647VRqCdKgDKpslQAcqpisXtRDgBU00KPff
         w+RDjDLqHg16yAydys8hXLkeMVdY8VamOBMzIXv889DrftLimEAlLkXZvCOd9CpfZn
         5BeXBqAELkHZoJYiO/KuSyCRn60c8cWBIBsjwJc03nElgbgFbutOn3NPEUD3CMygO7
         30AENz0Ksz3g10rTyD/XRB7OK2k28jUV/cuXQcOkK3ANwwUODs0HCFrXv6LGnXhH/A
         2XNd2WIUmOBud89e/FoMG++qzHLnJ5V1hf2H57ddAxsnTyAxlJDxgG7tRQEnjJtKt+
         H17wvW9EA9TUA==
Subject: Re: [PATCH v2] power: domain: handle power supplies that need
 interrupts
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     rafael@kernel.org, khilman@kernel.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, pavel@ucw.cz,
        kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Mon, 18 Jul 2022 14:07:51 +0200
In-Reply-To: <CAPDyKFr0Lnp_3rUWcdZMcgtcFW050hOiGVZV_bVu=pqCLE8dEw@mail.gmail.com>
References: <20220712121832.3659769-1-martin.kepplinger@puri.sm>
         <CAPDyKFr0Lnp_3rUWcdZMcgtcFW050hOiGVZV_bVu=pqCLE8dEw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, dem 18.07.2022 um 12:54 +0200 schrieb Ulf Hansson:
> On Tue, 12 Jul 2022 at 14:19, Martin Kepplinger
> <martin.kepplinger@puri.sm> wrote:
> > 
> > If the power-domains' power-supply node (regulator) needs
> > interrupts to work, the current setup with noirq callbacks cannot
> > work; for example a pmic regulator on i2c, when suspending, usually
> > already
> > times out during suspend_noirq:
> > 
> > [   41.024193] buck4: failed to disable: -ETIMEDOUT
> > 
> > So fix system suspend and resume for these power-domains by using
> > the
> > "outer" suspend/resume callbacks instead. Tested on the imx8mq-
> > librem5
> > board, but by looking at the dts, this will fix imx8mq-evk and
> > possibly
> > other boards too.
> > 
> > Possibly one can find more changes than suspend/resume for this
> > case. They
> > can be added later when testing them.
> > 
> > Initially system suspend problems had been discussed at
> > https://lore.kernel.org/linux-arm-kernel/20211002005954.1367653-8-l.stach@pengutronix.de/
> > which led to discussing the pmic that contains the regulators which
> > serve as power-domain power-supplies:
> > https://lore.kernel.org/linux-pm/573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm/T/
> > 
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > ---
> > 
> > revision history
> > ----------------
> > v2: (thank you Krzysztof)
> > * rewrite: find possible regulators' interrupts property in parents
> >   instead of inventing a new property.
> > 
> > v1: (initial idea)
> > https://lore.kernel.org/linux-arm-kernel/20220711094549.3445566-1-martin.kepplinger@puri.sm/T/#t
> > 
> > 
> >  drivers/base/power/domain.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/drivers/base/power/domain.c
> > b/drivers/base/power/domain.c
> > index 3e86772d5fac..ca3e3500939d 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -2298,6 +2298,28 @@ static bool genpd_present(const struct
> > generic_pm_domain *genpd)
> >         return ret;
> >  }
> > 
> > +/**
> > + * of_genpd_get_power_supply_irq() - Adjust if power-supply needs
> > interrupts
> > + * @genpd: Pointer to PM domain associated with the PM domain
> > provider.
> > + */
> > +static void of_genpd_get_power_supply_irq(struct generic_pm_domain
> > *pd)
> > +{
> > +       struct device_node *dn;
> > +
> > +       dn = of_parse_phandle(pd->dev.of_node, "power-supply", 0);
> > +       if (!dn)
> > +               return;
> > +
> > +       while ((dn = of_get_next_parent(dn))) {
> > +               if (of_get_property(dn, "interrupts", NULL)) {
> > +                       pd->domain.ops.suspend =
> > genpd_suspend_noirq;
> > +                       pd->domain.ops.resume = genpd_resume_noirq;
> > +                       pd->domain.ops.suspend_noirq = NULL;
> > +                       pd->domain.ops.resume_noirq = NULL;
> > +               }
> > +       }
> > +}
> > +
> >  /**
> >   * of_genpd_add_provider_simple() - Register a simple PM domain
> > provider
> >   * @np: Device node pointer associated with the PM domain
> > provider.
> > @@ -2343,6 +2365,8 @@ int of_genpd_add_provider_simple(struct
> > device_node *np,
> >         genpd->provider = &np->fwnode;
> >         genpd->has_provider = true;
> > 
> > +       of_genpd_get_power_supply_irq(genpd);
> > +
> >         return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(of_genpd_add_provider_simple);
> > @@ -2394,6 +2418,8 @@ int of_genpd_add_provider_onecell(struct
> > device_node *np,
> > 
> >                 genpd->provider = &np->fwnode;
> >                 genpd->has_provider = true;
> > +
> > +               of_genpd_get_power_supply_irq(genpd);
> >         }
> > 
> >         ret = genpd_add_provider(np, data->xlate, data);
> 
> Overall I understand the need for this, but let me suggest a slightly
> different approach to solve this. See below.
> 
> I think the OF parsing looks quite platform specific. Rather than
> adding this in the generic layer of genpd, I suggest that we move the
> OF parsing into the genpd provider code.
> 
> Moreover, to inform genpd that it should use the other set of
> callbacks for system suspend/resume, let's add a new genpd
> configuration bit. The genpd provider should then set the genpd-
> >flag,
> prior to calling pm_genpd_init(), to let it know that it should pick
> the other callbacks.
> 
> Does it make sense?

the provider here would be gpcv2, right? Conceptually I know what you
mean and will try to make it work later. thanks a lot!

> 
> Kind regards
> Uffe


