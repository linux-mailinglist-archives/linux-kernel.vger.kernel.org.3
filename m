Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F995472BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234818AbhLMLuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:50:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:1357 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhLMLuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:50:19 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="299499128"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="299499128"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 03:50:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="481485151"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 03:50:17 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mwjpY-005bND-Hc;
        Mon, 13 Dec 2021 13:49:20 +0200
Date:   Mon, 13 Dec 2021 13:49:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message
 when IRQ can't be retrieved
Message-ID: <YbczQAIMK4KBI9w0@smile.fi.intel.com>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
 <febc7f73-929f-d8a6-ea01-5056b9101b46@omp.ru>
 <549c1825-56e6-de9e-e109-77f0d06cfd0f@opensource.wdc.com>
 <5322dafd-86ad-a293-6005-29384cb96cc8@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5322dafd-86ad-a293-6005-29384cb96cc8@omp.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 01:25:20PM +0300, Sergey Shtylyov wrote:
> On 11.12.2021 2:45, Damien Le Moal wrote:

...

> > > > > platform_get_irq() will print a message when it fails.
> > > > > No need to repeat this.
> > > > > 
> > > > > While at it, drop redundant check for 0 as platform_get_irq() spills
> > > > > out a big WARN() in such case.
> > > > 
> > > > The reason you should be able to remove the "if (!irq)" test is that
> > > > platform_get_irq() never returns 0. At least, that is what the function kdoc
> > > > says. But looking at platform_get_irq_optional(), which is called by
> > > > platform_get_irq(), the out label is:
> > > > 
> > > > 	WARN(ret == 0, "0 is an invalid IRQ number\n");
> > > > 	return ret;
> > > > 
> > > > So 0 will be returned as-is. That is rather weird. That should be fixed to
> > > > return -ENXIO:
> > > > 
> > > > 	if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
> > > > 		return -ENXIO;
> > > > 	return ret;
> > > 
> > >     My unmerged patch (https://marc.info/?l=linux-kernel&m=163623041902285) does this
> > > but returns -EINVAL instead.
> > 
> > Thinking more about this, shouldn't this change go into platform_get_irq()
> > instead of platform_get_irq_optional() ?
> 
>    Why? platform_get_irq() currently just calls platform_get_irq_optional()...
> 
> > The way I see it, I think that the intended behavior for
> > platform_get_irq_optional() is:
> > 1) If have IRQ, return it, always > 0
> > 2) If no IRQ, return 0
> 
>    That does include the IRQ0 case, right?

What IRQ0 case? We do not expect platform APIs ever to handle vIRQ0
(mind letter v) case. Platforms, where it's the case, should handle
it exceptionally on per architecture basis.

> > 3) If error, return < 0
> > no ?
> 
>   I completely agree, I (after thinking a bit) have no issues with that...
> 
> > And for platform_get_irq(), case (2) becomes an error.
> > Is this the intended semantic ?
> 
>    I don't see how it's different from the current behavior. But we can do
> that as well, I just don't see whether it's really better...
> 
> > I am really not sure here as the functions kdoc description and the code do not
> > match. Which one is correct ?
> 
>    It seems both are wrong. :-)

-- 
With Best Regards,
Andy Shevchenko


