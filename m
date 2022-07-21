Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE8B57D24A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiGURPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiGURPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:15:33 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C264767E;
        Thu, 21 Jul 2022 10:15:25 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 94B2DDF900;
        Thu, 21 Jul 2022 10:14:54 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3105FPhhJ2dY; Thu, 21 Jul 2022 10:14:53 -0700 (PDT)
Message-ID: <885c4c97e32148d4acdbb5fa2f4401f41ae76084.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1658423693; bh=Yf0fpqX233oiOoDb4KXCi8yX/cXwrPg0zmJEHKFEDq4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bCNUG+tQ1QaS8nOnqtxb/xbwBDJmgiqVosDxfvTQf7iAdt6EecnF5JmnXtk1+idvC
         lunGGWtshAzTjsoDzTXW3Q1vVyQ6vPYtZ6Go2DnENey4+uPl4lXsp2Mdwl/GaDSege
         +EcE+YwSABQBYHolZXF4QDcoTX6zDSZIW7Lfh6ISiw3o4L191JmfybRkuRac0y2X7K
         A7oGzz6k6vqIcKPOgBZ7Hyp90tVAvvFqYXRlPe2BmNMRFmA1uyJedZQ1cDxewhsdvZ
         hssKVKGd2coWCVOww5LDagwPkKV7TOcOisCQRR1gjuNeYyG3jO8fU9n7LYUD61FkS2
         Mwd70cdGSgbPQ==
Subject: Re: [PATCH v5 2/3] power: domain: handle genpd correctly when
 needing interrupts
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     rafael@kernel.org, khilman@kernel.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, pavel@ucw.cz,
        kernel@puri.sm, linux-imx@nxp.com, broonie@kernel.org,
        l.stach@pengutronix.de, aford173@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Thu, 21 Jul 2022 19:14:46 +0200
In-Reply-To: <CAPDyKFouWMVcbDyrs=KgC+R4E61nb45Y0yOjt3PZ3JfcRyY9dA@mail.gmail.com>
References: <20220721043608.1527686-1-martin.kepplinger@puri.sm>
         <20220721043608.1527686-3-martin.kepplinger@puri.sm>
         <CAPDyKFouWMVcbDyrs=KgC+R4E61nb45Y0yOjt3PZ3JfcRyY9dA@mail.gmail.com>
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

