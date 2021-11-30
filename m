Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7684639FA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbhK3P1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:27:45 -0500
Received: from mga04.intel.com ([192.55.52.120]:26459 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243492AbhK3P1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:27:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="234960613"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="234960613"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 07:23:35 -0800
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="458873312"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 07:23:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ms4xi-000aRy-FK;
        Tue, 30 Nov 2021 17:22:30 +0200
Date:   Tue, 30 Nov 2021 17:22:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: Fix math.h breakage
Message-ID: <YaZBtvcmFFt1PE5M@smile.fi.intel.com>
References: <20211130141316.2987986-1-willy@infradead.org>
 <YaY3hKLejcy09bZk@smile.fi.intel.com>
 <YaY+IFrgBOUGomW6@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaY+IFrgBOUGomW6@casper.infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 03:07:12PM +0000, Matthew Wilcox wrote:
> On Tue, Nov 30, 2021 at 04:39:00PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 30, 2021 at 02:13:16PM +0000, Matthew Wilcox (Oracle) wrote:
> > > Commit 98e1385ef24b broke the radix tree test suite in two different ways;
> > > first by including math.h which didn't exist in the tools directory, and
> > > second by removing an implicit include of spinlock.h before lockdep.h.
> > > Fix both issues.
> > 
> > Sorry for that and thank you for the fix.
> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > I'm wondering if there is a way of not copying kernel headers manually,
> > otherwise we always will have such breakages.
> 
> It's not necessarily that these are _copies_ of kernel headers, so much as
> they're ways of mocking kernel interfaces when building userspace code.
> We could separate out pieces and include them from each direction, but
> that has its own problems, and doesn't necessarily solve these kinds of
> problems either.
> 
> I think the only way to prevent these kinds of breakages is to make sure
> the build bots are also building things.

I don't know how to achieve this locally because I'm using `make O=...` and
it's broken for many tools/ folders. At some point I simply gave up.

-- 
With Best Regards,
Andy Shevchenko


