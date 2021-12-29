Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F929481583
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 18:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbhL2RAk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Dec 2021 12:00:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42344 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbhL2RAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 12:00:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B3C5B81904;
        Wed, 29 Dec 2021 17:00:38 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 0DEA7C36AE7;
        Wed, 29 Dec 2021 17:00:33 +0000 (UTC)
Date:   Wed, 29 Dec 2021 17:06:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/23] counter: Provide alternative counter
 registration functions
Message-ID: <20211229170612.1dffa818@jic23-huawei>
In-Reply-To: <20211229154441.38045-14-u.kleine-koenig@pengutronix.de>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
        <20211229154441.38045-14-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Dec 2021 16:44:31 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> The current implementation gets device lifetime tracking wrong. The
> problem is that allocation of struct counter_device is controlled by the
> individual drivers but this structure contains a struct device that
> might have to live longer than a driver is bound. As a result a command
> sequence like:
> 
> 	{ sleep 5; echo bang; } > /dev/counter0 &
> 	sleep 1;
> 	echo 40000000.timer:counter > /sys/bus/platform/drivers/stm32-timer-counter/unbind
> 
> can keep a reference to the struct device and unbinding results in
> freeing the memory occupied by this device resulting in an oops.
> 
> This commit provides two new functions (plus some helpers):
>  - counter_alloc() to allocate a struct counter_device that is
>    automatically freed once the embedded struct device is released
>  - counter_add() to register such a device.
> 
> Note that this commit doesn't fix any issues, all drivers have to be
> converted to these new functions to correct the lifetime problems.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Basically fine - a few trivial comments inline that I'm not that fussed
about whether you take notice of or not. As such

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---

I'd have liked to have seen a change log here. Quite a few comments on this
one and not all had 'obvious' resolutions.

>  drivers/counter/counter-core.c | 168 ++++++++++++++++++++++++++++++++-
>  include/linux/counter.h        |  15 +++
>  2 files changed, 181 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
> index 00c41f28c101..b3fa15bbcbdb 100644
> --- a/drivers/counter/counter-core.c
> +++ b/drivers/counter/counter-core.c
> @@ -15,6 +15,7 @@
>  #include <linux/kdev_t.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/wait.h>
>  
> @@ -24,6 +25,16 @@
>  /* Provides a unique ID for each counter device */
>  static DEFINE_IDA(counter_ida);
>  
> +struct counter_device_allochelper {
> +	struct counter_device counter;
> +
> +	/*
> +	 * This is cache line aligned to ensure private data behaves like if it
> +	 * were kmalloced separately.
> +	 */
> +	unsigned long privdata[] ____cacheline_aligned;

Change log for the patch would have made it easier to see you decided
to make this change after the discussion in v2.

> +};
> +

...

>  
> +/**
> + * counter_alloc - allocate a counter_device
> + * @sizeof_priv: size of the driver private data
> + *
> + * This is part one of counter registration. The structure is allocated
> + * dynamically to ensure the right lifetime for the embedded struct device.
> + *
> + * If this succeeds, call counter_put() to get rid of the counter_device again.
> + */
> +struct counter_device *counter_alloc(size_t sizeof_priv)
> +{
> +	struct counter_device_allochelper *ch;
> +	struct counter_device *counter;
> +	struct device *dev;
> +	int err;
> +
> +	ch = kzalloc(sizeof(*ch) + sizeof_priv, GFP_KERNEL);
> +	if (!ch) {
> +		err = -ENOMEM;
> +		goto err_alloc_ch;

Slight preference for a direct return here even though it means
replicating the ERR_PTR() statement.  Makes for one less error
path where a reviewer has to go see what is being done.

> +	}
> +
> +	counter = &ch->counter;
> +	dev = &counter->dev;
> +
> +	/* Acquire unique ID */
> +	err = ida_alloc(&counter_ida, GFP_KERNEL);
> +	if (err < 0)
> +		goto err_ida_alloc;
> +	dev->id = err;
> +
> +	mutex_init(&counter->ops_exist_lock);
> +	dev->type = &counter_device_type;
> +	dev->bus = &counter_bus_type;
> +	dev->devt = MKDEV(MAJOR(counter_devt), dev->id);
> +
> +	err = counter_chrdev_add(counter);
> +	if (err < 0)
> +		goto err_chrdev_add;
> +
> +	device_initialize(dev);
> +
> +	return counter;
> +
> +err_chrdev_add:
> +
Nitpick: Unusual spacing (to my eye anyway). I wouldn't expect to see a blank line after a label
as the label indentation makes a visual separation anyway.

> +	ida_free(&counter_ida, dev->id);
> +err_ida_alloc:
> +
> +	kfree(ch);
> +err_alloc_ch:
> +
> +	return ERR_PTR(err);
> +}
> +EXPORT_SYMBOL_GPL(counter_alloc);

