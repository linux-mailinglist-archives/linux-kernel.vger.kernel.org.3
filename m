Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B403D480C30
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 18:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbhL1Ryk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 12:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbhL1Ryj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 12:54:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F70CC061574;
        Tue, 28 Dec 2021 09:54:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B626EB816C2;
        Tue, 28 Dec 2021 17:54:37 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 29621C36AED;
        Tue, 28 Dec 2021 17:54:32 +0000 (UTC)
Date:   Tue, 28 Dec 2021 18:00:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/23] counter: Provide alternative counter
 registration functions
Message-ID: <20211228180017.37c2703d@jic23-huawei>
In-Reply-To: <20211227094526.698714-14-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-14-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:16 +0100
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
In general looks very nice to me.

Few minor things inline.
> ---
>  drivers/counter/counter-core.c | 149 ++++++++++++++++++++++++++++++++-
>  include/linux/counter.h        |  15 ++++
>  2 files changed, 163 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
> index 00c41f28c101..8261567b6272 100644
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
> @@ -24,6 +25,11 @@
>  /* Provides a unique ID for each counter device */
>  static DEFINE_IDA(counter_ida);
>  
> +struct counter_device_allochelper {
> +	struct counter_device counter;
> +	unsigned long privdata[];
Nice to keep this opaque. We danced around how to do this in IIO for
a while and never got to a solution we all liked.  Slight disadvantage
is this might matter in hot paths where the compiler doesn't have visibility
to know it can very cheaply access the privdata.

I guess that can be looked at if anyone ever measures it as an important
element (they probably never will!)

> +};
> +
>  static void counter_device_release(struct device *dev)
>  {
>  	struct counter_device *const counter =
> @@ -31,6 +37,9 @@ static void counter_device_release(struct device *dev)
>  
>  	counter_chrdev_remove(counter);
>  	ida_free(&counter_ida, dev->id);
> +
> +	if (!counter->legacy_device)
> +		kfree(container_of(counter, struct counter_device_allochelper, counter));
>  }
>  
>  static struct device_type counter_device_type = {
> @@ -53,7 +62,14 @@ static dev_t counter_devt;
>   */
>  void *counter_priv(const struct counter_device *const counter)
>  {
> -	return counter->priv;
> +	if (counter->legacy_device) {
> +		return counter->priv;
> +	} else {
> +		struct counter_device_allochelper *ch =
> +			container_of(counter, struct counter_device_allochelper, counter);
> +
> +		return &ch->privdata;
> +	}
>  }
>  EXPORT_SYMBOL_GPL(counter_priv);
>  
> @@ -74,6 +90,8 @@ int counter_register(struct counter_device *const counter)
>  	int id;
>  	int err;
>  
> +	counter->legacy_device = true;
> +
>  	/* Acquire unique ID */
>  	id = ida_alloc(&counter_ida, GFP_KERNEL);
>  	if (id < 0)
> @@ -114,6 +132,100 @@ int counter_register(struct counter_device *const counter)
>  }
>  EXPORT_SYMBOL_GPL(counter_register);
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
> +	int id, err;
> +
> +	ch = kzalloc(sizeof(*ch) + sizeof_priv, GFP_KERNEL);
> +	if (!ch) {
> +		err = -ENOMEM;
> +		goto err_alloc_ch;
> +	}
> +
> +	counter = &ch->counter;
> +	dev = &counter->dev;
> +
> +	/* Acquire unique ID */
> +	err = ida_alloc(&counter_ida, GFP_KERNEL);
> +	if (err < 0) {
> +		goto err_ida_alloc;
> +	}
> +	dev->id = err;
> +
> +	err = counter_chrdev_add(counter);

Should think about renaming  counter_chrdev_add() given it
does init and allocation stuff but no adding.

Personal inclination here would be to keep the elements in here
in the same order as in counter_register() where it doesn't matter
in the interests of slightly easier comparison of the code.

> +	if (err < 0)
> +		goto err_chrdev_add;
> +
> +	device_initialize(dev);
> +	/* Configure device structure for Counter */
> +	dev->type = &counter_device_type;
> +	dev->bus = &counter_bus_type;
> +	dev->devt = MKDEV(MAJOR(counter_devt), id);

