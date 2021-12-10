Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCD74707B6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244795AbhLJR4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:56:17 -0500
Received: from mga17.intel.com ([192.55.52.151]:18455 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244769AbhLJR4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:56:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="219090440"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="219090440"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 09:52:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="480801816"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 09:52:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mvk3T-004b4u-PL;
        Fri, 10 Dec 2021 19:51:35 +0200
Date:   Fri, 10 Dec 2021 19:51:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message
 when IRQ can't be retrieved
Message-ID: <YbOTp2f0WLhPo0bu@smile.fi.intel.com>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d841bc59-a2a6-27f5-10af-05fe2e24067a@omp.ru>
 <YbI/6OIKM7qvLQcp@smile.fi.intel.com>
 <bfd96f5a-94c7-cee6-9546-14dc59cb8542@omp.ru>
 <YbJXjmsDJWlr3xpB@smile.fi.intel.com>
 <15cf03b2-8d45-93b1-f0a0-d79c93cee0da@omp.ru>
 <YbMvfzKsc4CcQzSa@smile.fi.intel.com>
 <7ffe328f-2ba1-4799-5c6a-d48d88c0459d@omp.ru>
 <YbM541VXHoOUsM5+@smile.fi.intel.com>
 <51c0aa6e-e75f-faa7-b9b1-850684da58c8@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51c0aa6e-e75f-faa7-b9b1-850684da58c8@omp.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 08:39:38PM +0300, Sergey Shtylyov wrote:
> On 12/10/21 2:28 PM, Andy Shevchenko wrote:
> 
> >>>>>>>>> While at it, drop redundant check for 0 as platform_get_irq() spills
> >>>>>>>>> out a big WARN() in such case.
> >>>>>>>>
> >>>>>>>>    And? IRQ0 is still returned! :-(
> >>>>>>>
> >>>>>>> It should not be returned in the first place.
> >>>>>>
> >>>>>>    But it still is, despite the WARN(), right?
> >>>>>
> >>>>> So, you admit that there is a code which does that?
> >>>>
> >>>>    I admit *what*?! That platfrom_get_irq() and its ilk return IRQ0 while they
> >>>> shouldn't? =)
> >>>
> >>> That there is a code beneath platform_get_irq() that returns 0, yes.
> >>
> >>    Look at the ACPI-specific GpioInt handling code (just above the out_not_found label) --
> >> I'm not sure the check there is correct -- I'm not very familiar with ACPI, you seem to
> >> know it much better. :-)
> > 
> > And what is your point here exactly?
> 
>    You're saying IRQ0 shouldn't be returned (by the ACPI code) -- from this fragment
> we can see that it may be returned...

Please, provide your analysis, I really don't see how it's possible.
If you prove that, we must fix the severe bug then.

> > If == 0 case happens, it will be
> > immediately WARN() and reported (I hope)
> 
>    Well, "hope dies last"... :-)

Believe, big WARNs are quite likely to be reported if not by humans, then by
CIs and fuzzers. So, the hope is rather to word 'immediately'.

> > since it will mean bug in the code.
> > 
> >>    Also, 0 can be specified via the normal IRQ resource. I know of e.g. the Alchemy MIPS SoCs
> >> that have IRQ0 used by UART0; luckily, currently SoC IRQs are mapped starting at Linux IRQ8
> >> (but it wasn't the case in the 2.6.1x time frame where we had issue with the serial driver)...
> > 
> > You mixed up HW IRQ with vIRQ.
> 
>    I didn't. Linux expects the vIRQs (I called them Linux IRQs). In the 2.6.1x time frame
> those corresponded 1:1 on Alchemy. Also, there's 8259 which is always mapped at vIRQ0 (or
> the legacy drivers won't work).
> 
> > The former one may be 0 and it's completely valid case, while
> > the second one is not.
> 
>    Well, request_irq() happilly takes vIRQ0. Moreover, there are 8253 drivers in e.g. the arch/x86/
> (PPC and MIPS too) which do use vIRQ0.

This is an exception which is not in the scope here. Let me remind that the
topic here is libahci_platform and platform_get_irq().

> >>>>> That code should be fixed first. Have you sent a patch?
> >>>>
> >>>>    Which code?! You got me totally muddled. =)
> >>>
> >>> Above mentioned.
> >>
> >>    What needs to be fixed in this case is the interrupt controller driver.
> > 
> > What do you mean by that?
> 
>    You better ask Linus... ;-)

If you cite somebody you have to understand what they said, right?
Lemme repeat the question, what do you mean by that? In your own words, please.

> > vIRQ is handled by IRQ core, IRQ controller driver
> > just a mere provider of the resource. And those exceptions for vIRQ == 0
> > shouldn't be propagated to the platform code or so.
> 
> >> Quoting Linus
> >> (imprecisely :-)), IRQ #s should be either mapped starting with #1 or IRQ0 remapped at
> >> the end of the controller's interrupt range... I currently have no information on the
> >> platforms requiring such kind of fixing (Alchemy don't seem to need it now)...
> 
>    Well, actually that Linus' quote predates drivers/irqchip/, so I must confess this
> argument was wrong... :-)
> 
> > Again, do not mix vIRQ (about which Linus ranted) and HW IRQ.

...

> >>>>>>>>> -	if (!irq)
> >>>>>>>>> -		return -EINVAL;
> >>>>>>>>
> >>>>>>>>    This is prermature -- let's wait till my patch that stops returning IRQ0 from
> >>>>>>>> platform_get_irq() and friends gets merged....
> >>>>>>>
> >>>>>>> What patch?
> >>>>>>
> >>>>>>    https://marc.info/?l=linux-kernel&m=163623041902285
> >>>>>>
> >>>>>>> Does it fix platform_get_irq_optional()?
> >>>>>>
> >>>>>>    Of course! :-)
> >>>>>
> >>>>> Can you share link to lore.kernel.org, please?
> >>>>> It will make much easier to try and comment.
> >>>>
> >>>>    I don't know how to uise it yet, and I'm a little busy with other IRQ0 issues ATM,
> > 
> >>    A little bit, I meant to type.
> > 
> > No problem. I just haven't got what other IRQ0 issues except fixing
> > platform_get_irq_optional() et al. could be possibly needed...
> 
>    There is other IRQ0 issue which is very old already...

Is it big secret? What is that issue?

-- 
With Best Regards,
Andy Shevchenko


