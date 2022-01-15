Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955BE48F8BE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 19:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbiAOSaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 13:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiAOS37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 13:29:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D6DC061574;
        Sat, 15 Jan 2022 10:29:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8636A60EEE;
        Sat, 15 Jan 2022 18:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E915C36AE7;
        Sat, 15 Jan 2022 18:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642271397;
        bh=pzTH2C50QSvEuZZGhTaGw1rIwySnAGNftGSfnIyTiBs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RSE/adY/2vJ1KFUvGXmpEqgZGHuUBjrDs23NoifHq6S1xb55KPUa//HvbPG5/3ul9
         Gxqy1kjMlw6amCVg0Bj3ApVO/VZ3btkwDbnsCCHCSJyPusZJX1AEwPS5dqkBAANPZi
         Vch6hPfjoy/Nz7ucGf6PvVDO+hionDtj5d7GH30TkU9p6RN4nfwttz9j0rl0bE0Qvg
         8qk0pYdmA9hthRo8m66jvRz5nQ8jxQoAOgtbRfCMiTgDfC0d5pLhP6f7Mvkp4VV1wg
         tVEHit8+UHNhzu+0Pz4evS9lJHZII+CBJUwW2yYeN0BlRRlNqeKS4a914Dk9zW5W9O
         RIgJUFxs8/tCA==
Date:   Sat, 15 Jan 2022 18:35:58 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 1/1] iio: adc: tsc2046: rework the trigger state
 machine
