Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D6E4636EC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 15:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbhK3On0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 09:43:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:20459 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232476AbhK3OnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 09:43:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="223454402"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="223454402"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 06:40:05 -0800
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="499790615"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 06:40:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ms4Hc-000ZLw-FP;
        Tue, 30 Nov 2021 16:39:00 +0200
Date:   Tue, 30 Nov 2021 16:39:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: Fix math.h breakage
Message-ID: <YaY3hKLejcy09bZk@smile.fi.intel.com>
References: <20211130141316.2987986-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130141316.2987986-1-willy@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 02:13:16PM +0000, Matthew Wilcox (Oracle) wrote:
> Commit 98e1385ef24b broke the radix tree test suite in two different ways;
> first by including math.h which didn't exist in the tools directory, and
> second by removing an implicit include of spinlock.h before lockdep.h.
> Fix both issues.

Sorry for that and thank you for the fix.
Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I'm wondering if there is a way of not copying kernel headers manually,
otherwise we always will have such breakages.

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  tools/include/linux/kernel.h             | 22 +--------------------
>  tools/include/linux/math.h               | 25 ++++++++++++++++++++++++
>  tools/testing/radix-tree/linux/lockdep.h |  3 +++
>  3 files changed, 29 insertions(+), 21 deletions(-)
>  create mode 100644 tools/include/linux/math.h
> 
> diff --git a/tools/include/linux/kernel.h b/tools/include/linux/kernel.h
> index a7e54a08fb54..3e8df500cfbd 100644
> --- a/tools/include/linux/kernel.h
> +++ b/tools/include/linux/kernel.h
> @@ -7,6 +7,7 @@
>  #include <assert.h>
>  #include <linux/build_bug.h>
>  #include <linux/compiler.h>
> +#include <linux/math.h>
>  #include <endian.h>
>  #include <byteswap.h>
>  
> @@ -14,8 +15,6 @@
>  #define UINT_MAX	(~0U)
>  #endif
>  
> -#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
> -
>  #define PERF_ALIGN(x, a)	__PERF_ALIGN_MASK(x, (typeof(x))(a)-1)
>  #define __PERF_ALIGN_MASK(x, mask)	(((x)+(mask))&~(mask))
>  
> @@ -52,15 +51,6 @@
>  	_min1 < _min2 ? _min1 : _min2; })
>  #endif
>  
> -#ifndef roundup
> -#define roundup(x, y) (                                \
> -{                                                      \
> -	const typeof(y) __y = y;		       \
> -	(((x) + (__y - 1)) / __y) * __y;	       \
> -}                                                      \
> -)
> -#endif
> -
>  #ifndef BUG_ON
>  #ifdef NDEBUG
>  #define BUG_ON(cond) do { if (cond) {} } while (0)
> @@ -104,16 +94,6 @@ int scnprintf_pad(char * buf, size_t size, const char * fmt, ...);
>  
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
>  
> -/*
> - * This looks more complex than it should be. But we need to
> - * get the type for the ~ right in round_down (it needs to be
> - * as wide as the result!), and we want to evaluate the macro
> - * arguments just once each.
> - */
> -#define __round_mask(x, y) ((__typeof__(x))((y)-1))
> -#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
> -#define round_down(x, y) ((x) & ~__round_mask(x, y))
> -
>  #define current_gfp_context(k) 0
>  #define synchronize_rcu()
>  
> diff --git a/tools/include/linux/math.h b/tools/include/linux/math.h
> new file mode 100644
> index 000000000000..4e7af99ec9eb
> --- /dev/null
> +++ b/tools/include/linux/math.h
> @@ -0,0 +1,25 @@
> +#ifndef _TOOLS_MATH_H
> +#define _TOOLS_MATH_H
> +
> +/*
> + * This looks more complex than it should be. But we need to
> + * get the type for the ~ right in round_down (it needs to be
> + * as wide as the result!), and we want to evaluate the macro
> + * arguments just once each.
> + */
> +#define __round_mask(x, y) ((__typeof__(x))((y)-1))
> +#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)
> +#define round_down(x, y) ((x) & ~__round_mask(x, y))
> +
> +#define DIV_ROUND_UP(n,d) (((n) + (d) - 1) / (d))
> +
> +#ifndef roundup
> +#define roundup(x, y) (                                \
> +{                                                      \
> +	const typeof(y) __y = y;		       \
> +	(((x) + (__y - 1)) / __y) * __y;	       \
> +}                                                      \
> +)
> +#endif
> +
> +#endif
> diff --git a/tools/testing/radix-tree/linux/lockdep.h b/tools/testing/radix-tree/linux/lockdep.h
> index 565fccdfe6e9..016cff473cfc 100644
> --- a/tools/testing/radix-tree/linux/lockdep.h
> +++ b/tools/testing/radix-tree/linux/lockdep.h
> @@ -1,5 +1,8 @@
>  #ifndef _LINUX_LOCKDEP_H
>  #define _LINUX_LOCKDEP_H
> +
> +#include <linux/spinlock.h>
> +
>  struct lock_class_key {
>  	unsigned int a;
>  };
> -- 
> 2.33.0
> 

-- 
With Best Regards,
Andy Shevchenko


