Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B9549CA4F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbiAZNDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:03:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:42709 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231904AbiAZNDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643202231; x=1674738231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mSnFOYWb2NTAiZJ6gl/F22Fq/rOFI1cKTn49lNqjzw4=;
  b=SOoxsq2mC+ryPptauJSMGHYP81Tt1KfoTTiDalzjDodfpxrl+Jg0F4eM
   mAuCcOcb0KLCsY/8CdkgUmbrhOMTH6cQPePOeWqATOUmb1Dm+Ynt7KMUB
   su1CtRxgk2xzd8v55A34UQM9lHxfp0fm17NMcAlV1Vlpbxz8fzc2jVE4X
   gNi6EK0KqcZrKDuQJsHAxrwCFHuQR3tEzfgSYyp9dgtNPJgAkS2Xt3WhE
   R3E/fhsswUAW7mruWSkzICKkaVp3VmFj/m1UL+vxn0k1L+DQInQdkb1rO
   Wo+BhZy40XzmPs8KHc5QdvmFtf4sKt81PUcxsDPTQFMsNpOPnBuKpM3fI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="246322107"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="246322107"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:03:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="617957353"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:03:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nChwe-00EbPb-NL;
        Wed, 26 Jan 2022 15:02:40 +0200
Date:   Wed, 26 Jan 2022 15:02:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Carlis <zhangxuezhi1@yulong.com>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Helge Deller <deller@gmx.de>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 4/4] fbtft: Replace 'depends on FB_TFT' by 'if FB_TFT
 ... endif'
Message-ID: <YfFGcEDnQwdDSwOx@smile.fi.intel.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <20220125202118.63362-5-andriy.shevchenko@linux.intel.com>
 <e12b11d20e22123736e5d8728286947e971c489f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e12b11d20e22123736e5d8728286947e971c489f.camel@perches.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 12:54:13AM -0800, Joe Perches wrote:
> On Tue, 2022-01-25 at 22:21 +0200, Andy Shevchenko wrote:
> > Replace 'depends on FB_TFT' by 'if FB_TFT ... endif'
> > for the sake of deduplication.
> []
> > diff --git a/drivers/video/fbtft/Kconfig b/drivers/video/fbtft/Kconfig
> []
> > @@ -10,87 +10,75 @@ menuconfig FB_TFT
> >  	select FB_DEFERRED_IO
> >  	select FB_BACKLIGHT
> >  
> > +if FB_TFT
> > +
> []
> >  config FB_TFT_PCD8544
> >  	tristate "FB driver for the PCD8544 LCD Controller"
> > -	depends on FB_TFT
> >  	help
> >  	  Generic Framebuffer support for PCD8544
> >  
> > @@ -108,62 +96,52 @@ config FB_TFT_S6D02A1
> 
> Looks like you missed a couple.

Thanks! I'll incorporate it, if the series has a continuation.

-- 
With Best Regards,
Andy Shevchenko


