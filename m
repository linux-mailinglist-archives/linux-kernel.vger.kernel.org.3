Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6806150377B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 18:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiDPQQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 12:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiDPQP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 12:15:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758D21082;
        Sat, 16 Apr 2022 09:13:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB6F3B803F1;
        Sat, 16 Apr 2022 16:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAC4C385A3;
        Sat, 16 Apr 2022 16:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650125601;
        bh=4ofBq2cnwuXfg4JJlByIBd7llus0sa80rOJh8LVLKV0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t0arKJbmT0t/Tebzh3mqBbgILQoSmwW9boHwnROmWlW0iQxtDexyffpXe9ecvI8r0
         AwJA75JVnAT7SpFcNfTjX7i6zn8lWunFg1xhSwY0483VeeVNQTWrr9CpahqC4K0NK2
         LiLhosuhc+H0VJxZHz2lkV85zPjjnRsRr29pl4eKmWNux9YG6JVPM/dWJwG8mDcJgc
         YlhE64u2dWfIxH6OFa0xTtuAHH2I3oRClZODSYk5s0IH9hTVHs6xLcHhXSOqV8DZ3k
         lJ4fzWfKqzNVXeJyugMlIJ6jCaGoLuHre+JjZAvOuuMY+o588c5PqdquHqhZl+h15w
         dJKgY9eSEWDRg==
Date:   Sat, 16 Apr 2022 17:21:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v1 3/3] iio: adc: ad4130: add AD4130 driver
Message-ID: <20220416172117.230b5d8c@jic23-huawei>
In-Reply-To: <20220413094011.185269-3-cosmin.tanislav@analog.com>
References: <20220413094011.185269-1-cosmin.tanislav@analog.com>
        <20220413094011.185269-3-cosmin.tanislav@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 12:40:11 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> AD4130-8 is an ultra-low power, high precision,
> measurement solution for low bandwidth battery
> operated applications.
> 
> The fully integrated AFE (Analog Front-End)
> includes a multiplexer for up to 16 single-ended
> or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip
> reference and oscillator, selectable filter
> options, smart sequencer, sensor biasing and
> excitation options, diagnostics, and a FIFO
> buffer.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

Hi Cosmin,

I've only glanced at Andy's comments, so may well overlap in places
though I'll try and avoid too much repetition if I happen to remember
Andy commented on something already.

Only a few minor things from me.  For such a complex device this
is looking pretty good for a first version posted.

Jonathan


> ---
>  MAINTAINERS              |    8 +
>  drivers/iio/adc/Kconfig  |   13 +
>  drivers/iio/adc/Makefile |    1 +
>  drivers/iio/adc/ad4130.c | 2072 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 2094 insertions(+)
>  create mode 100644 drivers/iio/adc/ad4130.c
> 

...

> diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
> new file mode 100644
> index 000000000000..89fb9b413ff0
> --- /dev/null
> +++ b/drivers/iio/adc/ad4130.c
> @@ -0,0 +1,2072 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD4130 SPI ADC driver
> + *
> + * Copyright 2022 Analog Devices Inc.
> + */
> +#include <asm/div64.h>
> +#include <asm/unaligned.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/kfifo_buf.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define AD4130_8_NAME			"ad4130-8"
> +
> +#define AD4130_COMMS_READ_MASK		BIT(6)
> +
> +#define AD4130_REG_STATUS		0x00
> +#define AD4130_STATUS_POR_FLAG_MASK	BIT(4)
> +
> +#define AD4130_REG_ADC_CONTROL		0x01
> +#define AD4130_BIPOLAR_MASK		BIT(14)
where possibly it is good to name register fields such that it's
obvious which register they are fields of.  Makes it easier
to be sure we have the right one.
(I fell into this trap myself this week and wasted an hour or
so before I figured out that there were two different registers
with fields with exactly the same name ;)

Lots of different conventions for this one and I don't mind
which one you pick. e.g.  This works, but isn't perfect by
any means.

#define AD4130_ADC_CTRL_REG
#define  AD4130_ADC_CTRL_BIPOLAR_MASK

