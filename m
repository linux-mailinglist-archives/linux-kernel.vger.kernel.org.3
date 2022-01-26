Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070F149CA82
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238084AbiAZNPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:15:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:25921 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234520AbiAZNPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643202913; x=1674738913;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jvn1DT8hkIC9aHCBN88BfzW6xWKdrEbGQoRpjkz2lt4=;
  b=jodYnQlA0gn+YmW3inc+Gbg3xO/VpLOOx57Fe9doyytS6VeT6CV3hhGA
   GIykQJtXYtr5RWYWT5XBPyqJMHjpR1PRVn4C2fSVPTL3h8T/g8mS9ohhd
   Rae6EgSlLsWwQmF/fyBk2xKnASA9arZlp/qG8BC6QtcHycTi2Or8nCGRy
   XSOGLwoq/WMphOOzF3kSh+K/M1FuyQpfI/n9DYxfM4bXdePRq4FZUmMLq
   mbNrwVyJk9x2QIOlKl321CD/Gd1N+mJDGBHlFs/avL0CXUK/iSTRrkrhY
   WXjP882sRjZuTqF0r1SYhKTJjkmT4jkuxRa/mDqkisCk5UuSlN8XMwh81
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="307260494"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="307260494"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:15:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="597459201"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 05:15:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nCi7f-00EbZf-0w;
        Wed, 26 Jan 2022 15:14:03 +0200
Date:   Wed, 26 Jan 2022 15:14:02 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Helge Deller <deller@gmx.de>,
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
Message-ID: <YfFJGrfMi0E1ySmH@smile.fi.intel.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <20220125202118.63362-2-andriy.shevchenko@linux.intel.com>
 <YfEG2qVO9K9G+g1d@kroah.com>
 <CAKMK7uGoRC9a4cMCADTipV67oivfWvTw=6RYm2kOthB_bhWnXQ@mail.gmail.com>
 <f671a112-880d-1526-a395-360947b40c5a@gmx.de>
 <CAKMK7uFhJPpiHqL-040ozbCM=QxiWNrFHp1gOEUvpEUjxbwAQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFhJPpiHqL-040ozbCM=QxiWNrFHp1gOEUvpEUjxbwAQQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 12:27:19PM +0100, Daniel Vetter wrote:
> On Wed, Jan 26, 2022 at 12:18 PM Helge Deller <deller@gmx.de> wrote:
> > On 1/26/22 11:31, Daniel Vetter wrote:

...

> > You are describing a transitioning over to DRM - which is Ok.
> > But on that way there is no need to ignore, deny or even kill usage scenarios
> > which are different compared to your usage scenarios (e.g. embedded devices,
> > old platforms, slow devices, slow busses, no 3D hardware features,
> > low-color devices, ...).
> 
> This patchset isn't about killing existing support.
> 
> This is about adding new drivers to a subsystem where consensus the
> past 6 years or so was that it's closed for new drivers.

You mean fbdev?

-- 
With Best Regards,
Andy Shevchenko


