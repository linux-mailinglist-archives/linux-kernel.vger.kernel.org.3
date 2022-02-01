Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894614A5958
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbiBAJim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 04:38:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:39147 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234230AbiBAJil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643708321; x=1675244321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v3bwci/IZNUC13Df1rGNpVJ3VxQmJjDUPftTWX/BcSA=;
  b=G/Zia9t7o73BaYYOjSUpQDG1Cbpot4IVTD8/y/dwMNNuCIdfLQoyeG/8
   heIU88gow6vzqXv8ggjXvpIj6iFvTm56X0nICYMsrmATSEyWPya5/rvBP
   7gT9ZXyTZcTV3d9KPIQdwVIcauixH/BNNvsEZGEPvZhZaE+x/vyppuazr
   ueTjClCZntpzfjFzzWJ+H3zkazqJ0EOTYwBREtaQha3IJDVYR0JyQuVeq
   2bzpZmCy1IFwazsJuo+VsuGLnMwdQTuCGckQPMg1cPPk2GIJ+QQDd8Je1
   LWe8TMG3UCIhH2kIXjvClvgKi9YHRUclTwwsWrENN4s0HZ5AzthQM1dBv
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247873037"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="247873037"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 01:38:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="565540154"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 01:38:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nEpbR-00HFPS-0n;
        Tue, 01 Feb 2022 11:37:33 +0200
Date:   Tue, 1 Feb 2022 11:37:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED
 displays
Message-ID: <Yfj/XGRRDNABsLPm@smile.fi.intel.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <YfhM97cVH3+lJKg0@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfhM97cVH3+lJKg0@ravnborg.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 09:56:23PM +0100, Sam Ravnborg wrote:
> On Mon, Jan 31, 2022 at 09:12:20PM +0100, Javier Martinez Canillas wrote:

...

> > Patch #3 adds the driver. The name ssd1307 was used instead of ssd130x
> > (which would be more accurate) to avoid confusion for users who want to
> > migrate from the existing ssd1307fb fbdev driver.
> Looking forward the name ssd130x would make more sense. There is only so
> many existing users and a potential of much more new users.
> So in my color of the world the naming that benefits the most users
> wins.

It depends if the binding is going to be preserved. Also this series doesn't
answer to the question what to do with the old driver.

If you leave it, I would expect the backward compatibility, otherwise the
series misses removal of the old driver.

-- 
With Best Regards,
Andy Shevchenko


