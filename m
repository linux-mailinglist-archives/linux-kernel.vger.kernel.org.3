Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0494BCA44
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243182AbiBSSvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:51:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243199AbiBSSv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:51:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C8B19FB1E;
        Sat, 19 Feb 2022 10:50:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B91EBCE0AD9;
        Sat, 19 Feb 2022 18:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28072C340F7;
        Sat, 19 Feb 2022 18:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645296647;
        bh=sKm2+FRBtnpjt0evUH3oxdcHOE+4UuXz1uhUxqdVDHg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c340fbCSO3I2tzMZclEJW9IHjf7sgJADHsHz7+JxfuWnQ3jXGuaZDl5mOvjiAYhFP
         NDMRxm1J/4B8Ur6RCndBhhhON1Vn9RMGQe+W7qYKx8/zgAOifwhEhLEtD9ajIDLl0O
         qGdD0ZMW/SqXC/Zl3b5fUyBC01rbKMH5wowI1Gmf8YOJSc//O+32WQr1+NOEcRfhA+
         cLtcXKrgkcK7DD1wcYyyucOKH2Okymrt/GIeikVDx0waavFAGwDCj/rITvmh1Jg36u
         Mz2IL68M6WrAIXDRgVTMS0+1Mz/RmYJq0Xx/kQqDjrcQpqN2UtZoVgf8Eh5BCbFrh+
         iAiWbpsNl0HCQ==
Date:   Sat, 19 Feb 2022 18:57:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] iio:amplifiers:ada4250: add support for ADA4250
Message-ID: <20220219185734.1ac059d2@jic23-huawei>
In-Reply-To: <20220214094115.48548-1-antoniu.miclaus@analog.com>
References: <20220214094115.48548-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 11:41:13 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADA4250 is an instrumentation amplifier with SPI/pin-strap
> progammable gains that is optimized for ultra-low power systems.
> With a minimum supply voltage of 1.7V, 26uA of quiescent current,
> a shutdown mode, a sleep mode, and a fast wake up settling time,
> ADA4250 can be power cycled on a battery powered system for even
> futher savings.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Antoniu

Just a few really small comments about comment syntax.

If it's all that comes up in review I can just fix them up whilst applying.
We need to give a little more time for review, including dt bindings so
I'll not be picking this up today anyway.

Thanks,

Jonathan

