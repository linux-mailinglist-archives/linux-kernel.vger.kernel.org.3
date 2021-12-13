Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0917347372E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243338AbhLMWDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:03:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:40554 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242178AbhLMWDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:03:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="236370995"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="236370995"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 14:03:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="603877437"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 14:03:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mwtPF-005oQj-2t;
        Tue, 14 Dec 2021 00:02:49 +0200
Date:   Tue, 14 Dec 2021 00:02:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v1 1/2] ata: libahci_platform: Get rid of dup message
 when IRQ can't be retrieved
Message-ID: <YbfDCNIMNy4PdBwL@smile.fi.intel.com>
References: <20211209145937.77719-1-andriy.shevchenko@linux.intel.com>
 <d91cf14d-c7d8-1c61-9071-102f38e8c924@opensource.wdc.com>
 <febc7f73-929f-d8a6-ea01-5056b9101b46@omp.ru>
 <549c1825-56e6-de9e-e109-77f0d06cfd0f@opensource.wdc.com>
 <5322dafd-86ad-a293-6005-29384cb96cc8@omp.ru>
 <de3dc434-8b87-5d9d-7fe8-bd44ff2bcbfb@opensource.wdc.com>
 <Ybcz85/ZoXRCmbbD@smile.fi.intel.com>
 <0d967bb4-0b80-c293-b7d5-f49c9cc38718@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d967bb4-0b80-c293-b7d5-f49c9cc38718@opensource.wdc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 06:36:00AM +0900, Damien Le Moal wrote:
> On 2021/12/13 20:52, Andy Shevchenko wrote:
> > On Mon, Dec 13, 2021 at 07:39:31AM +0900, Damien Le Moal wrote:
> >> On 2021/12/11 19:25, Sergey Shtylyov wrote:

...

> >> The problem I see is that the current behavior is unclear: what does
> >> platform_get_irq_optional() returning 0 mean ? IRQ == 0 ? or "no IRQ" ? I think
> >> it should be the latter rather than the former. Note that the function could
> >> return ENOENT (or similar) for the "no IRQ" case. With that, case (2) goes away,
> >> but then I do not see any difference between platform_get_irq_optional() and
> >> platform_get_irq().
> >>
> >> If the preferred API semantic is to allow returning IRQ 0 with a warning, then
> >> the kdoc comments of platform_get_irq_optional() and platform_get_irq() are
> >> totally broken, and the code for many drivers is probably wrong too.
> > 
> > Yeah, what we need to do is that (roughly a roadmap):
> >  - revisit callers of platform_get_irq_optional() to be prepared for
> >    new behaviour
> >  - rewrite platform_get_irq() to return -ENOENT
> >  - rewrite platform_get_irq_optional() to return 0 on -ENOENT
> > 
> > This is how other similar (i.e. _optional) APIs do.
> 
> Sounds like a good plan to me. In the mean time though, your patch 1/2 should
> keep the "if (!irq)" test and return an error for that case. No ?

No problem. I can send a v2.

-- 
With Best Regards,
Andy Shevchenko


