Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAAC47E292
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 12:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348008AbhLWLtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 06:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhLWLtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 06:49:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AE9C061401;
        Thu, 23 Dec 2021 03:49:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EBC3B81FCA;
        Thu, 23 Dec 2021 11:49:04 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id F3013C36AE9;
        Thu, 23 Dec 2021 11:49:00 +0000 (UTC)
Date:   Thu, 23 Dec 2021 11:54:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/3] iio: frequency: admv1013: add support for
 ADMV1013
Message-ID: <20211223115430.797179b1@jic23-huawei>
In-Reply-To: <20211221112206.97066-1-antoniu.miclaus@analog.com>
References: <20211221112206.97066-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 13:22:04 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADMV1013 is a wideband, microwave upconverter optimized
> for point to point microwave radio designs operating in the
> 24 GHz to 44 GHz radio frequency (RF) range.
> 
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/ADMV1013.pdf
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
Hi Antoniu,

A couple of observations inline but neither was significant enough
to require a respin or clearly beneficial to a degree where I'd just
fix them whilst applying.

Series applied and Rob's tag added to the dt-binding.

Pushed out as testing for 0-day to take a first look at it.

Where this makes it pre merge window depends on various people's
vacation plans so we'll see how that goes.

Thanks,

Jonathan



> +
> +static ssize_t admv1013_read(struct iio_dev *indio_dev,
> +			     uintptr_t private,
> +			     const struct iio_chan_spec *chan,
> +			     char *buf)
> +{
> +	struct admv1013_state *st = iio_priv(indio_dev);
> +	unsigned int data, addr;
> +	int ret;
> +
> +	switch ((u32)private) {
> +	case ADMV1013_RFMOD_I_CALIBPHASE:
> +		addr = ADMV1013_REG_LO_AMP_I;
> +		break;
> +	case ADMV1013_RFMOD_Q_CALIBPHASE:
> +		addr = ADMV1013_REG_LO_AMP_Q;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = admv1013_spi_read(st, addr, &data);
> +	if (ret)
> +		return ret;
> +
> +	data = FIELD_GET(ADMV1013_LOAMP_PH_ADJ_FINE_MSK, data);
> +
> +	return sysfs_emit(buf, "%u\n", data);
> +}
> +
> +static ssize_t admv1013_write(struct iio_dev *indio_dev,
> +			      uintptr_t private,
> +			      const struct iio_chan_spec *chan,
> +			      const char *buf, size_t len)
> +{
> +	struct admv1013_state *st = iio_priv(indio_dev);
> +	unsigned int data;
> +	int ret;
> +
> +	ret = kstrtou32(buf, 10, &data);
> +	if (ret)
> +		return ret;
> +
> +	data = FIELD_PREP(ADMV1013_LOAMP_PH_ADJ_FINE_MSK, data);
> +
> +	switch ((u32)private) {
> +	case ADMV1013_RFMOD_I_CALIBPHASE:

As a possible follow up / cleanup you could just make private == ADMV1013_REG_LO_AMP_I/Q
and use it directly as the address.

The indirection here isn't adding anything that I can see.

> +		ret = admv1013_spi_update_bits(st, ADMV1013_REG_LO_AMP_I,
> +					       ADMV1013_LOAMP_PH_ADJ_FINE_MSK,
> +					       data);
> +		if (ret)
> +			return ret;
> +		break;
> +	case ADMV1013_RFMOD_Q_CALIBPHASE:
> +		ret = admv1013_spi_update_bits(st, ADMV1013_REG_LO_AMP_Q,
> +					       ADMV1013_LOAMP_PH_ADJ_FINE_MSK,
> +					       data);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret ? ret : len;
> +}
> +
> +static int admv1013_update_quad_filters(struct admv1013_state *st)
> +{
> +	unsigned int filt_raw;
> +	u64 rate = clk_get_rate(st->clkin);
> +
> +	if (rate >= (5400 * HZ_PER_MHZ) && rate <= (7000 * HZ_PER_MHZ))
> +		filt_raw = 15;
> +	else if (rate >= (5400 * HZ_PER_MHZ) && rate <= (8000 * HZ_PER_MHZ))
> +		filt_raw = 10;
> +	else if (rate >= (6600 * HZ_PER_MHZ) && rate <= (9200 * HZ_PER_MHZ))
> +		filt_raw = 5;
> +	else
> +		filt_raw = 0;
> +
> +	return __admv1013_spi_update_bits(st, ADMV1013_REG_QUAD,
> +					ADMV1013_QUAD_FILTERS_MSK,
> +					FIELD_PREP(ADMV1013_QUAD_FILTERS_MSK, filt_raw));
> +}
> +

> +#define _ADMV1013_EXT_INFO(_name, _shared, _ident) { \
> +		.name = _name, \
> +		.read = admv1013_read, \
> +		.write = admv1013_write, \
> +		.private = _ident, \
> +		.shared = _shared, \
> +}
> +
> +static const struct iio_chan_spec_ext_info admv1013_ext_info[] = {
> +	_ADMV1013_EXT_INFO("i_calibphase", IIO_SEPARATE, ADMV1013_RFMOD_I_CALIBPHASE),
> +	_ADMV1013_EXT_INFO("q_calibphase", IIO_SEPARATE, ADMV1013_RFMOD_Q_CALIBPHASE),
> +	{ },
> +};
> +
> +#define ADMV1013_CHAN_PHASE(_channel, _channel2, _admv1013_ext_info) {		\
> +	.type = IIO_ALTVOLTAGE,					\
> +	.output = 0,						\
> +	.indexed = 1,						\
> +	.channel2 = _channel2,					\
> +	.channel = _channel,					\
> +	.differential = 1,					\
> +	.ext_info = _admv1013_ext_info,				\

Trivial but there is little purpose in passing _admv1013_ext_info into here
as it only ever takes once value.  It would be cleaner to just hard
code it here.

> +	}
> +
> +#define ADMV1013_CHAN_CALIB(_channel, rf_comp) {	\
> +	.type = IIO_ALTVOLTAGE,					\
> +	.output = 0,						\
> +	.indexed = 1,						\
> +	.channel = _channel,					\
> +	.channel2 = IIO_MOD_##rf_comp,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBBIAS),	\
> +	}
> +
> +static const struct iio_chan_spec admv1013_channels[] = {
> +	ADMV1013_CHAN_PHASE(0, 1, admv1013_ext_info),
> +	ADMV1013_CHAN_CALIB(0, I),
> +	ADMV1013_CHAN_CALIB(0, Q),
> +	ADMV1013_CHAN_CALIB(1, I),
> +	ADMV1013_CHAN_CALIB(1, Q),
> +};
> +

