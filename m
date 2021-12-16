Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066944771FE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbhLPMkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhLPMku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:40:50 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4476C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 04:40:49 -0800 (PST)
Received: from [81.101.6.87] (port=52564 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1mxpap-0001lo-ON; Thu, 16 Dec 2021 12:10:40 +0000
Date:   Thu, 16 Dec 2021 12:15:58 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: accel: add ADXL367 driver
Message-ID: <20211216121518.4f5d1e82@jic23-huawei>
In-Reply-To: <32968eda-e243-5420-77e5-41dd16f1e870@gmail.com>
References: <20211207094337.59300-1-cosmin.tanislav@analog.com>
        <20211207094337.59300-3-cosmin.tanislav@analog.com>
        <20211212170433.467b93a9@jic23-huawei>
        <32968eda-e243-5420-77e5-41dd16f1e870@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2021 21:25:46 +0200
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> On 12/12/21 19:04, Jonathan Cameron wrote:
> > On Tue,  7 Dec 2021 11:43:37 +0200
> > Cosmin Tanislav <demonsingur@gmail.com> wrote:
> >   
> >> The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.
> >>
> >> The ADXL367 does not alias input signals to achieve ultralow power
> >> consumption, it samples the full bandwidth of the sensor at all
> >> data rates. Measurement ranges of +-2g, +-4g, and +-8g are available,
> >> with a resolution of 0.25mg/LSB on the +-2 g range.
> >>
> >> In addition to its ultralow power consumption, the ADXL367
> >> has many features to enable true system level power reduction.
> >> It includes a deep multimode output FIFO, a built-in micropower
> >> temperature sensor, and an internal ADC for synchronous conversion
> >> of an additional analog input.
> >>
> >> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>  
> > Hi Cosmin,
> > 
> > I'd gotten half way through this on v1, but not had a chance to finish
> > an initial review. I've cut and paste over comments, and added more stuff
> > but it is possible some of them don't make complete sense any more.
> > 
> > Anyhow, various comments inline.
> > 
> > Thanks,
> > 
> > Jonathan  
> 
> Could you also take a look at the question asked in the cover letter 
> about locking?

Others covered it much better than I would have done :)

> 
> >   
> >> ---
> >>   MAINTAINERS                     |   11 +
> >>   drivers/iio/accel/Kconfig       |   27 +
> >>   drivers/iio/accel/Makefile      |    3 +
> >>   drivers/iio/accel/adxl367.c     | 1696 +++++++++++++++++++++++++++++++
> >>   drivers/iio/accel/adxl367.h     |   24 +
> >>   drivers/iio/accel/adxl367_i2c.c |   89 ++
> >>   drivers/iio/accel/adxl367_spi.c |  151 +++
> >>   7 files changed, 2001 insertions(+)
> >>   create mode 100644 drivers/iio/accel/adxl367.c
> >>   create mode 100644 drivers/iio/accel/adxl367.h
> >>   create mode 100644 drivers/iio/accel/adxl367_i2c.c
> >>   create mode 100644 drivers/iio/accel/adxl367_spi.c
> >>

...

> >> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> >> index d03e2f6bba08..4d8792668838 100644
> >> --- a/drivers/iio/accel/Makefile
> >> +++ b/drivers/iio/accel/Makefile
> >> @@ -15,6 +15,9 @@ obj-$(CONFIG_ADXL345_SPI) += adxl345_spi.o
> >>   obj-$(CONFIG_ADXL355) += adxl355_core.o
> >>   obj-$(CONFIG_ADXL355_I2C) += adxl355_i2c.o
> >>   obj-$(CONFIG_ADXL355_SPI) += adxl355_spi.o
> >> +obj-$(CONFIG_ADXL367) += adxl367.o
> >> +obj-$(CONFIG_ADXL367_I2C) += adxl367_i2c.o
> >> +obj-$(CONFIG_ADXL367_SPI) += adxl367_spi.o
> >>   obj-$(CONFIG_ADXL372) += adxl372.o
> >>   obj-$(CONFIG_ADXL372_I2C) += adxl372_i2c.o
> >>   obj-$(CONFIG_ADXL372_SPI) += adxl372_spi.o
> >> diff --git a/drivers/iio/accel/adxl367.c b/drivers/iio/accel/adxl367.c
> >> new file mode 100644
> >> index 000000000000..df8d859e5483
> >> --- /dev/null
> >> +++ b/drivers/iio/accel/adxl367.c
> >> @@ -0,0 +1,1696 @@

