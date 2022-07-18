Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9065A57824F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbiGRM1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbiGRM1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:27:17 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267E025EB2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:27:14 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u13so19024018lfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SvNSiy3Bwyzzmb9hWm5P2ubOF+K0KPQR5bua58V/jh0=;
        b=fvzJULg7DRCWCIpeJrHd8MszLKI1FCkIqUIlpfMgk4Y9DoLijatc6bknHRhlef65cQ
         WSkxz+dMpXpDQuTDLRcjqChHLNrmSK1htOi3Q1Ap1XjPzlitOiadSO1j5WrlV2PdnB8E
         bqtRarasBZWlUSAezWCCVo4ExQZu8B52noAfuFmdP/NsR5T0xIJ0in5tQtPG9DFaHdi4
         QqCuJ6LqHK5C0/OdDwFCLUCvvBdyfHNx5u4y8d6miqg6/gZsHqeGlcNHyGb1dc6KnZPy
         +41xCZsvOhgvrTLuk8Ii1L0cwh6uist3zpQZdMgbIFTbjXXsz50iwd/HBs+TbaV7xxiy
         tFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SvNSiy3Bwyzzmb9hWm5P2ubOF+K0KPQR5bua58V/jh0=;
        b=vRPh/8AeGNC/krw8BbknmvG3U9awQSN2N/YWkimR0IOL2lFcAMMSWJTVliBWm5HenV
         ZftlxkTuvwIpUlj7UHbx0LMXPaZyutU4ZLzRuMxhD4+3cDBVmm9voTHPQ1tZ60hOdkeH
         uHR5sINZXe0yQsWZEhzp/Y5Wg2HZyyaZ3u/3lXAWsZlagknWxJSFaHLX1iTsWsi7WShZ
         oUn1B+jyhcN9pHW6YXOjbMg4mcwfEITFjbQiIpHyWVOOqvLnGGYwsPUcrZm1Hsa9AwtK
         7r3mu2RImhrmJC568ndocuW1axg1xfY7+u1+yyuH5/QzNUZnNDV/G996DpWJ3uBJSDP7
         RPww==
X-Gm-Message-State: AJIora+IHIBFZ9mSSjtnhkl3D3WTxhyKsJHBig5QrhbGkMCRD5VFVKc5
        8e1uDuSUVoDDLXGQ0h2cLsoYVjIOeeRNdS2+DSUWcA==
X-Google-Smtp-Source: AGRyM1uKiFktgrEzxlm7H0kdDSoycjmIDjrn5dKMTQroWG6UyBZUIQ/Ro4Bg+FkT/p4F94gX2lwF5GGf0OM1CfmattE=
X-Received: by 2002:a05:6512:aca:b0:48a:1a70:d0d8 with SMTP id
 n10-20020a0565120aca00b0048a1a70d0d8mr11279481lfu.167.1658147232435; Mon, 18
 Jul 2022 05:27:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220712121832.3659769-1-martin.kepplinger@puri.sm>
 <CAPDyKFr0Lnp_3rUWcdZMcgtcFW050hOiGVZV_bVu=pqCLE8dEw@mail.gmail.com> <06ee17dfd5f5fb0cb3db4ddfee863c7b8351096e.camel@puri.sm>
