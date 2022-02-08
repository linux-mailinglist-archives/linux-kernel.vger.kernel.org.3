Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1695A4ADE8B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 17:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383484AbiBHQqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 11:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbiBHQp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 11:45:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88750C061576;
        Tue,  8 Feb 2022 08:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=kPMXXd6d9rnGjX69ktGIh5H3gUoF6mPBzgaLD0J5WWE=; b=DMbClZXJMFdvLYy1aodWs4Sqkg
        2eB8zSA3W0Zl9gjg22rBO+5vtKAUgnIoZfWHoe19xhqn8AvMfGgKLz7yVPSzgCabdhODC0Fr5lfh3
        81svV47f2bu6GHqDR8CW49ww8fA0Lzy9t/HeEh7QOgvteCyVNPGMCCr9t+BOUrc6wF60CviFBtz8T
        w1Q4kDskFQs0Zla8cW9CYTRGfhQjO7hSpSY+o6JqCi4Cs+yOTbL8I+krA857zUZgykGmpD2HZHDnk
        +LTxiiXtHQkdkkxAil6GT6xDhzXkkzN7yWMMbGVgtf0ZVv8H7GsNqK1JX8EsWBU+r9yDeZCGPK0t4
        +yZrffbw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHTci-0089v9-NB; Tue, 08 Feb 2022 16:45:49 +0000
Message-ID: <b5cf2337-770f-1834-dd37-2d0c579aa113@infradead.org>
Date:   Tue, 8 Feb 2022 08:45:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2] gpiolib: make struct comments into real kernel docs
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220208104831.308722-1-brgl@bgdev.pl>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220208104831.308722-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 2/8/22 02:48, Bartosz Golaszewski wrote:
> We have several comments that start with '/**' but don't conform to the
> kernel doc standard. Add proper detailed descriptions for the affected
> definitions and move the docs from the forward declarations to the
> struct definitions where applicable.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> v1 -> v2:
> - described fields not yet documented
> - added missing '@'
> - made using periods consistent
> - fixed struct references
> 
>  drivers/gpio/gpiolib.h        | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/gpio/consumer.h | 35 ++++++++++++++++-------------------
>  2 files changed, 50 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> index 30bc3f80f83e..40723a179902 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -37,6 +37,9 @@
>   * or name of the IP component in a System on Chip.
>   * @data: per-instance data assigned by the driver
>   * @list: links gpio_device:s together for traversal
> + * @notifier: used to notify subscribers about lines being requested, released
> + *            or reconfigured
> + * @pin_ranges: range of pins served by the GPIO driver
>   *
>   * This state container holds most of the runtime variable data
>   * for a GPIO device and can hold references and live on after the
> @@ -72,6 +75,20 @@ struct gpio_device {
>  /* gpio suffixes used for ACPI and device tree lookup */
>  static __maybe_unused const char * const gpio_suffixes[] = { "gpios", "gpio" };
>  
> +/**
> + * struct gpio_array - Opaque descriptor for a structure of GPIO array attributes
> + *
> + * @desc:		Array of pointers to the GPIO descriptors
> + * @size:		Number of elements in desc
> + * @chip:		Parent GPIO chip
> + * @get_mask:		Get mask used in fastpath
> + * @set_mask:		Set mask used in fastpath
> + * @invert_mask:	Invert mask used in fastpath
> + *
> + * This structure is attached to struct gpiod_descs obtained from

maybe
                                    &struct gpiod_descs

> + * gpiod_get_array() and can be passed back to get/set array functions in order
> + * to activate fast processing path if applicable.
> + */
>  struct gpio_array {
>  	struct gpio_desc	**desc;
>  	unsigned int		size;
> @@ -96,6 +113,23 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
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
> + * Contrary to integers, a pointer to a &struct gpio_desc is guaranteed to be
> + * valid until the GPIO is released.
> + */
>  struct gpio_desc {
>  	struct gpio_device	*gdev;
>  	unsigned long		flags;
> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> index 3ad67b4a72be..c3aa8b330e1c 100644
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
> + * @desc:	Array of pointers to GPIO descriptors
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
> + * @GPIOD_ASIS:			Don't change anything
> + * @GPIOD_IN:			Set lines to input mode
> + * @GPIOD_OUT_LOW:		Set lines to output and drive them low
> + * @GPIOD_OUT_HIGH:		Set lines to output and drive them high
> + * @GPIOD_OUT_LOW_OPEN_DRAIN:	Set lines to open-drain output and drive them low
> + * @GPIOD_OUT_HIGH_OPEN_DRAIN:	Set lines to open-drain output and drive them high
>   */
>  enum gpiod_flags {
>  	GPIOD_ASIS	= 0,


thanks.
-- 
~Randy
