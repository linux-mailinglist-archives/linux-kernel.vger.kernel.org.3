Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BD14779F7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbhLPREc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:04:32 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51906 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbhLPREb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:04:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF7DE61E81;
        Thu, 16 Dec 2021 17:04:30 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id B158BC36AE0;
        Thu, 16 Dec 2021 17:04:27 +0000 (UTC)
Date:   Thu, 16 Dec 2021 17:09:50 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] iio: frequency: admv1013: add support for
 ADMV1013
Message-ID: <20211216170950.29ba6767@jic23-huawei>
In-Reply-To: <20211206154845.268445-1-antoniu.miclaus@analog.com>
References: <20211206154845.268445-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 17:48:43 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADMV1013 is a wideband, microwave upconverter optimized
> for point to point microwave radio designs operating in the
> 24 GHz to 44 GHz radio frequency (RF) range.
> 
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/ADMV1013.pdf
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Antoniu,

Sorry for slow response on these. End of year rush and all that
+ a day of booster side effects to make it extra fun.

Anyhow, things have gotten a bit disconnected with the changes in interface
so I don't think the calibbias attributes currently work.

Otherwise, I have an open question below on what we do about phase units.
_phase is supposed to be in radians, but I don't think they are calibrated
at all in this device.  There is a vague reference to 25 degree range, but
no actual detail on that...

