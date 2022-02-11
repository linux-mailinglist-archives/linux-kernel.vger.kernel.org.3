Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C474B207B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348117AbiBKIqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:46:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348134AbiBKIqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:46:11 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F947F12;
        Fri, 11 Feb 2022 00:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644569169; x=1676105169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZO41/6QTQ7lECjmvh5tmSvjvvAY7ky6Pq6DyoOUjdL0=;
  b=jXBImRKRyrR8tMlG+3NYnmuz3JQK5j9s5zllfdlKSwBT9ZzIHd7DlWKh
   wnZPp7niEscdV+oPtmpwkx1Y56MQo5bqVh4OJBBswBogEjJ54quY7TOXp
   C6tfbY+y4YFR0RPt5uLwLIMwF0fxj9jyXAEfuVOwV5R5FO3lEDRG2Xbu5
   qHg2Nderj//yuZcZwwv+aF8i7eLCk8zF3QTYpyBDNklLbyrZU1cD91JMl
   MpeXlkXtTwIWQek/UZJs200lfhRVDT7ZhR4WyTBg9ygJENSQ3oIxpNNOe
   nBJKjuvvJvXRGm8OL4rDVed/EWuERpLfwfO9Y0w492XSH3fB6jMagychV
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249637606"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="249637606"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 00:46:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="586267118"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 00:46:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nIRY8-003NBk-86;
        Fri, 11 Feb 2022 10:45:04 +0200
Date:   Fri, 11 Feb 2022 10:45:04 +0200
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
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 04/49] iio: fix opencoded for_each_set_bit()
Message-ID: <YgYiELMVJn52EZxY@smile.fi.intel.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
 <20220210224933.379149-5-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210224933.379149-5-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 02:48:48PM -0800, Yury Norov wrote:
> iio_simple_dummy_trigger_h() is mostly an opencoded for_each_set_bit().
> Using for_each_set_bit() make code much cleaner, and more effective.

I would wait for some testing, but from code perspective looks good.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  drivers/iio/dummy/iio_simple_dummy_buffer.c | 48 ++++++++-------------
>  1 file changed, 19 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> index d81c2b2dad82..3bc1b7529e2a 100644
> --- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
> +++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
> @@ -45,41 +45,31 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
> +	int i = 0, j;
>  	u16 *data;
>  
>  	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
>  	if (!data)
>  		goto done;
>  
> -	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength)) {
> -		/*
> -		 * Three common options here:
> -		 * hardware scans: certain combinations of channels make
> -		 *   up a fast read.  The capture will consist of all of them.
> -		 *   Hence we just call the grab data function and fill the
> -		 *   buffer without processing.
> -		 * software scans: can be considered to be random access
> -		 *   so efficient reading is just a case of minimal bus
> -		 *   transactions.
> -		 * software culled hardware scans:
> -		 *   occasionally a driver may process the nearest hardware
> -		 *   scan to avoid storing elements that are not desired. This
> -		 *   is the fiddliest option by far.
> -		 * Here let's pretend we have random access. And the values are
> -		 * in the constant table fakedata.
> -		 */
> -		int i, j;
> -
> -		for (i = 0, j = 0;
> -		     i < bitmap_weight(indio_dev->active_scan_mask,
> -				       indio_dev->masklength);
> -		     i++, j++) {
> -			j = find_next_bit(indio_dev->active_scan_mask,
> -					  indio_dev->masklength, j);
> -			/* random access read from the 'device' */
> -			data[i] = fakedata[j];
> -		}
> -	}
> +	/*
> +	 * Three common options here:
> +	 * hardware scans: certain combinations of channels make
> +	 *   up a fast read.  The capture will consist of all of them.
> +	 *   Hence we just call the grab data function and fill the
> +	 *   buffer without processing.
> +	 * software scans: can be considered to be random access
> +	 *   so efficient reading is just a case of minimal bus
> +	 *   transactions.
> +	 * software culled hardware scans:
> +	 *   occasionally a driver may process the nearest hardware
> +	 *   scan to avoid storing elements that are not desired. This
> +	 *   is the fiddliest option by far.
> +	 * Here let's pretend we have random access. And the values are
> +	 * in the constant table fakedata.
> +	 */
> +	for_each_set_bit(j, indio_dev->active_scan_mask, indio_dev->masklength)
> +		data[i++] = fakedata[j];
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, data,
>  					   iio_get_time_ns(indio_dev));
> -- 
> 2.32.0
> 

-- 
With Best Regards,
Andy Shevchenko


