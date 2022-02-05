Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D5B4AAAFD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380961AbiBESmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:42:17 -0500
Received: from mga12.intel.com ([192.55.52.136]:35209 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231970AbiBESmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644086535; x=1675622535;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cNnZtxWbDRndveerOgtEVX5WSi6u+NAFTOgxNigDKo4=;
  b=jy1u3LUgjdGIrQJI/RdxXN5O66j2KEpsJtT52sCHmx/GQ8EZApX0Bwdu
   gFeLOW6XNgBV0mopmF1QutCRVRz6Dm05vc89R3B2PeVoNmvPHjKjONdE7
   QfQwa4/AXwtN2Ouc5akRgfw1RSi3wHbWM4vvAhBt6s+zc9Lq/SbEWY4pN
   s8VC6sReXnfGUXbVGcsQLOCapX7S1h7PECNO5aLL/ptcNrfbvU5Dq+qS7
   F9ZaW6Nw1zz9ZT3SkXc2e1BbrsgOc6puIXX+WBGSID29mHDTVmqRuGGlA
   Aaax7V969qyaQWjJt0+NUj5NIQjjy1fVr/ijUKKnFSCYv9dvalrikWREP
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="228499951"
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="228499951"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 10:42:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="524664659"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 10:42:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nGPzm-001LbV-I0;
        Sat, 05 Feb 2022 20:41:14 +0200
Date:   Sat, 5 Feb 2022 20:41:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/1] iio: chemical: atlas-ezo-sensor: Make use of
 device properties
Message-ID: <Yf7EyhRjBqa4GM1o@smile.fi.intel.com>
References: <20220203162725.63979-1-andriy.shevchenko@linux.intel.com>
 <20220205163758.760d1c44@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205163758.760d1c44@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 04:37:58PM +0000, Jonathan Cameron wrote:
> On Thu,  3 Feb 2022 18:27:25 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Convert the module to be property provider agnostic and allow
> > it to be used on non-OF platforms.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Hi Andy,
> 
> Looks fine to me, though I'm a little curious what your logic
> was in dropping the enum?  Moving to pointers to the array
> entry is fine, but without the enum, you have to refer back
> and forwards whilst reading to check entries are the right ones.
> 
> I wouldn't have bothered commenting on this if reviewing new
> code, but here you are removing what I would consider good
> practice.

> >  static struct atlas_ezo_device atlas_ezo_devices[] = {
> > -	[ATLAS_CO2_EZO] = {
> > +	[0] = {
> 
> I think I would have kept the enum so ...

Even in the original code it's an overkill.

The problems with enums and especially in the cases like this are:
- unnecessary level of indirection when we may use pointers directly
- the casting of the enum in the driver_data is ugly in my opinion
- the enum value 0 used as driver_data can't be read by
  *device_get_match_data() APIs.

Or do you mean that use enum for the indices? That's okay.
Let me leave them for the sake of indices.

...

> > +	{ "atlas-co2-ezo", (kernel_ulong_t)&atlas_ezo_devices[0] },
> 
> Locally it would have been obvious that
> (kernel_ulong_t(&atlas_ezo_devices[ATLAS_CO2_EZO])
> was the right one index.

Right.

-- 
With Best Regards,
Andy Shevchenko