Note I quite like the subtle indenting to make it easier
to read these definitions as well.

> +#define AD4130_INT_REF_VAL_MASK		BIT(13)
> +#define AD4130_INT_REF_2_5V		2500000
> +#define AD4130_INT_REF_1_25V		1250000
> +#define AD4130_CSB_EN_MASK		BIT(9)
> +#define AD4130_INT_REF_EN_MASK		BIT(8)
> +#define AD4130_MODE_MASK		GENMASK(5, 2)
> +#define AD4130_MCLK_SEL_MASK		GENMASK(1, 0)

...


> +
> +#define AD4130_RESET_CLK_COUNT		64
> +#define AD4130_RESET_BUF_SIZE		(AD4130_RESET_CLK_COUNT / 8)
> +
> +#define AD4130_SOFT_RESET_SLEEP		(160 * 1000000 / AD4130_MCLK_FREQ_76_8KHZ)
> +
> +#define AD4130_INVALID_SLOT		-1
> +
> +#define AD4130_FREQ_FACTOR		1000000000ull

Arguably should use the standard define for NANO

> +#define AD4130_DB3_FACTOR		1000
> +

> +
> +struct ad4130_chip_info {
> +	const char	*name;
> +	u8		resolution;
> +	bool		has_int_pin;
> +};
> +
> +struct ad4130_setup_info {
> +	unsigned int			iout0_val;
> +	unsigned int			iout1_val;
> +	unsigned int			burnout;
> +	unsigned int			pga;
> +	unsigned int			fs;
> +	bool				ref_bufp;
> +	bool				ref_bufm;
> +	u32				ref_sel;
> +	enum ad4130_filter_mode		filter_mode;
> +	unsigned int			enabled_channels;
> +	unsigned int			channels;
> +};
> +
> +#define AD4130_SETUP_SIZE		offsetof(struct ad4130_setup_info, \
> +						 enabled_channels)

Perhaps a comment on what this is?  Or define this as one structure
containing another so that you can have the meta data alongside the
actual stuff you want to be able to compare.

Or just rename it as AD4130_SETUP_MATCH_SIZE or something along
those lines.

...

> +struct ad4130_state {
> +	const struct ad4130_chip_info	*chip_info;
> +	struct spi_device		*spi;
> +	struct regmap			*regmap;
> +	struct clk			*mclk;
> +	struct regulator_bulk_data	regulators[4];
> +	u32				irq_trigger;
> +	u32				inv_irq_trigger;
> +
> +	/*
> +	 * Synchronize access to members of driver state, and ensure atomicity
> +	 * of consecutive regmap operations.
> +	 */
> +	struct mutex			lock;
> +	struct completion		completion;
> +
> +	struct iio_chan_spec		chans[AD4130_MAX_CHANNELS];
> +	struct ad4130_chan_info		chans_info[AD4130_MAX_CHANNELS];
> +	struct ad4130_setup_info	setups_info[AD4130_MAX_SETUPS];
> +	enum ad4130_pin_function	pins_fn[AD4130_MAX_ANALOG_PINS];
> +	u32				vbias_pins[AD4130_MAX_ANALOG_PINS];
> +	u32				num_vbias_pins;
> +	int				scale_tbls[AD4130_REF_SEL_MAX]
> +						  [AD4130_PGA_NUM][2];
> +	struct gpio_chip		gc;
> +	unsigned int			gpio_offsets[AD4130_MAX_GPIOS];
> +	unsigned int			num_gpios;
> +
> +	u32			int_pin_sel;
> +	bool			int_ref_en;
> +	u32			int_ref_uv;
> +	u32			mclk_sel;
> +	bool			bipolar;
> +
> +	unsigned int		num_enabled_channels;
> +	unsigned int		effective_watermark;
> +	unsigned int		watermark;
> +
> +	struct spi_message	fifo_msg;
> +	struct spi_transfer	fifo_xfer[2];
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	u8			reset_buf[AD4130_RESET_BUF_SIZE] ____cacheline_aligned;
> +	u8			reg_write_tx_buf[4];
> +	u8			reg_read_tx_buf[1];
> +	u8			reg_read_rx_buf[3];
> +	u8			fifo_tx_buf[2];
> +	u8			fifo_rx_buf[AD4130_FIFO_SIZE *
> +					    AD4130_FIFO_MAX_SAMPLE_SIZE];

This is quite a large buffer.  Perhaps it would be better to drain the fifo
in multiple steps if it is very full?  I guess that could be added
later if anyone ever ran into a problem with the buffer size.


> +};