Possibly the best we can do is note in docs somewhere that the value
is unscaled for this particular device. (The "raw" I asked you to drop
last time - I'd been assuming we could scale these - oops)

Hmm. maybe my naming suggest was wrong and we need to invent something
new such as i_calibphase?  What do you think?

These devices keep pushing the limits of what I've thought of as possible!

Jonathan


> ---
>  drivers/iio/frequency/Kconfig    |  11 +
>  drivers/iio/frequency/Makefile   |   1 +
>  drivers/iio/frequency/admv1013.c | 628 +++++++++++++++++++++++++++++++
>  3 files changed, 640 insertions(+)
>  create mode 100644 drivers/iio/frequency/admv1013.c
> 

> diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
> index 518b1e50caef..559922a8196e 100644
> --- a/drivers/iio/frequency/Makefile
> +++ b/drivers/iio/frequency/Makefile
> @@ -7,3 +7,4 @@
>  obj-$(CONFIG_AD9523) += ad9523.o
>  obj-$(CONFIG_ADF4350) += adf4350.o
>  obj-$(CONFIG_ADF4371) += adf4371.o
> +obj-$(CONFIG_ADMV1013) += admv1013.o
> diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
> new file mode 100644
> index 000000000000..ccefd79603fe
> --- /dev/null
> +++ b/drivers/iio/frequency/admv1013.c
> @@ -0,0 +1,628 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADMV1013 driver
> + *
> + * Copyright 2021 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>

All these clk headers needed? We only care about clks as a consumer
/ user of notifications.

...


> +struct admv1013_state {
> +	struct spi_device	*spi;
> +	struct clk		*clkin;
> +	/* Protect against concurrent accesses to the device and to data */
> +	struct mutex		lock;
> +	struct regulator	*reg;
> +	struct notifier_block	nb;
> +	unsigned int		input_mode;
> +	unsigned int		quad_se_mode;
> +	bool			det_en;
> +	u8			data[3] ____cacheline_aligned;
> +};
> +

...

> +static ssize_t admv1013_read(struct iio_dev *indio_dev,
> +			     uintptr_t private,
> +			     const struct iio_chan_spec *chan,
> +			     char *buf)
> +{
> +	struct admv1013_state *st = iio_priv(indio_dev);
> +	unsigned int data, addr;
> +	int ret;
> +
> +	if (chan->differential) {
> +		switch ((u32)private) {
> +		case ADMV1013_RFMOD_I_PHASE:
> +			addr = ADMV1013_REG_LO_AMP_I;
> +			break;
> +		case ADMV1013_RFMOD_Q_PHASE:
> +			addr = ADMV1013_REG_LO_AMP_Q;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		ret = admv1013_spi_read(st, addr, &data);
> +		if (ret)
> +			return ret;
> +
> +		data = FIELD_GET(ADMV1013_LOAMP_PH_ADJ_FINE_MSK, data);
> +	} else {

As below, some of this belongs in the read_raw callback as there doesn't
seem to be any way tot get to this code.

> +		switch (chan->channel) {
> +		case IIO_MOD_I:
> +			addr = ADMV1013_REG_OFFSET_ADJUST_I;
> +			break;
> +		case IIO_MOD_Q:
> +			addr = ADMV1013_REG_OFFSET_ADJUST_Q;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		ret = admv1013_spi_read(st, addr, &data);
> +
> +		if (!chan->channel)
> +			data = FIELD_GET(ADMV1013_MIXER_OFF_ADJ_P_MSK, data);
> +		else
> +			data = FIELD_GET(ADMV1013_MIXER_OFF_ADJ_N_MSK, data);
> +	}
> +
> +	return sysfs_emit(buf, "%u\n", data);
> +}
> +
> +static ssize_t admv1013_write(struct iio_dev *indio_dev,
> +			      uintptr_t private,
> +			      const struct iio_chan_spec *chan,
> +			      const char *buf, size_t len)
> +{
> +	struct admv1013_state *st = iio_priv(indio_dev);
> +	unsigned int data, addr, msk;
> +	int ret;
> +
> +	ret = kstrtou32(buf, 10, &data);

So we have a quirk here that we may want to 'fix'.
Phase units in IIO are in radians, but the issue here is that we
don't have any real information on what the units of this are that I can find.

> +	if (ret)
> +		return ret;
> +
> +	if (chan->differential) {
> +		data = FIELD_PREP(ADMV1013_LOAMP_PH_ADJ_FINE_MSK, data);
> +
> +		switch ((u32)private) {
> +		case ADMV1013_RFMOD_I_PHASE:
> +			ret = admv1013_spi_update_bits(st, ADMV1013_REG_LO_AMP_I,
> +						       ADMV1013_LOAMP_PH_ADJ_FINE_MSK,
> +						       data);
> +			if (ret)
> +				return ret;
> +			break;
> +		case ADMV1013_RFMOD_Q_PHASE:
> +			ret = admv1013_spi_update_bits(st, ADMV1013_REG_LO_AMP_Q,
> +						       ADMV1013_LOAMP_PH_ADJ_FINE_MSK,
> +						       data);
> +			if (ret)
> +				return ret;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	} else {

How do you get to this branch?  I think these calibbias offsets are now handled
via write_raw callback as they fit in the standard ABI.

> +		switch (chan->channel2) {
> +		case IIO_MOD_I:
> +			addr = ADMV1013_REG_OFFSET_ADJUST_I;
> +			break;
> +		case IIO_MOD_Q:
> +			addr = ADMV1013_REG_OFFSET_ADJUST_Q;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		if (!chan->channel) {
> +			msk = ADMV1013_MIXER_OFF_ADJ_P_MSK;
> +			data = FIELD_PREP(ADMV1013_MIXER_OFF_ADJ_P_MSK, data);
> +		} else {
> +			msk = ADMV1013_MIXER_OFF_ADJ_N_MSK;
> +			data = FIELD_PREP(ADMV1013_MIXER_OFF_ADJ_N_MSK, data);
> +		}
> +
> +		ret = admv1013_spi_update_bits(st, addr, msk, data);
> +	}
> +
> +	return ret ? ret : len;
> +}


> +
> +#define _ADMV1013_EXT_INFO(_name, _shared, _ident) { \
> +		.name = _name, \
> +		.read = admv1013_read, \
> +		.write = admv1013_write, \
> +		.private = _ident, \
> +		.shared = _shared, \
> +}
> +
> +static const struct iio_chan_spec_ext_info admv1013_ext_info[] = {
> +	_ADMV1013_EXT_INFO("i_phase", IIO_SEPARATE, ADMV1013_RFMOD_I_PHASE),
> +	_ADMV1013_EXT_INFO("q_phase", IIO_SEPARATE, ADMV1013_RFMOD_Q_PHASE),
> +	{ },
> +};
> +
> +#define ADMV1013_CHAN_PHASE(_channel, _channel2, _admv1013_ext_info) {		\
> +	.type = IIO_ALTVOLTAGE,					\
> +	.output = 0,						\
> +	.indexed = 1,						\
> +	.channel2 = _channel2,					\
> +	.channel = _channel,					\
> +	.differential = 1,					\
> +	.ext_info = _admv1013_ext_info,				\
> +	}
> +
> +#define ADMV1013_CHAN_CALIB(_channel, rf_comp) {	\
> +	.type = IIO_ALTVOLTAGE,					\
> +	.output = 0,						\
> +	.indexed = 1,						\
> +	.channel = _channel,					\
> +	.channel2 = IIO_MOD_##rf_comp,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBBIAS),	\
> +	}
> +
> +static const struct iio_chan_spec admv1013_channels[] = {
> +	ADMV1013_CHAN_PHASE(0, 1, admv1013_ext_info),
> +	ADMV1013_CHAN_CALIB(0, I),
> +	ADMV1013_CHAN_CALIB(0, Q),
> +	ADMV1013_CHAN_CALIB(1, I),
> +	ADMV1013_CHAN_CALIB(1, Q),
> +};
> +
> +static int admv1013_init(struct admv1013_state *st)
> +{
> +	int ret;
> +	unsigned int data;
> +	struct spi_device *spi = st->spi;

Trivial but the following would be more useful in this function.

struct device *dev = &st->spi->dev;

> +
> +	/* Perform a software reset */
> +	ret = __admv1013_spi_update_bits(st, ADMV1013_REG_SPI_CONTROL,
> +					 ADMV1013_SPI_SOFT_RESET_MSK,
> +					 FIELD_PREP(ADMV1013_SPI_SOFT_RESET_MSK, 1));
> +	if (ret)
> +		return ret;
> +
> +	ret = __admv1013_spi_update_bits(st, ADMV1013_REG_SPI_CONTROL,
> +					 ADMV1013_SPI_SOFT_RESET_MSK,
> +					 FIELD_PREP(ADMV1013_SPI_SOFT_RESET_MSK, 0));
> +	if (ret)
> +		return ret;
> +
> +	ret = __admv1013_spi_read(st, ADMV1013_REG_SPI_CONTROL, &data);
> +	if (ret)
> +		return ret;
> +
> +	data = FIELD_GET(ADMV1013_CHIP_ID_MSK, data);
> +	if (data != ADMV1013_CHIP_ID) {
> +		dev_err(&spi->dev, "Invalid Chip ID.\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = __admv1013_spi_write(st, ADMV1013_REG_VVA_TEMP_COMP, 0xE700);
> +	if (ret)
> +		return ret;
> +
> +	data = FIELD_PREP(ADMV1013_QUAD_SE_MODE_MSK, st->quad_se_mode);
> +
> +	ret = __admv1013_spi_update_bits(st, ADMV1013_REG_QUAD,
> +					 ADMV1013_QUAD_SE_MODE_MSK, data);
> +	if (ret)
> +		return ret;
> +
> +	ret = admv1013_update_mixer_vgate(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = admv1013_update_quad_filters(st);
> +	if (ret)
> +		return ret;
> +
> +	return __admv1013_spi_update_bits(st, ADMV1013_REG_ENABLE,
> +					  ADMV1013_DET_EN_MSK |
> +					  ADMV1013_MIXER_IF_EN_MSK,
> +					  st->det_en |
> +					  st->input_mode);
> +}
> +

