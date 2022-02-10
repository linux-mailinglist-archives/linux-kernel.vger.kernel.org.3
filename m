Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 466684B0FF2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 15:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242712AbiBJOOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 09:14:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242701AbiBJOOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 09:14:30 -0500
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930CF1B1;
        Thu, 10 Feb 2022 06:14:31 -0800 (PST)
Received: by mail-pf1-f178.google.com with SMTP id y8so7734102pfa.11;
        Thu, 10 Feb 2022 06:14:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LUbnigTK7eMp70mYsejtJbJYjEFyQuhAMXnMyn7VY2s=;
        b=WoxjrqKt/C2/8hUf6FRXzJhbHV20uHkulyFEzwWmtvct4ZtIB0wSQ7Krt6DpZZH6IK
         80QV1JvPuUHLvWPBCYvBhtr4lfPMk878gnVk+cT0cuLzgkVMVas3ioeisCwibJKqx1i8
         qIqGECgK6kZQPWErfI21RJWQC1SSKrQ2oo09hyt6bqAzMxivSp5gigh+2LjHz7EXQCVI
         ghogz6WxM5d7jUBk9QAVmzuOoxQjp8ReNivv/s3celq3/G7ZvelDOkC0ydZA6b8blGK1
         rZA6bOz64tLjffKGDhLe1uS7pkPUBIy5EYMYBwalZy6+r7my3YCBjg90uhqdoIwfGou+
         KQgA==
X-Gm-Message-State: AOAM5313qUSSa05KH9IqGsaaS+x08u+yTQKemHREeNL8+yya8f9WrOaR
        MlQPPnZIQ7NssAB0wkYjJ0ZyYo+qTqO+PdMg3yk=
X-Google-Smtp-Source: ABdhPJwiopYFp7pKfiNckfL/EHgfbB16QLvg8l6yZlX0EwLMXr0WLF0kGb74/gs3GKS1QXJuplwxBRuUJHp03LesFYo=
X-Received: by 2002:a63:4505:: with SMTP id s5mr2889541pga.531.1644502471010;
 Thu, 10 Feb 2022 06:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20220209162607.1118325-1-maz@kernel.org> <20220209162607.1118325-11-maz@kernel.org>
 <CANBLGcwKeLn7Q1Ra8pCw=cXy=kJeEFRmBjOxjds10+k70LvzXA@mail.gmail.com>
 <87zgmz3xbf.wl-maz@kernel.org> <CANBLGcwwrqkYS2cxX5dYAaoWdj5pRp9c+qBDAMb3=0D5oBD+Zg@mail.gmail.com>
 <87v8xm4zkm.wl-maz@kernel.org> <CANBLGcyvMVdTnndMSWDFnN6207Nareps=AdzVvt0OaMdeAXEHg@mail.gmail.com>
 <87tud64yqa.wl-maz@kernel.org>
