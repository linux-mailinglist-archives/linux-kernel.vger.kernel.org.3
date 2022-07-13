Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5995573671
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbiGMMd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbiGMMdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:33:54 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2659B1F625;
        Wed, 13 Jul 2022 05:33:44 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id r2so11713961qta.0;
        Wed, 13 Jul 2022 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ii72F0mdoIuYImy599wVYhiswv+BSl02KUUpq2menZs=;
        b=jWO+y1pUPs33hxx0NY5dypZXuzg7lSSrAX+hLiFEpTZuKM6FKIRAorLSyThtvlHyPi
         ML2NKHHOUw5bKT6GmhfcP1pIC2vjVWZm6741b3Gjeo3TcQ+0T9PaW4n6jzOxS8L0QvUn
         cgHgHNnncbGVAXt1P+tiqXe83keqvwQcpjR79KikF68nW424pExtIWDB9q/StsqhNgfR
         1iEfG4sYIBQMIhUJbZYxlnDyhdVDfi7ABDOwjgKK0no6T8TWuRFyK3JZ7AaLAyz/vdE1
         ExsbsFrbFYR4ctPglZjgSub71xKoUTwWG0PPuOjIL3Qfg3rMClwSj4mPH3m5n/q3V+J4
         BEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ii72F0mdoIuYImy599wVYhiswv+BSl02KUUpq2menZs=;
        b=42wXAHhXVFZmWOnZVOcc/fd0teajr5brDUHc77gotSjP24hKfsj3IbAf0M2KlF3+1x
         0UAbX6E/oTtdBQNfatLenIs/49dmrm1IM5/6IqaA2DG34Wx7H74WxRx2i6O4FqpBM6Ul
         Ae+PJDMjbP0PFp80HS9tJ8rbdIBN7yS9QN3mewE0hkf0Gx1VJcs33w7PCooTbpMawj+4
         DUziq2e6dqTLNo8+rz11TcnI1wzZ6CRUwnQWxanx8FhSZK7tzw+vN9tTbEhEs66vIC3X
         jFF6GZV7OnYT8s2JO5PBd45jH3earw8WcYKTrL1NTShxUeFXMBuCeQHOiNOp/w6ujCkP
         a0MA==
X-Gm-Message-State: AJIora/kP+ciFaeobVBo++sqnXWaqId+A5Xp1Y4N4qHOqLDtIZXmp9I2
        H1lt/JqKvkjWXSU/916m8RTOU/wwvtVgpNsQ/Uo=
X-Google-Smtp-Source: AGRyM1uU0lS6rwylGqW9OmKky1vKPBQIKsof2U8Kv/Mmu+hxwGmDl0hw2Sx3uAw5D4MitFBZrxoBChZlbjRxmOB+eAY=
X-Received: by 2002:a05:622a:178d:b0:31e:c386:510e with SMTP id
 s13-20020a05622a178d00b0031ec386510emr2795794qtk.82.1657715623148; Wed, 13
 Jul 2022 05:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220624195112.894916-1-robimarko@gmail.com> <87edyq1ujr.wl-maz@kernel.org>
 <20220712124445.GC21746@workstation> <87czea1i2f.wl-maz@kernel.org>
 <CAOX2RU5RX+H=omuKGye2fBy9dOFmfC9HC_3pekeGMxDJuReCUw@mail.gmail.com> <d8912a0d811b5eb924b8c4136b099f72@kernel.org>
