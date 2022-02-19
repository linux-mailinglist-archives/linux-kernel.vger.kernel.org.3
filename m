Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E514BCA63
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 20:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243070AbiBSTDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 14:03:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiBSTDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 14:03:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C135D19D;
        Sat, 19 Feb 2022 11:02:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B89860DFB;
        Sat, 19 Feb 2022 19:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2187C004E1;
        Sat, 19 Feb 2022 19:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645297367;
        bh=tj0EP2VurH6MfpD42AsvaZR9bvac+IhL8NrnCSENi8g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fCES3hd8m9ArBa3CY92cwD2O+v7Y/61E4kkOlvkQj359shYE359i50DPZUTPGoABH
         UbXvTP12FdP2e9OI/nfX8nDG+siB9bGag4T9/+Ycr8mc06ga8WA/VICTePSnT8z9cu
         b7Sl+RyMSmxVDC9qHYlH3crpfvBDCTumeiIZptg+4OvvnUrYPStIud7NTXWpQ9wiy3
         6Y0PfkykA8LWoi2SLnbtGTLllbKmsAsNDxsQTkzJCjY+WwYqlmCdEAiNv7xFNaO6Ns
         fF1Q8RKUHJm+cAYAd4fokvXDhe2INRYnItUeYB17vYzrr5HfVD6a0LVDWltOAmVyHR
         9c4QRrer+fNYw==
Date:   Sat, 19 Feb 2022 19:09:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v5 2/2] iio: frequency: admv4420.c: Add support for
 ADMV4420
Message-ID: <20220219190936.72000244@jic23-huawei>
In-Reply-To: <20220218150738.94735-2-cristian.pop@analog.com>
References: <20220218150738.94735-1-cristian.pop@analog.com>
        <20220218150738.94735-2-cristian.pop@analog.com>
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

On Fri, 18 Feb 2022 17:07:38 +0200
Cristian Pop <cristian.pop@analog.com> wrote:

> Add support for K Band Downconverter with Integrated
> Fractional-N PLL and VCO.
> More info:
> https://www.analog.com/en/products/admv4420.html
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>

Just some really minor comment from a final read through.

Mainly we need to leave time for futher DT review.

Thanks,

Jonathan


> ---
>  drivers/iio/frequency/Kconfig    |  10 +
>  drivers/iio/frequency/Makefile   |   1 +
>  drivers/iio/frequency/admv4420.c | 400 +++++++++++++++++++++++++++++++
>  3 files changed, 411 insertions(+)
>  create mode 100644 drivers/iio/frequency/admv4420.c
> 
> diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
> index b44036f843af..d905214a0be6 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig
> @@ -60,6 +60,16 @@ config ADMV1013
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called admv1013.
>  
> +config ADMV4420
> +       tristate "Analog Devices ADMV4420 K Band Downconverter"
> +       depends on SPI
> +       help
> +         Say yes here to build support for Analog Devices K Band
> +         Downconverter with integrated Fractional-N PLL and VCO.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called admv4420.
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
> index 000000000000..b4579505372e
> --- /dev/null
> +++ b/drivers/iio/frequency/admv4420.c
> @@ -0,0 +1,400 @@
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
> +#include <linux/units.h>
> +
> +#include <asm/unaligned.h>
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
> +#define ADMV4420_SPI_CONFIG_1_SDOACTIVE		(BIT(4) | BIT(3))
> +#define ADMV4420_SPI_CONFIG_1_ENDIAN		(BIT(5) | BIT(2))
> +#define ADMV4420_SPI_CONFIG_1_SOFTRESET		(BIT(7) | BIT(1))
> +
> +#define ADMV4420_REFERENCE_DIVIDE_BY_2_MASK	BIT(0)
> +#define ADMV4420_REFERENCE_MODE_MASK		BIT(1)
> +#define ADMV4420_REFERENCE_IN_MODE(x)		FIELD_PREP(ADMV4420_REFERENCE_MODE_MASK, x)
> +#define ADMV4420_REFERENCE_DOUBLER_MASK		BIT(2)
> +#define ADMV4420_REFERENCE_DOUBLER(x)		FIELD_PREP(ADMV4420_REFERENCE_DOUBLER_MASK, x)

I'd have preferred that you only defined the MASK then used FIELD_PREP inline
as that tends to be easier to review than hiding macros behind macros.

> +

> +
> +struct admv4420_state {
> +	struct spi_device		*spi;
> +	struct regmap			*regmap;
> +	u64				vco_freq_hz;
> +	u64				lo_freq_hz;
> +	struct admv4420_reference_block ref_block;
> +	struct admv4420_n_counter	n_counter;
> +	enum admv4420_mux_sel		mux_sel;
> +	struct mutex			lock;
> +	u8				transf_buf[4] ____cacheline_aligned;
> +};

...

> +static int admv4420_set_n_counter(struct admv4420_state *st, u32 int_val,
> +				  u32 frac_val, u32 mod_val)
> +{
> +	int ret;
> +
> +	put_unaligned_le32(frac_val, st->transf_buf);

Comment rather than suggestion that you change this, but we actually know
transf_buf is aligned, so could have used cpu_to_le32() as it is __cacheline_aligned
which is way more than 32 bits.

> +	ret = regmap_bulk_write(st->regmap, ADMV4420_FRAC_L, st->transf_buf, 3);
> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_le32(mod_val, st->transf_buf);
> +	ret = regmap_bulk_write(st->regmap, ADMV4420_MOD_L, st->transf_buf, 3);
> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_le32(int_val, st->transf_buf);
> +	return regmap_bulk_write(st->regmap, ADMV4420_INT_L, st->transf_buf, 2);
> +}
> +

...

> +static void admv4420_fw_parse(struct admv4420_state *st)
> +{
> +	struct fwnode_handle *fwnode = dev_fwnode(&st->spi->dev);
> +	u32 tmp;
> +	int ret;
> +
> +	ret = fwnode_property_read_u32(fwnode, "adi,lo-freq-khz", &tmp);

Why not device_property_read_u32?

> +	if (!ret)
> +		st->lo_freq_hz = (u64)tmp * KILO;
> +
> +	st->ref_block.ref_single_ended = fwnode_property_read_bool(fwnode,
> +								   "adi,ref-ext-single-ended-en");

device_property_read_bool()?

> +}
> +

