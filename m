Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037BA47E3CC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348497AbhLWM4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:56:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41790 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbhLWM4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:56:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15DFCB82075;
        Thu, 23 Dec 2021 12:56:01 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 32D24C36AE9;
        Thu, 23 Dec 2021 12:55:55 +0000 (UTC)
Date:   Thu, 23 Dec 2021 13:01:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: accel: add ADXL367 driver
Message-ID: <20211223130100.059231d6@jic23-huawei>
In-Reply-To: <20211217114548.1659721-3-cosmin.tanislav@analog.com>
References: <20211217114548.1659721-1-cosmin.tanislav@analog.com>
        <20211217114548.1659721-3-cosmin.tanislav@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 13:45:48 +0200
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.
> 
> The ADXL367 does not alias input signals to achieve ultralow power
> consumption, it samples the full bandwidth of the sensor at all
> data rates. Measurement ranges of +-2g, +-4g, and +-8g are available,
> with a resolution of 0.25mg/LSB on the +-2 g range.
> 
> In addition to its ultralow power consumption, the ADXL367
> has many features to enable true system level power reduction.
> It includes a deep multimode output FIFO, a built-in micropower
> temperature sensor, and an internal ADC for synchronous conversion
> of an additional analog input.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

A few comments and questions inline.

Would definitely be helpful if the datasheet becomes available though
as would have saved some of the questions.

Thanks,

Jonathan



> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> new file mode 100644
> index 000000000000..ce574f0446eb
> --- /dev/null
> +++ b/drivers/iio/accel/adxl367.c

...

> +
> +static bool adxl367_push_event(struct iio_dev *indio_dev, u8 status)
> +{
> +	unsigned int ev_dir;
> +
> +	if (FIELD_GET(ADXL367_STATUS_ACT_MASK, status))
> +		ev_dir = IIO_EV_DIR_RISING;
> +	else if (FIELD_GET(ADXL367_STATUS_INACT_MASK, status))
> +		ev_dir = IIO_EV_DIR_FALLING;
> +	else
> +		return false;
> +
> +	iio_push_event(indio_dev,
> +		       IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, IIO_MOD_X_OR_Y_OR_Z,
> +					  IIO_EV_TYPE_THRESH, ev_dir),
This is unusual for event detection as it's a simple or of separately
applied thresholds on X, Y and Z axes.  Given the effect of gravity that
means you have to set the thresholds very wide.

Also, I'd expect these to be magnitudes, not THRESH - no data sheet that
I can find though so can't be sure.

> +		       iio_get_time_ns(indio_dev));
> +
> +	return true;
> +}
> +
> +static bool adxl367_push_fifo_data(struct iio_dev *indio_dev, u8 status,
> +				   u16 fifo_entries)
> +{
> +	struct adxl367_state *st = iio_priv(indio_dev);
> +	int ret;
> +	int i;
> +
> +	if (!FIELD_GET(ADXL367_STATUS_FIFO_FULL_MASK, status))
> +		return false;
> +
> +	fifo_entries -= fifo_entries % st->fifo_set_size;
> +
> +	ret = st->ops->read_fifo(st->context, st->fifo_buf, fifo_entries);
> +	if (ret)
> +		return false;

Odd corner cases - it doesn't mean IRQ_NONE is appropriate I think...
Definitely print an error message if you hit this one but I think you should
still be returning that IRQ_HANDLED from the caller to avoid getting stuck.
IRQ_NONE doesn't mean error, it means a spurious IRQ.

> +
> +	for (i = 0; i < fifo_entries; i += st->fifo_set_size)
> +		iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
> +
> +	return true;
> +}


> +
> +static int adxl367_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long info)
> +{
> +	struct adxl367_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		return adxl367_read_sample(indio_dev, chan, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			mutex_lock(&st->lock);
> +			*val = adxl367_range_scale_tbl[st->range][0];
> +			*val2 = adxl367_range_scale_tbl[st->range][1];
> +			mutex_unlock(&st->lock);
> +			return IIO_VAL_INT_PLUS_NANO;
> +		case IIO_TEMP:
> +			*val = 1;
> +			*val2 = ADXL367_TEMP_PER_C;
> +			return IIO_VAL_FRACTIONAL;

Base units of temp channels are milli degrees C. Given naming here, this looks
like it might be the scale factor to degrees C.
Always check Documentation/ABI/testing/sysfs-bus-iio.
Unfortunately for historical reasons some of the units are not
entirely obvious.

> +		case IIO_VOLTAGE:
> +			*val = ADXL367_VOLTAGE_MAX_MV;
> +			*val2 = ADXL367_VOLTAGE_MAX_RAW;
> +			return IIO_VAL_FRACTIONAL;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			*val = 25 * ADXL367_TEMP_PER_C - ADXL367_TEMP_25C;
> +			return IIO_VAL_INT;
> +		case IIO_VOLTAGE:
> +			*val = ADXL367_VOLTAGE_OFFSET;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&st->lock);
> +		*val = adxl367_samp_freq_tbl[st->odr][0];
> +		*val2 = adxl367_samp_freq_tbl[st->odr][1];
> +		mutex_unlock(&st->lock);
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int adxl367_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct adxl367_state *st = iio_priv(indio_dev);
> +	bool en;
> +	int ret;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		ret = adxl367_get_act_interrupt_en(st, ADXL367_ACTIVITY, &en);
> +		return ret ?: en;
> +	case IIO_EV_DIR_FALLING:
> +		ret = adxl367_get_act_interrupt_en(st, ADXL367_INACTIVITY, &en);
> +		return ret ?: en;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adxl367_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      int state)
> +{
> +	struct adxl367_state *st = iio_priv(indio_dev);
> +	enum adxl367_activity_type act;
> +	int ret;
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		act = ADXL367_ACTIVITY;
> +		break;
> +	case IIO_EV_DIR_FALLING:
> +		act = ADXL367_INACTIVITY;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);

