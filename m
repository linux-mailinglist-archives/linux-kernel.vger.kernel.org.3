Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CFF50D2F2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 17:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiDXPqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 11:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiDXPqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 11:46:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD25E32EFA;
        Sun, 24 Apr 2022 08:43:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F90F61033;
        Sun, 24 Apr 2022 15:43:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4756DC385A7;
        Sun, 24 Apr 2022 15:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650815016;
        bh=LVe8ehDaLFY4166uKvg5YQ81xwVvz9DM1SS04H4e83k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ExOrsgZxgxRPqqLFPgCYiCFWFvZUKYdbNRkBO+C9uv5Kti7n3DGDhWLA1rSdz9Fys
         3/zJY+Q63H2GjbGd+4Ao/aNK5hu9mZ27/UG4gyX+b7kfo9SIMC4rAiSXAFdPPHgsbY
         1DVoKEzddS1c+n8N7Z39Ytgks8I3HBX7ISxCs8StImiw0e0YlGs/4Uq2eh+0j0sCsC
         V7/zm2M6AOSYxSf5WLAZLf9x8Al5zyAZkU1Ms1hvFTBMSFE4IdGuCE5oGLXp8Khz2/
         IQviD73aihDcC5y+EgVQTiJoL7i+ny0UT900LN/hvBjgamas6frLcoU49huGndTqk0
         bG1RcNsVPSk4g==
Date:   Sun, 24 Apr 2022 16:51:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v1 3/3] iio: adc: ad4130: add AD4130 driver
Message-ID: <20220424165143.068ba254@jic23-huawei>
In-Reply-To: <59033522-9095-319e-2710-cfac79e2d7e4@gmail.com>
References: <20220413094011.185269-1-cosmin.tanislav@analog.com>
        <20220413094011.185269-3-cosmin.tanislav@analog.com>
        <20220416172117.230b5d8c@jic23-huawei>
        <59033522-9095-319e-2710-cfac79e2d7e4@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Apr 2022 13:26:38 +0300
Cosmin Tanislav <demonsingur@gmail.com> wrote:

> On 4/16/22 19:21, Jonathan Cameron wrote:
> > On Wed, 13 Apr 2022 12:40:11 +0300
> > Cosmin Tanislav <demonsingur@gmail.com> wrote:
> >   
> >> AD4130-8 is an ultra-low power, high precision,
> >> measurement solution for low bandwidth battery
> >> operated applications.
> >>
> >> The fully integrated AFE (Analog Front-End)
> >> includes a multiplexer for up to 16 single-ended
> >> or 8 differential inputs, PGA (Programmable Gain
> >> Amplifier), 24-bit Sigma-Delta ADC, on-chip
> >> reference and oscillator, selectable filter
> >> options, smart sequencer, sensor biasing and
> >> excitation options, diagnostics, and a FIFO
> >> buffer.
> >>
> >> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>  
> > 
> > Hi Cosmin,
> > 
> > I've only glanced at Andy's comments, so may well overlap in places
> > though I'll try and avoid too much repetition if I happen to remember
> > Andy commented on something already.
> > 
> > Only a few minor things from me.  For such a complex device this
> > is looking pretty good for a first version posted.
> > 
> > Jonathan
> > 
> >   
> >> ---
> >>   MAINTAINERS              |    8 +
> >>   drivers/iio/adc/Kconfig  |   13 +
> >>   drivers/iio/adc/Makefile |    1 +
> >>   drivers/iio/adc/ad4130.c | 2072 ++++++++++++++++++++++++++++++++++++++
> >>   4 files changed, 2094 insertions(+)
> >>   create mode 100644 drivers/iio/adc/ad4130.c
> >>  
> > 
> > ...
> >   
> >> diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
> >> new file mode 100644
> >> index 000000000000..89fb9b413ff0
> >> --- /dev/null
> >> +++ b/drivers/iio/adc/ad4130.c
> >> @@ -0,0 +1,2072 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +/*
> >> + * AD4130 SPI ADC driver
> >> + *
> >> + * Copyright 2022 Analog Devices Inc.
> >> + */
> >> +#include <asm/div64.h>
> >> +#include <asm/unaligned.h>
> >> +#include <linux/bitfield.h>
> >> +#include <linux/bitops.h>
> >> +#include <linux/clk.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/device.h>
> >> +#include <linux/err.h>
> >> +#include <linux/gpio/driver.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/irq.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/iio/buffer.h>
> >> +#include <linux/iio/kfifo_buf.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of_irq.h>
> >> +#include <linux/property.h>
> >> +#include <linux/regmap.h>
> >> +#include <linux/regulator/consumer.h>
> >> +#include <linux/spi/spi.h>
> >> +
> >> +#include <linux/iio/iio.h>
> >> +#include <linux/iio/sysfs.h>
> >> +
> >> +#define AD4130_8_NAME			"ad4130-8"
> >> +
> >> +#define AD4130_COMMS_READ_MASK		BIT(6)
> >> +
> >> +#define AD4130_REG_STATUS		0x00
> >> +#define AD4130_STATUS_POR_FLAG_MASK	BIT(4)
> >> +
> >> +#define AD4130_REG_ADC_CONTROL		0x01
> >> +#define AD4130_BIPOLAR_MASK		BIT(14)  
> > where possibly it is good to name register fields such that it's
> > obvious which register they are fields of.  Makes it easier
> > to be sure we have the right one.
> > (I fell into this trap myself this week and wasted an hour or
> > so before I figured out that there were two different registers
> > with fields with exactly the same name ;)
> > 
> > Lots of different conventions for this one and I don't mind
> > which one you pick. e.g.  This works, but isn't perfect by
> > any means.
> > 
> > #define AD4130_ADC_CTRL_REG
> > #define  AD4130_ADC_CTRL_BIPOLAR_MASK  
> >  > Note I quite like the subtle indenting to make it easier  
> > to read these definitions as well.
> >   
> 
> Well. It's not late to change it now, if you insist.
> 
> If you look at my past drivers, I kept the register prefix
> for masks, but it seemed kind of redundant and I dropped it
> for this one.

