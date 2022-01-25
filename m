Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B3D49BB25
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiAYSUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:20:12 -0500
Received: from mga05.intel.com ([192.55.52.43]:53955 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229951AbiAYSTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 13:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643134746; x=1674670746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tv1tjWDzNBoDUOS+Q8dhCcXjC2IOqiaYcuGKE757/JY=;
  b=e9iB+OFkjxRB/A6gNVQ+7T3BGi1KLPkyuhRHDrK7OVhCEOsBkS6gnkR+
   NmIZlEYNa3aCPC1avelFGdcboiHMAKknXd+5FvDhc9XE+ptzwp+UxDtNG
   Z9AW83urdHHrlt5+YI9HSLpH5Ov5PFSbC8+hMhBhV7/m3JnL2egwG6mGd
   Q1N/xzFZ6SSUPiW/SDpmoTUbtjcA80HKr3fJhgXAkLcGB9UZI3dYA2FBZ
   kHTI4DBiHRS3x4UXbkntlRkJ5+l7UAPoFGsTOR7ACFDVRb3c1nekezt+t
   5P6+66SuevJeIbald3U+7DLBECx9LG+8BN+tUEUYJXS5t020Z2lP1rNbr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="332725513"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="332725513"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 10:18:50 -0800
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="477203483"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 10:18:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nCQNw-00ELWo-LD;
        Tue, 25 Jan 2022 20:17:40 +0200
Date:   Tue, 25 Jan 2022 20:17:40 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     Liam Beguin <liambeguin@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 5/5] iio: afe: iio-rescale: Re-use generic struct
 s32_fract
Message-ID: <YfA+xFR0oh2ztDKv@smile.fi.intel.com>
References: <20220110193104.75225-1-andriy.shevchenko@linux.intel.com>
 <20220110193104.75225-5-andriy.shevchenko@linux.intel.com>
 <20220115185203.567780e8@jic23-huawei>
 <Ye7DSAN4gdhXfEUs@smile.fi.intel.com>
 <Ye8Z6dS5cCji9LNQ@shaak>
 <Ye/4eJ/RhlWF7q70@smile.fi.intel.com>
 <b25932d7-91bc-27b4-ada9-8d5da1ef2ddf@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b25932d7-91bc-27b4-ada9-8d5da1ef2ddf@axentia.se>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 03:54:07PM +0100, Peter Rosin wrote:
> On 2022-01-25 14:17, Andy Shevchenko wrote:
> > On Mon, Jan 24, 2022 at 04:28:09PM -0500, Liam Beguin wrote:
> >> On Mon, Jan 24, 2022 at 05:18:32PM +0200, Andy Shevchenko wrote:
> >>> On Sat, Jan 15, 2022 at 06:52:03PM +0000, Jonathan Cameron wrote:
> >>>> On Mon, 10 Jan 2022 21:31:04 +0200
> >>>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> >>>> I'm not totally sold on this series showing there is a strong case for
> >>>> these macros so interested to hear what others think.
> >>>
> >>> So far no news :-)
> >>
> >> Like I mentioned briefly in the other thread[1], I don't really see the
> >> advantage for the AFE driver given that it's almost just like renaming
> >> the parameters.
> > 
> > I tend to disagree, perhaps I wasn't so clear in my points.
> > 
> > The change reveals that the layering can be improved. In OOP
> > the object A which is inherited (or encapsulated as we see here)
> > allows to clearly get what kind of data the methods are operating
> > with / on. As you may see the two functions and the method
> > declaration appears to have interest only in the fraction data
> > for rescaling. The cleanup I consider helpful in the terms
> > of layering and OOP.

> [Sorry for the delay, I have been far too busy for far too long]

Anyway, thanks for review! My answers below.

> While this is all true for the current set of front-ends, it is not
> all that far-fetched to imagine some kind of future front-end that
> requires some other parameter, such that the rescaling fraction is no
> longer the only thing of interest. So, I have the feeling that changing
> the type of the 2nd argument of the ->props functions to just the
> fraction instead of the bigger object is conceptually wrong and
> something that will later turn out to have been a bad idea.

How? Technically as I mentioned currently it's the case to use
only the date from fraction. The bigger object would be needed
in case of using data that is not fraction. Either way it would
be easy to add a container_of() than supply unneeded data to
the method.

TL;DR: It makes possible not to mix bananas with wooden boxes.

> Regarding the new xyz_fract types, I have no strong opinion. But as
> long as there are no helper functions for the new types, I see little
> value in them. To me, they look mostly like something that newcomers
> (and others) will not know about or expect, and it will just be
> another thing that you have to look out for during review, to keep new
> numerators/denominators from appearing and causing extra rounds of
> review for something that is mostly a bikeshed issue.
> 
> My guess is that many times where fractions are used, they are used
> since fp math is not available. And that means that there will be a
> lot of special handling and shortcuts done since various things about
> accuracy and precision can be assumed. I think it will be hard to do
> all that centrally and in a comprehensible way. But if it is done it
> will of course also be possible to eliminate bugs since people may
> have taken too many shortcuts. But simply changing to xyz_fract and
> then not take it further than that will not change much.

I understand your point. I will provide a mult_fract() macro and
apply it to AFE to show the usability of this. Would it work better?

I haven't checked the other possible improvements based on new type, but
I truly believe that the types themselves are good to have.

> Also, there is already a v4l2_fract which is exposed in UAPI (maybe
> there are others?). I don't see how we bring that one in line with this
> new struct xyz_fract scheme?

UAPI is another story. It might be possible to extend, but I would like
to avoid expanding the proposed types to UAPI (we don't have many users
and I believe they more or less unique, so v4l2 is rather exception than
usual).

-- 
With Best Regards,
Andy Shevchenko


