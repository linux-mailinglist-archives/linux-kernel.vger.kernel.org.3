Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE834472BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236378AbhLMLrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:47:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:1214 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231452AbhLMLru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:47:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10196"; a="299498879"
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="299498879"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 03:47:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,202,1635231600"; 
   d="scan'208";a="681607200"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 03:47:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mwjn9-005bKa-2P;
        Mon, 13 Dec 2021 13:46:51 +0200
Date:   Mon, 13 Dec 2021 13:46:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message
 when IRQ can't be retrieved
Message-ID: <YbcyqvEAPu1SiV8w@smile.fi.intel.com>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
 <febc7f73-929f-d8a6-ea01-5056b9101b46@omp.ru>
 <549c1825-56e6-de9e-e109-77f0d06cfd0f@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <549c1825-56e6-de9e-e109-77f0d06cfd0f@opensource.wdc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2021 at 08:45:51AM +0900, Damien Le Moal wrote:
> On 2021/12/10 17:59, Sergey Shtylyov wrote:
> > On 12/10/21 1:49 AM, Damien Le Moal wrote:
> > 
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
> >> 	WARN(ret == 0, "0 is an invalid IRQ number\n");
> >> 	return ret;
> >>
> >> So 0 will be returned as-is. That is rather weird. That should be fixed to
> >> return -ENXIO:
> >>
> >> 	if (WARN(ret == 0, "0 is an invalid IRQ number\n"))
> >> 		return -ENXIO;
> >> 	return ret;
> > 
> >    My unmerged patch (https://marc.info/?l=linux-kernel&m=163623041902285) does this
> > but returns -EINVAL instead.
> 
> Thinking more about this, shouldn't this change go into platform_get_irq()
> instead of platform_get_irq_optional() ?
> 
> The way I see it, I think that the intended behavior for
> platform_get_irq_optional() is:
> 1) If have IRQ, return it, always > 0
> 2) If no IRQ, return 0
> 3) If error, return < 0
> no ?

At least this is my understanding on how it _should_ be.

> And for platform_get_irq(), case (2) becomes an error.

Precisely!

> Is this the intended semantic ?
> I am really not sure here as the functions kdoc description and the code do not
> match. Which one is correct ?

The problem is that platform_get_irq_optional() doesn't follow above mentioned
logic and needs to be fixed. While trying to fix that it appears that it's not
an simple and 5 minutes task since it needs a revisiting of all callers first
followed by rectifying the API itself.

> >> Otherwise, I do not think that removing the "if (!irq)" hunk is safe. no ?
> > 
> >    Of course it isn't...

-- 
With Best Regards,
Andy Shevchenko


