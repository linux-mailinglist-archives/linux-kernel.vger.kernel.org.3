Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87FB47939A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 19:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239922AbhLQSMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 13:12:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:62049 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230432AbhLQSMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 13:12:05 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="219821298"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="219821298"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 10:10:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="605965790"
Received: from smile.fi.intel.com ([10.237.72.184])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 10:10:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1myHfd-007YU0-SR;
        Fri, 17 Dec 2021 20:09:29 +0200
Date:   Fri, 17 Dec 2021 20:09:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v1 1/1] serial: 8520_mtk: Prepare for
 platform_get_irq_optional() changes
Message-ID: <YbzSWas9OfeZzY3o@smile.fi.intel.com>
References: <20211217151034.62046-1-andriy.shevchenko@linux.intel.com>
 <YbzA3y5jp5K5zL/+@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbzA3y5jp5K5zL/+@kroah.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 05:54:55PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Dec 17, 2021 at 05:10:34PM +0200, Andy Shevchenko wrote:
> > The platform_get_irq_optional() is going to be changed in a way
> > that the result of it:
> >    = 0 means no IRQ is provided
> >    < 0 means the error which needs to be propagated to the upper layers
> >    > 0 valid vIRQ is allocated
> 
> What about 0 being a valid irq?

For this driver it can't be possible. The driver is instantiated via DT only
and OF APIs never return 0 for IRQ. If it's the case, it's a regression in the
OF APIs.

I can elaborate in the commit message.

> > In this case, drop check for 0. Note, the 0 is not valid vIRQ and
> > platform_get_irq_optional() issues a big WARN() in such case,
> 
> But it still is a valid irq, so why did you just break things?  Yes, a
> warning will happen, but the driver and platform will still work.

In general yes, but not in this case. See above.

...

> > -	if (irq >= 0)
> > +	if (irq > 0)
> >  		disable_irq_wake(irq);
> 
> Why change this now?  What does this solve at this point in time?

As explained in the commit message, it's a preparation patch to fix the logic
behind platform_get_irq_optional().

-- 
With Best Regards,
Andy Shevchenko


