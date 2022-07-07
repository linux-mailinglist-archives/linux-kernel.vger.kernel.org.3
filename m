Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6CE56A5AA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbiGGOkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbiGGOkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:40:12 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8ACE42AE07;
        Thu,  7 Jul 2022 07:40:07 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1o9Sfm-0000mx-00; Thu, 07 Jul 2022 16:40:06 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D197BC02B6; Thu,  7 Jul 2022 16:39:30 +0200 (CEST)
Date:   Thu, 7 Jul 2022 16:39:30 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Aleksander Jan Bajkowski <olek2@wp.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>, git@birger-koblitz.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: smp-mt: enable all hardware interrupts on second
 VPE
Message-ID: <20220707143930.GA14693@alpha.franken.de>
References: <20220702190705.5319-1-olek2@wp.pl>
 <3c9a032edd0fb9b9608ad3ca08d6e3cc38f21464.camel@svanheule.net>
 <87fsjen2kl.wl-maz@kernel.org>
 <20220706081901.GA10797@alpha.franken.de>
 <CAFBinCAsj=RNvitj2tXJU6pTLSbanRXdKM9H4vyF=N9N=PP06g@mail.gmail.com>
 <20220707100630.GC9894@alpha.franken.de>
 <CAFBinCBn3+MbKFE84Y0KjW4qG_88+HuBTzRhPQSDqzqGhyhhZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFBinCBn3+MbKFE84Y0KjW4qG_88+HuBTzRhPQSDqzqGhyhhZw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 02:57:15PM +0200, Martin Blumenstingl wrote:
> On Thu, Jul 7, 2022 at 12:11 PM Thomas Bogendoerfer
> <tsbogend@alpha.franken.de> wrote:
> [...]
> > > - why can MIPS CPU interrupt 6 and 7 be enabled unconditionally while
> > > 2-5 cannot be enabled unconditionally?
> >
> > 7 is timer interrupt and is usually wired for 34K cpus and 6 is
> > performance counter hopefully handled as well. And I agree that
> > this still isn't the best approach here
> Thanks for this explanation!
> 
> > > - seeing that there's also a mips_gic_present() check in the opposite
> > > case of what Aleksander's patch modifies: does this indicate that
> > > unmasking CPU interrupt lines for VPE 1 is not handled by the MIPS CPU
> > > interrupt controller driver at all at this point (and if so: do you
> > > have any suggestions how to properly fix this)?
> >
> > I haven't checked how GIC is integrated. Iirc it does something similair
> > to Lantiq's irq controller and hides all CPU internal interrupts behind
> > it.
> >
> > So I see two solutions for your problem.
> >
> > 1. Add "mti,cpu-interrupt-controller" to the DT and wire it up
> I think this is the preferred way. I tried this before (if you are
> curious, see [0] and [1]) and it didn't work.
> Are you aware of any MIPS SoC with upstream drivers which do have
> working IRQs on VPE 1?

I don't know of such SoC. Looking at the comment in vsmp_init_secondary()

/* This is Malta specific: IPI,performance and timer interrupts */

there is probably some Malta board using it.

> Or can you point me to the code in
> drivers/irqchip/irq-mips-cpu.c that's responsible for enabling the
> interrupts on VPE 1 (is it simply unmask_mips_irq)?

IMHO there is the problem, irq-mips-cpu.c can only do CPU irq operations
on the same CPU. I've checked MIPS MT specs and it's possible do
modify CP0 registers between VPEs. Using that needs changes in
irq-mips-cpu.c. But mabye that's not woth the effort as probably
all SMP cabable platforms have some multi processort capable
interrupt controller implemented.

I thought about another way solve the issue. By introducing a
new function in smp-mt.c which sets the value of the interrupt
mask for the secondary CPU, which is then used in vsmp_init_secondary().
Not sure if this is worth the effort compared to a .boot_secondary
override.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
