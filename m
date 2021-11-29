Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BB8461FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350853AbhK2TOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:14:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:37799 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237628AbhK2TMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:12:50 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="223280492"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="223280492"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 11:06:41 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="458554931"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 11:06:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mrly1-00080f-Jt;
        Mon, 29 Nov 2021 21:05:33 +0200
Date:   Mon, 29 Nov 2021 21:05:33 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        cezary.rojewski@intel.com, liam.r.girdwood@linux.intel.com,
        yang.jie@linux.intel.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: Intel: atom: Remove redundant check to simplify
 the code
Message-ID: <YaUkfV9ng6/Wmpkd@smile.fi.intel.com>
References: <20211125075028.8500-1-tangbin@cmss.chinamobile.com>
 <3ca07ce3-6d5c-20cc-8992-4700490ea472@linux.intel.com>
 <YaUJ2EfU6kYFfjWn@sirena.org.uk>
 <YaUjfFNA6IScPCY9@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaUjfFNA6IScPCY9@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 09:01:16PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 29, 2021 at 05:11:52PM +0000, Mark Brown wrote:
> > On Mon, Nov 29, 2021 at 10:22:41AM -0600, Pierre-Louis Bossart wrote:
> > > On 11/25/21 1:50 AM, Tang Bin wrote:
> > 
> > > > In the function sst_platform_get_resources(), if platform_get_irq()
> > > > failed, the return should not be zero, as the example in
> > > > platform.c is
> > > >   * int irq = platform_get_irq(pdev, 0)
> > > >   * if (irq < 0)
> > > >   * return irq;
> > > > So remove the redundant check to simplify the code.
> > 
> > > Humm, it's a bit of a gray area.
> > 
> > > the comments for platform_get_irq and platform_get_irq_optional say:
> > 
> > > * Return: non-zero IRQ number on success, negative error number on failure.
> > 
> > > but if you look at platform_get_irq_optional, there are two references
> > > to zero being a possible return value:
> > 
> > Zero is (or was, people were working on changing it partly due to
> > confusion and partly due to moving to newer infrastructure which
> > doesn't use it) a valid IRQ on some architectures.  x86 wasn't one of
> > those though, at least AFAIR.
> 
> I guess it's about x86, but the API returns Linux virtual IRQ and 0 shouldn't
> be among them (hardware IRQ != Linux virtual IRQ). Legacy x86 used 1:1 mapping
> for ISA IRQs (lower 16) among which the Timer IRQ is 0. I believe that timer
> code does not use any of those APIs (it most likely and IIRC has it hardcoded).
> 
> Nevertheless, I have planned to make platform_irq_get_optional() to be optional
> indeed, where we return 0 when there is no IRQ provided and error when it's a
> real error happens. This needs to clean up the current (mis-)use of the API.

Link for previous work: https://lore.kernel.org/lkml/20210331144526.19439-1-andriy.shevchenko@linux.intel.com/T/#u

-- 
With Best Regards,
Andy Shevchenko