To a certain extent this is about consistency.  Even if it's
not necessary for clarity in this particular driver I'd like
to keep that clarity of definition in all drivers if possible
to provide good examples for cases where maybe it's more
important.

> 
> By subtle indenting, you mean, making the masks look like
> sub-definitions of the register?

Sort of - I mean the extra space as in the example above between
define and the name.

> 
> >> +#define AD4130_INT_REF_VAL_MASK		BIT(13)
> >> +#define AD4130_INT_REF_2_5V		2500000
> >> +#define AD4130_INT_REF_1_25V		1250000
> >> +#define AD4130_CSB_EN_MASK		BIT(9)
> >> +#define AD4130_INT_REF_EN_MASK		BIT(8)
> >> +#define AD4130_MODE_MASK		GENMASK(5, 2)
> >> +#define AD4130_MCLK_SEL_MASK		GENMASK(1, 0)  


> > ...
> >   
> >> +struct ad4130_state {
> >> +	const struct ad4130_chip_info	*chip_info;
> >> +	struct spi_device		*spi;
> >> +	struct regmap			*regmap;
> >> +	struct clk			*mclk;
> >> +	struct regulator_bulk_data	regulators[4];
> >> +	u32				irq_trigger;
> >> +	u32				inv_irq_trigger;
> >> +
> >> +	/*
> >> +	 * Synchronize access to members of driver state, and ensure atomicity
> >> +	 * of consecutive regmap operations.
> >> +	 */
> >> +	struct mutex			lock;
> >> +	struct completion		completion;
> >> +
> >> +	struct iio_chan_spec		chans[AD4130_MAX_CHANNELS];
> >> +	struct ad4130_chan_info		chans_info[AD4130_MAX_CHANNELS];
> >> +	struct ad4130_setup_info	setups_info[AD4130_MAX_SETUPS];
> >> +	enum ad4130_pin_function	pins_fn[AD4130_MAX_ANALOG_PINS];
> >> +	u32				vbias_pins[AD4130_MAX_ANALOG_PINS];
> >> +	u32				num_vbias_pins;
> >> +	int				scale_tbls[AD4130_REF_SEL_MAX]
> >> +						  [AD4130_PGA_NUM][2];
> >> +	struct gpio_chip		gc;
> >> +	unsigned int			gpio_offsets[AD4130_MAX_GPIOS];
> >> +	unsigned int			num_gpios;
> >> +
> >> +	u32			int_pin_sel;
> >> +	bool			int_ref_en;
> >> +	u32			int_ref_uv;
> >> +	u32			mclk_sel;
> >> +	bool			bipolar;
> >> +
> >> +	unsigned int		num_enabled_channels;
> >> +	unsigned int		effective_watermark;
> >> +	unsigned int		watermark;
> >> +
> >> +	struct spi_message	fifo_msg;
> >> +	struct spi_transfer	fifo_xfer[2];
> >> +
> >> +	/*
> >> +	 * DMA (thus cache coherency maintenance) requires the
> >> +	 * transfer buffers to live in their own cache lines.
> >> +	 */
> >> +	u8			reset_buf[AD4130_RESET_BUF_SIZE] ____cacheline_aligned;
> >> +	u8			reg_write_tx_buf[4];
> >> +	u8			reg_read_tx_buf[1];
> >> +	u8			reg_read_rx_buf[3];
> >> +	u8			fifo_tx_buf[2];
> >> +	u8			fifo_rx_buf[AD4130_FIFO_SIZE *
> >> +					    AD4130_FIFO_MAX_SAMPLE_SIZE];  
> > 
> > This is quite a large buffer.  Perhaps it would be better to drain the fifo
> > in multiple steps if it is very full?  I guess that could be added
> > later if anyone ever ran into a problem with the buffer size.
> >   
> 
> We're quite time-constrained when receiving the FIFO watermark
> interrupt, I'm not sure two separate transfers would be any better.

Potential issue is that you get an SPI master that can't do such a bit
transfer.  There are a few out there which are quite limited because
they aren't DMA based. As stated, perhaps this is one to fix only
when someone runs into the problem.

> 
> >   
> >> +};  
> >   
> >> +
> >> +static const struct iio_info ad4130_info = {
> >> +	.read_raw = ad4130_read_raw,
> >> +	.read_avail = ad4130_read_avail,
> >> +	.write_raw_get_fmt = ad4130_write_raw_get_fmt,
> >> +	.write_raw = ad4130_write_raw,
> >> +	.update_scan_mode = ad4130_update_scan_mode,
> >> +	.hwfifo_set_watermark = ad4130_set_fifo_watermark,
> >> +	.debugfs_reg_access = ad4130_reg_access,
> >> +};
> >> +
> >> +static int ad4130_buffer_postenable(struct iio_dev *indio_dev)
> >> +{
> >> +	struct ad4130_state *st = iio_priv(indio_dev);
> >> +	int ret;
> >> +
> >> +	mutex_lock(&st->lock);
> >> +
> >> +	ret = ad4130_set_watermark_interrupt_en(st, true);
> >> +	if (ret)
> >> +		goto out;
> >> +
> >> +	/* When the chip enters FIFO mode, IRQ polarity is inversed. */  
> > 
> > That is downright odd :)  Perhaps a datasheet section reference is
> > appropriate here.  
> 
> Page 65, FIFO Watermark Interrupt section.
> 
> +
> 
> Page 71, Bit Descriptions for STATUS Register, RDYB.
> 
> I'll add them as a comment.

