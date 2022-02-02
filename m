Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB36A4A7055
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344009AbiBBLv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:51:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:12343 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231839AbiBBLv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:51:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643802717; x=1675338717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TaSayFeG3Tla1Ek3mItiUJbCMOq53RsNaYSQFDxfn/k=;
  b=XEd2Vi8y53xyze+5SKvzvyMb2fb6q2V6tKsrK3utoKrouitoCoNq6h0F
   c/nHEqA/s3DFAnC+FS6oEbmE2BUqJbc3e5QGNk81bIZRh4412K8pO2Mh9
   sbiucSpW7j05I5LLLO3Z+T5E3CPZfZvcOUQzP/j+UbjNOzVtF2PLcaq7s
   USObwo3YJUxLFdV5ladsJm4NKtSVodJhg3lmoj71hd2xFK+Rq8b5zp/L8
   9xCfSwsTah5mSbNRn1cxDtI98D5+oxbnK8pcF1YxlPPSCm2WjRtEcr3no
   YVnLXraQwIlzg5vW2nLsFaxZix0bq1ZWV4USIQePYpU5tQmiapQkjJ7+z
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="235296798"
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="235296798"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 03:51:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="620124007"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 03:51:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nFE9y-00041p-Fe;
        Wed, 02 Feb 2022 13:50:50 +0200
Date:   Wed, 2 Feb 2022 13:50:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Message-ID: <YfpwGtjj5hGkN7A4@smile.fi.intel.com>
References: <Yfj/XGRRDNABsLPm@smile.fi.intel.com>
 <f8d71acb-5c8b-ac4e-0c32-38eb66af04c3@redhat.com>
 <CAMuHMdVP6ER119r2KAegjZes1a=KWZ47z6j=kgQ0oNx1oeUJ+w@mail.gmail.com>
 <51f54519-bb8b-f108-1c1e-4fed101ca5ef@redhat.com>
 <CAMuHMdVwUfv7pXhPazsgG6t=X=aVtDQkFUk_=mUuFH8Fscx8wg@mail.gmail.com>
 <abf63995-a529-1e80-18c3-df473a3e7a9c@redhat.com>
 <YfmaqUBqCrgp0QdO@ravnborg.org>
 <e552caec-5136-f4b2-12dc-23b182ab8af6@redhat.com>
 <YfploeCM6C5y3Imj@smile.fi.intel.com>
 <2f149fef-b991-9e34-98cb-426e561192ff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f149fef-b991-9e34-98cb-426e561192ff@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 12:39:29PM +0100, Javier Martinez Canillas wrote:
> On 2/2/22 12:06, Andy Shevchenko wrote:
> > On Wed, Feb 02, 2022 at 09:38:51AM +0100, Javier Martinez Canillas wrote:
> >> On 2/1/22 21:40, Sam Ravnborg wrote:

> > And how will distros choose "the right" option in this case?
> 
> It depends on the distro. In Fedora we are disabling *all* the fbdev drivers.

Yes, and Distro A will think about old driver (because they have customers and
don't want to have a bad user experience) and Distro F will choose a new one.


> > What to do when I wan to see a regression and I want to change drivers w/o
> > recompilation?
> 
> If you want to have the two drivers without recompilation (and same compatible
> to match) then how would kmod / udev choose which one to load ? It becomes a
> race condition between the two drivers which one probes first.

We have a long history in kernel where new drivers came and old faded.
When two or more drivers of the same feature is enabled in the kernel
we may use modprobe facilities to prioritize them (blacklisting).

> > NAK from me to that proposal.
> 
> What's your suggestion then to solve the issue mentioned above ? With my distro
> maintainer hat I don't care that much, since the fbdev drivers will be disabled.

I think both of them can work together. If user doesn't care, the first one wins.

-- 
With Best Regards,
Andy Shevchenko


