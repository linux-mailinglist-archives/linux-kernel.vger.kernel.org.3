Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7EA497FBC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241411AbiAXMmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:42:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:13834 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239476AbiAXMmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643028170; x=1674564170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OFvwUyjsTkpoOcyTWZpVZ/Pod31okaU07im8tZrVkM4=;
  b=TXyBwf2+KJIyb61w1nalrgA9Zwrs2XQo1qwVDgBhl6egDm1ZZqLNJdOT
   euGw3n0qaU0K4Os+SK3uAT5VGkPnbBxCM+vwFmJJWvLE4X8CU4DCMOnl3
   lEOUnjXZgeUDjpXxhowyC5gNSCVefzXhjZdlQG6JOcO8CQd7gz/BsH6HX
   ucOj/JeLSqLImuf62sYgJ3PMRi+9dClj80Ew+JKl1VWAViWTEO/g84Bf7
   aDBuHmKGdMkaVzMqW0yWnWuaPfRuGajasgt/Qvboxdn9houItO+fW2OjG
   ZtPO67eBWuwMXyMpA00EgyjWuGZ2KZWkRMzwWbxPqXx5Zfe7IMVS8r6D+
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245816787"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245816787"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 04:42:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="624069672"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 04:42:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nByfC-00DtC9-Om;
        Mon, 24 Jan 2022 14:41:38 +0200
Date:   Mon, 24 Jan 2022 14:41:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 27/54] lib/bitmap: add bitmap_weight_{cmp, eq, gt, ge,
 lt, le} functions
Message-ID: <Ye6egq/6It3LZs19@smile.fi.intel.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-28-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220123183925.1052919-28-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 10:38:58AM -0800, Yury Norov wrote:
> Many kernel users use bitmap_weight() to compare the result against
> some number or expression:
> 
> 	if (bitmap_weight(...) > 1)
> 		do_something();
> 
> It works OK, but may be significantly improved for large bitmaps: if
> first few words count set bits to a number greater than given, we can
> stop counting and immediately return.
> 
> The same idea would work in other direction: if we know that the number
> of set bits that we counted so far is small enough, so that it would be
> smaller than required number even if all bits of the rest of the bitmap
> are set, we can stop counting earlier.
> 
> This patch adds new bitmap_weight_cmp() as suggested by Michał Mirosław
> and a family of eq, gt, ge, lt and le wrappers to allow this optimization.

lt, and le

> The following patches apply new functions where appropriate.

What I missed in the above message is the rough statistics like some of them
are used more often, some less, and some, perhaps, just added for the sake of
symmetry (the latter is what would be important to see if there are APIs which
have no users at all).

> Suggested-by: "Michał Mirosław" <mirq-linux@rere.qmqm.pl> (for bitmap_weight_cmp)

Please, avoid using double quotes in the tags.

While at it, as a few folks already noticed, keep the subject lines in align
with the policies established in the certain subsystems (in this case seems
'bitmap:' should suffice). I would recommend to run

  `git log --oneline --no-merges -- ...file(s)_in_question...`

to figure out what is the most used and best fit in each case individually.

...

> + * Returns zero if weight of @src is equal to @num;
> + *	   negative number if weight of @src is less than @num;
> + *	   positive number if weight of @src is greater than @num;

> + * NOTES
> + *
> + * Because number of set bits cannot decrease while counting, when user
> + * wants to know if the number of set bits in the bitmap is less than
> + * @num, calling
> + *	bitmap_weight_cmp(..., @num) < 0
> + * is potentially less effective than
> + *	bitmap_weight_cmp(..., @num - 1) <= 0
> + *
> + * Consider an example:
> + * bitmap_weight_cmp(1000 0000 0000 0000, 1) < 0
> + *				    ^
> + *				    stop here
> + *
> + * bitmap_weight_cmp(1000 0000 0000 0000, 0) <= 0
> + *		     ^
> + *		     stop here

This probably should precede the Returns paragraph, also that paragraph can be
converted to a section in the documentation as follows:

 *
 * Returns:
 *   ...
 *

...

> +	if (num > (int)nbits || num < 0)

Wonder if

	if (abs(num) > nbits)

would be sufficient.

> +		return -num;

-- 
With Best Regards,
Andy Shevchenko


