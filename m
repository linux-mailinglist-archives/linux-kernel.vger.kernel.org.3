Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7B04B5289
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354767AbiBNOAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:00:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245234AbiBNOAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:00:33 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2D613EA2;
        Mon, 14 Feb 2022 06:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644847224; x=1676383224;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qW3sr4UpfHOJBkGebrV5Id5bVpujcOv1DgqT7fTbuks=;
  b=B0M9RtAOhQSXR5psybe+1DAicJnW+gDno4ewYWOLd7wIzVyghvFB7Qrd
   r+xbTN8X4keZ9mO6EKG3vkxVhdhF5gC/VoW2GWc04uJ+ywxpR2U6okl/m
   OW6ZJh1cNlAKtFUZ66HHY9ECW7uSDcnKXpI6JcSCNlC11izXvEzSIprNB
   x3Ts1ZPJaUFJ10DlmmdycJqHqqoRPYkfVFtM5F7EGHX7lJxgEYZ3iKy5Z
   fel1/XRsF+ruItprK8FrKk2Pm/KzKPhDh1Bt0YV9Fso9IXbjippa055Z5
   ZETDQr20ks3CrsIB3r4ZYDy4JEXdC2foWZM6Ej3fLVERFWGmhdUbA+sJc
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="248924542"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="248924542"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 06:00:24 -0800
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="632157823"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.59])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 06:00:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nJbsz-004Yhy-62;
        Mon, 14 Feb 2022 15:59:25 +0200
Date:   Mon, 14 Feb 2022 15:59:24 +0200
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
Message-ID: <YgpgPCT7XVLvwTnr@smile.fi.intel.com>
References: <20220211091927.2988283-2-javierm@redhat.com>
 <YgY6OqN+guBlt/ED@smile.fi.intel.com>
 <4fa465d9-4fac-4199-9a04-d8e09d164308@redhat.com>
 <YgZEuXvJ2ZiOyNS+@smile.fi.intel.com>
 <7560cd10-0a7c-3fda-da83-9008833e3901@suse.de>
 <87pmnt7gm3.fsf@intel.com>
 <YgaDj6Wld4b7S6DF@smile.fi.intel.com>
 <f87ce2fa-6b18-f985-eb86-506ce7103db3@suse.de>
 <YgoxFBGNsrezVxmi@smile.fi.intel.com>
 <5ee24960-7843-827a-2c47-b93a4b4798e3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ee24960-7843-827a-2c47-b93a4b4798e3@suse.de>
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

On Mon, Feb 14, 2022 at 01:12:48PM +0100, Thomas Zimmermann wrote:
> Am 14.02.22 um 11:38 schrieb Andy Shevchenko:
> > On Mon, Feb 14, 2022 at 10:03:53AM +0100, Thomas Zimmermann wrote:
> > > Am 11.02.22 um 16:41 schrieb Andy Shevchenko:

...

> > > > > IMO *always* prefer a for loop over while or do-while.
> > > > > 
> > > > > The for (i = 0; i < N; i++) is such a strong paradigm in C. You
> > > > > instantly know how many times you're going to loop, at a glance. Not so
> > > > > with with the alternatives, which should be used sparingly.
> > > > 
> > > > while () {}  _is_ a paradigm, for-loop is syntax sugar on top of it.
> > > 
> > > Naw, that's not true.
> > 
> > In the section 3.5 "Loops - While and For" in "The C Programming
> > Language" 2nd by K&R, the authors said:
> 
> Year of publication: 1988 . It's not the most up-to-date reference for C
> programming.

Yet this makes your above remark invalid, i.e. `for` _is_ syntax sugar despite
what you think it's idiomatic _nowadays_.

> > 	The for statement ... is equivalent to ... while..."
> > 
> > They said that for is equivalent to while, and not otherwise.
> 
> Even leaving readability aside, it's not equivalent. You can declare
> variables as part of the for statement. (I know it's not the kernel's
> style.) Also, 'continue' statements are not well-suited in for loops,
> because it's non-obvious if the loop's update statement is being executed.
> (It isn't.)

It's also written in the book :-)

> > Also, syntax sugar by definition declares something that can be written as
> > a single line of code, which usually is done using more (not always).
> 
> The discussion has entered the phase of hair splitting. Good.

I don't know why we are adding an oil into the flames...

-- 
With Best Regards,
Andy Shevchenko