...

> >> +static const unsigned long adxl367_channel_masks[] = {  
> > 
> > If these are the valid masks and can be easily laid out like this why
> > not use the core support for available_scan_masks and
> > the demux it provides?  
> 
> Mostly because I need to run the same validation in
> update_scan_mode to figure out the fifo format.
> I would just be running the same function twice.

Ok.  So the issue is the reverse lookup in there.

Been a while since I looked at how that bit worked, but IIRC there
is a disadvantage in that using the validate_scan_mask path
doesn't let us use the demux.  So that means we can only
start the buffer if using a mask from the below.  

Hence if we have XY it won't start.  If we do it via 
available_scan_masks (with the resulting duplication) of
some of the information in the driver, then we'll be able to enable
just those two channels and the core will pick XYZ and drop
the Z channel for us automatically.

> 
> >   
> >> +	[ADXL367_FIFO_FORMAT_XYZ]  = ADXL367_X_CHANNEL_MASK
> >> +				     | ADXL367_Y_CHANNEL_MASK
> >> +				     | ADXL367_Z_CHANNEL_MASK,
> >> +	[ADXL367_FIFO_FORMAT_X]    = ADXL367_X_CHANNEL_MASK,
> >> +	[ADXL367_FIFO_FORMAT_Y]    = ADXL367_Y_CHANNEL_MASK,
> >> +	[ADXL367_FIFO_FORMAT_Z]    = ADXL367_Z_CHANNEL_MASK,
> >> +	[ADXL367_FIFO_FORMAT_XYZT] = ADXL367_X_CHANNEL_MASK
> >> +				     | ADXL367_Y_CHANNEL_MASK
> >> +				     | ADXL367_Z_CHANNEL_MASK
> >> +				     | ADXL367_TEMP_CHANNEL_MASK,
> >> +	[ADXL367_FIFO_FORMAT_XT]   = ADXL367_X_CHANNEL_MASK
> >> +				     | ADXL367_TEMP_CHANNEL_MASK,
> >> +	[ADXL367_FIFO_FORMAT_YT]   = ADXL367_Y_CHANNEL_MASK
> >> +				     | ADXL367_TEMP_CHANNEL_MASK,
> >> +	[ADXL367_FIFO_FORMAT_ZT]   = ADXL367_Z_CHANNEL_MASK
> >> +				     | ADXL367_TEMP_CHANNEL_MASK,
> >> +	[ADXL367_FIFO_FORMAT_XYZA] = ADXL367_X_CHANNEL_MASK
> >> +				     | ADXL367_Y_CHANNEL_MASK
> >> +				     | ADXL367_Z_CHANNEL_MASK
> >> +				     | ADXL367_EX_ADC_CHANNEL_MASK,
> >> +	[ADXL367_FIFO_FORMAT_XA]   = ADXL367_X_CHANNEL_MASK
> >> +				     | ADXL367_EX_ADC_CHANNEL_MASK,
> >> +	[ADXL367_FIFO_FORMAT_YA]   = ADXL367_Y_CHANNEL_MASK
> >> +				     | ADXL367_EX_ADC_CHANNEL_MASK,
> >> +	[ADXL367_FIFO_FORMAT_ZA]   = ADXL367_Z_CHANNEL_MASK
> >> +				     | ADXL367_EX_ADC_CHANNEL_MASK,
> >> +};
> >> +
> >> +static int adxl367_set_measure_en(struct adxl367_state *st, bool en)
> >> +{
> >> +	enum adxl367_op_mode op_mode = en ? ADXL367_OP_MEASURE
> >> +					  : ADXL367_OP_STANDBY;
> >> +	int ret;
> >> +
> >> +	ret = regmap_update_bits(st->regmap, ADXL367_REG_POWER_CTL,
> >> +				 ADXL367_POWER_CTL_MODE_MASK,
> >> +				 FIELD_PREP(ADXL367_POWER_CTL_MODE_MASK,
> >> +					    op_mode));
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/*
> >> +	 * Wait for acceleration output to settle after entering
> >> +	 * measure mode.
> >> +	 */
> >> +	if (en)
> >> +		msleep(100);  
> > 
> > This is interesting.  Worth thinking about how to make this work with
> > runtime_pm and autosuspend.  My guess is you should enable autosuspend
> > with maybe a a 1 second delay if not doing fifo based capture.
> > 
> > That is fine as a follow up patch when someone needs it as the handling
> > will be a little complex given you need it to be off for some paths.
> >   
> 
> Take into account that measurement mode also needs to be enabled if
> activity events are expected, which would limit the cases in which
> I could disable measurement mode as a power management feature.

yup.  It will be one whenever the device is being used (events or
data).

> 
> I thought of another thing regarding this delay. I could store
> a timestamp of when measurement mode was turned on, and only
> sleep when acquiring data, if needed. 100ms might have already
> passed by the time the data acquisition functions are called.

That sounds like it might be premature optimization but interesting
idea if you can justify the complexity.

> 
> >> +
> >> +	return 0;
> >> +}  
> >   
> >> +static int _adxl367_set_act_threshold(struct adxl367_state *st,
> >> +				      enum adxl367_activity_type act,
> >> +				      unsigned int threshold)
> >> +{
> >> +	u8 reg = adxl367_threshold_h_reg_tbl[act];
> >> +	struct reg_sequence reg_seq[] = {
> >> +		{ reg },
> >> +		{ reg + 1 },
> >> +	};
> >> +	int ret;
> >> +
> >> +	if (threshold > ADXL367_THRESH_MAX)
> >> +		return -EINVAL;
> >> +
> >> +	reg_seq[0].def = FIELD_PREP(ADXL367_THRESH_H_MASK,
> >> +				    FIELD_GET(ADXL367_THRESH_VAL_H_MASK,
> >> +					      threshold));
> >> +	reg_seq[1].def = FIELD_PREP(ADXL367_THRESH_L_MASK,
> >> +				    FIELD_GET(ADXL367_THRESH_VAL_L_MASK,
> >> +					      threshold));
> >> +
> >> +	ret = regmap_multi_reg_write(st->regmap, reg_seq, ARRAY_SIZE(reg_seq));
> >> +	if (ret)
> >> +		return ret;  
> > 
> > Given addresses are sequential you should be fine with regmap_bulk_write() I think?  
> 
> Using regmap_bulk_write would mean allocating a DMA-safe buffer 
> somewhere, and it would not be that useful for this one use only.

ok. Definitely add a comment on that as wasn't obvious to me at least :)

I'm not sure the balance is right though as side effect might be a longer bus transaction
and those tend to be much more complex than a bit of indirection to use a dma safe buffer
in adxl367_state.


> 
> >   
> >> +
> >> +	if (act == ADXL367_ACTIVITY)
> >> +		st->act_threshold = threshold;
> >> +	else
> >> +		st->inact_threshold = threshold;
> >> +
> >> +	return 0;
> >> +}
> >> +  
> > 
> > 
> > ...

