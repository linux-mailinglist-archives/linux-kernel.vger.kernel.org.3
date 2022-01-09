Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153B5488B77
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 18:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbiAIRz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 12:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiAIRz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 12:55:57 -0500
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A567FC06173F;
        Sun,  9 Jan 2022 09:55:56 -0800 (PST)
Received: from [81.101.6.87] (port=35382 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n6cQ0-0005na-DE; Sun, 09 Jan 2022 17:55:52 +0000
Date:   Sun, 9 Jan 2022 18:01:39 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio:frequency:admv1014: add support for ADMV1014
Message-ID: <20220109180131.753e7d27@jic23-huawei>
In-Reply-To: <20220103092201.21576-2-antoniu.miclaus@analog.com>
References: <20220103092201.21576-1-antoniu.miclaus@analog.com>
        <20220103092201.21576-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jan 2022 11:21:59 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADMV1014 is a silicon germanium (SiGe), wideband,
> microwave downconverter optimized for point to point microwave
> radio designs operating in the 24 GHz to 44 GHz frequency range.
> 
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/ADMV1014.pdf

One line as it's a tag. (doesn't matter it if is too long in this case :)

> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  drivers/iio/frequency/Kconfig    |  10 +
>  drivers/iio/frequency/Makefile   |   1 +
>  drivers/iio/frequency/admv1014.c | 784 +++++++++++++++++++++++++++++++
>  3 files changed, 795 insertions(+)
>  create mode 100644 drivers/iio/frequency/admv1014.c
> 
> diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
> index 2c9e0559e8a4..493221f42077 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig
> @@ -50,6 +50,16 @@ config ADF4371
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called adf4371.
>  
> +config ADMV1014
> +	tristate "Analog Devices ADMV1014 Microwave Downconverter"
> +	depends on SPI && COMMON_CLK && 64BIT
> +	help
> +	  Say yes here to build support for Analog Devices ADMV1014
> +	  24 GHz to 44 GHz, Wideband, Microwave Downconverter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called admv1014.
> +
>  config ADRF6780
>          tristate "Analog Devices ADRF6780 Microwave Upconverter"
>          depends on SPI
> diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
> index ae3136c79202..5f0348e5eb53 100644
> --- a/drivers/iio/frequency/Makefile
> +++ b/drivers/iio/frequency/Makefile
> @@ -7,4 +7,5 @@
>  obj-$(CONFIG_AD9523) += ad9523.o
>  obj-$(CONFIG_ADF4350) += adf4350.o
>  obj-$(CONFIG_ADF4371) += adf4371.o
> +obj-$(CONFIG_ADMV1014) += admv1014.o
>  obj-$(CONFIG_ADRF6780) += adrf6780.o
> diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1014.c
> new file mode 100644
> index 000000000000..2b6c38e82f92
> --- /dev/null
> +++ b/drivers/iio/frequency/admv1014.c
> @@ -0,0 +1,784 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADMV1014 driver
> + *
> + * Copyright 2021 Analog Devices Inc.

2022? :)

> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/notifier.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +
> +#include <asm/unaligned.h>
> +
> +/* ADMV1014 Register Map */
> +#define ADMV1014_REG_SPI_CONTROL		0x00
> +#define ADMV1014_REG_ALARM			0x01
> +#define ADMV1014_REG_ALARM_MASKS		0x02
> +#define ADMV1014_REG_ENABLE			0x03
> +#define ADMV1014_REG_QUAD			0x04
> +#define ADMV1014_REG_LO_AMP_PHASE_ADJUST1	0x05
> +#define ADMV1014_REG_MIXER			0x07
> +#define ADMV1014_REG_IF_AMP			0x08
> +#define ADMV1014_REG_IF_AMP_BB_AMP		0x09
> +#define ADMV1014_REG_BB_AMP_AGC			0x0A
> +#define ADMV1014_REG_VVA_TEMP_COMP		0x0B
> +
> +/* ADMV1014_REG_SPI_CONTROL Map */
> +#define ADMV1014_PARITY_EN_MSK			BIT(15)
> +#define ADMV1014_SPI_SOFT_RESET_MSK		BIT(14)
> +#define ADMV1014_CHIP_ID_MSK			GENMASK(11, 4)
> +#define ADMV1014_CHIP_ID			0x9
> +#define ADMV1014_REVISION_ID_MSK		GENMASK(3, 0)
> +
> +/* ADMV1014_REG_ALARM Map */
> +#define ADMV1014_PARITY_ERROR_MSK		BIT(15)
> +#define ADMV1014_TOO_FEW_ERRORS_MSK		BIT(14)
> +#define ADMV1014_TOO_MANY_ERRORS_MSK		BIT(13)
> +#define ADMV1014_ADDRESS_RANGE_ERROR_MSK	BIT(12)
> +
> +/* ADMV1014_REG_ENABLE Map */
> +#define ADMV1014_IBIAS_PD_MSK			BIT(14)
> +#define ADMV1014_P1DB_COMPENSATION_MSK		GENMASK(13, 12)
> +#define ADMV1014_IF_AMP_PD_MSK			BIT(11)
> +#define ADMV1014_QUAD_BG_PD_MSK			BIT(9)
> +#define ADMV1014_BB_AMP_PD_MSK			BIT(8)
> +#define ADMV1014_QUAD_IBIAS_PD_MSK		BIT(7)
> +#define ADMV1014_DET_EN_MSK			BIT(6)
> +#define ADMV1014_BG_PD_MSK			BIT(5)
> +
> +/* ADMV1014_REG_QUAD Map */
> +#define ADMV1014_QUAD_SE_MODE_MSK		GENMASK(9, 6)
> +#define ADMV1014_QUAD_FILTERS_MSK		GENMASK(3, 0)
> +
> +/* ADMV1014_REG_LO_AMP_PHASE_ADJUST1 Map */
> +#define ADMV1014_LOAMP_PH_ADJ_I_FINE_MSK	GENMASK(15, 9)
> +#define ADMV1014_LOAMP_PH_ADJ_Q_FINE_MSK	GENMASK(8, 2)
> +
> +/* ADMV1014_REG_MIXER Map */
> +#define ADMV1014_MIXER_VGATE_MSK		GENMASK(15, 9)
> +#define ADMV1014_DET_PROG_MSK			GENMASK(6, 0)
> +
> +/* ADMV1014_REG_IF_AMP Map */
> +#define ADMV1014_IF_AMP_COARSE_GAIN_I_MSK	GENMASK(11, 8)
> +#define ADMV1014_IF_AMP_FINE_GAIN_Q_MSK		GENMASK(7, 4)
> +#define ADMV1014_IF_AMP_FINE_GAIN_I_MSK		GENMASK(3, 0)
> +
> +/* ADMV1014_REG_IF_AMP_BB_AMP Map */
> +#define ADMV1014_IF_AMP_COARSE_GAIN_Q_MSK	GENMASK(15, 12)
> +#define ADMV1014_BB_AMP_OFFSET_Q_MSK		GENMASK(9, 5)
> +#define ADMV1014_BB_AMP_OFFSET_I_MSK		GENMASK(4, 0)
> +
> +/* ADMV1014_REG_BB_AMP_AGC Map */
> +#define ADMV1014_BB_AMP_REF_GEN_MSK		GENMASK(6, 3)
> +#define ADMV1014_BB_AMP_GAIN_CTRL_MSK		GENMASK(2, 1)
> +#define ADMV1014_BB_SWITCH_HIGH_LOW_CM_MSK	BIT(0)
> +
> +/* ADMV1014_REG_VVA_TEMP_COMP Map */
> +#define ADMV1014_VVA_TEMP_COMP_MSK		GENMASK(15, 0)
> +
> +/* ADMV1014 Miscellaneous Defines */
> +#define ADMV1014_READ				BIT(7)
> +#define ADMV1014_REG_ADDR_READ_MSK		GENMASK(6, 1)
> +#define ADMV1014_REG_ADDR_WRITE_MSK		GENMASK(22, 17)
> +#define ADMV1014_REG_DATA_MSK			GENMASK(16, 1)
> +
> +enum {
> +	ADMV1014_IQ_MODE,
> +	ADMV1014_IF_MODE
> +};
> +
> +enum {
> +	ADMV1014_SE_MODE_POS = 6,
> +	ADMV1014_SE_MODE_NEG = 9,
> +	ADMV1014_SE_MODE_DIFF = 12
> +};
> +
> +enum {
> +	ADMV1014_GAIN_COARSE,
> +	ADMV1014_GAIN_FINE,
> +};
> +
> +static const int detector_table[] = {0, 1, 2, 4, 8, 16, 32, 64};
> +
> +struct admv1014_state {
> +	struct spi_device	*spi;
> +	struct clk		*clkin;
> +	struct notifier_block	nb;
> +	/* Protect against concurrent accesses to the device and to data*/
> +	struct mutex		lock;
> +	struct regulator	*reg;
> +	unsigned int		input_mode;
> +	unsigned int		quad_se_mode;
> +	unsigned int		p1db_comp;
> +	bool			det_en;
> +	u8			data[3] ____cacheline_aligned;
> +};
> +
> +static const int mixer_vgate_table[] = {106, 107, 108, 110, 111, 112, 113, 114, 117, 118, 119, 120, 122, 123, 44, 45};
> +
> +static int __admv1014_spi_read(struct admv1014_state *st, unsigned int reg,
> +			       unsigned int *val)
> +{
> +	int ret;
> +	struct spi_transfer t = {0};
> +
> +	st->data[0] = ADMV1014_READ | FIELD_PREP(ADMV1014_REG_ADDR_READ_MSK, reg);
> +	st->data[1] = 0x0;
> +	st->data[2] = 0x0;
> +
> +	t.rx_buf = &st->data[0];
> +	t.tx_buf = &st->data[0];
> +	t.len = 3;
> +
> +	ret = spi_sync_transfer(st->spi, &t, 1);
> +	if (ret)
> +		return ret;
> +
> +	*val = FIELD_GET(ADMV1014_REG_DATA_MSK, get_unaligned_be24(&st->data[0]));

This looks like it would be easy enough to support with regmap and that might reduce
the number of custom read/write functions + let you use caching etc for free.

> +
> +	return ret;
> +}
> +
> +static int admv1014_spi_read(struct admv1014_state *st, unsigned int reg,
> +			     unsigned int *val)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = __admv1014_spi_read(st, reg, val);
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int __admv1014_spi_write(struct admv1014_state *st,
> +				unsigned int reg,
> +				unsigned int val)
> +{
> +	put_unaligned_be24(FIELD_PREP(ADMV1014_REG_DATA_MSK, val) |
> +			   FIELD_PREP(ADMV1014_REG_ADDR_WRITE_MSK, reg), &st->data[0]);
> +
> +	return spi_write(st->spi, &st->data[0], 3);
> +}
> +
> +static int admv1014_spi_write(struct admv1014_state *st, unsigned int reg,
> +			      unsigned int val)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = __admv1014_spi_write(st, reg, val);
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int __admv1014_spi_update_bits(struct admv1014_state *st, unsigned int reg,
> +				      unsigned int mask, unsigned int val)
> +{
> +	int ret;
> +	unsigned int data, temp;
> +
> +	ret = __admv1014_spi_read(st, reg, &data);
> +	if (ret)
> +		return ret;
> +
> +	temp = (data & ~mask) | (val & mask);
> +
> +	return __admv1014_spi_write(st, reg, temp);
> +}
> +
> +static int admv1014_spi_update_bits(struct admv1014_state *st, unsigned int reg,
> +				    unsigned int mask, unsigned int val)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = __admv1014_spi_update_bits(st, reg, mask, val);
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int admv1014_update_quad_filters(struct admv1014_state *st)
> +{
> +	unsigned int filt_raw;
> +	u64 rate = clk_get_rate(st->clkin);
> +
> +	if (rate >= (5400 * HZ_PER_MHZ) && rate <= (7000 * HZ_PER_MHZ))
> +		filt_raw = 15;
> +	else if (rate >= (5400 * HZ_PER_MHZ) && rate <= (8000 * HZ_PER_MHZ))
> +		filt_raw = 10;
> +	else if (rate >= (6600 * HZ_PER_MHZ) && rate <= (9200 * HZ_PER_MHZ))
> +		filt_raw = 5;
> +	else
> +		filt_raw = 0;
> +
> +	return __admv1014_spi_update_bits(st, ADMV1014_REG_QUAD,
> +					ADMV1014_QUAD_FILTERS_MSK,
> +					FIELD_PREP(ADMV1014_QUAD_FILTERS_MSK, filt_raw));
> +}
> +
> +static int admv1014_update_vcm_settings(struct admv1014_state *st)
> +{
> +	unsigned int i, vcm_mv, vcm_comp, bb_sw_high_low_cm;
> +	int ret;
> +
> +	vcm_mv = regulator_get_voltage(st->reg) / 1000;
> +	for (i = 0; i < ARRAY_SIZE(mixer_vgate_table); i++) {
> +		vcm_comp = 1050 + (i * 50) + (i / 8 * 50);
> +		if (vcm_mv == vcm_comp) {
Where you can invert a condition to reduce indenting, do so.
		if (vcm_mv != vcm_comp)
			continue;
	
		ret = 
> +			ret = __admv1014_spi_update_bits(st, ADMV1014_REG_MIXER,
> +							 ADMV1014_MIXER_VGATE_MSK,
> +							 FIELD_PREP(ADMV1014_MIXER_VGATE_MSK,
> +								    mixer_vgate_table[i]));
> +			if (ret)
> +				return ret;
> +
> +			bb_sw_high_low_cm = ~(i / 8);
> +
> +			return __admv1014_spi_update_bits(st, ADMV1014_REG_BB_AMP_AGC,
> +							  ADMV1014_BB_AMP_REF_GEN_MSK |
> +							  ADMV1014_BB_SWITCH_HIGH_LOW_CM_MSK,
> +							  FIELD_PREP(ADMV1014_BB_AMP_REF_GEN_MSK, i) |
> +							  FIELD_PREP(ADMV1014_BB_SWITCH_HIGH_LOW_CM_MSK, bb_sw_high_low_cm));

Local varaibles to shorten these lines are a must.


> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int admv1014_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long info)
> +{
> +	struct admv1014_state *st = iio_priv(indio_dev);
> +	unsigned int data;
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_OFFSET:
> +		ret = admv1014_spi_read(st, ADMV1014_REG_IF_AMP_BB_AMP, &data);
> +		if (ret)
> +			return ret;
> +
> +		if (chan->channel2 == IIO_MOD_I)
> +			*val = FIELD_GET(ADMV1014_BB_AMP_OFFSET_I_MSK, data);
> +		else
> +			*val = FIELD_GET(ADMV1014_BB_AMP_OFFSET_Q_MSK, data);
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_PHASE:
> +		ret = admv1014_spi_read(st, ADMV1014_REG_LO_AMP_PHASE_ADJUST1, &data);
> +		if (ret)
> +			return ret;
> +
> +		if (chan->channel2 == IIO_MOD_I)
> +			*val = FIELD_GET(ADMV1014_LOAMP_PH_ADJ_I_FINE_MSK, data);
> +		else
> +			*val = FIELD_GET(ADMV1014_LOAMP_PH_ADJ_Q_FINE_MSK, data);
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = admv1014_spi_read(st, ADMV1014_REG_MIXER, &data);
> +		if (ret)
> +			return ret;
> +
> +		*val = FIELD_GET(ADMV1014_DET_PROG_MSK, data);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		ret = admv1014_spi_read(st, ADMV1014_REG_BB_AMP_AGC, &data);
> +		if (ret)
> +			return ret;
> +
> +		*val = FIELD_GET(ADMV1014_BB_AMP_GAIN_CTRL_MSK, data);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int admv1014_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long info)
> +{
> +	struct admv1014_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->channel2 == IIO_MOD_I)
> +			return admv1014_spi_update_bits(st, ADMV1014_REG_IF_AMP_BB_AMP,
> +							ADMV1014_BB_AMP_OFFSET_I_MSK,
> +							FIELD_PREP(ADMV1014_BB_AMP_OFFSET_I_MSK, val));
> +		else
> +			return admv1014_spi_update_bits(st, ADMV1014_REG_IF_AMP_BB_AMP,
> +							ADMV1014_BB_AMP_OFFSET_Q_MSK,
> +							FIELD_PREP(ADMV1014_BB_AMP_OFFSET_Q_MSK, val));
> +	case IIO_CHAN_INFO_PHASE:
> +		if (chan->channel2 == IIO_MOD_I)
> +			return admv1014_spi_update_bits(st, ADMV1014_REG_LO_AMP_PHASE_ADJUST1,
> +							ADMV1014_LOAMP_PH_ADJ_I_FINE_MSK,
> +							FIELD_PREP(ADMV1014_LOAMP_PH_ADJ_I_FINE_MSK, val));

Lines too long.  I'd suggest using some local variables.

> +		else
> +			return admv1014_spi_update_bits(st, ADMV1014_REG_LO_AMP_PHASE_ADJUST1,
> +							ADMV1014_LOAMP_PH_ADJ_Q_FINE_MSK,
> +							FIELD_PREP(ADMV1014_LOAMP_PH_ADJ_Q_FINE_MSK, val));
> +	case IIO_CHAN_INFO_SCALE:
> +		return admv1014_spi_update_bits(st, ADMV1014_REG_MIXER,
> +						ADMV1014_DET_PROG_MSK,
> +						FIELD_PREP(ADMV1014_DET_PROG_MSK, val));
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		return admv1014_spi_update_bits(st, ADMV1014_REG_BB_AMP_AGC,
> +						ADMV1014_BB_AMP_GAIN_CTRL_MSK,
> +						FIELD_PREP(ADMV1014_BB_AMP_GAIN_CTRL_MSK, val));
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t admv1014_read(struct iio_dev *indio_dev,
> +			     uintptr_t private,
> +			     const struct iio_chan_spec *chan,
> +			     char *buf)
> +{
> +	struct admv1014_state *st = iio_priv(indio_dev);
> +	unsigned int data;
> +	int ret;
> +
> +	switch ((u32)private) {
> +	case ADMV1014_GAIN_COARSE:
> +		if (chan->channel2 == IIO_MOD_I) {
> +			ret = admv1014_spi_read(st, ADMV1014_REG_IF_AMP, &data);
> +			if (ret)
> +				return ret;
> +
> +			data = FIELD_GET(ADMV1014_IF_AMP_COARSE_GAIN_I_MSK, data);
> +		} else {
> +			ret = admv1014_spi_read(st, ADMV1014_REG_IF_AMP_BB_AMP, &data);
> +			if (ret)
> +				return ret;
> +
> +			data = FIELD_GET(ADMV1014_IF_AMP_COARSE_GAIN_Q_MSK, data);
> +		}
> +		break;
> +	case ADMV1014_GAIN_FINE:
> +		ret = admv1014_spi_read(st, ADMV1014_REG_IF_AMP, &data);
> +		if (ret)
> +			return ret;
> +
> +		if (chan->channel2 == IIO_MOD_I)
> +			data = FIELD_GET(ADMV1014_IF_AMP_FINE_GAIN_I_MSK, data);
> +		else
> +			data = FIELD_GET(ADMV1014_IF_AMP_FINE_GAIN_Q_MSK, data);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return sysfs_emit(buf, "%u\n", data);
> +}
> +
> +static ssize_t admv1014_write(struct iio_dev *indio_dev,
> +			      uintptr_t private,
> +			      const struct iio_chan_spec *chan,
> +			      const char *buf, size_t len)
> +{
> +	struct admv1014_state *st = iio_priv(indio_dev);
> +	unsigned int data, addr, msk;
> +	int ret;
> +
> +	ret = kstrtou32(buf, 10, &data);
> +	if (ret)
> +		return ret;
> +
> +	switch ((u32)private) {
> +	case ADMV1014_GAIN_COARSE:
> +		if (chan->channel2 == IIO_MOD_I) {
> +			addr = ADMV1014_REG_IF_AMP;
> +			msk = ADMV1014_IF_AMP_COARSE_GAIN_I_MSK;
> +			data = FIELD_PREP(ADMV1014_IF_AMP_COARSE_GAIN_I_MSK, data);
> +		} else {
> +			addr = ADMV1014_REG_IF_AMP_BB_AMP;
> +			msk = ADMV1014_IF_AMP_COARSE_GAIN_Q_MSK;
> +			data = FIELD_PREP(ADMV1014_IF_AMP_COARSE_GAIN_Q_MSK, data);
> +		}
> +		break;
> +	case ADMV1014_GAIN_FINE:
> +		addr = ADMV1014_REG_IF_AMP;
> +
> +		if (chan->channel2 == IIO_MOD_I) {
> +			msk = ADMV1014_IF_AMP_FINE_GAIN_I_MSK;
> +			data = FIELD_PREP(ADMV1014_IF_AMP_FINE_GAIN_I_MSK, data);
> +		} else {
> +			msk = ADMV1014_IF_AMP_FINE_GAIN_Q_MSK;
> +			data = FIELD_PREP(ADMV1014_IF_AMP_FINE_GAIN_Q_MSK, data);
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = admv1014_spi_update_bits(st, addr, msk, data);
> +
> +	return ret ? ret : len;
> +}
> +
> +static int admv1014_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = detector_table;
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(detector_table);
> +
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int admv1014_reg_access(struct iio_dev *indio_dev,
> +			       unsigned int reg,
> +			       unsigned int write_val,
> +			       unsigned int *read_val)
> +{
> +	struct admv1014_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (read_val)
> +		ret = admv1014_spi_read(st, reg, read_val);
		return...
> +	else
> +		ret = admv1014_spi_write(st, reg, write_val);
		return...

> +
> +	return ret;
> +}
> +
> +static const struct iio_info admv1014_info = {
> +	.read_raw = admv1014_read_raw,
> +	.write_raw = admv1014_write_raw,
> +	.read_avail = &admv1014_read_avail,
> +	.debugfs_reg_access = &admv1014_reg_access,
> +};
> +
> +static int admv1014_freq_change(struct notifier_block *nb, unsigned long action, void *data)
> +{
> +	struct admv1014_state *st = container_of(nb, struct admv1014_state, nb);
> +	int ret;
> +
> +	if (action == POST_RATE_CHANGE) {
> +		mutex_lock(&st->lock);
> +		ret = notifier_from_errno(admv1014_update_quad_filters(st));
> +		mutex_unlock(&st->lock);
> +		return ret;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +#define _ADMV1014_EXT_INFO(_name, _shared, _ident) { \
> +		.name = _name, \
> +		.read = admv1014_read, \
> +		.write = admv1014_write, \
> +		.private = _ident, \
> +		.shared = _shared, \
> +}
> +
> +static const struct iio_chan_spec_ext_info admv1014_ext_info[] = {
> +	_ADMV1014_EXT_INFO("gain_coarse", IIO_SEPARATE, ADMV1014_GAIN_COARSE),
> +	_ADMV1014_EXT_INFO("gain_fine", IIO_SEPARATE, ADMV1014_GAIN_FINE),
> +	{ },
> +};
> +
> +#define ADMV1014_CHAN(_channel, rf_comp) {				\
> +	.type = IIO_ALTVOLTAGE,						\
> +	.modified = 1,							\
> +	.output = 0,							\
> +	.indexed = 1,							\
> +	.channel2 = IIO_MOD_##rf_comp,					\
> +	.channel = _channel,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_PHASE) |		\
> +		BIT(IIO_CHAN_INFO_OFFSET),				\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_HARDWAREGAIN)	\

Some of this ABI is non obvious enough that I'd like to see the whole thing in the
patch description with some info on what they are actually being used for alongside.

> +	}
> +
> +#define ADMV1014_CHAN_GAIN(_channel, rf_comp, _admv1014_ext_info) {	\
> +	.type = IIO_ALTVOLTAGE,						\
> +	.modified = 1,							\
> +	.output = 0,							\
> +	.indexed = 1,							\
> +	.channel2 = IIO_MOD_##rf_comp,					\
> +	.channel = _channel,						\
> +	.ext_info = _admv1014_ext_info					\
> +	}
> +
> +#define ADMV1014_CHAN_DETECTOR(_channel) {				\

If only one use, probably better to just put this inline as it'll be slightly
more readable when not a macro.

> +	.type = IIO_POWER,						\
> +	.modified = 1,							\
> +	.output = 0,							\
> +	.indexed = 1,							\
> +	.channel = _channel,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),			\
> +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE)	\
> +	}
> +
> +static const struct iio_chan_spec admv1014_channels[] = {
> +	ADMV1014_CHAN(0, I),
> +	ADMV1014_CHAN(0, Q),
> +	ADMV1014_CHAN_GAIN(0, I, admv1014_ext_info),
> +	ADMV1014_CHAN_GAIN(0, Q, admv1014_ext_info),
> +	ADMV1014_CHAN_DETECTOR(0)
> +};
> +
> +static int admv1014_init(struct admv1014_state *st)
> +{
> +	int ret;
> +	unsigned int chip_id, enable_reg, enable_reg_msk;
> +	struct spi_device *spi = st->spi;
> +
> +	/* Perform a software reset */
> +	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_SPI_CONTROL,
> +					 ADMV1014_SPI_SOFT_RESET_MSK,
> +					 FIELD_PREP(ADMV1014_SPI_SOFT_RESET_MSK, 1));
> +	if (ret) {
> +		dev_err(&spi->dev, "ADMV1014 SPI software reset failed.\n");
> +		return ret;
> +	}
> +
> +	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_SPI_CONTROL,
> +					 ADMV1014_SPI_SOFT_RESET_MSK,
> +					 FIELD_PREP(ADMV1014_SPI_SOFT_RESET_MSK, 0));
> +	if (ret) {
> +		dev_err(&spi->dev, "ADMV1014 SPI software reset disable failed.\n");
> +		return ret;
> +	}
> +
> +	ret = admv1014_spi_write(st, ADMV1014_REG_VVA_TEMP_COMP, 0x727C);
> +	if (ret) {
> +		dev_err(&spi->dev, "Writing default Temperature Compensation value failed.\n");
> +		return ret;
> +	}
> +
> +	ret = admv1014_spi_read(st, ADMV1014_REG_SPI_CONTROL, &chip_id);
> +	if (ret)
> +		return ret;
> +
> +	chip_id = (chip_id & ADMV1014_CHIP_ID_MSK) >> 4;
> +	if (chip_id != ADMV1014_CHIP_ID) {
> +		dev_err(&spi->dev, "Invalid Chip ID.\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = __admv1014_spi_update_bits(st, ADMV1014_REG_QUAD,
> +					 ADMV1014_QUAD_SE_MODE_MSK,
> +					 FIELD_PREP(ADMV1014_QUAD_SE_MODE_MSK,
> +						    st->quad_se_mode));
> +	if (ret) {
> +		dev_err(&spi->dev, "Writing Quad SE Mode failed.\n");
> +		return ret;
> +	}
> +
> +	ret = admv1014_update_quad_filters(st);
> +	if (ret) {
> +		dev_err(&spi->dev, "Update Quad Filters failed.\n");
> +		return ret;
> +	}
> +
> +	ret = admv1014_update_vcm_settings(st);
> +	if (ret) {
> +		dev_err(&spi->dev, "Update VCM Settings failed.\n");
> +		return ret;
> +	}
> +
> +	enable_reg_msk = ADMV1014_P1DB_COMPENSATION_MSK |
> +			 ADMV1014_IF_AMP_PD_MSK |
> +			 ADMV1014_BB_AMP_PD_MSK |
> +			 ADMV1014_DET_EN_MSK;
> +
> +	enable_reg = FIELD_PREP(ADMV1014_P1DB_COMPENSATION_MSK, st->p1db_comp) |
> +		     FIELD_PREP(ADMV1014_IF_AMP_PD_MSK, !(st->input_mode)) |
> +		     FIELD_PREP(ADMV1014_BB_AMP_PD_MSK, st->input_mode) |
> +		     FIELD_PREP(ADMV1014_DET_EN_MSK, st->det_en);
> +
> +	return __admv1014_spi_update_bits(st, ADMV1014_REG_ENABLE, enable_reg_msk, enable_reg);
> +}
> +
> +static void admv1014_clk_disable(void *data)
> +{
> +	clk_disable_unprepare(data);
> +}
> +
> +static void admv1014_reg_disable(void *data)
> +{
> +	regulator_disable(data);
> +}
> +
> +static void admv1014_powerdown(void *data)
> +{
> +	unsigned int enable_reg, enable_reg_msk;
> +
> +	/* Disable all components in the Enable Register */
> +	enable_reg_msk = ADMV1014_IBIAS_PD_MSK |
> +			ADMV1014_IF_AMP_PD_MSK |
> +			ADMV1014_QUAD_BG_PD_MSK |
> +			ADMV1014_BB_AMP_PD_MSK |
> +			ADMV1014_QUAD_IBIAS_PD_MSK |
> +			ADMV1014_BG_PD_MSK;
> +
> +	enable_reg = FIELD_PREP(ADMV1014_IBIAS_PD_MSK, 1) |
> +			FIELD_PREP(ADMV1014_IF_AMP_PD_MSK, 1) |
> +			FIELD_PREP(ADMV1014_QUAD_BG_PD_MSK, 1) |
> +			FIELD_PREP(ADMV1014_BB_AMP_PD_MSK, 1) |
> +			FIELD_PREP(ADMV1014_QUAD_IBIAS_PD_MSK, 1) |
> +			FIELD_PREP(ADMV1014_BG_PD_MSK, 1);
> +
> +	admv1014_spi_update_bits(data, ADMV1014_REG_ENABLE, enable_reg_msk, enable_reg);

Where it doesn't hurt, keep lines under 80 chars.

> +}
> +
> +static int admv1014_properties_parse(struct admv1014_state *st)
> +{
> +	int ret;
> +	const char *str;
> +	struct spi_device *spi = st->spi;
> +
> +	st->det_en = device_property_read_bool(&spi->dev, "adi,detector-enable");
> +
> +	st->p1db_comp = device_property_read_bool(&spi->dev, "adi,p1db-comp-enable");
> +	if (st->p1db_comp)
> +		st->p1db_comp = 3;

Why? I'd just make this a bool and then do any necessary conversion to 3 where it is used.

> +
> +	ret = device_property_read_string(&spi->dev, "adi,input-mode", &str);
> +	if (ret)
> +		st->input_mode = ADMV1014_IQ_MODE;
Be lazy :)

	str = "iq";
	device_property_read_string(&spi->dev, "adi,input-mode", &str);