Great.

...

...

> >> +	ret = ad4130_parse_fw_children(indio_dev);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	for (i = 0; i < AD4130_MAX_GPIOS; i++) {
> >> +		if (st->pins_fn[i + AD4130_AIN2_P1] != AD4130_PIN_FN_NONE)
> >> +			continue;  
> > 
> > I'm a bit confused. pins_fn seems to be for the Analog pins, yet here is being
> > used for the GPIOs?  Maybe some explanatory comments
> >   
> 
> AIN2 = P1, AIN3 = P2, AIN4 = P3, AIN5 = P4. I'll add some comments.

Ah. I'd missed that relationship.

> 
> >> +
> >> +		st->gpio_offsets[st->num_gpios++] = i;
> >> +	}
> >> +
> >> +	return 0;
> >> +}  
...

> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = clk_prepare_enable(st->mclk);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = devm_add_action_or_reset(dev, ad4130_clk_disable_unprepare,
> >> +				       st->mclk);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (st->int_ref_uv == AD4130_INT_REF_2_5V)
> >> +		int_ref_val = AD4130_INT_REF_VAL_2_5V;
> >> +	else
> >> +		int_ref_val = AD4130_INT_REF_VAL_1_25V;
> >> +
> >> +	/* Switch to SPI 4-wire mode. */
> >> +	val = AD4130_CSB_EN_MASK;
> >> +	val |= st->bipolar ? AD4130_BIPOLAR_MASK : 0;  
> > 
> > Prefer field PREP even for these single bit cases >  
> 
> Do you want this for the places where I used `status ? mask : 0`
> inside regmap_update_bits() calls too?

That would be great.   Though probably not for the gpio one as
that is used in a more complex fashion so would be more confusing
done with two FIELD_PREP() calls.

> 
> >> +	val |= st->int_ref_en ? AD4130_INT_REF_EN_MASK : 0;

Sorry I didn't get back to this earlier (I see you sent a v2 and v3).
Fun week of spec review against a short timescale so I've not had any
time to get much IIO mailing list reading done!

Thanks,

Jonathan


