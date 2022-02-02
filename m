Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029ED4A70A6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbiBBMWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 07:22:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:10273 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239210AbiBBMWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643804571; x=1675340571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eamKrK/VTEauZLd9AACZ72hNNHTYn1T5iAicwAio230=;
  b=GITnRpK9130xyXR6PtzxXp7wj6RFv50b3RAkAaZOcL1v3pFF+fShFric
   0l2OYxF+aAz2nH+99lsivsxxoEgLP2Q1DiQaU2y7y4tJvNwtjbjcb6Q/a
   0H9OBIWFK+XOoZOX0bNEOoZTP6YORBFrBRbyy3L6HOHKRxJxCdMUqw/6g
   9KuZ9ICNQUs7UpLNTQQrK21+8yyIAXxETWDwNe+gZ7YFD6eFen0OTnv/j
   sJMlhvB5YCWWK9AaHHzoeCUaSfea6UoWcuIpARd9SHs8J8jxaigWgzo6a
   YeR6p3mOy+Up+tfkawlThqfl+l5B6tFNHSmM7eWjm6tdKFVWWc52zBltg
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="308633227"
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="308633227"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 04:22:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="565970219"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 04:22:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nFEds-0004d4-Dd;
        Wed, 02 Feb 2022 14:21:44 +0200
Date:   Wed, 2 Feb 2022 14:21:44 +0200
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
Message-ID: <Yfp3WL8JMlSP19MI@smile.fi.intel.com>
References: <CAMuHMdVP6ER119r2KAegjZes1a=KWZ47z6j=kgQ0oNx1oeUJ+w@mail.gmail.com>
 <51f54519-bb8b-f108-1c1e-4fed101ca5ef@redhat.com>
 <CAMuHMdVwUfv7pXhPazsgG6t=X=aVtDQkFUk_=mUuFH8Fscx8wg@mail.gmail.com>
 <abf63995-a529-1e80-18c3-df473a3e7a9c@redhat.com>
 <YfmaqUBqCrgp0QdO@ravnborg.org>
 <e552caec-5136-f4b2-12dc-23b182ab8af6@redhat.com>
 <YfploeCM6C5y3Imj@smile.fi.intel.com>
 <2f149fef-b991-9e34-98cb-426e561192ff@redhat.com>
 <YfpwGtjj5hGkN7A4@smile.fi.intel.com>
 <a3a06362-ab9f-e29b-4f03-968e3f1865ba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3a06362-ab9f-e29b-4f03-968e3f1865ba@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 12:54:32PM +0100, Javier Martinez Canillas wrote:
> On 2/2/22 12:50, Andy Shevchenko wrote:
> >> What's your suggestion then to solve the issue mentioned above ? With my distro
> >> maintainer hat I don't care that much, since the fbdev drivers will be disabled.
> > 
> > I think both of them can work together. If user doesn't care, the first one wins.
> 
> I don't think this is a good idea but as mentioned I don't really care that much
> since we will disable all fbdev drivers anyway. So I'm happy to allow them both.

Thanks!

-- 
With Best Regards,
Andy Shevchenko


