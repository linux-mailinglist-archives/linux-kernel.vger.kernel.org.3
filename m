Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F306A48F87F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 18:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiAORcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 12:32:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38394 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiAORcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 12:32:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 443D460DE4;
        Sat, 15 Jan 2022 17:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C82BC36AEA;
        Sat, 15 Jan 2022 17:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642267921;
        bh=m5J7+tK2dWkkkUIRZ+mqjcO+qjUeYRLarvpRzjxJJKo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OM4+iEXbS5CpZnCkQBcT1D/SviHwns49WjfKMqcX/j8Dv0YazFek0hHryaoYZzHzi
         BHpWpHKRFV3iyAWcyUBkYZ17R+QhgjJ9O5RQFQ0tXZ0dB0PYmSA23iBmsvGEVG6lN4
         nYjmPrIM122QjXg6Nbt/t2vlQ0Jl/Pn5UvwDgtR3s19VG8+C8KemR6BZ2eQB3YVmP5
         TrEBl68stSRyUMUP50MqZxQxrJqA8mlwc/GW/kG9UESpIo3P7DECanHKruUWN6Z+KD
         sA+DeSamtrG9OwfF5I9IgrNpgx5T/xObWzyUag0ffi7o8M7j1zkyAZyI5pMMG1OoNV
         LZBlQ+9OE5S4g==
Date:   Sat, 15 Jan 2022 17:38:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     xkernel.wang@foxmail.com
Cc:     jic23@jic23.retrosnub.co.uk, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: dummy: iio_simple_dummy: check the return value
 of kstrdup()
Message-ID: <20220115173803.417c0b8f@jic23-huawei>
In-Reply-To: <tencent_E14226FC5CC9EF3F18C480D9249783C39B05@qq.com>
References: <tencent_E14226FC5CC9EF3F18C480D9249783C39B05@qq.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 11:48:28 +0800
xkernel.wang@foxmail.com wrote:

> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> kstrdup() is also a memory allocation-related function, it return NULL
> when some memory errors happen. So it is better to check the return
> value of it so to catch the memory error in time. Besides, there should
> have a kfree() to clear up the allocation if we get a failure later in
> this function to prevent memory leak.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>

Hi a few minor follow on comments. Sorry it took me so long to get back to
you on this. I wasn't rushing as I won't be picking up fixes until the merge
window is done and I can rebase on rc1.

> ---
> Changelog:
> 1. Clean up some error labels(error_ret & error_kzalloc), directly make
> them reflect what they are clearing up and return.
> 2. Clear up indio_dev->name on error path. I put that under label 
> `error_free_device`, as kfree(NULL) is safe. Or I may need to add an
> another label as the traget of `goto`.
> Note: Suggestions are from Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
> ---
>  drivers/iio/dummy/iio_simple_dummy.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
> index c0b7ef9..430c12a 100644
> --- a/drivers/iio/dummy/iio_simple_dummy.c
> +++ b/drivers/iio/dummy/iio_simple_dummy.c
> @@ -577,7 +577,7 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
>  	swd = kzalloc(sizeof(*swd), GFP_KERNEL);
>  	if (!swd) {
>  		ret = -ENOMEM;
> -		goto error_kzalloc;
> +		return ERR_PTR(ret);

		return ERR_PTR(-ENOMEM);

>  	}
>  	/*
>  	 * Allocate an IIO device.
> @@ -589,8 +589,9 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
>  	 */
>  	indio_dev = iio_device_alloc(parent, sizeof(*st));
>  	if (!indio_dev) {
> +		kfree(swd);
Ah. Not what I meant unfortunately. This should look something like.

	if (!indio_dev) {
		ret = -ENOMEM;
		goto error_free_swd;
	}	
With error_ret label renamed to error_free_swd to reflect where it is.

>  		ret = -ENOMEM;
> -		goto error_ret;
> +		return ERR_PTR(ret);
>  	}
>  
>  	st = iio_priv(indio_dev);
> @@ -616,6 +617,10 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
>  	 *    indio_dev->name = spi_get_device_id(spi)->name;
>  	 */
>  	indio_dev->name = kstrdup(name, GFP_KERNEL);
> +	if (!indio_dev->name) {
> +		ret = -ENOMEM;
> +		goto error_free_device;
> +	}
>  
>  	/* Provide description of available channels */
>  	indio_dev->channels = iio_dummy_channels;
> @@ -650,10 +655,9 @@ static struct iio_sw_device *iio_dummy_probe(const char *name)
>  error_unregister_events:
>  	iio_simple_dummy_events_unregister(indio_dev);
>  error_free_device:
> +	kfree(indio_dev->name);
>  	iio_device_free(indio_dev);
> -error_ret:
>  	kfree(swd);
> -error_kzalloc:
>  	return ERR_PTR(ret);
>  }
>  

