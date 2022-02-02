Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BEE4A6F93
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239252AbiBBLHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:07:17 -0500
Received: from mga18.intel.com ([134.134.136.126]:37287 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229552AbiBBLHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643800036; x=1675336036;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IUN0B8wCPrd5whIz0ndsi5oEOD4UtnfCc7PBqv0ehBQ=;
  b=hk9vZF99v6mtiQwvlMA8+YqtMVmu29mppypR1dXcDry4bN/fHIK8J5Z+
   FlEKlW/rqe5dWukGyYGaL5RDsgLTSK3FyiAqNqUSjkqfy7K+tOpw95NKL
   IKfhkd02lByzI0tsZpBeOrMor9ErilyMHmVNOr1cRUFhEZw5AZmCyiGEu
   vxAQtCYjFC645bwmntrjwzAbnbT+sQDCi7Y5bw25wIbZCfq08ovGA7Dlw
   0onufqzJmRRP1seaR3/mB5TCdvs6OMWo6KWZz8vZRZe0BfIgjqhrZh4UJ
   qa5eOC3qhkMgL1/UH3SZ2wgLv0Pxzwuy9AzLW75BMb5M/VmWbSaLjfqr3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="231463039"
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="231463039"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 03:07:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="676400854"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 03:07:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nFDSj-0003No-Bi;
        Wed, 02 Feb 2022 13:06:09 +0200
Date:   Wed, 2 Feb 2022 13:06:09 +0200
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
Message-ID: <YfploeCM6C5y3Imj@smile.fi.intel.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <YfhM97cVH3+lJKg0@ravnborg.org>
 <Yfj/XGRRDNABsLPm@smile.fi.intel.com>
 <f8d71acb-5c8b-ac4e-0c32-38eb66af04c3@redhat.com>
 <CAMuHMdVP6ER119r2KAegjZes1a=KWZ47z6j=kgQ0oNx1oeUJ+w@mail.gmail.com>
 <51f54519-bb8b-f108-1c1e-4fed101ca5ef@redhat.com>
 <CAMuHMdVwUfv7pXhPazsgG6t=X=aVtDQkFUk_=mUuFH8Fscx8wg@mail.gmail.com>
 <abf63995-a529-1e80-18c3-df473a3e7a9c@redhat.com>
 <YfmaqUBqCrgp0QdO@ravnborg.org>
 <e552caec-5136-f4b2-12dc-23b182ab8af6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e552caec-5136-f4b2-12dc-23b182ab8af6@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 09:38:51AM +0100, Javier Martinez Canillas wrote:
> On 2/1/22 21:40, Sam Ravnborg wrote:

...

> Peter Robinson suggested to
> make the driver mutually exclusive and add !FB_SSD1307 in the config symbol.

And how will distros choose "the right" option in this case?
What to do when I wan to see a regression and I want to change drivers w/o
recompilation?

NAK from me to that proposal.

-- 
With Best Regards,
Andy Shevchenko


