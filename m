Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E0946FFCE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240283AbhLJLdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:33:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:9170 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231759AbhLJLdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:33:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="238132239"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="238132239"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:29:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="612898820"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:29:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mve4p-004TGO-T0;
        Fri, 10 Dec 2021 13:28:35 +0200
Date:   Fri, 10 Dec 2021 13:28:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message
 when IRQ can't be retrieved
Message-ID: <YbM541VXHoOUsM5+@smile.fi.intel.com>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d841bc59-a2a6-27f5-10af-05fe2e24067a@omp.ru>
 <YbI/6OIKM7qvLQcp@smile.fi.intel.com>
 <bfd96f5a-94c7-cee6-9546-14dc59cb8542@omp.ru>
 <YbJXjmsDJWlr3xpB@smile.fi.intel.com>
 <15cf03b2-8d45-93b1-f0a0-d79c93cee0da@omp.ru>
 <YbMvfzKsc4CcQzSa@smile.fi.intel.com>
 <7ffe328f-2ba1-4799-5c6a-d48d88c0459d@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ffe328f-2ba1-4799-5c6a-d48d88c0459d@omp.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 02:14:15PM +0300, Sergey Shtylyov wrote:
> On 12/10/21 1:44 PM, Andy Shevchenko wrote:
> 
> >>>>>>> While at it, drop redundant check for 0 as platform_get_irq() spills
> >>>>>>> out a big WARN() in such case.
> >>>>>>
> >>>>>>    And? IRQ0 is still returned! :-(
> >>>>>
> >>>>> It should not be returned in the first place.
> >>>>
> >>>>    But it still is, despite the WARN(), right?
> >>>
> >>> So, you admit that there is a code which does that?
> >>
> >>    I admit *what*?! That platfrom_get_irq() and its ilk return IRQ0 while they
> >> shouldn't? =)
> > 
> > That there is a code beneath platform_get_irq() that returns 0, yes.
> 
>    Look at the ACPI-specific GpioInt handling code (just above the out_not_found label) --
> I'm not sure the check there is correct -- I'm not very familiar with ACPI, you seem to
> know it much better. :-)

And what is your point here exactly? If == 0 case happens, it will be
immediately WARN() and reported (I hope) since it will mean bug in the code.

>    Also, 0 can be specified via the normal IRQ resource. I know of e.g. the Alchemy MIPS SoCs
> that have IRQ0 used by UART0; luckily, currently SoC IRQs are mapped starting at Linux IRQ8
> (but it wasn't the case in the 2.6.1x time frame where we had issue with the serial driver)...

You mixed up HW IRQ with vIRQ. The former one may be 0 and it's completely valid case, while
the second one is not.

> >>> That code should be fixed first. Have you sent a patch?
> >>
> >>    Which code?! You got me totally muddled. =)
> > 
> > Above mentioned.
> 
>    What needs to be fixed in this case is the interrupt controller driver.

What do you mean by that? vIRQ is handled by IRQ core, IRQ controller driver
just a mere provider of the resource. And those exceptions for vIRQ == 0
shouldn't be propagated to the platform code or so.

> Quoting Linus
> (imprecisely :-)), IRQ #s should be either mapped starting with #1 or IRQ0 remapped at
> the end of the controller's interrupt range... I currently have no information on the
> platforms requiring such kind of fixing (Alchemy don't seem to need it now)...

Again, do not mix vIRQ (about which Linus ranted) and HW IRQ.

...

> >>>>>>> -	if (!irq)
> >>>>>>> -		return -EINVAL;
> >>>>>>
> >>>>>>    This is prermature -- let's wait till my patch that stops returning IRQ0 from
> >>>>>> platform_get_irq() and friends gets merged....
> >>>>>
> >>>>> What patch?
> >>>>
> >>>>    https://marc.info/?l=linux-kernel&m=163623041902285
> >>>>
> >>>>> Does it fix platform_get_irq_optional()?
> >>>>
> >>>>    Of course! :-)
> >>>
> >>> Can you share link to lore.kernel.org, please?
> >>> It will make much easier to try and comment.
> >>
> >>    I don't know how to uise it yet, and I'm a little busy with other IRQ0 issues ATM,

>    A little bit, I meant to type.

No problem. I just haven't got what other IRQ0 issues except fixing
platform_get_irq_optional() et al. could be possibly needed...

> >> so I'm afraid you're on your own here...
> > 
> > lore.kernel.org is the official mailing list archive for Linux kernel work
> > AFAIU. Other sites may do whatever they want with that information, so -->
> > they are unreliable. If you wish to follow the better process, use
> > lore.kernel.org. Understanding how it works takes no more than 5 minutes
> > by engineer with your kind of experience with Linux kernel development.
> 
>    OK, I'll explore this archive when I have time. BTW, does it keep the messages not
> posted to LKML (I tend to only CC LKML if there's no other mailing lists to post to)?

TL;DR: yes.

-- 
With Best Regards,
Andy Shevchenko


