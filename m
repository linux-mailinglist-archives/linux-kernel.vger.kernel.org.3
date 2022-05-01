Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BB851650E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 18:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348649AbiEAQDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 12:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240387AbiEAQDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 12:03:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59B550065;
        Sun,  1 May 2022 08:59:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5281F60F23;
        Sun,  1 May 2022 15:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25ACAC385AE;
        Sun,  1 May 2022 15:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651420793;
        bh=OcyXZkRHPpsVxID3mg1jFwUZyOkf+F6A4Phok4YUP8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D00X6zkiTJ/l7231Xh89nEdjX7A28mqR9Z4J80JdiFKtkiz7UA0AjPNvNLne4w8Ka
         0+PME3sPVJ36PR+I7NcSxp/ybnJHvHGQ3fKNj9mrKXDGecGfbQh5hCR6GbrIn6jc9H
         QZaOJb7ww8T9neCO0wKG6VSWtnGqAu5A8SCeg7aamtQKC4YV/zY79G4Qw94E3Pej9V
         oXMqDZlBRy5DaLld8zhW5eK8U+UT9gwerWZWtCPBYNZUfyp9Jrg7VmIeCTD1rdxqd5
         F9QGce64yPfgUA4+5wAB4Upk5UizH4rQ3P3ZDGYL8FMAeagri1QupLRsvrkFu3kPN+
         KgJBoaab0xS6A==
Date:   Sun, 1 May 2022 17:08:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v3 2/2] iio: adc: ad4130: add AD4130 driver
Message-ID: <20220501170807.1e728524@jic23-huawei>
In-Reply-To: <20220419150828.191933-3-cosmin.tanislav@analog.com>
References: <20220419150828.191933-1-cosmin.tanislav@analog.com>
        <20220419150828.191933-3-cosmin.tanislav@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

On Tue, 19 Apr 2022 18:08:28 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> AD4130-8 is an ultra-low power, high precision, measurement solution for
> low bandwidth battery operated applications.
> 
> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
> selectable filter options, smart sequencer, sensor biasing and excitation
> options, diagnostics, and a FIFO buffer.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

Hi Cosmin,

Sorry this one took me a while to get back to.  Last week was a little
crazy on the day job front.

Anyhow, whilst reading this I realised we have some unclear ABI documentation
and hence divergence in interpretation of the units of hwfifo_watermark.
See below. I've not done a thorough audit as don't have enough time today,
but we have at least some drivers treating it as being in scans (+ the core
does this for watermark) and some treating it as being in individual channel
readings...  My intent IIRC was that it was in scans as otherwise you run into
the problem you are working around with needing to tweak it to match scans
within each driver.

A few other trivial things inline including the alignment issue I emailed
the list about but haven't sent patches out for yet (about 90 driver are
affected... *sigh*).

Thanks,

Jonathan


> ---

...

> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 39d806f6d457..c3aa7e4eca2f 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -6,6 +6,7 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
>  obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
> +obj-$(CONFIG_AD4130) += ad4130.o
>  obj-$(CONFIG_AD7091R5) += ad7091r5.o ad7091r-base.o
>  obj-$(CONFIG_AD7124) += ad7124.o
>  obj-$(CONFIG_AD7192) += ad7192.o
> diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
> new file mode 100644
> index 000000000000..dd2f18734cba
> --- /dev/null
> +++ b/drivers/iio/adc/ad4130.c

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
> +	struct ad4130_slot_info		slots_info[AD4130_MAX_SETUPS];
> +	enum ad4130_pin_function	pins_fn[AD4130_MAX_ANALOG_PINS];
> +	u32				vbias_pins[AD4130_MAX_ANALOG_PINS];
> +	u32				num_vbias_pins;
> +	int				scale_tbls[AD4130_REF_SEL_MAX][AD4130_PGA_NUM][2];
> +	struct gpio_chip		gc;
> +	unsigned int			gpio_offsets[AD4130_MAX_GPIOS];
> +	unsigned int			num_gpios;
> +
> +	u32			int_pin_sel;
> +	u32			int_ref_uv;
> +	u32			mclk_sel;
> +	bool			int_ref_en;
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

This needs a fix along with the other set that I'll hopefully get this weekend.
In meantime if you change this to __aligned(IIO_ALIGN); then the fix I have
coming shortly will change that define to be large enough for the odd ARM systems
with 128 byte requirement for DMA and 64 byte L1 cache alignment (which is what
___cacheline_aligned guarantees.


> +	u8			reg_write_tx_buf[4];
> +	u8			reg_read_tx_buf[1];
> +	u8			reg_read_rx_buf[3];
> +	u8			fifo_tx_buf[2];
> +	u8			fifo_rx_buf[AD4130_FIFO_SIZE *
> +					    AD4130_FIFO_MAX_SAMPLE_SIZE];
> +};
> +

