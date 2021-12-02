Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C334666D4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245536AbhLBPmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:42:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:9631 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231841AbhLBPl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:41:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="235464298"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="235464298"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 07:38:37 -0800
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="677696731"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 07:38:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mso9M-001Qyw-DX;
        Thu, 02 Dec 2021 17:37:32 +0200
Date:   Thu, 2 Dec 2021 17:37:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Johan Hovold <johan@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] gpiolib: check the 'ngpios' property in core
 gpiolib code
Message-ID: <YajoPEgfTvuvjqG/@smile.fi.intel.com>
References: <20211202134034.14048-1-brgl@bgdev.pl>
 <20211202134034.14048-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202134034.14048-2-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 02:40:34PM +0100, Bartosz Golaszewski wrote:
> Several drivers read the 'ngpios' device property on their own, but
> since it's defined as a standard GPIO property in the device tree bindings
> anyway, it's a good candidate for generalization. If the driver didn't
> set its gc->ngpio, try to read the 'ngpios' property from the GPIO
> device's firmware node before bailing out.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
One nit-pick below (you may amend it when applying)

> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> v1 -> v2:
> - use device_property_read_u32() instead of fwnode_property_read_u32()
> - reverse the error check logic
> 
> v2 -> v3:
> - don't shadow errors other than -ENODATA in device_property_read_u32()
> 
> v3 -> v4:
> - also make sure we return -EINVAL when the device 'ngpios' property is
>   set to 0 (thanks Andy!)
> 
>  drivers/gpio/gpiolib.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index ede8b8a7aa18..bd9b8cb53476 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -599,6 +599,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  	int base = gc->base;
>  	unsigned int i;
>  	int ret = 0;
> +	u32 ngpios;
>  
>  	/*
>  	 * First: allocate and populate the internal stat container, and
> @@ -646,6 +647,26 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>  		goto err_free_dev_name;
>  	}
>  
> +	/*
> +	 * Try the device properties if the driver didn't supply the number
> +	 * of GPIO lines.
> +	 */
> +	if (gc->ngpio == 0) {
> +		ret = device_property_read_u32(&gdev->dev, "ngpios", &ngpios);
> +		if (ret == -ENODATA)
> +			/*
> +			 * -ENODATA means that there is no property found and
> +			 * we want to issue the error message to the user.
> +			 * Besides that, we want to return different error code
> +			 * to state that supplied value is not valid.

> +			 * */

First '* ' is not needed.

> +			ngpios = 0;
> +		else if (ret)
> +			goto err_free_descs;
> +
> +		gc->ngpio = ngpios;
> +	}
> +
>  	if (gc->ngpio == 0) {
>  		chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
>  		ret = -EINVAL;
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


