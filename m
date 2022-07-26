Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FE35819CA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbiGZSdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiGZSda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:33:30 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7528F1FCD7;
        Tue, 26 Jul 2022 11:33:29 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31f1d1c82c8so59051057b3.8;
        Tue, 26 Jul 2022 11:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5+m7EBDqZU/jW3BuYu28PjO80Us2rcYeVmkBo88WcRQ=;
        b=T+mwv+9ekmkrYeOZY28nPu71f6I3WE0oVub5EJ9bIXm3a9h52CP5huB1pJvIqfNbPa
         muDsSytg8X/xbuXnZT1Lf1B93JqDa7HuwnKcXtCmeGUdnH+tayiDiRj3OA+wXfaOaWwD
         guWUvL/nh4JTgJNLEN6fyUeljl8QlL5PwSS2wZ+siDc5wqX1qZu4nOU8ASfqWMo/TT5w
         lW/b4dPtnqyHMgWFewy4yiMtj2bgN9/+lnsxvwjffxD8FepcesOJgozRLmUZUCam2Drr
         UNQjw62TZziDUMIf2JGmSS9GAgWu95rAZet41DfOnJskz+1ehyf2VllaBsV403Ws2rsp
         pGdg==
X-Gm-Message-State: AJIora/BYhSc+kcb4bTebkj5ibVuMn4QFy0ynLCu2eHjtUlkAN2HiWG+
        +t3EEi92DGzZm5VFo0YT85AT8XuEwo/BB3gxRLumuCvy
X-Google-Smtp-Source: AGRyM1v+eroIuT8BybBIl9+jRpYcBVPNVsJgdQpI7FwfWSz8KlUO5x9QDs65P5xz9wsvnf6SnKWfixXAYLgYtgF4C14=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr15609044ywb.326.1658860408658; Tue, 26
 Jul 2022 11:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220726083257.1730630-1-martin.kepplinger@puri.sm>
 <20220726083257.1730630-2-martin.kepplinger@puri.sm> <CAPDyKFrLLw=y9+t3f_bOH2mw2NVDGJxKE5=+XHY7C6SUzLzUDg@mail.gmail.com>
In-Reply-To: <CAPDyKFrLLw=y9+t3f_bOH2mw2NVDGJxKE5=+XHY7C6SUzLzUDg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Jul 2022 20:33:17 +0200
Message-ID: <CAJZ5v0hG4+z=ypDudiSnhG1SUxfLv+EFsUGOjQEqUi0EKH3+Rw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] power: domain: handle genpd correctly when needing interrupts
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh@kernel.org>,
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

On Tue, Jul 26, 2022 at 5:07 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 26 Jul 2022 at 10:33, Martin Kepplinger
> <martin.kepplinger@puri.sm> wrote:
> >
> > If for example the power-domains' power-supply node (regulator) needs
> > interrupts to work, the current setup with noirq callbacks cannot
> > work; for example a pmic regulator on i2c, when suspending, usually already
> > times out during suspend_noirq:
> >
> > [   41.024193] buck4: failed to disable: -ETIMEDOUT
> >
> > So fix system suspend and resume for these power-domains by using the
> > "outer" suspend/resume callbacks instead. Tested on the imx8mq-librem5 board,
> > but by looking at the dts, this will fix imx8mq-evk and possibly many other
> > boards too.
> >
> > This is designed so that genpd providers just say "this genpd needs
> > interrupts" (by setting the flag) - without implying an implementation.
> >
> > Initially system suspend problems had been discussed at
> > https://lore.kernel.org/linux-arm-kernel/20211002005954.1367653-8-l.stach@pengutronix.de/
> > which led to discussing the pmic that contains the regulators which
> > serve as power-domain power-supplies:
> > https://lore.kernel.org/linux-pm/573166b75e524517782471c2b7f96e03fd93d175.camel@puri.sm/T/
> >
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > ---
> >  drivers/base/power/domain.c | 13 +++++++++++--
> >  include/linux/pm_domain.h   |  5 +++++
> >  2 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 5a2e0232862e..58376752a4de 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -130,6 +130,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
> >  #define genpd_is_active_wakeup(genpd)  (genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
> >  #define genpd_is_cpu_domain(genpd)     (genpd->flags & GENPD_FLAG_CPU_DOMAIN)
> >  #define genpd_is_rpm_always_on(genpd)  (genpd->flags & GENPD_FLAG_RPM_ALWAYS_ON)
> > +#define genpd_irq_on(genpd)            (genpd->flags & GENPD_FLAG_IRQ_ON)
> >
> >  static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
> >                 const struct generic_pm_domain *genpd)
> > @@ -2065,8 +2066,15 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
> >         genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
> >         genpd->domain.ops.runtime_resume = genpd_runtime_resume;
> >         genpd->domain.ops.prepare = genpd_prepare;
> > -       genpd->domain.ops.suspend_noirq = genpd_suspend_noirq;
> > -       genpd->domain.ops.resume_noirq = genpd_resume_noirq;
> > +
> > +       if (genpd_irq_on(genpd)) {
> > +               genpd->domain.ops.suspend = genpd_suspend_noirq;
> > +               genpd->domain.ops.resume = genpd_resume_noirq;
> > +       } else {
> > +               genpd->domain.ops.suspend_noirq = genpd_suspend_noirq;
> > +               genpd->domain.ops.resume_noirq = genpd_resume_noirq;
>
> As we discussed previously, I am thinking that it may be better to
> move to using genpd->domain.ops.suspend_late and
> genpd->domain.ops.resume_early instead.

Should I take this as a change request?

> Beside this, I think the $subject patch looks good to me.

Or not?
