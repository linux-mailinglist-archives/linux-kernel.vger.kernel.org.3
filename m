Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262B75795C3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiGSJG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbiGSJG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:06:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D124205E5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:06:25 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1oDjB6-000469-41; Tue, 19 Jul 2022 11:06:04 +0200
Message-ID: <60cda0c11ce004c8e019b7bb7523d46b373dac58.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/2] power: domain: handle power supplies that need
 interrupts
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     rafael@kernel.org, khilman@kernel.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, pavel@ucw.cz,
        kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        aford173@gmail.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 19 Jul 2022 11:06:02 +0200
In-Reply-To: <CAPDyKFrkwKrvEsPHjfXUhGPcRg8z7J4OkOKq8KDp_0xj78Gudg@mail.gmail.com>
References: <20220718210302.674897-1-martin.kepplinger@puri.sm>
         <CAPDyKFrkwKrvEsPHjfXUhGPcRg8z7J4OkOKq8KDp_0xj78Gudg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

Am Dienstag, dem 19.07.2022 um 10:53 +0200 schrieb Ulf Hansson:
> On Mon, 18 Jul 2022 at 23:04, Martin Kepplinger
> <martin.kepplinger@puri.sm> wrote:
> > 
> > If the power-domains' power-supply node (regulator) needs
> > interrupts to work, the current setup with noirq callbacks cannot
> > work; for example a pmic regulator on i2c, when suspending, usually already
> > times out during suspend_noirq:
> > 
> > [   41.024193] buck4: failed to disable: -ETIMEDOUT
> > 
> > So fix system suspend and resume for these power-domains by using the
> > "outer" suspend/resume callbacks instead. Tested on the imx8mq-librem5 board,
> > but by looking at the dts, this will fix imx8mq-evk and possibly other boards
> > too.
> > 
> > Possibly one can find more changes than suspend/resume for this case. They
> > can be added later when testing them: This is designed so that genpd
> > providers just say "this power-supply" needs interrupts - without implying
> > what exactly should be configured in genpd.
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
> > v3: (thank you Ulf)
> > * move DT parsing to gpcv2 and create a genpd flag that gets set
> > 
> > v2: (thank you Krzysztof)
> > * rewrite: find possible regulators' interrupts property in parents
> >   instead of inventing a new property.
> > https://lore.kernel.org/linux-arm-kernel/20220712121832.3659769-1-martin.kepplinger@puri.sm/
> > 
> > v1: (initial idea)
> > https://lore.kernel.org/linux-arm-kernel/20220711094549.3445566-1-martin.kepplinger@puri.sm/T/#t
> > 
> > 
> >  drivers/base/power/domain.c | 19 +++++++++++++++++++
> >  drivers/soc/imx/gpcv2.c     |  9 +++++++++
> >  include/linux/pm_domain.h   |  6 ++++++
> >  3 files changed, 34 insertions(+)
> > 
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 739e52cd4aba..1437476c9086 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -130,6 +130,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
> >  #define genpd_is_active_wakeup(genpd)  (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
> >  #define genpd_is_cpu_domain(genpd)     (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
> >  #define genpd_is_rpm_always_on(genpd)  (genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
> > +#define genpd_ps_needs_irq(genpd)      (genpd->flags & GENPD_FLAG_IRQ_POWER_SUPPLY)
> > 
> >  static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
> >                 const struct generic_pm_domain *genpd)
> > @@ -2298,6 +2299,20 @@ static bool genpd_present(const struct generic_pm_domain *genpd)
> >         return ret;
> >  }
> > 
> > +/**
> > + * of_genpd_get_power_supply_irq() - Adjust if power-supply needs interrupts
> > + * @genpd: Pointer to PM domain associated with the PM domain provider.
> > + */
> > +static void of_genpd_config_power_supply_irq(struct generic_pm_domain *pd)
> 
> This isn't an "of" function. Moreover, I think we just skip the
> function all together and have the code in pm_genpd_init() instead.
> 
> > +{
> > +       if (genpd_ps_needs_irq(pd)) {
> > +               pd->domain.ops.suspend = genpd_suspend_noirq;
> > +               pd->domain.ops.resume = genpd_resume_noirq;
> > +               pd->domain.ops.suspend_noirq = NULL;
> > +               pd->domain.ops.resume_noirq = NULL;
> > +       }
> > +}
> > +
> >  /**
> >   * of_genpd_add_provider_simple() - Register a simple PM domain provider
> >   * @np: Device node pointer associated with the PM domain provider.
> > @@ -2343,6 +2358,8 @@ int of_genpd_add_provider_simple(struct device_node *np,
> >         genpd->provider = &np->fwnode;
> >         genpd->has_provider = true;
> > 
> > +       of_genpd_config_power_supply_irq(genpd);
> 
> Drop this. As stated above, I think the code belongs in pm_genpd_init().
> 
> > +
> >         return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(of_genpd_add_provider_simple);
> > @@ -2394,6 +2411,8 @@ int of_genpd_add_provider_onecell(struct device_node *np,
> > 
> >                 genpd->provider = &np->fwnode;
> >                 genpd->has_provider = true;
> > +
> > +               of_genpd_config_power_supply_irq(genpd);
> 
> Ditto.
> 
> >         }
> > 
> >         ret = genpd_add_provider(np, data->xlate, data);
> > diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
> > index 85aa86e1338a..3a22bad07534 100644
> > --- a/drivers/soc/imx/gpcv2.c
> > +++ b/drivers/soc/imx/gpcv2.c
> > @@ -1303,6 +1303,7 @@ static const struct imx_pgc_domain_data imx8mn_pgc_domain_data = {
> >  static int imx_pgc_domain_probe(struct platform_device *pdev)
> >  {
> >         struct imx_pgc_domain *domain = pdev->dev.platform_data;
> > +       struct device_node *dn;
> >         int ret;
> > 
> >         domain->dev = &pdev->dev;
> > @@ -1333,6 +1334,14 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
> >                 regmap_update_bits(domain->regmap, domain->regs->map,
> >                                    domain->bits.map, domain->bits.map);
> > 
> > +       dn = of_parse_phandle(domain->dev->of_node, "power-supply", 0);
> > +       if (dn) {
> > +               while ((dn = of_get_next_parent(dn))) {
> > +                       if (of_get_property(dn, "interrupts", NULL))
> > +                               domain->genpd.flags |= GENPD_FLAG_IRQ_POWER_SUPPLY;
> > +               }
> > +       }
> > +
> >         ret = pm_genpd_init(&domain->genpd, NULL, true);
> >         if (ret) {
> >                 dev_err(domain->dev, "Failed to init power domain\n");
> > diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> > index ebc351698090..bcceaf376f36 100644
> > --- a/include/linux/pm_domain.h
> > +++ b/include/linux/pm_domain.h
> > @@ -60,6 +60,11 @@
> >   * GENPD_FLAG_MIN_RESIDENCY:   Enable the genpd governor to consider its
> >   *                             components' next wakeup when determining the
> >   *                             optimal idle state.
> > + *
> > + * GENPD_FLAG_IRQ_POWER_SUPPLY:        The power-domains' power-supply (regulator)
> > + *                             needs interrupts to work. Adjust accordingly.
> > + *                             Use the outer suspend/resume callbacks instead
> > + *                             of noirq for example.
> 
> I prefer a more generic name. How about GENPD_FLAG_IRQ_ON.
> 
> For the description, I would rather state that the genpd needs irqs to
> stay on to be able to manage power on/off. Or something along those
> lines.
> 
> >   */
> >  #define GENPD_FLAG_PM_CLK       (1U << 0)
> >  #define GENPD_FLAG_IRQ_SAFE     (1U << 1)
> > @@ -68,6 +73,7 @@
> >  #define GENPD_FLAG_CPU_DOMAIN   (1U << 4)
> >  #define GENPD_FLAG_RPM_ALWAYS_ON (1U << 5)
> >  #define GENPD_FLAG_MIN_RESIDENCY (1U << 6)
> > +#define GENPD_FLAG_IRQ_POWER_SUPPLY (1U << 7)
> > 
> >  enum gpd_status {
> >         GENPD_STATE_ON = 0,     /* PM domain is on */
> > --
> > 2.30.2
> > 
> 
> BTW, a more generic question. If you move away from using the *noirq
> callbacks to the other suspend/resume callbacks in genpd to solve this
> problem, that requires all devices that is attached to the PM domain
> (genpd) to also *not* be managed with the "late/early" or the "noirq"
> callbacks too. In other case, we may power off the PM domain while
> some devices may still rely on it to be on.
> 
> Are you sure that this is the case?

For the i.MX8M* it should be fine. While we have some devices that are
using the noirq supend/resume callbacks, like PCIe, those are not in a
power-domain where we would like to control an external regulator, so
things should work fine for the targeted use-case.

However, it may be a good idea to introduce some kind of kernel warning
when a driver with noirq suspend/resume callbacks is attached to a
GENPD_FLAG_IRQ_ON domain.

Regards,
Lucas

