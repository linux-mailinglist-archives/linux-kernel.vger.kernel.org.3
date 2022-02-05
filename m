Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E040E4AA8FB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 14:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379920AbiBENFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 08:05:31 -0500
Received: from mga03.intel.com ([134.134.136.65]:8073 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346507AbiBENF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 08:05:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644066328; x=1675602328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P8ih86m6G0IyyDLA73dvPC4Mr4i85BIOOZC9rN0gCSw=;
  b=WTQkS3qMbTkm+Qt1PmmEmNVZCcs1z1vSGuJRqN2tKBHqZAIYxC2fdj/v
   T4qLLwAOh8fxwnyVq49WdN3maHvSh63ophR5FgfBpnS7zdl1jfagjbUQO
   62gRi0npht6pwzNOFY9FRryRU/l8rkxFWU6sm6RBRcU11z8Tloa7GE5AW
   7qxgpPfTLRwJh/E0X828tSDbRxirL82egkfuUuDhFNg47+Po5PpRanjGI
   6FFjOi2QgT33tOWfdvCIPdy/s7Pr9++2y3TNUmuu8Lyclk3QPMIJ3ks08
   5fBK9hyNQzb5zCgPgfCmhVUqw3pf1m/Jztogpq+PONZvJ3/Qaj+ugPyNZ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="248459692"
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="248459692"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 05:05:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="567007845"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 05:05:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nGKjm-001GmE-8z;
        Sat, 05 Feb 2022 15:04:22 +0200
Date:   Sat, 5 Feb 2022 15:04:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 2/4] drm/tiny: Add driver for Solomon SSD130X OLED
 displays
Message-ID: <Yf511hhojzIXcNXp@smile.fi.intel.com>
References: <20220204134347.1187749-1-javierm@redhat.com>
 <20220204134347.1187749-3-javierm@redhat.com>
 <Yf03sCSuQwHKvgA9@smile.fi.intel.com>
 <d4e8c16c-5586-3233-0b99-be15a4c0f7aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4e8c16c-5586-3233-0b99-be15a4c0f7aa@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 08:19:12PM +0100, Javier Martinez Canillas wrote:
> On 2/4/22 15:26, Andy Shevchenko wrote:
> > On Fri, Feb 04, 2022 at 02:43:45PM +0100, Javier Martinez Canillas wrote:

...

> >> +struct ssd130x_device {
> >> +	struct drm_device drm;
> >> +	struct drm_simple_display_pipe pipe;
> >> +	struct drm_display_mode mode;
> >> +	struct drm_connector connector;
> > 
> > 
> >> +	struct i2c_client *client;
> > 
> > Can we logically separate hw protocol vs hw interface from day 1, please?
> > This will allow to add SPI support for this panel much easier.
> > 
> > Technically I would like to see here
> > 
> > 	struct device *dev;
> >
> > and probably (I haven't looked into design)
> > 
> > 	struct ssd130x_ops *ops;
> > 
> > or something alike.
> 
> Sure. I wanted to keep the driver simple, making the writes bus agnostic and
> adding a level of indirection would make it more complex. But I agree that
> it will also make easier to add more buses later. I will do that for v3.

I have SSD1306 display with SPI interface and I'm not able to test your series.
With the above it at least gives me a point to consider helping (coding and
testing)  with SPI one.

...

> >> +	if (!fb)
> >> +		return;
> > 
> > Can it happen?
> 
> I don't know, but saw that the handler of other drivers checked for this so
> preferred to play safe and do the same.

So, either cargo-cult or indeed it may happen. Somebody may conduct a research
on this...

...

> >> +	drm_mode_probed_add(connector, mode);
> >> +	drm_set_preferred_mode(connector, mode->hdisplay, mode->vdisplay);
> >> +
> >> +	return 1;
> > 
> > Positive code, what is the meaning of it?
> 
> It's the number of connector modes. The driver only supports 1.

A comment then?

-- 
With Best Regards,
Andy Shevchenko


