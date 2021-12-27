Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B95F47FC88
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 13:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbhL0MRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 07:17:02 -0500
Received: from www381.your-server.de ([78.46.137.84]:55306 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbhL0MRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:17:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=jdcCyU+oQzxZ8PdQytmggyUxsG3MZfW7C6pREoHgr5w=; b=W11LW5cMo2EphSF6porGhxyPcH
        Grce/iVKriqZD8rGIG3l5jrg7Nx3PlZ/tUzwGizAIqHjpAYsUUpmpTBqDXRzwQyBQWJJyUELe38z3
        VcnFRcim9iBkKULqfyHX35C4uyA2FuouVhmi5ZpX4UW8NA1tTkK8aGEoES7FykjzkDecCaz1uXP16
        K8RERHd1OLuSk2tyF0izctj6LgLAZ8t/EAjo2R5ku7MKBcI/MLgOPc2DxKz1SUIudHWz7r1gOftSp
        AtWv20T0OOgfCA8kAohvqmtG8u3nmq2urL7wTr+n7mS30A8gdzY5cFhvAO07YjKgSNMYuWR4w4z+M
        kVr1EO4Q==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1n1ovx-0009Fg-L6; Mon, 27 Dec 2021 13:16:57 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1n1ovx-000Oie-Cf; Mon, 27 Dec 2021 13:16:57 +0100
Subject: Re: [PATCH v2 13/23] counter: Provide alternative counter
 registration functions
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
 <20211227094526.698714-14-u.kleine-koenig@pengutronix.de>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2053a9ea-a647-89f4-497c-1141ac3e0fa7@metafoo.de>
Date:   Mon, 27 Dec 2021 13:16:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211227094526.698714-14-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26404/Mon Dec 27 10:34:40 2021)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/21 10:45 AM, Uwe Kleine-König wrote:
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
>   - counter_alloc() to allocate a struct counter_device that is
>     automatically freed once the embedded struct device is released
>   - counter_add() to register such a device.
>
> Note that this commit doesn't fix any issues, all drivers have to be
> converted to these new functions to correct the lifetime problems.
Nice work!


> [...]
> @@ -24,6 +25,11 @@
>   /* Provides a unique ID for each counter device */
>   static DEFINE_IDA(counter_ida);
>   
> +struct counter_device_allochelper {
> +	struct counter_device counter;
> +	unsigned long privdata[];

The normal k*alloc functions guarantee that the allocation is cacheline 
aligned. Without that for example the ____cacheline_aligned attribute 
will not work correctly. And while it is unlikely that a counter driver 
will need for example DMA memory I think it is still good practice to 
guarantee this here to avoid bad surprises. There are two ways of doing 
this.

Make privdata ____cacheline_aligned like in the memstick framework[1]. 
The downside is that this will reserve padding for the allocation, even 
if no private data is allocated.

The alternative is to do something similar to IIO[2] which only 
allocates the padding if there actually is any private data requested. 
The disadvantage of that is that the code is a bit more cumbersome. And 
most drivers will want to have some private data anyway so it might not 
be worth it.

[1] 
https://elixir.bootlin.com/linux/v5.16-rc7/source/include/linux/memstick.h#L292
[2] 
https://elixir.bootlin.com/linux/v5.16-rc7/source/drivers/iio/industrialio-core.c#L1638

> [...]
> +struct counter_device *counter_alloc(size_t sizeof_priv)
I'd add a parent parameter here since with the devm_ variant we have to 
pass it anyway and this allows to slightly reduce the boilerplate code 
in the driver where the parent field of the counter has to be initialized.
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
There is a inconsistency whether braces are used for single statement 
`if`s in this patch.
> +	dev->id = err;
> +
> +	err = counter_chrdev_add(counter);
> +	if (err < 0)
> +		goto err_chrdev_add;
> +
> +	device_initialize(dev);
> +	/* Configure device structure for Counter */
> +	dev->type = &counter_device_type;
> +	dev->bus = &counter_bus_type;
> +	dev->devt = MKDEV(MAJOR(counter_devt), id);
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

This get_device() is not needed. device_add() will also add a reference, 
so you increment the reference count by 2 when calling counter_add().

It is only needed to balance the put_device() in counter_unregister(). 
I'd add a `counter->legacy_device` around that put_device() and then 
remove it in the last patch.

The extra get_device() here is also leaked on the error paths, so 
removing it will allow to keep the errors paths as they are.

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
return cdev_device_add(...).
> +struct counter_device *devm_counter_alloc(struct device *dev, size_t sizeof_priv)
API Documentation?
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
API Documentation?
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
>   #define COUNTER_DEV_MAX 256
>   

