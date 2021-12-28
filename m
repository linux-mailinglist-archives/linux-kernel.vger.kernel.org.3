Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C8D480B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbhL1QVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:21:11 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:33614 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbhL1QVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:21:09 -0500
Received: from [IPv6:2a02:a03f:eafe:c901:b7e1:d25f:71b8:19e7] (unknown [IPv6:2a02:a03f:eafe:c901:b7e1:d25f:71b8:19e7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 4CE4528904D;
        Tue, 28 Dec 2021 17:21:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640708468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vaiKPsvgL29Gfgz/PTuixbM+UnphhcnKiyaBMMq0bz0=;
        b=O6MO9m3Y0AGGSX4DaNMj0YX+ulzqJEq+pZt+KzRTBMfbzS7DHIdzWHlprCiEx1yOpX+HUM
        FgW40vPwSNkqjFjj2gRwj39PcJa+szLSaLCeDhGdkXdsQSh0EvjJONAivT5yHBJRMezyW0
        4uxj1syUETJutAKCD1tWJO1XMU+x44eGbz5mFSBC6Vy73/Xe1YPdD97Cl5R20FMpbe3lXW
        wM2ex4TAHPm5U4X6kbRyX451+tkbVmtmxD/9uXytklohley64A2vmbPP3vMi3pGuVy4sT0
        D0io3Z4u5Ibl5nSGue96s0Iot8Cyqw1gT4jB70CmfHzCaj+nj1yX9pLqns5j9Q==
Message-ID: <9c15877604b5fc39d0d1fe23f59afeb78f6f63dd.camel@svanheule.net>
Subject: Re: [RFC PATCH v2 2/5] irqchip/realtek-rtl: fix off-by-one in
 routing
From:   Sander Vanheule <sander@svanheule.net>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org
Date:   Tue, 28 Dec 2021 17:21:06 +0100
In-Reply-To: <87k0fpyozt.wl-maz@kernel.org>
References: <cover.1640548009.git.sander@svanheule.net>
         <2235a7748b8f7689a96b1e0f91461e36a946a4ef.1640548009.git.sander@svanheule.net>
         <87tueuz732.wl-maz@kernel.org>
         <48164a669fee54e2dc58cdbbde25c600d88d93f9.camel@svanheule.net>
         <87k0fpyozt.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-12-28 at 10:59 +0000, Marc Zyngier wrote:
> On Tue, 28 Dec 2021 10:13:26 +0000,
> Sander Vanheule <sander@svanheule.net> wrote:
> > 
> > Hi Marc,
> > 
> > On Mon, 2021-12-27 at 10:16 +0000, Marc Zyngier wrote:
> > > On Sun, 26 Dec 2021 19:59:25 +0000,
> > > Sander Vanheule <sander@svanheule.net> wrote:
> > > > 
> > > > There is an offset between routing values (1..6) and the connected MIPS
> > > > CPU interrupts (2..7), but no distinction was made between these two
> > > > values.
> > > > 
> > > > This issue was previously hidden during testing, because an interrupt
> > > > mapping was used where for each required interrupt another (unused)
> > > > routing was configured, with an offset of +1.
> > > 
> > > Where does this 'other routing' come from?
> > 
> > When I reported the interrupt-map issue with this binding/driver, I
> > tried to reduce the mapping/routing to something as small as
> > possible, but I couldn't get away with anything less than the
> > following:
> > 
> >         interrupt-map =
> >                 <31 &cpuintc 2>, /* UART0 */
> >                 <20 &cpuintc 3>, /* SWCORE */
> >                 <19 &cpuintc 4>, /* WDT IP1 */
> >                 <18 &cpuintc 5>; /* WDT IP2 */
> > 
> > The UART0 and WDT_IP1 mappings were required. These would cause the
> > driver to assign chained handlers to <&cpuint 2> and <&cpuint 4>,
> > and also write values "2" and "4" to the respective routing
> > registers.
> > 
> > The SWCORE mapping was not required for any configured features, but
> > it was required to get the console to work. This is because a
> > routing register value of "2", actually causes that interrupt input
> > to be (electrically) cascaded into to <&cpuintc 3>. But <&cpuintc 3>
> > would only be assigned a chained handler because of the SWCORE
> > mapping.
> > 
> > By then assigning the same handler to all parent interrupts, and not
> > caring about which parent interrupt caused the handler to be called,
> > this ended up actually working.
> 
> Urgh... Pure luck, then.
> 
> > 
> > > > 
> > > > Offset the CPU IRQ numbers by -1 to retrieve the correct routing value.
> > > > 
> > > > Fixes: 9f3a0f34b84a ("irqchip: Add support for Realtek RTL838x/RTL839x interrupt
> > > > controller")
> > > > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > > > ---
> > > >  drivers/irqchip/irq-realtek-rtl.c | 8 +++++---
> > > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
> > > > index d6788dd93c7b..568614edd88f 100644
> > > > --- a/drivers/irqchip/irq-realtek-rtl.c
> > > > +++ b/drivers/irqchip/irq-realtek-rtl.c
> > > > @@ -95,7 +95,8 @@ static void realtek_irq_dispatch(struct irq_desc *desc)
> > > >   * SoC interrupts are cascaded to MIPS CPU interrupts according to the
> > > >   * interrupt-map in the device tree. Each SoC interrupt gets 4 bits for
> > > >   * the CPU interrupt in an Interrupt Routing Register. Max 32 SoC interrupts
> > > > - * thus go into 4 IRRs.
> > > > + * thus go into 4 IRRs. A routing value of '0' means the interrupt is left
> > > > + * disconnected. Routing values {1..15} connect to output lines {0..14}.
> > > >   */
> > > >  static int __init map_interrupts(struct device_node *node, struct irq_domain
> > > > *domain)
> > > >  {
> > > > @@ -134,7 +135,7 @@ static int __init map_interrupts(struct device_node *node,
> > > > struct
> > > > irq_domain *do
> > > >                 of_node_put(cpu_ictl);
> > > >  
> > > >                 cpu_int = be32_to_cpup(imap + 2);
> > > > -               if (cpu_int > 7)
> > > > +               if (cpu_int > 7 || cpu_int < 2)
> > > 
> > > How many output lines do you have? The comment above says something
> > > about having 15 output lines, but you limit it to 7...
> > 
> > The SoCs we are using with this interrupt controller, connect their
> > output lines to CPU IRQ 2..7. If "interrupt-map" specifies parent HW
> > IRQ numbers, the driver needs to verify those numbers are valid. If
> > they are, it can derive the routing register values from that.
> > 
> > On the other hand, routing register values have four bits. "0"
> > appears to disconnect an input interrupt, so that leaves 15
> > potential interrupt outputs (in theory, we don't have actual
> > hardware descriptions). Only 6 outputs are used here, but that could
> > be an implementation detail for these SoCs, rather than a limitation
> > of the interrupt router.
> 
> It would be good to find out if there are more CPU interrupts that can
> be targeted. My impression is that this is a copy/paste effect from
> the original BSP, and that nobody actually checked. But maybe that's
> the wrong impression.

The BSP doesn't seems to refer to anything but the 6 CPU HW IRQs, so it appears to be a
standard mti,cpu-interrupt-controller. Those only have 6 HW (2-7) and 2 SW (0-1) IRQs.

> > 
> > > >                         return -EINVAL;
> > > >  
> > > >                 if (!(mips_irqs_set & BIT(cpu_int))) {
> > > > @@ -143,7 +144,8 @@ static int __init map_interrupts(struct device_node *node,
> > > > struct
> > > > irq_domain *do
> > > >                         mips_irqs_set |= BIT(cpu_int);
> > > >                 }
> > > >  
> > > > -               regs[(soc_int * 4) / 32] |= cpu_int << (soc_int * 4) % 32;
> > > > +               /* Use routing values (1..6) for CPU interrupts (2..7) */
> > > > +               regs[(soc_int * 4) / 32] |= (cpu_int - 1) << (soc_int * 4) % 32;
> > > >                 imap += 3;
> > > >         }
> > > >  
> > > 
> > > What I don't understand is how this worked so far if all mappings were
> > > off my one. Or the mapping really doesn't matter, because this is all
> > > under SW control?
> > 
> > The reason this worked, was due to a number of issues compensating
> > for each other, like I tried to explain above.
> > 
> > The mapping is indeed arbitrary, and not designed into the
> > hardware. So it could (should?)  just be put in the driver, instead
> > of the devicetree.
> 
> Indeed. Which is what I was advocating for the first place. What I
> understand from the HW is that it is able to freely route any input to
> any output (muxing them as required), and to map each output to any
> CPU interrupt line.

Indeed input-to-output is runtime configurable, but output-to-parent is hard-wired AFAICT.
If the output-to-parent mapping is known, an input-to-parent mapping can be used (i.e.
"interrupt-map") to select the outputs.

> If my understanding is correct, the only thing you need from the DT is
> a description of which input an endpoint is targeting (the interrupt
> specifier), and a list of CPU interrupt lines. Everything else can be
> decided at runtime.

I think this hardware is similar to 'fsl,imx-intmux' (irq-imx-intmux.c). See also my
comments on the bindings patch.


> Anyway, I'll probably end-up queuing the first two patches for 5.17,
> and a Cc: to stable. The rest we can discuss ad-nauseam.

Would you like me to submit the first two separately or will you take them as they are
from this series?

Best,
Sander
