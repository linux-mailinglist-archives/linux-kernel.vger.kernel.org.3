Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A5C579480
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 09:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbiGSHr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 03:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbiGSHr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 03:47:57 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2151422532
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:47:56 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id k19so11229268pll.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 00:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fZvYFTQVWADi8JgqnZ6cTCBLOf5nfyb++I9Q8W9P3TU=;
        b=rS3eNboYNUbV5YTV7UweX1aBei0pk0eAjbMBOoeSTOyva/8H3/zLSPn56ETr1wTuSC
         X6rxYkItGvztKmfuGsmTzcYEDWNfGqixq3CQ4N0QbotHVpvxiFu/rPgxCrXEcpcshs4q
         A8lTmLGOfiwyxGIn6FYXNON0KE2dGL9DeXq+cGUz0j3vo/iaz5Ok+4k5yrVMmI0Iiprr
         24mr6evwQ83HD1Z96mKhNqki/Gv9N0HMvI+dRdN3FEDQO+sZG9WfIOp480/W+j4uwjhB
         UMxWHpd9BJnLQq5ukuFaHU0RqnZhIAJ5cDZYwTDELtxIi8coKNigJCVYhkaXpuR2oorY
         GaOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fZvYFTQVWADi8JgqnZ6cTCBLOf5nfyb++I9Q8W9P3TU=;
        b=NcHzt9Sy8xc/FyX4GLsW+X1a3kKrS19mRHsgu4Qt5P62zGvMvaqIUTkSL/Qs6FPUkF
         NDpieWh2S+zH66d5da2xPHXUC47cR5ZCqT1yA0GtiPMgmFO95SnVRDlUCez5VLtkcOO7
         W/SPdqFKNsEJLqo3UaKcr3hCW2Uk27azJwI9O6bfxTiKZEA9s3fyLJbi9Y5BWImSrMQW
         evXSlBfawp83tqh48OYKqkrBreXVJHojXM3G+TtIhuR2sh7hPpGQbAgklliqZLHyfqdp
         wtjkIBa4ECW21wGTUFYP807Di30WAq2pO/+t/N5jH3E42oVV3oAMZCz25a3jqGAPmjOD
         6iOQ==
X-Gm-Message-State: AJIora/+ROG9oAGJ8c7FPYQ3D8TWhBAyQId5gj6TLOnjT0F+KIz50Qud
        bqxkWX2L9nFoNBI52tY/5xV2
X-Google-Smtp-Source: AGRyM1vhGsYy0ZCs7uCK5IyNM/JATxHm5llih9735ndNReIUaUR4bNWVTvb8U7jYVVeY4XEkNie0Ug==
X-Received: by 2002:a17:90a:590e:b0:1f1:afeb:996 with SMTP id k14-20020a17090a590e00b001f1afeb0996mr14350841pji.205.1658216875538;
        Tue, 19 Jul 2022 00:47:55 -0700 (PDT)
Received: from thinkpad ([117.217.180.99])
        by smtp.gmail.com with ESMTPSA id y6-20020aa79e06000000b00528655cd6a6sm10697477pfq.53.2022.07.19.00.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 00:47:55 -0700 (PDT)
Date:   Tue, 19 Jul 2022 13:17:51 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: qcom: spmi-gpio: make the irqchip immutable
Message-ID: <20220719074751.GA25065@thinkpad>
References: <20220624195112.894916-1-robimarko@gmail.com>
 <87edyq1ujr.wl-maz@kernel.org>
 <20220712124445.GC21746@workstation>
 <87czea1i2f.wl-maz@kernel.org>
 <CAOX2RU5RX+H=omuKGye2fBy9dOFmfC9HC_3pekeGMxDJuReCUw@mail.gmail.com>
 <d8912a0d811b5eb924b8c4136b099f72@kernel.org>
 <CAOX2RU4MpyEQ0RtcrZ07VXRbB+SWWU=1zWfYUXhQFtvh=MCiDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOX2RU4MpyEQ0RtcrZ07VXRbB+SWWU=1zWfYUXhQFtvh=MCiDw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 02:33:32PM +0200, Robert Marko wrote:
