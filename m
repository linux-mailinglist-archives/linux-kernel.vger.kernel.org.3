Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471A757B2C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239758AbiGTIWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237440AbiGTIWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:22:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430AF6B772
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:21:59 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oE4xj-0003c1-JD; Wed, 20 Jul 2022 10:21:43 +0200
Message-ID: <5b4019dc8f3f797941037ebbbafb30b8541b2b4b.camel@pengutronix.de>
Subject: Re: [PATCH v4 3/3] soc: imx: gpcv2: fix suspend/resume by setting
 GENPD_FLAG_IRQ_ON
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>, rafael@kernel.org,
        khilman@kernel.org, ulf.hansson@linaro.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        aford173@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 20 Jul 2022 10:21:42 +0200
In-Reply-To: <5a6bfd6827f8ad838bdab8dfb208753ad258b1ec.camel@puri.sm>
References: <20220720043444.1289952-1-martin.kepplinger@puri.sm>
         <20220720043444.1289952-4-martin.kepplinger@puri.sm>
         <a7d51c154693881523e5d96c443a7dc9b3cc216d.camel@pengutronix.de>
         <5a6bfd6827f8ad838bdab8dfb208753ad258b1ec.camel@puri.sm>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 20.07.2022 um 10:05 +0200 schrieb Martin Kepplinger:
> Am Mittwoch, dem 20.07.2022 um 09:53 +0200 schrieb Lucas Stach:
> > Am Mittwoch, dem 20.07.2022 um 06:34 +0200 schrieb Martin Kepplinger:
> > > For boards that use power-domains' power-supplies that need
> > > interrupts
> > > to work (like regulator over i2c), set GENPD_FLAG_IRQ_ON.
> > > This will tell genpd to adjust accordingly. Currently it "only"
> > > sets the
> > > correct suspend/resume callbacks.
> > > 
> > > This fixes suspend/resume on imx8mq-librem5 boards (tested) and
> > > imx8mq-evk (by looking at dts) and possibly more.
> > > 
> > > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > > ---
> > >  drivers/soc/imx/gpcv2.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> > > index 85aa86e1338a..46d2ead2352b 100644
> > > --- a/drivers/soc/imx/gpcv2.c
> > > +++ b/drivers/soc/imx/gpcv2.c
> > > @@ -1303,6 +1303,7 @@ static const struct imx_pgc_domain_data
> > > imx8mn_pgc_domain_data = {
> > >  static int imx_pgc_domain_probe(struct platform_device *pdev)
> > >  {
> > >         struct imx_pgc_domain *domain = pdev->dev.platform_data;
> > > +       struct device_node *dn;
> > >         int ret;
> > >  
> > >         domain->dev = &pdev->dev;
> > > @@ -1333,6 +1334,14 @@ static int imx_pgc_domain_probe(struct
> > > platform_device *pdev)
> > >                 regmap_update_bits(domain->regmap, domain->regs-
> > > > map,
> > >                                    domain->bits.map, domain-
> > > > bits.map);
> > >  
> > > +       dn = of_parse_phandle(domain->dev->of_node, "power-supply",
> > > 0);
> > > +       if (dn) {
> > > +               while ((dn = of_get_next_parent(dn))) {
> > > +                       if (of_get_property(dn, "interrupts",
> > > NULL))
> > > +                               domain->genpd.flags |=
> > > GENPD_FLAG_IRQ_ON;
> > > +               }
> > > +       }
> > > +
> > While I understand the intention, I think the DT walking is overkill.
> > I
> > believe that there are no cases where we have a external regulator
> > attached to the PD and the devices in the domain needing noirq
> > support.
> > I think it's sufficient to simply set the IRQ_ON flag based on
> > presence
> > of the power-supply property on the domain DT node.
> 
> Are you sure? Can't boards just *describe* a power-supply that doesn't
> really do much, where noirq would work? looking for "interrupts" in any
> parent feels very stable and makes sure we only change behaviour when
> really needed. But for the boards I'm looking at, I have to admit it
> wouldn't change anything afaik. So if you insist, I'll happily remove
> that.
> 
I'm pretty sure that this holds for all boards. Yes, it might introduce
some more runtime changes than your option, but it will be more
consistent.

One could possibly have a simple GPIO regulator, which could work in
noirq if the GPIO is internal MMIO, but it already breaks when the GPIO
is from an i2c attached GPIO expander. This might even be a good
example where your DT parsing breaks: a GPIO regulator is not
necessarily a child device of the i2c GPIO expander, so the DT walking
will miss that IRQs need to be functional in order to toggle the GPIO.

Just keying the IRQ_ON flag on the presence of the power-supply
property will have less surprises, I think.

> 
> 
> Also, I forgot to say earlier: We could even add "if not regulator-
> always-on" to the DT parsing above, because in that case noirq is fine
> even for external regulators. Should I add that? I'd like as little
> runtime change as possible so I would add that (and keep the
> "interrupts" search above for the same reason). 
> 
Yea, one could make this even more complex to preserve the current
behavior as much as possible, but I just don't think that the current
behavior is relevant enough to warrant the complexity and possible
inconsistent behavior on different systems.

Thanks for working on this!

Regards,
Lucas

> thanks for looking at this,
> 
>                              martin
> 
> 
> > 
> > Regards,
> > Lucas
> > 
> > >         ret = pm_genpd_init(&domain->genpd, NULL, true);
> > >         if (ret) {
> > >                 dev_err(domain->dev, "Failed to init power
> > > domain\n");
> > 
> > 
> 
> 