> +
> +static const struct iio_info ad4130_info = {
> +	.read_raw = ad4130_read_raw,
> +	.read_avail = ad4130_read_avail,
> +	.write_raw_get_fmt = ad4130_write_raw_get_fmt,
> +	.write_raw = ad4130_write_raw,
> +	.update_scan_mode = ad4130_update_scan_mode,
> +	.hwfifo_set_watermark = ad4130_set_fifo_watermark,
> +	.debugfs_reg_access = ad4130_reg_access,
> +};
> +
> +static int ad4130_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4130_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	ret = ad4130_set_watermark_interrupt_en(st, true);
> +	if (ret)
> +		goto out;
> +
> +	/* When the chip enters FIFO mode, IRQ polarity is inversed. */

That is downright odd :)  Perhaps a datasheet section reference is
appropriate here.

> +	ret = irq_set_irq_type(st->spi->irq, st->inv_irq_trigger);
> +	if (ret)
> +		goto out;
> +
> +	ret = ad4130_set_fifo_mode(st, AD4130_FIFO_MODE_WATERMARK);
> +	if (ret)
> +		goto out;
> +
> +	ret = ad4130_set_mode(st, AD4130_MODE_CONTINUOUS);
> +
> +out:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int ad4130_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct ad4130_state *st = iio_priv(indio_dev);
> +	unsigned int i;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	ret = ad4130_set_mode(st, AD4130_MODE_IDLE);
> +	if (ret)
> +		goto out;
> +
> +	/* When the chip exits FIFO mode, IRQ polarity returns to normal. */
> +	ret = irq_set_irq_type(st->spi->irq, st->irq_trigger);
> +	if (ret)
> +		goto out;
> +
> +	ret = ad4130_set_fifo_mode(st, AD4130_FIFO_MODE_DISABLED);
> +	if (ret)
> +		goto out;
> +
> +	ret = ad4130_set_watermark_interrupt_en(st, false);
> +	if (ret)
> +		goto out;
> +
> +	for (i = 0; i < indio_dev->num_channels; i++) {
Comment here on why we do this in predisable and not the equivalent in
postenable.  (I assume because we don't call update_scan_mode in
the disable path).

> +		ret = ad4130_set_channel_enable(st, i, false);
> +		if (ret)
> +			goto out;
> +	}
> +
> +out:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static const struct iio_buffer_setup_ops ad4130_buffer_ops = {
> +	.postenable = ad4130_buffer_postenable,
> +	.predisable = ad4130_buffer_predisable,
> +};
> +

...

> +
> +static int find_table_index(const unsigned int *tbl, size_t len,
> +			    unsigned int val)

This is a generic enough name you may well find you have
ended up clashing with something added in a header in future.
So I'd prefix this with the part number.

> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < len; i++)
> +		if (tbl[i] == val)
> +			return i;
> +
> +	return -EINVAL;
> +}
> +
> +static int ad4130_get_ref_voltage(struct ad4130_state *st,
> +				  enum ad4130_ref_sel ref_sel,
> +				  unsigned int *ref_uv)
> +{
> +	struct device *dev = &st->spi->dev;
> +	int ret;
> +
> +	switch (ref_sel) {
> +	case AD4130_REF_REFIN1:
> +		ret = regulator_get_voltage(st->regulators[2].consumer);
> +		break;
> +	case AD4130_REF_REFIN2:
> +		ret = regulator_get_voltage(st->regulators[3].consumer);
> +		break;
> +	case AD4130_REF_AVDD_AVSS:
> +		ret = regulator_get_voltage(st->regulators[0].consumer);
> +		break;
> +	case AD4130_REF_REFOUT_AVSS:
> +		if (!st->int_ref_en) {
> +			ret = -EINVAL;
> +			break;
> +		}
> +
> +		ret = st->int_ref_uv;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	if (ret <= 0)
> +		return dev_err_probe(dev, ret, "Cannot use reference %u\n",
> +				     ref_sel);
> +
> +	if (ref_uv)
> +		*ref_uv = ret;

I'd probably keep this simpler and have the caller always provide
ref_uv. Use a local dummy variable where it doesn't need the answer
or even better just return the voltage as positive value.

> +
> +	return 0;
> +}

...

> +static int ad4310_parse_fw(struct iio_dev *indio_dev)
> +{
> +	struct ad4130_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	unsigned int i;
> +	int avdd_uv;
> +	int irq;
> +	int ret;
> +
> +	st->mclk = devm_clk_get_optional(dev, "mclk");
> +	if (IS_ERR(st->mclk))
> +		return dev_err_probe(dev, PTR_ERR(st->mclk),
> +				     "Failed to get mclk\n");
> +
> +	st->int_pin_sel = AD4130_INT_PIN_DOUT_OR_INT;
> +
> +	for (i = 0; i < ARRAY_SIZE(ad4130_int_pin_names); i++) {
> +		irq = of_irq_get_byname(dev->of_node, ad4130_int_pin_names[i]);

fwnode version.

> +		if (irq > 0) {
> +			st->int_pin_sel = i;
> +			break;
> +		}
> +	}
> +
> +	if (st->int_pin_sel == AD4130_INT_PIN_DOUT ||
> +	    (st->int_pin_sel == AD4130_INT_PIN_DOUT_OR_INT &&
> +	     !st->chip_info->has_int_pin))
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Cannot use DOUT as interrupt pin\n");
> +
> +	if (st->int_pin_sel == AD4130_INT_PIN_P1)
> +		st->pins_fn[AD4130_AIN2_P1] = AD4130_PIN_FN_SPECIAL;

Looking at datasheet I see an option for P2, but not P1?

> +
> +	st->mclk_sel = AD4130_MCLK_76_8KHZ;
> +	device_property_read_u32(dev, "adi,mclk-sel", &st->mclk_sel);
> +
> +	if (st->mclk_sel >= AD4130_MCLK_SEL_MAX)
> +		return dev_err_probe(dev, -EINVAL, "Invalid clock %u\n",
> +				     st->mclk_sel);
> +
> +	if (st->mclk && (st->mclk_sel == AD4130_MCLK_76_8KHZ ||
> +			 st->mclk_sel == AD4130_MCLK_76_8KHZ_OUT))
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Cannot use external clock\n");
> +
> +	if (st->int_pin_sel == AD4130_INT_PIN_CLK &&
> +	    st->mclk_sel != AD4130_MCLK_76_8KHZ)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid clock %u for interrupt pin %u\n",
> +				     st->mclk_sel, st->int_pin_sel);
> +
> +	st->int_ref_en = true;
> +	if (device_property_present(dev, "adi,int-ref-en"))
> +		st->int_ref_en = device_property_read_bool(dev, "adi,int-ref-en");
> +
> +	st->int_ref_uv = AD4130_INT_REF_2_5V;
> +
> +	/*
> +	 * When the AVDD supply is set to below 2.5V the internal reference of
> +	 * 1.25V should be selected.

Good to give specific reference to datasheet section for things like this.
Seems to be in the ADC REFERENCE section.

> +	 */
> +	avdd_uv = regulator_get_voltage(st->regulators[0].consumer);
> +	if (avdd_uv > 0 && avdd_uv < AD4130_INT_REF_2_5V)
> +		st->int_ref_uv = AD4130_INT_REF_1_25V;
> +
> +	st->bipolar = device_property_read_bool(dev, "adi,bipolar");
> +
> +	ret = device_property_count_u32(dev, "adi,vbias-pins");
> +	if (ret > 0) {
> +		st->num_vbias_pins = ret;
> +
> +		ret = device_property_read_u32_array(dev, "adi,vbias-pins",
> +						     st->vbias_pins,
> +						     st->num_vbias_pins);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to read vbias pins\n");
> +
> +		ret = ad4130_validate_vbias_pins(st, st->vbias_pins,
> +						 st->num_vbias_pins);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = ad4130_parse_fw_children(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < AD4130_MAX_GPIOS; i++) {
> +		if (st->pins_fn[i + AD4130_AIN2_P1] != AD4130_PIN_FN_NONE)
> +			continue;

I'm a bit confused. pins_fn seems to be for the Analog pins, yet here is being
used for the GPIOs?  Maybe some explanatory comments

> +
> +		st->gpio_offsets[st->num_gpios++] = i;
> +	}
> +
> +	return 0;
> +}

...

> +static int ad4130_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad4130_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	unsigned int int_ref_val;
> +	unsigned long rate = AD4130_MCLK_FREQ_76_8KHZ;
> +	unsigned int val;
> +	unsigned int i;
> +	int ret;
> +
> +	if (st->mclk_sel == AD4130_MCLK_153_6KHZ_EXT)
> +		rate = AD4130_MCLK_FREQ_153_6KHZ;
> +
> +	ret = clk_set_rate(st->mclk, rate);

Ah. I'd neglected in my review of the dt bindings that we'd
be specifying the clock in here. We will need a parameter
to specify the clock speed if external is used, but I'd still like
that separated from the question of internal vs external clocks.

> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(st->mclk);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, ad4130_clk_disable_unprepare,
> +				       st->mclk);
> +	if (ret)
> +		return ret;
> +
> +	if (st->int_ref_uv == AD4130_INT_REF_2_5V)
> +		int_ref_val = AD4130_INT_REF_VAL_2_5V;
> +	else
> +		int_ref_val = AD4130_INT_REF_VAL_1_25V;
> +
> +	/* Switch to SPI 4-wire mode. */
> +	val = AD4130_CSB_EN_MASK;
> +	val |= st->bipolar ? AD4130_BIPOLAR_MASK : 0;