It's unusual (though not unheard of) to have events that cannot be enabled
at the same time as a fifo.  If that's true here, please add some comments
to explain why.  Or is this just about the impact of having to disable
the measurement to turn it on and the resulting interruption of data capture?

If so that needs more thought as we have a situation where you can (I think)
have events as long as you enable them before the fifo based capture is started,
but cannot enable them after.

> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	ret = adxl367_set_measure_en(st, false);
> +	if (ret)
> +		goto out;
> +
> +	ret = adxl367_set_act_interrupt_en(st, act, state);
> +	if (ret)
> +		goto out;
> +
> +	ret = adxl367_set_act_en(st, act, state ? ADCL367_ACT_REF_ENABLED
> +						: ADXL367_ACT_DISABLED);
> +	if (ret)
> +		goto out;
> +
> +	ret = adxl367_set_measure_en(st, true);
> +
> +out:
> +	mutex_unlock(&st->lock);
> +
> +	iio_device_release_direct_mode(indio_dev);
> +
> +	return ret;
> +}
> +

> +
> +static ssize_t adxl367_get_fifo_watermark(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct adxl367_state *st = iio_priv(indio_dev);
Trivial but in cases where you don't need the indio_dev, it
is find to roll the above two lines into one as the function names
express the types so no information is lost.

struct adxl367_state *st = iio_priv(dev_to_iio_dev(dev));

> +	unsigned int fifo_watermark;
> +
> +	mutex_lock(&st->lock);
> +	fifo_watermark = st->fifo_watermark;
> +	mutex_unlock(&st->lock);
> +
> +	return sysfs_emit(buf, "%d\n", fifo_watermark);
> +}
...
> +
> +static IIO_CONST_ATTR(hwfifo_watermark_min, "1");
> +static IIO_CONST_ATTR(hwfifo_watermark_max,
> +		      __stringify(ADXL367_FIFO_MAX_WATERMARK));
> +static IIO_DEVICE_ATTR(hwfifo_watermark, 0444,
> +		       adxl367_get_fifo_watermark, NULL, 0);
> +static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
> +		       adxl367_get_fifo_enabled, NULL, 0);
> +
> +static const struct attribute *adxl367_fifo_attributes[] = {
> +	&iio_const_attr_hwfifo_watermark_min.dev_attr.attr,
> +	&iio_const_attr_hwfifo_watermark_max.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_watermark.dev_attr.attr,
> +	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
> +	NULL,
> +};

...

> +static int adxl367_update_scan_mode(struct iio_dev *indio_dev,
> +				    const unsigned long *active_scan_mask)
> +{
> +	struct adxl367_state *st  = iio_priv(indio_dev);
> +	enum adxl367_fifo_format fifo_format;
> +	unsigned int fifo_set_size;
> +	int ret;
> +
> +	if (!adxl367_find_mask_fifo_format(active_scan_mask, &fifo_format))
> +		return -EINVAL;
> +
> +	fifo_set_size = bitmap_weight(active_scan_mask, indio_dev->masklength);
> +
> +	mutex_lock(&st->lock);
> +
> +	ret = adxl367_set_measure_en(st, false);
> +	if (ret)
> +		goto out;
> +
> +	ret = adxl367_set_fifo_format(st, fifo_format);
> +	if (ret)
> +		goto out;
> +
> +	ret = adxl367_set_fifo_set_size(st, fifo_set_size);
> +	if (ret)
> +		goto out;
> +
> +	ret = adxl367_set_measure_en(st, true);
> +
> +out:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int adxl367_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct adxl367_state *st  = iio_priv(indio_dev);
> +
> +	return adxl367_set_temp_adc_mask_en(st, indio_dev->active_scan_mask,
> +					    true);

Why the logical separation of the channel enable to here and fifo setup to
post_enable?  Reality is there is very little reason any more to have
separate preenable/posteenable.  If there is a reason to do it here, please
add a comment to explain. 
Is it because this needs to occur before update_scan_mode() is called?


> +}
> +
> +static int adxl367_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct adxl367_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	ret = adxl367_set_measure_en(st, false);
> +	if (ret)
> +		goto out;
> +
> +	ret = adxl367_set_fifo_watermark_interrupt_en(st, true);
> +	if (ret)
> +		goto out;
> +
> +	ret = adxl367_set_fifo_mode(st, ADXL367_FIFO_MODE_STREAM);
> +	if (ret)
> +		goto out;
> +
> +	ret = adxl367_set_measure_en(st, true);
> +
> +out:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int adxl367_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct adxl367_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	ret = adxl367_set_measure_en(st, false);
> +	if (ret)
> +		goto out;
> +
> +	ret = adxl367_set_fifo_mode(st, ADXL367_FIFO_MODE_DISABLED);
> +	if (ret)
> +		goto out;
> +
> +	ret = adxl367_set_fifo_watermark_interrupt_en(st, false);
> +	if (ret)
> +		goto out;
> +
> +	ret = adxl367_set_measure_en(st, true);
> +
> +out:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int adxl367_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct adxl367_state *st = iio_priv(indio_dev);
> +
> +	return adxl367_set_temp_adc_mask_en(st, indio_dev->active_scan_mask,
> +					    false);
> +}
> +

