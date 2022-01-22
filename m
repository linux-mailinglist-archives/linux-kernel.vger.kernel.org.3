Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72302496D84
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 20:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbiAVTE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 14:04:28 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35586 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiAVTE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 14:04:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9482560EAE;
        Sat, 22 Jan 2022 19:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95733C004E1;
        Sat, 22 Jan 2022 19:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642878266;
        bh=Rlio+Y9TAi3gHzpWJlgXWKrKeaNXUUWbBqc0KyT9kKo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TJ/ZdAg1DNVH5eeb0RH9NItE6E0ocpTfutTw6H+pE6Cq8OyefbTQHjBO0TCdFHtgp
         KMGzk0BUuiJZTnekIqx6t6dTq66ypyY+eztZeDXnWGmv8NapVfhYaaJxRSkGuTzweF
         2tfnh4EMD4SLBvIPRNUEk/Gzj46onllJiQIWjgG9c7gR3s3HsB0GPaYzVgN4hch0Nz
         kvClN6eAf5AtzK5I4CmNVN1hBwkxY+C7/lZF7vQ7mIapJT92hPxutsZTk/u0G/w/ym
         1/hQ5G3v5qODRt3XzewIWFZJeDD/aUKDG3zLtycYRJpDK3vZMj/Tu+awbgwwt03nWx
         Pz+kkpjrR12Lw==
Date:   Sat, 22 Jan 2022 19:10:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Daniel Beer <daniel.beer@igorinstitute.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Derek Simkowiak <derek.simkowiak@igorinstitute.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] iio: adc: ad_sigma_delta: IRQ sharing mechanism.
Message-ID: <20220122191034.74cb89c4@jic23-huawei>
In-Reply-To: <61dd3e0c.1c69fb81.cea15.8d98@mx.google.com>
References: <61dd3e0c.1c69fb81.cea15.8d98@mx.google.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 21:07:47 +1300
Daniel Beer <daniel.beer@igorinstitute.com> wrote:

> This patch allows for multiple Analog Devices ADCs to be placed on the
> same SPI bus. While it's not possible for them to share interrupts
> arbitrarily, a special restricted form of sharing for this special case
> is implemented here.
> 
> The first instance of an ADC using a given interrupt will acquire the
> IRQ and register an object in a global list. Any subsequent instances
> will increment a reference count on this object.
> 
> During a conversion, the active instance indicates that it is the
> recipient of the interrupt by setting a pointer on the object shared
> among it and the other instances.
> 
> The existing CS locking mechanism guarantees that no more than one
> instance per bus will be expecting the interrupt at any time.
> 
> Signed-off-by: Daniel Beer <daniel.beer@igorinstitute.com>

Hi Daniel,

So for this problem I'm definitely looking for inputs from others
on how 'best' to handle it.

Lars, this is the sort of crazy stuff you "like" :).  Any thoughts?

For others not familiar with these parts they don't have separate
interrupt lines, but instead use the SPI data out line both
as the data out wire when clocking out data and as a data ready
signal.  The driver then has to call enable_irq()
only when an ADC data acquisition has started and disable_irq()
whenever the acquisition is finished and we want to use the SPI bus.

When I first read the description I wondered if we should think about
representing this as an IRQ chip with some unusual restrictions.
Note irq_chip infrastructure is how we handle triggers causing
capture on multiple devices in IIO, another case where it's
convenient to harness this infrastructure when it's really just
software stuff going on - there isn't any hardware.

So effectively a "one-hot" IRQ chip. It would only allow one
driver at a time to have enabled the IRQ they are getting.

'wiring' wise it would pretend we had.

  __________________ SPI Data Out.
 | ___________
 ||           |---- ADC0_int
--| IRQ chip  |---- ADC1_int
  |___________|---- ADC2_int

If none of the ADCX_int irqs are enabled, then the input IRQ would
also be disabled.  Any attempt to enable two ADCX_int lines at
the same time is an error.  We can continue to rely on bus locking
on the SPI bus to avoid sync issues between different devices
though that will need some clear documentation in the IRQ chip
driver as it won't be 'locally' obvious.

We don't strictly speaking 'need' to enforce the one-hot condition
because the ADC drivers won't break it anyway due to the SPI
bus locking needed when the interrupts are enabled so that would just
be informational / hardening against bugs.

So in short, we would have an irq chip which would always disable
it's source interrupt if no downstream interrupts are enabled.

The advantage of this is we can do it as a layer in front of the
ADC drivers in a separate driver with appropriate description
in firmware.  That might be a bit controversial though.

That driver may be more generally useful for other SPI devices
doing something similar to this.  There may be other ADCs though
I'm not aware of any we support today other than via the
ad_sigma_delta common code.

+CC Mark and Thomas who may well tell me this approach would be crazy
from SPI or IRQ chip end of things.

Other options I can think of that 'might' work are:
1) mediation layer as you have in this patch.
2) shared interrupt and harden the interrupt handlers to know if it
   is 'not' their interrupt which is a bit nasty as that is just a software
   thing.  I'm not sure how calling enable_irq()/disable_irq() will work with
   a shared interrupt.  The irq chip approach would mask it so the ADC driver
   never sees someone else's interrupt.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/ad_sigma_delta.c       | 191 +++++++++++++++++++++++--