Message-ID: <20220115183558.7e01220c@jic23-huawei>
In-Reply-To: <20220111130402.3404769-1-o.rempel@pengutronix.de>
References: <20220111130402.3404769-1-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 14:04:02 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Initially this was designed to:
> | Fix sleeping in atomic context warning and a deadlock after iio_trigger_poll()
> | call
> |
> | If iio_trigger_poll() is called after IRQ was disabled, we will call
> | reenable_trigger() directly from hard IRQ or hrtimer context instead of
> | IRQ thread. In this case we will run in to multiple issue as sleeping in atomic
> | context and a deadlock.
> |
> | To avoid this issue, rework the trigger to use state machine. All state
> | changes are done over the hrtimer, so it allows us to drop fsleep() and
> | avoid the deadlock.
> 
> Since this issue was fixed by: 9020ef659885 ("iio: trigger: Fix a scheduling
> whilst atomic issue seen on tsc2046"). This patch is a cleanup to make
> state machine easier to follow.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
One trivial thing inline that I've tidied up whilst applying.

Applied to the togreg branch of iio.git and pushed out as testing to let 0-day
poke at it.

Note I'll be rebaseing when rc1 is available and won't push out for linux-next
until after that.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-tsc2046.c | 144 ++++++++++++++++++++++++-----------
>  1 file changed, 98 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> index e8fc4d01f30b..c373da11bff1 100644
> --- a/drivers/iio/adc/ti-tsc2046.c
> +++ b/drivers/iio/adc/ti-tsc2046.c
> @@ -82,6 +82,10 @@
>  #define TI_TSC2046_DATA_12BIT			GENMASK(14, 3)
>  
>  #define TI_TSC2046_MAX_CHAN			8
> +#define TI_TSC2046_MIN_POLL_CNT			3
> +#define TI_TSC2046_EXT_POLL_CNT			3
> +#define TI_TSC2046_POLL_CNT \
> +	(TI_TSC2046_MIN_POLL_CNT + TI_TSC2046_EXT_POLL_CNT)
>  
>  /* Represents a HW sample */
>  struct tsc2046_adc_atom {
> @@ -123,14 +127,23 @@ struct tsc2046_adc_ch_cfg {
>  	unsigned int oversampling_ratio;
>  };
>  
> +enum tsc2046_state {
> +	TSC2046_STATE_SHUTDOWN,
> +	TSC2046_STATE_STANDBY,
> +	TSC2046_STATE_POLL,
> +	TSC2046_STATE_POLL_IRQ_DISABLE,
> +	TSC2046_STATE_ENABLE_IRQ,
> +};
> +
>  struct tsc2046_adc_priv {
>  	struct spi_device *spi;
>  	const struct tsc2046_adc_dcfg *dcfg;
>  
>  	struct iio_trigger *trig;
>  	struct hrtimer trig_timer;
> -	spinlock_t trig_lock;
> -	unsigned int trig_more_count;
> +	enum tsc2046_state state;
> +	int poll_cnt;
> +	spinlock_t state_lock;
>  
>  	struct spi_transfer xfer;
>  	struct spi_message msg;
> @@ -411,21 +424,62 @@ static const struct iio_info tsc2046_adc_info = {
>  	.update_scan_mode = tsc2046_adc_update_scan_mode,
>  };
>  
> -static enum hrtimer_restart tsc2046_adc_trig_more(struct hrtimer *hrtimer)
> +static enum hrtimer_restart tsc2046_adc_timer(struct hrtimer *hrtimer)
>  {
>  	struct tsc2046_adc_priv *priv = container_of(hrtimer,
>  						     struct tsc2046_adc_priv,
>  						     trig_timer);
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&priv->trig_lock, flags);
> -
> -	disable_irq_nosync(priv->spi->irq);
> -
> -	priv->trig_more_count++;
> -	iio_trigger_poll(priv->trig);
> +	/* This state machine should address following challenges :

Nitpick that I can fix whilst applying if there is nothing else needing a v3.

	/*
	 * This state

> +	 * - the interrupt source is based on level shifter attached to the X
> +	 *   channel of ADC. It will change the state every time we switch
> +	 *   between channels. So, we need to disable IRQ if we do
> +	 *   iio_trigger_poll().
> +	 * - we should do iio_trigger_poll() at some reduced sample rate
> +	 * - we should still trigger for some amount of time after last
> +	 *   interrupt with enabled IRQ was processed.
> +	 */
>  
> -	spin_unlock_irqrestore(&priv->trig_lock, flags);
> +	spin_lock_irqsave(&priv->state_lock, flags);
> +	switch (priv->state) {
> +	case TSC2046_STATE_ENABLE_IRQ:
> +		if (priv->poll_cnt < TI_TSC2046_POLL_CNT) {
> +			priv->poll_cnt++;
> +			hrtimer_start(&priv->trig_timer,
> +				      ns_to_ktime(priv->scan_interval_us *
> +						  NSEC_PER_USEC),
> +				      HRTIMER_MODE_REL_SOFT);
> +
> +			if (priv->poll_cnt >= TI_TSC2046_MIN_POLL_CNT) {
> +				priv->state = TSC2046_STATE_POLL_IRQ_DISABLE;
> +				enable_irq(priv->spi->irq);
> +			} else {
> +				priv->state = TSC2046_STATE_POLL;
> +			}
> +		} else {
> +			priv->state = TSC2046_STATE_STANDBY;
> +			enable_irq(priv->spi->irq);
> +		}
> +		break;
> +	case TSC2046_STATE_POLL_IRQ_DISABLE:
> +		disable_irq_nosync(priv->spi->irq);
> +		fallthrough;
> +	case TSC2046_STATE_POLL:
> +		priv->state = TSC2046_STATE_ENABLE_IRQ;
> +		/* iio_trigger_poll() starts hrtimer */
> +		iio_trigger_poll(priv->trig);
> +		break;
> +	case TSC2046_STATE_SHUTDOWN:
> +		break;
> +	case TSC2046_STATE_STANDBY:
> +		fallthrough;
> +	default:
> +		dev_warn(&priv->spi->dev, "Got unexpected state: %i\n",
> +			 priv->state);
> +		break;
> +	}
> +	spin_unlock_irqrestore(&priv->state_lock, flags);
>  
>  	return HRTIMER_NORESTART;
>  }
> @@ -434,16 +488,20 @@ static irqreturn_t tsc2046_adc_irq(int irq, void *dev_id)
>  {
>  	struct iio_dev *indio_dev = dev_id;
>  	struct tsc2046_adc_priv *priv = iio_priv(indio_dev);
> -
> -	spin_lock(&priv->trig_lock);
> +	unsigned long flags;
>  
>  	hrtimer_try_to_cancel(&priv->trig_timer);
>  
> -	priv->trig_more_count = 0;
> -	disable_irq_nosync(priv->spi->irq);
> -	iio_trigger_poll(priv->trig);
> +	spin_lock_irqsave(&priv->state_lock, flags);
> +	if (priv->state != TSC2046_STATE_SHUTDOWN) {
> +		priv->state = TSC2046_STATE_ENABLE_IRQ;
> +		priv->poll_cnt = 0;
>  
> -	spin_unlock(&priv->trig_lock);
> +		/* iio_trigger_poll() starts hrtimer */
> +		disable_irq_nosync(priv->spi->irq);
> +		iio_trigger_poll(priv->trig);
> +	}
> +	spin_unlock_irqrestore(&priv->state_lock, flags);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -452,49 +510,42 @@ static void tsc2046_adc_reenable_trigger(struct iio_trigger *trig)
>  {
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>  	struct tsc2046_adc_priv *priv = iio_priv(indio_dev);
> -	unsigned long flags;
> -	int delta;
> +	ktime_t tim;
>  
>  	/*
>  	 * We can sample it as fast as we can, but usually we do not need so
>  	 * many samples. Reduce the sample rate for default (touchscreen) use
>  	 * case.
> -	 * Currently we do not need a highly precise sample rate. It is enough
> -	 * to have calculated numbers.
> -	 */
> -	delta = priv->scan_interval_us - priv->time_per_scan_us;
> -	if (delta > 0)
> -		fsleep(delta);
> -
> -	spin_lock_irqsave(&priv->trig_lock, flags);
> -
> -	/*
> -	 * We need to trigger at least one extra sample to detect state
> -	 * difference on ADC side.
>  	 */
> -	if (!priv->trig_more_count) {
> -		int timeout_ms = DIV_ROUND_UP(priv->scan_interval_us,
> -					      USEC_PER_MSEC);
> -
> -		hrtimer_start(&priv->trig_timer, ms_to_ktime(timeout_ms),
> -			      HRTIMER_MODE_REL_SOFT);
> -	}
> -
> -	enable_irq(priv->spi->irq);
> -
> -	spin_unlock_irqrestore(&priv->trig_lock, flags);
> +	tim = ns_to_ktime((priv->scan_interval_us - priv->time_per_scan_us) *
> +			  NSEC_PER_USEC);
> +	hrtimer_start(&priv->trig_timer, tim, HRTIMER_MODE_REL_SOFT);
>  }
>  
>  static int tsc2046_adc_set_trigger_state(struct iio_trigger *trig, bool enable)
>  {
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>  	struct tsc2046_adc_priv *priv = iio_priv(indio_dev);
> +	unsigned long flags;
>  
>  	if (enable) {
> -		enable_irq(priv->spi->irq);
> +		spin_lock_irqsave(&priv->state_lock, flags);
> +		if (priv->state == TSC2046_STATE_SHUTDOWN) {
> +			priv->state = TSC2046_STATE_STANDBY;
> +			enable_irq(priv->spi->irq);
> +		}
> +		spin_unlock_irqrestore(&priv->state_lock, flags);
>  	} else {
> -		disable_irq(priv->spi->irq);
> -		hrtimer_try_to_cancel(&priv->trig_timer);
> +		spin_lock_irqsave(&priv->state_lock, flags);
> +
> +		if (priv->state == TSC2046_STATE_STANDBY ||
> +		    priv->state == TSC2046_STATE_POLL_IRQ_DISABLE)
> +			disable_irq_nosync(priv->spi->irq);
> +
> +		priv->state = TSC2046_STATE_SHUTDOWN;
> +		spin_unlock_irqrestore(&priv->state_lock, flags);
> +
> +		hrtimer_cancel(&priv->trig_timer);
>  	}
>  
>  	return 0;
> @@ -668,10 +719,11 @@ static int tsc2046_adc_probe(struct spi_device *spi)
>  	iio_trigger_set_drvdata(trig, indio_dev);
>  	trig->ops = &tsc2046_adc_trigger_ops;
>  
> -	spin_lock_init(&priv->trig_lock);
> +	spin_lock_init(&priv->state_lock);
> +	priv->state = TSC2046_STATE_SHUTDOWN;
>  	hrtimer_init(&priv->trig_timer, CLOCK_MONOTONIC,
>  		     HRTIMER_MODE_REL_SOFT);
> -	priv->trig_timer.function = tsc2046_adc_trig_more;
> +	priv->trig_timer.function = tsc2046_adc_timer;
>  
>  	ret = devm_iio_trigger_register(dev, trig);
>  	if (ret) {

