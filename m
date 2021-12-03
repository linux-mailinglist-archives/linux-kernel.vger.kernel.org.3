Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A748467770
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380816AbhLCMfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:35:19 -0500
Received: from mga02.intel.com ([134.134.136.20]:47194 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380804AbhLCMfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:35:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="224210449"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="224210449"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 04:31:39 -0800
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="541608253"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 04:31:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mt7hz-001lU9-NK;
        Fri, 03 Dec 2021 14:30:35 +0200
Date:   Fri, 3 Dec 2021 14:30:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] find: Do not read beyond variable boundaries on small
 sizes
Message-ID: <YaoN6wnNezMvyyd5@smile.fi.intel.com>
References: <20211203100846.3977195-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203100846.3977195-1-keescook@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 02:08:46AM -0800, Kees Cook wrote:
> It's common practice to cast small variable arguments to the find_*_bit()

It's a bad practice and should be fixed accordingly, no?

> helpers to unsigned long and then use a size argument smaller than
> sizeof(unsigned long):
> 
> 	unsigned int bits;
> 	...
> 	out = find_first_bit((unsigned long *)&bits, 32);
> 
> This leads to the find helper dereferencing a full unsigned long,
> regardless of the size of the actual variable. The unwanted bits
> get masked away, but strictly speaking, a read beyond the end of
> the target variable happens. Builds under -Warray-bounds complain
> about this situation, for example:
> 
> In file included from ./include/linux/bitmap.h:9,
>                  from drivers/iommu/intel/iommu.c:17:
> drivers/iommu/intel/iommu.c: In function 'domain_context_mapping_one':
> ./include/linux/find.h:119:37: error: array subscript 'long unsigned int[0]' is partly outside array bounds of 'int[1]' [-Werror=array-bounds]
>   119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
>       |                                     ^~~~~
> drivers/iommu/intel/iommu.c:2115:18: note: while referencing 'max_pde'
>  2115 |         int pds, max_pde;
>       |                  ^~~~~~~
> 
> Instead, just carefully read the correct variable size, all of which
> happens at compile time since small_const_nbits(size) has already
> determined that arguments are constant expressions.

What is the performance impact?

-- 
With Best Regards,
Andy Shevchenko


