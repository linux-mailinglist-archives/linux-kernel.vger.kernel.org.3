Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FD548FC63
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 12:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbiAPLqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 06:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbiAPLqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 06:46:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596ECC061574;
        Sun, 16 Jan 2022 03:46:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E439DB80D36;
        Sun, 16 Jan 2022 11:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A8EC36AE3;
        Sun, 16 Jan 2022 11:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642333587;
        bh=I0r+/wTl0F5l9BP3ULpRGT1RP+BgKphnF8zp5XSQ/os=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DMEt09LaLCXp9lcVmf/Uj+tzal00FGzVGD06PVGqhDwtdI/a1xxW5a2w2cyqoHMM5
         MCrClJm2L9+MR9XTdozO3Lcntk3FydqD+dj7Q31lMLBkonOoZO/naFXPj3X1HMILm7
         vl3EwXAzAjGnCh+nFK2RUlisMNvvvnuOppOQ35GAd7oSDcrV/EeoB43megrhRwr2+b
         bJJToJtnhka2UNEwfdVRVqgKq3KCKHpEfqJK5i+pBDFx7l6/gy9prEkCPpYyTAmOFG
         hsKFmz6vHQw1Pn8r984SDQFqE46O7rmvjwro1uS9hwEyp/TzdLMiz+RsWFll2PWDF3
         gxlaDc53aQwaw==
Date:   Sun, 16 Jan 2022 11:52:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/2] one-bit-adc-dac: Add initial version of one bit
 ADC-DAC
Message-ID: <20220116115228.1f7b4728@jic23-huawei>
In-Reply-To: <20220111115919.14645-2-cristian.pop@analog.com>
References: <20220111115919.14645-1-cristian.pop@analog.com>
        <20220111115919.14645-2-cristian.pop@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 13:59:19 +0200
Cristian Pop <cristian.pop@analog.com> wrote:

> This allows remote reading and writing of the GPIOs. This is useful in
> application that run on another PC, at system level, where multiple iio
> devices and GPIO devices are integrated together.
Hi Cristian,

So I fully understand why this can be useful, but it is a software only
construction so I'm not convinced that it makes sense to necessarily
configure it via device tree.   A better fit may well be configfs.
(note I always meant to add configfs controls for iio_hwmon but haven't
found the time to do it yet...)

As it currently stands, doing only polled / sysfs reads this driver doesn't
do enough to justify its existence. You could just do all this in userspace
using the existing gpio interfaces.  So to be useful I'd expect it to
at least do triggered buffer capture.

When we have talked about handling digital signals int he past we discussed
whether the IIO channel description would also benefit from tighter packing
than the current minimum of a byte per channel.  Perhaps we don't technically
'need' it here but if we do add it in future it will be hard to retrofit into
this driver without big userspace ABI changes (i.e. breaking all existing
users).

I've not repeated stuff Andy got it in his review (assuming
I remembered it was something Andy raised).

Conclusion:
1) Creation interface needs a rethink or strong argument why it belongs in DT.
2) Driver needs to do more to justify it's existence.

Jonathan

> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
>  drivers/iio/addac/Kconfig           |   8 +
>  drivers/iio/addac/Makefile          |   1 +
>  drivers/iio/addac/one-bit-adc-dac.c | 229 ++++++++++++++++++++++++++++
>  3 files changed, 238 insertions(+)
>  create mode 100644 drivers/iio/addac/one-bit-adc-dac.c
> 
> diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
> index 138492362f20..5f311f4a747e 100644
> --- a/drivers/iio/addac/Kconfig
> +++ b/drivers/iio/addac/Kconfig
> @@ -17,4 +17,12 @@ config AD74413R
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad74413r.
>  
> +config ONE_BIT_ADC_DAC
> +	tristate "ONE_BIT_ADC_DAC driver"
> +	help
> +	  Say yes here to build support for ONE_BIT_ADC_DAC driver.

Needs a lot more detail here.  Though naming it to be explicitly about
GPIO to IIO binding would help.

> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called one-bit-adc-dac.
> +
>  endmenu
> diff --git a/drivers/iio/addac/Makefile b/drivers/iio/addac/Makefile
> index cfd4bbe64ad3..0a33f0706b55 100644
> --- a/drivers/iio/addac/Makefile
> +++ b/drivers/iio/addac/Makefile
> @@ -5,3 +5,4 @@
>  
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AD74413R) += ad74413r.o
> +obj-$(CONFIG_ONE_BIT_ADC_DAC) += one-bit-adc-dac.o
> diff --git a/drivers/iio/addac/one-bit-adc-dac.c b/drivers/iio/addac/one-bit-adc-dac.c
> new file mode 100644
> index 000000000000..5680de594429
> --- /dev/null
> +++ b/drivers/iio/addac/one-bit-adc-dac.c
> @@ -0,0 +1,229 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +/*
> + * one-bit-adc-dac

Improve description here as well.  It's really just a wrapper for
a gpio in an IIO channel, so just say that.  Fine to say the
representation is 1 bit ADC or DAC channels as well, but
I think the GPIO part will be more obvious to the casual reader.

> + *
> + * Copyright 2022 Analog Devices Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/iio/iio.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio/consumer.h>
> +
> +enum ch_direction {
> +	CH_IN,
> +	CH_OUT,
> +};
> +
> +struct one_bit_adc_dac_state {
> +	int			in_num_ch;
> +	int			out_num_ch;
> +	struct platform_device  *pdev;

Not used after probe so don't keep it around.

> +	struct gpio_descs       *in_gpio_descs;
> +	struct gpio_descs       *out_gpio_descs;
> +	const char		**labels;
> +};
> +
> +static int one_bit_adc_dac_read_raw(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, int *val, int *val2, long info)
> +{
> +	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
> +	struct gpio_descs *descs;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->output)
> +			descs = st->out_gpio_descs;
> +		else
> +			descs = st->in_gpio_descs;
> +		*val = gpiod_get_value_cansleep(descs->desc[chan->channel]);
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int one_bit_adc_dac_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val,
> +			    int val2,
> +			    long info)
> +{
> +	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
> +	int channel = chan->channel;
> +
> +	if (!chan->output)
> +		return 0;

-EINVAL;  It's an error that should be reported to userspace..

> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		gpiod_set_value_cansleep(st->out_gpio_descs->desc[channel], val);
> +
> +		return 0;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int one_bit_adc_dac_read_label(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, char *label)
> +{
> +	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
> +	int ch;
> +
> +	if (chan->output)
> +		ch = chan->channel + st->in_num_ch;
> +	else
> +		ch = chan->channel;
> +
> +	return sprintf(label, "%s\n", st->labels[ch]);
> +}
> +
> +static const struct iio_info one_bit_adc_dac_info = {
> +	.read_raw = &one_bit_adc_dac_read_raw,
> +	.write_raw = &one_bit_adc_dac_write_raw,
> +	.read_label = &one_bit_adc_dac_read_label,
> +};
> +
> +static int one_bit_adc_dac_set_ch(struct iio_chan_spec *channels,
> +					int num_ch,
> +					enum ch_direction direction)
> +{
> +	int i;
> +
> +	for (i = 0; i < num_ch; i++) {
> +		channels[i].type = IIO_VOLTAGE;
> +		channels[i].indexed = 1;
> +		channels[i].channel = i;
> +		channels[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +		channels[i].output = direction;
> +	}
> +
> +	return 0;
> +}
> +
> +static int one_bit_adc_dac_set_channel_label(struct iio_dev *indio_dev,
> +						struct iio_chan_spec *channels,
> +						int num_channels)
> +{
> +	struct device *device = indio_dev->dev.parent;
> +	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
> +	struct fwnode_handle *fwnode;
> +	struct fwnode_handle *child;
> +	struct iio_chan_spec *chan;
> +	const char *label;
> +	int crt_ch = 0, child_num, i = 0;
> +
> +	fwnode = dev_fwnode(device);
> +	child_num = device_get_child_node_count(device);
> +
> +	st->labels = devm_kzalloc(device, sizeof(*st->labels) * child_num, GFP_KERNEL);
> +	if (!st->labels)
> +		return -ENOMEM;
> +
> +	i = child_num;
> +	fwnode_for_each_child_node(fwnode, child) {
> +		if (fwnode_property_read_u32(child, "reg", &crt_ch))
> +			continue;
> +
> +		if (crt_ch >= num_channels)
> +			continue;
> +
> +		if (fwnode_property_read_string(child, "label", &label))
> +			continue;
> +
> +		chan = &channels[crt_ch];
? Not used.

> +		st->labels[--i] = label;

I've no idea how this works...  Should be looking for the chan->channel
value as that's what your read uses to index.

> +	}
> +
> +	return 0;
> +}
> +
> +static int one_bit_adc_dac_parse_dt(struct iio_dev *indio_dev)
> +{
> +	struct one_bit_adc_dac_state *st = iio_priv(indio_dev);
> +	struct iio_chan_spec *channels;
> +	int ret, in_num_ch = 0, out_num_ch = 0;
> +
> +	st->in_gpio_descs = devm_gpiod_get_array_optional(&st->pdev->dev, "in", GPIOD_IN);
> +	if (IS_ERR(st->in_gpio_descs))
> +		return PTR_ERR(st->in_gpio_descs);
> +
> +	if (st->in_gpio_descs)
> +		in_num_ch = st->in_gpio_descs->ndescs;
> +
> +	st->out_gpio_descs = devm_gpiod_get_array_optional(&st->pdev->dev, "out", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->out_gpio_descs))
> +		return PTR_ERR(st->out_gpio_descs);
> +
> +	if (st->out_gpio_descs)
> +		out_num_ch = st->out_gpio_descs->ndescs;
> +	st->in_num_ch = in_num_ch;
> +	st->out_num_ch = out_num_ch;
> +
> +	channels = devm_kcalloc(indio_dev->dev.parent, in_num_ch + out_num_ch,
> +				sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	ret = one_bit_adc_dac_set_ch(&channels[0], in_num_ch, CH_IN);
> +	if (ret)
> +		return ret;
> +
> +	ret = one_bit_adc_dac_set_ch(&channels[in_num_ch], out_num_ch, CH_OUT);
> +	if (ret)
> +		return ret;
> +
> +	ret = one_bit_adc_dac_set_channel_label(indio_dev, channels, in_num_ch + out_num_ch);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->channels = channels;
> +	indio_dev->num_channels = in_num_ch + out_num_ch;
> +
> +	return 0;
> +}
> +
> +static int one_bit_adc_dac_probe(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev;
> +	struct one_bit_adc_dac_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->pdev = pdev;
> +	indio_dev->name = "one-bit-adc-dac";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &one_bit_adc_dac_info;
> +
> +	ret = one_bit_adc_dac_parse_dt(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> +}
> +
> +static const struct of_device_id one_bit_adc_dac_dt_match[] = {
> +	{ .compatible = "one-bit-adc-dac" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, one_bit_adc_dac_dt_match);
> +
> +static struct platform_driver one_bit_adc_dac_driver = {
> +	.driver = {
> +		.name = "one-bit-adc-dac",
> +		.of_match_table = one_bit_adc_dac_dt_match,
> +	},
> +	.probe = one_bit_adc_dac_probe,
> +};
> +module_platform_driver(one_bit_adc_dac_driver);
> +
> +MODULE_AUTHOR("Cristian Pop <cristian.pop@analog.com>");
> +MODULE_DESCRIPTION("One bit ADC DAC converter");
> +MODULE_LICENSE("Dual BSD/GPL");
> \ No newline at end of file

Make sure to eyeball your patches before sending as this sort
of thing should be caught at that stage...


