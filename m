Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE384AAAD3
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380859AbiBESRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbiBESRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:17:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995BCC061348;
        Sat,  5 Feb 2022 10:17:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 244686118B;
        Sat,  5 Feb 2022 18:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BC8C340E8;
        Sat,  5 Feb 2022 18:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644085035;
        bh=guWqiYrr15Gj2kWEROHkgD2HvtfNgaW3CnBysHPHHjY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E2kdTMR4+jgnBUrlamXLzcLjGYen70N2qpyBXosn7aAsak/GdSoO+m4aEdqVEMJ0b
         qE4ZDS8wjwhRghsz7zXTMn47sEUfanZKJru4aUV5Qj6c/KnmJdBgn/6jQiyEL7uJ04
         p0EKMGNNM4O/fDcALHnBwAsv8awtN7KGcr0DM7FeQCta6fdN43l6jzIBJhSu9k0+5U
         fvwP5AR0oijsICzrVEU10kMapqRM3EiN7GeB7fL4uDBz6gxYuz4UuHLougc0+gd6QB
         so6/svuKUDsZIiom83xLN2v/VAzs+HGitfo6DG9/VV8k3qwAlgGMZ6qVx2MQ2YKd6u
         OG/ltOWQ03rtw==
Date:   Sat, 5 Feb 2022 18:23:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] iio:frequency:admv4420.c: Add support for
 ADMV4420
Message-ID: <20220205182346.017c84cb@jic23-huawei>
In-Reply-To: <20220201162351.53520-2-cristian.pop@analog.com>
References: <20220201162351.53520-1-cristian.pop@analog.com>
        <20220201162351.53520-2-cristian.pop@analog.com>
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

On Tue, 1 Feb 2022 18:23:51 +0200
Cristian Pop <cristian.pop@analog.com> wrote:

> Add support for K Band Downconverter with Integrated
> Fractional-N PLL and VCO.
> More info:
> https://www.analog.com/en/products/admv4420.html
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
Hi Cristian,

A few comments inline.

Thanks,

Jonathan