As 0-day pointed out id not initialized.

> +
> +	mutex_init(&counter->ops_exist_lock);
> +
> +	return counter;
> +
> +err_chrdev_add:
> +
> +	ida_free(&counter_ida, dev->id);
> +err_ida_alloc:
> +
> +	kfree(ch);
> +err_alloc_ch:
> +
> +	return ERR_PTR(err);
> +}
> +EXPORT_SYMBOL_GPL(counter_alloc);
> +
> +void counter_put(struct counter_device *counter)
> +{
> +	put_device(&counter->dev);
> +}
> +
> +/**
> + * counter_add - complete registration of a counter
> + * @counter: the counter to add
> + *
> + * This is part two of counter registration.
> + *
> + * If this succeeds, call counter_unregister() to get rid of the counter_device again.
> + */
> +int counter_add(struct counter_device *counter)
> +{
> +	int err;
> +	struct device *dev = &counter->dev;
> +
> +	get_device(&counter->dev);
> +
> +	if (counter->parent) {
> +		dev->parent = counter->parent;
> +		dev->of_node = counter->parent->of_node;
> +	}
> +
> +	err = counter_sysfs_add(counter);
> +	if (err < 0)
> +		return err;
> +
> +	/* implies device_add(dev) */
> +	err = cdev_device_add(&counter->chrdev, dev);
> +
> +	return err;

return cdev_device_add(&counter->chrdev, dev);
Lars got some of these points as well (maybe all of them but
I'm too lazy to filter them for you ;)


> +}
> +EXPORT_SYMBOL_GPL(counter_add);
> +
>  /**
>   * counter_unregister - unregister Counter from the system
>   * @counter:	pointer to Counter to unregister
> @@ -168,6 +280,41 @@ int devm_counter_register(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_counter_register);
>  
> +static void devm_counter_put(void *counter)
> +{
> +	counter_put(counter);
> +}
> +
> +struct counter_device *devm_counter_alloc(struct device *dev, size_t sizeof_priv)
> +{
> +	struct counter_device *counter;
> +	int err;
> +
> +	counter = counter_alloc(sizeof_priv);
> +	if (IS_ERR(counter))
> +		return counter;
> +
> +	err = devm_add_action_or_reset(dev, devm_counter_put, counter);
> +	if (err < 0)
> +		return ERR_PTR(err);
> +
> +	return counter;
> +}
> +EXPORT_SYMBOL_GPL(devm_counter_alloc);
> +
> +int devm_counter_add(struct device *dev,
> +		     struct counter_device *const counter)
> +{
> +	int err;
> +
> +	err = counter_add(counter);
> +	if (err < 0)
> +		return err;
> +
> +	return devm_add_action_or_reset(dev, devm_counter_release, counter);
> +}
> +EXPORT_SYMBOL_GPL(devm_counter_add);
> +
>  #define COUNTER_DEV_MAX 256
>  
>  static int __init counter_init(void)
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index 8daaa38c71d8..f1350a43cd48 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -327,14 +327,29 @@ struct counter_device {
>  	spinlock_t events_in_lock;
>  	struct mutex events_out_lock;
>  	struct mutex ops_exist_lock;
> +
> +	/*
> +	 * This can go away once all drivers are converted to
> +	 * counter_alloc()/counter_add().
> +	 */
> +	bool legacy_device;
>  };
>  
>  void *counter_priv(const struct counter_device *const counter);
>  
>  int counter_register(struct counter_device *const counter);
> +
> +struct counter_device *counter_alloc(size_t sizeof_priv);
> +void counter_put(struct counter_device *const counter);
> +int counter_add(struct counter_device *const counter);
> +
>  void counter_unregister(struct counter_device *const counter);
>  int devm_counter_register(struct device *dev,
>  			  struct counter_device *const counter);
> +struct counter_device *devm_counter_alloc(struct device *dev,
> +					  size_t sizeof_priv);
> +int devm_counter_add(struct device *dev,
> +		     struct counter_device *const counter);
>  void counter_push_event(struct counter_device *const counter, const u8 event,
>  			const u8 channel);
>  

