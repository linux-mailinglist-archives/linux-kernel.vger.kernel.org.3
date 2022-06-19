Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC910550A92
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 14:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbiFSMRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 08:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbiFSMRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 08:17:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AD160F4;
        Sun, 19 Jun 2022 05:17:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18F47B80CAC;
        Sun, 19 Jun 2022 12:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E008C34114;
        Sun, 19 Jun 2022 12:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655641066;
        bh=qF9O8ocNfk/1ToQv4px7r5bWDdJ7Z/a9Nwm8Ov8LlGU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tcl+2dO9Ff+s0bP+Fg+8t5XhTuBXPXux2NAZrM1I/YD/dSwJPtWrcXhOZJeb5G3tS
         DavJfzpGQoQ0jqy2ZcY01xPmt3wLI/SOqcruPrLqYFe6GlFyFcQ+8ndyVFteCDvkBl
         YTjGFLjjCEpCWlI2AH7zAA8tu3F77itdhBLsxIVO4GZ3D4N6Ajztd9Ln7E/VevBKuY
         jJbkSfuuzr/l0nctzCzBFP+cJdLv+L9tiEAaIkI69yb6spVJQoyB5pRT42R1LU8tkB
         yJxP8cWpN8vPuQ+xwH0vl+Pbsu7k0l1vQQk+pLsX/oeuM1SM5YuavSNjoFQp8Ge38u
         ZImnxBWg9HMkg==
Date:   Sun, 19 Jun 2022 13:27:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <DDRokosov@sberdevices.ru>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Message-ID: <20220619132703.5cf3b090@jic23-huawei>
In-Reply-To: <20220616104211.9257-3-ddrokosov@sberdevices.ru>
References: <20220616104211.9257-1-ddrokosov@sberdevices.ru>
        <20220616104211.9257-3-ddrokosov@sberdevices.ru>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 10:42:14 +0000
Dmitry Rokosov <DDRokosov@sberdevices.ru> wrote:

> MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> sensitivity consumer applications. It has dynamical user selectable full
> scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
> with output data rates from 1Hz to 1000Hz.
> 
> Datasheet can be found at following URL:
> https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf
> 
> This driver supports following MSA311 features:
>     - IIO interface
>     - Different power modes: NORMAL and SUSPEND (using pm_runtime)
>     - ODR (Output Data Rate) selection
>     - Scale and samp_freq selection
>     - IIO triggered buffer, IIO reg access
>     - NEW_DATA interrupt + trigger
> 
> Below features to be done:
>     - Motion Events: ACTIVE, TAP, ORIENT, FREEFALL
>     - Low Power mode
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Hi Dmitry,

A few things I missed before + I'm still not happy with the runtime
pm handling.  One case that isn't covered well is !CONFIG_RUNTIME_PM

Thanks,

Jonathan

> ---
>  MAINTAINERS                |    6 +
>  drivers/iio/accel/Kconfig  |   13 +
>  drivers/iio/accel/Makefile |    2 +
>  drivers/iio/accel/msa311.c | 1312 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 1333 insertions(+)
>  create mode 100644 drivers/iio/accel/msa311.c
> 
>

> diff --git a/drivers/iio/accel/msa311.c b/drivers/iio/accel/msa311.c
> new file mode 100644
> index 000000000000..f8a8ed064f21
> --- /dev/null
> +++ b/drivers/iio/accel/msa311.c
> @@ -0,0 +1,1312 @@

> +
> +#define MSA311_ACCEL_CHANNEL(axis) {                                       \
> +	.type = IIO_ACCEL,                                                 \
> +	.modified = 1,                                                     \
> +	.channel2 = IIO_MOD_##axis,                                        \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                      \
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE) |              \

Scale is very rarely shared by all, because technically that means it also applies
to the timestamp channel.  Should be shared_by_type


> +				   BIT(IIO_CHAN_INFO_SAMP_FREQ),           \
> +	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SCALE) |    \
> +					     BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.scan_index = MSA311_SI_##axis,                                    \
> +	.scan_type = {                                                     \
> +		.sign = 's',                                               \
> +		.realbits = 12,                                            \
> +		.storagebits = 16,                                         \
> +		.shift = 4,                                                \
> +		.endianness = IIO_LE,                                      \
> +	},                                                                 \
> +	.datasheet_name = "ACC_"#axis                                      \
> +}
> +


> +static irqreturn_t msa311_buffer_thread(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> +	struct device *dev = &msa311->i2c->dev;
> +	const struct iio_chan_spec *chan;
> +	__le16 axis;
> +	int bit = 0, err, i = 0;
> +
> +	/* Ensure correct alignment of time stamp when present */
> +	struct {
> +		__le16 channels[MSA311_SI_Z + 1];
> +		s64 ts __aligned(8);
> +	} buf;
> +
> +	memset(&buf, 0, sizeof(buf));
> +
> +	mutex_lock(&msa311->lock);
> +
> +	for_each_set_bit(bit, indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {
> +		chan = &msa311_channels[bit];

Nothing to do with your driver, but feels like it's worth
exploring a
	for_each_chan_in_iio_scan(struct iio_chan_spec, struct iio_dev) macro.

I'll add that to my todo list.

> +
> +		err = msa311_get_axis(msa311, chan, &axis);
> +		if (err) {
> +			mutex_unlock(&msa311->lock);
> +			dev_err(dev, "cannot get axis %s (%d)\n",
> +				chan->datasheet_name, err);
> +			goto err;
> +		}
> +
> +		buf.channels[i++] = axis;
> +	}
> +
> +	mutex_unlock(&msa311->lock);
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &buf,
> +					   iio_get_time_ns(indio_dev));
> +
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}