> ---
> changes in v2:
>  - Remove 'COMMON_CLK' since is not dependent on it
>  - Reduce some line to maximum 80 characters
>  - Use bulk writes instead of 'regmap_write()' with 'FIELD_GET'
>  - Use generic fw properties
>  - Pull ternary operating out on it's own line
>  - Remove initialisation with 0 of local 'val' variable
>  - Return 'regmap_write()' directly
>  - Use 'dev_err_probe()' instead of 'dev_err()'
>  - Remove 'indio_dev->dev.parent' initialisation, automatically set
>  drivers/iio/frequency/Kconfig    |  10 +
>  drivers/iio/frequency/Makefile   |   1 +
>  drivers/iio/frequency/admv4420.c | 397 +++++++++++++++++++++++++++++++
>  3 files changed, 408 insertions(+)
>  create mode 100644 drivers/iio/frequency/admv4420.c
> 
> diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
> index b44036f843af..4e929e8bf255 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig
> @@ -60,6 +60,16 @@ config ADMV1013
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called admv1013.
>  
> +config ADMV4420
> +	tristate "Analog Devices ADMV4420 K Band Downconverter"
> +	depends on SPI
> +	help
> +	  Say yes here to build support for Analog Devices K Band
> +	  Downconverter with integrated Fractional-N PLL and VCO.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called admv4420.
> +
>  config ADRF6780
>          tristate "Analog Devices ADRF6780 Microwave Upconverter"
>          depends on SPI
> diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
> index ae6899856c99..782e5baa1630 100644
> --- a/drivers/iio/frequency/Makefile
> +++ b/drivers/iio/frequency/Makefile
> @@ -8,4 +8,5 @@ obj-$(CONFIG_AD9523) += ad9523.o
>  obj-$(CONFIG_ADF4350) += adf4350.o
>  obj-$(CONFIG_ADF4371) += adf4371.o
>  obj-$(CONFIG_ADMV1013) += admv1013.o
> +obj-$(CONFIG_ADMV4420) += admv4420.o
>  obj-$(CONFIG_ADRF6780) += adrf6780.o
> diff --git a/drivers/iio/frequency/admv4420.c b/drivers/iio/frequency/admv4420.c
> new file mode 100644
> index 000000000000..ae649d104172
> --- /dev/null
> +++ b/drivers/iio/frequency/admv4420.c
> @@ -0,0 +1,397 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +/*
> + * ADMV4420
> + *
> + * Copyright 2021 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +/* ADMV4420 Register Map */
> +#define ADMV4420_SPI_CONFIG_1			0x00
> +#define ADMV4420_SPI_CONFIG_2			0x01
> +#define ADMV4420_CHIPTYPE			0x03
> +#define ADMV4420_PRODUCT_ID_L			0x04
> +#define ADMV4420_PRODUCT_ID_H			0x05
> +#define ADMV4420_SCRATCHPAD			0x0A
> +#define ADMV4420_SPI_REV			0x0B
> +#define ADMV4420_ENABLES			0x103
> +#define ADMV4420_SDO_LEVEL			0x108
> +#define ADMV4420_INT_L				0x200
> +#define ADMV4420_INT_H				0x201
> +#define ADMV4420_FRAC_L				0x202
> +#define ADMV4420_FRAC_M				0x203
> +#define ADMV4420_FRAC_H				0x204
> +#define ADMV4420_MOD_L				0x208
> +#define ADMV4420_MOD_M				0x209
> +#define ADMV4420_MOD_H				0x20A
> +#define ADMV4420_R_DIV_L			0x20C
> +#define ADMV4420_R_DIV_H			0x20D
> +#define ADMV4420_REFERENCE			0x20E
> +#define ADMV4420_VCO_DATA_READBACK1		0x211
> +#define ADMV4420_VCO_DATA_READBACK2		0x212
> +#define ADMV4420_PLL_MUX_SEL			0x213
> +#define ADMV4420_LOCK_DETECT			0x214
> +#define ADMV4420_BAND_SELECT			0x215
> +#define ADMV4420_VCO_ALC_TIMEOUT		0x216
> +#define ADMV4420_VCO_MANUAL			0x217
> +#define ADMV4420_ALC				0x219
> +#define ADMV4420_VCO_TIMEOUT1			0x21C
> +#define ADMV4420_VCO_TIMEOUT2			0x21D
> +#define ADMV4420_VCO_BAND_DIV			0x21E
> +#define ADMV4420_VCO_READBACK_SEL		0x21F
> +#define ADMV4420_AUTOCAL			0x226
> +#define ADMV4420_CP_STATE			0x22C
> +#define ADMV4420_CP_BLEED_EN			0x22D
> +#define ADMV4420_CP_CURRENT			0x22E
> +#define ADMV4420_CP_BLEED			0x22F
> +
> +
> +#define ADMV4420_SPI_CONFIG_1_SOFTRESET_	BIT(7)

I'm curious...
What does the _ postfix indicate here? The datasheet uses it
as well but I couldn't immediately spot and explanation.

> +#define ADMV4420_SPI_CONFIG_1_ENDIAN_		BIT(5)
> +#define ADMV4420_SPI_CONFIG_1_SDOACTIVE_	BIT(4)
> +#define ADMV4420_SPI_CONFIG_1_SDOACTIVE		BIT(3)
> +#define ADMV4420_SPI_CONFIG_1_ENDIAN		BIT(2)
> +#define ADMV4420_SPI_CONFIG_1_SOFTRESET		BIT(1)
> +
> +#define ADMV4420_REFERENCE_IN_MODE(x)		(x << 1)
Define a mask here and then use FIELD_PREP with that to do the
shift. Same for teh one below.