Am Donnerstag, dem 21.07.2022 um 13:16 +0200 schrieb Ulf Hansson:
> On Thu, 21 Jul 2022 at 06:37, Martin Kepplinger
> <martin.kepplinger@puri.sm> wrote:
> > 
> > If for example the power-domains' power-supply node (regulator)
> > needs
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
> > librem5 board,
> > but by looking at the dts, this will fix imx8mq-evk and possibly
> > many other
> > boards too.
> > 
> > This is designed so that genpd providers just say "this genpd needs
> > interrupts" (by setting the flag) - without implying an
> > implementation.
> > 
> > Initially system suspend problems had been discussed at
> >  
> > https://lore.kernel.org/linux-arm-kernel/20211002005954.1367653-8-l.stach@pengutronix.de/
> > which led to discussing the pmic that contains the regulators which
> > serve as power-domain power-supplies:
> >  
> > https://lore.kernel.org/linux-pm/573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm/T/
> > 
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > ---
> >  drivers/base/power/domain.c | 13 +++++++++++++
> >  include/linux/pm_domain.h   |  5 +++++
> >  2 files changed, 18 insertions(+)
> > 
> > diff --git a/drivers/base/power/domain.c
> > b/drivers/base/power/domain.c
> > index 5a2e0232862e..ef77700e0def 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -130,6 +130,7 @@ static const struct genpd_lock_ops
> > genpd_spin_ops = {
> >  #define genpd_is_active_wakeup(genpd)  (genpd->flags &
> > GENPD_FLAG_ACTIVE_WAKEUP)
> >  #define genpd_is_cpu_domain(genpd)     (genpd->flags &
> > GENPD_FLAG_CPU_DOMAIN)
> >  #define genpd_is_rpm_always_on(genpd)  (genpd->flags &
> > GENPD_FLAG_RPM_ALWAYS_ON)
> > +#define genpd_irq_on(genpd)            (genpd->flags &
> > GENPD_FLAG_IRQ_ON)
> > 
> >  static inline bool irq_safe_dev_in_sleep_domain(struct device
> > *dev,
> >                 const struct generic_pm_domain *genpd)
> > @@ -2079,6 +2080,13 @@ int pm_genpd_init(struct generic_pm_domain
> > *genpd,
> >                 genpd->dev_ops.start = pm_clk_resume;
> >         }
> > 
> > +       if (genpd_irq_on(genpd)) {
> > +               genpd->domain.ops.suspend = genpd_suspend_noirq;
> > +               genpd->domain.ops.resume = genpd_resume_noirq;
> > +               genpd->domain.ops.suspend_noirq = NULL;
> > +               genpd->domain.ops.resume_noirq = NULL;
> 
> Please move this a few lines above, just before we assign the _*noirq
> callbacks. In this way you don't need to reset thosepointers.

good point, thanks.

> 
> > +       }
> > +
> >         /* The always-on governor works better with the
> > corresponding flag. */
> >         if (gov == &pm_domain_always_on_gov)
> >                 genpd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
> > @@ -2769,6 +2777,11 @@ static int __genpd_dev_pm_attach(struct
> > device *dev, struct device *base_dev,
> >                         goto err;
> >                 dev_gpd_data(dev)->default_pstate = pstate;
> >         }
> > +
> > +       if (pd->domain.ops.suspend_noirq && (pd->flags &
> > GENPD_FLAG_IRQ_ON))
> > +               dev_err(dev, "PM domain %s needs irqs but uses
> > noirq suspend\n",
> > +                       pd->name);
> > +
> 
> This doesn't make sense, as it can never happen according to what we
> do in pm_genpd_init().
> 
> What Lucas suggested in the other thread was to log a warning if a
> device's (that gets attached to genpd) bus/driver has _*noirq
> callbacks. That would make sense.
> 
> Thinking more about this, perhaps we should move to use the
> _*late/early callbacks instead for genpd. This would decrease the
> window of potential problematic consumers users (drivers/buses).
> 

ok, I'll probably send another version without this. I'm leaving for
vacations for a few weeks soon, so I'd rather do the essentials only
here and take notes about what could be added later, if that's ok.

thank you very much!

                        martin


> >         return 1;
> > 
> >  err:
> > diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> > index 76bc9e3ef5ff..03bb86e43550 100644
> > --- a/include/linux/pm_domain.h
> > +++ b/include/linux/pm_domain.h
> > @@ -61,6 +61,10 @@
> >   * GENPD_FLAG_MIN_RESIDENCY:   Enable the genpd governor to
> > consider its
> >   *                             components' next wakeup when
> > determining the
> >   *                             optimal idle state.
> > + *
> > + * GENPD_FLAG_IRQ_ON:          genpd needs irqs to be able to
> > manage power
> > + *                             on/off. Use the outer
> > suspend/resume callbacks
> > + *                             instead of noirq for example.
> >   */
> >  #define GENPD_FLAG_PM_CLK              BIT(0)
> >  #define GENPD_FLAG_IRQ_SAFE            BIT(1)
> > @@ -69,6 +73,7 @@
> >  #define GENPD_FLAG_CPU_DOMAIN          BIT(4)
> >  #define GENPD_FLAG_RPM_ALWAYS_ON       BIT(5)
> >  #define GENPD_FLAG_MIN_RESIDENCY       BIT(6)
> > +#define GENPD_FLAG_IRQ_ON              BIT(7)
> > 
> >  enum gpd_status {
> >         GENPD_STATE_ON = 0,     /* PM domain is on */
> > --
> > 2.30.2
> > 
> 
> Kind regards
> Uffe


