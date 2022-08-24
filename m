Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F0459FB6B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbiHXNbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbiHXNbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:31:31 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F35974CF4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:31:25 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id s6so12778029lfo.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/IenWy/p40/CNXuFHNI+gb1QvEr/h9waQZxVYY7VtNA=;
        b=Vngrw9lShipNLvEXsA+IF/7Qgw/5CAr21iEyiIDB3tfF8HE1j9whkx2nzgD3FZPTjY
         l5pJLdWoG2QCfauSzSAYf7ZyzAwdbZlu6qSfkPHsnY7hSwdsK01A6iL9NEc6jwiuL7fc
         4s7UPn4w62w37ULGtqnYszVGIrhdyejdPzEXFObyNH9Ppm93tYWaiEc5ybp1HmxepakP
         2/yNnnlYUaRu5qFbplo/uBNTApWfB62YLDIrYCNDTFyRsXlPQCUq7cMNqSS/2uOV+evH
         2KtXeDwgcylnmBwkHuH6vpvmQViNfgCA+FPR/TTPNfkI3uoMh24mX8/Ri3QD7ogiJ0/C
         upLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/IenWy/p40/CNXuFHNI+gb1QvEr/h9waQZxVYY7VtNA=;
        b=z9Ef763LV96bu1nDl+apT3bSbekZzQAUST20+c6QQxYZF7MxgEXmfJ9fJCsSbKJGWu
         SQBjWJ6Pim+oUFyc/njCyZ72pR/ro+x77H42hZ1tdUOJgA8hvUUc4e/4Fs9VzYtDC2R5
         vSLQoJT4tF57DJsLeackB2dN2+mckDLdMovzmh9CU+6ayfrv5kP9OErMrZzb0T+uHfF6
         Ic4kl0js5LRivMPwnIHkILPIalwuoF8S41QeZV7/uBKUhDCFo7hiNdmIV8IknoarhHpK
         aQd63a18LfYcfTlMSantqgows4lyerLjbaM+nSkfBySF7Dc5xex+zlVvUmYBbYIvP8jj
         dmeA==
X-Gm-Message-State: ACgBeo3aHRArOzehUAPhjqrxEgHvcG+A2d1GXFOtvwstMHohjuhyjOBF
        R+0MG2CwVXQQM+8CRIZCnmFjucDxGm5QymDv4mW2xg==
X-Google-Smtp-Source: AA6agR7aG4e2SL7nOyVn87QFL7QjxbVK06xMjGUHAovRGzCaUPQqfwQ4OJbyp5/rhtJoMq3QQqaoUK4HES51ulCbeoA=
X-Received: by 2002:ac2:59cf:0:b0:492:bf97:9a03 with SMTP id
 x15-20020ac259cf000000b00492bf979a03mr10776265lfn.233.1661347883822; Wed, 24
 Aug 2022 06:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220726083257.1730630-1-martin.kepplinger@puri.sm>
 <20220726083257.1730630-2-martin.kepplinger@puri.sm> <CAPDyKFrLLw=y9+t3f_bOH2mw2NVDGJxKE5=+XHY7C6SUzLzUDg@mail.gmail.com>
 <d1db07c8ca57c72b4f0820fcb6832dd7e4501055.camel@puri.sm> <CAPDyKFpz0HG_AzCkj8LkyisO1fjJiiyX2QjKTWDTLng2O7PDgA@mail.gmail.com>
 <77baacb930bf2ba1a65cb1515e6795b48d2d4ed5.camel@puri.sm>
