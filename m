Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0651E4B245C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349498AbiBKLfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:35:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbiBKLfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:35:01 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E0EE76;
        Fri, 11 Feb 2022 03:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644579301; x=1676115301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ta83snNi9vzAwFFKvrm3a20yLtYu4gS2g5TL8vXcfj4=;
  b=BRQDU42vhDGS5xctnb1zLn98/7uH9e7tnusZOQ7F9KjxzWaU2nwtJRUC
   xo6jrkM7GB6yXL8XYYsDi4YAceMVmxRcDAh6mcABtj2X03Ev0ch7nHEGM
   KJABKbSUMUX4/y9tsH6B9Fvcm89Mp2p2E5RAooJMPpAI5ftrwHg9M+J+8
   9726Jrtt/ApRhXakiGOzw+3PH7Dlpjo0/lxO/j0RUhDvEP4uD/VQqQmZO
   HvMhRDAJO2WvewAz+hiBlTVjbO7T6TDW4nIPuTnivJrOjYxnY7A6hfxpo
   x58gOY0DWdTjBVS49Bh+DSK7S23UCsg/aNY+f9YAzAifI+oXYTcEllFBa
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="336138185"
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="336138185"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 03:35:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,360,1635231600"; 
   d="scan'208";a="623197161"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 03:34:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nIUBa-003QNQ-Nz;
        Fri, 11 Feb 2022 13:33:58 +0200
Date:   Fri, 11 Feb 2022 13:33:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 3/6] drm: Add driver for Solomon SSD130x OLED displays
Message-ID: <YgZJpi4llqr93U9Y@smile.fi.intel.com>
References: <20220211091927.2988283-1-javierm@redhat.com>
 <20220211091927.2988283-4-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211091927.2988283-4-javierm@redhat.com>
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

On Fri, Feb 11, 2022 at 10:19:24AM +0100, Javier Martinez Canillas wrote:
> This adds a DRM driver for SSD1305, SSD1306, SSD1307 and SSD1309 Solomon
> OLED display controllers.
> 
> It's only the core part of the driver and a bus specific driver is needed
> for each transport interface supported by the display controllers.

...

> +#include <linux/backlight.h>
> +#include <linux/bitfield.h>

bits.h
(FYI, specifically sent a patch few days ago to add explicitly the inclusions
 that needed for bitfield operations in the example inside bitfield.h).

> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/property.h>
> +#include <linux/pwm.h>
> +#include <linux/regulator/consumer.h>

...

> +#define SSD130X_SET_ADDRESS_MODE_HORIZONTAL	(0x00)
> +#define SSD130X_SET_ADDRESS_MODE_VERTICAL	(0x01)
> +#define SSD130X_SET_ADDRESS_MODE_PAGE		(0x02)
> +
> +#define SSD130X_SET_AREA_COLOR_MODE_ENABLE	(0x1e)
> +#define SSD130X_SET_AREA_COLOR_MODE_LOW_POWER	(0x05)

Do the parentheses add anything here?

...

> +/*
> + * Helper to write command (SSD130X_COMMAND). The fist variadic argument
> + * is the command to write and the following are the command options.

This is not correct explanation. Please, rephrase to show that _each_ of the
options is sent with a preceding command.

> + */
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

> +	if (ssd130x->device_info->need_pwm) {

Yeah, unfortunately we still don't have pwm_get_optional()...

> +		ret = ssd130x_pwm_enable(ssd130x);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable PWM: %d\n", ret);
> +			regulator_disable(ssd130x->vcc_reg);
> +			return ret;
> +		}
> +	}

...

> +static void ssd130x_power_off(struct ssd130x_device *ssd130x)
> +{

> +	if (ssd130x->device_info->need_pwm) {

Redundant check. The two below are NULL-aware.

> +		pwm_disable(ssd130x->pwm);
> +		pwm_put(ssd130x->pwm);
> +	}
> +
> +	regulator_disable(ssd130x->vcc_reg);
> +}

...

> +	ret = ssd130x_write_cmd(ssd130x, 2, SSD130X_SET_COM_PINS_CONFIG, compins);
> +	if (ret < 0)
> +		return ret;

> +
> +

One blank line is enough.

...

> +	for (i = y / 8; i < y / 8 + pages; i++) {
> +		int m = 8;
> +
> +		/* Last page may be partial */
> +		if (8 * (i + 1) > ssd130x->height)
> +			m = ssd130x->height % 8;

Perhaps it can be moved out of the loop with refactored piece below.

> +		for (j = x; j < x + width; j++) {
> +			u8 data = 0;
> +
> +			for (k = 0; k < m; k++) {
> +				u8 byte = buf[(8 * i + k) * line_length + j / 8];
> +				u8 bit = (byte >> (j % 8)) & 1;
> +
> +				data |= bit << k;
> +			}
> +			data_array[array_idx++] = data;
> +		}
> +	}

...

> +	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ssd130x,
> +					    &ssd130xfb_bl_ops, NULL);
> +	if (IS_ERR(bl)) {

> +		ret = PTR_ERR(bl);
> +		dev_err_probe(dev, ret, "Unable to register backlight device\n");
> +		return ERR_PTR(ret);

		dev_err_probe(dev, PTR_ERR(bl), "Unable to register backlight device\n");
		return bl;

?

> +	}

-- 
With Best Regards,
Andy Shevchenko


