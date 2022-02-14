Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FC14B4D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349680AbiBNLA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:00:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbiBNLAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:00:18 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC9A60D9F;
        Mon, 14 Feb 2022 02:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644834430; x=1676370430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YCbldYpJP2yJmPrWGzP+r81INHFHg/rlUsst41sYkZM=;
  b=cNwUjl36QkgPrmuRVRMekAh4pdGxNw1g75mOporGn0JgVTmzfWzLmhR0
   hoosuIWYyXc94TqCjZZ4cXrCc6dOlDcP/f419zHFwJ+0GRXWV19RemiW3
   lMf4RB1A+aiN5ol7neBZqTDVJa3p9h7HGmkP/U0bSJE3kEBkyZcFX+5zL
   sPnW1Nvl23gKpxCThIaSBe7s+asT1xZooMOXhdWMsnoJ34cnhfQM52to6
   BTMBOKiAXY33+CDactA6v/yAMzJjp2cMgJtwIn1PVuPM1s9KGQe/u73a3
   M5mkdkO3Ymf1RO20AkN6A2dI/VuyUGuOydRZV9J/J8IUQoYIbSeSowGBl
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="313340694"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="313340694"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 02:27:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="635075213"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 02:27:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nJYYc-004PSj-SD;
        Mon, 14 Feb 2022 12:26:10 +0200
Date:   Mon, 14 Feb 2022 12:26:10 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v4 1/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_gray8_line()
Message-ID: <YgouQj5XG6lGZA8I@smile.fi.intel.com>
References: <20220211091927.2988283-2-javierm@redhat.com>
 <YgY6OqN+guBlt/ED@smile.fi.intel.com>
 <4fa465d9-4fac-4199-9a04-d8e09d164308@redhat.com>
 <YgZEuXvJ2ZiOyNS+@smile.fi.intel.com>
 <7560cd10-0a7c-3fda-da83-9008833e3901@suse.de>
 <87pmnt7gm3.fsf@intel.com>
 <YgaDj6Wld4b7S6DF@smile.fi.intel.com>
 <87fsop74lu.fsf@intel.com>
 <YgaccFjPfJO0Mj6a@smile.fi.intel.com>
 <20220214111711.6536b4b6@eldfell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214111711.6536b4b6@eldfell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 11:17:11AM +0200, Pekka Paalanen wrote:
> On Fri, 11 Feb 2022 19:27:12 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Feb 11, 2022 at 06:25:17PM +0200, Jani Nikula wrote:
> > > On Fri, 11 Feb 2022, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> > > > On Fri, Feb 11, 2022 at 02:05:56PM +0200, Jani Nikula wrote:  
> > > >> On Fri, 11 Feb 2022, Thomas Zimmermann <tzimmermann@suse.de> wrote:  
> > > >> > Am 11.02.22 um 12:12 schrieb Andy Shevchenko:  
> > > >> >> On Fri, Feb 11, 2022 at 11:40:13AM +0100, Javier Martinez Canillas wrote:  
> > > >> >>> On 2/11/22 11:28, Andy Shevchenko wrote:  
> > > >> >>>> On Fri, Feb 11, 2022 at 10:19:22AM +0100, Javier Martinez Canillas wrote:  

...

> > > >> >>>>> +static void drm_fb_xrgb8888_to_gray8_line(u8 *dst, const u32 *src, unsigned int pixels)
> > > >> >>>>> +{
> > > >> >>>>> +	unsigned int x;
> > > >> >>>>> +
> > > >> >>>>> +	for (x = 0; x < pixels; x++) {
> > > >> >>>>> +		u8 r = (*src & 0x00ff0000) >> 16;
> > > >> >>>>> +		u8 g = (*src & 0x0000ff00) >> 8;
> > > >> >>>>> +		u8 b =  *src & 0x000000ff;
> > > >> >>>>> +
> > > >> >>>>> +		/* ITU BT.601: Y = 0.299 R + 0.587 G + 0.114 B */
> > > >> >>>>> +		*dst++ = (3 * r + 6 * g + b) / 10;
> > > >> >>>>> +		src++;
> > > >> >>>>> +	}  
> > > >> >>>>
> > > >> >>>> Can be done as
> > > >> >>>>
> > > >> >>>> 	while (pixels--) {
> > > >> >>>> 		...
> > > >> >>>> 	}
> > > >> >>>>
> > > >> >>>> or
> > > >> >>>>
> > > >> >>>> 	do {
> > > >> >>>> 		...
> > > >> >>>> 	} while (--pixels);
> > > >> >>>>  
> > > >> >>>
> > > >> >>> I don't see why a while loop would be an improvement here TBH.  
> > > >> >> 
> > > >> >> Less letters to parse when reading the code.  
> > > >> >
> > > >> > It's a simple refactoring of code that has worked well so far. Let's 
> > > >> > leave it as-is for now.  
> > > >> 
> > > >> IMO *always* prefer a for loop over while or do-while.
> > > >> 
> > > >> The for (i = 0; i < N; i++) is such a strong paradigm in C. You
> > > >> instantly know how many times you're going to loop, at a glance. Not so
> > > >> with with the alternatives, which should be used sparingly.  
> > > >
> > > > while () {}  _is_ a paradigm, for-loop is syntax sugar on top of it.  
> > > 
> > > And while() is just syntax sugar for goto. :p
> > > 
> > > The for loop written as for (i = 0; i < N; i++) is hands down the most
> > > obvious counting loop pattern there is in C.
> > >   
> > > >> And yes, the do-while suggested above is buggy, and you actually need to
> > > >> stop and think to see why.  
> > > >
> > > > It depends if pixels can be 0 or not and if it's not, then does it contain last
> > > > or number.
> > > >
> > > > The do {} while (--pixels); might be buggy iff pixels may be 0.  
> > > 
> > > Yeah. And how long does it take to figure that out?  
> > 
> > Okay, I made a mistake to drop the explanation. So, I (mistakenly) assumed
> > that people know this difference between post-decrement and pre-decrement
> > (note, while-loop here is not what is problematic).
> 
> That was not the question.
> 
> The question was, how long does it take to figure out if pixels can or
> cannot be zero?

To me these patterns, while() {} and do {} while(), while being shorter,
also give a hint. So if one is familiar with C, the do {} while (--foo)
_gives a hint_ while being shorter. It requires _less_ brain power to get
this.

But I assume my brain is unique and not working as million of others.

> Code is styled for humans other than the author, not for compilers.
> 
> Having to stop to think about the difference between post- and
> pre-decrement to figure out when the while-loop runs does take me a few
> more brain cycles to understand, even though I know the rules very well.
> 
> I would call that brain cycle optimization, and leave the CPU cycle
> optimization for the compiler in these cases.



-- 
With Best Regards,
Andy Shevchenko