In-Reply-To: <77baacb930bf2ba1a65cb1515e6795b48d2d4ed5.camel@puri.sm>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 24 Aug 2022 15:30:47 +0200
Message-ID: <CAPDyKFoS=E3c9XWWCaG2byMm-3nvvW5jXS0X7Bh-NK_msTUykQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] power: domain: handle genpd correctly when needing interrupts
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 at 10:38, Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:
>
> Am Freitag, dem 19.08.2022 um 16:53 +0200 schrieb Ulf Hansson:
> > On Fri, 19 Aug 2022 at 11:17, Martin Kepplinger
> > <martin.kepplinger@puri.sm> wrote:
> > >
> > > Am Dienstag, dem 26.07.2022 um 17:07 +0200 schrieb Ulf Hansson:
> > > > On Tue, 26 Jul 2022 at 10:33, Martin Kepplinger
> > > > <martin.kepplinger@puri.sm> wrote:
> > > > >
> > > > > If for example the power-domains' power-supply node (regulator)
> > > > > needs
> > > > > interrupts to work, the current setup with noirq callbacks
> > > > > cannot
> > > > > work; for example a pmic regulator on i2c, when suspending,
> > > > > usually
> > > > > already
> > > > > times out during suspend_noirq:
> > > > >
> > > > > [   41.024193] buck4: failed to disable: -ETIMEDOUT
> > > > >
> > > > > So fix system suspend and resume for these power-domains by
> > > > > using
> > > > > the
> > > > > "outer" suspend/resume callbacks instead. Tested on the imx8mq-
> > > > > librem5 board,
> > > > > but by looking at the dts, this will fix imx8mq-evk and
> > > > > possibly
> > > > > many other
> > > > > boards too.
> > > > >
> > > > > This is designed so that genpd providers just say "this genpd
> > > > > needs
> > > > > interrupts" (by setting the flag) - without implying an
> > > > > implementation.
> > > > >
> > > > > Initially system suspend problems had been discussed at
> > > > > https://lore.kernel.org/linux-arm-kernel/20211002005954.1367653-8-l.stach@pengutronix.de/
> > > > > which led to discussing the pmic that contains the regulators
> > > > > which
> > > > > serve as power-domain power-supplies:
> > > > > https://lore.kernel.org/linux-pm/573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm/T/
> > > > >
> > > > > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > > > > ---
> > > > >  drivers/base/power/domain.c | 13 +++++++++++--
> > > > >  include/linux/pm_domain.h   |  5 +++++
> > > > >  2 files changed, 16 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/base/power/domain.c
> > > > > b/drivers/base/power/domain.c
> > > > > index 5a2e0232862e..58376752a4de 100644
> > > > > --- a/drivers/base/power/domain.c
> > > > > +++ b/drivers/base/power/domain.c
> > > > > @@ -130,6 +130,7 @@ static const struct genpd_lock_ops
> > > > > genpd_spin_ops = {
> > > > >  #define genpd_is_active_wakeup(genpd)  (genpd->flags &
> > > > > GENPD_FLAG_ACTIVE_WAKEUP)
> > > > >  #define genpd_is_cpu_domain(genpd)     (genpd->flags &
> > > > > GENPD_FLAG_CPU_DOMAIN)
> > > > >  #define genpd_is_rpm_always_on(genpd)  (genpd->flags &
> > > > > GENPD_FLAG_RPM_ALWAYS_ON)
> > > > > +#define genpd_irq_on(genpd)            (genpd->flags &
> > > > > GENPD_FLAG_IRQ_ON)
> > > > >
> > > > >  static inline bool irq_safe_dev_in_sleep_domain(struct device
> > > > > *dev,
> > > > >                 const struct generic_pm_domain *genpd)
> > > > > @@ -2065,8 +2066,15 @@ int pm_genpd_init(struct
> > > > > generic_pm_domain
> > > > > *genpd,
> > > > >         genpd->domain.ops.runtime_suspend =
> > > > > genpd_runtime_suspend;
> > > > >         genpd->domain.ops.runtime_resume =
> > > > > genpd_runtime_resume;
> > > > >         genpd->domain.ops.prepare = genpd_prepare;
> > > > > -       genpd->domain.ops.suspend_noirq = genpd_suspend_noirq;
> > > > > -       genpd->domain.ops.resume_noirq = genpd_resume_noirq;
> > > > > +
> > > > > +       if (genpd_irq_on(genpd)) {
> > > > > +               genpd->domain.ops.suspend =
> > > > > genpd_suspend_noirq;
> > > > > +               genpd->domain.ops.resume = genpd_resume_noirq;
> > > > > +       } else {
> > > > > +               genpd->domain.ops.suspend_noirq =
> > > > > genpd_suspend_noirq;
> > > > > +               genpd->domain.ops.resume_noirq =
> > > > > genpd_resume_noirq;
> > > >
> > > > As we discussed previously, I am thinking that it may be better
> > > > to
> > > > move to using genpd->domain.ops.suspend_late and
> > > > genpd->domain.ops.resume_early instead.
> > >
> > > Wouldn't that better be a separate patch (on top)? Do you really
> > > want
> > > me to change the current behaviour (default case) to from noirq to
> > > late? Then I'll resend this series with such a patch added.
> >
> > Sorry, I wasn't clear enough, the default behaviour should remain as
> > is.
> >
> > What I meant was, when genpd_irq_on() is true, we should use the
> > genpd->domain.ops.suspend_late and genpd->domain.ops.resume_early.
>
> Testing that shows that this isn't working. I can provide the logs
> later, but suspend fails and I think it makes sense: "suspend_late" is
> simply already too late when i2c (or any needed driver) uses "suspend".

Okay, I see.

The reason why I suggested moving the callbacks to "suspend_late", was
that I was worried that some of the attached devices to genpd could
use "suspend_late" themselves. This is the case for some drivers for
DMA/clock/gpio/pinctrl-controllers, for example. That said, I am
curious to look at the DT files for the platform you are running,
would you mind giving me a pointer?

So, this made me think about this a bit more. In the end, just using
different levels (suspend, suspend_late, suspend_noirq) of callbacks
are just papering over the real *dependency* problem.

What we need for the genpd provider driver, is to be asked to be
suspended under the following conditions:
1. All consumer devices (and child-domains) for its corresponding PM
domain have been suspended.
2. All its supplier devices supplies must remain resumed, until the
genpd provider has been suspended.

Please allow me a few more days to think in more detail about this.

In some way, it looks like we should be able to combine the
information genpd has about its devices and child-domains, use PM
callbacks for the genpd provider driver - so we can rely on the
depency-path the fw_devlinks would give us for its supplier devices.

Kind regards
Uffe