In-Reply-To: <d8912a0d811b5eb924b8c4136b099f72@kernel.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 13 Jul 2022 14:33:32 +0200
Message-ID: <CAOX2RU4MpyEQ0RtcrZ07VXRbB+SWWU=1zWfYUXhQFtvh=MCiDw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: spmi-gpio: make the irqchip immutable
To:     Marc Zyngier <maz@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jul 2022 at 13:47, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2022-07-13 12:08, Robert Marko wrote:
> > On Tue, 12 Jul 2022 at 17:12, Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> On Tue, 12 Jul 2022 13:44:45 +0100,
> >> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> >> >
> >> > On Tue, Jul 12, 2022 at 11:42:32AM +0100, Marc Zyngier wrote:
> >> > > On Fri, 24 Jun 2022 20:51:12 +0100,
> >> > > Robert Marko <robimarko@gmail.com> wrote:
> >> > > >
> >> > > > Commit 6c846d026d49 ("gpio: Don't fiddle with irqchips marked as
> >> > > > immutable") added a warning to indicate if the gpiolib is altering the
> >> > > > internals of irqchips.
> >> > > >
> >> > > > Following this change the following warning is now observed for the SPMI
> >> > > > PMIC pinctrl driver:
> >> > > > gpio gpiochip1: (200f000.spmi:pmic@0:gpio@c000): not an immutable chip, please consider fixing it!
> >> > > >
> >> > > > Fix this by making the irqchip in the SPMI PMIC pinctrl driver immutable.
> >> > > >
> >> > > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> >> > > > ---
> >> > > >  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 22 ++++++++++++----------
> >> > > >  1 file changed, 12 insertions(+), 10 deletions(-)
> >> > > >
> >> > > > diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> >> > > > index c3255b0bece4..406ee0933d0b 100644
> >> > > > --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> >> > > > +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> >> > > > @@ -171,7 +171,6 @@ struct pmic_gpio_state {
> >> > > >   struct regmap   *map;
> >> > > >   struct pinctrl_dev *ctrl;
> >> > > >   struct gpio_chip chip;
> >> > > > - struct irq_chip irq;
> >> > > >   u8 usid;
> >> > > >   u8 pid_base;
> >> > > >  };
> >> > > > @@ -988,6 +987,17 @@ static void *pmic_gpio_populate_parent_fwspec(struct gpio_chip *chip,
> >> > > >   return fwspec;
> >> > > >  }
> >> > > >
> >> > > > +static const struct irq_chip spmi_gpio_irq_chip = {
> >> > > > + .name           = "spmi-gpio",
> >> > > > + .irq_ack        = irq_chip_ack_parent,
> >> > > > + .irq_mask       = irq_chip_mask_parent,
> >> > > > + .irq_unmask     = irq_chip_unmask_parent,
> >> > >
> >> > > No, this is wrong. Please look at the documentation to see how you
> >> > > must now directly call into the gpiolib helpers for these two
> >> > > callbacks.
> >> > >
> >> >
> >> > IIUC, you are referring to gpiochip_disable_irq() and
> >> > gpiochip_enable_irq() APIs.
> >>
> >> I am indeed.
> >>
> >> > These APIs are supposed to let the gpiolib know about that the IRQ
> >> > usage of these GPIOs. But for the case of hierarchial IRQ domain,
> >> > isn't the parent is going to do that?
> >>
> >> Why would it? The parent has no clue about what sits above it. In a
> >> hierarchical configuration, each level is responsible for its own
> >> level, and the GPIO layer should be responsible for its own
> >> management.
> >>
> >> > Please correct me if I'm wrong.
> >>
> >> I'm afraid you are, and this patch is a fairly obvious change in
> >> behaviour, as the callbacks you mention above are not called anymore,
> >> while they were before.
> >>
> >> If they are not necessary (for reasons I can't fathom), then this
> >> should be clearly explained.
> >
> > Hi Marc,
> > I will look at IRQ GPIO docs, but in this case, then we have more
> > conversions that
> > are not correct.
>
> Then please point them out.

Oh, now I get the issue, I was misunderstanding it completely.
gpiochip_enable_irq and gpiochip_disable_irq are not being called
at all.

However, I dont see them being called before the conversion as well.
I am not really familiar with the PMIC IRQ-s, looked like an easy conversion
to get rid of the warning.

Manivannan can you shed some light on this?

Regards,
Robert





>
>          M.
> --
> Jazz is not dead. It just smells funny...