> ---
> changes in v3:
>  - fix indent in Kconfig
>  - rename `ADA4250_SNSR_CAL_CFG_BIAS_MSK`
>  - use actual values for hwgain instead of raw register values
>  - VLSB -> Voltage per LSB
>  - add comment example for computing offset raw value
>  - add documentation comment about the offset polarity bit
>  - use __aligned(8) for data buffer
>  drivers/iio/amplifiers/Kconfig   |  11 +
>  drivers/iio/amplifiers/Makefile  |   1 +
>  drivers/iio/amplifiers/ada4250.c | 400 +++++++++++++++++++++++++++++++
>  3 files changed, 412 insertions(+)
>  create mode 100644 drivers/iio/amplifiers/ada4250.c
> 
> diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
> index 5eb1357a9c78..f217a2a1e958 100644
> --- a/drivers/iio/amplifiers/Kconfig
> +++ b/drivers/iio/amplifiers/Kconfig
> @@ -23,6 +23,17 @@ config AD8366
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad8366.
>  
> +config ADA4250
> +	tristate "Analog Devices ADA4250 Instrumentation Amplifier"
> +	depends on SPI
> +	help
> +	  Say yes here to build support for Analog Devices ADA4250
> +	  SPI Amplifier's support. The driver provides direct access via
> +	  sysfs.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ada4250.
> +
>  config HMC425
>  	tristate "Analog Devices HMC425A and similar GPIO Gain Amplifiers"
>  	depends on GPIOLIB
> diff --git a/drivers/iio/amplifiers/Makefile b/drivers/iio/amplifiers/Makefile
> index cb551d82f56b..2126331129cf 100644
> --- a/drivers/iio/amplifiers/Makefile
> +++ b/drivers/iio/amplifiers/Makefile
> @@ -5,4 +5,5 @@
>  
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AD8366) += ad8366.o
> +obj-$(CONFIG_ADA4250) += ada4250.o
>  obj-$(CONFIG_HMC425) += hmc425a.o
> diff --git a/drivers/iio/amplifiers/ada4250.c b/drivers/iio/amplifiers/ada4250.c
> new file mode 100644
> index 000000000000..2d88c831a7ee
> --- /dev/null
> +++ b/drivers/iio/amplifiers/ada4250.c
> @@ -0,0 +1,400 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ADA4250 driver
> + *
> + * Copyright 2022 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#include <asm/unaligned.h>
> +
> +/* ADA4250 Register Map */
> +#define ADA4250_REG_GAIN_MUX        0x00
> +#define ADA4250_REG_REFBUF_EN       0x01
> +#define ADA4250_REG_RESET           0x02
> +#define ADA4250_REG_SNSR_CAL_VAL    0x04
> +#define ADA4250_REG_SNSR_CAL_CNFG   0x05
> +#define ADA4250_REG_DIE_REV         0x18
> +#define ADA4250_REG_CHIP_ID         0x19
> +
> +/* ADA4250_REG_GAIN_MUX Map */
> +#define ADA4250_GAIN_MUX_MSK        GENMASK(2, 0)
> +
> +/* ADA4250_REG_REFBUF Map */
> +#define ADA4250_REFBUF_MSK          BIT(0)
> +
> +/* ADA4250_REG_RESET Map */
> +#define ADA4250_RESET_MSK           BIT(0)
> +
> +/* ADA4250_REG_SNSR_CAL_VAL Map */
> +#define ADA4250_CAL_CFG_BIAS_MSK    GENMASK(7, 0)
> +
> +/* ADA4250_REG_SNSR_CAL_CNFG Bit Definition */
> +#define ADA4250_BIAS_SET_MSK        GENMASK(3, 2)
> +#define ADA4250_RANGE_SET_MSK       GENMASK(1, 0)
> +
> +/* Miscellaneous definitions */
> +#define ADA4250_CHIP_ID             0x4250
> +#define ADA4250_RANGE1              0
> +#define	ADA4250_RANGE4              3
> +
> +/* ADA4250 current bias set */
> +enum ada4250_current_bias {
> +	ADA4250_BIAS_DISABLED,
> +	ADA4250_BIAS_BANDGAP,
> +	ADA4250_BIAS_AVDD,
> +};
> +
> +struct ada4250_state {
> +	struct spi_device	*spi;
> +	struct regmap		*regmap;
> +	struct regulator	*reg;
> +	/* Protect against concurrent accesses to the device and data content */
> +	struct mutex		lock;
> +	u8			bias;
> +	u8			gain;
> +	int			offset_uv;
> +	bool			refbuf_en;
> +};
> +
> +/* ADA4250 Current Bias Source Settings: Disabled, Bandgap Reference, AVDD */
> +static const int calibbias_table[] = {0, 1, 2};
> +
> +/* ADA4250 Gain (V/V) values: 1, 2, 4, 8, 16, 32, 64, 128 */
> +static const int hwgain_table[] = {1, 2, 4, 8, 16, 32, 64, 128};
> +
> +static const struct regmap_config ada4250_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.read_flag_mask = BIT(7),
> +	.max_register = 0x1A,
> +};
> +
> +static int ada4250_set_offset_uv(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan,
> +				 int offset_uv)
> +{
> +	struct ada4250_state *st = iio_priv(indio_dev);
> +
> +	int i, ret, x[8], max_vos, min_vos, voltage_v, vlsb = 0;
> +	u8 offset_raw, range = ADA4250_RANGE1;
> +	u32 lsb_coeff[6] = {1333, 2301, 4283, 8289, 16311, 31599};
> +
> +	if (st->bias == 0 || st->bias == 3)
> +		return -EINVAL;
> +
> +	voltage_v = regulator_get_voltage(st->reg);
> +	voltage_v = DIV_ROUND_CLOSEST(voltage_v, 1000000);
> +
> +	if (st->bias == ADA4250_BIAS_AVDD)
> +		x[0] = voltage_v;
> +	else
> +		x[0] = 5;
> +
> +	x[1] = 126 * (x[0] - 1);
> +
> +	for (i = 0; i < 6; i++)
> +		x[i + 2] = DIV_ROUND_CLOSEST(x[1] * 1000, lsb_coeff[i]);
> +
> +	if (st->gain == 0)
> +		return -EINVAL;
> +
> +	/* Compute Range and Voltage per LSB for the Sensor Offset Calibration      */

Please use the standard multiline comment syntax of

	/*
	 * Compute Range and ...
	 * Example ...
...
	 */
Reviewer's eyes get used to parsing a particular style so it is best to
keep to it.

> +	/* Example of computation for Range 1 and Range 2 (Curren Bias Set = AVDD): */
> +	/*                     Range 1                            Range 2           */
> +	/*   Gain   | Max Vos(mV) |   LSB(mV)        |  Max Vos(mV)  | LSB(mV) |    */
> +	/*    2     |    X1*127   | X1=0.126(AVDD-1) |   X1*3*127    |  X1*3   |    */
> +	/*    4     |    X2*127   | X2=X1/1.3333     |   X2*3*127    |  X2*3   |    */
> +	/*    8     |    X3*127   | X3=X1/2.301      |   X3*3*127    |  X3*3   |    */
> +	/*    16    |    X4*127   | X4=X1/4.283      |   X4*3*127    |  X4*3   |    */
> +	/*    32    |    X5*127   | X5=X1/8.289      |   X5*3*127    |  X5*3   |    */
> +	/*    64    |    X6*127   | X6=X1/16.311     |   X6*3*127    |  X6*3   |    */
> +	/*    128   |    X7*127   | X7=X1/31.599     |   X7*3*127    |  X7*3   |    */
> +
> +	for (i = ADA4250_RANGE1; i <= ADA4250_RANGE4; i++) {
> +		max_vos = x[st->gain] *  127 * ((1 << (i + 1)) - 1);
> +		min_vos = -1 * max_vos;
> +		if (offset_uv > min_vos && offset_uv < max_vos) {
> +			range = i;
> +			vlsb = x[st->gain] * ((1 << (i + 1)) - 1);
> +			break;
> +		}
> +	}
> +
> +	if (vlsb <= 0)
> +		return -EINVAL;
> +
> +	offset_raw = DIV_ROUND_CLOSEST(abs(offset_uv), vlsb);
> +
> +	mutex_lock(&st->lock);
> +	ret = regmap_update_bits(st->regmap, ADA4250_REG_SNSR_CAL_CNFG,
> +				 ADA4250_RANGE_SET_MSK,
> +				 FIELD_PREP(ADA4250_RANGE_SET_MSK, range));
> +	if (ret)
> +		goto exit;
> +
> +	st->offset_uv = offset_raw * vlsb;
> +
> +	// To set the offset calibration value, use bits [6:0] and bit 7 as the
> +	// polarity bit (set to "0" for a negative offset and "1" for a positive
> +	// offset).

Please use 
	/*
	 * To set the...
	 * pol...
	 * offset
	 */ 

syntax for multiline comments

> +	if (offset_uv < 0) {
> +		offset_raw |= BIT(7);
> +		st->offset_uv *= (-1);
> +	}
> +
> +	ret = regmap_write(st->regmap, ADA4250_REG_SNSR_CAL_VAL, offset_raw);
> +
> +exit:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int ada4250_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long info)
> +{
> +	struct ada4250_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		ret = regmap_read(st->regmap, ADA4250_REG_GAIN_MUX, val);
> +		if (ret)
> +			return ret;
> +
> +		*val = BIT(*val);
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = st->offset_uv;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		ret = regmap_read(st->regmap, ADA4250_REG_SNSR_CAL_CNFG, val);
> +		if (ret)
> +			return ret;
> +
> +		*val = FIELD_GET(ADA4250_BIAS_SET_MSK, *val);
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 1;
> +		*val2 = 1000000;
> +
> +		return IIO_VAL_FRACTIONAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ada4250_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long info)
> +{
> +	struct ada4250_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		ret = regmap_write(st->regmap, ADA4250_REG_GAIN_MUX,
> +				   FIELD_PREP(ADA4250_GAIN_MUX_MSK, ilog2(val)));
> +		if (ret)
> +			return ret;
> +
> +		st->gain = ilog2(val);
> +
> +		return ret;
> +	case IIO_CHAN_INFO_OFFSET:
> +		return ada4250_set_offset_uv(indio_dev, chan, val);
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		ret = regmap_update_bits(st->regmap, ADA4250_REG_SNSR_CAL_CNFG,
> +					 ADA4250_BIAS_SET_MSK,
> +					 FIELD_PREP(ADA4250_BIAS_SET_MSK, val));
> +		if (ret)
> +			return ret;
> +
> +		st->bias = val;
> +
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ada4250_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type, int *length,
> +			      long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*vals = calibbias_table;
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(calibbias_table);
> +
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		*vals = hwgain_table;
> +		*type = IIO_VAL_INT;
> +		*length = ARRAY_SIZE(hwgain_table);
> +
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ada4250_reg_access(struct iio_dev *indio_dev,
> +			      unsigned int reg,
> +			      unsigned int write_val,
> +			      unsigned int *read_val)
> +{
> +	struct ada4250_state *st = iio_priv(indio_dev);
> +
> +	if (read_val)
> +		return regmap_read(st->regmap, reg, read_val);
> +	else
> +		return regmap_write(st->regmap, reg, write_val);
> +}
> +
> +static const struct iio_info ada4250_info = {
> +	.read_raw = ada4250_read_raw,
> +	.write_raw = ada4250_write_raw,
> +	.read_avail = &ada4250_read_avail,
> +	.debugfs_reg_access = &ada4250_reg_access,
> +};
> +
> +static const struct iio_chan_spec ada4250_channels[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.output = 1,
> +		.indexed = 1,
> +		.channel = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
> +				BIT(IIO_CHAN_INFO_OFFSET) |
> +				BIT(IIO_CHAN_INFO_CALIBBIAS) |
> +				BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_CALIBBIAS) |
> +						BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> +	}
> +};
> +
> +static void ada4250_reg_disable(void *data)
> +{
> +	regulator_disable(data);
> +}
> +
> +static int ada4250_init(struct ada4250_state *st)
> +{
> +	int ret;
> +	u16 chip_id;
> +	u8 data[2] __aligned(8) = {};
> +	struct spi_device *spi = st->spi;
> +
> +	st->refbuf_en = device_property_read_bool(&spi->dev, "adi,refbuf-enable");
> +
> +	st->reg = devm_regulator_get(&spi->dev, "avdd");
> +	if (IS_ERR(st->reg))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->reg),
> +				     "failed to get the AVDD voltage\n");
> +
> +	ret = regulator_enable(st->reg);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to enable specified AVDD supply\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&spi->dev, ada4250_reg_disable, st->reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADA4250_REG_RESET,
> +			   FIELD_PREP(ADA4250_RESET_MSK, 1));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_read(st->regmap, ADA4250_REG_CHIP_ID, data, 2);
> +	if (ret)
> +		return ret;
> +
> +	chip_id = get_unaligned_le16(data);
> +
> +	if (chip_id != ADA4250_CHIP_ID) {
> +		dev_err(&spi->dev, "Invalid chip ID.\n");
> +		return -EINVAL;
> +	}
> +
> +	return regmap_write(st->regmap, ADA4250_REG_REFBUF_EN,
> +			    FIELD_PREP(ADA4250_REFBUF_MSK, st->refbuf_en));
> +}
> +
> +static int ada4250_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	struct ada4250_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init_spi(spi, &ada4250_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	st = iio_priv(indio_dev);
> +	st->regmap = regmap;
> +	st->spi = spi;
> +
> +	indio_dev->info = &ada4250_info;
> +	indio_dev->name = "ada4250";
> +	indio_dev->channels = ada4250_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ada4250_channels);
> +
> +	mutex_init(&st->lock);
> +
> +	ret = ada4250_init(st);
> +	if (ret) {
> +		dev_err(&spi->dev, "ADA4250 init failed\n");
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct spi_device_id ada4250_id[] = {
> +	{ "ada4250", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ada4250_id);
> +
> +static const struct of_device_id ada4250_of_match[] = {
> +	{ .compatible = "adi,ada4250" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ada4250_of_match);
> +
> +static struct spi_driver ada4250_driver = {
> +	.driver = {
> +			.name = "ada4250",
> +			.of_match_table = ada4250_of_match,
> +		},
> +	.probe = ada4250_probe,
> +	.id_table = ada4250_id,
> +};
> +module_spi_driver(ada4250_driver);
> +
> +MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com");
> +MODULE_DESCRIPTION("Analog Devices ADA4250");
> +MODULE_LICENSE("GPL v2");