as it should not change str unless it succeeds thus we can set a default.
Note the binding should have a default: entry for this.


> +
> +	if (!strcmp(str, "iq"))
> +		st->input_mode = ADMV1014_IQ_MODE;
> +	else if (!strcmp(str, "if"))
> +		st->input_mode = ADMV1014_IF_MODE;
> +	else
> +		return -EINVAL;
> +
> +	ret = device_property_read_string(&spi->dev, "adi,quad-se-mode", &str);
> +	if (ret)
> +		st->quad_se_mode = ADMV1014_SE_MODE_DIFF;

Same suggestion as above to set a default value.

> +
> +	if (!strcmp(str, "diff"))
> +		st->quad_se_mode = ADMV1014_SE_MODE_DIFF;
> +	else if (!strcmp(str, "se-pos"))
> +		st->quad_se_mode = ADMV1014_SE_MODE_POS;
> +	else if (!strcmp(str, "se-neg"))
> +		st->quad_se_mode = ADMV1014_SE_MODE_NEG;
> +	else
> +		return -EINVAL;
> +
> +	st->reg = devm_regulator_get(&spi->dev, "vcm");
> +	if (IS_ERR(st->reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
> +				     "failed to get the common-mode voltage\n");
> +
> +	st->clkin = devm_clk_get(&spi->dev, "lo_in");
> +	if (IS_ERR(st->clkin))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
> +				     "failed to get the LO input clock\n");
> +
> +	return 0;
> +}
> +
> +static int admv1014_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct admv1014_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	indio_dev->info = &admv1014_info;
> +	indio_dev->name = "admv1014";
> +	indio_dev->channels = admv1014_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(admv1014_channels);
> +
> +	st->spi = spi;
> +
> +	ret = admv1014_properties_parse(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = regulator_enable(st->reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable specified Common-Mode Voltage!\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_reg_disable, st->reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(st->clkin);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_clk_disable, st->clkin);
> +	if (ret)
> +		return ret;
> +
> +	st->nb.notifier_call = admv1014_freq_change;
> +	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&st->lock);
> +
> +	ret = admv1014_init(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&spi->dev, admv1014_powerdown, st);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct spi_device_id admv1014_id[] = {
> +	{ "admv1014", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, admv1014_id);
> +
> +static const struct of_device_id admv1014_of_match[] = {
> +	{ .compatible = "adi,admv1014" },
> +	{},

No comma after the 'null' terminator.

> +};
> +MODULE_DEVICE_TABLE(of, admv1014_of_match);
> +
> +static struct spi_driver admv1014_driver = {
> +	.driver = {
> +		.name = "admv1014",
> +		.of_match_table = admv1014_of_match,
> +	},
> +	.probe = admv1014_probe,
> +	.id_table = admv1014_id,
> +};
> +module_spi_driver(admv1014_driver);
> +
> +MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com");
> +MODULE_DESCRIPTION("Analog Devices ADMV1014");
> +MODULE_LICENSE("GPL v2");