> +#define ADMV4420_REFERENCE_DOUBLER(x)		(x << 2)
> +#define ADMV4420_REFERENCE_DIVIDE_BY_2_MASK	BIT(0)
> +#define ADMV4420_REFERENCE_MODE_MASK		BIT(1)
> +#define ADMV4420_REFERENCE_DOUBLER_MASK		BIT(2)
> +#define ADMV4420_REF_DIVIDER_MAX_VAL		GENMASK(9, 0)
> +#define ADMV4420_N_COUNTER_INT_MAX		GENMASK(15, 0)
> +#define ADMV4420_N_COUNTER_FRAC_MAX		GENMASK(23, 0)
> +#define ADMV4420_N_COUNTER_MOD_MAX		GENMASK(23, 0)
> +
> +#define ENABLE_PLL				BIT(6)
> +#define ENABLE_LO				BIT(5)
> +#define ENABLE_VCO				BIT(3)
> +#define ENABLE_IFAMP				BIT(2)
> +#define ENABLE_MIXER				BIT(1)
> +#define ENABLE_LNA				BIT(0)
> +
> +#define ADMV4420_SCRATCH_PAD_VAL_1              0xAD
> +#define ADMV4420_SCRATCH_PAD_VAL_2              0xEA
> +
> +#define ADMV4420_REF_FREQ_HZ                    50000000
> +#define MAX_N_COUNTER                           655360UL
> +#define MAX_R_DIVIDER                           1024
> +#define ADMV4420_DEFAULT_LO_FREQ_HZ		16750000000ULL
> +
> +enum admv4420_mux_sel {
> +	ADMV4420_LOW = 0,
> +	ADMV4420_LOCK_DTCT = 1,
> +	ADMV4420_R_COUNTER_PER_2 = 4,
> +	ADMV4420_N_CONUTER_PER_2 = 5,
> +	ADMV4420_HIGH = 8,
> +};
> +
> +struct admv4420_reference_block {
> +	bool doubler_en;
> +	bool divide_by_2_en;
> +	bool ref_single_ended;
> +	u32 divider;
> +};
> +
> +struct admv4420_n_counter {
> +	u32 int_val;
> +	u32 frac_val;
> +	u32 mod_val;
> +	u32 n_counter;
> +};
> +
> +struct admv4420_state {
> +	struct spi_device		*spi;
> +	struct regmap			*regmap;
> +	u64				pfd_freq_hz;
> +	u64				vco_freq_hz;
> +	u64				lo_freq_hz;
> +	struct admv4420_reference_block ref_block;
> +	struct admv4420_n_counter	n_counter;
> +	enum admv4420_mux_sel		mux_sel;
> +	struct mutex			lock;
> +};
> +
> +static const struct regmap_config admv4420_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 8,
> +	.read_flag_mask = BIT(7),
> +};
> +
> +static int admv4420_reg_access(struct iio_dev *indio_dev,
> +			       u32 reg, u32 writeval,
> +			       u32 *readval)
> +{
> +	struct admv4420_state *st = iio_priv(indio_dev);
> +
> +	if (readval)
> +		return regmap_read(st->regmap, reg, readval);
> +	else
> +		return regmap_write(st->regmap, reg, writeval);
> +}
> +
> +static int admv4420_set_n_counter(struct admv4420_state *st, u32 int_val,
> +				  u32 frac_val, u32 mod_val)
> +{
> +	u8 vals[3];
There is a fun long running discussion on whether regmap_bulk_read()
is always fine with being passed buffers that aren't DMA safe.
Last time I checked, the currently implementation probably is but
we can't rely on it staying so.  So this buffer should be DMA safe which
basically means allocate it on the stack (or use the ____cache_line_aligned
marking and put it at the end of the admv4420_state structure.


> +	int ret;
> +
> +	vals[0] = frac_val;
> +	vals[1] = frac_val >> 8;
> +	vals[2] = frac_val >> 16;
> +
> +	ret = regmap_bulk_write(st->regmap, ADMV4420_FRAC_L, vals, 3);
> +	if (ret)
> +		return ret;
> +
> +	vals[0] = mod_val;
> +	vals[1] = mod_val >> 8;
> +	vals[2] = mod_val >> 16;
> +
> +	ret = regmap_bulk_write(st->regmap, ADMV4420_MOD_L, vals, 3);
> +	if (ret)
> +		return ret;
> +
> +	vals[0] = int_val;
> +	vals[1] = int_val >> 8;

These look like unaligned puts. Please use appropriate put_unaligned_xx

> +
> +	return regmap_bulk_write(st->regmap, ADMV4420_INT_L, vals, 2);
> +}
> +
> +static int admv4420_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long info)
> +{
> +	struct admv4420_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		*val = div_u64(st->lo_freq_hz, 1000000);

MICRO from units.h would work well here.

> +		div_u64_rem(st->lo_freq_hz, 1000000, val2);
Also, why can't you just do
		*val = div_u64_rem(st->lo_freq_hz, MICRO, val2); ?
If you take a look at how div_u64 is implemented it uses
div_u64_rem() anyway.


> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info admv4420_info = {
> +	.read_raw = admv4420_read_raw,
> +	.debugfs_reg_access = &admv4420_reg_access,
> +};
> +
> +static const struct iio_chan_spec admv4420_channels[] = {
> +	{
> +		.type = IIO_ALTVOLTAGE,
> +		.output = 0,
> +		.indexed = 1,
> +		.channel = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY),
> +	},
> +};
> +
> +static void admv4420_fw_parse(struct admv4420_state *st)
> +{
> +	struct fwnode_handle *fwnode = dev_fwnode(&st->spi->dev);
> +
> +	fwnode_property_read_u64(fwnode, "adi,lo-freq-hz", &st->lo_freq_hz);
> +	st->ref_block.ref_single_ended = fwnode_property_read_bool(fwnode,
> +								   "adi,ref-ext-single-ended-en");
> +}
> +
> +static inline uint64_t admv4420_calc_pfd_vco(struct admv4420_state *st)
> +{
> +	return div_u64(st->vco_freq_hz * 10, st->n_counter.n_counter);
> +}
> +
> +static inline uint64_t admv4420_calc_pfd_ref(struct admv4420_state *st)
> +{
> +	uint64_t tmp;
> +	u8 doubler, divide_by_2;
> +
> +	doubler = st->ref_block.doubler_en ? 2 : 1;
> +	divide_by_2 = st->ref_block.divide_by_2_en ? 2 : 1;
> +
> +	tmp = ADMV4420_REF_FREQ_HZ * doubler;

Unless I'm missing something this doesn't benefit from 64 bit maths.
I think all possible values fit in a 32 bit integer.  If it needs
64 bit maths, perhaps a comment to say why would be good to have.

> +	return div_u64(tmp, st->ref_block.divider * divide_by_2);
> +}
> +
> +static int admv4420_calc_parameters(struct admv4420_state *st)
> +{
> +	u64 pfd_ref, pfd_vco;
> +	bool sol_found = false;
> +
> +	st->ref_block.doubler_en = false;
> +	st->ref_block.divide_by_2_en = false;
> +	st->vco_freq_hz = div_u64(st->lo_freq_hz, 2);
> +
> +	for (st->ref_block.divider = 1; st->ref_block.divider < MAX_R_DIVIDER;
> +	    st->ref_block.divider++) {
> +		pfd_ref = admv4420_calc_pfd_ref(st);
> +		for (st->n_counter.n_counter = 1; st->n_counter.n_counter < MAX_N_COUNTER;
> +		    st->n_counter.n_counter++) {
> +			pfd_vco = admv4420_calc_pfd_vco(st);
> +			if (pfd_ref == pfd_vco) {
> +				sol_found = true;
> +				break;
> +			}
> +		}
> +
> +		if (sol_found)
> +			break;
> +
> +		st->n_counter.n_counter = 1;
> +	}
> +	if (!sol_found)
> +		return -1;
> +
> +	st->n_counter.int_val = div_u64_rem(st->n_counter.n_counter, 10, &st->n_counter.frac_val);
> +	st->n_counter.mod_val = 10;
> +
> +	return 0;
> +}
> +
> +static int admv4420_setup(struct iio_dev *indio_dev)
> +{
> +	struct admv4420_state *st = iio_priv(indio_dev);
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, ADMV4420_SPI_CONFIG_1,
> +			   ADMV4420_SPI_CONFIG_1_SOFTRESET_ |
> +			   ADMV4420_SPI_CONFIG_1_SOFTRESET);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADMV4420_SPI_CONFIG_1,
> +			   ADMV4420_SPI_CONFIG_1_SDOACTIVE_ | ADMV4420_SPI_CONFIG_1_SDOACTIVE |
> +			   ADMV4420_SPI_CONFIG_1_ENDIAN_ | ADMV4420_SPI_CONFIG_1_ENDIAN);
This could just as clearly be written as:

	ret = regmap_write(st->regmap, ADMV4420_SPI_CONFIG_1,
			   ADMV4420_SPI_CONFIG_1_SDOACTIVE_ |
			   ADMV4420_SPI_CONFIG_1_SDOACTIVE |
			   ADMV4420_SPI_CONFIG_1_ENDIAN_ |
			   ADMV4420_SPI_CONFIG_1_ENDIAN);
