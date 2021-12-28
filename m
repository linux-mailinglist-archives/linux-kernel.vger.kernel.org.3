Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF33480C88
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 19:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237045AbhL1S0C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Dec 2021 13:26:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60508 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbhL1S0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:26:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F56D6130D;
        Tue, 28 Dec 2021 18:26:01 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 71D48C36AE9;
        Tue, 28 Dec 2021 18:25:57 +0000 (UTC)
Date:   Tue, 28 Dec 2021 18:31:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 23/23] counter: remove old and now unused
 registration API
Message-ID: <20211228183142.7600fa76@jic23-huawei>
In-Reply-To: <20211227094526.698714-24-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
        <20211227094526.698714-24-u.kleine-koenig@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 10:45:26 +0100
Uwe Kleine-König         <u.kleine-koenig@pengutronix.de> wrote:

> Usage of counter_register() yields issues in device lifetime tracking. All
> drivers were converted to the new API, so the old one can go away.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
LGTM and nice patch set in general.  Just those few things in the
patch introducing the new interfaces that need tidying up as far as I am
concerned.

Thanks,

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/counter/counter-core.c | 97 ++--------------------------------
>  include/linux/counter.h        | 12 -----
>  2 files changed, 4 insertions(+), 105 deletions(-)
> 
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
> index 8261567b6272..3f7dc5718423 100644
> --- a/drivers/counter/counter-core.c
> +++ b/drivers/counter/counter-core.c
> @@ -38,8 +38,7 @@ static void counter_device_release(struct device *dev)
>  	counter_chrdev_remove(counter);
>  	ida_free(&counter_ida, dev->id);
>  
> -	if (!counter->legacy_device)
> -		kfree(container_of(counter, struct counter_device_allochelper, counter));
> +	kfree(container_of(counter, struct counter_device_allochelper, counter));
>  }
>  
>  static struct device_type counter_device_type = {
> @@ -62,76 +61,13 @@ static dev_t counter_devt;
>   */
>  void *counter_priv(const struct counter_device *const counter)
>  {
> -	if (counter->legacy_device) {
> -		return counter->priv;
> -	} else {
> -		struct counter_device_allochelper *ch =
> -			container_of(counter, struct counter_device_allochelper, counter);
> +	struct counter_device_allochelper *ch =
> +		container_of(counter, struct counter_device_allochelper, counter);
>  
> -		return &ch->privdata;
> -	}
> +	return &ch->privdata;
>  }
>  EXPORT_SYMBOL_GPL(counter_priv);
>  
> -/**
> - * counter_register - register Counter to the system
> - * @counter:	pointer to Counter to register
> - *
> - * This function registers a Counter to the system. A sysfs "counter" directory
> - * will be created and populated with sysfs attributes correlating with the
> - * Counter Signals, Synapses, and Counts respectively.
> - *
> - * RETURNS:
> - * 0 on success, negative error number on failure.
> - */
> -int counter_register(struct counter_device *const counter)
> -{
> -	struct device *const dev = &counter->dev;
> -	int id;
> -	int err;
> -
> -	counter->legacy_device = true;
> -
> -	/* Acquire unique ID */
> -	id = ida_alloc(&counter_ida, GFP_KERNEL);
> -	if (id < 0)
> -		return id;
> -
> -	mutex_init(&counter->ops_exist_lock);
> -
> -	/* Configure device structure for Counter */
> -	dev->id = id;
> -	dev->type = &counter_device_type;
> -	dev->bus = &counter_bus_type;
> -	dev->devt = MKDEV(MAJOR(counter_devt), id);
> -	if (counter->parent) {
> -		dev->parent = counter->parent;
> -		dev->of_node = counter->parent->of_node;
> -	}
> -	device_initialize(dev);
> -
> -	err = counter_sysfs_add(counter);
> -	if (err < 0)
> -		goto err_free_id;
> -
> -	err = counter_chrdev_add(counter);
> -	if (err < 0)
> -		goto err_free_id;
> -
> -	err = cdev_device_add(&counter->chrdev, dev);
> -	if (err < 0)
> -		goto err_remove_chrdev;
> -
> -	return 0;
> -
> -err_remove_chrdev:
> -	counter_chrdev_remove(counter);
> -err_free_id:
> -	put_device(dev);
> -	return err;
> -}
> -EXPORT_SYMBOL_GPL(counter_register);
> -
>  /**
>   * counter_alloc - allocate a counter_device
>   * @sizeof_priv: size of the driver private data
> @@ -255,31 +191,6 @@ static void devm_counter_release(void *counter)
>  	counter_unregister(counter);
>  }
>  
> -/**
> - * devm_counter_register - Resource-managed counter_register
> - * @dev:	device to allocate counter_device for
> - * @counter:	pointer to Counter to register
> - *
> - * Managed counter_register. The Counter registered with this function is
> - * automatically unregistered on driver detach. This function calls
> - * counter_register internally. Refer to that function for more information.
> - *
> - * RETURNS:
> - * 0 on success, negative error number on failure.
> - */
> -int devm_counter_register(struct device *dev,
> -			  struct counter_device *const counter)
> -{
> -	int err;
> -
> -	err = counter_register(counter);
> -	if (err < 0)
> -		return err;
> -
> -	return devm_add_action_or_reset(dev, devm_counter_release, counter);
> -}
> -EXPORT_SYMBOL_GPL(devm_counter_register);
> -
>  static void devm_counter_put(void *counter)
>  {
>  	counter_put(counter);
> diff --git a/include/linux/counter.h b/include/linux/counter.h
> index f1350a43cd48..9afa0f1e9cea 100644
> --- a/include/linux/counter.h
> +++ b/include/linux/counter.h
> @@ -314,8 +314,6 @@ struct counter_device {
>  	struct counter_comp *ext;
>  	size_t num_ext;
>  
> -	void *priv;
> -
>  	struct device dev;
>  	struct cdev chrdev;
>  	struct list_head events_list;
> @@ -327,25 +325,15 @@ struct counter_device {
>  	spinlock_t events_in_lock;
>  	struct mutex events_out_lock;
>  	struct mutex ops_exist_lock;
> -
> -	/*
> -	 * This can go away once all drivers are converted to
> -	 * counter_alloc()/counter_add().
> -	 */
> -	bool legacy_device;
>  };
>  
>  void *counter_priv(const struct counter_device *const counter);
>  
> -int counter_register(struct counter_device *const counter);
> -
>  struct counter_device *counter_alloc(size_t sizeof_priv);
>  void counter_put(struct counter_device *const counter);
>  int counter_add(struct counter_device *const counter);
>  
>  void counter_unregister(struct counter_device *const counter);
> -int devm_counter_register(struct device *dev,
> -			  struct counter_device *const counter);
>  struct counter_device *devm_counter_alloc(struct device *dev,
>  					  size_t sizeof_priv);
>  int devm_counter_add(struct device *dev,

