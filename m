Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D47C46F4A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhLIULA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:11:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:12329 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229752AbhLIUK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639080446; x=1670616446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hi6i9pzDMrMYov4KZH9Zhg4JDGhGtJAz0j0T6yuD7KI=;
  b=O1e9bccRhB4WMLsRbn5LOapMMl5fN7GADXb2gPCBoVNjIQMtOmUlLBVS
   +3SfBDoY8c0CGynqE3gFMU2ER+MTvuWRciOgCttwuI956o9fCqGTtBIlU
   Y4psiCHy2vpKNwB1Lgz1u5RxrNYoAPnYy1pVsr+iAjA3/KNGvTqw17bWh
   HPvfjdqJCpsIp6GR2YOvVfV6KYZr0u3kb+4+07RwBs3rzSBVJK/ylnhc6
   F3SfYdorOCMfTQTKyv/ojW76Ew0Ce50PZNo6C/4AArllSjpr87pfBXqpa
   46QNTN4uj6QqCKGeFVLCubGxYJG9uZmMMzxpw4Tqyig6u9N9aOIK3vzT5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="218220597"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="218220597"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 12:07:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="680474704"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 12:07:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1mvPgJ-004FAU-At;
        Thu, 09 Dec 2021 22:06:19 +0200
Date:   Thu, 9 Dec 2021 22:06:19 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform: finally disallow IRQ0 in platform_get_irq()
 and its ilk
Message-ID: <YbJhu53WEmotslox@smile.fi.intel.com>
References: <5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2021 at 11:26:47PM +0300, Sergey Shtylyov wrote:
> The commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is
> invalid") only calls WARN() when IRQ0 is about to be returned, however
> using IRQ0 is considered invalid (according to Linus) outside the arch/
> code where it's used by the i8253 drivers. Many driver subsystems treat
> 0 specially (e.g. as an indication of the polling mode by libata), so
> the users of platform_get_irq[_byname]() in them would have to filter
> out IRQ0 explicitly and this (quite obviously) doesn't scale...
> Let's finally get this straight and return -EINVAL instead of IRQ0!

You are changing the return value of platform_get_irq_optional().
The problem here is the proposed change doesn't bring any value in such
case. platform_get_irq_optional() should be able (at the end of the day)
to return 3 types of values (as other APIs do):
	 > 0: success
	== 0: IRQ not found
	 < 0: an error that must be consumed by the caller

0 is unexpected result for non-optional APIs and there you may try to play
tricks (like replacing it by error code).

There was a discussion around the topic:
https://lore.kernel.org/lkml/20210331144526.19439-1-andriy.shevchenko@linux.intel.com/T/#u

Wanna help?

> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")

Not sure.

-- 
With Best Regards,
Andy Shevchenko


