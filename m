Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE51D49CA69
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbiAZNIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:08:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:8277 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233873AbiAZNIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643202531; x=1674738531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QoWttKHIwySovLh54+n/rDLYKaoGyIVOjoeQpsMFcHg=;
  b=eNcofZPcl0bFqwYymqesYiyfMZmbF6wKWN2fQkiO6QjngNlH4mb3jwEA
   fDy8KGuir5ed6Oyj8BcnNkvuJRITx6tC9HgnbXAWWiF7EWWL3+dZSxbM5
   ceK42QFfQNoXu/ZGr5DiVyKiYAXoc6WfQpJNGyXIF/7mCW36B3Hg7K9t8
   YYPlkeGCu6/WLlhRKziTxRHf5+GXHlCHDBbGPyA9SJ/4Xicf+zK14PTui
   6HG90VYAA5J5rN1GwpdjcJYYRqx34DZr5kWH6InJqsF1o4NdTRMik2CXd
   hOMgjRFdnxz1TzhBydf8dCWSYTcqZfl30I6GDAkg4TBsRq96SVq+27HhZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="245378237"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="245378237"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:08:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="532753138"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:08:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nCi1V-00EbTv-05;
        Wed, 26 Jan 2022 15:07:41 +0200
Date:   Wed, 26 Jan 2022 15:07:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v1 1/4] fbtft: Unorphan the driver
Message-ID: <YfFHnNXIWFwDrRij@smile.fi.intel.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <20220125202118.63362-2-andriy.shevchenko@linux.intel.com>
 <YfEG2qVO9K9G+g1d@kroah.com>
 <CAKMK7uGoRC9a4cMCADTipV67oivfWvTw=6RYm2kOthB_bhWnXQ@mail.gmail.com>
 <f671a112-880d-1526-a395-360947b40c5a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f671a112-880d-1526-a395-360947b40c5a@gmx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 12:17:08PM +0100, Helge Deller wrote:
> On 1/26/22 11:31, Daniel Vetter wrote:
> > On Wed, Jan 26, 2022 at 9:31 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:

...

> > On the other hand ... why does it have to be resurrecting fbdev?
> > There's an entire community of people who really know graphics and
> > display and spent considerable amount of effort on creating useful and
> > documented helpers for pretty much anything you might ever want to do.
> > And somehow we have to go back to typing out things the hard way, with
> > full verbosity, for an uapi that distros are abandoning (e.g. even for
> > sdl the direction is to run it on top of drm with a compat layer,
> > afaiui fedora is completely ditching any userspace that still even
> > uses /dev/fb/0). And yes I know there's still some gaps in drm,
> > largely for display features which were really en vogue about 20 years
> > ago. And we're happy to add that support, if someone who still has
> > such hardware can put in the little bit of work needed ...
> >
> > I don't get this.
> 
> You are describing a transitioning over to DRM - which is Ok.
> But on that way there is no need to ignore, deny or even kill usage scenarios
> which are different compared to your usage scenarios (e.g. embedded devices,
> old platforms, slow devices, slow busses, no 3D hardware features,
> low-color devices, ...).

Exactly, I am on the same side here.

-- 
With Best Regards,
Andy Shevchenko


