Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2DA4B2A3D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351468AbiBKQZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:25:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiBKQZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:25:26 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBBF38C;
        Fri, 11 Feb 2022 08:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644596724; x=1676132724;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=M1mHs7WEgatmlRjx4H6HCF+8F6e5ANVvjld7uTPgqFk=;
  b=JbHa6SfIrrmKG1LZ84MMoG7JLgIHx3nHidHKyaxsdpXs75fhydMFy7at
   cKVR+OhQWD2Jd8mJP1WWlZZD2Gg7k04bZO9Ob3cPcRUiYKGLfvFrehPxs
   Z1F9FCcK02YSeirLueXWPZKuBM87VVN2k+8KThThCv2YXGvRg3p8ELAPq
   zrXrrEdWLeFbWWc+pbsmZW4YebRdU1mnmaggveanPjCLKI1l0ovsNSRui
   H7cbwTxWUnaMFwME0GpHXSf65sf2uJFsR/S2d/QX5UQV1QvWxI/3+bOJL
   dMlqbH/jz9ZCWNJjD8OEWCpzxlPlv6P3qhdFDLs/Cgde6+C5+dMaeaCzK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="229725979"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="229725979"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:25:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="527010658"
Received: from rriverox-mobl.ger.corp.intel.com (HELO localhost) ([10.252.19.108])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:25:20 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v4 1/6] drm/format-helper: Add
 drm_fb_xrgb8888_to_gray8_line()
In-Reply-To: <YgaDj6Wld4b7S6DF@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-2-javierm@redhat.com>
 <YgY6OqN+guBlt/ED@smile.fi.intel.com>
 <4fa465d9-4fac-4199-9a04-d8e09d164308@redhat.com>
 <YgZEuXvJ2ZiOyNS+@smile.fi.intel.com>
 <7560cd10-0a7c-3fda-da83-9008833e3901@suse.de> <87pmnt7gm3.fsf@intel.com>
 <YgaDj6Wld4b7S6DF@smile.fi.intel.com>
Date:   Fri, 11 Feb 2022 18:25:17 +0200
Message-ID: <87fsop74lu.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Feb 11, 2022 at 02:05:56PM +0200, Jani Nikula wrote:
>> On Fri, 11 Feb 2022, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> > Am 11.02.22 um 12:12 schrieb Andy Shevchenko:
>> >> On Fri, Feb 11, 2022 at 11:40:13AM +0100, Javier Martinez Canillas wrote:
>> >>> On 2/11/22 11:28, Andy Shevchenko wrote:
>> >>>> On Fri, Feb 11, 2022 at 10:19:22AM +0100, Javier Martinez Canillas wrote:
>
> ...
>
>> >>>>> +static void drm_fb_xrgb8888_to_gray8_line(u8 *dst, const u32 *src, unsigned int pixels)
>> >>>>> +{
>> >>>>> +	unsigned int x;
>> >>>>> +
>> >>>>> +	for (x = 0; x < pixels; x++) {
>> >>>>> +		u8 r = (*src & 0x00ff0000) >> 16;
>> >>>>> +		u8 g = (*src & 0x0000ff00) >> 8;
>> >>>>> +		u8 b =  *src & 0x000000ff;
>> >>>>> +
>> >>>>> +		/* ITU BT.601: Y = 0.299 R + 0.587 G + 0.114 B */
>> >>>>> +		*dst++ = (3 * r + 6 * g + b) / 10;
>> >>>>> +		src++;
>> >>>>> +	}
>> >>>>
>> >>>> Can be done as
>> >>>>
>> >>>> 	while (pixels--) {
>> >>>> 		...
>> >>>> 	}
>> >>>>
>> >>>> or
>> >>>>
>> >>>> 	do {
>> >>>> 		...
>> >>>> 	} while (--pixels);
>> >>>>
>> >>>
>> >>> I don't see why a while loop would be an improvement here TBH.
>> >> 
>> >> Less letters to parse when reading the code.
>> >
>> > It's a simple refactoring of code that has worked well so far. Let's 
>> > leave it as-is for now.
>> 
>> IMO *always* prefer a for loop over while or do-while.
>> 
>> The for (i = 0; i < N; i++) is such a strong paradigm in C. You
>> instantly know how many times you're going to loop, at a glance. Not so
>> with with the alternatives, which should be used sparingly.
>
> while () {}  _is_ a paradigm, for-loop is syntax sugar on top of it.

And while() is just syntax sugar for goto. :p

The for loop written as for (i = 0; i < N; i++) is hands down the most
obvious counting loop pattern there is in C.

>> And yes, the do-while suggested above is buggy, and you actually need to
>> stop and think to see why.
>
> It depends if pixels can be 0 or not and if it's not, then does it contain last
> or number.
>
> The do {} while (--pixels); might be buggy iff pixels may be 0.

Yeah. And how long does it take to figure that out?


BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