> +static int ad4130_set_fifo_watermark(struct iio_dev *indio_dev, unsigned int val)
> +{
> +	struct ad4130_state *st = iio_priv(indio_dev);
> +	unsigned int eff;
> +	int ret;
> +
> +	if (val > AD4130_FIFO_SIZE)
> +		return -EINVAL;
> +
> +	/*
> +	 * Always set watermark to a multiple of the number of enabled channels
> +	 * to avoid making the FIFO unaligned.
> +	 */
> +	eff = rounddown(val, st->num_enabled_channels);
> +
> +	mutex_lock(&st->lock);
> +
> +	ret = regmap_update_bits(st->regmap, AD4130_REG_FIFO_CONTROL,
> +				 AD4130_WATERMARK_MASK,
> +				 FIELD_PREP(AD4130_WATERMARK_MASK,
> +					    ad4130_watermark_reg_val(eff)));
> +	if (ret)
> +		goto out;
> +
> +	st->effective_watermark = eff;
> +	st->watermark = val;

Hmm this is a potential inconsistency in the IIO ABI.
ABI docs describes watermark as being number of 'scan elements' which is
not the clearest text we could have gone with...

Now I may well have made a mistake in the following as it's rather a long time
since I last looked at the core handling for this...

The core treats it as number datum (which is same as a scan) when using
it for the main watermark attribute and also when using watermarks with the
kfifo (the IIO fifo is made up of objects each of which is a scan. So kfifo_len()
returns the number of scans.
 
Looking very quickly at a few other drivers 
adxl367 seems to use number of samples.
adxl372 is using number of scans.
bmc150 hardware seems to work on basis of frame count which I 'think' is probably scans.
fxls8962 uses 'samples count' which is not clearly defined in the datasheet but there
is an example showing that it's scans (I think)...
lsm6dsx - some of the fifos used with this are based on tagged data so the connection to
what hits the front end buffers is non obvious.

So, not great for consistency :( 

Going forwards i think we should standardize the hardware fifo watermark on what is being
used for the software watermark which I believe is number of scans.
Not necessary much we can do about old drivers though due to risk of breaking ABI...
We should make the documentation clearer though.

> +
> +out:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +


...

> +
> +static int ad4130_parse_fw_channel(struct iio_dev *indio_dev,
> +				   struct fwnode_handle *child)
> +{
> +	struct ad4130_state *st = iio_priv(indio_dev);
> +	unsigned int index = indio_dev->num_channels++;
> +	struct device *dev = &st->spi->dev;
> +	struct ad4130_chan_info *chan_info;
> +	struct iio_chan_spec *chan;
> +	u32 pins[2];
> +	int ret;
> +
> +	if (index >= AD4130_MAX_CHANNELS)
> +		return dev_err_probe(dev, -EINVAL, "Too many channels\n");
> +
> +	chan = &st->chans[index];
> +	chan_info = &st->chans_info[index];
> +
> +	*chan = ad4130_channel_template;
> +	chan->scan_type.realbits = st->chip_info->resolution;
> +	chan->scan_type.storagebits = st->chip_info->resolution;
> +	chan->scan_index = index;
> +
> +	chan_info->slot = AD4130_INVALID_SLOT;
> +	chan_info->setup.fs = AD4130_FS_MIN;
> +	chan_info->initialized = true;
> +
> +	ret = fwnode_property_read_u32_array(child, "diff-channels", pins,
> +					     ARRAY_SIZE(pins));
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4130_validate_diff_channels(st, pins, ARRAY_SIZE(pins));
> +	if (ret)
> +		return ret;
> +
> +	chan->channel = pins[0];
> +	chan->channel2 = pins[1];
> +
> +	ret = ad4130_parse_fw_setup(st, child, &chan_info->setup);
> +	if (ret)
> +		return ret;
> +
> +	fwnode_property_read_u32(child, "adi,excitation-pin-0",
> +				 &chan_info->iout0);
> +	if (chan_info->setup.iout0_val != AD4130_IOUT_OFF) {

It would be slightly better to set an explicit default value here as the fact it
is 0 is hidden by the enum. e.g.
	chan_info->iout0 = AD4130_IOUT_OFF;
	fwnode_property_read_u32(child, "adi,excitation-pin-0",
			 	 &chan_info->iout0);
	if (chan_info->....
That would save reviewers wondering what the default is and having to go
check the enum (and I'm lazy :)

> +		ret = ad4130_validate_excitation_pin(st, chan_info->iout0);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	fwnode_property_read_u32(child, "adi,excitation-pin-1",
> +				 &chan_info->iout1);
> +	if (chan_info->setup.iout1_val != AD4130_IOUT_OFF) {
> +		ret = ad4130_validate_excitation_pin(st, chan_info->iout1);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad4130_parse_fw_children(struct iio_dev *indio_dev)
> +{
> +	struct ad4130_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	struct fwnode_handle *child;
> +	int ret;
> +
> +	indio_dev->channels = st->chans;
> +
> +	device_for_each_child_node(dev, child) {
> +		ret = ad4130_parse_fw_channel(indio_dev, child);
> +		if (ret) {
> +			fwnode_handle_put(child);
> +			break;
Trivial, but slight preference for return ret here and
then return 0 below.

> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int ad4310_parse_fw(struct iio_dev *indio_dev)
> +{
> +	struct ad4130_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	u32 ext_clk_freq = AD4130_MCLK_FREQ_76_8KHZ;
> +	bool int_clk_out = false;
> +	unsigned int i;
> +	int avdd_uv;
> +	int irq;
> +	int ret;
> +

...

> +
> +	device_property_read_u32(dev, "adi,ext-clk-freq", &ext_clk_freq);

I'll note this in reviewing the binding, but the naming should incorporate the
units.

> +	if (ext_clk_freq != AD4130_MCLK_FREQ_153_6KHZ &&
> +	    ext_clk_freq != AD4130_MCLK_FREQ_76_8KHZ)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid external clock frequency %u\n",
> +				     ext_clk_freq);
> +

...

> +
> +	return 0;
> +}
> +

> +
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

Trivial but I'd prefer to see this treated as a field as well for consistency.
	val = FIELD_PREP(AD4130_CSB_EN_MASK, 1);

> +	val |= FIELD_PREP(AD4130_BIPOLAR_MASK, st->bipolar);
> +	val |= FIELD_PREP(AD4130_INT_REF_EN_MASK, st->int_ref_en);
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