...

> >> +	case IIO_CHAN_INFO_SAMP_FREQ:
> >> +		mutex_lock(&st->lock);
> >> +		*val = adxl367_samp_freq_tbl[st->odr][0];
> >> +		*val2 = adxl367_samp_freq_tbl[st->odr][1];
> >> +		mutex_unlock(&st->lock);
> >> +		return IIO_VAL_INT_PLUS_MICRO;
> >> +	case IIO_CHAN_INFO_ENABLE:  
> > 
> > Ah. you are using enable to pick between temp and ex.
> > Why?  Do it on the channel read, or based on the active_scan_mask
> > when enabling the buffer.
> > 
> > If that's slower than it would otherwise be, such is life. Reading
> > via sysfs is slow anyway and for the buffered path you will only
> > be doing this once.
> >   
> I'm aware this is a bit ugly but I wasn't sure how to go about it.
> Yes, enabling the channels automatically is cleaner for the user, but it 
> is undocumented how much time the ADC data takes to settle after 
> enabling it.

Probably dependent on external circuitry making it impossible to
define in the datasheet so you could add a fw property to describe it.
There are various similar cases for other devices.

> 
> >> +		switch (chan->type) {
> >> +		case IIO_TEMP:
> >> +			mutex_lock(&st->lock);
> >> +			*val = st->adc_mode == ADXL367_ADC_MODE_TEMP;
> >> +			mutex_unlock(&st->lock);
> >> +			return IIO_VAL_INT;
> >> +		case IIO_VOLTAGE:
> >> +			mutex_lock(&st->lock);
> >> +			*val = st->adc_mode == ADXL367_ADC_MODE_EX;
> >> +			mutex_unlock(&st->lock);
> >> +			return IIO_VAL_INT;
> >> +		default:
> >> +			return -EINVAL;
> >> +		}
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +}
> >> +

