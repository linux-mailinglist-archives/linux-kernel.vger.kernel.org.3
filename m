Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22085472BCD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbhLMLxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:53:19 -0500
Received: from mga09.intel.com ([134.134.136.24]:19391 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229618AbhLMLxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:53:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="238532082"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="238532082"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 03:53:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="464600657"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 03:53:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mwjsR-005bR7-V5;
        Mon, 13 Dec 2021 13:52:19 +0200
Date:   Mon, 13 Dec 2021 13:52:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message
 when IRQ can't be retrieved
Message-ID: <Ybcz85/ZoXRCmbbD@smile.fi.intel.com>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
 <febc7f73-929f-d8a6-ea01-5056b9101b46@omp.ru>
 <549c1825-56e6-de9e-e109-77f0d06cfd0f@opensource.wdc.com>
 <5322dafd-86ad-a293-6005-29384cb96cc8@omp.ru>
 <de3dc434-8b87-5d9d-7fe8-bd44ff2bcbfb@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de3dc434-8b87-5d9d-7fe8-bd44ff2bcbfb@opensource.wdc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 07:39:31AM +0900, Damien Le Moal wrote:
> On 2021/12/11 19:25, Sergey Shtylyov wrote:
> > On 11.12.2021 2:45, Damien Le Moal wrote:

...

> >>>> So 0 will be returned as-is. That is rather weird. That should be fixed to
> >>>> return -ENXIO:
> >>>>
> >>>> 	if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
> >>>> 		return -ENXIO;
> >>>> 	return ret;
> >>>
> >>>     My unmerged patch (https://marc.info/?l=linux-kernel&m=163623041902285) does this
> >>> but returns -EINVAL instead.
> >>
> >> Thinking more about this, shouldn't this change go into platform_get_irq()
> >> instead of platform_get_irq_optional() ?
> > 
> >     Why? platform_get_irq() currently just calls platform_get_irq_optional()...
> > 
> >> The way I see it, I think that the intended behavior for
> >> platform_get_irq_optional() is:
> >> 1) If have IRQ, return it, always > 0
> >> 2) If no IRQ, return 0
> > 
> >     That does include the IRQ0 case, right?
> 
> IRQ 0 being invalid, I think that case should be dealt with internally within
> platform_get_irq_optional() and warn/error return. IRQ 0 showing up would thus
> be case (3), an error.
> 
> > 
> >> 3) If error, return < 0
> >> no ?
> > 
> >    I completely agree, I (after thinking a bit) have no issues with that...
> > 
> >> And for platform_get_irq(), case (2) becomes an error.
> >> Is this the intended semantic ?
> > 
> >     I don't see how it's different from the current behavior. But we can do 
> > that as well, I just don't see whether it's really better...
> 
> The problem I see is that the current behavior is unclear: what does
> platform_get_irq_optional() returning 0 mean ? IRQ == 0 ? or "no IRQ" ? I think
> it should be the latter rather than the former. Note that the function could
> return ENOENT (or similar) for the "no IRQ" case. With that, case (2) goes away,
> but then I do not see any difference between platform_get_irq_optional() and
> platform_get_irq().
> 
> If the preferred API semantic is to allow returning IRQ 0 with a warning, then
> the kdoc comments of platform_get_irq_optional() and platform_get_irq() are
> totally broken, and the code for many drivers is probably wrong too.

Yeah, what we need to do is that (roughly a roadmap):
 - revisit callers of platform_get_irq_optional() to be prepared for
   new behaviour
 - rewrite platform_get_irq() to return -ENOENT
 - rewrite platform_get_irq_optional() to return 0 on -ENOENT

This is how other similar (i.e. _optional) APIs do.

-- 
With Best Regards,
Andy Shevchenko