In-Reply-To: <87tud64yqa.wl-maz@kernel.org>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Thu, 10 Feb 2022 15:14:19 +0100
Message-ID: <CANBLGcxg0qKWw4aifr+dHWge1aXE66e4wZzDwwpJjSad3xaeTQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] pinctrl: starfive: Switch to dynamic chip name output
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022 at 14:50, Marc Zyngier <maz@kernel.org> wrote:
> On Thu, 10 Feb 2022 13:44:12 +0000,
> Emil Renner Berthing <kernel@esmil.dk> wrote:
> >
> > On Thu, 10 Feb 2022 at 14:32, Marc Zyngier <maz@kernel.org> wrote:
> > > On Thu, 10 Feb 2022 12:59:59 +0000,
> > > Emil Renner Berthing <kernel@esmil.dk> wrote:
> > > >
> > > > On Thu, 10 Feb 2022 at 10:06, Marc Zyngier <maz@kernel.org> wrote:
> > > > > On Wed, 09 Feb 2022 23:30:55 +0000,
> > > > > Emil Renner Berthing <kernel@esmil.dk> wrote:
> > > > > >
> > > > > > On Wed, 9 Feb 2022 at 17:49, Marc Zyngier <maz@kernel.org> wrote:
> > > > > > >
> > > > > > > Instead of overloading the name field, use the relevant callback to
> > > > > > > output the device name.
> > > > > > >
> > > > > > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > > > > > ---
> > > > > > >  drivers/pinctrl/pinctrl-starfive.c | 11 +++++++++--
> > > > > > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/pinctrl/pinctrl-starfive.c b/drivers/pinctrl/pinctrl-starfive.c
> > > > > > > index 5be9866c2b3c..f29d9ccf858b 100644
> > > > > > > --- a/drivers/pinctrl/pinctrl-starfive.c
> > > > > > > +++ b/drivers/pinctrl/pinctrl-starfive.c
> > > > > > > @@ -15,6 +15,7 @@
> > > > > > >  #include <linux/of.h>
> > > > > > >  #include <linux/platform_device.h>
> > > > > > >  #include <linux/reset.h>
> > > > > > > +#include <linux/seq_file.h>
> > > > > > >  #include <linux/spinlock.h>
> > > > > > >
> > > > > > >  #include <linux/pinctrl/pinctrl.h>
> > > > > > > @@ -1163,12 +1164,20 @@ static int starfive_irq_set_type(struct irq_data *d, unsigned int trigger)
> > > > > > >         return 0;
> > > > > > >  }
> > > > > > >
> > > > > > > +static void starfive_irq_print_chip(struct irq_data *d, struct seq_file *p)
> > > > > > > +{
> > > > > > > +       struct starfive_pinctrl *sfp = starfive_from_irq_data(d);
> > > > > > > +
> > > > > > > +       seq_printf(p, sfp->gc.label);
> > > > > > > +}
> > > > > > > +
> > > > > > >  static struct irq_chip starfive_irq_chip = {
> > > > > > >         .irq_ack = starfive_irq_ack,
> > > > > > >         .irq_mask = starfive_irq_mask,
> > > > > > >         .irq_mask_ack = starfive_irq_mask_ack,
> > > > > > >         .irq_unmask = starfive_irq_unmask,
> > > > > > >         .irq_set_type = starfive_irq_set_type,
> > > > > > > +       .irq_print_chip = starfive_irq_print_chip,
> > > > > > >         .flags = IRQCHIP_SET_TYPE_MASKED,
> > > > > > >  };
> > > > > >
> > > > > > The parent interrupt doesn't show up in /proc/interrupts anyway, so if
> > > > > > setting the name is considered abuse we can just drop the addition
> > > > > > above and just delete the two lines below.
> > > > >
> > > > > Are you sure this never appears? Is there a another irqchip stacked on
> > > > > top of this one? Could you please dump /sys/kernel/debug/irq/irqs/XX,
> > > > > where XX is an interrupt number using one of these GPIO pins? Please
> > > > > run it without this patch, as I just noticed that debugfs blindly
> > > > > uses the name.
> > > >
> > > > Yes, the old gpio driver this derives from used to set
> > > >     sfp->gc.irq.parent_handler = NULL
> > > > and then register its own irq handler, then the parent would show up
> > > > in /proc/interrupts. But after switching to letting the gpio framework
> > > > register the handler it stopped showing up.
> > >
> > > But this patch does not deal with the parent interrupt. It deals with
> > > the irqchip that is used for the 'children interrupt'. Output
> > > interrupts for a chained handler are never shown, as they don't really
> > > make much sense on their own (you'd only see the sum of the input
> > > interrupts).
> >
> > I see. Sorry for the confusion.
> >
> > > >
> > > > root@visionfive~# cat /proc/interrupts
> > > >            CPU0       CPU1
> > > >   5:       5035       4907  RISC-V INTC   5 Edge      riscv-timer
> > > >   6:        960          0  SiFive PLIC   4 Edge      dw-mci
> > > >   7:       4384          0  SiFive PLIC   5 Edge      dw-mci
> > > >   8:        562          0  SiFive PLIC   6 Edge      eth0
> > > >  10:          1          0  SiFive PLIC   7 Edge      eth0
> > > >  11:          0          0  SiFive PLIC   2 Edge      dw_axi_dmac_platform
> > > >  15:       2690          0  SiFive PLIC  44 Edge      xhci-hcd:usb1
> > > >  17:          0          0  SiFive PLIC  43 Edge      104c0000.usb
> > > >  18:          0          0  SiFive PLIC   1 Edge      dw_axi_dmac_platform
> > > >  20:        234          0  SiFive PLIC  96 Edge      118b0000.i2c
> > > >  21:          0          0  SiFive PLIC  97 Edge      118c0000.i2c
> > > >  22:          7          0  SiFive PLIC  98 Edge      118d0000.trng
> > > >  28:          0          0  SiFive PLIC 101 Edge      sf_lcdc
> > > >  29:          0          0  SiFive PLIC 103 Edge      sf_vpp1
> > > >  30:          0          0  SiFive PLIC  70 Edge      12410000.spi
> > > >  31:        205          0  SiFive PLIC  73 Edge      ttyS0
> > > >  32:          0          0  SiFive PLIC  74 Edge      12450000.i2c
> > > >  33:          0          0  SiFive PLIC  80 Edge      12480000.watchdog
> > > >  34:         28          0  SiFive PLIC 122 Edge      124a0000.tmon
> > > >  37:          0          0  11910000.pinctrl  35 Edge      gpiomon
> > >                               ^^^^^^^^^^^^^^^^
> > > This is what this patch deals with. Going with your suggestion of
> > > dropping this output (or to hardcode it to something else) would be a
> > > userspace visible change, and we can't do that.
> >
> > Gotcha. The SoC has been out in very few numbers for less than a year
> > and the driver only entered mainline in 5.17-rc1, so I doubt anyone
> > has had time to write scripts that check for this, but I'll let it be
> > up to you.
>
> Ah, I should have checked that. In which case, would you be OK if I
> simply pushed the removal of this label as a fix for 5.17, and just
> have it to say "Star5 GPIO", for example, without any indication of
> the device (which appears in debugfs anyway as part of the irqdomain)?

I'm fine with it although I'd prefer "StarFive GPIO". I haven't seen
star5 used anywhere.
But shouldn't changes like this normally go through Linus Walleij's tree?

/Emil
