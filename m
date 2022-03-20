Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFE64E1C4E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 16:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245380AbiCTPi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 11:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiCTPi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 11:38:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC623207E;
        Sun, 20 Mar 2022 08:37:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F8ACB80E67;
        Sun, 20 Mar 2022 15:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE712C340E9;
        Sun, 20 Mar 2022 15:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647790620;
        bh=SiDJp8lidX5h+nrHIovxTqdvMeQ6E4ye1Q/qiodJ8mM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jsidaaJ6QWcSnt98qpRVcmCFGBqfjdnJbR2h0cPxr4m845dnvZNPb8lKDaCXRmGBC
         v0NENANa9cgMb/AGSsQ2BeCvinTrAZciyQDoZkYI5c9KyqOlU2bi1qqTZLemNFaHU2
         Yz05UvECxtZ6VB8/EPyR/+hQGe1HVQSplxZfFr1oFaKM8BTsAg0cCD62aQSEoYoBn1
         AMKFiwHmSKMbrrvbe9M2JXfSpemcXjEanAyrEVnkyTMgHnF2+Nii0kzDeRrHZdMk5d
         1dXb2MBZ8wOoZxcfVURkfOhAWWe7ONuRg9zCeArAFYbisvAIKmy5Gd2KHndsrVpnZU
         3yy1bOLnOUW0w==
Date:   Sun, 20 Mar 2022 15:44:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Rosin <peda@axentia.se>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 1/1] iio: multiplexer: Make use of device properties
Message-ID: <20220320154425.57643a5c@jic23-huawei>
In-Reply-To: <20220302160025.54348-1-andriy.shevchenko@linux.intel.com>
References: <20220302160025.54348-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  2 Mar 2022 18:00:25 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Peter Rosin <peda@axentia.se>
Applied to the togreg branch of iio.git and pushed out as testing (which will be rebased)
so 0-day can take an early poke at what I have queued up.

Thanks,

Jonathan

> ---
> v3: split variable definitions on 1 per line basis (Peter), fixed typo (Jonathan)
>  drivers/iio/multiplexer/Kconfig   |  1 -
>  drivers/iio/multiplexer/iio-mux.c | 49 +++++++++++++++----------------
>  2 files changed, 23 insertions(+), 27 deletions(-)
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
> index f422d44377df..93558fddfa9b 100644
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
> @@ -324,37 +325,21 @@ static int mux_configure_channel(struct device *dev, struct mux *mux,
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
> +	int all_children;
> +	int children;
>  	u32 state;
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
> @@ -366,9 +351,21 @@ static int mux_probe(struct platform_device *pdev)
>  		sizeof_ext_info *= sizeof(*mux->ext_info);
>  	}
>  
> +	all_children = device_property_string_array_count(dev, "channels");
> +	if (all_children < 0)
> +		return all_children;
> +
> +	labels = devm_kmalloc_array(dev, all_children, sizeof(*labels), GFP_KERNEL);
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
> @@ -395,7 +392,7 @@ static int mux_probe(struct platform_device *pdev)
>  	mux->cached_state = -1;
>  
>  	mux->delay_us = 0;
> -	of_property_read_u32(np, "settle-time-us", &mux->delay_us);
> +	device_property_read_u32(dev, "settle-time-us", &mux->delay_us);
>  
>  	indio_dev->name = dev_name(dev);
>  	indio_dev->info = &mux_info;
> @@ -426,11 +423,11 @@ static int mux_probe(struct platform_device *pdev)
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

