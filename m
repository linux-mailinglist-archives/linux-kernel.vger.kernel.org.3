Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D7E53AB48
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 18:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356203AbiFAQsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 12:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbiFAQsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 12:48:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE96A2042;
        Wed,  1 Jun 2022 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654102109; x=1685638109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=00iMzNpl4nVdOEC1GABzCwR9itIjYCdYxTEgVqgNnCQ=;
  b=KiWN7X+eNAX667k1LzNMCNthvwcQDqb6TPduY+FzmHlSZQ0fUPXtmC9w
   g6tfo7QvDNJq6+13MH8pOj4GpRI/dw+kxLwyZiRF1ylE+yXUBCoOt5fXk
   2MeBCRg37R/zz0rcRZfn0pZ/hXKjRsIylgSY7iI5tGvLZfUjwve7clyJH
   RjynBwZdaF7Uc1+ULHZHbZKAJcmH6Aez18zglHkLZfLAEbT0lodwsg5LA
   8+znuN3gCZAUMCIDLpMsRMWdc4WJDKlQrEAQXgTGr+79AHK6Jn4nVzl46
   SBpil7QvFY+EKvK/ethE2ampdIKMaC/5V6XJeMRYQmpRf+O2uCb8l0xu6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="338698165"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="338698165"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 09:48:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="756351737"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 09:48:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nwRWC-000QqK-Kt;
        Wed, 01 Jun 2022 19:48:24 +0300
Date:   Wed, 1 Jun 2022 19:48:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpio: wcove: make irq_chip immutable
Message-ID: <YpeYWKpD+ls2DMm5@smile.fi.intel.com>
References: <20220601154833.2173-1-andriy.shevchenko@linux.intel.com>
 <e965160d-08d1-f148-6452-f759053e7e99@linux.intel.com>
 <YpePLa0jbTLusGU9@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpePLa0jbTLusGU9@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 07:09:17PM +0300, Andy Shevchenko wrote:
> On Wed, Jun 01, 2022 at 08:51:03AM -0700, Sathyanarayanan Kuppuswamy wrote:
> > On 6/1/22 8:48 AM, Andy Shevchenko wrote:
> > > Since recently, the kernel is nagging about mutable irq_chips:
> > > 
> > >     "not an immutable chip, please consider fixing it!"
> > > 
> > > Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
> > > helper functions and call the appropriate gpiolib functions.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Looks good to me
> > 
> > Reviewed-by: Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Thanks!
> 
> Please fix your tools so it won't split tag line and `b4` may automatically test it.


Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


