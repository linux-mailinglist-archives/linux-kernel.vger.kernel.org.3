Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B496846D0EE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhLHK1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 05:27:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:62057 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230050AbhLHK1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 05:27:04 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="298596959"
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="298596959"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 02:23:33 -0800
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="606248476"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 02:23:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1muu5n-003bY5-4m;
        Wed, 08 Dec 2021 12:22:31 +0200
Date:   Wed, 8 Dec 2021 12:22:30 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] find: Do not read beyond variable boundaries on small
 sizes
Message-ID: <YbCHZmyfS7aXGuIx@smile.fi.intel.com>
References: <20211203100846.3977195-1-keescook@chromium.org>
 <YaoN6wnNezMvyyd5@smile.fi.intel.com>
 <20211203182638.GA450223@lapt>
 <202112031450.EFE7B7B4A@keescook>
 <20211207233930.GA3955@lapt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207233930.GA3955@lapt>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 03:39:30PM -0800, Yury Norov wrote:
> On Fri, Dec 03, 2021 at 03:01:30PM -0800, Kees Cook wrote:
> > On Fri, Dec 03, 2021 at 10:26:38AM -0800, Yury Norov wrote:
> > > On Fri, Dec 03, 2021 at 02:30:35PM +0200, Andy Shevchenko wrote:
> > > > On Fri, Dec 03, 2021 at 02:08:46AM -0800, Kees Cook wrote:
> > > > > It's common practice to cast small variable arguments to the find_*_bit()
> > > 
> > > Not that common - I found 19 examples of this cast, and most of them
> > > are in drivers.
> > 
> > I find 51 (most are in the for_each_* wrappers):
> > 
> > $ RE=$(echo '\b('$(echo $(grep -E '^(unsigned long find|#define for_each)_' include/linux/find.h | cut -d'(' -f1 | awk '{print $NF}') | tr ' ' '|')')\(.*\(unsigned long \*\)')
> > $ git grep -E "$RE" | wc -l
> > 51
> > 
> > > > > This leads to the find helper dereferencing a full unsigned long,
> > > > > regardless of the size of the actual variable. The unwanted bits
> > > > > get masked away, but strictly speaking, a read beyond the end of
> > > > > the target variable happens. Builds under -Warray-bounds complain
> > > > > about this situation, for example:
> > > > > 
> > > > > In file included from ./include/linux/bitmap.h:9,
> > > > >                  from drivers/iommu/intel/iommu.c:17:
> > > > > drivers/iommu/intel/iommu.c: In function 'domain_context_mapping_one':
> > > > > ./include/linux/find.h:119:37: error: array subscript 'long unsigned int[0]' is partly outside array bounds of 'int[1]' [-Werror=array-bounds]
> > > > >   119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
> > > > >       |                                     ^~~~~
> > > > > drivers/iommu/intel/iommu.c:2115:18: note: while referencing 'max_pde'
> > > > >  2115 |         int pds, max_pde;
> > > > >       |                  ^~~~~~~
> > > 
> > > The driver should be fixed. I would suggest using one of ffs/fls/ffz from
> > > include/asm/bitops.h
> > 
> > I don't think it's a good API design to make developers choose between
> > functions based on the size of their target.
> 
> Bitmap functions work identically for all sizes from 0 to INT_MAX - 1. 
> Users don't 'choose between functions based on the size of their target'.
> 
> Can you explain more what you mean?

I believe it was a reaction to your suggestion about ffs/ffz/etc.

Kees, if we _know_ that the size of the value in question will always
fit 32/64-bit, then ffs/ffz/etc is okay to use. OTOH, if the type of
that value is unsigned long [] and bitmap APIs() is used, then of
course the consistent use of bitmap APIs is preferable.

I.o.w.
 uXX: ffX()/etc is fine.
 unsigned long: bitmap API.

I believe that's what Yury meant.

-- 
With Best Regards,
Andy Shevchenko


