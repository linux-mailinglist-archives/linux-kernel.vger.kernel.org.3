Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822A44B4DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiBNLMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:12:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350992AbiBNLLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:11:10 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A3EA889C;
        Mon, 14 Feb 2022 02:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644835171; x=1676371171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C9m2rcxcDwLvUl2QbsECG3i5+PvKcHA60fHQFVqzZzs=;
  b=dhkhntxuAdMfT9J1D8023bmadjBHne0lC0goQVMLLlrxixpdQRhFMXVw
   wE9KhVl/y2By+y8UUtjFchH09gJWC6Tk7aaVx0xKDAzPRCOzG7EcOUhO4
   4Hdfa5TEhNgenE7lB6+3f6N3dpfAJzoRRm0lZIQQri9Xmez1OyoshS5Z2
   XUbOhVbyWbl2gTk/5CS5q1oE2f9JU7qPXhd/VY+iJ68as+6iIvHfWZgrz
   KpYfRrHMIOlErd7l4yLHAtW5fPkoR2cwQS4dB3OfSekVpM/7KD8wG/R7O
   XvqPP1i177p/Z3JnpvKxiukFzynom7c21l6Gy6lAoklGiMHXZrs68ch92
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="313342043"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="313342043"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 02:39:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="570085760"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 02:39:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nJYkG-004Pw8-Jg;
        Mon, 14 Feb 2022 12:38:12 +0200
Date:   Mon, 14 Feb 2022 12:38:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
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
Message-ID: <YgoxFBGNsrezVxmi@smile.fi.intel.com>
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-2-javierm@redhat.com>
 <YgY6OqN+guBlt/ED@smile.fi.intel.com>
 <4fa465d9-4fac-4199-9a04-d8e09d164308@redhat.com>
 <YgZEuXvJ2ZiOyNS+@smile.fi.intel.com>
 <7560cd10-0a7c-3fda-da83-9008833e3901@suse.de>
 <87pmnt7gm3.fsf@intel.com>
 <YgaDj6Wld4b7S6DF@smile.fi.intel.com>
 <f87ce2fa-6b18-f985-eb86-506ce7103db3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f87ce2fa-6b18-f985-eb86-506ce7103db3@suse.de>
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

On Mon, Feb 14, 2022 at 10:03:53AM +0100, Thomas Zimmermann wrote:
> Am 11.02.22 um 16:41 schrieb Andy Shevchenko:

...

> > > IMO *always* prefer a for loop over while or do-while.
> > > 
> > > The for (i = 0; i < N; i++) is such a strong paradigm in C. You
> > > instantly know how many times you're going to loop, at a glance. Not so
> > > with with the alternatives, which should be used sparingly.
> > 
> > while () {}  _is_ a paradigm, for-loop is syntax sugar on top of it.
> 
> Naw, that's not true.

In the section 3.5 "Loops - While and For" in "The C Programming
Language" 2nd by K&R, the authors said:

	The for statement ... is equivalent to ... while..."

They said that for is equivalent to while, and not otherwise.

Also, syntax sugar by definition declares something that can be written as
a single line of code, which usually is done using more (not always).

> An idiomatic for loop, such as for (i = ...; i < N;
> ++i), is such a strong pattern that it's way better than the corresponding
> while loop.

> > > And yes, the do-while suggested above is buggy, and you actually need to
> > > stop and think to see why.
> > 
> > It depends if pixels can be 0 or not and if it's not, then does it contain last
> > or number.
> > 
> > The do {} while (--pixels); might be buggy iff pixels may be 0.

-- 
With Best Regards,
Andy Shevchenko


