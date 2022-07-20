Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B6D57B244
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 10:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbiGTIGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 04:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiGTIGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:06:40 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F7140BDC;
        Wed, 20 Jul 2022 01:06:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 8670ADFEEB;
        Wed, 20 Jul 2022 01:06:08 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jy-yr_GXHRZu; Wed, 20 Jul 2022 01:06:04 -0700 (PDT)
Message-ID: <5a6bfd6827f8ad838bdab8dfb208753ad258b1ec.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1658304364; bh=W7oFWT03XGGKOHW68rUNi/F6WDaxeRdYnn8x89UH2q4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tgShpVNJhE4DH6cDe9LhF9t8ZZg9HXaPlW8oWfyhGAcHv8s3NwE9jbyTJHxMhFg22
         6ElNPXOH4RXR2EGuIsvXkdAdNMoxN5trZEXQlHzXH6q7IQQhdKTvd4/+bFz1TWrZge
         RMvnaNYzed+5RDRKbE6aJo7bZZo3ROTkunoclenpcuTrB4O2HXbtDLkXGvVxUPNQwP
         cthdfqn00Oad/ePytXnfQRnXRKbcmclvTAxObe4BE3zrJpuDpcIaXI5o9Mmjo5D2mK
         ZIKwjwFHmCKoZY5fObJV3F6a7ew+qkzJnUWVkw+Fzsp44ySZ9Buh9gzrat0Ebts0F6
         nl99fXMXnPEFw==
Subject: Re: [PATCH v4 3/3] soc: imx: gpcv2: fix suspend/resume by setting
 GENPD_FLAG_IRQ_ON
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Lucas Stach <l.stach@pengutronix.de>, rafael@kernel.org,
        khilman@kernel.org, ulf.hansson@linaro.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, pavel@ucw.cz
Cc:     kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        aford173@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 20 Jul 2022 10:05:57 +0200
In-Reply-To: <a7d51c154693881523e5d96c443a7dc9b3cc216d.camel@pengutronix.de>
References: <20220720043444.1289952-1-martin.kepplinger@puri.sm>
         <20220720043444.1289952-4-martin.kepplinger@puri.sm>
         <a7d51c154693881523e5d96c443a7dc9b3cc216d.camel@pengutronix.de>
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

Am Mittwoch, dem 20.07.2022 um 09:53 +0200 schrieb Lucas Stach:
> Am Mittwoch, dem 20.07.2022 um 06:34 +0200 schrieb Martin Kepplinger:
> > For boards that use power-domains' power-supplies that need
> > interrupts
> > to work (like regulator over i2c), set GENPD_FLAG_IRQ_ON.
> > This will tell genpd to adjust accordingly. Currently it "only"
> > sets the
> > correct suspend/resume callbacks.
> > 
> > This fixes suspend/resume on imx8mq-librem5 boards (tested) and
> > imx8mq-evk (by looking at dts) and possibly more.
> > 
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > ---
> >  drivers/soc/imx/gpcv2.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> > index 85aa86e1338a..46d2ead2352b 100644
> > --- a/drivers/soc/imx/gpcv2.c
> > +++ b/drivers/soc/imx/gpcv2.c
> > @@ -1303,6 +1303,7 @@ static const struct imx_pgc_domain_data
> > imx8mn_pgc_domain_data = {
> >  static int imx_pgc_domain_probe(struct platform_device *pdev)
> >  {
> >         struct imx_pgc_domain *domain = pdev->dev.platform_data;
> > +       struct device_node *dn;
> >         int ret;
> >  
> >         domain->dev = &pdev->dev;
> > @@ -1333,6 +1334,14 @@ static int imx_pgc_domain_probe(struct
> > platform_device *pdev)
> >                 regmap_update_bits(domain->regmap, domain->regs-
> > >map,
> >                                    domain->bits.map, domain-
> > >bits.map);
> >  
> > +       dn = of_parse_phandle(domain->dev->of_node, "power-supply",
> > 0);
> > +       if (dn) {
> > +               while ((dn = of_get_next_parent(dn))) {
> > +                       if (of_get_property(dn, "interrupts",
> > NULL))
> > +                               domain->genpd.flags |=
> > GENPD_FLAG_IRQ_ON;
> > +               }
> > +       }
> > +
> While I understand the intention, I think the DT walking is overkill.
> I
> believe that there are no cases where we have a external regulator
> attached to the PD and the devices in the domain needing noirq
> support.
> I think it's sufficient to simply set the IRQ_ON flag based on
> presence
> of the power-supply property on the domain DT node.

Are you sure? Can't boards just *describe* a power-supply that doesn't
really do much, where noirq would work? looking for "interrupts" in any
parent feels very stable and makes sure we only change behaviour when
really needed. But for the boards I'm looking at, I have to admit it
wouldn't change anything afaik. So if you insist, I'll happily remove
that.

Also, I forgot to say earlier: We could even add "if not regulator-
always-on" to the DT parsing above, because in that case noirq is fine
even for external regulators. Should I add that? I'd like as little
runtime change as possible so I would add that (and keep the
"interrupts" search above for the same reason). 

thanks for looking at this,

                             martin


> 
> Regards,
> Lucas
> 
> >         ret = pm_genpd_init(&domain->genpd, NULL, true);
> >         if (ret) {
> >                 dev_err(domain->dev, "Failed to init power
> > domain\n");
> 
> 


