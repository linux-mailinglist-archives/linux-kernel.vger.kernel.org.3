Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CC74AAA9E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 18:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbiBERcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 12:32:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55142 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiBERcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:32:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFE786113A;
        Sat,  5 Feb 2022 17:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A73C340E8;
        Sat,  5 Feb 2022 17:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644082343;
        bh=6CBARJ0ewgYzThnsUO5kNg3xJ7ZPiP6tCgQlpGxZ+EQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bYQQTMiVoZUQXtr0E0XPIrmuOVRbNX8jQ+EBqWjfgF1Ozd8G3pQ/MELO6GBgpA/6E
         7a8iFMLnQ6XHb0MZ1n+RDX5r8FMHvwq0WoN+4SwlFvruPBsfOzERLNDC0c074XsWB8
         vxGpfp4nHrGgEKbCTJODAwA3OhhTbqiHFYDzWqn8SfstpmkM4XDlUi4oi5SJkMKwhK
         YPXrNajzrQLCOuFHtZEgjCONoi73kESkZxcWwqnUh9D6pZ7gPg1x3xPkP9QQVpdZJv
         E67anE8gkFy/6bhAAe3ekbKoFz/mfx6e0wrw9aCz3+8WV/UQrpJ4llBSsO7BhtTUsP
         +eeFzTDb03TFg==
Date:   Sat, 5 Feb 2022 17:38:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v2 1/1] iio: multiplexer: Make use of device properties
Message-ID: <20220205173854.14a7aca0@jic23-huawei>
In-Reply-To: <20220202204427.57506-1-andriy.shevchenko@linux.intel.com>
References: <20220202204427.57506-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Feb 2022 22:44:27 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Looks good to me, but as it's complex I'd like Peter + anyone else interested
to have a bit more time to take a look before I apply this one.

Thanks,

Jonathan

> ---
> v2: dropped depends on OF
>  drivers/iio/multiplexer/Kconfig   |  1 -
>  drivers/iio/multiplexer/iio-mux.c | 48 ++++++++++++++-----------------
>  2 files changed, 22 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iio/multiplexer/Kconfig b/drivers/iio/multiplexer/Kconfig
> index a1e1332d1206..928f424a1ed3 100644
> --- a/drivers/iio/multiplexer/Kconfig
> +++ b/drivers/iio/multiplexer/Kconfig
> @@ -9,7 +9,6 @@ menu "Multiplexers"
>  config IIO_MUX
>  	tristate "IIO multiplexer driver"
>  	select MULTIPLEXER
> -	depends on OF || COMPILE_TEST
>  	help
>  	  Say yes here to build support for the IIO multiplexer.
>  
> diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
> index f422d44377df..e6f0fef96494 100644
> --- a/drivers/iio/multiplexer/iio-mux.c
> +++ b/drivers/iio/multiplexer/iio-mux.c
> @@ -10,11 +10,12 @@
>  #include <linux/err.h>
>  #include <linux/iio/consumer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/mux/consumer.h>
> -#include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  
>  struct mux_ext_info_cache {
>  	char *data;
> @@ -324,37 +325,20 @@ static int mux_configure_channel(struct device *dev, struct mux *mux,
>  	return 0;
>  }
>  
> -/*
> - * Same as of_property_for_each_string(), but also keeps track of the
> - * index of each string.
> - */
> -#define of_property_for_each_string_index(np, propname, prop, s, i)	\
> -	for (prop = of_find_property(np, propname, NULL),		\
> -	     s = of_prop_next_string(prop, NULL),			\
> -	     i = 0;							\
> -	     s;								\
> -	     s = of_prop_next_string(prop, s),				\
> -	     i++)
> -
>  static int mux_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *np = pdev->dev.of_node;
>  	struct iio_dev *indio_dev;
>  	struct iio_channel *parent;
>  	struct mux *mux;
> -	struct property *prop;
> -	const char *label;
> +	const char **labels;
>  	u32 state;
> +	int children, all_children;
>  	int sizeof_ext_info;
> -	int children;
>  	int sizeof_priv;
>  	int i;
>  	int ret;
>  
> -	if (!np)
> -		return -ENODEV;
> -
>  	parent = devm_iio_channel_get(dev, "parent");
>  	if (IS_ERR(parent))
>  		return dev_err_probe(dev, PTR_ERR(parent),
> @@ -366,9 +350,21 @@ static int mux_probe(struct platform_device *pdev)
>  		sizeof_ext_info *= sizeof(*mux->ext_info);
>  	}
>  
> +	all_children = device_property_count_string_array(dev, "channels");
> +	if (all_children < 0)
> +		return all_children;
> +
> +	labels = devm_kmalloc_array(dev, all_children, sizeof(char *), GFP_KERNEL);
> +	if (!labels)
> +		return -ENOMEM;
> +
> +	ret = device_property_read_string_array(dev, "channels", labels, all_children);
> +	if (ret < 0)
> +		return ret;
> +
>  	children = 0;
> -	of_property_for_each_string(np, "channels", prop, label) {
> -		if (*label)
> +	for (state = 0; state < all_children; state++) {
> +		if (*labels[state])
>  			children++;
>  	}
>  	if (children <= 0) {
> @@ -395,7 +391,7 @@ static int mux_probe(struct platform_device *pdev)
>  	mux->cached_state = -1;
>  
>  	mux->delay_us = 0;
> -	of_property_read_u32(np, "settle-time-us", &mux->delay_us);
> +	device_property_read_u32(dev, "settle-time-us", &mux->delay_us);
>  
>  	indio_dev->name = dev_name(dev);
>  	indio_dev->info = &mux_info;
> @@ -426,11 +422,11 @@ static int mux_probe(struct platform_device *pdev)
>  	}
>  
>  	i = 0;
> -	of_property_for_each_string_index(np, "channels", prop, label, state) {
> -		if (!*label)
> +	for (state = 0; state < all_children; state++) {
> +		if (!*labels[state])
>  			continue;
>  
> -		ret = mux_configure_channel(dev, mux, state, label, i++);
> +		ret = mux_configure_channel(dev, mux, state, labels[state], i++);
>  		if (ret < 0)
>  			return ret;
>  	}

