Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B23470A59
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 20:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242834AbhLJTam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 14:30:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:39184 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234441AbhLJTak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 14:30:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="299212247"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="299212247"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 11:27:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="462649633"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 11:26:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mvlWd-004coT-DK;
        Fri, 10 Dec 2021 21:25:47 +0200
Date:   Fri, 10 Dec 2021 21:25:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message
 when IRQ can't be retrieved
Message-ID: <YbOpu2whB5NaXbNa@smile.fi.intel.com>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
 <febc7f73-929f-d8a6-ea01-5056b9101b46@omp.ru>
 <YbMwBFf5e7k2o6W5@smile.fi.intel.com>
 <9e6b2e9a-e958-0c14-6570-135607041978@omp.ru>
 <YbM7xkTazM76CVvD@smile.fi.intel.com>
 <6c03ffef-b2e0-16ba-35f3-206af2a611d2@gmail.com>
 <YbOVmGw7ys6U51z3@smile.fi.intel.com>
 <9d688cd8-99e3-0265-06aa-d44597e7686c@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d688cd8-99e3-0265-06aa-d44597e7686c@omp.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 10:01:04PM +0300, Sergey Shtylyov wrote:
> On 12/10/21 8:59 PM, Andy Shevchenko wrote:
> 
> >>>>>>>> platform_get_irq() will print a message when it fails.
> >>>>>>>> No need to repeat this.
> >>>>>>>>
> >>>>>>>> While at it, drop redundant check for 0 as platform_get_irq() spills
> >>>>>>>> out a big WARN() in such case.
> >>>>>>>
> >>>>>>> The reason you should be able to remove the "if (!irq)" test is that
> >>>>>>> platform_get_irq() never returns 0. At least, that is what the function kdoc
> >>>>>>> says. But looking at platform_get_irq_optional(), which is called by
> >>>>>>> platform_get_irq(), the out label is:
> >>>>>>>
> >>>>>>> 	WARN(ret == 0, "0 is an invalid IRQ number\n");
> >>>>>>> 	return ret;
> >>>>>>>
> >>>>>>> So 0 will be returned as-is. That is rather weird. That should be fixed to
> >>>>>>> return -ENXIO:
> >>>>>>>
> >>>>>>> 	if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
> >>>>>>> 		return -ENXIO;
> >>>>>>> 	return ret;
> >>>>>>
> >>>>>>    My unmerged patch (https://marc.info/?l=linux-kernel&m=163623041902285) does this
> >>>>>> but returns -EINVAL instead.
> >>>>>>
> >>>>>>> Otherwise, I do not think that removing the "if (!irq)" hunk is safe. no ?
> >>>>>>
> >>>>>>    Of course it isn't...
> >>>>>
> >>>>> It's unsubstantiated statement. The vIRQ 0 shouldn't be returned by any of
> >>>>> those API calls.
> >>>>
> >>>>    We do _not_ know what needs to be fixed, that's the problem, and that's why the WARN()
> >>>> is there...
> >>>
> >>> So, have you seen this warning (being reported) related to libahci_platform?
> >>
> >>    No (as if you need to really see this while it's obvious from the code review).
> >>
> >>> If no, what we are discussing about then? The workaround is redundant and
> >>
> >>    I don't know. :-) Your arguments so far seem bogus (sorry! :-))...
> > 
> > It seems you haven't got them at all. The problems of platform_get_irq() et al
> > shouldn't be worked around in the callers.
> 
>    I have clearly explained to you what I'm working around there. If that wasn't clear
> enough, I don't want to continue this talk anymore. Good luck with your patch (not this
> one).

Good luck with yours, not the one that touches platform_get_irq_optional() though!

-- 
With Best Regards,
Andy Shevchenko


