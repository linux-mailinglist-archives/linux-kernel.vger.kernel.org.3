Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FA849B502
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 14:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576809AbiAYN0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 08:26:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:49181 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1576255AbiAYNS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 08:18:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643116737; x=1674652737;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s1cFwXVuWmH1WB6LHxaChd1NCzMYJ5RAUlwC/vLPmuA=;
  b=LNqMmM/2z9bjR5mLEJG7C1wIwmdFGe4OQPgFs4R0ZgM+KdFSLaUZ5i72
   tW7PJ98F7/L8Su432kccOT24jDtsg8LvG/P/GMlYfkjFCusJu9RUPtUDK
   IoN8UiMQwdMwIBWaZFWypzZeIqxxItQyfJxFXvTIpbQgVU7mJRn40i42y
   xQOBQty1OyWtPli2kip6OVnwVIBtu+HJvBuSP2M/30TSLAFsjEThC6zEP
   T64zBA4s2De37WuP1BiKXoHLkJaz1c5loQsf/lwZyJYNKzseZR4VjKFwF
   /XeuhGhs80wHCdELnEV/2e2ulsvutDvh8G72nonhDhkwqM+MO7cnqVqMC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="233667539"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="233667539"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 05:18:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="477099894"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 05:18:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nCLhg-00EFxD-FN;
        Tue, 25 Jan 2022 15:17:44 +0200
Date:   Tue, 25 Jan 2022 15:17:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 5/5] iio: afe: iio-rescale: Re-use generic struct
 s32_fract
Message-ID: <Ye/4eJ/RhlWF7q70@smile.fi.intel.com>
References: <20220110193104.75225-1-andriy.shevchenko@linux.intel.com>
 <20220110193104.75225-5-andriy.shevchenko@linux.intel.com>
 <20220115185203.567780e8@jic23-huawei>
 <Ye7DSAN4gdhXfEUs@smile.fi.intel.com>
 <Ye8Z6dS5cCji9LNQ@shaak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye8Z6dS5cCji9LNQ@shaak>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 04:28:09PM -0500, Liam Beguin wrote:
> On Mon, Jan 24, 2022 at 05:18:32PM +0200, Andy Shevchenko wrote:
> > On Sat, Jan 15, 2022 at 06:52:03PM +0000, Jonathan Cameron wrote:
> > > On Mon, 10 Jan 2022 21:31:04 +0200
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > > 
> > > > Instead of custom data type re-use generic struct s32_fract.
> > > > No changes intended.
> > > > 
> > > > The new member is put to be the first one to avoid additional
> > > > pointer arithmetic. Besides that one may switch to use fract
> > > > member to perform container_of(), which will be no-op in this
> > > > case, to get struct rescale.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > I'm not totally sold on this series showing there is a strong case for
> > > these macros so interested to hear what others think.
> > 
> > So far no news :-)
> 
> Like I mentioned briefly in the other thread[1], I don't really see the
> advantage for the AFE driver given that it's almost just like renaming
> the parameters.

I tend to disagree, perhaps I wasn't so clear in my points.

The change reveals that the layering can be improved. In OOP
the object A which is inherited (or encapsulated as we see here)
allows to clearly get what kind of data the methods are operating
with / on. As you may see the two functions and the method
declaration appears to have interest only in the fraction data
for rescaling. The cleanup I consider helpful in the terms
of layering and OOP.

> For the other drivers affected by the change, it drops the definition of
> the structure which is nice. So overall, it's a plus IMO :-)

Thanks!

> [1] https://lore.kernel.org/linux-iio/20220108205319.2046348-1-liambeguin@gmail.com/

-- 
With Best Regards,
Andy Shevchenko


