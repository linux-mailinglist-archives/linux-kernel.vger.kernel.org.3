Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21504A762A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 17:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346002AbiBBQrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 11:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiBBQr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 11:47:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B56C061714;
        Wed,  2 Feb 2022 08:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=6wN7Hkny+8K2qW71HdC4CGXNu9XZ2OwdgpzfkPahWuY=; b=PZ8XudiVZYfUG1QEBKsEGl6zJ/
        LaHUXymjzEsrH5WX/nFmbS8CZSBvChYUXra1pnp00Y1D5MEDhgcC9zHfYLF4VOjd3yacjceuK3yH1
        QjioW+L/wdP76MyR6OijJ2sNKlbpVga+hPgCZVpQN/h96Db54YKtooK8vwO/CDERLcAwgvp2b6NnO
        mxzAvr+ksO/MAj+ViJdCN5eZjLpoM0hqwj6tZEFrtZnX3Jxau/1owWFRki9HM+9Q03o1Z+XmNRUr8
        mhgN8tV8GgurI8Z90PqLooEmAdwtGYXEt8wddrg1s9Tb6yO47g9zz3OBXaDKn7tFq9dbCqNmRWZjv
        v2xxy9yQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nFIn0-00FF2Z-47; Wed, 02 Feb 2022 16:47:26 +0000
Message-ID: <1f16dc62-1b47-cf8a-6712-e0a407c83caa@infradead.org>
Date:   Wed, 2 Feb 2022 08:47:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] gpiolib: make struct comments into real kernel docs
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220202104937.146827-1-brgl@bgdev.pl>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220202104937.146827-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/22 02:49, Bartosz Golaszewski wrote:
> We have several comments that start with '/**' but don't conform to the
> kernel doc standard. Add proper detailed descriptions for the affected
> definitions and move the docs from the forward declarations to the
> struct definitions where applicable.
> 
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
> + * @desc:		Array of pointers to the GPIO descriptors
> + * @size:		Number of elements in desc
> + * @chip:		Parent GPIO chip
> + * @get_mask:		Get mask used in fastpath.
> + * @set_mask:		Set mask used in fastpath.
> + * @invert_mask:	Invert mask used in fastpath.
> + *
> + * This structure is attached to struct gpiod_descs obtained from
> + * gpiod_get_array() and can be passed back to get/set array functions in order
> + * to activate fast processing path if applicable.
> + */

scripts/kernel-doc says:

gpiolib.h:70: warning: Function parameter or member 'notifier' not described in 'gpio_device'
gpiolib.h:70: warning: Function parameter or member 'pin_ranges' not described in 'gpio_device'
2 warnings

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

consumer.h:26: warning: Function parameter or member 'desc' not described in 'gpio_descs'

as Andy pointed out.
Several of Andy's kernel-doc notation suggestions also look good.


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
> + * @GPIOD_IN:			Set lines to input mode
> + * @GPIOD_OUT_LOW:		Set lines to output and drive them low
> + * @GPIOD_OUT_HIGH:		Set lines to output and drive them high
> + * @GPIOD_OUT_LOW_OPEN_DRAIN:	Set lines to open-drain output and drive them low
> + * @GPIOD_OUT_HIGH_OPEN_DRAIN:	Set lines to open-drain output and drive them high
>   */
>  enum gpiod_flags {
>  	GPIOD_ASIS	= 0,

-- 
~Randy
