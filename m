Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4BA49CAAC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbiAZNW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:22:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:51983 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233165AbiAZNW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643203376; x=1674739376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RMyO1WCMKKm6nvlVwv3fqQksw6y8jrI2l1gTDNIwWL4=;
  b=IqYv8Bf46vqrZZNrnAuzvy356jc+8t7VuJK8S+6cyex1ShcEmXTN4lb4
   4trFR9K5YiGR/8eTFM5FssS2P46nzGFKVcvvVz4anS1FqgGREDYgHkEnU
   xObBnvHjmpA28sRGm7mfR36KdRc665eWcavXccOjW0oe3Ry4JsTYoB4hc
   fs36Suu/O3S0CCHj5tQOCgH+itR3qxiA7MV8wpqmmUq5E1YTqIUA2UaTT
   F9Pc2vFuKnCpmv+R7l+TfC5uyVvrp1ENhEyjRC030q5vcZSj8l7zKWe6X
   igQ7Nkpa0vUPUCHTm6HArUKAbPVNN7FBGlpKAojXiZWpqedae6hPT0iHu
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="227219017"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="227219017"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:22:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="563407497"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:22:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nCiF7-00Ebj5-R9;
        Wed, 26 Jan 2022 15:21:45 +0200
Date:   Wed, 26 Jan 2022 15:21:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     andy@kernel.org, deller@gmx.de, dri-devel@lists.freedesktop.org,
        gregkh@linuxfoundation.org, hkallweit1@gmail.com,
        lee.jones@linaro.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        michael.hennerich@analog.com, phil@philpotter.co.uk,
        zhangxuezhi1@yulong.com
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
Message-ID: <YfFK6VKEedqoseyH@smile.fi.intel.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <dc392272-80ae-dbbd-df26-c7ffa6239cf0@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc392272-80ae-dbbd-df26-c7ffa6239cf0@tronnes.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 02:15:29PM +0100, Noralf Trønnes wrote:
> >
> > Since we got a maintainer for fbdev, I would like to
> > unorphan fbtft (with the idea of sending PRs to Helge)
> > and move it out of staging since there is no more clean
> > up work expected and no more drivers either.
> >
> > Thoughts?
> 
> Here's a driver I have been working on:
> 
> drm/panel: Add MIPI DBI compatible SPI driver
> https://lore.kernel.org/dri-devel/20220125175700.37408-1-noralf@tronnes.org/
> 
> It should replace the SPI part of these fbtft drivers if accepted:

This is good news, but...

> $ grep -lr MIPI_DCS drivers/staging/fbtft/ | grep -v "-" | uniq | sort

Hint:

	git grep -lw MIPI_DCS -- drivers/staging/fbtft

> drivers/staging/fbtft/fb_hx8340bn.c
> drivers/staging/fbtft/fb_hx8353d.c
> drivers/staging/fbtft/fb_hx8357d.c
> drivers/staging/fbtft/fb_ili9163.c
> drivers/staging/fbtft/fb_ili9340.c
> drivers/staging/fbtft/fb_ili9341.c
> drivers/staging/fbtft/fb_ili9481.c
> drivers/staging/fbtft/fb_ili9486.c
> drivers/staging/fbtft/fb_s6d02a1.c
> drivers/staging/fbtft/fb_st7735r.c
> drivers/staging/fbtft/fb_st7789v.c
> drivers/staging/fbtft/fb_tinylcd.c
> 
> There's no support for the parallel interface on these controllers in
> drm. Support could be added to drivers/gpu/drm/drm_mipi_dbi.c.

...as I said and you confirmed that parallel interface support is missing.

> Here's a status report I wrote 2 years ago:
> 
> fbtft: 5 years in staging
> https://lore.kernel.org/dri-devel/a6cef26c-0f4b-47f0-d249-71f53891526b@tronnes.org/

Thanks for sharing!

-- 
With Best Regards,
Andy Shevchenko


