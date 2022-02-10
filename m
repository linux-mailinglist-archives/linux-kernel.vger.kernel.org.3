Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0AA4B0E03
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 14:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241885AbiBJNAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 08:00:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbiBJNAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:00:12 -0500
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E371210C8;
        Thu, 10 Feb 2022 05:00:10 -0800 (PST)
Received: by mail-pj1-f43.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so8434227pjl.2;
        Thu, 10 Feb 2022 05:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5havQfhy54vFpCXLxCR1KEbNC9FYGFMgir3uPBNso6g=;
        b=x5OCdzvNT/RjMeC+zycIrCBAgDk834mTH5rhgN/fpWHDxNPvFQvD5I2QeAbw+C55Mu
         YhHL+jCnONtManyPsnczpgAPdU7bXoXvAMU/ZJ6EDHzOhBmhqQ7/N5QR4tIFuhYKEp3b
         b5Uurej/6bGfJulAV2+uspOSHjaWz4MZX9Je73PI008xz/m2ng7CPKP60GF4EEMlk1hg
         wFSQUHmnR2N1OmBCy56qGpO78n4Vy82uaWR8T87kMbR+3j2F2dqAY08tX5L8lwo3AKso
         RCtIMBBnm5Pmv+EyD/ZiRjQZZSUVtI/MxiLiC2WvqAyh+TJAn/KA/YPeZZi/F3ELSN0E
         sfPA==
X-Gm-Message-State: AOAM533ZK4j8TjfWR3SzZK4IkKjkllzTilydTZsIzC6qKFJytu8Ts3OJ
        Fxk00wK49xlOC7URyIr8m7JTO/0OcU1epzWOt9Q=
X-Google-Smtp-Source: ABdhPJykZr+Oci+S2VHEw4I1iubQnEhkG5OOcbqZYrz2zGYnTS8kPBjOK/CzTwedRMy29+s+/Gp8v2XoN19SNtv8gW0=
X-Received: by 2002:a17:903:11c3:: with SMTP id q3mr7517443plh.97.1644498010285;
 Thu, 10 Feb 2022 05:00:10 -0800 (PST)
MIME-Version: 1.0
References: <20220209162607.1118325-1-maz@kernel.org> <20220209162607.1118325-11-maz@kernel.org>
 <CANBLGcwKeLn7Q1Ra8pCw=cXy=kJeEFRmBjOxjds10+k70LvzXA@mail.gmail.com> <87zgmz3xbf.wl-maz@kernel.org>
In-Reply-To: <87zgmz3xbf.wl-maz@kernel.org>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Thu, 10 Feb 2022 13:59:59 +0100
Message-ID: <CANBLGcwwrqkYS2cxX5dYAaoWdj5pRp9c+qBDAMb3=0D5oBD+Zg@mail.gmail.com>
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

On Thu, 10 Feb 2022 at 10:06, Marc Zyngier <maz@kernel.org> wrote:
> On Wed, 09 Feb 2022 23:30:55 +0000,
> Emil Renner Berthing <kernel@esmil.dk> wrote:
> >
> > On Wed, 9 Feb 2022 at 17:49, Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > Instead of overloading the name field, use the relevant callback to
> > > output the device name.
> > >
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > ---
> > >  drivers/pinctrl/pinctrl-starfive.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/pinctrl/pinctrl-starfive.c b/drivers/pinctrl/pinctrl-starfive.c
> > > index 5be9866c2b3c..f29d9ccf858b 100644
> > > --- a/drivers/pinctrl/pinctrl-starfive.c
> > > +++ b/drivers/pinctrl/pinctrl-starfive.c
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/of.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/reset.h>
> > > +#include <linux/seq_file.h>
> > >  #include <linux/spinlock.h>
> > >
> > >  #include <linux/pinctrl/pinctrl.h>
> > > @@ -1163,12 +1164,20 @@ static int starfive_irq_set_type(struct irq_data *d, unsigned int trigger)
> > >         return 0;
> > >  }
> > >
> > > +static void starfive_irq_print_chip(struct irq_data *d, struct seq_file *p)
> > > +{
> > > +       struct starfive_pinctrl *sfp = starfive_from_irq_data(d);
> > > +
> > > +       seq_printf(p, sfp->gc.label);
> > > +}
> > > +
> > >  static struct irq_chip starfive_irq_chip = {
> > >         .irq_ack = starfive_irq_ack,
> > >         .irq_mask = starfive_irq_mask,
> > >         .irq_mask_ack = starfive_irq_mask_ack,
> > >         .irq_unmask = starfive_irq_unmask,
> > >         .irq_set_type = starfive_irq_set_type,
> > > +       .irq_print_chip = starfive_irq_print_chip,
> > >         .flags = IRQCHIP_SET_TYPE_MASKED,
> > >  };
> >
> > The parent interrupt doesn't show up in /proc/interrupts anyway, so if
> > setting the name is considered abuse we can just drop the addition
> > above and just delete the two lines below.
>
> Are you sure this never appears? Is there a another irqchip stacked on
> top of this one? Could you please dump /sys/kernel/debug/irq/irqs/XX,
> where XX is an interrupt number using one of these GPIO pins? Please
> run it without this patch, as I just noticed that debugfs blindly
> uses the name.

