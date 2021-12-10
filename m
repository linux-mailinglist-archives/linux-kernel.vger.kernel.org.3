Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA36F470031
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbhLJLlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:41:24 -0500
Received: from mga02.intel.com ([134.134.136.20]:28254 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240626AbhLJLlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:41:21 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="225603944"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="225603944"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:37:39 -0800
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="543952620"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:37:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mveCd-004TN5-3z;
        Fri, 10 Dec 2021 13:36:39 +0200
Date:   Fri, 10 Dec 2021 13:36:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message
 when IRQ can't be retrieved
Message-ID: <YbM7xkTazM76CVvD@smile.fi.intel.com>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
 <febc7f73-929f-d8a6-ea01-5056b9101b46@omp.ru>
 <YbMwBFf5e7k2o6W5@smile.fi.intel.com>
 <9e6b2e9a-e958-0c14-6570-135607041978@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e6b2e9a-e958-0c14-6570-135607041978@omp.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 02:19:52PM +0300, Sergey Shtylyov wrote:
> On 12/10/21 1:46 PM, Andy Shevchenko wrote:
> 
> >>>> platform_get_irq() will print a message when it fails.
> >>>> No need to repeat this.
> >>>>
> >>>> While at it, drop redundant check for 0 as platform_get_irq() spills
> >>>> out a big WARN() in such case.
> >>>
> >>> The reason you should be able to remove the "if (!irq)" test is that
> >>> platform_get_irq() never returns 0. At least, that is what the function kdoc
> >>> says. But looking at platform_get_irq_optional(), which is called by
> >>> platform_get_irq(), the out label is:
> >>>
> >>> 	WARN(ret == 0, "0 is an invalid IRQ number\n");
> >>> 	return ret;
> >>>
> >>> So 0 will be returned as-is. That is rather weird. That should be fixed to
> >>> return -ENXIO:
> >>>
> >>> 	if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
> >>> 		return -ENXIO;
> >>> 	return ret;
> >>
> >>    My unmerged patch (https://marc.info/?l=linux-kernel&m=163623041902285) does this
> >> but returns -EINVAL instead.
> >>
> >>> Otherwise, I do not think that removing the "if (!irq)" hunk is safe. no ?
> >>
> >>    Of course it isn't...
> > 
> > It's unsubstantiated statement. The vIRQ 0 shouldn't be returned by any of
> > those API calls.
> 
>    We do _not_ know what needs to be fixed, that's the problem, and that's why the WARN()
> is there...

So, have you seen this warning (being reported) related to libahci_platform?
If no, what we are discussing about then? The workaround is redundant and
no need to have a dead code in the driver, really.

> > If it is the case, go and fix them, no need to workaround
> > in each of the callers.
> 
>    There's a need to work around as long as IRQ0 ican be returned, otherwise
>    we get partly functioning or non-functioning drivers...

You get them unfunctioning anyways and you get the big WARN() even before this
patch.


-- 
With Best Regards,
Andy Shevchenko


