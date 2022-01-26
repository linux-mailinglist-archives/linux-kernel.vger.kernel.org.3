Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8D049C942
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241069AbiAZMGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:06:09 -0500
Received: from mga01.intel.com ([192.55.52.88]:23918 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241060AbiAZMGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643198768; x=1674734768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ppDxVaxFOB8xCtyaz1C0wlYJV3uWw9Rg2IHoloxfDDM=;
  b=F24bQpFN50m0swkVrekz+dAh2gw6y5BauUARXdE7MDmvVbOW2nA+PtVL
   LToqdFAXIT9BO3t3gNBdiPXk9w0VQ0n/da/3sO91pFe5w9dv/p1XcOveG
   NUeutvs8JONL7dWpgVHAyniTVy9C2kztsbcNH1cx3wvlproxlVi5r5mlA
   z2fS8iHvIsLg8AvRYthBKECabvj3LZ47fqxzUCUXBJSW2kiaBB5JhHVZm
   QUAwq1gJjQF6RVUx9PSnvgE4TOKfk5IIXSoykCEv3FowpmXsSeOnLvXvn
   1fnHPfJqhzZZ41gLEkIzNJ1KYUoGekbGf5o/kF42XYikgtwdet7gbXm+2
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="270986943"
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="270986943"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 04:06:03 -0800
X-IronPort-AV: E=Sophos;i="5.88,318,1635231600"; 
   d="scan'208";a="628286413"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2022 04:06:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nCh2j-00Eaan-UQ;
        Wed, 26 Jan 2022 14:04:53 +0200
Date:   Wed, 26 Jan 2022 14:04:53 +0200
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
Message-ID: <YfE45cImAQpOeziT@smile.fi.intel.com>
References: <20220110193104.75225-1-andriy.shevchenko@linux.intel.com>
 <20220110193104.75225-5-andriy.shevchenko@linux.intel.com>
 <20220115185203.567780e8@jic23-huawei>
 <Ye7DSAN4gdhXfEUs@smile.fi.intel.com>
 <Ye8Z6dS5cCji9LNQ@shaak>
 <Ye/4eJ/RhlWF7q70@smile.fi.intel.com>
 <b25932d7-91bc-27b4-ada9-8d5da1ef2ddf@axentia.se>
 <YfA+xFR0oh2ztDKv@smile.fi.intel.com>
 <34c121fa-2a3b-fb6b-f6d5-fc2be2a5c6b7@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34c121fa-2a3b-fb6b-f6d5-fc2be2a5c6b7@axentia.se>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 11:26:50AM +0100, Peter Rosin wrote:
> On 2022-01-25 19:17, Andy Shevchenko wrote:
> > On Tue, Jan 25, 2022 at 03:54:07PM +0100, Peter Rosin wrote:
> >> On 2022-01-25 14:17, Andy Shevchenko wrote:
> >>> On Mon, Jan 24, 2022 at 04:28:09PM -0500, Liam Beguin wrote:
> >>>> On Mon, Jan 24, 2022 at 05:18:32PM +0200, Andy Shevchenko wrote:
> >>>>> On Sat, Jan 15, 2022 at 06:52:03PM +0000, Jonathan Cameron wrote:
> >>>>>> On Mon, 10 Jan 2022 21:31:04 +0200
> >>>>>> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> >>>>>> I'm not totally sold on this series showing there is a strong case for
> >>>>>> these macros so interested to hear what others think.
> >>>>>
> >>>>> So far no news :-)
> >>>>
> >>>> Like I mentioned briefly in the other thread[1], I don't really see the
> >>>> advantage for the AFE driver given that it's almost just like renaming
> >>>> the parameters.
> >>>
> >>> I tend to disagree, perhaps I wasn't so clear in my points.
> >>>
> >>> The change reveals that the layering can be improved. In OOP
> >>> the object A which is inherited (or encapsulated as we see here)
> >>> allows to clearly get what kind of data the methods are operating
> >>> with / on. As you may see the two functions and the method
> >>> declaration appears to have interest only in the fraction data
> >>> for rescaling. The cleanup I consider helpful in the terms
> >>> of layering and OOP.
> > 
> >> [Sorry for the delay, I have been far too busy for far too long]
> > 
> > Anyway, thanks for review! My answers below.
> > 
> >> While this is all true for the current set of front-ends, it is not
> >> all that far-fetched to imagine some kind of future front-end that
> >> requires some other parameter, such that the rescaling fraction is no
> >> longer the only thing of interest. So, I have the feeling that changing
> >> the type of the 2nd argument of the ->props functions to just the
> >> fraction instead of the bigger object is conceptually wrong and
> >> something that will later turn out to have been a bad idea.
> > 
> > How? Technically as I mentioned currently it's the case to use
> > only the date from fraction. The bigger object would be needed
> > in case of using data that is not fraction. Either way it would
> > be easy to add a container_of() than supply unneeded data to
> > the method.
> 
> It's easy to both remove and to add back "the bigger object". I just
> don't see the point of the churn. Technically you can probably rearrange
> stuff in probe and remove the 2nd argument to ->props() altogether and
> chase pointers from the dev object instead. I don't see the point of
> that either. It doesn't really make things simpler, it doesn't really
> make things easier to read. To me, it's just pointless churn.

