Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542194B29EE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 17:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350757AbiBKQOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 11:14:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350602AbiBKQOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:14:16 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9DF2D4F;
        Fri, 11 Feb 2022 08:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644596055; x=1676132055;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2sObmrIIJ6u7JgxEqMuhXgNJQeFbV1/jHHnxLE325BM=;
  b=Ho2Z1vLaSXw9C3ZYUNKHXqJ949xAeGMTE5ncjC6IO5sRzALyGeeNaGBa
   9M8FL6SQmLdhRgLXrg8LSrWh7jlrcbMMBlpppKiSmEBQmI8eIBvDTL4PG
   jkrGDS35uv1yF8Me5sfSd9GTC/MvJQwD5I0QFH6WgqcDFrSxpYFhHBSLU
   hpNXwzhWn5Ylim4qjpNHfCMkRl4HRlu0W40f48seWA40EkZPmrv85ttKR
   7+NsFcznypY5cG2plQar28tFA5zytFpsSIrWYqzG/9jxtwRsrdp1PEG/W
   71crS0SqP11Jedr3xCbjyYR1/r6ZZv/PgJoHZ7m984VBWAJTOeybg+axd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="230400142"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="230400142"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:14:15 -0800
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="483479902"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 08:14:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nIYXo-003V6e-FM;
        Fri, 11 Feb 2022 18:13:12 +0200
Date:   Fri, 11 Feb 2022 18:13:12 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v5 3/6] drm: Add driver for Solomon SSD130x OLED displays
Message-ID: <YgaLGDVscXlANxcZ@smile.fi.intel.com>
References: <20220211143358.3112958-1-javierm@redhat.com>
 <20220211143358.3112958-4-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211143358.3112958-4-javierm@redhat.com>
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

On Fri, Feb 11, 2022 at 03:33:55PM +0100, Javier Martinez Canillas wrote:
> This adds a DRM driver for SSD1305, SSD1306, SSD1307 and SSD1309 Solomon
> OLED display controllers.
> 
> It's only the core part of the driver and a bus specific driver is needed
> for each transport interface supported by the display controllers.

...

> +#define SSD130X_SET_CLOCK_DIV_MASK		GENMASK(3, 0)
> +#define SSD130X_SET_CLOCK_DIV_SET(val)		FIELD_PREP(SSD130X_SET_CLOCK_DIV_MASK, (val))
> +#define SSD130X_SET_CLOCK_FREQ_MASK		GENMASK(7, 4)
> +#define SSD130X_SET_CLOCK_FREQ_SET(val)		FIELD_PREP(SSD130X_SET_CLOCK_FREQ_MASK, (val))
> +#define SSD130X_SET_PRECHARGE_PERIOD1_MASK	GENMASK(3, 0)
> +#define SSD130X_SET_PRECHARGE_PERIOD1_SET(val)	FIELD_PREP(SSD130X_SET_PRECHARGE_PERIOD1_MASK, (val))
> +#define SSD130X_SET_PRECHARGE_PERIOD2_MASK	GENMASK(7, 4)
> +#define SSD130X_SET_PRECHARGE_PERIOD2_SET(val)	FIELD_PREP(SSD130X_SET_PRECHARGE_PERIOD2_MASK, (val))

> +#define SSD130X_SET_COM_PINS_CONFIG1_MASK	GENMASK(4, 4)

BIT(4)

> +#define SSD130X_SET_COM_PINS_CONFIG1_SET(val)	FIELD_PREP(SSD130X_SET_COM_PINS_CONFIG1_MASK, (!val))
> +#define SSD130X_SET_COM_PINS_CONFIG2_MASK	GENMASK(5, 5)

BIT(5)

> +#define SSD130X_SET_COM_PINS_CONFIG2_SET(val)	FIELD_PREP(SSD130X_SET_COM_PINS_CONFIG2_MASK, (val))

I would put GENMASK() directly into FIELD(), but it's up to you
(and I haven't checked the use of *_MASK anyway).


...

> +static int ssd130x_write_data(struct ssd130x_device *ssd130x, u8 *values, int count)
> +{
> +	int ret;
> +
> +	ret = regmap_bulk_write(ssd130x->regmap, SSD130X_DATA, values, count);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

return regmap_bulk_write(...);

> +}

...

> +/*
> + * Helper to write command (SSD130X_COMMAND). The fist variadic argument
> + * is the command to write and the following are the command options.
> + *
> + * Note that the ssd130x protocol requires each command and option to be
> + * written as a SSD130X_COMMAND device register value. That is why a call
> + * to regmap_write(..., SSD130X_COMMAND, ...) is done for each argument.
> + */

Thanks!

> +static int ssd130x_write_cmd(struct ssd130x_device *ssd130x, int count,
> +				    /* u8 cmd, u8 option, ... */...)
> +{
> +	va_list ap;
> +	u8 value;
> +	int ret;
> +
> +	va_start(ap, count);
> +
> +	do {
> +		value = va_arg(ap, int);
> +		ret = regmap_write(ssd130x->regmap, SSD130X_COMMAND, (u8)value);

Wondering if you really need this casting. value is u8 by definition.

> +		if (ret)
> +			goto out_end;
> +	} while (--count);
> +
> +out_end:
> +	va_end(ap);
> +
> +	return ret;
> +}

...

> +	ssd130x = devm_drm_dev_alloc(dev, &ssd130x_drm_driver,
> +				     struct ssd130x_device, drm);
> +	if (IS_ERR(ssd130x)) {

> +		dev_err_probe(dev, PTR_ERR(ssd130x),
> +			      "Failed to allocate DRM device\n");
> +		return ssd130x;

This...

> +	}

...

> +	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ssd130x,
> +					    &ssd130xfb_bl_ops, NULL);
> +	if (IS_ERR(bl))
> +		return ERR_PTR(dev_err_probe(dev, PTR_ERR(bl),
> +					     "Unable to register backlight device\n"));

Can be consistent with this then.

-- 
With Best Regards,
Andy Shevchenko


