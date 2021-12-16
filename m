Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E62477B20
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbhLPRzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbhLPRzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:55:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE467C061574;
        Thu, 16 Dec 2021 09:55:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A8A961ED1;
        Thu, 16 Dec 2021 17:55:20 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id AFE40C36AE0;
        Thu, 16 Dec 2021 17:55:16 +0000 (UTC)
Date:   Thu, 16 Dec 2021 18:00:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <nuno.sa@analog.com>, <dragos.bogdan@analog.com>,
        <alexandru.ardelean@analog.com>
Subject: Re: [PATCH v7 2/2] drivers:iio:dac: Add AD3552R driver support
Message-ID: <20211216180040.3723a906@jic23-huawei>
In-Reply-To: <20211213110825.244347-3-mihail.chindris@analog.com>
References: <20211213110825.244347-1-mihail.chindris@analog.com>
        <20211213110825.244347-3-mihail.chindris@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 11:08:25 +0000
Mihail Chindris <mihail.chindris@analog.com> wrote:

> The AD3552R-16 is a low drift ultrafast, 16-bit accuracy,
> current output digital-to-analog converter (DAC) designed
> to generate multiple output voltage span ranges.
> The AD3552R-16 operates with a fixed 2.5V reference.
> 
> Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad3552r.pdf
> 
> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
Hi Mihail,

Found a few tiny things on final read though. I'll fix them whilst applying.


Series applied to the togreg branch of iio.git and pushed out as testing for
0-day to have a first poke at it.

Nice driver,

Thanks,

Jonathan



> +
> +static int ad3552r_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val,
> +			     int val2,
> +			     long mask)
> +{
> +	struct ad3552r_desc *dac = iio_priv(indio_dev);
> +	int err = 0;

Set in all paths, so no need to initialize.

> +
> +	mutex_lock(&dac->lock);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		err = ad3552r_write_reg(dac,
> +					AD3552R_REG_ADDR_CH_DAC_24B(chan->channel),
> +					val);
> +		break;
> +	case IIO_CHAN_INFO_ENABLE:
> +		err = ad3552r_set_ch_value(dac, AD3552R_CH_DAC_POWERDOWN,
> +					   chan->channel, !val);
> +		break;
> +	default:
> +		err = -EINVAL;
> +		break;
> +	}
> +	mutex_unlock(&dac->lock);
> +
> +	return err;
> +}
> +

...

> +static int ad3552r_configure_device(struct ad3552r_desc *dac)
> +{
> +	struct device *dev = &dac->spi->dev;
> +	struct fwnode_handle *child;
> +	struct regulator *vref;
> +	int err, cnt = 0, voltage, delta = 100000;
> +	u32 vals[2], val, ch;
> +
> +	dac->gpio_ldac = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_HIGH);
> +	if (IS_ERR(dac->gpio_ldac))
> +		return dev_err_probe(dev, PTR_ERR(dac->gpio_ldac),
> +				     "Error getting gpio ldac");
> +
> +	vref = devm_regulator_get_optional(dev, "vref");
> +	if (IS_ERR(vref)) {
> +		if (PTR_ERR(vref) != -ENODEV)
> +			return dev_err_probe(dev, PTR_ERR(vref),
> +					     "Error getting vref");
> +
> +		if (device_property_read_bool(dev, "adi,vref-out-en"))
> +			val = AD3552R_INTERNAL_VREF_PIN_2P5V;
> +		else
> +			val = AD3552R_INTERNAL_VREF_PIN_FLOATING;
> +	} else {
> +		err = regulator_enable(vref);
> +		if (err) {
> +			dev_err(dev, "Failed to enable external vref supply\n");
> +			return err;
> +		}
> +
> +		err = devm_add_action_or_reset(dev, ad3552r_reg_disable, vref);
> +		if (err) {
> +			regulator_disable(vref);
> +			return err;
> +		}
> +
> +		voltage = regulator_get_voltage(vref);
> +		if (voltage > 2500000 + delta || voltage < 2500000 - delta) {
> +			dev_warn(dev, "vref-supply must be 2.5V");
> +			return -EINVAL;
> +		}
> +		val = AD3552R_EXTERNAL_VREF_PIN_INPUT;
> +	}
> +
> +	err = ad3552r_update_reg_field(dac,
> +				       addr_mask_map[AD3552R_VREF_SELECT][0],
> +				       addr_mask_map[AD3552R_VREF_SELECT][1],
> +				       val);
> +	if (err)
> +		return err;
> +
> +	err = device_property_read_u32(dev, "adi,sdo-drive-strength", &val);
> +	if (!err) {
> +		if (val > 3) {
> +			dev_err(dev, "adi,sdo-drive-strength must be less than 4\n");
> +			return -EINVAL;
> +		}
> +
> +		err = ad3552r_update_reg_field(dac,
> +					       addr_mask_map[AD3552R_SDO_DRIVE_STRENGTH][0],
> +					       addr_mask_map[AD3552R_SDO_DRIVE_STRENGTH][1],
> +					       val);
> +		if (err)
> +			return err;
> +	}
> +
> +	dac->num_ch = device_get_child_node_count(dev);
> +	if (!dac->num_ch) {
> +		dev_err(dev, "No channels defined\n");
> +		return -ENODEV;
> +	}
> +
> +	device_for_each_child_node(dev, child) {
> +		err = fwnode_property_read_u32(child, "reg", &ch);
> +		if (err) {
> +			dev_err(dev, "mandatory reg property missing\n");
> +			goto put_child;
> +		}
> +		if (ch >= AD3552R_NUM_CH) {
> +			dev_err(dev, "reg must be less than %d\n",
> +				AD3552R_NUM_CH);
> +			err = -EINVAL;
> +			goto put_child;
> +		}
> +
> +		if (fwnode_property_present(child, "adi,output-range-microvolt")) {
> +			err = fwnode_property_read_u32_array(child,
> +							     "adi,output-range-microvolt",
> +							     vals,
> +							     2);
> +			if (err) {
> +				dev_err(dev,
> +					"mandatory adi,output-range-microvolt property missing\n");

Trivial but that comment doesn't make sense.  You know it it exists as you check that
above, so failure here means something wrong with it. I'll tweak this if it's
all I find in this round of review to something like "failed to parse adi,out..." 

> +				goto put_child;
> +			}
> +
> +			err = ad3552r_find_range(dac->chip_id, vals);
> +			if (err < 0) {
> +				dev_err(dev,
> +					"Invalid adi,output-range-microvolt value\n");
> +				goto put_child;
> +			}
> +			val = err;
> +			err = ad3552r_set_ch_value(dac,
> +						   AD3552R_CH_OUTPUT_RANGE_SEL,
> +						   ch, val);
> +			if (err)
> +				goto put_child;
> +
> +			dac->ch_data[ch].range = val;
> +		} else if (dac->chip_id == AD3542R_ID) {
> +			dev_err(dev,
> +				"adi,output-range-microvolt is required for ad3542r\n");
> +			err = -EINVAL;
> +			goto put_child;
> +		} else {
> +			err = ad3552r_configure_custom_gain(dac, child, ch);
> +			if (err)
> +				goto put_child;
> +		}
> +
> +		ad3552r_calc_gain_and_offset(dac, ch);
> +		dac->enabled_ch |= BIT(ch);
> +
> +		err = ad3552r_set_ch_value(dac, AD3552R_CH_SELECT, ch, 1);
> +		if (err < 0)
> +			goto put_child;
> +
> +		dac->channels[cnt] = AD3552R_CH_DAC(ch);
> +		++cnt;
> +
> +	}