and fit under 80 chars

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADMV4420_SCRATCHPAD, ADMV4420_SCRATCH_PAD_VAL_1);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, ADMV4420_SCRATCHPAD, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != ADMV4420_SCRATCH_PAD_VAL_1) {
> +		dev_err(indio_dev->dev.parent, "Failed ADMV4420 to read/write scratchpad %x ", val);

You have multiple uses of indio_dev->dev.parent in here. 
I suggest using a local variable.

> +		return -EIO;
> +	}
> +
> +	ret = regmap_write(st->regmap, ADMV4420_SCRATCHPAD, ADMV4420_SCRATCH_PAD_VAL_2);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, ADMV4420_SCRATCHPAD, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != ADMV4420_SCRATCH_PAD_VAL_2) {
> +		dev_err(indio_dev->dev.parent, "Failed to read/write scratchpad %x ", val);
> +		return -EIO;
> +	}
> +
> +	st->mux_sel = ADMV4420_LOCK_DTCT;
> +	st->lo_freq_hz = ADMV4420_DEFAULT_LO_FREQ_HZ;
> +
> +	admv4420_fw_parse(st);
> +
> +	ret = admv4420_calc_parameters(st);
> +	if (ret) {
> +		dev_err(indio_dev->dev.parent, "Failed calc parameters for %lld ", st->vco_freq_hz);
> +		return ret;
> +	}
> +
> +	ret = regmap_write(st->regmap, ADMV4420_R_DIV_L,
> +			   FIELD_GET(0xFF, st->ref_block.divider));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADMV4420_R_DIV_H,
> +			   FIELD_GET(0xFF00, st->ref_block.divider));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADMV4420_REFERENCE,
> +			   st->ref_block.divide_by_2_en |
> +			   ADMV4420_REFERENCE_IN_MODE(st->ref_block.ref_single_ended) |
> +			   ADMV4420_REFERENCE_DOUBLER(st->ref_block.doubler_en));
> +	if (ret)
> +		return ret;
> +
> +	ret = admv4420_set_n_counter(st, st->n_counter.int_val, st->n_counter.frac_val,
> +				     st->n_counter.mod_val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, ADMV4420_PLL_MUX_SEL, st->mux_sel);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, ADMV4420_ENABLES, ENABLE_PLL | ENABLE_LO | ENABLE_VCO |
> +			    ENABLE_IFAMP | ENABLE_MIXER | ENABLE_LNA);