>  include/linux/iio/adc/ad_sigma_delta.h |   4 +
>  2 files changed, 181 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index cd418bd8bd87..cd593af6ef3a 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -13,6 +13,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/list.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -24,6 +25,161 @@
>  
>  #include <asm/unaligned.h>
>  
> +static irqreturn_t ad_sd_data_rdy_trig_poll(int irq, void *private);
> +
> +struct ad_sigma_delta_interrupt {
> +	/* Constant from time of creation */
> +	int			irq;
> +	struct spi_master	*master;
> +
> +	/* Protected by global lock */
> +	struct list_head	list;
> +	int			refcnt;
> +
> +	/* Protected by lock on corresponding SPI bus */
> +	struct ad_sigma_delta	*active;
> +};
> +
> +static DEFINE_MUTEX(interrupt_lock);
> +static LIST_HEAD(interrupt_list);
> +
> +static void adsdi_enable(struct ad_sigma_delta *a)
> +{
> +	struct ad_sigma_delta_interrupt *intr = a->interrupt;
> +
> +	WARN_ON(intr->active);
> +	intr->active = a;
> +	pr_debug("ad_sigma_delta: enable %d for %p\n", intr->irq, a);
> +	enable_irq(intr->irq);
> +}
> +
> +static void adsdi_disable(struct ad_sigma_delta *a, int nosync)
> +{
> +	struct ad_sigma_delta_interrupt *intr = a->interrupt;
> +
> +	if (nosync)
> +		disable_irq_nosync(intr->irq);
> +	else
> +		disable_irq(intr->irq);
> +
> +	pr_debug("ad_sigma_delta: disable %d for %p\n", intr->irq, intr->active);
> +
> +	/* In the case of a timeout, it's possible for adsdi_disable to
> +	 * be called twice by the same instance (if the interrupt runs
> +	 * between the call to check and the call to disable).
> +	 *
> +	 * We still need to disable first before checking intr->active.
> +	 * Then we can roll back if we've done it twice.
> +	 */
> +	if (intr->active != a) {
> +		WARN_ON(intr->active);
> +		pr_debug("ad_sigma_delta: double-disable\n");
> +		enable_irq(intr->irq);
> +	}
> +
> +	intr->active = NULL;
> +}
> +
> +static int adsdi_get(struct ad_sigma_delta_interrupt **intr_ret,
> +		     int irq, struct spi_master *master,
> +		     int flags)
> +{
> +	struct ad_sigma_delta_interrupt *intr = NULL;
> +	struct list_head *ptr;
> +	int ret = 0;
> +
> +	mutex_lock(&interrupt_lock);
> +
> +	/* Try to find an existing instance */
> +	list_for_each(ptr, &interrupt_list) {
> +		struct ad_sigma_delta_interrupt *i = list_entry(ptr,
> +			struct ad_sigma_delta_interrupt, list);
> +
> +		if (i->irq == irq) {
> +			/* No instance will attempt to wait for the
> +			 * interrupt without the SPI bus locked, which
> +			 * we can rely on to ensure correct operation.
> +			 * However, we would like to detect
> +			 * misconfiguration that would lead to unsafe
> +			 * access.
> +			 */
> +			if (i->master != master) {
> +				pr_err(
> +				    "ad_sigma_delta: SPI master mismatch on IRQ %d\n",
> +				    irq);
> +				ret = -EINVAL;
> +				goto fail_search;
> +			}
> +
> +			intr = i;
> +			break;
> +		}
> +	}
> +
> +	/* Allocate a new one if necessary */
> +	if (!intr) {
> +		intr = kmalloc(sizeof(*intr), GFP_KERNEL);
> +		if (!intr) {
> +			ret = -ENOMEM;
> +			pr_err("ad_sigma_delta: can't allocate memory\n");
> +			goto fail_search;
> +		}
> +
> +		intr->irq = irq;
> +		intr->refcnt = 0;
> +		intr->active = NULL;
> +		intr->master = master;
> +
> +		ret = request_irq(irq,
> +				  ad_sd_data_rdy_trig_poll,
> +				  flags | IRQF_NO_AUTOEN,
> +				  "ad_sigma_delta",
> +				  intr);
> +		if (ret)
> +			goto fail_search;
> +
> +		pr_debug("ad_sigma_delta: sharing interrupt %d\n", irq);
> +		list_add(&intr->list, &interrupt_list);
> +	}
> +
> +	intr->refcnt++;
> +	*intr_ret = intr;
> +
> +fail_search:
> +	mutex_unlock(&interrupt_lock);
> +	return ret;
> +}
> +
> +static void adsdi_put(struct ad_sigma_delta_interrupt *intr)
> +{
> +	mutex_lock(&interrupt_lock);
> +	if (!--intr->refcnt) {
> +		pr_debug("ad_sigma_delta: interrupt %d deallocated\n",
> +			intr->irq);
> +		free_irq(intr->irq, intr);
> +		list_del(&intr->list);
> +		kfree(intr);
> +	}
> +	mutex_unlock(&interrupt_lock);
> +}
> +
> +static void devm_adsdi_release(void *arg)
> +{
> +	adsdi_put(arg);
> +}
> +
> +static int devm_adsdi_get(struct device *dev,
> +			  struct ad_sigma_delta_interrupt **intr_ret,
> +			  int irq, struct spi_master *master,
> +			  int flags)
> +{
> +	const int ret = adsdi_get(intr_ret, irq, master, flags);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, devm_adsdi_release, *intr_ret);
> +}
>  
>  #define AD_SD_COMM_CHAN_MASK	0x3
>  
> @@ -221,11 +377,11 @@ int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
>  		goto out;
>  
>  	sigma_delta->irq_dis = false;
> -	enable_irq(sigma_delta->spi->irq);
> +	adsdi_enable(sigma_delta);
>  	timeout = wait_for_completion_timeout(&sigma_delta->completion, 2 * HZ);
>  	if (timeout == 0) {
>  		sigma_delta->irq_dis = true;
> -		disable_irq_nosync(sigma_delta->spi->irq);
> +		adsdi_disable(sigma_delta, 0);
>  		ret = -EIO;
>  	} else {
>  		ret = 0;
> @@ -294,7 +450,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
>  	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_SINGLE);
>  
>  	sigma_delta->irq_dis = false;
> -	enable_irq(sigma_delta->spi->irq);
> +	adsdi_enable(sigma_delta);
>  	ret = wait_for_completion_interruptible_timeout(
>  			&sigma_delta->completion, HZ);
>  
> @@ -314,7 +470,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
>  
>  out:
>  	if (!sigma_delta->irq_dis) {
> -		disable_irq_nosync(sigma_delta->spi->irq);
> +		adsdi_disable(sigma_delta, 0);
>  		sigma_delta->irq_dis = true;
>  	}
>  
> @@ -361,7 +517,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  		goto err_unlock;
>  
>  	sigma_delta->irq_dis = false;
> -	enable_irq(sigma_delta->spi->irq);
> +	adsdi_enable(sigma_delta);
>  
>  	return 0;
>  
> @@ -379,7 +535,7 @@ static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
>  	wait_for_completion_timeout(&sigma_delta->completion, HZ);
>  
>  	if (!sigma_delta->irq_dis) {
> -		disable_irq_nosync(sigma_delta->spi->irq);
> +		adsdi_disable(sigma_delta, 0);
>  		sigma_delta->irq_dis = true;
>  	}
>  
> @@ -425,7 +581,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
>  
>  	iio_trigger_notify_done(indio_dev->trig);
>  	sigma_delta->irq_dis = false;
> -	enable_irq(sigma_delta->spi->irq);
> +	adsdi_enable(sigma_delta);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -438,10 +594,17 @@ static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
>  
>  static irqreturn_t ad_sd_data_rdy_trig_poll(int irq, void *private)
>  {
> -	struct ad_sigma_delta *sigma_delta = private;
> +	struct ad_sigma_delta_interrupt *intr = private;
> +	struct ad_sigma_delta *sigma_delta = intr->active;
> +
> +	WARN_ON(!sigma_delta);
> +	if (!sigma_delta)
> +		return IRQ_NONE;
>  
> +	pr_debug("ad_sigma_delta: interrupt %d fired for %p\n",
> +		intr->irq, sigma_delta);
>  	complete(&sigma_delta->completion);
> -	disable_irq_nosync(irq);
> +	adsdi_disable(sigma_delta, 1);
>  	sigma_delta->irq_dis = true;
>  	iio_trigger_poll(sigma_delta->trig);
>  
> @@ -486,11 +649,11 @@ static int devm_ad_sd_probe_trigger(struct device *dev, struct iio_dev *indio_de
>  	init_completion(&sigma_delta->completion);
>  
>  	sigma_delta->irq_dis = true;
> -	ret = devm_request_irq(dev, sigma_delta->spi->irq,
> -			       ad_sd_data_rdy_trig_poll,
> -			       sigma_delta->info->irq_flags | IRQF_NO_AUTOEN,
> -			       indio_dev->name,
> -			       sigma_delta);
> +	ret = devm_adsdi_get(dev,
> +			&sigma_delta->interrupt,
> +			sigma_delta->spi->irq,
> +			sigma_delta->spi->master,
> +			sigma_delta->info->irq_flags);
>  	if (ret)
>  		return ret;
>  
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index c525fd51652f..62f38cfe807b 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -54,6 +54,9 @@ struct ad_sigma_delta_info {
>  	unsigned long irq_flags;
>  };
>  
> +/* Data relating to interrupt sharing */
> +struct ad_sigma_delta_interrupt;
> +
>  /**
>   * struct ad_sigma_delta - Sigma Delta device struct
>   * @spi: The spi device associated with the Sigma Delta device.
> @@ -76,6 +79,7 @@ struct ad_sigma_delta {
>  	uint8_t			comm;
>  
>  	const struct ad_sigma_delta_info *info;
> +	struct ad_sigma_delta_interrupt *interrupt;
>  
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the

