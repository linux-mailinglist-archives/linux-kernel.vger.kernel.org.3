Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F56146FFAD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 12:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbhLJLWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 06:22:12 -0500
Received: from mga17.intel.com ([192.55.52.151]:45095 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233117AbhLJLWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 06:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639135116; x=1670671116;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m35ExWwB8gEA+PnLWzkVApCjgWZ0gek5hCqH/5Yb4KQ=;
  b=JGWPFb9tHVo6psgN4NeL0NgavANu/z+nJMEfHcRqKrkfNN61mQksMsFM
   NACocfgVZOil6aY0SGGxqatSePn8oUlmz0rQTSlv3Hec2bHpjTEMpHAAa
   s71z/Tg9vqyW1maEAOTYwsnG5FiIflbCr/x1HR/cpcKAtHDIgWxUAZ323
   jvkPctV5E/VL+C96dKHvffj8AK/2amcjiZwdZ0/4asGu9yBjkNuQEgGL4
   Zh3NOP8JnqiBUleq6KFhMmfYe6O5eh6VKalP3BuZCXY/5kxK1KmvAvmWS
   +EbB6gf0Ao0t0xoSKT/hvHNeTc6uZTrT77ZrPvSn/pKDh+WFt5JaNZm5Q
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="219017204"
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="219017204"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:18:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,195,1635231600"; 
   d="scan'208";a="463633975"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 03:18:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mvduB-004T5U-Tk;
        Fri, 10 Dec 2021 13:17:35 +0200
Date:   Fri, 10 Dec 2021 13:17:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform: finally disallow IRQ0 in platform_get_irq()
 and its ilk
Message-ID: <YbM3T29wPZFLMu1D@smile.fi.intel.com>
References: <5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru>
 <YbJhu53WEmotslox@smile.fi.intel.com>
 <59f08001-7e1e-7fe2-28ba-045972bbae90@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59f08001-7e1e-7fe2-28ba-045972bbae90@omp.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 11:21:41PM +0300, Sergey Shtylyov wrote:
> On 12/9/21 11:06 PM, Andy Shevchenko wrote:
> 
> >> The commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is
> >> invalid") only calls WARN() when IRQ0 is about to be returned, however
> >> using IRQ0 is considered invalid (according to Linus) outside the arch/
> >> code where it's used by the i8253 drivers. Many driver subsystems treat
> >> 0 specially (e.g. as an indication of the polling mode by libata), so
> >> the users of platform_get_irq[_byname]() in them would have to filter
> >> out IRQ0 explicitly and this (quite obviously) doesn't scale...
> >> Let's finally get this straight and return -EINVAL instead of IRQ0!
> > 
> > You are changing the return value of platform_get_irq_optional().
> > The problem here is the proposed change doesn't bring any value in such
> > case. platform_get_irq_optional() should be able (at the end of the day)
> > to return 3 types of values (as other APIs do):
> > 	 > 0: success
> > 	== 0: IRQ not found
> > 	 < 0: an error that must be consumed by the caller
> 
>    I remember that was in your patch that got reverted right after being merged. ;-)
> IMHO returning both error code and 0 on failure is a sign of a misdesigned API, it
> makes the failure check unnecessarily complex and error prone.

I dunno what you are talking about when you mentioned "0 on failure" because 0
is not the failure, that's what I'm trying to tell.

> > 0 is unexpected result for non-optional APIs and there you may try to play
> > tricks (like replacing it by error code).
> > 
> > There was a discussion around the topic:
> > https://lore.kernel.org/lkml/20210331144526.19439-1-andriy.shevchenko@linux.intel.com/T/#u
> 
>    I don't see much of the discussion there...

Indeed, it was split between two threads. Another one is this:
https://lore.kernel.org/linux-serial/20210407101713.8694-1-andriy.shevchenko@linux.intel.com/T/#u

> > Wanna help?
> 
>    No, I'm afraid you're on your own here... 
> 
> >> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
> > 
> > Not sure.
> 
>    Why? It fixes gthe IRQ0 problem, so that you don't have to check for IRQ0 in many callers
> (for the subsytems that treat 0 as s/th special, like polling mode)... If you have something
> to improve, you can do that atop of this patch...

Because first we need to fix all users of platform_get_irq_optional().

-- 
With Best Regards,
Andy Shevchenko


