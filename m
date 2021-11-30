Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AEF4639FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244085AbhK3P2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:28:15 -0500
Received: from mga05.intel.com ([192.55.52.43]:5566 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243958AbhK3P2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:28:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="322480411"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="322480411"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 07:24:53 -0800
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="601541560"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 07:24:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ms4yy-000aTB-Ei;
        Tue, 30 Nov 2021 17:23:48 +0200
Date:   Tue, 30 Nov 2021 17:23:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: Fix math.h breakage
Message-ID: <YaZCBLVTV7Dy1PWd@smile.fi.intel.com>
References: <20211130141316.2987986-1-willy@infradead.org>
 <YaY3hKLejcy09bZk@smile.fi.intel.com>
 <YaY+IFrgBOUGomW6@casper.infradead.org>
 <YaZBtvcmFFt1PE5M@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaZBtvcmFFt1PE5M@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 05:22:30PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 30, 2021 at 03:07:12PM +0000, Matthew Wilcox wrote:
> > On Tue, Nov 30, 2021 at 04:39:00PM +0200, Andy Shevchenko wrote:
> > > On Tue, Nov 30, 2021 at 02:13:16PM +0000, Matthew Wilcox (Oracle) wrote:
> > > > Commit 98e1385ef24b broke the radix tree test suite in two different ways;
> > > > first by including math.h which didn't exist in the tools directory, and
> > > > second by removing an implicit include of spinlock.h before lockdep.h.
> > > > Fix both issues.
> > > 
> > > Sorry for that and thank you for the fix.
> > > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > I'm wondering if there is a way of not copying kernel headers manually,
> > > otherwise we always will have such breakages.
> > 
> > It's not necessarily that these are _copies_ of kernel headers, so much as
> > they're ways of mocking kernel interfaces when building userspace code.
> > We could separate out pieces and include them from each direction, but
> > that has its own problems, and doesn't necessarily solve these kinds of
> > problems either.
> > 
> > I think the only way to prevent these kinds of breakages is to make sure
> > the build bots are also building things.
> 
> I don't know how to achieve this locally because I'm using `make O=...` and
> it's broken for many tools/ folders. At some point I simply gave up.

To be clear, it's an argument to support your idea that CI can do it for us.

-- 
With Best Regards,
Andy Shevchenko


