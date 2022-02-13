Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB87D4B3C4A
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 17:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237096AbiBMQmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 11:42:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbiBMQmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 11:42:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9C65AEE3;
        Sun, 13 Feb 2022 08:41:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D74F3B8069A;
        Sun, 13 Feb 2022 16:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AE1C340F0;
        Sun, 13 Feb 2022 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644770516;
        bh=kUhWsiT726hh3d+Q4QTvYQe9Waodt0JYRn2TX7NIR6k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OH1ybJh11ejoklwHhmT4uPdunpMwpZHRG5EOQ84X1ofiH/XVDHt97gL0iiE8pZdzC
         02KI6UIC4tWaIcfY4BE4L2NEv+Ot1L0N74OlKd/0wm+AIZkzDFzq939dyd3nRm+t0V
         O5hbD705ahe4Wd5uuLpHr+EbsNumS7UjNW0nLhTQVjQwO5keHK2rNNzzKYauHre/b2
         emajjFCEtCJrXVH9cYXj5euyL8hlpcPlpVr+uF7GMjk6LPVXA87yZkmBJDQx/KpIqf
         Vrhe41M53WCVWcz+a77F2B2brNaV/VvKKGHX+nYcihAEOrRMbtvC6NeXGy7Kr7Kpyp
         62io0dP8qLhZQ==
Date:   Sun, 13 Feb 2022 16:48:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] iio:amplifiers:ada4250: add support for ADA4250
Message-ID: <20220213164837.1324409a@jic23-huawei>
In-Reply-To: <20220212105153.19748-1-antoniu.miclaus@analog.com>
References: <20220212105153.19748-1-antoniu.miclaus@analog.com>
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

On Sat, 12 Feb 2022 12:51:51 +0200
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

One comment as result of a change - your buffer isn't DMA safe
when done like this.

A few more things noticed on reading through again + a few places
where some documentation / comments would be great.

Thanks,

Jonathan

> ---
> changes in v2:
>  - move all IIO attributes under a single channel
>  - use DMA safe buffers + endian conversion
>  - fix odd spacing in Kconfig

That got worse :( 

>  drivers/iio/amplifiers/Kconfig   |  11 +
>  drivers/iio/amplifiers/Makefile  |   1 +
>  drivers/iio/amplifiers/ada4250.c | 384 +++++++++++++++++++++++++++++++
>  3 files changed, 396 insertions(+)
>  create mode 100644 drivers/iio/amplifiers/ada4250.c
> 
> diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
> index 5eb1357a9c78..0099fd26fa89 100644
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
> +          Say yes here to build support for Analog Devices ADA4250
> +          SPI Amplifier's support. The driver provides direct access via
> +          sysfs.

Fix this indenting.  Should be a tab plus 2 spaces I think.

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
> index 000000000000..c8b2c3382e33
> --- /dev/null
> +++ b/drivers/iio/amplifiers/ada4250.c
> @@ -0,0 +1,384 @@
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
> +#define ADA4250_SNSR_CAL_VAL_MSK    GENMASK(7, 0)
> +
> +/* ADA4250_REG_SNSR_CAL_CNFG Bit Definition */
If you chose appropriate naming I'd hope the
register / field relationship woudl be clear.

ADA4250_SNSR_CAL_CFG_BIAS_MSK

maybe?  Not sure what the set brings you in the way
of useful information.  Mind you, not sure what
SNSR tells you over simply 
ADA4250_CAL_CFG_BIAS_MSK
ADA4250_REG_CAL_CFG
etc



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
> +static const int hwgain_table[] = {0, 1, 2, 3, 4, 5, 6, 7};

While hw gain is often not somethign we put clear units on
it does rather feel like the values in the comment would make more sense
for what you expose as the user interface for this.

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
> +	/* Compute Range and VLSB for the Sensor Offset Calibration */

VLSB is what?  Voltage per LSB?

> +	for (i = ADA4250_RANGE1; i <= ADA4250_RANGE4; i++) {

Maths here is unusual. If you can add a comment on what it is doing
that would be great.

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
> +	if (offset_uv < 0) {

This is sufficiently unusual I'd like to see a comment expalingin why setting
that bit makes sense. Also use the BIT() macro.

> +		offset_raw |= 1 << 8;
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

> +
> +static int ada4250_init(struct ada4250_state *st)
> +{
> +	int ret;
> +	u16 chip_id;
> +	u8 data[2] ____cacheline_aligned;

Unfortunately I'm fairly sure this isn't sufficient.

So the reason it works in a structure such as iio_priv() is that the
allocation is guaranteed to padded to at least the same step as the
alignment.  So that our allocation starts at the beginning of
a cacheline and that the rest of the cacheline is padded so that nothing
else ends up in it.  (Note this is also why DMA safe buffers are always
at the end of iio_priv() structures - you can have rx and tx buffers
in the same cacheline assuming the same device doing the DMA, but you
can't have arbitrary data there).

As a side note, using aligned pragmas on stack variables in general used
be broken. I'm not sure on whether the current minimum compiler version
is now fine with them or not.

Also, we can use the __aligned(8) trick for non dma buffers to force timestamp
alignment as we don't care about what comes after those (so you'll see
that in quite a few IIO drivers).


> +	struct spi_device *spi = st->spi;
> +
...
