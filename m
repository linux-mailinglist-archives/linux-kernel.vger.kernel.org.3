Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BA84AAADA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 19:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380879AbiBESYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 13:24:13 -0500
Received: from mga11.intel.com ([192.55.52.93]:18148 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380871AbiBESYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 13:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644085451; x=1675621451;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=74+bUnq6csTeGAEUDrWTUFcny69WpFvh1Opo1QTCzwE=;
  b=h2X1hG2Pzd0Y6ZQlPuZ3MQGxvqmBU5vZ8YygUqJY8uQ86CfHWeTb4vjg
   KC0QS3R50U9oGXz9c3SK8ro4bkCbtgCdi4deCMr0VVqLnmCyWrb+gad8q
   ZrqA2hYPBZ/gR21btQujyz1IALXxdpFODK8eiSUnMMMIWORiy5B3m7xmf
   plbSRYkoIUcFOK/es0ABtaTfivF/YbHJ10oczjBEZAuySD10vnyQDZlAQ
   5M0wNRYCNFlWXYeRb/7yDsmLFFq0wX9iv/gmfcdWo6MKDLMHVrkFtlnE2
   J2l8E9b8t+wB2v9tyhWYCZovACGdKX/JU6RrvRgdTxCXuMyyHO1C3oGwc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="246116689"
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="246116689"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 10:24:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,346,1635231600"; 
   d="scan'208";a="524662224"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 10:24:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nGPiH-001LKO-EP;
        Sat, 05 Feb 2022 20:23:09 +0200
Date:   Sat, 5 Feb 2022 20:23:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     jic23@kernel.org, robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] iio:frequency:admv1014: add support for ADMV1014
Message-ID: <Yf7AjXsRuhFeFTpD@smile.fi.intel.com>
References: <20220131100102.15372-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131100102.15372-1-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 12:00:59PM +0200, Antoniu Miclaus wrote:
> The ADMV1014 is a silicon germanium (SiGe), wideband,
> microwave downconverter optimized for point to point microwave
> radio designs operating in the 24 GHz to 44 GHz frequency range.

Excellent job!
A few comments / questions below.

...

> +config ADMV1014
> +	tristate "Analog Devices ADMV1014 Microwave Downconverter"
> +	depends on SPI && COMMON_CLK && 64BIT

Why 64BIT only?

..

> +enum {
> +	ADMV1014_IQ_MODE,
> +	ADMV1014_IF_MODE

+ Comma.

> +};
> +
> +enum {
> +	ADMV1014_SE_MODE_POS = 6,
> +	ADMV1014_SE_MODE_NEG = 9,
> +	ADMV1014_SE_MODE_DIFF = 12

+ Comma.

> +};

> +
> +enum {
> +	ADMV1014_CALIBSCALE_COARSE,
> +	ADMV1014_CALIBSCALE_FINE,
> +};

...

> +	int ret;
> +	struct spi_transfer t = {0};

{} would suffice.
Also, can we here and everywhere else use reversed xmas tree order?

	struct spi_transfer t = {};
	int ret;

...

> +	st->data[0] = ADMV1014_READ | FIELD_PREP(ADMV1014_REG_ADDR_READ_MSK, reg);
> +	st->data[1] = 0x0;
> +	st->data[2] = 0x0;

0x0 --> 0

Or I would rather put it cleaner with

	put_unaligned_be16(...);

(or is it le16?)

...

> +	t.len = 3;

sizeof()?

...

> +	put_unaligned_be24(FIELD_PREP(ADMV1014_REG_DATA_MSK, val) |
> +			   FIELD_PREP(ADMV1014_REG_ADDR_WRITE_MSK, reg), &st->data[0]);

Looking at the above I think the proper one will be byte assignment + put_unaligned_be16().

...

> +	return spi_write(st->spi, &st->data[0], 3);

sizeof() ?

...

> +	if (rate >= (5400 * HZ_PER_MHZ) && rate <= (7000 * HZ_PER_MHZ))
> +		filt_raw = 15;

> +	else if (rate >= (5400 * HZ_PER_MHZ) && rate <= (8000 * HZ_PER_MHZ))

What's the point to have 5400 here? Shouldn't be 7000?

> +		filt_raw = 10;
> +	else if (rate >= (6600 * HZ_PER_MHZ) && rate <= (9200 * HZ_PER_MHZ))
> +		filt_raw = 5;
> +	else
> +		filt_raw = 0;

...

> +		vcm_comp = 1050 + (i * 50) + (i / 8 * 50);

		vcm_comp = 1050 + mult_frac(i, 450, 8);
		// alternatively mult_frac(i * 50, 9, 8)

?

> +		if (vcm_mv != vcm_comp)
> +			continue;

...

> +	ret = kstrtou32(buf, 10, &data);