...


> +static int adxl367_setup(struct adxl367_state *st)
> +{
> +	int ret;
> +
> +	ret = _adxl367_set_act_threshold(st, ADXL367_ACTIVITY,
> +					 ADXL367_2G_RANGE_1G);
> +	if (ret)
> +		return ret;
> +
> +	ret = _adxl367_set_act_threshold(st, ADXL367_ACTIVITY,
> +					 ADXL367_2G_RANGE_100MG);

Should one of this pair be inactivity?

> +	if (ret)
> +		return ret;
> +
> +	ret = adxl367_set_act_proc_mode(st, ADXL367_LOOPED);
> +	if (ret)
> +		return ret;
> +
> +	ret = _adxl367_set_odr(st, ADXL367_ODR_400HZ);
> +	if (ret)
> +		return ret;
> +
> +	ret = _adxl367_set_act_time_ms(st, 10);
> +	if (ret)
> +		return ret;
> +
> +	ret = _adxl367_set_inact_time_ms(st, 10000);
> +	if (ret)
> +		return ret;
> +
> +	return adxl367_set_measure_en(st, true);
> +}
> +
> +static void adxl367_disable_regulators(void *data)
> +{
> +	struct adxl367_state *st = data;
> +
> +	regulator_bulk_disable(ARRAY_SIZE(st->regulators), st->regulators);
> +}
> +
> +int adxl367_probe(struct device *dev, const struct adxl367_ops *ops,
> +		  void *context, struct regmap *regmap, int irq)
> +{
> +	struct iio_dev *indio_dev;
> +	struct adxl367_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->dev = dev;
> +	st->regmap = regmap;
> +	st->context = context;
> +	st->ops = ops;
> +
> +	mutex_init(&st->lock);
> +
> +	indio_dev->channels = adxl367_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adxl367_channels);
> +	indio_dev->available_scan_masks = adxl367_channel_masks;
> +	indio_dev->name = "adxl367";
> +	indio_dev->info = &adxl367_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	st->regulators[0].supply = "vdd";
> +	st->regulators[1].supply = "vddio";
> +
> +	ret = devm_regulator_bulk_get(st->dev, ARRAY_SIZE(st->regulators),
> +				      st->regulators);
> +	if (ret)
> +		return dev_err_probe(st->dev, ret,
> +				     "Failed to get regulators\n");
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(st->regulators), st->regulators);
> +	if (ret)
> +		return dev_err_probe(st->dev, ret,
> +				     "Failed to enable regulators\n");
> +
> +	ret = devm_add_action_or_reset(st->dev, adxl367_disable_regulators, st);
> +	if (ret)
> +		return dev_err_probe(st->dev, ret,
> +				     "Failed to add regulators disable action\n");
> +
> +	ret = adxl367_verify_devid(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = adxl367_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = adxl367_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_kfifo_buffer_setup_ext(st->dev, indio_dev,
> +					      INDIO_BUFFER_SOFTWARE,
> +					      &adxl367_buffer_ops,
> +					      adxl367_fifo_attributes);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_threaded_irq(st->dev, irq, NULL,
> +					adxl367_irq_handler, IRQF_ONESHOT,
> +					indio_dev->name, indio_dev);
> +	if (ret)
> +		return dev_err_probe(st->dev, ret, "Failed to request irq\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +EXPORT_SYMBOL_GPL(adxl367_probe);

Something Andy raised in a recent review was that for cases like this
we should be using the NS variants so that we move stuff used only between
a smalls set of drivers into it's own namespace.

I think it is an excellent idea, and will hopefully convert a few drivers
over shortly.  In the meantime it would be good to ensure no new drivers
go in without using the NS support (EXPORT_SYMBOL_NS_GPL(adxl367_probe, adxl367) etc.

> +
> +MODULE_AUTHOR("Cosmin Tanislav <cosmin.tanislav@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADXL367 3-axis accelerometer driver");
> +MODULE_LICENSE("GPL");