> On Wed, 13 Jul 2022 at 13:47, Marc Zyngier <maz@kernel.org> wrote:
> >
> > On 2022-07-13 12:08, Robert Marko wrote:
> > > On Tue, 12 Jul 2022 at 17:12, Marc Zyngier <maz@kernel.org> wrote:
> > >>
> > >> On Tue, 12 Jul 2022 13:44:45 +0100,
> > >> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > >> >
> > >> > On Tue, Jul 12, 2022 at 11:42:32AM +0100, Marc Zyngier wrote:
> > >> > > On Fri, 24 Jun 2022 20:51:12 +0100,
> > >> > > Robert Marko <robimarko@gmail.com> wrote:
> > >> > > >
> > >> > > > Commit 6c846d026d49 ("gpio: Don't fiddle with irqchips marked as
> > >> > > > immutable") added a warning to indicate if the gpiolib is altering the
> > >> > > > internals of irqchips.
> > >> > > >
> > >> > > > Following this change the following warning is now observed for the SPMI
> > >> > > > PMIC pinctrl driver:
> > >> > > > gpio gpiochip1: (200f000.spmi:pmic@0:gpio@c000): not an immutable chip, please consider fixing it!
> > >> > > >
> > >> > > > Fix this by making the irqchip in the SPMI PMIC pinctrl driver immutable.
> > >> > > >
> > >> > > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > >> > > > ---
> > >> > > >  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 22 ++++++++++++----------
> > >> > > >  1 file changed, 12 insertions(+), 10 deletions(-)
> > >> > > >
> > >> > > > diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> > >> > > > index c3255b0bece4..406ee0933d0b 100644
> > >> > > > --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> > >> > > > +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> > >> > > > @@ -171,7 +171,6 @@ struct pmic_gpio_state {
> > >> > > >   struct regmap   *map;
> > >> > > >   struct pinctrl_dev *ctrl;
> > >> > > >   struct gpio_chip chip;
> > >> > > > - struct irq_chip irq;
> > >> > > >   u8 usid;
> > >> > > >   u8 pid_base;
> > >> > > >  };
> > >> > > > @@ -988,6 +987,17 @@ static void *pmic_gpio_populate_parent_fwspec(struct gpio_chip *chip,
> > >> > > >   return fwspec;
> > >> > > >  }
> > >> > > >
> > >> > > > +static const struct irq_chip spmi_gpio_irq_chip = {
> > >> > > > + .name           = "spmi-gpio",
> > >> > > > + .irq_ack        = irq_chip_ack_parent,
> > >> > > > + .irq_mask       = irq_chip_mask_parent,
> > >> > > > + .irq_unmask     = irq_chip_unmask_parent,
> > >> > >
> > >> > > No, this is wrong. Please look at the documentation to see how you
> > >> > > must now directly call into the gpiolib helpers for these two
> > >> > > callbacks.
> > >> > >
> > >> >
> > >> > IIUC, you are referring to gpiochip_disable_irq() and
> > >> > gpiochip_enable_irq() APIs.
> > >>
> > >> I am indeed.
> > >>
> > >> > These APIs are supposed to let the gpiolib know about that the IRQ
> > >> > usage of these GPIOs. But for the case of hierarchial IRQ domain,
> > >> > isn't the parent is going to do that?
> > >>
> > >> Why would it? The parent has no clue about what sits above it. In a
> > >> hierarchical configuration, each level is responsible for its own
> > >> level, and the GPIO layer should be responsible for its own
> > >> management.
> > >>
> > >> > Please correct me if I'm wrong.
> > >>
> > >> I'm afraid you are, and this patch is a fairly obvious change in
> > >> behaviour, as the callbacks you mention above are not called anymore,
> > >> while they were before.
> > >>
> > >> If they are not necessary (for reasons I can't fathom), then this
> > >> should be clearly explained.
> > >
> > > Hi Marc,
> > > I will look at IRQ GPIO docs, but in this case, then we have more
> > > conversions that
> > > are not correct.
> >
> > Then please point them out.
> 
> Oh, now I get the issue, I was misunderstanding it completely.
> gpiochip_enable_irq and gpiochip_disable_irq are not being called
> at all.
> 
> However, I dont see them being called before the conversion as well.
> I am not really familiar with the PMIC IRQ-s, looked like an easy conversion
> to get rid of the warning.
> 
> Manivannan can you shed some light on this?
> 

I hope you got the answer by now. When I looked into the conversion I saw that
there were missing calls to gpiochip_{enable/disable}_irq APIs. But at that
time I blindly assumed (yeah very bad of myself) that the parent irqchip will
handle that :(

Anyway, you should call these helpers from the mask/unmask callbacks as a part
of the conversion patch. Let me know if you are onto it or not!

Thanks,
Mani

> Regards,
> Robert
> 
> 
> 
> 
> 
> >
> >          M.
> > --
> > Jazz is not dead. It just smells funny...

-- 
மணிவண்ணன் சதாசிவம்