> +static void msa311_powerdown(void *dev)
> +{
> +	/* Resume device if any */
> +	pm_runtime_get_sync(dev);

Hmm. I'm never particularly keen on unusual ways of using runtime pm,
so I wonder if we can avoid this turn it on to turn it off now cycle.

See below. 

> +
> +	/* Suspend device right now */
> +	pm_runtime_put_sync_suspend(dev);

I'm still unconvinced this dance is necessary - if we assume runtime_pm
is enabled.
__pm_runtime_use_autosuspend(dev, false); which is called as part of
devm_pm_runtime_enable() being unwound calls update_autosuspend
https://elixir.bootlin.com/linux/latest/source/drivers/base/power/runtime.c#L1595
after setting power.use_autosuspend to false.
Thus it takes the else branch and call rpm_idle() which I think should be
able to suspend the device just as the above does.

Note the more complex sequence below still applies, because runtime
pm is in general optional.

> +}
> +
> +static int msa311_probe(struct i2c_client *i2c)
> +{
> +	struct msa311_priv *msa311;
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &i2c->dev;
> +	int err;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*msa311));
> +	if (!indio_dev)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "iio device allocation failed\n");
> +
> +	msa311 = iio_priv(indio_dev);
> +	msa311->i2c = i2c;
> +	i2c_set_clientdata(i2c, indio_dev);
> +
> +	err = msa311_regmap_init(msa311);
> +	if (err)
> +		return err;
> +
> +	mutex_init(&msa311->lock);
> +
When this unwind we will disable autosuspend etc, but leave the device
in whatever state it happens to be in at that stage (if I understand
this handling correctly).  That might seem like a bad thing, but if
we register a devm_add_action_or_reset() callback before this which
disables the device independently of anything to do with runtime PM,
then the device will
a) Be turned off as desired.
b) It'll still be turned off even if runtime pm is disabled for the system
   which is nice.

Given the particular state register must be writeable and is presumably
idempotent, can we just call 
err = msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_SUSPEND);
Unconditionally in such a callback?



> +	err = devm_pm_runtime_enable(dev);
> +	if (err)
> +		return err;
> +
> +	/* Resume msa311 logic before any interactions with registers */
> +	err = pm_runtime_resume_and_get(dev);
I missed this before, but if runtime pm is disabled, this won't do anything
so device won't be powered on.

One common(ish) way to handle this is the following sequence.

1) Power up supply regs etc and a register a devm_ callback to turn them off again.
2) Put the device into a non suspend state (not using runtime pm calls).
3) Register a callback to turn it off again (that is safe against it being
   turned off via another path such as runtime pm).
4) pm_runtime_set_active() to let the runtime pm code know it is turned on.
5) devm_pm_runtime_enable()
6) autosuspend setup and enablement.

If runtime pm isn't enabled then only 1-3 happen.  We waste power but the
device works.

> +	if (err)
> +		return err;
> +
> +	pm_runtime_set_autosuspend_delay(dev, MSA311_PWR_SLEEP_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	err = msa311_chip_init(msa311);
> +	if (err)
> +		return err;
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE; /* setup buffered mode later */
> +	indio_dev->channels = msa311_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(msa311_channels);
> +	indio_dev->name = i2c->name;
> +	indio_dev->info = &msa311_info;
> +
> +	err = devm_iio_triggered_buffer_setup(dev,
> +					      indio_dev,
> +					      iio_pollfunc_store_time,
> +					      msa311_buffer_thread,
> +					      &msa311_buffer_setup_ops);
> +	if (err)
> +		return dev_err_probe(dev, err, "cannot setup iio trig buf\n");
> +
> +	if (i2c->irq > 0) {
> +		err = msa311_setup_interrupts(msa311);
> +		if (err)
> +			return err;
> +	}
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	/*
> +	 * Register powerdown deferred callback which suspends the chip
> +	 * after module unloaded.
> +	 *
> +	 * MSA311 should be in SUSPEND mode in the two cases:
> +	 * 1) When driver is loaded, but we do not have any data or
> +	 *    configuration requests to it (we are solving it using
> +	 *    autosuspend feature).
> +	 * 2) When driver is unloaded and device is not used (devm action is
> +	 *    used in this case).
> +	 */
> +	err = devm_add_action_or_reset(dev, msa311_powerdown, dev);
> +	if (err)
> +		return dev_err_probe(dev, err, "cannot add powerdown action\n");
> +
> +	err = devm_iio_device_register(dev, indio_dev);
> +	if (err)
> +		return dev_err_probe(dev, err, "iio device register failed\n");
> +
> +	return 0;
> +}
> +
> +static int msa311_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> +	int err;
> +
> +	dev_dbg(dev, "suspending %s\n", dev->driver->name);
> +
> +	mutex_lock(&msa311->lock);
> +	err = msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_SUSPEND);
> +	mutex_unlock(&msa311->lock);
> +
> +	if (err) {
> +		dev_err(dev, "failed to power off device (%d)\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static int msa311_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct msa311_priv *msa311 = iio_priv(indio_dev);
> +	int err;
> +
> +	dev_dbg(dev, "resuming %s\n", dev->driver->name);
> +
> +	mutex_lock(&msa311->lock);
> +	err = msa311_set_pwr_mode(msa311, MSA311_PWR_MODE_NORMAL);
> +	mutex_unlock(&msa311->lock);
> +
> +	if (err) {
> +		dev_err(dev, "failed to power on device (%d)\n", err);
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +


