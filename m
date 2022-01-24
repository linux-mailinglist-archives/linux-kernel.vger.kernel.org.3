Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4893A497FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242240AbiAXMr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:47:59 -0500
Received: from mga01.intel.com ([192.55.52.88]:54060 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240117AbiAXMr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643028476; x=1674564476;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t4XLhenzUQSF8a6/n12cTXUdVH0+2ekbL4ehTIMp2HE=;
  b=c//zWTFAsQ+ZuNj4tXVU8VGmWzEf+iNqgr2exQ0aJewjoQf9CoFLeaca
   Aqq8EQttYndqGVQ7SGD8a+WKZEb1nYUid1Rc6WsMfhZpsHMs+Z7/CpjXO
   Db/9hPyG3YbR1B6Yk8OnYZBBv99ds5U8ASlj1r1UDhRIX6xp44dQJ6HnB
   s6z9vOuep5lW23V9oJKQnlGDz8+v1ERMmSPFvIMvyt4rfM57sQLGgoSN6
   ZGwm6Y3TZZcYRS2qQ0bI0ECEgB4Vpj0GwbVQMVJHdo4fNHqD8oGqXQP0r
   1KywlvEk59Vkz+f/8ILCCG7vKbsbyYqUk7cqJfWdD5n4BDpQznUQTNVGq
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="270471496"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="270471496"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 04:47:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="562645653"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 04:47:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nByk7-00DtHD-LL;
        Mon, 24 Jan 2022 14:46:43 +0200
Date:   Mon, 24 Jan 2022 14:46:43 +0200
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
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 29/54] drivers/iio: replace bitmap_weight() with
 bitmap_weight_{eq,gt} where appropriate
Message-ID: <Ye6fsynB1/q0ZLui@smile.fi.intel.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
 <20220123183925.1052919-30-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220123183925.1052919-30-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 23, 2022 at 10:39:00AM -0800, Yury Norov wrote:
> drivers/iio calls bitmap_weight() to compare the weight of bitmap with
> a given number. We can do it more efficiently with bitmap_weight_{eq, gt}
> because conditional bitmap_weight may stop traversing the bitmap earlier,
> as soon as condition is met.

...

>  		int i, j;
>  
>  		for (i = 0, j = 0;
> -		     i < bitmap_weight(indio_dev->active_scan_mask,
> -				       indio_dev->masklength);
> +		     bitmap_weight_gt(indio_dev->active_scan_mask,
> +				       indio_dev->masklength, i);
>  		     i++, j++) {
>  			j = find_next_bit(indio_dev->active_scan_mask,
>  					  indio_dev->masklength, j);

This smells like room for improvement. Have you checked this deeply?

-- 
With Best Regards,
Andy Shevchenko


