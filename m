Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE2C4707F2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244876AbhLJSCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:02:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:5780 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235392AbhLJSCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:02:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="238347542"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="238347542"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 09:58:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="544053703"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 09:58:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mvk9M-004bBe-TE;
        Fri, 10 Dec 2021 19:57:40 +0200
Date:   Fri, 10 Dec 2021 19:57:40 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message
 when IRQ can't be retrieved
Message-ID: <YbOVFH1B2TDZEcGY@smile.fi.intel.com>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
 <CAHp75VcdwozpUJVB17VmCDska7euYnx1VjZLnCaZ8DHG+_3vYg@mail.gmail.com>
 <587c35bd-8877-030e-6236-d0d8c2b6811c@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <587c35bd-8877-030e-6236-d0d8c2b6811c@omp.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 07:38:40PM +0300, Sergey Shtylyov wrote:
> On 12/10/21 11:47 AM, Andy Shevchenko wrote:
> 
> >>> platform_get_irq() will print a message when it fails.
> >>> No need to repeat this.
> >>>
> >>> While at it, drop redundant check for 0 as platform_get_irq() spills
> >>> out a big WARN() in such case.
> >>
> >> The reason you should be able to remove the "if (!irq)" test is that
> >> platform_get_irq() never returns 0. At least, that is what the function kdoc
> >> says. But looking at platform_get_irq_optional(), which is called by
> >> platform_get_irq(), the out label is:
> >>
> >>         WARN(ret == 0, "0 is an invalid IRQ number\n");
> >>         return ret;
> >>
> >> So 0 will be returned as-is. That is rather weird. That should be fixed to
> >> return -ENXIO:
> >>
> >>         if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
> >>                 return -ENXIO;
> 
>    -ENXIO seems to me more fitting indeed (than -EINVAL that I used).
> 
> > 
> > No, this is wrong for the same reasons I explained to Sergey.
> 
>    I fail to understand you, sorry. We're going in circles, it seems... :-/

platform_get_irq_optional() is supposed to return 0 when there is no IRQ found,
but everything else went alright.

I'm tired to waste my time to go circles.

Again, the problem is that platform_get_irq_optional() has wrong set of output
values. And your patch doesn't fix that. And it has nothing to do with my code
here.

> > The problem is that this is _optional API and it has been misdesigned.
> > Replacing things like above will increase the mess.
> 
>    What's wrong with replacing IRQ0 with -ENXIO now? platform_get_irq_optional()
> (as in your patch) could then happily return 0 ISO -ENXIO. Contrarywise, if we don't
> replace IRQ0 with -ENXIO, platform_get_irq_optional() will return 0 for both IRQ0
> and missing IRQ! Am I clear enough? If you don't understand me now, I don't know what
> to say... :-/

See above. Read my messages again, please. I'm really tired to explain again
and again the same.

TL;DR: You simply try to "fix" in a correct place but in a wrong way.

> >>         return ret;
> >>
> >> Otherwise, I do not think that removing the "if (!irq)" hunk is safe. no ?
> > 
> > No. This is not a business of the caller to workaround implementation
> > details (bugs) of the core APIs.
> > If something goes wrong, then it's platform_get_irq() to blame, and
> > not the libahci_platform.
> 
>    I'm repeating myself already: we don't work around the bug in platform_get_irq(),

Yes, you do.

> we're working around the driver subsystems that treat 0 specially (and so don't
> support IRQ0); libata treats 0 as an indication of the polling mode (moreover,
> it will curse if you pass to it both IRQ == 0 and a pointer to an interrupt handler!
> Am I clear enough this time? :-)

Yes, and it doesn't contradict to what my patch does.
Read comment against platform_get_irq(). If it returns 0,
it's not a business of the callers to work around it.

Am I clear enough this time? :-)

-- 
With Best Regards,
Andy Shevchenko