Should be kstrtouint(). Please check all such calls to be in align with the
type of variables that are used as a receptor.

> +	if (ret)
> +		return ret;

...

> +	switch ((u32)private) {

Why casting? Switch-case with castings is quite unusual.

> +	}

...

> +	return ret ? ret : len;

	return ret ?: len; ?

...

> +static const char * const admv1014_reg_name[] = {
> +	 "vcm", "vcc-if-bb", "vcc-vga", "vcc-vva", "vcc-lna-3p3", "vcc-lna-1p5",
> +	 "vcc-bg", "vcc-quad", "vcc-mixer"

4 or 5 on one line is easier to read and follow the index (if needed).
Also add a comma to the end.

> +};

...

> +#define ADMV1014_CHAN_IQ(_channel, rf_comp) {				\
> +	.type = IIO_ALTVOLTAGE,						\
> +	.modified = 1,							\
> +	.output = 0,							\
> +	.indexed = 1,							\
> +	.channel2 = IIO_MOD_##rf_comp,					\
> +	.channel = _channel,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_PHASE) |		\
> +		BIT(IIO_CHAN_INFO_OFFSET),				\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBSCALE)	\

+ Comma, same for the rest similar cases below.

> +	}

...

> +#define ADMV1014_CHAN_CALIBSCALE(_channel, rf_comp, _admv1014_ext_info) {	\
> +	.type = IIO_ALTVOLTAGE,							\
> +	.modified = 1,								\
> +	.output = 0,								\
> +	.indexed = 1,								\
> +	.channel2 = IIO_MOD_##rf_comp,						\
> +	.channel = _channel,							\
> +	.ext_info = _admv1014_ext_info						\

+ Comma.

> +	}
> +
> +static const struct iio_chan_spec admv1014_channels_iq[] = {
> +	ADMV1014_CHAN_IQ(0, I),
> +	ADMV1014_CHAN_IQ(0, Q),
> +	ADMV1014_CHAN_POWER(0)

+ Comma.

> +};
> +
> +static const struct iio_chan_spec admv1014_channels_if[] = {
> +	ADMV1014_CHAN_IF(0, I),
> +	ADMV1014_CHAN_IF(0, Q),
> +	ADMV1014_CHAN_CALIBSCALE(0, I, admv1014_ext_info),
> +	ADMV1014_CHAN_CALIBSCALE(0, Q, admv1014_ext_info),
> +	ADMV1014_CHAN_POWER(0)

+ Comma.

> +};

...

> +	enable_reg = FIELD_PREP(ADMV1014_P1DB_COMPENSATION_MSK, st->p1db_comp ? 3 : 0) |

3 --> GENMASK() ?

> +		     FIELD_PREP(ADMV1014_IF_AMP_PD_MSK, !(st->input_mode)) |
> +		     FIELD_PREP(ADMV1014_BB_AMP_PD_MSK, st->input_mode) |
> +		     FIELD_PREP(ADMV1014_DET_EN_MSK, st->det_en);
> +
> +	return __admv1014_spi_update_bits(st, ADMV1014_REG_ENABLE, enable_reg_msk, enable_reg);
> +}

...

> +	str = "iq";
> +	device_property_read_string(&spi->dev, "adi,input-mode", &str);
> +
> +	if (!strcmp(str, "iq"))
> +		st->input_mode = ADMV1014_IQ_MODE;
> +	else if (!strcmp(str, "if"))
> +		st->input_mode = ADMV1014_IF_MODE;
> +	else
> +		return -EINVAL;

Please, put the array of strings near to the enums and use match-string here.
Something like:

static const char const *mode_names = { "iq", "if" };

	ret = device_property_read_string(&spi->dev, "adi,input-mode", &str);
	if (ret)
		input_mode = ...
	else {
		ret = match_string();
		if (ret < 0)
			return ret;
		input_mode = ret;
	}

...

> +	str = "diff";
> +	device_property_read_string(&spi->dev, "adi,quad-se-mode", &str);
> +
> +	if (!strcmp(str, "diff"))
> +		st->quad_se_mode = ADMV1014_SE_MODE_DIFF;
> +	else if (!strcmp(str, "se-pos"))
> +		st->quad_se_mode = ADMV1014_SE_MODE_POS;
> +	else if (!strcmp(str, "se-neg"))
> +		st->quad_se_mode = ADMV1014_SE_MODE_NEG;
> +	else
> +		return -EINVAL;

Ditto.

While in the above case no win in LOCs, here already a little win.
The most important not that, the possibility to extend without changing the
code much.

...

> +	st->clkin = devm_clk_get(&spi->dev, "lo_in");

Perhaps _optional?

> +	if (IS_ERR(st->clkin))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
> +				     "failed to get the LO input clock\n");

-- 
With Best Regards,
Andy Shevchenko