Yes, the old gpio driver this derives from used to set
    sfp->gc.irq.parent_handler = NULL
and then register its own irq handler, then the parent would show up
in /proc/interrupts. But after switching to letting the gpio framework
register the handler it stopped showing up.

root@visionfive~# cat /proc/interrupts
           CPU0       CPU1
  5:       5035       4907  RISC-V INTC   5 Edge      riscv-timer
  6:        960          0  SiFive PLIC   4 Edge      dw-mci
  7:       4384          0  SiFive PLIC   5 Edge      dw-mci
  8:        562          0  SiFive PLIC   6 Edge      eth0
 10:          1          0  SiFive PLIC   7 Edge      eth0
 11:          0          0  SiFive PLIC   2 Edge      dw_axi_dmac_platform
 15:       2690          0  SiFive PLIC  44 Edge      xhci-hcd:usb1
 17:          0          0  SiFive PLIC  43 Edge      104c0000.usb
 18:          0          0  SiFive PLIC   1 Edge      dw_axi_dmac_platform
 20:        234          0  SiFive PLIC  96 Edge      118b0000.i2c
 21:          0          0  SiFive PLIC  97 Edge      118c0000.i2c
 22:          7          0  SiFive PLIC  98 Edge      118d0000.trng
 28:          0          0  SiFive PLIC 101 Edge      sf_lcdc
 29:          0          0  SiFive PLIC 103 Edge      sf_vpp1
 30:          0          0  SiFive PLIC  70 Edge      12410000.spi
 31:        205          0  SiFive PLIC  73 Edge      ttyS0
 32:          0          0  SiFive PLIC  74 Edge      12450000.i2c
 33:          0          0  SiFive PLIC  80 Edge      12480000.watchdog
 34:         28          0  SiFive PLIC 122 Edge      124a0000.tmon
 37:          0          0  11910000.pinctrl  35 Edge      gpiomon
IPI0:        52        133  Rescheduling interrupts
IPI1:      2591       6924  Function call interrupts
IPI2:         0          0  CPU stop interrupts
IPI3:         0          0  IRQ work interrupts
IPI4:         0          0  Timer broadcast interrupts
root@visionfive~# cat /sys/kernel/debug/irq/irqs/26
handler:  starfive_gpio_irq_handler
device:   (null)
status:   0x00010c00
            _IRQ_NOPROBE
            _IRQ_NOREQUEST
            _IRQ_NOTHREAD
istate:   0x00000000
ddepth:   0
wdepth:   0
dstate:   0x02401200
            IRQD_ACTIVATED
            IRQD_IRQ_STARTED
            IRQD_AFFINITY_SET
            IRQD_DEFAULT_TRIGGER_SET
node:     0
affinity: 0-1
domain:  :soc:interrupt-controller@c000000
 hwirq:   0x20
 chip:    SiFive PLIC
  flags:   0x0
root@visionfive~# cat /sys/kernel/debug/irq/irqs/37
handler:  handle_edge_irq
device:   (null)
status:   0x00000403
            _IRQ_NOPROBE
istate:   0x00000020
            IRQS_ONESHOT
ddepth:   0
wdepth:   0
dstate:   0x00400203
            IRQ_TYPE_EDGE_RISING
            IRQ_TYPE_EDGE_FALLING
            IRQD_ACTIVATED
            IRQD_IRQ_STARTED
node:     0
affinity: 0-1
domain:  :soc:pinctrl@11910000
 hwirq:   0x23
 chip:    11910000.pinctrl
  flags:   0x1
             IRQCHIP_SET_TYPE_MASKED

> > The gpio framework seems to fill in default handlers in the struct
> > above, so unfortunately it can't yet be made const. Is this something
> > you intend to fix in the future?
>
> This is next on my list of things to address. The whole 'let's copy a
> whole irqchip structure and hijack random pointers' should not have
> happened, and it certainly is going to be an interesting ride.

Sounds great, thanks.

/Emil