In-Reply-To: <06ee17dfd5f5fb0cb3db4ddfee863c7b8351096e.camel@puri.sm>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Jul 2022 14:26:35 +0200
Message-ID: <CAPDyKFpm1nMEeUjygapfwtBcr25AQerX4j14MPKd5NW2-BW33g@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jul 2022 at 14:08, Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:
>
> Am Montag, dem 18.07.2022 um 12:54 +0200 schrieb Ulf Hansson:
> > On Tue, 12 Jul 2022 at 14:19, Martin Kepplinger
> > <martin.kepplinger@puri.sm> wrote:
> > >
> > > If the power-domains' power-supply node (regulator) needs
> > > interrupts to work, the current setup with noirq callbacks cannot
> > > work; for example a pmic regulator on i2c, when suspending, usually
> > > already
> > > times out during suspend_noirq:
> > >
> > > [   41.024193] buck4: failed to disable: -ETIMEDOUT
> > >
> > > So fix system suspend and resume for these power-domains by using
> > > the
> > > "outer" suspend/resume callbacks instead. Tested on the imx8mq-
> > > librem5
> > > board, but by looking at the dts, this will fix imx8mq-evk and
> > > possibly
> > > other boards too.
> > >
> > > Possibly one can find more changes than suspend/resume for this
> > > case. They
> > > can be added later when testing them.
> > >
> > > Initially system suspend problems had been discussed at
> > > https://lore.kernel.org/linux-arm-kernel/20211002005954.1367653-8-l.stach@pengutronix.de/
> > > which led to discussing the pmic that contains the regulators which
> > > serve as power-domain power-supplies:
> > > https://lore.kernel.org/linux-pm/573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm/T/
> > >
> > > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > > ---
> > >
> > > revision history
> > > ----------------
> > > v2: (thank you Krzysztof)
> > > * rewrite: find possible regulators' interrupts property in parents
> > >   instead of inventing a new property.
> > >
> > > v1: (initial idea)
> > > https://lore.kernel.org/linux-arm-kernel/20220711094549.3445566-1-martin.kepplinger@puri.sm/T/#t
> > >
> > >
> > >  drivers/base/power/domain.c | 26 ++++++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > >
> > > diff --git a/drivers/base/power/domain.c
> > > b/drivers/base/power/domain.c
> > > index 3e86772d5fac..ca3e3500939d 100644
> > > --- a/drivers/base/power/domain.c
> > > +++ b/drivers/base/power/domain.c
> > > @@ -2298,6 +2298,28 @@ static bool genpd_present(const struct
> > > generic_pm_domain *genpd)
> > >         return ret;
> > >  }
> > >
> > > +/**
> > > + * of_genpd_get_power_supply_irq() - Adjust if power-supply needs
> > > interrupts
> > > + * @genpd: Pointer to PM domain associated with the PM domain
> > > provider.
> > > + */
> > > +static void of_genpd_get_power_supply_irq(struct generic_pm_domain
> > > *pd)
> > > +{
> > > +       struct device_node *dn;
> > > +
> > > +       dn = of_parse_phandle(pd->dev.of_node, "power-supply", 0);
> > > +       if (!dn)
> > > +               return;
> > > +
> > > +       while ((dn = of_get_next_parent(dn))) {
> > > +               if (of_get_property(dn, "interrupts", NULL)) {
> > > +                       pd->domain.ops.suspend =
> > > genpd_suspend_noirq;
> > > +                       pd->domain.ops.resume = genpd_resume_noirq;
> > > +                       pd->domain.ops.suspend_noirq = NULL;
> > > +                       pd->domain.ops.resume_noirq = NULL;
> > > +               }
> > > +       }
> > > +}
> > > +
> > >  /**
> > >   * of_genpd_add_provider_simple() - Register a simple PM domain
> > > provider
> > >   * @np: Device node pointer associated with the PM domain
> > > provider.
> > > @@ -2343,6 +2365,8 @@ int of_genpd_add_provider_simple(struct
> > > device_node *np,
> > >         genpd->provider = &np->fwnode;
> > >         genpd->has_provider = true;
> > >
> > > +       of_genpd_get_power_supply_irq(genpd);
> > > +
> > >         return 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(of_genpd_add_provider_simple);
> > > @@ -2394,6 +2418,8 @@ int of_genpd_add_provider_onecell(struct
> > > device_node *np,
> > >
> > >                 genpd->provider = &np->fwnode;
> > >                 genpd->has_provider = true;
> > > +
> > > +               of_genpd_get_power_supply_irq(genpd);
> > >         }
> > >
> > >         ret = genpd_add_provider(np, data->xlate, data);
> >
> > Overall I understand the need for this, but let me suggest a slightly
> > different approach to solve this. See below.
> >
> > I think the OF parsing looks quite platform specific. Rather than
> > adding this in the generic layer of genpd, I suggest that we move the
> > OF parsing into the genpd provider code.
> >
> > Moreover, to inform genpd that it should use the other set of
> > callbacks for system suspend/resume, let's add a new genpd
> > configuration bit. The genpd provider should then set the genpd-
> > >flag,
> > prior to calling pm_genpd_init(), to let it know that it should pick
> > the other callbacks.
> >
> > Does it make sense?
>
> the provider here would be gpcv2, right?

Correct.

> Conceptually I know what you
> mean and will try to make it work later. thanks a lot!

Great! Feel free to ping me if you need some help to put it together.

Kind regards
Uffe