Since you still haven't got a point the conclusions are wrong.
The point is (I dunno how more clear to make it) is to have proper
layering from the (current) design perspective.

If we go to the road full of "if it will come XYZ then this sucks".
The future is uncertain and neither of us may prove the current
change good or bad in terms of the future (unknown and uncertain)
changes.

Preventing this patch to land is to tell "Oh, my design is bad,
but I will keep it, because in the future everything may change".
So, why don't you make this future to be now?

> > TL;DR: It makes possible not to mix bananas with wooden boxes.
> 
> Which is all good until you need to ship an apple in the box with the
> bananas. (e.g. if you for some reason need the bananas to get ripe real
> quick, apples produce ethylene)

Really. arguments about the future changes are weak. If you have
patches in mind, send them, We will see in practice what you meant.

> >> Regarding the new xyz_fract types, I have no strong opinion. But as
> >> long as there are no helper functions for the new types, I see little
> >> value in them. To me, they look mostly like something that newcomers
> >> (and others) will not know about or expect, and it will just be
> >> another thing that you have to look out for during review, to keep new
> >> numerators/denominators from appearing and causing extra rounds of
> >> review for something that is mostly a bikeshed issue.
> >>
> >> My guess is that many times where fractions are used, they are used
> >> since fp math is not available. And that means that there will be a
> >> lot of special handling and shortcuts done since various things about
> >> accuracy and precision can be assumed. I think it will be hard to do
> >> all that centrally and in a comprehensible way. But if it is done it
> >> will of course also be possible to eliminate bugs since people may
> >> have taken too many shortcuts. But simply changing to xyz_fract and
> >> then not take it further than that will not change much.
> > 
> > I understand your point. I will provide a mult_fract() macro and
> > apply it to AFE to show the usability of this. Would it work better?
> 
> In my experience, burying stuff in macros will make it harder to follow
> what is really happening. Something that has proven hard as-is in this
> driver. While reviewing the changes from Liam, I have repeatedly looked
> up the various division variants to find out what they are actually
> doing. Here, it's not the individual steps that are difficult. I feel
> that if we start adding macros for fractions they will soon multiply and
> I'm not really looking forward to also have a set of similar fraction
> macros to juggle.

The problem here is that every driver would like to do this differently
and since it's related to the calculation we will have all possible error
prone implementations which do miscalculations (yes, one may not notice
traditional off-by-one until it becomes a huge issue by using additional
conversion formulas or so).

> But sure, feel free to suggest something. But please hold until the
> current work from Liam is merged.
> That series is clearly more
> important, and I'm not really interested in neither adding more work for
> him nor a cleanup of the current code without those pending changes.

I'm very well fine with that. As I mentioned from the beginning, I may rebase
this on top of the Liam's work.

-- 
With Best Regards,
Andy Shevchenko