Tidy this up.  I'd rather see it aligned as

	return regmap_write(st->regmap, ADMV4420_ENABLES,
			    ENABLE_PLL | ENABLE_LO | ENABLE_VCO |
			    ENABLE_IFAMP | ENABLE_MIXER | ENABLE_LNA);
so that the set of |'d values look less like different parameters.

> +}
> +
> +static int admv4420_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct admv4420_state *st;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init_spi(spi, &admv4420_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
> +				     "Failed to initializing spi regmap\n");
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +	st->regmap = regmap;
> +
> +	indio_dev->name = "admv4420";
> +	indio_dev->info = &admv4420_info;
> +	indio_dev->channels = admv4420_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(admv4420_channels);
> +
> +	ret = admv4420_setup(indio_dev);
> +	if (ret) {
> +		dev_err(&spi->dev, "Setup ADMV4420 failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct of_device_id admv4420_of_match[] = {
> +	{ .compatible = "adi,admv4420" },
> +	{ },

No comma after null terminators like this.  We won't ever add
a line after them.

> +};
> +
> +MODULE_DEVICE_TABLE(of, admv4420_of_match);
> +
> +static struct spi_driver admv4420_driver = {
> +	.driver = {
> +		.name	= "admv4420",
> +		.of_match_table = admv4420_of_match,
> +	},
> +	.probe		= admv4420_probe,

Trivial thing but don't do table indenting link this.
As you can see clearly here it doesn't result in nice alignment
and it often ends up being a pain when some new entry requires
re-indenting all the others.

> +};
> +module_spi_driver(admv4420_driver);
> +
> +MODULE_AUTHOR("Cristian Pop <cristian.pop@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADMV44200 K Band Downconverter");
> +MODULE_LICENSE("Dual BSD/GPL");