...


> >> +
> >> +static int adxl367_read_fifo(void *context, __be16 *fifo_buf,
> >> +			     unsigned int fifo_entries)
> >> +{
> >> +	struct adxl367_spi_state *st = context;
> >> +
> >> +	st->fifo_xfer[1].rx_buf = fifo_buf;
> >> +	st->fifo_xfer[1].len = fifo_entries * sizeof(*fifo_buf);
> >> +  
> > 
> > For this fifo case, I'm fine with it being more complex.
> > 
> >   
> >> +	return spi_sync(st->spi, &st->fifo_msg);
> >> +}
> >> +
> >> +static int adxl367_read(void *context, const void *reg_buf, size_t reg_size,
> >> +			void *val_buf, size_t val_size)
> >> +{
> >> +	struct adxl367_spi_state *st = context;
> >> +	u8 reg = ((u8 *)reg_buf)[0];  
> > 
> > Keep it const for the cast.
> > 
> >   +  
> >> +	st->reg_read_tx_buf[1] = reg;
> >> +	st->reg_read_xfer[1].rx_buf = val_buf;
> >> +	st->reg_read_xfer[1].len = val_size;
> >> +  
> > 
> > For this one it would be not much costly to  just use spi_write_then_read()
> > and end up with a few more copies.  
> 
> Which would mean I'd have to create a u8[2] here, fill it with the 
> command and register, then call spi_write_then_read, which will also 
> copy both buffers (for the second time, depending on which regmap API 
> calls this function, it might have been copied before) into DMA safe 
> buffers, and which might also have to allocate the DMA-safe buffers if 
> the pre-allocated buffer is already in use or too small. The assumption 
> that it "would be not much costly" only takes into account the current 
> usecase, which doesn't read more than 3 bytes at a time. But who knows 
> how this driver might be modified / used in the future.

Unlikely to be many that are actually in a fast path, but it is 'possible'.

> 
> In my head, these are enough disadvantages to just prepare an 
> spi_message beforehand and only have to fill in the newly supplied data. 
> I don't find the usage of spi_message to make the data being transfered 
> much harder to understand.
> 
> I usually just do as you say to make sure the process goes smoothly and 
> we can get the driver merged faster, but sometimes I just think it is 
> worth discussing. I'm sure you can recognize that some of this stuff is 
> just a matter of opinion.

Of course :)  I just want easy to read code where possible as then
I don't have to think too much if I need to do something with this driver
in 5+ years time!

Perhaps a comment providing information here on what the data layout
actually is would be in order?

> 
> >   
> >> +	return spi_sync(st->spi, &st->reg_read_msg);
> >> +}
> >> +
> >> +static int adxl367_write(void *context, const void *val_buf, size_t val_size)
> >> +{
> >> +	struct adxl367_spi_state *st = context;
> >> +
> >> +	st->reg_write_xfer[1].tx_buf = val_buf;
> >> +	st->reg_write_xfer[1].len = val_size;  
> > 
> > I'm in two minds about whether it is worth the complexity you have here.
> > You could just copy a few more things for the small read/write cases and
> > not bother with the pre setup etc.
> > 
> > This is particular so because you aren't messing with cs_change or
> > anything like that so I assume the write could be a single transfer.
> >   
> The write case would mean that I'd have to limit the maximum raw write 
> size, or allocate a buffer dynamically to also fit the command in the 
> write buffer.

A realloc strategy would mean you only did the alloc once, but that would
indeed make it more complex.

I'll plead brain being slow on Sunday due to booster vaccine though
sadly I only get to use that excuse occasionally :)

> 
> >> +
> >> +	return spi_sync(st->spi, &st->reg_write_msg);
> >> +}

Thanks,

Jonathan
