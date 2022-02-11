Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70BE4B2BBE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352155AbiBKR2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:28:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351129AbiBKR2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:28:16 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5DE2C9;
        Fri, 11 Feb 2022 09:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644600493; x=1676136493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kFSqnDXKLmnzkeqj34XrRG8BjVnVtFyc7BDAxOa/Lkg=;
  b=XfeKUXs7b8/0GIEmvuDV8d1xCtrfHycn62P/QwSDKPxHCt57/ov9KmBH
   HyXYWVxJutWA2koDVU9zf+CvR1Asrd8CaPdlGqx4qZMv9oFiNNOPVRbOX
   iT2ArNJe3RJg0W+7UNYBsms6zoHxtBMs8BuzSN8iPy748C7lJNduiVHna
   WEUh9Xo7nnhYMmVQmWKZ7glEk/oiNfTDc0bm6riT/qHWoZOdPHqvD+Le9
   BtP5cYgAU4tZ1ZW93kXH1dEaPqm1dG1X9SMR0hKiU4/7T7uoTSQQfrN8A
   7ltt+2+zdprZ7GUZ+g1HjV6VM/gEltBNIG3d/2h8tKHSYPL84jJA7oQBa
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="313054504"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="313054504"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 09:28:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="772150602"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 09:28:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nIZhQ-003Wrs-CU;
        Fri, 11 Feb 2022 19:27:12 +0200
Date:   Fri, 11 Feb 2022 19:27:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v4 1/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_gray8_line()
Message-ID: <YgaccFjPfJO0Mj6a@smile.fi.intel.com>
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-2-javierm@redhat.com>
 <YgY6OqN+guBlt/ED@smile.fi.intel.com>
 <4fa465d9-4fac-4199-9a04-d8e09d164308@redhat.com>
 <YgZEuXvJ2ZiOyNS+@smile.fi.intel.com>
 <7560cd10-0a7c-3fda-da83-9008833e3901@suse.de>
 <87pmnt7gm3.fsf@intel.com>
 <YgaDj6Wld4b7S6DF@smile.fi.intel.com>
 <87fsop74lu.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fsop74lu.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 06:25:17PM +0200, Jani Nikula wrote:
> On Fri, 11 Feb 2022, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Fri, Feb 11, 2022 at 02:05:56PM +0200, Jani Nikula wrote:
> >> On Fri, 11 Feb 2022, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >> > Am 11.02.22 um 12:12 schrieb Andy Shevchenko:
> >> >> On Fri, Feb 11, 2022 at 11:40:13AM +0100, Javier Martinez Canillas wrote:
> >> >>> On 2/11/22 11:28, Andy Shevchenko wrote:
> >> >>>> On Fri, Feb 11, 2022 at 10:19:22AM +0100, Javier Martinez Canillas wrote:
> >
> > ...
> >
> >> >>>>> +static void drm_fb_xrgb8888_to_gray8_line(u8 *dst, const u32 *src, unsigned int pixels)
> >> >>>>> +{
> >> >>>>> +	unsigned int x;
> >> >>>>> +
> >> >>>>> +	for (x = 0; x < pixels; x++) {
> >> >>>>> +		u8 r = (*src & 0x00ff0000) >> 16;
> >> >>>>> +		u8 g = (*src & 0x0000ff00) >> 8;
> >> >>>>> +		u8 b =  *src & 0x000000ff;
> >> >>>>> +
> >> >>>>> +		/* ITU BT.601: Y = 0.299 R + 0.587 G + 0.114 B */
> >> >>>>> +		*dst++ = (3 * r + 6 * g + b) / 10;
> >> >>>>> +		src++;
> >> >>>>> +	}
> >> >>>>
> >> >>>> Can be done as
> >> >>>>
> >> >>>> 	while (pixels--) {
> >> >>>> 		...
> >> >>>> 	}
> >> >>>>
> >> >>>> or
> >> >>>>
> >> >>>> 	do {
> >> >>>> 		...
> >> >>>> 	} while (--pixels);
> >> >>>>
> >> >>>
> >> >>> I don't see why a while loop would be an improvement here TBH.
> >> >> 
> >> >> Less letters to parse when reading the code.
> >> >
> >> > It's a simple refactoring of code that has worked well so far. Let's 
> >> > leave it as-is for now.
> >> 
> >> IMO *always* prefer a for loop over while or do-while.
> >> 
> >> The for (i = 0; i < N; i++) is such a strong paradigm in C. You
> >> instantly know how many times you're going to loop, at a glance. Not so
> >> with with the alternatives, which should be used sparingly.
> >
> > while () {}  _is_ a paradigm, for-loop is syntax sugar on top of it.
> 
> And while() is just syntax sugar for goto. :p
> 
> The for loop written as for (i = 0; i < N; i++) is hands down the most
> obvious counting loop pattern there is in C.
> 
> >> And yes, the do-while suggested above is buggy, and you actually need to
> >> stop and think to see why.
> >
> > It depends if pixels can be 0 or not and if it's not, then does it contain last
> > or number.
> >
> > The do {} while (--pixels); might be buggy iff pixels may be 0.
> 
> Yeah. And how long does it take to figure that out?

Okay, I made a mistake to drop the explanation. So, I (mistakenly) assumed
that people know this difference between post-decrement and pre-decrement
(note, while-loop here is not what is problematic).

-- 
With Best Regards,
Andy Shevchenko


