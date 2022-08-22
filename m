Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC1E59BBCB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 10:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbiHVIiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 04:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233615AbiHVIit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 04:38:49 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A524213D04;
        Mon, 22 Aug 2022 01:38:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 26B01E10D7;
        Mon, 22 Aug 2022 01:38:17 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NzF1olkKBo4b; Mon, 22 Aug 2022 01:38:16 -0700 (PDT)
Message-ID: <77baacb930bf2ba1a65cb1515e6795b48d2d4ed5.camel@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1661157496; bh=Or8IwOdSKEWwlGznaa4jIrIy54u6R0bhCX7D8BpveYc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G+0ygPseRNiuy7XIUI/F0uRFYjM3u+rJkq/3MHDCQ8gA+QlYmcfFp1vFHIlaVXNYi
         kyChZfMM6UUO7+Dm+75vexUyQOzpVeClDtMbs2DDX0wS5tfysSJ7Z9mpErUvOPg22l
         TGxDkJSmIQKXuAUiM81XxXxyAUSGKWwRZU/mGP6+v+9nTRKTzN39VKNdw4qj+KHVcc
         eGH+I+C46hYGWHBFVSyZvu3I3KzNIV5TvLIZCrEr5ZwIpRXiS2rF9vFkGmiX+3F4/w
         cuRwbLchuWwx2sAZmUAb9o1EP0IQFvtF+4ybV57q6SjZeuYAgg7hQ5D9/HLhswUsN6
         cj9XA0AK9NYIg==
Subject: Re: [PATCH v6 1/2] power: domain: handle genpd correctly when
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
Date:   Mon, 22 Aug 2022 10:38:10 +0200
In-Reply-To: <CAPDyKFpz0HG_AzCkj8LkyisO1fjJiiyX2QjKTWDTLng2O7PDgA@mail.gmail.com>
References: <20220726083257.1730630-1-martin.kepplinger@puri.sm>
         <20220726083257.1730630-2-martin.kepplinger@puri.sm>
         <CAPDyKFrLLw=y9+t3f_bOH2mw2NVDGJxKE5=+XHY7C6SUzLzUDg@mail.gmail.com>
         <d1db07c8ca57c72b4f0820fcb6832dd7e4501055.camel@puri.sm>
         <CAPDyKFpz0HG_AzCkj8LkyisO1fjJiiyX2QjKTWDTLng2O7PDgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, dem 19.08.2022 um 16:53 +0200 schrieb Ulf Hansson:
> On Fri, 19 Aug 2022 at 11:17, Martin Kepplinger
> <martin.kepplinger@puri.sm> wrote:
> > 
> > Am Dienstag, dem 26.07.2022 um 17:07 +0200 schrieb Ulf Hansson:
> > > On Tue, 26 Jul 2022 at 10:33, Martin Kepplinger
> > > <martin.kepplinger@puri.sm> wrote:
> > > > 
> > > > If for example the power-domains' power-supply node (regulator)
> > > > needs
> > > > interrupts to work, the current setup with noirq callbacks
> > > > cannot
> > > > work; for example a pmic regulator on i2c, when suspending,
> > > > usually
> > > > already
> > > > times out during suspend_noirq:
> > > > 
> > > > [   41.024193] buck4: failed to disable: -ETIMEDOUT
> > > > 
> > > > So fix system suspend and resume for these power-domains by
> > > > using
> > > > the
> > > > "outer" suspend/resume callbacks instead. Tested on the imx8mq-
> > > > librem5 board,
> > > > but by looking at the dts, this will fix imx8mq-evk and
> > > > possibly
> > > > many other
> > > > boards too.
> > > > 
> > > > This is designed so that genpd providers just say "this genpd
> > > > needs
> > > > interrupts" (by setting the flag) - without implying an
> > > > implementation.
> > > > 
> > > > Initially system suspend problems had been discussed at
> > > > https://lore.kernel.org/linux-arm-kernel/20211002005954.1367653-8-l.stach@pengutronix.de/
> > > > which led to discussing the pmic that contains the regulators
> > > > which
> > > > serve as power-domain power-supplies:
> > > > https://lore.kernel.org/linux-pm/573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm/T/
> > > > 
> > > > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > > > ---
> > > >  drivers/base/power/domain.c | 13 +++++++++++--
> > > >  include/linux/pm_domain.h   |  5 +++++
> > > >  2 files changed, 16 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/base/power/domain.c
> > > > b/drivers/base/power/domain.c
> > > > index 5a2e0232862e..58376752a4de 100644
> > > > --- a/drivers/base/power/domain.c
> > > > +++ b/drivers/base/power/domain.c
> > > > @@ -130,6 +130,7 @@ static const struct genpd_lock_ops
> > > > genpd_spin_ops = {
> > > >  #define genpd_is_active_wakeup(genpd)  (genpd->flags &
> > > > GENPD_FLAG_ACTIVE_WAKEUP)
> > > >  #define genpd_is_cpu_domain(genpd)     (genpd->flags &
> > > > GENPD_FLAG_CPU_DOMAIN)
> > > >  #define genpd_is_rpm_always_on(genpd)  (genpd->flags &
> > > > GENPD_FLAG_RPM_ALWAYS_ON)
> > > > +#define genpd_irq_on(genpd)            (genpd->flags &
> > > > GENPD_FLAG_IRQ_ON)
> > > > 
> > > >  static inline bool irq_safe_dev_in_sleep_domain(struct device
> > > > *dev,
> > > >                 const struct generic_pm_domain *genpd)
> > > > @@ -2065,8 +2066,15 @@ int pm_genpd_init(struct
> > > > generic_pm_domain
> > > > *genpd,
> > > >         genpd->domain.ops.runtime_suspend =
> > > > genpd_runtime_suspend;
> > > >         genpd->domain.ops.runtime_resume =
> > > > genpd_runtime_resume;
> > > >         genpd->domain.ops.prepare = genpd_prepare;
> > > > -       genpd->domain.ops.suspend_noirq = genpd_suspend_noirq;
> > > > -       genpd->domain.ops.resume_noirq = genpd_resume_noirq;
> > > > +
> > > > +       if (genpd_irq_on(genpd)) {
> > > > +               genpd->domain.ops.suspend =
> > > > genpd_suspend_noirq;
> > > > +               genpd->domain.ops.resume = genpd_resume_noirq;
> > > > +       } else {
> > > > +               genpd->domain.ops.suspend_noirq =
> > > > genpd_suspend_noirq;
> > > > +               genpd->domain.ops.resume_noirq =
> > > > genpd_resume_noirq;
> > > 
> > > As we discussed previously, I am thinking that it may be better
> > > to
> > > move to using genpd->domain.ops.suspend_late and
> > > genpd->domain.ops.resume_early instead.
> > 
> > Wouldn't that better be a separate patch (on top)? Do you really
> > want
> > me to change the current behaviour (default case) to from noirq to
> > late? Then I'll resend this series with such a patch added.
> 
> Sorry, I wasn't clear enough, the default behaviour should remain as
> is.
> 
> What I meant was, when genpd_irq_on() is true, we should use the
> genpd->domain.ops.suspend_late and genpd->domain.ops.resume_early.

Testing that shows that this isn't working. I can provide the logs
later, but suspend fails and I think it makes sense: "suspend_late" is
simply already too late when i2c (or any needed driver) uses "suspend".

> 
> Kind regards
> Uffe


