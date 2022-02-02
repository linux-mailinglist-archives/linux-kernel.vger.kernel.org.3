Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5CA4A6FCF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343867AbiBBLTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:19:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:1948 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230163AbiBBLTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643800791; x=1675336791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SCEv/Wglia+T7mU/w1Yp9MF6QWS6lSICLKOjH2+nPqI=;
  b=ddJmN/rwYeR9Rvlpgo8giJlrsCb7coU0OPn6Rg6EYk3DyLmCiXuPB9+6
   WnB4zGutkotXgxo3iCcbBohRw7IzDAxUfCPn3YEMg1nfi2r90olJrVoXz
   mkQFzrp4AV1vMdtLUqNUFUbbjGCBEbJG4VTb+lHvqIZcO6Grnh7fLF+nh
   Ac8kybLei2k6eCByV7495Gs0Yae9m/BwtOZU6pxDqoIpuZkDjQnoemV7w
   dqySuE2k5ElQotZibnLI1/ED3KxJjQlOuS2hQGC3w9SlmmoqCjz6irzCD
   GO+QM9rDce2/hQ1mDydGuQOjK2vzJLJ+pNcuCVlKaUoV3PwQPVIks/ZG6
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="227863392"
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="227863392"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 03:19:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="599524678"
Received: from smile.fi.intel.com ([10.237.72.61])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 03:19:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nFDey-0003Zy-Iq;
        Wed, 02 Feb 2022 13:18:48 +0200
Date:   Wed, 2 Feb 2022 13:18:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: make struct comments into real kernel docs
Message-ID: <YfpomMEgiTh8kjGJ@smile.fi.intel.com>
References: <20220202104937.146827-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202104937.146827-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2022 at 11:49:37AM +0100, Bartosz Golaszewski wrote:
> We have several comments that start with '/**' but don't conform to the
> kernel doc standard. Add proper detailed descriptions for the affected
> definitions and move the docs from the forward declarations to the
> struct definitions where applicable.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

A few comments below.

> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> ---
>  drivers/gpio/gpiolib.h        | 31 +++++++++++++++++++++++++++++++
>  include/linux/gpio/consumer.h | 35 ++++++++++++++++-------------------
>  2 files changed, 47 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> index 30bc3f80f83e..0025701b7641 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -72,6 +72,20 @@ struct gpio_device {
>  /* gpio suffixes used for ACPI and device tree lookup */
>  static __maybe_unused const char * const gpio_suffixes[] = { "gpios", "gpio" };
>  
> +/**
> + * struct gpio_array - Opaque descriptor for a structure of GPIO array attributes

> + *

I dunno we need these blank lines.

> + * @desc:		Array of pointers to the GPIO descriptors
> + * @size:		Number of elements in desc

  in @desc

or

  in the array of the descriptor pointers

> + * @chip:		Parent GPIO chip
> + * @get_mask:		Get mask used in fastpath.
> + * @set_mask:		Set mask used in fastpath.
> + * @invert_mask:	Invert mask used in fastpath.

Why some of the descriptions are with grammar period and some w/o?

> + *
> + * This structure is attached to struct gpiod_descs obtained from
> + * gpiod_get_array() and can be passed back to get/set array functions in order
> + * to activate fast processing path if applicable.
> + */
>  struct gpio_array {
>  	struct gpio_desc	**desc;
>  	unsigned int		size;
> @@ -96,6 +110,23 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
>  extern spinlock_t gpio_lock;
>  extern struct list_head gpio_devices;
>  
> +
> +/**
> + * struct gpio_desc - Opaque descriptor for a GPIO
> + *
> + * @gdev:		Pointer to the parent GPIO device
> + * @flags:		Binary descriptor flags
> + * @label:		Name of the consumer
> + * @name:		Line name
> + * @hog:		Pointer to the device node that hogs this line (if any)
> + * @debounce_period_us:	Debounce period in microseconds
> + *
> + * These are obtained using gpiod_get() and are preferable to the old
> + * integer-based handles.
> + *
> + * Contrary to integers, a pointer to a gpio_desc is guaranteed to be valid

&struct gpio_desc

> + * until the GPIO is released.
> + */
>  struct gpio_desc {
>  	struct gpio_device	*gdev;
>  	unsigned long		flags;
> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> index 3ad67b4a72be..3ffb054fafbd 100644
> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h
> @@ -8,27 +8,16 @@
>  #include <linux/err.h>
>  
>  struct device;
> -
> -/**
> - * Opaque descriptor for a GPIO. These are obtained using gpiod_get() and are
> - * preferable to the old integer-based handles.
> - *
> - * Contrary to integers, a pointer to a gpio_desc is guaranteed to be valid
> - * until the GPIO is released.
> - */
>  struct gpio_desc;
> -
> -/**
> - * Opaque descriptor for a structure of GPIO array attributes.  This structure
> - * is attached to struct gpiod_descs obtained from gpiod_get_array() and can be
> - * passed back to get/set array functions in order to activate fast processing
> - * path if applicable.
> - */
>  struct gpio_array;
>  
>  /**
> - * Struct containing an array of descriptors that can be obtained using
> - * gpiod_get_array().
> + * struct gpio_descs - Struct containing an array of descriptors that can be
> + *                     obtained using gpiod_get_array()
> + *
> + * @info:	Pointer to the opaque gpio_array structure
> + * @ndescs:	Number of held descriptors
> + * desc:	Array of pointers to GPIO descriptors

Missed @?

>   */
>  struct gpio_descs {
>  	struct gpio_array *info;
> @@ -43,8 +32,16 @@ struct gpio_descs {
>  #define GPIOD_FLAGS_BIT_NONEXCLUSIVE	BIT(4)
>  
>  /**
> - * Optional flags that can be passed to one of gpiod_* to configure direction
> - * and output value. These values cannot be OR'd.
> + * enum gpiod_flags - Optional flags that can be passed to one of gpiod_* to
> + *                    configure direction and output value. These values
> + *                    cannot be OR'd.
> + *
> + * @GPIOD_ASIS:			Don't change the direction

Don't change anything

(Not only direction, also the output value. Some hardware allows to change
output buffer value even if the line is configured as input).

> + * @GPIOD_IN:			Set lines to input mode
> + * @GPIOD_OUT_LOW:		Set lines to output and drive them low
> + * @GPIOD_OUT_HIGH:		Set lines to output and drive them high
> + * @GPIOD_OUT_LOW_OPEN_DRAIN:	Set lines to open-drain output and drive them low
> + * @GPIOD_OUT_HIGH_OPEN_DRAIN:	Set lines to open-drain output and drive them high
>   */
>  enum gpiod_flags {
>  	GPIOD_ASIS	= 0,
> -- 
> 2.30.1
> 

-- 
With Best Regards,
Andy Shevchenko