Prefer field PREP even for these single bit cases.

> +	val |= st->int_ref_en ? AD4130_INT_REF_EN_MASK : 0;
> +	val |= FIELD_PREP(AD4130_MODE_MASK, AD4130_MODE_IDLE);
> +	val |= FIELD_PREP(AD4130_MCLK_SEL_MASK, st->mclk_sel);
> +	val |= FIELD_PREP(AD4130_INT_REF_VAL_MASK, int_ref_val);
> +
> +	ret = regmap_write(st->regmap, AD4130_REG_ADC_CONTROL, val);
> +	if (ret)
> +		return ret;
> +
> +	val = FIELD_PREP(AD4130_INT_PIN_SEL_MASK, st->int_pin_sel);
> +	for (i = 0; i < st->num_gpios; i++)
> +		val |= BIT(st->gpio_offsets[i]);
> +
> +	ret = regmap_write(st->regmap, AD4130_REG_IO_CONTROL, val);
> +	if (ret)
> +		return ret;
> +
> +	val = 0;
> +	for (i = 0; i < st->num_vbias_pins; i++)
> +		val |= BIT(st->vbias_pins[i]);
> +
> +	ret = regmap_write(st->regmap, AD4130_REG_VBIAS, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->regmap, AD4130_REG_FIFO_CONTROL,
> +				 AD4130_ADD_FIFO_HEADER_MASK, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* FIFO watermark interrupt starts out as enabled, disable it. */
> +	ret = ad4130_set_watermark_interrupt_en(st, false);
> +	if (ret)
> +		return ret;
> +
> +	/* Setup channels. */
> +	for (i = 0; i < indio_dev->num_channels; i++) {
> +		struct ad4130_chan_info *chan_info = &st->chans_info[i];
> +		struct iio_chan_spec *chan = &st->chans[i];
> +		unsigned int val;
> +
> +		val = FIELD_PREP(AD4130_AINP_MASK, chan->channel) |
> +		      FIELD_PREP(AD4130_AINM_MASK, chan->channel2) |
> +		      FIELD_PREP(AD4130_IOUT1_MASK, chan_info->iout0) |
> +		      FIELD_PREP(AD4130_IOUT2_MASK, chan_info->iout1);
> +
> +		ret = regmap_write(st->regmap, AD4130_REG_CHANNEL_X(i), val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +

...

> +static int ad4130_probe(struct spi_device *spi)
> +{
> +	const struct ad4130_chip_info *info;
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad4130_state *st;
> +	int ret;
> +
> +	info = device_get_match_data(dev);
> +	if (!info)
> +		return -ENODEV;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	memset(st->reset_buf, 0xff, AD4130_RESET_BUF_SIZE);
> +	init_completion(&st->completion);
> +	mutex_init(&st->lock);
> +	st->chip_info = info;
> +	st->spi = spi;
> +
> +	/*
> +	 * Xfer:   [ XFR1 ] [         XFR2         ]
> +	 * Master:  0x7D N   ......................
> +	 * Slave:   ......   DATA1 DATA2 ... DATAN
> +	 */
> +	st->fifo_tx_buf[0] = AD4130_COMMS_READ_MASK | AD4130_REG_FIFO_DATA;
> +	st->fifo_xfer[0].tx_buf = st->fifo_tx_buf;
> +	st->fifo_xfer[0].len = sizeof(st->fifo_tx_buf);
> +	st->fifo_xfer[1].rx_buf = st->fifo_rx_buf;
> +	spi_message_init_with_transfers(&st->fifo_msg, st->fifo_xfer,
> +					ARRAY_SIZE(st->fifo_xfer));
> +
> +	indio_dev->name = st->chip_info->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ad4130_info;
> +
> +	st->regmap = devm_regmap_init(dev, NULL, st,
> +				      &ad4130_regmap_config);

Don't wrap below 80 chars unless there is some extra meaning conveyed
by doing so.  Don't think that's true ehre.


> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	st->regulators[0].supply = "avdd";
> +	st->regulators[1].supply = "iovdd";
> +	st->regulators[2].supply = "refin1";
> +	st->regulators[3].supply = "refin2";
> +
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(st->regulators),
> +				      st->regulators);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get regulators\n");
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(st->regulators), st->regulators);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable regulators\n");
> +
> +	ret = devm_add_action_or_reset(dev, ad4130_disable_regulators, st);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to add regulators disable action\n");
> +
> +	ret = ad4130_soft_reset(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4310_parse_fw(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4130_setup(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ad4130_fill_scale_tbls(st);
> +
> +	if (st->num_gpios) {
> +		st->gc.owner = THIS_MODULE;
> +		st->gc.label = st->chip_info->name;
> +		st->gc.base = -1;
> +		st->gc.ngpio = AD4130_MAX_GPIOS;
> +		st->gc.parent = dev;
> +		st->gc.can_sleep = true;
> +		st->gc.get_direction = ad4130_gpio_get_direction;
> +		st->gc.set = ad4130_gpio_set;
> +
> +		ret = devm_gpiochip_add_data(dev, &st->gc, st);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev,
> +					      INDIO_BUFFER_SOFTWARE,
> +					      &ad4130_buffer_ops,
> +					      ad4130_fifo_attributes);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_request_threaded_irq(dev, spi->irq, NULL,
> +					ad4130_irq_handler, IRQF_ONESHOT,
> +					indio_dev->name, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request irq\n");
> +
> +	st->irq_trigger = irq_get_trigger_type(spi->irq);
> +	if (st->irq_trigger & IRQF_TRIGGER_RISING)
> +		st->inv_irq_trigger = IRQF_TRIGGER_FALLING;
> +	else if (st->irq_trigger & IRQF_TRIGGER_FALLING)
> +		st->inv_irq_trigger = IRQF_TRIGGER_RISING;
> +	else
> +		return dev_err_probe(dev, -EINVAL, "Invalid irq flags: %u\n",
> +				     st->irq_trigger);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +

